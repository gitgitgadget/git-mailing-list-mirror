Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FFF20513A
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 09:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729070415; cv=none; b=gVnidZ7TcfJz1tdiA+sbwugrU84A0B1ITVovgGiAeLsrj+nCEf6EKGNjguf8NNnC/k4sSzln+P5kr2vmR/fU+wBGeZYA8PGlHgX72MX9n2jbQDSlU0+/X3h1hzr+sqjey8wQFBib9CjdPT8Xb3mKMof9N4Ukuv9QiDHRBg0fCww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729070415; c=relaxed/simple;
	bh=RT3UWskzIDzYenMrlXMjLEzixCvmGraBST40DfixfvE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ornHR6td0drqfTFgHAvGffCwWtZpNpQtUiEeZtCBzAg2kVyEyGLpTQkPGQgwxo1fG5/SjO4qsr3myB2sjf8qBm88aaaYp6hoFver80WpjOHXpGN29g18zwPYZDBks8TGYCWUimV9xLMVhCQpQMcur/pCE2YbNfjm3ugCApU935A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=On+X5T6/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="On+X5T6/"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-431195c3538so45025075e9.3
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 02:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729070413; x=1729675213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cvfZMB6NS6hH6eO3UaL2K7ECyRhSjHXG6PTlJ5dmdXU=;
        b=On+X5T6/qyPJiwGNcIMViERZ1/lnk8gIG1ULtdXtthn5dpcvo6fg84ZjKXwx4PcumU
         Yb3NLPlpxAls+VTESh055Klo3zlxweK4/3hsrXO5qxozsAz9uoCqMN0/Q37cP6p+fhDe
         giPjS6yvslV98qGR6KVjvXO7vJmqKlgZCr6Ln2J78vdiPwDMw7zRjCj1z5dqSfG1WUhv
         EfFgAKrPcuyK1062+QWuBPlZgNRV5dl/9yoLHupnwaOb8TfJ2m3d0gqo8AZqEoN6A7sB
         7WdI6mdTb7XS7PIvZXOavdLuABol6apmd+Zuy8WjlgoIwkkFsO5cnC5+fOvUArna1aHW
         nypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729070413; x=1729675213;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cvfZMB6NS6hH6eO3UaL2K7ECyRhSjHXG6PTlJ5dmdXU=;
        b=P7Otu7G/d5fDPDOZMdI9FxMSZbFFwgDVFp3t/gGiHcs6sKS9xmldkZ/7B/WhH0pB/t
         aGlNZRA2j9TIhZz/GfQn/ZAdRjOerBcGbMu4vp7K18bIfG8qlIT786yTBL4IJ/PJPQau
         pgB1aN//u+tXL+JREJYJJ64XhhO+7p3qWSuT4bClaAiLWNFooQFTCNBjwYhEGcO2aKe0
         ItbT92nmW92lre4BEJTgCqPXW5qkLelfLIKrq3Sr/uARMNEAAmav7ceY+0xa33lXSfz7
         6a574xuFe934qzuvmrBV35ZY+g33SWrXmsV4xq58nDIYAIphXX7NAMJMfZyVpTOYg/d+
         XgGA==
X-Forwarded-Encrypted: i=1; AJvYcCVuyn205ggXElXjcdaudYdvECZbKaUHSJPqpPtsBU/HdJYD0zVsr76qi0/xXkI7tnoTMCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiiguxLrGFwP5H6Z0ciPJbrx0vdHJo33XAQ4UJxNCjGLc2Y/hO
	CllqlS3Z1plK2HaZ7yW1VD9jHm6yDqKjt76xjGmrIf8DV5xudXRe
X-Google-Smtp-Source: AGHT+IH0DDawc8WE1/8BJdMpRz9pr3hg0Z68x05udxuGm/xK+FmvvzBnc6cc/kfOWBP4RbpxDEf6mA==
X-Received: by 2002:a05:600c:4688:b0:42f:80f4:ab31 with SMTP id 5b1f17b1804b1-4314a2ff46amr25412435e9.18.1729070412438;
        Wed, 16 Oct 2024 02:20:12 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a? ([2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa92741sm3816419f8f.60.2024.10.16.02.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 02:20:11 -0700 (PDT)
Message-ID: <87090897-7ff9-4396-b81c-0fc423593602@gmail.com>
Date: Wed, 16 Oct 2024 10:20:11 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] parse: replace atoi() with strtoul_ui() and
 strtol_i()
From: Phillip Wood <phillip.wood123@gmail.com>
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
 <84dbe9f1-976d-45f8-a49a-d0f942906686@gmail.com>
 <CAPSxiM8-C6DAE3nYqMUCs+UgHN1R41grwVE+S-cSi6gZGvCpYw@mail.gmail.com>
 <9952b3a7-0ebc-4555-b8b3-f50f6f383704@gmail.com>
Content-Language: en-US
In-Reply-To: <9952b3a7-0ebc-4555-b8b3-f50f6f383704@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/10/2024 19:28, phillip.wood123@gmail.com wrote:
> On 15/10/2024 16:17, Usman Akinyemi wrote:
>> 
>> I grepped the error message and I noticed that the message is gotten
>> from parse-options.c and it ensures that the arg is negative. How to
>> proceed in such a case ?
> 
> The code you're changing parses the conflict-marker-size attribute so 
> you need to set up a .gitattributes file with an invalid marker size and 
> then run "git merge" or "git cherry-pick"

t/t6406-merge-attr.sh would be a good place to add this test

Best Wishes

Phillip

