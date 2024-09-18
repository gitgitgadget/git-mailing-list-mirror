Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC13189F57
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726665194; cv=none; b=oqGU6LA2aoGb32sxYgwvtJPxsamGgy5wYWeC02ETZO660oaOx34IPnpXcySF2F6/sTmPAmhPIvbpjuJfW8FKk45TujZsdgjs3YfMgBFuXguMVVKZsPjV1pqSUIfil4+6UPhafy/IFJOIfO1y8J+jYqt9O8uvPaeOuR0gbKzxu2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726665194; c=relaxed/simple;
	bh=Ec3b4038BFVNCewEXh2OUBKZuoyMShyYjguzvs9zZq8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JwNpqwh6QbFOV15ANN+1Ey3VOk3gQ9/AkDdWj1zmGqZfqA88ytA0sXaYHYn7MCxkdiaLROgceyroRGEaDGmpb4qsEgJOJgNg4TyC0WU5akUF5DhsXJuYujzyHJGD3ikLGJuAgDuoRDD3otYgd7vzHmQLUB85nagRSXVUmrQ8hoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=O3Ye12UF; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="O3Ye12UF"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6ddceaaa9f4so25294267b3.2
        for <git@vger.kernel.org>; Wed, 18 Sep 2024 06:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1726665192; x=1727269992; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lRYWkggd/tK2Qf5UwaSwCzdpLW1/n2yOj/KxGE2Yw6Q=;
        b=O3Ye12UFYlDOn/hyZWXpiSHnDuuq1/RnuGDcfjmEYzEIONyytlWkxevL1t0k/pD+xl
         CXFQIR/hv6T+XqW5XotLtwRjiJ+6RyQMeFtIg+5YGqALcYTVIvFM634MZOpcZ1hnWDAl
         LLhNgtyTOKhtvCWdYmRFNvyE8N7XEr4Y3p1F+COesFLA2GFMcJlLb9uBiOfAH5dx7gCq
         RdCqoaR3LmY1yNTrXff9w5xdqXwkjfETtapN1OMfgs85zoPaPB8zqMohC5XLWRdxIM1e
         egjnDZahHWg+9uFyv0+IFMdSQDCuEC6E4PXRWdK69YiE+lS9GjbpndmjWjh9U74EzA28
         6Rrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726665192; x=1727269992;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lRYWkggd/tK2Qf5UwaSwCzdpLW1/n2yOj/KxGE2Yw6Q=;
        b=d4xjBUgGPj4hcp9LB5JsItAQ5z1LslqqR6qy2xaCXThuFehUuxQQ8NDN4prmktEFoW
         lBnn847z2n9bp6li9o8vI3c9a/nEfl1+V3v2iHlrXhGfXmdTZ0yXGZNiQO561LBVDwaS
         Zmp/w2Cadb9QCEUxMovxGxUgeW5bmV6oY93OVi5hiXJMVw4pF13MCut+KlaL37Nwb8DW
         U0XTzKMkNq12S+Ub2sXWA/m2y0T+UitHwPfswtS5L/5J+aFYVrVD3AnOX5qL2EtFVEIx
         bYf4Oe6FdceuDucbRWZkMTLii7aCPA7YDfhie2jHp+x+mMqpABu8o2Uw/WDoorGMJw67
         VHTg==
X-Gm-Message-State: AOJu0Yx6s7zbfkzWzkd4JynBohAtOrMzACJY1/ZvOkBY6UKst6iVak3l
	88/c5zepFbkITyJ9+F0XmXX01Lkl+ViPCAOwFlWIPf312e2OK588J8oaCMfmkkh6myp2nS/S6k8
	OixL1SA==
X-Google-Smtp-Source: AGHT+IHlXPgVwY+pBhUDpyqR2Z1uS5bOxBcHsOTXl8ZjEfEuNRUq91sjMWK9M+PLvy/W7WfVVJ+2ag==
X-Received: by 2002:a05:690c:6611:b0:65f:d27d:3f6a with SMTP id 00721157ae682-6ddc6919f71mr83781487b3.7.1726665191941;
        Wed, 18 Sep 2024 06:13:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6dbe2ee7c75sm17696997b3.119.2024.09.18.06.13.11
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 06:13:11 -0700 (PDT)
Date: Wed, 18 Sep 2024 09:13:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: Git / Software Freedom Conservancy status report (2024)
Message-ID: <ZurR5HGfhktqZPa+@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

I wrote up a small update on the Git project's activities at Software
Freedom Conservancy over the past year, but vger keeps marking it as
spam-y.

Instead of spending more time trying to figure that out, here's a link
to a copy of that report as a public Gist :-).

    https://gist.github.com/ttaylorr/cc41512caafefab110ad7a0b8a088750

Feel free to respond here with any questions or comments.

Thanks,
Taylor
