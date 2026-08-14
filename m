Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AD63644B3
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 02:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786673191; cv=none; b=ou8ukTEf1NQ8ag1UmzCjMc7MVxbXhK71T+UQhZ0Py8csUj9njFh6K++0Iv/AfwvUhaAHgkUufE/PzSfcze+0Q1AUXLMq8sYttsPSrPJWL7ZwGBSDzGyKcbSEZ/Gy0thIdtrOAyqqlRqQjj6BCw/0mALOUjWwSJUIu6UfV/yH8+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786673191; c=relaxed/simple;
	bh=/NO0WGCpEhTSdBmvVjuK7VsyOr7yWhoVGB0lG+mJG+Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Kk6FkglV3hwqcTDgjJz0lFtHV5dISKOJpsZiBZaHFPA1QCLrDFJCtbUS4+g7Q9aqF0OgfHpkIGmpeqzw/9TUg7NqCCpcH9pQB8qD4spFoQeHhI+PQFrRrIxgPVX07dG0QDaSpIVUe1y98N5Cf7apWegslvkOkvROECBMyg3JX/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kK+ywQo2; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kK+ywQo2"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc891373e0so8197665ad.2
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 19:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786673189; x=1787277989; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XZa00Wg+uYZvXSRJZR9d8XmeLOfclZfkMH7fwLGDIYg=;
        b=kK+ywQo2StTPJPSKPffmNuinVx6x4/stOtrD37e4rc+TvxqAbNtaGAxpeu//6U+eFY
         1tHa4tXELcLdB1WAaP7KN1WTRhWVZt9AL4SFMEFQ2VIbZkZD2lgoBYCQLy5zxbDp9+J2
         YdZbDeiCdd5TYxBoy+Q8KqgzEPRu5MbVfC+UMdYfHAnaM9/JCgC453SVo1rZoSUxlEC+
         DavLu/jmxCshs7qeLfQEjeum3QDHeP3wJ3faRy1tH7JqI47S1mhXFawEG0HU6azxPVnz
         B0CglaAcWhypunO10UccKrd3RQ/XIV8fvMhQ7I2MiU5uPd5Mt7MaSttV2hpzpWukCft9
         zN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786673189; x=1787277989;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XZa00Wg+uYZvXSRJZR9d8XmeLOfclZfkMH7fwLGDIYg=;
        b=IkSrvUw7fgS4K1zSCTTr0GJS/cxsUKZXRYdpfSHXJPCgWd9ZdG79uQtxg6jNl3AKsV
         gXdqbkBB/WhVuiKwXfusvWffuRR6udmBNDaAtjH1mnVbkHSoe8kw2DRyy8gEH3DmdRuM
         qDyZXUjaQIUAkWFRpp1uK7uLFfpA7F+6j2fMsWt+YcOMFNNIsU448YhPMhidLhc2TJOa
         2N3nbWEfUHPrgNhKbXMb5LqL2MHgynqj1TESjgum5Ho4tunIkH3QTvgfwLr8sm+XMXGr
         z4oH0qPdiBfpeo689idAqWQjWU3zq3hXobVqfEJM7vpV28Hk4jFOWoM1hcEoDFGv5ak4
         2Jlg==
X-Gm-Message-State: AOJu0YxDPVs1WIGkCugVf/0fWcPA0IHE8imiyLwdfXcMM5EWvamayu9L
	ICKih2us/R9BT90kvdWTmSjYW1VwvVWDOHg/85+u5yAP+WiEBb7js6qzF8TTGA==
X-Gm-Gg: AR+sD11MOuSjnXP37fVdkkCRPcIAhzRCb8+qrvzLpEWcbjHbcC6GzGpMNcix88EDdtU
	rFrsdDgM1+QIY1HxSRLgTgpEUvN3YwMjPvMcl2F5opDdJPOBtQYGlsTH3uOMCVp6XJ68m0VCX27
	conHPop+9eh3kyKJUta3wSAUh7A1o5IAV37jj0HaRkIkVDsflBneWmnZ+A+rrjByXGxZO/0WFMv
	ZQ9YWyX/hErTjxE3ygiEYsMjkHz1MsACQf5JqBRnzXQsg7aMhOp2SvVZSbXNnYMOCcgnYbpaPnF
	ERq1gBW5/OdgkKyGOmrGGXkbKypJoEYLoK/UkqJQF6TLg0vIa1kdD5XCH0YiluI9bPr6qhrnqyf
	T3BQw4ioFQmooosl50t+dSplmbuqn9FGeYs5SDR/5ln+LeIh5V8XMAIUNNfeB2sVFbVbmaf11W7
	DhXOZMgPwFG2GHMMTqPpZB6+z2mMoJJ674lgt1bB/78maAn0MaDTDsNnDW7QBEEA==
X-Received: by 2002:a05:6a21:600e:b0:3cb:b2e6:9032 with SMTP id adf61e73a8af0-3cc71d55f44mr2461168637.8.1786673189427;
        Thu, 13 Aug 2026 19:06:29 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.162.7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ebfc3ca41sm13069476eec.21.2026.08.13.19.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 19:06:28 -0700 (PDT)
Message-Id: <pull.2035.v2.git.1786673186855.gitgitgadget@gmail.com>
In-Reply-To: <pull.2035.git.1786516958048.gitgitgadget@gmail.com>
References: <pull.2035.git.1786516958048.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 14 Aug 2026 02:06:26 +0000
Subject: [PATCH v2] diff: avoid misleading statement about -l option
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

In commit 6623a528e00b (doc: clarify documentation for rename/copy
limits, 2021-07-15), the wording around rename limit options and config
variables were updated to point out that only the quadratic portion of
rename detection (or "exhaustive portion of rename/copy detection" as
used in that commit) was limited by these options, because exact rename
detection and basename-guided rename detection (which both run in time
linear in the number of files) still run before this limit is checked.

However, the short help message wasn't updated at the time; update it
too.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    diff: avoid misleading statement about -l option
    
    Changes since v1:
    
     * Fixed author to match signoff
     * Simplified the wording a bit, along the lines of Junio's suggestion

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2035%2Fnewren%2Fdiff-l-option-doc-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2035/newren/diff-l-option-doc-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2035

Range-diff vs v1:

 1:  6253e1dc96 ! 1:  58729a71ce diff: avoid misleading statement about -l option
     @@
       ## Metadata ##
     -Author: Elijah Newren <newren@github.com>
     +Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
          diff: avoid misleading statement about -l option
     @@ diff.c: struct option *add_diff_options(const struct option *opts,
       			       PARSE_OPT_NOARG, diff_opt_follow),
       		OPT_INTEGER('l', NULL, &options->rename_limit,
      -			    N_("prevent rename/copy detection if the number of rename/copy targets exceeds given limit")),
     -+			    N_("prevent exhaustive portion of rename/copy detection if the number of rename/copy targets exceeds given limit")),
     ++			    N_("limit to cheap rename/copy detection if the number of rename/copy targets exceeds this value")),
       
       		OPT_GROUP(N_("Diff algorithm options")),
       		OPT_CALLBACK_F(0, "minimal", options, NULL,


 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 589c1969e4..c593066592 100644
--- a/diff.c
+++ b/diff.c
@@ -6186,7 +6186,7 @@ struct option *add_diff_options(const struct option *opts,
 			       N_("continue listing the history of a file beyond renames"),
 			       PARSE_OPT_NOARG, diff_opt_follow),
 		OPT_INTEGER('l', NULL, &options->rename_limit,
-			    N_("prevent rename/copy detection if the number of rename/copy targets exceeds given limit")),
+			    N_("limit to cheap rename/copy detection if the number of rename/copy targets exceeds this value")),
 
 		OPT_GROUP(N_("Diff algorithm options")),
 		OPT_CALLBACK_F(0, "minimal", options, NULL,

base-commit: 2c78326f810173a4f3aefd8021f1e07575412481
-- 
gitgitgadget
