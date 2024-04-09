Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC3D2746A
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 01:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712625037; cv=none; b=AxYUFbEMEi80lSRNmkzIS761HcPCWnvskottT5T3ZzCrDgvv1vInVcwwQF79W3UgugZOuv3Hj8fhJ9Zlhmqf/ysJEK7IcHtIq5A2K/nwTQCvVbuHV34h18mqvrMXg914U32J6LlKtvV9/iMUOwvV1iCQmDN1WzK6NGpNlRHrBxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712625037; c=relaxed/simple;
	bh=wcJe9DxhYDdQBAtEZY3K5WCRtpzmrEFQ4cwFH3OHUa0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AoA5EoAePKknPONO5SYKbO+2Z0vKlQpFaOwHJmzvhiT6e55A1LMRgkTrdxNZpX8xpEJs+zE+oYXuyYLDoaojRwrr/Bsh/VibtfdHI09ePp88RqVEMeOaYa/bazkEoqPWq6c3qsGs2XhORuK0pY+QgenNMw4g/iuF6k9WiMILtkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XW38PxBD; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XW38PxBD"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cc8d4e1a4so85900547b3.3
        for <git@vger.kernel.org>; Mon, 08 Apr 2024 18:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712625035; x=1713229835; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oXOD92vJzJhQfNu2yUfvIMz5slfex2THpHF9uzw6KHA=;
        b=XW38PxBDy+VNJlr7VBq08a8otHi7C5dCxDpJEMAHXcdqXRRdYHH5L9XFIm85sRBoqP
         Rx5um3++hU70IOdE5/Ch2ur1mun34lLnyNJEtEtoXmKrN109BlBSfJjWIFm5HwD1gU6I
         Suc7GvKm5R2uFh/1nNTxx75LeIKxKETkKFcSAoc95RmetzAuVfIyXyIyWFiTj9LTzm3U
         u+jhuP/34nO+eiD4gmrh4iEmf7dX59h0eSKwtvN8khAwmXf6UHGwhcGKmq1CcMKFIt0Q
         mwzYiplKYhiTuLAAD9+MKe05SLiuPnIcNuMEVTCygsylx8nbvwyahq0qtwU7PRJpdMn8
         bjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712625035; x=1713229835;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oXOD92vJzJhQfNu2yUfvIMz5slfex2THpHF9uzw6KHA=;
        b=wnGNv8CVv+AZw4bUDywFAQK8V0swWILigzP5JQqIh1J0U6skMYcbCAWIa8SqDT7Y4w
         OqH79MYsTvfcpgLdicR3TaNv3ZRHkD+5eMiwTBsemWWOfvo0lmRwp1OLXc6yvoVqJzXG
         K1SJ+8MsHJEpu6Yo/Vz40lMJyEGEUdtuRCz2HCIAj+fW3V9DpNyoqpLEP9lf5ryLICK8
         y0vPBT8WS7nSbBVTYipJtb6Rh17r0SYwyw1JvcJbdVQFR0LDkUET0TWFRIvDA4Ja8jHa
         cqPxUpWxKFGc4Ba3LLEgLW8I3aih1eXCpDnT/4FeeE/vC9PiXDTZvY01NwASkbHQCHwz
         xxLw==
X-Gm-Message-State: AOJu0YxuQRZTFtKKJP7ZgPoegcC3xJX60n1xJ0HkbuRB6zObC45ahvhi
	3I7ZkQ3hOxqSqpU5bAGa3wC8oICwE6a+QZUAo/0pknaYM3IQlsGk0p/OoBnGAkTnrkjzoPL8q04
	iaQ==
X-Google-Smtp-Source: AGHT+IHg7AEI7H5lhbqv/+/gPw7R1E3/7klBteaIYAif4Z5R1NOmKcVzoeIGc88kq9XY+Iaur3im4J8RxzU=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:690c:88b:b0:60a:3d7e:2b98 with SMTP id
 cd11-20020a05690c088b00b0060a3d7e2b98mr2868612ywb.4.1712625035387; Mon, 08
 Apr 2024 18:10:35 -0700 (PDT)
Date: Mon, 08 Apr 2024 18:10:33 -0700
In-Reply-To: <xmqqy19rp6od.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1704.git.1712017205754.gitgitgadget@gmail.com>
 <pull.1704.v2.git.1712366536.gitgitgadget@gmail.com> <6e6950afa6e6e884ee89ac24c05b50dcc722657d.1712366536.git.gitgitgadget@gmail.com>
 <xmqqy19rp6od.fsf@gitster.g>
Message-ID: <owlyle5ns5me.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 3/8] SubmittingPatches: mention GitGitGadget
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Jonathan Tan <jonathantanmy@google.com>, Emily Shaffer <nasamuffin@google.com>, 
	Patrick Steinhardt <ps@pks.im>, Matthieu Moy <git@matthieu-moy.fr>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Linus Arver <linusa@google.com>
>>
>> Signed-off-by: Linus Arver <linusa@google.com>
>> ---
>>  Documentation/SubmittingPatches | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
>> index a33fe7e11f6..48b270b4c48 100644
>> --- a/Documentation/SubmittingPatches
>> +++ b/Documentation/SubmittingPatches
>> @@ -408,6 +408,10 @@ are optimized for the workflow of sending patches, avoiding many ways
>>  your existing e-mail client (often optimized for "multipart/*" MIME
>>  type e-mails) might render your patches unusable.
>>  
>> +NOTE: You can also use GitGitGadget (https://gitgitgadget.github.io/) to send in
>> +your patches. The discussion here focuses on using `format-patch` and
>> +`send-email`.
>> +
>>  People on the Git mailing list need to be able to read and
>>  comment on the changes you are submitting.  It is important for
>>  a developer to be able to "quote" your changes, using standard
>
> Rather than giving the URL and have the readers figure out how to
> use it for themselves, it would be more helpful to readers to refer
> them to MyFirstContrib document.
>
>     Note: we outline the procedure using `format-patch` plus
>     `send-email`, but you can also use GitGitGadget to send in your
>     patches (see MyFirstContribution document).

Ah, of course. Will update.
