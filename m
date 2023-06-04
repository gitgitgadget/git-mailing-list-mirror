Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E825C77B73
	for <git@archiver.kernel.org>; Sun,  4 Jun 2023 18:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjFDSyg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jun 2023 14:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjFDSyf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jun 2023 14:54:35 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CBDDB
        for <git@vger.kernel.org>; Sun,  4 Jun 2023 11:54:33 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id BC8E2320090A;
        Sun,  4 Jun 2023 14:54:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 04 Jun 2023 14:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1685904870; x=1685991270; bh=3XQuOaDd2byUbv7qYtSXae94U
        kFDQOyWI5MlvPCgRVU=; b=IZkunValRLxFhzKZwf0nBIM9LKAVrIKLT8NnsnxDw
        DlJQQ4NusTiuOYlV2tzPIJvdKzz63DzdBBnzAPVL3xe3CRVt/jzL99/KqdJoc6bc
        DdJBv0RgrCRdvcK3erOR7P9E/JGdmEzEFcE3yYfSUXtyE2IwnleCP6vvdAX5cTp1
        taG35DHqEeqejENcAboQTdmL536TLZp1heEvoAcY07MxBqMReuZcH0/pYVIUhvTD
        TUe2tZBQmlb6JVAUo/hEynqJx2/LXy56OkB4N7b7l6JDcZiQvAG49p/8B6UuNFhx
        akVKcW4jEl+EdVjg751K/Yw2gLVkG9S+cgtzhTuabxw7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685904870; x=1685991270; bh=3XQuOaDd2byUbv7qYtSXae94UkFDQOyWI5M
        lvPCgRVU=; b=lL5uGgPQskBgUkbV8RvhQENVNdka33E8w58Bcz/esypIH4BZSg6
        T26dxTasYrdFoxLyd5AvVp2Brs54JflH1AgDrUarXVIZ9+0ilnTenafzKXlEqQDt
        Xg7dVP8btL8oQWfK0uD9qpsz8xh+PHl39ZOf6q1SlspPR2Kdy9x1jyM3uTn0oiTw
        ELu01cA2Rs8JcOmvFr25NrXoyxHljLy+nYS3KLMLUyh50BQEV79eVLJ9OFX1NVLu
        F8VgVtZU1c9dMg7yn/DHuKMmYQPynV1LbeMvNZRDtw4oXvjftghhHElYgoPoLWUC
        iIaRfqmtLTNLtIPPpZUDXuHsOudra0bl+8A==
X-ME-Sender: <xms:5t18ZPPBOV9rHFqV03gsqF9GorUtE7wE-Gdn4nPyWYH6O-B2P_cTr8Y>
    <xme:5t18ZJ8C0j1JPTwx0HtNzAesP7YBqA7KHkqJ7-xwNIVTSrEORAFJQsKiwQZQBueQn
    sYWKuxqL8yjIm0Lug>
X-ME-Received: <xmr:5t18ZORPukTzgQolaCTHHnQXhu27pnCGmh0FUI7wm-uUf25Wx9yjNhA_5rIVN1a1WFNAL47zipcpgEuI7mdNHvfp6UhYkukdaaClGOymGiS_5jyZDD0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeljedgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgse
    htkeertdertdejnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcu
    oegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepue
    eiueffuefftefhhfefleelhfeuheettedtheevgeejteehgfevffeugffglefhnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:5t18ZDtILkpmTU-j-zp_IURbI_QTpntqQxZ5uIs354j8RTIt9qz9Sw>
    <xmx:5t18ZHeHQScgaplaIm2xVbDTVZMpACiSVRoOROxQwXv0-JMT_mD_eg>
    <xmx:5t18ZP0zNiscFvsiBcKd2Opy1-LZZ6FM6eb9JqWSxmrSYoZErFUC4w>
    <xmx:5t18ZIpsk_z_ncKSCt0Q-RCfS1r82RnMsZuzRivkXlqjRrpuHwQcOQ>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Jun 2023 14:54:29 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: [PATCH v3 0/2] notes: update documentation for `use_default_notes`
Date:   Sun,  4 Jun 2023 20:53:58 +0200
Message-ID: <cover.1685904424.git.code@khaugsbakk.name>
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

§ Changes in v3 by patch

• 1: change initial “else” to “otherwise”
• 1. tweak commit message
• 2: New: move documentation to struct definition

Kristoffer Haugsbakk (2):
  notes: update documentation for `use_default_notes`
  notes: move the documentation to the struct

 notes.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

Range-diff against v2:
1:  3c757bcb3d ! 1:  3eaa725d3a notes: update documentation for `use_default_notes`
    @@ Commit message
         2011-03-29).

         The commit message says that “values less than one [indicates] “not
    -    set” ”, but I think what was meant was “less than zero”.
    +    set” ”, but what was meant was probably “less than zero” (the author of
    +    3a03cf6b1d agrees on this point).

         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>

    -
    - ## Notes (series) ##
    -    § v2
    -
    -    • Fix sloppy typos (sorry about that)
    -    • “default notes” instead of “default refs”
    -    • Don’t drop “it” (“treat it like”)
    -
      ## notes.h ##
     @@ notes.h: void disable_display_notes(struct display_notes_opt *opt, int *show_notes);
       * If 'opt' is not NULL, then it specifies additional settings for the
    @@ notes.h: void disable_display_notes(struct display_notes_opt *opt, int *show_not
     - * - suppress_default_notes indicates that the notes from
     - *   core.notesRef and notes.displayRef should not be loaded.
     + * - use_default_notes: less than `0` is "unset", which means that the
    -+ *   default notes are shown iff no other notes are given. Else treat it
    -+ *   like a boolean.
    ++ *   default notes are shown iff no other notes are given. Otherwise,
    ++ *   treat it like a boolean.
       *
       * - extra_notes_refs may contain a list of globs (in the same style
       *   as notes.displayRef) where notes should be loaded from.
-:  ---------- > 2:  99c88c74ce notes: move the documentation to the struct
--
2.41.0
