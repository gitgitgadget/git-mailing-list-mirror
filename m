X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Wink Saville <wink@saville.com>
Subject: Resolving conflicts
Date: Thu, 30 Nov 2006 23:06:09 -0800
Message-ID: <456FD461.4080002@saville.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 07:06:14 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32855>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq2TL-0002zx-Kr for gcvg-git@gmane.org; Fri, 01 Dec
 2006 08:06:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759261AbWLAHGI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 02:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759264AbWLAHGI
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 02:06:08 -0500
Received: from 70-91-206-233-BusName-SFBA.hfc.comcastbusiness.net
 ([70.91.206.233]:17891 "EHLO saville.com") by vger.kernel.org with ESMTP id
 S1759261AbWLAHGF (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006
 02:06:05 -0500
Received: from [192.168.0.52] (unknown [192.168.0.52]) by saville.com
 (Postfix) with ESMTP id 83D4C57A6F for <git@vger.kernel.org>; Thu, 30 Nov
 2006 23:02:08 -0800 (PST)
To: git <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

Sorry to be so ignorant, but I just updated to 2.6.19 using:

   git-checkout master
   git-pull

   ...
   sound/usb/usbaudio.c                          |    3
   usr/Makefile                                  |    2
   92 files changed, 888 insertions(+), 371 deletions(-)
   create mode 100644 arch/mips/kernel/topology.c
   create mode 100644 arch/um/os-Linux/execvp.c
   create mode 100644 include/asm-arm/mach/udc_pxa2xx.h

All seemed to go I then moved back to my branch and pulled from master to my branch:

   git-checkout ace
   git-pull . master

But that failed:

   Trying really trivial in-index merge...
   fatal: Merge requires file-level merging
   Nope.
   Merging HEAD with 0215ffb08ce99e2bb59eca114a99499a4d06e704
   Merging:
   d7083db038fb98266e331a7f96198ec35a12367a A partial fix BUG 061124 (crashing when 1ms interrrupts).
   0215ffb08ce99e2bb59eca114a99499a4d06e704 Linux 2.6.19
   found 1 common ancestor(s):
   1abbfb412b1610ec3a7ec0164108cee01191d9f5 [PATCH] x86_64: fix bad page state in process 'swapper'
   Auto-merging kernel/fork.c
   CONFLICT (content): Merge conflict in kernel/fork.c
   Auto-merging kernel/spinlock.c
   CONFLICT (content): Merge conflict in kernel/spinlock.c

   Automatic merge failed; fix conflicts and then commit the result.

I then searched the net for how to resolve conflicts, seems you
should start by doing a git-diff, so I did and I get this:

   diff --cc kernel/fork.c
   index d74b4a5,8cdd3e7..0000000
   --- a/kernel/fork.c
   +++ b/kernel/fork.c
   diff --cc kernel/spinlock.c
   index f4d1718,2c6c2bf..0000000
   --- a/kernel/spinlock.c
   +++ b/kernel/spinlock.c

And git-status shows:

   # On branch refs/heads/ace
   #
   # Updated but not checked in:
   #   (will commit)
   #
   #       modified: Documentation/rtc.txt
   #       modified: Makefile
   #       modified: arch/arm/configs/assabet_defconfig
   #       modified: arch/arm/configs/cerfcube_defconfig
   ......
   #       modified: sound/usb/usbaudio.c
   #       modified: usr/Makefile
   #
   #
   # Changed but not updated:
   #   (use git-update-index to mark for commit)
   #
   #       unmerged: kernel/fork.c
   #       modified: kernel/fork.c
   #       unmerged: kernel/spinlock.c
   #       modified: kernel/spinlock.c
   #

So what have I done wrong?
Did the pull complete and I just need to resolve this or
do I need to redo the git-pull?

Thanks,

Wink Saville
