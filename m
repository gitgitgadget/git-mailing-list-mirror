From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: New feature discussion: git rebase --status
Date: Tue, 11 Jun 2013 14:40:26 +0200
Message-ID: <871u8895xh.fsf@linux-k42r.v.cablecom.net>
References: <fb379a75c6c1af6dcff2e65bef1f1836@ensibm.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	<Matthieu.Moy@grenoble-inp.fr>
To: Mathieu =?utf-8?Q?Li=C3=A9nard--Mayor?= 
	<mathieu.lienard--mayor@ensimag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 11 14:40:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmNsN-0002Gx-Fe
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 14:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755072Ab3FKMk3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Jun 2013 08:40:29 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:56862 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752218Ab3FKMk2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jun 2013 08:40:28 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 11 Jun
 2013 14:40:23 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS20.d.ethz.ch (172.31.51.110) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 11 Jun 2013 14:40:25 +0200
In-Reply-To: <fb379a75c6c1af6dcff2e65bef1f1836@ensibm.imag.fr> ("Mathieu
	\=\?utf-8\?Q\?Li\=C3\=A9nard--Mayor\=22's\?\= message of "Tue, 11 Jun 2013 14:35:29
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227433>

Mathieu Li=C3=A9nard--Mayor <mathieu.lienard--mayor@ensimag.fr> writes:

> (Got the idea from:
> https://git.wiki.kernel.org/index.php/SmallProjectsIdeas#git_rebase_-=
-status)
>
> When in the middle of a rebase, users can be easily confused about
> what to do, or where they are in the rebase process.
>
> All the information is available in .git/rebase-merge/, but I believe
> it would be helpful to have a command (for example 'git rebase
> --status') which would explicitely indicate the state of the process.
>
> For instance, the output could look like:
>
> $ git rebase --status
> Rebasing my_last_commit onto base_commit
> Already applied 2 patches:
> 	b170635... my_commit_message
> 	b170635... my_commit_message
> Currently applying b170635... my_commit_message
> 2 patches left to apply:
> 	b170635... my_commit_message
> 	b170635... my_commit_message
>
>
> Another nice thing could be to improve the output of 'git status' by
> saying the number of patches left to apply.
> As an example, it could say:
> 	You are currently rebasing (patch 3/5).
>
> What do you think?
> Does the name rebase --status seem appropriate?
> Should the output be providing more/less information?

I think a worthy goal would be to arrange things such that the "here's
what you do next" messages are shared between --status and the code tha=
t
stops.  I.e., the same code should generate

  When you have resolved this problem, run "git rebase --continue".    =
                                 =20
  If you prefer to skip this patch, run "git rebase --skip" instead.   =
                                 =20
  To check out the original branch and stop rebasing, run "git rebase -=
-abort".

in both cases.  Naturally --status should also explain how it got into
this state, as you outlined above.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
