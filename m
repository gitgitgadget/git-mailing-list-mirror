X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Documentation: Correct alternates documentation, document http-alternates
Date: Sun, 19 Nov 2006 00:30:15 +0100
Message-ID: <20061118233015.16808.4484.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
NNTP-Posting-Date: Sat, 18 Nov 2006 23:30:37 +0000 (UTC)
Cc: <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: StGIT/0.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31814>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlZde-0002nT-U8 for gcvg-git@gmane.org; Sun, 19 Nov
 2006 00:30:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755371AbWKRXaS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 18:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755373AbWKRXaS
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 18:30:18 -0500
Received: from w241.dkm.cz ([62.24.88.241]:17611 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1755371AbWKRXaQ (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 18:30:16 -0500
Received: (qmail 16818 invoked from network); 19 Nov 2006 00:30:15 +0100
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1) by localhost
 with SMTP; 19 Nov 2006 00:30:15 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

For one, the documentation invalidly claimed that the paths have to be
absolute when that's not the case and in fact there is a very valid reason
not to use absolute paths (documented the reason as well).

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/repository-layout.txt |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/repository-layout.txt b/Documentation/repository-layout.txt
index fd9f406..73a025b 100644
--- a/Documentation/repository-layout.txt
+++ b/Documentation/repository-layout.txt
@@ -52,9 +52,20 @@ objects/info/packs::
 	by default.
 
 objects/info/alternates::
-	This file records absolute filesystem paths of alternate
-	object stores that this object store borrows objects
-	from, one pathname per line.
+	This file records paths to alternate object stores that
+	this object store borrows objects from, one pathname per
+	line. Note that not only native Git tools use it locally,
+	but the HTTP fetcher also tries to use it remotely; this
+	will usually work if you have relative paths (relative
+	to the object database, not to the repository!) in your
+	alternates file, but it will not work if you use absolute
+	paths unless the absolute path in filesystem and web URL
+	is the same. See also 'objects/info/http-alternates'.
+
+objects/info/http-alternates::
+	This file records URLs to alternate object stores that
+	this object store borrows objects from, to be used when
+	the repository is fetched over HTTP.
 
 refs::
