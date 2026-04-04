Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C188343D8F
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 19:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775332204; cv=none; b=uBoFYrdYa5GXZK0TfmJZuK/OkqpM/zIYlscdtji0BI0lsTB7HaFSWL6ak6C+VgsgXEHZzz+ivP3oAETHf4fn7i0ymvDHsUOQHb+0aukSgDmxfp3Z9GXzm9Bo1fRXCd3dmp2T9DUgPXlPCXjQCT8CsOJxGlESByOt8qc5t4jqTD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775332204; c=relaxed/simple;
	bh=d1HpGepY7OTo4GSnHn/90JC1pUegYXD1q1N7NE52a8I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VUMuWMAqROmQAY88QrgFqg5jp52f1HnWtu9TNfdmsdgCCHVMkENmiPqhSb1/SECAXeDx3qSzbu3z28KNsOyZUT7K7v3iirnHNEDmqZgAf8bB2W5U4oWjJ9VhUzZdsBWa+iTgHEXwFdxYq4zjeh8qffyt8O0IkVZH51FB6cU+E80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErjsDjVW; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErjsDjVW"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cbb6d5f780so305509885a.1
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 12:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775332202; x=1775937002; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2pMOkJGbquIsOyduzjPo7YoobacrNK2/UDFyZNLKrg=;
        b=ErjsDjVWDyEPz0CLPFqzAKMHh/p6v4BlbXdQznbW9767OIKyAwOnsNYrPEuoFURSGL
         +qxZIL7c4HicDI1bKLVlUdvf7TF8LIqqFp3OSE4ikopRDJpcbMlgybgXqV2BSRfhRpMi
         XIYrOrVVCSNrH0MAiW1bHFP/Gm/GaHALfZNthwrafxYDA+5Qcoyl7bHK36n+A3oPf45G
         sSAyFnusRISejfZZGrpgCurNOJ5RpL69i0Pa3upRh3RMQuHP4eDYzPuOCH20IGupAYf9
         LWxJaq7W72y9IUFUTT8BluOtID6e6CB88+nTE5HPuZPedc7P6vDXQCIJaxsdQGXhl+mF
         W3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775332202; x=1775937002;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R2pMOkJGbquIsOyduzjPo7YoobacrNK2/UDFyZNLKrg=;
        b=EJ9EWZs7V9LqNpZYkyUe0q5qjCUQChOgpD8AZb2EnCxpTerXDPR1IZdoZhQku5OXGl
         ie0jgJJHs9JB7Z0N0Nt6Y3AjHhH8tKdB6i3Ypx2UOEdc5j2+qK41oTBT39vQSyHSOUxS
         XB/kMGcaGBiZlv9LKMUlKMB+9/q7jcHaEv+ZwuNli0FNz1xwLTmdjx7xB14O5+rKgXY2
         mKOZaPeKM2AqTw48wXkDTmcaIoxt9RxEgMGXHFOcYEqE01Zat5eNjoPxVlwPIPPEUkbS
         SCQXZF4Bi+tHpo9Oskgv0XILKTaYn13Lnhoky6vdo7h5d+sMbnSCfKF2ycBj1BJATQ5s
         11sQ==
X-Gm-Message-State: AOJu0YwoUXgI8L5nOOyZ3AJe/+aOo1Gi7FcuzLD/RbLm+5pJQXPuGyKP
	IEtM/hqsV+AMMUdoPD9qLGjrdc54jjXGylb+V4jDjKm8o3jR5+OdS3krN9+7azjv
X-Gm-Gg: AeBDievoRvLFfZXbN2vE9Uqdum4K0hQjVj4aXlJIapWpJJMmp3QpCeY8+55dY0dMLlq
	yV2MiVKEVcPo1DHg1gm/DD9gj0h0bpun8zjfNpSEFitFXQ0Z+/VAK7hNZZt4kxS9mqqRIdMH8i2
	0FnjVC3N2ZLKF39csAmi0pVmgga4QdXLtFyCDBtJpRnX+MhMXpbRLSPzgOV2UUGc5k5rmQ1d3TX
	529X8RiFA7HClIZox2B6pYZszyatseGC+llvrERS3IutJvLMgbJUqVbbhzNrKo6A8fZXr/LHvzO
	RfMNFU8QjeBg1QraIIvbSA2iRXEdHAamKeWVbzO3oE+gUNUvuXF1yjfutkomVj0UlJIDZmxfqoi
	1y22ml5yciWmHdKAvWHAnDcoRFzS6JgSZVeNYD7RcvU/h2M/+0IhI6fp8z7+Qtq7v4ogEE8/UJh
	f6v/rpJO9AdKeGUqEGr2pGQ1J+IwNaE1hQeQ065w==
X-Received: by 2002:a05:620a:72a5:b0:8d6:2beb:9474 with SMTP id af79cd13be357-8d62beba32fmr232728985a.43.1775332201689;
        Sat, 04 Apr 2026 12:50:01 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.121.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a5392d1dsm803463585a.1.2026.04.04.12.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 12:50:01 -0700 (PDT)
Message-Id: <a4f7a6df516c848936e6952dac8ca02ccb0ac643.1775332197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2076.v2.git.1775332197.gitgitgadget@gmail.com>
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
	<pull.2076.v2.git.1775332197.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 04 Apr 2026 19:49:43 +0000
Subject: [PATCH v2 03/17] t0003: use `--git-dir` for bare repo attribute tests
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

The bare repo tests in t0003-attributes.sh currently `cd` into the bare
repository inside subshells, relying on implicit discovery. Restructure
these tests to pass `--git-dir=bare.git` to the `attr_check` and
`attr_check_source` helpers instead. This makes the code much easier to
read, and also makes bare repo access explicit, i.e. compatible with an
eventual `safe.bareRepository=explicit` default.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0003-attributes.sh | 66 ++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 39 deletions(-)

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 582e207aa1..3a34f5dbc2 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -346,17 +346,14 @@ test_expect_success 'setup bare' '
 
 test_expect_success 'bare repository: check that .gitattribute is ignored' '
 	(
-		cd bare.git &&
-		(
-			echo "f	test=f" &&
-			echo "a/i test=a/i"
-		) >.gitattributes &&
-		attr_check f unspecified &&
-		attr_check a/f unspecified &&
-		attr_check a/c/f unspecified &&
-		attr_check a/i unspecified &&
-		attr_check subdir/a/i unspecified
-	)
+		echo "f	test=f" &&
+		echo "a/i test=a/i"
+	) >bare.git/.gitattributes &&
+	attr_check f unspecified --git-dir=bare.git &&
+	attr_check a/f unspecified --git-dir=bare.git &&
+	attr_check a/c/f unspecified --git-dir=bare.git &&
+	attr_check a/i unspecified --git-dir=bare.git &&
+	attr_check subdir/a/i unspecified --git-dir=bare.git
 '
 
 bad_attr_source_err="fatal: bad --attr-source or GIT_ATTR_SOURCE"
@@ -449,41 +446,32 @@ test_expect_success 'diff without repository with attr source' '
 '
 
 test_expect_success 'bare repository: with --source' '
-	(
-		cd bare.git &&
-		attr_check_source foo/bar/f f tag-1 &&
-		attr_check_source foo/bar/a/i n tag-1 &&
-		attr_check_source foo/bar/f unspecified tag-2 &&
-		attr_check_source foo/bar/a/i m tag-2 &&
-		attr_check_source foo/bar/g g tag-2 &&
-		attr_check_source foo/bar/g unspecified tag-1
-	)
+	attr_check_source foo/bar/f f tag-1 --git-dir=bare.git &&
+	attr_check_source foo/bar/a/i n tag-1 --git-dir=bare.git &&
+	attr_check_source foo/bar/f unspecified tag-2 --git-dir=bare.git &&
+	attr_check_source foo/bar/a/i m tag-2 --git-dir=bare.git &&
+	attr_check_source foo/bar/g g tag-2 --git-dir=bare.git &&
+	attr_check_source foo/bar/g unspecified tag-1 --git-dir=bare.git
 '
 
 test_expect_success 'bare repository: check that --cached honors index' '
-	(
-		cd bare.git &&
-		GIT_INDEX_FILE=../.git/index \
-		git check-attr --cached --stdin --all <../stdin-all |
-		sort >actual &&
-		test_cmp ../specified-all actual
-	)
+	GIT_INDEX_FILE=.git/index \
+	git --git-dir=bare.git check-attr --cached --stdin --all <stdin-all |
+	sort >actual &&
+	test_cmp specified-all actual
 '
 
 test_expect_success 'bare repository: test info/attributes' '
+	mkdir -p bare.git/info &&
 	(
-		cd bare.git &&
-		mkdir info &&
-		(
-			echo "f	test=f" &&
-			echo "a/i test=a/i"
-		) >info/attributes &&
-		attr_check f f &&
-		attr_check a/f f &&
-		attr_check a/c/f f &&
-		attr_check a/i a/i &&
-		attr_check subdir/a/i unspecified
-	)
+		echo "f	test=f" &&
+		echo "a/i test=a/i"
+	) >bare.git/info/attributes &&
+	attr_check f f --git-dir=bare.git &&
+	attr_check a/f f --git-dir=bare.git &&
+	attr_check a/c/f f --git-dir=bare.git &&
+	attr_check a/i a/i --git-dir=bare.git &&
+	attr_check subdir/a/i unspecified --git-dir=bare.git
 '
 
 test_expect_success 'binary macro expanded by -a' '
-- 
gitgitgadget

