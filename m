Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B9C1E0DFC
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 20:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715801; cv=none; b=n5lxc+u5b5GU8B3io75KXEY2cbbxCHjZT10+WIV7DWTDHrFS5TyD4RLjnkOJXRiNt1f9dNoA6db4Oh143nZzFlp99IWgShOfwj/PjVzNmzGUKT9a2/Tzz2TKkKtLyVDXgqcaiAmSMWT2vKKFdRYH1fuyPJo/VXWKIeL2jaGR7f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715801; c=relaxed/simple;
	bh=z44ZJ6ZwWi570hkWZcZTiZo7MQhyqkvcKRHGPSXnWuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rL5BjAPEKiKwXQ9S9hheU3UmJrmtsOfTdT8Yx83J76vFCoxa29gAi0pGUPnipcpHZn6lwoYqKbhpGll5fGFtuBNJviqq8Y3OwxwOigC5pwXTwHZ6pPp8UNxYLB1iJI3QriJUa5ruhmLs3NyizT8SkZ1Q1oBXI4mEB9AOzjnj6po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=aziK934J; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="aziK934J"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e3b7b3e9acso1689427b3.1
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 13:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729715799; x=1730320599; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zfcHp/FLvJ3hLQpRXUKLf5tHJLFoW0KUDTXQjoUCxTc=;
        b=aziK934JFLwwFAF05fjPLMnVAxFqLWNAH4/CWFqnmSyBqy9izqK7VUyJ9ItmOrLcrq
         Yko06+2VO+F09m3saMShpqMF1e1u73bfn0WuT/rVu2lM8wJ/dgnLABlvglHQLtVQPdOY
         qv1BPjjvr7bH8qZWHpFIquBeWYJHWYs8tXqgCKfTWsP8y5265hYGKSxBAVTewJhFGXbI
         bkMAxsID9hAnCCgzrV8dR6KJRjInNC/ox0cTaZLlgocuLi0wbl3Q/3MWn0aBP4+6l6gy
         8QSE5dELuM0TsYSCHZk76YtSTaaMjMk6xEC6JTglxDks+NZP3r/suJnpkDQUSlV7b5hS
         CQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729715799; x=1730320599;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zfcHp/FLvJ3hLQpRXUKLf5tHJLFoW0KUDTXQjoUCxTc=;
        b=ekS0dX2Xxq8KyF/8JnNkSm2qvuYkHzEutUP0CsjIkimDUtAycWYK1rLx87dDsC4B2h
         NAngMa316qq8DY2ZWiXxcXaKeATHRMn2VlVxA3/Fxk5n4L+AaBSF58upl8uY5RwIWqzu
         DwS+YBEq0V/XxK9O6B7mfLRdxKp2woQoCoI4054oA7TMbsJZcfggaYC5wHrSlyMNbGEw
         rkSCD2587WhTdDKWQLOOXMg81suhJD9+VktlShjxjhilk+53f5IL0bZ4moTSJXqXKDs1
         Z6Z/XNMCjUXh+QLnPImZTQmFYivNMjoVn3GWV+J5K/oXO+rqrkfvR6BH+vfgfB0/khkf
         l23Q==
X-Gm-Message-State: AOJu0Yyagmk7HqoikvCNyZd3nfpRCOCupoEmGFyA5sFr9gVH18Gp8RhG
	FUBU0d9RD3kShabpssp4q68d68vO0jJU4TFV710w/yxWre+bZxL0Rcidzf7omAU=
X-Google-Smtp-Source: AGHT+IGiNxQDwrJU9WAkhPrn//Bk9yUhg48wOBLlHk7Aq/uHgTTEX+ph6FnER+KFjEYFngDpdbLDWQ==
X-Received: by 2002:a05:690c:7009:b0:6e7:e3b1:8cc7 with SMTP id 00721157ae682-6e7f0e73fe6mr45948327b3.22.1729715799200;
        Wed, 23 Oct 2024 13:36:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5ad5a33sm16752617b3.68.2024.10.23.13.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:36:38 -0700 (PDT)
Date: Wed, 23 Oct 2024 16:36:37 -0400
From: Taylor Blau <me@ttaylorr.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	gitster@pobox.com, dsimic@manjaro.org
Subject: Re: [PATCH v3] t7001: add failure test which triggers assertion
Message-ID: <ZxleVZ5Jh52Wj3e7@nand.local>
References: <29d71db280c972c91174bd0a501af66be72643af.1729462326.git.code@khaugsbakk.name>
 <c4ada0b787736ecd5aee986b1b8a4f90ccb84e21.1729631436.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4ada0b787736ecd5aee986b1b8a4f90ccb84e21.1729631436.git.code@khaugsbakk.name>

On Tue, Oct 22, 2024 at 11:14:33PM +0200, kristofferhaugsbakk@fastmail.com wrote:
> Notes (series):
>     v3:
>     • Rewrite commit message based on Junio’s reply
>     • Tweak test description: less volatile.  Also mention index state.
>     v1/v2:
>     • It’s been a good while.  Let’s just add this as a known breakage?

Thanks, this the new version looks good to me. Let's start merging this
one down.

Thanks,
Taylor
