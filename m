Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1C5131759
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 14:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709736093; cv=none; b=Y+i8yPqvdhOHGGYjRhRz5+BDWvQsZNhKvxiqxfkSnnyMEYVbSuFK1T494PtPY65V0XyHLuHfYT+jPRaw6z3rY+CC+Kdd6aE8ehvy6V8DTwiDHx9hjcGG7U1NXl0d0iECInk4hM8z+ENSZW9N3x4GN7un7bVH8/mc4dAowGSh4dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709736093; c=relaxed/simple;
	bh=42hnCcEakg2QxhaqiZvNtijCrAdlpSQ1CmdYJoniSSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=T+j4NJHPQK8vOY2RisvuAVA3z5S+q0NMoBqg0+IcFAlEgOk6/T0VP0gC0z+z5LHSZqVVnTeb1cVHw1ub75zmBRpJT0xmKbZzLoAQoBA5NJo9T+3feyTWD42OClF0QSz3GqnFr8YCwFtf5vOWBJFBAGFaRMtFRvTCJ5m5B2MEU9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7yFn/0v; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7yFn/0v"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so1154214966b.2
        for <git@vger.kernel.org>; Wed, 06 Mar 2024 06:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709736089; x=1710340889; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgfEOqFrBntI7cXTi8KjV6/WAjtQRTbW+4TRhg14n+M=;
        b=F7yFn/0vYtPq68+2TUtKOoUt8GXyyz0hxz6f3YrIp8DPGO2TSp2e6eFaI0y2Idefr/
         6mnstBZULi/MPtGfRU9EFXkyeFIWO0ZMtOijCI1ysT/NtfhEeh9Um+yh1E+9r+th+bqc
         nVnj2Q7YeY/lEO/TrtuljvQ31QZzFStiU9jv9jKyhTK49fz+EV0wQIkSIuo1VLW/pYgc
         DkBZhavbRKnXZBb7ObvUKIr+ZmMmqrzGBHs+lZ0Z9q66hItfWSZMSZYW8eLA3QloG+jB
         2klzHhikK0LIbndpTtrgymNVyhsTFPUUZbncG4Prc5Gt6Ge+W403DMJcwKQ2RBnNbBMl
         SCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709736089; x=1710340889;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgfEOqFrBntI7cXTi8KjV6/WAjtQRTbW+4TRhg14n+M=;
        b=KSsbglVmq/EoQg+qPWjL/P+uZ9WR0yAuuVY0ZYQJkcZoxiV9TTAUMW9PfFttNBwYpV
         g1hTowSdE2A0RIskVkYRlCqCd3cHwXRYKjjNeyplIoyx/QygxCUQ25JumncjpI6LzSKj
         ljh9jju76G58os+lgQKp9aOBIlEMpOGHoMjicze+hqXwg2vr/FS6de4A0h2/ATPRwI/i
         dOL+/s2viZ7cYN/OhUEE3UyyIhAUX0/l2ZcHVK0HtJQ2nRyE0rDb8vqA5pOKvuDmh5Rp
         +34kc7RZ4fmMSa9gRiz7/vZBJ6p16CyKRQS64A2wwUE1AkxX/x2zOW4qA4QQ5+0hfOAm
         U4IA==
X-Forwarded-Encrypted: i=1; AJvYcCVbk9IkvBqpWuwILMUU6nJ+4WS7rTIuXjb1/dNhvUxocTfhtKkXERaj84fHUEFCxlX5bKvMZf36iNcIZkRMsd+U3SBs
X-Gm-Message-State: AOJu0YxsoMuYcmSk7hZfQ4HV2X2MwY1/EZSqzT5TJqZxBV6UNZjFRQd/
	XQa5u2I8tYgThBQGu3vIOi0nzPZLcqa4uF7y1ZbhHdoXKhMjFhbjsRb2ANzAlQoH+9lCHayFlXr
	gEndwzyCnEqSYQQl0ag53ICaMRnWBOElR
X-Google-Smtp-Source: AGHT+IFqJa6s3K0DQcWpr5S8q138G/n2If2xHct8zEK+zZOHINrFWYyjyW9Ay3mzRMik8iBd8/bEjeJ6opQpQXaOBck=
X-Received: by 2002:a17:906:71c7:b0:a45:182e:29ba with SMTP id
 i7-20020a17090671c700b00a45182e29bamr6587092ejk.30.1709736089084; Wed, 06 Mar
 2024 06:41:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>
 <pull.1632.v6.git.1709252086.gitgitgadget@gmail.com> <xmqq5xy036a2.fsf@gitster.g>
 <Zedtd6esmIgayeoU@google.com>
In-Reply-To: <Zedtd6esmIgayeoU@google.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 6 Mar 2024 15:41:16 +0100
Message-ID: <CAP8UFD1Zd+9q0z1JmfOf60S2vn5-sD3SafDvAJUzRFwHJKcb8A@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] Enrich Trailer API
To: Josh Steadmon <steadmon@google.com>, Junio C Hamano <gitster@pobox.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Christian Couder <chriscool@tuxfamily.org>, Emily Shaffer <nasamuffin@google.com>, 
	"Randall S. Becker" <rsbecker@nexbridge.com>, Christian Couder <christian.couder@gmail.com>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>, Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 8:07=E2=80=AFPM Josh Steadmon <steadmon@google.com> =
wrote:
>
> On 2024.03.05 10:03, Junio C Hamano wrote:
> >
> > It's been nearly a week since this was posted.  Any more comments,
> > or is everybody happy with this iteration?  Otherwise I am tempted
> > to mark the topic for 'next' soon.
> >
> > Thanks.
>
> I scanned through v6 yesterday and have nothing new to add. LGTM.

I took another look at it, and I am fine with it now too. Acked.
