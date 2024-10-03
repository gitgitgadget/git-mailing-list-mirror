Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB80238DD1
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 17:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727978039; cv=none; b=kn7mOxMTNACimxrPXFiFQwtyt4Gg5SIKCAjrIYXRnIPiDoFA3vYYeFDg0XSiw7ICBa522adjSUTWnFHYqMCex5hH2ULKeQ5TMM92XV+gWbQYIIH3KN6xQQb+9JfXNCJWLlYJrlnO0YJFnl62RUIbWxbGJ8wh9CJ26paOp8+kdeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727978039; c=relaxed/simple;
	bh=acvJOpcakkfh58WTsxRk0xO/+Zvb8ybHx4DsLq76aj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUEDvhNYCCF5SvMVBpPf8khycJMAFPhUmRSFnUI4KlzeHbaJFLfmzHogQAUB75XNUOwI8yHWp4qG31NuXbj9U8YSdJUQYodCu+yzFkOAwpz4a+MImEFigove2V+ZOwX/Btifz1Q64gzz5EMqecipzryz00nHeNO63UWNCPU1MqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=f3x6Jl1y; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="f3x6Jl1y"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e25d57072dcso1217880276.0
        for <git@vger.kernel.org>; Thu, 03 Oct 2024 10:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1727978036; x=1728582836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=acvJOpcakkfh58WTsxRk0xO/+Zvb8ybHx4DsLq76aj4=;
        b=f3x6Jl1yaarn7sex85jFwGazTyeDWGo13QU3xhYZwn6PT21eDzFODedxW1grqrdWSy
         Upx84llZhH7teOhH3al7S+1KUi1NqAD9vaPNOaSq9KSxcC2i0JzAphnMFMApnZvxGna/
         abV1Fi8C8zsaytJIBxR6kUHIUrImPMRQ4WLoUj1Xa3M0oyZlsqhz0HQCTfjQe1eZVEgT
         GSmSOKFDK5HDwtobFY2XxxEhkv6438VX8q9IGgA2CmRl9JT7zB2KaBWa6789V79yuNxl
         nIJgdC85N/LrngPWUYPVE3RaLSmFE+0kMZFbWtknDqn4MZDVCFZC9e3UgMp6qmfGH4kI
         Tgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727978036; x=1728582836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acvJOpcakkfh58WTsxRk0xO/+Zvb8ybHx4DsLq76aj4=;
        b=Tbo8JRiBvLK53IOUAoiH+ISViX16skmEcaJ7TNd9RWpQDxKwgDy/iv1tDJn/ucAfED
         0u3gS9ws5MQ71SQaatnr8JaFQ1/LrmXrxftGNCKX+Lz+3j6Iua4z6Wh5a3xh3XKEoN2k
         ux4O1HvYdh925IddGg6+fdoCKrDk8e27U/SYaMCxdXOM5nYUCmTDkjo966HgDcYIsnMM
         JXPCLVTBUcRvTK55IXnHmPt7iF8rPji/Jn/GmOH6lxMs+xb12QySBEDnXpdNox2/LaM3
         TR4GLFqJreQiS2P5mOQOD+u5asy9Qxn49L/Gxf0CjM/MtY75FJOEa/SlSSdW34sHeKwQ
         HPlg==
X-Gm-Message-State: AOJu0YzFyFygtGW7j2otESta8fvQbrK0P4lNAw7c721e/1s0Mwi5798R
	XJkpAtVyxFJG3YLC3NzFB/5H0Vcpmt+nIFxwpJ7yinvNcpZUpgBgnw7pZLoUyUM=
X-Google-Smtp-Source: AGHT+IFs6twG6Kxqk/0r8S1QGege6JAwvf6uOb5siK4CIvqB8Kxfz4Zd3K7OeIp0lyUp8HVE70TqMA==
X-Received: by 2002:a25:8e12:0:b0:e28:6c15:ac6c with SMTP id 3f1490d57ef6-e286c15ae04mr3984400276.40.1727978036590;
        Thu, 03 Oct 2024 10:53:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2885d69be1sm284733276.29.2024.10.03.10.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 10:53:55 -0700 (PDT)
Date: Thu, 3 Oct 2024 13:53:49 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: the latter half of october, the maintainer goes offline
Message-ID: <Zv7aLRXwt9cfqW58@nand.local>
References: <xmqqh69thzd0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh69thzd0.fsf@gitster.g>

On Thu, Oct 03, 2024 at 10:26:19AM -0700, Junio C Hamano wrote:
> It can be somebody stepping up and say "ok, I'll self nominate and
> run the project as the interim maintainer, just like it was done in
> the past years", or "let's do something differently, how about
> everybody throws a merge request to this mob repository, use this
> (possibly different) review procedure, and give back the tip of
> 'master' when Junio returns", or "OK, we'll discuss and exchange
> patches for these two weeks among ourselves and we can cope without
> a central meeting place".
>
> IOW, I am interested to see if the community comes up with a
> day-to-day project structure that may be better for the contributors
> than what I have dictated in the past during my vacation time.

Interesting. If list participants would prefer to use the same structure
as when you're not on vacation, I'm happy to shuffle the patches and
send regular "What's cooking" reports for those couple of weeks.

I guess that amounts to the "I'll self nominate and run the project as
interim maintainer" option you mentioned above :-).

Thanks,
Taylor
