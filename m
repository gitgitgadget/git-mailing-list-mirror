Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA993202961
	for <git@vger.kernel.org>; Mon, 16 Jun 2025 09:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750067081; cv=none; b=aORQ/2j/cR00OdUoOmEaMl3yyU45RFqQcWqWEynWS5c8H3MWk7KzE/jOFCDtsxQ3s5q8nBEQXQTPCydXgQVZP4znrR1jrlxYSsORUB7QTNIRHcKVV0RQs2EoDF0YF0E7mLLFztTt3bMvFq6/8C4Hi6XDzrdeQlcAZ/f42w/gqzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750067081; c=relaxed/simple;
	bh=QjDf2VW5t4d1iW4pVzjIB2tbaJAIfOYEa63uEcPMV7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zbp30QqyYFCSv0TIqIgvJlyF+dE009rVWQXKZwHgMadyLI76Skrsw9AeR8DlFNjMhaM0IRFYnMEynb4T8+MCdu/VenveLSaGkDU7OUDyPoBgi9AF3KSCGtPxZgtA7YvqzfPZsF3sjSm6ksAQ1H+a/EN7ZFdxO7oVKFKPAnPEjtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJNRobwQ; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJNRobwQ"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7d21f21baf7so428760585a.0
        for <git@vger.kernel.org>; Mon, 16 Jun 2025 02:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750067075; x=1750671875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9H9/FxXKunF/iPyvm/lI95269S1aEr64/Z6FlEHXTk=;
        b=ZJNRobwQZkf4Aa+fRdsUmngOXzymOBA7W82rU5daB7k+DkujH2dZb0KpL0eIOk5CYH
         3tbjS91nvgp+uMadnYqFnMK+hujEuzpLCezj6Yq7VFp2FCxZwtBUp1NXrV5sX5RdIYtD
         dBpMbAxW+J/vBJgo90qO7EphguNQNY6TS/W6YX2xbijZC/mcSVbcARB/Bw2hq64fRpct
         wDxHWtaKGhFOKGL5/Efdf5HUl8GyFtkPm0FNsKT+Mis0/lHXLLyoc4bvezP47HJyYZts
         Tw9vk5qEO0wJo3TuuvGhRR0AUbwTNs3Fq+PgmP4p6h9eixXlhgm7HpnTl9+78NBft+Cv
         w3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750067075; x=1750671875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9H9/FxXKunF/iPyvm/lI95269S1aEr64/Z6FlEHXTk=;
        b=iooC7fB7rFt1vKBvHs7tJ8vc4yR8wbl0P/crejzH/GT1u3ncWwlQiACVARzoz9X0zT
         h0wcAJUOb5NvwvR6EKgX74F7qrev8aEX0RNMjzrdkq/yWinAdNII4Z7ftMpUf5QeEdKC
         v7r/AnNRyX2DBHVJD7Roocc/dt177MWUMHsFkOpY0iQWr+H0yTOH+fBcTJRrKtxZRERB
         5BZ0xwT/yss8Bqht3PQ6tyfQ/VQm3QWCmRsUFbn3g/h3uBjJBh/5UG2YXvA5SC+0kCg3
         4PKdNHKztZeZt57QelMvJGTH7xU/92y+daJqY2dZHi6EMu3a6qRuL+KatxNSVza9Hbib
         MLrg==
X-Gm-Message-State: AOJu0Yw/lfxTiZTovJiomlHEpwDQyVQTSonxVpjDmKdUp+OPbcwiLZdN
	QdDBf/uWbfV0hY+pF2gWU3zQWFpcjmYLUaTU2NoA1OvioLS883wsut6YVwtSlict/OhOf7NNLPX
	nFJLCSjDOOWgyOgpZ7y51998J2WgDiMg=
X-Gm-Gg: ASbGnctoQdgfREC7LZncQf34C1/TDawvZY8i4IsISV8RVyB1W+/563nD2d1vYCkra7m
	jcoF4JueUq7RyIP+mkj80fFskOhmhH+sOcpc1a7AhYM4PBrpOu+qn4o3s7xogRRJZXZin5B3V82
	5V8WUAUd+U3UDBWKBuGuglIvgKtHwSfCd7A9ol74Ybkp9YRGvr2GTwfuto+VIO18CLJvi3ATqyK
	LM=
X-Google-Smtp-Source: AGHT+IHauZ/xWF/9+/1WaaphKQULrV1C5C/k5NDHY3iDeBWcxYq9XgoZEkCfLP2nH/yy/gjVpt2yCdbsiOjlWkjgxqs=
X-Received: by 2002:a05:622a:1a8c:b0:4a6:f410:f85a with SMTP id
 d75a77b69052e-4a73c47e327mr120476401cf.10.1750067075441; Mon, 16 Jun 2025
 02:44:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+rGoLf8Lf0gbPEUjTU9Zc9KQrzui4pjyvfxhA-LT4YuafqeOQ@mail.gmail.com>
 <xmqq8qlu72hz.fsf@gitster.g> <CA+rGoLehMUWPMBrZ1hOk-GBQBCvSY0_ivFCn1w1C-V_bGTDgZg@mail.gmail.com>
 <xmqqldpt6dht.fsf@gitster.g> <CA+rGoLcsuhhSOVJoK2vEV3m7PgH+8hpfpdih2furnyim=0gP+A@mail.gmail.com>
 <xmqqy0ts4izb.fsf@gitster.g>
In-Reply-To: <xmqqy0ts4izb.fsf@gitster.g>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Mon, 16 Jun 2025 15:14:23 +0530
X-Gm-Features: AX0GCFs99E2MI-c7qvq6iIEymnGhq5WwqmD7ZuU6XimgW5F32p9V2ple32LhUxc
Message-ID: <CA+rGoLeG=-PK6QiMKL6YuUYAarnd0rM_iGD=vAUReKYZ9ex9AA@mail.gmail.com>
Subject: Re: Question: regarding understanding code base
To: Junio C Hamano <gitster@pobox.com>
Cc: GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 6:10=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com> writes:
>
> > On Sun, Jun 15, 2025 at 6:13=E2=80=AFAM Junio C Hamano <gitster@pobox.c=
om> wrote:
> >>
> >> JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com> writes:
> >>
> >> > What I meant was:
> >> > You previously suggested that one good way to understand Git is to
> >> > start from the initial commit of the Git repo and move forward
> >> > chronologically through the commits.
> >>
> >> Not at all.  I only suggested to study the initial one.  It is more
> >> like biology students learning the common principles that apply to
> >> all kinds of life by studying a lot simpler organism as a model,
> >> instead of studying a lot higher order ones like mammals.
> >>
> >> Moving forward is all your invention or hallucination ;-)
> >>
> > Fair enough I have read your biology metaphor
> > into a full evolutionary theory.
>
> I should probably have said "before" instead of "instead of" in the
> above.  You were looking for a way to see what higher order
> organisms there are to study, after learning from the simplest
> organism.
>
> "git log --reverse -p" is a simpler replacement for your shell
> script loop to do so.
>
> If I were doing this, after studying the initial one, I would
> probably see how much of what I learned from the initial version
> remains in 1.0.0, 1.3.0, 1.5.3, and 1.6.0.
>
> 1.5.3 was probably the last version one can read cover to cover in
> one sitting.  Anything after that version are just too big, I think,
> but there probably are those with more patience than I have ;-).

Agreed, it takes time to sincerely understand each function

Till now how I've done is
Whenever there was a bug report
I acted like the compiler, tracing the file and function with pen and
paper and found the quirk
While this would work for bug fixes, I'm not sure if this is a good
practice for big projects or a good practice in general.
