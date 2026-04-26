Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5E5366DA4
	for <git@vger.kernel.org>; Sun, 26 Apr 2026 14:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777214325; cv=none; b=rh72dAuyEcj8P2ijH1U7YJscYUi3eCCDYr2nwrKjiS8MaqAqc663rgYbNLjaGmwBaBockuB6H0CEYxR0J+4iS0RAo82WB6x7t8X81flD5nmnKNL90COYD2qdHvd4nApiAY7kEU+NM9g34uO2pwfiXZRRInVim+N6Y4kuRg/IZTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777214325; c=relaxed/simple;
	bh=zybI3vBkHjddp9qA4zOkYagmVVZI/AnjXPwAHdFPIjU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TykZRr0aPj86AURpAphgb1Kh5FtAeFO76hxx5AGO+6r+HXv8Mhg3r+IokBjHbP8ksZKMVZ4Fd5cKvMAtgRjoj0+gmvTBoJDf73WaMKHQ78ZZvJL/r09ee+Df6L8seqwidD+3IT+28ssx5tMkj/J7cq4zCH1tu9agLCqlE3HP1iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvE1hhSs; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvE1hhSs"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8b3d6b215cfso2035566d6.3
        for <git@vger.kernel.org>; Sun, 26 Apr 2026 07:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777214323; x=1777819123; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFpggHaSoj2Tklm9B6rhJzlbpA8+LOPq74rQDTJ796Q=;
        b=AvE1hhSsiuXKz+ImyT3w1OQDzu/bvJ3PfU3W4GveQMlw0ozxmwL1Vems18omojvKVn
         U0oGtkOcKZ3BpHFA80m5XBe4bUymOiC8tRInlqAJtdyXgT6RmtgcsKNgtCtc2vnJ0Cbl
         Fq3Vem9d4Jf1Q4WIIf8s/laXAFQDt3KfX5/IhodSyvgbKF0OcJDOj96Q1gez5bBFhPHA
         ad8SbYAlhJ1RCIfFnMvTgEssIsz3hHWE/Dlkib8gykeiwYmn4ZgKCuJOiRjZQByb/DyU
         nuqolso4YI5qrtP6ssxp84a3sarr7TFQocQJ2JgV00KNGq6aXNa1picqhurnEzNBeMwa
         p3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777214323; x=1777819123;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CFpggHaSoj2Tklm9B6rhJzlbpA8+LOPq74rQDTJ796Q=;
        b=F+REAvZuThpBg6PQxxp0jdHO4gSXTZ6vvbDAlhQz31JSTD5OcZF5Xbic1WHgvwqUDy
         RMR35WTaf0nzEi/9h4xaXPwiaDKuPAjXlK0N83J/XtW0hlugc9N3Tqz5E0KRT4t/iWjn
         F0vIWY571fLAzLWZymRAVV9gylsnt6K9UaknIwdeFdYmhquqiEtKFzlnYblpOVNDaWwe
         C5S4qOv9TIWST/9Gedv94YBnByMaZm+b0EGZC7x6e5XEoVvyV3xXDV0CZmrqjMbRdgiP
         +t07L1G6JUidiRNYG7Z9iIMukzJ50EsOqgcuHQOm76z0+396Gpq+NLqW0EptVdGePl2k
         2MaA==
X-Gm-Message-State: AOJu0YxY6n0Lu7r3XDfV9HH0LDHgXroCOTjUvwx+VCAZVCdcT4jxpf16
	BykUZQ2/AYfsh79FOWkX3viCHkr2FKZSZ7ZQyzpCGVwgONWE+DT5N2pmQPSBCw==
X-Gm-Gg: AeBDiesSTPS8wXHcc0xJG3M6ibe/PD+0OgQEoWaiuGoD4u2oUVoIQx0ojMKYfYkgLd6
	r7W2olmp/v6nLE1xFdoDfs6b6/liq9s658Vj3Z3TItlTjHU/0rVaOKmN7njrUSfzZ1sMOezmXkr
	rIuf57NxMrttCM06CcP1WxqnXCuxOlwgBnpM44wJb5BjdYQNvSGhImCxEaoFfQJi/OR7mqSkqYs
	fbxaERxywXd9KoE61Ime8xaKQmnL/DfyYMn8BUMWqS1s0LGsC0MPPZUPchcGR+WpZPQ3JIS0vOl
	N3jwNs2+IBoD8qUAFpRyluRf49ozvSNrkQ3QDKBpezSLWAMm5iQ02eu/h3mVB7vwJZuQMqBwv/4
	zs1ZM5+tWnNa5pKmWPUzmqoP9xOy5ZnhKr6DSYpRuBeUs25ci6qBrWkCPLs9ZdhFndUZz9qf2DT
	YnnId/fjAQyZm3C+CI3j3QTLVGvFwAzo2tmQ==
X-Received: by 2002:a05:6214:5d87:b0:899:efbf:9292 with SMTP id 6a1803df08f44-8b02818b4c8mr594914586d6.43.1777214323162;
        Sun, 26 Apr 2026 07:38:43 -0700 (PDT)
Received: from [127.0.0.1] ([20.98.18.66])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae5eaf1sm240779266d6.30.2026.04.26.07.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 07:38:42 -0700 (PDT)
Message-Id: <7d68155805f9681f4071ad6d4378960ce36e667b.1777214316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2098.v2.git.1777214316.gitgitgadget@gmail.com>
References: <pull.2098.git.1777042877.gitgitgadget@gmail.com>
	<pull.2098.v2.git.1777214316.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 26 Apr 2026 14:38:31 +0000
Subject: [PATCH v2 3/8] t1300: remove global config settings injected by
 test-lib.sh
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Since test-lib.sh now writes `safe.bareRepository=all` to the global
config when `WITH_BREAKING_CHANGES` is in effect, that entry shows
up in `git config --list` output. Tests in t1300 that expect exact
config contents then fail because of this unexpected extra line.

Unlike the working-tree contamination fixed in the preceding
commits, this is not about the file's existence but about its
content leaking into test expectations. Since t1300 does not use
bare repositories, simply remove the injected setting in a
preparatory step.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Assisted-by: Claude Opus 4.6
---
 t/t1300-config.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 128971ee12..11fc976f3a 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -11,6 +11,13 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
+# test-lib.sh may have added global config (e.g. safe.bareRepository)
+# that would appear in "git config --list" output and break tests
+# that expect exact config contents.
+test_expect_success 'remove global config from test-lib.sh' '
+	test_might_fail git config --global --unset-all safe.bareRepository
+'
+
 for mode in legacy subcommands
 do
 
-- 
gitgitgadget

