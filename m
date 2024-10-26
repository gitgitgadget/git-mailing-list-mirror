Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0F2161
	for <git@vger.kernel.org>; Sat, 26 Oct 2024 05:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729918885; cv=none; b=qNgertLy2MQzC+77N5yGGzpO/fBaRPAsD7tGKVwP1E2gYy448HpopMI22BOEXOOg5sdoHVseFAY51FCm2znGzU/7PBRH8v6kEDk3KINBJdDUttIG7Vj7UwbrnRgE68quHUwDh3erE82tYNso14NStm/JfsUtkcnzGoqgsohL4v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729918885; c=relaxed/simple;
	bh=w581Tk/W+FsE429QRQzqA04/P/FV9Wricsaaznxzg2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJtkzk8NBsaQtLmylKKndgGLuGOMIdDR6OVl1t1tvVqzn4HgZqBXl7k2XTUEdQCA6DRPePB2lQ1QblYyCdzBvaFwFSYfZrH2skNGVYW73GbKWVg8V77Ax8/QydWwUPciuafh4OZAguAxiSy6P4djrKAnWxgHEXc1vHeHRSxkB6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqemd+fP; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqemd+fP"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-72041ff06a0so1825854b3a.2
        for <git@vger.kernel.org>; Fri, 25 Oct 2024 22:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729918883; x=1730523683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+87P1QjtcEjBVzEQ9Pvi+2ODdZ3lq+ndnOy5YtnHUc0=;
        b=lqemd+fPQeDEJKj3zvYu6OWgVP8d+OXNXZ4BO82gLQqwpSk2w4P/IbIeCtevPvjyK4
         GpQXI7XcUiIYm+DWUKtkThbVJxU0X8h2gyWBdAOfTicWR1Ks1Rgts/fdkDq9S9uJdr3o
         qgpZrXCmmYSMRlobxfJ0FjenhNnRLPygZZ+nub4DIWGpTrGDux/gHnwJILLKTbUHYFoJ
         Z/YC2rWh9WyoRuFbR9qFFM5z2OJ0BbPF593J3BCzOvn+CR1oDLCrdqV4MPQjN7zSUKC+
         dPsznq1R7rZd0H+QkQyqcxbKVno20Ptbnl+O5VEZSCS4gvem9HClWdHX9kvt6WkpHA8z
         ENIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729918883; x=1730523683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+87P1QjtcEjBVzEQ9Pvi+2ODdZ3lq+ndnOy5YtnHUc0=;
        b=H+gGZgUEXOfQN5q0aG0u3ogykAN0xT8ixC3XaBmXD9Y/1RMsZS/xqr7dJSAZU16Bv6
         sZuwfV0qtN7kzjvrikizjmqpl6bQh7o9zGsodc/KkBH48v+9mvAYdZeWifnNlwVg0qPq
         sALAlP9qiFqbjJ5S78UpE9jEs6uUn+m5/mtw5q9TiNDxpOOygCffEoaTtdGTY0u++c0V
         tFYQWEBZmNFNYvFTU75GcJxNbaGQnTc8rj33AwuAMnMW0xeW8r0Lhf8G7QEVqU2MHtK1
         9ICabmNqpMOVkS5Z0z49ePhdVqM9p9rSwSpraeG97RTEhxhU+/BeKj41xYiMQb9FQzXy
         QcIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVm+N3y7HSaQwbd4ErxkdqlgpAmc6H88x0bT2tXUU4wiQBvUr053uaSvdk6i7fmx7xness=@vger.kernel.org
X-Gm-Message-State: AOJu0YzulFXT6OI0TJyV0eaIFCMdV2M0oPoPDQ5N44IoFP2WPKF7FMfN
	B5B2xRbMdVM1Y3JnmBGuNwSQ2bSzZD0Bwovo98zmc+sfXnWHDqsj
X-Google-Smtp-Source: AGHT+IGzm13OijVWXV4Pef0b0qcM64bIogjoTMSRleBlYAHZGOrQE3almc8sVD2uaUkUawEvk03eRw==
X-Received: by 2002:a05:6a21:2d87:b0:1d9:6c9c:75ea with SMTP id adf61e73a8af0-1d9a83a6a48mr2304366637.5.1729918882769;
        Fri, 25 Oct 2024 22:01:22 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc866796bsm1972895a12.1.2024.10.25.22.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 22:01:21 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 621B04C49A22; Sat, 26 Oct 2024 12:01:18 +0700 (WIB)
Date: Sat, 26 Oct 2024 12:01:18 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>,
	Toon Claes <toon@iotcl.com>, Taylor Blau <me@ttaylorr.com>,
	Ed Reel <edreel@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Edgar Bonet <bonet@grenoble.cnrs.fr>, Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 0/5] t/unit-tests: improve clar platform compatibility
Message-ID: <Zxx3nmfp61DR6vvB@archie.me>
References: <CAOO-Oz3KsyeSjxbRpU-SdPgU5K+mPDcntT6Y4s46Mg_0ko9e_w@mail.gmail.com>
 <cover.1729506329.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AaiYnl/avTzb+N7I"
Content-Disposition: inline
In-Reply-To: <cover.1729506329.git.ps@pks.im>


--AaiYnl/avTzb+N7I
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 12:56:30PM +0200, Patrick Steinhardt wrote:
> Hi,
>=20
> this is the second version of my patch series that addresses some
> platform compatibility issues with clar. Changes compared to v1:
>=20
>   - I've merged the CMake fixes at [1] into this patch series to avoid
>     conflicts. @Taylor, please drop that other series, which is
>     "ps/cmake-clar".
>=20
>   - I've fixed up the "generate-clar-decls.h" script.
>=20
>   - I've updated the clar such that it includes upstreamed changes for
>     improved uClibc support when we lack support for `wchar_t`.
>=20

Git builds successfully on Buildroot (aarch64 uClibc with and without wchar,
aarch64 glibc).

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--AaiYnl/avTzb+N7I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZxx3mAAKCRD2uYlJVVFO
ozoMAQDqlt/B0RuYptHWVCqx1GOVys48cD1U7/TGeGqy8NxwKQD6A94AVIKd2f5z
3GdEGKDdR1JnIrq+QVRMSEe22oWwng8=
=QbyJ
-----END PGP SIGNATURE-----

--AaiYnl/avTzb+N7I--
