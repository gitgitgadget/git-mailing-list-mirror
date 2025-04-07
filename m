Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E119255E31
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 18:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051416; cv=none; b=rRiN4MTp0GkUl875FHVZtETJxhQmkzNCQnGv6P9jllhKATSMIDl9PaKdFb0+WVhU+T6LdrvDVP+cIHKffmusIUCPCpttk5VLqWhsSCTWFJarBHPDRxy/YA2psBypDjFmSaYYqJ35edYZ84qJAx06JWy6rYvNlzeNWxMJGjImZXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051416; c=relaxed/simple;
	bh=aWawWhF4jK9KHPvVDeTliLSXxqrOUvMDjpwSF+jiUak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uYDwc3RBhrSSTaqQ8c+O+imlfXrJnrK/ELPnm5Jpl/Lb4f64JIuoVhYLKEK0Vkw4GMkkv72zH8N4nt7keP0WMunLkUcHHfUV/0k1g0qqCgPkQ8EvFRce13VZjfmEr+I4tKa+3NWZFlhoaR5ktUqAA1kVi2uRi2SPDYxxoZmavi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkkqnXyw; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkkqnXyw"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39c14016868so4230067f8f.1
        for <git@vger.kernel.org>; Mon, 07 Apr 2025 11:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744051412; x=1744656212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lx3vtrBSKF/Nj+QhJb3r1+P9KrQviaYCFzVDXCfzu18=;
        b=bkkqnXywyH3njIvDmspgCVjrFKfkAII6HB1hBuJjdyMVCIjLSonEc8g0F2Zpc6lsnv
         lxZ7DXpJniZCmk+oLSFSU5r3EXiMHEXLHivB5Boqxh7JZceyCAcooWnJA6FwC7m2Qqpx
         IjP1z0Yb3ytkQ/X8lAdzX3voEyjrXIwCGoQEfIUf02u/oDYJbO87yD5y3vz601sJolYn
         Nc7Nd9ZziAGRvLoivXYGan8vOqM7p5gBWBOsJMnI0N2DYT2Yd2iA3lY4ceAZDngHHagp
         oH4BLtlmzFp/QuaKAMGVrcS7K3b8hamLDvzdLtzc1sIcv/Gfurmy7jWXc/PiSLoOOZ6b
         P5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744051412; x=1744656212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lx3vtrBSKF/Nj+QhJb3r1+P9KrQviaYCFzVDXCfzu18=;
        b=TLVBTiP9yMkhekrTV1GozYr49qNQ5t38UGYDbSXTl8AHpXGtPhpC5bmfL7YIGbOaes
         ejlIazcsBm9HWgq+6/4yEsoeQytAqvv1WYYqA70qPNmc9Flwsn9PP4bWnMOiEqVDXPHV
         dLPRngRXODBDR7sijCkZJ4ogQUlE3lvBoWr+8GiBwyZDMzXfqorFc1WlHBlTttKmO7UN
         ZZ6iJzPgvGIQnB8N9p59bMDgRy0GJoXrEsqmVSvIaqzdHWFe6NVARca4ukcTUIYfe0Ha
         q0TOGwvBds/lXTdeNWozjKPDDXBTg4H5RrYTZOxFQZANH+Tbz6CszLyrQjGWUvA1sXwr
         2vOw==
X-Gm-Message-State: AOJu0Yz2rIFo/izwWJddEjcgzw4BVorpRl39isbsY/4OfXXt/XJkCmoK
	Oxv412T6Na50LTkETt8qUL7uJJ4ZeA05fN+nt2p5R2bmwA25oyyMean9Vp8gLcYzaon1M5csN3I
	ArhizFWYj6YBrDaBaYqit4tKVpBEO8fVd
X-Gm-Gg: ASbGncvTD0gXa5d0NXT8Ud28mKgtNuasuSnRnhq9MOq3N2l62JS6UBd4VXeEGPYhfKU
	6lRn7qqKImlo+OqPJWoDoIFNIDN97u+44HQq7+3ElOTXPf/753mF3NoD5W9gQwHibBgaYZMeJk2
	d7wP7PzlUNH9yTvuaLL1Y+2p+PUUM=
X-Google-Smtp-Source: AGHT+IHJvvdXptVe9lmW6r4/ioWNFLwJxkWm/QjArkAlZiOBV1eJRVUVTjxj0psTCh7d7VA2LM25faoAE2IXZ/MmVFg=
X-Received: by 2002:a05:6000:4282:b0:399:737f:4e02 with SMTP id
 ffacd0b85a97d-39d0de66f06mr11070026f8f.39.1744051412320; Mon, 07 Apr 2025
 11:43:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1940.git.git.1743791986754.gitgitgadget@gmail.com> <pull.1940.v2.git.git.1743857867327.gitgitgadget@gmail.com>
In-Reply-To: <pull.1940.v2.git.git.1743857867327.gitgitgadget@gmail.com>
From: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date: Mon, 7 Apr 2025 20:43:20 +0200
X-Gm-Features: ATxdqUFFTQqfGMykPeNlZCxTyB08XViLMoyPR5fC_JMuOyvjJpXKRykRtmrnNWQ
Message-ID: <CAN0heSoh4SuQcYHVVniO1BYH_C4O-BeF4kKxDg3uQPzpotLA1A@mail.gmail.com>
Subject: Re: [PATCH v2] refs: fix duplicated word in comment
To: Christian Fredrik Johnsen via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Fredrik Johnsen <christian@johnsen.no>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 5 Apr 2025 at 14:58, Christian Fredrik Johnsen via
GitGitGadget <gitgitgadget@gmail.com> wrote:
>
> From: Christian Fredrik Johnsen <christian@johnsen.no>
>
> Fix a typo in a comment in refs.c: "checking checking" =E2=86=92 "checkin=
g".
>
> Signed-off-by: Christian Fredrik Johnsen <christian@johnsen.no>

This addresses my comment on v1.

>     Changes since v1:
>
>      * Add a blank line in the commit message to separate commit body fro=
m
>        Signed-off-by: footer
>      * Moved the word common from line 2553 to 2552, to make the comment =
be
>        similar in style to other comments in refs.c. (Usually the last
>        comment line is somewhat shorter than the first ones).

>                         /*
>                          * If we've already seen the directory we don't n=
eed to
> -                        * process it again. Skip it to avoid checking ch=
ecking
> -                        * common prefixes like "refs/heads/" repeatedly.
> +                        * process it again. Skip it to avoid checking co=
mmon
> +                        * prefixes like "refs/heads/" repeatedly.
>                          */
>                         if (!strset_add(&dirnames, dirname.buf))
>                                 continue;

Ok. In general, there's some trade-off to be made between "make a small cha=
nge
at the top of a twenty-line comment and rewrap the whole thing causing more
churn than necessary and create more room for conflicts with other topics" =
and
"make the change and live with slightly less beautiful wrapping". In this
particular case, the blast radius is small. `git show --word-diff` confirms
that you simply removed the duplicate word and moved "common" (or "*").

FWIW, this patch looks good to me.

Martin
