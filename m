Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F61F26AC1
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332547; cv=none; b=c4aLvZMbP47IlxC3ZJ8e/axC9vCE2JTCm+1gw0UTzbIRINjBk+7aBlBZZTNG712fgsy2f9Mtd6Kc8IQ5sA/zMSjrzgPBN2ONumi8ULZPPLXmVAP6oyMsI47ioccojF9erGzd5DwaK8BC6xQJLNj+egmKbmdOBprg26FDE1crFnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332547; c=relaxed/simple;
	bh=+k71jZ/KSt2uVn8K3gmomR8QyYfbPZnC2n+S60Wcous=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XRIQAnqJZd7Lg+JqInNebGgSVhFFXqqheOyYyOsQKzP5p3YJ2tXb+DLWtu4Dx+UZerrDMQLU95get1v21p0DCwia281ooJfl3jYGVbJkfIKytiKA1mLEc8iS6idSEx3WYRmbUyr20VQDCSMGKOsS4ZUYLZOljzUv7xUzk+/Cn/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmyuHFdh; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmyuHFdh"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-201ed196debso7180935ad.1
        for <git@vger.kernel.org>; Thu, 22 Aug 2024 06:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724332545; x=1724937345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kfbb6RVpU8iVEsjzyom49EjZvtm8eUiE8lN32hdj0og=;
        b=SmyuHFdhGiGmsUN5S760M8YVeqCEpRDaWOOv3Q1ZOmhOJZZGf1lSGC3WG7C6b73Dp2
         f1CXMidaEaFCs/KKtonpGRYPecPtiBwcIAcpUOyFsPf4d7gD/W9Gl+DntH6sUgESYMZ3
         4BOUoOLg96iFvnzHwFLyIbyuIhY170jxNvOUoXwtQSi0dPOFxK6cLcrwxz3k4f3MWAUe
         8M3oDDfKUIHGl51lIv7W74UYqP40gN5Yge2Q3maX4Y8vmLMwlcF8i8XLnP96MHtsGpgy
         iolA7iCOJpSUV7T3ub6ZzYJ70cIzhbXv8pm1oaK6VrGFfg2wwV7a/3pOvVv/fSMXJEjn
         o9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724332545; x=1724937345;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kfbb6RVpU8iVEsjzyom49EjZvtm8eUiE8lN32hdj0og=;
        b=dABuv1nqRInEFmYExJ5dt43eujza5iaDUnE4cTol50QLJE7zVhx4KCHnqzJX5y871B
         NdIblt8i8ku1giVRRHltRB/QYx45cUPj8LDkHTviUQEyeYXrpvrwI+HQNMOQ55naAJ57
         oZ4lQ2tQSil2L/iDTW4IMZkKTgwAs9mJP2l4jd8jUce8Yc0o02KRn8h5RueifWP6QxqL
         NyWAFJYmCwTQa/ilZZitPOc7UhZcyFH7FrtLvfstBeAH1MgTXQaLclp1WYsrq3/BS8da
         DyOJjH/Z5T+bPw7LHI0sYvokBL2YlHI+YRAKOn1+MJH6xMsqEyAx0xGZqkFjIPPgFq+i
         WT/w==
X-Forwarded-Encrypted: i=1; AJvYcCUQ9exLx+57oHqNRdk2sv6if5Xuz7P2xTuY/ugIvHQXb/rPuhuDtc7NS+wmq72PmRFwmjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe1eG0cumz5xy9oy2VM3Iyr7wpYHu2KziZHq+svFADzFpo4qve
	BQxReb1+3SCAp/tKlrvqmqy3ZS5OMzWN6LRXBBDJ80IVxMwlqg/H
X-Google-Smtp-Source: AGHT+IFwoqQdUDDg2VqFV4xJPL3GjXEJZeT7sqifMp2xe2m5jo3lLjDiCntqdF3qz4dVp+/EHjWZVg==
X-Received: by 2002:a17:902:728c:b0:1fb:3474:9527 with SMTP id d9443c01a7336-20367d32671mr52951825ad.25.1724332545046;
        Thu, 22 Aug 2024 06:15:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:874:83ce:907c:8496? ([2600:1700:60ba:9810:874:83ce:907c:8496])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557e7e9sm12257175ad.69.2024.08.22.06.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 06:15:44 -0700 (PDT)
Message-ID: <e90949ed-8065-4498-9ddb-3d5c6afa7b35@gmail.com>
Date: Thu, 22 Aug 2024 09:15:42 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] [RFC] advice: refuse to output if stderr not TTY
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de, ps@pks.im,
 james@jamesliu.io, peff@peff.net, gombasgg@gmail.com
References: <pull.1776.git.1724238152.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.1776.git.1724238152.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/21/24 7:02 AM, Derrick Stolee via GitGitGadget wrote:
> Advice is supposed to be for humans, not machines. Why do we output it when
> stderr is not a terminal? Let's stop doing that.
> 
> I'm labeling this as an RFC because I believe there is some risk with this
> change. 

Thanks, all, for the feedback about the risk of making such a change. I
agree that we should not pursue this direction.

The main issues are:

  1. Some tools create a wrapper around Git and may want to supply the
     advice to the user by parsing stderr.

  2. The advice system has been on for a long time and we cannot know
     where other dependencies could be for it.

I'll abandon this RFC, but plan on the following action items:

  * Document GIT_ADVICE in Documentation/git.exe.

  * Modify Documentation/config/advice.txt to mention GIT_ADVICE and
    recommend that automated tools calling Git commands set it to zero.

  * If we have a place to recommend best practices for automation
    executing Git commands, then I would add GIT_ADVICE=0 as a
    recommendation there. I couldn't find one myself. Do we have one?

Thanks!
-Stolee

