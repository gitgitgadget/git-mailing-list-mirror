From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Patch (apply) vs. Pull
Date: Thu, 23 Jun 2005 15:49:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506231523020.11175@ppc970.osdl.org>
References: <Pine.LNX.4.21.0506231522080.30848-100000@iabervon.org>
 <Pine.LNX.4.58.0506231510370.11175@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
X-From: git-owner@vger.kernel.org Fri Jun 24 00:41:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlaNo-00075x-9g
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 00:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbVFWWre (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 18:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262769AbVFWWre
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 18:47:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4993 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262675AbVFWWrT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2005 18:47:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5NMl3jA007249
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 23 Jun 2005 15:47:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5NMl2QZ016733;
	Thu, 23 Jun 2005 15:47:02 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.58.0506231510370.11175@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 23 Jun 2005, Linus Torvalds wrote:
> 
> It's also obviously totally untested, but hey, I always write perfect
> code, so what could _possibly_ go wrong..

Actually, for once it actually does work.

Doing this for the whole current git kernel history shows the following
patch ID's that are duplicates:

 - fix ia64 syscall auditing:
	0d9a1c0b1d4009f81f1c3d558961cc1eaf89c43d 3ac3ed555bec5b1f92bb22cb94823a0e99d0f320
	0d9a1c0b1d4009f81f1c3d558961cc1eaf89c43d 446b8831f5acf2076fa58a66286789eb84f3df2c

 - remove outdated print_* functions:
	1a830d81e7580b55eb0d445a5bf43920e1dba211 1409277c4aad2e87ad27b2b8a6901ce78eaf8081
	1a830d81e7580b55eb0d445a5bf43920e1dba211 db9dff366ba78085d0323364fadbf09bec0e77ee

 - zfcp: add point-2-point support:
	3969795b9b61425ef7e7ac52e9576203dc1ca71a 6f71d9bc025b02a8cbc2be83b0226a7043a507a5
	3969795b9b61425ef7e7ac52e9576203dc1ca71a 91bbfbda8d41f834c70c47d6f8c95245c90019e5

 - ppc32: add 405EP cpu_spec entry:
	59a8f295cf4c44cae74db41699392dc22db64df1 7fbdf1a23be1837b8bc5bcec096015ca99e00aa7
	59a8f295cf4c44cae74db41699392dc22db64df1 ad95d6098dd1e94a09d2a1fdf39fd8281fcd8958
	59a8f295cf4c44cae74db41699392dc22db64df1 beb9e1c3f32a0f878765c7c1142f91083739c5bd

 - Convert i2o to compat_ioctl:
	6ab2bc457d0a736d97f26f2ca75666bb981fdc42 83363ea074504f9005e28cd6209923637bb74de5
	6ab2bc457d0a736d97f26f2ca75666bb981fdc42 f4c2c15b930b23edaa633b09fe3f4c01b4ecce9f

 - ppc32: Fix Alsa PowerMac driver on old machines:
	7c82fcb20679f5c24c8db37b6dc554bf841744e9 5218064c885af5c49e380d09d54f3cc86891a580
	7c82fcb20679f5c24c8db37b6dc554bf841744e9 9ae250d175e1cbff82223ce2c07897c790c5b948

 - scsi: remove unused scsi_cmnd->internal_timeout field
	883a1e3ca52a071eaf9d53e66d13b250c6d60942 97665e9c22991401dc56968619c6b8b9c09f3268
	883a1e3ca52a071eaf9d53e66d13b250c6d60942 d3a933dc9851e74581f9f4c8e703e77901ae8d01

 - scsi: remove meaningless scsi_cmnd->serial_number_at_timeout field:
	8d3c15861cc08388e610940506255d3a19109aee 84011ae88da62a20b3ae7b48e2ae3b1ef0fc810a
	8d3c15861cc08388e610940506255d3a19109aee c6295cdf656de63d6d1123def71daba6cd91939c

 - kill old EH constants:
	9b0f17e44f99618902fa0cdc5cd73711060f3650 0db7157ca47e21c7623a59e710b807ad06fce161
	9b0f17e44f99618902fa0cdc5cd73711060f3650 2bc474c3646efba67bdc83b7fc7d8ee7562e0106

 - input: Fix fast scrolling scancodes in atkbd.c:
	bb6b1e4d2d979e1cccf96d0dd494f608d5143bee 5212dd58e67e4b8009107d69a9de45dd2e687496
	bb6b1e4d2d979e1cccf96d0dd494f608d5143bee 7d6064d44bc79e328f2794ee7322ba2676511e2b

 - scsi: add DID_REQUEUE to the error handling:
	c62473f1990c475b087fee7280a1b2e9b9589bc5 686579d95d48c713bdb7008cc76af8398219e687
	c62473f1990c475b087fee7280a1b2e9b9589bc5 bf341919dbc1fbcbb565fb3224c840760ebd9f85

 - consolidate timeout defintions in scsi.h:
	d56aa0d90bced261ddf3b58038fca3cbff59a189 0890d74f295be849032fd4390ee00422dfda83b1
	d56aa0d90bced261ddf3b58038fca3cbff59a189 b6651129cc27d56a9cbefcb5f713cea7706fd6b7

 - kill gratitious includes of major.h:
	e938d763a9c231acbf93f1140c911cbec447c89d 5523662c4cd585b892811d7bb3e25d9a787e19b3
	e938d763a9c231acbf93f1140c911cbec447c89d b453257f057b834fdf9f4a6ad6133598b79bd982

 - drivers/scsi/sym53c416.c: fix a wrong check:
	eb2d067160e40137cd00590e59e800dd09c4f62f 380c3877ae5de888cfb7a59990b9aee5a415295f
	eb2d067160e40137cd00590e59e800dd09c4f62f b6f0b0d016a254ff583fec26f2c9e21c1ae2fdf3

 - ultrastor: fix compile failure:
	ed19cee5e4439c92e4e711fe1c10569b58415c46 4e33bd874bce8b3df2ab52538db59730196383c3
	ed19cee5e4439c92e4e711fe1c10569b58415c46 69aa3f71580990f39e387d96ed1001d2f5fb04b1

 - qla trivial iomem annotation:
	ff16fe82338d2dd7d8baf6a3b38780e0eac2b1f0 766f2fa170e65948053b06c6106c8dc8526c3e14
	ff16fe82338d2dd7d8baf6a3b38780e0eac2b1f0 93fc4294fc112ce4e518a3f62dea8681dc39d9cf

where the first number is the patch ID, the the second number is the 
commit ID.

What's interesting to note here is the following:

 - it actually did find duplicates in the current kernel that had just 
   merged perfectly and come in through two different trees.

   It's also interesting to note that while most of them had largely the
   same commit message (ie they clearly got applied from the same emailed
   diff), the algorithm doesn't even look at that one, and thus the fact
   that some had extra comments ("I have tested this patch and have seen
   no problems with it.") others had not just different sign-offs (due to 
   the different paths they took), but different authors noted.

   Ie this really doesn't care at all about how the patch came there, it 
   just notices that the patch is identical to some other patch.

 - it didn't have a single false positive (the above is the full list of 
   duplicate patch ID's - I just did a

	git-whatchanged -p | git-patch-id | LANG=C sort > sorted-patch-list

   followed by

	cut -d' ' -f1 sorted-patch-list | uniq -d | join -j 1 - sorted-patch-list

   and then when you have that list, you can check the commits themselves 
   with

	cut -d' ' -f2 dup-list | git-diff-tree --pretty -p --stdin | less -S

   and verify the output.

 - it actually found the patch that got incorrectly applied _three_times_ 
   ("ppc32: add 405EP cpu_spec entry") because it continued to apply, and
   thus Andrew's scripts didn't notice it.

In other words, this "check patch ID's" thing is not only efficient, it
actually seems to work. It literally checked the last 2+ months of kernel
history (2788 patches) for duplicate patches in just under a minute, and
might be useful to Andrew etc as a way to see "yup, that patch got
applied".

Doing the same for just the difference between two branches is pretty much
instantaneous. You can basically check ~50 patches a second using this.

		Linus
