Received: from mail-yx1-f67.google.com (mail-yx1-f67.google.com [74.125.224.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501F4C8E6
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 00:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773619787; cv=none; b=iFCvUo+TRW0Pe/qgclfm8Kgip6417sSq2F4a4xkzTxAl+ybLQQ6H3Hce1d8pn/cZ7s0cAVNO0Zhcj5MVqrBUCRL28paVYKe5Ze3wOpc/b1+IHfHIHMnkWmMo2NbTWcP2FVJ69tyPu3Jn2auLPkDC7MRaGkp4qCwk9cAp6A7NoCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773619787; c=relaxed/simple;
	bh=xovjTCS2CQqpuSisTu6odHmTBLU51Vn92LkaGa9/YKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQDgiLOEqeEpMqQ3qBvZB75C56n/HRouYJmqRoqV07JJKdUqLT9J2gtup+VGI/lQqWGsbbIzBkNCETofLLlP8AzaGKhlZy+nrE3u1/Oahb2eJgv1BldbbYGVpDdpt2oHPC6bB2PGSu3Z4R/VS2W+cqG3Xnw8RuWWGmQ9EkYUACg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=VmNonJsX; arc=none smtp.client-ip=74.125.224.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="VmNonJsX"
Received: by mail-yx1-f67.google.com with SMTP id 956f58d0204a3-64ae2ce2fe1so3775371d50.1
        for <git@vger.kernel.org>; Sun, 15 Mar 2026 17:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1773619785; x=1774224585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jtS2lRFi3XlNAzVN3urDCEDaySWiV1WoqC6JbcyzTwo=;
        b=VmNonJsXr03RCmopBvv0eaaN4GTmKct1Wp79IqWHdABLhkRuZnjkJF6Fs5KvXaaHeb
         tBvlj9njIFXSADvmqFZE8QMhmECkTboXIkwG1RciUwt6U7bo0EVp893T1ubEKSnopgCX
         YEgggDPKzG+6VH9OBemYboFFkUNPyPrbsYCOkdVKmLm7QFnomZxziCO0ufgEvNCuHnNr
         IDfw/miHUkYN/HquUYdhJjLM18psdz04+rhs8RW3lRISzJ68DunDoraE+oBWoXtl0el2
         3/VyPs9iIkVpN/bsZSPjGDdXOBHvdq8udzo1ZtMfmxGExjTN54jkmf0+xW68P+SsFrZN
         QOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773619785; x=1774224585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtS2lRFi3XlNAzVN3urDCEDaySWiV1WoqC6JbcyzTwo=;
        b=r5gFXVRPzN6GHcmSLw7JceCI7P/ULSXnmTULXINXJt8OE+T5ul9LJzcxynfdgJX+Wt
         /CUW/WLQFmjfz06PcKLeiUBjzIaYVfC8UtzIudTZ1YzfCK3CwkzBD2erkBWBltBFvdO1
         pkahJf+DJPXpZOpJCRsVoWLIiiw5V2zsWaQiTJkr5M+Jm2NIJklECNgW0Tsb7vjDIkw3
         RAO7zWY4LpuFKOZvgvJYmMEkzFZJK61wxGfhn2qod/JZZe+d1Px8JuCBCM4gcgPUcGwD
         /GbDboR4VdeRroBqYZ2XCEq93+6eTqXKT4GU4x87+LwpmTjRp/WJVYR9AozXwwmWiQGA
         nn2A==
X-Gm-Message-State: AOJu0Yzig43WhvNtnCqVBCMTL9Suw5dDEUh0N6Kb0gPkncxfDMljcyAY
	7XqugJKLgdNim5RGgnJ7MtqSYlSGMCuKaoMC0ztbrUgN6S9qr+JcPGvE4R2ywp13NEp4Krhdn5T
	RZYi4PqoqmTRS
X-Gm-Gg: ATEYQzxfhvxjuYUz3PzDDoMKmEOgSyENd0sgT7nhcT0P5iSJP4KjETRJunALXMcfOJj
	6MjFRfERwF/cspHYHEBqpqLhCivDcZNkSe0zcNXa/CO1kYtorsASU/giCbc6XYrvtKB+6CLagGX
	mmgoyGLYMG+NF9Bi4yQWvlo9FIJJPiraavt3pGZD1INnat5qiZsL0PmnKvR0sgmPOvfNd+yNMgI
	6kLHXXtXx9W2LRwrJ1Yb3+57Xp1h+xB7brFu9ejNUxy65VQq81vqsJTuXJJF74dFPvTvldUcdl6
	amLhlZmhHscbq51cu22dwOynEE+2grBDQmBmGtDmgBJz+x4gxhpK0A0zUAmyddFSO6s09PGILHF
	Ly4LMh/IliuCcaTm7eAjbXIPuzuFxor3uME4ayAcnsLgl3BNoORufs9UPX+8AWj8Un5RlpFc64J
	/RyWajlXEoxfPOjDwQb7aEtGXUnFAbaikVeVI6YEYcVJt6PDmfdwV/jETzSxKejzZ0yAMOjOFq9
	K6iPpW6V9EtNv/zqRioHcFb1CBwhQ==
X-Received: by 2002:a53:d611:0:b0:644:795a:391 with SMTP id 956f58d0204a3-64e6308d775mr8215668d50.60.1773619785212;
        Sun, 15 Mar 2026 17:09:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64e65b63601sm4803012d50.18.2026.03.15.17.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 17:09:44 -0700 (PDT)
Date: Sun, 15 Mar 2026 20:09:41 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] .editorconfig: separate tree-wide glob patterns
Message-ID: <abdKRVm29/zJsMZW@nand.local>
References: <518d71de9cdd71d0fc259740cf0da075bcf79746.1773609807.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <518d71de9cdd71d0fc259740cf0da075bcf79746.1773609807.git.me@ttaylorr.com>

On Sun, Mar 15, 2026 at 05:23:31PM -0400, Taylor Blau wrote:
> ---
>  .editorconfig | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Heh, serves me right for trying to send something to the list after
vacation without being fully caught up ;-). Patrick already took care of
this in his series [1].

Our approach is ever so slightly different, but the end result is the
same. His patch is further along, so let's drop this one in favor of
his.

Sorry for the noise :-).

Thanks,
Taylor

[1]: https://lore.kernel.org/git/20260311-b4-pks-editorconfig-fix-subdirs-v1-1-4938193ccd31@pks.im/
