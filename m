Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3872C1514EE
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 08:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738830687; cv=none; b=etaGmABETj/nY6dojNGXO6MnOPNw4PYHErE5K0vxKU2JFgMXTEEEzkd60C+oGAQqa8hS2FiMyrJ0r6IqCySGZEgEyjcKfYdlZs90MpIqBM3oJy8f4/9aSOk25YdjH8/xjctMKIM0qJlHBl2xXH2xYVNEEZSANZhKi9b+SAvS4Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738830687; c=relaxed/simple;
	bh=KV2AdffQOZAipp+iApOkBcTxufat2wZfdgfD50ix5sI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FKGBetyX+MExZ/4mJmc+u9SFfuK5LTL/B+fRUCOAUkZFUBGsRzOw4cbigal5sZg5mK4NzkU4JO81Tg5oDgx8d6BEwk5FQJfETz8FHhD/KvkJsa0hqV02ZNnpVbiPtN5rp3xBVG+MtshFj9tai6pNTXGn0HSmgWbCDjzpTlCDooc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5JFr5HD; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5JFr5HD"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-844ee166150so19543439f.2
        for <git@vger.kernel.org>; Thu, 06 Feb 2025 00:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738830685; x=1739435485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vao3POX5D/h+wxwuBixRDFIPGNVihd9avr3HbfPSz3I=;
        b=U5JFr5HDI8okYNytBrGpLTxUrxnHJjKIJeRgRymXJ6tgeMQAt+JbUpGbKi077rmlit
         EzQdPOy+fWHSK/oPaeIUCEGWtuO2lTgMcU5DygQIwkBjOlflTBuvfWQfd65iMWYzJw+U
         OpZgEpSEZPKYEL8w7FahgR+syBiNY/kqNRCuoByfTJL/AVf1ZnR62NDgZzWQ8dQlv36b
         BMf+noUlnqOl3nOWCQOapru+3oEUbjNkKwAAXZDjhNYd/+bSd5UISwzowucFJSnJjG0P
         5P2RmF6dvfkFrY0CC5NipRww3a6s7a5l6tb3pMKK2ERDRzo+RGUHVm4o4s5+AZs2RuV+
         /CsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738830685; x=1739435485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vao3POX5D/h+wxwuBixRDFIPGNVihd9avr3HbfPSz3I=;
        b=vh275TiJ3mETenFaDya/kWypnYJE57MVsRWJBSSsjj7m+xOPwRC2c+1NHQ9QsMiusO
         53/ZE7ErREUT6C0b0FqNmht4ajMvOxnY2XDxnas3JV/rOLwk7b1nUgj2JXt9I7+MKFUk
         UpygNYcyu1LJ1s89mcQlIW2xOPaWe/JPuWYeai9M9fAnL1u/8II6Cwq3wZRDi+oQMd3A
         2goZTIwa5xDQ1I1cN892ohfNBnjD9bFC6TBoiY4QKI6dAbk13+wOAYrJ6jg7hQD/Stda
         GCmvH2zFt8waUJmLSYC7iKY9HTYIrfC+xRVm4q0QIUrSd3oUjXV76WkUSes236StGHnZ
         RY5w==
X-Gm-Message-State: AOJu0YzaaSwagwhwytrZOzfghPE+XDz8YfAlHtFRqsSw6wS9aaMQXD3p
	qJoOnKZAib8Mt+WKXn6hu6SLOEJa6aPxbjl1U/2muhzhaqH7v4wSB1vzbXwMB5K6XOjrHUUSRj5
	kPJwQoo7f1sq5NjkXwy97fXNoink=
X-Gm-Gg: ASbGncvFw0hUi7xIuSlT1HHe1SZVHSClZ0DlzTTEccJKYXwPctvDLiDiogoRt7gZ3Il
	AeWX/RUoZi88wHXKFu67Vbe3tYtBw3LnX7a1JvCMnsAQwC5lxBRiEe4THjGxdqonkJcXjuB8Z3l
	U9XuMDxGGH9pE=
X-Google-Smtp-Source: AGHT+IHji372lNd60Te6y/h08pA4iHfquIwzBvwMkXvMtXNad+Wjs1GO9Uyb5RqnymRE9TG0OccBOS/vsGt+RhjeWkY=
X-Received: by 2002:a05:6602:3892:b0:84f:2929:5ec0 with SMTP id
 ca18e2360f4ac-854ea44048emr700585239f.4.1738830685335; Thu, 06 Feb 2025
 00:31:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206042010.865947-1-davvid@gmail.com> <20250206042010.865947-3-davvid@gmail.com>
In-Reply-To: <20250206042010.865947-3-davvid@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 6 Feb 2025 00:31:14 -0800
X-Gm-Features: AWEUYZnH5JaK6c1VUoFRKToDDcC8yAcJBzEsVvqbUDFrLd9rZ2XNsa7HaAUH8Aw
Message-ID: <CABPp-BGi51EQvPOgaz8p0RjAJ0zDDeTpMDp__puz_wQH5wowXw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] difftool: eliminate use of USE_THE_REPOSITORY_VARIABLE
To: David Aguilar <davvid@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Patrick Steinhardt <ps@pks.im>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 8:20=E2=80=AFPM David Aguilar <davvid@gmail.com> wro=
te:
>
> Remove the USE_THE_REPOSITORY_VARIABLE #define now that all
> state is passed to each function from callers.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>  builtin/difftool.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/builtin/difftool.c b/builtin/difftool.c
> index 81d733dfdf..41cd00066c 100644
> --- a/builtin/difftool.c
> +++ b/builtin/difftool.c
> @@ -12,8 +12,6 @@
>   * Copyright (C) 2016 Johannes Schindelin
>   */
>
> -#define USE_THE_REPOSITORY_VARIABLE
> -
>  #include "builtin.h"
>
>  #include "abspath.h"
> --
> 2.48.1.461.g612e419e04


Nice; thanks for working on this.
