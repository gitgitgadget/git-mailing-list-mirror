Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F0B38F233
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 08:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782117403; cv=none; b=KZsGk78F10zdHUn65MqDNgfDmQqa/BpUDk/fHdvs9gRfO56ojVsXq4A89TkYyGxQH1Zv6+BShE828yIHq5BijcVcPtKuf7MFkCVHv8P9BpJWh1XjtnlzSklOxv6Q7OqT8+CLe0xCiLOe4aQ8YAIaEiryCFjDd/5TfV6ODhGfBcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782117403; c=relaxed/simple;
	bh=f85fpMv1MrpjUllKAF4Mt0I6Eou3v16RA8kvGzBUfkY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bcwSJdxRkt6Fghya9DdUu1zv02+D07gvAzh8BzkKqZzDYXcBW+iAHvFO26OlE6pmuGLAaKs6Eo/DfeNM0+H/vRXFdQTI81jj1rM5khL5tdeFoY1uN2sQUIBSQU/Kj2SGmERYyNgZzfO2B0TBfWE+4yIZpBAbgyV/F3OdkDDzvSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+aMu94T; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+aMu94T"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6974f511dd3so3749805a12.1
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 01:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782117401; x=1782722201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h0hoNzMa1hVWDX/ZRNbBmSEwT0Pmd9ruA+PFt4RAdis=;
        b=A+aMu94TqPgTku1eTx1NOsgLULPLcOU9K2orz+9oBDgfN2PjkVGYN+gblDSveUf4OW
         9rUVcArCJ72cXXqo5LKXhVra23FfpPEQ7fsXUe566c5KMLxD2RS6ExsvuhKmU36UqOEO
         DEkj9Eodn58/xfDQ2vhqyX78YwizqoJMKkdRkaemxfKrxyeXaFj8HsaXMG5/1YTgakbD
         CuHgLyRf9ZcrkzTAyrrULculcAkmW94dz5iK9ee8hLcbRk4xwHKNSMF+83CQUN36N3f2
         6Yi7seWidTXVMa0/BrQzWn9oYm44NFiIYpqGO+QmD34YhRMec4nX1LQF6+vpj9XKbn3r
         EE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782117401; x=1782722201;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h0hoNzMa1hVWDX/ZRNbBmSEwT0Pmd9ruA+PFt4RAdis=;
        b=T3X+QYP2X2OyOcg5nvDOhXtVxwFW24mXKSf0U6R9AaOz486Ktz/PZhqkpDV5xOblhm
         Sw1qZEJTZRX8eJpH8Sa3n09b6fGuJMWJydYEosoZkqeVheEDhf5h5De6W+w29Fj63Ok9
         VFiIjCtB+27ysbrUOJPT1SnMduUuwOtrWnRE25xdEquCZpeEdVdOtqGRayYKNN1Dz7ui
         5L1LUhG296sVs78ofB+ICcmnzoxvN4nUADPPMfrBfPtdwkNpiEiB8hm4sS0KpLeGMCYe
         le86DyZpNwSs+g/CK3DLcglgFa7Apnxpr2McdE0fHFuRHfp0l6XTE43FkXCi5Whq4jGr
         j9Iw==
X-Gm-Message-State: AOJu0Ywin44yhexmrkn+/fztltfdOO3C54yxJV0uSnvTtQ+S7xocVeqA
	cYyTbHKrlNgo+0xQi2JsfojUJgIxFF3ffalcRq3d9ROaaU5z/yfr0vfI
X-Gm-Gg: AfdE7clKvCjLj5sAfiZzSVHS/+l/0CQ4VHH5junwdTCZNzbAYBRnN6KnOKaycwTMw9q
	11O3EWN7c80MUt5aejmkfY+2OHkr9SzkY9xYgCa5UGVdugwv3BDV4kN8izabCWk15ChfDADOIWw
	3LtDRhGpfkTkRDP4egCJVN/YBUzqxEMnhZDGpIHehI8bZyFuAny+s8T2ggCJHXXK4NnNBIS394+
	l17jOD6TT5yZeQVeqhbjk3KlGzpblS+ZwJWIVWU7PWh3hDWXmbPCoU2wAecBl4WmbF8QBXx/VD7
	ZaBTWkL4QJI4wAm40AezrcOC8OrnRvrpYsJGv0AYjk40u5McFv6t42rzA41Kz7QF3CSKp+1ouWx
	YyU7moN8wVuBExXcCErnl7njCz1jORqHrAr0VtABWnumS83Xr3dh8ZHrQXEiuaKiggA50ay+T0o
	4EaJoQabPpgDyjuEJeDw8iYVOcoiLTsw6lffGHRcZAjQe4aFz2ePzNlbP5kq9n0HiNIvI=
X-Received: by 2002:a05:6402:a50d:10b0:697:5efa:ef21 with SMTP id 4fb4d7f45d1cf-6975efaf64fmr3593247a12.9.1782117401040;
        Mon, 22 Jun 2026 01:36:41 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6977be31c73sm2770445a12.17.2026.06.22.01.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 01:36:39 -0700 (PDT)
Message-ID: <056b742b-7a9c-4b1a-80d6-1fcc7c51ad57@gmail.com>
Date: Mon, 22 Jun 2026 09:36:31 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] status: improve rebase todo list parsing
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
 Patrick Steinhardt <ps@pks.im>
References: <cover.1776697483.git.phillip.wood@dunelm.org.uk>
 <cover.1777648598.git.phillip.wood@dunelm.org.uk>
 <b80bc1e0a298e2773a2fdab3e73651d59b8d39b7.1777648598.git.phillip.wood@dunelm.org.uk>
 <xmqqbjdwcsno.fsf@gitster.g> <4fafee2c-4151-45f4-a842-17d6b77d951c@gmail.com>
 <xmqqqzmdoya9.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqqzmdoya9.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/06/2026 17:08, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> Hi Junio
>>
>> On 31/05/2026 01:46, Junio C Hamano wrote:
>>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>>
>>>> +static void abbrev_oid_in_line(struct repository *r,
>>>> +			       struct strbuf *line, char **pp)
>>>> +{
>>>> ...
>>>> +	have_oid = !repo_get_oid(r, p, &oid);
>>>> +	*end_of_object_name = saved;
>>>> +	if (!have_oid)
>>>> +		goto out; /* object name was a label */
>>>
>>> Can there be a label "deadbeef123" that is unrelated to an object whose
>>> object name happens to abbreviate to "deadbeef123"?
>>
>> In theory yes, but I had assumed it was so unlikely to happen that we
>> could ignore it. If we want to be more careful then we could add a "bool
>> maybe_label" argument for commands that accept a label or a revision and
>> check if "refs/rewritten/$object_name" exists before trying repo_get_oid().
> 
> To me, how rare the possibility of such a bug happening is of
> secondary importance.  What affects the decision more is when the
> "rare" failure happens, if it is immediately obvious to the user,
> and if the user may be further harmed badly if they used the wrong
> information given by the tool due to such a "rare" failure.

That's a good point - I should have been clearer that I thought the 
consequences were not serious so and while we wouldn't want to 
misinterpret labels on a regular basis it didn't matter we did so very 
occasionally.

> It would be a huge plus if the workaround, when such a "rare"
> failure triggers, would be immediately obvious to the user.
> 
> What we do not want to see is that the tool to create a wrong
> result, cascading into more problems, silently.  In a sense, it is
> even worse if such a bug triggers only rarely, because it would mean
> that the users always have to be on the lookout.
> 
> Having said all that.
> 
> I suspect that the OID in the output generated by "status" after it
> parses rebase "todo list" is merely meant as an eye candy, and the
> users do not _use_ it to decide further actions based on them.

That's my suspicion as well

> Or do people stare at "git status" output, find an interesting
> object name and go "git show" on it or something?  If not, then even
> if such a failure were not rare, it would be OK.  We may however
> want to record i as a limitation of the current implementation in
> the end-user facing documentation, though.

I've updated the implementation to check for a label before trying to 
abbreviate the object name.

Thanks

Phillip

> 
> Thanks.
> 
> 

