Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BF460B80
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 19:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707853982; cv=none; b=qpYMhiFYu1fS1k2+CvLiGwFKoEMz9FaimE1fXFkVu4V04HyxSIV/QMN3nDqpPdFeWtClclUyjGPBLFk3mzMrJuYMNM45KYcORcLK3lzhmqo9y072+4WxCSdNtsUkqtaNjWmK2VKRuD04mElza8k0HCLm09bmxXlFdoL+joeLpdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707853982; c=relaxed/simple;
	bh=BFyVGKe8oqoCsFy1T/LFm+2UMtubZqyjYoXHDAGEKjU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nsG7rUb2Dndq22VXMRi/dedZAC5z42KcUalrnqk4AT9GGVAba8eW3JOmgAQQ9kI9wrFQ3xqER6W8Sh2meMBaz3uhaG0ows5OjofN+bxKs2yCTvqNQtKFwsAqTb4RFJcd/C6L0neqZIkyBItM1D9Tp2QNY7Eovxst1a8gK3Zeo1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E/VEBemo; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E/VEBemo"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6077ca6e1e1so22324817b3.2
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 11:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707853980; x=1708458780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IdlNnq9dCbna4hyORyBBqf/TqGNdot5J95QByDjFxJ8=;
        b=E/VEBemoXLpVg+Px142U/90Hc6YZn7EuFSbsrZXp/+egpFxN5er5lu5aKmnLxgCxby
         ryY37Y0wJxBDxdUvCVbPyDmqand++WB6Qe2W6rNh+wvr2upMkiksk3ITtcmRp3Vqp3FP
         CHo7dA+x+TP0Jb7/z+t0tJJUa0mWiHqZ/5CXdB1iWXZUv6XLUuHNROX1XuWjR1d9cRU2
         Q79b9SMxq63epPL22aaT6OyN/0oAZI5RH52Wjz/st8rXb1kKWC2Dk/HUV0lyHdgyN1+3
         BorH+EdGByCz9J42iiaxFj+ieGDX5YsHGaHOfiK1FnELLDEBiiY0yVf8MBWVgugIwUWl
         5w9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707853980; x=1708458780;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IdlNnq9dCbna4hyORyBBqf/TqGNdot5J95QByDjFxJ8=;
        b=IuQ5U6pXz8sLARrGZq3r5SVF3URuVzeEoDHJ4nWBKfOz1SEgr4LMI8zdvUbEmOqglL
         2+VaR+pmqCdD4TREqqdVVXhgts6E9NhGlLMBr1X4bLp1vQvBpDB+Zu804bRjBTgQZF9j
         YbEr5HUbeGxbrwCs0C7zqKw576YByUlLOmE4wbWzFXXv6iJkdath/1RDdr9aPtULNmOq
         up3k+ikRoHgfQB9OOetWTL89pUNy7CBf9UFB7f4XL+/PXQIBct8/uwXHCoq7Hmhyqd9P
         4jiYSzDCeGUTyGAcsmg/r50vHgerXmoKgxwD2N+cYhOfDHf14jnIljc2DoR+XA/Y57V4
         o4jg==
X-Forwarded-Encrypted: i=1; AJvYcCWJ9oxXVDI0FuCADLLerUPeeUaGii/iNU12KgS8xwxZWE5kfu37+lxbjy/INmLlL0XMeCrRW+WUxEXkpjSJ3Wc6GquP
X-Gm-Message-State: AOJu0YzBjEooDsbT5CBrkF5J3VOU4pUInPjW1DqkdV4mK9R3vdB3trtm
	78/ME0BvtC8TBbd9BogwbqvVIDXSKcg7+wMP+X1bHyryu2lsSc9soyVS4BNOaZMtwrKxPQrvu8S
	Ywg==
X-Google-Smtp-Source: AGHT+IFnm8QiSKuP1kpQc3T+RrUe1iisL8nH72RshiWhpqS8hYfsC8DucSpwjaEGl8/kVMoyRcQu2i/vJ0c=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a0d:d557:0:b0:607:7f86:dc24 with SMTP id
 x84-20020a0dd557000000b006077f86dc24mr67315ywd.3.1707853980114; Tue, 13 Feb
 2024 11:53:00 -0800 (PST)
Date: Tue, 13 Feb 2024 11:52:58 -0800
In-Reply-To: <CAP8UFD0nmK4ZigW9LcWOr_POEX5LX7m+T=Jq9rK34YL5C6xatw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
 <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com> <ba1f387747b08a7270f7387beddd75dc4a8eddfe.1707196348.git.gitgitgadget@gmail.com>
 <CAP8UFD3u+QDx2LqpO2ZpeHQszwjMAsQ90qqbE7Om=t1vPRQ==w@mail.gmail.com>
 <owlyr0hgb7qg.fsf@fine.c.googlers.com> <CAP8UFD0nmK4ZigW9LcWOr_POEX5LX7m+T=Jq9rK34YL5C6xatw@mail.gmail.com>
Message-ID: <owlyttmc9m5h.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v4 15/28] format_trailer_info(): avoid double-printing the separator
From: Linus Arver <linusa@google.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Christian Couder <chriscool@tuxfamily.org>, Junio C Hamano <gitster@pobox.com>, 
	Emily Shaffer <nasamuffin@google.com>, Josh Steadmon <steadmon@google.com>, 
	"Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, Feb 13, 2024 at 6:21=E2=80=AFPM Linus Arver <linusa@google.com> w=
rote:
>>
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>> > On Tue, Feb 6, 2024 at 6:12=E2=80=AFAM Linus Arver via GitGitGadget
>> > <gitgitgadget@gmail.com> wrote:
>
>> > Also I wonder why it was not possible to modify format_trailer_info()
>> > like it is done in this patch before using it to replace
>> > format_trailers().
>>
>> The artificial organization apparent in this patch was deliberate, in
>> order to make it painfully obvious exactly what was being replaced and
>> how. See https://lore.kernel.org/git/xmqqjzno13ev.fsf@gitster.g/
>
> As for the previous patch, I would have thought that it would be
> better not to break the tests.

I could just squash these patches together to avoid breaking tests (and
also avoid doing the flipping of expect_success to expect_fail and back
again). I don't mind at all which way we go, but now that we have these
patches broken out I wonder if it's better to just keep them that way.

Junio, do you mind if I squash the relevant changes together into just
one patch?  I'd like your input because you requested the current style
(modulo test breakages which was my error). Thanks.
