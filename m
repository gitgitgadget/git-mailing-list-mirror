Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB8A1E86F
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 18:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708109266; cv=none; b=QZiN/59wuMNetoOCrHgB8japS9PyjmalBciqfNxV8s0zwr/WUfPDLBI7lW8/cNah4oXMQTD9gVeaC/9IGT6Cv/12Dz+P7Pv589yypKiLYTiMLBTOTBVJXrmES61uuxNYdOeerChmvAFh2eyUIZwIRMnNuf3ghPtv8J/Xn59sgzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708109266; c=relaxed/simple;
	bh=WpESM+oD2NEvvOWX5nvit8zg/RBX8ngpCQ+DR23KYpQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lVHunQuzWLTd8OZ2LV54AVEiirdBebP34aDNyJXoup+rGgJzVJw5+bUbj1U4/5CDewRKrw1yr34As1LpMmQx8UCyyIm27/P4Y6rACQeCOFznZn4w7DepPuPdm2t7R/s1dpozcRd56pFHU7uGpXAA0Nh8LpSGYwaGw1cmpUhySkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhrtO7MI; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhrtO7MI"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-785bdb57dfaso279647685a.1
        for <git@vger.kernel.org>; Fri, 16 Feb 2024 10:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708109263; x=1708714063; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RolayLjujm3QejMDMEMjfpr0YpdBgtCdv5cdJcGauco=;
        b=jhrtO7MIIt07KKfl+33rj/OY/YB6kN54P1BMQASN6YIDKqMPvd8MjWIjKQ74fz4Esk
         8FRwfq/OJM+60YMHAjEqvMlMBNXQ7cMM9kz3NV9lCLY1EnmCQeZLVu1e8YxFislMQE0K
         JNtVj9OEXjdqoPEZRtdVvNhzqn63UKrK21Z+CZGDF/cbgaUatydGt7btFUCVjUqLizwp
         vZ8NMtWcQf6TS9E2HRINmeU8u175nVl1X7bHOaygJf5U2PMihqFjwFwbgh+JXBiQ41aC
         0FRBOujnrc3uf/tsdVs+gPXamV6U+6xYbYrbO7J84av/htG1ZNmyM5RDKQVudH2OLqgt
         7O8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708109263; x=1708714063;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RolayLjujm3QejMDMEMjfpr0YpdBgtCdv5cdJcGauco=;
        b=EdkIC6mO9DmmA1pgWFL8mZw/qjVJdp/3f3xb+laBSjabr4H2HgSwAymWijzTtCN9fU
         mha/SN/VF4AO55t0eXBYDjq+OHjUvL9fwD06VpDebEgDyVTEyReABks5QKyoLnZJw5au
         QPsmjJNfg+yE264gSzLWw7vA7nxeD5PJu+7Ua2lRmVJxfDBGqSvaUU+uKuTVEEHnwRAx
         PuDFYAo5OIUo5XvSx3uxa7J0q0XD+NafVol/9uovmlRYpe6TaiT0YK2q8d7doTRBbyv1
         OYDNsRS0Ww3PIuzmYBanq8UlP6JL/LFugWFgO6JSt5WOVQ1rf18IlUM7kqVC64KTzm8X
         5QDQ==
X-Gm-Message-State: AOJu0YzYkte/1HR/pBAn9sxfw89U/O0zDgTrozgyutRJDoi1NT6HVj1k
	QfaRG5ooI77m4W1c1dUz1b8rQR54Ef/c4nvjClEz+gqar0XXdBLnS2brriU2
X-Google-Smtp-Source: AGHT+IEM71qgfZyZGmMTb2ezKj5+AoiUukBAgbA1hx+WC6FFBb+EpxnY1dvr75aSlOD8N/zTbxPeKg==
X-Received: by 2002:a05:6214:4b07:b0:68f:1178:6911 with SMTP id pj7-20020a0562144b0700b0068f11786911mr11674356qvb.12.1708109263492;
        Fri, 16 Feb 2024 10:47:43 -0800 (PST)
Received: from ?IPv6:2606:6d00:17:3855:1496:5298:e845:1591? ([2606:6d00:17:3855:1496:5298:e845:1591])
        by smtp.gmail.com with ESMTPSA id lr10-20020a0562145bca00b0068c82e2ea33sm164567qvb.135.2024.02.16.10.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 10:47:43 -0800 (PST)
Subject: Re: [PATCH] completion: use awk for filtering the config entries
To: Junio C Hamano <gitster@pobox.com>, Beat Bolli <dev+git@drbeat.li>
Cc: git@vger.kernel.org, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?=
 <avarab@gmail.com>
References: <20240216171046.927552-1-dev+git@drbeat.li>
 <xmqqr0hcjorg.fsf@gitster.g>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <fcd3f999-a8d1-9f9d-e8fd-071b38124edc@gmail.com>
Date: Fri, 16 Feb 2024 13:47:42 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <xmqqr0hcjorg.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Hi Beat and Junio,

Le 2024-02-16 à 12:35, Junio C Hamano a écrit :
> Beat Bolli <dev+git@drbeat.li> writes:
> 
>> Commits 1e0ee4087e (completion: add and use
>> __git_compute_first_level_config_vars_for_section, 2024-02-10) and
>> 6e32f718ff (completion: add and use
>> __git_compute_second_level_config_vars_for_section, 2024-02-10)
>> introduced new helpers for config completion.
>>
>> Both helpers use a pipeline of grep and awk to filter the list of config
>> entries. awk is perfectly capable of filtering, so let's eliminate the
>> grep process and move the filtering into the awk script.
> 
> Makes sense.  

Yes, thanks for improving that!

> I wonder if we can have some simple script sanity
> checker that catches things like this, e.g., catting a single file
> into pipe, grep appearing upstream of awk or sed, etc.
> 
>> The "-E" grep option (extended syntax) was not necessary, as $section is
>> a single word.
>>
>> While at it, wrap the over-long lines to make them more readable.
>>
>> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
>> ---
>>
>> Junio, this goes on top of 'pb/complete-config' which is on next
>> currently.
> 
> Alternatively we could redo the topic, squashing this fix in, after
> the release when we rewind 'next'.
> 
> Thanks.

Actually you already merged this topic to master in 89400c3615, so it would 
go on top, no ? 

Thanks,
Philippe.
