Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD709C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 00:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7653A222C2
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 00:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=edef.eu header.i=@edef.eu header.b="sVIqq+/d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k1cpALiO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfLTAj4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 19:39:56 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:56487 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726952AbfLTAj4 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 19 Dec 2019 19:39:56 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4D55122672;
        Thu, 19 Dec 2019 19:39:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 19 Dec 2019 19:39:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=edef.eu; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=0wKBU8iazye05gPDHstYHa4wMd
        Ad3DQloo25VyWz1kc=; b=sVIqq+/dCWfemfT1zu0aMZkC4jAW872dUOBIeiA/qy
        YC3qVq8L72tlb0xGbddOvEU+pznPwBnjVw2Ry4op9tpefJzZi1govIxYdnJQwFes
        YBgq0IubPa4ZLJbOG/y1ec3XisZK05MuckvHzN6WCazE38R2gGM/Yoa8/eKcrheH
        kmYYWPa/kSiWj/0hNjAZTCW0+C3AlAhIPBUczw+vvtVuSF0b1T9fRcVzZPHDBJsx
        3uxhus3u3qMtHzqhto03Etb1f95AKI5+29hZAZPK0XzjY2Xl3LjKQ/LQxi5b3Yld
        LGWd7cvD5QWLsixeifj23lp6C/agL1z8VoPC/OUznicg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=0wKBU8iazye05gPDH
        stYHa4wMdAd3DQloo25VyWz1kc=; b=k1cpALiOeionXg96sfLowWbhUyfR2szZU
        NewDItgmKuyclsGagFd0UyTb6pyEKvT9RDr5XhsCOLce60OElwmpsb+RSi/Llfrm
        eDDUrs6W3kAIrtObL4ESScZCvxL5RozsqpMfp8Ine01IP81VNM5hvKr+FeWJoNOi
        +xW0+soV5hqUA1EgCNgKb2a4kzlWDIDQv9cvj4zqNDaeC1e3tN4qKXHVPJpJfTnr
        k5+q6a4ohh23coOHAlwxmIwbgdSLOSo/PL0010hzRk8Gl5Hb3ddfPoVjVbG9hLxI
        XUIvLmbBU/v6RDSa907anG8n9+TSy4f5RI9Xl6iMyaLTEgXtkv/IQ==
X-ME-Sender: <xms:Wxj8XUTK0ssez4TVX4Hy21xAN3gbPAYpF40hHwWnXgKEjfv6FsKrzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdduvddgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepvgguvghfuceovgguvghfsegvuggvfhdrvghuqeenucffohhmrghi
    nhepkhgrlhiiuhhmvghushdrtghomhenucfkphepudelhedrvddtuddrvddtiedrudejfe
    enucfrrghrrghmpehmrghilhhfrhhomhepvgguvghfsegvuggvfhdrvghunecuvehluhhs
    thgvrhfuihiivgeptd
X-ME-Proxy: <xmx:Wxj8XQ-HRoWZieE8l-rFe9j5sn8E8DPj5mA3MSa01isttgtgxlTUfQ>
    <xmx:Wxj8XYBYpSCNPfBbXcuK5l6MclO2PKewIU3gEYYzv63X_JPjJthGuA>
    <xmx:Wxj8XZj4nsPYyQPSjyDzDLsnJEWDmxBmrWhCouTmxiss2Gv4q93HYQ>
    <xmx:Wxj8XXqfgpKw6sY97ZkPUY47jRKiDsubNZK_vjrY1iaMQ2WTv2MKpA>
Received: from localhost (uhura.edef.eu [195.201.206.173])
        by mail.messagingengine.com (Postfix) with ESMTPA id CD12C306081D;
        Thu, 19 Dec 2019 19:39:54 -0500 (EST)
From:   edef <edef@edef.eu>
To:     git@vger.kernel.org
Cc:     edef <edef@edef.eu>
Subject: [PATCH] mailinfo: don't discard names under 3 characters
Date:   Fri, 20 Dec 2019 00:39:48 +0000
Message-Id: <20191220003948.60272-1-edef@edef.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I sometimes receive patches from people with short mononyms, and in my
cultural environment these are not uncommon. To my dismay, git-am
currently discards their names, and replaces them with their email
addresses.

Link: https://www.kalzumeus.com/2010/06/17/falsehoods-programmers-believe-about-names/
---
I'm not *completely* sure there's even a case where `src = email` is 
the right thing to do, but I'd rather not modify this code more than 
strictly necessary.

 mailinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mailinfo.c b/mailinfo.c
index b395adbdf2..7274232e28 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -19,7 +19,7 @@ static void cleanup_space(struct strbuf *sb)
 static void get_sane_name(struct strbuf *out, struct strbuf *name, struct strbuf *email)
 {
 	struct strbuf *src = name;
-	if (name->len < 3 || 60 < name->len || strchr(name->buf, '@') ||
+	if (!name->len || 60 < name->len || strchr(name->buf, '@') ||
 		strchr(name->buf, '<') || strchr(name->buf, '>'))
 		src = email;
 	else if (name == out)
-- 
2.24.1

