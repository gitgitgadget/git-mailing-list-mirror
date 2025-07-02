Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E5B2F2706
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 17:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476121; cv=none; b=fjlPzU/cmNp3twFcGIO1pKKwkeYpu1t+4AMmLghRDJJvFsFqcnX9J6ngt/4tyI9uinuaIspwikZzOlk7A5UjqBdMHZ+fM4xCOl/CULTQ/hSKjeRFPiYdvPSP8ep9xEJ67hdzt7Qx6afoUg4lSxJnRHF8mog7Q3DX/6wb0Ceofzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476121; c=relaxed/simple;
	bh=60hfnSx5+WNRsuHNIG2UZwUJoLwyYzNS54+Q+FXYj94=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sbPTxu0Uk/CailO3oKl43ghaXm5CD+BDIZl7Sq1UajJUSA0is1/9jurMy150DhEwx7flLW18CfJ9cym5KSDOUXNQ5jI1ZrMrC6gfEX6GfYW6OI4soS5d+SRkSkr093L7ohFDfcfk3wETYekQwsMFk+HmdT97OqP9di9EWoG4aqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTfAJIcu; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTfAJIcu"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-234d3261631so51557455ad.1
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 10:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751476119; x=1752080919; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KsMbMfuJdMEU+KEGkMicDOP0XDjNQd+Y8chQZLN+rEo=;
        b=HTfAJIcuncgdZd6WoIKOKGvrc5wNYBfJCzw76QDgFm7Vx4XnxXhAAv4WKtdZst7H1V
         oFYfOSGJ1NjtTv2xck4yJjCeCCEk9xF/attps1Gr2S50qmTe9/h2YcFEz/62sxO14Nd2
         7Nmtsey1EJICvi/XjnOfD5RUOwygBBr4PLDYhCR5qs+J52koWNsKg38PmO7/CAdjSvfL
         KWD/g0b78e8ANiEghDNh1vPgbrb/XPZsBy5G4LHyedtpWH5tAEI/Ccp1EEAcw6KGIPXK
         XPOVMDao7cFThCHvEEt0yBZh+Qv4Xk9rpX7Id1GHNSVsHZSsvcJsfJGPhhC6VgbCzzoS
         nf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751476119; x=1752080919;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KsMbMfuJdMEU+KEGkMicDOP0XDjNQd+Y8chQZLN+rEo=;
        b=U5sLMIAWRvfGA6i6yySYwWwFiJ8/jgAZ+mHKJtCIrWUCkR5CUk5zNq6DmO4/cKZYda
         oqT8s1qeTc4KYrI6d5imwcpW3+tGWood1K0LucPfy31xTUZkpXOxBcxP4+ic2k990eaN
         +Vqw0U8GpBLOux936b5Uwan8A7h90YPzhTFlmd11xoNd78vLWovNHSBbJhG6c/D09Qm1
         mys+/YhlZ+3oPZB6fcBPJbxDEuNiF/BVqW7hJ4AHtqt1UCWxmN6/yPRUu/3XKIwLnwqW
         pkXkUVfX4ON6TmqG3F1KUzNt36/NBwJtF8WPn7srk95bmC86oryZJs8WFsoBe3/XvkT5
         s+7w==
X-Forwarded-Encrypted: i=1; AJvYcCXUUyDgxJRzsi9ihlUsANmYfVtRgQvH66wmM7yrITTF7psuB1GDMFx3YsvqMGcWPFcagpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAeTA5tMjBV7F7gZYnIejLcXhTPahvnNL5lRqJQNh2pSSi1qQH
	DVnGc3aAh87tGBasyYXrqwDYYAYkjSkhNXBDdpjgNDhieZFezTdFluuDUVm9GQ==
X-Gm-Gg: ASbGncu8TUD0o0ZST7+yOm3VMTgJMqwIdOb+3qvYsv7HOiQwByeU4HFv9sthrvdtB/x
	NFYt2B22yAnSSEwSXQiLHz8K7s74e9/cLRA/lt/8QK0ZDfauNSkZsyPLh1oH93+Q7c+4HVj8x0/
	jN1f1ekA/geGJ8kJfdMfEUSN15eHmCMFnuBpG0p5HdARIE8uBzxZV1yRjwMMGwwkptnow+N2Jqm
	IWihvjD32Zri93RXcR5U0xZK6bOticT7f0YBv+G3GSyLLhcXT/J+YBSPwuobdBURJBh5CONalLF
	nUySaf++qcnbc+mUkutY23sLcMqX0tE2/TJEPfhQf/IADGgIktWDffE9dSZSmJrr38evCIRRhEi
	wTmR62Nte03lot1NXvEnokaX57e4=
X-Google-Smtp-Source: AGHT+IET2LKVAn8EiIQL9Gt+TQq8rD2Rn+SpBm67s9ENUlP/9eahO4JHnHb9PsTcx0nIsJswcWwknA==
X-Received: by 2002:a17:902:d58d:b0:234:c549:d9dd with SMTP id d9443c01a7336-23c79842237mr1348185ad.48.1751476118921;
        Wed, 02 Jul 2025 10:08:38 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb39bcbcsm132297385ad.134.2025.07.02.10.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 10:08:38 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Renato Botelho <garga@FreeBSD.org>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,  Patrick Steinhardt
 <ps@pks.im>,  GIT Mailing-list <git@vger.kernel.org>
Subject: Re: Bug: build is broken on FreeBSD if libsysinfo is installed
In-Reply-To: <818958f6-7387-48f8-a0a8-c050af212069@FreeBSD.org> (Renato
	Botelho's message of "Wed, 2 Jul 2025 08:28:10 -0300")
References: <f32292e0-4c99-47d0-8eac-21dbc5aca302@FreeBSD.org>
	<9dce7213-0b8c-4636-ab37-4c26081aedf4@FreeBSD.org>
	<d3b912ca-ba5a-4b56-81d1-0e8a10055d83@ramsayjones.plus.com>
	<818958f6-7387-48f8-a0a8-c050af212069@FreeBSD.org>
Date: Wed, 02 Jul 2025 10:08:37 -0700
Message-ID: <xmqq34beed0q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Renato Botelho <garga@FreeBSD.org> writes:

>> I very quickly knocked up a patch to do the last option above (I
>> moved
>> the setting of HAVE_SYSINFO down the file rather that HAVE_BSD_SYSCTL
>> up. I guess it doesn't matter, but I gave it *no* thought!).
>> The patch is below. (I didn't write a commit message ;) ).
>> Does this work for you?
>
> Your patch works just fine for FreeBSD.  I tried it with libsysinfo
> installed and it just ignored it, as expected.
>
> I didn't test meson build since FreeBSD ports is based on autotools yet.
>
> BTW, should I start moving the port to meson?  Is it the default build
> method now?  Is there a plan to remove autotools?
>
> Thank you!

So we have a bit of loose end that needs a finishing touch, but
otherwise we are good to go?

Thanks, both.  

