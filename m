Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED9A1D88C3
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 22:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725401216; cv=none; b=AKtblKJg9GLJzhXh+CybckaG8FRIthkQNt9Rin3HUCXJQQUzOvFXbkom7HVrS5/27vUn06EkvstgR4yRfHSmYyIEjqSluflRRIwZW+CI0tg+TCa2lVfCrpg6UY2Cy+4ubmkdd3sEY/OTNjM/gwRR+p2vHI3Z9FGhYFii76cH7aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725401216; c=relaxed/simple;
	bh=k3zqn/w4HkRx5sqHTuYeI4pIkAW4NRjhqcgFW4oEVdQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SlUVLSA5y3wE/IOLVXWXa2vYRazODAgFis4y3pZiZs9CzcV7WSEOl8DaOBMJ5BEEsDwVS4lFQA7YY+BQSaV7MYS1ygomgZCkI8HKw3US2x3XIWSqVdRNkreYXJgyN9h+RO8dAUE5ghYpf5xj8xuAYLiDQ5v88CVwfk4ShVDL2yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTP6Te03; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTP6Te03"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a866d3ae692so339353866b.0
        for <git@vger.kernel.org>; Tue, 03 Sep 2024 15:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725401211; x=1726006011; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/yMnIJkTJjce0gXAPjc03uZ/yS9kmwpi7BaT3dAzcQE=;
        b=bTP6Te03Mc/kTSaRwo9Hlp8Kfribb3/CYWVHDGOnidwMPM0p3PetGx2ycl3c8kYAVk
         hxpDPkkj+Ult7L2o+W5Wwg4xCfuBmLOCkyJV6ijdwivE1cbZ8TMHqZdUyn8nU412wXIH
         SCajRckqpwVHyQUJqwi9aIhnSgNPlRM3rE9Vyn9VXayZoqWu5wD3yYtkwMbCb5pz41Ht
         k4ooNG+/wmMicU55OTj1RrFaWcFLQ2UjVG+xGOMuTyiT9phv+jsjVS88V5x0ekigQfLp
         1l+1DsMdeuPvSnS7n3oKLTMMt24+p3L5Pt1XOeE6X+4dFQnrrogNFbf0EIf9MaKm1/lL
         jppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725401211; x=1726006011;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/yMnIJkTJjce0gXAPjc03uZ/yS9kmwpi7BaT3dAzcQE=;
        b=nQHnaYBiDtHqX5eoDjwWMZJz3oWCYQ/M78IRZdkjQvJJfnYmgPCee5D2E781c6J/mc
         UDYmZV1IBwITyMzOtEkTeytUTr9DZTbOS1WyEDeJE/UNgX5zHt7vb28lcHqVQfvRSHh7
         /a4PBk6lUbk0bSE6OD8AB2w5n0iAjFP1vduybSdqVSJfv4ukqeiKeMRAl0GbXt73VysT
         kpYAtNWpw6uEChWbrsj0S8Y+rFHbran0CSjLc3/vH8IEH91/vFWq1E+UF6bodxAyouS9
         FdAPUpfxHqSVqKIY+8kOOB2aKic1shVAiqn5bVU+qLuSoGBJ14Zu9PhzfUqtvwJT/Jmo
         np5Q==
X-Gm-Message-State: AOJu0YyU0o/Vm7DxgilIL0GMf3c61ruNZ2ouwnyMnTFsDgC49XaP6VEz
	cXm3lsWOfQXdGZj2Ns54pa9FJHU3jEEJFb20nVvUsHbFc+5taFqn03w9Kg==
X-Google-Smtp-Source: AGHT+IE2rg+ICD+Ui0bcw2akoE0kV02bXM8JOBHf+QADRtkNCQs0EGLyND13AJVcClINXzFNnqdR1Q==
X-Received: by 2002:a05:6402:d08:b0:5c2:1803:ac65 with SMTP id 4fb4d7f45d1cf-5c21ed54d08mr17128815a12.21.1725401210330;
        Tue, 03 Sep 2024 15:06:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c24b5ad63dsm4447658a12.80.2024.09.03.15.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 15:06:50 -0700 (PDT)
Message-Id: <ac913257309960d86a9c11e825c76621c6ac405c.1725401207.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1770.v4.git.git.1725401207.gitgitgadget@gmail.com>
References: <pull.1770.v3.git.git.1725386044.gitgitgadget@gmail.com>
	<pull.1770.v4.git.git.1725401207.gitgitgadget@gmail.com>
From: "Kevin Lyles via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Sep 2024 22:06:47 +0000
Subject: [PATCH v4 2/2] builtin/cat-file: mark 'git cat-file' sparse-index
 compatible
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Kevin Lyles <klyles+github@epic.com>,
    Kevin Lyles <klyles+github@epic.com>

From: Kevin Lyles <klyles+github@epic.com>

This change affects how 'git cat-file' works with the index when
specifying an object with the ":<path>" syntax (which will give file
contents from the index).

'git cat-file' expands a sparse index to a full index any time contents
are requested from the index by specifying an object with the ":<path>"
syntax. This is true even when the requested file is part of the sparse
index, and results in much slower 'git cat-file' operations when working
within the sparse index.

Mark 'git cat-file' as not needing a full index, so that you only pay
the cost of expanding the sparse index to a full index when you request
a file outside of the sparse index.

Add tests to ensure both that:
- 'git cat-file' returns the correct file contents whether or not the
  file is in the sparse index
- 'git cat-file' expands to the full index any time you request
  something outside of the sparse index

Signed-off-by: Kevin Lyles <klyles+github@epic.com>
---
 builtin/cat-file.c                       |  3 ++
 t/t1092-sparse-checkout-compatibility.sh | 36 ++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 18fe58d6b8b..1afdfb5cbae 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -1047,6 +1047,9 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	if (batch.buffer_output < 0)
 		batch.buffer_output = batch.all_objects;
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	/* Return early if we're in batch mode? */
 	if (batch.enabled) {
 		if (opt_cw)
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 4cbe9b1465d..eb32da2a7f2 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2358,4 +2358,40 @@ test_expect_success 'advice.sparseIndexExpanded' '
 	grep "The sparse index is expanding to a full index" err
 '
 
+test_expect_success 'cat-file -p' '
+	init_repos &&
+	echo "new content" >>full-checkout/deep/a &&
+	echo "new content" >>sparse-checkout/deep/a &&
+	echo "new content" >>sparse-index/deep/a &&
+	run_on_all git add deep/a &&
+
+	test_all_match git cat-file -p :deep/a &&
+	ensure_not_expanded cat-file -p :deep/a &&
+	test_all_match git cat-file -p :folder1/a &&
+	ensure_expanded cat-file -p :folder1/a
+'
+
+test_expect_success 'cat-file --batch' '
+	init_repos &&
+	echo "new content" >>full-checkout/deep/a &&
+	echo "new content" >>sparse-checkout/deep/a &&
+	echo "new content" >>sparse-index/deep/a &&
+	run_on_all git add deep/a &&
+
+	echo ":deep/a" >in &&
+	test_all_match git cat-file --batch <in &&
+	ensure_not_expanded cat-file --batch <in &&
+
+	echo ":folder1/a" >in &&
+	test_all_match git cat-file --batch <in &&
+	ensure_expanded cat-file --batch <in &&
+
+	cat >in <<-\EOF &&
+	:deep/a
+	:folder1/a
+	EOF
+	test_all_match git cat-file --batch <in &&
+	ensure_expanded cat-file --batch <in
+'
+
 test_done
-- 
gitgitgadget
