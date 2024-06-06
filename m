Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CC7199382
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 18:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717698084; cv=none; b=q59mf5lF/XXPkIc+Z+/s2O+i8r1rlUf5z6eRkztlhQ22zRQnUFYLd0dGVj0tGPmwgwYyrvA0li7kxu8nrLrUrRW4ConRRsWixjs7T1PK6CBPaDWDCTG4Pto33DwkTGoiUsSgTGVM17HxnodlRTtN2DxnX3AnhbIXEGVuKf18qe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717698084; c=relaxed/simple;
	bh=CHnXGSHyb45FtxdciA1XOvZ/fdnJ1ELhMWp+t8xyOqI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JnmLlddkovk2Ym+zRvwru0uRu8xnl6t7IDVMzD19QuJQPA5PSiTp26DVRhCCyrh2T8aiR5dvSs1HcN/t0JHTWhQ3ExOg287ebzuG5q+CDC4bVgPYfpM+RXsVTXgFOODp0Q2+b7OjnTXe0YxRNfXs6UHOkTbSg88jPJefc7Bywec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzsXcHzj; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzsXcHzj"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f692d6e990so13284385ad.3
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 11:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717698082; x=1718302882; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BSk8o52vUQ+Qyq8B8MTk6cPGF0ySGQnrO8SDBVkJCNA=;
        b=EzsXcHzjEm64Tqi8D6iNU3eGQVEurMrTHQT005FgbgucVo/d32YJJPgIrWiFoyabFe
         J0Qt3pfYnsoU14HTH4hYF8G0t32I7i6M/scXVcUaK1xup4AFIdlH7e9pMHswwKhiUfEw
         efhwVctuG6ZKDyHj41KlKLdgRHmuqnC7UfFGJY5ttbIqAJLwpo/uTtjmAL9DzIuaefw/
         trr+Ydn+PeawHoC5lsHzYNulD3/J4er3CUGH2CKL9I5b+4n+kxXushMjm6H768RKf13l
         q1t2/X7guGAYVPTahsQsogtad0XYuCbOvfRBiVKdehdLCvSFXl23NtPNHBsP++PqxXsg
         wuQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717698082; x=1718302882;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BSk8o52vUQ+Qyq8B8MTk6cPGF0ySGQnrO8SDBVkJCNA=;
        b=qhUCOCL8+reqEaidb/0JLVqLjD4BUaYjwKrAtp0ClgHBJSeUtI2jh+H1qfwt3c29gg
         RwHjoVol/eQ6U8euUt8DpuCsjlaFLHa3v27Wqv1zbaGWL++9pheexbvOwY/EGcMch2o6
         8aJc8A9e2j6wHBhRRqWSnPkTLeC/M5moLffpAF80CQk20i2Y+KUh7O+DM+A8r0K3U6XQ
         lH0jGJWnDjlbZzuTwmn+MMB34IbIlS3lCGbmOEk6Wyg0sqdN45yZcjG2/pd7q59M9t3l
         WudhKT/zoOJKCv/x6yCBHgzcCHnGF1NdtYrn9i6bd9sigXWHPQGima3ZKYkVGdERRzVL
         80gA==
X-Gm-Message-State: AOJu0YwdIk4EdSzG9wgBWJK5CVxbAqyzNLv3ApnhpVj3+m0zDaXD6SBA
	sn2fAK69Ys4UGG+/z19n28mEGvtRJPKRLXNbjlJznPqtpx85MV5C
X-Google-Smtp-Source: AGHT+IHhEMxMXOSJbDCQQ2f0+jF6QtkzuL0nNzBGrEQYwsFKoyAkdoGSNdA2FOd0xAUXssR1J0czbg==
X-Received: by 2002:a17:902:dac6:b0:1f6:678c:9e8c with SMTP id d9443c01a7336-1f6d03be125mr3727135ad.67.1717698082128;
        Thu, 06 Jun 2024 11:21:22 -0700 (PDT)
Received: from localhost (201.204.125.34.bc.googleusercontent.com. [34.125.204.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd778259sm18270745ad.117.2024.06.06.11.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 11:21:21 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
    "Phillip Wood" <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    "Jeff King" <peff@peff.net>,
    "Patrick Steinhardt" <ps@pks.im>,
    =?utf-8?Q?Jean-No=C3=ABl_Avila?= <avila.jn@gmail.com>,
    John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/4] refs: add referent parameter to
 refs_resolve_ref_unsafe
In-Reply-To: <011c10f488610b0a795a843bff66723477783761.1717694801.git.gitgitgadget@gmail.com>
References: <pull.1712.git.git.1717694800.gitgitgadget@gmail.com>
	<011c10f488610b0a795a843bff66723477783761.1717694801.git.gitgitgadget@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 06 Jun 2024 11:21:21 -0700
Message-ID: <xmqq34pqlyou.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

ADMINISTRIVIA.  Check the address you place on the CC: line.  What
we can see for this message at

https://lore.kernel.org/git/011c10f488610b0a795a843bff66723477783761.1717694801.git.gitgitgadget@gmail.com/raw

looks like this.

    Cc: "Phillip Wood [ ]" <phillip.wood123@gmail.com>,
        Kristoffer Haugsbakk <[code@khaugsbakk.name]>,
        "Jeff King [ ]" <peff@peff.net>,
        "Patrick Steinhardt [ ]" <ps@pks.im>,
        "=?UTF-8?Q?Jean-No=C3=ABl?= Avila [ ]" <avila.jn@gmail.com>,
        John Cai <johncai86@gmail.com>,
        John Cai <johncai86@gmail.com>

I fixed them manually, but it wasn't pleasant.  I think we saw a
similar breakage earlier coming via GGG, but I do not recall the
details of how to cause such breakages (iow, what to avoid repeating
this).

Anyway.

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  29 files changed, 64 insertions(+), 52 deletions(-)

Wow, the blast radius of this thing is rather big.  Among these
existing callers of refs_resolve_ref_unsafe(), how many of them
will benefit from being able to pass a non NULL parameter at the end
of the series, and more importantly, in the future to take advantage
of the new feature possibly with a separate series?

I am assuming that this will benefit only a selected few and the
callers that would want to take advantage of the new feature will
remain low.  Have you considered renaming refs_resolve_ref_unsafe()
to a new name (say, refs_resolve_ref_unsafe_with_referent()) and
implement the new feature (which is only triggered when the new
parameter gets a non NULL value), make refs_resolve_ref_unsafe() a
very thin wrapper that passes NULL to the new thing?

That way, you do not have to touch those existing callers that will
never benefit from the new capability in the future.  You won't risk
conflicting with in flight topics semantically, either.

Or will they also benefit from the new feature in the future?

Offhand, I do not know how a caller like this ...

> diff --git a/add-interactive.c b/add-interactive.c
> index b5d6cd689a1..041d30cf2b3 100644
> --- a/add-interactive.c
> +++ b/add-interactive.c
> @@ -533,7 +533,7 @@ static int get_modified_files(struct repository *r,
>  {
>  	struct object_id head_oid;
>  	int is_initial = !refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
> -						  "HEAD", RESOLVE_REF_READING,
> +						  "HEAD", NULL, RESOLVE_REF_READING,
>  						  &head_oid, NULL);
>  	struct collection_status s = { 0 };
>  	int i;

... would be helped.

Thanks.
