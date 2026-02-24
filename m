Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662AB2874FE
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 18:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771959216; cv=none; b=a987nKZzNaSnv3VUF0JHQuLyBurQoLQgjN60nXgE7ymoMvUFfgCmUot83UaAGIrShdsdE2mH6lS09dAz0BLK4BkdWyIme1aSzYL/qaxBLkO7KEwCpDCSUQYVJlwZmriIu2JTBvx/A8fd5vgQiGbQAZzD9rqVIuKkdsibfQkpl2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771959216; c=relaxed/simple;
	bh=OzhhB70+Zq8D2b5R8f36MQ/AB+bNziyZ7gCNNigX7YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKs1VnFtj4araFg0aTTmwO7sQ7X7dls9G5NGenk7XXtIX3Ba3NZPzDSvStR/PWRWyOUvGQJmL0O3NZZiVxLymOBtGy9H0A97J8v5N6EsXz/14ePffZShS5keDZETH1dla6s/8UpVDcCCy9jJKokz6lUiDgqOh1/Q8Y/c04c2oSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ei4AFV8U; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ei4AFV8U"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-506e287dd53so48197561cf.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 10:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1771959214; x=1772564014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4T8QAtnrgZRlnISJSQxHoWAGBf1VK5patgEBTV6tvS0=;
        b=ei4AFV8U4rmII1ms3iN0wevneU17FxccuAG1Q1dO6RM0ZEndtuahB9oB5Xmjro2H0V
         0rOfitgl37vpRHg9o+EYPYUI3YTVTqahEotz3RNHwEVYJYKRuOVvlB4TzC37bHu9e7yL
         wzVlaciEVpbXXVrOaTILr7YWhEcOHajUKyQaXrRMbX0Kybq8Q8HIe8+xkqSst1xTld4F
         CC7CI5v9ZZY/7/QrdJG7lDN3YZcLN+E1dZ5iVr0rH4aqxrgigLLGUHXTF+iuBFngmyA8
         0PBpt8C9mg5Mc83RRik1Gju/pnylo8S3hRpnb6aQ3KoyjOcSo/VM1lz1jfBhCp4Wpr4a
         zk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771959214; x=1772564014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4T8QAtnrgZRlnISJSQxHoWAGBf1VK5patgEBTV6tvS0=;
        b=Z2nizNU1kWY/8U8BcSM9D5rB8MIpVKQzm4InCJFH7cTWJoxOFsVsmdvGIFMSV2HFXY
         JbeaEznIBZjmPRupLs0Y3YWDEYUN4xtojHFu11QQ/RUbTLc4NSaBj8LSOupaVvAXeXzp
         jei6/sXc4+7doyDN811ziSw94hQQlOhnQGkZOsjWVEY/ZC1ZX4UThL4SKDnu4q7RR0VV
         +6FdZt534irXFJvn/z0OklHnW1h9QAoouErLGSyStyw18rlwJZB2E55xsgFM3gtXys5h
         rb42gNuSMDsUevUNr9Sjn6K8BRjGjDcaqKe8Nb3L507yAnJBlkUvnPpN7MpuZx4cLw0M
         6CSw==
X-Forwarded-Encrypted: i=1; AJvYcCUqPBSK59OnFfS/VgmlXfmWQYplGMDQeIQF4QLMvUJZ8uIxHi4cfGHF+F1VtjceTf3M6lE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjpytfN+7rH4raK1KVL+oBewAVtmhxKsI52EzUY9tMClKi/QsD
	ZxWyLYhIMeo4wqOU6pJ+hRjJm67sR6p0aijqRQHHa2krT1nafq0rnZcXyFQJFCZu9cg=
X-Gm-Gg: AZuq6aKQAMP/88F+GHPkKTImrzpbokjvOH+nPsLqGtl67Qob80M0Vs7mT9oD2KMQJaH
	17nPmuh2hpp9V5royF7vI4vhyKbOAkJK32QUIc28xrd3x/JNj/JbiRhmYYgiaynxH04d0WDYOl9
	aNRcaHteKgikXr3fvNSpTm6IC6VEB0aR1EUwhaEBQJr8yMFSDIwiN0sqf5E/9SFtNqZ0ge8EU/D
	XK+/fg5spvtDFBCBzeSCxehuxS6lq81dlHS2UY//wxlactZbdwjvtdr32/+BVRFRBcDSZalu7DK
	DWv4MWjt1F3216uPpOrCWe6H58VC+cfsCk6KkqOK8QymycxrMoUo6voY1etGJc+3+9BXB1qQ4dK
	anaZD0s6gDoC276c+euM4sczAHECeJWDf3kqPw82v7/EUNNfQkx31IeZcfQyhT9hFp1kXdH86ca
	wvLnreGi7RjvTX0j2Wt5ftoRhSnq077/L/1fa0zTwXDTWn8auiNCvcefK5x1WCZ73SsN3l+t3Pc
	G9oxpj2j0XWiBFtdWRVR0UzJiNnzg==
X-Received: by 2002:a05:622a:293:b0:4eb:a192:de99 with SMTP id d75a77b69052e-5070bd286d5mr165732661cf.76.1771959213928;
        Tue, 24 Feb 2026 10:53:33 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d50c920sm105880371cf.7.2026.02.24.10.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 10:53:33 -0800 (PST)
Date: Tue, 24 Feb 2026 13:53:31 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 11/18] git-compat-util.h: introduce `u32_add()`
Message-ID: <aZ3zq0QEd8LeBxUG@nand.local>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1768420450.git.me@ttaylorr.com>
 <c0c1769464b1c8065c2cea59dfd85a1d37de9dd1.1768420450.git.me@ttaylorr.com>
 <xmqqpl7beugj.fsf@gitster.g>
 <aWgSzI30k0BZfZ4Q@nand.local>
 <aWgwn2rk/qw+fRoA@nand.local>
 <aXCTkVpjJkTabx_0@pks.im>
 <aXFni2tE7vn1dKFp@nand.local>
 <20260223134935.GA271392@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260223134935.GA271392@coredump.intra.peff.net>

On Mon, Feb 23, 2026 at 08:49:35AM -0500, Jeff King wrote:
> I am to blame for the crappy interface of the st_add() etc functions. It
> did make conversion _much_ easier, because you can do stuff like:
>
>   -foo = malloc(nr * size);
>   +foo = malloc(st_mult(nr, size));
>
> as opposed to:
>
>   size_t total;
>   ...
>   st_mult(&total, nr, size));
>   foo = malloc(total);

Yeah, I agree that the latter is far less readable and more verbose than
the former. I think that your reasoning about why it's OK to just die()
here

> My rationale was that size_t computations like this are OK to die() with
> very little useful error reporting up the chain because:

All very sensible.

Thanks,
Taylor
