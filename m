Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08FF15C137
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 09:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726566834; cv=none; b=PJUzbihvK4VnDaATVvZ5eihU+nbD+wtLASYJ3dtwt/R4q2lbLmIFuHlJEW2G+g3UdkmDFfp7EXEur+xmyVOOzgVCLCUWvgsn7JeXHIS127z/yMPdXyGczeAlA0Hdck2QKg2Vc4FRdZ0geC6DGm4ClKTY0AWo+rSSraf7qRUkHoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726566834; c=relaxed/simple;
	bh=ofsCzyc6JZcyCOCt6yNfgTVZNEpHqLSiao06fgsfzPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knAY2ktQyMPOyCiJScEvpJLIdVAzLMcsOwK1op046XI1/pbDs+P/lgR0XmqP1mM0K3V40rYsuqvqExhdAaZlJKxpPzLxccPlDdvNA3WJvDe+6uAi3f/YhIAQNTF4ogpcoXZPJ8YXK8UbB7lLLHfEcE+pLvgfVOlAzX5detDyLf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=xCG+xt3t; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="xCG+xt3t"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-82ce603d8daso177805439f.0
        for <git@vger.kernel.org>; Tue, 17 Sep 2024 02:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1726566832; x=1727171632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ofsCzyc6JZcyCOCt6yNfgTVZNEpHqLSiao06fgsfzPQ=;
        b=xCG+xt3tomnJjgMnevG0ZmxLcrfCRf168id2Sz4QLcTa7JV1uS34vO8rY8T1IQDjA2
         gdIA4X5+2HF7hhkwnMpbLnHtw/7L+wFQwzPykdxAfwXKCI0O1m7digCuQIT8blIvmGUO
         mDZDwJAVceATQm8x1LsCT+Dob4h9+7PCZN5njiBounLgrBh+Bv+1hP2oUezvoUSLJ3zh
         oqEQUt4O+pn5djG7v1jVsVZ/WS3VytBc28wMYYrum1gkCqhtTLMKPTODlQRhCSyfgNXM
         8RSE7UgwbDRu8aH2OCRQeFs9MU2duCjxWEZdRAuYIrdIeQhO6a2UjXF8D2XZuOUmUUAa
         SK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726566832; x=1727171632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofsCzyc6JZcyCOCt6yNfgTVZNEpHqLSiao06fgsfzPQ=;
        b=Shk5yCxDMeR95LJJRKKRU8pWrV1mUxzN/gBNEk7Nxz9KujivmVsDl1TzVx3tL+1irf
         O1Io6YrA9HltIuhQ7LZAWsyMle4O2p2K1Xqqni89tF1PHKKM3L0Qa38t1wKkcjQnnpgd
         SUL2arYBw972axuKV8DiI+a6d3zOp9mL00fYQiCWqmoKDR33BcjC2sr+lpD+TFrJn8Fy
         SsfExRwxsffrwssVmeQAxcIfS4uadRZ7I6QOI9SEu2f5JR04ZA4skgdSpEK7NBRr8ybO
         ZCQcOOH4WsrDPDX1ckrO1lBiULuOlpaOhz7ah158m/RjwRpmHO51wzqKdM+Qw7vQSvjw
         4NzA==
X-Gm-Message-State: AOJu0Yw5j9MwIi+BJGEQrCFhAtYqMaUSq1FFk+8hbD6YEUB5J2uSWBrN
	vpjQwCBA6qkRkA5ipbXmzpJgBpVgD61Y4DwUhDM7NFBOiZPNAbBybJtpIsCPQNxUhump7EL2XZu
	laPvw1g==
X-Google-Smtp-Source: AGHT+IHiprF6QRH021nyKxdPKg2t7qIXrMo1yWCpAeH09XcAF4eREOx5zh3FNsdPZ9yT/qp7sYtxjg==
X-Received: by 2002:a05:6e02:218c:b0:3a0:9050:702a with SMTP id e9e14a558f8ab-3a090507262mr102957715ab.17.1726566831947;
        Tue, 17 Sep 2024 02:53:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ec2bc56sm1908885173.72.2024.09.17.02.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 02:53:51 -0700 (PDT)
Date: Tue, 17 Sep 2024 05:53:48 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 6/6] refs/reftable: wire up support for exclude
 patterns
Message-ID: <ZulRrH2Pgrv/Cr/X@nand.local>
References: <cover.1725881266.git.ps@pks.im>
 <cover.1726476401.git.ps@pks.im>
 <050f4906393d1f9c58a6b6bc695b004695d219be.1726476401.git.ps@pks.im>
 <ZulLWJWLgU7gL1MK@nand.local>
 <ZulOLLdh1_jrYcN2@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZulOLLdh1_jrYcN2@pks.im>

On Tue, Sep 17, 2024 at 11:39:04AM +0200, Patrick Steinhardt wrote:
> > Ugh, I just read the next hunk below, so ignore me here ;-).
>
> ;)
>
> I was also wondering whether we'd want to amend the generic parts of the
> refs interface to filter out globs. But it is entirely feasible that a
> backend can indeed filter out globs efficiently, even though none of the
> current ones can. So it kind of makes sense to keep things as-is and let
> the backends themselves decide what they can use.

Yep, agreed.

> > One question I had reading this is why we don't filter these out on the
> > fly in the iterator itself instead of allocating a separate array that
> > we have to xstrdup() into and free later on.
> >
> > We may be at the point of diminishing returns here, but I wonder if
> > allocating this thing is more expensive than a few redundant strcmp()s
> > and calls to is_glob_special(). I dunno.
>
> I think duplicating the array is the right thing to do anyway to not get
> weird lifetime issues with the exclude patterns. A caller may set up a
> ref iterator that they may end up using for longer than they keep alive
> the exlude patterns passed to the iterator. So by duplicating the array
> we might end up wasting a bit of memory, but we avoid such lifetime
> problems completely, which I think is a win to make the infrastructure
> less fragile.

OK, I trust your judgement here over my own as not having nearly the
familiarity with reftables as you do.

Thanks,
Taylor
