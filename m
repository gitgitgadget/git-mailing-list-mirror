Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DBC38E132
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 21:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774561482; cv=none; b=Iumor7vU7Y/S8X78e4gP0F+vKfbSQXJWt+csCwGNGr+6WPobuypvn2F36WbBhmKkS5y5Ljj4B0ecSbzKJcXZG8U5SEOvmOFbRmtGzsPXQJZAwglaFzrFYPfZcg1X4S3zCkJQq/5dVDA1hscfqIoJx56va7BnwYvaemD2585tajY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774561482; c=relaxed/simple;
	bh=9v7WNRi7UsTyw9dPI3tc9mbkAxwfu0XHp+HbmLG8Ha8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hxt3eAi0xT2qIv23uzaXfjyyHgRupV1jgGM/ULf7ltnGzJClieAxEtvNyJ9wWzBS8DyTcmEnkSjVvGf7qr+iARIazrirkfxpPF8TVebpG1o6KekWIXQFowHXfTR65Wu9AjHQJNN037ZvA+VVFEDj0muymIGgHTC4cy5F59mw3+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=bgbf4blf; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="bgbf4blf"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79a40fb9890so15895567b3.1
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 14:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774561480; x=1775166280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9v7WNRi7UsTyw9dPI3tc9mbkAxwfu0XHp+HbmLG8Ha8=;
        b=bgbf4blfULZy4nlzbY52fY+x6D1WlOnMtqEOZgs2c2GEs7MP9n3+gURNKHbndh0pvU
         X3nA4cGLXRpq/tbWD4KZWnLdEQ3v6iDQoeXfUH1UgtNB+K+M5CIq1HmzjRvEiUjnzjin
         GqqrG3nXrdM+/AaInu97zytl0WHyk//ZlHMdFpH7Ng100AKPFvEGC+g74rpaOJuL5qxE
         tZac+17cO9zt49pjt6XgFHeVE+nxaMilL8RP5a1eSMEDO7S51BMltkUxjnsKULYxuiaA
         2GAT25ei5GOmJbT2iZti3Kp1JWhK61QnQimdCk3xkE+n/SY4CPSmiHCOZsP2y3yvOM6f
         yGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774561480; x=1775166280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9v7WNRi7UsTyw9dPI3tc9mbkAxwfu0XHp+HbmLG8Ha8=;
        b=kW4Cxefg5oNC4wJNY+5b27w65FCYSfnH7wV2Ju82YJ02gTpjuSaaM2Xn5pdiZIxUEm
         gdkQr483/T1wg4i75OrTQ+2Rx6qEdMLtEB/J/sLXx490X9i7/DqaOIb1fsJv2ys7tJVU
         cUX4Jid4F3Adm9/tM77V9lNyrKZt63VKYRFko9pnjHcjJ8YBd2e6V51E4thxuLIka4/9
         I7cElPRyCPQhKn+em9bjIER93FelXpZQZa6ortVruAvkvwHj2xa6QqXIDJymTYoFFQ5g
         xd7eL7509PxsvMQ8kV8VrdFs5LhCTAJ2ZVc1ttOsMB/rGRyRmziOqBL47p0ewXDDl+dL
         rpKg==
X-Gm-Message-State: AOJu0YwsT6QFrOnhHpIYhrFgiH2qu7Rnb7u3XDhHWJr7O0RyB2CRImpU
	iVqX/Omt+WjDJvORc/4aq/DtEeRT34ISek52ZZBEacp+0ZwRm0WQWgQrMkSHDh29Wn0=
X-Gm-Gg: ATEYQzwQ4yrHcAvJCN6Ech/meb+HF2xrw9RfzjySLDTUO3iekBhexWTfKuNkj2qdrjd
	1kvqeCvyqiWp9HhK2GxeBSp8tbGsHkdbqqrjjTjYFobyGcpt9LEb4VHDH4hb/B1reX61izVfAxT
	zCGtkOV3+lB6cKIhD169fR1lRjjeQd+eutebTTMWMP90KvaniMjelY2avh9SmT9r6J71EKnT2OR
	dXOMo413T85w9j7SUoKNHqkd0qr2i9tNGnXDlujq+0K4CXNiC47GEzDllyeArLss0DdFmxGGbTT
	W5ZAEOMDlk5fEp/VkJrrHlUnMjA8uaVXQd8Pzv6KqcFYoD9bgwhcHg1+8RiVTvNrI4+Jhpx5Z39
	w1YWze54JM++Empfm8bca7Mn1hhwApD+nmllR6AiFI/iXTAwVYbQEdagi311dfdnbVfo7ELjPvS
	3n4O9wTSp/5vguNT6s9BoagKj//F1Q9YbIpgp/+qN0S0EDbMDNkWqLUbQ3slaeHDPrjjWk/ozFi
	begb3BqWLJWDZIaSQrTShV9F4Y0gg==
X-Received: by 2002:a05:690c:86:b0:798:c349:7207 with SMTP id 00721157ae682-79acf331559mr100513897b3.4.1774561480303;
        Thu, 26 Mar 2026 14:44:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79b1e4123b4sm19159667b3.43.2026.03.26.14.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 14:44:40 -0700 (PDT)
Date: Thu, 26 Mar 2026 17:44:39 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 5/5] repack: mark non-MIDX packs above the split as
 excluded-open
Message-ID: <acWoxy1NoDjI+J4Z@nand.local>
References: <cover.1773959041.git.me@ttaylorr.com>
 <cover.1774482700.git.me@ttaylorr.com>
 <23cb9f33dbac735feeb4fa9b5e7676ab871e2c94.1774482701.git.me@ttaylorr.com>
 <2b1a7624-d9cc-48b1-a224-646cafabb359@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2b1a7624-d9cc-48b1-a224-646cafabb359@gmail.com>

On Thu, Mar 26, 2026 at 04:49:40PM -0400, Derrick Stolee wrote:
> I appreciate the brevity of this behavior change after you
> established the new building blocks that make such a
> concise change possible.

;-).

Thanks,
Taylor
