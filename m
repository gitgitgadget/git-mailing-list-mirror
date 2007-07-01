From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH] git-svn: allow dcommit to retain local merge
	information
Date: Sun, 01 Jul 2007 15:09:44 +0200
Organization: Transmode AB
Message-ID: <1183295384.20673.116.camel@gentoo-jocke.transmode.se>
References: <466C8B35.3020207@midwinter.com>
	 <003401c7abba$c7574300$0e67a8c0@Jocke> <20070611042509.GA19866@muzzle>
	 <7vir9vox5l.fsf@assigned-by-dhcp.cox.net> <20070612072035.GA29385@muzzle>
	 <7v1wghlj7j.fsf@assigned-by-dhcp.pobox.com> <20070612083910.GA28369@muzzle>
	 <20070613092328.GA30318@muzzle>
	 <1181754781.30670.323.camel@gentoo-jocke.transmode.se>
	 <20070620065600.GA25010@muzzle>
Reply-To: joakim.tjernlund@transmode.se
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jul 01 15:09:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4zBb-0001QB-Pa
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 15:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755992AbXGANJs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 09:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755812AbXGANJs
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 09:09:48 -0400
Received: from mail.transmode.se ([83.241.175.147]:9962 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755490AbXGANJr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 09:09:47 -0400
Received: mail.transmode.se 192.168.46.15 from 192.168.1.15 192.168.1.15 via HTTP with MS-WebStorage 6.0.6249
Received: from gentoo-jocke by mail.transmode.se; 01 Jul 2007 15:09:44 +0200
In-Reply-To: <20070620065600.GA25010@muzzle>
X-Mailer: Evolution 2.8.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51293>


> > Sidenote:
> > Doing this 
> >   git-svn init -t tags -T trunk -b branches  file:///usr/local/src/tst-git-svn/svn-uboot-repo
> >   git-svn fetch --quiet
> > makes git svn fetch stop for rather long periods in do_update:
> >   Found possible branch point: file:///usr/local/src/tst-git-svn/svn-uboot-repo/trunk => file:///usr/local/src/tst-git-svn/svn-uboot-repo/tags/snap-uboot-1.1.4, 2
> >   Found branch parent: (tags/snap-uboot-1.1.4) 81eef14963597cc99ba375f52e6d0b3bc09e25f8
> >   Following parent with do_update
> >   Successfully followed parent
> > 
> > Is it possible to speed up do_update?
> 
> Use a do_switch()-enabled SVN to avoid do_update().  do_update will
> redownload everything.  I have patched 1.4.3 debian packages with source
> and a diff here: http://git-svn.bogomips.org/svn.  SVN 1.4.4 claims to
> have fixed the bindings, but 1.4.3 claimed the same thing, too...
> Confirmation of it working in SVN 1.4.4 would be nice.

I upgraded to svn 1.4.4 and it seemed to work OK, but then i noticed
some problems, 
 git clone -t tags -T trunk -b branches svn+ssh://devsrv/svn/TM-uboot
failed(error msg was something with "Malformed data ...")

I decided to go back to 1.4.3 with you patch, switch-editor-perl.diff
applied. Now the error was gone, but the clone operation did use
do_update insted of do_switch. Did I miss someting?

 Jocke
