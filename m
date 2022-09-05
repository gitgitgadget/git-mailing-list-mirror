Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FB9ECAAA1
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 08:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237596AbiIEI1H (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 04:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237273AbiIEI0z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 04:26:55 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74682DFB
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 01:26:54 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t14so2997985wrx.8
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 01:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=2Redibo89qRTF4a0M6I/5Sg54RhXL21FFnWB7K7+4IM=;
        b=WTZ2BaGjTg5Stq0N7yyxyEHTH80C+p34BIW1Husf5kBgOJ6L+baxsSyB7Xj8/QoBIM
         OTTu+0Bd03aVbblde0yJ/4lgsQwteVh8cc+Sba/umLsmU/PiQK969rxCh0Cho4G0tZAQ
         tuuCP50lOJ3LmO+qu8OtSFPrkoAsqCWU+xGgKIyBxpv5nZeQfsr0g9SbeLMvsmjy7UX4
         FV+AoSZw3jMSvW5SHE/mcs4ITTtSoN6RAXhoTUWRFhDLut2D2xvRo3sQBiDkde9mojBe
         ubI10X3qC4tALuEO9PnJKm8MxJsxZPfeLe5P9CIw8UAxj4inuo3LdbaGmbmu+d8xp+av
         TCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2Redibo89qRTF4a0M6I/5Sg54RhXL21FFnWB7K7+4IM=;
        b=dVJiY3TXI5T2Y2g5h3AWyffaE8TVxwk/IVxJzp5OZm0KmfZPYCZ8WNm+qQNe1Go4Ub
         M4qq8kv4sM/+9pCc9ZzRPB4U9F7CnmKE32xsiSv7laPJuz6tSFVMTIw10KfUBlluNhDr
         Hyjd8f+9ize+ev31CGn10iIyBnjk7GzSH0HNPSe+D3D+0uOv/4OyrdJQo/48F1Id0cKT
         wkLJo+pjgIh/BMAUMiJhIOLhmhhr6x+IsornKo20V1k4vVW0UnURviYl1433Fd06beMB
         8ip5/I96otCN22OgNklCly454r+6mVVQMGTAmDPtClGumsbPZycwuaeYdNkJVWGmm+qq
         bemQ==
X-Gm-Message-State: ACgBeo0a0F/CE2qAccS54lKMXkK8bOAByiVbtFhWBO9orikvqGo2++yY
        zfeasVfQYvH9HPbrmIdNJAkv1AuMERc1HA==
X-Google-Smtp-Source: AA6agR6wXbrMlCVUhRXK6QOw2fEDjPpsIn8rYVzeKMvVz8yzKq1MlFMPitn40v3SsA2JE1L1jI567w==
X-Received: by 2002:a05:6000:15c8:b0:226:efb2:1d7a with SMTP id y8-20020a05600015c800b00226efb21d7amr12398028wry.99.1662366412984;
        Mon, 05 Sep 2022 01:26:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003a2f6367049sm10564258wmq.48.2022.09.05.01.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:26:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/34] builtin/bundle.c: use \t, not fix indentation 2-SP indentation
Date:   Mon,  5 Sep 2022 10:26:13 +0200
Message-Id: <patch-02.34-66286fa3af7-20220902T092734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1425.g73df845bcb2
In-Reply-To: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix indentation issues introduced with 73c3253d75e (bundle: framework
for options before bundle file, 2019-11-10), and carried forward in
some subsequent commits.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bundle.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index e80efce3a42..5c78894afd5 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -12,31 +12,31 @@
  */
 
 static const char * const builtin_bundle_usage[] = {
-  N_("git bundle create [<options>] <file> <git-rev-list args>"),
-  N_("git bundle verify [<options>] <file>"),
-  N_("git bundle list-heads <file> [<refname>...]"),
-  N_("git bundle unbundle <file> [<refname>...]"),
-  NULL
+	N_("git bundle create [<options>] <file> <git-rev-list args>"),
+	N_("git bundle verify [<options>] <file>"),
+	N_("git bundle list-heads <file> [<refname>...]"),
+	N_("git bundle unbundle <file> [<refname>...]"),
+	NULL
 };
 
 static const char * const builtin_bundle_create_usage[] = {
-  N_("git bundle create [<options>] <file> <git-rev-list args>"),
-  NULL
+	N_("git bundle create [<options>] <file> <git-rev-list args>"),
+	NULL
 };
 
 static const char * const builtin_bundle_verify_usage[] = {
-  N_("git bundle verify [<options>] <file>"),
-  NULL
+	N_("git bundle verify [<options>] <file>"),
+	NULL
 };
 
 static const char * const builtin_bundle_list_heads_usage[] = {
-  N_("git bundle list-heads <file> [<refname>...]"),
-  NULL
+	N_("git bundle list-heads <file> [<refname>...]"),
+	NULL
 };
 
 static const char * const builtin_bundle_unbundle_usage[] = {
-  N_("git bundle unbundle <file> [<refname>...]"),
-  NULL
+	N_("git bundle unbundle <file> [<refname>...]"),
+	NULL
 };
 
 static int parse_options_cmd_bundle(int argc,
-- 
2.37.3.1425.g73df845bcb2

