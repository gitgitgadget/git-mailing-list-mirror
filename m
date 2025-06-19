Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2A430E843
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 21:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750368667; cv=none; b=B1915yZl4mKrhVeI+sgQX21p9NifCTo9HUkAz4Lehrja+s3D+facnZHLFUSRdbxlTgAWEd4nvIVcWbjJyHcqY1WNDQMBclDIb8jTrXLh8/DVpHGa/A8MnVlt5JeuUVUUQsQnyf6o7XbJShBUiK0NCqJTMHB6zgDUcyIW7VCEVew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750368667; c=relaxed/simple;
	bh=+9W6Tc9CjXmbwgcOd4+E5uTWfj/z5wJV1YCZVrHkndU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iWSg/szZX55yr0trHYD6iGflba1QiTlrWRo0WzeLi5FHJAfyaZ4nl9Lb9lXMjcqs/EnKMtoNyNrkig+AjjVH14vIUT4HJ57GkkpAGu2lQT9XsOBaA755i1FuKDNnUuVHORLCt4Tgw4BlX+PfyBt6wD9kG36VRrjuwpFFNt20c+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAMDFvXn; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAMDFvXn"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-235e1d710d8so16804835ad.1
        for <git@vger.kernel.org>; Thu, 19 Jun 2025 14:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750368665; x=1750973465; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f1Zl4juqclnernHXCrRu61+t9TZsprbOmTS/TutqO38=;
        b=BAMDFvXnIZygBS4J6YugW2yf1zU5MICayT5cKsBp38XfsCf7RdKa4V0uJZtZ+abukj
         v9DBSSawXUrEGEDBQ03pEEza+dcItwXr5h31igKqj9mgGRt3xbVZbM0WsVxgMukEp48R
         hwvqjujiucdOTrn8nVZsMtTLxvnFPNegDu9TFBnh0D8AVc149SHajgtDbEjYXtTIEPd4
         Gn+wBK9SFF5DqiMSog3MvLXiOt20TeQ/wJWa5fXtB/0wfwZf6ULSpPrIkbmtenez4KrV
         cOjVOZPE4ptpqCjvPXQxIdrTzK4kHE74Zj/YU0DPvkbnHeV+2qNgEoAL45mMmXmEe7w4
         Sw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750368665; x=1750973465;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1Zl4juqclnernHXCrRu61+t9TZsprbOmTS/TutqO38=;
        b=KXZYOHJqb1NmbksKetAvRmnP0MrHg/qp6N94PdVNNRuPoTnbWhXPYuD86NP4Vdv4Kj
         9V4stQTHY9km/F0lWPPz4GLu3I5thLYY2NcDHSb9upx+i60B2cwCMAd/IExzsYINZAbu
         H7M6gGjqN+rZQDUbh7kSJ+IcaPXztiTU1XRm5WlFdgdFnvdUOGngvX4Wx0OfZ8rj3c1d
         1XJckL0QM614yA5xXwjNZeilPb3tyvIPS0Sxw6exSy0lHfK96xBFOOsfQ66pT8ZyNl5E
         T3ApXW3gFqyhYdzHMG4MEJmcx8I9v88F6Ec32SiIqqUE22esvR7+iCRTkMuW0PFg9UCb
         BRZA==
X-Forwarded-Encrypted: i=1; AJvYcCXsxzoyChK8yFp0hiTwJ5W+jL8z7wv1UkiFhB01/aF2C4gXPafDfgx8rUb8Ez/7TvWC8NQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH1mHaLgqa8MhgpHTxJtAbsjv6YEYvy68T5PNRZF1gYlfDOxce
	c8bP7ZB2/RWNPQbZZGSCMPskwIJ8zIqULhW9lmaOwDepopFbHqQxzwqR
X-Gm-Gg: ASbGncuv3NRfpdx5CBenyVB9kYe39EXnCsidV4f+/l5XcrBC7Bl5vGWMzATnYop6bIs
	Vs8m4RLD2UDb63DOzPZMosI+Rfr3+S3adRwBiCeJ/vnuqfQ7Z1eCZ/OCVZ3jmed+m/0YVurZ3Tq
	FwjcHzMAopzGNCd0xaE+WRVrF3ErkPdDqwuXBC6k1Vbghy52V90+3o2D27WxU8E+KnMzah6XvVN
	eFCXO79JKii6/JkiLxwcj88UDN79D5hoo1/RoT3nsX7B9qiHjRFMQC9sWUgzNt4kgJI3cH/vX5o
	CgFxQlSgTe5ylP3pwumEiygzwVBz6DS1voGI6bAFZ3A=
X-Google-Smtp-Source: AGHT+IHLZD1A980GFLczgTEYwAeYYBaiaJTRP9kessCgc+3v7SK9xqL11/yGuXNhNJ4KymnUG4zEHg==
X-Received: by 2002:a17:902:f68c:b0:236:7079:fafd with SMTP id d9443c01a7336-237d98fc308mr4885395ad.36.1750368664885;
        Thu, 19 Jun 2025 14:31:04 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::53de])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8640dc6sm2520595ad.146.2025.06.19.14.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 14:31:04 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  =?utf-8?Q?Ren?=
 =?utf-8?Q?=C3=A9?= Scharfe
 <l.s.r@web.de>
Subject: Re: .clang-format: how useful, how often used, and how well
 maintained?
In-Reply-To: <aFR-Yf0PMj30ex2O@fruit.crustytoothpaste.net>
References: <xmqqmsa3adpw.fsf@gitster.g>
	<aFR-Yf0PMj30ex2O@fruit.crustytoothpaste.net>
Date: Thu, 19 Jun 2025 14:31:03 -0700
Message-ID: <87msa3quzs.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I agree most people probably do not use it, probably for the reasons I
> don't.  I don't know if clang-format produces stable output: that is,
> using a newer version of clang-format with the same config does not
> result in diff changes.  If it does, then we can simply pick a set of
> style configs and a minimum version and tell people to apply it.
>
> We can then check it in CI and if CI fails, we can output a
> base64-encoded diff (since it's going to have lots of whitespace, base64
> encoding will be practically useful) that the author can apply.  Then
> people using esoteric systems without clang-format can simply apply the
> diff from CI.
>
> If clang-format does not produce stable output, we're going to have a
> bunch of practical problems.  I use Debian unstable at home and I know
> Peff does as well, but I also use Ubuntu 24.04 at work.  Some
> contributors use Fedora or Cygwin, and we're all going to have a giant
> problem picking a consistent version of clang-format to use such that
> people don't have to compile their own or use external packages. Perhaps
> we can create a small script that does the tidying in a Linux
> Docker/Podman container in that case.

From what I remember, clang-format is not at all stable between
releases. Newer versions will produce different output than old 
ones (usually better, but that does not matter).

For the reasons that you already mention, it ends up being a chore, in
my opinion. I don't think we should expect everyone to build/install a
clang-format version that is newer or older than what their distro ships
with, just to align the output with the project.

If you wanted to be help avoid badly formatted patches adding a .vimrc
and .dir-locals.el file would cover most people, I think. For Emacs, the
.dir-locals.el would be something simple like:

    (c-mode . ((c-file-style . "linux")
               (fill-column . 80)
               ((indent-tabs-mode . t))))

At least with Emacs it is easy to type things that break these rules. So
one can avoid diffs like this, which clang-format would produce:

> -		/* Warn on any additional signatures, as they will be ignored. */
> +		/* Warn on any additional signatures, as they will be ignored.
> +		 */

I assume this is similar for vim, but I do not use it enough.

Collin
