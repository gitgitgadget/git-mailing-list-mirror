Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3F723B612
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 14:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755959363; cv=none; b=RIeUXo8yp1zxJsuKhvOuLpFN/ZE/7tFn1pWyZdyr/Xc7uNcarUCRbVOCcIhfmyReMUzLPYZ73zhwCclzmqvnPo2lcrmEodgBicM9IfqLUy9s4Xb+oRsuAz0j32awZhiNlUIwNUE5GmRubdxoA9XV3P8MhQFGIM2eWfq2ofU092I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755959363; c=relaxed/simple;
	bh=xeSrcrHxGX66p73jSkqIDEuqef+uTu56m+/0aBSuLlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGyl3Jnx/m0Vdmx/FUIh9x8FFOWWzaKthkftSdEZt/SW1uh2tyQQvHLbnqloEfFiYndrL86sBucHLxI044r7q4pbiKKjoJXEuAeZvwXFndcVCX4W9Q+a9EHcroM36YvqRJP2pFJhhKeEyBeMv3z9B54Gk+HvXynWzIvwrm1KaoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyVHYkX8; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyVHYkX8"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-335360f9b6aso30227411fa.0
        for <git@vger.kernel.org>; Sat, 23 Aug 2025 07:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755959360; x=1756564160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xeSrcrHxGX66p73jSkqIDEuqef+uTu56m+/0aBSuLlY=;
        b=NyVHYkX87uK2dFIxQEoLZAhK6+uhRz0MseId8vPGwCCIseQSNLDLWEnlIXViq5yrOP
         WnXWefjBLcwhiDwJc7BESHf3ADAcmgnEsvyD8TWYhln9tMYtxERayXeOtB/4IxOKDOuF
         KGwQxFDj0hTlZe4KD2PyROTuYpMHbtZPdLayzR7J5iYw3VJp1oDXXS66nafY2xbMovl3
         3V2yiTw6JeCv0sS0VTFQ/qWTbrGmGM1E/vz5UexqmJz5l3U+BhpeQMvF3cZVbfohxbVk
         9A87VKl2yJTsvIQ1h6gW/R3VFMGM/iZDovNsBn7wd93kyGjyUsqTz5OQzCIQ2uZCULPS
         6aBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755959360; x=1756564160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xeSrcrHxGX66p73jSkqIDEuqef+uTu56m+/0aBSuLlY=;
        b=iIs9wqinrKXMj1LpNavEYqie0eBz/17pJLpJNcAKShb/5tIEDBZZV37EHZd9kA+04x
         DZvxyxA6yp5m/frmxMpgT5fQGoeaDE/DQSqnx9bWpA/46zGs/yqEFMs1rY9onRw4XhXu
         FE/fgIVwVCQ/1AD7J8NRMhX0yZkWtccwLdDz/mXw+Q1etcH8mzRos94DmA4oR68hoIDV
         86NR65hanTATBav/5PCC1KQn+VrhHZFzDhyMes5RprN85Ctt5vvB27mB2y1BPheObNSA
         Zp1qa3jo7nkS7jkL3K8anazVYqbRrbGTsL44QKCY+D5VVL7C2qHX7CU0nWvKYuUpTg/l
         c1Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVzatBCMwBR58VlZ3kciNYjah3iH19bHi5XM0fArK/HGXURpRobXJ9VPDbche9Dd/9JIzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxWTUskTMdHNh1LTF8m1Y5tzShAuwOUihgfEzGe2DfqwhtRjB0
	dv0O1clv4CZkR9GaUFhOPoJ/dr4AXGfeq3avPt+m+1LEpd0P+3dmVfWsvnPXFbcoY9TE6IRMZo9
	Zag9HGRodK3T67T2gmomiPHXM4j9K9oU=
X-Gm-Gg: ASbGnctqum2aEqdITEnZDCt7t8Nda2/mTHdh8/Tl1nG0AOsUPzfAv7KCVcSho27H302
	o1NJ1akQYukMMkNTYL+MJ5FMr5uveAE/YOnEqA0OtfL6y7bU54npXEKYnJI4dcXHM9vEgotiQlO
	Og10pcMWWADYMwrDxwJTw4TLQbJjLc98ftUA3fMs0iBpv3yAkcfyon1ECVhpHxTI7y10V8ZuhkD
	6BSmj4C
X-Google-Smtp-Source: AGHT+IHAy8n6bZUJHGJn+QBjJHWugh6hgx3aJEf1Sg1Mc+nqxIjj9kEHoueyBvTbGBhOmTy4JLpLnD5zWmHqTU3/Otw=
X-Received: by 2002:a2e:be2a:0:b0:333:ad65:c512 with SMTP id
 38308e7fff4ca-33650ddab4cmr15763591fa.13.1755959359953; Sat, 23 Aug 2025
 07:29:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
 <pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com> <03939951256baaaec3fcc690cfa38ee12fb553ce.1755921357.git.gitgitgadget@gmail.com>
 <030a01dc1433$ee3e2510$caba6f30$@nexbridge.com>
In-Reply-To: <030a01dc1433$ee3e2510$caba6f30$@nexbridge.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Sat, 23 Aug 2025 08:29:08 -0600
X-Gm-Features: Ac12FXxiAXQIaQJoNGKFBes6AO21gaXs9iVvDCmQugmv0z58f5fN4JGMC1p8K70
Message-ID: <CAH=ZcbB87HCNscUh+1GithGxjnkTcQEGiPdzuAYMk8CZE8KELw@mail.gmail.com>
Subject: Re: [PATCH v3 02/15] xdiff: introduce rust
To: rsbecker@nexbridge.com
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Taylor Blau <me@ttaylorr.com>, Christian Brabandt <cb@256bit.org>, 
	Phillip Wood <phillip.wood123@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>, 
	Patrick Steinhardt <ps@pks.im>, Sam James <sam@gentoo.org>, Collin Funk <collin.funk1@gmail.com>, 
	Mike Hommey <mh@glandium.org>, 
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, Ben Knoble <ben.knoble@gmail.com>, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 7:44=E2=80=AFAM <rsbecker@nexbridge.com> wrote:

> Does this introduce Rust as a mandatory dependency for git? If so, it cut=
s out
> numerous platforms.

Yes it does.
