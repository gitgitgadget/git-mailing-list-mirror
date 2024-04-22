Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAAB208A5
	for <git@vger.kernel.org>; Mon, 22 Apr 2024 22:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713823462; cv=none; b=ROTAkY3z30fXSjgwxOigdR2NSJQuqKwvxGei/41LiUHocNeK4zG13oa4MbeVn9992uZadyr7NyIZSahRFuwNJ7WcO+y7by9qu3LSq1MjP7rXOC//zZe70bciO0gsjaa8LULcDX0oKR79IX97f4MBu7uF55epHwNoHAzCCv0PWSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713823462; c=relaxed/simple;
	bh=rqCOkMuH7yOzlTK7U4INoeDoJSwiz28ldDvADeaR4V8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=TP6P5LwP1LFkDrm1LRZ0Xi2js5vZNEVeOGPTlwRH6B0eeYl1SJQaccEQdc65XToeww8ijfDHFohKA5MSbgFKZWDStMEbYe/6skAtZFBQkcvXQAotATWAJFRdf+8SjmS9hXcoorShZEEveNtXWr+K4u6vOLxDCM32ckhBIaSFv0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgzUpPFs; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgzUpPFs"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41a77836fa6so8810775e9.2
        for <git@vger.kernel.org>; Mon, 22 Apr 2024 15:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713823458; x=1714428258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xokP1eb8whOSQ8Zd5txaOHtbsHL7e+25sDNJnMxQmao=;
        b=AgzUpPFsH2vbBULwz4Zcq8K4bNcIb07NjU9dNwTMg7lFcjjpiycDt4IPZpGPw+ImLs
         GDXwS4MZ9j0ggmjBCnz0o9ElUDhcRZmnkmrehBR6C39hEQe8vL7N2G3jsopvqP9dtW3+
         ckDGHrNVJFy9VsFaHBbZ5Tb4VmYc+pOHwUW0qe7zb4zbnC3c89YJ2fFLGgRyD8hU6KHW
         xGeP9pqleLQSa7Jk1hjqz1eu53cSzljvt5zWCeVuSPCusBSzIGEyDxVyyXrT/DO2zAo3
         1skWAaMw0Ywahd6jKRCzmBmmgAW6gJYehbeVl6IDdJwKdUvO2ZxMjR4v6eaPVdURRnoz
         B0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713823458; x=1714428258;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xokP1eb8whOSQ8Zd5txaOHtbsHL7e+25sDNJnMxQmao=;
        b=Wh2azORmJ2OZgC5COuMAkJK+Ifoezu6dsWi6+NpT6ukP2wOFmjXVKOV7G1Z6EwoGPU
         VmHQgRuaTbLRa5rLNSAKpChXx8uHzJdKplALMxn/xSN8vdWLS6mVNbWysAFCRN6nQqXM
         Z98KsYX5plnBiKXLkTUj5b4C3X2wRJAOtl7CsPlRO742vNYvdoom70SWI6UFu3QJh2FW
         3TNpj2CRJxLfclHw5aJENNXvxWsd0FuVeV/gho2PR5LFXGYSyfpj/UCXolJzng1br35Z
         UyD+VvVlzN3vFMMwKVBa+QznQG3OucC0jCF1tRFCeb6b1dnXEgpv5Dj4uXogR/Gd2jLO
         zgdA==
X-Forwarded-Encrypted: i=1; AJvYcCUf1ubXAiH86FuzOC+wtTG2CCsQQaZmjJmsOWU31kebrVu/doVlVlxd31CEQaOTD5iSDqbC3LXuNmFthKD8HZs1veaQ
X-Gm-Message-State: AOJu0Yx4I//FPVoXxs1ovYI8wUG3Nwh5YT60xPkXjAKhft8KOhWzsJBF
	2jDwSzUT0qdgHPI1FBvvx2Rs/T/DAzazphzmBt8+c/6QYR9yqSVqQwLkYw==
X-Google-Smtp-Source: AGHT+IGrRGhHWP3h+d+vE1tbA8zgQ4H6zUoVSRPfLxLeRz/mOEa6IT4bW7xQFvMSPXKAuSUoWQ8nbg==
X-Received: by 2002:a05:600c:3151:b0:41a:993e:97a2 with SMTP id h17-20020a05600c315100b0041a993e97a2mr1204313wmo.19.1713823458405;
        Mon, 22 Apr 2024 15:04:18 -0700 (PDT)
Received: from gmail.com (247.red-88-14-44.dynamicip.rima-tde.net. [88.14.44.247])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b00418a6d62ad0sm21761439wmq.34.2024.04.22.15.04.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 15:04:18 -0700 (PDT)
Message-ID: <78f38e0f-7456-42d7-b0d1-887944bb01c9@gmail.com>
Date: Tue, 23 Apr 2024 00:04:16 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] apply: plug a leak in apply_data
To: phillip.wood@dunelm.org.uk
References: <b7b2d0d2-245e-440f-a7cc-fa0df1ce73ad@gmail.com>
 <8e6ab088-2026-43e7-a869-b1c7185ee765@gmail.com>
 <74a6465c-01b6-4a65-8491-751244d37c82@gmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
In-Reply-To: <74a6465c-01b6-4a65-8491-751244d37c82@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Apr 22, 2024 at 04:41:18PM +0100, Phillip Wood wrote:

> On 21/04/2024 11:28, Rubén Justo wrote:
> > Plug a leak we have since cfb6f9acc3 (apply: accept -3/--3way command
> > line option, 2012-05-08).
> 
> Looking at that commit I see
> 
> -        if (apply_fragments(&image, patch) < 0)
> -                return -1; /* note with --reject this succeeds. */
> +        if (apply_fragments(&image, patch) < 0) {
> +                /* Note: with --reject, apply_fragments() returns 0 */
> +                if (!threeway || try_threeway(&image, patch, st, ce) < 0)
> +                        return -1;
> +        }
> 
> So the leak existed before that commit. Indeed it looks
> like the leak predates the introduction of struct image in b94f2eda99
> (builtin-apply.c: make it more line oriented, 2008-01-26) and when
> the patch does not apply we have been leaking the buffer passed to
> apply_fragments() since the beginning of the builtin apply added in
> ac6245e31a3 (Builtin git-apply., 2006-05-23)

You are very right.

I saw that commit.  I reviewed again my notes and I recorded the hash of
the previous hop;  the one that my message, incorrectly, refers to.
I'll reroll to fix it.

Thank you very much for your attention.
