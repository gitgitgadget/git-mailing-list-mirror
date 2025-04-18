Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF59C2E401
	for <git@vger.kernel.org>; Fri, 18 Apr 2025 03:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744948345; cv=none; b=ZrEgYVygpHSdu0IOPoeKpV9oBYnOJDWpIoGlFibFfRvqvMQfkdw7PT3RLYXhnfVheN765vo2ly464bKOWtE41Cbq+ROjmcz6woMKr1rxjE5aanwRdQdrOIVxoihnF+nsQoSfdnxy04Gbdo7kT4v4BDcgtPauvJa9OVJC1hved6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744948345; c=relaxed/simple;
	bh=Tb1VZmxNz+/NZn9R4PaZMVgREWbNnQ+n1uiMkzVv+ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=thLAtSfOUImB6T2z/9FFBkJ9ezkKDWkezqtwtx4+nN2ODMemPjjqsIJLnvMLCGVN06HYTLIG3F0JifPvpHht5vQxcEL2NUc3RxSl/raSGeFYRCz8JFiTi+o83lVlkmAA5YKwYu1H8RMovzb/p1YAqfhleXhlfhSMgTwt6ifO0nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJ6iAFoE; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJ6iAFoE"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso10470835e9.3
        for <git@vger.kernel.org>; Thu, 17 Apr 2025 20:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744948342; x=1745553142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AISzvE2Zgkny16MKAU23VRiPOvs0JYH9EgMN5V1tg2I=;
        b=fJ6iAFoEa01Xq73c8mL6ZxBtInZBquibu8cvuiY4ewf6FfzFNXeOE2bNNnegUYC656
         rIBsCRbp0esNhjIrv34k5N3acd7SSzAMZs6p3HeuyQ9e8mC+pycj3MLqmDSxE3z+kZFt
         y5fDlN3KeXhMGTukZ+6yIBdG2Qkkm49X4ka9AVXcd2ouQuil+QUi21pqgV6KrdXoNayu
         qd/twdSdYoRfPSvUzmYvYuaKi5mzLqBbRUBqme8LL6DKyNzeszSPI/Jn2ft6phM0pmiq
         bQnEsvBFAX6L8t1cufqzH/hNOZNYF3x6OV8KMocXRnDEPNRLqnK5wx3lexLeJe7f7ZfI
         w2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744948342; x=1745553142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AISzvE2Zgkny16MKAU23VRiPOvs0JYH9EgMN5V1tg2I=;
        b=KsPGzv4WWNNl97BpgTB1G0B/y6iFhAiRCLjBz2G1jACDeYPDSQv3U+kvaLvWT3iCZI
         lNSC0EVRs8MS4GGWcdW4pZ+FzY3YK833opGSE12RAVLCYkoDR96RsJqZCdlshHLXKRMA
         TRv5xJ/nvGBRVn1WaLyp1ZvsNl4dENpqnfrOa+OzO+Jahok0Pp/O3QOimyPDECbiMx7C
         ZhFu1LVJ19vyB93sI9almUr2Fc2aqIWSFDT89uNjArwjjw5vA3hEHfhiabvE9WZRNwfm
         49R+1jAAR8VTuc4d4uwG8BS+iWCLk4HIOdLV5BT8ScR8GfbjjCsxwshoMDjkBIi+p/J0
         gjew==
X-Gm-Message-State: AOJu0YwWr5df+RR6vCPHKiTmEScO5n8Gm+AQLK6xWfsphgWl8hip8qc/
	0KWYZf64hey3iDCg0u0F1f56cKLkhILmEug+hQVsbBbDPYMJ9UEMYudh7iaXKSxirqQT5QPoK20
	LVYE7dEvK3tp0CU6tyapQ8LkJT4c=
X-Gm-Gg: ASbGncs0XMoziwehsuIRitORfLa5BOgAR5JG21Zu0HhGqCDVuqvpT65dSkETwKZW8G4
	T6H36c+AnY8elZXRXmn0M3jlS78lPs0GKqugTCglYCVZjjVytWFLxiy+b+f6w24mOanbHHRx1IS
	l60ccL49RMI+8S7cYElDZ8sg==
X-Google-Smtp-Source: AGHT+IEZ9ZE8VWAEv7Y+j/LgWCH88/PRsTdI8eotRPIJvM6c45mHlLDiLBzlMUYnJUbEjBH0nc5cemOmFBV/2qGt548=
X-Received: by 2002:a05:600c:5107:b0:43d:fa58:700d with SMTP id
 5b1f17b1804b1-4406ac2179dmr6636065e9.32.1744948341715; Thu, 17 Apr 2025
 20:52:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAHpriMkqapiJuUGimn-i8SqcZmvmc=Wpk6oUr844uAkCYgMxA@mail.gmail.com>
 <xmqq5xj2clcx.fsf@gitster.g>
In-Reply-To: <xmqq5xj2clcx.fsf@gitster.g>
From: Keith Thompson <Keith.S.Thompson@gmail.com>
Date: Thu, 17 Apr 2025 20:52:10 -0700
X-Gm-Features: ATxdqUHEmGp-_3rIenhMVHz4e48JSDlE_D5AOWNAKumPZ5g-3epvf3BhwlRS8nk
Message-ID: <CAAHpriNYikDFwiTpjZEupG4yWOkbzW5DnBcsUnBKkfxxxtWNkw@mail.gmail.com>
Subject: Re: Bug report: Minor glitch in "git help" error message
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Keith Thompson <Keith.S.Thompson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 6:24=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Keith Thompson <Keith.S.Thompson@gmail.com> writes:
>
> > What did you do before the bug happened? (Steps to reproduce your issue=
)
> > git help nosuchcommand
> >
> > What did you expect to happen? (Expected behavior)
> > An error message: "No manual entry for git-nosuchcommand"
> >
> > What happened instead? (Actual behavior)
> > An error message: "No manual entry for gitnosuchcommand"
>
> I am of two minds.  When "git help" is asked for commands, your
> suggestion does make sense, i.e.
>
>     $ git help dog-file
>     No manual entry for gitdog-file
>
> And these two are moral equivalents.
>
>     $ git help cat-file
>     $ man git-cat-file
>
> But "git help" can ask for things other than subcommands.
> For example, these two are equivalents.
>
>     $ git help glossary
>     $ man gitglossary
>
> Notice the lack of "-" there?

Indeed. I've just learned several things that I either didn't know
or had forgotten:

* "git help foo" works for values of "foo" that aren't command names,
  like "glossary" or "cli".
* "git help subcommand" directly invokes "man git-subcommand".
* "git help topic" directly invokes "man gittopic".

Clearly, "git help" knows whether the user wanted a subcommand or a
topic if it's something that exists. If it isn't, "git help" has no
way of knowing what was intended.

Some proposed solutions, none of which I really like (except maybe
the first):

* Assume that the unrecognized word is a subcommand name. There will
  be errors (a message referring to "git-topic" that should have been
  "gittopic"), but I speculate that *most* (mistyped) arguments are
  command names.

* Produce an error message like:
  "No such manual entry for git-foo or gitfoo"
  Problem: The error message comes directly from the "man" command,
  which can't be persuaded to produce the above message.
  Probably more effort than it's worth, and a potential new source
  of bugs.

* Construct the man page names the same way for subcommands and topics,
  so "git help glossary" invokes "man git-glossary".  This is a change
  to long-standing practice, and I don't expect this idea to be taken
  seriously.

* Create aliases for all the topic names, so "git-glossary.7.gz"
  is a symlink to "gitglossary.7.gz".  Likely too confusing, and
  not worthwhile for the sake of a one-character glitch in an error
  message.  (Except that I might expect "man git-cli" to work, but
  I almost always use Git's help mechanism rather than "man".)


>
> > If "nosuchcommand" were a git command, the man page would be
> > readable by typing "man git-nosuchcommand".  The error message
> > should reflect that.  (The error message is actually produced
> > by the "man" command.)
>
> In other words, if "nosuchguide" were a concept with guide, the man
> page is readable by "man gitnosuchguide", and the error message does
> reflect it.
>
> Unlike "git foo --help", where it is clear that the user expected a
> subommand "foo", when the user says "git help foo", we cannot tell
> whether the user asked for documentation for a command or a concept
> guide, so adding "-" there is a bit like robbing Peter to pay Paul.
>
> Thanks for a report.
>
>
