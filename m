Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF3681ABF
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324469; cv=none; b=IgPM1JFwua4HgSf3BdHvxBbIYnNfittaXq9f3BsJFRmmjDaQeBx8ifv0D5I1J6FGkaBch9ZbGPYwR7CFKrae5jw0tV0Hhv0/3QqEJdsWS5WDVNPho/Mj63NXk07GhexJcoGVBFXWvnKOY7W+yV4d52ske5cvtu47uYiwgPmxKoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324469; c=relaxed/simple;
	bh=Xq7WRXhxo0C1kRAmZ99K0pnF6HJm4Bw5bwfBCsQ5cn4=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NIWusNHnsDa2xasj7nVX4n3xUjE1ISahRtItDQDJ2KTbs1+MUoLZ8XuYAe/r49NSogJktSWG2sFlP+BE759d9jiJNlWLQEbb5sHeGVH9iWNVc4ViWzdCw8xv1AKE/zqti7GKQCenncMMigKp3JFDtazJpHsqOHHmgYwagNbTC0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQ2JHmKj; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQ2JHmKj"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33b2fba3176so577930f8f.0
        for <git@vger.kernel.org>; Wed, 07 Feb 2024 08:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707324465; x=1707929265; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+i8PkXYJCTRN8cYGZeTF3cwl+HgYBrV1XX86X8PXc4=;
        b=HQ2JHmKjS3ROfqFrGs9gZB5eHpE9mFRdkvy5a4X4TqMEx5ddrLLvl2P58w1Y3P4jQG
         INcONOA4aCLLKrmyWqsxfAYN2EUdLHFByDJrrh8SkFFK4t2jESmG6YADVsGWoZjuox+2
         50/egbMfk7ipoeAL39gxcDra9If4BPQUIsMrohv/eLihvN00lvKBgmQfRPT2zrJqFzhm
         TSGLb2yYp2vfoInoVwr+t7bAmCl3Dlzk48b2XCyZrY5SPz7qwhB5NEC/zQx0P4JaDIJj
         PMUF7yBAbhR2WyeQywHOIRdGtygX5mLeEg+rI/WUugd689RU9iSv9iodWZPtv9AMrvT5
         98Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707324465; x=1707929265;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+i8PkXYJCTRN8cYGZeTF3cwl+HgYBrV1XX86X8PXc4=;
        b=dSXKq51r1CXXjm2cn81n1M/HZbWJBxSKj7OUspBm6HctCEKYOZyT2Rsf8MNtdmEOGp
         73EeRdiYTjUwHYX54ENNSy8W06DxX34qNZVdEqyUZ/MMQ5QMC35d/eyQ1aNQrSuRr9Ng
         zePRLuBoqs8wUTzZNZUsH4hBUSZwWsQaR5x5oprDmncH33xAEfcN3AV89mZwSpsnb8Yb
         j9Nh/quz61sTd0q4q0+zsw3D89vjJiTiko6ZSYWGrRCHOl2ws/HkmIypN4v2TdXwd6W8
         85yO6hesYiwW4enZG18+EZyYbM92imApNOxtvBP3cmlaSCpM3DWoFr4XUferCLDx+1FV
         h5Rg==
X-Gm-Message-State: AOJu0YxxHAaVVB0JThygAc/TMbSrFdxDdCXrHM3pKNGoNsJa82uy6kyB
	5mDtBzzVCHMKn7o0rHq1HMRdWplMKfb9s+DC5F/pn/sZq79FZtUcRGL8KmFv
X-Google-Smtp-Source: AGHT+IGhMwh5ioO0ACRW94H/Q/Tv6j7kkrH2v6N8tQ8KC6tfq+5q7Bkq7mfc0JFQ88B7iUjL9g9R2A==
X-Received: by 2002:a05:6000:1703:b0:33b:4e38:b878 with SMTP id n3-20020a056000170300b0033b4e38b878mr2935491wrc.26.1707324465311;
        Wed, 07 Feb 2024 08:47:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVjb0lD2b1pu/6TAnJENQvcRKFve8AOFjmK6C0pJbw7yAdtwnQYjsGbVEKJgefoCy7wEHkAssckvaKXHWNZav5RyT18tHor6JlLcw==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d1-20020adff841000000b0033b3d726d41sm1868402wrq.104.2024.02.07.08.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 08:47:45 -0800 (PST)
Message-ID: <a1bbb7e06e5c319e14e6a2a3b40680354aca8987.1707324462.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1651.v2.git.1707324461.gitgitgadget@gmail.com>
References: <pull.1651.git.1707212981.gitgitgadget@gmail.com>
	<pull.1651.v2.git.1707324461.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 Feb 2024 16:47:38 +0000
Subject: [PATCH v2 2/5] merge-ort: do check `parse_tree()`'s return value
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

