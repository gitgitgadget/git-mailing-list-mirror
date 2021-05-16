Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A83C433B4
	for <git@archiver.kernel.org>; Sun, 16 May 2021 15:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A549961076
	for <git@archiver.kernel.org>; Sun, 16 May 2021 15:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbhEPPJH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 May 2021 11:09:07 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:55463 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230040AbhEPPJH (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 May 2021 11:09:07 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 70695B36;
        Sun, 16 May 2021 11:07:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 16 May 2021 11:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=edef.eu; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=CA+OaOSZD/dZb
        n2HCgXrbQqy4ypQnNDGSJkhjp+aBqQ=; b=ly8W0ZWPz3N3vjthTdMC63tREP1ml
        sb5kuX0CLoz+RWU9FORJeD7i8bxI8l/+D1D3lERt10xzGASM5WPxP7w4DTMvtKxM
        0WUL1ckaM9B36oKQqOFBAcyqrtAw73QaKgxOqwH38JL0J8WKZn+FQrfeoIJ6J8Rz
        NSLQU15OZifvV1jq/v+G3En4kN9rQ4xzeUL4QslMrZ1O6fqyqqNPbwl5KU5LSrfw
        xEHxIgAKUQmQXYXy6qfGZ5MJJjZKFYJTHbpPXE5YDZKVKaMTiUmmQrhc/hqHYfpL
        GO3F5kMszaKkO8ecpiEyTJVBw/GY9RnWXWieU20D3EDHx41hkJiQfQsJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=CA+OaOSZD/dZbn2HCgXrbQqy4ypQnNDGSJkhjp+aBqQ=; b=RP0U04YK
        cqWC8gE/STrcp9ULLVhB640U77HA0vAzD3ZNw/k0FQ899KQ52iZ7W226fHzo1x5b
        hjmqni1Y8fk2CpWo1YzkVUle4eVf7gQ1vXheGQ2cWe3w960mvBdl2G40OoO8YXwY
        vX2bUGlugNcVhqixveDLV51AAiGa3PUkfjpHyDTcdHpz0hKBcHC64zzd015Czzym
        UNwiuWDmAX8eJzjgPdYewgrXie3EeLp+BjWWHKktAzaDBf1YP0h+t5I0IPX0pS+9
        o2dqAmxilvnCVVsfEgcxUCPLK4lpnxdeFTnkOlAxBQ4p1D1vciIT1ZJMuYj7Xc7r
        L6VWJv/Z78fRcw==
X-ME-Sender: <xms:RzWhYDgALps5WrjfmDbbudacZLv_rI6AnlOAECtx45SXgMQQsJrpmg>
    <xme:RzWhYACEXnLIiCjO6XSpclHezt47bt9Hk0UCFW10ywtrvU4MK2z4WUy9e_nF6GsP0
    CNTGG2DQihHV_kmGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeifedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvgguvghfuceovgguvghfsegvuggvfhdrvghuqeenucggtffr
    rghtthgvrhhnpeelheevfedvveetgffgudelteevledtveekuedvleeuvedutdehtdeutd
    etjeelfeenucffohhmrghinhepkhgrlhiiuhhmvghushdrtghomhenucfkphepudelhedr
    vddtuddrvddtiedrudejfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegvuggvfhesvgguvghfrdgvuh
X-ME-Proxy: <xmx:RzWhYDGMNkTr1phfCgX9zlqqv91BHiHBhADhjSnsgvlW22nDFotclQ>
    <xmx:RzWhYAQjPQ2vdSEeuI6EPMMm-T-YbInVDJSfGg_abM1jmAsDYs3tSQ>
    <xmx:RzWhYAxFcYwX1bGhvUJVJrKt5FIkOytiY4fibW1WJCnXcb3x5z6UAg>
    <xmx:SDWhYNs27_VNYHsmOdC3qUA3ZYWd4VPoc_UzdDCW22h04YCEbayiiA>
Received: from localhost (uhura.edef.eu [195.201.206.173])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Sun, 16 May 2021 11:07:51 -0400 (EDT)
From:   edef <edef@edef.eu>
To:     git@vger.kernel.org
Cc:     edef <edef@edef.eu>
Subject: [PATCH v2] mailinfo: don't discard names under 3 characters
Date:   Sun, 16 May 2021 15:07:19 +0000
Message-Id: <20210516150719.49710-1-edef@edef.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200130100654.GA840101@coredump.intra.peff.net>
References: <20200130100654.GA840101@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I sometimes receive patches from people with short mononyms, and in my
cultural environment these are not uncommon. To my dismay, git-am
currently discards their names, and replaces them with their email
addresses.

Link: https://www.kalzumeus.com/2010/06/17/falsehoods-programmers-believe-about-names/
Signed-off-by: edef <edef@edef.eu>
---
Rebased and with Signed-off-by this time :)

 mailinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mailinfo.c b/mailinfo.c
index 95ce191f38..626228654c 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -19,7 +19,7 @@ static void cleanup_space(struct strbuf *sb)
 static void get_sane_name(struct strbuf *out, struct strbuf *name, struct strbuf *email)
 {
 	struct strbuf *src = name;
-	if (name->len < 3 || 60 < name->len || strpbrk(name->buf, "@<>"))
+	if (!name->len || 60 < name->len || strpbrk(name->buf, "@<>"))
 		src = email;
 	else if (name == out)
 		return;
-- 
2.30.0

