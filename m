Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EC130C0E7
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 15:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727143; cv=none; b=c5trtC5zSHvpmFIq4VkS34WJhwy5GRIg2wekIFGkUDqZbFAUm0G2JbPdL7KG2JmRrv9V78kQ3scUPwK3v1OzyL9F9AZynNJUpwWesbDF8+SHuL9Qaz1GjFxa9P9iA1U+moTaziFS0pPFAJJrfznT8iCAusEMkZSw0ie81PTz8M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727143; c=relaxed/simple;
	bh=a92C58D/6r45XFv2Sp4xLYx1A/HvkL7tSCsQhcpCWP4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ULkDK6mONKbNVe0W3IaEyGA6ZcRRTz9NEDS/rCj4iGawoJwGCqcWKLWYVH7CXAaj5ZHyuguvxRMB6nRnY+yDp2UmSnsqmDUYdz7yJbmMhiHXGbOWavYxtshv1KxjOPjLf5IiQ6qbjMtfEkaLiv2Q/y7aucRPjo4DkDtARhf3EMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEaMuf6r; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEaMuf6r"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3eebc513678so4912184f8f.1
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 08:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758727140; x=1759331940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U5oBGluOKo06slG90Bbd6EnBJgJMeC1CNqpz5PsB/yk=;
        b=iEaMuf6r+EOQDBhEAiTkqfXLWNW0wyqOOaNeZxXyxPv2ZKk0kzeeVMYUN9CW1ud1bO
         I7h65dzW2fWyKw0exbSeAvBe2zSAxtkDIvzSfpwR5ShV/lzKcLsy1+KUnqw7K4Z7I13U
         VYL9lcL2Irg011sr9/FB3nBT5GBeo5FoP/hPJm8ofWPrY0coNxDFGWyOERDVPwbc7+Mt
         Zl8mucdLIWhcRD28BM4NTnPvzR5LlcRD098FdcdRob9CiRPxsFcbnBJ0q3BYmAgMsnPy
         Ka8Z2ny040X/SSHoy+f+BwkVrhFVyj3E5hWDHlWutEaQrtovt03cH43PevnaYNbDBaq/
         zKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758727140; x=1759331940;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U5oBGluOKo06slG90Bbd6EnBJgJMeC1CNqpz5PsB/yk=;
        b=LHmH+Zh7AbDnPZYyoKHb/Dw8TZPIKkBWtMxKH9LpAvP0qR8y+A/Wg80/krNx1uwPjR
         7WqDZsEZjux35PsThM90A4JqPk0XvBpVXCrK5+XcDeo5mJFiMIpdPJxfF0YnCd/+pecq
         nfSZShzHnsw6VLhclNaJb1x/bzPynnCxm4f0W67xgPQ1ikJz+0u5Vn0FFqdl9FJhaqw7
         BiANWWlA6cRPyYM3crAFu/A+DIbgYyhYD1FNJwD3P4WU0H/Onr3z8UrUAU9ZQ5mHRN9g
         9AjggT4g/HajOfmEGFWMWMtCRsDVTszC9ibusg54t6FpqKSpqiafJq8LjF0XKXC+trmh
         Xr8w==
X-Forwarded-Encrypted: i=1; AJvYcCVDKGvWcR38LOq4kiPM/tKQy4stqOr3SMcZfQaAHfPWaCN/0rjrf5Dq4rcdcTLwxpUZ6Fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKckpJ6c2AwOlD03eo8Y4KKvptcUgRoyCqdzLUqsv9NhFsB99B
	FXBp/ogMzURrDHLUO9yqmkNo30oXrFQQ1IBTIfeUwZUm5iAFT1qe02RF
X-Gm-Gg: ASbGnctbYpK+ynU2U4ONPPEzmDcX7S+SwYuIdZYXUixDJNc3q9YRUdm8UKsjqqURz1n
	bIDyeq6WWM7wwSQAS16O7Of7wCSvQPd95JHAc0DLdqTXImdV0vj9NefAiYeR06wW5AmImF9kBjP
	bK9d0E3+QH3GBLbqrgqN6EkQAHXBCGkA/IPVaKqonar8qkuLdWeetwF7F+IlGFYwQyrLxjcNAIY
	+gJ63Z4PNjfxOeynwh5iJsSi/zoYrH97ko9WUmLWhj8iwJ3/LskHbSiZDTm85iA2Je7GE3+/m/H
	9jWaulfPcx5mL/otUR6m+y5w1Dw8pFpDc6XpCH8Glald6pNhIfhi/BuEmcEXmMT6G1PlrN2FKe/
	FbmpfchXoHhoyUkoYP9i6WxbAkMZ+hlIzbn5dpNfGo1GABI9KkKRsLSvaLYRHvPC+uE6Zd2o3aW
	c=
X-Google-Smtp-Source: AGHT+IErLVO6eI4j/HtCxin50UeLh8lkKFJgOEXmmHoO/Q0XzxKn0WOYh1GaNeJZ1Djg0aZmN8FeOw==
X-Received: by 2002:a05:6000:615:b0:3ee:f10c:6baa with SMTP id ffacd0b85a97d-40e4b850ab1mr279335f8f.37.1758727139545;
        Wed, 24 Sep 2025 08:18:59 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f88de2d075sm17069142f8f.35.2025.09.24.08.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 08:18:59 -0700 (PDT)
Message-ID: <6057413c-97a7-4b4f-add8-173ec6f74e2b@gmail.com>
Date: Wed, 24 Sep 2025 16:18:58 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 11/13] xdiff: rename rchg -> changed in xdfile_t
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
 Ben Knoble <ben.knoble@gmail.com>, Jeff King <peff@peff.net>
References: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
 <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
 <570ab9f8983d7507cd8f1937176f3268255da416.1758662670.git.gitgitgadget@gmail.com>
 <82ee55d6-f8ae-4a88-84fc-47c6ce18139a@gmail.com>
 <CAH=ZcbA+MLbyNp3f7RbMFA6vrDZC6yRKVh7ryVer1Ozg3d4oSg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAH=ZcbA+MLbyNp3f7RbMFA6vrDZC6yRKVh7ryVer1Ozg3d4oSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/09/2025 16:10, Ezekiel Newren wrote:
> On Wed, Sep 24, 2025 at 4:21 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> On 23/09/2025 22:24, Ezekiel Newren via GitGitGadget wrote:
>>> From: Ezekiel Newren <ezekielnewren@gmail.com>
>>
>> I agree "changed" is a better name but the commit message should explain
>> what "rchg" is used for so that someone who is not familiar with the
>> code can understand why the change in name is desirable.
> 
> The field rchg (now 'changed') declares if a line in a file is changed
> or not. A later commit will change it's type from 'char' to 'bool'
> to make its purpose even more clear.
> 
> Something like that?

That's great

Phillip

