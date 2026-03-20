Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A86136D4EF
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 16:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774024544; cv=none; b=ZiGxWggD41R4Zmv65QGXmqDJh0UZACh1RiHgFQAmETPRMymV/TwqGY+HatTDNL3KXlfmY9faK4Z4M/XJemcg0Bkn97iow5+CWmGtHfC7KzBezRrNb7xDE6jikC5qv8qY/Ti3o36uf/5WYAUBHrJ+s5b5OBNVQX0z0vIRYv+oW3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774024544; c=relaxed/simple;
	bh=GCCYTzlDaBbIjpg08KEXszWy+ziptBZq1uE8gSBOiJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jFhsdlENkogkr0cykrdU47+aKTmU7/odu/qB6ArNPkHSmcqQF54dj7Wr+tyJHNitibL46ECM3RpXl0KzquxpRqwrelKNmrho/NEaqlPaLfPJA2rgvxnM+EXngUCzIzmWzu2836QyBKYLoF7jINUc1DtVPmbtd/jITJUTgsLyYug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifhGTr09; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifhGTr09"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8cfbbdbaf3cso208561385a.0
        for <git@vger.kernel.org>; Fri, 20 Mar 2026 09:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774024542; x=1774629342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dEWirSqLtrCB4d689T/0mdlzRRBhM3gS56xIE0UKz6A=;
        b=ifhGTr09jcvLXmhj6ldCgPwIhmTMxZRxvVTNyrixaNwHAWokTd8eOGn67GMw+ly/AB
         9Ay0NqEiuUnZV7qnxEL2Npy7d3klC4BzsYQz5unWsnuo7iuZk6uaHt0Pe2/QPRY7O6E9
         vM0hQcnsNEJb060islUk2VeQdrhu58xv5GK8BpurMqThPuWqow0GrL1xQTn4utXnn0HQ
         q9H0Q7eF0jQBSaV09aMFw0m1uxUF4FaGzgsGNDDRY4AK/Enp74Q2a6Hu3HbgLD+TFdQ0
         rAoqNVY+sy1U9lWhrRz5VRhNEzutz7E2ZtYKg2wHu4X3ek+Q3b4ZMDDz7XPivgR8zZNJ
         QXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774024542; x=1774629342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dEWirSqLtrCB4d689T/0mdlzRRBhM3gS56xIE0UKz6A=;
        b=VuKWs+kKjl6XauB9BM3B4d9pLu7ZtBys6XkXBTYBG+GJPFe0qBfLvffNeoDkoM4CAU
         rjkdHqyXOR4axS8dd3aDsi7eoRDsGlY+6tMTHZ9zogsL7wv0j55quRnvamQNwzUiGsQc
         9k7Ix9259XQpsf9AQW3TsSnknmN7xRoAjnMAa+Kgq7c18ETp1LfpYGDoDZvroLmAUpaA
         ZgFDlFtn9Sp9SKA9pcPz+vchSgN4ccoqJkMySr9XJZHZ8ec2WRapbSGbVoNfDXNDA7os
         RhkcXh+aCwde8WArjFyJnTF/pdbFOC/JDUa9I9CWnRUIAA/Amatf5W/SR4FFkdqJn+wp
         KKDw==
X-Gm-Message-State: AOJu0Yw4hT8yfm0xfDvvNjkE/vieHd3LyXJ7u7W2Y90TqAL45EwoFCF4
	PRHgKxDEfQW7ipd2qRYGCUvpNOzZ5C6uJtRotCsgyjRoipa6nlBc4pbIjYV04Q==
X-Gm-Gg: ATEYQzyr3pldYCTTGLqE/JVM35lff50kr7I7XulzcR2o1WjizT4LcVIobTSiH+AQP5Z
	fcEDsF7Eu0TAoFaAN1/O64kvsDOka1Rb4gWqR3wJIqjueEmD3/A6WwfRXn2GF+n3+F2A7V95yY9
	tbcWsDzXJeYCCy4dvGdDE6TEARU4ES7Yc5PlzdnxjzXbeCmMYrlFCK6jA3Vtfu23ku633Yp10XV
	maX7txWpt7KkFnWLiehggmhSLJP6+L/Fy594sf3ToDNc+ffni/ifSglciMspAlbts7GV2979TKn
	OT2MOwcu6TCzmqHbF1aA5E3AmgPk8why7sYrcwOhgH0kLcxv2KGCtJl1eaaJDNZ0SrPS5TogAhm
	Xs7usIWBPadAWMIiTdmBdeb8tUvM5mvQBeGWtDQFBTpCy8vrNjZ7a0IiVfE8TOVSKL9uhuQLJxP
	jwZCCRDinMHCxPQ5wRZelqfZECmK+dtjACo3ohgpg9YMxipeBKp1zHXhMIC/SPbVnOaCg+mA==
X-Received: by 2002:a05:620a:318a:b0:8cf:cee2:e405 with SMTP id af79cd13be357-8cfcee2ecf7mr270204685a.24.1774024541828;
        Fri, 20 Mar 2026 09:35:41 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc90e6965sm202081085a.44.2026.03.20.09.35.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 09:35:41 -0700 (PDT)
Message-ID: <ac4df3ef-1704-4a1b-a47c-6fe96ae1c01f@gmail.com>
Date: Fri, 20 Mar 2026 12:35:40 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] commit-reach: simplify cleanup of remaining bitmaps in
 ahead_behind()
To: Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>
References: <06000e28-c1b1-472f-bd6b-367b6c8d208d@web.de>
 <21adf042-2bd1-4022-8822-9ed4985122a4@web.de> <xmqqjyv7lnmz.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqjyv7lnmz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/19/2026 1:44 PM, Junio C Hamano wrote:
> René Scharfe <l.s.r@web.de> writes:
> 
>> Don't bother extracting the last few remaining prio_queue items in
>> order when we only want to free their associated bitmaps; just iterate
>> over the item array.

> Quite obvious and straightforward.  Will queue.  Thanks.

>> -	while (prio_queue_peek(&queue)) {
>> -		struct commit *c = prio_queue_get(&queue);
>> -		free_bit_array(c);
>> -	}
>> +	for (size_t i = 0; i < queue.nr; i++)
>> +		free_bit_array(queue.array[i].data);

I like this cleanup quite a bit, thanks! I appreciate your
self-review on the performance side, too. Thinking out loud
like that can help other (e.g. me) avoid similar mistakes in
the future.

Thanks,
-Stolee
