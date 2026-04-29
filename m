Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247993FB070
	for <git@vger.kernel.org>; Wed, 29 Apr 2026 13:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777469757; cv=none; b=rLfw6aV+EUY5+/P6SmpLa2v5jUhI2fFvmSKO9YAhJwA8cWT/RwQokuNmc3RSNXLdlQ1H/q4ekDgIOH6tvG+rjaKj8nvLJTTsJzfygahP2a9x5Bu6XtU5jN8pdcvRqtQWnX5O9PeVkAULyEPOVhEWrnr3zt/WQFwMTpF+4+hEySQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777469757; c=relaxed/simple;
	bh=lgM39/9wKm9VIIJf2LU2b1i5IxNMrmugHm/H/5XMGBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qDToDVzBl+vwgniAhs05Bi/r9UCW4bR+w6OKHzTVeI5Q3qmzOkEuUDRSrs8StqdNtjjtd9a/1iQbUn71uHwS5qLOiuyRqIvugbBzCHwiBCf+PN7QLrEiW2yIO8qy/0UKzhtHDKPAAQqFi0X6f4b8HkQZtAXuTDsZxyrzAQpf2Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTSdJ/pc; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTSdJ/pc"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-89fc349b5ceso178249036d6.3
        for <git@vger.kernel.org>; Wed, 29 Apr 2026 06:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777469755; x=1778074555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TXZOthH7V/K1rDc5FTfNdNhA351w/5bD2sJ2g0NuKwg=;
        b=MTSdJ/pcW/ryCgR6reF00JSDBDrfHwyML4yauacZXAMJlr8kETCiwEqCkfAbPhMEGR
         RXVe+9nLkjbjjMXsMV0oOihL0dfcdEgutGGtHiMuAfLQE3tLvM+/dJZBMknnbi9CqEQI
         775r7znzIfdrXeZKHn3ptNLJIWFP/7fSDCfD4L54rF7bC5ZWp7Yt/fO6vlq5gPJwGCCi
         h8Q0SkhDxAC3YtLV5vucF00AD4pguq3Dt3oe7WlpSOGt+rxIzOyY4ftb8o5Mrix2Twn0
         0ZbdqW9snQ3JKw/dw3k4Fn2bTA65e1K5k58TJNpotwkwwMfrAIBLVyow2jCIDBJyPaMS
         QA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777469755; x=1778074555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TXZOthH7V/K1rDc5FTfNdNhA351w/5bD2sJ2g0NuKwg=;
        b=VNo0TGTPK2cHjb58q65ImCf9ZxVrtU4UBL4iuMEN8+aDzPGX6dl7L9qVjyMW7a7oSq
         iUAWD6nremqfqyGX+K2tKSI3d21gidIvyBVtcQEaTKtyqlb4x3opYao3hkyJvWKMKs2A
         Iq6B31GTyA7xKeX7bd4zKpG+nX3IBceOLEh+N/7Yt82FuQUO6szBuw5bAvEiHsNCIq2Y
         UEawqz5WTYM/eeSaY3zNhYU33KifX/zTY5vR8qVsFgLYk579E28o3UJaAUW5ooLYJF37
         Py8MI5fMQFhkYSGbCFucBkW1OE6R6Fu9tpk9O5YOjyaEdFCMCmglc/TaexEBJo1DNfTF
         Jp0w==
X-Forwarded-Encrypted: i=1; AFNElJ/ke1h5JQvWz3DS8jLc/uzF5e+MGIRU+Uv4frSOizJTJUjkcf+lEg4HBv+MRoNjBNeRKXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuEpPOjTdib4jy9K7szKcQOWwZdX67s257q3ubh6o6vHGQMNuy
	1F6ZjgQTIrU7b5tlt0lMEqjv4Oy7E6Yt8d8dlOwhqwGcC/Unx+nX4r+T
X-Gm-Gg: AeBDiet/5ma2kgfuFqntWVlS77VuPDwuASwegc4mXvH2J0YR7jV6fAd6x7Q8/OjmlvB
	/1XzHVjiluy1gbxmI3AUtx4i8wVkIJh6hLUSS1zprfcgE0Oab/cKEqy/04LoWxVBwm8aVFki1+6
	97tDkwVj2bOXSNWM0ybnEqEx4Mr++R0FP37G5Dn/G2vq76rPvGBalT/sd1L7sz+Ddnmlpl6NWtC
	1QFORA5YNoHdXkB6xGnzIc8OlUhm08MzK8lwFYNeIOCC3xsYeBL1NwY1kpBJ+C/QIliWLHgBXVa
	rDIE9xXmg2hzjOR8N1HEpSvGWqFunwmmAQd6kCfXauJ27Wn++2Qv9gsKsWnIC4iw1Zwh4ojs6MN
	gPPXiUDzmQaWk/Ti8uKUxhbvoQVZlTPsrs0ouwzo38sCXxjwM1zaK7XPfu+DHdFxGJOPaXzY2q/
	aFXBWrj2zzGAb+hKuzv5RYCIMwlnxn3P7aIsAI0bTeH1nOUOt7w4xgqhKuh/X4MTRbjiGCFrtw1
	zC3ASVE39VAoz407H7CckuJchrxY0I7Sdj3+G02x/QV1b9JS8T8gcxhWgE1mw==
X-Received: by 2002:a05:6214:1c4b:b0:8a5:104b:e37b with SMTP id 6a1803df08f44-8b3e31ef79emr119829876d6.42.1777469755019;
        Wed, 29 Apr 2026 06:35:55 -0700 (PDT)
Received: from ?IPV6:2605:a601:9b88:8300:c8b0:7338:485b:4bd7? ([2605:a601:9b88:8300:c8b0:7338:485b:4bd7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b3ef7e7eb3sm18809576d6.29.2026.04.29.06.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 06:35:54 -0700 (PDT)
Message-ID: <7bed56a9-520c-4d7b-a4d6-f03d89667993@gmail.com>
Date: Wed, 29 Apr 2026 09:35:54 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Handle cloning of objects larger than 4GB on Windows
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/28/26 12:26 PM, Johannes Schindelin via GitGitGadget wrote:
> On Windows, unsigned long is 32-bit even on 64-bit systems. This causes
> multiple problems when Git handles objects larger than 4GB. This patch
> series is a very targeted fix for a very early part of the problem: it
> addresses the most fundamental truncation points that prevent a >4GB object
> from surviving a clone at all.
> 
> Specifically, this fixes:
> 
>   * zlib's uLong wrapping and triggering BUG() assertions in the git_zstream
>     wrapper
>   * Object sizes being truncated in pack streaming, delta headers, and
>     index-pack/unpack-objects
>   * pack-objects re-encoding reused pack entries with a truncated size,
>     producing corrupt packs on the wire

I'm glad to see this progress in this direction. It's a big step!

> Many other code paths still use unsigned long for object sizes (e.g.,
> cat-file -s, object_info.sizep, the delta machinery) and will need their own
> conversions. This series does not attempt to fix those.

I appreciate the mechanisms used to keep the scope of change minimal. This
differs from the typical "replace all 'unsigned long's with 'size_t'"
proposals in some clever ways.

> Based on work by @LordKiRon in git-for-windows/git#6076.
> 
> The last two commits add a test helper that synthesizes a pack with a >4GB
> blob and regression tests that clone it via both the unpack-objects and
> index-pack code paths using file:// transport.

My biggest concern here is about how expensive this test is. I wonder if
we should mark it as expensive for the core project and leave it enabled by
default in git-for-windows/git.

Thanks,
-Stolee

