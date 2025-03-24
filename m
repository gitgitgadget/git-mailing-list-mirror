Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD5125F7B3
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742829779; cv=none; b=MpnHtMRxcSu1ohow1PaSpC71q+o6+ewQk/0QL+jdYdgBtRCxxavIoXk5Cu+WiGRPMnikkrO2AuzhE93V1Ijzw7G9yuureS9/08Gc2MZY9TBb+6jowV+//WD3YSTTXiLNoyYMUzCDlSEQx6JRFbcWpo+vWfzpNwySF/zN5vlaVGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742829779; c=relaxed/simple;
	bh=xIEKG0EG1jfY68ggbTcC0OC7wwOCz57pT4COkHwdHVI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FTN35yI79+UaX9AUji3jIoujduRymaL3jO+cygqsMyDtBvNYF/DzCRj+4QP+AgEqGDp3Yiwf4qZzqcXulV9FMy0whpUI6unb0TqZ7THZGU7Bru2lPYm4KdDdVvbSWI+onQqYzskmUhxCgNNz+4JxXK7KrNF9XeHBj3+/MaGZyx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bi6mUAbZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bi6mUAbZ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso45712715e9.0
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 08:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742829775; x=1743434575; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdzesK0wF0DCw92PbvjVSxI7mMGp0p+80LAJKndv8vI=;
        b=Bi6mUAbZ6dBIbXjvX+/Q6m9X63bVPumJEsZSoptCRRwKJEpyp6TCMSUZNiamBEQyWa
         rqJdxSdcFUGJK9KDQybhcvTXvNxk+eMvKf6x3lmS6k/8GJx2UqmTC8IXnVFiYet2Hp3K
         yML8dc6U4YycnUHZo56KuHN18qvbmiV78Gd5PksLoh5779m12jbs4/98BsDMiljxBptW
         lsrNbhmW7pNddZNU0w+favIh+GBXG/ETdOO0RCYObkc6KBlp3lomeEN5AkXVzkz0P3NH
         qL4x5RTLrDWwrKR894XYoRQ9PM18mYWkh3b4LW651hBnOIPji0NGUEpq5Qk8KruCqm+C
         ANjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742829775; x=1743434575;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdzesK0wF0DCw92PbvjVSxI7mMGp0p+80LAJKndv8vI=;
        b=jQaytCNAZOEI7VVPp3hdTGmS4Gen3gHtG9I7sIgWlVhiLBW+8rrfJ15ICU5UFJGNOK
         1bs4Ne7ZvjLoTpPzRq6hruk5+/pieUzZP8AnhTtKYDrI02TYDKsRNy25J93otufzdZdv
         zpFJUjMKHNxp/Vgn9gWKc+XBiN2miQuyfMV4rWh+3ifS43fbCKwBE/PnE8d7sQL8Opde
         6VAtyQum7PLYoXpQI+Wwm2Te8BXf0Id/I6EzTUSEWIsZNsIY7ic5o2UCE7KL6XbEQxDJ
         /TbGKqpBbQjKF+2T0dPIa2drCYcUrgapJ8s0h9QO8Dq37n8k9PfISaV96DcsxLcnK0L4
         iMeg==
X-Gm-Message-State: AOJu0Yw/8/6AjLaAMcVz1blVnK2bAWq4eDTk7C/BwKL7V+IZZDP3v7/D
	pV9Ahnz6nMv/wl+tgczCfLIYTaKQRqzOyE3I4MZXFGG9fw70IK32MZbENg==
X-Gm-Gg: ASbGnct5gZQn4FSUThUBj/T1merdXR1LTLipDOTZeUMa1mW4K7knOIVx9Qq26IGNfoA
	Hayyp2R89cBvfAe6lLSaXahoLInEpLGImOmh03EnuKvITdBDbF3Su14ejAdaxmHKmY5ReCwk9I6
	1Dci1IGA43xGNj/vPQok84hFLxa2gdfs3IbrqelVEM3SgmA51iS0EJvoM3NTycucKuhBqggpuzN
	uC01Fek64EuHUqy88QL520xTJmpj44sM+lM7L5E33FijHclfUWwcLA/5lqeYvPZB7VBcsJPUIfS
	FB7NB3SqBci/ilP8I22AwZWY6PoooR0z8U518udYyhyJaw==
X-Google-Smtp-Source: AGHT+IEcHPfOiiyNRP/V9DE1E3ryIT+09l/bGG+7DDjNm767S3dBvLnKQbgbGXClC1KFwtOqIWBOOg==
X-Received: by 2002:a05:600c:3b04:b0:43d:aed:f7d0 with SMTP id 5b1f17b1804b1-43d50a3a421mr93974225e9.28.1742829775029;
        Mon, 24 Mar 2025 08:22:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a3a10sm11110975f8f.28.2025.03.24.08.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 08:22:54 -0700 (PDT)
Message-Id: <dcff01392ffba718cb3cce86e63b9e959190ccf7.1742829770.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
	<pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 24 Mar 2025 15:22:39 +0000
Subject: [PATCH v2 03/13] pack-objects: update usage to match docs
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
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The t0450 test script verifies that builtin usage matches the synopsis
in the documentation. Adjust the builtin to match and then remove 'git
pack-objects' from the exception list.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-pack-objects.adoc | 14 +++++++-------
 builtin/pack-objects.c              | 10 ++++++++--
 t/t0450/adoc-help-mismatches        |  1 -
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index 7065758eddf..7c666a14277 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -10,13 +10,13 @@ SYNOPSIS
 --------
 [verse]
 'git pack-objects' [-q | --progress | --all-progress] [--all-progress-implied]
-	[--no-reuse-delta] [--delta-base-offset] [--non-empty]
-	[--local] [--incremental] [--window=<n>] [--depth=<n>]
-	[--revs [--unpacked | --all]] [--keep-pack=<pack-name>]
-	[--cruft] [--cruft-expiration=<time>]
-	[--stdout [--filter=<filter-spec>] | <base-name>]
-	[--shallow] [--keep-true-parents] [--[no-]sparse]
-	[--name-hash-version=<n>] [--path-walk] < <object-list>
+		   [--no-reuse-delta] [--delta-base-offset] [--non-empty]
+		   [--local] [--incremental] [--window=<n>] [--depth=<n>]
+		   [--revs [--unpacked | --all]] [--keep-pack=<pack-name>]
+		   [--cruft] [--cruft-expiration=<time>]
+		   [--stdout [--filter=<filter-spec>] | <base-name>]
+		   [--shallow] [--keep-true-parents] [--[no-]sparse]
+		   [--name-hash-version=<n>] [--path-walk] < <object-list>
 
 
 DESCRIPTION
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4f934847558..75a6545cca1 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -187,8 +187,14 @@ static inline void oe_set_delta_size(struct packing_data *pack,
 #define SET_DELTA_SIBLING(obj, val) oe_set_delta_sibling(&to_pack, obj, val)
 
 static const char *pack_usage[] = {
-	N_("git pack-objects --stdout [<options>] [< <ref-list> | < <object-list>]"),
-	N_("git pack-objects [<options>] <base-name> [< <ref-list> | < <object-list>]"),
+	N_("git pack-objects [-q | --progress | --all-progress] [--all-progress-implied]\n"
+	   "                 [--no-reuse-delta] [--delta-base-offset] [--non-empty]\n"
+	   "                 [--local] [--incremental] [--window=<n>] [--depth=<n>]\n"
+	   "                 [--revs [--unpacked | --all]] [--keep-pack=<pack-name>]\n"
+	   "                 [--cruft] [--cruft-expiration=<time>]\n"
+	   "                 [--stdout [--filter=<filter-spec>] | <base-name>]\n"
+	   "                 [--shallow] [--keep-true-parents] [--[no-]sparse]\n"
+	   "                 [--name-hash-version=<n>] [--path-walk] < <object-list>"),
 	NULL
 };
 
diff --git a/t/t0450/adoc-help-mismatches b/t/t0450/adoc-help-mismatches
index c4a15fd0cb8..06b469bdee2 100644
--- a/t/t0450/adoc-help-mismatches
+++ b/t/t0450/adoc-help-mismatches
@@ -38,7 +38,6 @@ merge-one-file
 multi-pack-index
 name-rev
 notes
-pack-objects
 push
 range-diff
 rebase
-- 
gitgitgadget

