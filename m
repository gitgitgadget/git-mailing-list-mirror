From: Enrico Weigelt <enrico.weigelt@vnc.biz>
Subject: Re: Bizarre problem cloning repo from Codeplex
Date: Sat, 10 Nov 2012 08:49:53 +0100 (CET)
Message-ID: <6c843260-6190-469a-aa53-243ac440b0fd@zcs>
References: <508B133D.3090300@game-point.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Jeremy Morton <admin@game-point.net>
X-From: git-owner@vger.kernel.org Sat Nov 10 08:50:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TX5pR-0001kS-IF
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 08:50:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625Ab2KJHt4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Nov 2012 02:49:56 -0500
Received: from zcs.vnc.biz ([83.144.240.118]:18886 "EHLO zcs.vnc.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751415Ab2KJHtz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2012 02:49:55 -0500
Received: from localhost (localhost [127.0.0.1])
	by zcs.vnc.biz (Postfix) with ESMTP id 50BFF622260;
	Sat, 10 Nov 2012 08:49:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at vnc.biz
Received: from zcs.vnc.biz ([127.0.0.1])
	by localhost (zcs.vnc.biz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rzj3JNa+XWyY; Sat, 10 Nov 2012 08:49:53 +0100 (CET)
Received: from zcs.vnc.biz (zcs.vnc.biz [172.17.1.118])
	by zcs.vnc.biz (Postfix) with ESMTP id D3397622259;
	Sat, 10 Nov 2012 08:49:53 +0100 (CET)
In-Reply-To: <508B133D.3090300@game-point.net>
X-Originating-IP: [91.43.209.211]
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC20 (Linux)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209260>


> I'm trying to clone the following repository from Codeplex:
>=20
> https://git01.codeplex.com/entityframework.git
>=20
> git downloads all the objects, creates the directory
> "entityframework",
> then displays "error: RPC failed; result=3D56, HTTP code =3D 200" and
> immediately deletes the directory.
>=20
> I can clone other HTTPS repos with this git installation, for example
> from Bitbucket and Github.  It's git 1.7.10.4 on Debian. =20

reproduced it on Ubuntu precise, git-1.7.9.5

When starting with an empty repo, adding the url as remote and calling
git remote update origin:

> Fetching origin
> WARNING: gnome-keyring:: couldn't connect to: /tmp/keyring-5cWq1d/pkc=
s11: No such file or directory
> remote: Counting objects: 21339, done.
> remote: Compressing objects: 100% (3778/3778), done.
> remote: Total 21339 (delta 17180), reused 21339 (delta 17180)
> Receiving objects: 100% (21339/21339), 11.24 MiB | 1.04 MiB/s, done.
> error: RPC failed; result=3D56, HTTP code =3D 200
> Resolving deltas: 100% (17180/17180), done.
> error: Could not fetch origin

But: refs/remotes/origin/master is added and looks sane (git fsck
shows no errors).

Subsequent 'git remote update' calls look good:

> Fetching origin

Even after manually removing the ref and re-running update,
everything look fine:

> Fetching origin
> WARNING: gnome-keyring:: couldn't connect to: /tmp/keyring-5cWq1d/pkc=
s11: No such file or directory
> From https://git01.codeplex.com/entityframework
>  * [new branch]      master     -> origin/master

Their webserver seems to be configured quite restrictively
(eg. cannot access files like 'packed-refs').

Is there a way to trace the actual HTTP calls ?


cu
--=20
Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards=20

Enrico Weigelt=20
VNC - Virtual Network Consult GmbH=20
Head Of Development=20

Pariser Platz 4a, D-10117 Berlin
Tel.: +49 (30) 3464615-20
=46ax: +49 (30) 3464615-59

enrico.weigelt@vnc.biz; www.vnc.de=20
