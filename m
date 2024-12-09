Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1150812D758
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 10:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740961; cv=none; b=CWxfMOklgjXeFKL4xVv8xoTfvW/ridWhKSfG2Q8WkzTKFnlUhXo4Arsa8kXjqDEwlRM2UKAr2pjzvzzRJpIPvRZIQNTsDcDtyIMO08wrJughkDjUD4wZcoRd4JirfFeQTcCEX33gA0YxDCrK0mO1KiAcwyn6soxRxhKdj9OCLOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740961; c=relaxed/simple;
	bh=74ox9Vw0FIc+afhvM9E6jO9kFKhQ//Pff4iElVC19jQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLPpNDESTs55HLCDq7mhmPhQDd4QltuXHrUrf8gtkwBPumcnK0/QkuDl21j58mQOSrtnVCu3VBkkJCvRaWZVfRVcfGQ3/My+XyIc9mHF43c3fzV7rCT4Fjge2j4hrYgj7zUY5xHTRcGTFuU3Z1fzPVJOSNo8+iypFsL+eYo8jB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rl3ziTbp; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rl3ziTbp"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5cedf5fe237so6594158a12.3
        for <git@vger.kernel.org>; Mon, 09 Dec 2024 02:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733740958; x=1734345758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74ox9Vw0FIc+afhvM9E6jO9kFKhQ//Pff4iElVC19jQ=;
        b=Rl3ziTbpvXI2eBoTLeoX8kTZFTdVd0Y4nMPlCU16qTDTgrSkeGOpC2ifYl0giLgVV1
         GYIgLZqNbtYa+EKoco9F4wFNx6hm+HYCowxJuoxmQQF6pehcheDRAKKRLJNDjagmfD7t
         xbB5UwMp/SxzHK7jafIqeusMhpinPBcjiGLkaPr82Blu+PqYmP41Xz7b+3SQEAOPtksc
         Rqy6D7mXCp/W4xUHtusj95cOsazOksWjVWCH1tFTch/LPJP3K/fF/u+Daq0K5Aq3GNOL
         zBqqPe76Xy2yp3ViB494F+JQRtPqVxeyOryneLQHaBL4E9GNPPUlvgnAOiFHrfxmI57c
         aLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733740958; x=1734345758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74ox9Vw0FIc+afhvM9E6jO9kFKhQ//Pff4iElVC19jQ=;
        b=mhzm4g3K7U4kRguFWCXXeLXGDIeYx3Xd+5q3JCjpNkBGKAPsH9syX7n84eaZIdWXfp
         6QydZIhRF8PsX6OAkOapzOsUPHQaJ2ZE/jk/ZY43Eb/kfUow3n5yT97aOaciOMAh9+Hm
         vFWUXpdV3LiWhw7d6k6g+tKcuoHlO4xaQ1/DZpPYuQJsVYWtBq1IQAvBBYbUL3Ziw5XZ
         yoW+LQvn4/EXB6i+vnuJHl7gToLKXFkI+ceAFk4rI073+Bcc16InGPXh8oW+cFLF+Jnu
         QQJFMi5Wz27PfzPJnx+b8hzZdzAcawR59Vix12jLMwAXmaTxHRGZsoRsS1CP+CMods/7
         iahQ==
X-Gm-Message-State: AOJu0Yw2XkqYkR2yjwJQsYd6nTreWXqTCn/tGscy3JO0lthOZqGeo0dq
	+AQIic6LdNViasF4VKOKMtRPsr6uUpAfzsIKbeqLyVYf/DLwo/R7FmVUIZyPm1irX5ybuHSDlvM
	lScHSECvYhAClYmTvKAFBX0xZjng=
X-Gm-Gg: ASbGnctHhNmMMMsfRCG1gEaxEb2J6rxq1Ji+wfII6wyjGi6pbKnVAqhHfhSOY7KsWZ0
	v/A0I/gr66/XZN7QkXGJ7IofAxgpBl6MnoA==
X-Google-Smtp-Source: AGHT+IGBj34zsBQpOD4tjW9jDmgXkMdtaaCqZqw5zs/48ty/Z5+7UvTR0mIkX/uNLEFkE53yKNfzLwRmmyInVdwhPho=
X-Received: by 2002:a05:6402:5194:b0:5d1:2377:5afc with SMTP id
 4fb4d7f45d1cf-5d418502c8amr77081a12.3.1733740958228; Mon, 09 Dec 2024
 02:42:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910163000.1985723-1-christian.couder@gmail.com>
 <20241206124248.160494-1-christian.couder@gmail.com> <xmqqikrtnuyp.fsf@gitster.g>
 <CAP8UFD3bdEo1_bg+aX52xSGxmg9KfNrpiX+2LwUM-yDqjvfZbQ@mail.gmail.com>
In-Reply-To: <CAP8UFD3bdEo1_bg+aX52xSGxmg9KfNrpiX+2LwUM-yDqjvfZbQ@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 9 Dec 2024 11:42:26 +0100
Message-ID: <CAP8UFD1fwKLn=aETNacv-Udzfft=-mztbuKeMvNq3Xo8uYbzyw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Introduce a "promisor-remote" capability
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, John Cai <johncai86@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 11:40=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:

> Yeah, not sure why

Sorry for this. It's an editing mistake.
