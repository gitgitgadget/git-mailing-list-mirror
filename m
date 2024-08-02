Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0981AE021
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 17:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722621394; cv=none; b=FUoHHgCjkWVVg41ls7WB7cdq40oHHD5NvOEXVkiwWNlDnqn2dbmXLl/tN7yynrYONy33kcI9eu/BGxlfPax3MwGEk6KDwhpcvCI2AxC/Yszp2U4qPO21MWpC/4wniuT1Iqixyr5xeb5npSRrNkj31S02rpR8d3kebnnGdSj/o/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722621394; c=relaxed/simple;
	bh=O6+n+ocqPhqd0pFalmPkC8sXYhzAu9MndXgIm1j4bug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oO2uyqg3y3rrbaetvBjNRzzAviwYNXdts+4SY5C6dC0OUH7eNMVYNSUYC7YfKZ7cAe3XSu0oo2yILDBmhBTa1XQzt2ZsqQIYKqDKtV4SRJBwg91KK5ZDmeBtyZZAgugdK50kO3onNu4apcLlYtk9enUDjzpIsceykrE/O86Yvyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Aq4suKj0; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Aq4suKj0"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a6135dso1023598a12.1
        for <git@vger.kernel.org>; Fri, 02 Aug 2024 10:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722621391; x=1723226191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSma+jjlz5IB7BwQ1qyWnZXbEyjbCGf8xPoggTPDlfI=;
        b=Aq4suKj0v84EaF/xWlC/hYlRMzgm5jxaIoa2/8MSl5ZTLHZwrfM9aeDeOWRuTmqtg3
         rzYVIUjAs0vWGLXXt+0hES6KIJrdT9jecGvElonN+nVfZzvqHFqlG4OycHmtvyGmkqpK
         FV6VoekKSguvipV2wyVqCDySFhEBj5X2hSi9E0lS84EIspY/q23Mav8sle3Q5HElwDcy
         X+SL0ibyo5uqWvfPt36v+VQDj06EnoKpc5w7WnkGMoxbkGGFRCQ9aYA0nZksavYK+A7Y
         zJm6JVaZMhfX+QO5/RAWBt0DYUU5f+1JWi1oducCMPALcsO0WkNGvQWger0Bhmj8aiSE
         zJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722621391; x=1723226191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KSma+jjlz5IB7BwQ1qyWnZXbEyjbCGf8xPoggTPDlfI=;
        b=JlADyyov7DdgS78bmP7mwRXDUM46JKcBBkveEmRYceSp4j96hMDpBWAWuljUIuURZl
         8zbycGS8u3V5bNK6yGYkeO/udmTl7PcyQ3gjeBYu124iRe+3PP0q1uo645trIFL2SduS
         Y5iNQ/mceCeU5yVbarMRIF6aUGbWrg666GiQdpmkYP2kqEhPuJvFgg0dnyMyvVZUtOTk
         mNyrQEZF+wVZGaeEV9k11zq/FT8vcXTuCh6pLGiUbdJBDdGZU0OPN8KcOd6x2o475JPB
         i91k76qn4f11KDGd2DsqLlhrVecKbhi4TMSE7Yb0Yi0ceXF4caDejl/n528le9DQ1zhk
         kaXg==
X-Forwarded-Encrypted: i=1; AJvYcCUVCckf3I3+dF3Wqoz4gr4bw7QAEHNw7MMs2Cpq3fWorSho+Dg155zt7CsU/0an6nBpplN6oKPBIrSLb7dCbyShnBnu
X-Gm-Message-State: AOJu0Ywv+je+xX9S5im2UfHkLrp2OHcLy+ehvXiPhgkzpLn8Trr5tWXa
	c2nz1XN2nKvx69TLMp+MQMIcraAUwLw7OEImEsIJRRKG/04WNaD7kkndOc5eOWNzEXWROBAg9YW
	bW7gVJpyr91Pnmi2Re6fbTCU4UbB//+rwowexBLPBLa+hH7I/s8xD
X-Google-Smtp-Source: AGHT+IGxpm12OQutRRTF495Jc3tl12diH6uO+EisJXYtoW/4EpvMqL2XiwVMCiVKX0ITPZ4+8XQAuMnJtPIitox5nh0=
X-Received: by 2002:a17:906:fe0e:b0:a7a:8d73:c2c6 with SMTP id
 a640c23a62f3a-a7dc4e5277emr314017066b.18.1722621390688; Fri, 02 Aug 2024
 10:56:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1756.git.git.1722571853.gitgitgadget@gmail.com>
 <0ed09e9abb85e73a80d044c1ddaed303517752ac.1722571853.git.gitgitgadget@gmail.com>
 <xmqqv80jeza5.fsf@gitster.g>
In-Reply-To: <xmqqv80jeza5.fsf@gitster.g>
From: Kyle Lippincott <spectral@google.com>
Date: Fri, 2 Aug 2024 10:56:17 -0700
Message-ID: <CAO_smVh-16cfWDOq_XwNHpov7coufu-m-buexz86+MBYnFb3YA@mail.gmail.com>
Subject: Re: [PATCH 2/3] strbuf: set errno to 0 after strbuf_getcwd
To: Junio C Hamano <gitster@pobox.com>
Cc: Kyle Lippincott via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 8:10=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Set `errno =3D 0;` prior to exiting from `strbuf_getcwd` successfully.
> > This matches the behavior in functions like `run_transaction_hook`
> > (refs.c:2176) and `read_ref_internal` (refs/files-backend.c:564).
>
> This deep in the call chain, there is nothing that assures us that
> the caller of this function does not care about the error before
> entering this function, so I feel a bit uneasy about the approach,
> and my initial reaction was "wouldn't it be safer to do the usual
>
>         int saved_errno =3D errno;
>
>         for (guessed_len =3D 128;; guessed_len *=3D 2) {
>                 ... do things ...
>                 if (...) {
>                         ... happy ...
>                         errno =3D saved_errno;
>                         return 0;
>                 }
>         }
>
> pattern.
>
> Who calls this function, and inspects errno when this function
> returns 0?

That's a difficult question to answer if you want to be wholistic for
the whole program :) For immediate callers:
- unix_sockaddr_init: doesn't inspect or adjust errno itself if
strbuf_getcwd returns 0. Continues on to call other functions that may
set errno.
- strbuf_realpath_1: same
- chdir_notify: same
- discover_git_directory_reason: same
- setup_git_directory_gently: same
- setup_enlistment_directory (in scalar.c): dies immediately if
strbuf_getcwd returns < 0, otherwise same
- xgetcwd: also doesn't inspect/adjust errno if strbuf_getcwd returns
0. Doesn't call any other functions afterward (besides strbuf
functions).
- main: stores the value if strbuf_getcwd returns 0, but doesn't inspect er=
rno.

>  I do not mind adding the "save and restore" fix to this
> function, but if there is a caller that looks at errno from a call
> that returns success, that caller may also have to be looked at and
> fixed if necessary.

There aren't any that I could find, this patch is mostly a
defense-in-depth solution to the strtoX functions that were fixed in
patch 1. This function _may_ set errno even on success. That errno
value ends up retained indefinitely as long as things continue
succeeding, and then we call a function like `strtod` which has a
suboptimal interface. If this patch doesn't land, the codebase is
still correct; the main reason to want to land this is that without
this patch, any user that has paths longer than 128 bytes becomes de
facto responsible for finding and reporting/fixing issues that arise
from this errno value being persisted, and I was hoping I wouldn't be
signing the people maintaining CI at $JOB up for that :) It's not an
obvious failure, either. For example, t0211's failure, prior to
setting errno to 0 just before calling strtoX is just: `fatal: expect
<exit_code>`. That's not easy to trace back to "strbuf_getcwd sets
ERANGE in errno in our environment, so this is a misuse of a strtoX or
parse_timestamp function".

>
> Thanks.
>
> > Signed-off-by: Kyle Lippincott <spectral@google.com>
> > ---
> >  strbuf.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/strbuf.c b/strbuf.c
> > index 3d2189a7f64..b94ef040ab0 100644
> > --- a/strbuf.c
> > +++ b/strbuf.c
> > @@ -601,6 +601,7 @@ int strbuf_getcwd(struct strbuf *sb)
> >               strbuf_grow(sb, guessed_len);
> >               if (getcwd(sb->buf, sb->alloc)) {
> >                       strbuf_setlen(sb, strlen(sb->buf));
> > +                     errno =3D 0;
> >                       return 0;
> >               }
