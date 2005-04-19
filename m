From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: SCSI trees, merges and git status
Date: Mon, 18 Apr 2005 17:03:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504181651241.15725@ppc970.osdl.org>
References: <1113856118.4998.70.camel@mulgrave>  <Pine.LNX.4.58.0504181429570.15725@ppc970.osdl.org>
 <1113866092.4998.92.camel@mulgrave>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, SCSI Mailing List <linux-scsi@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 19 01:59:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNg8N-0001Iv-Jv
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 01:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVDSACT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 20:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVDSACT
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 20:02:19 -0400
Received: from fire.osdl.org ([65.172.181.4]:1483 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261188AbVDSABu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 20:01:50 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3J01ks4012822
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 18 Apr 2005 17:01:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3J01jxL013030;
	Mon, 18 Apr 2005 17:01:46 -0700
To: James Bottomley <James.Bottomley@SteelEye.com>
In-Reply-To: <1113866092.4998.92.camel@mulgrave>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 18 Apr 2005, James Bottomley wrote:
> 
> It looks like the merge tree has contamination from the scsi-misc-2.6
> tree ... possibly because the hosting system got the merged objects when
> I pushed.

Nope, the way I merge, if I get a few objects it shouldn't matter at all. 
I'll just look at your HEAD, and merge with the objects that represents.

Afterwards, if I have extra objects, I'll see them with fsck-cache. 

> Could you strip it back and I'll check out the repos on www.parisc-
> linux.org?

Git does work like BK in the way that you cannot remove history when you
have distributed it. Once it's there, it's there.

The patches from you I have in my tree are:

	scsi: add DID_REQUEUE to the error handling
	zfcp: add point-2-point support
	[PATCH] Convert i2o to compat_ioctl
	[PATCH] kill old EH constants
	[PATCH] scsi: remove meaningless scsi_cmnd->serial_number_at_timeout field
	[PATCH] scsi: remove unused scsi_cmnd->internal_timeout field
	[PATCH] remove outdated print_* functions
	[PATCH] consolidate timeout defintions in scsi.h

or at least that's what they claim in their changelogs.

Oh, and here's the diffstat that matches "scsi":

 drivers/block/scsi_ioctl.c                 |    5 -
 drivers/s390/scsi/zfcp_aux.c               |    4 -
 drivers/s390/scsi/zfcp_def.h               |    5 +
 drivers/s390/scsi/zfcp_erp.c               |   20 +++++
 drivers/s390/scsi/zfcp_fsf.c               |   38 ++++++++--
 drivers/s390/scsi/zfcp_fsf.h               |    6 +
 drivers/s390/scsi/zfcp_sysfs_adapter.c     |    6 +
 drivers/scsi/53c7xx.c                      |   23 +++---
 drivers/scsi/BusLogic.c                    |    7 -
 drivers/scsi/NCR5380.c                     |    9 +-
 drivers/scsi/advansys.c                    |    7 -
 drivers/scsi/aha152x.c                     |   17 ++--
 drivers/scsi/arm/acornscsi.c               |    9 +-
 drivers/scsi/arm/fas216.c                  |    9 +-
 drivers/scsi/arm/scsi.h                    |    2 
 drivers/scsi/atari_NCR5380.c               |    9 +-
 drivers/scsi/constants.c                   |    2 
 drivers/scsi/ips.c                         |    7 -
 drivers/scsi/ncr53c8xx.c                   |   14 ---
 drivers/scsi/pci2000.c                     |    4 -
 drivers/scsi/qla2xxx/qla_dbg.c             |    6 -
 drivers/scsi/scsi.c                        |    5 -
 drivers/scsi/scsi.h                        |   43 -----------
 drivers/scsi/scsi_error.c                  |   11 ---
 drivers/scsi/scsi_ioctl.c                  |    5 -
 drivers/scsi/scsi_lib.c                    |    2 
 drivers/scsi/scsi_obsolete.h               |  106 -----------------------------
 drivers/scsi/scsi_priv.h                   |    5 -
 drivers/scsi/seagate.c                     |    5 -
 drivers/scsi/sg.c                          |    3 
 drivers/scsi/sun3_NCR5380.c                |    9 +-
 drivers/scsi/sym53c8xx_2/sym_glue.c        |    6 -
 drivers/scsi/ultrastor.c                   |    4 -

so it doesn't look like there's a _lot_ wrong. Send in a patch to revert 
anything that needs reverting..

		Linus
