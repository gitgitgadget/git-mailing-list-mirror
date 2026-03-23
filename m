Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2112AD4B
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 05:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774244936; cv=none; b=h+CTu/bvzbByv71Jd40kcuR3YoKq17rATxD1NoH0cC1jZ3af25DHlzgtF/KYhumxo2CVWgbMKtZbCLJJ3ArrWtJOEGrLwyelhtJ17e+LVKqxevFJ0QUR/LcLsT8H9hsAOePSTa5DPDxRwLpF8gP7OqBLKQ1w7UqqotqH6913ztE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774244936; c=relaxed/simple;
	bh=qgFz80LiGfzEH/Bk63Jse/wij71CAL3qSuI1CJJHFHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TEjRGSKqd5AkT269bHUhXdO6u24LjgYKuN5hGIrzdmMzCUhZKDPffHCZm1SvgB8+O+WGs2oUcil82A+i5aIJpYB7ePjhdMo2EgsEBXvXP3+D9j7vXbQhgXTQUnyA5p5xAy3rVmI+Pv8RGBvSbRpH/2Hnj0qEMTBZKITNqmD2u5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lvl9Jc/e; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lvl9Jc/e"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b05930696cso3276955ad.0
        for <git@vger.kernel.org>; Sun, 22 Mar 2026 22:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774244934; x=1774849734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nyOY3njC7uZiMbCRkdHukN4YECXHNWPLKNwV2VAMKNI=;
        b=Lvl9Jc/eq9R7IOkBiW0ETUqZRbhh6nwySib98F+UDT9bcsPqSMYQlmnbugusXiGx7A
         2Tu32EiD9xqN9kcxWXwRDouI9OzSlCxEzydMX2z/5B4TwVpopakj8dJO0UTIdR60iI3/
         YS0qhwwHPBIxzTZh73fhUP+/NOvFNN/oe/V/sBS6oLrwbFuuaNfYBpQch5M5tvnv//Fj
         chp9qFxlKVPGHrHlRhwRNt27BFXVIsED6S1qW9AR5BHDLJKcSi7WzktTs+IRck5hEYbp
         RFc9kaQdPuB/3ubnzZMQ+l2kW/kA0oYe3YX7tqJ8sfRJhjVliADu1bjysyRGWgNIyUlX
         WxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774244934; x=1774849734;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nyOY3njC7uZiMbCRkdHukN4YECXHNWPLKNwV2VAMKNI=;
        b=b/b9S3viUjDyyP0owooRMZRTe69GAlpJvVxVEFKwVTYZQbwMyBJCNTKTeGOwlZoN+L
         VgC8NcgP1VDJjY2OS38s7tIo1iW6awsfbXwjiSNNBHvgRqwgYF1bHoSkPF2/tXs7PJvf
         qoucxOkISegAzHPIx1ri9xWiFJz2V+RrJiXa1tpb/4HoXukNskWgkVYrBVZIT6iqLIBK
         /CfxDjYjaY/66D8W85tWEWXZPcu9cqgx20c+nvpcoA8j99JiJtkqk4iDWa1k7UanC5bw
         qmC6uaIHpKMkEq5BaEb/XtFa3xz/r2uAL4IbAIsf0kiX0/nrQnETzW5NtWZrBVIjbxK8
         2UKA==
X-Gm-Message-State: AOJu0YzmoITiZDunQ3XkdG/TWYpGu0k8dWDuYaP3HuAoUXfL5pq6sAe4
	r3C3/Lgt2udlhxRfTsVmyYsh8B5nQGRzYxbgZuylRl1NHKsYtA0vl2pCVuYK5Ew4
X-Gm-Gg: ATEYQzyrZe49OFwt9Z7pVyGvl552MkFfl8vFaBmlM6P5EqkV8fm2r98wBN1aRsl5pPU
	WZ2rNsdqZ43pHEbXF5B9tiNiFIl9NfXpT3e9VALTdr47kY7gbUvDVnoI7fGiEph14yY6bJY0VAG
	iiKPwqKBBzxaOce+6f+N4xwP6aZvCvykYfrAGkMtoVQeByN9Y5xPQVw2gtFgpQBWOkU9bQteMEB
	Nfs2O1p1jN32ailNwIMN/geFEUKGoYFxE8fS/oeAt71Ym8mzR5ILg+pZyr+BW2qpGA11o2RQwUU
	hbyREB1i8HUnPRX38qk9bn+cYOrwW8xFTTwSn5A8Yv0ShcPKQ0OfMeP6b5oCxVmDAL6CjKAjh8p
	AwbLzEqkbh+h+sHo56sowmk3WxN8DkaDQajFr5c4goyz6g4dXf3AbfIRiSnT+rnOnePlLG5HKpL
	zZi/AqMhCEo2qN4x7DaZM/t6F5N6bPd09K93N9ZSJSlFzdLDks1+RoT/AOXZ1izBpFMuqczSxTK
	qO85ciXfc2Yb1s1EDF3NA==
X-Received: by 2002:a17:90b:4c12:b0:35b:e69f:847 with SMTP id 98e67ed59e1d1-35be69f0922mr2876803a91.8.1774244934088;
        Sun, 22 Mar 2026 22:48:54 -0700 (PDT)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd364ef9fsm2931014a91.9.2026.03.22.22.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Mar 2026 22:48:53 -0700 (PDT)
Message-ID: <b1064c6b-21df-4ea1-b753-549e0ca1f346@gmail.com>
Date: Mon, 23 Mar 2026 13:48:49 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] diff-highlight: use test_decode_color in tests
Content-Language: en-US
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Scott Baker <scott@perturb.org>
References: <20260320004138.GA3653623@coredump.intra.peff.net>
 <20260320004436.GE3654226@coredump.intra.peff.net>
 <b992e118-f948-4145-8d77-96f00b497f99@gmail.com>
 <20260322204750.GB2047044@coredump.intra.peff.net>
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <20260322204750.GB2047044@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/23/26 04:47, Jeff King wrote:
> On Mon, Mar 23, 2026 at 01:24:00AM +0800, Tian Yuchen wrote:
> 
>>> @@ -42,9 +39,9 @@ dh_test () {
>>>    	} >/dev/null &&
>>>    	"$DIFF_HIGHLIGHT" <diff.raw >diff.hi &&
>>> -	test_strip_patch_header <diff.hi >diff.act
>>> +	test_strip_patch_header <diff.hi | test_decode_color >diff.act
>>
>> Although this is just simple text filtering and leaving it as is wouldn’t
>> cause any problems IMO, why not go ahead and add the && while you’re at it?
> 
> The bug is in an earlier commit (patch 3), which breaks apart the pipe
> but doesn't add the necessary &&. And it's more than just text
> filtering; it breaks the &&-chain, so we miss the exit code of
> $DIFF_HIGHLIGHT (which was the whole point of patch 3).
> 
> chainlint doesn't find it because we're in a helper function, not
> directinly in a test snippet.
> 
> I'll send a revised series to fix it, but...
> 
>> I've noticed that there are several missing &&.
> 
> Where else do you see?
> 
> Or do you mean that we should not pipe text filtering commands? There
> I'd disagree. We are not likely to see a failure from 'sed', and if we
> do, the fact that the output does not match would catch it. And the cost
> of breaking every command down without pipes means having to manage lots
> of intermediate files.
> 
> -Peff

Oh, I see.

To be honest, I didn't think about it in that much detail. I just 
noticed this tiny issue and wanted to take the opportunity to remind you 
to check other parts as well. I'm not saying we should remove those pipe 
commands :P

Thanks for the explanation about chainlint.

Regards, Yuchen
