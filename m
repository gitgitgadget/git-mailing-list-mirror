Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F535C8F6
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 17:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707586029; cv=none; b=LQgGwjRwT2DEEUN5zb5KeZtvggElkbLBrQn8hECZSWsf1jrsTsEyYvJtayHw/LDdZo48snMACB+g6zLmIEqseMQtaxA/pW86A/f8jZZG9iyrOPVBQZcZXqFWCqrTvc+djY/rsZe8ZlrU6nIFUBkCQUJzCWZia2w3lTbyq6AanSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707586029; c=relaxed/simple;
	bh=fIWzluyMUqRM83RKaJVIpaG2MBcvANL2lra8Mjz+pg4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Ta6vNh2C9w6TttSguFH7JjZa4PXLMBaKWCSYAOtF4TVYPXdgiQnMe/fNH68mwkxNLQRUnuot0YGhKCuU3WyXRqa14RcjcF2W8g1uJAoQolyii5OV6aGKXFS4uCIjULWUMxbozQNuAP31nmw4tI/yRTu/021NjH/yxFhVDFbHNtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XiakXtz4; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiakXtz4"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42a8a398cb2so12492791cf.1
        for <git@vger.kernel.org>; Sat, 10 Feb 2024 09:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707586026; x=1708190826; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6s4NKSnTwElUws/VDUChz9uEVgB/nEuHyneHI/Kq2c4=;
        b=XiakXtz40b1/EfH80X9TCH2GgKr6XTS3a/QnHYC0FiI/x5ytrhIVmGjiJ/fHSvgEwT
         Cm8zO1WF/BGCEApEP8rUCy4v/KoHpmPuDoT8Y+bBDGzkHEicKvmCsvexKli6YNkfHa/T
         rzl9+qweb6SKKPrQDwRqzGsJ0hc7bc1sxi2+jDyk9hdjcVyxgsNdad8y+iixJMLqTrdt
         AqHa1oKYZpYPHOs3Zn6XjA0pvwzcdEBPFanXQl0FbAoD+5esYjgKrRbiPL4FbbESEzFi
         pdq3OaHN1ZE+HgHb9RWVeQEu3RlOwnm2ZHlinMC/SEzL0nxMzCVdjTjb+QjNU6vxCU1T
         DlQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707586026; x=1708190826;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6s4NKSnTwElUws/VDUChz9uEVgB/nEuHyneHI/Kq2c4=;
        b=g6d48plVNzpjj3hoAXNljVBc3jN7vFC4fvhisXtsyPhUTZ2Uf3wVOC+lO0FNqBF1/u
         CivIpmtuG8QdEAcuaCL5pMVJDfIo7NkfXkvBI4R0t1mWYP8nz6Xx/o3ywvel2Sx/EzSy
         ei37Ew7clFF2b3iz9jAayGaxurbEki/NAvH86FOhlClSb0ui5Ux7foRjJnsaxHDJswf9
         J5qnxx1RC9iWTHY9ed1DLksieu+7t4kXbALoOhadMVvatZjcDhmno0sbFaLcJDERQ2if
         JqvkVYrK/42wTrJOVdFWueTJzqlqc6ac6HU9VULXCmtK9iTYJn+pKlqbB1RrMdryGob5
         sCLw==
X-Forwarded-Encrypted: i=1; AJvYcCX4aUBSXEaeoy+qNnNC3kzuNUXTxR6QSHFkMDdfdFpntKXhd7Hu2ID/lU0wPWwDzSUu1lSSfeRUjNz/nhvpO5WrTZoq
X-Gm-Message-State: AOJu0Yxih4YQmQEshxRuTrC7+D5Yy88y4C3n7ivuKxeAqd4fBjDJh8/J
	KQ7zQ4CbcWietXiVDR3GkkGcCPVF7NCgTTATB+RnSdQOJ4NVLuEg2/qrP6Ff
X-Google-Smtp-Source: AGHT+IG6O9OyJBHzU3a6pJTCPb1nu/1bOqGZEk907pflCBytZYsv6Vv9zY6K1jOlJweo+fjJMj4scw==
X-Received: by 2002:ac8:590b:0:b0:42c:524:ef2b with SMTP id 11-20020ac8590b000000b0042c0524ef2bmr3817989qty.8.1707586026210;
        Sat, 10 Feb 2024 09:27:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUjd30icPI6IgwDj2bbG0d+wf0aTZ4rIOabWuqcSXASG4w2CjgJD1hriAosU7xi16NGK3oCKT2NIb7XRtT4iMIGSfUDq5hJQMMni1SimyX6RsRGjPtcqKoosoxb
Received: from ?IPv6:2606:6d00:17:3855:7446:337:f37a:d47? ([2606:6d00:17:3855:7446:337:f37a:d47])
        by smtp.gmail.com with ESMTPSA id ay20-20020a05620a179400b007855f767745sm706354qkb.73.2024.02.10.09.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Feb 2024 09:27:05 -0800 (PST)
Subject: Re: [PATCH v2 3/5] completion: add and use
 __git_compute_first_level_config_vars_for_section
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>,
 Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.1660.git.git.1706472173.gitgitgadget@gmail.com>
 <pull.1660.v2.git.git.1706534881.gitgitgadget@gmail.com>
 <838aabf2858b73361be8e8579bc80826e1cfd4c3.1706534882.git.gitgitgadget@gmail.com>
 <ZcSF1mJ-JXQLmoZ5@tanuki> <e8642ad8-bdc9-00d6-39b5-81dd399e60ec@gmail.com>
 <xmqqwmrcb5q8.fsf@gitster.g>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <996fab96-82b1-0b54-3a09-0ecc18d68a11@gmail.com>
Date: Sat, 10 Feb 2024 12:27:05 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <xmqqwmrcb5q8.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Hi Junio,

Le 2024-02-10 à 12:15, Junio C Hamano a écrit :
> Philippe Blain <levraiphilippeblain@gmail.com> writes:
> 
>>>> +	__git_compute_config_vars
>>>> +	local this_section="__git_first_level_config_vars_for_section_${section}"
>>>> +	test -n "${!this_section}" ||
>>>> +	printf -v "__git_first_level_config_vars_for_section_${section}" %s "$(echo "$__git_config_vars" | grep -E "^${section}\.[a-z]" | awk -F. '{print $2}')"
>>>> +}
> 
> A silly question (primarily because I do not much use the indirect
> reference construct ${!name}).  Does the assignment with printf need
> to spell out the long variable name with "_${section}"?  Can it be
> 
>     printf -v "$this_section" ...
> 
> instead, as we already have the short-hand for it?

No, unfortunately neither "$this_section" nor "${!this_section}"
work, so we must use the long name.

> 
>> finds also others. I think the idea is to cache these lists to avoid 
>> computing them everytime they are needed (probably most useful on Windows 
>> where process creation is longer). I'll mention that in the 
>> commit message.
> 
> Yup, as long as the contents of the list stays stable (e.g., list of
> Git subcommands, list of options a Git subcommand takes, list of
> configuration variable names that do not have end-user customization
> part, etc.), it is a viable optimization technique.  The available
> <slot> for color.branch.<slot> and color.diff.<slot> do not change
> (unless you talk about new version of Git adding support for more
> slots) and is a good idea to cache.  remote.<name>.url takes its
> <name> component out of an unbound set of end-user controlled names,
> so unless we somehow have a method to invalidate cached values, the
> list can go stale as remotes are added and removed.

Indeed. Here I'm caching Git config variables, not any user-defined names,
so these are stable.

Thanks,

Philippe.
 
