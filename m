Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7923E498
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 14:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708612611; cv=none; b=MOPu/Phvn3BfVZOyglPgLvkmsKtQNqDBtarTnuMOFV3+dZ/atdK+ySfyu6EGJ9Mfa2WkrNyXAg+WkmCl61zdgunZmgoSjWWFHdFF8bFafih3w4TvzJONL1uD2uL8QQRU+9V6nSExTiiClIlLEXIxZdgCfAK3eX/SEM0rRDNPSqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708612611; c=relaxed/simple;
	bh=Xq7WRXhxo0C1kRAmZ99K0pnF6HJm4Bw5bwfBCsQ5cn4=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Yt7hLiUdsYaeOksoroOIK7ivMBKcVUNzxp+nsF/pFJPNQeOZd6/rqZksGRJBEyv4oQq5+zTZieSpiVk8gceuItV70oo0wRJfVAMBc5TBsK42bBTqzbLT9UwDdbp6CrGx5RaJ67MdjE3WnHyhWVqGIjHsYUNIixizygX5Rb/LH3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksog571R; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksog571R"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4128cfb6c1aso2998555e9.0
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 06:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708612608; x=1709217408; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+i8PkXYJCTRN8cYGZeTF3cwl+HgYBrV1XX86X8PXc4=;
        b=ksog571R38PSxa+r/UISpZDV5p9U3lJUgSDqksJdJcRDnWvoG20jlBYH8tYyQu6Jaw
         7lr4VeuaD5SuQrRPlC7wgoq/ZdfnJjf/CWHy0mT3UP1XM1qGaN/0Mful8UD3v+Rz8pfs
         XS3OfFG3scUuiG61CldXf2EcmkIN/xot3pc+sBdDTyhqcyIMCGFuDArspXsBOkNIOpps
         R8NOcdna66pbW6TKSc71ypG7nd9GXeBmQM/lbWKQY5aIMxFrBeGLVS5ANpDB23AnTcr7
         eHAuf9nZGoECXxquU7jMqcTluDZDtQkHROT7oThhc8OoFY0Ls9gyiT20MiulKm1bvCE7
         ha7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708612608; x=1709217408;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+i8PkXYJCTRN8cYGZeTF3cwl+HgYBrV1XX86X8PXc4=;
        b=J3A1fI2T7U86lqm8gjFHabH4dh72WhfvAzMYUmh7Q6vWcfefcb+hH7t4FPvsgzVUlN
         YO4WvkST1P134MLEQG+d/mAGt2RrQsiS6FmA7x+EegZPbgAbI1yGNXJoQxgQMUVVC/fW
         7JqRGfYnAIpfF+2aSk9pI/qgRs0srN8unvYwCDB0H8kDzoXVosyjrI2sVjwAYUj/GPdi
         rPpT6mVEDBrOIDsojVhT3HgvnCQZpR09v4g60Lp7VBj04ubYNLohlptPzckx1hEl7stm
         Ja69xi8QHyXY8nbV7HwuCMYXLuRlL2G17jcwA7h3ra9OSpLIpMNqZXvLWFQVF/TMXR/Y
         lirw==
X-Gm-Message-State: AOJu0YzrfKpJ5M+dXgT/DKUsAr9pmbix4hBMVJ3qy0s3DxqaZaRwFeQx
	O+Wc1s9kaCBZg9e48HCMI0TdNRNETwwonTvYb9y1ZwxFGn4zmD2sJNc+khUf
X-Google-Smtp-Source: AGHT+IFRAF0SPfd+D3ScagUUGz8Dbcucn9fPxLsyJLcazJYeMQ11p0IeCTCgU1gUbEx4TFzL4Yc60A==
X-Received: by 2002:a05:600c:154b:b0:412:5eba:c155 with SMTP id f11-20020a05600c154b00b004125ebac155mr2516797wmg.11.1708612608326;
        Thu, 22 Feb 2024 06:36:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id jw3-20020a05600c574300b0040d5ae2906esm6391819wmb.30.2024.02.22.06.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 06:36:48 -0800 (PST)
Message-ID: <f01f4eb011b400faeff1c33934775a521dec7a3d.1708612605.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1651.v3.git.1708612605.gitgitgadget@gmail.com>
References: <pull.1651.v2.git.1707324461.gitgitgadget@gmail.com>
	<pull.1651.v3.git.1708612605.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Feb 2024 14:36:42 +0000
Subject: [PATCH v3 2/5] merge-ort: do check `parse_tree()`'s return value
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The previous commit fixed a bug where a missing tree was reported, but
not treated as an error.

This patch addresses the same issue for the remaining two callers of
`parse_tree()`.

This change is not accompanied by a regression test because the code in
question is only reached at the `checkout` stage, i.e. after the merge
has happened (and therefore the tree objects could only be missing if
the disk had gone bad in that short time window, or something similarly
tricky to recreate in the test suite).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-ort.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index c37fc035f13..79d9e18f63d 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4379,9 +4379,11 @@ static int checkout(struct merge_options *opt,
 	unpack_opts.verbose_update = (opt->verbosity > 2);
 	unpack_opts.fn = twoway_merge;
 	unpack_opts.preserve_ignored = 0; /* FIXME: !opts->overwrite_ignore */
-	parse_tree(prev);
+	if (parse_tree(prev) < 0)
+		return -1;
 	init_tree_desc(&trees[0], prev->buffer, prev->size);
-	parse_tree(next);
+	if (parse_tree(next) < 0)
+		return -1;
 	init_tree_desc(&trees[1], next->buffer, next->size);
 
 	ret = unpack_trees(2, trees, &unpack_opts);
-- 
gitgitgadget

