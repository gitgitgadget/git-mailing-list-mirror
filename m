From: Enrico Weigelt <enrico.weigelt@vnc.biz>
Subject: Re: bare vs non-bare <1.7 then >=1.7 ?
Date: Sat, 10 Nov 2012 09:23:07 +0100 (CET)
Message-ID: <e4dc73e8-69f9-4695-b8f7-cbc0f04e8197@zcs>
References: <509B8552.4080303@rktmb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Issues <git@vger.kernel.org>
To: Mihamina Rakotomandimby <mihamina@rktmb.org>
X-From: git-owner@vger.kernel.org Sat Nov 10 09:28:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TX6QB-0002Pd-SZ
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 09:28:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092Ab2KJIXL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Nov 2012 03:23:11 -0500
Received: from zcs.vnc.biz ([83.144.240.118]:47758 "EHLO zcs.vnc.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751949Ab2KJIXJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2012 03:23:09 -0500
Received: from localhost (localhost [127.0.0.1])
	by zcs.vnc.biz (Postfix) with ESMTP id 6A921460009;
	Sat, 10 Nov 2012 09:23:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at vnc.biz
Received: from zcs.vnc.biz ([127.0.0.1])
	by localhost (zcs.vnc.biz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id krOq2Un4Qa6N; Sat, 10 Nov 2012 09:23:07 +0100 (CET)
Received: from zcs.vnc.biz (zcs.vnc.biz [172.17.1.118])
	by zcs.vnc.biz (Postfix) with ESMTP id DDC7B622259;
	Sat, 10 Nov 2012 09:23:07 +0100 (CET)
In-Reply-To: <509B8552.4080303@rktmb.org>
X-Originating-IP: [91.43.209.211]
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC20 (Linux)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209263>


> When experimenting in order to train some colleagues, I saw that If I
> clone a repository, I couldn't push to it because it was a non-bare
> one.
> Searchin for some explanations, I found this ressource:
> http://www.bitflop.com/document/111

That's just a precaution (technically it's not necessary, just stops
you from doing some dumb things). Suppose the following scenario:

* non-bare repository A, with branch 'master' currently checked out.
* clone B -> somebody's working on branch 'master' (which was forked=20
  from A's master)
* on A, somebody did some local changes
* meanwhile somebody pushes the branch 'master' from B to A
* after that, on A, new commit to 'master'.

Weird things can happen, eg. the changes coming from B completely
reverted by the new commit in A.

Unless nobody pushes to the branch currently checked and later somebody
doing local changes after that, there shouldn't be any real technical
problem. But then, you most likely wont need an worktree anyways.

Wait, there *is* an usecase for such things, deploying trees (eg. webap=
ps)
some server:

 * application is developed in git
 * the final production-system tree is maintained in certian branch
 * a post-update hook acts on a specific production branch and does
   something like git checkout --detach <treeish>


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
