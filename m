Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFCA1E501
	for <git@vger.kernel.org>; Sun,  5 May 2024 18:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714935593; cv=none; b=q5Xy9lfu2vNLxB2Wiuhq6WwxJZnQlWqK65tK+QiFm2z0yUw7VGaeGVN8f0NXr9PzFu7B7esOxmguvd9yXAuMb40DoEmrnY4YBgOIGtPd3puIxF8mRO2EgtbQExQ7tRdnAUDfj+oBMlFoWwGmO/XRN0QrgOkhlsyqCa6YDevNJEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714935593; c=relaxed/simple;
	bh=wUN8WyLYy7NFC7m2C8y3PhZ58Cpu24X0cmPfcN1+ls4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJJUrNp9jURG8iub3au189xnMDYru7GNqDbrykmC7EesOpkvWdhNDIOUU+vFreyNjHBIzCyv6rR90TPsfrS8bECk25bDKZx/v7Ct3vVzB143sK1d9Pd17MJ1ZmledZAgUn0oal8gWC1pYh55pniPtquwyWuxim5dfS5pc/hi6Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEu2MDtq; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEu2MDtq"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a556d22fa93so277428666b.3
        for <git@vger.kernel.org>; Sun, 05 May 2024 11:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714935590; x=1715540390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIVpIfo6GoNo+l6yNHWYDYYtiuYUhoruE7J2duDvzzk=;
        b=MEu2MDtqj8pzH8GNb8i3utKswO+gbfXM2SNn2R5Z+T/9hWdTwl1YMum3tIWYzDqPcG
         bRaHWG+e8NKeyZozWU+58r8Kjvd4JeVtfcurEkjx7LnamTThTr1jefOU6UF+O7ypT5LU
         66vVl3NUu/2Gd2xc031gfDbKwspwbb2ofTC4i/BYR67HkWdOoCjAQ13UR24L5tdgv8PV
         JHKNAMhXvNfR+FzTbWdpGy6BYvzHGdCWAPeJN44ROH8U40hJyJ4tZAwezCu/zUTH4wQe
         tD6PZY5vR7ufD0+tkQ9hKjcAnEyvG+YUh+HwAfe7f4va/St13UOrkLHrMOMmXy59uB79
         QB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714935590; x=1715540390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tIVpIfo6GoNo+l6yNHWYDYYtiuYUhoruE7J2duDvzzk=;
        b=ZTBpfwj7shdLjocscbV6P0ewRFaSXHTMwBTMB5wIycQ0JQNRtMBerXzJxhzlzmLRy/
         Linc+jVAurbE7MFqSfpbUXpO6QNkRQud81HJINnWghacXLnZF7d9fCa8Rsp4Mu03nWtI
         uHKx/mwhQqGBrELFUJEpAky9POKSV053iC9wD246GyophZJCO+icjgF7HpOhbMrWwCV4
         oSnMaij1BPU6N98wNt9do5BUyrxWJi5Dvq5ZQbykV18FowljFKenQWOe87btKYUgR0vS
         IK6jmtqZPlUcsn7VKJoe80r5gWH1Rr143/qogYpOZBewG3TJ7xvdXBbaIz/4u9t6SiKz
         L17A==
X-Forwarded-Encrypted: i=1; AJvYcCXQ50Tl5yTrKZy2+ONEshRuWbqPxsvRbpzbHXzh1y4kWfigm8WKaITc8Z1UwGKjtIvYkYzDqlKASzfrRNyg7nfzvFxZ
X-Gm-Message-State: AOJu0YxRvvdZqiZV0jTiJcIUBC+KnnuaH3W3bWOSkO7kuFGADwCLON1Q
	82evRcDGQ7POm+YgkP2p9FLCIqLhx32dVvNiAc+8Ye9csn27i+Q7Pw3GC3+1z/UKtOtEmS/z9kK
	AD4q5FoI1JcsAJuRE/7d8a5sjEzM=
X-Google-Smtp-Source: AGHT+IHZ6mVtG7pQYn1fh0LoYwsCxB8XmsxugayEhfxIFJZ+7wi5qiTge3UhApa6B0wPvDBWyEmUmOL59XNb4nCY4Xs=
X-Received: by 2002:a17:907:e86:b0:a59:c728:5430 with SMTP id
 ho6-20020a1709070e8600b00a59c7285430mr1350578ejc.76.1714935590329; Sun, 05
 May 2024 11:59:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1723.v2.git.1714409638089.gitgitgadget@gmail.com>
 <pull.1723.v3.git.1714416863.gitgitgadget@gmail.com> <5b6239167b8d7c26f96e5c23d0d82b7a3a9b01fe.1714416865.git.gitgitgadget@gmail.com>
 <xmqqv83yrduw.fsf@gitster.g> <CAJdN7Kggv-y8xRhdFanTyxa5wP-bG0omBPuETW6qijA67gn8oQ@mail.gmail.com>
 <xmqq4jbixzg6.fsf@gitster.g>
In-Reply-To: <xmqq4jbixzg6.fsf@gitster.g>
From: John Passaro <john.a.passaro@gmail.com>
Date: Sun, 5 May 2024 14:59:13 -0400
Message-ID: <CAJdN7Kj0nW2TSsEO4W4A6Oy_1sG-Tpz43d5+883G0LMvWeL2Gg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] builtin/tag.c: add --trailer arg
To: Junio C Hamano <gitster@pobox.com>
Cc: John Passaro via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 6:23=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> John Passaro <john.a.passaro@gmail.com> writes:
>
> > There's also project-specific trailers. For example, on my team,
> > we use "Deploy-Strategy: ..." to tell CICD what deployment routines to =
run. This
> > is pretty specific to us but worth calling out. Maybe could translate t=
o a
> > documentation example with something like "<Project-specific-trailer>: =
foo"
>
> The last one that uses placeholders for both trailer tag and value
> may be generic enough.
>

done


> > However, in service of helping users find workarounds, shouldn't we tel=
l them
> > --trailer may be the culprit?
> >
> >> Failed to read '%s'. Try again without --trailer (use -e or -F to add =
trailers manually).
>
> I dunno.
>
> If -m/-F that wrote the original using the open/write_or_die/close
> sequence succeeded, the "amend_file" thing successfully spawned
> "interpret-trailers --in-place" and got control back, yet we fail
> to read that message back, it does not smell like a failure with
> that "--trailer" option to me.  A failure with "--trailer" that
> could be worked around would have been caught in "amend_file" thing,
> before the control reaches this point, no?
>
I considered "Failed to read '%s' after adding trailers to it". But on
reflection it's really pretty difficult to imagine why this would happen at
all - like it could only really happen if the call to git-interpret-trailer=
s
somehow corrupted the file. Probably best, as you say, not to speculate
about the cause when telling the user what happened and potentially
mislead them.

Plus this wording reduces load on the l10n teams in case this patch is
accepted, and allows future changes to enable this code path for other
reasons with minimal change.
