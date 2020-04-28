Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D74C83004
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 10:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0080206E2
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 10:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbrKIj4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgD1KxO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 06:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726348AbgD1KxO (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Apr 2020 06:53:14 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F0FC03C1A9
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 03:53:14 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id hi11so983689pjb.3
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 03:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HfxT5LCtKtXerLxR9EJu7IhmeEMoXx77a1PYqO3Kt1k=;
        b=cbrKIj4NfVtKoAJrWaawPhZifVYy3q5u9XWsi1RjOTN4XBuiL2JZKThNwRPS2ulGeA
         Xn1aw7jwsH7sPiDsCNbqUpaaaT0tp8ZJ/Ns4wXoMd9TF7IA/CBxAuTR9EpszBsnwJex/
         r9GygTc11N5rwjtrZQ4c9hMePAkhD1/gdewViINjCHias4tZFp6PPkweNNwv4Pw9vxlE
         2VgSK3CsDL6lK9jUTRxC7ES/w6J4TWVY8qlzQy4FZ4EgmY0ZsVCT/M6xx1vD9edLbjCc
         omkqYVsGp55S6QhsMYSLZYBO0bG/eZMX0lu8OiYuzkLfU7nUOJGz33VfTPEvVTSWWprH
         hSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HfxT5LCtKtXerLxR9EJu7IhmeEMoXx77a1PYqO3Kt1k=;
        b=sNCZTV+MOG07AKVnY0R77Ts+L0IfkrUbKrvgKv1/VZ0lIsJj3GoxVgquIIOIQDeV/U
         YSRpm5VMlmeLK9e7HulUwwpeh3PJCPDH1K/uDI7yv3YP5Un3oE0fEN9DJcbOQxlDbKZg
         CvTdYKxtNUGzix8fsD75S8SBzbMxRwwVg3KcO+v7prOWBNFZQZfAds5TgY5I/MjlrVW1
         62lvCZRuKK9uoAcCjupD8mO96/hVEpa9tEkpdtPriSfm5L1D9vUXfqs0yaDKV8KCs2L2
         gnW5TbC5Drt4/ng9fcvNbsS7hIsp9Ip6FAZUqqTpBC7w4eLejowXpznegNqoorgnTpHx
         djIA==
X-Gm-Message-State: AGi0Pubwruj7BpebUlQWyOJFIV6/NoyNGqq94/A0h5wlN/C6A+QQqmHy
        lt77gJv3Jd++98UOjwgAPNj2cAG+a8M=
X-Google-Smtp-Source: APiQypKl5koCknORgcKJWnAg7gm7vBiod28ykZUyKWoW4gT06DH3VZz7HSnJ4+s6B3HuNGFrZNwpyw==
X-Received: by 2002:a17:90a:4fc5:: with SMTP id q63mr4196121pjh.70.1588071193505;
        Tue, 28 Apr 2020 03:53:13 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id e11sm12513436pfl.85.2020.04.28.03.53.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 03:53:13 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     dirk@ed4u.de, sunshine@sunshineco.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v4 2/4] git-credential-store: skip empty lines and comments from store
Date:   Tue, 28 Apr 2020 03:52:52 -0700
Message-Id: <20200428105254.28658-2-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.569.g1d74ac4d14
In-Reply-To: <20200428105254.28658-1-carenas@gmail.com>
References: <20200428104858.28573-1-carenas@gmail.com>
 <20200428105254.28658-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

with the added checks for invalid URLs in credentials, any locally
modified store files which might have empty lines or even comments
were reported[1] failing to parse as valid credentials.

add corresponding failing cases

[1] https://stackoverflow.com/a/61420852/5005936

Reported-by: Dirk <dirk@ed4u.de>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/t0302-credential-store.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index d6b54e8c65..94cdcb9e56 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -120,4 +120,19 @@ test_expect_success 'erase: erase matching credentials from both xdg and home fi
 	test_must_be_empty "$HOME/.config/git/credentials"
 '
 
+test_expect_failure 'get: store file can contain empty/bogus lines' '
+	test_write_lines "#comment" " " "" \
+		 https://user:pass@example.com >"$HOME/.git-credentials" &&
+	check fill store <<-\EOF
+	protocol=https
+	host=example.com
+	--
+	protocol=https
+	host=example.com
+	username=user
+	password=pass
+	--
+	EOF
+'
+
 test_done
-- 
2.26.2.569.g1d74ac4d14

