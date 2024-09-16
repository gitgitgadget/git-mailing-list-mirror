Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F7B15E5C8
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 20:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726517710; cv=none; b=W/iTWl7gv1hSk3VC1K6p7QB0N1gOarctT1X3V/YkP4IBn+DMzDllvVOheBkDKsvouIkc3LN+7KmdaX3w4HVijMgTUyVg+dwWnPRhfBDLL2ddu9ntn+Q10vKY+GdTpZ69mW9lp82KWUXrXEbEvEUK+kg5NH637PZA1bh+CStM858=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726517710; c=relaxed/simple;
	bh=F2wS0X0ZcDZAqFolbU34ytMF6BaMtru9lVa1c+9QZ50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=klAU2juHRR9/BKsVJxONks/fGFp0qeQa1slp2tmjMjtNV0xWzhEO6BVhqEe1Ij/XEAH9YSPTlLoJwB/SHxVBWbiAg3v1gWTqL4ASb0utrhp8nkpRIR0YEuJ4jD6utkU8SJqWso2q6cyKJbhPuW03A1AqP+7YNSUd8/hZa1H8vuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyhBRokT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyhBRokT"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cb60aff1eso48673755e9.0
        for <git@vger.kernel.org>; Mon, 16 Sep 2024 13:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726517707; x=1727122507; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nL0wsvqH4vRGBOh+KU+tqwXRBJFiwJLt/6EDUkibUr4=;
        b=fyhBRokT5CqW0wI1XEP86/c+daJPH5RnlmFUrhCOtORjAH9xye4ehte3ttVRNCa5ID
         u/2CvUaWhwfKPMyXPKNvOi5BGGeI3yG0y/tiFKbah2djgr+fpBJQ29d1GSdwYJItj3dp
         HkmPfqUrddzWkWkXqUiOP8o2JUTyXutM/o71iR9VhrQeqrJ3i7vCfHIY/twFDNI3zH/8
         T3iJlqIIoTAgx8+fRNYrBC/7zcyyOlPCiyMvMenTC8EIqMxxvY7eL6CDrLY6x7K4tW0c
         /sicLIEVXUB/DJRabbPnukWvK4qEuz6oB47ll6r33hyGAru/MYEkMlXVQCQNKDigogCp
         9Hww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726517707; x=1727122507;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nL0wsvqH4vRGBOh+KU+tqwXRBJFiwJLt/6EDUkibUr4=;
        b=iOOjMbE67OnPTqTQsBndCgGr7RjK/uNqdMquWlUVjb1AXSOO1uXj7YhoWqENItnriA
         dgdFg8HsUSdUkTBErkaNuVHU8zdMxJqootbao8CMvxMPmEfFHG8Kl9gBTwUTAZKTXt+j
         OvDf4C2iTUc6y4H1K5yeEJM9wAEgpGoTWZn3ALSIpzktlDbycj6AGzxOij/+UmHxOFdA
         qdlXuxJRSc9XOcW+iE3RpEuy7wg0FIn6XYSXkzTg3NUfc83v7EljQwK/4y98n6wZJ4P4
         ok5unwRK4Hkp9J5++FtNMl78Ydin/0da/mz6jUOqWV9JuHHJBtca9OUkX8zZBAo4ZApL
         hkGg==
X-Gm-Message-State: AOJu0YyVBTl+Mb1WraYoYvEYXSALh5Fl+K5zD7WTG/nQlbbLya7n5ENO
	mwSqjpYOdL9sKwFwnwQsO/RJvUvgy8LO/TlqeXpW/zuBa6D0Y08G3zVZeUYS/p/jOhEUt6Jm/8Y
	6EHulx+NhCBrikWL5jYic8tIFubI=
X-Google-Smtp-Source: AGHT+IFnBVq5MVTZhFUJjZXv8/Kep96T6sfPxZXB/yfBuYrZN7psETerjHLfsB1Y4P4K4vO/UO0s3L7OgMffPJL1Mvo=
X-Received: by 2002:a5d:4811:0:b0:374:c6ad:a7c6 with SMTP id
 ffacd0b85a97d-378c2d065c0mr8141795f8f.20.1726517706337; Mon, 16 Sep 2024
 13:15:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915111119.GA2017770@coredump.intra.peff.net> <20240915112024.GB2017851@coredump.intra.peff.net>
In-Reply-To: <20240915112024.GB2017851@coredump.intra.peff.net>
From: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date: Mon, 16 Sep 2024 22:14:55 +0200
Message-ID: <CAN0heSpk0f1-8tbguqAyTOQbuWrHYpkE-W6H29CJ-QBzqULCrg@mail.gmail.com>
Subject: Re: [PATCH 2/2] git-jump: ignore deleted files in diff mode
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 15 Sept 2024 at 13:20, Jeff King <peff@peff.net> wrote:
>
> If you do something like this:
>
>   rm file_a
>   echo change >file_b
>   git jump diff
>
> then we'll generate two quickfix entries for the diff, one for each
> file. But the one for the deleted file is rather pointless. There's no
> content to show since the file is gone, and in fact we open the editor
> with the path /dev/null!

Ah, yes, I've seen this. I just went "I can see why this would happen"
and moved on to the next hunk. Thanks for actually patching.

> Let's skip such entries entirely. There's nothing useful to show, since
> the point is that the file has been deleted.

Agreed. Anybody who relies on `git jump diff` to produce an empty
quickfix list (no entries to go through) if *and only if* the diff is
empty is already in for a surprise due to binary files. Skipping
/dev/null makes perfect sense.

>         perl -ne '
> -       if (m{^\+\+\+ (.*)}) { $file = $1; next }
> +       if (m{^\+\+\+ (.*)}) { $file = $1 eq "/dev/null" ? undef : $1; next }
>         defined($file) or next;

This looks very reasonable. From my testing, this patch fixes the issue.

Martin
