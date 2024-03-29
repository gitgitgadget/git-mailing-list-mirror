Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A2F37165
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 03:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711684161; cv=none; b=HVOzBzkk0+o+ecGYlZwW/23FVPPxfSsiyWfNsxtIefrP7rP05Y6YZ63Fz1yRxbsntOx0gFOnngeUc1QA71XYUfps3k7+wSb18gSlXi4ax9b0lfieTZ9PuxLjDP3kW5hWr7eHKvvBqM3wcrr9TYQkLQZ9KCNK/OG9Kj0sWBOLbSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711684161; c=relaxed/simple;
	bh=GvnkWpocbraXZUadoeIB3vpMzADSafUyXgHR+NQIn9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hO3tH7zBhZgHGS94G1wC3w7lLZ/DlLPsVLpRwk5ImQvNzqkLTgGs5mEstGfOXMXIowIqjPENSmh9y8lJT0HF/MGKdqzI5MLPmdRaqXDp1z72aS7Dq+VbvTXN3n1f6fpIjE41YNEfQ100yJZjmYVL7A6A0ii0AcDOtR3SFZFaWSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQ+3xZY8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQ+3xZY8"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4154614b47eso6514545e9.1
        for <git@vger.kernel.org>; Thu, 28 Mar 2024 20:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711684158; x=1712288958; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NBBZNKP4yWIB2rJ93Qqpc0Yo5uIMs4k7H9zb9rtQW/c=;
        b=iQ+3xZY8H0Br+HbLkyCUmd1T6DVKbZiA9qakJT+bY8piFLYMsviT5dnfCjnUWTCXNr
         nf7REN7mMYQyKgsYz+dCiF/+NnT7cdCYSILbcxoIKMyklGvuT4gq9uqp7tJ+h+O8Syut
         h2Ii74eWvh2mRjr42m5JjTgxlRXfbS+t7dyeiLQIqSqgELMsJDtQd73bRd53Xa7JHl6W
         c28ddFtODjKkxhC6cFbtbuaDZwGrV8cw+HjG9g3IWKxA9/bPsC6S36onPAK8hBDV9a7t
         Q0YxemkWCCEhtyJdKZLfdqFvqCTwbslUyxq/VEZiRJUpHnQvAALWNvxCeCGOElEYLuje
         REBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711684158; x=1712288958;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NBBZNKP4yWIB2rJ93Qqpc0Yo5uIMs4k7H9zb9rtQW/c=;
        b=qG5QhtSHbqNId8Y4sSeI7TQ9h47ZCb8aHhczFCp11Ao0IC1fZDvoXt1nWTDSNTIpy/
         Pmcwpk9Ev+G5xIeo7MAVJH3CdKurEOKwP8dcTMBK4VgVdt7fmBGilbunjsrtbcAAB8Cf
         4sG51yIUjAGxlbShel5ezmk0k9w69HyZ/NMGK+vn4iChkEgC4ueDJ/IHXiHtr1dMo9Ld
         k7dYgC531IPLdW8QwNP1gLsCbhvghJ+w8+ByFBkWw4qwpB8U1cppLeEes9BiTYJwngLN
         d7mlRFyg9+F2O663QxOdDh1w1JvE/9d4YLGdSgT1eOznySzRZEPaDxyZBsVqP1YlWDT6
         Y1vQ==
X-Gm-Message-State: AOJu0Yy9+WZ8NDw91kvBVN7/jqySneYIxg0eMPgIIo6ul0cFfvJYKXzE
	8M1e4e5OQ2wpetlqfjgWRdGljY5qwmPqHxE39zY8S68IQwjGgSnDr8gXaJX8
X-Google-Smtp-Source: AGHT+IGeygtbgd63hgs4aHXpZP+Xr9EsSgc4gccg+LB9p01HavXt65YIOOohy9avE/e/Yr1xRbMt/g==
X-Received: by 2002:a05:600c:1d14:b0:414:90ab:9d29 with SMTP id l20-20020a05600c1d1400b0041490ab9d29mr3472391wms.0.1711684158022;
        Thu, 28 Mar 2024 20:49:18 -0700 (PDT)
Received: from gmail.com (220.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.220])
        by smtp.gmail.com with ESMTPSA id u6-20020adfa186000000b00341e2146b53sm3126156wru.106.2024.03.28.20.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 20:49:17 -0700 (PDT)
Message-ID: <914d5313-0232-4b44-84f9-4bd82674a89c@gmail.com>
Date: Fri, 29 Mar 2024 04:49:11 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] add-patch: do not print hunks repeatedly
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
 <6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
 <60d978d0-f69a-4b65-b4ba-d30dac8f112a@gmail.com>
 <60c43160-1b60-42f6-9488-4cc332201b7e@gmail.com> <xmqqmsqixvmf.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqqmsqixvmf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Thu, Mar 28, 2024 at 07:46:00AM -0700, Junio C Hamano wrote:

I realized that I missed a minor fix suggested by Phillip in the
previous iteration.

> Looking good.  As we are not doing anything dynamic to the help
> text, I think dropping "again" in [1/2] would make sense.

OK.

I'll reroll with both changes.
