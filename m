From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 0/5] Split-up "unpack_trees()" cleanup series
Date: Wed, 5 Mar 2008 20:28:19 -0800
Message-ID: <cover.1204777699.git.torvalds@linux-foundation.org>
To: undisclosed-recipients:;
X-From: git-owner@vger.kernel.org Thu Mar 06 05:37:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX7rG-0003pq-PF
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 05:37:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756213AbYCFEgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 23:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756058AbYCFEgx
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 23:36:53 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39650 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753802AbYCFEgx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2008 23:36:53 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m264atnY006295
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 5 Mar 2008 20:36:56 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m264aZDY008856;
	Wed, 5 Mar 2008 20:36:36 -0800
X-Spam-Status: No, hits=-3.947 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76320>

Ok, here's the patch I sent out earlier, except now it's been split up
into a series fo five patches (and has some trivial one-liner cleanups
here and there, mainly to shrink the patches a bit)

It's a series of five patches:
 -  Add 'df_name_compare()' helper function
 - Make 'traverse_tree()' use linked structure rather than 'const char *base'
 - Add return value to 'traverse_tree()' callback
 - Make 'traverse_trees()' traverse conflicting DF entries in parallel
 - Move 'unpack_trees()' over to 'traverse_trees()' interface

with a more lines added than removed:

 cache.h        |    1 +
 merge-tree.c   |   58 ++++---
 read-cache.c   |   35 ++++
 tree-walk.c    |   59 ++++++-
 tree-walk.h    |   23 ++-
 unpack-trees.c |  530 ++++++++++++++++++++++++++------------------------------
 6 files changed, 387 insertions(+), 319 deletions(-)

but especially in this new split-up format, it's now more possible to
see how the last patch actually simplifies things. 

