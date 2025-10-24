Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02E834C99B
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 19:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761332610; cv=none; b=K6MSOoPKt6ggAmFVQEzxK8hRw6X4O6o3ySK3vppJRSAQaHc22gmNuUUAtEa67GoAF78tkHiY/0klbpYuF3wRDNWg/w6gATZxDXNRjq9AoXuLnG1MhsBvfEkzQa6b6Uai7wm+64259W0qqxHsOdulXamd0jFGyXrre0OjJjoFJoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761332610; c=relaxed/simple;
	bh=+IYfWP1ppT3YfOfJ+GvuhvTjMBu3AyA20jlCDo4CrQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiYhXBWq+Na78UhO/dTgxOTFy9ui1cXLRpg22PI4gRvnMdwDV0ew3lQe8YO+BoKYBCA/gj+LVbRuvycZrvt8OqzWaSFi1wNabErSYIAapz1fJZh59Xhl0W0OQEeChtxKnD3iyNnVkEEuPV5sv1kFNfdirToduyawoOi63egCb2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=TKYwtwIs; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="TKYwtwIs"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7829fc3b7deso19670507b3.3
        for <git@vger.kernel.org>; Fri, 24 Oct 2025 12:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1761332607; x=1761937407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BMnWJ+zZOBIhPnXTS5JiXGNBlwS4FWOtcrxD16KCZTc=;
        b=TKYwtwIslZpHfUvAyG7Ven1UUdXrQux895Pk48bLVB2GAmZf+WDgZ68x9O1nAOuuSj
         VLKZv5SDwSv8Y6TXYO0dvc/Ngn7UxmPdCe0kWSk9G38yEqA0sXL0B8k3aVCoS+PG0jYE
         ajJA1u1/CqzzxdbVW+zr92o6vSEb//SHQSVijaj+3DS0XH7W2LUiy5yU9F8gePKiJPip
         9+iNAjxuxTu6aVHTdLbPKcvymUb66ocf2k/J2pcFYm9xIyUyCD1YQZvrn1h7DOjtuOVy
         X/BmaaevC4mpkYoCiIztFonapwKT9f6QY9RHtR8yvBFZVEkYPIZVpr8D8B6m6pWgPGKg
         YRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761332607; x=1761937407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMnWJ+zZOBIhPnXTS5JiXGNBlwS4FWOtcrxD16KCZTc=;
        b=SKN9zlHigw/HQhkrViR3P69UaVQ5I9LuERskfo04Kwsfn3emNiNMDAa1z0PNWWXJ4Y
         aw/SZEgu5Kf6crFRErlwjEb1ctWFRRnnFJsAEl04v7p4UQvzmsAcvrR+oKcYNNFvvHr7
         eHggjAWXHs0Yo2nL9GXkq459A5j+1+6CTPFElf+LKg3KSSggw1Vj3/DVJXcWx2KTfYa/
         E+X6aHx5bFAwjBwCbPjsmiTCBJAdb9bL+IsM6mTIaTScaH/DvOIM6SuP4lv9PFiNROAR
         4FktJHA4DNKQBu9VqFoB+ITU1TF9xtPWsCltoM8XDS8VScidwiPN/GoLfoe95fsy/SCa
         ajjg==
X-Gm-Message-State: AOJu0YwNWApXkuAjKc4lVUKT3BgEvuqPJMMyk0kN3wwnGx4YBZO5wHqP
	UXMBVLslDNi75lEBlUDdesSaA1UeoqkgUaEKrhesIflkkrtNQQea9FRzMKvBPMGxx5s=
X-Gm-Gg: ASbGncup7Es/USvNvSN3i3rH9rFQ/Aepr+U/E/GukkF1uYqmMkmO1bukAZDHiAqFAeA
	ipZL/MZtt9/C1OFG9vYU0dI4AwZuzpxN+MKNC6QVWhXBT2UuFUgJnLgcqdwQbRS/I/l/WzTw6El
	kDadk9cC5dR6KDgDSjy9xXtfyMYGa594eoJB++XvtMdEby+02PgCwABRAEzSRzEHFgnzredApio
	R2Zm0ojMw1iaMC3T9XUHZ63gY5KaPHZealElvGdAOQh3JEvleo29KLtViROW+xbnnB3wPrnHuqI
	pNjU9G2JdQ2vdKNRKAZPlKh+3LiUVwcFNzaFVjKInTGLiKca5bXn85LSSYhVZKLfnLUjPn6sWWY
	VsNy3gg0umhJnSKzYVO5QtgOpTVDHTt9nikTxlqhxkZqWC9XnilLjOBniCU2ECKdpowg4EgW3Sp
	rY3z4cv0Jd0+Xm9SxxT/XXezd4Q6vr9ULEwHQqlu0QPk0+8Agi/dedB8lKJT5J54BfVFXkNKDAO
	4gaZynqSZMmgSfR3A==
X-Google-Smtp-Source: AGHT+IGE37ie7ge2jWUgmzMx6BiXfL0NUdWEnJZHQ/al8wL5RG4BaulxfztChgtLulH+GU87lsWGoQ==
X-Received: by 2002:a05:690c:61c1:b0:785:bfd8:c4b9 with SMTP id 00721157ae682-785bfd8d1e6mr101504607b3.51.1761332607496;
        Fri, 24 Oct 2025 12:03:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-785cd5b0f33sm15106287b3.4.2025.10.24.12.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 12:03:27 -0700 (PDT)
Date: Fri, 24 Oct 2025 15:03:25 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/10] builtin/maintenance: introduce "geometric"
 strategy
Message-ID: <aPvNfU0B8J9sRy//@nand.local>
References: <20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im>
 <20251024-pks-maintenance-geometric-strategy-v3-0-9b5b3bdb4387@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251024-pks-maintenance-geometric-strategy-v3-0-9b5b3bdb4387@pks.im>

On Fri, Oct 24, 2025 at 08:57:13AM +0200, Patrick Steinhardt wrote:
> Range-diff versus v2:

The range-diff all looks good to me, so this has my:

    Acked-by: Taylor Blau <me@ttaylorr.com>

Thanks for working on this! I'm excited to have an easier way for more
uses to interact with geometric repacking without having to juggle in
their head when they should use that versus doing an all-into-one
repack.

Thanks,
Taylor
