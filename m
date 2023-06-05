Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F88C7EE23
	for <git@archiver.kernel.org>; Mon,  5 Jun 2023 10:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjFEKGY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jun 2023 06:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFEKGW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2023 06:06:22 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1A1D3
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 03:06:21 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 43AB4320090C;
        Mon,  5 Jun 2023 06:06:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 05 Jun 2023 06:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1685959577; x=1686045977; bh=xh8Zg7aK9ZofmNfsQ7ABRlDGa
        CDynnlNsao/GLLhjzA=; b=Ux+vjVzCbeV1ss5qlI1T3xm8zIU35y0mDmricaEYp
        Pt5NyIyEt+KIF8/jJTKtPkzS+amyuVOYleekYbB+k1Eqplmaj9zJhQxkxAqefNip
        UMUQcS4zovGkU5ARTZWGv+SSpyt0KI5HV+FZ19l/wRp8BKiEcKD/xpnn1zBTxWNW
        M7V3eXl/0YoMcYtRJPZFTmdCfvXWkZETpcA4ZGMQu065+XwD0mZyU8TcnPBehmMq
        mn5prK6KaTQv4HmEFwB0HYC/y4uB+k/10JX16htqT5bkguJDY3xJEKK/ASTuj1VX
        CL5ZAOvvi9JPUMoz+x0Dx/j8fPWkPnsEPh0QmVsQg2tkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685959577; x=1686045977; bh=xh8Zg7aK9ZofmNfsQ7ABRlDGaCDynnlNsao
        /GLLhjzA=; b=EcNY5Cb4oA8e2nssUd6ee5v6vkH95QIgLScSJCbzHcGzcOiJ4zI
        h1DfQ1R97c5EeyooQWD4lhU+euM6B7haTxBGwqL9UyMTqk6pD/7mCOdaONHwyGRT
        sy1ez5jEhxA6TqOeThaTV7iA9StQV1aWwV4j62CJvX4hFvq2baV2M5068uwnmrqG
        StTEgHZScNaRoE85qy2l1Lol29XuFMHlIWmcfYL9LDr6vv+MvuYpo7jPha6YJtxH
        uXVXrEFrimK9NWy6/tIUxIJROu6tLNBrWWedbcQJG4p0l9lm9VBWYWQ3RtcCcuvo
        lZ+ipQEqdtta7ff+wvhr497PPs441DpnHhQ==
X-ME-Sender: <xms:mbN9ZJexE6VAJVBPmjvxuj0EpLAdrNR2IXR1iHWBPswx2NvLzWsS8DA>
    <xme:mbN9ZHNjGuzka_OP99fYwJtRDCUPfufFjj16nj9FhGw3qqbK3zvR0fC-GKG-d2acZ
    TNe8Ebh-zC94kbVcQ>
X-ME-Received: <xmr:mbN9ZCgC-psC7iUay6OIp4rIW7AfZloFo8RMAr1qM9DPSluilLR2lfaZPBBH5srRsDo4t2aFiuhIw-Hfz12dXmyrtl9dNxhy8PCLbM31p2BRnVZV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelledgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceo
    tghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeeuie
    euffeuffethffhfeellefhueehteettdehveegjeethefgveffuefggfelhfenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:mbN9ZC9HJvmfx-HpxVjyjOCMQHXAMeEgb_pxCVAMCoDguQYi8LqPYQ>
    <xmx:mbN9ZFtN2BY0H53ziI_BazeCw_tZh5gSXnqdWZpIw7rKEroSA_nqyw>
    <xmx:mbN9ZBFOY8rH5phI9nYxo8aDrFSE5xh88D9bzh3j4dyX3Z8I6zmYyg>
    <xmx:mbN9ZO6K37lh3RNOnMCYjNwXzllwgvLfYQnB-B5uA4pK_JCVsOtXWA>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jun 2023 06:06:16 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 0/2] notes: update documentation for `use_default_notes`
Date:   Mon,  5 Jun 2023 12:05:21 +0200
Message-ID: <cover.1685958731.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <b3829cb0d1e36a5ebb44a315fe32037f2a3f6c7a.1685526558.git.code@khaugsbakk.name>
References: <b3829cb0d1e36a5ebb44a315fe32037f2a3f6c7a.1685526558.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While I was working on [1] I found that the doc for the struct
`display_notes_opt` hadn’t been updated when one of the members were
renamed. I chose to post a separate patch/series.

[1] https://lore.kernel.org/git/cover.1685441207.git.code@khaugsbakk.name

§ Changes in v4 by patch

• 2: Document the struct members directly

Kristoffer Haugsbakk (2):
  notes: update documentation for `use_default_notes`
  notes: move the documentation to the struct

 notes.h | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

Range-diff against v3:
-:  ---------- > 1:  3eaa725d3a notes: update documentation for `use_default_notes`
1:  99c88c74ce ! 2:  ba147707ef notes: move the documentation to the struct
    @@ Metadata
      ## Commit message ##
         notes: move the documentation to the struct

    -    Its better to document the struct members on the struct definition
    -    instead of on a function that takes a pointer to such a struct. This
    -    will also make it easier to update the documentation in the future.
    +    Its better to document the struct members directly instead of on a
    +    function that takes a pointer to the struct. This will also make it
    +    easier to update the documentation in the future.
    +
    +    Make adjustments for this new context. Also drop “may contain” since we
    +    don’t need to emphasize that a list could be empty.

         Suggested-by: Jeff King <peff@peff.net>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>


      ## Notes (series) ##
    -    Suggested in: https://lore.kernel.org/git/20230601175218.GB4165405@coredump.intra.peff.net/
    +    v3: Suggested in: https://lore.kernel.org/git/20230601175218.GB4165405@coredump.intra.peff.net/
    +    v4:
    +        • Put docs on each member instead
    +        • Update commit message accordingly
    +        • Drop “may contain” since we don’t have to emphasize that a list
    +          could be empty
    +        • Formatting is based on clang-format and `bloom_filter_settings` in
    +          `bloom.h`

      ## notes.h ##
     @@ notes.h: void free_notes(struct notes_tree *t);
    -
      struct string_list;

    -+/*
    -+ * - use_default_notes: less than `0` is "unset", which means that the
    -+ *   default notes are shown iff no other notes are given. Otherwise,
    -+ *   treat it like a boolean.
    -+ *
    -+ * - extra_notes_refs may contain a list of globs (in the same style
    -+ *   as notes.displayRef) where notes should be loaded from.
    -+ */
      struct display_notes_opt {
    ++	/*
    ++	 * Less than `0` is "unset", which means that the default notes
    ++	 * are shown iff no other notes are given. Otherwise,
    ++	 * treat it like a boolean.
    ++	 */
      	int use_default_notes;
    ++
    ++	/*
    ++	 * A list of globs (in the same style as notes.displayRef) where
    ++	 * notes should be loaded from.
    ++	 */
      	struct string_list extra_notes_refs;
    + };
    +
     @@ notes.h: void disable_display_notes(struct display_notes_opt *opt, int *show_notes);
      /*
       * Load the notes machinery for displaying several notes trees.
--
2.41.0
