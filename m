Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA6AC3DA79
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 02:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbiL3CTF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 21:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiL3CSp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 21:18:45 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A2517055
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 18:18:43 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id c17so28839840edj.13
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 18:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOj+o2phs01pUDldCm15uyOAtoTjLseArBFdBqfacRg=;
        b=Zs3S3ZTdBhjBCskUPjbAX6XXelRT30Ka/7NrKMx5eWsEodFQIMjhJsPZjeVfPoEE0o
         AbmtU9qXMgoXUkrCOj8MHK/Zl5K1Xuo3w1J/73UhOMRzObAu49HF0tHJrF0FYhw+pgfQ
         SiXau+Zml1/pMiIijoSq7rzG+NSJcQbYGNbyUDAwNpQEh2s6Em2mbjbxcXl1l0PIB8bn
         UD1ggwkKeie6ipj3wQZtIu9xdvFVsjCQWB4I/wRqRezxhcc+Aiqy2WYX0C30vUn9ocfT
         MzhNKFWwK/OJulaBqH9RaIC44PIj079Hak6a0W7hxLQRw5C5cO3YnVHcwYF0HvdES9d0
         3i7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOj+o2phs01pUDldCm15uyOAtoTjLseArBFdBqfacRg=;
        b=AzGI7Rz3ztkYbxV54j4mRZZfO0f24tP6M4Gmri78k/HnIiOy7AZHsPtoMZEJIL1LlA
         HAxnYWZWEjdqRA5i7Imwy7fFkrBZSsBjuVZGkp3Gymz03LHLsPBhNhXBmBmv0BPqAeIb
         L12kR+kSHIY992bFyZDzBRM5zlb50haKkTEoKPcnYmk2s/0Smeh6kaV0vpq/a+fKVZKJ
         +FTJIwV/0lOQB82hTaNEgHWPbrCae8dRpSxTi0zAAlFSPCaTxi+cnOUctwiI9iby+w2A
         Mtw0iizpOOmUyLHG2Uajmjl6SwXrGheUcTxmrtZHZPVooBV8bQ7VOz03OVpv6eh/jkSj
         hKWg==
X-Gm-Message-State: AFqh2koGMccLe76oOPRhAYf0ZYaOTybAabPKKWZsMid0MhVtZzE5sOrT
        b1HTEn+MXlje9ih7MthZQh+J6Ce0aEO7aw==
X-Google-Smtp-Source: AMrXdXspHdvvDSbKRtl8cEigxBXBfsv4EhbVOcENZ1S5iwmwmdZzZEPgAQ1CiGehd7KrjUd9M048fg==
X-Received: by 2002:a05:6402:14d6:b0:479:6bf2:a9bb with SMTP id f22-20020a05640214d600b004796bf2a9bbmr23889521edx.15.1672366721447;
        Thu, 29 Dec 2022 18:18:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay15-20020a056402202f00b0046dd0c2a08esm8861991edb.36.2022.12.29.18.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 18:18:40 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/20] bundle.c: don't leak the "args" in the "struct child_process"
Date:   Fri, 30 Dec 2022 03:18:17 +0100
Message-Id: <patch-v2-02.20-5036712391d-20221230T020341Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.g589e4efe9dc
In-Reply-To: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com> <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a leak that's been here since 7366096de9d (bundle API: change
"flags" to be "extra_index_pack_args", 2021-09-05), if can't verify
the bundle we didn't call child_process_clear() to clear the "args".

But rather than doing that let's verify the bundle before we start
preparing the process we're going to spawn, if we get an error we
don't need to push anything to the "args".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 bundle.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/bundle.c b/bundle.c
index 4ef7256aa11..9ebb10a8f72 100644
--- a/bundle.c
+++ b/bundle.c
@@ -627,6 +627,10 @@ int unbundle(struct repository *r, struct bundle_header *header,
 	     enum verify_bundle_flags flags)
 {
 	struct child_process ip = CHILD_PROCESS_INIT;
+
+	if (verify_bundle(r, header, flags))
+		return -1;
+
 	strvec_pushl(&ip.args, "index-pack", "--fix-thin", "--stdin", NULL);
 
 	/* If there is a filter, then we need to create the promisor pack. */
@@ -638,8 +642,6 @@ int unbundle(struct repository *r, struct bundle_header *header,
 		strvec_clear(extra_index_pack_args);
 	}
 
-	if (verify_bundle(r, header, flags))
-		return -1;
 	ip.in = bundle_fd;
 	ip.no_stdout = 1;
 	ip.git_cmd = 1;
-- 
2.39.0.1153.g589e4efe9dc

