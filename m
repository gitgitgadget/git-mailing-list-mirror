Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0FE58210
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707921271; cv=none; b=lgwcClHC282jSP1ylxe51zUcgHXoNTi48MDXQ7E9x0aqM8N9TgLnAcfONyGEbF+JFWQQ75odeTX/uNBzr7TEM+wA66WPvomy1wN0xXQQ3YCC9ynIzLn8DhftuSjVA+u6T4B9SS5MKpFbOV5VJ2bXnF/Gdi3oy5wEUK7gR9d9Cbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707921271; c=relaxed/simple;
	bh=Fs5JZSzV3V/xTwb/kWkhUf1BGtVq8qvdBA9FcEu3jds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ed+2LXNdMuXbRLbYGAUaQucQOLOoquL9BBtFHPL1QT3pUpBUP/UAGEwvvUD127NsbMNxpnVR91I1R60Z1uKBHa9kfvhqjFHmJMCDhMgqEqk3/0oHzTNefAN7lhbreY1xHoUwB5tVAPJtl8z/iRAeV6HYBcjjvwk/RFXvtCsVTjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6x99T1z; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6x99T1z"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3d484a58f6so93000666b.3
        for <git@vger.kernel.org>; Wed, 14 Feb 2024 06:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707921268; x=1708526068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5pXgat3jpi4wvT88q/JAP5qKsAdCWd9sLuITNb7Jes=;
        b=b6x99T1zX706Wfza2hy/NVbbnJH8avm1bXEKJIYka24hp7QY/ndklRtEQM8zQ0oG5H
         ljMmLUUi4YpU4SdmwINaGaOKH91Koto9UuiQBzNEo/v4jdECD+JdoQaf63wV2axQNf39
         deaGWIHjQvf0GP9tzwFREYv0WXsSwEblfZUHLvh6j0tr5WR00QQCJ7zUYjPGzrJhpa+K
         FgRC3q5LQkyMdjCKu5rLHPAF3TNxvp36Sfcbklk9ta3xqgsNmDUVhWFKvZy8Yef1YOK/
         3F0TsUlTiWfEkk4pvsIvI1IyJFyXqdJZBmuCoDy2B0Ei0WWBns6ziWsKTid0IPQYnU+X
         JnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707921268; x=1708526068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5pXgat3jpi4wvT88q/JAP5qKsAdCWd9sLuITNb7Jes=;
        b=k7u7GMj9YpFACJ06FqFsN8a6v01TpUL7tD0kk0gpurigroYHYjQtYd4jkiSL+JGHOh
         LJet9rBCLho1Oa5PD341su/xPf7QXBiM9jS76YSnyX4gRs4wkeoT67PDk40TbvcQULw/
         lJvn/t7u3m8QIw5hWHP0vt59+R2vceDDboRLYR85BN55EvoRoQQZBiQVb6YUOFVHgT8z
         HiTi1qQnA6JikmpCywkUuKGyIIIRa7E0/FdbJbeh0kFwGZ740LxaZVJFFTw0BDzDQxa6
         R3NNXP5PJoax6uyFhp9NijRwPLZcMhdY9IG/1LbGJIWqSa1kmspz8YRNPVYXRr9Z9Dyd
         J5pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEcjAed7jQHzxQdKK7UZT0wTA7iaaToThpbwcVc+jpflJs9VDZf9Y5SRtDVuO1DdDvsoUdT6GqdCu4jozdQ2m+ULXG
X-Gm-Message-State: AOJu0Yy3CB70xF45jqnNdNvMOGg87FIwF/2M8FfXX94KpGQVRxgLW/H8
	mbUOSDP7ePMz0tFf/OEsedoSWpfHsngWdmoYuaOhlr1/bMWobCqJWigonG1mz2/es98iAOd6RPu
	IGVD7ohLNzzSgjxEJI1onEzg+ltU=
X-Google-Smtp-Source: AGHT+IHQm2QDQ7SaMRlMPjT6c6d08K//NZV8fHcY8TIVbRcXFg0dO36gcBxdjjduJwNZ77344c7iG4QTNCNanGwS5TM=
X-Received: by 2002:a17:906:3490:b0:a38:9446:106 with SMTP id
 g16-20020a170906349000b00a3894460106mr1980432ejb.51.1707921266047; Wed, 14
 Feb 2024 06:34:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208135055.2705260-1-christian.couder@gmail.com>
 <20240208135055.2705260-5-christian.couder@gmail.com> <xmqqeddmonq0.fsf@gitster.g>
 <owlyfrxw9ei3.fsf@fine.c.googlers.com>
In-Reply-To: <owlyfrxw9ei3.fsf@fine.c.googlers.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 14 Feb 2024 15:34:14 +0100
Message-ID: <CAP8UFD25urs1ud16c4BhMLFxHQHuDde+KV71BN6M3vDQqJ-YwA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] rev-list: allow missing tips with --missing=[print|allow*]
To: Linus Arver <linusa@google.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	John Cai <johncai86@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 11:38=E2=80=AFPM Linus Arver <linusa@google.com> wr=
ote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Christian Couder <christian.couder@gmail.com> writes:
> >
> >> +     * mechanism to allow and disallow some sets of options for
> >> +     * different commands (like rev-list, replay, etc). Such
> >> +     * mechanism should do an early parsing of option and be able
> >> +     * to manage the `--exclude-promisor-objects` and `--missing=3D..=
.`
> >> +     * options below.
> >> +     */
> >>      for (i =3D 1; i < argc; i++) {
> >>              const char *arg =3D argv[i];
> >>              if (!strcmp(arg, "--exclude-promisor-objects")) {
> >> @@ -753,8 +762,12 @@ int cmd_rev_list(int argc, const char **argv, con=
st char *prefix)
> >>
> >>      if (arg_print_omitted)
> >>              oidset_init(&omitted_objects, DEFAULT_OIDSET_SIZE);
> >> -    if (arg_missing_action =3D=3D MA_PRINT)
> >> +    if (arg_missing_action =3D=3D MA_PRINT) {
> >>              oidset_init(&missing_objects, DEFAULT_OIDSET_SIZE);
> >> +            /* Already add missing tips */
> >> +            oidset_insert_from_set(&missing_objects, &revs.missing_co=
mmits);
> >> +            oidset_clear(&revs.missing_commits);
> >> +    }
> >
> > It is unclear what "already" here refers to, at least to me.

I wanted to hint that we already have some missing objects that we can
add to the set. But it's not an important detail and I agree it can be
confusing.

> It's grammatically correct but perhaps a bit "over eager" (gives the
> impression that we get these missing tips all the time and is a common
> "happy" path). I do still think my earlier v1 comments
>
>     Did you mean "Add already-missing commits"? Perhaps even more explici=
t
>     would be "Add missing tips"?

"Add missing tips" is used in the V3 I just sent. Thanks.

> are relevant here.
