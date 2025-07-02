Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594D02DE70C
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 23:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497696; cv=none; b=XHjJjPWj2S+aHXAYcmeDx2IyztBsLso8oDuYFbcF3JW0C/x4OByfH2pZYTfWK+3WGXelbkRUCjIWLmy73rskzw+CE2D+NQUVpW92tCjpfAASYajDp1OMAfS7HPD4Fs7rAn4sFc9qDAbfAD7Md1dLaYw/i/hZZnFn2+LMhkbUPEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497696; c=relaxed/simple;
	bh=U6mxD+jmAhHaZx6a2owwq1PNFKc5+7m8T0Hd48hqNA4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i0O3OPFqxwCOo6H23RSipSk5QG4RyWdyr37YQsr0yF9kD5w+zaSrNtuVRQB8J1Dx7REuV6HlfsOdKgMqczY0nxB377pjh7yzGHyFoWNGd09WYcVaVkq//wealpOWNTVW5l9o4QnVlqUCggNURMMmeGd8PdA7/Vmfcgi+JHbT2tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9LVvZMJ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9LVvZMJ"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-74b54af901bso822686b3a.2
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 16:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751497694; x=1752102494; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U6mxD+jmAhHaZx6a2owwq1PNFKc5+7m8T0Hd48hqNA4=;
        b=f9LVvZMJIlyLVs44eaOVRq2nQwGTDtRGLnvpquHRsQIB86Uy9oOJcvPRuUng+GRR6z
         G7N/Ud+1yECWMfon2MdwtELnaQT9OT0vT4mGbcgzwKm4MfGXFyKEwNlhza128S/x3tqh
         U5t3MicfRJFaDQDkaWhPNTe36FAxOv1fMooBF/MNwjG3sAHu+gs75wV/pR1WqLOnxE5b
         KOvhdrtbWvbUooodLXLjD8jMwfRl7QeGAxM0wZQmsIn90TTPajBY0FX0yQvGf9LpBJ/j
         rG5m7bPKxfm/tGLfSeRhmmGMbwL3ymmADA2NtUXW/7yT9WmOr5urP84kNxjiwgJ/T5rH
         Zq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497694; x=1752102494;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U6mxD+jmAhHaZx6a2owwq1PNFKc5+7m8T0Hd48hqNA4=;
        b=KfP88JqudFdbOaeCsZ2x0EMFRio0saEF0zwEmuq6R22eioVxiIlXNob3+1cJg1qCIf
         v/Tgik23bmB5UZUsiluoXria9FtF1XyuWjCetoCmmv5t7y3SF3Qm2ES6ys8jmF9nfXVD
         E+JA/w7g28I5Dnaqe7v78PkLy5TmLbuoZSuJHtLyxfHge25IFrk1PvoNTo0wAIOUcqqc
         uS9D2AYcxZu3U8qARWQO+PSo/dRf1KCFeiNUwvOGunJR6cS7A3SJ6YKOt38pY9rMFeT0
         kl6SW0KVY6nRGHHgAWqLz1ZuMTOu48dtFlp3KTq4KkXA5tnIrbQRYsRrBWc0pIqbBZnj
         xhbw==
X-Forwarded-Encrypted: i=1; AJvYcCUruYzUNXQeHCKqLycKqfksaulad8It8STI2HL25VXwPO4YeQFdvsC0xhNbHVBIOxw3C18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw9nSGunh8x4s412se13a4aZpHKzuFfCd2uDvGXfkqND56+TnQ
	FQQd4/lCObLgBCHV6mx1k7ctqTBe2cw2KvpEf40Ug6LeCq68wqHarchRn1kyeA==
X-Gm-Gg: ASbGncuzmq7sJ8wN8WrxO39dWmvVu+myl3tH+3YGmyjGuXjlU+TiP2b0viJNbwuEOoG
	CoxBsGdvRwMjN+yv+Y9KnK3Oue4mrVRZFHkWdv1gv1+MDLMkOObt1b2RVlDapZI4uWdktJXxBxh
	zND5w1+Q4NImX9xDnpL+EVTrXVGGNnRja8TsXx4moK58xx9os/eEwpZcNBMg8DQfQFFTknom6aJ
	ioT0MI8WWGI7HyXiwv+ROKfTmFE847E0qnIVn9AAS+NRAbFSTIZgYbAs8iIqSiiSuwH4wX4fQ7i
	9T5Yws0faQ+XLGhC4pDCxW7j47UjmxaaOFd+pABmPv7fAL1/OhHAKxuk7IiITu+lzC199kX+Ipt
	GgFefhBS9Wib3D7nr2eCRdfTqdw4=
X-Google-Smtp-Source: AGHT+IHowvcT0CiIuPJSaNDO49UGmhPSAKgmbnHCYybax7WD9xiZ+TqFPdikItXa1BekO+liJjExBA==
X-Received: by 2002:a05:6a00:a29:b0:748:3964:6177 with SMTP id d2e1a72fcca58-74b5126b80emr6279821b3a.19.1751497694458;
        Wed, 02 Jul 2025 16:08:14 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af55c6a3asm14341556b3a.118.2025.07.02.16.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:08:14 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Renato Botelho <garga@FreeBSD.org>,  Patrick Steinhardt <ps@pks.im>,
  GIT Mailing-list <git@vger.kernel.org>
Subject: Re: Bug: build is broken on FreeBSD if libsysinfo is installed
In-Reply-To: <1993f24d-4433-427a-a834-360f6a9a963a@ramsayjones.plus.com>
	(Ramsay Jones's message of "Wed, 2 Jul 2025 23:37:23 +0100")
References: <f32292e0-4c99-47d0-8eac-21dbc5aca302@FreeBSD.org>
	<9dce7213-0b8c-4636-ab37-4c26081aedf4@FreeBSD.org>
	<d3b912ca-ba5a-4b56-81d1-0e8a10055d83@ramsayjones.plus.com>
	<818958f6-7387-48f8-a0a8-c050af212069@FreeBSD.org>
	<xmqq34beed0q.fsf@gitster.g>
	<39e370f3-5113-4feb-8a19-2cbdba6c17ce@FreeBSD.org>
	<1993f24d-4433-427a-a834-360f6a9a963a@ramsayjones.plus.com>
Date: Wed, 02 Jul 2025 16:08:13 -0700
Message-ID: <xmqqwm8qb38i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>>> So we have a bit of loose end that needs a finishing touch, but
>>> otherwise we are good to go?
>> From my side, yes.
>
> OK, I will write a commit message and submit the patch to the list
> some time soon (I'm a little busy atm, sorry!).

No need to hurry, and thank you very much.
