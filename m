From: "Luck, Tony" <tony.luck@intel.com>
Subject: git-whatchanged -p anomoly?
Date: Thu, 18 Aug 2005 13:49:07 -0700
Message-ID: <200508182049.j7IKn7TA010456@agluck-lia64.sc.intel.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 22:50:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5rKM-0001Tt-EV
	for gcvg-git@gmane.org; Thu, 18 Aug 2005 22:49:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbVHRUtJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 16:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbVHRUtJ
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 16:49:09 -0400
Received: from fmr21.intel.com ([143.183.121.13]:65242 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750879AbVHRUtI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2005 16:49:08 -0400
Received: from scsfmr100.sc.intel.com (scsfmr100.sc.intel.com [10.3.253.9])
	by scsfmr001.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j7IKn7FX032334
	for <git@vger.kernel.org>; Thu, 18 Aug 2005 20:49:07 GMT
Received: from agluck-lia64.sc.intel.com (agluck-lia64.sc.intel.com [143.183.251.239])
	by scsfmr100.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id j7IKpXMi028464
	for <git@vger.kernel.org>; Thu, 18 Aug 2005 20:51:33 GMT
Received: from agluck-lia64.sc.intel.com (agluck-lia64.sc.intel.com [127.0.0.1])
	by agluck-lia64.sc.intel.com (8.13.1/8.13.1) with ESMTP id j7IKn7Ko010457
	for <git@vger.kernel.org>; Thu, 18 Aug 2005 13:49:07 -0700
Received: (from aegl@localhost)
	by agluck-lia64.sc.intel.com (8.13.1/8.13.1/Submit) id j7IKn7TA010456;
	Thu, 18 Aug 2005 13:49:07 -0700
To: git@vger.kernel.org
X-Scanned-By: MIMEDefang 2.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Yesterday I was all happy ... Linus pulled a couple of changes from
my tree, and after I did a pull back from his tree into my "linus"
tracking branch, my status scripts correctly identified the branches
that I'd been using to track those changes as being no longer needed.

But this morning I ran another one of my status scripts that does

 $ git-whatchanged -p test ^linus | diffstat -p1

and was surprised when it reported changes in 10 files that I knew
I hadn't touched (the other 18 files it reported looked correct).

So I ran:

 $ git-whatchanged test ^linus | git-shortlog

and this just reported the changesets that I expected.

 $ git-diff-tree -p linus test | diffstat -p1

shows what I expect to see.

The current heads of the two branches are:

linus=30d5b64b63fa69af31b2cba32e6d71d68526eec9
test=0e595ad82db1b42d631e581630eb3fbeebb3c285

my tree is at:
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/aegl/linux-2.6.git

The spurious changes reported by "git-whatchanged -p" are:

>  Documentation/acpi-hotkey.txt              |    3 
>  Documentation/kernel-parameters.txt        |    5 
>  drivers/acpi/osl.c                         |    6 
>  fs/jfs/inode.c                             |    4 
>  fs/jfs/jfs_logmgr.c                        |   36 -
>  fs/jfs/jfs_logmgr.h                        |    2 
>  fs/jfs/jfs_txnmgr.c                        |   12 
>  fs/jfs/super.c                             |    4 
>  include/asm-i386/processor.h               |    2 
>  include/asm-x86_64/processor.h             |    2 

Is this a bug, or am I just confused about how "git-whatchanged" works?

-Tony
