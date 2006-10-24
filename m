From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Tue, 24 Oct 2006 10:37:10 +0200
Message-ID: <200610241037.11001.jnareb@gmail.com>
References: <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <46a038f90610231739x5beffc90u33c6a81f461974ec@mail.gmail.com> <845b6e870610240052l70ad72f4ma30065f151828dfd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>,
	"Linus Torvalds" <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 10:37:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcHmH-0000Wh-Vo
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 10:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbWJXIgt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006 04:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbWJXIgt
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 04:36:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:24793 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030213AbWJXIgs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Oct 2006 04:36:48 -0400
Received: by ug-out-1314.google.com with SMTP id 32so147795ugm
        for <git@vger.kernel.org>; Tue, 24 Oct 2006 01:36:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QZDof2nE+/OI4HQSXK7Th5Ewle/+xtiSSKmhYK2als1UY31L09Xw7Z7cV1KzsQzF044yB+X2YibEP7Bt6jBL8+odl2qQcQqtEv2Pr9HGP9UgKx+DDHikcmFrfg53NhLNc103AIiOXwzTq86YFDk7qicI9XgloalEsupvAJwWW/U=
Received: by 10.66.232.10 with SMTP id e10mr7976493ugh;
        Tue, 24 Oct 2006 01:36:45 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id e33sm344371ugd.2006.10.24.01.36.45;
        Tue, 24 Oct 2006 01:36:45 -0700 (PDT)
To: "Erik =?iso-8859-1?q?B=E5gfors?=" <zindar@gmail.com>
User-Agent: KMail/1.9.3
In-Reply-To: <845b6e870610240052l70ad72f4ma30065f151828dfd@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29944>

Erik B=E5gfors wrote:
> I think this disussion is getting out of hand.
>=20
> There are a few things that are being discussed
> 1. Revnos are bad/good
> 2. treating "leftmost" parrent special is bad/good
> 3. plugins are useless/useful
> 4. And now, storing branch information should be done manually (if
> wanted) and not automatically.
>=20
> 1. I don't really care, I haven't seen any confusion based on it, but
> I don't have a very strong opinion about it either.

To use revnos[*1*] you have to have branch as path through DAG. Bzr doe=
s
that by treating first parent special, which leads to empty merges
in fast-forward case.

Using revnos as implemented in bzr leads to some (perhaps unforeseen)
consequences.

[*1*] Meaning that revnos won't change on you.

> 2. This is something I do care about. =A0For me, this is the only
> logical way of doing it. It might be because I am used to it now, but
> when I started to look at bzr/hg/git/darcs/etc, I just got a so much
> more clear view of the history when running a standard log command,
> that it was one of the first things that attracted me to bzr. This is
> just a user talking.

Git has reflog for when you are interested in branch tip history
(which also stores "reason" for branch tip change: pull, amending
a commit, rebase,...). Git doesn't unfortunately have git-ref-log
command (or --ref option to git-log) to display reflog in user friendly=
=20
format.

Git users are used to use graphical history viewers (mainly gitk and=20
qgit, but there is also gitview, tig and git-browser) more to have=20
clear view of history, view that log cannot provide.

That said I _thing_ that caring about "branch identity" is just=20
something you are used to, perhaps because bzr doesn't have wonderfull=20
git log limiting specifiers aka. builtin git log searching (a..b,=20
a...b, --max-count, -- <path>, --committer, --grep etc.).

> There might be technical reasons why it's better to not do it, but fo=
r
> me it works the way I expect, therefore I'm happy

I think it would be better to maintain "branch identity" separately and=
=20
not in DAG, but that might have other problems I have not seen.

> 3. This is just silly

I think the discussion/arguments were twofold.=20

=46irst, Bazaar-NG has plugin infrastructure "for free" because it is=20
written in Python, which allows modules loading and monkey-patching.=20
Git core is written in C, and git is not yet fully libified.

Second, all that can be done with plugins except for core changes can b=
e=20
done in Git writing scripts (this also allows for fast prototyping).=20
All except core changes can be done writing few lines in C, but you=20
have to compile against some version of Git, and don't have advantages=20
of bultin command; git is OSS project.

> 4. No comment.

Storing branch information could be done automatically on demand ;-)
--=20
Jakub Narebski
Poland
