Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975BE18CC1E
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 22:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722380144; cv=none; b=nMiYcwi/s6JrdGnFZ6BCD6j4EFEW/p19+Bzbh2jBel9emURnh95dSf7RT2I5RPJKWlSj4vemL92EOpj9WvEXzwd7X2hJZYhdMQt25GOmiPKlTaS0p6JUg7F0boJe/pZNEqmFh/S3P2DjLeuDx3UjlTMHcOhCA1+kClFbQ58GyOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722380144; c=relaxed/simple;
	bh=GzaULOlzwrCADHb8BMzLsw5itkc/xhNPjmkK31CYr1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXg4jHlZYIC+N9ScvZcq02w0NRxFqo6PVa2T+6ORAuZRPQypKQYQJNRLnDmnGsYZOhPN7MuNnP3BbOPZwc2KEW4FYT2AJq/g80i3k3McnXS/SDI9Dx/cG4nNZ6CNcZA8PMPTrpfxH2em6emVRzZQ+6ZqquxBodD4FWytBxPwwfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8PbUXdF; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8PbUXdF"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3dab336717fso3472760b6e.0
        for <git@vger.kernel.org>; Tue, 30 Jul 2024 15:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722380142; x=1722984942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=amBz1weOKLLA6PuIJD85N+K6+NlonQZVmzCJ00yABKE=;
        b=d8PbUXdFCONPuBzyrfEB0AGJlYeGHPPwuGN/YTlp8wECKJWnrRrF8JxN2PnH7uupzG
         clqpzy5UDgRSWZe0BmWRQ1AqebAFeJrtPMfR9Ct1ANGJasORDTw9uhqap8BvjDQMBZTf
         Ul6kol1Hz313qIiqZCj3dq2NN2e9dpA8FgFvaG2oaXQyBQtgUvY88+IyjQolSKS0ugHG
         gp1p2LF1jgY4jnuHBZks8sheE/HDQAQfSMwjCPAHa/B2FnLRCn+s1TlgA87A6au624DK
         1xaHDKC+sLGmK3+FdyKH9iOueFrTKBLTMhi8k3TaxTjyQUIldzWfNUp/X6PbqkBqZ4ex
         4G4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722380142; x=1722984942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amBz1weOKLLA6PuIJD85N+K6+NlonQZVmzCJ00yABKE=;
        b=vFlrreP1x+vXVMjhCk52XjTLkUvmJqToYKqpPMgYleHaniSKr4cTTl7wwm+vsUnOw0
         FQPbIsx++UQ5MC6sYFV0ccZXSmMiDSVzvSOgtWVBgh43YWqdkO1itLQdkUcRrModWwEd
         ruu8qBgz9mtrqRQ7T6Of6QzInVv7vmrAbPcCzSzjuE5qBx/ZnEXmJefRh+XrrL7QFXIj
         baxzxFCuRS62CZKJsyDyqy19YH+vesHLTn1HekV/ZR4JfGtsdjBUg7F+gGKP24yDuYrJ
         sCAfXwtBgvR7/7YkEsDSUF2el//o8USFruaUw8w6wVYbd+3lELAvgh1h/pHEs2z9RBen
         EllA==
X-Gm-Message-State: AOJu0Yzuu7ZdwRLCCYPKuOvXl1LHsy+g9KE093jSlszxz9Xx+IvBQnX9
	VieHw07G67tk0OMswY/oJMp3hNfS0N5MFHptjXxd2GWjjbYepSxXWv8SFA==
X-Google-Smtp-Source: AGHT+IHq2iJhY/e1Bw3Be8d3NNXmhyFB17TsmkkS/PKP2K1sldQRdioIOWbvFQu+LCoqnoL9dAqw+A==
X-Received: by 2002:a05:6808:1589:b0:3d9:2f59:c0d5 with SMTP id 5614622812f47-3db2389908dmr15825855b6e.19.1722380141560;
        Tue, 30 Jul 2024 15:55:41 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3db41ff7297sm474103b6e.37.2024.07.30.15.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 15:55:41 -0700 (PDT)
Date: Tue, 30 Jul 2024 17:54:59 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] t98xx: mark Perforce tests as memory-leak free
Message-ID: <rid2hs3dx77k5gkvxmhjyaramar7dces5ml6blxwu2tkqfh3x5@3fttesbincxm>
References: <cover.1721740612.git.ps@pks.im>
 <d0a80ba403a59d2d3f05b8336f229ff27caaa9d3.1721740612.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0a80ba403a59d2d3f05b8336f229ff27caaa9d3.1721740612.git.ps@pks.im>

On 24/07/23 04:05PM, Patrick Steinhardt wrote:
> All the Perforce tests are free of memory leaks. This went unnoticed
> because most folks do not have p4 and p4d installed on their computers.
> Consequently, given that the prerequisites for running those tests
> aren't fulfilled, `TEST_PASSES_SANITIZE_LEAK=check` won't notice that
> those tests are indeed memory leak free.
> 
> Mark those tests accordingly.

Nice to have more tests marked off the list! To me, it makes sense to go
ahead and mark these tests as leak free even if we end up getting rid of
them in the future. Thanks

> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
