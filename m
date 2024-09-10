Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F381F188CB1
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725978549; cv=none; b=AKp1zy/+oL/IaZf3SbBX9SpCi3veiQHTF/peV/acvqNSJUdt9N6xphFYCY3OV6gbEN82kmF8v1U6GlW8eZ3RoPLZ4CsfDIZ0OZeA9AU25zjJsskEjQ0s/po6irXHEEWi284hTc84I1y5mJWly3uYktKkwhaKYoNhQv5ZEY7uTt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725978549; c=relaxed/simple;
	bh=THZ8NRLyHl4SgMYlrlt2zY77ByxlvjHZcZL5m1f+B1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBimYqzDfhr7VnhWTACaN8Wbe0x2sA/v+ybhcfINApz//ohnLFHCbQskLraNBBtcP9QFg6WoakgeMlYuuZtbj6ACY8kCdE618H9YCjTV7JnGrLiVXc7kyGURVQZ37r2N0EHb74wmcHTrJfSbh+Vb8Dmj6BTx5kYhEgYii6s8s3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLdTWNSk; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLdTWNSk"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f74e613a10so1914281fa.1
        for <git@vger.kernel.org>; Tue, 10 Sep 2024 07:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725978546; x=1726583346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THZ8NRLyHl4SgMYlrlt2zY77ByxlvjHZcZL5m1f+B1g=;
        b=QLdTWNSkFwMv/fmffARSmf2h0khchzKtk4RoxlFPgBopWLawdPQTWGgTlRTCk0d4MW
         PDKZl9MT6DGRHmjtix76Mc7rg7iG8Y80bKP4hULwAIo7I6Rt6/Ff7LBiDZK8Wtzk7ytm
         QPsly1A9iBjtZq/KgwzlWxg+A3+pOKyYltwljLVghwJmO36pzx6XLlsG/eP4XebcpAVt
         WvBPyHtNti8/LYZYZ8VMHh553y6BojVYnJFNVyEKXO0V16YQxputJv6qlhh/Beabu+3r
         5jPUjoLS5qi6Fb94jJG5rhqcEfXi3VMQmV1GVcJiHsfqGjqcII4enSDhHzvGyiPWvza8
         0uYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725978546; x=1726583346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THZ8NRLyHl4SgMYlrlt2zY77ByxlvjHZcZL5m1f+B1g=;
        b=e8qKsjA5LtFALb14YypMcl4h93ADtau41NiiiSfv+SRgz4NEcj4h3jZhbEkfe+TLwZ
         S8sCxPb5cEP7qLjirTITh9tPiNPKIgjSGfDliDZJU9y+qg9RXji7Wpmvhy1yyJ0IDUg9
         K2I5YkdAranxlNKHPB6wrVPq43gLTphzMBPlQ4JE1oW6lCK6VEO49H1DLvPcUUlRISia
         Iw8208LB0cMkxpIVG+pB+zuB3Ttn9TsQBKhsFGX8FtsqeRrFVEMDySsFQlPWtX/tkbtY
         qxoq6ZcTpW0DrvJQ0uAQx91HdjVcElhKiRFWXBo/Qwm3ZNXIDNIPphBG8dXQ/RzD68Mk
         RqAA==
X-Gm-Message-State: AOJu0Yw40jDHHIqrTBljDxW+C7JZRjGdxeGBP/wtKZOIG1mGR7h5/CAK
	DLtidynKRSqTKYkZ9nxdDEGt4Gme7waGSwsQe7BmB1Qedcoz8s84rgjd7nLVXgaetiyvq95sdwz
	OmTJZa6OC6OTtYwiUQzczghKNRfg=
X-Google-Smtp-Source: AGHT+IE35lC0d7OS2QmQeyUE44KQBPSt7UJmD4fgJGsxu3X0eEcLdzuLuG0nqUhJuHm3jXUQ/I/bOVcfpjVHwI68bxc=
X-Received: by 2002:a2e:e0a:0:b0:2f3:f1ee:2256 with SMTP id
 38308e7fff4ca-2f75aa110eemr79554271fa.44.1725978545067; Tue, 10 Sep 2024
 07:29:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP8UFD10B4ROEjvP7MPygALuUFgyBQqZVhAjgSUris3cdiowsQ@mail.gmail.com>
 <Zt6pbMP3Rpjy-pC_@pks.im> <Zt6rC7TtUvxWGXN-@pks.im>
In-Reply-To: <Zt6rC7TtUvxWGXN-@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 10 Sep 2024 16:28:53 +0200
Message-ID: <CAP8UFD2Oz0WiFbke=JUX63-NcV9nDOA=j_6_PJtySgyDoCssoA@mail.gmail.com>
Subject: Re: [ANNOUNCE] Outreachy mentor sign-up deadline is Wednesday
 September 11th at 4pm UTC
To: Patrick Steinhardt <ps@pks.im>
Cc: git <git@vger.kernel.org>, Git at SFC <git@sfconservancy.org>, 
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Tilda Udufo - Outreachy Organizer <organizers@outreachy.org>, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 10:00=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Sep 09, 2024 at 09:53:20AM +0200, Patrick Steinhardt wrote:
> > On Thu, Sep 05, 2024 at 11:50:20AM +0200, Christian Couder wrote:

> > > The mentor sign-up deadline is very soon too: Wednesday September 11t=
h
> > > at 4pm UTC
> > >
> > > So if you are interested in mentoring please sign-up. I think
> > > co-mentors might be able to sign-up later but I am not sure.

> > Thanks for organizing this! With the clar unit testing framework having
> > landed I think it would be a nice project for Outreachy to convert (a
> > subset of) our unit tests to that new framework.
> >
> > There is still a bunch of work that I'm in the process of upstreaming
> > [1][2][3][4] as well as a refactoring of the macros to make them
> > typesafe that I'm currently preparing. But none of these changes should
> > impact how the clar is used, so I would say that it is fine to queue up
> > such a project.

Great. I think it's worth adding this as a possible Outreachy project.
We can always decide later to not propose it after all.

> I forgot to say: I'd be happy to mentor or co-mentor such a project.

If you prefer to mentor or in case of doubt about mentoring or
co-mentoring, I would suggest signing up before tomorrow 4pm UTC if
you haven't already done so.

Thanks.
