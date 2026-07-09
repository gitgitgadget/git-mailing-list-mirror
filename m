Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946013F2108
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 09:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590174; cv=none; b=DqQnxOhwhOf5nrntBz+M0BkCdEC7QZzxCShQ2boVxeSqqrrcY1iMtnXD5uXsYaqVa3fnGPZewl+b8g4rD99l3qQUKLf/84mm2xHwwS3w46NA1jGDRkURC1sY9yoAl+4wtkVqXllxifKN8cB3SasOgJ+3cesqajtXQWcJknxJRYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590174; c=relaxed/simple;
	bh=WAxShR0w8gKQfjJ91ZwViTAI2DoYiX/ro1ouNW0ecmE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Odi+itHhCgrRgI68jK4uI3rTRcJywrdk4FlVeHon2n6sQKu/dn+xKbKdRoRlQnJNNDsXSoels86QgxSpNQIteoRb4sKguNeOQU74gH28SPxYjrDEh6BMj0pPrcv786mMjq3JPrrq0OkHBLoZFI6UVd+6Zor7gGad/nVr6hjEHiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbDxxtjI; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbDxxtjI"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e855da580so129469285a.1
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 02:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783590171; x=1784194971; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ogkcqj0nUCKjt4z7HnkC+YFq1ZmeUss5+VCkLH7JXvM=;
        b=JbDxxtjIWeAg5E2xaEbViqd2KLZ2qLF04m/8j2ijbyv+GPAipCJPbTez4JzNBGF7sf
         N/1Xc98BS2LvJpfXb1/ALI7Pn5/SD4/ZuWL9JEWbsPQGyZ3O8/hYZZ93j3vIZTJ7RYcV
         zCl8tbyrnwuohirNhNonYwkQHOVo2m32K3K5E85tNBHCnWQ7IyAMk+268wkbF2M4K09c
         FKYjrUcZZdoxtrFNBi7yHg2w3dgy78Ln3hOoL6Fx4Tpuxa8AMceLhEnb2KTQgG03BZ21
         WkaJFcYMJfdIRF5tWPGBq1BhkBk4iA2pmf7C+uAharhWSNIZPzB/ZMiBrhg5oP0gc369
         ibZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590171; x=1784194971;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ogkcqj0nUCKjt4z7HnkC+YFq1ZmeUss5+VCkLH7JXvM=;
        b=pburObIWa78c3TsyEmV01clQho8Aagz/9F1BOCNjTFHOUVhohvSH7OKwjz1Jgc/upw
         woCrZnvFqYL/3Xg4TvTITrFsoNQfHCy+rke7E8wpKu7pwneA65TwXtcOmf5jCpSMY/jz
         /48nhriqTRTSJFQxK4y46Z3rTQlp9JJ2+DV4E83HJbmjg28opKjxb2I3rpZw53BEZn1S
         OnD7wHq3f2982vOQvj3zwSOvpgSvucfyXZzx0fFnfvIHc05cFR4/jqxMeoQCDdFrc6Hc
         c3WALQAPuioOzyHNOzAAP9JL1aqSDyRR/oNsm2NRNKceZg2cMZlhbpK+nbcuuRL3XpW3
         EpEA==
X-Gm-Message-State: AOJu0Yz5+GWuQZcOoY7WOa9V5JgkgheGEMCzKOJB3Lyd/vzbGKX/TZHM
	Jptu1eJFgMzNq/Penz0ad2Y/riAJJ6G4UoCJZXrWgMOKJVo1qEv7TMR9VWio0ECj
X-Gm-Gg: AfdE7cmLMw9AXmQFtuqFRCDiy2AxTBAPWCqOOwhsptMUZrnDp4lOWK6eD5Z/hYaXjgo
	nW2IUHGa4hKtNDkGK2JwCuliO1c2/0dtF81QnL5JLpN+CpqF+cQ4dkwYyhpLPmRj/U7sbJ6EILj
	EG9YYKPjJZpdsI9fOPzfoXCkSr3kGuVGU8KTge4fojNxkMgaQAyQhqjl7frT/ZqpqLc7a5htaFy
	jZH1fy786wDIga09ocVSqU1Vb1YlcSvYMH1eVtrIc1e/wvbyQu0daeBXCj2K+sDvcA02dzRM8cv
	Qjii4mu47Stquoj4eMlNwPL3p7J1oS6UWrOC5JBXgwBA8uIPSuBy2OZLGSdvW8ZaOHGnIYrywuI
	9gEdMYjn10FlstCyWTQqC3EX61a6pdtRJNA0rCnasMR/1LmI68IDBk6M8Ihq5LvIwLIWV6qw4Wv
	gEOXzJDOfJJUQj
X-Received: by 2002:a05:620a:404a:b0:92e:c117:9ea4 with SMTP id af79cd13be357-92ecf8fd18fmr640761885a.82.1783590171545;
        Thu, 09 Jul 2026 02:42:51 -0700 (PDT)
Received: from [127.0.0.1] ([20.84.47.35])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90ce5126sm1617174985a.41.2026.07.09.02.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:42:50 -0700 (PDT)
Message-Id: <0b27860478a284719755b8ac2386862c1fc3d0e7.1783590159.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
References: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 09:42:36 +0000
Subject: [PATCH 09/11] pack-bitmap: handle missing bitmap for base MIDX
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

When `prepare_midx_bitmap_git()` is called to load the bitmap for a
chained MIDX's base layer, if the base MIDX does not have an associated
bitmap file (e.g., it was not generated, or was deleted by gc), the
return value is NULL. It is then stored in `bitmap_git->base` and
immediately dereferenced on the next line.

This can happen in practice with incremental MIDX chains: the base MIDX
may have been written without `--write-bitmap-index`, or the bitmap may
have been pruned while the incremental layer's bitmap still references
it.

Check the return value and go to the cleanup label (which unmaps the
current bitmap and returns -1) so the caller falls back to non-bitmap
object enumeration, matching the handling of other bitmap loading
failures in the same function.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 pack-bitmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index e8a82945cc..ca7998c10b 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -523,6 +523,10 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 
 	if (midx->base_midx) {
 		bitmap_git->base = prepare_midx_bitmap_git(midx->base_midx);
+		if (!bitmap_git->base) {
+			warning(_("could not open bitmap for base MIDX"));
+			goto cleanup;
+		}
 		bitmap_git->base_nr = bitmap_git->base->base_nr + 1;
 	} else {
 		bitmap_git->base_nr = 0;
-- 
gitgitgadget

