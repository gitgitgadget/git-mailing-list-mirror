From: Marcel Holtmann <marcel@holtmann.org>
Subject: Problem in update from the linux-2.6 repository
Date: Mon, 07 Nov 2005 17:18:13 +0100
Message-ID: <1131380293.5824.139.camel@blade>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Nov 07 17:22:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZ9hh-00027C-A3
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 17:18:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbVKGQSL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 11:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbVKGQSK
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 11:18:10 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:40338 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S964860AbVKGQSJ
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 7 Nov 2005 11:18:09 -0500
Received: from blade (p5487DB86.dip.t-dialin.net [84.135.219.134])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id jA7GIIGB019311
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <git@vger.kernel.org>; Mon, 7 Nov 2005 17:18:19 +0100
To: git@vger.kernel.org
X-Mailer: Evolution 2.5.1 
X-Virus-Scanned: ClamAV 0.85.1/1165/Sun Nov  6 06:12:58 2005 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11268>

Hi guys,

I run into a weird problem when trying to update my clone of the
linux-2.6 repository from Linus:

---
# cg-update -f
17:09:00 URL:http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/HEAD [41/41] -> "refs/heads/.origin-fetching" [1]
Getting alternates list
Getting pack list
error: Unable to find 2ed5e6d09e266bd2288d49aaaf240ed8c468c13c under http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/

Cannot obtain needed object 2ed5e6d09e266bd2288d49aaaf240ed8c468c13c
while processing commit 0000000000000000000000000000000000000000.
cg-fetch: objects fetch failed
---

I use the latest available git and cogito for this and I have no idea
which is at fault. Using rsync as transport it even looks more worse:

---
# cg-update -f
WARNING: The rsync access method is DEPRECATED and will be REMOVED in the future!

receiving file list ... done

sent 111 bytes  received 774 bytes  354.00 bytes/sec
total size is 41  speedup is 0.05

receiving file list ... done
progress: 2631 objects, 9754798 bytes, 100% done
info/packs

sent 58020 bytes  received 10252045 bytes  74982.29 bytes/sec
total size is 121158464  speedup is 11.75

receiving file list ... done

sent 118 bytes  received 1095 bytes  346.57 bytes/sec
total size is 902  speedup is 0.74
Tree change: f912696ab330bf539231d1f8032320f2a08b850f:2ed5e6d09e266bd2288d49aaaf240ed8c468c13c
error: unable to find 2ed5e6d09e266bd2288d49aaaf240ed8c468c13c
fatal: git-cat-file 2ed5e6d09e266bd2288d49aaaf240ed8c468c13c: bad file
error: unable to find 2ed5e6d09e266bd2288d49aaaf240ed8c468c13c
fatal: git-cat-file 2ed5e6d09e266bd2288d49aaaf240ed8c468c13c: bad file
Invalid tree id: 2ed5e6d09e266bd2288d49aaaf240ed8c468c13c

Applying changes...
error: unable to find 2ed5e6d09e266bd2288d49aaaf240ed8c468c13c
fatal: git-cat-file 2ed5e6d09e266bd2288d49aaaf240ed8c468c13c: bad file
error: unable to find 2ed5e6d09e266bd2288d49aaaf240ed8c468c13c
fatal: git-cat-file 2ed5e6d09e266bd2288d49aaaf240ed8c468c13c: bad file
Invalid commit id: 2ed5e6d09e266bd2288d49aaaf240ed8c468c13c
---

Maybe this is a problem of the kernel.org synchronization, but otherwise
it should be fixed. Will there be a way to get some useful messages to
the end user in case of an error or some sanity checks that the tree you
are pulling from is in sane state or not?

Regards

Marcel
