Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEA9168BD
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 20:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729198667; cv=none; b=uOym7Qkc7h9Z437tLUrsx4V/Kj+6AMMot2vooaWtH1J5h6mDVj8toXJKql0shYOFNPK57krUCaEoDHbZVtx//MWhSuzNaAOF8G9mMwqXAEPc4hEyTFXzG7t3rgstLGaXfCRe/eWXX24J64PGRT98GNtcKUYikGSqu3oIydzoyzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729198667; c=relaxed/simple;
	bh=Ja+bGwkmNb45DkFAFPEJcOu8dXJQxLV0ygygHOgxQSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ni8+SvuCUwP1/BIdBNMn2fFUmEY9974bbElrxGzC4v1B2m+aQlRbddOSQAoi1Hjwlg3w9aVaLrLiFd877Gl4v6ycAR9y1KMfWaKhGDwBkz/uRdUiH7TP0bzIVytPeBN58d2O+l/zaj/iRjtmFFUWvs6GbGLDfDkxPdls8wLnb4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=MWGlJRp8; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="MWGlJRp8"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e305c2987bso14299677b3.0
        for <git@vger.kernel.org>; Thu, 17 Oct 2024 13:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729198665; x=1729803465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PELEnmu0WohVBsPSpQoln9ucGxcTSIw5BcPs+lD3ygs=;
        b=MWGlJRp8acwXJM5kJxzeU3GxhpIo+lhxZpVY4eEilw9VGeM9Pn0ah8D9ReExC3Pg1h
         it8GiK57T0rUy2L/VcrHqsjM9FiKlsq54S8lznYPZLPc8LMxIFUMZeVuVmqK46XHEk2l
         F7IJ1NvNc0i5R/2a4uBwDCoCSySEJnhD5ZX55Le3LCHxV/3OuiHjv+Ofa93FilbQkcBj
         ampyTqWqY0tteaj04/kQPTbG4Rl9u25aOGMQBB/XFDSqAzZ7Ryo0KBXqZ8sKRNqSiNDr
         C5xQWvHkR8yq9PHbKxTzFLBe0mXWniGbWxgRzKdZDLmBdR421/N60YPlgiMLNj8tvbZZ
         2NHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729198665; x=1729803465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PELEnmu0WohVBsPSpQoln9ucGxcTSIw5BcPs+lD3ygs=;
        b=FJUtRAz11sakglL4GUIOgkKFGMdU2KrzDM+oeXwbDZM9EXWDtLxF6zAEGMm9S4cW/A
         i/NLKONrMbthGIdy8X4I0b1TOzhPbX3OjuRg2XHnvpHtJyl9dKQw55eo6WEidXgTJ4fB
         TE3cKjr9oYpucwPam+dpJ3M6QGjub9EBHKIMQpBmEX86t39N9hGRyFEwYShUuWMg2qDy
         9UL+N33dQdQnSBHOm8TipjSz1uqf0XGOoF8I2DGSNMKfCk8XyDQAhrEyTDZv2l+LX3tY
         tMxcYnAUqfKrgSGjvnAB4b5i7xdwxpfv7U2KZqWl9AW47uL9bIrmO3sndtWceCvoF70S
         ptOQ==
X-Gm-Message-State: AOJu0YxkKGBT61EGWhbS6mJCAK+/tBKErmLEJiOMBOF3cCKlXgS5r9/6
	sE0akzZCj5Uold4npGvmvOjWuAv10zPHS5X3p/LiltnhlxCw2nashG9Bjhl9qz+M3GAr0gbQ5ed
	K
X-Google-Smtp-Source: AGHT+IFpvcKNZT8K59+fdMPM28b8/hn6dChN1X9kuICbyR0JkUh35aD1Iw0m8oULHi7ikq8KNYoj9Q==
X-Received: by 2002:a05:690c:26ca:b0:6e3:d8ca:f00 with SMTP id 00721157ae682-6e5bfd4bdbamr2605937b3.44.1729198664753;
        Thu, 17 Oct 2024 13:57:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5c00deccbsm361947b3.33.2024.10.17.13.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 13:57:44 -0700 (PDT)
Date: Thu, 17 Oct 2024 16:57:42 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] ref-filter: format iteratively with lexicographic
 refname sorting
Message-ID: <ZxF6RkjnZwObHbRb@nand.local>
References: <a873ed828ccae426214cc8f87610df97ff9a269e.1729055871.git.ps@pks.im>
 <e0daa6a2eac97c2b18a53399b7c124fc8d3d238d.1729141657.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e0daa6a2eac97c2b18a53399b7c124fc8d3d238d.1729141657.git.ps@pks.im>

On Thu, Oct 17, 2024 at 07:09:51AM +0200, Patrick Steinhardt wrote:
>  ref-filter.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)

Looking good. Let's see if Peff has any further comments, otherwise I
think we can start merging this one down.

Thanks,
Taylor
