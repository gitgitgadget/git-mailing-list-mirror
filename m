Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F04731D72E
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 23:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784591702; cv=none; b=dM2I1Ju25XYZ0BTLxQ9mtaNCHuKhVWccbyaBqSDC0U0Mc0rkzokjDxtbZnwRwiObeRll50Qqc9ZplTR+ROxPzIoPiD2HRBbzUtzfKnz+s2rC5BLekPnzOHoKADlaxoYM2rv5ZbziZlLxVGPkJuZE2qWWlMHPg9ldfHXfoE+t4AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784591702; c=relaxed/simple;
	bh=hMRHwahkXbE01E3z9yokC2KjnOGSzlaHwJcik3lf2B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzBCPY5bRJaVINZjS6iRfVNh56ZybgNBuAz+ccLLC5hIme4jaWh1Qri5KfL7L/MB4TBP1jLa1jq89GuEILPp5wDJOMqNugTQgULae0uGJu+XruIlTahesZSZ/RQRLNpdQbB9Db3G08QSpxOvrVdh7OFTA+6dY7KjSPo0wbl85xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=ZceF/mr6; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="ZceF/mr6"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-80c5cb9a888so90262817b3.3
        for <git@vger.kernel.org>; Mon, 20 Jul 2026 16:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784591700; x=1785196500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6DPydGdDfcik0xsRXXEMYfz7Q3CnW6GhulpRR+3n1cY=;
        b=ZceF/mr6Y217xmvAsQwnjDukx7ZgFSgtzjrAjb8AO520yGBcMtBDclL44YLMBFOgja
         G8/wdXIrH8xAQ5BXXQlKfTEzV/cDEjbxqSS7i1OsEy+ls3wHqj3CMgTLGs0HY4X/GPvF
         sjuMXNdnrsBbGeHWSu9xp3Obwbv/PA4vASxlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784591700; x=1785196500;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6DPydGdDfcik0xsRXXEMYfz7Q3CnW6GhulpRR+3n1cY=;
        b=QR+Zp65P4YGvkQ68ckw7IVtcZbYGUnX0R/8iajiyCLGyCuq/exAkZg/WlwGzY0zrAx
         e7UU6l8TvJsoQKNcuWg4snWLYQxNwmCMKZ3CpYUDL6eGxan5mS4DrIMCg4m/aq/6FYUn
         yiWHPqeLT63pxR32rKX8JDce+rsLssJhh2Vk75Neuyr37uMtEZ3LXqjFpwejNuFI4doo
         0DpHD6FYirvplHL5oZBJmn7Jl/+yQnm3rz7nYNY8EbQQgehyh2qsuOoj80ba9ib0uzfJ
         eYRSOwVyFjVj1eTARegzZwzRdPJzpjsNqxuTHOWi9x9g2y4t2HtwjDufaaF8G8A7Pu60
         9f4w==
X-Gm-Message-State: AOJu0YxKHzCaTMJWDALFoJo68PnHqiFqRgwhIVYl+2lV7efk5VoQ++/L
	lnhlzUu27b4CuX0aE6SVFcp6XkjidHN3cfXgCZ3euAQTvDaTkofl3/NmI3Jxq8aZWKo=
X-Gm-Gg: AR+sD11rFeCi7GMfS/HWTRif2vZ8eiYBP+avZTY/4aNibcqPp31E8A/fmWZ+npNXWwj
	bFlkemto4VTA6rJ7iRq2k+pc6j/IXcVPXJh69KzWcD1rQcyuRI6RmxQUkzAwSmlKsmv+0lrQOYi
	1qV8zYuSNOx7mmJajxXU4iwDm/ABuonEKnzW+nnCrOgXeWEahUBAV3MiCOKTHMm2jcUUa+5kadY
	7NmuTSA1xmmOwk2uFbWdgTubrUptDBnp7dguJLweDRgJHI+eOxwsn218dDpUW/WovafZPCG1+KZ
	BsH6TGJ1di74PX86gYdf3PbvEy+Pyk47+DVb1JA+4ZR1oKG3iCs7yX9MAyYU3jPO8t1I9tboF19
	/Bz/5O/CGA/QfsuJKs1AllCp6I9HturXEeGD5sp8JA6Ws2m+xuCgLCWfY0VcpZvZAvLsmxy6fqB
	VSSmKGf3rC5264ae9IvjURB1/qWXD5n5v8iv2pqDHsTNjdetMrdGJxC/8DPVvJf4rLbGVZdw==
X-Received: by 2002:a05:690c:3344:b0:81e:79f0:4898 with SMTP id 00721157ae682-81ef26cd1a0mr43738137b3.15.1784591700196;
        Mon, 20 Jul 2026 16:55:00 -0700 (PDT)
Received: from com-79390 (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ef4058cefsm56906957b3.18.2026.07.20.16.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 16:54:59 -0700 (PDT)
Date: Mon, 20 Jul 2026 18:54:57 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: tnyman@openai.com
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
	Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 2/2] stash: avoid sparse-index expansion for in-cone paths
Message-ID: <al61UTM0aK9j9eiP@com-79390>
References: <20260720223118.62821-4-tnyman@openai.com>
 <20260720223118.62821-6-tnyman@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260720223118.62821-6-tnyman@openai.com>

On Mon, Jul 20, 2026 at 03:31:21PM -0700, tnyman@openai.com wrote:
> Signed-off-by: Ted Nyman <tnyman@openai.com>
> ---
>  builtin/stash.c                          |  4 +-
>  t/perf/p2000-sparse-operations.sh        |  1 +
>  t/t1092-sparse-checkout-compatibility.sh | 55 ++++++++++++++++++++++++
>  3 files changed, 58 insertions(+), 2 deletions(-)

All looks reasonable, and it's very nice indeed to see another one of
these /* TODO */ comments go away ;-).

Very pleasant read, this series is

    Reviewed-by: Taylor Blau <ttaylorr@openai.com>

, and looks good to me.

Thanks,
Taylor
