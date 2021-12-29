Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65F6C433F5
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 06:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238947AbhL2GXu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Dec 2021 01:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238937AbhL2GXq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 01:23:46 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7A8C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 22:23:45 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d9so42563787wrb.0
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 22:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3xEi0GzwO3pJ210HIyppg03Rk7RBaWeMVlmPpH+mMEc=;
        b=KkPm4lNa7mYq3P1UojczTpgN9s+B4VqpPXL35wKOIumGQVcO7GYXuNzQbEVkkvoJOV
         BUIQT4mH6u3PE4jio1EiEDirssWc992u7jnmcMS/bbXGwuM3H9+FW1LNdKzatyDI0tnf
         GubRgHGlqof8kdYamL82InhzIxsw58eLmbWl1s8KwAX51wrQrkv9LpLtXJfZlq9oABOa
         RzhaW56BsXsqDrodxZb7IqQcbBn1zTSvLvTWg4lx0txYZHjmKfJCaVLJHfQFqRg2+gkL
         LKR8PoPzcNrhDppW+2rCAPijvRll43wnLRYCPrHNwPdp7JXpMaCG2TRIuSBzybpKYRW4
         3YeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3xEi0GzwO3pJ210HIyppg03Rk7RBaWeMVlmPpH+mMEc=;
        b=yqmr5P3/bgO3QPNxpgQefiGNolkfedzhXx4QSho45KD+qRDPbfQeXjNLdeJ51oLiLt
         EJf/KSS8nxy74XcxHM/PNAOzDGHsp1D5KBB1bdqMoZl1nS/M6qNZdym9oA8QwmIwgLsx
         lUX5p4K2q/evh5qjLZjuNE9XhINgtyIm/Z7Q3nDCNZJ9T50518w2yEUzlxTcXKLj4lTM
         nssFoh64/B0/rY1917WCjvdgVOBlm1PMaaIwo1sP9Wl6qFku+IyM4E7JO1x1F0fWcnW2
         QcjB4Ezhz9hTjP2M6m2yIGtlakerU6nay+0nfeZIVZ6qY0ejtLHH1mziED60M6keyXMx
         pGHQ==
X-Gm-Message-State: AOAM530Vgn/N7c9kVL1yk+zvzHxCL6+flHCjGZ9WApkS7m6TFBqLkgFc
        gn0bxA77r1YSubTsEFZ7MJ+/KNqeEBM=
X-Google-Smtp-Source: ABdhPJyobTMi43IYP56OIIblsO0Xm8PJEVkjKYLXDkF++V6DUDpy0/TiJiLJizSt63dM0lZQVoXabg==
X-Received: by 2002:adf:f24e:: with SMTP id b14mr19089877wrp.612.1640759024006;
        Tue, 28 Dec 2021 22:23:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a22sm20331954wme.19.2021.12.28.22.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 22:23:43 -0800 (PST)
Message-Id: <4636e27f53e0e6ac2c11b227d4dac32d975c82f4.1640759021.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1171.v2.git.git.1640759021.gitgitgadget@gmail.com>
References: <pull.1171.git.git.1640492910432.gitgitgadget@gmail.com>
        <pull.1171.v2.git.git.1640759021.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 29 Dec 2021 06:23:41 +0000
Subject: [PATCH v2 2/2] name-rev.c: use strbuf_getline instead of limited size
 buffer
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Using a buffer limited to 2048 is unnecessarily limiting. Switch to
using a string buffer to read in stdin for annotation.

Signed-off-by: "John Cai" <johncai86@gmail.com>
---
 builtin/name-rev.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 21370afdaf9..85993bc2b38 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -625,12 +625,10 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 	if (annotate_stdin) {
 		struct strbuf sb = STRBUF_INIT;
 
-		while (!feof(stdin)) {
-			char *p = fgets(buffer, sizeof(buffer), stdin);
-			if (!p)
-				break;
-			name_rev_line(p, &data);
+		while (strbuf_getwholeline(&sb, stdin, '\n') != EOF) {
+			name_rev_line(sb.buf, &data);
 		}
+		strbuf_release(&sb);
 	} else if (all) {
 		int i, max;
 
-- 
gitgitgadget
