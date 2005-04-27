From: Steven Cole <elenstev@mesatop.com>
Subject: Re: I'm missing isofs.h
Date: Wed, 27 Apr 2005 09:31:07 -0600
Message-ID: <426FB03B.9090509@mesatop.com>
References: <20050426214338.32e9ac27.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 17:28:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQoQY-0007Ie-7R
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 17:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbVD0Pb1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 11:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbVD0Pb1
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 11:31:27 -0400
Received: from mailwasher.lanl.gov ([192.65.95.54]:11107 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S261740AbVD0PbO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 11:31:14 -0400
Received: from w-mail.lanl.gov (w-mail.lanl.gov [128.165.4.47])
	by mailwasher-b.lanl.gov (8.12.11/8.12.11/(ccn-5)) with ESMTP id j3RFVAdx004480
	for <git@vger.kernel.org>; Wed, 27 Apr 2005 09:31:11 -0600
Received: from [128.165.67.197] (spc7.esa.lanl.gov [128.165.67.197])
	by w-mail.lanl.gov (8.12.11/8.12.11/(ccn-5)) with ESMTP id j3RFV7RK003152;
	Wed, 27 Apr 2005 09:31:08 -0600
User-Agent: Thunderbird 1.0 (Multics)
X-Accept-Language: en-us, en
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050426214338.32e9ac27.akpm@osdl.org>
X-PMX-Version: 4.7.0.111621
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Andrew Morton wrote:
> In a current tree, using git-pasky-0.7:
> 
> bix:/usr/src/git26> cat .git/tags/v2.6.12-rc3 
> a2755a80f40e5794ddc20e00f781af9d6320fafb
> bix:/usr/src/git26> git diff -r v2.6.12-rc3|grep isofs.h
> +#include "isofs.h"
>  #include "zisofs.h"
> +#include "isofs.h"
> +#include "isofs.h"
> +#include "isofs.h"
>  #include "zisofs.h"
> +#include "isofs.h"
> +#include "isofs.h"
> +#include "isofs.h"
> +#include "isofs.h"
> 
> 
> That diff should have included the addition of the new isofs.h, but it
> isn't there.
> 

I'm seeing unexplained behaviour using the above technique, and I'm
also seeing fs/isofs/isofs.h as missing, along with seven other changes.

I'm using the latest cogito release:
[steven@spc0 COGITO]$ cg-version
cogito-0.8 (3e0fb979cc7541506ec660ab66b83d8120da6d57)

I updated my linux-2.6 repo with cg-update origin, and then created
a current linux-2.6 tree using cg-export.  I diffed that exported
tree with 2.6.12-rc3 and saved the result as "a.diff".

I created another diff using Andrew's technique using cg-diff and saved
that to "b.diff".

I had expected that a.diff and b.diff to be the same, but they are
not, and the AWOL file fs/isofs/isofs.h is among the missing using
Andrew's technique.

Here are the details.

Steven

[steven@spc0 linux-2.6]$ cat .git/HEAD
e8108c98dd6d65613fa0ec9d2300f89c48d554bf

[steven@spc0 linux-2.6]$ fsck-cache --tags
tagged commit a2755a80f40e5794ddc20e00f781af9d6320fafb (v2.6.12-rc3) in 0397236d43e48e821cce5bbe6a80a1a56bb7cc3a
tagged commit 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 (v2.6.12-rc2) in 9e734775f7c22d2f89943ad6c745571f1930105f
expect dangling commits - potential heads - due to lack of head information
dangling commit e8108c98dd6d65613fa0ec9d2300f89c48d554bf

[steven@spc0 linux-2.6]$ cg-export ../linux-2.6-current
[steven@spc0 linux-2.6]$ cg-diff -r v2.6.12-rc3 >../b.diff
[steven@spc0 linux-2.6]$ cd ..

[steven@spc0 COGITO]$ diff -urN linux-2.6.12-rc3 linux-2.6-current >a.diff
#note that linux-2.6.12-rc3 was created by patch from kernel.org.

[steven@spc0 COGITO]$ diffstat a.diff >a.diffstat
[steven@spc0 COGITO]$ diffstat b.diff >b.diffstat
[steven@spc0 COGITO]$ tail -n 1 a.diffstat
  199 files changed, 3083 insertions(+), 1601 deletions(-)
[steven@spc0 COGITO]$ tail -n 1 b.diffstat
  191 files changed, 2539 insertions(+), 1540 deletions(-)
[steven@spc0 COGITO]$ diff -u a.diffstat b.diffstat
--- a.diffstat  2005-04-27 09:07:04.000000000 -0600
+++ b.diffstat  2005-04-27 09:07:14.000000000 -0600
@@ -101,7 +101,6 @@
   drivers/usb/net/zd1201.c                     |   20
   drivers/usb/serial/Kconfig                   |    9
   drivers/usb/serial/Makefile                  |    1
- drivers/usb/serial/hp4x.c                    |   85 +++
   drivers/usb/storage/unusual_devs.h           |   22 -
   drivers/video/imsttfb.c                      |    4
   drivers/video/logo/Kconfig                   |    2
@@ -113,7 +112,6 @@
   fs/isofs/dir.c                               |   13
   fs/isofs/export.c                            |    6
   fs/isofs/inode.c                             |   19
- fs/isofs/isofs.h                             |  190 ++++++++
   fs/isofs/joliet.c                            |    6
   fs/isofs/namei.c                             |   13
   fs/isofs/rock.c                              |    8
@@ -136,15 +134,10 @@
   include/asm-sparc64/pgtable.h                |    5
   include/asm-sparc64/spinlock.h               |   48 +-
   include/linux/iso_fs.h                       |  147 ------
- include/linux/iso_fs_i.h                     |   27 -
- include/linux/iso_fs_sb.h                    |   34 -
   include/linux/netfilter_ipv4.h               |    3
   include/linux/pci_ids.h                      |    1
- include/linux/tc_act/tc_defact.h             |   21
- include/net/act_generic.h                    |  142 ++++++
   include/net/ax25.h                           |   10
   include/net/ipv6.h                           |    2
- include/net/tc_act/tc_defact.h               |   13
   include/net/tcp.h                            |   11
   kernel/panic.c                               |    4
   mm/mempolicy.c                               |    2
@@ -190,11 +183,10 @@
   net/sched/Kconfig                            |   10
   net/sched/Makefile                           |   11
   net/sched/cls_fw.c                           |   31 +
- net/sched/simple.c                           |   93 ++++
   net/unix/af_unix.c                           |    1
   net/xfrm/xfrm_state.c                        |    5
   scripts/mod/file2alias.c                     |  111 ++++-
   security/selinux/hooks.c                     |    3
   sound/oss/msnd_pinnacle.c                    |    2
   sound/ppc/Kconfig                            |    2
- 199 files changed, 3083 insertions(+), 1601 deletions(-)
+ 191 files changed, 2539 insertions(+), 1540 deletions(-)
[steven@spc0 COGITO]$ cg-version
cogito-0.8 (3e0fb979cc7541506ec660ab66b83d8120da6d57)

