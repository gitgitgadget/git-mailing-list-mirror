Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FC5C433F5
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 12:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383870AbiAYMkL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 07:40:11 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59093 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1383604AbiAYMhq (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 25 Jan 2022 07:37:46 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 6BBF05C0106;
        Tue, 25 Jan 2022 07:37:35 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 25 Jan 2022 07:37:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hurrell.net; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=lJ6hxeVWRuT2ITbnCHVn65A8bA/cQL
        90lpuTiqn7TAM=; b=JxRxTSmRw9A+nhUTbM0mg7+haAzwZWhMaVFglk3eA3TGQ2
        fmkZ+h6rtQW/55enGx85cL27ZsemcDHLZI3LegSP5LXpIRm7BmUC9CGySBHSJjGe
        Li02iZNf9HGi5+EupWyJM6oD0mE03WOiCoD48ffBe/O8ZwvyzZoSYoe96YXpZUNE
        XZDgpxLiT6rHjlNSsCrglvdcl38++bSJ/JucfxQdDrQ3iTbCJZI6vmGrKML0C/fl
        ln9iDDvgFUMsLoma1dsnFA84xE8+ThxYCvoMBHnnJd2PlXWex1FEQvO6B4WbOVnm
        mMgA1PFYmTPV1PfGdO0yk42zPZPZy2A29sPRz+nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=lJ6hxe
        VWRuT2ITbnCHVn65A8bA/cQL90lpuTiqn7TAM=; b=MBgGqzAHtTVWe2NvmdTInd
        CSbLItAB/SZ3oSOicXffYjyjG4pFduLZQIaGMGvK/Rai6phC4S0yRX7Aev8L1hIQ
        64V6HM2aOaqRJAuVbM7h71EKxrOHz5FA1e4aGZXPX3Lu06IVyWZW1/3ufFn+qvvl
        cenTxVzuIAHTPsKjXPiQveuhmUUQ0fBEnF8shKTFyHUwA709xtXrr0cBQlxOlOrL
        9gz3vqD1n14YHIJtGXGGWU6v/9I3LZGkkV1nJgAjHHIfppvv6TaYjSE0k7m7Aspj
        rg2VgcZ8lJzdMeKeowHwLHoQ73NZGKj+YqOdjDg2iPe3uq2g1Du10kMQjrhJo47g
        ==
X-ME-Sender: <xms:D-_vYZ_Rgn4XClhX1s2B58gJpWuQjuvUG4KCLlZURz-oZ5vGM6sDcw>
    <xme:D-_vYds2ks5oe2vv_jHYRvxKyjgf19l55VK-C3U25yGzDBJxBPZV3ODR1lfobIEBx
    OjPB7SZM_DxXejgRZc>
X-ME-Received: <xmr:D-_vYXB1zsT21KXTp7vemCOSjtGnKrZrHPrj1ZPdDbDQM82DBn9qFIGXhYCiDJBXfAcLzUrl-YrDPzzz5HtrEhIl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrvdelgdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefirhgvghcujfhurhhrvghllhcuoehgrhgvgheshhhurhhrvghl
    lhdrnhgvtheqnecuggftrfgrthhtvghrnhepueetvdeiffdugeegheduhedtudefleejhe
    dttdetvdetfefhveekueduleehtdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepghhrvghgsehhuhhrrhgvlhhlrdhnvght
X-ME-Proxy: <xmx:D-_vYdcMjvHWL6YMOg4ApNgkLQmUwwvRS6M73nR-l6sp0Lwa2Aj_sg>
    <xmx:D-_vYeNlfP0mhmM2DVH17UuzE7Yk9EVgWm-BhUvPec7haot_JwvIFA>
    <xmx:D-_vYfnvq_mxJRfZFGGtjm0fajCziZ6gJ8n-k3OJWVv-KpbeV5NEQw>
    <xmx:D-_vYYXQCkvOLDIAls2BVsYkcCiFQ_nB3c77Nh0D13og4K2a5b6Shw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Jan 2022 07:37:34 -0500 (EST)
From:   Greg Hurrell <greg@hurrell.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Greg Hurrell <greg@hurrell.net>
Subject: [PATCH 2/2] docs: add missing apostrophe to Documentation/config/gpg.txt
Date:   Tue, 25 Jan 2022 13:37:16 +0100
Message-Id: <20220125123716.66991-3-greg@hurrell.net>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220125123716.66991-1-greg@hurrell.net>
References: <20220125123716.66991-1-greg@hurrell.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an apostrophe to "signatures" to indicate the possessive
relationship in "the signature's creation".

Signed-off-by: Greg Hurrell <greg@hurrell.net>
---
 Documentation/config/gpg.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
index abfabd6d62..86892ada77 100644
--- a/Documentation/config/gpg.txt
+++ b/Documentation/config/gpg.txt
@@ -66,7 +66,7 @@ This way only committers with an already valid key can add or change keys in the
 +
 Since OpensSSH 8.8 this file allows specifying a key lifetime using valid-after &
 valid-before options. Git will mark signatures as valid if the signing key was
-valid at the time of the signatures creation. This allows users to change a
+valid at the time of the signature's creation. This allows users to change a
 signing key without invalidating all previously made signatures.
 +
 Using a SSH CA key with the cert-authority option
-- 
2.35.0

