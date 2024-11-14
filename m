Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C2AB65C
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 13:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731591729; cv=none; b=LCKaj9wuOxsHR1XM+XpD+6QBUtsU3n+yNs7ijFfpS647lNJFhjMTfBV4AKjOp8SWGnIaU0cAWm6Rg56Z7WL/n/oDReA54oA3IgHkSWmFj+oJk2xbNogPo9G4MmuxZ49itwqEl16FcwbvrkywMsG3gAkdo1H6KH/elLCVNAHt64E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731591729; c=relaxed/simple;
	bh=tA44fHS8aDYPzid5Az0kykyAOWMV102ynkfS7nnRE4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkBjD+Tn9eBoypsu/MjwzXNehCu91kJd4cPFDpSzWnhVIWs1P4Sikrw000Vd3GG+cLajT1UOfudq/QWtD83E88yVGxc0QsxYxr3yP5zUzBCIdx6JgOQUTzOgam+0XhuWkDlGEfgXPwP/RNsj6tMuMhGOc1pM22CS5naWKNmrIZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=xYt7U7YM; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="xYt7U7YM"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e30eca40c44so676124276.2
        for <git@vger.kernel.org>; Thu, 14 Nov 2024 05:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1731591727; x=1732196527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vxx4PKcIeYGX3/q+WqNke/OCoaIKqwut53EuvZDcLHs=;
        b=xYt7U7YMgmZPX5KhdkKuGocc87j6Kj2ymsbKTlO3S6vn9fVcf68NjnvU8DSxoqCLFN
         TLYZ0CrYQ1jq2+0vL1NlSRqb1wGrk5Qz7Ot9+B59VzBa2RrMt0QTFu4vfNuLn0a8eHtp
         TVgHYlvTdqMs+VVMgSctxxydkJUDggXUnImgl3FR+ILP1PGt7iPA1vs07OvPNq0cpyKe
         F5WVXzQDKURne9nXN/gdkQMCTFRDIBQ7J9QWB6fiaxb4Zoi5p4rl58LVfyV/zRs+5KVv
         k1CHXhAYJDo7p0V9j+5DYHO5XU8hAkwJfruzYnpNtzqMExET0iKEGUk76Yde86Sho1Nv
         vI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731591727; x=1732196527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxx4PKcIeYGX3/q+WqNke/OCoaIKqwut53EuvZDcLHs=;
        b=MJbkZlmjoG8XWsjSdBwulgtkLuI+GF/GhRMV/mVwpuCKP3TSlwK25s99HFtJzqegjW
         mdXLwyYCUqHfYecjJyISaCX7YAjPX0ll9Cvqg65m5Kqb2I84y5zVdqx8uEzJYOY19Uaq
         IwytMzdUR9Kb2BtEVDnHmK4WT9riWQPyiaXUwfMK7CSTdoaoonQZdG+pqA2wAw3ElfMf
         1m1Qsxf28VKZk+/n1W7waNIS0ab7Xm53WpqiIp35EGCc5GpXtkQUgvKJZdJvtmGWBnsW
         mmLhvcxctnp+VHAnd9X0TxUwBWkxhiD4jFsVNwCXSIGzYUxdmPl7GKQ7aKDZBzpixJ+S
         LFIw==
X-Gm-Message-State: AOJu0Yw9qT0j6NuDuPK84b/dXa+hfLks9Q5BWM6aUxwxQsfNd/nnWYsN
	LW4i10ZwOPucAL/OKKWbR3Zr4uLXhCvwe0u2s3+5N5VzF2PT5Sn4h31zz61Wc3q1iZ9Ae3Bn4pR
	zqcI=
X-Google-Smtp-Source: AGHT+IElI/FrxVxPKnbD/QKL9Xkpz/VD+fAcyLGmHTrkRQZC5Lrf77BkHajK/x6C4/OLBV2e/vFtZQ==
X-Received: by 2002:a05:6902:2685:b0:e30:d289:49d2 with SMTP id 3f1490d57ef6-e337f859d1fmr20762412276.17.1731591727103;
        Thu, 14 Nov 2024 05:42:07 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e38152caccdsm312552276.14.2024.11.14.05.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 05:42:06 -0800 (PST)
Date: Thu, 14 Nov 2024 08:42:05 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 0/2] pack-objects: more brown-paper-bag multi-pack reuse
 fixes
Message-ID: <cover.1731591708.git.me@ttaylorr.com>
References: <cover.1731518931.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1731518931.git.me@ttaylorr.com>

This is a small re-roll of my series to fix a regression in multi-pack
reuse based on a broken assumption in write_reused_pack_verbatim().

The only change since last time is removing a stray debugging aid, and
the series is otherwise identical as in v1. A range-diff is included
below for convenience.

Thanks in advance for your review!

Taylor Blau (2):
  t5332-multi-pack-reuse.sh: demonstrate duplicate packing failure
  pack-objects: only perform verbatim reuse on the preferred pack

 builtin/pack-objects.c      | 101 +++++++++++++++---------------------
 t/t5332-multi-pack-reuse.sh |  22 ++++++++
 2 files changed, 65 insertions(+), 58 deletions(-)

Range-diff against v1:
1:  7a69cf84ae5 ! 1:  d791b7b20c9 t5332-multi-pack-reuse.sh: demonstrate duplicate packing failure
    @@ t/t5332-multi-pack-reuse.sh: test_expect_success 'duplicate objects' '
     +
     +		# ...and create a separate pack containing just that object
     +		p="$(git pack-objects $packdir/pack <in)" &&
    -+		git show-index <$packdir/pack-$p.idx &&
     +
     +		git multi-pack-index write --bitmap --preferred-pack=pack-$p.idx &&
     +
2:  2520abf24a8 = 2:  d73b8fe2d63 pack-objects: only perform verbatim reuse on the preferred pack

base-commit: 25b0f41288718625b18495de23cc066394c09a92
-- 
2.46.0.421.g159f2d50e75
