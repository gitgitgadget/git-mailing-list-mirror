Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F8F2BE034
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 19:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780947538; cv=none; b=fmpJAvvtShiUO7zuCPrRnzzfbPLH9Zm5zQENhE3BZ0u4sNwNX9fy5+Mzqhe7b7NEy1jJiLpewAD+Vf4ylC/ENEHQyiYLT82WrZSQKQPMFOu/7HmtKGkSuy8ipytmR5WuIphIlhkXA5PbvDHSCucvv16OCLeLYqbEKOeWZX6MfCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780947538; c=relaxed/simple;
	bh=QDjxT0FyejakIp8iXrvHQsmINTrVefsDt57gdS3n+J4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mJpd8/XosW+PupaC4ptDEMDzi/GKqErh1Su5C14NunbgpDYmhy1QciMaNizIlNjmWi4qYx66xBEHJfa9xRLWst80Ds0fOqEaj7gwaEOwsU5D41anbiPgEYNcEZzM7Rx693Jl5eRNEHLTpQ75taOVrqMZP0yZg8rxlTRaXgjV7iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sXpyhGDw; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sXpyhGDw"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-91591f19c30so734738285a.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 12:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780947536; x=1781552336; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gfdeQhtmIQC+ES7D+JpyzQEpqxbjVjQOeAblewyhrFY=;
        b=sXpyhGDw6yqt6xf18/FN48IlnP9DWJ8wZsITvkc//xt6INxDk4BeC/qaSe7Dz6iPIB
         Gbra6f+qp5c2nc3UJJavvYBaGeilloj/VnW3j7VcL6Z+3S13Ci8crfld8FAyehmZzu+e
         o9E8ovLxU5apjN92O7e0MXjSRcPQOPJCyNrKEY8TYiwFP9gdoMvny5GDEIWnLwlGbb1i
         QZaQUTJL0WNwtmrktQjLyQ5wkeMEoqI3JFYvPpfWdXlpbCbo2tOfw2RvTb+pMJkzzFoW
         lGhQCLd1n3MDJtoGO69ISh1wQUXXVuofiTJu1+zVI2EOi1Juw3WbsLFaQ9qRZFPAIEBn
         eGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780947536; x=1781552336;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gfdeQhtmIQC+ES7D+JpyzQEpqxbjVjQOeAblewyhrFY=;
        b=A9lTe7uL4vOYJldmz9S/lDefKo4Bf8wr39z+PaaonRjqE/OY/dNq+7lqf19wXYUVd9
         ltnxwT801D/ymWwelxuP1c8hpqpYwecll+YtmfOAP3GKuK+nCgW5F32Q0CdqpYYL+4bY
         dQOjcOvYg8DJaErGeSYI2A3CGONk+YTLnGzvbOhMxWrRSe4rvziHBIwZv3evU1Yabrfm
         sflzHIkhrVodq9F5WPV8MvcsmnZU/AJUprywfxNVyP99585V3B0gfTOSIQoQqXP7sVc6
         a2tylwSzE0mh6Ku+Uq05TKR1jInF/EDuRzpRIl6RQIrRukRr34Y5RehRrsIPwcqrWTHH
         3pKw==
X-Gm-Message-State: AOJu0YzplNtX0VRv/dW76BQ/E4/tQgV9+UvHIom3oib8owNkKfPzT+n2
	Q1WvnvQ82sXOc+Iv0XsBFdsRgG19yM2joAwptVL5AdWIVH+wzfTq++nwYL6lig==
X-Gm-Gg: Acq92OEzBMgvaABEHRSq6Ci966oRsL2uzLPKbcj53hgiI9QVKrZwdtE5ZiHLg8U9CyB
	2bXevCnUBQBT3LljnHr9eMrLGvcX1gwZIOtM7ze+LqIlzlT2S+35ITWfcXKRl7nr4bdYulB3i77
	L9NVaaOK5x60oKbPBzmoz9XYj2aJV+BRE765qhIs+2X1UgD/k837olgULBRp1rfhc083yrrTYGY
	gPMsjjha/B2KGZrRWmPDIUEUqBOr/+6ePLt0fJ0VQBPlfROpitgBcTX4OhnJ5ibuT724LA2rg8H
	HLVpC1Z6X5NnycOnlvskPwk+RZBaI7n706qX+Hm/hNXjtAUznU2T6+ISoid2HbyRIBLQA7s2WsS
	i6tSwUowx8cQ1RvSnI60R5xU76ZEf4ld8R9sM9nBuqp/OIw3r9QSpciyMI2lmgxgk1+DOdLMPVs
	m7w9wZpjajf0g5nGIpjq4wcutL7Vyt+p0aBSYWELA2WbN6FpKDapLqG6VnkGnh3HbeAf/I2MPtX
	NY3TkFB
X-Received: by 2002:a05:620a:2305:10b0:915:a4c1:8c34 with SMTP id af79cd13be357-915a9d7657amr1993304485a.38.1780947536169;
        Mon, 08 Jun 2026 12:38:56 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a243f24sm1851075585a.20.2026.06.08.12.38.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 12:38:55 -0700 (PDT)
Message-ID: <dd971b9e-2c13-4521-b991-b9bee1c5bf5b@gmail.com>
Date: Mon, 8 Jun 2026 15:38:55 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] config: add GIT_CONFIG_INCLUDES
To: Patrick Steinhardt <ps@pks.im>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
References: <pull.2139.git.1780927027.gitgitgadget@gmail.com>
 <b48fe9f7abe794864ac4470c2620048c2e5e6b53.1780927027.git.gitgitgadget@gmail.com>
 <aibTAOrcSvTOtv78@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <aibTAOrcSvTOtv78@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/8/2026 10:34 AM, Patrick Steinhardt wrote:
> On Mon, Jun 08, 2026 at 01:57:05PM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> The config keys 'include.path' and 'includeIf.*' allow users to specify
>> config stored in a location outside of the typical list of config files
>> (system, global, local, etc.). For example, users who accept the risk
>> can specify helpful aliases via a file checked into the repo by pointing
>> 'include.path' to the position of that file in the working directory.
>> This is dangerous, but people do it.
> 
> Huh, I never even considered this use case. But of course, this is
> possible, even though it's quite scary.
> 
>> What becomes tricky is that this modifies all Git behavior, including
>> operations that are intended to be limited in activity or sandboxed in
>> some way. These include directives can provide surprising changes to
>> behavior, especially when expecting a specific list of allowed file
>> accesses. This could lead to failed builds, for instance.
>>
>> To allow for these user-desired features when they are running commands,
>> add a new GIT_CONFIG_INCLUDES environment variable that disables these
>> redirections of config when set to zero. This variable can be set by
>> automation, such as build tooling, to avoid these strange behaviors.
>> This could be considered a recommended option for tools executing Git
>> commands, the same as GIT_ADVICE=0.
> 
> I don't know about this part though. I could see use cases where the
> tools _should_ read the project-relative configuration. It might also be
> the case that the user may want to evaluate some includes, but not all
> of them.

True. I'm not confident that we should recommend this environment in all
cases.

> That raises the question whether we can introduce the configuration in a
> way that it allows a bit more flexibility than just "yes"/"no", like for
> example an allow-list of locations that should be evaluated. But maybe
> I'm overthinking this.
I see. So we can say "avoid including into the repository worktree" but
that will probably be incomplete.

There is room for nuance in future expansions, if we can find a creative
way to handle that nuance. For now, I think I would still want an ability
to turn the entire feature off, at least for certain tools that care.

Thanks,
-Stolee
