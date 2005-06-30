From: Paul Mackerras <paulus@samba.org>
Subject: problem with git-diff-tree -S
Date: Thu, 30 Jun 2005 22:48:44 +1000
Message-ID: <17091.59948.453311.980846@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jun 30 14:42:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnyMj-0006X1-GP
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 14:42:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262833AbVF3Ms5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 08:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbVF3Ms5
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 08:48:57 -0400
Received: from ozlabs.org ([203.10.76.45]:5551 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262833AbVF3Msx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jun 2005 08:48:53 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 1713D67BA2; Thu, 30 Jun 2005 22:48:52 +1000 (EST)
To: git@vger.kernel.org
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I'm trying to implement a find function in gitk that will find commits
where the patch includes a particular string, using git-diff-tree.
It's not doing what I expect - am I expecting the wrong thing, or is
there a bug in git-diff-tree?

As an example, take commit 92a582ed2757456ca9599f8b4ea2064f2154eb02,
"[IA64] sparse cleanup of TIOCA files".  If I put that ID in a file
called id and do:

git-diff-tree --stdin -p <id

the resulting patch includes the lines:

-uint64_t
+static uint64_t

+int sn_topology_open(struct inode *inode, struct file *file);
+int sn_topology_release(struct inode *inode, struct file *file);

+extern struct list_head tioca_list;

Now if I do:

git-diff-tree --stdin -r -s -Ssn_topology <id

I get the ID printed to stdout, but if I do:

git-diff-tree --stdin -r -s -Stioca <id

I get nothing on stdout, and similarly if I use "-Sstatic".  What's
going on?

Paul.
