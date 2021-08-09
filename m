Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF6DC4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 20:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBB9E60F38
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 20:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbhHIUea (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 16:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbhHIUea (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 16:34:30 -0400
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55079C0613D3
        for <git@vger.kernel.org>; Mon,  9 Aug 2021 13:34:09 -0700 (PDT)
Received: from fencepost.gnu.org ([2001:470:142:3::e]:55340)
        by eggs.gnu.org with esmtp (Exim 4.90_1)
        (envelope-from <tsdh@gnu.org>)
        id 1mDByJ-0001ZF-Ll
        for git@vger.kernel.org; Mon, 09 Aug 2021 16:34:07 -0400
Received: from auth2-smtp.messagingengine.com ([66.111.4.228]:39777)
        by fencepost.gnu.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <tsdh@gnu.org>)
        id 1mDByJ-0005yJ-G2; Mon, 09 Aug 2021 16:34:07 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9DC8727C005B;
        Mon,  9 Aug 2021 16:34:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 09 Aug 2021 16:34:06 -0400
X-ME-Sender: <xms:PpERYT0CDdGKoJktGFkQg3zEGsce97eE3t7ODYuFDwCYChENvez8sg>
    <xme:PpERYSHevvDiECCT0NJT0oWXB6r1psakPbHcwqOtFi7iE8HjCJy6aTIDUC5nLeKAD
    NobioVTwlcMTw>
X-ME-Received: <xmr:PpERYT6Solh_ndRjaJx1m2NWtxX0Ttsp1k6HU7HCVpJOGTOLyBbKXcETkDv5LwwEF6XgK7FpHPdGkBtLopLByYn4yYcTRKNpqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeejgdduhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepvfgrshhsihhlohcujfhorhhnuceothhsughhsehgnhhurdhorhhg
    qeenucggtffrrghtthgvrhhnpeevffekhfegvdefiefgjeeujedvfffhffeutefhgfekie
    eiheeludeludeltdefhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehthhhorhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqd
    ekieejfeekjeekgedqieefhedvleekqdhtshguhheppehgnhhurdhorhhgsehfrghsthhm
    rghilhdrfhhm
X-ME-Proxy: <xmx:PpERYY1kp6aAvzn1k7mnzqgMuc7RoK0FAaKJyhDmZJuFTh9i4W7qDQ>
    <xmx:PpERYWFC3I2XmOwE8CjB7VMzUpExQWg5fB1-sxGGJ0t_BFqHgUF-KA>
    <xmx:PpERYZ8FvhoJnFlu-v8fYIjx7pGN7Zp6dtVNPDMbzc7d_cIyUy7KfA>
    <xmx:PpERYRN5DDNwTwX8_f2SLBXr4T6HZZCWkWymPCUHolpuyn-Su62UAw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Aug 2021 16:34:05 -0400 (EDT)
From:   Tassilo Horn <tsdh@gnu.org>
To:     git@vger.kernel.org
Cc:     Tassilo Horn <tsdh@gnu.org>
Subject: [PATCH] userdiff: improve java regex for generic return types
Date:   Mon,  9 Aug 2021 22:33:08 +0200
Message-Id: <20210809203308.30128-1-tsdh@gnu.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, the git diff hunk headers show the wrong method signature if the
method has a generic return type because the regex doesn't allow < and > in the
return type.  This patch adds those.

Bug repro: In a repository with .gitattributes containing "*.java diff=java"
and a java file

--8<---------------cut here---------------start------------->8---
class MyExample {
    public void firstMethod() {
        // Whatever...
    }

    public List<Integer> secondMethod() {
        // Here is some comment,
        // and here is more,
        // and here is even more,
        // followed by this,
        // and that,
        // and even more.
        return Arrays.asList(1, 2, 3, 4, 5);
    }
}
--8<---------------cut here---------------end--------------->8---

when adding the number 6 to the Arrays.asList() call in secondMethod(), the git
diff one gets is

--8<---------------cut here---------------start------------->8---
diff --git a/src/main/java/MyExample.java b/src/main/java/MyExample.java
index a0f1a6b..ea37a98 100644
--- a/src/main/java/MyExample.java
+++ b/src/main/java/MyExample.java
@@ -14,6 +14,6 @@ public void firstMethod() {
         // followed by this,
         // and that,
         // and even more.
-        return Arrays.asList(1, 2, 3, 4, 5);
+        return Arrays.asList(1, 2, 3, 4, 5, 6);
     }
 }
--8<---------------cut here---------------end--------------->8---

where the hunk header shows the signature of firstMethod whereas it should show
the signature of secondMethod.

Signed-off-by: Tassilo Horn <tsdh@gnu.org>
---
 userdiff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/userdiff.c b/userdiff.c
index 3c3bbe38b0..a244ad7ab1 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -142,7 +142,7 @@ PATTERNS("html",
 	 "[^<>= \t]+"),
 PATTERNS("java",
 	 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
-	 "^[ \t]*(([A-Za-z_][A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$",
+	 "^[ \t]*(([A-Za-z_][A-Za-z_0-9<>]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$",
 	 /* -- */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
-- 
2.32.0

