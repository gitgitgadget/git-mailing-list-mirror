Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC68C77B73
	for <git@archiver.kernel.org>; Wed, 31 May 2023 09:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbjEaJws (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 May 2023 05:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235645AbjEaJwp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2023 05:52:45 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CDA10B
        for <git@vger.kernel.org>; Wed, 31 May 2023 02:52:42 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id DCBA25C00EA;
        Wed, 31 May 2023 05:52:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 31 May 2023 05:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1685526761; x=
        1685613161; bh=S8qKkxq/cyjCvymFl3grq1+KStrQWvWOBcukehAfniQ=; b=v
        Ek5vX0FV1MIIzrk1HpyIQNTZLPbgZCe+yM+1I8XLR6PZ2FjE76itJzTHoatMwyTE
        KMsXC5amE4+of8SDOFiqs2ymZgusyEoq+bsGcnhDS7w1WPqunPja705JbqkgQfAZ
        ntu/JGxOPQS1mzQDOxvilqXxfACWQn+ImBHqbXtAlA98aNhAUx9qVIbsiAgtWwwk
        hRy/mwuYU/uk0J4RY4jz9JqVDE/KRFDQ23i7rRQ9bv7/LIp+OoAv1Z550HTFvyfe
        YG5XOwzg0F2a28YT7WHIQkPQzzJuL61qzp1VhJBoHH0UKIaGQ1POer2j5oMqs99B
        qBFU9li7a5Tj8rCmHqIHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1685526761; x=1685613161; bh=S
        8qKkxq/cyjCvymFl3grq1+KStrQWvWOBcukehAfniQ=; b=KU2Sp7F6I5zkKE1DA
        iNX/38BKrCQuIH0foSQhgNohHIsA7rTTJ4OGg68xJXpqxYNnRNx3fBzojwWHPL1Q
        Utt2A7dX8e8CTSqPJ8oCQ5GLO6vTubfcsGBw3B4ffgULZ8NZEg2ixm396J8jLi/r
        VBzVfYeyZU1MRVGxgYTVvZvrkxPq4ff9SGZniF+Z0YUSDegogVEbsWsEcqBRBM/4
        LGFFDX13YDmeEcYgWJsRklwyfnLArgDPtBLQdUH/GrwhW+ExBycDQoMuHkizzxyX
        MoP9IqBzgFU0hg5808UQvAkITcGCnQ+tIitorJOJWTRtwO1fvX0WQGXc88Bzznjy
        MnvHQ==
X-ME-Sender: <xms:6Rh3ZB_PG5g31ktk_9EbLbNdwY5vLNBz_CmxSoIDzEMKUZi676VKYZg>
    <xme:6Rh3ZFsmd9qxzysfO3gyeYPVaIi5Z0gOmt8K9EIZkL9J2wgcb3qKyiZK2LDEWXn5f
    bAgCRyz7yaJfVrhSg>
X-ME-Received: <xmr:6Rh3ZPBudU4sv20vPBrZJAgX6o5r5mfp71grq-D7vzujkAQ8Dfnfub8Bqago0I8KWZKQQFV9fPpckuhaoVeCXNWTkmWAUUOj-b2UBkLZt3ns9_so>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekledgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffogggtgfesthekre
    dtredtjeenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceotgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeetgedtge
    ehieehfeejtdelhfeuueeitedttefgtefhveevuedtledvfeejheevjeenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:6Rh3ZFdIz5MLC6w4Vw4iaNwuBJ8ToHBh8LGjs_6B0GkCQt-e0ayZwQ>
    <xmx:6Rh3ZGO7t4hRzUd-MUpOP6ED59PDkNpBQEmUYjjV9apeew6uV1RT-w>
    <xmx:6Rh3ZHlXwGJWFBvsVLDzmEgPbv8fW1-CJPkU0hnM52y47qmJfVVtog>
    <xmx:6Rh3ZI1nkGSZaNrF6FMVh_mO2x1R2ne5_ZZRzUIo5v2fe4nfxYgevw>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 May 2023 05:52:40 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Jeff King <peff@peff.net>
Subject: [PATCH] notes: update documentation for `use_default_notes`
Date:   Wed, 31 May 2023 11:52:07 +0200
Message-ID: <b3829cb0d1e36a5ebb44a315fe32037f2a3f6c7a.1685526558.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.41.0.rc2
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
set” ”, but I think what was meant was “less than zero”.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    See also: https://lore.kernel.org/git/cover.1685441207.git.code@khaugsbakk.name
    
    Found while working on that. But this change could be posted
    separately.

 notes.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/notes.h b/notes.h
index c1682c39a9..69b6120146 100644
--- a/notes.h
+++ b/notes.h
@@ -286,8 +286,9 @@ void disable_display_notes(struct display_notes_opt *opt, int *show_notes);
  * If 'opt' is not NULL, then it specifies additional settings for the
  * displaying:
  *
- * - suppress_default_notes indicates that the notes from
- *   core.notesRef and notes.displayRef should not be loaded.
+ * - use_default_notes: less than `0` is "unset", which means that the
+ *   deafult refs are show iff no other notes are given. Else treat like
+ *   a boolean.
  *
  * - extra_notes_refs may contain a list of globs (in the same style
  *   as notes.displayRef) where notes should be loaded from.
-- 
2.41.0.rc2

