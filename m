Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362D7125AC
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 14:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559596; cv=none; b=VB8G6Ln5zr/4QZXeMsPMzUYJWs0ZZUjG2mAplGOAcVd+nLFlKjYj4STYgOvYjOpToH6QLJJZ6Ry/uTvB8JL28GukvV9tQL2db7Hzh2FCpKLH4j3tRBepH7dUAXg0lq3yzfBVnUwDfLC9PMfiC8NCofoYZ7x5IN66pLe+pAytD4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559596; c=relaxed/simple;
	bh=USOky9N//oVLxpj34YLSZ/r8quL6mrsoWc4KFevgGAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j+vm6XA1ULp1qP8NREq4cHrJnoSEbX4+6N/A2exnta03B3kBX7E8JUS4+21QHp70oDzIqvuDv7SQ2x9qvokTC6k3PWVVoJTA5BWPQ/XKpif3z508QxJ1tO46ZuSOEOODG8ipMULrN9W6tiHA0Bkj2CrUNtMd0ubgbNLuIKI5DQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6QWDoAv; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6QWDoAv"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52efd8807aaso7365697e87.3
        for <git@vger.kernel.org>; Tue, 13 Aug 2024 07:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723559593; x=1724164393; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3EP7VOZcXsTb04C+qU5LDhWVbRMNw2Ps32++kJTHDxM=;
        b=b6QWDoAvdeCllIMZwalNeWQfgYDwj1nBCDSZgj8re5wfHXycf+YNeOaSiFzRrR2FlH
         gbYA4v4HlssnGNJ9v8xaH74p3fBpdz6X6PkvX48n1NynXnzn8I2kAh067dRKYXMhBqJe
         jzxmYSTSNwhj9vVtJWEy5l+KkZdK5CPySijMqa/ZqlrZhbauSGTpxWMttoGcHwV0tHhq
         39v3FaPQZMSu+bpbxlOWADmQa15KtyF1sSGGJGfbPBuQ2nZzDqS1yGwVUyVm4j5k+f9M
         tGMJu2c1YdRFqssH9jdx156b7bpRG2EtYQR8lnekL/G272miC7uWLXIzoH51lbhlvC9X
         NKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723559593; x=1724164393;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3EP7VOZcXsTb04C+qU5LDhWVbRMNw2Ps32++kJTHDxM=;
        b=SnoyqfptOuwCMD499wxw9nH6JVqagFGA8A+bbeotinzUF0F9bwSu9UrePT/WxEn21v
         17NWDCFZ1USHuqPDIzAfKkEZM+BriP7aKwDVqAZ8DwXvsiKdiKZZy00AIhB2SRpyxRBj
         ZffQ2Y77dakK1VpEu/3UPdgZ4p++FWm5aqq9OW+Mrt75l5+3trz1PXQb8/n94UXonPxm
         73iIJgqR+diIdU4T9UCQltVLQMfYRRp9a2l9DLsXkAj2lFDZuP8LnaBiBDWAzN6QRyHO
         dWAz3iUzLq26A9zWr4DjSvChfehQXAkW3NMWxtUjvi2FFeHHxD+7rzDqIlIYemixR1SN
         OF+w==
X-Forwarded-Encrypted: i=1; AJvYcCWGMuy5H2vzhcULZIjR19DcWoHI3D6OmQzjnIc8q18v9We2HxSZfXyyHAcTy6eHjVDZmY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKIuV+LD3HD8n19rZSa2rFzkRurdpZ6gtPtpDwY370+Fc7s87i
	nbCdZRWvaWY8ACXaMA635GTt6KZjJB2i1YW4POqb7zJVB/+pNTM9YXdE9JO5K5U88g==
X-Google-Smtp-Source: AGHT+IGUKDy9NaO6alyAJyq+3lTHiV/YQNQkG1lKSsJXcdr7Hgk26N2uxNDGawqEQmASJVcwFVfU1Q==
X-Received: by 2002:a05:6512:ac8:b0:52f:cbce:b9b7 with SMTP id 2adb3069b0e04-532135ae559mr2660038e87.0.1723559592713;
        Tue, 13 Aug 2024 07:33:12 -0700 (PDT)
Received: from [192.168.1.6] ([154.182.137.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c74a855sm229136705e9.25.2024.08.13.07.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 07:33:12 -0700 (PDT)
Message-ID: <99a7a1c9-3b37-4192-a06a-2f148e3b62d5@gmail.com>
Date: Tue, 13 Aug 2024 17:33:09 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BNewcomer=5D_Introducing_myself_and_expressing_in?=
 =?UTF-8?Q?terest_in_=60Implement_support_for_reftables_in_=E2=80=9Cdumb?=
 =?UTF-8?Q?=E2=80=9D_HTTP_transport=60_project?=
To: karthik nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im
References: <31efb040-57cd-46a7-80f1-62a9ce9efb52@gmail.com>
 <CAOLa=ZTCpetjY=kU9eQxq-LXkxe==Yr=rsNQRmPLHLPsnO5KEg@mail.gmail.com>
Content-Language: en-US
From: AbdAlRahman Gad <abdobngad@gmail.com>
In-Reply-To: <CAOLa=ZTCpetjY=kU9eQxq-LXkxe==Yr=rsNQRmPLHLPsnO5KEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/13/24 3:56 PM, karthik nayak wrote:
> AbdAlRahman Gad <abdobngad@gmail.com> writes:
> 
> Hello,
> 
>> Hi,
>>
>> My name is AbdAlRahman, I'm a senior computer science student.
>> I'm interested in working on the `Implement support for reftables in
>> “dumb” HTTP transport` project with the help of a mentor, I'm aware that
>> the project is not being worked on in GSOC but I was wondering if the
>> project is still not taken in general, and whether I can work on it
>> outside of GSOC?
>>
> 
> I think Patrick already responded. Just adding my response too. This was
> my first time mentoring and as such, I'll probably stick to the GSoC
> schedule as that helps me plan out my time better.
> 
> If you do pickup the project sooner, I'd be happy to review the patches
> as I can but cannot promise the dedication that having a mentor would
> provide.
> 
> Wishing you the best :)

Thank you very much! I'll do my best.
