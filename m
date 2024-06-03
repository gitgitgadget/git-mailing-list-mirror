Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF63229A5
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 17:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717437082; cv=none; b=KU6cUI+S98rjxHr71Uj78KWugxG7xUcwMqGsIWZoZ4Lgj1kv5jx0JXniDYpnVyfcck7OvkTon4OkdEZvlBC0UnfdlEddxZaqtHAR32JVP3fMLNZW5A868nhdih6OhLJBYKDXj480l7vSkjVbQQ/GDsHva+CFXqJI9koRQLoF7Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717437082; c=relaxed/simple;
	bh=mfDkbUV7Igomkrqg6IRn31fnIF9G+nY2oq1ua1cmtN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5DcAuNf+ka1Hpao8XZgznSaPUEvzp/8l5+Wu7L/3jBCyMDZxQTJMNu2GXZztrno0jQ9kDgFX2aduia48qw1KjOuLfCsrTk/u69Y9jBaG7sDlUsnuwlWusAuCNLh3uCiV85W0GSK1qNpnMC1TjYqtaZxSNeU70m9zW2rUKU+54Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBUg/bYW; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBUg/bYW"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70249c5fb36so2521172b3a.2
        for <git@vger.kernel.org>; Mon, 03 Jun 2024 10:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717437080; x=1718041880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b4FGd44/WfuJAkVwF9ysRt9y2qNPq4+7IihIdDUtqpo=;
        b=iBUg/bYWdAfdtOCQBPPF1CjhvlNCIF07SAEAEMCv/CP50MZAnN2GbxTauIV1gutW2L
         FvhJboGSVT36DApkkFrrsEwbpuQg9wQTF6h+UgTd93r4wh4rqcpRimT+JKDvhm/O6HgG
         2idt+lBcnYtC/Zjgj47T6nvPCnBC/CMn987rMdoQoqDSAW8uNZt9r+uPsA+Us48f0b1w
         9wOimr89hJ7wFEdx0TM3HBaDwJsOSgg6/Pluhu/f/+oXul/U6nfPaQf/Yh2UQ+Rbk4jy
         6//MApJXDJxaJPKM+oafwFP/1SOcITr8oD6nN9nnmO64SwAFsRmJ1DoNnXpHq9WPJPtT
         cP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717437080; x=1718041880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4FGd44/WfuJAkVwF9ysRt9y2qNPq4+7IihIdDUtqpo=;
        b=wzco9r7MGdCSr+qIowl40+Am+E6hNro2rUTWh7aY+MiitafmWvGz4QPm0KS/BQqYZR
         Td4K4vgsUOlOL6Yt6O8YBePiK+d7ZP5VZ1MZ6iOaMTTrZRu3Zk/qEMFkPNGMfXaYcdSu
         gF2vTjqNJqUOLisxrSXCMrlntB8IAon9VPhZvgh+2ox/8nRxv1Kc5fPxsuA3gp1ULxpF
         +26PrJ27dT+kTNY7B66yCE6nLkVz98YqXP5SKNbcrSIYrpopkpXAJGQDW+BeNnWdkg8Z
         HcmTnGN78TXKVo3R1QRRlgv0QCrgiEb/uyZgpjNAMtz+QEqBEkzDvwoVtBlpBDYXpltk
         4v/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVm2E+JPc6SSAQFlr0n65Vy+g1A3NVwttaEuPSAUhz7laq6JI52c0T74FaRXOUhxSBwPL9ECIYybguDu1J4k4AS2wfC
X-Gm-Message-State: AOJu0YxCmfvCq9uzP/8Y5XDgcgPyj5MsmgkvVWq5cfOFQpBR4AeuGOV3
	1xISppN5wWMqc12ezsaovZPrt8RhmGx4RVgRpzkR0qELATbm6wMg
X-Google-Smtp-Source: AGHT+IG16CcGgijDueUIKfAw3vhkWCKrUU0vikkqnxCa8PJJc8IDK/vttqKlum9URD2h/Pv3xQgjZA==
X-Received: by 2002:a05:6a20:7495:b0:1b2:1fdb:1678 with SMTP id adf61e73a8af0-1b26f185925mr11071620637.35.1717437080016;
        Mon, 03 Jun 2024 10:51:20 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7025dca288bsm3223958b3a.156.2024.06.03.10.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 10:51:19 -0700 (PDT)
Date: Mon, 3 Jun 2024 23:21:16 +0530
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org, 
	Christian Couder <chriscool@tuxfamily.org>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH] t/: migrate helper/test-example-decorate to the
 unit testing framework
Message-ID: <uplnglu2texnwzwf4fnu6kkbpg46nfxwuhum6pzwlgqwsqksg4@xgxy4mayyrcp>
References: <20240528125837.31090-1-shyamthakkar001@gmail.com>
 <xmqq8qzsuwh1.fsf@gitster.g>
 <CAP8UFD1YVyZj-uGfGXp6UxMfj3kZC5XXNed-5s-jj=ROx4URnA@mail.gmail.com>
 <tubjmjeczh6iigem32ulffvt2ucpygbm4frsr3jsps5tv2i7v5@ly3wge23zn6f>
 <xmqqjzjbqoqc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjzjbqoqc.fsf@gitster.g>

On Thu, 30 May 2024, Junio C Hamano <gitster@pobox.com> wrote:
> Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:
> 
> > The latter provides much more context (we almost don't have to open
> > t-example-decorate.c file itself in some cases to know what failed)
> > than the former. Now, of course we can add more test_msg()s to the
> > former to improve, but I feel that this approach of splitting them
> > provides and improves the information provided on stdout _without_
> > adding any of my own test_msg()s. And I think that this is a good
> > middleground between cluttering the stdout vs providing very little
> > context while also remaining a faithful copy of the original.
> 
> If so, why stop at having four, each of which has more than one step
> that could further be split?  What's the downside?
> 
>     Note: Here in this review, I am not necessarily suggesting the
>     tests in this patch to be further split into greater number of
>     smaller helper functions.  I am primarily interested in finding
>     out what the unit test framework can further do to help unit
>     tests written using it (i.e., like this patch).  If using
>     finer-grained tests gives you better diagnosis, but if it is too
>     cumbersome to separate the tests out further, is it because the
>     framework is inadequate in some way?  How can we improve it?

It's not that the framework is inadequate in its current state
(for this test). As Christian said, in the original
test-example-decorate.c, the tests were divided into four sections 
by a space and comments like:
	/*
	 * Add 2 objects, one with a non-NULL decoration and one with a NULL
	 * decoration.
	 */

So, I also made those four sections in the form of those functions and
the comments became the test description. I definitely don't see any
downside in further dividing where it makes sense. For example, the
first test can be split into two, one which adds an object with non-NULL
decoration and one with NULL (I think you mentioned this). And the third
test can split to test lookup for a known object vs an unknown object.
Besides these I don't see where we can split.

Thanks.
