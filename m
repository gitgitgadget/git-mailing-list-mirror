Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B517117C68
	for <git@vger.kernel.org>; Sun,  1 Dec 2024 04:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733027096; cv=none; b=b+MzFGjZqJbNSymICWKyOrevlciBbmj7io2PI6W28gNOG/O75yuxBsd22O5OCx2FoYdmk655PRySMO9pNFY0izhhL5b6G/nBs+2cAVVvRGWbkaqE1Ob7XgmFFUqjyN6dqmrt3zEKWn81DlVTVfx1qZLjYccFTu3+03WFxRRsoeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733027096; c=relaxed/simple;
	bh=Xh8QnDs1ws8uUhQTZ7ZY7HkVYPP757JKwLFaSOhS9T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwE2LoNWKAbvXMn3fracQTdtzTN6Uh3+G6gJlv8CwpNh1YM7cnXdV2TkMmleCBqwG48aKUoxAZ707sCdhEki6NkluMX9iSQivemge3ktyOmmVQjOyZBF/SAuZrCW75J2uTO4nP1O4m6AJLz+L8z34lEBW7R9twuLl4UaLuj21p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=TIvORTdA; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="TIvORTdA"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e3983fe3aadso1847091276.2
        for <git@vger.kernel.org>; Sat, 30 Nov 2024 20:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1733027093; x=1733631893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k7ciJivhATEN2tfZS2ekgJqV+tDlyS/pfCB1fSPpiro=;
        b=TIvORTdA4NYZm8jAr5EWJu2DaWqGMm2Xhrfu5Nj59VJRNdNFNidyQFD+RCoM2oO4ZA
         a6KAAayJm75y1PfWEQyJUmInZD19g/J0UUYTh5RiNxFeIy0JXiQziM/7wEbOCQfcvkuQ
         kI01HH6EvwogplDOwqVnsr1tbCM3TaHnusUFtnBpvx+NhFaHG0+RV+1VCdkYZ7Zll4cv
         Jc17IarubE1xvalssq7UmjEwtFvJfjijfyNA6I322IcQGnayULXLxrcqVvNFHjlr7qxW
         KVUDQxyI1zioCVWGrBDhlkhMK6DcwWTZ1LtCQ+xUf3BpY2bVuSW+8Nn6zsVfmPG1m+vu
         1gNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733027093; x=1733631893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7ciJivhATEN2tfZS2ekgJqV+tDlyS/pfCB1fSPpiro=;
        b=VRmnYSsvA9Rei+8ALj6Jk6LMyrFmpp6Qp1BKWRCc2T0Qe4g209yJXOoQOqA283qYii
         dwOwckVw0KCZHWlsBeJii6tjdYoop5RCCJ80twG9rL7zvNofUGQHTEVWk7K78k6P45Ww
         GnPAOD7xYwDQNrAd0cmspkeSt+vVh1XNWJZtO+6nknoE8a4AvBXhNbZO82EGEf4PqDUZ
         Rs9W/mUUqZKvoNU6/LmIo0nLKYC9UmsNmv8jZZ7JXWT8wHfnt0yR5J1uKxhYHWYl5aQO
         sItwiIH6Y3+0+fehEBQiBvnpZ0iRyznOXLlGiu22kEIw5XDEhDFU3dpKcs6e2c9AoJNV
         38OQ==
X-Gm-Message-State: AOJu0Yw6WlxysUNFulGu1RIX2PyfngU2t9fWIeUaZYvLOO5oNjuB5Dmp
	DpAgO76gFqoiqGP7sIPsRgpALCBJS76MrNFaJQdhxIob3D7VB6EHZbFf2IiNr8WIsgMtoFfltbj
	l
X-Gm-Gg: ASbGnct6IL3xS9DLJlhZ2O+YvcXMKXa9YpbVidrWMsa8WV/7l40fF4YQ/ob99DoS6oP
	z+2QGw9Ywy28XylHtX1w4Tw/kWgBvF+2DVgq23Fh1Z+T9A1xYfCqgwy7NrTsdXxH/64Zu3xo8N+
	6ceee3s5EcwYEz5p6qJfCjPR8uIoNSxEW+YVMWf3kjxb1+HeJbhJA6PzzjSPGgBtHyMIWel16C1
	8rJPKwnHnDAavkD5byQt3V2L3qiz5xhJ7Hym/FYR19gL3q8jSvQzwfN3YBleXy+fM8oDMWr5PGw
	fvjMGzQ4l/s+Z90gf0s3wQ==
X-Google-Smtp-Source: AGHT+IHNuFvwZibCMivmzoRtRl4ZN81OAm6xeKLDsmnU2TFbqm79oReiYckWToh28/Hqzr/VxpyApA==
X-Received: by 2002:a05:6902:1184:b0:e39:7050:f5d9 with SMTP id 3f1490d57ef6-e397050fae3mr12688508276.42.1733027093119;
        Sat, 30 Nov 2024 20:24:53 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e39768fb0b6sm1765004276.31.2024.11.30.20.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 20:24:52 -0800 (PST)
Date: Sat, 30 Nov 2024 23:24:47 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/repack.c: prune unreachable objects with
 `--expire-to`
Message-ID: <Z0vlD7/vOhot0qwc@nand.local>
References: <48438876fb42a889110e100a6c42ca84e93aac49.1733011259.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <48438876fb42a889110e100a6c42ca84e93aac49.1733011259.git.me@ttaylorr.com>

On Sat, Nov 30, 2024 at 07:01:03PM -0500, Taylor Blau wrote:
> diff --git a/builtin/repack.c b/builtin/repack.c
> index d6bb37e84ae..57cab72dcf5 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -1553,6 +1553,21 @@ int cmd_repack(int argc,
>  							&existing);
>  		if (show_progress)
>  			opts |= PRUNE_PACKED_VERBOSE;
> +
> +		if (expire_to && *expire_to) {
> +			char *alt = dirname(xstrdup(expire_to));
> +			size_t len = strlen(alt);
> +
> +			if (strip_suffix(alt, "pack", &len) &&
> +			    is_dir_sep(alt[len - 1])) {

Argh. This clearly needs a bounds check to ensure that 'len >= 1'.

I suspect that passing "--expire-to=pack/xyz" would segfault.

Thanks,
Taylor
