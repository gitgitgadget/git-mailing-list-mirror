Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9672877E3
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 18:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762192917; cv=none; b=PfPQEKIIU/lsU0wBV+vgkQId0o6pyO2ICiPrC1inEXphna+PYy2lDzZxwtfCsFvSG/Fn/ZXGhWSRX5AutLxUXVUvQPeXtChGP0z8/VwUNzZEhcAzQahHQQc9hjT/kpsGqRZP6S3s6MlidsR2SThqbNO2jR6jfBEMZ/X4j553LBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762192917; c=relaxed/simple;
	bh=pVPyRwWlb6S/Y2hsIiCHW/TmNCgYNUPJBHCMWw5RhRw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=siNuxZ2YVk8Wb08uh0rEjXYPbuvbx9a3DlHnVGpqjO5jfonMTCqCcr8k7ibRJcrlrzRwkqKDeaDJxMLjGeGyuigt2wegcxjRZ6ODI7RTOwIHL0wSvcy55w7ArhAoO1puGZsJg1y3oJlBV0cRPhvZOeNPJ9zoJlddPUyRkjuek2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sf+1tJDq; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sf+1tJDq"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-81efcad9c90so55922496d6.0
        for <git@vger.kernel.org>; Mon, 03 Nov 2025 10:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762192914; x=1762797714; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vq3mni6TPQaDpp+EoKTznavtrLWT3xNFw71ZETwYjKE=;
        b=Sf+1tJDqjDL/bes7vKISlWUrjgRQonZABogggjEcjo5CJZpRafd9R0jIVILI/ZgNOe
         rxsv0EfptQYBxz6r/5hmXb0Xv2yvqP+FkA8vp2PmzQ765XvccFGILXfSbuLRkNptn6SP
         Eo/4zJ1ye1LTno045G29FpDoBBxU6PC8aSMBE5AUGDIOpR1Jj4dtCToUB8+UfkxUqwW4
         AuNwx65M4TOm23oEPZWD0zbO5OmTD/HY8mT7orP8W6+WKcMQXwRs+0k43aJnGrcY3u/h
         vlKpLwxYOEXwTFvLYdZZ69y0/kuszY/ISNzQ5JCyUi+GjxiW/i/5gaqjc9oK5oGXbMea
         0HGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762192914; x=1762797714;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vq3mni6TPQaDpp+EoKTznavtrLWT3xNFw71ZETwYjKE=;
        b=IJ3/b4xFqKr8nOOLS1XG/zt0Yh8rJ/xw1M47gMXvYpb3FkI+yxzhvOXbl+9sqY+mWk
         y9kHJVCQUj/tgoli7XprQ73UrAiADqmjClRgLsOEhIvCs9dHEPLBU9rUb5tUsB/ZuT9O
         uXP8PbfY9jAq5XN/+Guut3H4Zr/VYZkGuDabL7c1H3xV8+7tA5L2ozHgkRSFKm19UKTn
         iJCVBlGbr7jmwponTplhI0ZVY5+ViBEEtF9PV8pgTsGP4SYv6KEALzKrXaOBAALskp4e
         k+khif/13u31bLl1jeXaaLQ/tu75ENgbF8g9FZZIC3OkkW6m0LXRYwsUtuCEW8kRVCjw
         Rtaw==
X-Gm-Message-State: AOJu0YzTlSKi6dyA53qj0EoTWR7bmI0BlUCJgObdZvJex12/Xv137PsP
	/sKqAy9oUTBub2oJEN07qhqEwsZcHg8Ea+VEEsMWgA9JX0xvre4std5vsic9xDGd
X-Gm-Gg: ASbGncvTuaZTLJTGCMuUufvWKa6IwKoLtcuaA/rPEHgkN86EwM1e5R/dRPeWcqOIUNU
	0rTrPOTa8jWWFnCfC97DmHODl/6lg7m9yn1pBrCzcIH58eOfKKoyYZ59vm5CK1PSW/co1nRGsft
	qcGggZ6lNcT9YcX/hQaENZrddx4w+eowt8C98E10D7cgEgCrRZ7KEsQjs6au/vm5EUA1c1Fuya5
	AyL9bMLfsOKzPzLMmsVcJZrtzL9urkgNNc/VODFf+ZgBmqwAwA5pAT8qb8XInnwppRUA4aHbbuE
	nsQl5QQRmJz0ovDSI0b6b9FyvB/mWixfSWYkU8E+ZBwLT7QEPc0Z5075FykD4zo94EvacekGmv3
	8j0jpanenq+bvNLxjsbIPPEwaHlODvVVCdZlhCSfOj7DEg2U5Rdfepjkk5us4iS2q3E+jxwMquU
	UAd3bn2mvITy5QHg==
X-Google-Smtp-Source: AGHT+IHRMoEHJAkrgWK9qaOCcS6awGyt83V2BMzFma0wn5e4L288RHpEXx0cmKX/2ku6HRtxH6wjtQ==
X-Received: by 2002:a05:622a:198b:b0:4e8:b979:c7ca with SMTP id d75a77b69052e-4ed30dcfc90mr184512801cf.18.1762192914037;
        Mon, 03 Nov 2025 10:01:54 -0800 (PST)
Received: from [127.0.0.1] ([145.132.100.68])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed5fabb398sm3051611cf.2.2025.11.03.10.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 10:01:53 -0800 (PST)
Message-Id: <bbbf2971ab3d70c1d455973c4a1f24b407a56a1b.1762192908.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1992.git.1762192908.gitgitgadget@gmail.com>
References: <pull.1992.git.1762192908.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 03 Nov 2025 18:01:47 +0000
Subject: [PATCH 2/3] merge-ort: remove debugging crud
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

While developing commit a16e8efe5c2b (merge-ort: fix
merge.directoryRenames=false, 2025-03-13), I was testing things out and
had an extra condition on one of the if-blocks that I occasionally
swapped between '&& 0' and '&& 1' to see the effects of the changes.  I
forgot to remove it before submitting and it wasn't caught in review.
Remove it now.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 29858074f9..23b55c5b92 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3438,7 +3438,7 @@ static int collect_renames(struct merge_options *opt,
 			continue;
 		}
 		if (opt->detect_directory_renames == MERGE_DIRECTORY_RENAMES_NONE &&
-		    p->status == 'R' && 1) {
+		    p->status == 'R') {
 			possibly_cache_new_pair(renames, p, side_index, NULL);
 			goto skip_directory_renames;
 		}
-- 
gitgitgadget

