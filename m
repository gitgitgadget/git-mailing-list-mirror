Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F6618C35A
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 22:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724192652; cv=none; b=NbSP3CwBhIvZEwnirQbte2vp/Jc5VW1nmSnMt5SEkdMZBswe0PaQ6KH5lrDbFrkwyHe/5IS2Hlcqb/kpJRc6v5Tp0p/M1BfKIV8RN1VLoCI3uNgfwp8rD8TjAQHCKb+AuIy+3TSMKCM6ERVjZ14XyN+eta1JAgjV2ZAqOlwanUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724192652; c=relaxed/simple;
	bh=2j9KrCUqDnaXnIFSfpELcCvAGja3FwU9FrB5e+/f/Is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vEKDgO3m3ZIPYhFZww6AFzy4lmbNgtdjdQuZ5JLpm1ItbFoBs7ZYcDrRHm4LA8ne1+LOmOvj3MvN4tt2aKJCLZ2qrLeME/C4ghILKGyeLMhZUYS8JD/oZe8mKC3taUdLp6TN4As7QR0q11IqN+OJ7oC4EYsz9GQcWODejfaZrKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhvVea/G; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhvVea/G"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7a94478a4eso30531066b.1
        for <git@vger.kernel.org>; Tue, 20 Aug 2024 15:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724192649; x=1724797449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2j9KrCUqDnaXnIFSfpELcCvAGja3FwU9FrB5e+/f/Is=;
        b=IhvVea/GQ9hRNOIDNyronQ6Wd1C7P8CxSGlClKmm3GxrTw9SpNJOfp7hsOFOHXRu6V
         lKHnbebpKLrToiX/RZUgDZbXH2OStRhkw7SZqAEugFLn54fL1hM8J6w1UsQGYlOZoL8W
         v5MQEMcEgB17pXn9qjLzKRMhkRQbqHPHsxUPWpu4phq2VCCA3aMSGkyXMMc1d6V9V/Fi
         so0uU5w9doYroKbSgVC3I1vpuvhhhQH7719qF0s6wo5QKiCD1RnltyTcn1+kih3JZxse
         lOiO9ICyYaHxWm8ThTUug5mx9tl38gkBctq3Xx9Ur/iwM3PIbOHK0Sfmv1FMiLlGje01
         0aRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724192649; x=1724797449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2j9KrCUqDnaXnIFSfpELcCvAGja3FwU9FrB5e+/f/Is=;
        b=Dbg72Z7LSQ+yIJXfSOd/QoQltly4yF/u3AhKQ4QPJ02wrtqe9HCnUO60Nq/8qzJnmy
         MAbIRrPg7HtgPd2AhTYTMmU52O/8Vk+a79GJRQ3rxZpYdPToFx6D69oJ5sNoPZ7ZPM/l
         507gwzO/5zQ+HsO8LDVhTAX+762hr3kyTEVvwdLH82/cyMXnVR6UGe4MnI+dazgPD+Qw
         cnWPW/qL3nEI0EPovoZFeFHcpE0TEkGupv0QaXQglGRxS9Z774ZLNVZB9scBsVl9RuVf
         /KIhiSQGKDWR+vCCvBgTSJmJ4F5m3Ce4eVg/v3PFlm0IC36zy24Gvr0aWZVhCykTrGlu
         e8cg==
X-Forwarded-Encrypted: i=1; AJvYcCWqc66E5+5HGfkPqz6B3S5kzav0sCj5v62px3ehHtrWefeWLEODJQbj75gZtrwqCFsrWCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrtB79hTwmtBsN12L6gaZegIA5sSO8dmTrnknBig/PbWITxVKu
	tEpte8/c3DOgmRj0Q9YooV90rnpw9O0JXbvBHDi4Z2DqkJAzkmLq+PyMl71oJKW9gwIm7Msj7ZW
	K2jmvKkS0BT4OqHBFOsDSC29TnrA=
X-Google-Smtp-Source: AGHT+IEbRSLmrxvyK0g1/EU6mOhdkRzPk2TlZyxM31k/f9Gc9VNNY8sehO17B2piIYw9LpKKceMH8xm2VmcyCn4xrtQ=
X-Received: by 2002:a17:907:9307:b0:a7c:d284:4f1d with SMTP id
 a640c23a62f3a-a867014eb40mr26846266b.28.1724192649030; Tue, 20 Aug 2024
 15:24:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <767ea219e3365303535c8b5f0d8eadb28b5e872e.1723778779.git.matheus.tavb@gmail.com>
 <be3c968b0d9085843cd9ce67e85aadfaaafa69c8.1723848510.git.matheus.tavb@gmail.com>
 <xmqq34n3jswh.fsf@gitster.g> <CAGdrTFhZ6KeDPDUoCsV3h5myPuoYf7RR8eFdbFFXGrUGCdEkEw@mail.gmail.com>
 <08dc334a-e1d9-4aa1-945e-c543de549163@gmail.com>
In-Reply-To: <08dc334a-e1d9-4aa1-945e-c543de549163@gmail.com>
From: Matheus Tavares Bernardino <matheus.tavb@gmail.com>
Date: Tue, 20 Aug 2024 19:23:57 -0300
Message-ID: <CAGdrTFgo5kyObDTyhwjbnDUf8zm=-qYFbykqKv6cDG1mgSfmpg@mail.gmail.com>
Subject: Re: [PATCH v2] rebase -x: don't print "Executing:" msgs with --quiet
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, johannes.schindelin@gmx.de, 
	newren@gmail.com, ps@pks.im, Lincoln Yuji <lincolnyuji@hotmail.com>, 
	Rodrigo Siqueira <siqueirajordao@riseup.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 10:57=E2=80=AFAM Phillip Wood <phillip.wood123@gmai=
l.com> wrote:
>
> Hi Matheus
>
> On 18/08/2024 14:03, Matheus Tavares Bernardino wrote:
> > On Sat, Aug 17, 2024 at 8:22=E2=80=AFAM Junio C Hamano <gitster@pobox.c=
om> wrote:
> > The idea is that, when running in --quiet mode, we don't want to print
> > anything, not even a line-cleaning char sequence.
> >
> > Nonetheless, since these are invisible chars (assuming we haven't
> > printed anything to be "cleaned" before them), printing them doesn't
> > actually make a difference to the user running rebase in the terminal,
> > as they won't see the chars anyways.
> >
> > The actual issue is when piping/redirecting the rebase output, which
> > will include these invisible chars... So perhaps, instead of modifying
> > the sequencer.c to use "if (!opts->quiet && !opts->verbose)
> > term_clean_line()", the correct approach would be to modify
> > "term_clean_line()" to return earlier "if (!isatty(1))". What do you
> > think?
>
> On the face of it that sounds like a good idea but I haven't thought too
> much about it. These messages are all going to stderr rather than
> stdout.

Oh, good point. So `isatty(2)`, actually.

> If we do go that way we'll need to adjust
> launch_specified_editor() in editor.c to either suppress the hint or
> terminate it with '\n' if stderr is not a terminal.

Hmm, isn't that what we do already? The hint printing is conditional
on `print_waiting_for_editor` which, in turn, is conditional on
`isatty(2)`.
