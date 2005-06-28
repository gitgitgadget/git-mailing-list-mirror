From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Tue, 28 Jun 2005 17:54:14 -0400
Message-ID: <200506282154.j5SLsETL010486@laptop11.inf.utfsm.cl>
References: <andrewkt@aktzero.com>
Cc: Petr Baudis <pasky@ucw.cz>, Christopher Li <hg@chrisli.org>,
	mercurial@selenic.com, Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 28 23:53:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnO0x-0003vL-Q1
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 23:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVF1V6b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 17:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVF1V4p
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 17:56:45 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:59316 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261490AbVF1Vys (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2005 17:54:48 -0400
Received: from laptop11.inf.utfsm.cl (fw.inf.utfsm.cl [200.1.19.2])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id j5SLsGVF004943
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 28 Jun 2005 17:54:16 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.4/8.13.1) with ESMTP id j5SLsETL010486;
	Tue, 28 Jun 2005 17:54:15 -0400
To: Andrew Thompson <andrewkt@aktzero.com>
In-Reply-To: Message from Andrew Thompson <andrewkt@aktzero.com> 
   of "Tue, 28 Jun 2005 11:10:47 -0400." <42C16877.6000909@aktzero.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Tue, 28 Jun 2005 17:54:16 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Andrew Thompson <andrewkt@aktzero.com> wrote:
> Petr Baudis wrote:

> >>Mercurial's undo is taking a snapshot of all the changed file's repo
> >>file length at every commit or pull.  It just truncate the file to
> >>original size and undo is done.

> > "Trunactes"? That sounds very wrong... you mean replace with old
> > version? Anyway, what if the file has same length? It just doesn't make
> > much sense to me.

> I believe this works because the files stored in a binary format that
> appends new changesets onto the end. Thus, truncating the new stuff
> from the end effectively removes the commit.

And is exactly the wrong way around. Even RCS stored the _last_ version and
differences to earlier ones (you'll normally want the last one (or
something near), and so occasionally having to reconstruct earlier ones by
going back isn't a big deal; having to build up the current version by
starting from /dev/null and applying each and every patch that ever touched
the file each time is expensive given enough history, besides that any
error in the file is guaranteed to destroy the current version, not
(hopefully) just making old versions unavailable).  It also means that
losing old history (what you'll want to do once in a while, e.g. forget
everything before 2.8) is simple: Chop off at the right point.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
