Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2EB12E4C
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 18:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705775000; cv=none; b=MqiUY2NHQ1d7kH4KAD/esd2/Otk4k/ZuwB5+cRU0R5iJcvILZggUU567TgxxRQ1sz9CjSQSDWDyHofadcL7WBcpM4tdglg5QCSAYLPQ6cOYombMXMfFl6iny7Gn7kFZ5qFfjzFuqcrqenFVcMJ/rk850ftfcJLweEVy3PA1pye8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705775000; c=relaxed/simple;
	bh=RFaNmWs5VlRmeXMdBTmf77hjZBEI6QZHSriWflQCnmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j+sRWyhObFcNnYQwUioDVzf07WjmFQTcJ7ggiVX/bfiGNGVAZkHYlrnZeA5HJX3xQi0A/vEgAsUFB6cfLuOMeQBimdD8hfaEzdGYxqrEVAGm3qaDZ26VSztGrwWVIcgEcRVd/KigklYcEs+Mvopj8FPr8xJhxDvnlc4Do9/2P6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEiZ+g0z; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEiZ+g0z"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e76626170so20984425e9.2
        for <git@vger.kernel.org>; Sat, 20 Jan 2024 10:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705774997; x=1706379797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=igVtz1kDSVsaD4npxkx1FzfDbYAzBy6wufyS1iUwwfo=;
        b=kEiZ+g0z6Y2sdxlcfdNVFRnuHEHktCBn1RK/i67Q5Rwylhr8WrN0ksR353WnFHz2/P
         AKJ6ZkcC9VH+/MNsJez70DOBLR/NdRw+Ldavny/5yjQhr3+hrVqWWENAHtW9usMdWtpK
         5E+eqPevDE9slH3J66tyFnf85Q1VTifpI4XnxiIx4yCai8r4sLjrFsTIs8TYHC2tZh42
         TqZpnkIQWlzsOdS7IK5RG45Vk7cD3M4/HY77OLPmgQ4akd4aUcT76TVc4yVtv7mbA8y8
         Hhkj8X6PNLU7cTJk5Q7D9fNCQ9rDGYxBWFNrHqlL6SW1WqVhHFdk+rgKobr8TQ7VAoOw
         ELnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705774997; x=1706379797;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=igVtz1kDSVsaD4npxkx1FzfDbYAzBy6wufyS1iUwwfo=;
        b=U66PP4cX9cxdvsO9sYdsmwWXS1lAJZjWQgH7sci2yXa2JZMPlnXJRKzqAjGzw+UdtF
         rl9WQ3yDqtAly8J8iarl75fVlnQt8vs0qA0gSLRBGCrKG9dX/Mxr7sL/yKE0LuqclJXH
         t9K04bc8Rujef9b1x9ABOcFlvz5gEaPrh8xqIgIVF36/WXYyTEKmhmL7+9dr5Ejjb2Qi
         2s/qCrWQhp7qUrJP/QEv3ss/qbXDkNyLUsvlN6du7gy3s2LYtVExQlqziH/4kd1eKphS
         TytBihV9hicnM5Q5A/K4itHYONl/E0yMxgnySvE2QhjyoHn5L8CmsiBtUtKSjo8ISetd
         cBhA==
X-Gm-Message-State: AOJu0YyhQnSL1gBz2ieqeFHjc3npaASl5AocbpignyQ5TBK3CCETv2x6
	P0b/ld/bIUpJ5C4f4UpDVe4CWj7x7cMZ1cjLTHbTZVxgGrPovgAM
X-Google-Smtp-Source: AGHT+IFDdc2J7SYcK/EmzH85a2+S3x3L+AcaU0AcW+PDGu3Ih8M89PD14XyDoHFZSb4scNS/1MUixA==
X-Received: by 2002:a05:600c:4eca:b0:40e:5b2a:e50c with SMTP id g10-20020a05600c4eca00b0040e5b2ae50cmr870920wmq.27.1705774997370;
        Sat, 20 Jan 2024 10:23:17 -0800 (PST)
Received: from [192.168.1.101] ([84.64.64.237])
        by smtp.googlemail.com with ESMTPSA id k23-20020a05600c0b5700b0040e596320bfsm2432457wmr.0.2024.01.20.10.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jan 2024 10:23:17 -0800 (PST)
Message-ID: <7dbe4006-bfc2-402e-8073-870d7ec38319@gmail.com>
Date: Sat, 20 Jan 2024 18:23:16 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] merge-ll: expose revision names to custom drivers
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Antonin Delpeuch via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Antonin Delpeuch <antonin@delpeuch.eu>
References: <pull.1648.v2.git.git.1705592581272.gitgitgadget@gmail.com>
 <pull.1648.v3.git.git.1705615794307.gitgitgadget@gmail.com>
 <82624802-aa7f-4856-b819-9a2990b25a69@gmail.com> <xmqqsf2rgb39.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqsf2rgb39.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 20/01/2024 17:37, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> Not part of this patch but I noticed that we're passing the filenames
>> for '%A' etc. unquoted which is a bit scary.
> 
> May be scary but safe, as long as create_temp() gives a reasonable
> temporary filename.  We pass ".merge_file_XXXXXX" to xmkstemp(),
> which calls into mkstemp(), which should give us a shell safe name?

Yes. I'd mis-read create_temp() and thought we were appending 
".merge_file_XXXXX" to the path being merged but looking at it again it 
is safe.

> It also should be a safe conversion to change strbuf_addstr() used
> for these three to sq_quote_buf(), as the string with these %[OAB]
> placeholders are passed to the shell that eats the quoting before
> invoking the end-user supplied external merge driver, which means
> the merge driver would not notice any difference.

I agree that would be a safe conversion , but I'm not sure it is worth it.

Best Wishes

Phillip

