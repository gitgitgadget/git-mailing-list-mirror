Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945751BFDF0
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 21:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725052251; cv=none; b=uTdFjeULrbSj7nQyQUyBSN1LgCiQkPlePptvl5k3sySJ8igimiimfue0fhtJYHacm44IvcpwC4o/50umh3I3N7EOsgGTRYlJbQ0AUk+SJXApTvJ1QBzcxQog7w4eO99GC5pO0ZIU+MvpxMzuJ0TqEbaHcf3QnG2q3nDF4N/zIdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725052251; c=relaxed/simple;
	bh=BmJ0ERBnjLMeV/LUhc9sq7abNs9bKuLnjbdPHIKy0D0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YwASBxlNEvCAPckw1Lm0H2XXaAu5uWZ3utJrhFySUzsSaz9+FbNe4WLntAH1KVkrn5vS00eb8LsWsG6uxoPQo1rDWEy3klfRsfnvvEPDHPDxDA5gkFvy1WKWa2r0OYEO5aVN3wY0zk4tk1gi0IsHxVATCvvYXCStRm5SvJfVWdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUzyYlgo; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUzyYlgo"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a868d7f92feso270398766b.2
        for <git@vger.kernel.org>; Fri, 30 Aug 2024 14:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725052247; x=1725657047; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7Tep8SsL3ZpfKfkfrHx24hebf2Rej7JLc7+8vrAqMI=;
        b=hUzyYlgo0wccUNjQ4mnzoAHuRJiWi/dx/iMKWkACloLGlwEZTboeA0Iac+1pD0tP12
         U2A1rndZob8zMstqfmiP413/JuINZLrJfL/4Da1UuBvAQg6f12HMFhNKjXyd5jZOD7gJ
         ayE5JzIbmMKNuO/rC5GT+nX8EyM45VKyAaslWUyTCkrgN7dPt1KQb8KUVslJohKAAXDK
         dOCU4IZ/YFp9zBB9A5pKIo8JTxJZmnRqIbQj+8k96cO7/pYrlaYYGrLlzRGJkE+3dboS
         63hbiT2lG/GKDTe+ceCXD3fZyp//rgDvhmlEjUbh4UNkStSVQlZwLb6Y2lWhkcYYkfmS
         JCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725052247; x=1725657047;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7Tep8SsL3ZpfKfkfrHx24hebf2Rej7JLc7+8vrAqMI=;
        b=NTlMaXI5BnCKmvizFepCXabnBA5exIdgKnjbMtNWxIumkOb35F7GUHNCLx1t59gM2z
         Hzbn2QQ2clM6g0SdtJ1zsS4HQP4wi82GEuEW0wKKXkP0lM9iL3CzRPg7DWvC6zR1RcWh
         GAJjoR0jEJMG8T54ykBvJU+S1pnYqtMBZChLtJtFbjYlk3xoGoBaX9eQnxV8OevM/Xmy
         BhZmJPXZ/VxeJAKQ3dJzgtAbvGR2jDsifWoKDC4hUW3UvqczR1Pv/6poTk7hGnWnSk4b
         E4JEROTl42IVYi6vMyu5e/e/oGOJYIa6FrNZLDav1o6Z40X/an9HV2eMVdqwMicleUwg
         c6kg==
X-Gm-Message-State: AOJu0YwGNsM9XplTkRT3SokS4SGEaHXgZAz0/1zMtX24GxKsAP6TbrNm
	rKnT6tjpLfsdwgZvDl8eZhMlh9gYSmwB/L4tvpxv6z29EblKtO/sNoCl2g==
X-Google-Smtp-Source: AGHT+IHLX8vqgSIqLMXRy0XDiaylpzT0woSRxqky23Of0JVunWsxSn2STFYnZ2NcqeABWF/Y40ozrA==
X-Received: by 2002:a17:907:3208:b0:a87:31c:c6c4 with SMTP id a640c23a62f3a-a897f83623fmr609053666b.24.1725052246827;
        Fri, 30 Aug 2024 14:10:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891da22bsm252535066b.182.2024.08.30.14.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 14:10:46 -0700 (PDT)
Message-Id: <a92825e502f1795910b869165779279b89212939.1725052243.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1770.v2.git.git.1725052243.gitgitgadget@gmail.com>
References: <pull.1770.git.git.1724695732305.gitgitgadget@gmail.com>
	<pull.1770.v2.git.git.1725052243.gitgitgadget@gmail.com>
From: "Kevin Lyles via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 30 Aug 2024 21:10:43 +0000
Subject: [PATCH v2 2/2] Mark 'git cat-file' sparse-index compatible
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
    Kevin Lyles <klyles+github@epic.com>,
    Kevin Lyles <klyles+github@epic.com>

From: Kevin Lyles <klyles+github@epic.com>

This change affects how 'git cat-file' works with the index when
specifying an object with the ":<path>" syntax (which will give file
contents from the index).

'git cat-file' will expand a sparse index to a full index when needed,
but is currently marked as needing a full index (or rather, not marked
as not needing a full index). This results in much slower 'git cat-file'
operations when working within the sparse index, since we expand the
index whether it's needed or not.

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
 builtin/cat-file.c                       |  3 +++
 t/t1092-sparse-checkout-compatibility.sh | 34 ++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

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
index b140b642b21..4d025c5f8d6 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2349,4 +2349,38 @@ test_expect_success 'advice.sparseIndexExpanded' '
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
+	ensure_expanded cat-file -p :folder1/a'
+
+test_expect_success 'cat-file --batch' '
+	init_repos &&
+	echo "new content" >>full-checkout/deep/a &&
+	echo "new content" >>sparse-checkout/deep/a &&
+	echo "new content" >>sparse-index/deep/a &&
+	run_on_all git add deep/a &&
+
+	echo ":deep/a">in &&
+	test_all_match git cat-file --batch <in &&
+	ensure_not_expanded cat-file --batch <in &&
+
+	echo ":folder1/a">in &&
+	test_all_match git cat-file --batch <in &&
+	ensure_expanded cat-file --batch <in &&
+
+	cat <<-\EOF >in &&
+	:deep/a
+	:folder1/a
+	EOF
+	test_all_match git cat-file --batch <in &&
+	ensure_expanded cat-file --batch <in'
+
 test_done
-- 
gitgitgadget
