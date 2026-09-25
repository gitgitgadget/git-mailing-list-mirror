Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF7148125E
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 09:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790328543; cv=none; b=TUkCtnj7518vH9kQ8bNvoyKyuM5+bLpmvZqZnT1HmzpuG/beC91QLX2aPF7H14jj2KBXy6xGWSWY731aOS7bKssuxXXdU5N3yEbWIcu4JL3Dr+qwwcxtuFsXk0Qx8K5hnBXl0bWv2p6I4QDO5uCOjOq0F/uhuC+KCX4PeJbDHB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790328543; c=relaxed/simple;
	bh=0t4qQnZLcZWOsCadKtbXJTpf2W/5KcHXauAJ/eEyTsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwIlRYaN+Iz5A78G2U6Dn2cb6BhAOgZT6yIIAgQDv6VwPBAsirlybhgLF0uyAFYRyib6ohh+UpZ/OPz+VpMsTZ66HGMJbqPZhm408WKzJgrexYxAuycbOH/vo2UBFO7PcDvwN22ehB8vfwr89zAa48bpnj3HI3vCSSBJpUJXAtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMjkMPhS; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMjkMPhS"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a6056ac81fso1075195a12.2
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 02:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790328540; x=1790933340; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x2hSTWHCyuTzi3DN+2JZJbohKEO0ZXLx+gCt9FnMQRk=;
        b=BMjkMPhS48UI4AUvTqAoXjipkJICfgLIE01C0hutNdfZiHpmSXy8H6uQhIgxpK1gju
         h3jX2nBQhScseSpWyp/NaBGcp64qDLT9TFKYtsUqbV2iUZx+SvMsYXVpf3ekcUKLsEcJ
         Ju1nk++wXl6pnVYqyAyHDQbOnuE5Cc+qosR2y0vxRCmPrqqPCq46zYIhTkE2jYunxRlZ
         h14DuDzk9t6hPgDeUA6dqnUaXvSvPxeDVsu62390sDzSXbsSbHtK4QhjfntuTN+7C3jx
         oMPC/WgnlMdeiDh0K3FsrkruGrKx7qMt8ZOagO4H8U78arUOdh4mMN7Hd9FRHzMS8RGG
         o40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790328540; x=1790933340;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=x2hSTWHCyuTzi3DN+2JZJbohKEO0ZXLx+gCt9FnMQRk=;
        b=V838kK2scyvmeuYJuHrv247+EJd/9SOSo4I9mNpOPIFsYmqSDPHGczT7EQZKbNFgt7
         Y4ddxYM5tEFTugmBKB9LvrxI4MvwfWtTpj1GJr90lWR68y2jgwirKCSQgB6Mwdsi5edK
         4mF1k85mog+ZmPXQhypEWZm/pjafuWaEdOEMSEN+S2xZpO3v2PlFQ/44GNTKXLTKNLJm
         AOmVsn3YZpvK9eBgUZQZLbGACjklUv/i3pfHQ7+MHcRG3VHyAVwv8uZHUh24u2m2Arjr
         D0GOPwTjnk3Gws5w1yswFGCaSuvHNQeJoPKhwjyQBbWMSAephJIkjGYsAyC2c7KxFYTZ
         Sk6Q==
X-Forwarded-Encrypted: i=1; AKwUvBwETjqtSVocoV7SnqBFrCXDX7OKAv8ssTio9JIJQ0vXKdwzQ+MuHIAtWsTS+MVAZAUFxz4=@vger.kernel.org
X-Gm-Message-State: AFuF++njfQqJkjeicv4+5cs2QydP6jy3S4cbF64B6UmGGKmpG/OlqxD7
	a/yomwyxUJxppICO66jZ89FwXmbeWRcCIT2esQAIb0+vBEqiac7mD/gq
X-Gm-Gg: AYBFou34FMgby2ErCjYu5bAsFxPpLfcfUkopVf6UdsK4HMfdEpg7jTbtk0/Yn6f/DVd
	3Ageo6/duFgW1/DOF9WD+HAfAV4nCnIKpWZG6OcD0Bf7l4vgEiTzwHXAsuyBgmXewLIYQSemiyl
	Hs7vLLGo6A+MTHsK3fSXD3rD0NU3BLjHYCFlgZdj5OFvDusO8GjSpA0IyWSaKnhQxgt3hXDMWNd
	3bzaLYTGU7c3uw7wreVD79+eLOXw7mhwAVM7ofMdfi57oiwdf5Ny8G9gUfGR7LOwHMKHMJmTaVz
	1RUBlubYWo9KSeJ14LNrL1LdYFYGWtrMdVE9bT63lNNKcPeK9CP0zZq7Ww5qLURBMeABQX59pTm
	FZyPY3Y0VH+qea2Mdz0nL4fKG1ungFhWvKEb1I/2Edh0aBcHzIUScFrRBG/jgDUh1aPR/M7A+0/
	64W9eK37GWwv7y0ACwD2Wea7p2sy/6wU0Hi28FpR7UCJsn/FP6PT5Y4mYim4/TxUVAqbL7d3sTi
	8qWwAFc/9/kl//GADBi4wXlJQ==
X-Received: by 2002:a05:6938:a08a:20b0:c2a:f8e2:4231 with SMTP id a640c23a62f3a-c2af8e248ddmr2360766b.27.1790328539754;
        Fri, 25 Sep 2026 02:28:59 -0700 (PDT)
Received: from localhost (78-131-17-47.pool.digikabel.hu. [78.131.17.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae7806c47sm84596766b.55.2026.09.25.02.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 02:28:59 -0700 (PDT)
Date: Fri, 25 Sep 2026 11:28:58 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
	graysongordon-gl <graysongordon1@gmail.com>, git@vger.kernel.org,
	peff@peff.net, avarab@gmail.com
Subject: Re: [PATCH v7] http: add http.sslVerifyStatus to check stapled OCSP
 responses
Message-ID: <arY+2p3YZWlyL9Gq@szeder.dev>
References: <xmqqecfez7ie.fsf@gitster.g>
 <20260915162348.97792-1-ggordon@gitlab.com>
 <arQ/nOH+o3XwQFD/@szeder.dev>
 <xmqqwlsb63o9.fsf@gitster.g>
 <arTUNYVvCNwX1pDp@szeder.dev>
 <arTYVLnW-2GHpGGm@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <arTYVLnW-2GHpGGm@pks.im>

On Thu, Sep 24, 2026 at 09:59:16AM +0200, Patrick Steinhardt wrote:
> On Thu, Sep 24, 2026 at 09:41:41AM +0200, SZEDER Gábor wrote:
> > On Wed, Sep 23, 2026 at 02:47:18PM -0700, Junio C Hamano wrote:
> > > SZEDER Gábor <szeder.dev@gmail.com> writes:
> > > 
> > > > On Tue, Sep 15, 2026 at 12:23:48PM -0400, graysongordon-gl wrote:
> > > >> From: Grayson Gordon <graysongordon1@gmail.com>
> > > >> 
> > > >> git never sets CURLOPT_SSL_VERIFYSTATUS, so libcurl never requests the
> > > >> OCSP "Certificate Status Request" extension and any stapled response a
> > > >> server sends is ignored, including responses that explicitly state the
> > > >> certificate has been revoked.
> > > > ...
> > > > This patch was merged to 'next' the other day, and the last test in
> > > > the new t5585 fails on my system.
> > > 
> > > Sorry about a premature merge.  Since we are not in a hurry to take
> > > this topic in (or no new feature topic in general), let me revert it
> > > out of 'next' and give it a clean slate to try again.
> > 
> > Well, if you hadn't merged it, we would perhaps still be none the
> > wiser, because, alas, I don't have the bandwidth to run tests on the
> > seen branch regularly...
> > 
> > However, CI does, but I can't seem to find any CI runs that failed
> > because of this, which makes me worried that something is wrong on my
> > end.
> 
> Do you maybe run with a curl backend that doesn't properly support OCSP?
> But even if so, our test suite should notice and skip the tests.

Apparently I did!  Removing 'libcurl4-gnutls-dev' and installing
'libcurl4-openssl-dev' instead makes t5585 succeed.  Go figure.

Thanks for the hint!

