Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E7217A31E
	for <git@vger.kernel.org>; Fri, 23 May 2025 03:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747970765; cv=none; b=M7NnrMejRJflnLYCFIgr6158VzeyhkpNvAdrnNOcFIKAdTzdbRg7CWXVhxJKCi/di2wxzHpOmlExmtNbtvRPZS3FlR0Ia3z+vcOb8t7XCZJr3fHEP/5szma+zxcwK6IYKxAV+HCb1B3iJUaA+S7tiojAzORgHmYR3EQAWKyrGgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747970765; c=relaxed/simple;
	bh=yGYZ9DHFpg18CPglIEMyfDL/mB0Sds9xMSOuzkwMSDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VH+AJNurcvLvm6NwpfY0iTA94tz166vS5CgZ33axoY6rBiXylIv+7dqA+qRM0qmPAKuURS9uPnyDcoCxoWaWbbfSe5ADLieABMjI9A1NlrY+Hs3r5S8kDyijgfuLLbSgiJSVKeBI6REc7O0BVmlUFJISV16oLI9EW/1xM5KaRDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Exk52W3u; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Exk52W3u"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6019b564d0bso12557473a12.2
        for <git@vger.kernel.org>; Thu, 22 May 2025 20:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747970762; x=1748575562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJ/DekXYEB/fIPcsL6+jMbU7rDBLW07SQpPJ1SivX4k=;
        b=Exk52W3ubrhAyIbcHPnYyU2BAkyT5sTftcEHFdFQz4fAmiXfRvnB6BHTnwNPC1CLTS
         1OnKVztgFjfJzvQ72OVFovvDueBMmaZIns85JaDbV1DcbT8Gj34BCKAWtlxZxcrYW4w9
         e5kgKhRnan0liElDb3gqUOVQnO89lN0ZdY3dqBmFXMQRsYhrVAvQUck981QGWn8OIWgH
         Cs+8uT6GgRCWaFppi3LDYsB7/7bL2CXFRXV+x/aj+P9OlXIBpC9gUJSGm5h3SaAvCMdW
         xXy5OIRoOJgQ1oJF+pK8d2CErQl164Fm5HViY9GB17McPIZfjDGDHxldkw4FPsyARlq6
         ijHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747970762; x=1748575562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJ/DekXYEB/fIPcsL6+jMbU7rDBLW07SQpPJ1SivX4k=;
        b=IMkvsSun0It0YfmF5Q2ToUJMj/Fgy/G81Siyc4JSIjqykFhuMAhyPJIZYKppPErVES
         YMe2Ry7aDqH51oRZKnPATyr9wl3xu/YwhlrN/rV02sJ/s6VhH6nBx90DdNkyaC2byv3l
         n0ZzY126aJU0WXl1MbAC+JEzx1rxP90ne5o+li9sBqCGj5sAkitlvC0Y9EUQQcmmIgVj
         7xoPkQGiwm7kmDPk7tFQmZzZmgVkFLlnUkC13jQMsV9Wy/5Um3dG7MipQDow/7emBnb/
         JoF/kH8nSiSSIdlp/Ef3+vHJXsATX5QENp79B4eaBiwg1NXk8sYIXh07pfUL5GeHo6/5
         G66Q==
X-Gm-Message-State: AOJu0Ywc6jIOVtSiUNqXDmc8bu/vta+YjdjK72+LFBXMCtUdmPp9tQ2O
	2grKt/AgHyBBAY45nzbOYJ2XD0TRKpPYq6d5wOQQuInQt1HkCaV5QEBU14XhlJx9BaLLAUQZ93T
	j5GbfMux0hRYcNoCU/tD+BS75gMSVx74=
X-Gm-Gg: ASbGncsdbuC+nor9693ThOT12+AKSTG6X1hl9wdhb6xlMC/f9Gw7SgJeclJfibjDfPx
	l7arfGzYvvvPwDoM3zN4v0fPYV/7lw+wZ3XniMUZwklUXEZwheuF0cSSoSvdtUg3qihcHjq5GIt
	UB/a46GsHhOcJ0REAJi2KDtK1HPT0yjB9NFpeX0KtG4NqHmKuaSgkc+pep3ul9gdnH
X-Google-Smtp-Source: AGHT+IHfajLoIb6tXGyYb1ZqOAXhFpkAZfWjHAvpaykANj76rAXZn++ikqc2SLpCPmr5KlX9lQWssr0cGdMaaVQWsLQ=
X-Received: by 2002:a17:906:f5a3:b0:ad5:57e0:c3b1 with SMTP id
 a640c23a62f3a-ad557e0cc21mr2014666266b.23.1747970761539; Thu, 22 May 2025
 20:26:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521191352.30849-1-ocarneiro1@gmail.com> <xmqqtt5d7e9z.fsf@gitster.g>
In-Reply-To: <xmqqtt5d7e9z.fsf@gitster.g>
From: "O. C." <ocarneiro1@gmail.com>
Date: Fri, 23 May 2025 00:25:50 -0300
X-Gm-Features: AX0GCFsuLRyXNaQfrTPX_h4vqikWF_PUKXiJIgYvseaKYX6ZGKkBdbc8vndxzUY
Message-ID: <CADHqMhY85ZUd=NVq9dfUrBZEzEhfqwc-iYh=gcQ9J1hg=EkAsg@mail.gmail.com>
Subject: Re: [Newcomer][PATCH] graph.c: change graph_line->width type to int
 to remove sign-compare warning
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 8:08=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> An obvious question after reading the above explanation is if it
> also would be a valid solution to change the type of git_graph.width
> to match the type of graph_line.width instead.  And if so, what was
> the reason why you chose to match their types in this direction?

While writing the patch, I saw how the git_graph and graph_line structs
related to each other, and understood git_graph as being the "more
important" struct in this context. So, it seemed more reasonable to
have graph_line.width comply with git_graph.width type.

I do see the opposite point, taking notice of graph_line.width interactions
with "size_t". With those in mind, having the type as "size_t" does
also make a lot of sense.

However, considering that:
> "git log --graph" output is certainly something that should not exceed
> thousands for sane people
It feels intuitive to " use platform natural "int" " as you put it.

> By the way, these lines are overly long.  We aim to limit our (physical) =
line
> length to around 70 chars or so by line wrapping.
Sorry about that, I'll keep them shorter.

Lastly, thanks for the quick and careful response to the patch. As a
first timer
I appreciate the discussion.

- Octavio
