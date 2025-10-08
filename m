Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827E02AF1B
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 20:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759956950; cv=none; b=rYWDIK/ON1nOPW5EQnVBNO9mzVLmBLkeEgSTPP3sTfQbd5l5Wv4w5kk68oMXUIhslbEtcErRORd71gu2HC1TgQy1DfDviNESed+6PtCIODoHNjP0m/tMnYh+9vUSU5WtJt+smIYp8KXc7KkptVoBNkkjPaH6bI5xQNyzrr1+ipk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759956950; c=relaxed/simple;
	bh=SSLruaoJGBYLJizoSs/8BKnI1Y4hyq+W6HlXePzuED4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5wGBrDexsnMrGfmZyXVjz7gN6cWaITIZ2UHicwWWcIVYlM55lNHucV4gpzO5KNbcZC+sHMkw1H2p+Vxw6tCbUbY2nz5nUGtZASjIJA6uglYpygDeVWAgEJNe1n7Fro8fOjWhhetMgyeb0x4Q9jRi383aVXxnNdAjtm6H2Fmjyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajbrrOtQ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajbrrOtQ"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e3af7889fso1546715e9.2
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 13:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759956946; x=1760561746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wfgjbpGs30nPwmZf3iIqBtBx3u75g9mB7pYQq/VSkEY=;
        b=ajbrrOtQFhEr4koLD0t76B2QR2fk9QTrerNW32VRvJ3IAGfld+0NE0APqBZOcx3ai6
         mhPZRSTAMrgDIiQ/X84fkG87rlrOXQ9/ES0Bk6Lc3aYoBIuWJYaVLJbvQqkdsF6JilO8
         8ZK68Ki11sXiLY89AtKVx8ygL8wY4EdgOlWxxMI15wey1JzBDOw2cM5wHerlBVW3gT9r
         lyRaK8zXg+o5+GUjuKepTnTNl/uNpBn1UVOigWtL5sEqoIve+nzu4UFZ90aL9sc7gQ7P
         O6dZoXvzb8mIhwDaqMiM2nJ4ry8gDgCEZ4UXG6XjCiwkniDSs7qgoWnZ36SyNVY2I4aH
         XoKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759956946; x=1760561746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfgjbpGs30nPwmZf3iIqBtBx3u75g9mB7pYQq/VSkEY=;
        b=oBHtZDtnfE2IUVKz1zHfzjWhmvku88TI4Cqa7jBd+L36SGmtPOU+OLSg2NfoUko1Rn
         PYTlWNYT5Pq2b0eeLbqEv6REkeMnPa1aIpN3mSLC/JdPdJRnWzc9VWS01PTkStr6vi89
         NaHQV5mCwuc0I9dnNdefO8OxnnTz+rGHg7VmJ+nvmTG/2N197Z87GtjI/owQrhI8Hiwl
         BsNC0+ouJUkHd814XpV0nNbOhrtQCmESrEL7l1uGmghPjGsFDDrfrP6dfZ3LmwEPYV8f
         R7ljlfwTXuGR8G9MKEnpZ0OGR6XONpX/0MhjSsKVF0LiApm9DhpirJ247KtZd7u0vGG7
         5l8w==
X-Gm-Message-State: AOJu0YzS58wPHiJ6QR/7Fs4fjBhUGnezqOLBK3J8kjfZHXDqlkjq/J66
	aHktUxl1lgy26FatZNcjyWFLz955KQ+2AM5RS8PnCgmtRreKBoLjt/yA
X-Gm-Gg: ASbGncs8kwv4EmkEWlmz9fFYsw+EO2PhsZxM57bC3FdlStOWQJY0wv3JngyBCxI+3Js
	+5Dkk5E0PZA6bWu6GHVu5zQlXue9MNkaB706Ef7VCYK6kAjEetq6CKqc5StkU9XJi9V5Bg0RRUU
	wP/1AKyW2ZxXIUARmK+x988Wsb/W7zHL+bNbqKL6Bjv7+fGn9TUqb+pA01YJuJLl3RoPhR/D9CW
	kU5BVc3+HAvhWuDY9uMzyMK/vyjZKMmEIDoCkvpAgtAG8uAgpqHmnwoOyk/5BoQUg6BD2XXJphE
	oFZRgcUl/izpHg462ELAOL3sPZP5crjSIqM4VzcjL5xwIi104B4h022dpRA2F7vsnE9RGU7KM4k
	Cz07nAZKyZDwVrFyn2lV/9AZhUXd48HlxZpnl86A57b9kRD/PG1pL4BCDh3Cr4AWJUAELxGQewE
	06
X-Google-Smtp-Source: AGHT+IHh1LkIt8pHi9LhhN95o00QXtdcC1VgYcnGiWAtV27lX9I+ser5GHzcKho6ROBTnVKhBdblWQ==
X-Received: by 2002:a05:600c:1552:b0:46e:1c16:7f42 with SMTP id 5b1f17b1804b1-46fa9a9659emr35929185e9.11.1759956945735;
        Wed, 08 Oct 2025 13:55:45 -0700 (PDT)
Received: from localhost (94-21-146-170.pool.digikabel.hu. [94.21.146.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab4f3b07sm21675695e9.2.2025.10.08.13.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 13:55:44 -0700 (PDT)
Date: Wed, 8 Oct 2025 22:55:43 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/6] ci: check formatting of our Rust code
Message-ID: <aObPzzLtZzodZf+Q@szeder.dev>
References: <20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im>
 <20251007-b4-pks-ci-rust-v1-2-394502abe7ea@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251007-b4-pks-ci-rust-v1-2-394502abe7ea@pks.im>

On Tue, Oct 07, 2025 at 02:36:30PM +0200, Patrick Steinhardt wrote:
> Introduce a CI check that verifies that our Rust code is well-formatted.
> This check uses rustfmt(1), which is the de-facto standard in the Rust
> world.
> 
> The rustfmt(1) tool allows to tweak the final format in theory. In
> practice though, the Rust ecosystem has aligned on style "editions".
> These editions only exist to ensure that any potential changes to the
> style don't cause reformats to existing code bases. Other than that,
> most Rust projects out there accept this default style of a specific
> edition.
> 
> Let's do the same and use that default style. It may not be anyone's
> favorite, but it is consistent and by making it part of our CI we also
> enforce it right from the start.
> 
> Note that we don't have to pick a specific style edition here, as the
> edition is automatically derived from the edition we have specified in
> our "Cargo.toml" file.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---

> diff --git a/ci/run-rust-checks.sh b/ci/run-rust-checks.sh
> new file mode 100755
> index 0000000000..082eb52f11
> --- /dev/null
> +++ b/ci/run-rust-checks.sh
> @@ -0,0 +1,12 @@
> +#!/bin/sh
> +
> +. ${0%/*}/lib.sh
> +
> +set +x
> +
> +if ! group "Check Rust formatting" cargo fmt --all --check
> +then
> +	RET=1
> +fi
> +
> +exit $RET

Our ci/*.sh scripts usually rely on 'set -e' to catch failed commands.
Either this script should follow that convention as well, or the
commit message should justify the deviation from convention.

