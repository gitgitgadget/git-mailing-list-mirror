From: Linus Torvalds <torvalds@osdl.org>
Subject: git-fmt-merge-message problem..
Date: Wed, 12 Jul 2006 21:38:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607122133250.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 13 06:38:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0sxy-000482-VG
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 06:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWGMEiO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 00:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbWGMEiO
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 00:38:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46055 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932254AbWGMEiN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Jul 2006 00:38:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6D4c6nW006649
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 12 Jul 2006 21:38:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6D4c5u1010457;
	Wed, 12 Jul 2006 21:38:06 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.85__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23808>


Not a huge one, but it's ugly.

When I did a "git pull repo", the merge messages _used_ to look like this:

    Merge master.kernel.org:/pub/scm/linux/kernel/git/davem/net-2.6
    
    * master.kernel.org:/pub/scm/linux/kernel/git/davem/net-2.6:
      [NEIGH]: Fix IP-over-ATM and ARP interaction.
      [TG3]: ethtool always report port is TP.

or (if I specified a branch):

    Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/ro
    
    * 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/roland/infini
      IB/mthca: FMR ioremap fix
      IPoIB: Free child interfaces properly
      IB/mthca: Fix race in reference counting
      IB/srp: Fix tracking of pending requests during error handling
      IB: Fix display of 4-bit port counters in sysfs

but now they look like this:

    Merge commit master.kernel.org:/pub/scm/linux/kernel/git/davem/net-2.6 of HEAD
    
    * HEAD:
      [NET]: fix __sk_stream_mem_reclaim
      [Bluetooth] Fix deadlock in the L2CAP layer
      [Bluetooth] Let BT_HIDP depend on INPUT
      [Bluetooth] Avoid NULL pointer dereference with tty->driver
      [Bluetooth] Remaining transitions to use kzalloc()
      [WAN]: converting generic HDLC to use netif_dormant*()
      [IPV4]: Fix error handling for fib_insert_node call
      [NETROM] lockdep: fix false positive
      ....

which makes no sense AT ALL. It's doesn't even parse. "Merge commit <repo> 
of <branch>"? Whaa? That's just insane.

Also, the " * HEAD" is just ugly. It was better before.

Dscho? Can you please make git fmt-merge-message print out something 
sensible again? It doesn't have to match the old behaviour 100%, but the 
current one is just ugly and senseless.

			Linus
