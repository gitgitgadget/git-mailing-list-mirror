Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63EC17579
	for <git@vger.kernel.org>; Wed,  5 Mar 2025 00:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741133174; cv=none; b=enfGldoI705/8f0ADV1eaz45bmipzlB380ji3S0rOs5eoFoyenQvp8EV/kLu2r+CJmIljd9my70B3c1nd8+XLKKP6LgjYyp4PP2joF0NxY97WbJirsFW25kk7IJIa6m/fVlP0OkP7BRMYvRF7mHkD9E0nAKZLAOysHl9GDNGl5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741133174; c=relaxed/simple;
	bh=hpyCAvSGxgPbAWKDoZbx1V/vP+RpAF8slwZ/am+P/GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCOcXMb1VvKQskYKBfG01FIOA41t0SpGuh0ahzmYiWWblj1dq2Sj2RKUq+JWDhTPHz8O2OszfgGQO9TbfxGCVzPgbPl5l4iGehNJQvviybke4aE3htbduD+rwtRNUDcV8dlwyLvh/dPTz7OlEiTs4yMBQn556Ib6tSKJbVOiVOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=o5eLk1fI; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="o5eLk1fI"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e46ebe19368so5149841276.0
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 16:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741133172; x=1741737972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hpyCAvSGxgPbAWKDoZbx1V/vP+RpAF8slwZ/am+P/GQ=;
        b=o5eLk1fIcS0dese6+KCYr1SM3o98uS1LKDeJsQG0X+8MbaRzHZa9fe89a0KlfiwAG6
         RssQTXIZUfsPDxGv2SDsHmhayPrzvAd8F7o0EsLw8EdU6loaOA+tghBmoUWwu2JYP0Pi
         6aU8VsftSwCC/RMEP9WP4enalDJs3oYUg2OId60AKYjRatKHgqOzu++MDzOxwyrhkAGA
         OTyV26B/Lrk3uPg0O60ObM7az9bzF8dZHLRur5rHgT7xyW2AtYbi3UZX6iNyMxswOko0
         tASYM+xvdSGUMhxZOdwxitBatL/LD6Bq2FrJK7qN5eUuC0s66FP1V0bagKwEtaa6KK7e
         pWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741133172; x=1741737972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpyCAvSGxgPbAWKDoZbx1V/vP+RpAF8slwZ/am+P/GQ=;
        b=hZLoxtZsE0CUHfUQy63JppgixRcd1GRWHc+DrQKfZkc+6YBCT1yl3ciL7zuLdixxh6
         HUEygZdrLMOr9RSy0cYIpeckQrFlM5biNJOAAQv76n3C/hZ1q3uORbYlDaEoNhBd6G8f
         UcxXsXeGd5Vj4ieWgm5/k8NVpGOgKf48kyG1NU0lzkEB5CqN3sT9DBvD0Gde0Vl26p8r
         TRFN0wojKayxF2a2IYHYplAwZi5xujSqYFqkqhHxJdVz0knL03eauYJcsGZk9BmnagxG
         Je5OCOTMgqa/pZy0QbMIyKLqVvaDQMnRJVAh0syFcxFopIuGlLfpg8gQvtCbLNvqaTiy
         7pmQ==
X-Gm-Message-State: AOJu0Yznwsb+SlAHCoFBsRxQCKlZM3zMiBLAT6Ca588rG99cppa42mhy
	bl4HHaj15pVFOR8eoQxcAXvEs+QoqgIz4h6EbFfz29IZ7Yh24kI8/7rApp5bkCg=
X-Gm-Gg: ASbGncv+/8ZT7MGwssDfCCWj5SqudBhFrN3w7eR/0iQuN4CdjUw4z8YVutLPPtBkGwH
	nzACCdIc7jpH1czpJLy6ou3NWxuvpT6zFQLOVWS/per3yJesZ7LTLrya5IUQyky/XwpkZNLELf+
	A4JO2eGmAUbpESZKzuwe8jipRQPGBbV+PCdvuIt6r0We1zKp3Jfu/XqNjJ8MHplfl8LhtE8hjVf
	+a8RML1IG2TzOVTOoMxiAwsrJZWePfbgOoV/DBSenAslNecwVXAsSCZJds8evyPBNTxc2hEC8a6
	jlAHSS3MfBP4nT6/0Di0q6EN9Y3WX1lK0+Qspa7VOgF/WcjCUSicfhTRrdnN6ZmrnNbuDd2ac6S
	c/9NxWMDcslfVbm0r
X-Google-Smtp-Source: AGHT+IHOuHtM2sGPeqwl3K9hfoI6uLJomC2lgejeVoiEb7573ddfdaqTzY0MJEz594XKtFkb/uh4hw==
X-Received: by 2002:a05:6902:1701:b0:e60:a35e:b74f with SMTP id 3f1490d57ef6-e611e1e4c6dmr1885523276.29.1741133171685;
        Tue, 04 Mar 2025 16:06:11 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e60a3aa4f01sm3927470276.36.2025.03.04.16.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 16:06:11 -0800 (PST)
Date: Tue, 4 Mar 2025 19:06:10 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/2] pack-objects: freshen objects with multi-cruft
 packs
Message-ID: <Z8eVcn1wdnaV2VNH@nand.local>
References: <cover.1740680964.git.me@ttaylorr.com>
 <cover.1741124116.git.me@ttaylorr.com>
 <CABPp-BHv2_tgeQBKU6v4mnwU8_wOPHfPPRcpRQZ8wEP9P-HovA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BHv2_tgeQBKU6v4mnwU8_wOPHfPPRcpRQZ8wEP9P-HovA@mail.gmail.com>

On Tue, Mar 04, 2025 at 02:55:00PM -0800, Elijah Newren wrote:
> v2 looks good to me; though I'm curious if some wording improvement in
> the commit message might help in distinguishing between
> --max-cruft-size and --max-pack-size...and whether we want to provide
> any checks on the relative sizes of the two.

Thanks for the review! :-)

--max-cruft-size and --max-pack-size are the same thing from
pack-objects' perspective; the two flags exist at the repack level in
case you want to set a different maximum pack size for cruft- and
non-cruft packs.

Both end up as a --max-pack-size value when repack invokes pack-objects
for the cruft and non-cruft case.

Thanks,
Taylor
