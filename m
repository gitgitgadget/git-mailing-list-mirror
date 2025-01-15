Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3D68635E
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736952595; cv=none; b=J9VFIvUO/ONHgsUO33laKRi78XRmwGU8oEdqhCYyE2nInUJMTDGXWZnjOKqrbXJLdMXnUaPBde9NZsFO7yMxdRHnUunG1a8G8SvoMu6C4R2sSzITZ8CXd6/2m+RRSEJy+TXIJzUU5MwiOdq3f/L9j1d4+sVhd37sJ/oODAvgVD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736952595; c=relaxed/simple;
	bh=7zdAG0Wd7rJGPrJEYL7F/SWjKMLarWiK/Wpn6KSFSRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QKRRiSqCX+pejqOwtbPBmMAD3XD0CnOYDf3RfOuL/iD5d2Vjm7M7SjXt8bcGpA7I/vq6m0W/p+0Hr7RFyZ2odPVU+dEAY9kTQzihEqYK7BmWQ6+dAqjAe0XxaOoVJM96chCo6sNPmuneJFHtcTYvI0AJ5Ybk7wT0nWovytdpTNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEijp6Nh; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEijp6Nh"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3862d6d5765so3624700f8f.3
        for <git@vger.kernel.org>; Wed, 15 Jan 2025 06:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736952591; x=1737557391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RXSpMIvNEmZQpIcazmtiXWiOM868dV5H5LIZJcl9CKs=;
        b=eEijp6NhqC/RSM84IFYVXAtyPJz/wkXuUjYckVnIQjiizQWtbrw7FE/8VsEMbNDg3T
         8lHC+2AyJh7PVOSN5r/sGTE1j8mYjTjeFPd4uWTkJr0QxBgbc8mDx/RNoooPJk833vfI
         3QGDe+aFMuLs8n25hqbMRMmXu9QnHaPKu3BDmCRosqhN8Tv3vOe/8h5iMf3e5cF8pNrm
         hMr5sNjmZcNjMWaahdpxYx27+P7d1h6jlogoVp0FebMLRt4I1c2/MeDnIYFMMNCrDPhJ
         S6AZRhAsgWTcpfJ2JNDbD0Ab8FTiAy/IpNOZLmDC64vBbnYEbEavyeg9BLvOdLw12tIf
         na6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736952591; x=1737557391;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RXSpMIvNEmZQpIcazmtiXWiOM868dV5H5LIZJcl9CKs=;
        b=G3vPK6s1Wq1dbU/8UaMtcSh1i0rhvqhoxxviTdQf7W52I46B7HcccZmjXB/49nNu5I
         JHo0+vjF8jn7rcQ6WvkkrP5TZQi++h1GdfzYZxg2k/Y6evuVflRSiiezmMmrokarms+i
         X4J0umkqsw/7RNQwlEoFCir/hOkfBIsLzOwyb9sKwFHpporD50PZwPS+52Ns2Tyc6SB7
         4CUix7An7/lX3dxw1VVHBUM/u9CDFmQyuAdpNKFn2QzXrRSwTMOYU+sqro4beQ5OTxDU
         UFwS2ZJWijKJkiCYBTLeSh3skbR6W7WkD0PM1apG5mewUVz1TxMxUyZK5sV/YPl3K/rm
         lc5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/vR52XL3eCvdtJ19h1s5gInlOb8bucwY8Z0aVJUzObaBA7z9jteNYF2L0e3Jz2KzO9Ww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/0DP/KoWcs2V4zxk1O/iBBfb/LLBKlYvmfmTbI4JrHOkFy22g
	Gte97p7l8iPxVgLb1bQXoRduRhTlIoqOezgsMX+cRKxqlDChF2D0//83fg==
X-Gm-Gg: ASbGnctV/9r5mIl/3rT1Zr8XGF7shcwZmlD3w9FR7LHEwv3waqtryO7BP8GjASOqHdY
	0IHdrjB/bsvyUvtEV3BD7RlKrV4XKefKxC7PKlPX+ucxFp4arSkieR7kFnizqVNhIIsZB9XY5R2
	UhwrpEEnb50IG4MrYMuXsHyrzV7UmjPs8ra1fy+EndnJ34bzJYCwg4GEL3tbCCXA5UNfFsmrx3k
	yBPwdVSD5dllFW6sFYo4i/YgSZoF+o2LoNXP341ISK3lh4O87UXcE06PNIHs6dT2ccU66uqtS2T
	fXePRvtmmC3X/R1eCj83lYRFXPklKSdny8E=
X-Google-Smtp-Source: AGHT+IGBLsh8VW64ux2e8sCQO1cSPiJZHvrjQ1x8sBS1KpTVaN0OPDfsS1JA67S5dTF2uhr3yn7kWg==
X-Received: by 2002:a05:6000:471a:b0:385:db11:badf with SMTP id ffacd0b85a97d-38a872e1640mr26122737f8f.22.1736952591262;
        Wed, 15 Jan 2025 06:49:51 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c74accc3sm26217355e9.14.2025.01.15.06.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 06:49:50 -0800 (PST)
Message-ID: <8570a129-d66a-465a-905e-0a077c69c409@gmail.com>
Date: Wed, 15 Jan 2025 14:49:13 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/3] Sanitize sideband channel messages
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Dscho

On 14/01/2025 18:19, Johannes Schindelin via GitGitGadget wrote:
> When a clone fails, users naturally turn to the output of the git
> clone command. To assist in such scenarios, the output includes the messages
> from the remote git pack-objects process, delivered via what Git calls the
> "sideband channel."
> 
> Given that the remote server is, by nature, remote, there is no guarantee
> that it runs an unmodified Git version. This exposes Git to ANSI escape
> sequence injection (see
> CWE-150, https://cwe.mitre.org/data/definitions/150.html), which can corrupt
> terminal state, hide information,

I agree we should think about preventing an untrusted remote process 
from making it look like its messages come from the trusted local 
process. At best it is confusing and at worst it might trick a user into 
running a malicious command if they think the message came from the 
local git process. We need to be careful not to break existing 
legitimate output though. Brian has already highlighted the need to 
support '\e[K' (clear to the end of the current line), we may also want 
to treat '\e[G' (move to column 1 on the current line) as '\r' in 
addition to SGR escapes in the last patch.

> and even insert characters into the input
> buffer (as if the user had typed those characters).

Maybe I've missed something but my understanding from the link above is 
that this is a non-issue for terminal emulators released in the last 20 
years. In any case I think that that is a security bug in the emulator 
and should be fixed there as it has been in the past. I found [1] to be 
much more informative than the mitre link above about the actual 
vulnerabilities.

Best Wishes

Phillip

[1] https://marc.info/?l=bugtraq&m=104612710031920

> This patch series addresses this vulnerability by sanitizing the sideband
> channel.
> 
> It is important to note that the lack of sanitization in the sideband
> channel is already "exploited" by the Git user community, albeit in
> well-intentioned ways. For instance, certain server-side hooks use ANSI
> color sequences in error messages to make them more noticeable during
> intentional failed fetches, e.g. as seen at
> https://github.com/kikeonline/githook-explode and
> https://github.com/arosien/bart/blob/HEAD/hooks/post-receive.php
> 
> To accommodate such use cases, Git will allow ANSI color sequences to pass
> through by default, while presenting all other ASCII control characters in a
> common form (e.g., presenting the ESC character as ^[).
> 
> This vulnerability was reported to the Git security mailing list in early
> November, along with these fixes, as part of an iteration of the patches
> that led to the coordinated security release on Tuesday, January 14th, 2025.
> 
> While Git for Windows included these fixes in v2.47.1(2), the consensus,
> apart from one reviewer, was not to include them in Git's embargoed
> versions. The risk was considered too high to disrupt existing scenarios
> that depend on control characters received via the sideband channel being
> sent verbatim to the user's terminal emulator.
> 
> Several reviewers suggested advising terminal emulator writers about these
> "quality of implementation issues" instead. I was quite surprised by this
> approach, as it seems overly optimistic to assume that terminal emulators
> could distinguish between control characters intentionally sent by Git and
> those unintentionally relayed from the remote server.
> 
> Please note that this patch series applies cleanly on top of v2.47.2. To
> apply it cleanly on top of v2.40.4 (the oldest of the most recently serviced
> security releases), the calls to test_grep need to be replaced with calls
> to test_i18ngrep, and the calls to git_config_get_string_tmp() need to be
> replaced with calls to git_config_get_string().
> 
> Johannes Schindelin (3):
>    sideband: mask control characters
>    sideband: introduce an "escape hatch" to allow control characters
>    sideband: do allow ANSI color sequences by default
> 
>   Documentation/config.txt            |  2 +
>   Documentation/config/sideband.txt   | 16 ++++++
>   sideband.c                          | 78 ++++++++++++++++++++++++++++-
>   t/t5409-colorize-remote-messages.sh | 30 +++++++++++
>   4 files changed, 124 insertions(+), 2 deletions(-)
>   create mode 100644 Documentation/config/sideband.txt
> 
> 
> base-commit: e1fbebe347426ef7974dc2198f8a277b7c31c8fe
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1853%2Fdscho%2Fsanitize-sideband-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1853/dscho/sanitize-sideband-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1853

