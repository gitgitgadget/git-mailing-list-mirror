Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBA726C385
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 00:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771808227; cv=none; b=T2+ueeWQ0tsIU521szcP/FUEjE5NFpdtsvb0WWh5gJNlIUFnwTlFC2rZu2IZcJDkycWBZFm3N060yu11EUyYrba8UrVioqLUGP0f/3FxE4r1Ika337igaRtfKq5HMZcoDmExfZZHTAB9kWeYayUf49WPh9CgHLhwGhlMDsqlyGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771808227; c=relaxed/simple;
	bh=Lbzo5Xmx3mxF5oWTQ1xLZAXk/LGg0RNF+yeBvf+QqWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HFZodMB60PI78Pm2ZjLtHJg5aUlkPcQ7SweiC8/OzY6XUgd3f43zBGv9FMyPdLLhZG+dHQ4IlsE6NSp+E5HNOUjUNCj34aVO1UlU2mZb4Q19zfx0CCHT+kHV/rV+rxFnieIx6a/pavsxSaH1bwiG22gGLsWOW8aIMf46Nj9nQoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFy72Q43; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFy72Q43"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c6de5ea6879so437578a12.0
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 16:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771808226; x=1772413026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4pSmV5Vr3ZPvxlkcAhLcyM4+S5Xj4r1V81zE+qp0Gck=;
        b=GFy72Q434kLVYiRRkE/FW3dF+D3q+RqzRFBktcmJvKXR1lbezGHgCy7JSv1xeZlEiK
         dLHUDBCWzuyx0YDuan1vkqKByt5ngVfr33OUMppGDgHujY5YtMQhm+aDKBCboqoeP4fv
         JlSKc5AxHWjpEargFRD0o3MTAdU3ABS+p4PkFduoWqA/3K1kEtOnpGtXjvpsJj1+EzEi
         K04f/VRPP/SgqMyfY4lM18HdEjG2MCMJ4vfuXX+GInzms7nUbksxrhVIJbEukYdvAO2D
         6cMTbHHoTu1Qccw4kNYK4qiorDgm0C8k05ZlNOKbGZhfSQl/HN4q57nOH6cQ0q1OcfdQ
         6Evg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771808226; x=1772413026;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4pSmV5Vr3ZPvxlkcAhLcyM4+S5Xj4r1V81zE+qp0Gck=;
        b=Tfen2gvNU6xZvJToFSXgHobznrvLHRKtTI+qYutXbo0iiLKsj3TaoqwyCVSaAPMHs8
         hn9tB8JW7VPIMPNyCJynETGHCMK6Iy5VJGER/TXyv6ZS9T9OTyyoZVn8zZ5hes2J0yY7
         GjZFOgHLpgltnUJv72ON/HBPeHREMqjdWSPlt3512WhUgnxfWk9U/gkMP8OS7v0PZ/EH
         J2uiKLcEjREnra3C5gYUmeNL6TnG6ilXpYiiJJBsj6laqOUhHupSufSYlE2FPddeA+tz
         MCnOSmShQDehgSGAGIFUKJJPFslUxQqgb7uxGAptgw7tVQchfvVDGRiojflyS865uzOt
         Pb4g==
X-Gm-Message-State: AOJu0YxTX6qnsCSieZfVT3brZIxTFVheHqADb0TbNn0l6ygDwujTe02v
	JE2Sca/46rePNKFWKaCT3bQSAR0fBFuSSBm1NvKd0yH1KR57WB48AEJY/KxgBA==
X-Gm-Gg: AZuq6aIr5CRszDbaIBXavCW4N3/GGjxwU7q8NGIcwrnpSnj/2y/JaaFAkACR4E0Ie6n
	bSiNAZOVd2l0nWciHlVwWscSgDmSlZQJ4XdfjGw4VuMbgV3gV/bo0v9JfQmIAIcOPiQHZSCzZIU
	z8KWGsZe4Kl4KM1S5zdfwqF/d4pGXOnFaQozgIOrfHUijWJTq5bzd3jna1q9Br+vkL0p7IIwaC9
	vFTl5yWC+hZZcrlxliKbYve3XuBBOKVpF6dL9sHwJyYTHNo7EjxhOdkR016I6FJwiktqEHzC5Uq
	hsEbTVuIHTaBQngE/C2JmJ4Rr7bvW5DJyABdCwQTIqzmu4yGwaaSsnHUN7v/CnA7fHdPuS7+ZaX
	Ful5jJpatwxqTD1DCIgOhN2KLX/xEaZITzfoGYpuGL55xeCHDz5yPax8uMv2NDzfhrJ7/8iTF+G
	mPpWMXcmQiUxKcgrDHo5alTmVGyo4=
X-Received: by 2002:a17:902:dac9:b0:2a0:ccee:b356 with SMTP id d9443c01a7336-2ad7445409amr49694025ad.1.1771808226191;
        Sun, 22 Feb 2026 16:57:06 -0800 (PST)
Received: from [192.168.0.104] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7500e062sm74534785ad.48.2026.02.22.16.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Feb 2026 16:57:05 -0800 (PST)
Message-ID: <b3660d47-1129-4d07-9032-029e232a6d4b@gmail.com>
Date: Mon, 23 Feb 2026 08:57:01 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC][Draft Proposal] Refactoring in order to reduce Git's
 global state
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
 Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>
References: <ab45758c-fbcf-42b2-96df-030eef8526c3@gmail.com>
 <CAPSxiM-f1nQiFAW=dDCCqr1Yce=ZrVrMYE0YHc+-cFAjx+5m8A@mail.gmail.com>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <CAPSxiM-f1nQiFAW=dDCCqr1Yce=ZrVrMYE0YHc+-cFAjx+5m8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/23/26 02:34, Usman Akinyemi wrote:
> On Sun, Feb 22, 2026 at 11:29 PM Tian Yuchen <a3205153416@gmail.com> wrote:
>>
>> Hi everyone,
>>
>> I'm Tian Yuchen and I'm planning to apply for GSoC this year!
>>
>> Instead of pasting a giant wall of text into this email, I have
>> drafted my proposal in Google Doc. I thought it might be easier for
>> everyone to leave inline comments and suggestions there. (Of course, if
>> you're more accustomed to email replies, you can also quote the content
>> from the doc in your response. Thank you.)
> I believe that a giant wall of text is the appropriate way to send a
> proposal to the
> Git community. I will advise you to send that giant of text actually.
> It is easier for the
> community to review and give feedback. Also future gsoc participants
> can also learn
> from it. By telling the reviewer to go through the link to the docs
> and then copy it on the
> to the email just to reply is giving them an extra lot of work to do.
> So send it through text
> and make it easy for people to review.
>>
>>
> Thank you.

Makes sense. I will format the proposal into plain text and send it as 
v2 shortly so it's easier to review inline and properly archived.

Thanks,

Yuchen
