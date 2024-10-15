Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880529461
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 00:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728952160; cv=none; b=SD3UVAPiiOJ7lB8HBhA477bUeQSPjwrRgpTcfaPgsEjczbmLgkvs3nPTpCqCZsIfdpgAMHtFA7q8f9f2Neoi2TkWTO1wk4DAivRmcJHye8kyvP+NDYkgBwCVSCEzxxVedtLa00nlAKjsM7d2g68XgdCC8nrqTusPY2CrqzOJd58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728952160; c=relaxed/simple;
	bh=Qe9CxmHmTPHkc7QVS2Lg95VMPO/84Kbrh6vo27kUBnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIAdD5bH296WyJzUCDgP81oQu1i5jiKzIqebVFpWfZGx4cMX1KT5wpIXrLJjM3d62rVJkQXLS0kk1NAglfEhDQGR04wfXA0sk/9w0mlLbxNpASAxySaSwrBszGn0xZ1Gyq7tckEHd8BYb/95jmF04nyrBbMVW4JhvjYcoW6iqcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=SbB/oiKv; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="SbB/oiKv"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b12a02596aso94759185a.2
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 17:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728952157; x=1729556957; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qe9CxmHmTPHkc7QVS2Lg95VMPO/84Kbrh6vo27kUBnQ=;
        b=SbB/oiKv6e6z/5E1Xg/XaxnCZCxG0aUedt3p2BNhf6tw15IXo7miVH/xUz0qDE2/J7
         79OJ88Sd+BknSS/ZobSeD/eybiR5lAV7Qoog5yC4oFPiKl8nflqMBGiWTBX5fUk12ZfW
         NJ/Z76OkdZAIt512aqrn4tEZcWStjEhYEvFVT0UzEewErDCws2QnsYZe+KPhW7pK26G3
         GqNeekrqlVTrRuK4khmF55OaNLPi70W6RUY1eLFUr9EQVuJChT4W2T2lga1nGzsgUkpN
         ilA+h6rYuFClqj5rQfeMaOQ7/EMexK6lM/siQjM/eQeL8PNQwgKQtsxVkzhzBPFfeJcU
         Z9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728952157; x=1729556957;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qe9CxmHmTPHkc7QVS2Lg95VMPO/84Kbrh6vo27kUBnQ=;
        b=bVvritvGSF1LJdzWf2Y9rEZZw3C6fu1S1tdpqiwDwPfN+UPAqSvZnirsCxh2GBNYju
         A1DfL3gsXVlj5sUNoHlC48dQmVxA3HZgexH1G4n8Sk/iV1loLBelwwC1Fq1iJuF5eyDe
         xMdnzaGe5zChTWAL0LZTJaGNVLBfXV+5ZXdkyJxNBn0pGIewsw/h0ETpvNK3j6N9m2aS
         F5u2t+8qE8ElpXvvfM9IA5rz6QyT15G2RNqnFHBMygmfITGZ2N8dPmynmCMZgfrWeUrT
         8d3z3qOThxrYz4XoBjOZRKB3dzy+PHivrKpZF+7Zn1S0Qb8+w6sovmaWbNNgdEhk20Ff
         93Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUk4oCcW5x+lS9rdmVQEmGhNpPeCJG3Z/XaIBcFT4yExxLB3s4AYokC3cArznKsF0vxDa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLgdk70a2POqU1KPKnE6ZINKG4d7RWQ8IbxJB9WzbbY2yoRm+n
	tWWvOxnN3V+5hNzBL6A5pTDdqvic8dMp94Ppr18CJUPJoWREOvHzkqVJRjsge1s=
X-Google-Smtp-Source: AGHT+IFgr/KvCFMGx3UgvcAVQ9IZcEtAf8m7HEDCYcU8iopDCknQixTk4xTWJErlAcv0iQMRwlWeng==
X-Received: by 2002:a05:620a:4509:b0:7a9:b9c6:ab4d with SMTP id af79cd13be357-7b11a3a9c83mr2302065985a.51.1728952157392;
        Mon, 14 Oct 2024 17:29:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1363b5336sm8510185a.123.2024.10.14.17.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 17:29:17 -0700 (PDT)
Date: Mon, 14 Oct 2024 20:29:15 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 05/10] t1401: make invocation of tar(1) work with
 Win32-provided one
Message-ID: <Zw23WxDIeQh9FjJv@nand.local>
References: <cover.1728906490.git.ps@pks.im>
 <d082cd92af36610af24985ef2279c4176b1f182f.1728906490.git.ps@pks.im>
 <CAPig+cS4X=sX84XOoNiw7jVO5Gaze-155Gcd6sO-UzyFXZ1Z3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cS4X=sX84XOoNiw7jVO5Gaze-155Gcd6sO-UzyFXZ1Z3A@mail.gmail.com>

On Mon, Oct 14, 2024 at 07:23:29PM -0400, Eric Sunshine wrote:
> On Mon, Oct 14, 2024 at 8:21 AM Patrick Steinhardt <ps@pks.im> wrote:
> > Windows nowadays provides a tar(1) binary in "C:\Windows\system32". This
> > version of tar(1) doesn't seem to handle the case where directory paths
> > end with a trailing forward slash. And as we do that in t1401 the result
> > is that the test fails.
> >
> > Drop the trailing slash. Other tests that use tar(1) work alright, this
> > is the only instance where it has been failing.
> > ---
>
> Missing sign-off.

Very good catch. It sounds like we will see a reroll of this series,
then.

Thanks,
Taylor
