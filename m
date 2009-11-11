From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git-svn problem with v1.6.5
Date: Wed, 11 Nov 2009 14:41:32 -0500
Message-ID: <32541b130911111141n7b029b1ep68656d2eb39be3c7@mail.gmail.com>
References: <4AF9E7FE.3060701@obry.net> <32541b130911101428t50038cfcsf37e3ea9edb26f64@mail.gmail.com> 
	<4AFA91BB.7050402@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>, adambrewster@gmail.com,
	git list <git@vger.kernel.org>
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Wed Nov 11 20:42:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8J4u-0005Ny-A9
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 20:42:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758551AbZKKTlr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Nov 2009 14:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758574AbZKKTlr
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 14:41:47 -0500
Received: from mail-yw0-f202.google.com ([209.85.211.202]:62521 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758557AbZKKTlq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Nov 2009 14:41:46 -0500
Received: by ywh40 with SMTP id 40so1268603ywh.33
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 11:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=N7cIEzoks/CX3rsqkrERD2TZ6VMmhyrsUwrPds1eTIA=;
        b=WqrAMu8fDkHEJuKt8TPKFWdMYstpTkONl4Wlvp0zUcWhnldP5acm/o3J8la8S9BpiD
         rQvOUrLXb1Lub7H2XMVz6sjB2EP0t35R2HxCO3mGRu7t+xn3PICkHEzUZEE0UZRMS/uG
         +hP75dfrBR8oRbhHfn6zOzLWoXpURVF5grJR4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=tuThJ+XGf2JFsWapH6X0umVtTdFaXBd6hfY0WnW2FEOC++FBDSkPlEXW8v6r78Yvgi
         RdKsvT/mJuxKGoAkiEq9Fevdh8cwzFLIXnqkcmgjMSkg1sPaAXJT/uTNxsJ6Vw/cFBXA
         UBf7Skk7CdZiDV7oQZwDCKn+QTO/E/nSJhpkU=
Received: by 10.150.236.17 with SMTP id j17mr3450688ybh.229.1257968512079; 
	Wed, 11 Nov 2009 11:41:52 -0800 (PST)
In-Reply-To: <4AFA91BB.7050402@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132691>

On Wed, Nov 11, 2009 at 5:28 AM, Pascal Obry <pascal@obry.net> wrote:
>> Avery wrote:
>> Is d2cf08bb67e4b7da33a250127aab784f1f2f58d3 a valid revision? =A0(gi=
t
>> log d2cf08bb67e4b7da33a250127aab784f1f2f58d3).
>
> No.

Well, that's bad news.  Does "git log --all --parents | grep
d2cf08bb67e4b7da33a250127aab784f1f2f58d3" reveal any places that refer
to it?

It sounds a bit like your git-svn thinks something maps on to that
commit id, but a previous 'git gc' or something has thrown it away.
However, that doesn't explain why earlier git versions don't have this
problem.

>> You could try using git bisect to figure out which exact commit to
>> git.git created the problem.
>
> I wanted to avoid that :) Anyway, here is the culprit:
>
> commit 6f5748e14cc5bb0a836b649fb8e2d6a5eb166f1d
> Author: Adam Brewster <adambrewster@gmail.com>
> Date: =A0 Tue Aug 11 23:14:27 2009 -0400
>
>   svn: allow branches outside of refs/remotes
[...]
>
> But frankly I'm no expert on Perl... I fear that I won't be able to d=
ebug
> that!

If you retrieve the latest version of git and then git revert the
above commit, does that fix the problem, at least?

Is it possible you have some weird branches outside of the
refs/remotes tree (either in .git itself, or in .git/refs/*) that you
forgot about, and which the new version of git-svn is finding somehow?

Avery
