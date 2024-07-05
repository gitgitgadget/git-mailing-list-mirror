Received: from mx0a-00256a01.pphosted.com (mx0a-00256a01.pphosted.com [148.163.150.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F311487D8
	for <git@vger.kernel.org>; Fri,  5 Jul 2024 14:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.150.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720189729; cv=none; b=kfr/ayP24avUg5f9+2MAJnlkVMLU542xtrBXcdFFxWnxso7B4eD4FiSSo4lMYYCuT1Q1XbytI9PVPet7l/sKSzK/FZpt7uF7XAMnXvsT0LNooH31tR2NL1w3zuoj+B+YR6cEZNsurbfjK76DM6Alr3QDdM0GVCeRm3tQfhpBu8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720189729; c=relaxed/simple;
	bh=Y4YS5ugg+E8l5hKCL29WhUqMUmMLxDWQvdxlJgv0uBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rJ3a6DES1laCVxzIort7FgTiuRk8w7OSjTgwRcV7PkTfmJU8y4F8ZTbQz+MQ06lhaa4KENS5uJ80CFOM75ot6DaWmQ7qMNH2S4wCfZ4K4tf9QOf1yp+OlLWMV1Y5fSbABVwajbWNSOeyoiv2lYk0hfjNijoqwk/rIt84uhEDVzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nyu.edu; spf=pass smtp.mailfrom=nyu.edu; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=Dlq4c4io; arc=none smtp.client-ip=148.163.150.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="Dlq4c4io"
Received: from pps.filterd (m0355795.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465D1wAb004772
	for <git@vger.kernel.org>; Fri, 5 Jul 2024 10:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=20180315; bh=t
	NPwI9gtPi+s3K5sgWB6AvdLyelOMoWNHR3voR5eirg=; b=Dlq4c4io3PfMxEa+L
	zBjgWpnOfVaX8ZlKLJWFixLs1+RmlphoPfMqVLCW0PIQ8YYkaBD4zsUmEwp2HZ33
	jr7kY40g8DCxChrzQ4AFJGHtDqVltOx+FEWpdHq1GAIzSkrVU5ikRA9f78VvGIOu
	NIbSiK37bNvP99bnQgxiTv8+31zPt583E6rsNkW5pHtl8g1QuBfyRu7TrmfubUsC
	bHfGq/r339W+kYfDTNkwVrSZtVDjZCxjSo+sFgxHagEXneLJ03ZagnUUBbVvs9Lx
	Q8wiOdxyhN8vBulcsKCarDCV3wwbWrAaUKwet1tRNdzNxb3jWRc1f4wpGUtAHLpk
	szXOQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4057pn3039-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Fri, 05 Jul 2024 10:12:19 -0400 (EDT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b5f61c0cc1so10989226d6.2
        for <git@vger.kernel.org>; Fri, 05 Jul 2024 07:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720188738; x=1720793538;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tNPwI9gtPi+s3K5sgWB6AvdLyelOMoWNHR3voR5eirg=;
        b=EgdYgtbBKXQJpw59JZYEpNAZMFidoS1bjvRK2DOB+CT+llB+JmHbysbVpOMiJJF1hh
         DMFnHcAgTFV/+8dVqWBumEH9c4VrK7mY4D4HRJEmpMKwXd3eLlD1pGmOYh11swHVsxw8
         cedSfHjG198qO1f6l3qEf4dFApA/GHqf8ibACB1slbYMem1HGeI0FljGixCNDa6v3uIY
         IzpJeQs6V/Mr+/M/W849Kxvcs5EiPxCisyS0ejMGLAReZ80BAgOBDaypqVNhtb0qEhQE
         uN4QMhZXhNye4tr+EGIyGDajiRpCAgV940gNzytO9eOciSAWEKbdhBId83d7DRGLeNBj
         YZhQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7r02YbPnXHwF1FYM1LvfU/gFivJPneRZpZwnWynDqTJQonEA+dwx4zcdYnUEhrfSI/LJZl/dsbDYiKg9RENDfjrST
X-Gm-Message-State: AOJu0YyKm7tu9B5wBnPUHSs54lAageGdKOUIaXQ9vVvnc39fC8B4gqlP
	jUj3mnl8prKxm0ZMSXZ4NliiC1qlHp2TAZesfgdkUXZubOWXnQejuNsZ9+YQ/tBFHt/PM50nq7x
	iiw/rhZhLeCQY521MgOVA75PxDsi6KERZJwQnDsJSCOuwx1k=
X-Received: by 2002:a05:6214:c23:b0:6b5:4125:415d with SMTP id 6a1803df08f44-6b5ecf8ef48mr47265756d6.13.1720188738335;
        Fri, 05 Jul 2024 07:12:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVE2E7QWooOx9166YBEfXsdVDgdpqKEiySxIoUtoXsfrtgelACyLoVaCNN3j0b1IL1Xhjn5g==
X-Received: by 2002:a05:6214:c23:b0:6b5:4125:415d with SMTP id 6a1803df08f44-6b5ecf8ef48mr47265586d6.13.1720188738004;
        Fri, 05 Jul 2024 07:12:18 -0700 (PDT)
Received: from [192.168.0.114] ([162.84.196.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e5642fesm73522496d6.40.2024.07.05.07.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 07:12:17 -0700 (PDT)
Message-ID: <7e506cb4-b47b-44ac-9e08-ff783f18e5dd@nyu.edu>
Date: Fri, 5 Jul 2024 10:12:16 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] Git Merge 2024, September 19-20, 2024, Berlin
To: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc: Scott Chacon <schacon@gmail.com>
References: <Zj0JyL1b+g1G3zWx@nand.local>
Content-Language: en-US
From: Aditya Sirish A Yelgundhalli <aditya.sirish@nyu.edu>
In-Reply-To: <Zj0JyL1b+g1G3zWx@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Er-36IDeoh5XPmo-KHzGsCxjjU6SNF-v
X-Proofpoint-GUID: Er-36IDeoh5XPmo-KHzGsCxjjU6SNF-v
X-Orig-IP: 209.85.219.70
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407050102

On 5/9/24 1:37 PM, Taylor Blau wrote:
> Git Merge 2024 is happening in-person on September 19th and 20th in
> Berlin!
> 
> GitButler and GitHub are co-hosting the event, which will take place
> over two days in Berlin and allow developers and community members to
> get together and talk about the future of Git.
> 
> Here are the details for the main conference:
> 
>    When: September 19th and 20th
>    Where: Location TBD (in Berlin, Germany)
>    What: Talks on the 19th, birds of a feather discussions on the 20th.
> 
> This email is just to announce the date so people can start planning for
> the main conference and BOF discussions.
> 
> Registration for the event is still being set up, but it should
> hopefully be live in the next short while. I'll reply to this email when
> I have some more details.
> 
> In the meantime, the CFP site is up and running. If you have any
> interest in giving a talk, please consider submitting a proposal here:
> 
>    https://bit.ly/git-merge-2024-cfp
> 
> If you'd like to come but need financial assistance with travel costs,
> please reach out to the Git PLC at <git@sfconservancy.org>. We'll
> collect requests and try to make decisions and notify people by
> mid-August, which would hopefully still leave time for making travel
> arrangements.
> 
> Other than that, please be thinking about (and feel free to discuss in
> this thread) topics you'd like to discuss, or any general thoughts on
> the format, venue setup, etc.
> 
> Thanks,
> Scott Chacon (GitButler)
> Taylor Blau (GitHub)
> 
Hey!

A co-speaker and I submitted a talk, looking forward to hearing back and 
attending! :D

I was curious: is there any clarity on the timeline for when the CFP 
will close and the accepted talks are released? I need to apply for a 
visa in order to attend, and having a conference program, etc. would be 
very helpful!

Thanks,
Aditya
