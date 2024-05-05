Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF739B662
	for <git@vger.kernel.org>; Sun,  5 May 2024 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714918166; cv=none; b=DrJP06c2GPSXF+J/wJZIvwf+Chcfwi3b+bNwyT5ZgC2ZANyEW9MyhJRtGf9hSZp9KfRZfO+UhJC1pJv4tihxSSirr0N2o8nyD3OJiEb43N4k72+IHZE123x//MvlkhqkJZM6N+oOl9tdreFo3c7lDxnSbLnlg3WVExcjueuPbC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714918166; c=relaxed/simple;
	bh=TbubuGrhHVwAYgdeY1vp40NCfcPmG997C8aqElLdcAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YqoZpjMbKH1ZQDIdjuBQPAiUy0sAbDWAAiHrkM+3Ws/3VX0j1opijkIG4JoI30TRmDG/hGAaQyWljNOygm1hV0EAIlajWioYiamllyetZv2+hFZ8SkV0zqzN2jfL5fe/YFuvVut2Rt2/xBWOzXcQOJ9+1gd9E7J63VnTUzMPMWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJhWr0e9; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJhWr0e9"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41b79450f8cso6982365e9.3
        for <git@vger.kernel.org>; Sun, 05 May 2024 07:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714918163; x=1715522963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HwQXc6owFpcb2XJEi7eFNSNmbl5Q66a4YDJ5h8OI1/w=;
        b=mJhWr0e9HAlACjCaBUm55wwMPeMKWgGbTuN8wI28ryYVPViX4GnfyP284Mv2rX6TCU
         /EbXPHRTV4Wn1yBsOx1/iT0/uspX4bC9ttAVeq2lnpGl93S3EXI7yNSCG/6idof4so6p
         qSqDldFMCck53j1vtPjgK4oSoGu3KlCacD1wnZHy15KeFwKRCl+uy4zXx2MT1nrbPj8p
         Bjcj+V+A4ra1SO5Dn/RkrXy20XTI5qgv2E7dW/jOG602reaHUENGzVmMWYZqpfTmXTK0
         qsUJ2GIgMkACcJi/keGsF3+e5dwQlZcR/DITiXgGqeLy//zCvKgMCR/MXMZQ3golat5x
         x7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714918163; x=1715522963;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HwQXc6owFpcb2XJEi7eFNSNmbl5Q66a4YDJ5h8OI1/w=;
        b=WJWFHFN326sAjmAHmdnP30sz5T95voiQypTNnasu05WZ+DoCjk93MxjGkh8I9BcDeI
         NWU6fyBfgCcEhXaSP2IYUFD8rIqYbC4oWAXMxSRQMwL/j3tPjtimQNB45xgmzBDX/kYZ
         8VcBX59gft8YUHrvH8hHPuejVSxYEMtauE3ED5ocFmxTyzLNqRmdG34O0B4mYmBa4+8q
         94yJNgby958Klv+scp00KI2L6yPB0PqUrPB8fCxyjA3Nh0yf4STGinu3JSckbliUm/m+
         5ZQaXlTETbQH8/wwjS2wwmLo9V8eoUaens8YSW4RmGPjpTpaKuF/lWvcqMNLr7MHvF0l
         DxVA==
X-Forwarded-Encrypted: i=1; AJvYcCWYIzxRixlAy6H7Uap2XcG3DEO/JlFqf33KQ9sLygEJIzP1EWe0vdOlUOUHGuvpr6W0MFNf1QXVQz0Yn0/pRkwhfuRo
X-Gm-Message-State: AOJu0Yxy09DfJrfIUB8NvbWaCQQ+gfnJWzUUxr9KuC89FOu/b3hP4Idf
	mbe/Arh0PJ3Es0XkXEdzR8K2PkGS2BsntH1CLBd0jmfgvIk7CnPE
X-Google-Smtp-Source: AGHT+IHoIg1+eJgEgSiBQ9QIZ0FyuYCXQ9PfxBfd8iFUOKLALSXbcvvQWEi3DAAvjFDr5HaQ60eZ+g==
X-Received: by 2002:a05:600c:4709:b0:416:2471:e102 with SMTP id v9-20020a05600c470900b004162471e102mr5663625wmo.37.1714918162748;
        Sun, 05 May 2024 07:09:22 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1? ([2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1])
        by smtp.gmail.com with ESMTPSA id bg4-20020a05600c3c8400b0041bf29ab003sm16455005wmb.30.2024.05.05.07.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 May 2024 07:09:22 -0700 (PDT)
Message-ID: <a75133dc-a0bb-4f61-a616-988f2b4d5688@gmail.com>
Date: Sun, 5 May 2024 15:09:21 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 03/10] trailer: teach iterator about non-trailer lines
To: Linus Arver <linus@ucla.edu>, phillip.wood@dunelm.org.uk,
 Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>,
 Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>,
 Josh Steadmon <steadmon@google.com>,
 "Randall S. Becker" <rsbecker@nexbridge.com>,
 Christian Couder <christian.couder@gmail.com>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>
References: <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
 <pull.1696.v4.git.1714625667.gitgitgadget@gmail.com>
 <4aeb48050b14e44ec65cfa651a4d98587a6cd860.1714625668.git.gitgitgadget@gmail.com>
 <18343148-80d1-4558-b834-caaf8322467a@gmail.com>
 <CAMo6p=GJwmStLrW6cDDKrch2cXn_8fe0GsBHi3hpe5Uya72y=w@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAMo6p=GJwmStLrW6cDDKrch2cXn_8fe0GsBHi3hpe5Uya72y=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus

On 05/05/2024 02:37, Linus Arver wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>> On 02/05/2024 05:54, Linus Arver via GitGitGadget wrote:
>>> From: Linus Arver <linus@ucla.edu>
>>>
>>> The new "raw" member is important because anyone currently not using the
>>> iterator is using trailer_info's raw string array directly to access
>>> lines to check what the combined key + value looks like. If we didn't
>>> provide a "raw" member here, iterator users would have to re-construct
>>> the unparsed line by concatenating the key and value back together again
>>> --- which places an undue burden for iterator users.
>>
>> Comparing the raw line is error prone as it ignores custom separators
>> and variations in the amount of space between the key and the value.
>> Therefore I'd argue that the sequencer should in fact be comparing the
>> trailer key and value separately rather than comparing the whole line.
> 
> I agree, but that is likely beyond the scope of this series as the
> behavior of comparing the whole line was preserved (not introduced) by
> this series.

Right but this series is changing the trailer iterator api to 
accommodate the sub-optimal sequencer code. My thought was that if the 
sequencer did the right thing we wouldn't need to expose the raw line in 
the iterator in the first place.

> For reference, the "Signed-off-by: " is hardcoded in "sign_off_header"
> in sequencer.c, and it is again hardcoded in "git_generated_prefixes" in
> trailer.c. We always use the hardcoded key and colon ":" separator in a
> few areas, so changing the code to be more precise to check for only the
> key (to account for variability in the separator and space around it as
> you pointed out) would be a more involved change (I think many tests
> would need to be updated).

So the worry is that we'd create a "Signed-off-by: " trailer that we 
then couldn't parse because the user didn't have ':' in trailer.separators?

>> There is an issue that we want to add a new Signed-off-by: trailer for
>> "C.O. Mitter" when the trailers look like
>>
>> 	Signed-off-by: C.O. Mitter <c.o.mitter@example.com>
>> 	non-trailer-line
>>
>> but not when they look like
>>
>> 	Signed-off-by: C.O. Mitter <c.o.mitter@example.com>
>>
>> so we still need some way of indicating that there was a non-trailer
>> line after the last trailer though.
> 
> What is the issue, exactly? Also can you clarify if the issue is
> introduced by this series (did you spot a regression)?

There is no regression - the issue is with my suggestion. We only want 
to add an SOB trailer if the last trailer does not match the SOB we're 
adding. If we were to use the existing trailer iterator api in the 
sequencer we would not know that we should add an SOB in the first 
example above as we'd only see the last trailer which matches the SOB 
we're trying to add. We'd still need some way to tell the caller that 
there was a non-trailer line following the last trailer.

>>> The next commit demonstrates the use of the iterator in sequencer.c as an
>>> example of where "raw" will be useful, so that it can start using the
>>> iterator.
>>>
>>> For the existing use of the iterator in builtin/shortlog.c, we don't
>>> have to change the code there because that code does
>>
>> An interface that lets the caller pass a flag if they want to know about
>> non-trailer lines might be easier to use for the callers that don't want
>> to worry about such lines and wouldn't need a justification as to why it
>> was safe for existing callers.
> 
> Makes sense. But perhaps such API enhancements belong in a future
> series, when other callers that need such flexibility could benefit from
> it?

For me the main benefit would be that you don't have to spend time 
explaining why the changes are safe for existing callers because they 
would keep the existing iterator behavor.

Best Wishes

Phillip
