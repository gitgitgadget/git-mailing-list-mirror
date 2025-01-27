Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAC01FBEB6
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 11:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737975661; cv=none; b=gGgR8PioIc1jcvEhFTh7eJ+XvoYeNWgdIPVfH33c0R++RsC6UA2mXReCJjAugMUyeFpchY9LX8ETdler4Vj9cGanb4mX0a2nXGONg9sjKirmtIaNgE0kRCJNDJEHdvdHJZ0iRXqUDF0ow6BXXMP6THhWMLBPUxNxMDJGOm7WHt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737975661; c=relaxed/simple;
	bh=LktKJToAbYIdi5wcj04X3uy8m3T2xH0oM2I20DqCcos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=PDUpbDqfvdNuX4QKRXiuJmABcu6CCt9Bd/pKN/naBxzZiiKtqEiuXfORvu9YE5hckl9K9o4PPnWwyFaw7IFqBMl5MRB7/iC30HfZx2gTIT+hngHdYpMKsuYvcGr4JQ5r2u5WbubJziA/bMiY/WpxufJItJJ799R5PkuRlo/nCfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJi7uMp7; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJi7uMp7"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54298ec925bso5165200e87.3
        for <git@vger.kernel.org>; Mon, 27 Jan 2025 03:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737975657; x=1738580457; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LVLOEDhvWwwPwnm8IwY+XFduWXbRPZTOO+FVWC4vE9o=;
        b=EJi7uMp7pNhX+iWVkl5HfLARzBFO8LZqSwmkP86ZVUX1FOIRvvRh8wSSFst1WwD4qQ
         UO33FPHENjBUDbVzydz6F6dPWw+Z/SX+ukly8W6KKutkYKDBo3SlQMAZPFRAm9KJOBwJ
         AD75BNVpbXX+Kgj3EaCMVXP5WVfllYHg4FQxTp16G76q/JGpHFXDstsCB0yshPpkt+7s
         GykKVZr84l3wlcGlUD8wMSIxHNIS6ahsh6uofqtw5gqAI8zLowiV6teFKc1gaTgEbnRT
         WONHdPJFUdoL+Rfz53bKPaXIY7UyVRg2Mcxv26iWihKH8O83pjQZ++I1OaZ0qRZ5wlMl
         CekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737975657; x=1738580457;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LVLOEDhvWwwPwnm8IwY+XFduWXbRPZTOO+FVWC4vE9o=;
        b=XVyDl8UGYAP2bYhSqZvqXMCOzbyWJU/O/3dXxUpt/JIXuIWI7pMX7pvA2hjTxtvf9Y
         XVLriuuE7mLL4eobybUPxpIwQFVV4Uq4SCsEa1t8t3NxS+NKgnpioGh8guYJK6Dmea9N
         s8JOigkc4kePjQsBcamnOq5Yf+fLy228O7v6aOJHb8jYMPmhnQrShwM6ksdZ7jCutomZ
         xH16mZOeV5x3TU9dYIdDsaBjfotYGvkq+ZB4aiaXilq7esB9Cr9hJjLckeQ4n9hXbh7j
         j00GRrzaqQ2vuyvNikVRsMUjgnLowe4cCtSWTenB1RVLeja4Wi1pbOwbDJhnbiGdYmYN
         ndAA==
X-Gm-Message-State: AOJu0YxtU4kb0FY7UuQTRwUt+Pxpk5lExUOTFcVZKN9TsjB5+ANtmfbp
	B4+MWiz5NrwLU/a6TU7M7L4SSTNWH52JNi6KyNFQkpGAXz1OLB/IiZSANIgbAMCxlLoFUMNp+0j
	pjxUpiMVWbKDeE8esuJZUkHNsYM+9O+3vYj4=
X-Gm-Gg: ASbGnctVgt7NmnwiErLbM6TLdqGwB3gSfVnQHR4RZysh5aAyGlh7TkAvd0GWwuK7wAL
	J6MB+9DLpKq4Aj28l1cnNHWeQW90JmFskSVQ/iVEyyyhLr90UKDCj5Hk4Jts8HbZ8
X-Google-Smtp-Source: AGHT+IGK1P7mt5kgW+A6WvjvVGEiCWTduvlqGdgpPaZRxCb2KVwZBMo+ngWjFhdDVVpd0ukxsjV/j98BL/7TW1tmcW8=
X-Received: by 2002:a05:6512:33cf:b0:542:2a0b:cdd4 with SMTP id
 2adb3069b0e04-5439c287e81mr14117529e87.47.1737975657104; Mon, 27 Jan 2025
 03:00:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127103644.36627-1-meetsoni3017@gmail.com>
In-Reply-To: <20250127103644.36627-1-meetsoni3017@gmail.com>
From: Meet Soni <meetsoni3017@gmail.com>
Date: Mon, 27 Jan 2025 16:30:45 +0530
X-Gm-Features: AWEUYZl619FV9vTzZ2e0kbe1fYe-hE5MGBTcEBGF-dhgWkaG-dSU3WudhPqNqJI
Message-ID: <CAPhwyn1GHkZK-ySwFqEzFMxQjmzsEtPMBKGLv311pixUeR5W=g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] refspec: centralize refspec-related logic
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Jan 2025 at 16:06, Meet Soni <meetsoni3017@gmail.com> wrote:
>
> Thank you for reviewing :)
>
> I've added documentation comments for various function signatures to
> better understand what they do.
>
> Meet Soni (3):
>   refspec: relocate omit_name_by_refspec and related functions
>   refspec: relocate query related functions
>   refspec: relocate apply_refspecs and related funtions
>
>  refspec.c | 203 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  refspec.h |  41 +++++++++++
>  remote.c  | 201 -----------------------------------------------------
>  remote.h  |  15 ----
>  4 files changed, 244 insertions(+), 216 deletions(-)
>
> Range-diff against v1:
> 1:  97c98f5a38 ! 1:  8e393ea1c2 refspec: relocate omit_name_by_refspec and related functions
>     @@ refspec.h: struct strvec;
>      + * name matches at least one negative refspec, and 0 otherwise.
>      + */
>      +int omit_name_by_refspec(const char *name, struct refspec *rs);
>     ++
>     ++/*
>     ++ * Checks whether a name matches a pattern and optionally generates a result.
>     ++ * Returns 1 if the name matches the pattern, 0 otherwise.
>     ++ */
>      +int match_name_with_pattern(const char *key, const char *name,
>      +                             const char *value, char **result);
>      +
> 2:  4f0080aad6 ! 2:  ef6edbc15b refspec: relocate query related functions
>     @@ refspec.c: int omit_name_by_refspec(const char *name, struct refspec *rs)
>      +}
>
>       ## refspec.h ##
>     -@@
>     - #ifndef REFSPEC_H
>     - #define REFSPEC_H
>     +@@ refspec.h: struct refspec_item {
>     +   char *raw;
>     + };
>
>     -+#include "string-list.h"
>     ++struct string_list;
>      +
>     - #define TAG_REFSPEC "refs/tags/*:refs/tags/*"
>     + #define REFSPEC_FETCH 1
>     + #define REFSPEC_PUSH 0
>
>     - /**
>      @@ refspec.h: int omit_name_by_refspec(const char *name, struct refspec *rs);
>       int match_name_with_pattern(const char *key, const char *name,
>                                    const char *value, char **result);
>
>     ++/*
>     ++ * Queries a refspec for a match and updates the query item.
>     ++ * Returns 0 on success, -1 if no match is found or negative refspec matches.
>     ++ */
>      +int query_refspecs(struct refspec *rs, struct refspec_item *query);
>     ++
>     ++/*
>     ++ * Queries a refspec for all matches and appends results to the provided string
>     ++ * list.
>     ++ */
>      +void query_refspecs_multiple(struct refspec *rs,
>      +                              struct refspec_item *query,
>      +                              struct string_list *results);
> 3:  f89328fa66 ! 3:  ea72647439 refspec: relocate apply_refspecs and related funtions
>     @@ refspec.h: void query_refspecs_multiple(struct refspec *rs,
>      + */
>      +struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs);
>      +
>     ++/*
>     ++ * Applies refspecs to a name and returns the corresponding destination.
>     ++ * Returns the destination string if a match is found, NULL otherwise.
>     ++ */
>      +char *apply_refspecs(struct refspec *rs, const char *name);
>      +
>       #endif /* REFSPEC_H */
> --
> 2.34.1
>
Hi everyone,
I realized I forgot to include the In-Reply-To header in my v2 submission,
which would have linked this series to v1. My apologies for the oversight!

For reference, the v1 cover letter can be found here [1]
[1]: https://lore.kernel.org/git/20250122075154.5697-1-meetsoni3017@gmail.com/

Please consider this email as a manual link between the v1 and v2 series.
Thank you for your understanding.

Best regards,
Meet
