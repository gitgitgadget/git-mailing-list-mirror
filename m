Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA09156C73
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 20:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567710; cv=none; b=Y1F0wHwOGcr3UEkEUHYd435z935oQcI4/ZcRz8hEnafGigekmgR1xvpcFH7OazJjlslNvM7Cu/C9G4kDLduq4FpLlcBwVRNFlq+R+LtRuUZKy216fbiRB5h5DQc13TOW6gNcf0KLwFNWRNlDfVXNevvUiVxQd1O7bDuZwJQv7Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567710; c=relaxed/simple;
	bh=Ru6OFaOq+fyFUmxJknLuKcj9Wg08tO6dZAIquVXJ/wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fm0iAwVho3PRsdwd2F61sRvQJrd+4BfABR+PyuA1RJPjHffzs1VOwVaVHre+a7d4gTY67WE+WHVN5ZwEL/uG2G8/uZH0dtzCL45ArkHVDrZkMj9z50SKNrh+I1eBsHmItfcAZ4bgxa5jAw+uWEr6jDTSnHbihKZjBPwyqr6+Zhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=vK+7oRg4; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="vK+7oRg4"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e1a9dc3f0a3so1442505276.0
        for <git@vger.kernel.org>; Thu, 05 Sep 2024 13:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1725567708; x=1726172508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ymn0QnKg8xvkb11qf9MZcTj1UcxsH2tklb/OHkxWW8=;
        b=vK+7oRg4bBqtErQ/goGBgXIyFi9cy0RAXhxiU2PZHKwFH7en6B/cO8OnbU8S2YOaZE
         3GBUd5i7NCk4qnyhaj8pcCOcg5Y6SIvLRcBL+n3izvWrKK29sfrRgHfBtis40t4UaNez
         u3R5Ix+nf2UL+jeapXt0vPaYxD0wQ3qKjEm/bj4n36H+9F1oV8ZwIwRqeZ2tuCO+oMvm
         jlQeh0e/rVp+uLq+Lmr1WxszeZwlNLE6FBoXUYY8Ha7HhgjgFiL7xS5WjkXqGovZTyZd
         O0gVuJqguSlQizVA28WJc6Ar545QoQkzq/UyenNdMywygzgRqKHNONuExwEbDx4f0gi8
         ihJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725567708; x=1726172508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ymn0QnKg8xvkb11qf9MZcTj1UcxsH2tklb/OHkxWW8=;
        b=UXdnt7iN5XUyXd5Zyf6e0L/yDHdmDpsjltwec/iK1q2MYe2j86riIwxmuNF2fGdSvz
         dE2jha0N1UV9MySrfFpLN34I36jxVwxJjlwDovfM+XQvBMUS5WGo8KZERW/uekITmezu
         z5eBO093XIDs6RibbhQO//4Hkr/6jnu4fCloXQvPecHYuwMHWmDFTOjYmP0eJvQ4JHfX
         RX7lhGhWCajJEjfhqvf5TtzE41gm8ytUQEjffZGjulZT6mUSRw8O5b2LpEZ3LQZL22Zq
         AFdtbEn+aG+F14GqW43IvxriNGI3H7pByrNmShlqaunaMP0MyOgpnGX9HpCGqhob5bfB
         RU0w==
X-Forwarded-Encrypted: i=1; AJvYcCWdFYut1omf6kI5Qgdw2lkBBiWGcXYKDzxJdqD6SpQwd7GZ3m+rarAsh+fpyEUT3P6MCjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWNEwZTcNPcEfLON1xBJgfMsAIL0Avtyw5iroMHKZ3PPRMYjeW
	i0aDfU2Swd7XoYn1doCe3nykCW1emYaXEjHwGRfigY1HSrrWBvWbf7wRfZE4i+o=
X-Google-Smtp-Source: AGHT+IHtTkKfobQLjdp8Za05X8AU6wGuxTSkWtTfgjhSG/CPrLCj2rA9tAI1kz3tyZCmU/nCQ3AOwQ==
X-Received: by 2002:a05:6902:13cc:b0:e1a:5870:6380 with SMTP id 3f1490d57ef6-e1d348ba428mr537741276.17.1725567707814;
        Thu, 05 Sep 2024 13:21:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1d12cd3d73sm820563276.33.2024.09.05.13.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 13:21:47 -0700 (PDT)
Date: Thu, 5 Sep 2024 16:21:41 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/4] hash.h: support choosing a separate SHA-1 for
 non-cryptographic uses
Message-ID: <ZtoS0LYEZqfwvmtw@nand.local>
References: <cover.1725206584.git.me@ttaylorr.com>
 <ZtXG2cEbxr8pNg7j@tapette.crustytoothpaste.net>
 <Ztdn25zfi8WHO+GS@nand.local>
 <20240905103736.GC2556395@coredump.intra.peff.net>
 <xmqq34me5crn.fsf@gitster.g>
 <ZtnbFXL7W5DvW8UN@nand.local>
 <xmqq34me3uyz.fsf@gitster.g>
 <ZtnkovOqrJNxUtez@nand.local>
 <ZtnvjlW3DotdK/lB@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZtnvjlW3DotdK/lB@nand.local>

On Thu, Sep 05, 2024 at 01:51:10PM -0400, Taylor Blau wrote:
> , fails very quickly and produces the following:
>
>     [main 727346d] foo
>     Enumerating objects: 12, done.
>     Counting objects: 100% (12/12), done.
>     Delta compression using up to 20 threads
>     Compressing objects: 100% (11/11), done.
>     Writing objects: 100% (12/12), 779 bytes | 779.00 KiB/s, done.
>     Total 12 (delta 10), reused 0 (delta 0), pack-reused 0 (from 0)
>     remote: fatal: final sha1 did not match
>     error: remote unpack failed: unpack-objects abnormal exit
>     To ../victim.git
>      ! [remote rejected] HEAD -> foo (unpacker error)
>     error: failed to push some refs to '../victim.git'

I didn't set transfer.unpackLimit to zero here, which is why this says
"(unpacker error)". But if I did remember, it would instead say:

    remote: fatal: pack is corrupted (SHA1 mismatch)
    error: remote unpack failed: index-pack abnormal exit
    To ../victim.git
     ! [remote rejected] HEAD -> foo2 (unpacker error)
    error: failed to push some refs to '../victim.git'

So we're safe here whether or not you use the unpackLimit setting.

Thanks,
Taylor
