Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26003217641
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 12:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736424518; cv=none; b=EbiMRPB1t/FdWNcnVW/+/8XBMO/WNTmyLpGxZAAh7bqPrI6b3Z/pblQdClFEDp/XSRXHEfEfU9WDSckthKWWr9KcYMDCgPNItK9DaSNI+jTIHWXCYwTZ8ASyrLq/rZfw0gh19MeGTMqWC5ybAEY+cymOL3hfqNfdMi9QLFBkVAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736424518; c=relaxed/simple;
	bh=ibcXROZokqVnmijRke9UKOZMllhYV6yFZvPop03iKH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sH/adbWdO9BEwrDV03NavNYKb6tUWrG2zDlei9DsAR4m+4uhXCCVe49BMkDDzAdzXUShYTz2L3tjdxl4dq7IO5MZf8m4Qh1IwiTib+qOaRxjytdLVhZqG14zb+RyCC7h+VplB/nYpILowkmeyUkdHIcE9zXmrB7WAUjS4d0c30g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=koordinates.com; spf=pass smtp.mailfrom=koordinates.com; dkim=pass (2048-bit key) header.d=koordinates.com header.i=@koordinates.com header.b=IFe3acUk; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=koordinates.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=koordinates.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=koordinates.com header.i=@koordinates.com header.b="IFe3acUk"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ee67e9287fso1397144a91.0
        for <git@vger.kernel.org>; Thu, 09 Jan 2025 04:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=koordinates.com; s=google; t=1736424516; x=1737029316; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mdEaagTd/GL+v/4iR0pwxIJqNahimzGsEJk+/sS5HtI=;
        b=IFe3acUkjClz8YBLrn6lihIBpC+BQrRUVJ5qcfQ2djSk0RWOYIwT1RZOjk8K3wH+gO
         UY1iOZJ2Sc3Z4z3xvExkzvsEJwvMlsuT5btkUur05sADbbFixYTUEAp7k3Km3gbkHBdW
         8vw5RPaz34m8ZJHckxQbWNzAjAKQFbfFOr92ma5NT2VJaTNcPj0+H12J8wtd9DVn/2n7
         LC96CAbt5E1GeDogPQFeUSQjtDwFW9ON/YGI5YBBtDyCFEHg+cuIx/6qQYLoVb7u5wfu
         tIOvqoSxKjj3rn0krpzsg0nCvjoe5L6iUUSohT3geDzYhg56fyLiWC22Axeljyc4Nim2
         7BsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736424516; x=1737029316;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mdEaagTd/GL+v/4iR0pwxIJqNahimzGsEJk+/sS5HtI=;
        b=vK4JjOwlg0SP0skKxRmBhsBm2W+rAJgcksFY2JojV7MOQ13/1EuVAEoko73fJlsFPL
         WA2RlZld8UIzGQFox3iuM3NnzJYjk70k1VN1XYgRWU1hS3z1G7b3LlTlPgY+6ZSivVLK
         1oXGRVIMx98odz8bfk9+zGk5QgYN9TFmQBveGzBHHuiEMFyscLGDw37P5ox5qrDDmfo5
         8BuswBooU5zEqn4QYLuzqHgIeITPrw268p5NYbVDcycJCkg9n/bWdW8hwVsfU3No1S+8
         B8F8NZndBHEelUe1KKCOOb6naeMBUdeDB0xMipL+kGz1AE++9pd3vdjtuC6AvzYZ/O2L
         qOOA==
X-Forwarded-Encrypted: i=1; AJvYcCUt5CY+LKawMf1yB7rzcRFPhnU6zTXz979SUB5WQODQMMzHDJo9SMpBF/AdBmIf+OkVzAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC6R9v3DVIMqUIn+uGut5aBfHUb/B923938YQ2JaSkijwq1Y1f
	qRV5J09JzbTBa/rP51ZovDnMoGqCp/bIMnhQRyaFF0QZBmk10Q8hpxno7Xoy1vQD1mhWp5IsNqK
	KpKYQCcFu6xhnJQlM90MzB3a1rVTPO+72XSkteQ==
X-Gm-Gg: ASbGncthpNfWpT0nEqf0n62KeyxNIuF02bJNRHoMVMGo8UQsqaNNGJ2YtKgnkPqCBMH
	q7RRXPpY6n6IUFdhfOzgtMymG+/s9LjmunL9mQSZGppe6/6e+hJv8NOxPv3uJrolPr70=
X-Google-Smtp-Source: AGHT+IFUc4ElKcKmeng38Jlo2+YaBMKfY2h6PjRnCH9Pa2HOXe9PbvAVRREJJQKKAhDMBjZgfjVQ7wZcGWDKjvw/ToY=
X-Received: by 2002:a17:90b:37c5:b0:2ea:3f34:f18d with SMTP id
 98e67ed59e1d1-2f548eae685mr10246046a91.10.1736424516513; Thu, 09 Jan 2025
 04:08:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106-pks-remote-branches-deprecation-v2-0-2ce87c053536@pks.im>
 <20250106-pks-remote-branches-deprecation-v2-5-2ce87c053536@pks.im>
 <CAP8UFD0Lzazxyq9nnT-vwN=MijKAsYySFC2dvDEj33cS7VB0kA@mail.gmail.com>
 <xmqq34hw0whh.fsf@gitster.g> <Z30hnx43mEwjWqzA@pks.im> <xmqq8qrmvap5.fsf@gitster.g>
 <xmqq4j2avaam.fsf@gitster.g> <006701db6124$f16f9420$d44ebc60$@nexbridge.com> <Z34c3rj0E6hP_kHN@pks.im>
In-Reply-To: <Z34c3rj0E6hP_kHN@pks.im>
From: Robert Coup <robert.coup@koordinates.com>
Date: Thu, 9 Jan 2025 12:08:20 +0000
X-Gm-Features: AbW1kvYKVmng7zsQ4KtD4POhuaIkGNfiQnAvbwBL2l_63sJyoKOPgV9bHIhvQ0I
Message-ID: <CAFLLRpKk2qq3nZSz1XWotrt5W=6b6HfHevFQJ_UfMYbhOqRi1Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] remote: announce removal of "branches/" and "remotes/"
To: Patrick Steinhardt <ps@pks.im>
Cc: rsbecker@nexbridge.com, Junio C Hamano <gitster@pobox.com>, 
	Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org, 
	"D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Patrick,

On Wed, 8 Jan 2025 at 06:36, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Tue, Jan 07, 2025 at 11:55:16AM -0500, rsbecker@nexbridge.com wrote:
>
> > I like this but wonder whether there might be some way to inhibit the
> > warnings one a user gets it and decides they will act but do not want
> > to see the warnings any longer? I have had requests like this on other
> > products. Just a thought.
>
> I guess the best idea I have here is to use an environment variable,
> e.g. "GIT_ALLOW_DEPRECATED_REMOTES=true", along with a hint for how to
> enable it.

Since there will hopefully be several of these deprecated behaviours
as 3.0 comes closer, rather than adding a tonne of variables should it
be a consistent method of silencing warnings? eg:
"GIT_IGNORE_DEPRECATION_WARNINGS=remotes:splines:llamas".  And/or
achieving it via config settings.

Rob :)
