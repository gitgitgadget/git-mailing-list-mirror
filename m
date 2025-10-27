Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BE92EC563
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 08:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761555532; cv=none; b=JLYMtQ6Mr47YsgPgR7DcS9vtmWRfaG8EyraCLUorJItAeSyD3v3gAb8kaxsQw5Kc1Usolg9zBbaBre2MSzAX+YRd3B/p2c/eTQW6IyIjMQoJy9xRDtJXQT3rl7BWtXyXZ4wwKsbsKS07E3XUsu//LvmLfckRITXHIAzCONFMJyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761555532; c=relaxed/simple;
	bh=I5u7P53TR5g+jdnfvrUgllLHlRztFwDGkU9wzHce8Uo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X572wv2Dfc1EsSeZTfXfvFFIvHRKYdsoxH1NUMEW/SD+Ixa3k7KbqG2sR2uaYJ/oiYLidrx/fVgBve5ZNulsRopaFJcouO2eeX+uKctip2TvT1tJrX4TGo9itSFO/ByYH+5FEQf2okXBrS4IUQsTE8K/2APxNaKB6p3aebHF99A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imMEpZAl; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imMEpZAl"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b6ce806af3eso4013853a12.0
        for <git@vger.kernel.org>; Mon, 27 Oct 2025 01:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761555530; x=1762160330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5u7P53TR5g+jdnfvrUgllLHlRztFwDGkU9wzHce8Uo=;
        b=imMEpZAl4rEEtl387FG/6gtrZH+Hq8Wh+iT1pOzked+tPUte7anMMZOQxsNmfjuUi3
         tSby4CAOVaWrz3oQkXbJk0nn4drt/ZiTBCeoiRyZJAeLxyHHFxfIqkfCpeufjx64TSof
         Nd6d2Kn3QbTDNgkfATM4m42iMQEJXo5ccOGVFaBZUo4cUhSUfyxE1NkGMGf6NtTJB3Q6
         B2rS/O6FSTJ0XVbhd0b8BjGqH6J+yMqplKiATaAePRg454vCn8c71t5TqP1tUHjGpxDq
         eBwgqAwNmGJvhpR1Q0v7MGLrLYEKQR71wOa2eL79oJCZN36nnZ1c5c8wHy8U2Zdr3dY6
         VV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761555530; x=1762160330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I5u7P53TR5g+jdnfvrUgllLHlRztFwDGkU9wzHce8Uo=;
        b=aZvAk3QVOnrtv9OE4vZedyAueW+yUmNjBVaHczRWiFOc8I5nHEoKcRYgB6rd+9tvKt
         pBW8DABdcjzrn2ExNlQ8Yp+92d9tYwx1BOb4Dv+Mj0j1db1F7sXlH3paeWGvIrA4HI0L
         n2A1rYEQchmtOqWfArvk6k4B3uq3YAqlBAMSOkSVTO61VqZhdEZnV/39HVr+KGM06GhP
         FsbEGcD+cV1NY2xFeSLPJJHBEdojdaJCIAnMTVwxB1dWxzGustdqpKnKZPHv94zhX8vp
         ix/WLKCS/M7lO23fddUdyJQ4E9LeEDLwFh5nAhiqEeuJi3J9CPH2bs0Rg6zxloupDmXU
         6BqA==
X-Gm-Message-State: AOJu0YxZgLAGuF7jYl1tuQYHLwzwdaTk3o+J4ptpBr9iriV8FljBc0rL
	GOGDq0/M9jqc6Z3dQT/vgSfS4tM11OYJP/37jXI0+FrcCW8BcP2ULW+XPCqQV+8OyM3UAiWmqrs
	ZM/6NC6f7KwZWh63Br8a1AvOENrgchYXPxbaD
X-Gm-Gg: ASbGncvMN4KdTHCpr8TQ/oZBkYEGHf3oSfJrN050ul1Be+zxB7ivDSJcFzKNbMFSQbL
	bsbRfb+ZmjxBNNZMQrwBVQCDeMk+D30mhA63yaWeGVcr6LuZqsK6uRJzna/SU4k0uB3C+4FtwCu
	9t5kTurn8Fb+tJ6VV3mN0VIxxB7A9/WkfIFbPn8ntTs+Grc6kLwHPQWil6Cj9WSGQsmWLUP4QRo
	dkRAxpUeTjAMvLKWM9kqs038X+KI/DI2ORfYMFIf4Sl1finGFAT5qt+j8IidD5l1I+YlY3N
X-Google-Smtp-Source: AGHT+IGo/Uk97kyxzK5N2cE3JvN7Zi0LT8D9L/PWFIt33+/+Ky0UsTiN/P0W5dYr8SbS6DfMSLBhxTzam8/o7zQSddQ=
X-Received: by 2002:a17:902:ea01:b0:27d:69de:edd3 with SMTP id
 d9443c01a7336-2948b9a141bmr167084205ad.20.1761555529873; Mon, 27 Oct 2025
 01:58:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD=f0L-Pr9MtQ1=Wrm3tybZFWKDUtDpVcOahoFUgdVcGKJm7Vg@mail.gmail.com>
 <CAP8UFD39hqkcy3WeOdS3Z_N8t5kMTipmE6-N_MwR6PhozZLfXg@mail.gmail.com>
In-Reply-To: <CAP8UFD39hqkcy3WeOdS3Z_N8t5kMTipmE6-N_MwR6PhozZLfXg@mail.gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Mon, 27 Oct 2025 09:58:51 +0100
X-Gm-Features: AWmQ_bnbbeIxgpaQD7ENh_nfQn6W1AbP1jCp0JKNl1_e5yMCWiWF2WDbOK-9y_Y
Message-ID: <CAD=f0L-c4GYEq1pNDGy+=hqig768YEsBLSDC-r8ksS1bhGGPGw@mail.gmail.com>
Subject: Re: [Outrechy][RFC] Request for final application guides
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Oct 2025 at 09:15, Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi,
>
> On Mon, Oct 27, 2025 at 7:09=E2=80=AFAM Bello Olamide <belkid98@gmail.com=
> wrote:
> >
> > Hello, I hope you all are doing well.
> > I'd like to appreciate everyone including Christian, Junio,
> > Usman and Kristoffer for the guides and assistance during
> > this contribution phase.
> > The deadline for the final application is in exactly a week's time.
> > I'd like to know if there is any new information on how to submit
> > the final application as the Outreachy page requires us to record
> > a contribution by submitting a link to the contribution and also
> > submit a final application to the project.
>
> There is no new information. Most of the interesting information
> should already be on Outreachy's website and on:
>
> https://git.github.io/General-Application-Information/

Okay thank you very much.
>
> I would suggest fully reading that page again. You might find ideas
> about things you could add to your application.

Yes, I will do that now.

>
> > While going through the mailing list for previous final applications,
> > I came across this thread
> > https://lore.kernel.org/git/CAPSxiM-kf8U=3Dvzp5MoD3tUuOtnNjcCgPhLdriyeQ=
o5CGf=3DEhyQ@mail.gmail.com/
>
> Patrick's suggestions are great
>
> > where the main points regarding my questions were answered as follows.
> > 1. We should use the link to the microprojects for the patch reviews as=
 the
> > contribution link.
> > 2. We should specify the current status of the patch, 'master' or 'next=
'
>
> Yeah, it's nice if you can give the object ID of the merge commits for
> patches that are merged into 'master' too. For those that aren't
> merged into 'master', the branch name (like it appears in Junio's
> "What's cooking from git.git ..." emails) is interesting.

Okay thank you very much.

>
> > 3. Send the final application to the mailing list for review which shou=
ld
> > include an explanation of the project we want to tackle, links to the
> > microprojects and a rough estimate of the project timeline.
>
> It's important to send the application soon, so we have time to review
> it and iterate on it (like for patches that are sent to the mailing
> list).

Okay I will prepare and send it as soon as possible.

>
> > Is there any other information we should know of or this is good enough=
?
>
> I see that Usman just replied and gave good suggestions too. So I
> think you definitely have enough good material to help you prepare a
> good application.

Yes I surely have now and you for your time and response

Bello.
