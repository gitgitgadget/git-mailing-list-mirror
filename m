Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC353793D3
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 17:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774890008; cv=none; b=Ij0Sq4GNrG3xU1vjAmKDPkQKY66HVX3KIFIbDp1TQs+ydXoyZXz/yvS7IrVx8gnC32WKhOOEsVeNoa4spA+PledMUBHsrFqeHH1Xybg04nYYPhGNC+KgfIBDsXGDQP7UREzqAvglOmL61TMUxZrUfcNMpL2gmlA3g7Olw8oQNDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774890008; c=relaxed/simple;
	bh=qsBoXDneTnnhpQf5ryyjm7doJKOLYOa1N3pEslbPhag=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qEhj1ppLGyHLlSVF3KqN1LAOu4zKLpyoEygW0YsA/bS2r3JCOB7mMl9TGaADPFvWGr2erCS0zXBGsfVPDLsfyydoFxe4Ll6fTGfP5Oq80/gFQMyrXMz23YbwgUzx4F7B2ufKG9hfRyqvtGC3z1SSGkONIToMD/RZ/g2oHzAj3AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sc3OupPn; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sc3OupPn"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-463f00cda04so2644698b6e.2
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 10:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774890006; x=1775494806; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIMWuV2EtkWyWHxcbZVz+ZEgumf2G+1R3RADh26dFps=;
        b=Sc3OupPnmVq+96Om6ndXLahPmongb/A8Cloo00wkpFM4ah/DDmR+WMZhfsisM4E8Hu
         AN+1tNYTq/TGVFuu4KFDw5V71trMJdAtEKIu5t1qwazsK3oMprwuAjnYQGodLvugCYJf
         rc8TEuA9YtHTcWbdSibuOIOT4EwTAo7OjvGjgY8HUuMhXQAjuC5QqVc/ifstqBTJWSV2
         D1bOs6DsdjVgaB6mHUqXfNQMjV+Xewx8h20DVO/s6GY+71YgDBEZ2TGOLq4cD3HX3xGc
         jsqeHVz0xbe6rJgMoSuxzuzBNeO0NSYlG0DtxzSjQ8VytBeYUU2D1XTSHJPCcPAWUQMb
         8gkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774890006; x=1775494806;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cIMWuV2EtkWyWHxcbZVz+ZEgumf2G+1R3RADh26dFps=;
        b=SCGEQnRuxzftCsAFeAyW8NncOJbVX/2praghc8rLQRbLTQ4ugZAe2DZ7Oft70s5reH
         CDYEymdvXLotdbcZJlr9mK46gyVknKmEvX6JucSN4JmS1I9vqDGA7x3N+6LQ61xm7Ci6
         KBdtgUxXPEHz/fGgLvWM2r94LYU92TSgsStDU6dgmXrB/cLzlSWcb4ZRYByfCxVfpWa/
         APUZZUa803go7dBSU3YK8F9MCZ7ziQtWMakBkKVtKGMg3L8XX4D+CZfLFZJklqCHWfti
         eAWz0ETGsYi7+X3GM+u8j2pYi1sXpj3x8hofI6YXrLcmnZAxm++gKB1ymvfywEliaQv4
         edOg==
X-Gm-Message-State: AOJu0YyCCwQBEI0yME1uPRVvuIg+uzI5psovy8QADcis53IxI/tmT/KH
	uhFIHWaKX7r0DxczgQFasfag+EuB76veBcO53jSzKAy/Cr0UuDpwpNaOY/pNEw==
X-Gm-Gg: ATEYQzwHQ+1m/RouuOs6BTtliNAIAS8dk/+x0nO2rwMxCdvZvZWdnCGuWft6sb8iDyu
	xzaIRQwaMosWmMU7twbayMMtHlKE0e6LNT1saMNY/vf9CRLC/rEhUzsOAWnvAv024bEQy+2oEyM
	Gtj93vGygiHW1Lgxt1XoY3jgdEHgq4uQuykmH4OPpvWxinXrJxE2FNZ6KGtROYeG83kEBtTc/yj
	2Z7Zq58uXp8F8eeNWxEkt+e/GMmk8rB8zHP1Hn6Tuqx164IzquoYxaGtf+lpYWkyAFYAjU3WiyJ
	lq0blqHeQjRBlFUKOmxt5vKNnIpcxR+lqByD0cDZK/WSaEMndUpFh9RjA1Gl8/P2C33f/Jtofir
	fQq1InAoIWEY8g55O14RZeifZEg/oytu1oBslNZmzjtBtdxIaysjL36LOFlb7ltm9BALO/ECRp9
	Z5/gASjyAfbrMK49VMowlPgGhspiU=
X-Received: by 2002:a05:6808:3020:b0:467:2e8a:8c6f with SMTP id 5614622812f47-46a8a6560f5mr6246458b6e.54.1774890005496;
        Mon, 30 Mar 2026 10:00:05 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.80.135])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46aa03e4acesm5105223b6e.17.2026.03.30.10.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 10:00:04 -0700 (PDT)
Message-Id: <pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com>
References: <pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 30 Mar 2026 16:59:57 +0000
Subject: [PATCH v4 0/6] Xdiff cleanup part 3
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
Cc: Yee Cheng Chin <ychin.git@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Jeff King <peff@peff.net>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

Changes in v3:

 * run make DEVELOPER=1 on each commit and fix all compiler issues

v2 is a radical departure from v1 Changes in v2:

 * make the flow of xdl_cleanup_records() easier to follow

There is no performance or behavioral change introduced in this patch
series.

=== original cover letter bellow ===

Patch series summary:

 * patch 1: Introduce the ivec type
 * patch 2: Create the function xdl_do_classic_diff()
 * patches 3-4: generic cleanup
 * patches 5-8: convert from dstart/dend (in xdfile_t) to
   delta_start/delta_end (in xdfenv_t)
 * patches 9-10: move xdl_cleanup_records(), and related, from xprepare.c to
   xdiffi.c

Things that will be addressed in future patch series:

 * Make xdl_cleanup_records() easier to read
 * convert recs/nrec into an ivec
 * convert changed to an ivec
 * remove reference_index/nreff from xdfile_t and turn it into an ivec
 * splitting minimal_perfect_hash out as its own ivec
 * improve the performance of the classifier and parsing/hashing lines

=== before this patch series typedef struct s_xdfile { xrecord_t *recs;
size_t nrec; ptrdiff_t dstart, dend; bool *changed; size_t *reference_index;
size_t nreff; } xdfile_t;

typedef struct s_xdfenv { xdfile_t xdf1, xdf2; } xdfenv_t;

=== after this patch series typedef struct s_xdfile { xrecord_t *recs;
size_t nrec; bool *changed; size_t *reference_index; size_t nreff; }
xdfile_t;

typedef struct s_xdfenv { xdfile_t xdf1, xdf2; size_t delta_start,
delta_end; size_t mph_size; } xdfenv_t;

Ezekiel Newren (6):
  xdiff/xdl_cleanup_records: delete local recs pointer
  xdiff: use unambiguous types in xdl_bogo_sqrt()
  xdiff/xdl_cleanup_records: use unambiguous types
  xdiff/xdl_cleanup_records: make limits more clear
  xdiff/xdl_cleanup_records: make setting action easier to follow
  xdiff/xdl_cleanup_records: simplify INVESTIGATE handling for clarity

 xdiff/xdiffi.c   |  2 +-
 xdiff/xprepare.c | 84 ++++++++++++++++++++++++++++++++----------------
 xdiff/xutils.c   |  4 +--
 xdiff/xutils.h   |  2 +-
 4 files changed, 60 insertions(+), 32 deletions(-)


base-commit: ca1db8a0f7dc0dbea892e99f5b37c5fe5861be71
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2156%2Fezekielnewren%2Fxdiff-cleanup-3-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2156/ezekielnewren/xdiff-cleanup-3-v4
Pull-Request: https://github.com/git/git/pull/2156

Range-diff vs v3:

 1:  da32a9747c = 1:  da32a9747c xdiff/xdl_cleanup_records: delete local recs pointer
 2:  86b0ad100c = 2:  86b0ad100c xdiff: use unambiguous types in xdl_bogo_sqrt()
 3:  39a35365ae = 3:  39a35365ae xdiff/xdl_cleanup_records: use unambiguous types
 4:  86dd98db9b ! 4:  75fe3ea125 xdiff/xdl_cleanup_records: make limits more clear
     @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *
       
      +	if (need_min) {
      +		/* i.e. infinity */
     -+		mlim1 = SIZE_MAX;
     -+		mlim2 = SIZE_MAX;
     ++		mlim1 = PTRDIFF_MAX;
     ++		mlim2 = PTRDIFF_MAX;
      +	} else {
      +		mlim1 = XDL_MIN(xdl_bogosqrt(xdf1->nrec), XDL_MAX_EQLIMIT);
      +		mlim2 = XDL_MIN(xdl_bogosqrt(xdf2->nrec), XDL_MAX_EQLIMIT);
 5:  ecc25be32f = 5:  0cf1412d01 xdiff/xdl_cleanup_records: make setting action easier to follow
 6:  8f4def8814 = 6:  fd14ccafc4 xdiff/xdl_cleanup_records: simplify INVESTIGATE handling for clarity

-- 
gitgitgadget
