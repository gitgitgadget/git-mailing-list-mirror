Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAF781AC8
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 03:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730775919; cv=none; b=XKl43KJv60MdAFxk9e7IA5jlYvC2p/IF8VIT6Xcg7XI7arsg9iEPqaJPzGfbqJV7FKSKe+iYSfXh38SH1sJwOmn4qSpZFFIcrbxmHqmlekhSfFHFB/A/UKEE0pVcIxcE23/5kNaxWelRJtcdYO4A69K6CcvRCsRF+auMRqWucwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730775919; c=relaxed/simple;
	bh=jrhFIPZ99BO9jWdiAJuXAizzXXpWugzpjONoaRsE6g4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NMxrXt1w6PAdDmRr80zGHztCYiY91FyIbKXliXHkYU5pP5XuGnn0ijE4peegN/hQOZv3I7JjqXPcYf6dh2vAPaijjnuJqML6F5VcBrMahdQPXEIR/D8u2EU6EuATcN0WTT+QCKoTTHWdF8wwIhT/KYMHxfo4PhRc2SoBXOsnY18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYe7B1nk; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYe7B1nk"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-431481433bdso43775395e9.3
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 19:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730775915; x=1731380715; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAbltwAN0XIOvmg6uzo2u3EmtVuKrJkCO4AxIbxgKh4=;
        b=nYe7B1nkGrIfdd33DxIBO4vN8DHFbjVzYcZ2BMStd6wER78/1ifIF2UBVtwEiyOWSo
         PFtwaV5NpgZ0ok9C0AMBGuc1D/pRppTqCBM6wFdxiVINSYzPpeA2myHytoZyMHPE9zyy
         16CrMaQ0y+chOWhGsQzmyGpTA8hkIDdfDwoLOEXf+eh4rfiypiXcOFGtpUY8BFwzL6/I
         LhOjRaDTefAHgZygj1zqlacVvhdi56ewvOCfnSxJ5bzs4IhNebWJa/16TV7QQyziWstW
         zdKKhAJuzygc+lugWsPPkKxizXu3cwXwiVxawPfuRoxUyoFJC1D/bhTjgN+A1j+SuQWf
         A5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730775915; x=1731380715;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAbltwAN0XIOvmg6uzo2u3EmtVuKrJkCO4AxIbxgKh4=;
        b=bSyyr2kIZ+myquAcVfT4lFrveq8uZ949KXFpEI70/W8/gWFOcv1yG04XfP71fd1WKK
         5wtQ/4WLdpCaUlFzqKy7OEak1fUxbdK/UYtDVxq7ZI8n275sPrm4WqbGC4MkOMKOgCGS
         9M04Hw+6mCrewkZS6Ssjf9AzWanuDfmH4mcs40ACMxdA0cXyTpQf+QEVGvjr4mv3zIh+
         /2M/CaSVf3C0vAhEXnU6KKI/RgWCvAnoNgcIGmwS5iNYCC64QPqUdU3hZ1ubl3ikgTHa
         HC/MaJPq3IGGUs7Aby5xz6UMQ0f9iAUzegL6qq67ysyUIImDp5hmQFKitr9ffA2dfPWY
         om4w==
X-Gm-Message-State: AOJu0YyCtXY8cPMysj3aEyuIjvuqbiZFQ4NPnrRBO9kQwiCGHrJpZUaX
	os2MbLXrRhZhzAyR9m1nZ7mQjsNRiNGxvRLaqqe/w6p8ovMGQB4v/fYGNQ==
X-Google-Smtp-Source: AGHT+IEt1lVqH9LZaDm6I5lK7p9lpEkXjwQgv3gV8kOh8Axlm16NJ9Xzd318yrkhzYBglk3D3pPnng==
X-Received: by 2002:a05:600c:1548:b0:431:588a:44a2 with SMTP id 5b1f17b1804b1-4327b6fd96fmr164392925e9.12.1730775915357;
        Mon, 04 Nov 2024 19:05:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd8e8466sm202054365e9.2.2024.11.04.19.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 19:05:14 -0800 (PST)
Message-Id: <b8a055cb196dd971ac21611c1957be319557b4d3.1730775908.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 Nov 2024 03:05:06 +0000
Subject: [PATCH 6/7] pack-objects: disable --full-name-hash when shallow
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

As demonstrated in the previous change, the --full-name-hash option of
'git pack-objects' is less effective in a trunctated history. Thus, even
when the option is selected via a command-line option or config, disable
this option when the '--shallow' option is specified. This will help
performance in servers that choose to enable the --full-name-hash option
by default for a repository while not regressing their ability to serve
shallow clones.

This will not present a compatibility issue in the future when the full
name hash values are stored in the reachability bitmaps, since shallow
clones disable bitmaps.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/pack-objects.c       | 6 ++++++
 t/perf/p5313-pack-objects.sh | 1 +
 2 files changed, 7 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7cb6f0e0942..f68fc30c9b9 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4589,6 +4589,12 @@ int cmd_pack_objects(int argc,
 	if (use_full_name_hash < 0)
 		use_full_name_hash = git_env_bool("GIT_TEST_FULL_NAME_HASH", 0);
 
+	if (shallow && use_full_name_hash > 0 &&
+	    !git_env_bool("GIT_TEST_USE_FULL_NAME_HASH_WITH_SHALLOW", 0)) {
+		use_full_name_hash = 0;
+		warning("the --full-name-hash option is disabled with the --shallow option");
+	}
+
 	if (write_bitmap_index && use_full_name_hash > 0) {
 		warning(_("currently, the --full-name-hash option is incompatible with --write-bitmap-index"));
 		use_full_name_hash = 0;
diff --git a/t/perf/p5313-pack-objects.sh b/t/perf/p5313-pack-objects.sh
index dfa29695315..a7f4e0bf8d8 100755
--- a/t/perf/p5313-pack-objects.sh
+++ b/t/perf/p5313-pack-objects.sh
@@ -66,6 +66,7 @@ test_size 'shallow pack size' '
 '
 
 test_perf 'shallow pack with --full-name-hash' '
+	GIT_TEST_USE_FULL_NAME_HASH_WITH_SHALLOW=1 \
 	git pack-objects --stdout --revs --sparse --shallow --full-name-hash <in-shallow >out
 '
 
-- 
gitgitgadget

