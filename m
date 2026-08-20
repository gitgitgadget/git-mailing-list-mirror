Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27857318BB5
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 09:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787219941; cv=none; b=WgEJGsgrqUITrDSLDMVAyavAwQUBx/ckxM85JHLdzDGMhQXh+sB5YMYXvOPVQKrf0m5lnId9pPGKcfILf82jsOGZJ9XhYW8noSYYV8HqtIDjLUuS2YQTIBuaOhIe2Inb4iQIl2GCN0kwDLbcB6OTERxVM7qhDceCPF2JueP36Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787219941; c=relaxed/simple;
	bh=Q/zq400CeY0dA0d5ywlMWheyebEpEFuKaW5PbFduLAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KYAGL3wxSt9POcq0xnw670uqmtuFIFkqeSRny3oqEV3r4iBt+1jt0QvbsMWUjkdqy9TWX3N/8pg7MEeghBs4y2lSgY9V2VSt4yuIUEk8EIeCNR4NWRPJf6RTEUuu6KiC9pa9YbWUqRIRcPRcEHduXlmjv660rLSZr5jp2+beQew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvYO1h5W; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvYO1h5W"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f7872abb6so987620f8f.3
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 02:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787219938; x=1787824738; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j0NuKazuhgvx7q3/V+2pD1el7MoPYhtPLQUxYSMrFzw=;
        b=BvYO1h5WyCyW0qPahs6DPZeSD9bVw7ibaEHyFI2OMaGreL29nQ4Do6OtspO3/+3Gd6
         wHkA206rJPAYqr35R5oY9DXt2ZF0WcOOMr3+F8K5mytuqfvSfSqYBqnIoFRyoczdqBzx
         sXhWUdeyXNi2QMmecSniSnh3jE92FDdJ/WGs4OeESt9shLvIF1t8Q4/vCE6lfeRGMznF
         8xIIoBNgHt/ZoS7R3YnRpxBeOwcfDHXOAEZpz1hJPhxTap4IFZFwwuuAKXzoGUeeaAL+
         m4dIejGy9cClbimq0qtwgNTF3qUArbnwVoeNZiEoaHgDs66kGSjmakJFSBG1DRcQVhzh
         8rgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787219938; x=1787824738;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j0NuKazuhgvx7q3/V+2pD1el7MoPYhtPLQUxYSMrFzw=;
        b=Cs209v/I3mlEzv37phqhyYZtp+KTCw247caS0JoulpZtCLwsc9QDoSLHjMTidmWQrQ
         sKVWa+WfV31eBMZa5WmEQfYzO3jN0gf+OVT+s+DC+5YuML5yn2RrJzDESfngoxPdrP62
         dRzz3IWj5m4+jFluhHWOJtxFAdmtZ/IjqjoluuxWE4pK7XZZL7igo295gkxyHlh39r2O
         a+UokKmLLuycUpsCQctvcuHZoGz74Pm3OR/Ebn7qgaTJmk54UIlDXAA9o0uPFPKd91y6
         F8w3PrbKtvtXy9qYhGqzOoh+41U2eSOqJhLEF5nJ9iBbQSsQSOiSZpPc1xY/Z2n3Z8X8
         EI4A==
X-Gm-Message-State: AFuF++k87lZXp8DchRIjng6k6H8TboJor8e0tPl5cVA5DhJkAnaZPcdt
	AtFMqu3ZB1lLLcnXZWgtEzhOriPR00zZo5dEJHpg4BrL4R2pkStOnTKX
X-Gm-Gg: AR+sD13IEkg7hgVaTWMzTBPdFHTmn9+ndXOPR9/Ax+zq1abFBynvd3lxGKLf7Nxo9Xu
	9x+c1/wqViAWriJ6DCRHLg0XaAiERJi0E/DRVqKg2NJGZDzX1ClC+iq0q6SSydAyFQHNNKLFc/2
	O4KD/uu5vXCC4QeId987WUYM5jDrF1faAkmnFppE7jrHswzclxauYs5on8LS88Em+8jWGdtj+AM
	ElVZcPHjG1c5rR0hfSdZ9IE0Pwbb+twpa03VsYN1JfTiZTg94yGXiAUtMfW1CFByTQGRgvc1DFq
	fi7AdFk0kUtE9H0E5cU70+OdZvo0hNADx/DVpidB4SiKor/Qzy+riT9NzHJTMNHwtOHvIHNrufo
	0JiUotnD/imw+uI15RYoXdbmjYM8dZp4vhH4h/u/phtqG++jimYiQBjElNolblKPYn8U+9FjpDS
	H4s2zkFXSylg6HjvPUn8gXHEpTBPHSMn/KpmryInd7OCLKdE8tJzSfSjezydCh5yiiHxNvI323H
	eGjZ9unP6o+Pvf0oY0fvfW/jiTA/NuE9cEKuhlH6Fo=
X-Received: by 2002:a05:6000:2388:b0:47f:f1ab:9075 with SMTP id ffacd0b85a97d-482b1fecc54mr17732627f8f.20.1787219938155;
        Thu, 20 Aug 2026 02:58:58 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14c46f2sm13614623f8f.29.2026.08.20.02.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 02:58:57 -0700 (PDT)
Message-ID: <0c2607e2-16da-4efd-879f-82ef2c2aa127@gmail.com>
Date: Thu, 20 Aug 2026 10:58:56 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] pull: add --hard mode
To: Junio C Hamano <gitster@pobox.com>,
 Artur Bieniek via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Artur Bieniek <abieniek@antmicro.com>,
 Artur Bieniek <ar2rekb@gmail.com>
References: <pull.2384.git.git.1787052873141.gitgitgadget@gmail.com>
 <xmqqwltn1o4e.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqwltn1o4e.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/08/2026 15:48, Junio C Hamano wrote:
> "Artur Bieniek via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Artur Bieniek <ar2rekb@gmail.com>
>>
>> Add --hard as an explicit alternative to merge and rebase. After
>> fetching, require a single integration candidate and reset the current
>> branch, index, and working tree to it.
> 
> There may be a population of users who *never* make changes to their
> history or working tree, and always want to "hard reset to the
> updated upstream".  Doing so would be safe for them because they
> create nothing in their tree whose loss matters.
> 
> Giving them a convenient and safe way to do so might be worth
> considering, but the behavior is already safely and explicitly
> achieved by running 'git fetch' followed by 'git reset --hard @{u}',
> so I am not sure whether it is worth adding another way to do so.

I think if the design was slightly different so that it errored out by 
default if there were uncommitted changes then that would make it worth 
while as it is safer than "git fetch; git reset --hard @{u}" and would 
allow the user to carry over those changes with "--autostash". So to me 
something like

	git pull --reset [--discard-changes | --autostash]

would be a more convincing design.

> More importantly, throwing it into 'git pull' feels very wrong.
> 
> The core purpose of 'git pull' is history integration.  The command
> is designed to help those who make their own changes and advance
> history.  Adding a destructive option to the command makes it easier
> for them to trigger it by accident, and unlike the main target of
> this new feature, they have things in their tree that they cannot
> afford to lose to accidents or mistakes.

If it refused to reset by default when there were uncommitted changes 
would that be safe enough? Uncommitted changes would be protected and 
any local commits that become unreachable after the reset can still be 
retrieved from the reflog. It's not quite the same as integrating remote 
and local changes, but more like updating the working copy.

Thanks

Phillip

> So, I am mildly against adding anything of this sort to 'git pull'.
> For that matter, I am generally against making it convenient to
> discard or destroy history.  I prefer to keep these destructive
> operations explicit, e.g., "fetch + reset --hard".
> 
> Thanks.
> 

