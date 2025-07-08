Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D74FAD21
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 22:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752012654; cv=none; b=Oiujd63mEUJgIEIU6pwdgYhwqqbdeTrsT1k0jdNwLScF2P0dRaKgJIw2wnlgBnBaWB4nP7WW3zZ1RNmO4rfe4Dfby0+Su/h+l1trJRJcwkavJvhhKSaTeGfeta+UR1NCDLX6OaMkld/BcUQvqxJh6qD/+QSCKUz5DDa5LgwkL0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752012654; c=relaxed/simple;
	bh=vNp2BQcC0a1g+SS4p8w5Z5h2j79uGoQoPppL7eDX/ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0NemDD/eKsESy5KmXj/QU9eToxQxc7TG5rO0Ebs04WhDC/zMS+ZzWOvTu+hJR0/nTLOHqWRrjp/BKJtJhURwDnRKAdUDqzUf/q3MNOrhC6Jbez5MZdJSrc1e+/fN4+qybNVouhLtL/tAFpZmby4YFg9dKIoOuuiuP747FqIpxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=c+jdQgR8; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="c+jdQgR8"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e8259b783f6so4061290276.3
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 15:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1752012652; x=1752617452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E4Xw/B5VliA3egaOyEx1hDk/slY6eyVTlaoFfYMjzXs=;
        b=c+jdQgR8EnDxqOknv04/A6qv5j30BASzAeh5uYwIsMk+V5K7rMwbITq1RBU7yhc94L
         H1DdDwewRYphhpnjL4oewh3uRdcb/c47XBsxMd5GB1asNlvhaxzDqHpM9njjr8H/+WlJ
         vixfBeoTA+7PboMzJRUR7k0V4VEq3rjmFU6VstvAyGFbvg4j+5QZ5M6CExGuePUpjy+j
         F4770ScFOOOs0vvkBDhbxmibRFyT1aWL3fh1KCMsE8NAPx0qmN/Z2SC0UcduL40K/uqN
         gB/Q8dh2fPReI0ubNg+5PEXPPUDQ+yASeTQYDNJv1Ne15MfoUEV653xyGORBnEZwQPGs
         IEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752012652; x=1752617452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4Xw/B5VliA3egaOyEx1hDk/slY6eyVTlaoFfYMjzXs=;
        b=MtKAHHY7kIIVufLy47jFb4Cwf9Ac5OpVDf55u24WcCW2ykzb5c4ui4hrs2D6T9Q7/e
         PyjV3GHkjV9gd9I+nyaG+eUM6B4hg/1DKoOJ8mjTzOtAZQYNAoSfyZ1E9YSd6V2Akf3i
         u2n6oLKli8+N9/vokrw9hCDbawy4kz0Z15roIM4mW1t1m5bj8Kl4zdQ9/li/8tEqcC9v
         tuiJJWlaOqP4NLWPG09l/vo5x+oJRmO/dJC7UuKSRG0+QXc7m7ChXqWGzI/sqJ1RTFuL
         cFi2uLxJOclgxvNd4zNFk/qOdwoua7NvV22R/P34qVjP/sjU89+KtTOHpmD+Zlinh6aY
         X5GA==
X-Gm-Message-State: AOJu0YxnhYZ3UxWri0vI5Aqp1cB8duvd6JkO4RwYQtA6Jwr/YN8IoVet
	ppLDzmX2uWNM/LPeV9yeRJd5SL4cgQLxZS7jyfskMWYGRgL9KfcgTW/4pLxqQVEx63s=
X-Gm-Gg: ASbGncunQM1G83xq3F/Jg9a/nJfwe+DArR95roBvZBHvY3Td0NOBUI2CTxtFAHtwDd+
	n2/wOJ4oRcY8xaQKly3s9MsFg46VZ2mrE5YgbSMJQAyKXzcg5EMZy3nhMponcGDS8BxxTWqGcuM
	xJgspcRsFDL51PrR88PU0x8Hau2cVb9+q77wVtfyli/bnsTPFMdXfdJCZ7+WUOzTfFa+hBwpjUj
	ZwP4aV9XgXVNqLzDfWP8Q7UwUhSk+ZbN7wp3MS/z4WuKbpNnrC93XRlzEomtjnVL8UaoeuDrQj4
	sOfTbqkeRiWRPIzw94yLaqR+vrBmMN+N5HU8Msyv4TQX8DWa9enRILaWXMXHOMjqeih4PmqeG6H
	5ZG/OtcH0zVgcrb4xcUsJE8pN6BK9PLCK4g==
X-Google-Smtp-Source: AGHT+IHzvtU0HS3UYtccEZuWZG6dDFLJIk4TQXqxWgcXSFtmegc0dMe4hN9iya52QrEgLAYSCfgIOQ==
X-Received: by 2002:a05:690c:6c08:b0:715:2081:f2f8 with SMTP id 00721157ae682-717b19bf0b5mr6533967b3.27.1752012652000;
        Tue, 08 Jul 2025 15:10:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-71665b1b09esm22686537b3.102.2025.07.08.15.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 15:10:51 -0700 (PDT)
Date: Tue, 8 Jul 2025 18:10:45 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
	Jeff King <peff@peff.net>,
	Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v6 0/3] pack-bitmap: fix memory leak if load_bitmap failed
Message-ID: <aG2XZYamUv5FWq/W@nand.local>
References: <pull.1962.v5.git.git.1748920444.gitgitgadget@gmail.com>
 <pull.1962.v6.git.git.1751347929.gitgitgadget@gmail.com>
 <xmqqfrf71ull.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfrf71ull.fsf@gitster.g>

On Mon, Jul 07, 2025 at 03:53:10PM -0700, Junio C Hamano wrote:
> "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Since it seems this patch has been inactive for some time, I have revised
> > the comments according to Taylor's feedback and submitted a new version.
> >
> > This patch prevents pack-bitmap.c:load_bitmap() from nulling
> > bitmap_git->bitmap when loading failed. Thus eliminates memory leak. This
> > patch also add a test case in t5310 which use clang leak sanitizer to detect
> > whether leak happens when loading failed.
> >
> > Lidong Yan (2):
> >   pack-bitmap: reword comments in test_bitmap_commits()
> >   pack-bitmap: add load corrupt bitmap test
> >
> > Taylor Blau (1):
> >   pack-bitmap: fix memory leak if load_bitmap() failed
>
> OK, now, how does this iteration look to folks?  We haven't heard
> anybody say yet.  Is it ready to be marked for 'next' yet?

Oops, this fell off of my review queue. This version looks great to me.
Thanks, Lidong!

Thanks,
Taylor
