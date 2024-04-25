Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF54156962
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 23:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714088811; cv=none; b=DuzAWkjLATk6I5mLajOvuZEeb4jaZHCP+OOMmL5PhXfxh1Y8FP/T/AGFv9J9Lx7DaZ9xSfvwxqFQrBpFlYtd8Pvbg9/TVCDPxhQ6dr7ZPd+a7SllCnFg3EP3WRAWR1e3ayG+R2EeHVBtOxIMeWBiOn7+mZPHq266SiohnU+lXoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714088811; c=relaxed/simple;
	bh=lBcoFAfEjdsLaWJ84FVUusDeIxEfRIF5YS1fWaMiLiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YYhIk1g5UXdyYYgHj+qUiONa5i0vgb4ktFgKQ2d1R9V5dzl818JMGpOF95BOdiMxi9rBOtWmm6ES1r6YbQrD6bEiwTIhItsl2rnkk1XVwUnu3n9eSsVvlVGE/6ZYYyjSccHsuSzFbvWQfY4iYCJBv3HIQ9uxXGAl6wb4qiwZTMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDQGiJjI; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDQGiJjI"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41b3692b508so11652115e9.1
        for <git@vger.kernel.org>; Thu, 25 Apr 2024 16:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714088808; x=1714693608; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5tgJGKi50Br4XYblufEIeSvEHwAREDIiwWuQEesK0rY=;
        b=QDQGiJjIiBycO+vHmci7txDasvWJJiZKS21nxfeKtl7kCIe9ZfYNGAHfrGoC72SKcl
         ElUhSe9nn9crUbT4SeKXN4QYpgnoVwy5EP6N0tg6DGu+pVzvXdu1AhtAeZfamC5B7TBr
         uYYH+TXFkcacj1/YuwZhBtBhOjD9nOD2+5FneAgtfHTD/8Qzdu8tnHJODgV5bo8F+MUe
         h/YceKNGa+1ZZ8neLfxHhot1R0qy2qaC4aYmRg8GY0RrqYExUXYSUrvT7xCs4vzCMEn2
         Oq6mQsTmYfWn4BABEuyeZPqC4/3It4FSA7fMZA65qGcvuCPqCu1rWmBE5LilW0aEpe8C
         /J/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714088808; x=1714693608;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5tgJGKi50Br4XYblufEIeSvEHwAREDIiwWuQEesK0rY=;
        b=iLi2J1qxgqiUShu4n0r3HX1H0n1BuRfzLlOi2E6YUkOWHg/PTd+ElzKNflp1WBSByL
         p4HX3gfN4QUAhjTuwK73NfuNB6Nqpyu/T0eWDsaMA0N16AkbdTkPhExZxZL0ColtQL/I
         hjBil1psJUhiSqiqusx9i59v5NJZHe5LXkDaH4aQFHs491C4JHA4S+WVaGiWldk7b0mV
         zE6hZpA8W5m8YVyiU9Zou7k0Vv1DTVmI87UR2W9+IdDSgsquqjBf1M6nw6ikdS+XF4KI
         ri6Lr13hLsYeWRaGeSmHMw+kx331B/NnLVmwSfzgDHdx3kBsERL7sWZ1sAvA/A9x8HPA
         t00g==
X-Forwarded-Encrypted: i=1; AJvYcCVKcQ2GJXgwl+be2OyBE2om9F+tjNW4FMU+qFBXkxRnmYyq2KATBISFHrpW7oGRe/3Rijsvr5ik5ljdvUSLuzWiAA3E
X-Gm-Message-State: AOJu0YwxvoG0Qwi9/Vsj0081PH3BVHF8zT1GZ/t/FD0UromLPTDA4y6W
	pB+eeZn6zy//lLUIZR4aLZaP9iaRBJPyPiLnsuPjmcKlCEQFp2V1hbdcGw==
X-Google-Smtp-Source: AGHT+IHIPpeyDCxhW/1LGILUy/yuQfHTEprq+gucwqGQvNaGqDlUb/7ISoMZCnCHNChaXByUeG6MRw==
X-Received: by 2002:a05:600c:4686:b0:419:f31e:267c with SMTP id p6-20020a05600c468600b00419f31e267cmr714980wmo.7.1714088808131;
        Thu, 25 Apr 2024 16:46:48 -0700 (PDT)
Received: from gmail.com (244.red-88-14-52.dynamicip.rima-tde.net. [88.14.52.244])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c450d00b00417f700eaeasm29170363wmo.22.2024.04.25.16.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 16:46:47 -0700 (PDT)
Message-ID: <305296f1-975b-41b9-968c-3984d8056196@gmail.com>
Date: Fri, 26 Apr 2024 01:46:38 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] add-patch: response to unknown command
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
 Git List <git@vger.kernel.org>, Phillip Wood <phillip.wood@dunelm.org.uk>,
 Patrick Steinhardt <ps@pks.im>
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
 <6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
 <db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
 <b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com>
 <20240425014432.GA1768914@coredump.intra.peff.net>
 <CAPig+cST4_hUwWg+P_drqT-mv8+eLAzBmuMFXm=Dui14kfYZzA@mail.gmail.com>
 <xmqqedatfay3.fsf@gitster.g> <xmqqv845dug2.fsf@gitster.g>
 <5854e33c-b84e-47a3-94c6-c5fe8c9a4c98@gmail.com> <xmqq8r11dr64.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqq8r11dr64.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Rubén Justo <rjusto@gmail.com> writes:
> 
> > On Thu, Apr 25, 2024 at 02:05:33PM -0700, Junio C Hamano wrote:
> >
> > I am assuming that this change will precede my series.
> 
> No, this was merely "if we were to update the series I queued to my
> tree, the squashable fix may look like this", which you can use to
> update _your_ series if you want to.
> 

I was not sure what was the expectation.  In fact, I'm still not quite
sure.

I am not sure about the change either.

The current options are:

	a.- make the test check for stderr and stdout, separatedly

	b.- fflush(stdout) in err

	c.- make err print to stdout

I suspect that similar tests for other commands would produce similar
errors, so (a) seems like an easy fix but feels like kicking the can
forward.

I'm not sure of the implications of (c).  Perhaps moving current
messages to stdout breaks some workflow out there?  The other thread
about disabling all hints has made me think.

The (b) option seems to me the less disturbing change, but it has not
attracted attention.

There is even a (d) that is to go back to test just the new error
message, not the whole output.

I will give it some thought.
