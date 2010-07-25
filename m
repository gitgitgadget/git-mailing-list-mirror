From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH 0/9] commit: more focused advice in the 
	no-changes-staged case
Date: Sun, 25 Jul 2010 08:54:22 +0000
Message-ID: <AANLkTilnQhsopnuAf0nja8Qq63VrOlt0_uCJrqYv5X-v@mail.gmail.com>
References: <20100725005443.GA18370@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff King <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 10:54:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ocwyb-0001x5-3p
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 10:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321Ab0GYIyY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 04:54:24 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60610 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504Ab0GYIyX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jul 2010 04:54:23 -0400
Received: by iwn7 with SMTP id 7so1777774iwn.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 01:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JVEZwxKhxp5w2kJarQ77K1f1uVhyKXAXHAojbfR5tGs=;
        b=k2wVZh5/bJOYKjxV12yG1prLy3zUWBkBr9mLHoJhYIXClfvQJ5G7rjiro3Xx4AJW9u
         F9MN1DBgm8Gaxno6DAuk1/mP4/HTPMzK7CnwKJjxgVP8v5GThmeNY3ygVuN2uX3awvKv
         PBSaHR0hG/D/GBwBktuRgDFGat6KuiZ9Ti7mw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IVCcvTaxza7iW301tKLbTHY9eoFsoJloRJHI8h1vDqMRInQkjk+E5FWwAnGoRBnXZ6
         wbELK9rNqM6+87iimtnRCI8oZfr13bZlH9FjdXfGuUAEdHMy5ZsJMttZf6PxPH3U+Waj
         /xU+a924g8jhz4nt88U6+SSW7HkfIgya+yA4Y=
Received: by 10.231.170.13 with SMTP id b13mr530383ibz.62.1280048062504; Sun, 
	25 Jul 2010 01:54:22 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Sun, 25 Jul 2010 01:54:22 -0700 (PDT)
In-Reply-To: <20100725005443.GA18370@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151715>

On Sun, Jul 25, 2010 at 00:54, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Hi,
>
> When last seen[1], this series was a single patch in very rough form,
> but there have been almost no functional changes since then.
>
> The patches suppress most output when =E2=80=9Cgit commit=E2=80=9D is=
 run without
> stages changed. =C2=A0So instead of
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git commit
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# On branch master
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# Changed but not updated:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# =C2=A0 (use "git add <file>..." to updat=
e what will be committed)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# =C2=A0 (use "git checkout -- <file>..." =
to discard changes in working directory)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0#
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# =C2=A0 =C2=A0 =C2=A0 modified: =C2=A0 di=
r1/modified
> =C2=A0 =C2=A0 =C2=A0 =C2=A0#
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# Untracked files:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# =C2=A0 (use "git add <file>..." to inclu=
de in what will be committed)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0#
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# =C2=A0 =C2=A0 =C2=A0 actual
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# =C2=A0 =C2=A0 =C2=A0 dir1/untracked
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# =C2=A0 =C2=A0 =C2=A0 dir2/modified
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# =C2=A0 =C2=A0 =C2=A0 dir2/untracked
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# =C2=A0 =C2=A0 =C2=A0 expect
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# =C2=A0 =C2=A0 =C2=A0 output
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# =C2=A0 =C2=A0 =C2=A0 untracked
> =C2=A0 =C2=A0 =C2=A0 =C2=A0no changes added to commit (use "git add" =
and/or "git commit -a")
>
> which may cause a newcomer to panic, you get
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git commit
> =C2=A0 =C2=A0 =C2=A0 =C2=A0no changes added to commit (use "git add" =
and/or "git commit -a")
>
> which would just cause her to scratch her head or say =E2=80=9Coh, ri=
ght!=E2=80=9D
> instead. =C2=A0Hopefully these patches will at least provide a remind=
er to
> improve the various "no changes" advice messages.
>
> Ideas for future work:
>
> =C2=A0- add some tests
> =C2=A0- give the full traditional output if -a or any paths were pass=
ed on
> =C2=A0 the command line.
>
> Most of the patches are code clarity improvements which is not
> strictly related to this topic.
>
> Patch 6 cleans up the most obvious script to add tests for this in,
> though I have not added any tests to it.
>
> Patch 8 changes commit --dry-run output in a more modest way, to
> print the same advice Jeff added to commit proper last month. =C2=A0I
> suspect this is a good change, but input from people who script
> around commit --dry-run would be welcome.
>
> Patch 9 is the advertised patch. =C2=A0It should be self-explanatory.
>
> Thoughts?

=46irstly. Acked-by on patches 1-8, they're some much needed
cleanup. Especially fixing the hairy wt-status.c code and the test
fixes.

I'm not so sure about 9/9. Every time I make this mistake with "git
commit" I find it helpful to be able to just look up to see what I
need to stage. But perhaps the wall of text can be confusing to
newbies, I don't have a strong opinion on whether it should be
included or not.

As an aside, isn't this sort of thing (i.e. long notices/help
messages) usually hidden behind advice.* nowadays?

With the stripped down message nothing tells you how to find out what
to add, which the old message did just by including the "git status"
output.

Anyway, meh, I don't know :)
