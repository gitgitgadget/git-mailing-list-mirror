Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0226FEEC0
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 19:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760126258; cv=none; b=fRoHs7sBDHUCa/l8ERb156ler2N8JFAgOgJSjp50xZqZeSudosVjQSHuQr0u92fyx/jp8PJnjbziWp4KqH5eTv5Xxbu1kX1p07CMMJ4/y4Bq1WulWhIy6PHVShGFJqoyJ7OXJUSkEt/XJ9dO1hEJeoufMwIuzDq94+G8eqFdevw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760126258; c=relaxed/simple;
	bh=0a7K372vqQdRbdklXJclxFlk49tEVn2izd6l9Q6cVZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6KDwM9suaXRxu2q3ZwUsK4XegWV6EVMiuYQ9kHFjtUf1MOeZvrHjtvexOa20H9ogKMo2w25QDXcsyGE9nHWeS9EwEU1PxdS9zcwjwpH2TDe0dryRLHxinp3TgGlMEr84lsTutvp4hwWdRGEBqudCkqADQ48iOyCfz6/FvWlU+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KCMYDhbA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KCMYDhbA"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2731ff54949so4415ad.1
        for <git@vger.kernel.org>; Fri, 10 Oct 2025 12:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760126256; x=1760731056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtqklxzyYx1hD/GcjBp9nMayZOdXB6S54PMAY3ibtNw=;
        b=KCMYDhbAVla2ThEVKIUE1poLm4676Lz5TMLYtB0UEyf3Ew6DySD7xAUe2wssB58VU9
         vStrxhrGVFNaG7BINsctvbWktaQ6uDNrMIUrxl2Imlk5JPjtjWbnSoI3GUVz79Z2h6rZ
         0BcZ8vqhjsS3uJIDl/RDvGwhmjKz2m3c1Lq8Ueqbd6zUtn8iBCZtw/si9wweCfWsAM3J
         cOAe8LRoklncJemoHQDOjStvPefXZLJqekFm060pKcB/ykzBz7xD67kXXvezUoVgVzMs
         EYy/laHimVhkPkkrXQfJkGM6RqwL/1Mg8QSC+L4JjM0Tr/DOFxaKsUKHlBs6keF5oxf+
         XMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760126256; x=1760731056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WtqklxzyYx1hD/GcjBp9nMayZOdXB6S54PMAY3ibtNw=;
        b=wFQfEnhd6TN0MreRt5JCYC8DPgLlma8KyS37SKX9da+GAzyd79xGEDKr5vGsC8kt4q
         CimBCrik4oTvedri0tUKBgP+S21u5fNBT+4EVkpnOff0Zx0PZb5izzp5sNTR+7etZ/jI
         G7FisSBdlMLYTqjCPUIMfIvMoRJgk9JbvZlWJOUr5Odeo0THo9X3fwqGzkRrroFDFl5Y
         00oxTSnsE2gTdsnMeO/YB0jw3Lg5K/wgwjEY6QGkGEdMo0167uVhLBkJI6JJtXdrqr8+
         RJyIf0Iw2ydzzu6JDUjPhVb2ikxWLIZK2Af+JX2XRB3K7hbh1JfvFMKeMH+lPynblzy8
         ZDEg==
X-Gm-Message-State: AOJu0YwKG4wAG9NiJbBWBoCAKWI1GL8GzAwYOWf5p33blK/EM+b+Hf/M
	fKTbhZcWeDzsBDcyPwxZaLF+xP1bRyyvBxJZT3cR/oeqJ3AACQqqnrDjf3qnHwCxMpPxcnMogqH
	JimKqJviNPhJJ+qeg2BuP3NCrfi/HL7dyy6NyxnRN
X-Gm-Gg: ASbGncu6KEpRBh3QbM6c9RBvS4+zX4cSodRg4sWU+pGEPaBeb1lHqB47x/Vs6woRgD+
	9MLRRcd/4uoCnwGD8Dpmxn8SP1C0cDyccSp78zllNoMc9oGRRWORRGUovQ+plfW5dzYtaQSv4fq
	XSQ4kGC47Jy/DOMKBMX3RfAE0IZWB5VM+sQIcEso6dC/MNhYS7+Rn8jzzDmh0KC4nVO8OwJJA2g
	Y+QGngdX6OJJfel/F6l13PwE53GyrbxkEZ0EguLMQNMpYz09gpN5IlpPyFQGzE=
X-Google-Smtp-Source: AGHT+IFS2mrICaoLlcjOZZ7RxwJ08we8GizvczQxzjUBKR9aMeWoZhiZg/kP6dtfZZOBy58tZ+Vq9hI5RjFhIjoy6R4=
X-Received: by 2002:a17:903:38cf:b0:248:7b22:dfb4 with SMTP id
 d9443c01a7336-290276dfef2mr15933055ad.16.1760126255771; Fri, 10 Oct 2025
 12:57:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
In-Reply-To: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
From: Emily Shaffer <nasamuffin@google.com>
Date: Fri, 10 Oct 2025 12:57:20 -0700
X-Gm-Features: AS18NWBDBTjgx2lYXVuz4pbMDeD-395YD0cDNWTHhhBJ-Tc2JUpqHcn7ynV4sTk
Message-ID: <CAJoAoZnHJP_UH8EkJ7==9g51fh6NFfv9dn4LJOThZFTzcSV+yg@mail.gmail.com>
Subject: Re: [PATCH 00/10] Convert remaining hooks to hook.h
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Rodrigo Damazio Bovendorp <rdamazio@google.com>, 
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 5:54=E2=80=AFAM Adrian Ratiu <adrian.ratiu@collabor=
a.com> wrote:
>
> Hello everyone,
>
> This is a continuation of Emily and Aevar's work to convert remaining hoo=
ks
> to the hook.h interface, by adding and using two new run-command/hook API=
s:
>  * feeding hook stdin via a callback
>  * capturing server-side collated outputs
>
> I've tried to keep the implementations as simple as possible and avoid an=
y
> unnecessary copying by feeding the data directly to the hook stdin fds an=
d
> even batching the writes of pre/post-receive so we achieve similar perf/d=
ata/
> syscall efficiency as we had before the callback conversion.
>
> As suggested by Aevar [1], I've removed the string_list API, the extra co=
pies
> and the $'\n' assumptions on the data, however I did not go the full zero=
-copy
> route with mmap-ing because I think that will break backwards compatbilit=
y. We
> could explore that in a future series as an efficientization of the curre=
nt IPC,
> this patch series basically aims for parity with the existing implementat=
ion.
>
> This series also unblocks config-based hooks and hooks parallelization wh=
ich will
> follow up in a separate series.
>
> The patch series is based on the master branch, I've pushed it to github =
[2] and
> it also passes CI runs. [3]. Also merged and tested against next with no =
conflicts.
>
> 1: https://lore.kernel.org/git/230209.86y1p7y4fa.gmgdl@evledraar.gmail.co=
m/
> 2: https://github.com/10ne1/git/tree/dev/aratiu/hooks-conversion-v1
> 3: https://github.com/10ne1/git/actions/runs/18006589297

Thanks Adrian. For the most part I have only small concerns - not
surprising as these patches are mostly (not entirely) logically
equivalent to patches I wrote a few years ago and which we have been
running for Googlers since that time.

Others covered some of the comments I had to send, but I have a few
comments of my own too. The only one I'm truly stumped on is the
`update` hook conversion, we can discuss on that patch.

Otherwise, I'll look forward to the v2.


 - Emily

>
> Big warm thank you,
> Adrian
>
> Adrian Ratiu (1):
>   reference-transaction: use hook.h to run hooks
>
> Emily Shaffer (9):
>   run-command: add stdin callback for parallelization
>   hook: provide stdin via callback
>   hook: convert 'post-rewrite' hook in sequencer.c to hook.h
>   transport: convert pre-push hook to hook.h
>   run-command: allow capturing of collated output
>   hooks: allow callers to capture output
>   receive-pack: convert 'update' hook to hook.h
>   post-update: use hook.h library
>   receive-pack: convert receive hooks to hook.h
>
>  builtin/fetch.c             |   2 +-
>  builtin/receive-pack.c      | 310 +++++++++++++++++++-----------------
>  builtin/submodule--helper.c |   2 +-
>  hook.c                      |  11 +-
>  hook.h                      |  30 ++++
>  refs.c                      |  61 ++++---
>  run-command.c               | 115 +++++++++++--
>  run-command.h               |  44 ++++-
>  sequencer.c                 |  62 +++++---
>  submodule.c                 |   2 +-
>  t/helper/test-run-command.c |  67 +++++++-
>  t/t0061-run-command.sh      |  37 +++++
>  transport.c                 |  79 ++++-----
>  13 files changed, 547 insertions(+), 275 deletions(-)
>
> --
> 2.49.1
>
