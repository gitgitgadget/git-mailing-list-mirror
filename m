Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D93A13FD85
	for <git@vger.kernel.org>; Wed, 15 May 2024 20:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715805364; cv=none; b=RY1kOV8mMl7vw/umczkeps0BIwyoSwhErzN/XeagD3TmiD981aMgoxtXw++z45ysNlHuBb7THCXXUxldQ70kjZK+9ASrf8Hu163xz7T26hSjdYOk+3lE3XeM4CikCN5xgMrbSZ1okGLKKg7S90pfr3TQlk3+xzsaaMRzIHxaan8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715805364; c=relaxed/simple;
	bh=sm2sJpjKMR1aGvSw0G+UUtGl7ohmd+sh1mPytZLMiys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z12ly0y4WjLcKtJ2NEXbliP3pDV3YiGefFPH4IF8HC3CopchSKK1tHE+Srf2Gb58cLXFmgnSzX7bJtt7fnLe2VfBvPF/Kpr5Ylyahyd/8RKP6v56Y3QfH999IOMf9+icZOk/hWlx4hxtbfU0rSFTwMelZ2MOo9vINmppVXHGISE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=usw7ovyY; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="usw7ovyY"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ee12baa01cso60935225ad.0
        for <git@vger.kernel.org>; Wed, 15 May 2024 13:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715805363; x=1716410163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BK9GZU/pih0xqXu1C3wUqO2jY3VEsoefeN68KC9ow2Y=;
        b=usw7ovyYKaMBP0h/P3VaCUjvQqbfxOaiyGstZCTygFlO4N6NpQ2Tmef/BxdOIspG4F
         iW0L9SHKwUdLy/le169SOjjYFgAOGMy+oyAqGwDyucBor2isnLvM7oJlHRzJ2k7NKgOf
         y/Ex2MCWi1wBnhG9EBpFFk0YLoHcLqNe4AploYU66KG/JlnU+pYk2TUOVIptzX/Qw/VG
         YVB1ldZVQIulflKpAWnFOVdHL6pdRavzPTRAlcfOTIO3kU6WaLsqTxAMKRwwBJG5lpM1
         kqkuan4boUUWVxxjhhGSkrw/MA4GQQb0hwX2a0cpZb66YMq3GxK8OZzp2Gah+HQvjWYI
         E+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715805363; x=1716410163;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BK9GZU/pih0xqXu1C3wUqO2jY3VEsoefeN68KC9ow2Y=;
        b=RWL3e/NmF3Tkny0cG4HThP+Qb9N7rU97sIzt72Bco3t6NHyCo4hUdLcQDa2HgFTXfu
         95jQ2IqnqIErQLPs4iLqpD0EzgK+WniBnzbk2lMeeVlLTqkl/LqdIcZNPCEASvgopdvT
         p2kadAGWmBY6yH5MlC+OvOYP8t17pO0Dlp2PYUkx7y5u78HyHmoWYPH0ES9Fi2QqukEV
         vYxt3ZRFcFxoQewJ9lJoVLuMRQOrlbDhEgVqp/cR5lIWUlxPaEhxCJ3r68UUvG6iPu5B
         LdccBnoh3FiEK+zYbKNCs16CExJCSo6VSnFyhEUCHkJMGK1AWv1l+oLSHJ9xmJISYZQ3
         Iqmw==
X-Gm-Message-State: AOJu0Yx4zoIcc8siG4mqWdMls8KzAQmw9EYpXfmJCB5V4Gu84rlYy05e
	K9/Ap922YZc1uBGHJ/EelXyCPryBADTPMe9WpYUnY9L3yPrlLL/0k0b3aXlqw/EhmqNAs5wHH3r
	lGLhg
X-Google-Smtp-Source: AGHT+IGXslmFJSI8kjmunhOM5bIPhwCaKsTnb5s0wtGB5q/B4kwlZ5qeZrBIyl1RA6mw2jajIX0sJg==
X-Received: by 2002:a17:902:b08f:b0:1e8:ef23:80f6 with SMTP id d9443c01a7336-1ef43e23412mr134520245ad.37.1715805362412;
        Wed, 15 May 2024 13:36:02 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:49d2:d87e:dff4:5956])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad6018sm123773715ad.71.2024.05.15.13.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 13:36:01 -0700 (PDT)
Date: Wed, 15 May 2024 13:35:56 -0700
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 0/2] Describe life cycle of a patch series
Message-ID: <ohvjmfopwq74ndsvnkzzw7h4i3zoxvf5iwevokfxjeza5wbq2f@q4olaeuvmya2>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
References: <xmqqy18issfv.fsf@gitster.g>
 <20240510165526.1412338-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510165526.1412338-1-gitster@pobox.com>

On 2024.05.10 09:55, Junio C Hamano wrote:
> Start the SubmittingPatches document by describing the life cycle of
> a typical patch series to give the readers a sense of what process
> to expect, including how the key events like rerolls, merge to 'next',
> and graduation to 'master' happen, and what are expected of them.
> 
> Relative to the initial version, 
> 
>  . [Patch 1/2] explains in its proposed log message that there is no
>    content changes except for the section level adjustment
> 
>  . [Patch 2/2] has lost a paragraph about how the process is
>    different from the "ideal", which is irrelevant to the target
>    audience who want to learn what the current practice is.
> 
> I'll follow these patches up with a separate patch to clarify the
> proposed "decision making" document by making it more focused on
> deciding on issues at levels higher than an individual patch series,
> which is fully covered by the SubmittingPatches document.
> 
> Junio C Hamano (2):
>   SubmittingPatches: move the patch-flow section earlier
>   SubmittingPatches: extend the "flow" section
> 
>  Documentation/SubmittingPatches | 121 ++++++++++++++++++--------------
>  1 file changed, 70 insertions(+), 51 deletions(-)
> 
> -- 
> 2.45.0-119-g0f3415f1f8
> 

This version looks good to me.
