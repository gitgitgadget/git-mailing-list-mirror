Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A589B305689
	for <git@vger.kernel.org>; Tue, 23 Jun 2026 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230102; cv=none; b=EKqE0MzWSPniTpwRxgWi92pml36pHIVEqN8lC4VZTlD+WzyDfv/dlgfBxrIiSnW81GwyXnK+yBBwh0PEhbCcMko8CPc7eMijicrqepn7XPCUwNJM8UWyMdjC7OCx8R3+OR5hQDBpOXhlmrImbcsRoEgKN0HY7E4iebHIMwZIK4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230102; c=relaxed/simple;
	bh=qTgL+OOU/tpJftBFuTuEK43uuaU7ota1DDUUiPUEQ2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ybv2PvDaoy9AcYkvPcTAI9NpbbiZFvd+qkyachV7kWDL2r6Hd/fv5dO/p/vhYKGXcg9RmltjYxaosaiJsGAAHVns5uDLj9px4s7LKsuWVXun8Ax6j8Rf0DIPzAWkMz0CCnii4UcunZn6dIkQWD+qj8AIhFtXJ5FyDSxtVAMk3S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=spcCkHLm; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spcCkHLm"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso11883615e9.0
        for <git@vger.kernel.org>; Tue, 23 Jun 2026 08:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782230100; x=1782834900; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2B/q8BZ+MDtwruFvvd1PIs4/mIL8vRbxtVfCj54Kkgk=;
        b=spcCkHLmBU918dRuyDbvQJiZgBY47uzWBlJz1CB1WGC8QzzQ8nN9zm6GZ67ZthTULN
         4U6FTEgcHF1uQmj9QlDuwM27JD1EHkHojmxfJ501x0DytbAsI8CktqFfzwbjCtWEOO0Z
         b8S8LJ8f3+BJCOuoo8EY/CZaVMXaWCguOmEYZGEGZk1MJphN6Qfih1oqanZUWn5SKZUd
         JfIJcHQ5POuqAVy2IlxhDVCh3RB++VcIK6R/+QZSmGRsD1hDGRes2ZPJQp62MEGBRbxm
         C1skVmRf3+DXUnoqt1F7GP01s6qW1fe7v3HwzJLHvCUJCLue1JjZ+YkdWqqBIxW4TJjZ
         hHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782230100; x=1782834900;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2B/q8BZ+MDtwruFvvd1PIs4/mIL8vRbxtVfCj54Kkgk=;
        b=kq779iTs8jzqr3SV6FNckevxwFO8f9SIvTh5uZcnibo4bqW5WYG2PrcXfAOwU83iGX
         cuE7lRN1SogcPLh03L2OVB9Yd9Mz86kjBKV+I0amULrZ76LhjQLn+wzTj3JzloTVVF8+
         VeuRj8lmPuCiu6uXfF36BVOFkyFbCILPaL41QwowABG9E3PrLyUDnK/IE1R/JsLOhJzW
         dvEhpcLO0bDhT3liO4nCxC9UZh4uvvr9N6999uBv4/WbDp4EB1yyY2ygHKtmxC5AC/tY
         y6D+QJz7E5KePH+CL/9Vl92SxHnkKmw+Bc1HMhIE+pvrZxm/LIazXNvv2XKAkjBgVgfI
         z6lg==
X-Gm-Message-State: AOJu0Yzte1P4UxJR6cpm4XAuvYgKo10+VvcmcMTVViudJgs6h3vQ8so6
	UQh4XbZhlgx8hwazEy0vY/xvaoPPwEkU1Yn7rysMPbVdToraa5vQfdkY
X-Gm-Gg: AfdE7ckogLAehciN7A1vMLajNM72ybhV06DfnFLYNaao7VF6F0U/7ksoZj/SzCSTANk
	kwDsgcNnaVdVZa9dVHbT47+3NGLYC3/Qqr1Y7LLereuEjGi7IaQfhkUoal4Y4TqbTNrikXVrYB6
	fO9iRXNfL8l/fdU5rD2pYmJ8HFAi8nw8890a51q4jooVYGgy7qf1B6OJgrUkwOL23amjFd3VRlb
	J4GCFIlUt1bE9w8E/4qaSeNmCiAze+oHAhOaSJC9A1+MmkGlpGULYfRBx1v8JXsefV1eWpvkvjw
	T6lyXy5wJ25KYtcriMElmICJ/x4xbNBheOBLEl+no6BcHynyyOT+wp4CeSanGTEget3s5ujY5fV
	t8v+HL61j5X/RVek6uqtq1u3Jv+LqktUy8eIS7eaOHY7eRBR4IqbFJGYtz3QOp/vGWBlUhBm4oW
	yr8hpb7dekk75oYpEPdMW7/JO5vB9x9iE+RLJJnCbsTqAAcAdXoVsaUyZLYgkshccGBeU=
X-Received: by 2002:a05:600c:5010:b0:492:1e36:9a90 with SMTP id 5b1f17b1804b1-4925a0da5cdmr58461555e9.18.1782230099982;
        Tue, 23 Jun 2026 08:54:59 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240f1f330sm240966495e9.2.2026.06.23.08.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 08:54:59 -0700 (PDT)
Message-ID: <57a048d2-89a7-4e0a-bd8c-733af6cc0b1f@gmail.com>
Date: Tue, 23 Jun 2026 16:54:58 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/2] status: improve rebase todo list parsing
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
 Patrick Steinhardt <ps@pks.im>
References: <cover.1776697483.git.phillip.wood@dunelm.org.uk>
 <cover.1782117361.git.phillip.wood@dunelm.org.uk>
 <b3514e9b1c9515bf1a7f7983b9f120d63edba97f.1782117361.git.phillip.wood@dunelm.org.uk>
 <xmqq8q86s12r.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqq8q86s12r.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/06/2026 22:43, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> +	if (!sequencer_parse_todo_command((const char**)&p, &cmd))
> 
> Style.  Missing SP between "char" and "**".

Fixed in V4

Thanks

Phillip

