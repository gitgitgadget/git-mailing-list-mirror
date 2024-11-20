Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E131C1F01
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 22:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732143331; cv=none; b=ahFyDyQxFp+hliqJ+vX4li7TEyiM5F94tgD72zwt/OSw4mlknKPDm/lt/jDgvWuPwsdvWnnHIJJI2PLDfXVv+2BZ1x4MrPqvs0kJGvWTCd7OAOBCFuCPMxkkF47iD7xE+Sl0rB5zfeWAJnJqk0ydwFypfO11riFiSilYotQPn88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732143331; c=relaxed/simple;
	bh=xCM2kDe0tER28OxTqWFiZA/WYPvwhLUcy/S6eYMrPQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzcDR1hnt1UcOTaqE/ZZGUD/s2EW0NKE0i+ind1LV1ByUtKbpBWVtSRF0AIsA9s0izyC2ZzPA2XBrQ2S6wGX2C+e7VV/BFXChOnE+1lSmp74C4Z6pDCqXjVqQZV1WU4+09m5WTGOEyehpxrrv/Db9sv2x2swjYhcNDZUjxjBY4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=u+onblnm; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="u+onblnm"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e3836b1ed44so1204217276.1
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 14:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732143329; x=1732748129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sg9aoRmEQuonsln+WIINtwxJpLI1QMAXg4MpKhEU6wA=;
        b=u+onblnmcywmiALbn0OnKGxCgBcp3gFaeXG82S34OTQlwg89PIIEX0Wa/cBjqjFV9r
         rDBlNHdnJDA0iW0GF2uicIKMbU/aTa8Ill+73EhWPEIg/EnH6XzYb69R0SE+KDW8B5ao
         FLqsCP22121arX/qS3NovEUmJm+TzhetoggbXxafcS+kROpkL1Oh+LCKWrIb3WZZ/so7
         gWIoyqoGkHr3HzTQvBn3bPH/77sPDWOmUlFw2LH9s3C39HN0maXOJZ6P19WrbKHXW/DH
         l9ANaNo2qtvSMDn3mTbm1mEW9x3v/a7rtTJlKAClxZSJGQKYJFVtTofWrFOQfqhuINfr
         +oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732143329; x=1732748129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sg9aoRmEQuonsln+WIINtwxJpLI1QMAXg4MpKhEU6wA=;
        b=CvJ8kufXgJfKJQwjKeTf/9ZafC005JEO7yvcq45kaKsK9RENSyBA6NmFk7XFdGcJDo
         KJ19EL/tJovIW9lSu3uwLEWu5C75q9SM7WSVCZ8zpoNqKfOSRvaaD6ODluefErpAeW9o
         HujjQPTXb/FyCyp+q4IzU7Cu7FJeBfAH+QdzorUygwYLfUylLdX0y+gCuOvGOT//WwuN
         fttAaIk/+zTz/hjGi5ZfB9HKGooFk5u1R3hDS+ZQB+6y3nXSuAPzvqso7iPELj4O1iqh
         YY4RJG0O//T3DoYmaZJe3G3S6tf6yVwIlaFFX2NUjLbj94AXl40s05J56uzM6dckXKbu
         Sz7Q==
X-Gm-Message-State: AOJu0Yzm9hOF/qUVPIYdax2pYb81sfjVCg1YX6c9iLhFg60no1lUBkZ9
	OeEq0LXR9AkEYcLvv8kEjzKvyfaHjSt6XAApQpA7eerJu0wXb4s8AKIed7xgg2I=
X-Google-Smtp-Source: AGHT+IHA6/N+g8CRrlbLvtkYO4USi2/Gp4F+90F6M2PmZvuLUHt5Kc0y71si+2g8rzN8LzXM4u97cg==
X-Received: by 2002:a05:6902:701:b0:e2b:d72f:c184 with SMTP id 3f1490d57ef6-e38e14be20emr1029104276.4.1732143329211;
        Wed, 20 Nov 2024 14:55:29 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e387e72252fsm3325145276.1.2024.11.20.14.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 14:55:28 -0800 (PST)
Date: Wed, 20 Nov 2024 17:55:27 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH v7 0/9] packfile: avoid using the 'the_repository' global
 variable
Message-ID: <Zz5o35FZPFyM5KyL@nand.local>
References: <cover.1729504640.git.karthik.188@gmail.com>
 <cover.1731323350.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1731323350.git.karthik.188@gmail.com>

On Mon, Nov 11, 2024 at 12:14:00PM +0100, Karthik Nayak wrote:
> Karthik Nayak (9):
>   packfile: add repository to struct `packed_git`
>   packfile: use `repository` from `packed_git` directly
>   packfile: pass `repository` to static function in the file
>   packfile: pass down repository to `odb_pack_name`
>   packfile: pass down repository to `has_object[_kept]_pack`
>   packfile: pass down repository to `for_each_packed_object`
>   config: make `delta_base_cache_limit` a non-global variable
>   config: make `packed_git_(limit|window_size)` non-global variables
>   midx: add repository to `multi_pack_index` struct

I reviewed this round, and think that it is looking very close. There
are a couple of typofixes that I and others have noticed, which are
minor (but I think in aggregate should merit a reroll).

I did have a concern about the conversion of delta_base_cache_limit to
be a non-global variable, since I think we're determining that value
from within unpack_entry() in a more expensive manner than is possible.

So I think that merits some investigation, and will likely result in
some changes that we should consider before merging.

Karthik: if you do end up rerolling this, please feel free to include
the patch I sent in [1] on top, which should make the maintainer's life
a bit easier than adding another topic dependent upon this one ;-).

Thanks,
Taylor

[1]: https://lore.kernel.org/git/884ca9770d1fb1e84962b1f700b1ce4adce6321c.1732142889.git.me@ttaylorr.com/
