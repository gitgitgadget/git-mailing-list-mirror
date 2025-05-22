Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463AF19994F
	for <git@vger.kernel.org>; Thu, 22 May 2025 17:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747936477; cv=none; b=GsbdWMspN4SUXfppHMj+tFdTw4mVIwOe8jB3K3/U/KD8+wJBJiVdDeUU1KVWVohaFjQComaDQlalynYjrvA3sW3f6eR80rVacx6rNUcgxCjhzSOwwz4JQRLE8F89G8wViSiyADbYIlJFCGLDtXjyLeSH/6piDHf2XXRGBx/vmOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747936477; c=relaxed/simple;
	bh=BNOkK0cUkpVeXdEe/Q8QuO80mqJjeeYBewHmxSfhA9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7ejxeojAAq9vRhloBG71ilw32PLMZAiseSZktiq7/gFfypaJE3klbGTQG68CLbZhsUmHSzz5lzIjgpckRixiOXSPG3xa8sPV5veWHNQR1ZsjxGC4cizWn7oMBGXDU3r+ttJ4cC4B/3G5l+LikoWce5f2vRpzJ/tWBwmtYmjZ1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BNbaKcj2; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BNbaKcj2"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-231f37e114eso21085ad.1
        for <git@vger.kernel.org>; Thu, 22 May 2025 10:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747936475; x=1748541275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3UzBWLPGk+v0c/GG4qa0lwy2xfg+OMGZQJRmiHKFpY=;
        b=BNbaKcj25SOsZjYQKKcl83NWuILg01ReIPyoMd7nugP2YoThWehtKR0w+lqZv34C8d
         v8VBoM22d3EHnrIC8abk73L9BNHxdtjyGlw+1pXWJehfL/WaJMzfJIbzwmL84P9ulL0S
         x/jtT1qMfK8eDFpnWRjmq/rtlhUWec7I7VWnqWkHJr0d3yahWS3jQxNv4XHjQb28jhCw
         XyC+965logfp/LdSrqvbyDFm55gnXNI/nqx61EMCz5IrBla0HsR/4uUyclvRzprRExzH
         oy9YkplCNlfm28p9JVBtY1W8peFcXEEFn7TlZ6oP/HrxBfQD2GFYXoyqa9Kd/zpnmkLI
         rHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747936475; x=1748541275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3UzBWLPGk+v0c/GG4qa0lwy2xfg+OMGZQJRmiHKFpY=;
        b=fxYdaDpBxpCfsX93gHC6HMZ9QXFqe2hKQcLUEaDnOxsSkKBzPZvmn7uiafKh0r4eau
         CXEGXF8SWSOIMBZdQu5T/hFuUjq5TAwlaVG1L2u8DdiTC9VAjIFyDkEGEY8UZTBFH0F2
         c3iUM6oHB3SHwPNUqlliQmnwFd1ARSS4EO4vtzYFlU1qQEIcjK/KRJVRpgY4Obr0Ez9S
         DtzS2xkdVJ+CaALYzMTFoSasISxMRWvnTk8inOgO3PUGzrYqurD5QlBrB/67umdEPYsT
         T0XoW/J5vkIJYCWWYKKLjXZhyc086pRwrzAU+7f0b71xNETuk0zGP7kLk+b01c3kEhkV
         rqqA==
X-Forwarded-Encrypted: i=1; AJvYcCX4Q0+BWIS8yDufFnuPClQXLaR4Hu7u7m3kWf9UQFiA0DgCq6FxpyNvUa7L5Adr2Vogtg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUQQqEhLGuj894TXIxheEO0a0AR2iTLsYH17WZwsUbClUOf4LT
	MhRN8x2P4vosT7IB+8LdO1KpO1vQzMS+ZiFGiaDeoBNp8z3EeYTsfDqHoyt/zVxCXR+AUU1KSPY
	uq9Wa9nvgKgs5GJX3O0l8BedYbr8jI3atWbgio9atipQyCTs7CSxb9cdJ
X-Gm-Gg: ASbGncv+psxpFby5UCCFsgMzJjiRNKHscHM2d0sf2R/mdX0MHsluOwwoaLVBhJ49t9B
	tPszYOuHr0Rd5FGEn28VwdgbYk9PI9aVwOXXyYoT/T4EAFpcnFZICd4/V8hI5e226ye6ZthcesH
	wldF1EKb/SkiQ2I9JXXSNSOM/p2BSmCzmcRDiQ0WdfFxIgM5i3JQF9+jdZRaClMpBzL1MtY6Mn
X-Google-Smtp-Source: AGHT+IGIF7aZs/huN7nfNlUv7ayh28sQc55UH97kcocLuPg1k81mIV5w68eGZ/7xBreXNlvSR+6S69ZMrlPLDnOU6JE=
X-Received: by 2002:a17:902:ecca:b0:231:bed7:1746 with SMTP id
 d9443c01a7336-233f1e6a663mr3505ad.15.1747936474984; Thu, 22 May 2025 10:54:34
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PN3PR01MB9597D5EBF0A8D91737E4FE52B89EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqikltaghp.fsf@gitster.g> <PN3PR01MB9597F61508C56A33136B3844B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <PN3PR01MB9597F61508C56A33136B3844B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
From: Emily Shaffer <nasamuffin@google.com>
Date: Thu, 22 May 2025 10:54:22 -0700
X-Gm-Features: AX0GCFtLOdKr4egLELCk44ZybARpVudY_oHpu6blGLcO5w38McpzMq2SwnOjvEQ
Message-ID: <CAJoAoZm_fsfhq2gD4JVCihf5do-+CurFRBfw8PX8-0QbSKk-VA@mail.gmail.com>
Subject: Re: Add git imap-get-recipients command
To: Aditya Garg <gargaditya08@live.com>
Cc: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 8:21=E2=80=AFPM Aditya Garg <gargaditya08@live.com>=
 wrote:
>
>
>
> > On 22 May 2025, at 1:22=E2=80=AFAM, Junio C Hamano <gitster@pobox.com> =
wrote:
> >
> > =EF=BB=BFAditya Garg <gargaditya08@live.com> writes:
> >
> >> I was wondering if it would be acceptable for the maintainers to add a=
 git imap-get-recipients
> >> command.
> >>
> >> I currently am working on it, and it would be a perl script. It would =
do a very simple thing,
> >> take the message id as an input, and output the To: and Cc: recipients=
 of that message ID.
> >
> > If you are selling this tool, you should clarify what the sources
> > are for the information.  There has to be a database of some sort
> > that you can query with a message-ID and get addresses in that
> > message.  What are you using as that database (e.g., your personal
> > mailbox?  lore archive?  an imap mailbox at your provider?) and how
> > extensive and configurable is the data source?  What data are you
> > picking up from that database to come up with To/Cc addresses?
>
> My plan was to select the Mailbox specified by the user and use the IMAP
> commands to search by message id
> >
> >> This can be useful to be used alongwith git-send-email, when you send =
a v2 and you don't have to
> >> type all the sender mails again.
> >
> > FWIW, if you're only duplicating the To/Cc list of the previous
> > round, then I do not need it, and I do not want to see anybody,
> > including you, to be using it.  To come up with a list of To/Cc
> > addresses to use in v2, you should start from those who commented on
> > v1, in addition to To/Cc used in v1, and then whittle it down.
>
> Fair
> >
> > Again, the description of the "tool" in the first paragraph was so
> > sketchy that I cannot tell where you are gathering the To/Cc
> > addresses from or if the tool is using only the named message, or
> > considers messages sent as response to that named message, so it is
> > impossible to give a meaningful response.  We cannot tell if the
> > tool will be useful with given information.
> >
> > A more generic version of the response follows to outline the
> > general principle for those who are watching from sidelines.
> >
> > ----------------------------------------------------------------
> > [make us come to you, begging]
>
> No intentions to make come to me begging :(. But I do get the point.
> It's best to keep it to myself.

I actually don't think this is the point Junio was trying to make -
rather that you should not need to feel like you have to ask for our
permission to write this tool which can also stand alone and improve
your own workflow. Rather, if you do write it and you find it useful,
it'd be cool to see it sent to the mailing list alongside a cover
letter like "would anybody else find value in this? It improved my
workflow because <measurements/reasons>".

Definitely I don't believe Junio's point was "don't send us this
patch, I don't care" - but rather "how do we know we care until we see
how you've implemented it". (One reinforcement here is his question
about where the Cc list is being queried from; local mbox vs. b4 vs.
using a direct clone from lore.kernel.org would definitely change who
this workflow will work well for.)

 - Emily

> >
> > I've seen from time to time people ask "I am thinking of doing this;
> > will a patch be accepted?  If so, I'll work on it." before showing
> > any work, and my response always has been:
> >
> > (1) We don't know how useful and interesting your contribution would
> >     be for our audience, until we see it; and
> >
> > (2) If you truly believe in your work (find it useful, find writing
> >     it fun, etc.), that would be incentive enough for you to work
> >     on it, whether or not the result will land in my tree.  You
> >     should instead aim for something so brilliant that we would
> >     come to you begging for your permission to include it in our
> >     project.
> >
