Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A76340DAD
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795553; cv=none; b=CEjKR7LD2b0BeN1neJ9AzaT7jB79tlOgPmsYDwrIT9QYHmIC7asjbYKegYdwaSJ4A7BLa+v+n8G+owSZTKp49YWxz8DZjXvBvCvqGVDb5libtkue/NMtxb5YNGpiSbiLODUc0NEpa0t5Y+QJN70i9ExTsNFtBtfKP4D15yX+Fyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795553; c=relaxed/simple;
	bh=B19hqTIXTT28Nbcy5+1j2aZBg7HR3lJiqq9r1cANA9M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iJNZeapScvNUH+kLnXi7ndDrMm5WGWnk40TkfTuFAMd9NnRx2b1lrdmxYXnVoM5v6HF4O6OAiR4AKwgeUiVuYlzqZ7Wj5cAOKdNZRq1Ps8bciFtLjm8C19R9Ot432HCCUAZA1xdYaNKdUF3xDXmHF7GNO/XCGx06v7mlMmanf1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ct6KWR+m; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ct6KWR+m"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-477632b0621so13146395e9.2
        for <git@vger.kernel.org>; Wed, 07 Jan 2026 06:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767795546; x=1768400346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZxgdKSayU+vVP98P+czEbJrklOjsEZzuz0B7pKiIurw=;
        b=Ct6KWR+mWF0GTJ9dHdK9UhEcbF9blMXiJ8ziBISFgwpq6UAuVdSXYpA8LUcsqPSg18
         sr9T/aXtkytF7TXXRkpPSdY2KJdLmpO1TTdi4QfmUQWeNLBlatDDBP1UL2FFCqgFWZqL
         lkmoEdMD0MmGAL3t5bFWu7AtMBdFolzYKnvSurMQciZIqwwbh991hkOffPzNE0vud37N
         C2eYfiw4wHFdq7iAulHyW7hbK6AMhSmQOXnARIqXRe53PHd67xI1zTX8z3VzjoXwxWDb
         vEIc3hY7QUINXgraBQnEitm6rgwMLyY2x7YdwZAqybEc86dqOccYXWDLHzRlXmn1b6/E
         WlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767795546; x=1768400346;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZxgdKSayU+vVP98P+czEbJrklOjsEZzuz0B7pKiIurw=;
        b=ASoVbYi20rUtFGZuU7UL+6W2jTa7zP3iXti3hZXB/pojlDtlq5psDc2AchrbPQevG2
         qY76oaz7BjzPdNxe4saOVkAGMgMTGqniJpTHZq5qgruFrLLVrJvppeTOEzl+b2LYO6w+
         WqEXxAQyOrB913o+3NSFtxnzTRvdPHbWfhwUTPvgjUuZyxydlCYCSp7ZJZsE+HTVOEly
         CSmLCscsBus3Liiy3UvriFy6KKQoHBEG9g8mjnCMSQkEnuHtQOQfKJ7XadGmN0tQl6a0
         VRCZ7ySF7gOehTyn7Z/h1VVOaw+Mx63OqMD8yRDMIO2/bP6HdoHSsC2x9sZ2YzYpHbOn
         AmQA==
X-Gm-Message-State: AOJu0Yx+vOGMYUIIYUIaxBmFq0GQrFybM4QucOJt/kX6S+R+pfQGaD9g
	gjO3gJY0dJwATXRLkpkGeRvZTqi5zu78I6c5enOSc4qUVzq0iCYZ3JE+
X-Gm-Gg: AY/fxX5jBH2U8lkpA91kJeHnl3OYFdTlu72gkxwP3JFVDX1grHIj/CLrSM8eoxuzxPt
	V6/oSnxbfo7bhhK52TUU48OnpQTYjJb7b+t6eWo0nnuWx1H6sVAUJxiyql2KsZH3aOTqylk1YJr
	Oyf2oGyr1lpVuRnDbWDCzo+li3w00m5xWGo4lnZTZrlckJb5Ix6LF/PYvIGItHXYc/c7wkyc0b5
	2nSnbcO9nzy6aXk+cC6pR4kr/DhPCQRtpzxirM/E8C0L2R7+3rFkEhJe4rH1HwvgZXoKz/B6nYg
	REZKA5Rig+CzFq4khdWJEJ2DZF5EbM+w3PuB+wwIXr5iNz+gk/taWjNL3JT9pT7lJMgMqxSotGQ
	kL4Uldz8xBwwmDRThmwVcmtETF8gJKsdIYG98ycq5gykA0VIgBSTVhCj6Ec97Yosn56E5AyDcDM
	STLYPoqwLwLjv58YXxDciHOlGoDXGpG9ecDIlliYbWkeinV3Yg0fkonrvzZUzdvZywYw==
X-Google-Smtp-Source: AGHT+IFva/lubrPULbwd8A882hRmLNti1/CYRE3iN/ZJoi/DzaFiVAmTPeLhZUit/N6a1phRTdGpaQ==
X-Received: by 2002:a05:600c:83c9:b0:45d:5c71:769a with SMTP id 5b1f17b1804b1-47d84b3b650mr31922445e9.26.1767795545511;
        Wed, 07 Jan 2026 06:19:05 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8384646fsm65844295e9.15.2026.01.07.06.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 06:19:04 -0800 (PST)
Message-ID: <8899016f-eeef-404b-8da6-ff3a90e81cea@gmail.com>
Date: Wed, 7 Jan 2026 14:18:57 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy PATCH v2] environment: move "core.attributesFile" into
 repo-setting
From: Phillip Wood <phillip.wood123@gmail.com>
To: Bello Olamide <belkid98@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
 Usman Akinyemi <usmanakinyemi202@gmail.com>,
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Taylor Blau
 <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>
References: <aVfzMsN2ouY3UBFG@ubuntu>
 <a881499d-e236-4f8e-a217-b6bce69e3e3c@gmail.com>
 <3947f777-e08a-4c17-81e3-c4711fe666a0@gmail.com> <xmqqwm1vk83a.fsf@gitster.g>
 <CAD=f0L9BEPSQivgpM7qURT+WFDY-+Ys_M6Knv8hE0JDw4Wjj5A@mail.gmail.com>
 <CAD=f0L9H5Q=zW02nr11OSBNgFH3UMLwVjVjn3zhgZ2rjwE85WA@mail.gmail.com>
 <922629dc-828c-4bdf-939c-b38b7b59e8e8@gmail.com>
Content-Language: en-US
In-Reply-To: <922629dc-828c-4bdf-939c-b38b7b59e8e8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/01/2026 10:26, Phillip Wood wrote:
> On 06/01/2026 13:44, Bello Olamide wrote:
>>
>> But won't this be a temporary solution since the goal is to prevent 
>> the use of
>> `the_repository`?
> 
> Yes but it would be a good start as passing a repository down to 
> git_default_config() will be quite invasive.

To expand on this the first steps could be
   (i) create a new struct to hold the config settings from
       git_default_config()
  (ii) add that struct as a member of `struct repository`
(iii) one-by-one, for each setting parsed by git_default_config() add a
       new member to the config struct, store the parsed value in
       `the_repository` and adjust any code that uses the variable.

Then later we can tackle the intrusive change to pass a `struct 
repository` down to git_default_config() and store the settings in that 
rather than `the_repository`. If we add a local variable to 
git_default_config() in step (iii) above then getting it to use the 
repository passed down the call chain will simply be a matter of doing 
something like

-	struct repository *r = the_repository;
+	struct repository *r = cb ? cb : the_repository;

Thanks

Phillip

