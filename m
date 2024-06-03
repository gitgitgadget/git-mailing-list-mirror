Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688E5847C
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717426886; cv=none; b=N5rP+EwEgXaJmIdQNqe9g0RL0TUZUPuzddqNeGj+wouAHwaR/J/0MQE1b87Dglk2QWUku/aN0wKEM1OvaAtsVQToaX+Gjob2Ohkxr4mhnMCVBKcAG+WeM5pI9d08jRGdTQTvrmrY1W6xa4tGGjNQKeHYehi/R6mZnUV8DQsDyLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717426886; c=relaxed/simple;
	bh=rO4Q1DXDHhXOUTohhRZx7Ji74LQOplraceN3WP8K3YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f4H1KLU5K8uemMLC+21Z+Y1ic95L68UvTlzvmEqDDw68UDjQjx+wUMf+pOSsGQR/MVjCg5l6nYDLHruhTJxA43kJH6w89ZfeQjDpZwSRmnpTR/A6j9vVuH6ITZ0dzXla1qZA+ntxDaxjd5LqiDHg07T0FbcliqFs8ZYEGIyMVEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwlRaZG1; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwlRaZG1"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57a30dbdb7fso4739391a12.3
        for <git@vger.kernel.org>; Mon, 03 Jun 2024 08:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717426884; x=1718031684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nbFqA49BsiHJYae42YPI55tnF+OjQdwPSCTzsWtszs=;
        b=IwlRaZG1ZiCwC+RZCxxj+3w35mmQdVjMEuzseMarf8XPSU98x8yRoqdYC0/t6ihngP
         cat2ov7+Sh+OEZqhBuNZVcmLlIUguTQQZDdgb9DW2xilg6aHfoCw4Lw2SH18+NR04m0o
         cgu1eizAEFJnSgAZTRef9LKTWDM7qJsFY4VnDPWM+0F76iD2weyLPlvJSwbbx2dNNp4O
         dShMPj6iwW87euQDoT1E8NnofSabYRZ+L/sHmjklxLxSE943NKJRXnlFKHKzamBXFMAc
         3kgEzjLUnYdV9o6vTlYPOV/lPGLMI5L536m6XnjBgbNX67R8rdzFyJZJLFd0WRWg0tbu
         xOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717426884; x=1718031684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/nbFqA49BsiHJYae42YPI55tnF+OjQdwPSCTzsWtszs=;
        b=whgPKmCQT9rEa8exUT/mpohYqeerB7oXz0vZ9E0k4HptaDnz32e3+oNVOkQmgTDhV1
         8cktn3IhO6K+OlTMes3DcHPqwV+p5PRGBlS61PK8u1I+mu+pAS3OSe+LY/XdsYUzeC5e
         UbUj3uHWax5MCty7jzWgDW5T8xjKbrgApfX/glBeOce2OjkuQKjKDykR8DGbDq6bbVNv
         kveRpThGwUmsOx5xhZBTo4NbPRRvt7Ja1x0+2HVDFjBn2racpfx2vJFwNgsEVhrNBnOa
         JiH8Se5u9qSsf2Ts3loXopG7zXZFmcALLHMLpq/AtzFcB6cgTSaseYNSo1yToBeJEiB3
         465g==
X-Gm-Message-State: AOJu0YzpGxriundlahJH5Htlb81sQ5k3Ey0h/zzEw65+6Ont5uqfCJvJ
	Cm55wc5KCybX9njm+Jj4sijM1GMScerdzSQ1VxwtDLmqHakfWMz0q02DIP9fye+oVvcJZ1OT0Ip
	u6dVMsw7kYDKbv6V4nIBIB4fk/ubG+fG5
X-Google-Smtp-Source: AGHT+IE3bDKIAJQl42VXNYllp7RBBSd0JyAZ4/bAmrPQ2W6eaZIqJ1czLUWaRQZ6wwIgRUg7PpPT6AAQ3lj9qgXSIq8=
X-Received: by 2002:a50:8e11:0:b0:579:c08b:afa9 with SMTP id
 4fb4d7f45d1cf-57a3636f725mr6761904a12.11.1717426883610; Mon, 03 Jun 2024
 08:01:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20221012135114.294680-1-christian.couder@gmail.com>
 <20240515132543.851987-1-christian.couder@gmail.com> <20240515132543.851987-4-christian.couder@gmail.com>
 <xmqqv83fvw7p.fsf@gitster.g> <CAP8UFD1JZ7eJzrTk1YPrfy1XLAnnLvukABOJE69-JbqVWtL1AQ@mail.gmail.com>
 <xmqqjzjikhdz.fsf@gitster.g> <CAP8UFD1_aHwbhF12v-miCTWEbbgjtpjTCmkRmFHu4Vusezq6dA@mail.gmail.com>
 <xmqq34q27wzg.fsf@gitster.g> <CAP8UFD18Y=NhnnzcHoBOiO7bu_VrxnHOeLgUeqiADQPcgtMW=A@mail.gmail.com>
 <xmqqwmn9athc.fsf@gitster.g>
In-Reply-To: <xmqqwmn9athc.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 3 Jun 2024 17:01:10 +0200
Message-ID: <CAP8UFD0aiBY27_8HqjyMtze1ZcME2gZVTMyB=botNErmu_CJDg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] upload-pack: allow configuring a missing-action
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, John Cai <johncai86@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 1, 2024 at 11:43=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:

> > I don't understand why you compare this to a "broken" implementation
> > of promisor remotes. What could then be a non-broken one that would
> > store large blobs on a separate server in your opinion? I am really
> > interested in answers to this question. It's not a rhetorical one.
>
> You as S would tell C "I want you to go to X because I am not
> serving objects X and Y".  Or at least make sure that C knows about
> X before deciding to omit what X ought to have.

Ok, so if there was a way for S to suggest config options and perhaps
also command line options to C (like I mentioned in a previous email),
and if S would suggest C to configure X as a promisor remote and C
would accept to do that, then it would be fine for the feature to
work, right?

Alternatively, if C would pass a new option called for example
--known-promisor=3DX on top of all other options, then that could be Ok
too?
