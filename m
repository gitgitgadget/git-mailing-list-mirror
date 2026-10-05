Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5298044065D
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791193881; cv=none; b=LSDANCGk/s/wAF92wi0EnoAzn+EtabqdTzX915QRDI7r7Fe+uZAxQaM6t2CZAjSxSSTm0G+no3ALXWLJLO/GemiKHgH0c1dgz9BfVt6ThRldpHUplgEyAg0yRps/lG299nQk6JO943Ih2DIQJc6LgtYgszYkv+9coySXtjQ825s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791193881; c=relaxed/simple;
	bh=akNdiTp7vyyYQLkZvgISvfRuQ21wNTTnekqlGTLOhHE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WhLKgaXGQMXkAH+QY81rUtQM+xA04+MTVhF8p4nUsUwGwAFVr5DfCKPhvzV4RoN5cv7hID42RpwtV4f5GHqzwJadNq0mt0KENcWnDEnK1vV0tEQECQPIKmRQL3Ol6yHPN5T91l6Hs8ANzVma03KYtkGa5AcQdMLjQJkTPZYFq7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcEvHY9/; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcEvHY9/"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39dacf053eeso639598a91.2
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 02:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791193880; x=1791798680; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BDp31P0+eelZQlPZp+1XDJo15iQUJeJfpg2MstHBDOg=;
        b=KcEvHY9/iWwGNg4A5JRM7mn2289OZdkN81bJYM8qqgyc4ktNjm35UUmWOlCrWUjSSC
         1GkdBET/NF4xfBxczjOT5GW6M96sihbaitViqshkoCq4SBHnPGMn9djPWYlBVd/42vm0
         jdrtXFvaKNs4YZRP4/45zLhveSnLk4Ba9bKZJXSeQUbGsRZJdmY2cd8aBW8aetjr5nSv
         PYjkGSbXC+TyJiWnZuxLhrMAM0EFIcaoLJ2886bukJEBkLh0cYXpxhWtqktvkxZVNg+T
         Oo829omgnZimSbJeerJtB4VeVneT1jedw8nwzVmdOSQ9dtkhPqH1iQbKoKHrKagNGWZB
         Kkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791193880; x=1791798680;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BDp31P0+eelZQlPZp+1XDJo15iQUJeJfpg2MstHBDOg=;
        b=CyBUaE0sCXKQQ3hwKofBl4gJibZFWiqIAgh4AM3vsq1JPG0pgrvMjoV/flgDbBnPfF
         RyxWr9WezDwKQH0yvbjL3Ktc96uwUj2iHPe2U+pUCBB84ngiFeV+rlX+PQy2b5NqG8Sc
         Kqvo+APJRNZIH/ahF1Vxk+H+Ir+AcP1THfsNUajv6E2QRNldmSIaD7wHuDJ4GMFsDp4E
         nrWflY+/r3HWQbLJ5BVJLzF1tjPq78D/qhCqmtxHcSwtrDplRC/SRIvtF+dTou1FpAbz
         ZVDLg9bAHGD0i2ZE/uX72t3JYvmGAuPxYlLy1e2T7KU5rztfwzZBZ2jT12AJnSuXE45f
         AbiA==
X-Forwarded-Encrypted: i=1; AKwUvByXfjZ7miu4h5EIuA9YSxGKRQVNFK2sPdOkHW+CjK3zCbOCb5A2vzr7qb0sBq+sWbaeY/E=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5oukbG8Mw66KrDZHyV8zJlAIYx5L+l1W/f9nIRr4KqrXh/8oC
	8cG+Ycbei6+lvYWARDV7nwxfU4VdGFiWe+Zk06waKyWymWqagvAoey4b
X-Gm-Gg: AYBFou0TA3Qiul7o65HZHUYR5DGgc7xdhPa6BmAHbydEIX/imHXxAOCoFVXi2gPX39r
	dVj/qQ9QVHRbl+B3qDjgD3n8NDWtbGInt8Dk1rB/NNptWxWH8c2CFoX5lj17GaroWhR6en+LXFg
	9lDtt74T4MZBhxqHV/gL3K0GJOIPxhCVJxl/dIJIKdEXTwLhNYrcMtjwpy6SRkbSmNVGx56BB4V
	XcAeLYzMLb1VIUDF2S22Zaah3Hq9SSEa26DEmDwNfPVheMC2FKMHWJ/ov1yMKCdrSHDaNjemSjQ
	B0/G+/5d7m/v3hfyvHPpQyhcHgZ9ZD6QLhPDTwMX8qMIDRJkiJmzoeLVWd7MWiwWYpoQENdN0YX
	kA1sLDhyj0Cj3L9u9cGsYZT+2YV4waMmriy9i+k8hayaG28As7EBspH8JpobtSBe6Zc3JFFSlb0
	dhEorWodR4tBc6enWjvITRfLE6unVbJajmWFzm3HX72TAfFQi7WXvdg2kjFfVPHS2kq+GuD+jss
	MUa7FI4AOBJCxHi9ErK1PPm
X-Received: by 2002:a17:90b:56c3:b0:3a0:c85a:ee02 with SMTP id 98e67ed59e1d1-3a6ce6e7febmr7206762a91.17.1791193879593;
        Mon, 05 Oct 2026 02:51:19 -0700 (PDT)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78daef465sm10991270a91.1.2026.10.05.02.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 02:51:19 -0700 (PDT)
Message-ID: <24737aed-50c5-4536-a081-938036c08588@gmail.com>
Date: Mon, 5 Oct 2026 15:21:16 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH 0/7] A couple of Meson improvements
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20260924-pks-meson-improvements-v1-0-90b7f79f1c4e@pks.im>
Content-Language: en-US
In-Reply-To: <20260924-pks-meson-improvements-v1-0-90b7f79f1c4e@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/26 19:39, Patrick Steinhardt wrote:
>
> ---
> Patrick Steinhardt (7):
>        meson: avoid recompiling HTTP sources several times
>        meson: don't recompile git-remote-http(1) multiple times for tests
>        meson: use precompiled headers for our test-helper
>        meson: use precompiled headers for unit tests

The only other sub-directory that does not yet include the precompiled 
header is 'compat' and leaving it out seems to be the right choice. 
Including it would trigger recursive compilation issues as 
git-compat-util.h itself depends on compat/posix.h. Trying to reshuffle 
the build code to fix this seems not worthwhile given the amount of code 
is a bit less there.

A few other similar targets that were not touched by this series are 
non-worthwhile such as 'common-main', 'git-curl' etc.

Apart from the few other comments in other threads, this series looks 
good to me.

-- 
Sivaraam

