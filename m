From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: git pull fails
Date: Tue, 28 Mar 2006 15:11:40 +0100
Message-ID: <20060328141140.GC3113@linux-mips.org>
References: <20060328162831.af1bd4c0.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 28 16:12:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOEvD-0000aq-31
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 16:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWC1OLo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 28 Mar 2006 09:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWC1OLo
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 09:11:44 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:63420 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S932255AbWC1OLn
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Mar 2006 09:11:43 -0500
Received: from localhost.localdomain ([127.0.0.1]:6311 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133720AbWC1OBO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Mar 2006 15:01:14 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k2SEBeIn021823;
	Tue, 28 Mar 2006 15:11:40 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k2SEBeRw021822;
	Tue, 28 Mar 2006 15:11:40 +0100
To: Timo Hirvonen <tihirvon@gmail.com>
Content-Disposition: inline
In-Reply-To: <20060328162831.af1bd4c0.tihirvon@gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18121>

On Tue, Mar 28, 2006 at 04:28:31PM +0300, Timo Hirvonen wrote:

> I think fast-forward check in git-fetch is too strict:
>=20
> 28 16:13 /usr/src/git: git pull
> Unpacking 33 objects
>  100% (33/33) done
> * refs/heads/todo: same as branch 'todo' of git://git.kernel.org/pub/=
scm/git/git
> * refs/heads/maint: same as branch 'maint' of git://git.kernel.org/pu=
b/scm/git/git
> * refs/heads/origin: same as branch 'master' of git://git.kernel.org/=
pub/scm/git/git
> * refs/heads/pu: does not fast forward to branch 'pu' of git://git.ke=
rnel.org/pub/scm/git/git;
>   not updating.
>=20
> After removing "exit 1" added by a9698bb22fb7b66e5882c3a5e7b2b8b53ea0=
3f90 from
> git-fetch "git pull" worked again.

Continuing to walk after breaking a leg isn't a good idea, but that's
basically what your change did.  What has happened to you is the normal
thing with branches that have been re-based or otherwise re-created.
The better way to handle this kind of branches is to add a `+=B4 sign t=
o
the refspec for the pu branc in .git/remote/origin like:

[ralf@blah git]$ cat .git/remotes/origin
URL: git://www.kernel.org/pub/scm/git/git.git
Pull: master:master
Pull: todo:todo
Pull: +next:next
Pull: maint:maint
Pull: +pu:pu
Pull: html:html
Pull: man:man
[ralf@blah git]$

The next branch is handled the same way, so another `+=B4 sign.

  Ralf
