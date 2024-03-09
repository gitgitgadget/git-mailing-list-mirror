Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E361BDF4
	for <git@vger.kernel.org>; Sat,  9 Mar 2024 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709993403; cv=none; b=Go2BSMklof6DSCVgB1FYzcoaRSMvBGz2Qm4SuYX45uJxK9Ozvgamz90ejm5R6dAbUrh0UQwHxj38BIkisomNphbV2NLvupAyK8SF5S7TePiWa9AY5O7+r0ojrf+i4zifIKkrE8hqD/IafLpLsWh1JErnJVCM4GkpJUnJndY0cvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709993403; c=relaxed/simple;
	bh=OgtvMbwLgvKkeTlhEzE6OKj8nbECKsAfZ1ktwgRsrnU=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=odhvCPQpsNqIqvp7BOECZrueEQMYuOu1UqSP2gS433fFP5mXrvfgQo4rdn7vfKD5EGsW8SgLQEY2Zt/xn5MO2xdwweNryqfVOXzbjFmBMVt7NnyezDLHF6q2NIKMJmP3XethzISnoTGyngaNHcAy9FJIGiEsKoMeAdGXyqzK9zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CC2+hxPe; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CC2+hxPe"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33e76d653b5so1557718f8f.3
        for <git@vger.kernel.org>; Sat, 09 Mar 2024 06:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709993400; x=1710598200; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2eZuCOnsVQaHxWHlTqlvxvLjjlHCjEtEdBvI92A0cM=;
        b=CC2+hxPeqbz/XOeWc9FpcbxBCsNPMI0KjMmSb+5wAVW5B5PqB21sux5PjaIPkjIHMF
         jWjuZzYmtEFEP9Gy3xhC+nVFFK/JAH1tSjHTZZB7KiAek01cw/jqEm5iQ1Ra5SrnRzMW
         +0ciEKsGZT2gKodQIDBoXV2zdkvACh9ODMRzWkHgMkH5iqQ+YdctWhZt+LlIFZLttnnL
         Anv5yLywqCg2djVfUbm86Tqhc4qwsV/vXlnLYY6hFiBkC09mNlFmSlIUqwW17XAlXwwZ
         kc004eEbP9fQ92fOLTIK/IG8hVYcsOCNcdNGG508nQUvXNBnDUSPeQgZsdb3hC8xRVvX
         v8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709993400; x=1710598200;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2eZuCOnsVQaHxWHlTqlvxvLjjlHCjEtEdBvI92A0cM=;
        b=OmPzJQs35+J5Ra+0DR3/zZRBgk/G47ZG7D1MM5BgpcwBOsRMq3S55ZXuiSNFMA/thS
         eBrxEXZX/j7joI4S37BOhMEz/NR9QqI2FJTXvRWBrizuQEbCAV6NYe3lWc98RAPfaj9a
         fi2pCU4v6PqqifFOcvGGAV0uRHoivBToEkfvl6LiPkgutUI5loVJdcruYLuBffzrpvAj
         fQHuOV4+ksob9y9B6ML1jwlCabT6ZQHCXTSvApFsq62AtNFmuAkOyjHWKv60uOSYPSGl
         4yZwJfZxgEHNLG3BxWnmAuo1IvIresVGba7d/0x8HgM/RGbIe9C6P/yqRTxLOaPrXDRk
         x2Ug==
X-Gm-Message-State: AOJu0YwAXsBKUyZl2yyx/cfVN6QCjYUsXMw/5Kj8wcmK9mPp7+fgKfHU
	hZb/P0++aVM9xWvfcOfecBPEQDG4Iihp6ybCB8DvJY4SShIK/UbT2Ssi2718
X-Google-Smtp-Source: AGHT+IHxFKWYzQp8+RKzVLnCvNIwDXLlgx6jJWQVw+ZoJV/Vp++swrOeV+Q+RCOU7fB4eEv6IPnedQ==
X-Received: by 2002:a05:6000:b0e:b0:33e:8771:c58b with SMTP id dj14-20020a0560000b0e00b0033e8771c58bmr627133wrb.62.1709993399676;
        Sat, 09 Mar 2024 06:09:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h6-20020adffa86000000b0033e7a499deasm1904275wrr.109.2024.03.09.06.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 06:09:59 -0800 (PST)
Message-ID: <533df4c6659439d0a241a8b2e329c88d475d4136.1709993397.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1686.git.1709993397.gitgitgadget@gmail.com>
References: <pull.1686.git.1709993397.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 09 Mar 2024 14:09:56 +0000
Subject: [PATCH 1/2] merge-recursive: prepare for `merge_submodule()` to
 report errors
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
    Dirk Gouders <dirk@gouders.net>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `merge_submodule()` function returns an integer that indicates
whether the merge was clean (returning 1) or unclean (returning 0).

Like the version in `merge-ort.c`, the version in `merge-recursive.c`
does not report any errors (such as repository corruption) by returning
-1 as of time of writing, even if the callers in `merge-ort.c` are
prepared for exactly such errors.

However, we want to teach (both variants of) the `merge_submodule()`
function that trick: to report errors by returning -1. Therefore,
prepare the caller in `merge-recursive.c` to handle that scenario.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 32e9d6665de..f3132a9ecae 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1426,13 +1426,14 @@ static int merge_mode_and_contents(struct merge_options *opt,
 			/* FIXME: bug, what if modes didn't match? */
 			result->clean = (merge_status == 0);
 		} else if (S_ISGITLINK(a->mode)) {
-			result->clean = merge_submodule(opt, &result->blob.oid,
-							o->path,
-							&o->oid,
-							&a->oid,
-							&b->oid);
-			if (result->clean < 0)
+			int clean = merge_submodule(opt, &result->blob.oid,
+						    o->path,
+						    &o->oid,
+						    &a->oid,
+						    &b->oid);
+			if (clean < 0)
 				return -1;
+			result->clean = clean;
 		} else if (S_ISLNK(a->mode)) {
 			switch (opt->recursive_variant) {
 			case MERGE_VARIANT_NORMAL:
-- 
gitgitgadget

