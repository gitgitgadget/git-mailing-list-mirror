Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5F6403B0A
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736828; cv=none; b=q83+4ptpZ0/s9zSe1p0f6hhFskgQCKoMP+LJoOcgUgrsnfGSRuDMgDWDXe8Qy/+QSi0ovn1ODnaef7VFRrvsQsAwrHLf2xgdePDUXhEgoZR6pnQhrm8ai/GBY/As4LSIBuF3NUywXTGzC2dnZYlJSmwgb6tjLHADYtoOV4gHwiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736828; c=relaxed/simple;
	bh=aVJuws5kBDdupR/7PuIDrz7aBhKTbUxOlmpyTHS6Muk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l3/tPjZOXBbHmMvdKSaBgobyumBtY+ulbDwEFPABCgRs3AHkfuX7S+sObpwVc76q7y+wC4Zis1bywiOIYDDqZgeiFEYcegIC6c8NwdnzM+Qvx/CZU4T2hCi4Cf3UMgZfwzsyJ62mfUJboF4oMjrdNzMvfgSNohEWaX7AYXP83/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHYCwrL8; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHYCwrL8"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aeab3465b9so1950905e87.3
        for <git@vger.kernel.org>; Mon, 29 Jun 2026 05:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782736825; x=1783341625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1UYgXQTkwi0BSLs5KZ1+i2dt/IZBMQa46sErHphNiVU=;
        b=LHYCwrL8Pwfm+iim7MlLxXs99GqiE5OO6+Ria8cOugVPt+wlrDAPR3r9fW7i9jxjcQ
         ae2A6Y1bqFUCQu1jtD4Ye73pXZwKE3F9QJkPKkri0mcpeOSxgfyfCQGzEESs+oJguCSy
         +ep0Pk/G2xFQNo5XUSFicArjgNQXyQz6ye1iegsDuXhgke0l6v93a74PMPkI0ak1Bg7g
         2//QZH8BKXLEzxrYjwnboVGmXoNi3beDF1HYK9FuEvDsM5kLpUy5xunYGGS4ZD0HFQ1W
         Vsuf5IxX1BMjDZ0PUtbewaygbu/BJimyl+AE4pjl/UCdd6+lfu1a5zlhkFe5v+yL3I2b
         WCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782736825; x=1783341625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1UYgXQTkwi0BSLs5KZ1+i2dt/IZBMQa46sErHphNiVU=;
        b=Pfk0fWBRuecROz/FDtrYg4ifEJvi54qtLmrsU9J7Envy3OTvn2oESkKAPrD2lxE5sr
         dNwPApCj98bzfD5sAeKG5xE+va3L3toscLlYFp3usVu1AbmGAiLIFXN9jw4vWHMnMmCv
         rvNEP3njdTUn9Iv+mKN9/WKM1bFcrIsc96deRXpaJu6biTsPj3ddRMpRYXPRhb7Y4KSM
         PQd9XPKHwSWpXHaJ5RxHv6PZV6hPP8R9Q5bIHouYU56ktJH9dfn1rqlUPnSG+CylR+Dp
         p7Cf6/gz3gzraWTsYWJjVGXSJL74OzUOBt7oGhZV5xFE0veUnZXpUDQwTNe6Jo8E8v+C
         lb5g==
X-Forwarded-Encrypted: i=1; AHgh+Rp73t2A8RglfEl0LldbJ85EWzrkPoiNh5bzQ/D/sYPfGz1g3uxzlNu/kzleC+ZZT0xpVFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2UU5OfbgCEa2UOnqq2ccd2cDt9QJxzinQE439HTUBsNhlZtEf
	BQazr6JCQuYKBqGX7CTYvfn1nNH43E/pAUqPgHQcO0vSrUjIMP7TfsYyDgPd9VlY
X-Gm-Gg: AfdE7cl+3MwHqwieEhx3GB7hxJ/bh2akb36KZUwDUGJpyBJ6VGrigWNFddOYT6SdX2Y
	OADeNKhWD1BPzaEfLP3ry+EAVSvNvrAN+lVzf5YdpKNd1pfO+uQLRQkWdGoPwlNr+GFrJlciS/k
	o3sVbt/s31e7JS2e0MbMu2scz6UqUZxeOe5OP+r6JVYUCjA0Nf/h0OXnn6C9Y1fshvdYE5UhnPt
	NUkShkfnaaF/BvZlLMAQs+v8Oj3NEH7SgE+gL8ndkvGz/lOBGIWOupMvACpWb5zbHWjMI3eq2q7
	WaG61otBc7htGtBUAHUyCRTlz0bfWhJwjaLHz9HzzeRkBoPItHzf3p0xqNrpiom327HI9WUJsiT
	DSD+J0jOxcx8vFZUzUTaVmTx9YfW/43QXJMK/mKxpj6o3ibOHyCdP05yObUPVRc4FAjYmO3MagI
	Mg8/y/+CpAs81zO33Y7pcH269913byFWQp3/ch1JjEwrTcSF4GgpAbSrPgjA==
X-Received: by 2002:a05:6512:b88:b0:5ae:a2b5:3acf with SMTP id 2adb3069b0e04-5aebcf09f4bmr137469e87.33.1782736824891;
        Mon, 29 Jun 2026 05:40:24 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad69580f73sm5781422e87.63.2026.06.29.05.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 05:40:24 -0700 (PDT)
Message-ID: <5ef694a3-9164-4ab4-8835-136439f6d267@gmail.com>
Date: Mon, 29 Jun 2026 08:40:22 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] commit-reach: terminate merge-base walk when one
 side is exhausted
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Elijah Newren <newren@gmail.com>
References: <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
 <pull.2149.v4.git.1782649547.gitgitgadget@gmail.com>
 <48bfdb11-2624-4aa6-8fbd-d3f894c33bcc@gmail.com>
 <CAL71e4O8gTLm4WUcPF-ZbOYTuEzuNSVh0Qjf8ys1w4LVF9Hi8Q@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAL71e4O8gTLm4WUcPF-ZbOYTuEzuNSVh0Qjf8ys1w4LVF9Hi8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/2026 8:11 AM, Kristofer Karlsson wrote:
> On Sun, 28 Jun 2026 at 17:16, Derrick Stolee <stolee@gmail.com> wrote:
>>
>> I reviewed the v3 discussion, the range-diff, and reread patch 8. I think
>> that this version is good to go.
> 
> Thanks for all your reviews and feedback. However, I found one more
> problem that needs to be resolved before this is good to go.
> 
> paint_down_to_common() has this fallback:
> 
>     if (!min_generation && !corrected_commit_dates_enabled(r))
>         queue.pq.compare = compare_commits_by_commit_date;
...> I traced the history of this fallback. 
...> The problem that 091f4cf3 addresses looks closely related to what
> side-exhaustion solves: the walk goes deep into a subgraph where
> only one paint side has presence. With side-exhaustion, the walk
> terminates as soon as one paint side is exhausted from the queue,
> so the deep walk never happens regardless of queue ordering.
> 
> I benchmarked "git merge-base --all v4.8 v4.9" on the Linux kernel
> (the same case from 091f4cf3) with three configurations:
> 
>                     master (--all)    side-exhaust (--all, gen ordering)
>   no graph:           3212 ms            3268 ms
>   v1 graph:            188 ms              17 ms
>   v2 graph:            227 ms              17 ms
> 
> With side-exhaustion, the v1 case no longer shows a regression
> compared to the date fallback -- if anything, it is slightly faster
> since the walk terminates earlier. This suggests that the workaround
> from 091f4cf3 may no longer be needed when side-exhaustion is
> present.

Thanks for digging into the history of this fallback and catching it
during review!

> If that reasoning holds, the fix for v5 would be to remove the date
> fallback entirely, always using compare_commits_by_gen_then_commit_date.
> This would:
> 
>  1. Fix the bug (finite generation always means generation-ordered
>     queue).
>  2. Remove corrected_commit_dates_enabled() which has no other
>     callers.

I agree with your reasoning, data-backed discovery, and the course of
action to fix this. I'm happy that you're able to close the loop on
this long-standing performance issue even with v1 generation numbers.
> Do you see any cases I might be missing where removing the fallback
> could cause problems?
I don't see any other concerns here. You're right that if we were to
have a different mode that changes the priority-queue ordering, then
the side-exhaustion optimization cannot be trusted, but you will
remove this possibility.

It _may_ be worth mentioning this with a comment when initializing
the queue order for the paint_queue, because the use of the queue
requires topological ordering.

Thanks,
-Stolee

