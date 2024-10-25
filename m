Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CD7217F20
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 21:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729891651; cv=none; b=EvCtZQusKhKV/tLkQUzaXIgLKlFyXmQaD/L9+gRLFHYsdrK97y2KDCAC9Pxl+N4nE7aiwjfSec8hn77kBU+FMqcI99mRhgO/gNkwblq/WUjzQlLRIqcHWRylYPvDFp7n9aTQe17T2O9v6QCA5oaHb0nuwEoQb+BODvpy190EPKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729891651; c=relaxed/simple;
	bh=hoJ3i4JStCGcz+wm6gqn9eCPELFHYWFDjG/J9WyT8/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByN7vFkH/DrdvMYbZiCw9tYvETPSgBVTG/mF035ZgH9D5mrr9k6b4UzCC3jZVB3C2dtelPxQs8sIk+HFftAa+ZaE0YHheeSOIe/BKBTppYfLCE9rBQlzjusp7wcwRVqmuCv5wCTHtZ4HVEn47E05od6IgQKQH2gaVQzAa7FmSgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=tfz4pOy8; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="tfz4pOy8"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e2e41bd08bso32332127b3.2
        for <git@vger.kernel.org>; Fri, 25 Oct 2024 14:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729891649; x=1730496449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dWBdMezHZG4c7I8MwEohFcVp+HOSjZsD0YxvWd5qeVE=;
        b=tfz4pOy8DhoT0OBSxm0DS8DlDQvx+kVM0tMVBOl0saUJj3GLtXaJqJPQjF5N5XqaMs
         9MmQs+Dpnq5fK6xhE5mYIcrG1ov83gplkXMgFpb2lXnDmoGNHAgOQio5IGoE8RpxHaCD
         8SyQ9anCwhsalsh6rTDI/a0/dPjoZne5PwKaohHt/8RWdxBZZA36zIEZ5rHt8WjKin+i
         L7JHk9C33bXE5c6eHoSmaBXv254UVxcNOmWynWIE5fzarU5mjaRmAue0HLUbeu68lCGF
         XAcftvPnLCZm1GLRzSN+cD5cyMSS2bcswDkhv9NVeGouGnu/cXDS7JLyvLraE+8ccLs9
         v4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729891649; x=1730496449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWBdMezHZG4c7I8MwEohFcVp+HOSjZsD0YxvWd5qeVE=;
        b=dm1fxo7t9kRFwtXv8JLAhRcT/KWumHR3GJQ451hVAeMEvBUEYVDeygpU602bvRYXTp
         9gy4yj4AMQ+H4u5JH5+lMWXOx++d/hxy1ekDkQ8k/7VefnMqXLad5gfZBETMAyBY5GXN
         7eiKlM8hks7nzN4SnG2aw+O5xN8ryHwJaNhVxp0iUNyUTmQnJC6jST7/Ld8PoK8KgP4w
         QCuBb+zcy9cbSp7JM3cNzlKoTSSVbzHpM5u0zOAhcWmb3aN8fvggxRoeYyNq4pW7I7IY
         pGxd6DNBzY7rsk638YFe1ZcMFbkTCkhW/lzgqlAT2I5i1MG6hOV4Hz9CCgsf/MvxBxYF
         qtUA==
X-Forwarded-Encrypted: i=1; AJvYcCX9jb4wRhAT9SoesX5ITz3KiEq5NIVYESrvkg1bIveJTwTn4bcA+ctqHXTLuaTEbWudQlE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhdn3HXw1oxvXfISmRHT8t5MX7WAqb/zua8j8zbQwk47F9Ase4
	mupr2RPZmpmpU39OtZ5cIe7IFkhnkAUq4OdT1TADTwcXcRgs0BnFB8zM10S34yQ=
X-Google-Smtp-Source: AGHT+IFIDiOiseMM3eteQ5Fef7DfglQ5oQ3BxXW+QmW/GtjfBvNw/viQ2naZXOHtoLx+jCnOb4Cm8w==
X-Received: by 2002:a05:690c:4b82:b0:6e3:1903:5608 with SMTP id 00721157ae682-6e9d8a6aa4amr13858697b3.21.1729891648822;
        Fri, 25 Oct 2024 14:27:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6c97b27sm4436657b3.115.2024.10.25.14.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 14:27:28 -0700 (PDT)
Date: Fri, 25 Oct 2024 17:27:27 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: fox <fox.gbr@townlong-yak.com>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 04/11] packfile: drop has_pack_index()
Message-ID: <ZxwNP1hKyi4eGHNO@nand.local>
References: <20241025064148.GA2110169@coredump.intra.peff.net>
 <20241025070009.GD2110355@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025070009.GD2110355@coredump.intra.peff.net>

On Fri, Oct 25, 2024 at 03:00:09AM -0400, Jeff King wrote:
> ---
>  http.c     | 15 ++++++++-------
>  packfile.c |  8 --------
>  packfile.h |  2 --
>  3 files changed, 8 insertions(+), 17 deletions(-)

All makes sense. Good, let's keep reading...

Thanks,
Taylor
