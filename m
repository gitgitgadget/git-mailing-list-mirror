Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C3B16B395
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 09:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723453529; cv=none; b=LYysbDP7DHbJzEi6qcm7UsKcAPD8NDkthwFhDwxMsgKXBX0gGTtuG0dJbOagbu325YGKx2nZYhmdUByd95yqd2LuoVLh8vgbhOIg/wfx0YJ3w1vq1u7AqG1k64wpOIr+BTJon0L7h3MF2kCwhtyoD5YO9Q7zxL4nV8Co3UhS3tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723453529; c=relaxed/simple;
	bh=WoM1ZNq517tzMVQ3GUu5gcVdDcYo63NdOv5vhNHIjGg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O8O5lWRNd1L5QpcGr/y068ReTU7x3O1TALeRcZMRJ5CZMuIeow83vFHyrKM21q9g3q6fd7S97xCZuD6SEG4yqnBqpxNxWAvgp0LQyeF94rUg6fgDNX9JUzURRLpMa9uyAgklTOza5p0Cpuf9qikxxyfhoElVxTw9ptEW0jmnys4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mq/B/6Jn; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mq/B/6Jn"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5d5bf833de7so2329238eaf.2
        for <git@vger.kernel.org>; Mon, 12 Aug 2024 02:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723453527; x=1724058327; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WoM1ZNq517tzMVQ3GUu5gcVdDcYo63NdOv5vhNHIjGg=;
        b=Mq/B/6JnURRgD/mauaLSRHOGDWXHqfur/93j40c4YGvYNeTnk98Z/jsinyHlzGXTSm
         ecfpU+nZwP5HdXDUPkEeGy+eVs4tnLMhWovNBxfZB5MnhteY5nUZVzQu6LauX+JUnSnq
         F78mKSTiomQuTEaA5QlR2wWhwOceLnXB36XII6xGjBSmPGNoXXPvo80xVVZ3Xf6mnMkR
         iyIh4cBAlehdZqCYYiMCeXdw98zsGa86Disb+6ujeTB8TptJ7CPMw63fwh37snss8P5m
         FfQDa39iRV0wmgKfhLsqy4zkzdkWtZKe9XrDoFDkcUcn2oomje8aemO6/Ia+B1K5cjuq
         A9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723453527; x=1724058327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WoM1ZNq517tzMVQ3GUu5gcVdDcYo63NdOv5vhNHIjGg=;
        b=jNVbClCdbyVBZVoo4+oysWembZIlFpnhkX4QzitbeT+XIreJZwlbp+LSUAhDwKXGvQ
         ktPWrIjTxItBXtc7R1TN3VhUKa7HF8KIedBC+atzSYmGg3osi/IkM3fZ56UKc2hEODo/
         HMOSlkVLx40JvT6m+mVCwHHsE2/mFr/CYAShgHvvyIeXhuwujnUS/2ytxNbekOTsgD2g
         r8mkFoZ9049dy/YBfI+lKeEuIAV53cgXY9yDJtwYs9NCcl7lIXKcgN0C/0X+o2DD1Bwq
         Sbifc6JoGMEOj5C3X37ok8z2FMUGWhBxzaIaw8UQCtQWjxItzuIN3eICfHwcZ7InFShi
         QcdA==
X-Forwarded-Encrypted: i=1; AJvYcCWYYO48tWOMKKL0VdltP5pB0PcUz/+noxE2qmtvsli+ytMb2z3bEVkc5dQ9nLGIsoi4K1EhpjMxVNZtQZOg2Ez1fN2+
X-Gm-Message-State: AOJu0YxXa6jtvp4adIUKbcuwNBs3j8QUKu1+AdzyAGEItX3RIiwvuVdP
	D2vvG3MC/uF2qO8uSin3/8OubIK2l0cfn8yNphoONA5qIqVbAWXtE+npNdDUTFdE24QSuw8if1H
	BLe4pp+cGOfGEg/F3Hyg5lC4Su8o=
X-Google-Smtp-Source: AGHT+IFY/o0IxBdPvXPOXbFZugM5kOlqlnbDl/iZ3PNmolluBT6CCAOZtzmYJIv90vTeRNb/X9gRG8HlHJU8fmdFclc=
X-Received: by 2002:a05:6820:1c89:b0:5d5:b226:2ff5 with SMTP id
 006d021491bc7-5d867b03760mr9302852eaf.0.1723453526834; Mon, 12 Aug 2024
 02:05:26 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Aug 2024 02:05:25 -0700
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <fa2d5c5d6b7b9018c3271a3c955852d1aeaf44d9.1723121979.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im> <cover.1723121979.git.ps@pks.im> <fa2d5c5d6b7b9018c3271a3c955852d1aeaf44d9.1723121979.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 12 Aug 2024 02:05:25 -0700
Message-ID: <CAOLa=ZSPtce9WFCyxDP5Ct7Geqj-g5Q=zfi1R3-kcs5Ms8-7YA@mail.gmail.com>
Subject: Re: [PATCH v2 12/22] builtin/fast-export: fix leaking diff options
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000412145061f78cb11"

--000000000000412145061f78cb11
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Before caling `handle_commit()` in a loop, we set `diffopt.no_free` such

s/caling/calling

> that its contents aren't getting freed inside of `handle_commit()`. We
> never unset that flag though, which means that it'll ultimately leak
> when calling `release_revisions()`.
>
> Fix this by unsetting the flag after the loop.
>

[snip]

--000000000000412145061f78cb11
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 29488614549633c9_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hNTBGUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mdzRQQy8wVm1rQW9ZVVUzWlFoUFdlaG1ZSUp2OURWUgpkOEVTU0c3WVBW
RVMwbUV5OG1yMXEweFJ2Ym0yMlgvLzRSYzM5YXNLYm44NTlPaEZsb3Z3bUxVUWkwVzFRNXJuCkZ0
S1BnU3FFLzl3c0R5VmxOQUw1YVF0UGtRV1JyOUJFNk5SWU9jeXFDVWhsSHI5NjRlZzZmR20rTXht
MHBEQXgKVnloZDRkSmlNZkJaZTZyN1JEWGhJV1RJMjN4dWFubXh5cm40WXRKbEdKNlFUUExIK0Nz
cjNEMWxoSEJETkwvYQorUk11RUhrdUM3KzZRSCtHbGtoM3RkZ1V6enI0MFg3NjBwMHQwdkwrNVZn
RUIzQ2lGY05jdjZkelhsUHRRY1NyClhVNWxldTBsU05SQW05R2dlU1hjU0xyV3BrVW4xL29ZcTBR
T0pwdENyaTlUN3lrbEZiQkI5MlFmSEhYNzVPMnkKL1FmTVBxVysvWWV3RE5SY1dmbU9RSTNNaTFa
eWNYeWcxWFh2cEM4QWtRZit0REdsTUJQTVN2U09ubTlSMlZCcQp5VkZnSElHWmF0TVp4NHpxLysv
bjlkOHNaMk5UY3hMQ0ducVEvbnFhYjdPcWhVSFFqMnBnbURYYkdzOHpzK3RBCnBQSmZreFdpNnY2
bGZ2dDN4elg5R1JzYi9ucVdGZkl0NVp4WDg2cz0KPUhlbFIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000412145061f78cb11--
