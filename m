Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451FFC433FE
	for <git@archiver.kernel.org>; Sun,  6 Nov 2022 07:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiKFHhm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Nov 2022 02:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKFHhk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2022 02:37:40 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15836DFE4
        for <git@vger.kernel.org>; Sun,  6 Nov 2022 00:37:40 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 7F2505C00D8;
        Sun,  6 Nov 2022 02:37:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 06 Nov 2022 02:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bernat.ch; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1667720259; x=1667806659; bh=qk
        6tX0ryb5b/5sUeOZHT+2XJ7I4mzry756v3JQZzqYE=; b=YT9M7tDeFbV+UT74ov
        kcc55EkRrGRUKjLqql6jc4OGIpn6VBZfJYRncgm0xMqfPZYEUPET7RbwnlOMhozB
        9fnsOQKpu2JR3fbYaVeEc1ZYxDMnCPnAA4ZdeQVTt7o83YmBzB2EKcRCBU2M6cxr
        D+8odmVehFOcuEzoKZM5dJJeOwIzISQ7pcIsopHEMxXpYYDcGM/Mu47+vD6TU7ch
        Z8sqDTMLaSTlinbV3Se4Da0xGR0KClmtMY6PjVbG8ottZGZeIioWIdDZPTSGVKsd
        /6fwHLwdRNDjBrxdRWofcIOWZgTdzFZ22tRHu2YUkKt8gs/br1pzyrhBsNkOQn+r
        F9GQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1667720259; x=1667806659; bh=qk6tX0ryb5b/5
        sUeOZHT+2XJ7I4mzry756v3JQZzqYE=; b=rwDayURzQskBiUqy2KEJ/0giznuN2
        gX3Wz68JnvInx3lTnSMxbL6WseKYmx0nGpsZMjlEvp1aND4z0fPHMp/EYhClQIL7
        4LToVbB8nnMvQDQvsXIL5QC0dPZPfJmgRP9UcyXkq5OvpVvdvgtZ2A9wZI+aRPxX
        QDGDZPmBzi47fBrjOebDj53bsRRm17y9jD1ENqyLDS49IzxBG3Go4E4YoptiKRQK
        1NDUPN3AQCB4pxTW+4AuJ25Iun6nAlo1/DNAC0lV4N/D9VogQ8UF/qv7m6BdF44d
        x56Hwdbiy+uw+VUqrTBWu+iznTxTx884u2lI4gfiqRqSI5tExZW6rbstg==
X-ME-Sender: <xms:Q2RnY-E2TBz7v95jjVdlX41u6d41h3B6CtQgGOhRQ72joTuW6Qg9_Q>
    <xme:Q2RnY_WfI4NbikimXDzcpmd5Poe1ait79FZZu0u2nmQZEAnBRSgsySMd6k2pjlBWe
    m6Ie2DXtEPGkErFrD8>
X-ME-Received: <xmr:Q2RnY4KRHbv8WhnB0MEFS-0p8om3NSyIn1nTU9LlFcRQkFdyJ56vtBXvTBgupOjz_KOGHgc6LDH_tiEYzk0J2M6DX9mYgvmEBXTwBHWMavtCT8akKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdehgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeggihhntggvnhhtuceuvghrnhgrthcuoehvihhntggvnhht
    segsvghrnhgrthdrtghhqeenucggtffrrghtthgvrhhnpeefvdeggeeltddvgeeiffdtte
    ehffelheettefhfedvgeeuvdelleejudeljedtvdenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgrtheslhhufhhfhidrtgig
X-ME-Proxy: <xmx:Q2RnY4EsDWHxfk7Az003Y43OKomevx3RnEGkwgIYdJZEJA3fdoCzvw>
    <xmx:Q2RnY0Wdx0mgHsLLRN29_QtCo4Y6siW-1ZLrBaZG6ox_vsKhzS4SIA>
    <xmx:Q2RnY7OQzBPisgjmC2dnX3DiMBzyFlvfvH6tUnZUq-WaJjpoE4Wlsw>
    <xmx:Q2RnY9ecRmqBJzJbUNgOPhkYWSmf6cdxrfUEo6fy-z5HZo7C5r0VJA>
Feedback-ID: id69944f0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Nov 2022 02:37:39 -0500 (EST)
Received: by wally.luffy.cx (Postfix, from userid 1000)
        id 59FED5F7D1; Sun,  6 Nov 2022 08:37:37 +0100 (CET)
From:   Vincent Bernat <vincent@bernat.ch>
To:     git@vger.kernel.org
Cc:     Vincent Bernat <vincent@bernat.ch>
Subject: [PATCH v2] ls-files: fix --ignored and --killed flags in synopsis
Date:   Sun,  6 Nov 2022 08:37:27 +0100
Message-Id: <20221106073727.48405-1-vincent@bernat.ch>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221106073445.47789-1-vincent@bernat.ch>
References: <20221106073445.47789-1-vincent@bernat.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Vincent Bernat <vincent@bernat.ch>
---
 Documentation/git-ls-files.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index d7986419c250..440043cdb8e4 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -10,8 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git ls-files' [-z] [-t] [-v] [-f]
-		[-c|--cached] [-d|--deleted] [-o|--others] [-i|--|ignored]
-		[-s|--stage] [-u|--unmerged] [-k|--|killed] [-m|--modified]
+		[-c|--cached] [-d|--deleted] [-o|--others] [-i|--ignored]
+		[-s|--stage] [-u|--unmerged] [-k|--killed] [-m|--modified]
 		[--directory [--no-empty-directory]] [--eol]
 		[--deduplicate]
 		[-x <pattern>|--exclude=<pattern>]
-- 
2.38.1

