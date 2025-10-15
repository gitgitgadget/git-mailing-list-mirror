Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45D43112A9
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567385; cv=none; b=hozwM+ZLD/DahQwxAmjWRpTPP4yErauzsj2ZtprVf0u5XRQnzQykBpPpA+WW9EMnkZ3kf7fHs4bh7gKiCxLx9Mfrs0N7E9PCVeScV55m8drJhutyWPYVmJKRPbydfg9sZGa9qMPFICoJI+n1w6wvyHvSs6A8MLOAnRVa3hHNxo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567385; c=relaxed/simple;
	bh=kD700lxyMItmWOFHhi4aAB4fCbFN0JDQB1frXTj718A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ikm1Jbc6rv/cAKtgYPL42hj0HbgX52NbM2IkpoSz4s5Be302AaWBPEjBq/UEUtJ/4p87ToSsZr/LpkdbKyEFu5KEWhkW+MEBd2ChIcmeeZk+jHiEkVMAhp/xqG+MotEVLpcfC/EUV5U8vsotMygQSg0TgwcpFsnX7OrP4y4SzvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=bUQpH9pM; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="bUQpH9pM"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7815092cd2fso1216807b3.0
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567383; x=1761172183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xGVxZL3wMnnldv8x/5JeEKadIbrIHBS8JPKJcElJkNg=;
        b=bUQpH9pM4pyg4o8txElqQf3SGlte/6OoDUqr28h9SWm6SSAL48ret5L5dZL6OzlQq0
         xBgXDqBJBbPNp3Qfo4EPP/rR0kSsl+WJ1LYbTOviy2Ayei3EWMphDlUAQtYhREXE78O3
         ryqHpXS5wXI8P0cb3JDu5CY/hLOqG8lJn0ckU0Jl+vpqJm9CXyGlbn4LY0LphcrG7MeK
         PBlubLyT3H7GDiSoMWEzM16GO9vjAYNSXbipNV2Lfo2bwmcDb6aYGRqFGKkxC0Evwd0w
         u8wkF6hvWVX02+Vne5DpsiVA+ipp1CZgLFHWhudwScp5vhhoinAhNgB5G0Q40uqPeCbl
         LzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567383; x=1761172183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGVxZL3wMnnldv8x/5JeEKadIbrIHBS8JPKJcElJkNg=;
        b=wuhiHYHSLwvzxWAKYRKlGmx/hqxUeVuNlxqUNDHhY/TBZry8H+RdVUxeQwkDXPcSEL
         YqFDOUxxpUMOWRn+Zmc0uMC/JD4bo/dB9iEKuiBzkiZBcFOgQcDx2js82cTq8svGV170
         az44S07Anu1uvwBkqlx3Da4g2KbbxcmZR0qtlD0HFPVdNbw6G02d6FaKfVzm1ACpCqvc
         6DS6Yju6aJ1qZTnNNSJBvwqq6poJBSH3vfYZFY1DV+RnYVEUTOGWyitSEopjbUUVtnlY
         WZq+GC4lZ1r8tg3Xn2+HkCPsMcakWJRbF/4JjCWlRK7osq0OCCbQIHWpjbc9j59j4ssM
         T99g==
X-Gm-Message-State: AOJu0Yzf2R28b+4KUjhwJtzLNZbi3eBI2EDi5uE7TIFgcqQhPQWNv89c
	l+3IjVbBqgU8BppSQNgAEzc7+Oh8hhuofkI4Iex6Rqyk9juQ+IYEhaLTlaMgNKRWwsZQRIeWmaU
	Cpz55iFK5QA==
X-Gm-Gg: ASbGncs0tWJeMGCQdcuHvbjJr8l4d7gPI/u35br1H6ynTkrEF3grm7dl9jHPO3/5IDZ
	boGELP8km1zgJu0zcZtUrd8K1uUYdj5Xo8a6eq/K4FMB3meAb2K5iKp1MFCtwM/wEt5GZTr4Fbu
	Vizsqo2xADvd5mYMd49+0P7zqzoB0htiMTJgJy3+MgGaJJ/GtkXtY9CNK9LXRs9EpI1qpHvJrxS
	sOJtdYuwt9V4pvfhiz1ggy8Mocs+c2jZcixK+LGT827STP1MLp0rdXF3t/imOQlaEzx63RxdmPE
	eB9mUBVbVENb5GVRef6L2YKfLR68OQTFWGkPzgDAi2Z9cZFDIOpvTcxk32ICJKvrbIT7p+SefyN
	Faj6aaKAuN9gpryPd+wxdU0GRfSb5XmXhm5IzO2k5Dfi9TyQkSvpoFJ9ediiwC2nhrnLxjgYR7v
	FMbunWrpxf+Y4WAp1JNzcSnt9iDAE/Ps3BwogTDGeNCo3yrd8gaxeBsYJ2gjXRscBTy2oFYDQhi
	44pyZY=
X-Google-Smtp-Source: AGHT+IHzt/ipHLYMuVc5J8yJYCD6+c8Zh3aYuCEiy+g2BP7rAciB5uUrx457oSyVzTM53zGguXDnrA==
X-Received: by 2002:a05:690c:6188:b0:781:64f:3139 with SMTP id 00721157ae682-781064f72e1mr228097097b3.55.1760567382619;
        Wed, 15 Oct 2025 15:29:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-782932f5f65sm2579467b3.49.2025.10.15.15.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:29:42 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:29:41 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 49/49] builtin/repack.c: clean up unused `#include`s
Message-ID: <b7178565ac6d7dcbaff8c1eb825dddef13128a02.1760567210.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
 <cover.1760567210.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1760567210.git.me@ttaylorr.com>

Over the past several dozen commits, we have moved a large amount of
functionality out of the repack builtin and into other files like
repack.c, repack-cruft.c, repack-filtered.c, repack-midx.c, and
repack-promisor.c.

These files specify the minimal set of `#include`s that they need to
compile successfully, but we did not change the set of `#include`s in
the repack builtin itself.

Now that the code movement is complete, let's clean up that set of
`#include`s and trim down the builtin to include the minimal amount of
external headers necessary to compile.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index a68c22f605..cfdb4c0920 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -4,26 +4,17 @@
 #include "builtin.h"
 #include "config.h"
 #include "environment.h"
-#include "gettext.h"
-#include "hex.h"
 #include "parse-options.h"
 #include "path.h"
 #include "run-command.h"
 #include "server-info.h"
-#include "strbuf.h"
 #include "string-list.h"
-#include "strvec.h"
 #include "midx.h"
 #include "packfile.h"
 #include "prune-packed.h"
-#include "odb.h"
 #include "promisor-remote.h"
 #include "repack.h"
 #include "shallow.h"
-#include "pack.h"
-#include "pack-bitmap.h"
-#include "refs.h"
-#include "list-objects-filter-options.h"
 
 #define ALL_INTO_ONE 1
 #define LOOSEN_UNREACHABLE 2
-- 
2.51.0.540.ga7423965ad8
