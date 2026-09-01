Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6E430E85B
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 13:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788270171; cv=none; b=I2Zg8xvUZ5F3vcleEZnA4h5z/YJuWOscHtWfUeyax6ShKtgjW93QihyNDvh3uJbLaz6vpnh15J3pWgeM3sLe6ThV3/lSLK19eBziiBSN9v22CwIoa4Akyw2ivSF4eVRnrdvqAowBFYMng4rkPjzQxIvdZIEA0d+62YZWG6NHTTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788270171; c=relaxed/simple;
	bh=ro5Icq2qngwxrJu2mLJNS0RioBT86kQbvbpgZ17kHu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UMPCbaiwZrtH2KieqYQcmghhHfZPrCYwqZGbeyj8uioSGQ6OwybaslrJyW/xNG0CN9LP8ruozvJHcTx9FFQk+e/6wdg3qA8C6xQdG+hi62LiSDMVtPwcygfRaRIt4GHpnA6BLbeJTNu8/fAHRidqF+dgUxWFE6DgiWX0TlQ2rNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cyjFxtjl; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyjFxtjl"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93906e8a5feso482148285a.1
        for <git@vger.kernel.org>; Tue, 01 Sep 2026 06:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788270169; x=1788874969; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+1vFXQuOizqBvZNp9IStxNYJrbprix7EA8WQB9jTJrk=;
        b=cyjFxtjlE5pU3tiZgG8p2vMpCDNnvUD9s8Dn0iWet1MngU19qQxThWqav4XZTHKWuZ
         UrvNEeNUHxPQwOKi8jhkU7+GTeP2hdJc0d+KasvrHq2JHUubF0BJvEMvZ7WobCCbGWdY
         Gq8rN3DZpxAfz+ZS+iows1xbx5NpwId3np/W4LUfRqd/TfT0WEvsta7m8yR/h0cxL+8N
         buhk5Riis8Z6Brawm8YwdmMfvc80vUIKLVSAcYRe2ew0WXm2q3dtFHOICNZ3LwXJCyCb
         DGnnKQxo1Mzle3BRAEIv7GFwhatUSNwdnA5b/yXuBiaYLauYmubtZ6XYyrjZkatRYdeI
         gBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788270169; x=1788874969;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+1vFXQuOizqBvZNp9IStxNYJrbprix7EA8WQB9jTJrk=;
        b=FMXwGEeUY170/lLSa6hlVFT6MwlP+Z2igeRb5/hYxX6FJgTPZyTc1PTTuI/J3EmBLv
         ZtYuYQv7CtVKBLDrIQxMlsDdknp0VQP5edLAJfrY5Ujyo3yRaWBZHqnhYr5PX5D/R4s4
         Bs4gCp8x/5bmSJDCIhe6pMsILATCYsaRVLZ+939k166mK3YQhK2J1GwYjMcgCdnh4CE9
         /6ybKc8Ui3NBSvpRimy5jf08aI0TrEBOfhaVQRMOWaz3AnEyGgpodsqIw5gXoo8jv6Vh
         jKw/nCgYC+I4HDcQ8V95n3O+ww3M3fojfP1ZPJO2X0PUDjDzzBAU2cCD6e77qmBssccG
         /FbA==
X-Forwarded-Encrypted: i=1; AHgh+Rqrj8boGstaRLBMJlLXJOD91oGtaFxGIjUipdDFkxdQ0ZOPmq0/MsYA98Ncl4J+7OCU/Fc=@vger.kernel.org
X-Gm-Message-State: AFuF++mawGrY20jWpRH4X+ijJG8+Z+kGwuaFiHamRIoRcy0p57fBBZCt
	R9ph9xcZUUZ1OG8utL4FnFDk+G1/gpKPfLJSaWYglcwBE2qZXErV7dbV
X-Gm-Gg: AR+sD12FL1AyYGNYG1vZ+EowvmPiJa9pywmDE95+SPpYnR9Hr7uYZky+CSNfSApYi0u
	xMBpKn0nqRP4kjlSTZyNqEyMDGX2g6mmksXfpl/A4GUy4Iy6r4i8bj6+zLvBsPO1mJQCspKrrhg
	oksMU1C0j3DS7BmbHyxZ4T7XHQ/74vyVKXDWei1fDA+B26VnMm79hIAtm3Mj7GWw0fn07qTwR4a
	xlhZ9Wp0SPkSwvZAhd9T/FdevampCafYHnUNOsmA9FH6lkW5gGDHw/umfn43ISr7Qi8AyhVuerI
	aas9CGh8DnleE3LxuEJNKKehVXen/o6+M8VariWCaB3rhw5k6nkNNh4K9QzLuxhaQu3Cqmj68Q/
	mC19noxLqSzkFoKMSN7DTlHfFipZeW1BV+rRsV+gJHYlugq/dK7aHvQrSlKBPFWf9DbP6tZgtj5
	3JE6XaY23IfovWlXRa+W+3sNCgqCqvilFkGdQnf4IzFz9bSxySf6nnFqALXC2LBCItwt7Q4iHmQ
	eKrHDAw0ddGhGhc6CiF3zS3ODgkcxUIR9QJYbt8AyTfRoJd3sdvPGNuDb35Dz6ot9CWT/YLMf0Q
	8p3bzvI+Z9ItpEQ=
X-Received: by 2002:a05:620a:6cc5:b0:937:6c0a:9b65 with SMTP id af79cd13be357-93913783d56mr3646306985a.7.1788270169067;
        Tue, 01 Sep 2026 06:42:49 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939173da67dsm1025065985a.34.2026.09.01.06.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 06:42:48 -0700 (PDT)
Message-ID: <c2c2d78a-52da-4814-9d05-ac757b164817@gmail.com>
Date: Tue, 1 Sep 2026 09:42:46 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] trace2: stop allowing die()
To: Jeff King <peff@peff.net>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, gitster@pobox.com, Taylor Blau <ttaylorr@openai.com>
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
 <pull.2178.v2.git.1787684181.gitgitgadget@gmail.com>
 <20260827052318.GC176544@coredump.intra.peff.net>
 <a41bdb3b-1fe7-4c1e-9d16-72390d93503b@gmail.com>
 <20260901050129.GB1075462@coredump.intra.peff.net>
 <20260901050311.GA1077240@coredump.intra.peff.net>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260901050311.GA1077240@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/2026 1:03 AM, Jeff King wrote:
> On Tue, Sep 01, 2026 at 01:01:30AM -0400, Jeff King wrote:
> 
>>> I don't have much knowledge of CodeQL, but the following vibe-coded
>>> .ql script is able to detect these transitive calls and demonstrate
>>> the issue:
>>
>> Yeah, I think the whack-a-mole can be solved with static analysis that
>> actually understands the complete (possible) call tree. And then you
>> wouldn't even really need your banned-die.h, because you'd have the real
>> thing.
> 
> Just to be clear, I am not opposed to banned-die.h in the meantime if it
> is helpful to your goals. The whack-a-mole is not something I would
> choose to spend time on, but you are welcome to. ;)
It's helpful in the sense that it demonstrates progress during the
refactor, but it's less helpful as a long-term protection. Which you
point out quite well.

I could easily send a v4 that removes patch 1 and all references to
banned-die.h with a focus on "die() less in trace2" to start this
reduction, but with the knowledge that it isn't sufficient, yet.

Thanks,
-Stolee

