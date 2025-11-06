Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DDC2E5B10
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 22:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468918; cv=none; b=bjQP3KehDjeRA26UWDGmCrU4Z9d/9jMh23/AePwtEPHZO3c4ZBzvxzRhCl+uSNXs33VXg1UV/C2lASYywKiBZourOAk8H9jDHdPnqxYWgBVYnJpSE7Wk/ldhde8DnHtOODkbCL+hz3NomR1Eu5IB//noiW9BXpyfsRQrVN79MII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468918; c=relaxed/simple;
	bh=xyNJpQS/Qd1QnWvfXUeKUJxCjC6MWUQTr5qdrhqWAu4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qO1M/2k0nW1Jx9XK6ySqKFTkG6pt/v69L6GH9yikuT3qjdvYckODPmMPh31pqqhdhiRJyWW9RSIQsMq7d0LhDIRZiBy0hiEYIaa9LF0zFZwWVJlTuBxeeu9GRnbuQagob9B9cw+HBFaX+TRCGsX5wbPf16iIJKNMkLmHLysVAp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4ViTz2s; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4ViTz2s"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-341988c720aso112002a91.3
        for <git@vger.kernel.org>; Thu, 06 Nov 2025 14:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762468916; x=1763073716; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Phi4SfJEaNbJm6cikfyQv9GwrE7McVE1qaIfSpWF0NQ=;
        b=K4ViTz2shLr65wZ2LcNbjwzLoYCjQtQM4nfQJWccw3GuEdxxRV9wrQY7B6of480N+f
         iZV84NRMnuPccQffbrRs1yrpj9JOe05cF8HsQHajUaSTNfnOJS+klR64j+aq6PnHsr/B
         fpIDipuk2RpF+WU0n3Uv6FJ5IqOaOBP2wg0iYM+QikbSd/hMn9h7J5VoD+cQ8pDlTceE
         a63vP/0Qbjd9rcs4PTp7BF5SitWS4R/UEqc7zY2F+bzPkWB5lSFbhE+7YlUJktCu8VQ9
         0jlP5Vr9uI3Ozsn9ssCRRBW5zXhE/lkOidSDVJIxznjNKdFSx5Tzb1i8sWDzaUFsjEHj
         Jrow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762468916; x=1763073716;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Phi4SfJEaNbJm6cikfyQv9GwrE7McVE1qaIfSpWF0NQ=;
        b=oiFyJYNaciRqLtpcDburQZW+eTXgwttyGIiFor3eh3X67aHueJ6qr8EfP6BOglu65C
         pKt1Jz9vJVBpKNzqslSLncn5QifkdslwUu2+aW/zqz0IUpGvVXaDJN1a8LTc7EoiJIWz
         NVb2A3wow7FLIFXtm5euQncCmPoY5efSV2oOtqMvYKAB27CZvZ5Y/qDPzGqP7IrR69ot
         ghqT1/MPmcx3qiLkruOt6vrwWDrpI3CTEwP58AE7QMKNly8F8MmQG+HwHZJ4eeYMS3a0
         HGFmg4W9LA/9VKZl3z2X7WiMuLsBU+wkSb8ueBGJwQKdP5/R6gbzLn7kMooarGpmgRC3
         JzOw==
X-Gm-Message-State: AOJu0YxEtqjlm72JV4BcddODDN3u+425ljyLgYyoam3rT21o0ByvGtHi
	A4gzkk4hFuxKQX6CDv81VjpxM5L8N28lKBTQ6fLuK9/nsxz8Zpb69aFFHL31Fg==
X-Gm-Gg: ASbGncs3WY7YDdPirKBVatvPSaf4cxXO2yCKuId0MNzsWkGXFyVTRj/Ptt7fhYFu77B
	UzdarIE/yyaA3OoYERqvm6mZnOmG94hSCWjlyNaLWU3wZ/Bme73wwOPGm2e0KRm4dvCn5I8BhqL
	ArAdW+CSRt8DFoqmc4f8M43xlEAEgc1fagmQKkU+StaB2aeg4KpvAT7dMSfs/3pjE0SJH9N7NqN
	xMPh0rrjqBT0tHz1/i1o6yR2gZJwm+Zx0HqHAxJ9uVBTMuPhWmJSxkNXTSufiOjmzvFnnX9sPtr
	iAxInUMzvaZKXEd6Z9tLs2oi7lY1QuMsWRwobNI3d0AvKX1Oyxy1QqeZWiMM0zhtqV4V1nVs8m0
	paZxZoP9C42228YBu0XQDF6zKbM+wlG/SU/IbzsFebabMRIL06+JPJ2HOUW0l67IYySMrj4J894
	Tc
X-Google-Smtp-Source: AGHT+IG6fQ0YHjo8bV0BCPTnkegs0umdvOIxHTlRQq24tpw20E5iofjGIQ/ydVeGHnWmqge8Cvqf+A==
X-Received: by 2002:a17:90b:4c86:b0:340:e4fb:130b with SMTP id 98e67ed59e1d1-3434c4ef82bmr1036885a91.14.1762468915699;
        Thu, 06 Nov 2025 14:41:55 -0800 (PST)
Received: from [127.0.0.1] ([68.220.59.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d0daabd1sm1506742a91.8.2025.11.06.14.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 14:41:55 -0800 (PST)
Message-Id: <pull.2075.v5.git.git.1762468914.gitgitgadget@gmail.com>
In-Reply-To: <pull.2075.v4.git.git.1762034252.gitgitgadget@gmail.com>
References: <pull.2075.v4.git.git.1762034252.gitgitgadget@gmail.com>
From: "Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 06 Nov 2025 22:41:52 +0000
Subject: [PATCH v5 0/2] blame: make diff algorithm configurable
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

Changes since v4:

 * hide --minimal option
 * simplify tests to minimize spun processes
 * remove redundant XDF_NEED_MINIMAL in bit mask

Antonin Delpeuch (2):
  xdiff: add 'minimal' to XDF_DIFF_ALGORITHM_MASK
  blame: make diff algorithm configurable

 Documentation/diff-algorithm-option.adoc |  20 +++
 Documentation/diff-options.adoc          |  21 +--
 Documentation/git-blame.adoc             |   2 +
 builtin/blame.c                          |  52 +++++-
 diff.c                                   |   2 -
 merge-ort.c                              |   2 -
 t/meson.build                            |   1 +
 t/t8015-blame-diff-algorithm.sh          | 203 +++++++++++++++++++++++
 xdiff/xdiff.h                            |   2 +-
 9 files changed, 279 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/diff-algorithm-option.adoc
 create mode 100755 t/t8015-blame-diff-algorithm.sh


base-commit: 4253630c6f07a4bdcc9aa62a50e26a4d466219d1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2075%2Fwetneb%2Fblame_respects_diff_algorithm-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2075/wetneb/blame_respects_diff_algorithm-v5
Pull-Request: https://github.com/git/git/pull/2075

Range-diff vs v4:

 1:  e81a5d2bd2 = 1:  e81a5d2bd2 xdiff: add 'minimal' to XDF_DIFF_ALGORITHM_MASK
 2:  920a6f3acb ! 2:  60015bbada blame: make diff algorithm configurable
     @@ builtin/blame.c: static int blame_move_callback(const struct option *option, con
      +		return error(_("option diff-algorithm accepts \"myers\", "
      +			       "\"minimal\", \"patience\" and \"histogram\""));
      +
     -+	*opt &= ~(XDF_NEED_MINIMAL | XDF_DIFF_ALGORITHM_MASK);
     ++	*opt &= ~XDF_DIFF_ALGORITHM_MASK;
      +	*opt |= value;
      +
      +	return 0;
     @@ builtin/blame.c: int cmd_blame(int argc,
      -		OPT_BIT(0, "minimal", &xdl_opts, N_("spend extra cycles to find better match"), XDF_NEED_MINIMAL),
      +		OPT_CALLBACK_F(0, "minimal", &xdl_opts, NULL,
      +			       N_("spend extra cycles to find a better match"),
     -+			       PARSE_OPT_NOARG, blame_diff_algorithm_minimal),
     ++			       PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, blame_diff_algorithm_minimal),
       		OPT_STRING('S', NULL, &revs_file, N_("file"), N_("use revisions from <file> instead of calling git-rev-list")),
       		OPT_STRING(0, "contents", &contents_from, N_("file"), N_("use <file>'s contents as the final image")),
       		OPT_CALLBACK_F('C', NULL, &opt, N_("score"), N_("find line copies within and across files"), PARSE_OPT_OPTARG, blame_copy_callback),
     @@ t/t8015-blame-diff-algorithm.sh (new)
      +	EOF
      +
      +	git -c diff.algorithm=histogram blame file.c > output &&
     -+	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output > without_varying_parts &&
     -+	sed -e "s/ *$//g" without_varying_parts > actual &&
     ++	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" \
     ++	    -e "s/ *$//g" output > actual &&
      +	test_cmp expected actual
      +'
      +
     @@ t/t8015-blame-diff-algorithm.sh (new)
      +	Commit_2 }
      +	EOF
      +
     -+	git -c diff.algorithm=myers blame file.c --diff-algorithm histogram &&
     -+	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output > without_varying_parts &&
     -+	sed -e "s/ *$//g" without_varying_parts > actual &&
     ++	git -c diff.algorithm=myers blame file.c --diff-algorithm histogram > output &&
     ++	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" \
     ++	    -e "s/ *$//g" output > actual &&
      +	test_cmp expected actual
      +'
      +

-- 
gitgitgadget
