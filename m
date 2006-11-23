X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 3/4] Optimize stg goto in the pop case.
Date: Fri, 24 Nov 2006 00:17:03 +0100
Message-ID: <20061123231658.9769.81157.stgit@gandelf.nowhere.earth>
References: <20061123230721.9769.38403.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 23 Nov 2006 23:18:12 +0000 (UTC)
Cc: GIT list <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061123230721.9769.38403.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32173>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnNpa-0001iD-GG for gcvg-git@gmane.org; Fri, 24 Nov
 2006 00:18:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934253AbWKWXSG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 18:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934255AbWKWXSG
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 18:18:06 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:63965 "EHLO
 smtp2-g19.free.fr") by vger.kernel.org with ESMTP id S934253AbWKWXSF (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 18:18:05 -0500
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net
 [81.57.214.146]) by smtp2-g19.free.fr (Postfix) with ESMTP id 3AAC07D0A; Fri,
 24 Nov 2006 00:18:04 +0100 (CET)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch) by
 bylbo.nowhere.earth with esmtp (Exim 4.62) (envelope-from
 <ydirson@altern.org>) id 1GnNpY-0002t2-6j; Fri, 24 Nov 2006 00:18:08 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/goto.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/stgit/commands/goto.py b/stgit/commands/goto.py
index 1b62d1c..e129b8d 100644
--- a/stgit/commands/goto.py
+++ b/stgit/commands/goto.py
@@ -45,11 +45,11 @@ def func(parser, options, args):
     check_head_top_equal()
 
     applied = crt_series.get_applied()
-    applied.reverse()
     unapplied = crt_series.get_unapplied()
     patch = args[0]
 
     if patch in applied:
+        applied.reverse()
         patches = applied[:applied.index(patch)]
         pop_patches(patches)
