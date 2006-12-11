X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Comment -p mode for cat-file
Date: Mon, 11 Dec 2006 22:13:00 +0000
Message-ID: <200612112213.00737.andyparkins@gmail.com>
References: <f323e83a37efd3b913004666f2fc104578a92833.1165875140.git.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 22:16:07 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition;
        b=Km4kCZmDuuErn6GcHQbz/a3kV8c0Qw8e+jLrkpXFnXBOEBII6Pw8EZ4CspLHDHp2be6oSY7kecy8MTlBgj0mTBpZklJ/A1hL1/IOUHLuP+6EpO/AAd3Owy6MUr1lGHDsqNI6oF0o7fAii3LpSyhc+i2bf5US4Us0zPV61NUL3rY=
In-Reply-To: <f323e83a37efd3b913004666f2fc104578a92833.1165875140.git.andyparkins@gmail.com>
X-TUID: 8f500c212ce093c8
X-UID: 187
X-Length: 1398
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34043>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GttRG-0000Vl-RN for gcvg-git@gmane.org; Mon, 11 Dec
 2006 23:15:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1763167AbWLKWP4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 17:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763162AbWLKWPz
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 17:15:55 -0500
Received: from wr-out-0506.google.com ([64.233.184.229]:28497 "EHLO
 wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1763165AbWLKWPz (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec
 2006 17:15:55 -0500
Received: by wr-out-0506.google.com with SMTP id i7so1815613wra for
 <git@vger.kernel.org>; Mon, 11 Dec 2006 14:15:54 -0800 (PST)
Received: by 10.78.117.10 with SMTP id p10mr2075684huc.1165875353043; Mon, 11
 Dec 2006 14:15:53 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id 32sm3247885hui.2006.12.11.14.15.52; Mon, 11 Dec
 2006 14:15:52 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 builtin-cat-file.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index 6c16bfa..e7997ee 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -121,12 +121,16 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 			die("Not a valid object name %s", argv[2]);
 
 		/* custom pretty-print here */
+		/* Special print tree types using ls-tree
+		 *  git-ls-tree argv[1] */
 		if (!strcmp(type, tree_type))
 			return cmd_ls_tree(2, argv + 1, NULL);
 
+		/* For everything else, read the object itself */
 		buf = read_sha1_file(sha1, type, &size);
 		if (!buf)
 			die("Cannot read object %s", argv[2]);
+		/* if the object is a tag, use pprint_tag() above */
 		if (!strcmp(type, tag_type)) {
 			pprint_tag(sha1, buf, size);
 			return 0;
-- 
1.4.4.1.geeee8
