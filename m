From: "Luck, Tony" <tony.luck@intel.com>
Subject: FW: Git pulls failing on ia64 test tree?
Date: Wed, 14 Sep 2005 08:47:09 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F046279C5@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Sep 14 17:49:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFZTf-0007LV-Kh
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 17:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbVINPrN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 11:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbVINPrM
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 11:47:12 -0400
Received: from fmr14.intel.com ([192.55.52.68]:56767 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S1030202AbVINPrM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 11:47:12 -0400
Received: from fmsfmr100.fm.intel.com (fmsfmr100.fm.intel.com [10.253.24.20])
	by fmsfmr002.fm.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j8EFlBnm023917
	for <git@vger.kernel.org>; Wed, 14 Sep 2005 15:47:11 GMT
Received: from fmsmsxvs043.fm.intel.com (fmsmsxvs043.fm.intel.com [132.233.42.129])
	by fmsfmr100.fm.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id j8EFlBHN021082
	for <git@vger.kernel.org>; Wed, 14 Sep 2005 15:47:11 GMT
Received: from fmsmsx331.amr.corp.intel.com ([132.233.42.156])
 by fmsmsxvs043.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2005091408471107788
 for <git@vger.kernel.org>; Wed, 14 Sep 2005 08:47:11 -0700
Received: from fmsmsx311.amr.corp.intel.com ([132.233.42.214]) by fmsmsx331.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 14 Sep 2005 08:47:10 -0700
Received: from scsmsx401.amr.corp.intel.com ([10.3.90.12]) by fmsmsx311.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 14 Sep 2005 08:47:10 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Git pulls failing on ia64 test tree?
Thread-Index: AcW5J6maqWr79fvqRS227TbpZLyCvAAGoMdQ
To: <git@vger.kernel.org>
X-OriginalArrivalTime: 14 Sep 2005 15:47:10.0484 (UTC) FILETIME=[917E2D40:01C5B943]
X-Scanned-By: MIMEDefang 2.52 on 10.253.24.20
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8533>

I've had two complaints that people can't pull from my tree
on kernel.org.  Here's a snip from the errors.

 > $ git pull 
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/aegl/linux-2.6.git test
 > MOTD:
 > MOTD:   Welcome to the Linux Kernel Archive.
    ... MOTD trimmed ...
 > receiving file list ... done
 >
 > wrote 113 bytes  read 30799 bytes  20608.00 bytes/sec
 > total size is 82275235  speedup is 2661.60
 > * committish: 6c141f61ee4f5fba63d9c54e03cb2faa6877bf1a  refs/heads/test from 
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/aegl/linux-2.6.git
 > error: Could not read 9401c705f2a6a7e5df102f6443dba395c3c5e5a8
 > error: Could not read 357d596bd552ad157a906289ab13ea6ba7e66e3d
 > Updating from aa2dca4563b0629ecd9d9994dfdf39f29ff1b43f to 
6c141f61ee4f5fba63d9c54e03cb2faa6877bf1a.
 > fatal: failed to unpack tree object 6c141f61ee4f5fba63d9c54e03cb2faa6877bf1a
 > $

After the first complaint, I looked around and found out about
"git-update-server-info" (which I'd somehow missed).  So I ran
(on master.kernel.org):

  $ GIT_DIR=/pub/scm/linux/kernel/git/aegl/linux-2.6.git git-update-server-info

and I now have info/refs, info/rev-cache, and objects/info/packs files.

12 hours later, I got another complaint.

I've set up objects/info/alternates to point at linus' tree and deleted
all the packs from my tree.  The web view at kernel.org/git looks ok,
so I think those changes are ok.

So what am I missing?

-Tony
