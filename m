Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECD936E
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 00:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713226922; cv=none; b=U4GORNKfsAF0RCt4Q1XMxM4UOQEsvRvYoulgzN7YbWs0qR4Dg1c7g29XqkE095aalOW95ZMA3dxgGI+gyr6FGIBuoRWj2jVq6+cgog4ulluKO880/fiIpP8HC3rchanC3KdNW19eoB91ebxlDpnj9W4t8DrexE37GazNCa2iTjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713226922; c=relaxed/simple;
	bh=bvC6exQgnafZajmu5Pn/Q2QHwOEMaOLGL+xL2CLSewk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L8ysPe1Zu+AB3lkJX9FzKzayFn+0wODjE/xed4EAhXvqxbT2f75PSJ3maH8wMWm2H/KRiCzGCKBWgyYEksr2NTlK2fFJrJnsyE9r6Akbw0D8d5Htt9hDYfgMVhF19p1G06hQBRHl4/tmAQ/v8enQnO5AzuZ5qIo8l/xscxMdVBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QEzr54ww; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QEzr54ww"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc647f65573so7047889276.2
        for <git@vger.kernel.org>; Mon, 15 Apr 2024 17:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713226920; x=1713831720; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FkGVL+3sGhGxeIoryjp58SYG8swVBMWdqzaT6K6u2to=;
        b=QEzr54wwK/P62jck6W/Vuy6BzmHL6WTBFPvi6qPf4xvFDMTHcMR8VOxMuqlfeCIR/f
         utH9L3mb3FFK0+1k8K80fgMcdLykE74oBZBvb04O1halwaKoZZ3WlsOF3wl1LRY9OUTK
         RQcPgyBVLRqhKjh9T448/ICYJdL5wBfSD292Uz/ZHjvKeUjvITYgqAXP/tCp5j3NJzPM
         wOpEZVzTThstXGkci+OtyPSCkpbLVGarrDAmLJvu04hhCa0G1WMqVk0swmXaCmckmwYq
         HwJBKG8EKrc89M1t8px9qBbl+ndc8OogHq7K0WOmPUjOINQ4zCtjozq7Hxh4GqiXImdC
         ZsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713226920; x=1713831720;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FkGVL+3sGhGxeIoryjp58SYG8swVBMWdqzaT6K6u2to=;
        b=LQXCOrlnm32pDRvGnqJCHCNX+3sdMY4Ek0OowAAjawv0HVJJQ64YwV7VztOfB3RLMn
         g7F3Ux11FMXLnqaEhpiyi3BKTwpKAzs/71dJZBkVNuQmvVckZKRLIl0RWDgwP2PwKYE/
         dAYhdLGB0kJL3hZfcUitWFGuh7xgwsuxeYxK0i4vCaxbAfrxxipz5ypR5TRe3kVhYOhz
         uTEbUx8SEq1wDixf1HLjvMQeOr3tycUDrK+XSh6fPKWjtWz6cVUUO31a37y+4KsNUYNM
         ntDlccUioyI3MrbJrKZ94uNKw4prML33Z4xyFm3HFajf9M5dOhEqyyOpQ30AGF/QYNoP
         5JhQ==
X-Gm-Message-State: AOJu0YyxMnInoPBeN04qk/8Mk4ZRJHU7Ir2PDOtnZNYuQ/5ZWTY9iZW3
	NbFeIRXhgWMLzchSTRZwA8tkEdQACQxCcH2nMkZX9RC/4D/5Fc9d4HIv2uucLOf9icyqxeDd7uh
	AXg==
X-Google-Smtp-Source: AGHT+IEouejsQncvtRc+Gsbk2Sq5SF6V7M7OnUyErsQdfMsR0Hpyv/GkvIWcx0RVFVIiRM4Ozl5yDAobadM=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a25:b04d:0:b0:dd9:3a6b:11f8 with SMTP id
 e13-20020a25b04d000000b00dd93a6b11f8mr3346487ybj.5.1713226920598; Mon, 15 Apr
 2024 17:22:00 -0700 (PDT)
Date: Mon, 15 Apr 2024 17:21:59 -0700
In-Reply-To: <xmqqo7aemrbw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
 <pull.1704.v4.git.1712878339.gitgitgadget@gmail.com> <84b1cf3f914067f8c2d056578e58d5b38bef7b45.1712878339.git.gitgitgadget@gmail.com>
 <xmqqo7aemrbw.fsf@gitster.g>
Message-ID: <owly1q76rwbc.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v4 8/8] SubmittingPatches: demonstrate using git-contacts
 with git-send-email
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Jonathan Tan <jonathantanmy@google.com>, Emily Shaffer <nasamuffin@google.com>, 
	Patrick Steinhardt <ps@pks.im>, Matthieu Moy <git@matthieu-moy.fr>, Eric Sunshine <sunshine@sunshineco.com>, 
	Kipras Melnikovas <kipras@kipras.org>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Linus Arver <linusa@google.com>
>>
>> Signed-off-by: Linus Arver <linusa@google.com>
>> ---
>>  Documentation/SubmittingPatches | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
>> index fd40a444f95..eac086133bc 100644
>> --- a/Documentation/SubmittingPatches
>> +++ b/Documentation/SubmittingPatches
>> @@ -420,6 +420,13 @@ trial merges of your topic to `next` and `seen`, you may have noticed
>>  work by others conflicting with your changes.  There is a good possibility
>>  that these people may know the area you are touching well.
>>  
>> +If you are using `send-email`, you can feed it the output of `git contacts` like
>> +this:
>> +
>> +....
>> +	git send-email --cc-cmd='git contacts' feature/*.patch
>> +....
>
> Doesn't this contradict with what we said in [2/8]?

Oops, will update.
