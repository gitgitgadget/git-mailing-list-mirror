Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325DB3191DB
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757094443; cv=none; b=QYozXa4Pik/GgR29wBULE2o59iuNkeEwG/Ko0dkO9b0X5NS46YOtqolaSDXuRkbLKcKujetuf8NqARBvk7tiKnFJkipY4uG8TT1t4QAV6ZLVjm8fJXKByU/dFM4QgOQolXvDO+g4NO+0Fab5ODq8zMfvNAcNstz3PD/zpcgUmUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757094443; c=relaxed/simple;
	bh=dkstoGOx9t/AwF8w7e7z2J5qhzbK2QpZznDH9SCD6wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Guv24Hg1icI0GGF22FBoUSMNUF00KnTG8VxxH/pxcuwI4MA30tZ02FWSGXtPCwc7758XJ57p2yoFbpvdnRF5+4fRVeAP9+gImIgIIJEXGq1wXXOWLaGSF9pUIzLmO6wiXKr7b7cdSqXGgZe3pkjLZ0A6+t3jIu9S5YsNQhEZnnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9YzB98i; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9YzB98i"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-30ccec59b4bso1985213fac.3
        for <git@vger.kernel.org>; Fri, 05 Sep 2025 10:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757094441; x=1757699241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FSlyqv63fFwnV8UDkR/A//YN/jHhOjqtlU15AoCePK8=;
        b=k9YzB98iYO7FqZYt3Y2dqhPPF6Q0qyaq6dVv8iETAItfJMp01Gs5bMYaKHVf9/GS/m
         hRsZwLN6nQxaFCwJQaDe03OLcCLqJzNpnql5PI9ryYfms9gqb0H7u5BeiZtWMY1yHvPn
         AZtcIgH509cpQiWyAaOkMTI1KoM5ydZclezWhjP+zWeurLNsQK4iJ3CdR4GPm2NlvRVM
         2UdDLNGrhcH6VWBYVLAZWY6nv887uciQ97eRatYN7v5qL86E++jnpUrD3qSQ6wSwzMPu
         uchww4ITg16XFwt8NfYbHloKe2p92Y8K8yHDaalFBygq/RAkYrU/TMFoBTAZOTxo2Y9x
         GhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757094441; x=1757699241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSlyqv63fFwnV8UDkR/A//YN/jHhOjqtlU15AoCePK8=;
        b=mYzbMxNygD2eKayIZo2velM8t0hO3GbikJ50snS9L4OKHWXBmCt3xiwXgcEsqkTd+w
         qL4Z188LG1UHU0/qgVy5xKULfs66N6Ywc+ZNSwsNn8llvP2B5B2ErI+/KWFCwKS5kUn9
         RtrWGMS/4YfmSXOC7u/b/GXdUSn0730XTBAYUwJykXWga4lXxCd4QzL3U0Jt4v3NHkwF
         w19gwqxrPxhxfRth06l+F+izlmd/Ge7QHYoveDQ/2XtDBco8vowXKRlXf8iTp6ZK2btB
         6beWSLIUZXWYS2vi1MsxxaL+cqvcoyqmjsqWRcWO9YKonK0giMgznlg7GEUmEGCBTND1
         RJag==
X-Gm-Message-State: AOJu0Yz/5m2lX073eW7qIRgypS+s5ippQEfz/vhzxvNdWWo8HSrhF+Iq
	qR7WjHAwgNiUCh98xDBsc5WsIKyUENeRXdbc10p+CCqGcGqvQTsUpEcS
X-Gm-Gg: ASbGncsuEqyOgYwOrKl88UQHUePInRVhGigED9DX/ImSxU/NDJX7M97pxOIOj1fmHWW
	CfobLRd0MmLgX96/NwZQSf5GDK1BQaoLTaRzJ8DyzTAnawBNFhVyhMqAhX1RORCB5Ahki881wOQ
	t/cfio/w/oLLcgHznwNMyljU1NS+uxlSU0/0omk0bgeLE9xg/pvQc3TV9IFW/sA0Xs3MBcCLBq4
	jaC370e+jJ/VY1kYbacUuFUkQvUKPHohUm2vuPd0PnmdlXB9MrCfDekxL6STTRitd6KSnDTovKV
	pG0DJU/dOXl+BcPX2vyJdvUgVFlF36YsFWZXc7F0WCQ2W/haDcY+s48nrafuDVToABAx/iTp6t2
	pf56HPW8SbQQVND4h
X-Google-Smtp-Source: AGHT+IFTtSOKbUD396JTmltx+AwC/qxXgX6B3XKxC80cks1uIDHLFJAzzvDOU9fqXzOh6U5h6p+ETA==
X-Received: by 2002:a05:6871:1c6:b0:2eb:b6a2:8d77 with SMTP id 586e51a60fabf-3196334520dmr13661398fac.29.1757094441311;
        Fri, 05 Sep 2025 10:47:21 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-31d6b4c05ecsm2891279fac.17.2025.09.05.10.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:47:20 -0700 (PDT)
Date: Fri, 5 Sep 2025 12:47:20 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, 
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>, 
	Collin Funk <collin.funk1@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
	Elijah Newren <newren@gmail.com>, Ezekiel Newren <ezekielnewren@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, 
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v2 1/7] meson: add infrastructure to build internal
 Rust library
Message-ID: <l3apalzo6m5kydmfn6c376rswnfw5h34xpxauqarvxmlaksf6i@dhhdbat6gso3>
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
 <20250905-b4-pks-rust-breaking-change-v2-1-6939cbf4a0b8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905-b4-pks-rust-breaking-change-v2-1-6939cbf4a0b8@pks.im>

On 25/09/05 01:50PM, Patrick Steinhardt wrote:
> +# The 'rust' module was only introduced in Meson 1.0. Furthermore, the module
> +# does not seem to work on macOS as expected right now. As such, we only
> +# conditionally enable tests.
> +if meson.version().version_compare('>=1.0.0') and host_machine.system() != 'darwin'
> +  rustmod = import('rust')
> +  rustmod.test('rust', libgit_rs)
> +endif

Out of curiousity, what is the problem that we are seeing with macOS? I
removed the darwin guard statement and didn't notice any problems when
running `meson test rust`. Is this a well known problem with the Rust
module?

-Justin
