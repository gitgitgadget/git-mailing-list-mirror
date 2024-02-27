Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752D51487DC
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 19:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709061703; cv=none; b=jqF9w9Kj6XOZRzzdaOH9PlJPtyv4IcD1InRNqYGXsiuOmyQnIy7JuG7aB7uKjGXosjddEKnPQPL1LD6ertvV+liIOhQmCC1WDdyb73dLRGFkwFqIXurGbpjTLNBFuiElxfqcwTgWyrxjgEzVnfEepdNaDpuMnpaz+CxlE2/0AuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709061703; c=relaxed/simple;
	bh=Wm48VFf/RIx7ltBQe8Kem7AKPbp5oXj0IahrgA51dvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=KK7OV/fHgOYSL79bETWEHUY2c6j18UbY/RnJZDdAYTX6pWvbOZakO0CY/x6VExXchLxwd9in5ilYrmLFpbka6xo9mJVeisgJKJ+ruKKjJ/F1o31R8nzKP5vrSEvSCHnUIub/I6pQfEe/qpcxQSzXhKZPywJrXGBj+NvDnO+Zk3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERV5A7ul; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERV5A7ul"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dca3951ad9so23445295ad.3
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 11:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709061702; x=1709666502; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5JrfhVLV15ajoZLTURiTDp8SeYbx0o+AzpKEOPPfOIM=;
        b=ERV5A7uls5bz0SWfOuo7fgqRGvQJjGGrLbJ6J659yCqmVboY43Bj/bngsRDS3ubM/A
         cK4AHAD+WBE+ghRR1kGq1kRi98Q/h4LhARxpXw65MijD99IQcw3W8KTa+NbvAHdn0TM9
         7imBs5ZpeLN1zdaE9PyKNmXLId52Tpui6+zXR/3hBlBlepT5dW7E6kd/MQOQdG+h54Ut
         YQuRTsOKAyslGrL+N2vwp5RhhTHg9hLTcgGivY5sikqqAQoHC6rm39H+sp5+/4989XA7
         x/X7fQejFn4NJ3P5IxFIo5hweCFyKOQUHm4lMt+YV+hAMuLaCvrz7faPMeaZvfqPWS2f
         spfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709061702; x=1709666502;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5JrfhVLV15ajoZLTURiTDp8SeYbx0o+AzpKEOPPfOIM=;
        b=Od1JCyADGWvLvmo56pN3KF3OMttwqaJxOcFvJxodYvVHyRVvHQUTxzPNqiHpi18nLl
         +U8q3gL6q8ZUC2PI/S9miMl/7x2fyvnItW9L9QCxqPLN51lrB8L2wo4fBkJExqOtIGlc
         mS89D0fSNzTvtv2bQt0ExXMd3RAIjczNel0p2kypjFXcisRUHr2YrbJPSO/+Q1tBlkPf
         Wq9m/sUMuhoE/JTCkedhW6+ExXkAE4NDfJeRUGuF9x9Djpi0PJsGq3ON1KpJI77PA0Z0
         KEpOLnF4qLnCmPGQBrrOn35wWilx6djFT3P1ZwiwRyNaBXb4wBXpoRe6FNbiliN9Mtz+
         Pj5Q==
X-Gm-Message-State: AOJu0YwhyzdJyzySpa2SWVpA0VdSH1Gai9piyi/o2mStIGh2ocTsgmDQ
	CTBscC/GMElngajWo2jZMG3xVcvMQbrAa69lztIQzOdoRIjq1RBz
X-Google-Smtp-Source: AGHT+IFMjSSYtDP7gwDPV3Zts2uvLxlZOe192rUl0iMUdRJVskiohAh2oFCG2ns6DBdxq8jG0W+zTg==
X-Received: by 2002:a17:902:e5c5:b0:1dc:4bf6:7eb4 with SMTP id u5-20020a170902e5c500b001dc4bf67eb4mr14661672plf.31.1709061701632;
        Tue, 27 Feb 2024 11:21:41 -0800 (PST)
Received: from [192.168.208.87] ([106.51.151.98])
        by smtp.gmail.com with ESMTPSA id li6-20020a170903294600b001db616fa11dsm1886380plb.238.2024.02.27.11.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 11:21:41 -0800 (PST)
Message-ID: <691bf66d-668f-438f-b115-bd3497f92dae@gmail.com>
Date: Wed, 28 Feb 2024 00:51:38 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Interest in Future Collaboration for GSoC 2024
Content-Language: en-US
To: Akhilesh Kumar Yadav <akacademic05@gmail.com>
References: <39C00ED0-2EA9-4BCA-8662-AAEC5A108D49@gmail.com>
Cc: git@vger.kernel.org
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <39C00ED0-2EA9-4BCA-8662-AAEC5A108D49@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Akhilesh,

Thank you for your interest!

Kindly check out our mentor programming guide[1] and SoC ideas page[2].
Completing microprojects is a requirement for selection. The more active 
you are with your contributions, the more you learn and higher the 
chance of selection :-)

[1]: https://git.github.io/Mentoring-Program-Guide/

[2]: https://git.github.io/SoC-2024-Ideas/

On 26/02/24 04:40, Akhilesh Kumar Yadav wrote:
> 
> I hope this message finds you well. I am writing to express my admiration for the innovative technology that your organization is working on for GSoC 2024. I have been following your work and find it truly amazing.
> 
> Currently, I am committed to another organisation and may not be able to contribute to your projects at this time. However, I noticed that your organisation sometimes faces a shortage of proposals. If such a situation arises, please consider this email as an expression of my interest.
> 
> I hold a strong interest in your organisation and would be more than willing to submit a comprehensive proposal should the need arise. I have also been an active contribution at open source projects and have decent programming experience.
> 
> Thank you. I look forward to the possibility of future interactions.
> 
> Best regards,
> Akhilesh.

-- 
Sivaraam
