Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99C7295DBD
	for <git@vger.kernel.org>; Sat, 18 Oct 2025 20:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760818048; cv=none; b=XSZR597qxvKwiZwgx68jktLGkv3A/S9qCr/fDXRb5PVcddegV9ZrdAo26rdmyYEhUoBy1xfojVlUksn2qjSBn4cQAFIvfeitlOEUAc9E8NXAAGdiv0q/RLaynjt8WiV8UwlWA558c/4hWySjuyOf1Qe5DMkNDQh9+GnyHZJYZBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760818048; c=relaxed/simple;
	bh=x7DL8wZ2H2y3CT4UixCIA02HGuAmtVuVKlfHEfMR65U=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oh/ujvFHqUSdggwozHdg61vlL3cETPyKOIrFWrMRTl/2pXPXeYOiPZYbknwsvYP0GwML3Y/EA3IVY9bcH0YNNtX8M2KUigOL4BFfMxOENKrdMI13LLx6Ol4kVROQ/CFsVy2MNb1jW6eW7O8EL+88m/pS1GxTmGoCzwR5wCXBLmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jmo5Dml4; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jmo5Dml4"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-781997d195aso2360779b3a.3
        for <git@vger.kernel.org>; Sat, 18 Oct 2025 13:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760818045; x=1761422845; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZfhe2hkJZ4fjedR/NgC4K5OxCXYVRt0oCFzUSwCtz0=;
        b=Jmo5Dml4n3Gf+gF5GvCe5C55BnScGmshp7NoNQdBxWYllFhtwI64gf8GihG3IJAlcN
         bX1MHpjWB0B5vk6cTa/FIt5gj5UIYbax2iAEoMNDrZMKWDVXt2OGbIZhmchQjSyoxqfc
         6ap+vaSpQAEd/E9iuxH1tqexUzqaa9DFQy4Cfluh7tPM+BZZSYJNcoJYku/RZbD8F4R0
         JBqBqn5YBnyjdF5Q/l92jK3Q7fGk7NQ3vgIPNdut0AoQo/nsrXpXY8EcIhuQYMJ8T5a7
         QNAw/sqHISNBYNIz5V/MXuIaHFEmOBsgsSCKa7u+cMEo95dNvbl8KPpZDJIO38SlIfjn
         UOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760818045; x=1761422845;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZfhe2hkJZ4fjedR/NgC4K5OxCXYVRt0oCFzUSwCtz0=;
        b=Msmzp5Hy4ounJLoGdeXr/AtWFvo87Bycm8N/H6/pHzxnpCIxkY0Nz8cGdZnR1LcPyp
         LIlHKOl7w5c9u+lMWb6W5WCddDjHKt47ITOR8SEj7qdduGQVtxzQwxQj62Jm5CYIIXJN
         LHBHKIxebwYNvO+AxwPqd+T4eOgjfRgzTkugT681n3SbnMfr1YtGlAC/eJeGKGUhSvus
         dMkAXpoG/wjOEMNYwALYF1eHQz0u+R0+0AgFXyGy03B7FTsPsv1+ckgj4HZ++SNfrwXb
         3MpiD5IFJiygLt+Gee+kI/87kDdLIMOh+0lE1WdfzphdyQpqQuLGcLBWq+LGKwhBJjwX
         b70Q==
X-Gm-Message-State: AOJu0YzWJRsHo0aM0fHeBKZnWyzpAypqRFcujse6m6eqwUTtA1MN4DsP
	2v4lFrhUeiyV0jVDFcQVGoe7jELjYJM9gT67mVCbnUcXlPUt+KgYCel80N03wYwR
X-Gm-Gg: ASbGncveXjrpO8/57/OYJZ9sqrHsotCNFaJq+rBTqO67nu61q753y5Ru3lHLDJgxu69
	5UNnFKLamBNZvijFshwTSeb5FmFUFSqikqT+eWOJ5TIgE6E3c1V+yRFCB7M24tWXB7XApppisuE
	jR9JJ6WigXbW1jQCm+9TRMPzrIqdQQmMWYC5keXetmqcsQQWHHqiPeIUyntY32ImLoLh72qrKVp
	xZsyLjaoXwR/KCcwuwWxrS+Gc+MzpEAJVUVNidM+RWInTqoj4vRwNoorwUy54y0UDRJYqXc3uhH
	JQuDkkEADJ3nCwREKI8ZH5S5o3iDncATUbGL8ZdDb88e+8HIiBsKipkUM2jnpThcDEbWkWcdolg
	+Z6U/Hp9uRnoD25aa54jy/rxnj1ZWgU3bzjlH5p8ZHjkh16xraqODZMp0MbRzd1A8cZmaQvRxHw
	fJngA=
X-Google-Smtp-Source: AGHT+IE/FSfLhg/lUCK80i3OzFCK9Q4QxUTYAu4K4UA7aG05vVeQR+H8v5XHLBCMN1pCpV4va+qrLg==
X-Received: by 2002:a05:6a00:4099:b0:7a2:23cd:418c with SMTP id d2e1a72fcca58-7a223cd42b2mr7490246b3a.3.1760818045395;
        Sat, 18 Oct 2025 13:07:25 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.211.85])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a230122380sm3494893b3a.77.2025.10.18.13.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 13:07:24 -0700 (PDT)
Message-Id: <58563a7b9039ff75bc449fc781a95a286c11c2b4.1760818039.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1987.git.1760818039.gitgitgadget@gmail.com>
References: <pull.1987.git.1760818039.gitgitgadget@gmail.com>
From: "Claus Schneider(Eficode) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 18 Oct 2025 20:07:18 +0000
Subject: [PATCH 4/5] tests: fix existing tests when add an ignore=all
 submodule
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
Cc: =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason <avarab@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Brandon Williams <bmwill@google.com>,
    Claus Schneider <claus.schneider@eficode.com>,
    "Claus Schneider(Eficode)" <claus.schneider@eficode.com>

From: "Claus Schneider(Eficode)" <claus.schneider@eficode.com>

There are tests that rely on "git add <submodule>" also adds it. A --force
is needed with this enhancement hence they are added accordingly in these
tests.

Updated tests:
- t1013-read-tree-submodule.sh ( fixed in: t/lib-submodule-update.sh )
- t7406-submodule-update.sh
- t7508-status.sh

Signed-off-by: Claus Schneider(Eficode) <claus.schneider@eficode.com>
---
 t/lib-submodule-update.sh | 6 +++---
 t/t7508-status.sh         | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 36f767cb74..f591de6120 100644
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -95,14 +95,14 @@ create_lib_submodule_repo () {
 			git commit -m "modified file2 and added file3" &&
 			git push origin modifications
 		) &&
-		git add sub1 &&
+		git add --force sub1 &&
 		git commit -m "Modify sub1" &&
 
 		git checkout -b add_nested_sub modify_sub1 &&
 		git -C sub1 checkout -b "add_nested_sub" &&
 		git -C sub1 submodule add --branch no_submodule ../submodule_update_sub2 sub2 &&
 		git -C sub1 commit -a -m "add a nested submodule" &&
-		git add sub1 &&
+		git add --force sub1 &&
 		git commit -a -m "update submodule, that updates a nested submodule" &&
 		git checkout -b modify_sub1_recursively &&
 		git -C sub1 checkout -b modify_sub1_recursively &&
@@ -112,7 +112,7 @@ create_lib_submodule_repo () {
 		git -C sub1/sub2 commit -m "make a change in nested sub" &&
 		git -C sub1 add sub2 &&
 		git -C sub1 commit -m "update nested sub" &&
-		git add sub1 &&
+		git add --force sub1 &&
 		git commit -m "update sub1, that updates nested sub" &&
 		git -C sub1 push origin modify_sub1_recursively &&
 		git -C sub1/sub2 push origin modify_sub1_recursively &&
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index cdc1d6fcc7..7617be14e8 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1565,7 +1565,7 @@ test_expect_success 'git commit will commit a staged but ignored submodule' '
 
 test_expect_success 'git commit --dry-run will show a staged but ignored submodule' '
 	git reset HEAD^ &&
-	git add sm &&
+	git add --force sm &&
 	cat >expect << EOF &&
 On branch main
 Your branch and '\''upstream'\'' have diverged,
-- 
gitgitgadget

