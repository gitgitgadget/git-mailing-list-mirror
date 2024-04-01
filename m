Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B32342056
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 19:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711999661; cv=none; b=RXcibgKWKRijemVw0Wi5P6xGQUdeMyWpiuQ9JLxjgrZN54+Nwl4OpTPtxAVotNw4GVb3KbUfaGSZMHjJqwgkRlPHxpbHlm4Ps7gL8RrA1hPYxIypZdj+Qm9iR13O/sQ5/C64QQJQsM89QkIR0zPYamkYMuOwSPjBexCzXPoqVMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711999661; c=relaxed/simple;
	bh=0+8yjDsWpYvNNRVdzSW0HwAt/qHPLvc21ePNO7Q2GyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vv70iR2usY0sq+csyGfqVre98b7oPjWg8vBCaoS9fUV8DHE06V+hvC2ExpazbrLSx5dDqmAaP3uurLI7HRIP2HC4M+MopM5/6eN19atW7DGuUxdVO4QuBL9SOHYBidcZ/kz5XGmdnKSqjfmoMtWIvOgcT1AZCLXhot7OLmS7bPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFX4FCYV; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFX4FCYV"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41564adfd5dso7584795e9.1
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 12:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711999658; x=1712604458; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p9n9FEd6YIWViy+Mi5QOT0lGxeuUkI3w/aI/2/CJqMw=;
        b=HFX4FCYV69iEeK1jS9zZzRTG7mphbhxZ+L3lobQKH52aJKoLhYeicki1lXnKo0pUCG
         T1sjWbvwNRI9tx4L9sBrpBSUj7XU3yQExwDmr4p6C6+6RmXLwDch3uOCeOVPejOEir06
         78llumjjn3gJkQJeJY4jcK8cqadj9iMWLZlFKDv4zqQXkrhduZuIkP96lJ4iRYfJ7jij
         xFiPawT8vYgCe6EviBM6Vq4e4c0cF1n2wv0PGm3VHI877OEB5pN1wURUa7g11moAM3wA
         JCEkoaMdNdeDmXuPZ8Orui/Xpqx5Ec06iyQzVBCba7t4pYmk//a0qF3YCwsaLJp9yDP6
         1n5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711999658; x=1712604458;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p9n9FEd6YIWViy+Mi5QOT0lGxeuUkI3w/aI/2/CJqMw=;
        b=wzsBRXg3f11IAEro4EBp+LXriqjMxjka/iIjCN+0NNtHhkovVk/gt4FX+hQI4Qib+9
         +Sv+T7rkSiXPlaBmXE9I1yUTjKj1LWX2APCZeS9Dud5JC/URE0/My+WGvV4XLMR0CzNS
         QwRl6xCg9ZYjXnTfHUqsykpXgwfhU31PwYfCfZfmPw9cqRAUH1pmWXUiR/rt6slegZ4K
         sKME2gHJTgS+FPVzax2vQMWts9kDlQbCgt5KvhPSAcLlcF/YTSHrDV8Lgi9RCu9jFy0y
         Tbt1oz9txPt7yuvhbkcSD68iuBOJr1JVAhun1nJ94dqLZMy9oLDSiCdJhPApwu6YZ4Bd
         p2VA==
X-Gm-Message-State: AOJu0YzTMopiEsQjkLlp/zo6XxZlqFtCVcfPa3mf9ygAf9bVV3pQ3C91
	NCHRH2si2s1BOvlTHLVJ5bHB1xQ235JHYv9vgvAUzlFn3bV5J+he
X-Google-Smtp-Source: AGHT+IGckrV+m7LkKCj/fHdsaxzJB0dvCwYmYEOxMxIXr2Sx2LBiGi2bCfoY+L26g/FYcNL7rqkKdA==
X-Received: by 2002:a05:600c:5207:b0:415:9df2:7405 with SMTP id fb7-20020a05600c520700b004159df27405mr168271wmb.40.1711999657776;
        Mon, 01 Apr 2024 12:27:37 -0700 (PDT)
Received: from gmail.com (4.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.4])
        by smtp.gmail.com with ESMTPSA id w7-20020a05600c474700b004156ca1df95sm1811310wmo.18.2024.04.01.12.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Apr 2024 12:27:37 -0700 (PDT)
Message-ID: <5acafee5-dd65-49f1-bc2d-f959ed4bc9e1@gmail.com>
Date: Mon, 1 Apr 2024 21:27:31 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] improve bugreports
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Git List <git@vger.kernel.org>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Emily Shaffer <nasamuffin@google.com>
References: <35de2d76-a03e-4a36-9bb7-6b6ffa4ea123@gmail.com>
 <4f179986-6aca-405a-a122-d0dc058c60d8@gmail.com>
 <CAPig+cRFqddMqTxCENnknv3Agcq3_bxGmB1sQTmJNb=xNYg1aw@mail.gmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <CAPig+cRFqddMqTxCENnknv3Agcq3_bxGmB1sQTmJNb=xNYg1aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, Mar 31, 2024 at 11:09:02PM -0400, Eric Sunshine wrote:
> On Sun, Mar 31, 2024 at 3:04 AM Rubén Justo <rjusto@gmail.com> wrote:
> > On Sat, Mar 23, 2024 at 06:32:35PM +0100, Rubén Justo wrote:
> > > Let's try to improve the readability of the bug reports we receive.
> >
> > This series received no response.  One option may be because it went
> > unnoticed, another because it may not add value.  I'm going to give it
> > another try and I'll quietly :-) take silence as confirmation of the
> > second option.
> >
> > I'll try to increase the chances of getting a "looks good" by CC'ing
> > some folks involved in the bugreport tool.
> 
> For what it's worth, when I read the cover letter of this series, I
> thought it was going to clean up the list of questions to eliminate
> redundancy. In particular, of the three questions:
> 
>    What did you expect to happen?
>    What happened instead?
>    What's different between what you expected
>         and what actually happened?
> 
> the final one seems to repeat what the first two ask, and it is common
> when answering the third question for people to simply repeat what was
> said in response to an earlier question.

Certainly, a diagnostic questionnaire can always be improved.
Unfortunately I do not have a better wording to offer here to reduce
that sense of repetition.

Thanks for your response.
