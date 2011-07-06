From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 12/14] revert: Introduce --reset to cleanup sequencer data
Date: Wed, 6 Jul 2011 16:25:02 +0530
Message-ID: <CALkWK0mLaCy3LePYYEpby-sd9Z2a=DWq4uWvFiadin7sa_h2+w@mail.gmail.com>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
 <1309938868-2028-13-git-send-email-artagnon@gmail.com> <20110706101423.GI15682@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 12:55:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QePlR-0004ah-BK
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 12:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576Ab1GFKzY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jul 2011 06:55:24 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64885 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005Ab1GFKzX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2011 06:55:23 -0400
Received: by wyg8 with SMTP id 8so4577382wyg.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 03:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Pa02WRWQnGSsc9jrotGx/LJs8ZAZQjtU2cGwkL6TNrs=;
        b=oi/EpFgcFEp26hoWmhop7+LotY8smuVuETBBzGVwUKAehihPmKMeiJJYE6HYrCpU4V
         g2WjALXDzyqU57p2v7YvYlweDBHbggGcl7s8qOTNSorukyZD6DXCEqOrhGOqGcbEhs7I
         YLe6+VvFKcHhWF0OsHlo5v+reT8nCoLBAJI5Q=
Received: by 10.217.3.17 with SMTP id q17mr5261352wes.107.1309949722111; Wed,
 06 Jul 2011 03:55:22 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Wed, 6 Jul 2011 03:55:02 -0700 (PDT)
In-Reply-To: <20110706101423.GI15682@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176686>

Hi,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> =C2=A0This is perfect but for the fact that 'git reset --hard' doesn=
't blow
>> =C2=A0away the sequencer state. =C2=A0Why I haven't implemented that=
 yet: should
>> =C2=A0ONLY a hard reset blow away the state?
>
> I don't know. =C2=A0What do you think?

I personally don't think any other kind of reset would warrant blowing
away the sequencer state.

> The constraints I see are:
>
> =C2=A01. outside scripts that use "git cherry-pick" should continue t=
o work
>
> =C2=A02. as a small indication that that's vaguely possible, unrelate=
d parts
> =C2=A0 =C2=A0of the test suite should not need to be patched

I don't see how this is possible.  I'm tempted to say that we should
call this new cherry-picking mechanism with the sequencing
functionality something else like "git sequencer"; then it's possible
to avoid breaking existing scripts.

> =C2=A03. when a person uses commands like "git reset --hard" without
> =C2=A0 _intending_ to blow away the sequencer state, it should be pos=
sible
> =C2=A0 to get the sequencer state back.

I like your suggestion here -- simply move .git/sequencer to
=2Egit/sequencer-old or similar :)

> For dealing with "git rebase --interactive" and similar porcelain-ish
> scripts, the CHERRY_PICK_HEAD code-path has its own trick of falling
> back to traditional behavior when the GIT_CHERRY_PICK_HELP environmen=
t
> variable is set (see v1.5.4-rc0~106^2~1, revert/cherry-pick: Allow
> overriding the help text by the calling Porcelain, 2007-11-28).

Ah, I see.

-- Ram
