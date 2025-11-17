Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E7F299A8E
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 16:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763397065; cv=none; b=PUmmcLqutE8rbuu8uNtX25duBxQ9RenYXkJqWG44RcFYM066PkRQuy66miGjUGlmxT1SPJG9OnRl/55o4hEd38e/svwXHN8KYAv/FgGXBrmH8yRbMAJhCQc1ixTo7y9zcfu1+kAJaqWmIoXNutQNlkl6CFPFdWlmTz3m7LKtC/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763397065; c=relaxed/simple;
	bh=/txmGPzEKLHU6A0HhlMYirb7fghJP0y9h4l9TS2qLRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BJ+r0C3emxpvbSqqTeb8HxYUj5rtjkPlYuyDn2HtBxjlkUM1g9doQuo6B98UQoQK9gaWIESWtMT1fuc3BHS3hHxqNvFvhiq37E0X9PQZWFd/vnnz8x5rv+03PxNmdj4MSgk7ZABTpYDdYkNBDtmJI1aDd2I4T6GPxeQko41lDw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INhP45w7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INhP45w7"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso23865615e9.0
        for <git@vger.kernel.org>; Mon, 17 Nov 2025 08:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763397062; x=1764001862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=31WiXQQb4yAJVSAE891O86Aqe5DfOA0oo8+iLG/X8RY=;
        b=INhP45w7YBYEB2w65wUBGAvFKfaxGYz4DG3wjlsZrHNlbddBlDLf/lbdovNkwLkVAN
         mdhR1rreoqDFmlk6WBX8/FCKWM5wlERQ+tW+xPKF1VFwW2glX6B3jwLWa9Q8S7N+Sm5b
         aDQL2bKRwa6lb+/IrliFjuLYKiO2hG6MaQRoPMjRjboXjhThO5/TnK8eDQXsMMYd47KT
         zLw7rfHI9lAaOkWaav70eZgipTiN+UB8ZOkXZa8thnfjStOYNfOlWLU63w736LZhu6pv
         ZSSdy5JkWhdmMnrBXT++9OZfGxiQAcWXudexboYkU7fkkcrgWflNuIFc0gtz488u3JDi
         J9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763397062; x=1764001862;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31WiXQQb4yAJVSAE891O86Aqe5DfOA0oo8+iLG/X8RY=;
        b=Mu/yLWipt/yzidIvTCssKlVgQlVlPGp5Nd/zo+RMoVgJ/AkttOvxZA0oMHK6APUbTO
         HIqtbIG50I6TgPHtqSrmURUyVLZ0Wom7qbbYdthJRjJ0OSc7QPMaGevJOOm8kmLPKMy9
         QiUshE7k3g3d6KnKkgyEde94OnN0UYk3iXZmSBpjsc6hMd3xEDjI2KUxbM3sILWcHXGr
         FyLtbZO3OpAwQ3ROWXrWU7F1DRYtDXpBcM+BzYmRRirCo6KGcxZ+eDgM2yL3OU97yKJ+
         64CIt5k/x0KVbO4VmfDyBZvX24lJhQSgUvf0/fGX5QO44LUDXDNvhbznrcYrOxjc6PTH
         42ag==
X-Gm-Message-State: AOJu0YyeohJquRCDG6VyJRLa8oG8tdY5WzUnO9Yj3zH7kG4FlXuA+DUt
	qnEVGoW1Gx4C0KRsl+Z901euMJYH+Fhnp9MQgM02pUcUpHlf2GmS5IVS8VKecg==
X-Gm-Gg: ASbGnctmH5T7Zd/7meUj2ZhW4abL8BXhV/uRv5H4ml5zKjPuTcuZRpBOMD66vq8KhWv
	qxzQYTWykJreWvLKQpYSUVayGPzr6EAqAl5pTqXhsmp8Op1bxFIw4qbMfQApR/plOcGBdqLWjUh
	XpeME2/W0KuBXL5f1SJtCkFwd/afqN74SzphQGTLmGpObRo8nVzkTu7qm5zKiE3UmET8GSqt3XF
	nJlYa0rOGiXKuQE0pn/Hc/ycpXEF89jk3LIJdO+hZRmVW1CboBRWLJrvGz2bPVvyotmlvCyoaFL
	Q2HxDlzu2CAafeeLL/6pUDgcdx3r6ikKabbebM2C7ToMs1ZHj7koYFJHpQ71ZxARiRi8zhhiw4U
	doqQAolueiQdhrKCkm21PcjkMhW1Tnj3fmc/tsekoJso24iXp2YDq8hG0sCP+7F6xPDwWSpK96l
	Qa8DDd/qSjj5Bur/F/LTFe9wmA4EzUBzt/dX275GlYXaZSzUwXdmLy7lBsUxv/fRU=
X-Google-Smtp-Source: AGHT+IGkpBBG+zXyaLMJi4dM/kLnOvhAQ6XtzFIn8vLHBz8pfOvCrvcX1Fcuauh6dUoFCHjlvw9NcQ==
X-Received: by 2002:a05:600c:4505:b0:477:7a87:48d1 with SMTP id 5b1f17b1804b1-4778fea8810mr136410445e9.30.1763397061378;
        Mon, 17 Nov 2025 08:31:01 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e36ca3sm340056795e9.5.2025.11.17.08.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 08:31:00 -0800 (PST)
Message-ID: <a407a793-9636-42ea-afe8-1283b1e220b7@gmail.com>
Date: Mon, 17 Nov 2025 16:31:00 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Nov 2025, #04; Fri, 14)
To: "D. Ben Knoble" <ben.knoble@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <xmqqcy5kgsjk.fsf@gitster.g>
 <CALnO6CDCzNbYFC4BGmqC5bhou5rtie7K5OhR_cP1CXJfChim=A@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CALnO6CDCzNbYFC4BGmqC5bhou5rtie7K5OhR_cP1CXJfChim=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/11/2025 16:51, D. Ben Knoble wrote:
> On Fri, Nov 14, 2025 at 5:27 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> * ps/history (2025-10-27) 12 commits
>>   - builtin/history: implement "split" subcommand
>>   - cache-tree: allow writing in-memory index as tree
>>   - add-patch: add support for in-memory index patching
>>   - add-patch: remove dependency on "add-interactive" subsystem
>>   - add-patch: split out `struct interactive_options`
>>   - add-patch: split out header from "add-interactive.h"
>>   - builtin/history: implement "reword" subcommand
>>   - builtin: add new "history" command
>>   - replay: stop using `the_repository`
>>   - replay: extract logic to pick commits
>>   - wt-status: provide function to expose status for trees
>>   - Merge branch 'sa/replay-atomic-ref-updates' into ps/history
>>   (this branch uses sa/replay-atomic-ref-updates.)
>>
>>   "git history" history rewriting UI.
>>
>>   Comments?
>>   source: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
> 
> But otherwise I generally am in favor of the idea and find it useful.

I agree with this and I'm pleased it is reusing some of the internals of 
"git replay" now. I've just reviewed the first half, I'll try and do the 
rest sometime this week.

Thanks

Phillip

