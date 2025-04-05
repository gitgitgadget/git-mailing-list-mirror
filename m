Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CDC1B423E
	for <git@vger.kernel.org>; Sat,  5 Apr 2025 22:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743891384; cv=none; b=enGbsGT8mqWrY8bay28lwgr4js37Lmmpm7qfuUs213FD4cosxRZ78wevYutLv3Li4GqxVBPXv7/e0taFw1//cmNddEYkdMKa5mr+hQU0rOrIuh74xubVt3YJJE8C1y0czCi+UAiep9nVkTleUu/LVrvjSG9Xh/r/pT2VpoAR/sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743891384; c=relaxed/simple;
	bh=9WE9DHCrkxclAtRxyd7r8TgKdnzJmkBcxj45LhpjGFI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pjuqqGnRJ+JPkNCF9NY56Nu+/Q/o976RATO6qwDYpjyCyBlM2H92MgO+xnvRAtIMMnRhXaKB6dvirQLMw7bwhCQnollAVnh+EhWRZrWd/we3/ZALqoT7oNeqRYArQHas9RYznr/zC8RLGW5MRa2n1VrtCwy8/ckEFWre0AmFwBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHfBYM3k; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHfBYM3k"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso34151065e9.0
        for <git@vger.kernel.org>; Sat, 05 Apr 2025 15:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743891380; x=1744496180; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lojPv5wdaz2eIF2J+eBFJD2HNxvZjKfzpRO9tMry/Mk=;
        b=NHfBYM3kBQSIfljL+X2ACRRFqCup5W+aZmuCAMEqgf73is9sPEOA/u/cQED1Nkp3zv
         +J16q4IRP4S+APsFqsb2BxF3PSDm+gj7EcVLVDmqZ06Y7Tek1Skoj3VacKid2j62N7Bn
         lC0wfBQl+RCh/l4NNWNa04qQiBvgVIMVSS80nzPtYuxuGXvDDYHDc/Q8c0dyk8VWT3sb
         33zSa7vy895cTB6CS8k/cLt3X6co07YLAMcowuG43xCWhK5fxYOzyJ/yPA1IXx41Zm3V
         0SMAt9SatCAyyPWdeVo8HKKLbz6Rj4mP2Jwle69De8Q5wlJ6UYpuI7/GsFunKOywbWNT
         bC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743891380; x=1744496180;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lojPv5wdaz2eIF2J+eBFJD2HNxvZjKfzpRO9tMry/Mk=;
        b=in5EcnnQ4XLcKxDVGUje4Hs1u42r+BRcTkOXqm+wdjr1NfGHRS7SM/vsG88YDvinb3
         X7/A2whH+SXuJv5RnZOkmQNtjsWiuZQ/8PmR6XjOWQ/x0OeSbYxP6AU4+1xzpAMxJlux
         57Lbk8dpItaLUy/9MiU62tAoxn6K2KmgvQWiX383h6hQHrz95EkzmkYJmFajNGgs2JBs
         2G8dFnH/+f9FCHRGGVMYqVpmUFgVvPc2fYEK0WjD93VBLT06vbdHa4HSB2QlktqaX3zx
         TIHiypNBJdMeJMfMCC0T6n2bAuCSiVGC6WCsbes/UI5bT6Uksx94zCybh3RcYSBWKeQu
         4EPw==
X-Gm-Message-State: AOJu0Yx55kT/RFEaqYIZBH4GE3D+BVQuQIyQy4pJA5or2fRWw5rksTJr
	o6eB6l4ff9bfmEbiq9J0lTjfswsXvseT8WdSU0UBkKr8Al4nk90jwWPqIA==
X-Gm-Gg: ASbGncsURxGJh7vlcq7Zp5+9d/ja74XGLdHVZcX/0Xnnox7fgGABdYg1wlVWmWU+8/L
	EEpc3d39C4xd1ihzSBUtqD7/CEKbCRHGG3JE9UkVx7lI3G777l1XGgM2hrJQ7MCRdnOz8291FES
	z6KH4jBbADO3xP2Gjuaisvpj8ej5EbdIUp4xAsfOaMhyIj63T+KX9cnHCG0Is4r/tqA61IKDex9
	dkDlyO+0kz7thtFDNUVnm/b1a+vyafgOsr3BkD+1j4PDiPji4pPrEX5WZd18Rnh+7ZvsbTn7xBL
	9gEbuM9loEzSdkqMI9USnMqYIusS1NY2U/6z1ntcxJHIIQ==
X-Google-Smtp-Source: AGHT+IE4oybEontc7irBnlDVZFgbm8xfGOGnie2pM3YxEOTcbLuaLTPVU6KZI8Pf0Y2oOyCn6JomiQ==
X-Received: by 2002:a5d:6d8b:0:b0:390:eb50:37c3 with SMTP id ffacd0b85a97d-39d0de25f88mr5999061f8f.27.1743891380325;
        Sat, 05 Apr 2025 15:16:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301b69fdsm7822471f8f.48.2025.04.05.15.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 15:16:19 -0700 (PDT)
Message-Id: <cf774437123722d6065139573b49c3e09c6c135a.1743891375.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1898.v2.git.1743891374.gitgitgadget@gmail.com>
References: <pull.1898.git.1743436279.gitgitgadget@gmail.com>
	<pull.1898.v2.git.1743891374.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 05 Apr 2025 22:16:09 +0000
Subject: [PATCH v2 3/8] merge-ort: enable diff-algorithms other than histogram
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

The ort merge strategy has always used the histogram diff algorithm.
The recursive merge strategy, in contrast, defaults to the myers
diff algorithm, while allowing it to be changed.

Change the ort merge strategy to allow different diff algorithms, by
removing the hard coded value in merge_start() and instead just making
it a default in init_merge_options().  Technically, this also changes
the default diff algorithm for the recursive backend too, but we're
going to remove the final callers of the recursive backend in the next
two commits.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/merge-strategies.adoc | 29 +++++++++++++++--------------
 merge-ort.c                         |  3 ---
 merge-recursive.c                   |  1 +
 3 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/Documentation/merge-strategies.adoc b/Documentation/merge-strategies.adoc
index 59f5ae36ccb..8c87dd70210 100644
--- a/Documentation/merge-strategies.adoc
+++ b/Documentation/merge-strategies.adoc
@@ -87,6 +87,20 @@ no-renames;;
 	configuration variable.
 	See also linkgit:git-diff[1] `--no-renames`.
 
+histogram;;
+	Deprecated synonym for `diff-algorithm=histogram`.
+
+patience;;
+	Deprecated synonym for `diff-algorithm=patience`.
+
+diff-algorithm=[histogram|minimal|myers|patience];;
+	Use a different diff algorithm while merging, which can help
+	avoid mismerges that occur due to unimportant matching lines
+	(such as braces from distinct functions).  See also
+	linkgit:git-diff[1] `--diff-algorithm`.  Note that `ort`
+	defaults to `diff-algorithm=histogram`, while regular diffs
+	currently default to the `diff.algorithm` config setting.
+
 subtree[=<path>];;
 	This option is a more advanced form of 'subtree' strategy, where
 	the strategy makes a guess on how two trees must be shifted to
@@ -111,20 +125,7 @@ recursive::
 For a path that is a submodule, the same caution as 'ort' applies to this
 strategy.
 +
-The 'recursive' strategy takes the same options as 'ort'.  However,
-there are two additional options that 'ort' ignores (not documented
-above) that are potentially useful with the 'recursive' strategy:
-
-patience;;
-	Deprecated synonym for `diff-algorithm=patience`.
-
-diff-algorithm=[patience|minimal|histogram|myers];;
-	Use a different diff algorithm while merging, which can help
-	avoid mismerges that occur due to unimportant matching lines
-	(such as braces from distinct functions).  See also
-	linkgit:git-diff[1] `--diff-algorithm`.  Note that `ort`
-	specifically uses `diff-algorithm=histogram`, while `recursive`
-	defaults to the `diff.algorithm` config setting.
+The 'recursive' strategy takes the same options as 'ort'.
 
 resolve::
 	This can only resolve two heads (i.e. the current branch
diff --git a/merge-ort.c b/merge-ort.c
index 2b7d86aa4ec..14a7ae4a6bf 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4957,9 +4957,6 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 	}
 	trace2_region_leave("merge", "sanity checks", opt->repo);
 
-	/* Default to histogram diff.  Actually, just hardcode it...for now. */
-	opt->xdl_opts = DIFF_WITH_ALG(opt, HISTOGRAM_DIFF);
-
 	/* Handle attr direction stuff for renormalization */
 	if (opt->renormalize)
 		git_attr_set_direction(GIT_ATTR_CHECKOUT);
diff --git a/merge-recursive.c b/merge-recursive.c
index 884ccf99a58..f3df127ad9b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3981,6 +3981,7 @@ static void init_merge_options(struct merge_options *opt,
 	opt->renormalize = 0;
 
 	opt->conflict_style = -1;
+	opt->xdl_opts = DIFF_WITH_ALG(opt, HISTOGRAM_DIFF);
 
 	merge_recursive_config(opt, ui);
 	merge_verbosity = getenv("GIT_MERGE_VERBOSITY");
-- 
gitgitgadget

