Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0601C3024
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 18:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728931011; cv=none; b=o2u2pzk4kW72rLhvCbSYC0p/u3HpIKukgzL1bOeZHupQLiu6hD7RYMIDu9MjPZ3n47/wjz0dfr5rBexivI1icg/kFWkJW96NsjzJNiSdF9AkYS8RSVDnx0zstUnpUngiyHxXs75DMZPzL5kLU2Mi8PTr9sNtRW7sgcfT6LuY+DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728931011; c=relaxed/simple;
	bh=uOvvQjx+fEQC6n+Vt9nmcnld/RGn9xSEOYzrTho1I2g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FmGk1HZyWzda2ej9NpdrddSV7rfZe7f8MsmZkdiA6Varzm2JmjgaZ+BJwcZqCFe6WIOL47nNhbtLR3TavlZmEIGKXru+5zbT27ikl5Yr+wBQy3OguiGwWhHiET+NvAFGi+SzmYiHnHY1JNXRaz78LJhBPh6YVs7dxTqJ4jqfUkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQWYdJQD; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQWYdJQD"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d4c482844so2595710f8f.0
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 11:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728931008; x=1729535808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L0HLFzmGq/abyyLF0gArAqCKLwGzwTw4vND0RiaCU7w=;
        b=IQWYdJQD3D4ISXGAlAlvT9GNXQYeT/lGogz57soJm+n3iqwlzBKe6Mu67ngxKbu+qS
         he+hILvi67hYrI+n01JBu/2LyALbbupPLWvEPOVlfRmbW3gf3GzPt+aqkNUpq6LVzrTG
         hm8ocs6+PFGwt87X2he0C9LDWGj1EwTFfkLmortnaeQ82bmvbfzGSNn2T8ovbQ05HJgT
         GM9Ckw+x1BgPW41aVBhi6qzl01Nvr7MgVq67XCsxGiVBp28EeHV8IItKNRIxPRjeyk6Z
         w2KFBSHQMEeQmAhHN6g22V5bY0cL2j65zunBL4g6f1fggxpGgGW5jtUlxQOpIbOWjIxz
         HRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728931008; x=1729535808;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L0HLFzmGq/abyyLF0gArAqCKLwGzwTw4vND0RiaCU7w=;
        b=ZUrKU/nWHT13y2p6U9XA6blOTwNzqX5ZieCf7VdtVi7iLQhhVXtxcMd0B6tfDongWX
         fIBzqxDC4cMTH8lDQltkZ4kfif5GMTg6F+MRIYpbbUdN/xpA9A2L5mlx+qm0YHs8UIoK
         Dc4T6YV5GaygqPg9pXVnRi7SDClelPFQdJrm7PGhb7hJmYtypq6QWT7WVfgKV/MF7xwp
         kYw7mqrzX+T25QnOt2y13q9N2NMnDwUyWKdAOP9iSnbUgjuQnEfYYr8ey0Rp1wIGYk0i
         shsDm0NFMFAxEvN7iXeF+VPSeTMNEZEnwBjvRKQclyAfQUSGnenvaHaW2g1Fw7xMO+fD
         iQGA==
X-Forwarded-Encrypted: i=1; AJvYcCXA09IsJo2uqStj1NhUJjXtCVzlTK0N/rV+b53D0swxJP7VOlMYvnFyZFxwVsJ73fMxQnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIUNE7uXxEVHOEHO/FONVmU90H6zwzWe6LM+NNfE18wowpDmLT
	TRerBastvTzGiHdnypjF4Yqx2Whm2hBuqFWXS8AxtuYnV/JWuvDH
X-Google-Smtp-Source: AGHT+IGh5ID5x2sfCEWhxCxmfRPZv2VoU36f2Jc3GPb3IAq0vJJFHfHGf/LrK85oWscWnpI+hgEixQ==
X-Received: by 2002:adf:e90f:0:b0:37d:50f8:a801 with SMTP id ffacd0b85a97d-37d5531323bmr8478408f8f.47.1728931008045;
        Mon, 14 Oct 2024 11:36:48 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a? ([2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6d7a72sm12113586f8f.64.2024.10.14.11.36.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 11:36:47 -0700 (PDT)
Message-ID: <84dbe9f1-976d-45f8-a49a-d0f942906686@gmail.com>
Date: Mon, 14 Oct 2024 19:36:46 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] parse: replace atoi() with strtoul_ui() and
 strtol_i()
To: Usman Akinyemi <usmanakinyemi202@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>,
 Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <c93bc2d81ffb33a2a61dda2878fa3b9987545e0b.1728774574.git.gitgitgadget@gmail.com>
 <CAPSxiM-V1qOB9QXUY3aDh+_nGdDHBWXJZ54U9p_XxKfHoODu7A@mail.gmail.com>
 <Zwz4B4osJnYJw6pd@pks.im> <2a937b6f-a3fb-4f2a-997b-5508f0e20e65@gmail.com>
 <Zw0kGLZ-mcYjb6Je@pks.im> <2160f8ea-5f00-49d9-8e02-d71d4d827d39@gmail.com>
 <CAPSxiM9ncwaZ3HF72wsRwmen7joWk3mjipsu78WxKEzLX607sw@mail.gmail.com>
 <CAPSxiM-aptyjesMX1H-P5QJjA-6CUonA01Bo84cq2_t==TqFgw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAPSxiM-aptyjesMX1H-P5QJjA-6CUonA01Bo84cq2_t==TqFgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/10/2024 17:26, Usman Akinyemi wrote:
> On Mon, Oct 14, 2024 at 4:13 PM Usman Akinyemi
>> On Mon, Oct 14, 2024 at 2:55 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> I got this from a leftoverbit which the main issue was reported as
>> bug. https://public-inbox.org/git/CAC4O8c-nuOTS=a0sVp1603KaM2bZjs+yNZzdAaa5CGTNGFE7hQ@mail.gmail.com/
>> For the test, I should have the test as another patch right ?

In general you should add tests in the same commit as the code changes 
that they test. In this instance I think you want to split this patch 
into three, one patch for git-daemon, one for imap-send and one for the 
merge marker config changes. Each patch should have a commit message 
explaining the changes and whether they change the behavior of the code 
(for example rejecting non-numbers) and add some tests. Note that I 
don't think it is possible to test the imap-send changes but the other 
two should be easy enough. The tests should be added to one of the 
existing test files that are testing the code being changed.

>> Thanks.
> Also, do I need to add the reference which mentions the leftoverbit in
> the commit message?

I'm not sure that's necessary so long as you explain the reason for the 
changes in the commit message.


Best Wishes

Phillip


