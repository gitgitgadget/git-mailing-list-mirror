Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9EDC432BE
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 00:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4BBB60F93
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 00:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbhG0ABe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 20:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbhG0ABW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 20:01:22 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F20CC0613C1
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 17:41:50 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id u15-20020a05600c19cfb02902501bdb23cdso664192wmq.0
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 17:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OGAju0jmn6Wk/whAvtdtn6iHkdPg4/dJ0aKJA+dE2D4=;
        b=GxaKVhdP1dIvF/w8LwnrHeGpXKwfOF53RlGi3s8TvVK2gum6NSiZLreQ9GW/t1Kc6x
         l/JWpdODGcMwmNON+Z18jSeT+9IpC/wDbpNlgfl9N4ZN3TF/+7HvGBvjA2ELm6YbgtVz
         EVj24zRRwm5b0/lbTW7el896+GHTrg7L0/UZ26QeQwZ4gFTKegrvpt7AE84ah48KJ1Am
         6ebuQhVfFRSTWcEsIN7EBx8xD+BaLW/wR/cRC4nZlTxTJ+SZCoqS0JAfK/DODtIVzXbF
         HpuDaBfasuKxEU1Xf9M8guKLSJSjjNhQvcYk13i5cyeX0EYSfcMwcyjjYcEOU6tPURIr
         Iz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OGAju0jmn6Wk/whAvtdtn6iHkdPg4/dJ0aKJA+dE2D4=;
        b=mmndhFdDKo5srqHUEnQtU7NehwqWtScwcKqEaRJ++l4/SLSHBTde3JJDb/N5wCm+ei
         W6O1+jA9DyzzIRciDO1K0N0p/YfHgDmbeWs2ecz5VGJTXi7qvC3fUZpyKzzlV+3Woa8/
         YooxPdYZTGXgAuKjnSkT09Xzu6ZkWHK792FJnt4Nz/D4UhozsQcywO+QJCazzMWfZvxq
         oWCP/JnJAExAvZcym+LgZ3PKd1y9Vpnzxm/7SLLqKsMXXSUSDJLBpkMiVK0k9/AiL9Pg
         +HhCPpy+FZUuMrPFmyFCPRnLEPqVUPqa42JEvGMrOz7yqlU8HF1VEKm1JNj/swnphM5r
         zMSw==
X-Gm-Message-State: AOAM530XUqYrliezpRwuI+QlHHsxfDReGV5jmL0o48uQt9WLaFWDj/Yf
        ISZoTc+KUPj4DvaObeSb4fyOGal6FWJzwg==
X-Google-Smtp-Source: ABdhPJwlwTfgG6Ll/9Ff4ofBc3L/PpE0yI85YrWbMaLUz24ue/cxKy96hlJKLuLGg6rigtMY+kTT6A==
X-Received: by 2002:a05:600c:3593:: with SMTP id p19mr19019731wmq.33.1627346508561;
        Mon, 26 Jul 2021 17:41:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c16sm1254377wru.82.2021.07.26.17.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 17:41:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/4] bundle API: start writing API documentation
Date:   Tue, 27 Jul 2021 02:41:39 +0200
Message-Id: <patch-1.4-8c88cd377a-20210727T004015Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.988.g189fd9ae38
In-Reply-To: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are no other API docs in bundle.h, but this is at least a
start. We'll add a parameter to this function in a subsequent commit,
but let's start by documenting it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 bundle.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/bundle.h b/bundle.h
index 1927d8cd6a..84a6df1b65 100644
--- a/bundle.h
+++ b/bundle.h
@@ -27,6 +27,13 @@ int create_bundle(struct repository *r, const char *path,
 		  int version);
 int verify_bundle(struct repository *r, struct bundle_header *header, int verbose);
 #define BUNDLE_VERBOSE 1
+
+/**
+ * Unbundle after reading the header with read_bundle_header().
+ *
+ * We'll invoke "git index-pack --stdin --fix-thin" for you on the
+ * provided `bundle_fd` from read_bundle_header().
+ */
 int unbundle(struct repository *r, struct bundle_header *header,
 	     int bundle_fd, int flags);
 int list_bundle_refs(struct bundle_header *header,
-- 
2.32.0.988.g189fd9ae38

