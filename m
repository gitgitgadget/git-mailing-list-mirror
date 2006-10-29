X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Subject: [PATCH] Stgit: allow importing series files where patch names include slashes
Date: Sun, 29 Oct 2006 18:35:16 +0100
Message-ID: <20061029173516.27112.86149.stgit@americanbeauty.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
NNTP-Posting-Date: Sun, 29 Oct 2006 16:35:46 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=EdM6eURhuYkDjjyv8irBvKVkxZJExJTlg+k84YkfkdFsMH4fMNu01Ljtqwgfbj8Hh+KsqVZmxdZWSI2Ys2uzVOzhYNE66aelPgMYWP7C6Tuvioe+DSWAhY4Q9fkX4usURL7DmC4gInffH5CULToftmlg66wh/7ECx863n/IY7hY=  ;
User-Agent: StGIT/0.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30433>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeDd8-0002aj-6c for gcvg-git@gmane.org; Sun, 29 Oct
 2006 17:35:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965266AbWJ2QfQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 11:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965282AbWJ2QfQ
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 11:35:16 -0500
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62]:15185 "HELO
 smtp008.mail.ukl.yahoo.com") by vger.kernel.org with SMTP id S965266AbWJ2QfP
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 11:35:15 -0500
Received: (qmail 82967 invoked from network); 29 Oct 2006 16:35:13 -0000
Received: from unknown (HELO americanbeauty.home.lan)
 (blaisorblade@82.55.100.30 with plain) by smtp008.mail.ukl.yahoo.com with
 SMTP; 29 Oct 2006 16:35:13 -0000
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Do that by converting slashes in patch name to dashes. Actually one could think
that different quilt folders relate to topic branches, but I do not see an
obviously correct mapping nor users which would do that.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 stgit/commands/imprt.py |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/stgit/commands/imprt.py b/stgit/commands/imprt.py
index 1b7dce8..c8cf42b 100644
--- a/stgit/commands/imprt.py
+++ b/stgit/commands/imprt.py
@@ -85,6 +85,11 @@ def __strip_patch_name(name):
 
     return stripped
 
+def __replace_slashes_with_dashes(name):
+    stripped = name.replace('/', '-')
+
+    return stripped
+
 def __parse_description(descr):
     """Parse the patch description and return the new description and
     author information (if any).
@@ -299,6 +304,7 @@ def __import_series(filename, options):
 
         if options.strip:
             patch = __strip_patch_name(patch)
+        patch = __replace_slashes_with_dashes(patch);
         if options.ignore and patch in applied:
             print 'Ignoring already applied patch "%s"' % patch
             continue
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
