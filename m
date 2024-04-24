Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E887E1635D5
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713975305; cv=none; b=qERVpZVK/EoJpu60qTlbZO/fwxcv6h6v8254t+vhHGnvnE0pj/dzTVwU6urdUJicX2PuwMgIExEuS77BRJkT6enujLLQkjbFpYY6FRGcCnR2xk7KHlaikzHGBr6htW+korc/3jZmtcmgXhHDFrySwRZH8zI5X+GX4vysh231oyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713975305; c=relaxed/simple;
	bh=UVAi8Gw8WuIWA+bgdkMp5oZJHFZdX+hL9ROz6vMCnwg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iXhHci/CZsyxNUMvCNJOAXYQ/pH20bj72fAVd6P9mKO4dnVtGIJswjPhHobXuKuaZqLBIFA7icHqRetXdzZa9pCyIxRElkrzx2enygtNVOwdmufwIZcjttlqzl1Nma0RKVrodyCoxGIqel2f5Jg3NRavhqdFk9hnzHycd6eSY7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXb7+Ovg; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXb7+Ovg"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-343c2f5b50fso5076105f8f.2
        for <git@vger.kernel.org>; Wed, 24 Apr 2024 09:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713975302; x=1714580102; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKr/wrzj5rL8EFlubVChQT1/qFA5WZAHie/ifEUH29Y=;
        b=cXb7+OvgpCwUr4YUnnRbMMJwrW2N7T32OddvjZWFhe+IVrbtIHG9X9kYuEZuqMmG42
         6n5RazfREpmKrmT+BnLrieIvR06aBKp9sZLx7VxKSHFEhsPoVMDIgmMvRfy+ZrYNqb4W
         3burKht99KGDkeGrz9Qv7Vce8KXdJfkHWW27vep6VgbMn2QMaWlwTuU8BOXYt1Bz4/zV
         BrykITS212hmuhmEQ0RczVz8kqkBs7lGTbOleK3bBDGAB3lWck8GaMFs5w6Oiv5XL+ZU
         OMUcYs6DqdTEdc9yszaG+HA1tkC4PVJHgaH4JzVQWY/DDRowVV3B7itVehiI9gF3+H7o
         4Jig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713975302; x=1714580102;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKr/wrzj5rL8EFlubVChQT1/qFA5WZAHie/ifEUH29Y=;
        b=mc8m+I4UcXxOJnv5knku7Oglhwptw3PFlfZ6iZ7A1Qdg2tGfyQ5tPpR4ZYnn64DARL
         2ggPgZ2BMzPHwv2p75shNAQrcy0efrDvfhL1MXv4qYK2g/jNSZIO6AWFcYxd00ccvqHG
         hxFREuhB0rUxFq+KBu9eS7xki8Yje2kjjEc1gseHNx7g+FTsoXdLyABsXyukvNAkjfVa
         PcqtOFQ6tdAfzrRjHDB+F+WTLSuSXyNkudZWUdB5y+GMHbFPBRVCl25isQT4aTHsaQhv
         GmEKuEWHnjSL8TUH1rmcl8aHsdQlLDu6fW/eqDgR9IXKjr19NwC/BMrqRLT00rudRWjk
         EDDA==
X-Gm-Message-State: AOJu0YwkEhT/5G2zQkaZg0G/g4e7DGPFXhMmRwO0NPRbSoaxy7dulNmM
	55lhyRIgZcf8oYmkc8FcovySfIZkHrir/bqdDr0/C76JbJJs7PCUwdhFGA==
X-Google-Smtp-Source: AGHT+IFkFwXzl/05J5baXIh/ZCLeqWi7VqW7eGRfMDdlCk5OFjJoUgfSylz89S8JxuGU7m5SW7u2Yg==
X-Received: by 2002:a5d:45c6:0:b0:343:dd56:b941 with SMTP id b6-20020a5d45c6000000b00343dd56b941mr2232349wrs.52.1713975301575;
        Wed, 24 Apr 2024 09:15:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r14-20020a05600c458e00b00417e5b71188sm24353251wmo.34.2024.04.24.09.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 09:15:00 -0700 (PDT)
Message-Id: <pull.1719.v3.git.1713975299.gitgitgadget@gmail.com>
In-Reply-To: <pull.1719.v2.git.1713444783.gitgitgadget@gmail.com>
References: <pull.1719.v2.git.1713444783.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Apr 2024 16:14:57 +0000
Subject: [PATCH v3 0/2] Use a "best effort" strategy in scheduled maintenance
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
    Patrick Steinhardt <ps@pks.im>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

Over in https://github.com/microsoft/git/issues/623, it was pointed out that
scheduled maintenance will error out when it encounters a missing
repository. The scheduled maintenance should exit with an error, all right,
but what about the remaining repositories for which maintenance was
scheduled, and that may not be missing?

This patch series addresses this by introducing a new for-each-repo option
and then using it in the command that is run via scheduled maintenance.

Changes since v2 (thanks Patrick, Jeff and Junio):

 * When not passing the new --keep-going option, the exit code is the same
   as before.
 * Clarified in the documentation of the --keep-going option that it is 0
   for success, 1 for failure, no matter the exact exit code of the failing
   command invocation(s).

Changes since v1 (thanks Eric!):

 * Changed the option's documentation to reflect the current state (instead
   of the original design)
 * Fixed grammar issues

Johannes Schindelin (2):
  for-each-repo: optionally keep going on an error
  maintenance: running maintenance should not stop on errors

 Documentation/git-for-each-repo.txt |  9 +++++++++
 builtin/for-each-repo.c             | 13 +++++++++++--
 builtin/gc.c                        |  7 ++++---
 t/t0068-for-each-repo.sh            | 16 ++++++++++++++++
 t/t7900-maintenance.sh              |  6 +++---
 5 files changed, 43 insertions(+), 8 deletions(-)


base-commit: 3c2a3fdc388747b9eaf4a4a4f2035c1c9ddb26d0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1719%2Fdscho%2Ffor-each-repo-stop-on-error-2.44-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1719/dscho/for-each-repo-stop-on-error-2.44-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1719

Range-diff vs v2:

 1:  abd796894c8 ! 1:  39ee6386aab for-each-repo: optionally keep going on an error
     @@ Commit message
          repository, still setting the exit code to indicate an error occurred.
      
          Helped-by: Eric Sunshine <sunshine@sunshineco.com>
     +    Helped-by: Patrick Steinhardt <ps@pks.im>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## Documentation/git-for-each-repo.txt ##
     @@ Documentation/git-for-each-repo.txt: These config values are loaded from system,
      +	Continue with the remaining repositories if the command failed
      +	on a repository. The exit code will still indicate that the
      +	overall operation was not successful.
     +++
     ++Note that the exact exit code of the failing command is not passed
     ++through as the exit code of the `for-each-repo` command: If the command
     ++failed in any of the specified repositories, the overall exit code will
     ++be 1.
       
       SUBPROCESS BEHAVIOR
       -------------------
     @@ builtin/for-each-repo.c: int cmd_for_each_repo(int argc, const char **argv, cons
       
      -	for (i = 0; !result && i < values->nr; i++)
      -		result = run_command_on_repo(values->items[i].string, argc, argv);
     -+	for (i = 0; (keep_going || !result) && i < values->nr; i++)
     -+		if (run_command_on_repo(values->items[i].string, argc, argv))
     ++	for (i = 0; i < values->nr; i++) {
     ++		int ret = run_command_on_repo(values->items[i].string, argc, argv);
     ++		if (ret) {
     ++			if (!keep_going)
     ++					return ret;
      +			result = 1;
     ++		}
     ++	}
       
       	return result;
       }
 2:  1ae11553052 = 2:  540962859c5 maintenance: running maintenance should not stop on errors

-- 
gitgitgadget
