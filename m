Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCBB39856
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 23:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708125172; cv=none; b=EXTqLqTnTrqn6lJq3Xw08aSY7SdXmAX8xdbyNF7m5dNslIC4US1QSEEDjRFH4TVYxKwZBWpF1/W8am7JDJ91HDfdNImH00ZLteuPG+Ge/4TaMAWy4+SdIGHd6olcSaKmqzFy6StvE9esUQ2bmFr6StenCd5xTW4GHKT61r8VKEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708125172; c=relaxed/simple;
	bh=hLVPB1YeHuZeHzt6Ud0+QYxO05J+asKz/Y/q+qjCQmw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lMiE0CsVcoSgltj6YkLM/2EtGLZc4vNFwqDOkxowUgYCN3bgmSOQlp9fwqIB5Dk2Pm3162q5mvc5gipV9H1f3mwi4XAvpBAz/pm3ijtzSs2LgEnUaboRogFGl2q8h5Ax4ktND3uLhUXFRT9MG+2tsjm8QEbt936bSZ6N+ogSomU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iuYoD+1m; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iuYoD+1m"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-607e8e8c2f1so32488497b3.3
        for <git@vger.kernel.org>; Fri, 16 Feb 2024 15:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708125170; x=1708729970; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NFkXGMi0vQuzrOmtomcI0M32SJkZymc+VDI4/Ej7nYs=;
        b=iuYoD+1m96dvS2pRmQG8RPuBhJlC4gg1gDG7HaJCMhdyp+6W/214+32zC7H4v7Y6DH
         wWsfUsHEIs2CZdLfnGBNN1LjLbB5wSRf4zeELFauSQmScrJYzULvYyfC4VQsVBN8x9wX
         KyOb6FzrVN+8HPpy9eFBcZFykIC4oOkprcnUPC1b6wyE+eK2HOSowlGYYnRd1KcBWmMZ
         X1EBZSf+8dCq22bOlGcZyAsHQXyxLUV68RmH538SJwEhyjeKxJaiENfHefvZg7zv2ATp
         6iSgAsZMLwt7cDRBHE5Rnp8nGezQbY2/ZzvVW5IwZUJdADWswYsf2+GLdep7jvbrewCz
         IDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708125170; x=1708729970;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NFkXGMi0vQuzrOmtomcI0M32SJkZymc+VDI4/Ej7nYs=;
        b=B9xE1uPIuudtQYS/BWY2KvZEd4GmbFicnPQSLVQGc5ucl4hNHVURq7wNa/4mBCdSDd
         GDzA2Fck7sAuuWaPbx1SPzVXElDRASGig6xtyQmMSsjaAlubBb/KoyV418yksssdA2g1
         QczTBlu/R/PJv6C9OnJpXCoOtoJpQoujuxB/lrWJqKJ0aRVpK9M1JIG0l+irzb5uS23B
         9FIvC8O9nn8aZlPpTfA/dPreUONpC2kaDM/2MjFl3kNW28UDVmju+sBvn0rMt4TT+3Mk
         tDl9HnOK4mtAMlQqFbnIjFkb7U/m87OGkZkX5u8iee3N12VawcazOd4dKcHmMJuX3Bi0
         OlXg==
X-Gm-Message-State: AOJu0YzDleAMg+1qJfmAz38H5s1ZHgpuFtfswGccVn+/rfPAxNVeDogF
	zlXkGXIEC4Swcs6sUhltARciHer03kbe3s9StpRxvIBokxqjoSGBRwpSNlCXjKD/vqMahjXJKc7
	3vA==
X-Google-Smtp-Source: AGHT+IGqk9RdZPkk1LeG2iSNnZBc77MO32LA4yQnp4BLDp97wMb9cwirR3x8Y96ERM9nRyTroFN+P3QZ0Jw=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a0d:e888:0:b0:5fb:5605:494a with SMTP id
 r130-20020a0de888000000b005fb5605494amr985034ywe.7.1708125170191; Fri, 16 Feb
 2024 15:12:50 -0800 (PST)
Date: Fri, 16 Feb 2024 15:12:48 -0800
In-Reply-To: <xmqq7cj4ggir.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <xmqq1q9mmtpw.fsf@gitster.g> <20240215053056.GD2821179@coredump.intra.peff.net>
 <xmqqv86pslos.fsf@gitster.g> <xmqq1q9cl3xv.fsf@gitster.g> <xmqqr0hcglpk.fsf_-_@gitster.g>
 <owlyh6i882k4.fsf@fine.c.googlers.com> <xmqq7cj4ggir.fsf@gitster.g>
Message-ID: <owlybk8g80lr.fsf@fine.c.googlers.com>
Subject: Re: [PATCH] git: extend --no-lazy-fetch to work across subprocesses
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

>>> Do not model how the value of GIT_NO_REPLACE_OBJECTS environment
>>> variable is ignored, though.  Just use the usual git_env_bool() to
>>> allow "export GIT_NO_LAZY_FETCH=0" and "unset GIT_NO_LAZY_FETCH"
>>> to be equivalents.
>>
>> s/equivalents/equivalent
>
> I meant to say that these two are "equivalents" (noun, plural).

Ah, I see.

> I can rephrase to
>
> 	Just use git_env_bool() to make "export GIT_NO_LAZY_FETCH=0"
> 	an equivalent to "unset GIT_NO_LAZY_FETCH".
>
> though, of course.

SGTM either way. Thanks.
