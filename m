Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C813939D7
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 15:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351151; cv=none; b=nlGxKbquIxwBSG1ohVBc/Rfnztyp82hSwHwrOd6kfoPinZgLcus4LQmWc7drfvG4TZpXXVBlcf+l1X5Wv2iBeg6k3I0JiPbe1CAMLNiYpCsIc4mgpK4ss7l4lIts+GSEjmXf7Od+vl7Tc1FxN9Xt8TAdX+vHeYzudSVZkCDRbp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351151; c=relaxed/simple;
	bh=WycBjIsOJAT6uKU62UC99+jdLN7+Snx9sdATMmkKoNI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=d552i4EDVdvjMSpY5jsZAUld48c1G2jr6hgCwA+PyDKVeqL1jyXd2Y5aKh4U1MhrW5IND21em5I/IpAJ2pzand+WORU0SKncn5xHBrWNtnw14vani3+hR8n4M5HRzMubeKYXld3634uIPuqrkdfqQTRUIMX5W5oXYv4r+RCm8EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pyBwHv5e; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pyBwHv5e"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f89so670582f8f.3
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 08:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790351148; x=1790955948; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mN5JkatQij/FxJORJLRXw10Zzsc9JQaUhl8s/JeRpXg=;
        b=pyBwHv5eReicu1WmUbKEx1a8ZgF+MZQQGmBLNmJRFhWFRViaeXomzVFeDA9oBy53xL
         F5F5hfrnQpjMoPYjZbjxpX1RcP8aVwrorsKQ8avBwuCRliS5fzVo8sOApEFNlSmC29cy
         jPMoc5SzNOjL8L7NWdlkC/5TazXw3JDvwq0s6UNAYlJCsPYwma2ZvAzF7qiYE9RP7vVe
         nCMF5j3zjIJbtidukshhkY8scvMwEOc91SCLiLQoYQkOd/bJ4odlEAq9XP1pr17xZC/i
         lJL5k+XbCd7R6Gwr1UHkJjJIWrT8BdXTMI5WhzQnKcfdbWkvOtYArQLIC9yH7Ym9zKgU
         I8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790351148; x=1790955948;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mN5JkatQij/FxJORJLRXw10Zzsc9JQaUhl8s/JeRpXg=;
        b=GwqrYFOOcdgXvryajbABtwgoJtxDd/aB1s1GGbKxBmuFoHIK+KbWPsV16grmtdsAhD
         gR10qjy91XopgLH4MWtv7B5RS5T18NYCBJQirisA3Iw0YsZf94YsImzuezYMa/pbDiOF
         3LeDA1xQ9OsjIRbmCDMszPtL2X3Tb+qlYkIm6IqjCaZKx8cLx/ERroShbbw1SpQkD+HO
         SRgH7N7/fuU/iCWgFt9epPiMRRya3ASMumx2KlXoAGpB4GOHg6jIs5IIgXFrKsoziUrt
         yyUeTGeXMhXCWhyHJdgNGy9JjmyF6rrDGH5aiAsuHUaFYsHxGdULgF7SQYrFo501hkoD
         XSIg==
X-Gm-Message-State: AFuF++keoYg1Dkp3lWGOOlioBpy4PYBOyuRDKuYvNhv1P7Q3kOQF92Q/
	fTA1v4Q8sdajX+qHP/sO4jTN/Ut882OmaZIXUudTthCPlR6socFuk2cY
X-Gm-Gg: AYBFou1HWTtPX7sK60pUCkZCCGy7k4xSUo4KLXVn1M8TnoetjTXDmwfNVI46+9DHp2k
	KGvVviFKVsF++B220Qv1qfp2daUwarUxQcX9xhjHNlSzSMaV4TiiVxDOb55cCgfgHWNUPax0Mpi
	CmjHZw89Zgn+BDTI4Ny3PfK7agkkbj+EN4DS3ZBcHuXgF4pSIuoKtq/bqSURo4RAhiVufJYRqvo
	RPW5X85T4oQQ0j7++uRTYhJuuLsVpKh3AiAMXasTsIwii+DKJ+QQU/IM8y/j34JfBCP4tz5jEng
	jq8bjGEA6z/e0wNYwvJZfr8IobGgrbDD/FiUy7Yf2oRitdNdqB50K+HKdpXOj5vSNSQRWneb/Wi
	bjxLQPc+WCLjBkrRrWDS1Cs2WWPF+Qrl/iJC5+4dMaXe1PLWLDs9wXrqKaz/f4QKzaRMr+OJH5u
	tGRpSTvgTrLbiqJFCLmXDOvmIq4oRtQI0wno590LvUvmnDxNX5ceRkNoI1xbK1AOJI2G9SeJtG7
	OpwmGbHRaRLEEDT7bC78fOXVprcJr3wF04HaHkx2h+AMK+VrC5v/Q==
X-Received: by 2002:a05:600c:348e:b0:49e:8191:e5cb with SMTP id 5b1f17b1804b1-49ff06b2ef6mr48910855e9.5.1790351147502;
        Fri, 25 Sep 2026 08:45:47 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a640df9sm7834143f8f.24.2026.09.25.08.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 08:45:47 -0700 (PDT)
Message-ID: <a9c44afa-583e-45ad-9447-c00144141c32@gmail.com>
Date: Fri, 25 Sep 2026 16:45:42 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/4] t: test failed "stash apply --index"
To: "D. Ben Knoble" <ben.knoble@gmail.com>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>,
 Victoria Dye <vdye@github.com>, Junio C Hamano <gitster@pobox.com>,
 Elijah Newren <newren@gmail.com>
References: <cover.1789853192.git.ben.knoble@gmail.com>
 <cover.1790168285.git.ben.knoble@gmail.com>
 <5bd4b78cace8ba8c8887c78f739bde3513dfda28.1790168285.git.ben.knoble@gmail.com>
 <232f2bf6-04d8-4a54-b4e9-51b5ee79799f@gmail.com>
 <CALnO6CDTaunaBby+Gy4B5vxiHES3DHpybv8Eq2JPvQ1cteGzrw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CALnO6CDTaunaBby+Gy4B5vxiHES3DHpybv8Eq2JPvQ1cteGzrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben

On 25/09/2026 14:36, D. Ben Knoble wrote:
> 
> So overall, I'm thinking
> 
> - (old) diff-files only shows file is changed
> - diff-files -p shows us changes for file, better (and won't show the
> other 2 files unless they've become unstaged)
> - diff-index --cached HEAD helps us check all the index changes

I think that sounds reasonable, we can delete the index lines from the 
patch output with sed to make it easier to compare them.

Thanks

Phillip

> Phew! Thanks for reading my rambling thinking aloud :)
> 

