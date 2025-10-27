Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8AD30CD92
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 19:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761592959; cv=none; b=PJ5bBWJn6nwoTdWP3esNGXAwCjO3DsPQdH2/PVrvMbC2kOYMIuhsm1703oRwvhDK0kQTj7uxgLZ8kllW5jmYEurfTPrdYJcwR+sPQV1WKL3cZaCwyrCtIe5M+CFFKpD0wjOgqFne+D3+o6osohWtE+mU8f4jsHUAsBqjuoIae5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761592959; c=relaxed/simple;
	bh=OfEZNhHk1BGeSabfK7zf/kx9lPGyeRdNNHlQ9o1dTW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYxhYe8v0TsCXWNvw76LKkKw0GXChvUqPDXsraJFPLqjJutZQ2qjHm1QRiwN1QyTvlW5F+u/DRd6CxM3PwzBJXoMXxSsqaESiPzptOkNyc8z3Dl2c5Nt7pI95qIC+AyOrheYkqN5DCKifhA+BNAQqMhgeUkn4Qz3Oz/3Uwm2yQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=auG1nLqn; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="auG1nLqn"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d71bcac45so52898107b3.0
        for <git@vger.kernel.org>; Mon, 27 Oct 2025 12:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1761592956; x=1762197756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VSYXbZ2CP/5nrROpn80S/RJbJzo99V7dpsKxPe2u6rk=;
        b=auG1nLqnWN+zxexttPFSdNS2bJkiPfDindpthp8Y9X1KiPENylylbqXw9c90X9CBtS
         32bK/1PkR5hMV3osalzqa3kz7wTxfxhQLGiblKJPx3TZoZ0MNFYgfkPaD1XCMTpG/C2u
         W1qh1FvRw2seSZCYTMSSbAi/F/thHCyon1768Rz/o2HUYuj6ZkOt0sI+zwabz3eVzGA6
         aeIDD3hZjMIjawvuwFUFkP0HlmVBszi+GSTQ1Gpc4h5T3XtoxnXSN7OhYRFk6juHvxZP
         vlUySTU0dP2BJAeIAWnOmItd5TzsoapoiK8ASzpeg4NGSIfxPHAugGSeFh5f4kd4VGyn
         YL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761592956; x=1762197756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSYXbZ2CP/5nrROpn80S/RJbJzo99V7dpsKxPe2u6rk=;
        b=ZsJzvEVt0e6Gj3GrcBFUhgettANqfDVuXgMAQZIAtrnR10XqEk3oX3WBdxOaRkx7UD
         mj+DRvgwJvVVEfpkAw7vhYx+tCj4YWEnDZ+2QdeVdUgdio3g5h/3JS3RzC3tl5BCEpn7
         XwgQz5ceBJ0Z2imMJs2xyzRQhBVd5Mlmfr2xj069f20mZq14m2cU3FwPIZImb7Yr8luK
         b/bCSS5G6sDZQcnd/bjUJwCNGqY90nOaqpS87PPYnbYqZe1nxQG0zbH0f8rJKP8b1QAZ
         WBziVim/yAUqFUScxkmNNclo7W/la3kq1Ra0iT30stPqx/gkfVoNTSqkZWTSgVZALToW
         C5uQ==
X-Forwarded-Encrypted: i=1; AJvYcCXf2gxXgJ+W4/oHH9MIeIuWh/9YxLfF8z0I5O9YQTiVO8opovLEc7BeEEXanlxODWLBtp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwswflodU6HelBn+R0P609BR0eVPVpr4Up/kTVXANjEzlwmGTh8
	irEQ5QxbKm2p5fVP0RUUacahJ7FQWhsDdOaQQAFIYTAKcQx6iT9+39w0zUmCXuJnkhc=
X-Gm-Gg: ASbGncvgOKtgYoope514FHFSuWdzY/zifPH0UN+fVHk1vospn4JKRHf9rdZWm3XTWNh
	RHykLLtNG8YGogB5VeTU/ZeHLfMz26FLh5kobrTy/+25MGBKKJkeqbP7m78/TPBy1r1bgtnZK33
	j59FmepPZGpisUFUnpQFaH0yQJsB/lLs7P44bGcQQLNNekprfLgRaPWG4tlHoxTSdLEnsu6+TMV
	7HjSEPHqryj0ikgQymp8HlND7KrXMxgoJfJbnFhXWyOuFXbsCV9KX6YH/wGPskkWoGTGxSiFyCq
	zf2kf+4K97U1SOdo2ck5wWQT/PRsHFtOP1H5R/ENhU8SoMVFtliInW12ISxSyf2+pahGaZKgKyA
	aUkHuLBg2lFMra5BJNQ2XB41284EwV2tIsj0lXZklESWnealEjpIZT1sM1caqwQfgmVivXjsqlc
	wZRLORcpjXUM4ukrhrGp6faK8AH9AfYfsyVzevXyOEcwGnMPLQ/rfCXUQq6z/zw2tzdxXaufFI6
	5ehBF8/+CR+5RQQnw==
X-Google-Smtp-Source: AGHT+IGxLzT7rn8OkTiY132ublw9yKDoExoDsmWtz7MSSGdZp5/6/+wYNyIKjg10K6Y9fElBDVHnNQ==
X-Received: by 2002:a05:690c:6d0d:b0:783:796c:c1a9 with SMTP id 00721157ae682-78617f61d33mr9971987b3.37.1761592956305;
        Mon, 27 Oct 2025 12:22:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7861aa05f9fsm304597b3.49.2025.10.27.12.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 12:22:35 -0700 (PDT)
Date: Mon, 27 Oct 2025 15:22:30 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] last-modified: implement faster algorithm
Message-ID: <aP/Gdl0kGJWklZdO@nand.local>
References: <20251016-b4-toon-last-modified-faster-v1-1-85dca8a29e5c@iotcl.com>
 <20251021-b4-toon-last-modified-faster-v2-1-f6dcbc26fc5c@iotcl.com>
 <xmqqy0p4uoqc.fsf@gitster.g>
 <aPgkwnq87UeusC6v@nand.local>
 <xmqqecqv1trk.fsf@gitster.g>
 <aPrByfpOkQ7biyEI@nand.local>
 <xmqqtszpqgmy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtszpqgmy.fsf@gitster.g>

On Thu, Oct 23, 2025 at 05:37:25PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > On Tue, Oct 21, 2025 at 08:48:31PM -0700, Junio C Hamano wrote:
> >> > Practically speaking that's probably OK, since we are unlikely to have
> >> > so many active paths anyway (or if we did, we'd likely have other
> >> > problems to deal with ;-)), but it is gross nonetheless.
> >>
> >> The case path_idx() returns -1 is an error case, not "there are too
> >> many paths we are following" case.  I do not see what relevance the
> >> number of active paths has here.
> >
> > I just meant that we are unlikely to ever have so many active paths at
> > once that (size_t)-1 would actually have a valid entry, or IOW that
> > active_paths_nr is smaller than 2^32-1.
>
> So?  If path_idx() needed to signal an error, it will return (size_t)-1,
> but as the compiler correctly caught, the code as written, i.e.
>
> 	k = path_idx(...);
> 	if (0 <= k) {
> 		/* did not error so we can safely use k */
> 		...
> 	}
>
> is outright buggy. I do not see why it is "practically speaking
> that's probably OK".  It certainly does not matter if the number we
> will receive in 'k' in the success case is expected to be
> small---the problem is only for an error case.

I am not saying that we should continue to write "if (0 <= k)", since we
will clearly never take the else branch. I am trying to say that
path_idx() *could* return (size_t)-1, and callers would be able to write
"if (k == (size_t)-1)" to check for that error condition.

My observation was that there are unlikely to be so many active paths at
any one time such that we'd ever want to return (size_t)-1 as a valid
index, and could always use it as an error sentinel.

Thanks,
Taylor
