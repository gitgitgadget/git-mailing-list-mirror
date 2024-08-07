Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAEC13D265
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 23:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723072993; cv=none; b=IJzKWaM8Y/Rcuhu17Tqe0KCZdSvoowDfHDEjIqTUyub56A5pxv3+ayZ93xS0JCiddgzoeyXAgd9fgojkiGPQM2QtwMZjYkpDqPmMQDJQA3vLiKK3itzUsPntGEaq7T2IlSTj4fNXTptp8cNGJbCxDnyMT+5roW2H2u1WA1I9bE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723072993; c=relaxed/simple;
	bh=7JMvhOfDGm5mzKJIURp86VgSnxBwSbnjdVndzVSSKGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsdreBoSYGkHzL2rnaCRKLr0wE1gPRpIN4xlPYSOzUnuFHlybA5QB2i88F4F1dRioFfylj0CfTmLkY7Sx3V7F3H7b9otbqBlNBPH0mGaIjlcHW6oobIUEavH4jLGwf3gJ9dLeLn9cFKmYEzzHtffCxvYgNO5CDZKibN2efrRIsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zy8ByoEZ; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zy8ByoEZ"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2689f74963bso249022fac.0
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 16:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723072991; x=1723677791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GsyCvptysQT+DujRX2qY/2GmscKhWpmNEwjoT+/PJR8=;
        b=zy8ByoEZDNJwcBGjiQeB5xx8mFv4UgKk0cr746/F3GfR+UgLb0w3mjHDypexBeMHhw
         VbcV7qTvJm5uwnmMJ+1uYyPozoIey89CczeQUFgZ4ycPi+RLaxuzgOsGAiutXGJFB5zw
         mecoXey1OZltMoRIhdifPSOirKa/4iW8z6CSdurS+enoelH4Vcn2tGrKlkBS/2ZX/VPN
         yGEapF12OGFBsI5b1CUW5Vdse0C5DVxPB5BbwPtjVbFamRlYaubqqy+55YmT2abDJ5QZ
         7T0kSBsQDR8EBahvKi5OgD8OGpm7NLnpCmgYqTHOfzt8/BEgheoJOQzMbpg79yYXnsm6
         ghFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723072991; x=1723677791;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GsyCvptysQT+DujRX2qY/2GmscKhWpmNEwjoT+/PJR8=;
        b=GkGAoAsfN6x5UOfDK74jokrutriJQsUCgWb/N1GCoOsJksBt5j03m6fPC7tihx7cjx
         tBtbRBwMrfKn+C2VywLh4gCU+9gn4EJUa/y9ZU/c4PtYqeO2Q56POdm66udhiBKgJnCc
         VzPlJbcF1ty6Yk3eBUKjcCxnvqYQq0KIS/fPCLmZtIRFTm2d7Befjl6V6SC6xsDkEz36
         ri7oZ7znxdKoUsNeHB/V/BvgxEOiJEbzg7LjaLE36p+wFThNW6V6nmYFY03ejS2v1OSA
         TnwV8j+9t7c8rkIl9IooClWt9kyr78mLfqGfntU42UITN3TqgKIX13WJlbGdwy0BilbB
         BNJQ==
X-Gm-Message-State: AOJu0YxEfjF4+IPSvJJvheDHxxC0sJLzrzxh7DgaHi/bTA7r5EuPK9yx
	e1TLNAvYyHjeRhtSK9fL5be9wImU1lFczkIpgqiOUu1EONBGTDa2IE2LTLxoyg==
X-Google-Smtp-Source: AGHT+IHVmmkMslWkvFWejKOQ2WUdLUCtz7VNAIq7C10garivPA+zwSNpCKoQ/HR9sCQ5tyV4fI/95w==
X-Received: by 2002:a05:6870:971f:b0:260:fc49:3e96 with SMTP id 586e51a60fabf-2692b7fd2e4mr154829fac.46.1723072990600;
        Wed, 07 Aug 2024 16:23:10 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:c023:b8:a8df:17c3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb2fa3dasm38855b3a.193.2024.08.07.16.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 16:23:10 -0700 (PDT)
Date: Wed, 7 Aug 2024 16:23:05 -0700
From: Josh Steadmon <steadmon@google.com>
To: Mike Hommey <mh@glandium.org>
Cc: git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 2/6] repository: add initialize_repo wrapper without
 pointer
Message-ID: <5miqrfkepbzi4qzu65invte3tk7weshq2fcnkyufnoih3ou6rp@siodpag6csmy>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com
References: <cover.1723054623.git.steadmon@google.com>
 <5f2e816cf6359725f2a86ce1d08e5e272fba4dac.1723054623.git.steadmon@google.com>
 <20240807225246.7jhqioyqh4e2ibza@glandium.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807225246.7jhqioyqh4e2ibza@glandium.org>

On 2024.08.08 07:52, Mike Hommey wrote:
> On Wed, Aug 07, 2024 at 11:21:27AM -0700, Josh Steadmon wrote:
> > Non-C external consumers of libgit.a have to redefine the `repository`
> > object in their own language if they want to call
> > initialize_repository() to ensure memory for the object is allocated
> > correctly. This is not ideal for external consumers that have no need
> > for the entire `the_repository` object but need to call other functions
> > from an initialized repository. Therefore, add a friendly
> > initialize_repository() wrapper without a `the_repository` pointer.
> 
> Technically speaking, you don't really need this.
> 
> You can define `repository` as an opaque type in Rust:
> ```
> #[allow(non_camel_case_types)]
> #[repr(C)]
> pub struct repository([u8; 0]);
> ```
> 
> And define `the_repository` as an extern symbol:
> ```
> extern "C" {
>     pub static mut the_repository: *mut repository;
> }
> ```
> 
> Mike

I've actually already done a refactor for V2 that will avoid using this
patch entirely, but thank you for the pointer. We do something similar
to opaquely wrap configset pointers in a later patch (we use an empty
enum there, I'm not sure whether that approach or a zero-size array is
preferred).
