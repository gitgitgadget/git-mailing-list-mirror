Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC3314EC5B
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755091541; cv=none; b=Pz8gCZp8HIO+efelTkBsc5Jk76C0Xul2umx3JBE2CQSEA4ZLE1TOwoGb6m7j+CIRtYgIROEiXpMN2S9CeYfdkmKXifoSZqRiBGlUkS62QGA2c3Ei50Kq8iyv43mdCi5hUxtqnJQ3VD+o7Q4rDxuM1yLCHq7x3547tMnr0cPx7UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755091541; c=relaxed/simple;
	bh=vBUABxdl+J/TJ9GKhAZ8UOPF880qN5auBHA7En3ywYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4//jWqJOZSlrBcrGlNcLn5gvygQHUcI3Zdt0tW7brGqkN0pDKdU+b2f7i9JHiu7CsQSIUQeVJyi2qP8RG9EpHKIlmebgwvDntpZZ8UzQiTE0hcFuoar4vn81rBrF4TDor0hTR1zaazCIQFA7z0GsFTCymmT+JH63tRY70ZJFSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=oWXuDTVz; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="oWXuDTVz"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3e56e033976so699655ab.1
        for <git@vger.kernel.org>; Wed, 13 Aug 2025 06:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1755091539; x=1755696339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=klMSp1+3v5an9t1PDwb+AMKdDMzzWbagdG4YlMuPaWY=;
        b=oWXuDTVz+0XgPivQVDMB/WV1ryWpa95QPYmyxhv8kIaRdDWwIJoQx66xjHJwS55Yjb
         F4tgO1kfiNm0w72Y/ZKbaIwqznNGpjFllWgXp9vzz2oRiiUT4D7RbKmwm2Qigm6x2ODq
         kHv8wsDW5tg3bU9jIMLIofu/Y/HfZjPFXuslNWBXka8xar5cRd9LGrKDGTTE7ww4EXvz
         ByXReJBwnlDod/xMsh00/pr3oS2siSDIhAmedqtdXiZnK4aYhd7PM0/mHnervWAbDQIo
         Tpo9qgBrbyUCZYnINqxhPMR/Xi8+rr3VmKcjyVXhsSalgJuH5dFippYtGIcRiOXA3jYq
         0cPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755091539; x=1755696339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klMSp1+3v5an9t1PDwb+AMKdDMzzWbagdG4YlMuPaWY=;
        b=G9gKSQeXJoQFu80IvHKTRe4Em1o2outwG2KlGU1NI3coBjVDT8Zd2l60oxEKEBrqXA
         /Vgjw9cTyWriuSbrLJM84DFVpwewfMNhRzm+Ir0c+WYgLqgmilX4YkboIELZqACr1GNq
         mJXO1AccYwipRg616JxZmaXCkZXuljIKQKkOMKKrTAAURDNhLC4hbzDnwUBzNwa47wSp
         mzXaPj+S8AFL4aKOEktkOt71gcS45A62tR4OMwOecpj5GWJYzrF3u1ZLKPvz4JEPDzUd
         LdYhxseRTf1+pcrxIkffAK/TZi3xDcrGY8RhEygAYcG/7AJfI+Eu9E6w3RSGv0S0JtDQ
         n4xQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg6q0u7S4saVo5ju6DPFHe+9+wc9JfhbguIcWFt6PC/t4RZG89OUcJPdZBGG9LyJ0jGtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlGPZ+OsyS7kg5ET/RNLFDkZyqCGbTU2jVDHzp7r4hlIY2tpxR
	KOIW7kmvJacBSG3iCd5M9/dKyPuyHrbgvh3g1dkKA2KnHANhOIo/VGSj/40kxMv+kyxsHDyP0vh
	gyEYM
X-Gm-Gg: ASbGnctOXwdVD6PRPVFQG0YB7tFDhXITkngDi/L8swuKOBsrjepc8sBVbcUF7albXDf
	CMxNlQNIXcAl3NywDpSDJIdpocFuLj06pt/GwORWymSoHYORarmT0qtPNgvjshm4q6bDY66tHfA
	Jhsb8SqDnd0W/x7XHJROT56/22T07zlmy6qZ9Be75N1YFOOCmsFo3zRVSccRfetwxzCKrZXpN76
	ZmmFMUfKPM3VSxIeBz4W3DB5Iv4WggR1JorsPMiUQOi0yzAqsm+dcLIUFzSaH4wRBBNtpZlmVBe
	3f/bhrw8iVh6GW4IYPb+TzUQTaIauT+yP+d2S1etquOnH+2Ll/SYG8LrFOG2clSSP3jmD5xegJA
	95DYSbsBITR7fLp9Z8aqfNPJ76BRR5x+IMWEVo/gGFxN8vBsMtBunM8FVUZJw1fwqls7hvA==
X-Google-Smtp-Source: AGHT+IGw/qA0ppT3eTt9kNWFKpc49MT2trofyM0UVFoOW0tlc2hwWRE3cDXe2dqyicWS7UZjnSy3JA==
X-Received: by 2002:a05:6e02:1566:b0:3e5:4326:d9cd with SMTP id e9e14a558f8ab-3e56848feeamr46536705ab.3.1755091539185;
        Wed, 13 Aug 2025 06:25:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-50ae9c29370sm3825105173.71.2025.08.13.06.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:25:38 -0700 (PDT)
Date: Wed, 13 Aug 2025 09:25:37 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2025, #05; Mon, 11)
Message-ID: <aJySUWSq+xFxhyZr@nand.local>
References: <xmqqwm79x7ra.fsf@gitster.g>
 <aJs5Gee3ZVCJX8dk@pks.im>
 <aJtSqgJ7w02Ox74w@nand.local>
 <aJw5eenXu5CO5z2W@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aJw5eenXu5CO5z2W@pks.im>

On Wed, Aug 13, 2025 at 09:06:33AM +0200, Patrick Steinhardt wrote:
> Fair. I don't want to spend too much time on this signedness topic,
> either. So I'd go with either:
>
>   - Taking the signedness patches as-is. They don't regress the status
>     quo and allow us to warn about future unintentional signedness bugs,
>     even though the fixes are mostly of theoretical value.
>
>   - I drop the signedness-conversion patches altogether.
>
> The more important part for me is to get the second half of patches
> merged anyway. So while I think that the first half of patches are nice
> to have, I can live with dropping them.

I'd personally lean towards the latter, and drop those patches for now.
I think practically speaking that equates to taking patches in the range
[5, 10].

To be clear, I am not opposed to the signedness changes entirely, but I
do think that they merit a little more discussion and thought around
what our general practices should be here.

If you want to resurrect those as a separate topic later on, I'd be
happy to discuss them then.

Thanks,
Taylor
