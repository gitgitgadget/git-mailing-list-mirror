Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D9D20FAB2
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 11:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743073565; cv=none; b=QisKqxtR/MiaTgv1Y017BNGUOS8KAr0t4M0itshcAotemWU039XGpjqSOctBWQQfD6oyUfqhUMYJMm8t15Qkq4N7qKYO+xQxS5IHUCN9TnAxAEFZFaTaZ4Z/YMVPcVxeJqZZXw5Z2qRT6qVy7T3Z3Nz5iS4BoSDIL1J9BTP4Vfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743073565; c=relaxed/simple;
	bh=A6EDD6PrTYfLdWpLfGjMroimJKK2hjRJguAMK9wyoUw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iGH3XIB31nwSmDdxk4hI/krGLr9nVGYTCWwsiIQL6oFB0WHiL0j7KJSczDIOqisjdTbRkawycSyXSPavlGw58V6o4BoiH0NBf44SF58ekKxoJH1nZa1swWRN/ld5pzT9Y71yqIbOYmqvISNAiSfwLxQoum9IxoWRp31UK0mARVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L01RsJXj; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L01RsJXj"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so5673495e9.1
        for <git@vger.kernel.org>; Thu, 27 Mar 2025 04:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743073561; x=1743678361; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMj9gIVSou/HO1jjw+eo8Yt7b8BGkqgVrcLrSAr6RvI=;
        b=L01RsJXjbe+qR54BFz29H4Ff6OFk4VFrtLvK+kABm4MP3z5CbZ6q7Vm3gvQQPE5QzM
         aboRNPAk2suTLmU+HOfVXVggA+5ptM4hbc3iNuR9qtlH5G/joeQpZernHgcTeYSL0fXn
         3ftoILI2IOMbzQY0m0efng6wphcfCKZdgM5ghMcf8jWAwgPGRJRslVQtGtntBF9MGQVt
         SobwHQhZb3GWSe6erFcTshu6DpsV3eipDnIK6AkgdRqsxLwI7k+PVvFLkEMBcUgVdxBs
         klPjNgehI2bsZMaHzkIJqUEpwHHX6jThAK/w/Ys6DfBDLTUTu55F99+GyvtoHtvej9DC
         ZaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743073561; x=1743678361;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZMj9gIVSou/HO1jjw+eo8Yt7b8BGkqgVrcLrSAr6RvI=;
        b=YvkUCoiDaW+ADPy+Vh+Bep9WE4jeCrPrHFDxW1PeFWxZzSootXS7nfaYabQelpyF/m
         eLpyBO9YethOUSaykuqueeiHo3atik2TkYWN1uM82ozDIZRaRtnRDR0WVynsvTfVKYgO
         BSzOxpc/8WqZjqKSwhMDT/byZ4Q75B6GA0d/9TQG6zYP4BuVqmsFe5dedmC/duzAcxoR
         liJBuX6EWdOEaVC+Y6w0Z8cTFb/AhrPPn60tGo3K8qJMK50jX6+TVxJ74xf3/ao6xJgG
         cOamINikXSRvWc8y63onFkdjbs9ZGe4KYjdhXUw4sxymAPcZo0nIxi+C/jw/Z64T/9/p
         e1gg==
X-Gm-Message-State: AOJu0YzmD59IPCrAk/qMx78ZgNICHxegh5VGAsR5ofr4cyPyVtY1hyNX
	mh2r655V8wxciNqVNJ549tdQXx8Gutf3Q3mJUEi9wa4NwpLKmW/VIYQxvA==
X-Gm-Gg: ASbGnctB0gXYELCbh916QYwl/bivgdIOqxAA1bnRUqcAft/WYH7kiIiwT7hgqLSr8/q
	ADOBinZ3wNYCFZr+TYDeQySeK70qyETFqfLy6y6D/aPsSsx0uUhDPIb88QjO+yt6NM/urzTwDbD
	hkTX30KdlSRQKvVUNsY8/jwVkjVzrp9Dkc+132mITdQzfMs851ZeDJLZ4PEiPgJ4sgx6tA7KXhJ
	hz6SS2JN5tLULlaIkCa/MazRkwdUXqlqIVikgIWPg+v/a/CWHC1E0JuEKth25KSbetl9HY6tbaR
	KpgLKr4fZTYimP3U24dvGM7SBCMogHVu82yLFviTE5lXo7Rq2V7ioaVb
X-Google-Smtp-Source: AGHT+IFbAmvhZ4YeoPD7Bm2+RUXkeude+g1rcRnVqNnf/9q6PapHomFXgFFh+Ml24tzvoWLS86A9Ew==
X-Received: by 2002:a05:600c:1ca2:b0:43d:5ec:b2f4 with SMTP id 5b1f17b1804b1-43d8d641ccemr2937735e9.10.1743073561226;
        Thu, 27 Mar 2025 04:06:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82deddd9sm34171425e9.7.2025.03.27.04.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 04:06:00 -0700 (PDT)
Message-Id: <73cae30129338cf219a810c3a2a78ef48d5637d0.1743073557.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1887.v2.git.1743073557.gitgitgadget@gmail.com>
References: <pull.1887.git.1743010011.gitgitgadget@gmail.com>
	<pull.1887.v2.git.1743073557.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Mar 2025 11:05:57 +0000
Subject: [PATCH v2 2/2] read-cache: check range before dereferencing an array
 element
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
Cc: Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Before accessing an array element at a given index, we should make sure
that the index is within the desired bounds, otherwise it makes little
sense to access the array element in the first place.

In this instance, testing whether `ce->name[common]` is the trailing NUL
byte is technically different from testing whether `common` is within
the bounds of `previous_name`. It is also redundant, as the range-check
guarantees that `previous_name->buf[common]` cannot be NUL and therefore
the condition `ce->name[common] == previous_name->buf[common]` would not
be met if `ce->name[common]` evaluated to NUL.

However, in the interest of reducing the cognitive load to reason about
the correctness of this loop (so that I can focus on interesting
projects again), I'll simply move the range-check to the beginning of
the loop condition and keep the redundant NUL check.

This acquiesces CodeQL's `cpp/offset-use-before-range-check` rule.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 read-cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index e678c13e8f1..08ae66ad609 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2686,8 +2686,8 @@ static int ce_write_entry(struct hashfile *f, struct cache_entry *ce,
 		int common, to_remove, prefix_size;
 		unsigned char to_remove_vi[16];
 		for (common = 0;
-		     (ce->name[common] &&
-		      common < previous_name->len &&
+		     (common < previous_name->len &&
+		      ce->name[common] &&
 		      ce->name[common] == previous_name->buf[common]);
 		     common++)
 			; /* still matching */
-- 
gitgitgadget
