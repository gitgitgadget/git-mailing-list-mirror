From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC] Malicously tampering git metadata?
Date: Tue, 12 Jan 2016 10:39:07 -0800
Message-ID: <CAGZ79kadpy9N0qEpxK-USVxCmNfYJm1g5xr8ZiFxf7sOVKZnEw@mail.gmail.com>
References: <20151216032639.GA1901@LykOS>
	<20151218231032.GA16904@thunk.org>
	<20151219173018.GA1178@LykOS>
	<20151220012835.GA3013@thunk.org>
	<20160112182137.GE27334@LykOS>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Tue Jan 12 19:39:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ3qc-0006fI-Ty
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 19:39:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904AbcALSjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 13:39:09 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:35612 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752307AbcALSjI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 13:39:08 -0500
Received: by mail-io0-f172.google.com with SMTP id 77so361931854ioc.2
        for <git@vger.kernel.org>; Tue, 12 Jan 2016 10:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=trYsUlsXpXc1mRT65TU6/7H4Ng06r9qaGmzBR5aFhak=;
        b=SvCHKy2PVcR8fLNanZEHSDGDxpCu2WlH246K4PBhA7+bCwgquthJ3M0NOiqGfzOlNl
         16+MrxtdeKserBU2OIG7BE7/leu2AOHKCsRC4rU6AqlHae6pvDk9qSP1+yLW0kPGNQt0
         XlFh+HSbJKMxkMzgSFMwGkJGSl/yzXw1Idl7JkJay9HjmsRJd7tEE6Ns9FvebnvpSiOY
         LkjfufbqoA7tt4TCA9cpT4eBLL2HcmVCxDYeSdMk/V3+wC/CvIbtHnDLMtDAPmd3i7Pt
         yy64QbNHbfqjG2WezYbQPOxkKCp4b1hmiM/ByH3RuOg4qAHTtv/nko/YvASpPKYiM/Dh
         virg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=trYsUlsXpXc1mRT65TU6/7H4Ng06r9qaGmzBR5aFhak=;
        b=gTZ+wGAzIRkK+kZLsuuZko2TagyOrooG1ptieExXHpO5vVH6OfQppQvrgdTQV6m15B
         VZuoULHM7x0yysVY2cyQ40ggHVX7n2M5Wh523koALANPtIdol4XcY/+rPkz51amUWwWJ
         dAG9mpnmM48EglmjGMcmOWPUN75Itrk6vbF2XaFElnn83RqdiiyVnRORzQ4nr0bCbgif
         NrgbcmO67czC8akuAmqxbb7Il0WlZa/oru4qVXQ116lPlyv/rgj2oBhJoJ5/NeGZBSZo
         TLq5Ezw9wK5x8yeTgGkrBBWPuYBZnrrnsBwF2eewjF8NGBUZZ8Q+OTvtUFxAvxh4Chy5
         w/Nw==
X-Gm-Message-State: ALoCoQkT26NU840fVSogXVNOE9bpCkvOXbqA/ZTPIvcGDlITKFj6aUOihURj8kZgwN3EH3GZtQq8c52s8ndVRovn+scuXMqew6eUusNOK18PygkrnD7smJk=
X-Received: by 10.107.137.68 with SMTP id l65mr3702270iod.110.1452623947399;
 Tue, 12 Jan 2016 10:39:07 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Tue, 12 Jan 2016 10:39:07 -0800 (PST)
In-Reply-To: <20160112182137.GE27334@LykOS>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283835>

On Tue, Jan 12, 2016 at 10:21 AM, Santiago Torres <santiago@nyu.edu> wrote:
> Hello Everyone,
>
> Thanks for the feedback regarding our attack scenario; it certainly shed some
> light in what is the current state of git's metadata protection. We were
> pleasantly surprised that attacks of this nature were considered, yet we think
> we can improve on the current mechanisms.
>
> We have been designing an extension that addresses this attack scenario (and
> other similar attacks). Although originally it is not based on push
> certificates, we feel that it works similar to them. The principal advantages
> over push certificates are:
>
> 1) It doesn't require (although it could support it) a side channel. We store similar
>     information about branch status (push status) on the repository itself.
>
> 2) It is backwards compatible, as it doesn't modify the existing metadata
>     format.
>
> 3) Following Ted's email, it could be easily integrated in any git workflow.
>     Although some workflows might be benefitted more than others, it doesn't
>     get in the way of any existing workflow that we know of.
>
> 4) It covers a broader attack suurface (e.g., our malicious-merge scenario).
>
> To keep things simple (we can elaborate in further emails), our solution
> basically works by keeping track of pushes by developers in an append only
> file, so that, everytime a branch is pushed, the deloper signs his version of
> the log and his "push entry" (similar to a push certificate). Right now, we
> push this log to a separate branch called BSL (for Branch State Log), but
> ideallly this could be part of the git metadata.

Recently in another context (an alternative refs backend) there was a proposal
by Shawn to keep the .git directory versioned by git itself, i.e.
having only loose refs in
.git/refs and then there is a repository tracking .git/refs as a
directory structure.

Using that idea of a refs back end, combined with signed tags in the
refs repository
would give you signed version of the log of possible push entries.

>
> Upon pulling/fetching, this push certificate chain (BSL) is also fetched
> and used to verify whether all branches are pointing to a sensible
> location (i.e., the location reported by the last user who
> pushed/merged).This ensures that a malicious server can't change the
> location to which branches point to.

This is what push certs ought to solve already?
AFAIU the main issue with untrustworthy servers is holding back the latest push.
As Ted said, usually there is problem in the code and then the fix is pushed,
but the malicious server would not advertise the update, but deliver the old
unfixed version.

This attack cannot be mitigated by having either a side channel (email
announcements)
or time outs (state is only good if push cert is newer than <amount of
time>, but this may
require empty pushes)


>
> Furthermore, upon fetching, users with write access also push an entry
> indicating that they fetched the BSL. This avoids cases in which a malicious
> attacker keeps older versions of the BSL and withhold changes to other users.

This would make it a "be malicious to all or none" thing? So the
attacker cannot attack
a single target IIUC.

I have a bad feeling about repository modifications upon fetching as
software distribution
is a highly asymmetric workflow (number of fetches is many orders of
magnitudes larger than
pushes), which may not scale well? (How would you serialize parallel
fetches into the BSL?)

Thanks,
Stefan
