Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50350C2BA4C
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 12:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241135AbiAZMOq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 07:14:46 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:56495 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241136AbiAZMOo (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 26 Jan 2022 07:14:44 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id C038C32009DB;
        Wed, 26 Jan 2022 07:14:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 26 Jan 2022 07:14:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hurrell.net; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=lJ6hxeVWRuT2ITbnCHVn65A8bA/cQL
        90lpuTiqn7TAM=; b=yNRiy/twDxat64OGSW+lMvbttKspKO3P8c9i8PXWPtwlLX
        Hpw9oXlBHRCfN4MQcppI+IL38uCv7leLlXR+6CzO9yT4+FbjCGQowt4XvWhnu1pr
        ZGwcDjADymey8nm9MWT0fb8108WMizrcArS6wigi5KN/iTsRuqgCrLvjWv8mI2cE
        XqIph21jdRrDwkrjzZnG5me8ATUgg8LhqGPnLJzMzQdzZYCmYkK4fO7q197Nt8KB
        cvXTlzv98uI2BcDOPo57y0AgxGMWKdAT76hDAET723shJvtsPgtcWhKX6htSLLlE
        5MpPD3iFVtthT33Al5heT5PyHu0BWHqf0XIckOkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=lJ6hxe
        VWRuT2ITbnCHVn65A8bA/cQL90lpuTiqn7TAM=; b=AJ8kXIrCzAA80TwVUOx5O3
        DbgnTG++3OCRrRdgMNzNICcdT+rdn6uYyxqS7hLQMC+xGZO1BcHLYboMVNfTRa+8
        RRF8giGSNjerfqC57P02pgKQ29kH0ebwY8lm0HoYxlv4cuOSL0iZhoz2AFVt3POp
        LvgrBqYlZVrKMfWOvx5F0qWdXR8m2uxuWY+Tk+9+R6HUtDRvDwsuq38dnwSc6LEM
        TDWbGjP2LURJIvLAbjOrXEAp7Ps3Om+vqQUlqNFW2HD4ylFGKLacIjihmqQlpLr4
        KYRDQtvbJvzz3zLTaDI+Xzv9SpaEMs4PrdkgxCNbcbLcnAmQCF2LwOaUJwl1zZ4A
        ==
X-ME-Sender: <xms:MzvxYYxA9vthFl4no4IlWbP59eupSmPKcqYLKD1joyN7ellPtH0giA>
    <xme:MzvxYcRf3bYaDWEzeyD0PHLBfsw4pyds6ib5g062mmtzExeEFYkNHaWdtjsibB5_6
    clp6Unchd859cx6Jf4>
X-ME-Received: <xmr:MzvxYaU2XPgmD51wwjYjRLObh6aoy57emTlJbpbpMwBt6smMfitEFvPnOrdSOVTfMhN1NNqcL7eL9ADz1mArAJ_S>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrfedugdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefirhgvghcujfhurhhrvghllhcuoehgrhgvgheshhhurhhrvghl
    lhdrnhgvtheqnecuggftrfgrthhtvghrnhepueetvdeiffdugeegheduhedtudefleejhe
    dttdetvdetfefhveekueduleehtdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepghhrvghgsehhuhhrrhgvlhhlrdhnvght
X-ME-Proxy: <xmx:MzvxYWjuWlMs8mPAYHasqR5HfX6Q7-Oh5-gBqXKbYf80bpZQ67jeHw>
    <xmx:MzvxYaC2DGRuGiBk8iL6MeDiAHNNGvU1OWUWuH_X-My-uKDPiDzdSQ>
    <xmx:MzvxYXIe5KEngUAylWL2wAdh6xkRHliGG-aQxXWkmarqSkeU2EOfBg>
    <xmx:MzvxYb5eKmGuxV3lv-A2Kne7UoTMZ73QbXm565nhwX2yZsPPl4znOw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Jan 2022 07:14:42 -0500 (EST)
From:   Greg Hurrell <greg@hurrell.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Greg Hurrell <greg@hurrell.net>
Subject: [PATCH 2/2] Documentation/config/pgp.txt: add missing apostrophe
Date:   Wed, 26 Jan 2022 13:14:26 +0100
Message-Id: <20220126121426.53799-3-greg@hurrell.net>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220126121426.53799-1-greg@hurrell.net>
References: <220125.861r0vhh8r.gmgdl@evledraar.gmail.com>
 <20220126121426.53799-1-greg@hurrell.net>
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

