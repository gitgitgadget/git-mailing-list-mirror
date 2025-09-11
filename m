Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6E02DC77F
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 23:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757633832; cv=none; b=Mh2iLULuyQgqu7bYxlue1cgHj3/2D+4+PHUrOrOaZ2cwKzIx7ZrGyqBCCYAylWOevjxqDlqle5hJrXF4IoybGCGb4uO78+BRlGNMyJlpCWYQ0W1AkgxuakOPxf+gDTmGg7htPB2VxmHRMh0LeMoz+V9R3BzLPDMDwgjRGguv3l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757633832; c=relaxed/simple;
	bh=pVZAJ/PKqW+RLgjiDCE1YOj5mGgtrPh+GWTLwgXAhwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PR2O98oyttTFjug4PCGfoSxtEFuQplE5P8Em22CihNw4C5wXIctwYuR33FkKXUhxXX0ugfs1PXkXnlZPHoV8TVJD64gQjoKGpW7+g2Rqbi+X3SjIOROg4jsrIMkm13v0WydgeCq1MZ8Ob27rpa5BpZr7YgQltmijA5NicE8znQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=NlN99gJT; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="NlN99gJT"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d603cebd9so11273697b3.1
        for <git@vger.kernel.org>; Thu, 11 Sep 2025 16:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1757633830; x=1758238630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XcmguR6nVQccUog4VpysEymyLILwtfoarPPPBBfuus8=;
        b=NlN99gJTUtkd8kgDxb6nBZWTcdt688ip6w/WMm67MAL8j2Vx9QbJmEgRn/4QGr/yrf
         2fnGMWeErrMCrFX1W3d3TkO25oyAGIHIfXONcBYoPNaLP1nJN8nzfINJ+dRGGthBtZ/n
         nUMMNJIMQmSDhXEAh+ERSqnYbKQw7YEUcdIzfB/EfTQOuOQylrI4EXrzEKzcvUjyucO6
         OeuJIHqEnsRFS+ZuSja8QPmfyQI6QJhw9mQiyOpHitfPYcerqt9Ur4BNjQJPuo3ZRSEo
         2Fy5OUcTeXm/C8JzvLUnGDNDXZ/zDhil2uhRJhOTY7xFFFmyyaWh3va3maF+nldeG0ga
         qsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757633830; x=1758238630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XcmguR6nVQccUog4VpysEymyLILwtfoarPPPBBfuus8=;
        b=erQv0K+yn4zFavOG4sV1iYcHc7g3wQ78yPI+Dypuqu9zYx+isxNrLav+LDuclrUFHj
         1PnOieBsoKp2tkYD+Tl1e5Yn8lBBKrKPNZQDpkmB4NR8Z1oOqbYvie/OI4pHUclx398y
         VyD6nM/mvQLJrmSwBXLHqF6Ia0dVbzXcX/BHlSzJ8N+fTC17ByahdqgT1br1+oBTvIZC
         1VIMIosY7xyvBlFoLnolzs5fuZvGOwfxQhqpPdeRfPv1TNR6m1lI/PHnsue9e1G++xRn
         3SflZXayWFfV2ojzdsArVz/QFRhk2uBQil/HKCa3+cWzZViNto7OmTqbY67Xk//Sj6uq
         dutw==
X-Gm-Message-State: AOJu0Yx3i9EMTgQo7yKfc3KqVL0M/4NG592TgwEdeO52ZMsDN4qDIEKu
	X0ZF+28tjq6Dif9lVQdwFzmJ0hHX+OuJBS3B+cCuVtc2YMwfanO89WPUpSd1LI9lY08=
X-Gm-Gg: ASbGncvh3f3mcmiany6Zau9zq2fBjFGHG2JRC5rDdg3eBIWv47BXNkaOh74UvakKL3A
	C5S7MzwFzHDt0CpjfZz36YqbX6X1xxS2smqFMdqzKT12yI9LvATKUZuFsLsqB1H/C2RzwdUD+Qz
	eH9G53qX7gMOal+BOapemZ4Mz0Maff5PZLmU/6YyvjkPlvunDUG8S5Ne+TnOvTtfADGqkFBfhrt
	Z4ayGZ4p1mW53rDHN+kdtwE+JfxFW7gWxLvVlCb8W/UFur5vKWVMwmvFlZWOhWWPuj48M/RuR7c
	mYKs3HIPDiaQxurB3LwIEMEclQC9xWX9xp7h4HzE/XI4g5Lky1eDqvpg7jx/jsvOlBZtQUqVIqq
	jtPCunI7aVYl79s6e/udQqFZJsmfsgBQleORSJS6BO7U1MfatWrQvxpf2K/cG1CFj73kfSXfKgs
	H1dgxGAdUDqmUA6kc0LCNg6o8psrCfGktyfNY4
X-Google-Smtp-Source: AGHT+IFN0s5EFFTMLFFrlNg/NlDSzuc8/OT7DBxQxFKqp7475StFDrrgyQnkdpzMC4qEiU6Hi3zGyA==
X-Received: by 2002:a05:690c:724a:b0:729:8822:a67a with SMTP id 00721157ae682-730656d0d06mr11584567b3.49.1757633829534;
        Thu, 11 Sep 2025 16:37:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-72f791a38cbsm7093617b3.42.2025.09.11.16.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 16:37:08 -0700 (PDT)
Date: Thu, 11 Sep 2025 19:37:07 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 13/15] packfile: remove `get_packed_git()`
Message-ID: <aMNdI5O96+RHbU+x@nand.local>
References: <20250909-b4-pks-packfiles-store-v4-0-151c4ba3619f@pks.im>
 <20250909-b4-pks-packfiles-store-v4-13-151c4ba3619f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250909-b4-pks-packfiles-store-v4-13-151c4ba3619f@pks.im>

On Tue, Sep 09, 2025 at 01:03:12PM +0200, Patrick Steinhardt wrote:
> We have two different functions to retrieve packfiles for a packfile
> store:
>
>   - `get_packed_git()` returns the list of packfiles after having called
>     `prepare_packed_git()`.
>
>   - `get_all_packs()` calls `prepare_packed_git()`, as well, but also
>     calls `prepare_midx_pack()` for each pack.
>
> Based on the naming alone one might think that `get_all_packs()` would
> return more packs than `get_packed_git()`. But that's not the case: both
> functions end up returning the exact same list of packfiles. The real
> difference between those functions is that `get_all_packs()` also loads
> the info of whether or not a packfile is part of a multi-pack index.

Just reading the newer versions and catching up on some of the
discussion here, I want to point out that my earlier comments here
explain a case where these two functions do *not* return the same list
of packs.

A future version of this series should either prepare all
"get_packed_git()" callers to handle packs that are part of the MIDX, or
drop this patch and address it later on.

Speaking personally, I think that there is already enough going on in
this series, that punting the clean-up out to a separate series where we
can discuss the implementation changes in more detail would be the way
that I'd suggest approaching it.

Thanks,
Taylor
