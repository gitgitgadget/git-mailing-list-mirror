Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6CB43AA1
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 15:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751296615; cv=none; b=CpvdF5beO1uBjR2GHMYAKV4DPa2wKDwX7sofQQdii/eFDMklFBl2iQb0Za6vWQ53Ufw4gow61LdV5jS+ggZtlf3ZtciWld1mSpvVlcmtfIt/yP++OegIBFzMlme/GEMiCNA0dLfLLZwf2PRjZIrVDBCujp2ojAZGM14eXQLTp2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751296615; c=relaxed/simple;
	bh=qrUeWW5EGcAcGRPkoGLoYZ3SL9na0na0eKxLEHOo4BI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UxI1L0UzYVOKb5i6xvvIWk5N7BAOq6w8gfku2scY4XXsjEv0uJExVkOL3VT9EUODSQ17vkmK0/uHNZhWjJsLMn8SMetLODFgTcAs92H6eiFoZqF/8Z7qH2kUDZePE1NWBhvIwdcUYAi+WbKLKaXNV6u+7t5SqQz620EpjnV/F7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gbap7kRq; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gbap7kRq"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-748d982e97cso2308909b3a.1
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 08:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751296613; x=1751901413; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qrUeWW5EGcAcGRPkoGLoYZ3SL9na0na0eKxLEHOo4BI=;
        b=Gbap7kRqWQ5njvLMsjb7iR9XDS7hcpi54goDpK4iEellkj/oZtk7nrGVStv8hEuP+h
         V8IWj80qwvmew+HwMmOAJLe/QVKLKYOteolom2DBY+geGH2YM1PZzeV0UqpwtjHDZTzA
         n0vW/ZrI3VmolKNYBZ2QiuxUrip34vjR4VdPXL3EvlXh0oiwsXFIdsf0XNWXspPM98ra
         /1SEtY0BjIdZSPU3yc3KkTW/doeXXqWKjQnWKHHG+uGqXMsf1GoS5UXS6vdc8+JTniRl
         VEoc/F+ha69YLvkjv68sagPhhtr2CmqlwZkKazw44B8kDhpr1yiFmc2+BO9/rwYDzhHf
         jGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751296613; x=1751901413;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qrUeWW5EGcAcGRPkoGLoYZ3SL9na0na0eKxLEHOo4BI=;
        b=eKusnlF77ucy8E8TvBmkNm3FXTmczSBjyJ9jy1POMVRzWHrmtg67saL8ZZ1izFRBg7
         k1aYkGhA+AvrAOrdp5nzq5KgyXmX/9ky7Tr8R+0OvlshBU11vjjHi5Fi5rr8EKmRAhZA
         oFR5eFf86Uq5phXW5cjU2dfdUabjqWA6OM8v5mFK+tNwvdhWqdxDKrMghPmiinu7k7pW
         q86pRBOo/LIQjHQIOoYfZPcup2ag+GnLCtEC9nqa8xZqqF/fS+g535iTj/hXgsZ6fTfP
         m8pvhTZ5TQsafjSq4taMnPSBcQeQ4NXCr6VKb91fRdezU137ZkcKnH5qk9tHFiLwsrl9
         9KQw==
X-Forwarded-Encrypted: i=1; AJvYcCXXzIJ/k6VqYJihRypVHgW0+QBEhT/0MVu4YTHB4etbT9wS+xyquDResd3n+UNZsdPM/9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlXd4Nxm8ChhLsfnMisVHAjzNupKs5ugCfuUE/IHg0OLQhAw8K
	IInnIhK9uhWb4lSCgHteIOCeRRM6m/uXiDORXN1TAVNtPuMUDf615Ph4
X-Gm-Gg: ASbGnctQMJ/Sk8UqRN58Tyz1aOLXpX/l+HF0Ix3N5ZTCA2PKORTsPPvblQa3CCgjckG
	KuWCmbvzAF9ysaK8P3KJYeb3YE+GWO0K3SwsMAPwPY/+ZxqBiyuOhKkJvfkAXqNKeRTcAqBQUqq
	B/uX/0QSDd8JC/tG9KpCpBJFi8oGydt5yCzS6uSEquk5rk9Ld9GSrbm7szEOD9kuMBMNQ3mAMFY
	BZ3GyPnHGKzYP8BYXL8NbOlOLncGew4RgNdLRtk8xTeqYICqPL/dT2VYow8Z0SbkT1ic16WLjFK
	sOom59U+osDx15DT84p48CvFrrBmTDsoRhLu/dTguD+hu9nU4rJizi34mlmZaBhBZej6Pkb/lC3
	wd6fNo3TRB7flVnq3RIPJf+H8His=
X-Google-Smtp-Source: AGHT+IGyvV0y9ZiKk5xFgela/n0j+phjD25b7mF0AZhYzUf/xV5DgkErXjU4WVCm6RnUr71VVoXoBg==
X-Received: by 2002:a05:6a21:999c:b0:21c:fbf0:21bb with SMTP id adf61e73a8af0-220a15841d6mr24100471637.24.1751296612644;
        Mon, 30 Jun 2025 08:16:52 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af541bec8sm9064811b3a.39.2025.06.30.08.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 08:16:52 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
  git@vger.kernel.org,
  chris.torek@gmail.com
Subject: Re: [RFC PATCH] daemon: add a self pipe to trigger reaping of children
In-Reply-To: <59087d2d-6034-44d4-9fa0-c51d4bd60683@gmail.com> (Phillip Wood's
	message of "Fri, 27 Jun 2025 09:38:36 +0100")
References: <c314cd2d-8fdd-4386-bda0-881ff87d9204@gmail.com>
	<20250626182432.87523-1-carenas@gmail.com>
	<59087d2d-6034-44d4-9fa0-c51d4bd60683@gmail.com>
Date: Mon, 30 Jun 2025 08:16:51 -0700
Message-ID: <xmqqbjq55kf0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> An obvious disadvantage (at least of this implementation), is that it
>> actually doubles the number of events that need to be handled for each
>> children process on most cases (ex: when `poll()` gets interrupted)
>> I suspect that if fixing that last race condition is so important
>> with
>> the current foundation, it might be better to reintroduce some sort of
>> timeout to poll(), so that they will be cleared periodically.
>> I had a prototype (only the bare minimum) that I thought was more
>> efficient and that would instead remove completely the need for a
>> signal handler which I would post (only for RFC) later.
>
> I'm not sure injecting an fd into each child process is a good direction.

Yeah, I thought that the "self pipe trick" (in the title) refers to
the technique to have a single pipe for the daemon to talk to
itself, so that it can write(2) into the pipe in non-blocking way
upon signal and expect its select/poll to be able to notice, where
it can reap the completed children, so having a pipe per child was a
surprise to me.
