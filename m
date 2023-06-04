Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0C1C7EE2A
	for <git@archiver.kernel.org>; Sun,  4 Jun 2023 18:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbjFDSy6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jun 2023 14:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjFDSyz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jun 2023 14:54:55 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BE9F2
        for <git@vger.kernel.org>; Sun,  4 Jun 2023 11:54:50 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id A10FF3200312;
        Sun,  4 Jun 2023 14:54:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 04 Jun 2023 14:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1685904889; x=
        1685991289; bh=nBdHCpeiPG7CqSs4WwxoWuRdsPRybSyMBcPD2O4Wx+I=; b=Q
        t7BWi/TjQxlKRGUogZSOAwK1FBbLkFGMjh2/sDelXCKKT0QmQRM+lsFDMFc82V5H
        bFTlj3t+6+PqAJRCULRVXrjWeLbKwE8zt977KFXzqXFH8yWyV9zTq82D7bNHrOMt
        IjfMhJmUkJ5JaJZMquVy7yvxDoz5ZzruQ7bj5HwF7PDJ8Kv8USSNBVjr0QL7JYV0
        wfSZORCPpAE7Up4oSDRZP9y9dlJP5PRZdWLyOu1WPdMzr0YmCQnfk3mxRfk2MrJK
        lHtXh/cKUISG7spBQM0YJ46TI1xXEI/YZmiBx+zLonrS4hovE5GTs82qBi2HMXUi
        jNkLhj62lEDwRQ8WY6LgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685904889; x=
        1685991289; bh=nBdHCpeiPG7CqSs4WwxoWuRdsPRybSyMBcPD2O4Wx+I=; b=v
        T2K877SDsECGOn35ltsJfpbe9nHnFzBptAbyfG6pBg8LuW0pfHFl76tTsznIwK0+
        FSzr0DM1iyFio2iheHeiSfxJTltLPaWOz+73P014FfAYGwGF0EvDCSlfQlJ1LKPM
        kmRf4TMdJO0hRRnHfleOuIFjPyBw0FeoQJioUHwYWXzeFz/0wQ63Fb3VTkhMKnsC
        kOOdfOGHoLuShofbZYECA1F1hKgsfSG+LUN/2lrqEKVKmmv1HN3u78zYtiYVs6Dz
        A3igfQId207KbhNNAiCcL1lrjHF42mOExyJAHwhwqF0jSGlRe2o7bi1it3o/SIuq
        Zq6BKLs9XOP/QJu+PCG7A==
X-ME-Sender: <xms:-d18ZDCYhJE-2X1K22g_TFcqNWVJVFhnDrkGeuQ_PpfQw1ZO2ZVXuII>
    <xme:-d18ZJgIZkqEeGOmwYP2kYcqBs1fa2HIEMQXzHJz7rbXLMZynvrxQSfJ4s72G02f4
    q3B6uW2fyKv4F27Tg>
X-ME-Received: <xmr:-d18ZOmQqgxujuWDFthFKd7xDZNP3iNK0RLjM4pfi_ljNkmd2VwM1JszjGqT1ei8FmhrCT8Fozd1wFWc0n3vA5MmRbhruOxVDPTnEbm1suliR6jkGx4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeljedgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
    ekredtredttdenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceo
    tghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpefhud
    evveejtddttedvhfelffeuuefhffeugeeluedtgfdtuefhtefhudelleekteenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:-d18ZFx1gIwcEkkVSn4XUodLnOdbuzxvLAYVStp9UQoR2hIDavRf9w>
    <xmx:-d18ZIRkNnEve1DmP6TdO5prK-8UWG4q6xgkZ0LP7vlr0cwR9ngDUA>
    <xmx:-d18ZIYADrXHsJRI7JEdz7MD49L9UqDk9u0zx-VaSpxPeEfp7wBN4Q>
    <xmx:-d18ZDf-T6DSNaBoDO_GFdXjS36RIVnesy72ecw6zonBg2ISHwE_PQ>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Jun 2023 14:54:48 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: [PATCH v3 2/2] notes: move the documentation to the struct
Date:   Sun,  4 Jun 2023 20:54:00 +0200
Message-ID: <99c88c74ceab751c0540b51d98bf339bffc098ef.1685904424.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1685904424.git.code@khaugsbakk.name>
References: <b3829cb0d1e36a5ebb44a315fe32037f2a3f6c7a.1685526558.git.code@khaugsbakk.name> <cover.1685904424.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Its better to document the struct members on the struct definition
instead of on a function that takes a pointer to such a struct. This
will also make it easier to update the documentation in the future.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Suggested in: https://lore.kernel.org/git/20230601175218.GB4165405@coredump.intra.peff.net/

 notes.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/notes.h b/notes.h
index a823840e49..c63b275d7a 100644
--- a/notes.h
+++ b/notes.h
@@ -255,6 +255,14 @@ void free_notes(struct notes_tree *t);
 
 struct string_list;
 
+/*
+ * - use_default_notes: less than `0` is "unset", which means that the
+ *   default notes are shown iff no other notes are given. Otherwise,
+ *   treat it like a boolean.
+ *
+ * - extra_notes_refs may contain a list of globs (in the same style
+ *   as notes.displayRef) where notes should be loaded from.
+ */
 struct display_notes_opt {
 	int use_default_notes;
 	struct string_list extra_notes_refs;
@@ -283,15 +291,7 @@ void disable_display_notes(struct display_notes_opt *opt, int *show_notes);
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

