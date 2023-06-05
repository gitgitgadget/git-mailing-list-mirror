Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C326C7EE23
	for <git@archiver.kernel.org>; Mon,  5 Jun 2023 10:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjFEKGh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jun 2023 06:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjFEKGc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2023 06:06:32 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3A6B0
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 03:06:31 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 095F13200583;
        Mon,  5 Jun 2023 06:06:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 05 Jun 2023 06:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1685959590; x=1686045990; bh=b7WdA8yaEnAaWVokTm3Wl92x4
        YbbiqegX8pCiHHIQjc=; b=zV1QIftWKlUatS/uOaRSxd+jNAE4ccokt01Q9Gvgm
        xoDZZdIKGaocCuitIGEGiL1urVNlLo14RS9r1izhc1deCRlq1S1NOtiaeAg7Uyab
        aiQ93I8h1eyBosy3iLEmEeIn+OxakVv35CTqbuRXUi/ldX1lU2vc2a6hueJT3rmH
        hxW+wzETTD5U5ty3U+QuiRnn6tGh6OjNJlNqy/IGW7DZK47zdu/eFOFphH6hTCNb
        tplRdQCHO2WYHma8RRR64zu8POWGYgCSibagetXqXwxhbMc+D71vlLAnb9Y+8FQp
        HUrgilolKfbl3PC7mOEojrNjxwXIeU3ixRQZ8hSkS7e5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685959590; x=1686045990; bh=b7WdA8yaEnAaWVokTm3Wl92x4YbbiqegX8p
        CiHHIQjc=; b=Umtd2QsrhpB0OU6MwIN3t4rY7d3rJpQDkZ0XtVwxggUVHexFvnq
        J/TC5jjsHofrhLO2M3vi8dEc6wXNsyNRbi7Yh576+wI4x/IYX1/6H7E4bBR7sBdY
        kwmSfnO2MDMU/wNXF9RZ1k7Yqwnsgi7peWGf6ZuTpSByU3qe+ad0oqBGj9cauYFE
        dOcO1UBfuagN5KvlCq7bvptES0YYlYjMGK7dpUti4nBjx7D+WzffkFkca72ajKbs
        kty+A89pi1N1ia7LvYwDdcIwW7GL5nzVLeos+KJiEmmk1IMftM2VHh9Q2kQg1yta
        jjvspiNycXgYLp1rWm5d40wOFGZhiO8t7ag==
X-ME-Sender: <xms:prN9ZP4zxt-b5zsuvSbGrvIbef7bFfE69M4yWvZUcj_W7iDx1P21Es4>
    <xme:prN9ZE5zONT0idRzyV-q3h1T7gvVIZL6Dbq1jXGhfuFADnzVxOGY9RQwEZ0D5COCD
    HgyBs6O3i-JAfiigA>
X-ME-Received: <xmr:prN9ZGeE6foX4SHD-7jwZSg-dqPQLBTMtmDlmmPhKLH-IbA1h37YCJxLkzoBb3263AKkIqFJPVWmQo4TkxwCG3DALga0vkKa-iZ8TYWoSv9CcUu5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelledgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceo
    tghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeeuie
    euffeuffethffhfeellefhueehteettdehveegjeethefgveffuefggfelhfenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:prN9ZAJWOUjMH-yg0VCWdtalLXOYAPoKwbEVZL4Cnmm5Qt5F7dgp7Q>
    <xmx:prN9ZDIvy4XMaEM3Mcr3M2ZsHHKFdwt_uGu_jCQXhH2K8u9W8oZYlQ>
    <xmx:prN9ZJyg6OI4urvhQbZ--UA-Ax-aWwA-CvBdH3mMCFoysSIn_YOpmw>
    <xmx:prN9ZKUwhg6nVZyLdz29U8Zjs_7DDFcP1-YTTVhDx5C_EMLO0kYMfg>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jun 2023 06:06:29 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 2/2] notes: move the documentation to the struct
Date:   Mon,  5 Jun 2023 12:05:23 +0200
Message-ID: <ba147707efe382e64a6559e05b8f266c436bdfa0.1685958731.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1685958731.git.code@khaugsbakk.name>
References: <b3829cb0d1e36a5ebb44a315fe32037f2a3f6c7a.1685526558.git.code@khaugsbakk.name> <cover.1685958731.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Its better to document the struct members directly instead of on a
function that takes a pointer to the struct. This will also make it
easier to update the documentation in the future.

Make adjustments for this new context. Also drop “may contain” since we
don’t need to emphasize that a list could be empty.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v3: Suggested in: https://lore.kernel.org/git/20230601175218.GB4165405@coredump.intra.peff.net/
    v4:
        • Put docs on each member instead
        • Update commit message accordingly
        • Drop “may contain” since we don’t have to emphasize that a list
          could be empty
        • Formatting is based on clang-format and `bloom_filter_settings` in
          `bloom.h`

 notes.h | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/notes.h b/notes.h
index a823840e49..064fd7143a 100644
--- a/notes.h
+++ b/notes.h
@@ -256,7 +256,17 @@ void free_notes(struct notes_tree *t);
 struct string_list;
 
 struct display_notes_opt {
+	/*
+	 * Less than `0` is "unset", which means that the default notes
+	 * are shown iff no other notes are given. Otherwise,
+	 * treat it like a boolean.
+	 */
 	int use_default_notes;
+
+	/*
+	 * A list of globs (in the same style as notes.displayRef) where
+	 * notes should be loaded from.
+	 */
 	struct string_list extra_notes_refs;
 };
 
@@ -283,15 +293,7 @@ void disable_display_notes(struct display_notes_opt *opt, int *show_notes);
 /*
  * Load the notes machinery for displaying several notes trees.
  *
- * If 'opt' is not NULL, then it specifies additional settings for the
- * displaying:
- *
- * - use_default_notes: less than `0` is "unset", which means that the
- *   default notes are shown iff no other notes are given. Otherwise,
- *   treat it like a boolean.
- *
- * - extra_notes_refs may contain a list of globs (in the same style
- *   as notes.displayRef) where notes should be loaded from.
+ * 'opt' may be NULL.
  */
 void load_display_notes(struct display_notes_opt *opt);
 
-- 
2.41.0

