Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D677282F0B
	for <git@vger.kernel.org>; Tue, 12 May 2026 01:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778550216; cv=none; b=snu9nyNBBfFtOVHrwh3DLWqCgkB6qTOseyzo48b5BP2C/cVDN8yNcjLL1ul4Bma9wzJGuPbPRqGkLrpL4Ki8hLRsw2fXl8W2w7WCTBffWn9tnjXhhueOGXUvpvapZYX/Ijz7l2IBQWbbx3ohB+LrDyjPNN9+yDuJVt1mVY6oQRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778550216; c=relaxed/simple;
	bh=/KZiAP+7BFjrWnB44uHGxpD9TWodiHJ6goBdYFprEZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HiNsb2DmL/WecySNe4VYsOgnKysvEmpVRklcGGzOGUcYLlsXuDkTVSEMVsPSwxuU/PnuIseLU7jjRUZ6wIQqm8nAwBk7DwyS3brv5+0hrFE51dN15JuNn+E2Dgb4tq9NrEvB67xAkGtcRmE+d8D8UovZRqhr0H6zaeHwmZCmcFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ju4nDERF; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ju4nDERF"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7bd5dde63dbso52610407b3.3
        for <git@vger.kernel.org>; Mon, 11 May 2026 18:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1778550214; x=1779155014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eE26YYJUfJhS/0qtVyTYShDJEHHJpTY1gI5+equDL9Q=;
        b=ju4nDERFrp+/XQovnONQ+Tlg6vSEV5qP7uCKQv6AXY4sQ8wdr5rr8fwDI+osFGku8F
         Yd3R4ilPuJO2aiNF+hYI7OfH1xpPm6uj6ywASMNw53bjIZaIgg8y5Y+LbiNcY0WYJesn
         og/TgP2Pp3kDPMoDvMIAqJe5lUf/gHunQF5q6zNZay/Rwz0ks+Mhg7MyRr0SmBn3Fw+W
         JcOtzJlyEhI365uqWgaLt+9o6B0N3stdWe+EKcbSyX4alJMneg0TIlIHGEUp3lno2aI6
         HVtAspT5N1FZi1C2j5Iya6OGEB4eS6MPwa/MYHVJHsz6prtTHeGhCqhpChhayvGxVJj+
         B84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778550214; x=1779155014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eE26YYJUfJhS/0qtVyTYShDJEHHJpTY1gI5+equDL9Q=;
        b=YsJzWlrvyk8MoRLtQF7Z9zX/TQ2ODxjNzmWN9H9tAFm1kEBtNv+5td3zUSXeWK+9yp
         7D+9vBh1xwIS3u6e1usbUp+LerlKLRjq3qgU+jP7Umf/5XT2oTqm11OUzOT1BL4UHsVS
         wXKcauE4BG1UPqrZP3gUb7z3n/P4Btd4md+PdrfP0mx/J5sGm1CbddZ+OQYKyIguZ8vQ
         Fze2hzNPtYsEileUe4ok8Z/j0TjwW+zUMRDAjf0xqvQmLdFt3HbP+/SMFBVbVaW9H4XI
         JbxQnDhOUjkrrrTEskdrWzNQzyOEaHIANWv4LE1+A/cloGiLrZxef7gd6cudUG697Cqk
         +Xzg==
X-Gm-Message-State: AOJu0YxHSZUEg+E0Gu5n9v1QfnDM/hP5ALj7wOXKJcPxoA66/kwvaEkR
	TDvSOAccVeVAdc+xyxjyGraOfs3GQq+8/+2GLkQ/bw6Y7PgWIV039C8QZfMj7FuTv8A=
X-Gm-Gg: Acq92OHltDH10CDjmXyagdnT6aPgR0tz1tW67lxm6S7pkk4mxBXID1LYJTulPmXm3ZK
	sP0GgyLhJVhD1oSw23TQCkbRqRzRtIh1KsP4PqniPMPIU4S/5iPxhnW6uGmR66KJ0yIbqOHfx7o
	n5/0pJoeBOeU/XM+DzogpHeuZ5Dp31ZMi1xmW7isRnydTkB3Eanh5ZHZchULXsQyj3tYcr8muUx
	MR6whDmUYzRukqnZk5Tnpc+9eDRx9SmxJ9jsMTV6PGKLQQsyVsH75no/5Lc+FDfRkzxlho19xqP
	mcIVle1NoBZiI4dS/TLYM5KmhgvwupBKefsvhF4/mzuDzriEgMlS5C/GMz9BRUepM1Jk82W1kYc
	S/pJZmfvKYHCKytTeCoDupuwujl3B3He6zNebh8OWGJPNI3GtFujH36j0TtNDtcZrtZB03lO8Fd
	A6SiD3bboyhnnAZctJhZRHmxTJwViLAPPWDibZwfY7jPmIZ3hLCDnlOntArnGQ09PBc+vaggGp1
	G4+cqadlLJ1oZtskO4Gz2Ep+RsTE9PlqtxC5wqh6+2nOxQn9G2bn0Q1LkTP3NA2MDwff51INrTg
	XMfbYQXyAiTr649C
X-Received: by 2002:a05:690c:4990:b0:7bf:dc60:ad14 with SMTP id 00721157ae682-7c563e47602mr8026667b3.46.1778550214159;
        Mon, 11 May 2026 18:43:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6652750asm156512987b3.10.2026.05.11.18.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 18:43:33 -0700 (PDT)
Date: Mon, 11 May 2026 21:43:32 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	karthik.188@gmail.com, kristofferhaugsbakk@fastmail.com,
	newren@gmail.com, peff@peff.net, ps@pks.im,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 00/12] pack-objects: integrate --path-walk and some
 --filter options
Message-ID: <agKFxFbMrlYn1GWt@nand.local>
References: <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
 <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>

On Mon, May 11, 2026 at 06:12:57PM +0000, Derrick Stolee via GitGitGadget wrote:
> Derrick Stolee (9):
>   t5620: make test work with path-walk var
>   pack-objects: pass --objects with --path-walk
>   t/perf: add pack-objects filter and path-walk benchmark
>   path-walk: always emit directly-requested objects
>   path-walk: support blobless filter
>   backfill: die on incompatible filter options
>   path-walk: support blob size limit filter
>   path-walk: add pl_sparse_trees to control tree pruning
>   pack-objects: support sparse:oid filter with path-walk
>
> Taylor Blau (3):
>   path-walk: support `tree:0` filter
>   path-walk: support `object:type` filter
>   path-walk: support `combine` filter

Thanks so much for putting this together! I'm really excited to see this
all moving along, and am eager to get this deployed at GitHub ;-).

I left a handful of notes throughout the series. There are a couple of
typos I noted that I think merit a reroll, but most of my remaining
comments are more for my own edification than identifying anything to
change within your series.

Thanks in advance for taking a look at them. I think that the next
reroll ought to be pretty close to the finish line.

Thanks,
Taylor
