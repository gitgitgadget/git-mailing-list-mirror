Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC7E19005E
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 17:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723137814; cv=none; b=c4pTAZBhvYQJEJvx7RZ66uK3tjSneE3Ln/zSNsjI5aL/ngR3nJHzMvZeKCHacG/wgLL3BlkuWzQ0I9ScvD7G+bI89hmgjxPjyWgV6u77A8g9ygB6wBfTqO3FIJNc68s7SzHVj6jpijGhjz14O55xIdSTopdttE47Hnq/POLU2Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723137814; c=relaxed/simple;
	bh=kGryneWIk/qymAFZnbqABbstDid+F5EEEUsWDrdNwRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SY+wVn0O1bpD2SG5t0qRLX4nbVy2bi8UbSm/vuXOSdqyjHSX5r47pVxbgYrfS6rv+d9SDWOmzhiN09iZoQWWTDmHO903k56PoQ7Qu/B6mZ9PrxjutyNW2ZGeyS/9gt4R0VQ8+PpmhhZ25bLP0bBmsDaJKjLkR62Ac3Pu2J/NGno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mASuiYFL; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mASuiYFL"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fc569440e1so11533125ad.3
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 10:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723137813; x=1723742613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5lNbbPnw6E4WH79/oFeeGo52Qpdu1o6owsIz01EHBlo=;
        b=mASuiYFLtTQaUWizQ+BulZ7QWWK1iMzQstWoV4WxTVVj38WDdDfjp7A7n4z7GJqPk7
         WGyXgFQMoU+Owd1nK6ZSvKDor714PSaTnCGRZFKlvESN4Otf3rY8zL9JWh4tIfk76w08
         r65YdyFcq60tdAxG26ev++kAUiQkAyuDuQm4qrhqyJDXbh7cXoU2YItKSFgtiPMEWI+n
         p6kQjUyBGDGHP9mktDyEI7ubtGMmgRA0Ek+5owq1Htz5jkUh1Ls/WM5uNuoP4exl0PDG
         fRZq0G2leJKiYMorvZivKByAsFZ9vJAHNrzeDNH+YQBUuZ3UOJStmH77EjqrYjCn+gZU
         rMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723137813; x=1723742613;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5lNbbPnw6E4WH79/oFeeGo52Qpdu1o6owsIz01EHBlo=;
        b=SXgXGNHHc+slg1+ViKmmB4hFaHCHsDtBZChYJBPpXujN83kWiLHh4zFj6/5lZP+LO6
         dFgDFR+mWQuON8tKdoeWI8SAOlJVRlb+7PcMqKA2MSsGxTNKJW4UiCEXcso/7lg/NFlY
         ltaKI2jKmK0cQvyahyZQxIale8hmTWgEnnOOfJobKpMA/j6j6utvDnWtjRRBOdLOgJLM
         OwTFsOc0BmjmYY/hX6nKjDekwofTyR40DnmO/YsCVuLZgHT+TleQ3gkQLuq5zRe6Z5Df
         szKruCGZs7v5sb113BKJE5JnudyaN9Tv3Pb3iahSAR9nklR0rPUvCrM0scYYqU60MJIo
         i+Sw==
X-Gm-Message-State: AOJu0YwLEv/GpkfU8R20kPTBPSpZRpwUsPkozaWItlGPAnc2ITW41EEX
	fjg91b5AR2EOieAVchayVmViWdeUOgttoeU3rYA/b76n8gokDRb4Rh3/EvAbPg==
X-Google-Smtp-Source: AGHT+IFNVUWuhfxxOQZLEUHgFjwzCeHep6uyVbGCgarTJBmWsqy/CizCIJSwx5NRzqHlF7e28a4VoQ==
X-Received: by 2002:a17:902:e84f:b0:1fb:44e1:b5d6 with SMTP id d9443c01a7336-2009526c238mr38402345ad.23.1723137812239;
        Thu, 08 Aug 2024 10:23:32 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:fa12:a76d:ac7c:e104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff592b8a38sm126870115ad.307.2024.08.08.10.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 10:23:31 -0700 (PDT)
Date: Thu, 8 Aug 2024 10:23:27 -0700
From: Josh Steadmon <steadmon@google.com>
To: Mike Hommey <mh@glandium.org>
Cc: git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 3/6] contrib/cgit-rs: introduce Rust wrapper for
 libgit.a
Message-ID: <33jdrobowiv25qk3cfjctozeemtyox4ywlj33dqnhcjnua6n36@alzbo7hjbbll>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com
References: <cover.1723054623.git.steadmon@google.com>
 <9a846c17c891e17566a9907b3627210a6a08ea76.1723054623.git.steadmon@google.com>
 <20240807224756.2zq5hkfq5j43b7jk@glandium.org>
 <njekhcypd7x7vdxmkzbdbeblwm4bwiiz74saxdmzqeod6zz547@qkkwkmpjvwkd>
 <20240808001743.4sx32gbjtypq3rje@glandium.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808001743.4sx32gbjtypq3rje@glandium.org>

On 2024.08.08 09:17, Mike Hommey wrote:
> On Wed, Aug 07, 2024 at 04:29:54PM -0700, Josh Steadmon wrote:
> > > You might as well use `dst.display()`.
> > 
> > Wouldn't that fail silently in the event that the path is non-UTF-8? I
> > think I'd prefer to explicitly fail in that case, even if it seems
> > unlikely.
> 
> That's the theory, unfortunately, reality is that even the most central
> Rust crates don't care:
> https://github.com/rust-lang/cc-rs/blob/main/src/lib.rs#L1357-L1360
> 
> Even better, last time I tried, cargo or rustc (I don't remember which
> one it was) would blatantly fail to work if the path is not UTF-8 in the
> first place.
> 
> Mike

Thanks for the pointers. Fixed in V2.
