Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAE3231CBF
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 19:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070038; cv=none; b=ccHbBxvzSzcW9hQxFGwPwQs/cb2CCrO2XbiBuv0FOV3Z4L0cTgda3rFfrK5IXzh3Lt8+4b8A1R38YjYfYETj8QqSWvxHWRMuaDUKWpbgED5NLlfTpPlfL25gQ5GMNw2hprgPQXl2xL9raoS0FE3Fqqq0zl9+iA0nDtLsRhqaszk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070038; c=relaxed/simple;
	bh=qqazs2Cr1HIYnMvRCRuBUYSD8iKCn2y5JZWjS2R8S84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zx2cmgl/KHeVCH6rFzBGu3KsjAQ8RaQCBBHgdfSwmyFXjjnoO5xRQR0vofUzyaRrw2G3PCGr2GWduu7pM6NCejQ4MB8ayfy+bzGYHYthO5iMMkMFCV2NicBFS1vvUCNQKd7vDGFLa71Wq7qCID92MuG/KCbmDBbcGFtLKw5Qkss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiNulqaJ; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiNulqaJ"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e129c01b3bso23204717b3.0
        for <git@vger.kernel.org>; Fri, 04 Oct 2024 12:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728070036; x=1728674836; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sef9S2wGf1yugGGbhFLROzZEAiVejEay2X+ZFYDeHTg=;
        b=eiNulqaJs/5QLqpaOFNzaMCeJLHMF6COOL+A4QZMwim5x0XjvSffrwl1aDUqRjL4IK
         2g2Lk6D4qTA4KPL9FSeXahqwgnt4y1/Gf0XMIhY4IGg4uszys/jDIzDWiYtbFWRAzsfG
         B7DSBQpiwiQmWOt9i5GxOWY0LJtl3qa8yr3fMav/bqaaxCXtIfPgx6PZlwphSyUWJ0i6
         uxZ4Qfs4+IvhLpqVkc49nnPBplC63BVHPIYML5f9ySRnhfogBwXWx/yrs4q3mhY7GTiz
         35JSgl2jjwaTr69CMTUFHJS2lvlnxe3piUvfyxc9bIuJMFbfkyLGbrKZGf1JY1JGUSMl
         Q02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728070036; x=1728674836;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sef9S2wGf1yugGGbhFLROzZEAiVejEay2X+ZFYDeHTg=;
        b=D3pICcHfS9u0AB6MePnV5vuiNeP5enCmgaUwM7iswlm1RoFaW22RsxMgJqgSUHZfCZ
         BbvBj1ENASRBd8CiO+sNs08BZ9yvzYRLupuL3SlXEipCMce0sG1CwSF+c20iasIF5dW1
         3F9HIHHt4jVb3o0ixdanNIWwjEZMFRwq+/8QOd/9tqrmt/COZ5zO68zZudbzSvyBT5kB
         vTgae6SMZv2YEVWymy5VSTg2tKxdapG0qFcbgwwyjPD8cVd0DvojUUcl0K6VrMIUNQX/
         Ru4KUmlQCkfXmWOFCrOC6t9VgdfF2uWropqD8NvKe6rffrHuKXhmGPgXBKoMUuIr0gZU
         e3NA==
X-Gm-Message-State: AOJu0YxSjA7UUG/9q9Iso60j7Pq/Rr/kCiutRuvr7Fi4MQvTv1uEpmOk
	jbGtunMnjJmvFPvS6X2fxYnUAP5fFE3d9Xxqhf6vnSqasKIfjPP1
X-Google-Smtp-Source: AGHT+IFBJFH608SOUrF4wuegEkyOFCorhJQ6T7VaoDqH/2WOk9ESSm2OXb1CfANuinJ9LMiS91TR3g==
X-Received: by 2002:a05:690c:60c1:b0:6e2:2c72:3aad with SMTP id 00721157ae682-6e2c7298c6cmr48403647b3.39.1728070035717;
        Fri, 04 Oct 2024 12:27:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:2979:6e53:aebc:1a02? ([2600:1700:60ba:9810:2979:6e53:aebc:1a02])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d9377b21sm594287b3.41.2024.10.04.12.27.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 12:27:15 -0700 (PDT)
Message-ID: <e38449d8-190a-49af-85b6-a628e14379d6@gmail.com>
Date: Fri, 4 Oct 2024 15:27:14 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] diff output_prefix cleanups
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im
References: <pull.1806.git.1727885224966.gitgitgadget@gmail.com>
 <pull.1806.v2.git.1727956724.gitgitgadget@gmail.com>
 <20241003210548.GB11180@coredump.intra.peff.net>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20241003210548.GB11180@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/24 5:05 PM, Jeff King wrote:
> On Thu, Oct 03, 2024 at 11:58:41AM +0000, Derrick Stolee via GitGitGadget wrote:

>> Note to the maintainer: feel free to take only the first patch, as Peff
>> replied that he may work on the remaining cleanup independently (but I had
>> already prepared patches 2 & 3).
> 
> Oh, I wasn't expecting you to go to that trouble, and had already
> polished them up myself. :)

It's perfectly fine that we were attempting to save each other work.

> So certainly your patch 1 looks good to me now. Here's what I would
> put on top (but I would suggest making it a separate branch, since yours
> is a fairly urgent fix and mine is all cleanup).

I approve of this plan. Please only consider my first patch and drop
the others.

Thanks,
-Stolee
