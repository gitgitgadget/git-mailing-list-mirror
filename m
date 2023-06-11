Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBBAC77B7A
	for <git@archiver.kernel.org>; Sun, 11 Jun 2023 18:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjFKSR2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jun 2023 14:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjFKSRZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2023 14:17:25 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688A2E64
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 11:17:24 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id A1AAF3200912;
        Sun, 11 Jun 2023 14:17:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 11 Jun 2023 14:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1686507443; x=
        1686593843; bh=x1zHAHnifooRFDMnLEctK8THSJBUpy5bn/9J7PxzrAU=; b=G
        W/S/GxIRQ+Ln1x/tNlL8HPtK2myGVhdOMFWD8mu0eecKUeZbzwpU8DPFKMtAX91L
        1JWLU/72zgjvppP/8AHQ5Gzc6tC3BtbJOrrD+otfdatEmHkqMiNam6dkkGt7tT6B
        QKFmMlc3fR8Ll7B7WPNA0Mli4AC4lSCW6fMCd5BsG8fQ49uTeu8+H0Vuu3m/rdB8
        q0pkQLuAxvZ7PXNZhidTiVvLZW460ID9T6nlYyTdlof3bHnoteExk8PqLSoWOtJH
        n3wUwCMfYEWBOZ+2QV2w6xnYC2owS0T9U9mfynuDZnGe6mf8LUTJthEpfQ8iy6JX
        9muKBgnaZFdztDk71HLKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1686507443; x=
        1686593843; bh=x1zHAHnifooRFDMnLEctK8THSJBUpy5bn/9J7PxzrAU=; b=X
        NtDoPsRoDUJfTvcY9TjlEnHSoKxhtzsyUlWGvK4nZEhuf3qFf/zfJ+ZsKgwWZ/Xt
        pM9gvmC3fLKaT8aNrKhjlhgIMgz6ceArSPJyVbOdr5s6xIikxWs11dulNzpFiil0
        OV5WQJPfpJGuqDYU1nJ2/SfAApYUA/jPEduKHXKgt1MLnBuJUHV+3EQY3ZNF9uQN
        wiqJcQpUWIQ4cCQMmbGRbnClmjGJIHmoCbVZciiDafAYCmMptueoTNyFZ2tMrHC3
        z3UV889mLbUjXZMVn5p2DufjlvUy88HLxpiLo9LkcuIRYC0oEK8jHHxXaQqr1n8u
        Oz6fFRPvE4t8Wr6KZ9Jtg==
X-ME-Sender: <xms:sw-GZNbByDEJx5x8_jJKpl52Bo_Z78PTgVoDHA3A3sjb1z6TlIgYt-Q>
    <xme:sw-GZEbo3h0nK-LuNCSouz4XSNk2AVOEd8A-C4gEVsQPhA9nSg0iIik9CWFkFfoED
    tktBdJq-kbIMk_w4g>
X-ME-Received: <xmr:sw-GZP8hgMg6sVillQtX1KUlKXoZ74Fyv3A0cF3-mad2sIeIVZt2EIeOjia7kgWifwYfrPg-tCcg_dQbpJuXJKpBvoU7fE2_4Uj_KCSgiPVmYSNjhEY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeduvddguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmrhhi
    shhtohhffhgvrhcujfgruhhgshgsrghkkhcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepteduieehgedutdfgudevkefhveduieeiteej
    hfffteeitdegjeeihedthfejgfetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:sw-GZLr_EDtfEN-PSqsumhDxydkcQXjgpaC16g2vBr43bVND1i1M_g>
    <xmx:sw-GZIrCubOtw7AwXeroE4GVTHrN8R7BKwuBzElhpIPL3fAvgNI1zg>
    <xmx:sw-GZBRt_u73cV0NlqSJOoU5_AgK068ROSz13hzN3GcCxhqYZ6aEQA>
    <xmx:sw-GZDXhF-r_y1sVC-CZvg59bCq8Sh7WAuVGbV_sefuToyc1ZWLhTQ>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 11 Jun 2023 14:17:21 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: [PATCH v1 3/3] revision: comment `--no-standard-notes` as deprecated
Date:   Sun, 11 Jun 2023 20:15:56 +0200
Message-ID: <9141f5a86e66276b672fc54783afe3b48b6227cf.1686505920.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1686505920.git.code@khaugsbakk.name>
References: <cover.1685441207.git.code@khaugsbakk.name> <cover.1686505920.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We still use `--standard-notes` but this option has no use and is no
longer documented anywhere.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 revision.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/revision.c b/revision.c
index a0ab7fb784..24219c741a 100644
--- a/revision.c
+++ b/revision.c
@@ -2529,6 +2529,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		enable_default_display_notes(&revs->notes_opt,
 					     &revs->show_notes);
 		revs->notes_opt.use_default_notes = -1;
+		/* Deprecated */
 	} else if (!strcmp(arg, "--no-standard-notes")) {
 		revs->notes_opt.use_default_notes = 0;
 	} else if (!strcmp(arg, "--oneline")) {
-- 
2.41.0

