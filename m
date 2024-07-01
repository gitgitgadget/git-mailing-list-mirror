Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0156416F903
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 19:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863369; cv=none; b=IE5MdN9QKFGXGx8WtyicrJC8Z6LThzkUzo+X53TjQAUy4AckQwDQmF6OLJgleiBijX5o2+y2HunqW0L7MH/WyadbSPNfcoQyinjL9eHO0KsxKEwzvDN9JG1mhsErlaw/JGtKT2iwghzWtp8N8C9rjvmooLDtoD0jE7Zgf35/Voo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863369; c=relaxed/simple;
	bh=ob5/vU/weiw9R1mvE31Bv6rFRpqTwVldjZoDOUlLjbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GufGat+RzR5fKm8gE8DHjyg13tWoO196jHhIEUmTEqjJ+kPEDXoxjCqysP3CNNA5eAUAL7PUkuhlP18hQIZUXT9i2xeNfUKKYl16KtFnfWT/8YPMKxPQ8QLto9weHD5z7KkIDRnr9c3pmh/bBkZ/pmDe2omtmUZWuthKeMbgVFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RTBOpeBf; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RTBOpeBf"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f9fb3ca81bso18307655ad.3
        for <git@vger.kernel.org>; Mon, 01 Jul 2024 12:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719863367; x=1720468167; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/4n4ccwPBiWneeheZ8ccBjy+jaJcRCzFlyaIGr9nHiY=;
        b=RTBOpeBf1DC3LqAPpZf0fzr4aFvHLMsZFD0a5fPZHKQBtbk/eI4HroE00olu+XsiVJ
         q6Z5NxJae4mco1XQtFxav1KCSW0tBhn6LAnjGSdGrHuvX8X2v1idjjYBG2pNrvgk4Pcn
         NTNJXcbENUKHTVkp2rKCHmZELzXBiz/huy6YFss+PLc61d8rBULCwzqSCboT7OB277yV
         DE7KQM2fGAGdW8F61nCfjmZAK+J1H46VJvrzzJqWdxg1YEQaK5KQ6Ec/crh+L58wzD5I
         UYWNL78qccp5GLCM84HXKLaxhhLUrg8hyHLFN7UZ/XHU+6YBqGlbEpBqYa+i32a53y9R
         oLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719863367; x=1720468167;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/4n4ccwPBiWneeheZ8ccBjy+jaJcRCzFlyaIGr9nHiY=;
        b=MsTNTo84sPOlRkVznDj5SwIKaW7UxDLp81c01V5iCE3YuWNe9/XGmEAQzQTzxFJlY5
         XYeCt4DKzXEPLutse2YneO8d8ZJa84xDsfq4ebFYxHvLVA1XwCazNcgBZJ/LipPCeKgg
         e6IYbwSxdpzndkOkJ+wPqt0LqjgQfSp2Orkkim5hWGfnfdP6xy9+AUwuJQ+Oz17paRhI
         5b9+AVrfbtrITyErXpZaPJcXV9dq4tQ7PlOwUm6v1bK01ab/jmD+NJ/p2IQBg+80y2cb
         as4ljyoK/c5kqqv6erVRNdM+uhe5PFZepEOOdYpgye5iYTLj5r/dlplt2cUtfvfEslSL
         uUHw==
X-Gm-Message-State: AOJu0Yw8VYpJL9BDjsoNm1Bs9p0qTiCup0ksjKCOotxHIkCZvj35lkYk
	rXapq9KZ1X9XT2GdI8knddRRqR8gofIkA8Eqnm0AlmcH4J2dUYrl+qvvmRo91g==
X-Google-Smtp-Source: AGHT+IEPXH3IzCZzAjiHIwJRdL7i7f6jk4vt419tsxM9jIQiN3tR1huZp3M/eU/EcoCXphIqD1q/rA==
X-Received: by 2002:a17:902:d4c7:b0:1f8:6776:7ab7 with SMTP id d9443c01a7336-1fadbc85c0bmr30632545ad.24.1719863366941;
        Mon, 01 Jul 2024 12:49:26 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:e464:1819:7745:be03])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e38c0sm68900535ad.71.2024.07.01.12.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 12:49:25 -0700 (PDT)
Date: Mon, 1 Jul 2024 12:49:21 -0700
From: Josh Steadmon <steadmon@google.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 3/6] t-ctype: use TEST_RUN
Message-ID: <eh556xjlxipeyumm3gchiiggyogpcuznil5kwvudcpyecj4uxq@uy5tk66blzsl>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, Git List <git@vger.kernel.org>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <abb96bfc-ed97-4c8e-a99a-0dadce45398e@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abb96bfc-ed97-4c8e-a99a-0dadce45398e@web.de>

On 2024.06.29 17:44, René Scharfe wrote:
> Use the macro TEST_RUN instead of the internal functions
> test__run_begin() and test__run_end().
> 
> Signed-off-by: René Scharfe <l.s.r@web.de>

Nitpick: please expand the commit message here as you did for the
following patches.
