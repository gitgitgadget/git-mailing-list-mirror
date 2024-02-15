Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED4241C61
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 20:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708030753; cv=none; b=G/ouicSqwTt21Bfnx0eFUDY9e3UVlp5CkIddPH8dyOZdFf31+mFrqIxeiE6l9cAEdCtZvWR/7qwukKEyilv/jPvaPXs8ZFNtkXaqtE6wvkqze1bBI2pHFpFi8te+yQ/A5ds2K9Ea/T3k3PoERngnXYw02K386VLue7on9vurwSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708030753; c=relaxed/simple;
	bh=GGLbkkuIoCnan332KU5+PcCBJwB1Kt+reKur7JS0IGk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mInwqlU8xGXOD1G/j40LLA9XHKztKMNXzohDnLhf5FAhDdpHvreP6C6EBMY/V/RFgTmQXQ2vfG0I1FI1LvSy/6dUpcTHiHDyAa/grOhGneingFWKo3lvxQxFCcKlBk5hhkUcC23iqJqdh9jjB/V4z54rXHJvrYEARwxI6f1/3IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EhP/fTJw; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EhP/fTJw"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1d950445c0bso14746265ad.2
        for <git@vger.kernel.org>; Thu, 15 Feb 2024 12:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708030751; x=1708635551; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yFErBsKDmo1AvfHk2r6dHRir1R3ZfsB22Yhoz5x+Gd8=;
        b=EhP/fTJwcvdPfwORiPZlmMkU8+9Pd2EX0Rh7OIgtTnOFQtrw85RZjwSinml1uDx/Fc
         rFgk1MPDTf7OGBsnlcQfcvl61cazARrPxarEYmPXGipAq5I1V1ao/huascjon2kQJhIW
         8GOYTZu9w/kMHLELjCN6DLCuirWZU62WP3xbgbzk7x9YsCLCFoGcFO14ALWLxJsKS2FW
         N2Wy/3HXCxlFX9R2H4H7c3gSsi+11SZwgsHGGzzU+Zmx8eEgh4JVZwLHvjwNSR0amAjU
         XgyJrIWljmeAdlBqC9xDLIwBDPQMd15DHVQ1L80XRyQzEnRUI+n/b9lWQvdWfff8Ut6V
         PVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708030751; x=1708635551;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yFErBsKDmo1AvfHk2r6dHRir1R3ZfsB22Yhoz5x+Gd8=;
        b=OlnweZ+uH8br5u5j2dZePHzI7Ogtg14HnprCxs/tHgbHuniFgjTQtU3RBqLM97aJ04
         mcIzrNK+qr23xbkj90PMkcVuF6jza7m0NnGwRKxxBczC9zNu/m4YLATs9y0nRSBizR+c
         O4pVbLPoPaPqhwpcaK+75tRdV5N3HJfpIxsR6hcksSjbynmahWrOl6bGbjAgwyM9l6BX
         57hEAh0lD/FgIGiniaXo/xI+Cl7U5lzvaI5OXOyQDBqGCR1euh3R5NA0JcCzP59kq95a
         RbDP4Rdi6WNOXmBEebadAJID2X2llg9jn2fZJ8ZcB9jWRgeNh9Ze+vuo+dKEAUVuZwe1
         kIdA==
X-Gm-Message-State: AOJu0Yz1w8hlO0b4RibFUXNzBHkIo5ccbjo6hhmVWbYMPybvEP1fc1/p
	kGgQWVtl0x2q7k68pMM4z/inkC15TJm8+QORGbanEfHvpkUiv9Bx+6w+i8+scPiGKd1hFfFnRX+
	Oyg==
X-Google-Smtp-Source: AGHT+IHCGXJ/LHV+qVxkCtzwbJjOovai4clIvm+iv/10BQVWtYwF0DMUwOTlAbyUJHORD9eEY1IQjV72xsQ=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:902:e551:b0:1da:1f7a:24ec with SMTP id
 n17-20020a170902e55100b001da1f7a24ecmr32712plf.0.1708030751363; Thu, 15 Feb
 2024 12:59:11 -0800 (PST)
Date: Thu, 15 Feb 2024 12:59:09 -0800
In-Reply-To: <20240215053056.GD2821179@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <xmqq1q9mmtpw.fsf@gitster.g> <20240215053056.GD2821179@coredump.intra.peff.net>
Message-ID: <owly4je9a1gi.fsf@fine.c.googlers.com>
Subject: Re: [PATCH] git: --no-lazy-fetch option
From: Linus Arver <linusa@google.com>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Thu, Feb 08, 2024 at 03:17:31PM -0800, Junio C Hamano wrote:
>
>> Sometimes, especially during tests of low level machinery, it is
>> handy to have a way to disable lazy fetching of objects.  This
>> allows us to say, for example, "git cat-file -e <object-name>", to
>> see if the object is locally available.
>
> That seems like a good feature, but...
>
>> @@ -186,6 +187,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>>  			use_pager = 0;
>>  			if (envchanged)
>>  				*envchanged = 1;
>> +		} else if (!strcmp(cmd, "--no-lazy-fetch")) {
>> +			fetch_if_missing = 0;
>>  		} else if (!strcmp(cmd, "--no-replace-objects")) {
>>  			disable_replace_refs();
>>  			setenv(NO_REPLACE_OBJECTS_ENVIRONMENT, "1", 1);
>
> This will only help builtin commands, and even then only the top-level
> one. If I run "git --no-lazy-fetch foo" and "foo" is a script or an
> alias, I'd expect it to still take effect. Ditto for sub-commands kicked
> off by a builtin (say, a "rev-list" connectivity check caused by a
> fetch).
>
> So this probably needs to be modeled after --no-replace-objects, etc,
> where we set an environment variable that makes it to child processes.

Thanks for the helpful explanation, very much appreciated.
