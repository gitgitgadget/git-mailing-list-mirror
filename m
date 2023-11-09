Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFB338F96
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 22:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="wFAotsus"
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D713C01
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 14:34:11 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-778927f2dd3so85138185a.2
        for <git@vger.kernel.org>; Thu, 09 Nov 2023 14:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1699569250; x=1700174050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I/9rj3sY4b02xWqf5zLGtfbxRyTQUsUOWhyLmyIsm/A=;
        b=wFAotsus5QONbY6EGOJRgbpAY48Fu9pOtjG7wWA9949azF9l7SWxujY52D7ef0HtUZ
         IocmOxOgC8GIYr6ZANIXBCHUbvV1tFf1fo2W/S689NVbz64L9y18if7TpZXDNUXm+bRp
         g8jUC0H09ru5zYirhIkNuetCshRwq9EMHbuOfk7tXBpEJw3JsmD4hWlMuVwaot3k2DFo
         U5UDl/uByq+Pd27MzhQU0TSWZRf+XgL2zZsqDGjQFavFrzR/OzA7m3xEHEpj+kib1Uik
         9XjPdbPR5XxcQWUGjdQtjMew5F63vP5kn68JWCgk230wTbUTi/yFfsLILmWdxF8izuKZ
         k6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699569250; x=1700174050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/9rj3sY4b02xWqf5zLGtfbxRyTQUsUOWhyLmyIsm/A=;
        b=FN49yPPelZEKAsUZYPEeGyeCQOI6S/56p5qy7ZA5Unm9myH6cj77L5MSDXMJ4iRx2p
         LHysc2vOmxeI9jOF/YpbKFubOLjJMGsAsGL+VEmmELXT6KrBQuwwRkpOjr2FU5V3n3O+
         UKMKS3gzIjGIxPPbkGlNtjwoNkDXYy9FdE1+zs8J5VsNud7nk7LDatx/pp89ARrlax8c
         hD/5TiOiRq2V8MiDEHrKlFoDUKlOyPS9ETJEdV3jAma6y3iXlwXivLs3X1WFTuzucFcH
         rIkMzzGHXgu5XeKxH7WeYQ5vPydV31zVkiGYbQPQ80b4T4KWfyuSaHkJcUqr7Pf0Y9Zl
         x0hQ==
X-Gm-Message-State: AOJu0YwumL6wE+zu9Ii5b9S5UB0mJYVWSC0+sSBNxgdNiDVKls/y1Irs
	AUY6oeWiCwW9Bjpa9OolbBDd5ExgU82wzpnFJxqGEg==
X-Google-Smtp-Source: AGHT+IGJptCN8OqRWDQUAEwiwSgz25+WgOSGwlF/fsqmA7YbGwLFw7/D0Lqegdi2egX5PPgdcrPQnA==
X-Received: by 2002:a05:620a:574:b0:778:9465:7407 with SMTP id p20-20020a05620a057400b0077894657407mr5299921qkp.71.1699569250228;
        Thu, 09 Nov 2023 14:34:10 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o2-20020a05620a110200b007758b25ac3bsm243261qkk.82.2023.11.09.14.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 14:34:09 -0800 (PST)
Date: Thu, 9 Nov 2023 17:34:09 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/7] chunk-format: introduce `pair_chunk_expect()`
Message-ID: <cover.1699569246.git.me@ttaylorr.com>
References: <20231109070310.GA2697602@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231109070310.GA2697602@coredump.intra.peff.net>

This series is based on the latest patches in what I am assuming will
become "jk/chunk-bounds", found here [1].

This is a rework of my earlier round of patches in [2], which introduces
a new `pair_chunk_expect()` to replace some of the trivial callbacks
given to `read_chunk()` that assert on the size of the expected chunk.

Let me know what you think, and thanks in advance for your review!

[1]: https://lore.kernel.org/git/20231109070310.GA2697602@coredump.intra.peff.net/
[2]: https://lore.kernel.org/git/cover.1697225110.git.me@ttaylorr.com/

Taylor Blau (7):
  chunk-format: introduce `pair_chunk_expect()` helper
  commit-graph: read `OIDL` chunk with `pair_chunk_expect()`
  commit-graph: read `CDAT` chunk with `pair_chunk_expect()`
  commit-graph: read `GDAT` chunk with `pair_chunk_expect()`
  commit-graph: read `BIDX` chunk with `pair_chunk_expect()`
  midx: read `OIDL` chunk with `pair_chunk_expect()`
  midx: read `OOFF` chunk with `pair_chunk_expect()`

 chunk-format.c              | 29 ++++++++++++++++
 chunk-format.h              | 13 ++++++-
 commit-graph.c              | 67 ++++++++++---------------------------
 midx.c                      | 33 +++---------------
 t/t5318-commit-graph.sh     |  6 ++--
 t/t5319-multi-pack-index.sh |  2 --
 6 files changed, 65 insertions(+), 85 deletions(-)


base-commit: 8be77c5de65442b331a28d63802c7a3b94a06c5a
prerequisite-patch-id: 507f1dfd74fae351883612048d334ed750db8b8c
prerequisite-patch-id: c5eef290abc1d28950b3ee8729ea86d2e1773027
prerequisite-patch-id: 0853baab4862833faee8ade3b1b63ee3aa406224
prerequisite-patch-id: 6dd32f90fd87aa92f7d0661414cdaab257bd14b7
prerequisite-patch-id: b0e1617c501a011c703605e59dd5eba89f8a3573
prerequisite-patch-id: 906426f565c470dc86d7e7379d25ecfbd2bc30ce
prerequisite-patch-id: 970cd79d1911bde36b88c340f001266d7e8d843b
prerequisite-patch-id: 083a24abc73a83345bd9e4ca714577990dd9b08b
prerequisite-patch-id: 210371a338dfe9b6f905d8821501aa9c235c8722
-- 
2.43.0.rc0.39.g44bd344727
