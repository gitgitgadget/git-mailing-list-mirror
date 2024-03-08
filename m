Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F101455C24
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 11:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709896073; cv=none; b=VSoqCEctwhlfOY7CqbrD3FMi6wscQ1RvIcy8MsmcEeLjsuxzeZZ9tgl9vA4dj7bbwJsl5VFVnbZtOz8X2OaCHm74cjMgmxCOt8MC9HplLnTAEWFPNBaKLC2rcLKE925p0Qy9rYuBqnlVQVmj2rKpGo02UCEhNNPp09P5KHzqXpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709896073; c=relaxed/simple;
	bh=B1b0YO5KLj8OyxI6idum7dTNNZnRhR2Ri4IIFZB6LBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j076p8rPAiN4CyWDiA72tXBtIivcb3A+my05X1uE2dgZFOzIc/ivlQbRI/jmR6oQkGZrBh3kF0eSxOAILP0IwR5yZwh/ZoRLmzGYbs1s9xx+wvRkwLzmVZFTIp47l7YcTw1bKj4z0zb+DS4mV2hxqjHfHG3+eAEs9KYzUcp5amw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DV2rUp6t; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DV2rUp6t"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d41d1bedc9so6359001fa.3
        for <git@vger.kernel.org>; Fri, 08 Mar 2024 03:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709896070; x=1710500870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v2PS7WMpUxr6Gfm7GFwTVy+838NKDv9In7TPwaetXrE=;
        b=DV2rUp6tfZMnQOV2H+ERhE9tHyhTQROt5bl/tRzLbwrM091oNdVv9U/FzElTtRzoSX
         UCc6xRqa5cYmUdHhG875kQdAFaM5Oh06zKKpN8waMltgJ/3CFCGkoSXXFxLa6YyPzT7l
         MQI5ta88taYo0U6LNsy3rTCGv4/Bc5G374c+C0uJ9RUdqQY+1MIGj+8ahKJ1R3f+KS4f
         gssZd5ezPZjYCfGjUvRiO9Vi76w63SrRfP33GcmszIoz28Q521Jff+u8YQCFMbpuj0uF
         hNnw4hvDyn2ZJNQiRRuW+fic8Idg63lkoShPd+6oJ++nnLFcUzPW3cM8fk4FHJE/Cv8f
         0kuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709896070; x=1710500870;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v2PS7WMpUxr6Gfm7GFwTVy+838NKDv9In7TPwaetXrE=;
        b=YzQXZjWxrAOiDTL9fvV3kVyDVoZBbFzdqk9NzSDwIml4DaD6SMzqmj7YgXQ8LnWAId
         1OhuDuo/wwC1F71N6jpxhnRGkCZNVs2+SjnomZgjcWIn156cwqREdVmRezT+bA70mBEV
         sRzxSBKr4Pe54ym2lv5M7ktAjKmnOgfD8a5gHdxmRd8jM211xKebqPlS+rJPAJGUfRQ2
         6OlnG8Nrl+QQbjnFyz4GEkKST3CuZbALB2kz+eonMl5jUyVLm7oS9xPTt+a3EFrmOwkf
         69lxHKSQ5H0ktSplMKF09tUcyXoVc8hZRiR4itZn1Sa+8m/KrhE9JzSuCxQOySd2iPpV
         b6ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWgko7N2l+UmWM/bcNKRktAHeN20/BkFY23e4QS8aNB0sgkmfk1QhOoWD434eEFcUU3Ustnqg8JfOp+jSEi6W6kTkuP
X-Gm-Message-State: AOJu0YxBiSIsMHKHeQa6myH4jRJt6Q5SM3Xeu7xLeKSWU1RKm1+kmRwz
	5ja4JeRUHDSBYq2ZyQbd5Owbb577HlLAGfD0S41YXsB7ixUgzL2v
X-Google-Smtp-Source: AGHT+IHpkNGVl4DTm1o1Kna3LRApa0ebytPIuyxRz0FTa/ORR4q1Iohm+ajtyq+JFChXFRryQdgClw==
X-Received: by 2002:a05:651c:2211:b0:2d3:469b:3dca with SMTP id y17-20020a05651c221100b002d3469b3dcamr3487408ljq.50.1709896069793;
        Fri, 08 Mar 2024 03:07:49 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6ca:8b01:d2c6:37ff:fef6:7b1? ([2a0a:ef40:6ca:8b01:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id c5-20020a05600c0ac500b00412dcaeef39sm2690224wmr.0.2024.03.08.03.07.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 03:07:49 -0800 (PST)
Message-ID: <b98671d5-e166-4b5b-9cb2-b0c85bca7fd6@gmail.com>
Date: Fri, 8 Mar 2024 11:07:48 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/15] allow multi-byte core.commentChar
To: Jeff King <peff@peff.net>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Manlio Perillo <manlio.perillo@gmail.com>
References: <CAAToxAEE-2B_8Wqrquk1peOnqTbOpV_8KZmsJ2dgk-mfCZXHiA@mail.gmail.com>
 <5e10f1e5-b87f-43cd-ac1e-d7c01b7dad21@app.fastmail.com>
 <xmqqsf1466eh.fsf@gitster.g> <52d6850914982ffaf15dda937d611ffb@manjaro.org>
 <xmqqmsrc4osm.fsf@gitster.g>
 <20240306080804.GB4099518@coredump.intra.peff.net>
 <20240307091407.GA2072522@coredump.intra.peff.net>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20240307091407.GA2072522@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Peff

On 07/03/2024 09:14, Jeff King wrote:
> On Wed, Mar 06, 2024 at 03:08:04AM -0500, Jeff King wrote:
> 
>> For a more readable series, I'd guess it would make sense to introduce
>> comment_line_str as a separate variable (but continue to enforce the
>> single-char rule), convert the easy cases en masse, the tricky cases one
>> by one, and then finally drop comment_line_char entirely. At which point
>> the config rules can be lifted to allow multi-byte strings.
> 
> I ended up cleaning this up. Like I said, this isn't something I'm
> personally that interested in. But it just seemed like a wart that this
> one spot could not handle multi-byte characters that all the cool kids
> are using in their prompts etc these days.

I agree it would be nice to support multibyte comment characters on 
principle even if I don't think I'd use that feature myself. I've looked 
through the changes to the sequencer and they all look sensible to me. 
As I mentioned when looking at patch 11 I do wonder if we want to reject 
ascii whitespace and control characters when parsing core.commentChar. 
At a minimum leading whitespace and LF anywhere in the comment string 
feel like they are asking for trouble.

Best Wishes

Phillip

> Plus it was kind of an interesting puzzle for how to lay out the
> refactoring to make each step self-consistent. At the very least, I
> think the first couple of cleanups are worth it even if we do not see
> the whole thing through. ;)
> 
> It obviously nullifies kh/doc-commentchar-is-a-byte, which is in 'next'.
> Sadly "git merge" does not find a conflict with the documentation update
> in patch 15, so we'll have to remember to pick up one topic or the
> other.
> 
> I'm using U+00BB as my commentChar for now to see if any bugs show up,
> but I expect I'll get sick of it after a few days.
> 
>    [01/15]: strbuf: simplify comment-handling in add_lines() helper
>    [02/15]: strbuf: avoid static variables in strbuf_add_commented_lines()
>    [03/15]: commit: refactor base-case of adjust_comment_line_char()
>    [04/15]: strbuf: avoid shadowing global comment_line_char name
> 
>      These four are cleanups that could be taken independently.
> 
>    [05/15]: environment: store comment_line_char as a string
> 
>      This one preps us for incrementally moving code over to the new
>      system.
> 
>    [06/15]: strbuf: accept a comment string for strbuf_stripspace()
>    [07/15]: strbuf: accept a comment string for strbuf_commented_addf()
>    [08/15]: strbuf: accept a comment string for strbuf_add_commented_lines()
>    [09/15]: prefer comment_line_str to comment_line_char for printing
>    [10/15]: find multi-byte comment chars in NUL-terminated strings
>    [11/15]: find multi-byte comment chars in unterminated buffers
>    [12/15]: sequencer: handle multi-byte comment characters when writing todo list
>    [13/15]: wt-status: drop custom comment-char stringification
> 
>      These ones are the actual transition.
> 
>    [14/15]: environment: drop comment_line_char compatibility macro
>    [15/15]: config: allow multi-byte core.commentChar
> 
>      And then we tie it off by dropping the now-unused bits and loosening
>      the config logic.
> 
>   Documentation/config/core.txt |  4 ++-
>   add-patch.c                   | 14 +++++-----
>   builtin/branch.c              |  8 +++---
>   builtin/commit.c              | 19 +++++++-------
>   builtin/merge.c               | 12 ++++-----
>   builtin/notes.c               | 10 ++++----
>   builtin/rebase.c              |  2 +-
>   builtin/stripspace.c          |  4 +--
>   builtin/tag.c                 | 14 +++++-----
>   commit.c                      |  3 ++-
>   config.c                      |  6 ++---
>   environment.c                 |  2 +-
>   environment.h                 |  2 +-
>   fmt-merge-msg.c               |  8 +++---
>   rebase-interactive.c          | 10 ++++----
>   sequencer.c                   | 48 ++++++++++++++++++-----------------
>   strbuf.c                      | 47 ++++++++++++++++++----------------
>   strbuf.h                      |  9 ++++---
>   t/t0030-stripspace.sh         |  5 ++++
>   t/t7507-commit-verbose.sh     | 10 ++++++++
>   t/t7508-status.sh             |  4 ++-
>   trailer.c                     |  6 ++---
>   wt-status.c                   | 31 +++++++++-------------
>   23 files changed, 149 insertions(+), 129 deletions(-)
> 

