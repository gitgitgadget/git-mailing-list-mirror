Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF7C33F7
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 01:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742090376; cv=none; b=IySz+Fg09MrzUFzZZVCBjQWiUNlGQBEv/Ck9i3IGCPll6b417Y+bBSwq7WymPpgzVwHmuiZjYdiaw9wc8M2AyssH1t544d7wvLg/N5FKw0WYIgo60Gs/0RhvyNPGF5IX+xZTSw49kpQECySTadEuUzXOS/qItAH5sLaDY46Zq00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742090376; c=relaxed/simple;
	bh=E1jbDhH5SNBqGI57qg1Bd/oQ6aW4f9H22IGrAHTUO9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tawuF+ax0ODSlj9ZY6MVytyuE0uzoK6sATyIq0+R/JNpnJw3OmijbK6F5r7tg1qwOIt2GqtgQ8JlSFsKJuvX1lk1B/JJID3LKm7ZheEG/ZQm/XTVOwjIsIMa/mSfbHkAIYsO6UKws2JFFQG3QTGZQpNk2l1B6JVdQ9BEGJwjYbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVvgFq4S; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVvgFq4S"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e573136107bso3112473276.3
        for <git@vger.kernel.org>; Sat, 15 Mar 2025 18:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742090374; x=1742695174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1jbDhH5SNBqGI57qg1Bd/oQ6aW4f9H22IGrAHTUO9E=;
        b=QVvgFq4SsWz3J6K7rWDsynovuVzp1XDm30BGp7xYzav3pNzeAFAtyZ8BL0kFGQr+6K
         10ByNZ9h0Cm7Zb3WV1GABs1bbQs/8pQWx+j0qK2mLYHhCO41m7Bfqo5x/UmbNfn/D2up
         lBKWafyMghW9i00n07irduVAvm+bC2QchgxTsBNoTUpG3JvjPf3GArtrTewGNWqgzjt6
         XJcH/cyTixRrNCH0T5PnMuQdz8L6kqKsanwEvonMlDiq2V7w1NCit6uis//eMTrsVk9Q
         QFy/6F8j7L/VKiKVj1F7XYBrGBQ8ZkjXsovXRGkyGc6wQgKFPBbjkldpYNHjRbawZK/1
         WCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742090374; x=1742695174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1jbDhH5SNBqGI57qg1Bd/oQ6aW4f9H22IGrAHTUO9E=;
        b=Wkh0XkN2EqH+IWbu1AkbfhNNvnSekBXFVW7TXsOYvSm+TyUXNwVOMleOzCv9D75qwD
         6t6BAkFO9SSmxxx5qTSnGhlwpuS9SYBZy5CzKtLhU0mNIYxCF6I+gRBih7zhDdUPko3f
         tn93ka9R2S123iSVjCBDM3tOGM6hASk9b5/GJx/45JZLL/uL8+GlvEQEBho6QdX8OSlK
         5oDwEiNUZzHiI37pxS2KhUuPEK0W2jcqwr24Ew6ziamjcOAqbvgK7hxmOncR5+yswRTv
         wVH7sJq+r6yHgrLF98+SjJJlZAi5gcNu0Q9Z+yDrv9Qmrj5BiCmOVbA1Kv75pjsE02Tj
         GCLw==
X-Forwarded-Encrypted: i=1; AJvYcCUyAQZXhyBl55S3sqXeqhUoemPFysfkd7sguChwfRG/ybZgWlfPTM2c6gwE/7ImP7z+6t0=@vger.kernel.org
X-Gm-Message-State: AOJu0YylGRxMkZ/UWAJKgpBzMT9Bhf07q03AtmjAkQg3sw3lWzioC6V6
	pDIFzAz4+xKQp3d4zmCOFVVZUTm28OJ6Xft2bS63VDStZorMj62/5esZFrLbSIV4MqkdgZvQv/+
	lri4RCTUnxCy5IZK/ka0kBZVyq5Q=
X-Gm-Gg: ASbGncsqccO5/E0KncQCU0JrWl4P1WtPOyc8ppD6Udb2qp1UWxeFILZ0CgjhE4WkWeG
	e1OP0DLCFqWdjDCJCAO4aGvZ5xY2NwmbIP53nNE2jSRiUnwIjSQqaAzlygQ/FrllBz7YvLFDWDg
	JtGBO4TlmW1QkQJSS1RRME/5vyDlO3ccrunLCkdC2OswdMXqU6ZWbAPU5u12OP
X-Google-Smtp-Source: AGHT+IE1rcNHNlzNY4hi8gmWHEZfswlkX14O2v5rBANiy9CM3/78XKn2xDt389QBoTJhP7Hj7AunnTRCrqh7Ocv2IE0=
X-Received: by 2002:a05:690c:a8b:b0:6f9:50aa:b7e2 with SMTP id
 00721157ae682-6ff45efc20dmr101444047b3.21.1742090373873; Sat, 15 Mar 2025
 18:59:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANrWfmRq=7Q=vCPgmcLcek=fRsw83BPqTX7gTpcLb=JpQpYZEw@mail.gmail.com>
 <CABPp-BHPAEcJibTaiMVE1K7AvYE+TYmOt7=6XUtcZbm7wsWhDQ@mail.gmail.com>
 <CANrWfmRpDFuqv+fkCf_p_ggHTrRjD3Vgviqrai_rA7Lu-YFEMA@mail.gmail.com>
 <CALnO6CCppGXFHoL1jSkUWQUh41=RHb346hW6Qr9hFJpTawEW=Q@mail.gmail.com> <CANrWfmQdnrGmGW3ot9e0DU0vEbstrOsqzh9Puv9dy0Zsr7zQcQ@mail.gmail.com>
In-Reply-To: <CANrWfmQdnrGmGW3ot9e0DU0vEbstrOsqzh9Puv9dy0Zsr7zQcQ@mail.gmail.com>
From: Han Jiang <jhcarl0814@gmail.com>
Date: Sun, 16 Mar 2025 14:59:23 +1300
X-Gm-Features: AQ5f1JrbOWFgkh1yHLmUrPVwczWB5_mZaLSSMtWEz_nYimHn9whGzluria4hiPU
Message-ID: <CANrWfmTFavk=q_h2yk6ORZnWyqyaANPnQ5vWiWXWXze5ng5C7Q@mail.gmail.com>
Subject: Re: `--ancestry-path` documentation has wrong graph
To: Elijah Newren <newren@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The patch is `/submit`ted to the mailing list:
https://lore.kernel.org/git/pull.1883.git.1742089659610.gitgitgadget@gmail.=
com/
.
Seems either or both of changing case of case-insensitive header and
removing optional spaces prevented the bot from parsing the cc line
correctly. (And I somehow got cc-ed twice.) I'll try again in the
future someday when I have a chance.

On Sun, Mar 16, 2025 at 12:51=E2=80=AFPM Han Jiang <jhcarl0814@gmail.com> w=
rote:
>
> Thank you for the help!
> The pull request has been created:
> https://github.com/gitgitgadget/git/pull/1883 . I'll `/submit` when
> someone `/allow`s me. (I'll also `/submit` before I'm `/allow`ed to
> see what the bot would say.)
> According to https://datatracker.ietf.org/doc/html/rfc4021 and
> https://datatracker.ietf.org/doc/html/rfc5322 mails can use `:`
> instead of `:<at least one whitespace>` to separate mail header and
> address list, use `,` instead of `,<at least one whitespace>` to
> separate multiple `address`es. According to
> https://datatracker.ietf.org/doc/html/rfc5322 and
> https://datatracker.ietf.org/doc/html/rfc5234, strings such as "Cc:"
> are case-insensitive. I'm just testing these in the `Cc` field.
>
> On Sun, Mar 16, 2025 at 10:50=E2=80=AFAM D. Ben Knoble <ben.knoble@gmail.=
com> wrote:
> >
> > On Sat, Mar 15, 2025 at 4:21=E2=80=AFAM Han Jiang <jhcarl0814@gmail.com=
> wrote:
> > >
> > >
> > > 7. How to make Gmail web client default to bottom-posting?
> >
> > AFAIK, you cannot :/
> >
> >
> > --
> > D. Ben Knoble
