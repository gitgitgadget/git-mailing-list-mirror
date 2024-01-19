Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CC7AD4E
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 02:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705630053; cv=none; b=FRYCLI6RE2U2J4c9+xWg6vgaUC3uzCQHudqldBlaKwBGC/kfHiJN33bZqE4DH2WbhQLrfyk5kiD93CtstNXqx8/I6q5MxCfBVkDJax456ARgsFF76HNJIwvB5jgjMoVRJCp3LHAN+6KpQuIjfHiKg4TpJMcRg14gwZkm8qeJIRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705630053; c=relaxed/simple;
	bh=na5PxnWSTehaJ7lgxmScnikunKZLI29q9f0L810xPNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p7DCF8lz/Qa4plxCaVPxqu5Pq72uF7beZIvuqCYNtoMvSRNCQfa41Gqz9qNbxAD+RW00c+RPgVlWJoDi2dbOrn7hh1VRZtdnEuOjdMDSNBDXaOf1wPHz6LsyadhlBoUDqHxccrRI3QxdE/AliMz9Fs8t92m+l+wZPq1VVm8mBB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihFsh2Oz; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihFsh2Oz"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cdb50d8982so3447051fa.2
        for <git@vger.kernel.org>; Thu, 18 Jan 2024 18:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705630050; x=1706234850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkWCCGEH8Qev+zbz5Js4NQWzr0FDB96eKyhVu1kI3nQ=;
        b=ihFsh2OzuGwJ6+EVV+vDljOhkPqVuvmhqqdm0x5dPhdqWLb5tZkCKZr6KkhDfKwQkg
         +AFg0v9V9zd5cXQaU+0i4zlQkBvU45Yx6zqmci3VQjxRbeH4ruPLA0YvSBjqfq5blvKW
         igaIwYLVgyQC4RhJA/Ekeqe86sxdie8NtC3zeRp+g7tUnKqp7Kh0AY3FkYaHW0JQttzj
         295lPF6rQZt12PBbC888jsem1yO4baQ6tq+d+pPzw8wQrghytiWv2m1zfnjYrfiyghnr
         8BOVNRc4+7lLbgOGyOHf36QJZlFb9Dllf7w1ySpm49KC+xHQeJhRBGzcX4OVVJpfxGG5
         RypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705630050; x=1706234850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TkWCCGEH8Qev+zbz5Js4NQWzr0FDB96eKyhVu1kI3nQ=;
        b=DgV7tKcf74WVEI9Hmp+h/JLKIGQsHJSA1nmZI3Fz4SOlRN8hqZr4Oeo8RJ4qkYb/sX
         Yt2FXVrinBFp6XMhFuUOPozakaQu5TM7c7ttWGS59Rzk+iE2S4iOpxMaK0CYGM+lD59p
         yFC9GyXrKGtASPsQ7a9SS0xuyR3y6L1VGztXPfTvIDgKyxbxBDHuhe237ILdVW+HlURN
         qI1sR/SfMoUgB8bDtR6qbAT7lI4CGowBCDyC7OG0Cz+CKo8gOIYpNu0dmstLC3weupDA
         H+jmj8sEBgEVO31ta5EvYFl9e1wnhS8xkv5KhncnNh/FB2/lHxiEDOdspHQHz0KOx9NH
         6xLg==
X-Gm-Message-State: AOJu0YwCFhCiaklvcpYOUV8/+0D/N9vYWuP6TpHgRpscaS6wiFtVDoj2
	I6mRqYISOGwQSIxe7aRCSB5ZfuLCIcr1nCCYmOQiB8RDuZqB1v/4vRQu2sDrPu3eTK8ivddSRVR
	BmFxApz3cIQmbmsSQBBs61N0TrcI=
X-Google-Smtp-Source: AGHT+IGip7oFJ2DB1PzJNMyqpc2sqJfAD7K/1SZljKaZvy0eGWX3KzRH5deVkv7fUWlLjh4uPX4Zj8WnwC51r5YBAzM=
X-Received: by 2002:a2e:8297:0:b0:2cd:7048:8852 with SMTP id
 y23-20020a2e8297000000b002cd70488852mr856279ljg.82.1705630049717; Thu, 18 Jan
 2024 18:07:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq34v6gswv.fsf@gitster.g>
In-Reply-To: <xmqq34v6gswv.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 18 Jan 2024 18:07:17 -0800
Message-ID: <CABPp-BHUVLS4vB5maZzU5gS33ve6LkKgij+rc1bBZges6Xej-g@mail.gmail.com>
Subject: Re: what should "git clean -n -f [-d] [-x] <pattern>" do?
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 12:21=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> I think the current code makes "-n" take precedence, and ignores
> "-f".

:-(

>  Shouldn't it either
>
>  (1) error out with "-n and -f cannot be used together", or
>  (2) let "-n" and "-f" follow the usual "last one wins" rule?

I believe so.

> The latter may be logically cleaner but it is a change that breaks
> backward compatibility big time in a more dangerous direction, so it
> may not be desirable in practice, with too big a downside for a too
> little gain.

Yeah, I think (1) is the safer option, for now.  We could potentially
do (1), then wait a long time, then switch to (2).
