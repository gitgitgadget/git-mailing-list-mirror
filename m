Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875663DE427
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 14:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776348940; cv=none; b=R8TogtNik8daZeiNO1VQ3ltMFzSy1KWXIhciYYp9MHnOf4e86EF7xNiTcPLBOILzq3xwcm3I1H47u/oVQiLXpNPUQhy9qDEVu1yv3r+RMhWw/LuPHpUyg7db8//85P23cppR0gb+E5bPljUZLVPMMFynOnySCodY8+xNVu1p6hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776348940; c=relaxed/simple;
	bh=oWOGIdmafTL4WOYxboGbf/Ke6qIoiGVt26Iwb3JGatM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UN1BKDGGD4AufGVXIiI4wkV/cI1onTYBgQRMvK+5NNcjdHTCefc3eT/H6mTkVdGrQ1fpC98lHuoGNgGPNLabvRD1i9xu21/sj4IiSHUOq5nWd1wE2mgKde4Oo99dtprlOdhUDjoMeTUTgx/uLlkfFIySvkOCInQkyCeH20rNFmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7AeK3oo; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7AeK3oo"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-6058a955e04so453997137.0
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 07:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776348938; x=1776953738; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AVY69b1/bJhhzbRGa6CIPHKWMeT618O9IB46xAGwmc4=;
        b=c7AeK3ooVEHyB4oEbPakfxCoD0aJf/uDODJwXBucrVMjDUVqh9s6T79+BnYyHeYm2A
         ZewnlstkOfso0ujvbTIWaZHoMhaxJH3N8RWYrsCC1BAwaGSXxbEqGpw/FZKgfHbhDbee
         Rm0U0AAnX0wjiMx7rQ6CZwenCGl1flyGJi4LgeC69ls082avejdt4a/obXMMvywVZEjD
         45fhfvuOdSlE1R1/wAxhDJ8eY5+wmpnEVVZll9KYHmwCLazxPsXnsfCvjL84DBlxe51I
         ED6qgNDAx/M3FoSU2n+MHtnSvqaUJBpDwWRWY6CeeR0977O9KGyVwpeIcqqXD3piyjRQ
         taCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776348938; x=1776953738;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AVY69b1/bJhhzbRGa6CIPHKWMeT618O9IB46xAGwmc4=;
        b=JBeD38g9glXO7JMrFW6Afaw/r0oKZtZSeZ+bN5Vhq/ETPluvVMhp0jaogx00HprsQM
         7J/H4J8qTLcuajG5t548hEVFRrqyR7MTxlgzXoKu3TFjm9GWoYNBP9ScTWBl+bfWjckd
         kgpBks/kfKDIPhSxuND/P/rulfOdhNYwK4SRtbvSnpVryaTJxf8IVBB1zphAejWnq0y3
         1hfAPU9mArk6+HCLwrxrQrZB2eu1EzkTyofI/toNtet15BJ9JGh3TGEmRtyUWbRaxF4A
         093Rc/Q5j16CGax4p09qaYYbgL04OglBzexj7EGcuCEGnjsZ8QoN8BKNBcSnchfJu2VV
         JESw==
X-Forwarded-Encrypted: i=1; AFNElJ/xIEfJo6oTSYB403YCMqflR2OwXS763Zxo8jzsrJjQazOkqVYzU5QFwVCCtAzAx7cglt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVfnnnyi2ob6E8AsnrEOJLF/H25JkzolKnK08PeSAiICZa2qWv
	Iz0qaw/AeKS1vkpNruNP4/w6Q/E1x8RpUCDLbTHa9pM5Xku31sotT6+e
X-Gm-Gg: AeBDieua8ddxuSi8pk3yXA4vTVR2WJkPXGIm0sv0O1mHlYFyzlS8+r2loW6fVx6G18N
	2Pq3eOzWo2UT9OA3zPxTlM18V8bdp14JsA4qfwMLKcEycZK9zL9FbR48Q7vcTDf+o64ch4pa62l
	oAOC/93g/0o7uDCRCdX8ucvZuG7hNyeCeb7KLncPIzJ6HnUN0AJXxOMirRcO4UfqkaeVWFvjFvF
	kEFIkkGppLGNfXSmX3yhcCxASLhlYbD6VgmoP2iWFU7vm4M7UzG0G5AHdFnFrAh5UHvDee2+LdX
	T4v+sLSANZ+YDFA5qHwqWoJqCAPrctutV67bIzKzPwKFIfJ2N03+2iKZeN8DW/ch8Q+RF/QBGcI
	hryLt/xSaCIipn8AnU1uM76HSX3BtJVOXQzeaVJyLZoHGDW2n7E46njMq1x4h916Xvdsqx/WZC0
	XA7loQxNIUMfuSSDpb55U4ayBSkMqhSX2uxROrpqut48bWDVHVLfZHzldE425Jlg7dyflwFw==
X-Received: by 2002:a05:6102:5695:b0:5f5:3739:100d with SMTP id ada2fe7eead31-613b7838b07mr1705335137.0.1776348937973;
        Thu, 16 Apr 2026 07:15:37 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6ceb80f6sm35649396d6.46.2026.04.16.07.15.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 07:15:37 -0700 (PDT)
Message-ID: <74af0a09-4c1b-4c0a-b5b3-e5044fcd0aaa@gmail.com>
Date: Thu, 16 Apr 2026 10:15:36 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] backfill: default to grabbing edge blobs too
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
References: <pull.2088.git.1776297482.gitgitgadget@gmail.com>
 <607ed38e2a8ae94266b4a3d51610e604cca8df4f.1776297482.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <607ed38e2a8ae94266b4a3d51610e604cca8df4f.1776297482.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/2026 7:58 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>

> Add an extra --[no-]include-edges flag to allow grabbing blobs from
> edge commits.  Since the point of backfill is to prevent on-demand blob
> loading and these are common commands, default to --include-edges.

I like this option and your motivation for including it.

> @@ -116,6 +117,8 @@ static int do_backfill(struct backfill_context *ctx)
>  	/* Walk from HEAD if otherwise unspecified. */
>  	if (!ctx->revs.pending.nr)
>  		add_head_to_pending(&ctx->revs);
> +	if (ctx->include_edges)
> +		ctx->revs.edge_hint = 1;

This would still work if...

>  		.revs = REV_INFO_INIT,
> +		.include_edges = 1,

...this was initialized to -1 to allow for "no user option".

We don't need this change unless we were deciding to make a
config option that specified a different default. That seems
like overkill right now, so this doesn't need a change. Just
something that I like to think about.

I also like how your tests don't just verify the backfill
behavior but the ultimate behavior of 'git log' and friends
after the fact.

Thanks,
-Stolee

