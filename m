Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE04C77B73
	for <git@archiver.kernel.org>; Sun,  4 Jun 2023 18:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbjFDSyr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jun 2023 14:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjFDSyn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jun 2023 14:54:43 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112CCFD
        for <git@vger.kernel.org>; Sun,  4 Jun 2023 11:54:42 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 24F893200312;
        Sun,  4 Jun 2023 14:54:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 04 Jun 2023 14:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1685904880; x=1685991280; bh=Vvo1TPjnwQYCV0GHxONkdkl5y
        sAT/81X67gMojfy86w=; b=qMN1t+B1aNT4+0nOS2D2apyURyvnd7m1XgvY2qN5o
        xeH8iGCB/GPz9D8hNR2ALcJcxQruv/xu0Y2YK7GAXyUhV8nJwCCN1lVQZ5rU+jLq
        PGjisAcJ2SW1y7fsluxNEc9JBKqDhabSp27aw+pCLprEVIGKisFzOMo83gosa4k6
        g8mF7ecUbNRCm8gISYESK48HUc/dg4kB3ndRkM4cgasgx4YvzDw31NMn2n4nMq9V
        nzr8dDjmVjdDUxJ5msolZFADQNT55W/gKh63++J46GoI11m368mfkJE5Ly7AndZa
        BhOK65GQakbhdaPE8iRTqH5JVdC2eQbzOGioMJRjwNjpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685904880; x=1685991280; bh=Vvo1TPjnwQYCV0GHxONkdkl5ysAT/81X67g
        Mojfy86w=; b=cIcnz6CqedTZqrnHEsnDm8Zd+jQmCn0vyxIyNKt2j+JNYb+xnDl
        aAupUyDfgnpCa3qdMmXRB+0uGGnA3PfJmo8U1sh0F/CsHCJNENiBc7QXTrr6+gDo
        tdDnzebec3mdKSzy9J2h084BQPzqw/Z7ZKDb/x1q7C55qkq4z2inADQhWF2VZBn0
        +LLyUYQiQrsSS/9b7qwX/1CnJoD/YmzMKIFip8Uq9JtWwxY0L9P0n+zZ9kOdmHkO
        wkRZXzh7ZiuWtPdhgY6bs/0dWkTxkr4vPXr/tO5HMxac0TKe62vKe69es8lxuQ/u
        iKe4bgA5IcKwhM6OlCYKJ2wyK0OXc8NITdw==
X-ME-Sender: <xms:8N18ZHek6t2BfCNG9t4qyNt0w6_0LfyIxJNFu06YIGe2SOkSLEefh9E>
    <xme:8N18ZNMMVWT2tC2DTk10hSTPenanx407JC3Epp-luAxzjD6c7lWULAcUyGT3jAWC_
    88aaffoBu8n3_YNBA>
X-ME-Received: <xmr:8N18ZAhgoOXHzZA7_-FTFMfrVOnE0fBtmRZiL6rw45f6-FjNpVDVqUSzVjod1nUtGjSy-LgtEjAPmgoofnBy8ELe5Zyve2t4I0_n3HsOdnib8xxA4Cs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeljedgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgse
    htkeertdertdejnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcu
    oegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepve
    fgleevieekgeejieekueevhfelieduvdelgeefkeejtdekvedttefgffevtedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhh
    gruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:8N18ZI9_05eHUcGfAFRFhDaOIMylVaaj-tOvWNCrj1iblDE4n6sBog>
    <xmx:8N18ZDuOv3-4gb5YxMZWWu0dlir-Ha0W_9RogGjwYOUeAG1pjM4icw>
    <xmx:8N18ZHEto0eBug167dNANyHtIjuxsH8PXFvVOzhqZYWVVCma7oAclQ>
    <xmx:8N18ZM4HWmGRZGNjriceQyxbcxHMfxx8krU5PNpHYRIDR9NDJUGTdA>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Jun 2023 14:54:39 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: [PATCH v3 1/2] notes: update documentation for `use_default_notes`
Date:   Sun,  4 Jun 2023 20:53:59 +0200
Message-ID: <3eaa725d3a476e3cfd7331104f35bbd322d9394f.1685904424.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1685904424.git.code@khaugsbakk.name>
References: <b3829cb0d1e36a5ebb44a315fe32037f2a3f6c7a.1685526558.git.code@khaugsbakk.name> <cover.1685904424.git.code@khaugsbakk.name>
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

