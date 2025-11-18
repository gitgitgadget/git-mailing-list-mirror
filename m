Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDB330BB89
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 20:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763499361; cv=none; b=pYgtunsyjRF3YpGnVEUhIDUTkmYu8VQ+MAvFteOATjpjRWgGPD5qgNVYtxa0mWhK/4tAKboJrHSKARDwm8Sbe+MNQEeK84fqsBSc0JexXCLjQekuJeBb0nQsMIZHVadIcirC36H81+zSLjCB7BE3usudze6HmgK1eKPXknXCw/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763499361; c=relaxed/simple;
	bh=XndnKlVlgz6SGEuECZ0eE7w2vK9Y4+3eXapob4QvfGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eVIS1lvhu0spdYtGYr2m0w8+ae4EiZ85hbIlJIU6hqsvUwylZCbiIgyzEOg2z3DCug9W3U8nTd/GkMR3SVdjDiZI/bwI5h41pI9TYQRZhI4a6jXMh3kB8/PwHwO4Zdu+c5me2aHi2PPLZfPBYJwBkDqiKgeV6BQDQYMVMGXyCVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfrxNbcZ; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfrxNbcZ"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5959105629bso2905425e87.2
        for <git@vger.kernel.org>; Tue, 18 Nov 2025 12:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763499357; x=1764104157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iY3kxmbKwo2rv5uDoVFPN6Wxec09MJswPEb7O5zIqIw=;
        b=cfrxNbcZZRCOkCD6a1pnIWd4u5tGjIvvD9gD4Nfbbb1fTtfNXIZCH2reH8AARk9/DP
         cl/87hL4H8DyGILoNkTllWkviOFuhf/xMyJTN+0UME5A5dO4+SUFMd6awJayiIDOAO3Y
         j5zO1/p+y12tpkne4MdM7X42JarVwipvSyj5KtlP3NIjimb4C2UyJJeAlFEfyIi/j9BX
         eeBqBjw/MQ6IKPM+Qtfrnv9mjUt8ZvERTP+u8x2mw1eH80NpUdovdMM2B60GgDpSpB9F
         hBEN4CtZ0fM/NGF0/NgUF5ZmjaDMIVK1nbgy95WZfw/RozS3xejt17K9Qlw/kjqHJzD9
         +H5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763499357; x=1764104157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iY3kxmbKwo2rv5uDoVFPN6Wxec09MJswPEb7O5zIqIw=;
        b=eCYpbA9xMMAPXb1L6uokibWVXCytYWEQPXxpYlpIIfCczvoyhEAGG1FUn2gch9QcXT
         /AGBDaMkwnxcpPVbMHIcW1i0prN449MOfzri8uE5J0PT69fN8Y5MlLP+K9o004bRi/qp
         8mOw3SXPy04oy0CTCSxH58HDPwarkrHXF8J883JetppkJKrJEy3PbQCTmifrydUfhECI
         QSZpzMCDAx1GE1e79M1P8C4MlU4muQIHkB/gZnQNzp9AF50mEnrEOw1uLg6OYRU8W28C
         Jw7Q8la3z8icU4p6AtcjXm56YkrQE1QysBRWgVJliXhjasA3FE97XFLRCU5EBck9rAhO
         fe4w==
X-Forwarded-Encrypted: i=1; AJvYcCW1HypUA0nAbCxWpYOtpm2Oh4NB4pxBwxeIdIdC7QoOmPwHZhZ9yci3QqfT6eNV82/SY+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxvgWH7GgDTuX3nZYrizbsLbPkQw84NyjbF9BaEkdTo2KK8Kf1
	PJDuadPvZewpmHJRrlpTPb+JAhMAnZ99BelOnIBuuZ+F/7maVK3wbgaL2Ynw2yD9PGVUgKZHvOa
	7CQ7glV5HL34LpDCvNMAB7nneLvJ4q48=
X-Gm-Gg: ASbGnctm8xdREClNgXOeTZByirwb4Y3FEQuWlyy7lkhJScYjM69s1aAfObVpRjRiVJm
	8RXq7WYevVoQ2WJkMoSykl+YVjVvyCBbR9gSbQMxdoKxC6xCRws26R4PWtztDbFgYP2dehn1bAa
	OSu6tbunL8TXtn0PVYYlvKkP9rpUL0SEolFYG3N/PhsWbj0COvyQGdh7dsYhaOzS6kCg9ko88XC
	Kqyb6AiBg5JMErqYyqtsfXUC3OgjGYDGQbFFKcGsEZcCIkkU8jY/3vF0jGU3ZyWB8XeoEC1
X-Google-Smtp-Source: AGHT+IGZZxHOGf4298c2SXZ8ryxoP2DSU02RXZbIB5mUnF/4E/eiygbjqnEIu3+8CEQw2Lna30Vz+OZMjA1FPKsl1t8=
X-Received: by 2002:a05:6512:124b:b0:595:9d6b:1192 with SMTP id
 2adb3069b0e04-5959d6b131fmr449300e87.3.1763499356819; Tue, 18 Nov 2025
 12:55:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com>
 <pull.2070.v4.git.git.1763159816.gitgitgadget@gmail.com> <042fbb11d03606879503846e86fac65e6e74d02a.1763159816.git.gitgitgadget@gmail.com>
 <xmqqy0o7g0rk.fsf@gitster.g>
In-Reply-To: <xmqqy0o7g0rk.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Tue, 18 Nov 2025 13:55:45 -0700
X-Gm-Features: AWmQ_bnnKlEPLBPXqeD_nOEPhv-c-vx-RQ9gmeJH0YdWPQjIwQ6sT3yAH35OTyc
Message-ID: <CAH=ZcbDzERvz7ZZ+yFOgEhtoBw3Ym1_2YPL3mbj2p0k7AK0v8w@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] xdiff: make xrecord_t.ptr a uint8_t instead of char
To: Junio C Hamano <gitster@pobox.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood123@gmail.com>, Chris Torek <chris.torek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 1:26=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > In order to avoid a refactor avalanche, many uses of this field were
> > cast to char* or similar. One exception is in get_indent() where the
> > local variable `char c` was changed to `uint8_t c`.
>
> I actually think keeping "char c" as in the original is a lot more
> logical for that particular case, as the existing use of that local
> variable are _all_ about C's 'char', and not about a very short
> unsigned integer.  The variable is compared with C's character
> constants like ' ' (whitespace) and '\t' (horizontal tab), or is
> given to XDL_ISSPACE() macro, which is also about C's character.
>
> But because it is so minor a thing, I do not think that it deserves
> a reroll on its own.  Just in case if there are other things that
> need to change and the series needs a reroll, here is the only
> change required for this.
>
>
>  xdiff/xdiffi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git c/xdiff/xdiffi.c w/xdiff/xdiffi.c
> index 8eb664be3e..4376f943db 100644
> --- c/xdiff/xdiffi.c
> +++ w/xdiff/xdiffi.c
> @@ -406,7 +406,7 @@ static int get_indent(xrecord_t *rec)
>         int ret =3D 0;
>
>         for (size_t i =3D 0; i < rec->size; i++) {
> -               uint8_t c =3D rec->ptr[i];
> +               char c =3D (char) rec->ptr[i];
>
>                 if (!XDL_ISSPACE(c))
>                         return ret;

I have v5 ready to go, but there seems to be a problem with
gitgitgadget. Once that's resolved I'll post the new version.
