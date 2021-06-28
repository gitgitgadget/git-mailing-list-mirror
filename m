Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43B1C11F64
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 19:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A75BD61C7C
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 19:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbhF1TnQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 15:43:16 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48331 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233988AbhF1TnP (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 28 Jun 2021 15:43:15 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 9E4885C004A;
        Mon, 28 Jun 2021 15:40:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 28 Jun 2021 15:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=beshr.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=Ikjit8iKWxhRE
        SyYXydoHoMbQo+jfbHRGergPjxG1Q4=; b=JC38YoRoDj2y+lTlV5O+g2HOXjhBk
        poaxtfr6BVkb2+cK4aH1u1MZcNGANm3B7xh9oHZXGvEoiBSzYcHUBbNq8naxKZQD
        yl7Lw8edXXw0JvmNBfazhfS8M0h86EEF0yjC8cetRC1hYuOvzxY/tovAYxDlmQtq
        oO9aP6EuWH0f1TpbTRVKpDBcix4Zqf0lCqQVfR7Z99bVVr1seOOnu8Tr0EOCL7mo
        SWeVcuJWGOWS24U7kq5QbesZf7P6PoHptBPaIbvwOuvOTn7MYpKyW1jo6htcumuK
        2sORRns0KYkQs0Gj7jxqYzLf55XNdeI1dizuJ8H30Zi3J7NIIa1b63BNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Ikjit8iKWxhRESyYXydoHoMbQo+jfbHRGergPjxG1Q4=; b=RVvVzyR3
        QCz/yQuL+iZtyzfkubDEUBslQO92YoRfaa/1hYHbYN8/kc+8jYDBKlvtk791e7Ki
        bB2rbMeIPJYAVlrkkCq3qRlNZPRKlvs7ntx0xnd4ukoWFlgrfApV9gZGCh9421w2
        0SdeOjiKUFXGMhYTSeuSjAy6Q9DfRMLDvWFOGkyCAc2V3Cg2A6gQMucDKIDYLwjc
        F5jBazVaJW4R/0XnKp1ihyBYP34BgGEEy8v2TyKbbjWRZ8erXbXOSxRga7eP6dvR
        Eja49tvXGVTcrNcWMVPp7VwjGaWzKwmP6/3XwDsHC1CliFAwJkEMFHlMbrC0PPx3
        3Vm+T5RusL65Zg==
X-ME-Sender: <xms:wSXaYO2a2Gd8GX632qOKt7TjWL691yThe7OH3Y13TDmI7vPJZoGvHA>
    <xme:wSXaYBEB3XL4QrlHkg1Nb0w35T3RdL19zoSMarlf-QFAx4Eo8482dgSQ0rnP9nPMe
    LUumVS_zAieu0ds_-8>
X-ME-Received: <xmr:wSXaYG4SGyjCXnheyYf3_UGElBkik9vBVdspkwu3MuhNlN1wAmcsqr1MQvIz8HKb4v1CCDCwEDRXaqyZNF0xTYwKJiagZJdpMUMDw8dvUSUuvG1Fkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeehgedgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuvghshhhrucfmrgihrghlihcuoehmvgessggvshhhrhdr
    tghomheqnecuggftrfgrthhtvghrnhepjeetudefteegtddvveevkedttddutefhtddvke
    elffelhfegvdevtefgvdfhudeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepmhgvsegsvghshhhrrdgtohhm
X-ME-Proxy: <xmx:wSXaYP0YYQyrrNuo_e2sjRshNy3daB2_Dsvd1dH6KJyMuskJVFB3XQ>
    <xmx:wSXaYBG2Si2SuOuR9faEBOmyAzttX0UOED8CF86OlVS0xHly7IDMZg>
    <xmx:wSXaYI9n9X5j22Pc0KvUsnY49x6BMm3QNNiG8Qf3UO2dA8A3zNdtcA>
    <xmx:wSXaYPNm8cHgkCfRmsixsuaazreG8PhDsg0nUbBMinFYsfgyxm_omw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jun 2021 15:40:48 -0400 (EDT)
From:   Beshr Kayali <me@beshr.com>
To:     git@vger.kernel.org
Cc:     Beshr Kayali <me@beshr.com>, "Bagas Sanjaya" <bagasdotme@gmail.com>
Subject: [PATCH v2 0/1] Documentation: Fix typo in patch option of the commit command
Date:   Mon, 28 Jun 2021 21:37:17 +0200
Message-Id: <20210628193718.377148-1-me@beshr.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210628052631.345601-1-me@beshr.com>
References: <20210628052631.345601-1-me@beshr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks to Bagas Sanjaya for the review. Changes since v1:

- Set commit message 

Beshr Kayali (1):
  Documentation: Fix typo in patch option of the commit command

 Documentation/git-commit.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.32.0

