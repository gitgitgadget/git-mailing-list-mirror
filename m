Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7E730DEBB
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 08:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763366677; cv=none; b=cTvXwStTOquPYZfMzaYOjGDX4raT9AS8jtMr49hS+eyu8rZT3WWsoFzQFSlbjmlnuin1EqO0pPS1xH+AGZa31eeN5Jibrthmgk4hXq+2Wm3AWuwJnpvmX5Cj41JllyeNI9j+zypnIsrsYi/PBGXNiehVup9F95zx3sy6INQpbrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763366677; c=relaxed/simple;
	bh=fFweqr5SwohRUIeCz5iYVK/AmJ1fZjgto8nBs3EAX84=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hcXPZ9lD1Pal/yweD3JSRfHpb6Df0+9jsfmfmjxMdV0AqLC//nIf8GluzqKN3sCm3O6laDh4lkk5M7qRITp2MPpRi+9An+JoZ4U2DmyKRVZCuTS841pUlSqNI1Tmge2BijDoVAaUHINymMOqBdtbQvnj7aRLaKIqqhq6zJLzrmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkKi/dia; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkKi/dia"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-bc09b3d3b06so2232644a12.2
        for <git@vger.kernel.org>; Mon, 17 Nov 2025 00:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763366674; x=1763971474; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2QesKUgKPfnkbAQZhwQI5a/Ukgf2Zi5Z+zJRBmqfLM=;
        b=UkKi/diaJjsgZUc2HuLl6C+ndiC8hq6nwUwEBoNVKtoEvlPYP+4waLfUW6Ixm4FRA/
         SgpEp6Mj9DZy0dTPjo6+EreDeMgVHCjTfkTzh9052qMg8jP8rvYQAhl8ADEzq+AFHv2W
         bAriO+ItNyI1jdDp5Us9QQNs0L+IbPzt/38bx95fEfKH79wDRVPcgfdUjt130fqpdL/v
         Uvb1Ul53RJx5YSQ0XkFkmnzrimquSd0Ef5YGA0uf52MHGq7P7TjzFVPfPTlPGkJyzSB6
         TiCG79K4L7dlcDmYUJlsmYn36z3sf4ogQ/ehBAcWHA501AgTF9CjPNX6NsVXd5XLrdzZ
         uHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763366674; x=1763971474;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s2QesKUgKPfnkbAQZhwQI5a/Ukgf2Zi5Z+zJRBmqfLM=;
        b=JeyjhD6hX2kni4RlYIqV+qyVB4arIRU1//evEldECNTiSdPaHqmy3TMoVRptuvStpC
         +6URVJwZcHoDTMiH+1lT2AvK/bunjVHnD3y+FYuc6Scy1+XA/Yh7le00WEAJvN45l8Mo
         EaBmTDHq4KYmeAcDG+YM49aumehtQ2RiRaD1w0k+IDJ6QflEp1HZX1R18cxmSnw246yq
         8n0PY2M4KFzME0ZwGSli+pLXfFUG3vu6ryO4iJxPGvf5f984DjWMxNpqgRxiNoiUr6Jp
         4KsrIpmPmZbu4uo5BPIi8e4RDgOaNbyFFjAZTEjKU/CUprnjRfbhgFFdqRt6vHIMBr4Y
         JXuQ==
X-Gm-Message-State: AOJu0YxlBP7rkjjv++wSwWZ78At2MccplihYjdMhC/Gf1kWrhV6CdEr8
	wkoWZlQRVRWimdHOcOuO2tcd0DsMFvGNqvwq0c9lqe85ZwGt2P6e3/VkeB+lFw==
X-Gm-Gg: ASbGncvdlihmjHH8kqnEcJBg4Q/3Cf2m5A1xk54itK8LdsMAcivOpkQZM2nNCVnxeYb
	SPXOzSpxLHNUuU+wlrLeExckR7Z4wmdJ/KZSoueYiC+s+81icOQUHtr6EHvmEPk05GmFfA2K6D4
	V4T1mjo3xUpOm+9P3t4q6hjq410X1k9yNMd8arkcPMxtHpGj88j7SvnuG6IMjQ6FrvVs+sLSk+J
	p23yOrC2H4w5rw03vGsG5r0KoPhPr3h39+UMzuFVhdojArNB4DnhZo+u06n6CPty8DD8yKHD6dZ
	PB9uL1q52jnzb2+dVZdbbR82y/0YGUZEnIyNoG6GUll1+FQRyxmjxIPCK/n1b4/uRBmXviOU5zS
	KCMtAcAijWlTg3oO65nBWqai8zJ2Wb1verne1oQ6wTsOcBp6xg4t9U+0rvwk6de9GVGNFWr9h44
	mNjg==
X-Google-Smtp-Source: AGHT+IGyAtW4lDw4z+v9eHMGf2McBnn/cwXp3hDWrX/Af9VFHGt6ccKsSVbyCqvV8Tw/7zDFDtO3Jw==
X-Received: by 2002:a05:7022:2583:b0:119:e55a:9c00 with SMTP id a92af1059eb24-11b411fd521mr4629666c88.28.1763366674107;
        Mon, 17 Nov 2025 00:04:34 -0800 (PST)
Received: from [127.0.0.1] ([52.161.74.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b0608861asm30866182c88.9.2025.11.17.00.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 00:04:33 -0800 (PST)
Message-Id: <pull.2075.v6.git.git.1763366672.gitgitgadget@gmail.com>
In-Reply-To: <pull.2075.v5.git.git.1762468914.gitgitgadget@gmail.com>
References: <pull.2075.v5.git.git.1762468914.gitgitgadget@gmail.com>
From: "Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 17 Nov 2025 08:04:30 +0000
Subject: [PATCH v6 0/2] blame: make diff algorithm configurable
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
    Phillip Wood <phillip.wood123@gmail.com>,
    Antonin Delpeuch <antonin@delpeuch.eu>

Changes since v5:

 * add back /* clear out previous settings */ comments
 * remove whitespace in bash output redirection

Antonin Delpeuch (2):
  xdiff: add 'minimal' to XDF_DIFF_ALGORITHM_MASK
  blame: make diff algorithm configurable

 Documentation/diff-algorithm-option.adoc |  20 +++
 Documentation/diff-options.adoc          |  21 +--
 Documentation/git-blame.adoc             |   2 +
 builtin/blame.c                          |  52 +++++-
 diff.c                                   |   1 -
 merge-ort.c                              |   1 -
 t/meson.build                            |   1 +
 t/t8015-blame-diff-algorithm.sh          | 203 +++++++++++++++++++++++
 xdiff/xdiff.h                            |   2 +-
 9 files changed, 279 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/diff-algorithm-option.adoc
 create mode 100755 t/t8015-blame-diff-algorithm.sh


base-commit: 4253630c6f07a4bdcc9aa62a50e26a4d466219d1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2075%2Fwetneb%2Fblame_respects_diff_algorithm-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2075/wetneb/blame_respects_diff_algorithm-v6
Pull-Request: https://github.com/git/git/pull/2075

Range-diff vs v5:

 1:  e81a5d2bd2 ! 1:  4846715436 xdiff: add 'minimal' to XDF_DIFF_ALGORITHM_MASK
     @@ Commit message
      
       ## diff.c ##
      @@ diff.c: static int set_diff_algorithm(struct diff_options *opts,
     - 	if (value < 0)
       		return -1;
       
     --	/* clear out previous settings */
     + 	/* clear out previous settings */
      -	DIFF_XDL_CLR(opts, NEED_MINIMAL);
       	opts->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
       	opts->xdl_opts |= value;
     @@ diff.c: static int set_diff_algorithm(struct diff_options *opts,
      
       ## merge-ort.c ##
      @@ merge-ort.c: int parse_merge_opt(struct merge_options *opt, const char *s)
     - 		long value = parse_algorithm_value(arg);
       		if (value < 0)
       			return -1;
     --		/* clear out previous settings */
     + 		/* clear out previous settings */
      -		DIFF_XDL_CLR(opt, NEED_MINIMAL);
       		opt->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
       		opt->xdl_opts |= value;
 2:  60015bbada ! 2:  c477b87cc6 blame: make diff algorithm configurable
     @@ t/t8015-blame-diff-algorithm.sh (new)
      +	Commit_1 }
      +	EOF
      +
     -+	git blame file.c > output &&
     -+	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output > without_varying_parts &&
     -+	sed -e "s/ *$//g" without_varying_parts > actual &&
     ++	git blame file.c >output &&
     ++	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output >without_varying_parts &&
     ++	sed -e "s/ *$//g" without_varying_parts >actual &&
      +	test_cmp expected actual
      +'
      +
     @@ t/t8015-blame-diff-algorithm.sh (new)
      +	Commit_2 }
      +	EOF
      +
     -+	git blame file.c --diff-algorithm histogram > output &&
     -+	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output > without_varying_parts &&
     -+	sed -e "s/ *$//g" without_varying_parts > actual &&
     ++	git blame file.c --diff-algorithm histogram >output &&
     ++	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output >without_varying_parts &&
     ++	sed -e "s/ *$//g" without_varying_parts >actual &&
      +	test_cmp expected actual
      +'
      +
     @@ t/t8015-blame-diff-algorithm.sh (new)
      +	Commit_2 }
      +	EOF
      +
     -+	git -c diff.algorithm=histogram blame file.c > output &&
     ++	git -c diff.algorithm=histogram blame file.c >output &&
      +	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" \
     -+	    -e "s/ *$//g" output > actual &&
     ++	    -e "s/ *$//g" output >actual &&
      +	test_cmp expected actual
      +'
      +
     @@ t/t8015-blame-diff-algorithm.sh (new)
      +	Commit_2 }
      +	EOF
      +
     -+	git -c diff.algorithm=myers blame file.c --diff-algorithm histogram > output &&
     ++	git -c diff.algorithm=myers blame file.c --diff-algorithm histogram >output &&
      +	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" \
     -+	    -e "s/ *$//g" output > actual &&
     ++	    -e "s/ *$//g" output >actual &&
      +	test_cmp expected actual
      +'
      +
     @@ t/t8015-blame-diff-algorithm.sh (new)
      +	Commit_2 G
      +	EOF
      +
     -+	git blame file.txt --minimal > output &&
     -+	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output > actual &&
     ++	git blame file.txt --minimal >output &&
     ++	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output >actual &&
      +	test_cmp expected actual
      +'
      +
     @@ t/t8015-blame-diff-algorithm.sh (new)
      +	Commit_2 G
      +	EOF
      +
     -+	git blame file.txt --minimal --diff-algorithm myers > output &&
     -+	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output > actual &&
     ++	git blame file.txt --minimal --diff-algorithm myers >output &&
     ++	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output >actual &&
      +	test_cmp expected actual
      +'
      +

-- 
gitgitgadget
