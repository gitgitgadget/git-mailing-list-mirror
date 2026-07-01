Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872CB3AFCE5
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 07:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889483; cv=none; b=qpkRAqg1uUhZGZ5+zpUSV9apupU1eNe/WxFGYqVXg3qenmSeBYZoDgBlY9/z+zobqjMkEM8g/WLAS/XydwmaAkZj/tGm/uFpnnN/jyO+j3L0nvsP3Btgc5T5qAua0YiAsyBPEbln1yPF8svCR6wAGmu44gDJG2kMHGxIjYSoQc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889483; c=relaxed/simple;
	bh=ULx61KFjRiz8ztCxJvoM710oeJ91oJlK5KV6bsa4a5I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SrcW6M51Ywm2scriKyp09YcIf4uj2+97/9vTfNcKppzpmWQbZoISx5Mxs840lNP6An3HkYPDNeWCcBCFC2wW5UAZc9k7gC7/f9v65TIi8dfkTmmT77uya72M7BDtTQOR0XdElLeHCxJjpZ+h5lrWQhfFuJdttNzgLgnvPtNaNH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4gRUwgZ; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4gRUwgZ"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e5cb052edso28187385a.2
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 00:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782889481; x=1783494281; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3RmaHc7Vng2Frkb01b4MmSdCz5j8c1AUvXwqnuGFRaA=;
        b=B4gRUwgZIMs8ACATKgJf82httYwrbZXqJ00htlLmkOqsGk59oRsG14TTLbLyth0I9F
         5ql1T+/VC5yr3+eL+sTlE5DgbTvtYwpg0jH6KejQmEyfFwkqng7pONfE9fPABDPHLaKo
         mh3DA4LkqzWUf1DdGLX1uYSgr2p6SryqGEnsxutWbCr5JK0FMgi3Eoo6HjcbsBVLGjTT
         6ygbZ7B59ZmHinUM03vA1d5ES1OJiPB5lzLL3jBXSQ6fsiuJKxWKkXn/rDb1I7gbXJCj
         Bj9vCQbfU/wm7aTNJD+JJdeNFvngg57URRUCbm8jNJkUVNHZZhY/zzuYiFYeR2Sl/FvC
         52fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782889481; x=1783494281;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3RmaHc7Vng2Frkb01b4MmSdCz5j8c1AUvXwqnuGFRaA=;
        b=fitorKinj6DaFoV8dyGe4EgpNNKMOMbzfqzPxImKO90EvwjZeMfJttnpyUL1jWRRky
         9WzgGJW+e9iNpFFf9P7m0TV/zr483tP2O/7mjBpmwIoy77MeIatrnCyWtvQIVgXo6AW3
         DA6q/5MXTbEuvSI2FZg4hrnO9M8a20GWRyOeoBs0zrVoCqBMykayx8nf/fTD4LRPUmvU
         d2TR5h7SRZdG2no7lZYD7wVZhxwW75WmVWsn8RNOahXEInO09tdgXIqpefKipxKo8enG
         sMguo3MHKY17M4RGSr16Qt45aKqCLisZMv5iXBN2TLDiIkCZAhfDbq7QvYG04Cln2k4f
         xa8Q==
X-Gm-Message-State: AOJu0YzmtjsGxu2MmnjLnuhXQjItmbEsixFsBX6vI5+Q/XPdMD1LPJ3a
	cPxkB+7FnzmSDAxnFfkV4QgnxnAyXe8rQG8AjHLx15/XKIR5o0oXIMTix/q8Cg==
X-Gm-Gg: AfdE7cmLkPPve3mfRmuDeY8U469++LfbABt48T8qAyXME4BNusEe4oqNwT0kKR1QHKE
	cVBS8ANPj6Km8WQ0krEI6VWcHGQMYvzWABS52gPhhV5xBVdflInHyVmiVEgVJoG5q5zYuG0+s0b
	wyKhNJD9csCrixnFk/TYQ27yaMuZba83QVesFETB+J7Wq5tqIRisArq7FFEQl+Ys3xTUSG0MxFP
	09A40hHjLjXSoAuuHnkg4mYKWgdNO8A0f2g4hgt1PyJmPs6v3cXqkFEXXJiHeE6hVnyoP2Jl9GN
	PO+r+RrjR3EHiIMjqKrAWnuKlrVwjtZooPbjsLDsKW6usAkknhcpLa4UdGQAQrguXsI5QDC3R+w
	3JwmAMQciyqgz9f+bcX5QT3Kfpi6LRlJMmeXovHs1EiCghezUEZPk9X81xJVMUTFiL/Yj9orkVO
	Z9J3D3/MG+7g3PJOVO
X-Received: by 2002:a05:620a:4005:b0:91c:ac0a:690b with SMTP id af79cd13be357-92e7825a4e2mr63662485a.17.1782889481534;
        Wed, 01 Jul 2026 00:04:41 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.44.231])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e622e8d9fsm486066985a.22.2026.07.01.00.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 00:04:40 -0700 (PDT)
Message-Id: <860bc8f52dc9be8bbfafcda296be831a1ffaf1c2.1782889472.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 01 Jul 2026 07:04:23 +0000
Subject: [PATCH 05/13] run_diff_files: avoid memory leak
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

In 4fc970c4388 (diff --cc: fix display of symlink conflicts during a
merge., 2007-02-25) a conditional block was introduced in
`run_diff_files()` that skips the rest of the loop iteration and
advances directly to the next iteration.

However, it missed that there was a similar conditional block that was
last touched in b4b1550315c (Don't instantiate structures with FAMs.,
2006-06-18) and which demonstrated that the `dpath` structure needed to
be released.

Let's fix this.

Pointed out by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff-lib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/diff-lib.c b/diff-lib.c
index ae91027a02..7ba839b4a8 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -152,7 +152,7 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
 			continue;
 
 		if (ce_stage(ce)) {
-			struct combine_diff_path *dpath;
+			struct combine_diff_path *dpath = NULL;
 			struct diff_filepair *pair;
 			unsigned int wt_mode = 0;
 			int num_compare_stages = 0;
@@ -164,6 +164,7 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
 			else {
 				if (changed < 0) {
 					perror(ce->name);
+					free(dpath);
 					continue;
 				}
 				wt_mode = 0;
-- 
gitgitgadget

