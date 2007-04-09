From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH v2] Documentation: show-ref: document --exclude-existing
Date: Mon, 9 Apr 2007 21:57:36 +0100
Message-ID: <20070409210721.21570.18686.julian@quantumfyre.co.uk>
References: <20070409205754.21048.73087.julian@quantumfyre.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 10 03:41:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hb17c-0006jN-1l
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 23:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965774AbXDIVJw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 17:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965778AbXDIVJw
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 17:09:52 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:41386 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965774AbXDIVJv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Apr 2007 17:09:51 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 5282AC6114
	for <git@vger.kernel.org>; Mon,  9 Apr 2007 22:09:50 +0100 (BST)
Received: (qmail 11036 invoked by uid 103); 9 Apr 2007 22:09:29 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90/3050. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.024658 secs); 09 Apr 2007 21:09:29 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 9 Apr 2007 22:09:29 +0100
In-Reply-To: <20070409205754.21048.73087.julian@quantumfyre.co.uk>
X-git-sha1: 155d908df649e0ca5d4450af2488ff42e79b6235 
X-Mailer: git-mail-commits v0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44095>

Use the comment in the code to document the --exclude-existing
function to git-show-ref.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---

This fixes an embarrassing copy/paste error with the previous version ...

 Documentation/git-show-ref.txt |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index 5973a82..2355aa5 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 [verse]
 'git-show-ref' [-q|--quiet] [--verify] [-h|--head] [-d|--dereference]
 	     [-s|--hash] [--abbrev] [--tags] [--heads] [--] <pattern>...
+'git-show-ref' --exclude-existing[=pattern]
 
 DESCRIPTION
 -----------
@@ -19,6 +20,9 @@ commit IDs. Results can be filtered using a pattern and tags can be
 dereferenced into object IDs. Additionally, it can be used to test whether a
 particular ref exists.
 
+The --exclude-existing form is a filter that does the inverse, it shows the
+refs from stdin that don't exist in the local repository.
+
 Use of this utility is encouraged in favor of directly accessing files under
 in the `.git` directory.
 
@@ -61,6 +65,18 @@ OPTIONS
 	Do not print any results to stdout. When combined with '--verify' this
 	can be used to silently check if a reference exists.
 
+--exclude-existing, --exclude-existing=pattern::
+
+	Make git-show-ref act as a filter that reads refs from stdin of the
+	form "^(?:<anything>\s)?<refname>(?:\^\{\})?$" and performs the
+	following actions on each:
+	(1) strip "^{}" at the end of line if any;
+	(2) ignore if pattern is provided and does not head-match refname;
+	(3) warn if refname is not a well-formed refname and skip;
+	(4) ignore if refname is a ref that exists in the local repository;
+	(5) otherwise output the line.
+
+
 <pattern>::
 
 	Show references matching one or more patterns.
-- 
1.5.1
