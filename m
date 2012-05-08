From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Please review this pull request for maint branch with update of de.po
Date: Tue, 8 May 2012 17:20:52 +0800
Message-ID: <CANYiYbGOrev6Frr7997gp_V7kj1jJP7HA=GGFYbeJ1RBL7E0yQ@mail.gmail.com>
References: <CANYiYbFf73hVen2sg1viNrXxt-g+tP=bF_ryBF8JYp0ZAL0b6A@mail.gmail.com>
	<CANYiYbFiwvy8Lw+XQTehbc3k2FukrvhCvR6urfAR_3xVqXxNZA@mail.gmail.com>
	<7vtxzr1kbd.fsf@alter.siamese.dyndns.org>
	<87ipg75drv.fsf@thomas.inf.ethz.ch>
	<CAN0XMOLeUxTgLw2KEJDJt8x6ebtJE2en-ChY3x=fbQdrH44COg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Thomas Rast <trast@student.ethz.ch>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	Git List <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Tue May 08 11:21:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRgbS-0002JJ-6U
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 11:21:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527Ab2EHJUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 05:20:55 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:55670 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510Ab2EHJUx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 05:20:53 -0400
Received: by yhmm54 with SMTP id m54so5088196yhm.19
        for <git@vger.kernel.org>; Tue, 08 May 2012 02:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YUrHGnGKay2ImqLhM5ABzUMr4CPU9lPhFCsBsg4Uy+c=;
        b=NixgCebyZkI5NyHY413pjafNULkrgVT1WKmYn0gxEun6nz1dXEqjl+Lx/OmCF0B0rq
         dLoi9gQAsxoveRDJFlHg6aZhC6rmujiN3uJ6l8MuTF7+7RC8eDQcXgcMJnSnqmN4swpd
         ekJYVf+KjO2K/zPuUgQpzUs4W2yi6U+LXGpAunDc/Lxh0asHmlOUXl68hvUU3ubNmCPO
         UUnNfxvqZfYtT5w1DPhwdz4UF5VpO4F/Mrzb9iOCouu/7sSdgLLiesmIlM/8yanJ2IYT
         e3rKjOFK9vVWV0F7OPFN9tWY1d1OETh+qnFKtJ1Wnb50YTtxVBfIVKnB67tzLVQFxRNx
         sQ7A==
Received: by 10.50.155.132 with SMTP id vw4mr10434960igb.27.1336468852227;
 Tue, 08 May 2012 02:20:52 -0700 (PDT)
Received: by 10.50.134.102 with HTTP; Tue, 8 May 2012 02:20:52 -0700 (PDT)
In-Reply-To: <CAN0XMOLeUxTgLw2KEJDJt8x6ebtJE2en-ChY3x=fbQdrH44COg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197350>

2012/5/8 Ralf Thielow <ralf.thielow@googlemail.com>:
> git-gui within a complete new patch (-series). That implies
> that Xin and I have to rewrite our history, don't?.

History of both master and maint branch of git-po has been
rewritten, and new git.pot is generated for both maint and
master branch. I see the tip commit of git.git maint branch is
"Start preparing for 1.7.10.2", and there is 1 new message,
so maybe no futher git.pot update for 1.7.10.2.

> It's pretty much easier to add a new commit which
> simply removes the change from git-gui.

Maybe you can work like this:

First, remove hacks on git-gui by a interactive rebase.

1. Start a interactive rebase against parent commit of fbd994d.

    $ git rebase -i fbd994d^

2. In the editor, change command for commit fbd994d
    from pick to edit; save and quit the edit.

3. The rebase process will stop at commit fbd994d.
    Revert hacks on "git-gui/po/de.po" by a checkout:

    $ git checkout HEAD^ -- git-gui/po/de.po

4. Amend your commit.

    $ git commit --amend

5. Continue the interactive rebase.

    $ git rebase --continue

Second, fetch the new maint branch from git-l10n/git-po
and do a rebase or merge. I prefer rebase, because
you won't have to write a merge commit log. ;-)

    $ git fetch https://github.com/git-l10n/git-po.git maint
    $ git rebase FETCH_HEAD

Then msgmerge git.pot to de.po, and translate 1 new message.

No forget reset your master branch completely before
merge the maint branch.

-- 
Jiang Xin
