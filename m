Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C99C7EE23
	for <git@archiver.kernel.org>; Mon,  5 Jun 2023 10:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjFEKGa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jun 2023 06:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjFEKG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2023 06:06:28 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9A8E3
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 03:06:27 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 4C3B43200902;
        Mon,  5 Jun 2023 06:06:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 05 Jun 2023 06:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1685959585; x=1686045985; bh=Vvo1TPjnwQYCV0GHxONkdkl5y
        sAT/81X67gMojfy86w=; b=qU9fPY4eL/NCSKkRuKPVxAqBo1+lgkh8iCGV8R76w
        ujYh7jv1FApDmzn3DqQ4/l+tt7Ptaqy+1EZE6PhItAxIYnawy/SpS0HVJ/5LB8AJ
        1/zsQpENmET9mqrjktGmzA/JqlpSJUMD9nRIhTDbV+rPBgHgIQKDmS7Fev7Tn4vL
        znC8sZQvLJ1vWbvcMTGtU27USCfcSJ8SDZcHssZJDdX/bx5ofxuMfnJ4725ncuAk
        N9lmAJwfg01tfBgVp3pdK5LlRpNcagHzXv1PIX5Uo+ld77R6s1FrENdw24mgI3sb
        OXgSYXPPlwLwWudYjeqpIEste59ZbAfrJK0bffFtfIt1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685959585; x=1686045985; bh=Vvo1TPjnwQYCV0GHxONkdkl5ysAT/81X67g
        Mojfy86w=; b=lQtfJEadqYOVCUSA1FCAMc1LP65cIOTJs9Fj55r9GirbnbsA/QA
        I+DzbvDDrZAhx4mc+yaAC6ekqmO7RtFNFvBle2FA4hCbIYpEToMPhdulJs/sYTOk
        +hnw3B/2UgzUoWACKv0ctnQCqthfxvuuSycCTB5jmiKQj5o1m48eDmHoUKbyRbWt
        /MCPbS4L0mo8Ize0OxmZDMI8w66c1RA0x0EaUrIUYjxcEzJGam7MohstshWb+eGG
        Vqb5u97AHT5zLijk+7UgKwaeKcaMDvpwtTO/iGzSDHAXKaMKt61iZnrpgWVIpiLu
        18s0vjRjEj6iUz+D6hwAc4r7BLHYGv75L1A==
X-ME-Sender: <xms:obN9ZBRz2zUvPG2npVB3BnLChzCVNJV1ZyhaQBdfoR_s8sy8C_BDnSk>
    <xme:obN9ZKwTOs6rRe_7sGz9wH2hbMfldoziGWYdFviqXlXMZPt2OAUOolOBAWiF8E1-E
    63cvJJw6geqLIFbhA>
X-ME-Received: <xmr:obN9ZG1AVz4vSbCUkmt1VNyAmK0ty43skCEJJ2hOluOFLLuAReGX2H3-jk9X87OmnVw3xYWs1BiTKruLyZba88RmsZgX2sxMupaOF_GVwPhXSXcJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelledgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceo
    tghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeevgf
    elveeikeegjeeikeeuvefhleeiuddvleegfeekjedtkeevtdetgfffveettdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrg
    hughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:obN9ZJDIZx5gVDu8jbFJisMYSpljcG5e80SWryfYiIIVPgwbUdumbw>
    <xmx:obN9ZKiJZTHW6zs1M6qchCrxoChTpy4JzxkUJFf_Mov_lLMt_j0gpQ>
    <xmx:obN9ZNoor1ltLT4jokiWj5u86miR7UygRJr13ptB_MCLutFDMZqTvw>
    <xmx:obN9ZNsjqWgc3k0PwrillOUiEOxBco4u5pQrai1QjYsj1ROS18-mUg>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jun 2023 06:06:24 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 1/2] notes: update documentation for `use_default_notes`
Date:   Mon,  5 Jun 2023 12:05:22 +0200
Message-ID: <3eaa725d3a476e3cfd7331104f35bbd322d9394f.1685958731.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1685958731.git.code@khaugsbakk.name>
References: <b3829cb0d1e36a5ebb44a315fe32037f2a3f6c7a.1685526558.git.code@khaugsbakk.name> <cover.1685958731.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`suppress_default_notes` was renamed to `use_default_notes` in
3a03cf6b1d (notes: refactor display notes default handling,
2011-03-29).

The commit message says that “values less than one [indicates] “not
set” ”, but what was meant was probably “less than zero” (the author of
3a03cf6b1d agrees on this point).

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 notes.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/notes.h b/notes.h
index c1682c39a9..a823840e49 100644
--- a/notes.h
+++ b/notes.h
@@ -286,8 +286,9 @@ void disable_display_notes(struct display_notes_opt *opt, int *show_notes);
  * If 'opt' is not NULL, then it specifies additional settings for the
  * displaying:
  *
- * - suppress_default_notes indicates that the notes from
- *   core.notesRef and notes.displayRef should not be loaded.
+ * - use_default_notes: less than `0` is "unset", which means that the
+ *   default notes are shown iff no other notes are given. Otherwise,
+ *   treat it like a boolean.
  *
  * - extra_notes_refs may contain a list of globs (in the same style
  *   as notes.displayRef) where notes should be loaded from.
-- 
2.41.0

