Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893DC22A4D3
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622357; cv=none; b=mrPohyOPXbQfQkHR2jt1GFlg8N2aGXlZeIxbo/V0qf3K6CLQZqWBYqv7B6lwTyLwLH2MBuJHbRPAKzYVItIEQvsR1RvU297wPK2Ve+/HtCESixUXv984/zPOZ1I9munF3nSS56bz+ya7E7/1u/KNXtXUA3558Sd+wQXgeSKd2Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622357; c=relaxed/simple;
	bh=pc32IRMZyoXWs3xvZYms0PJUaxtoTavP4aAFONs3uio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJkSWOlKnZPAgduHMUFzaD+yh8Vsd36TBrBWRMvmslg1PkkPhTS5nc4wb9y0UkdJVWLc6yGGbYjL2cye4Nw1hxGojFuYvbJ+ipOBHITStb9puvK+J0GW2E6gyxWJ/D8F5sYGamztHTXRl9zAwbdkEQM6fH9IsOR7yHNpNJZKvg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmE3r2M9; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmE3r2M9"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e5deb6482cso6959380a12.1
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 08:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741622354; x=1742227154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/f6UsvKfeKkWKuCGEWH8XIYYfV3Pgh3Ak3Eu9yBcAM=;
        b=cmE3r2M9K4+v7Xqilizm98ULIxkAKqVRbvEGPbiFB1STsRd6DELlBYU4eRJayMGa+e
         2L13bwRd7xF+sJ3eSu3NK9yGHckxFO+c1Z91YMV+xR12pkUZXLkFDhWNP35qTUeOQjmo
         EFU+Lmtxp6TmAc41tnZHv/NwEiIoQY6eqqII6qZMquH5IOdQMmQkP7npalWzmbwXUf1a
         f1BQR7+XhPpAIEY4P2a6Q3Nc9lespnUVVknsLYGHK0SJXZyTxCrwmSMchpYYuJtlLhDN
         Rx5ccS38Abur6Amkgz6UAtkI8ylJQvYTyDeWZAm7x3T8lkIFn6tXJFNUDoH/NOcD4PZ6
         LSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741622354; x=1742227154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J/f6UsvKfeKkWKuCGEWH8XIYYfV3Pgh3Ak3Eu9yBcAM=;
        b=azd8nFclGcU3uszpM4Cm9/2E2L+vcRfGZMP+97nPslMfz+yv7+C105o/NvWwenegEK
         WwPM53CzKN5JuvO+Q1FsKIsa+V15uqslDnKTxWtL/RYcYAMn22qhPneTbDjLbem1HrnM
         03BI5fWj0Xx6GgdEOoMUNS3nAOXDJRM+ieXuFUX0zSVr5w85B3Q3C7Zy4GLORxiYlKum
         sr+plOoPcniRlkbBeMevq8iQ4MAsqW7fAPY8w9UxWp2qNjqZ6XtwesDmbNlQ2m4vaif4
         QIb6u9/UC7W26kEIUUxr2QJmYUaXeHQ08nQhia5++WIAqhpPXljVCg6zCet5UWWL6pUP
         NwZw==
X-Gm-Message-State: AOJu0YwnnzHedISXzVtvU/zN0CdS/iME03bKONMmDFeNlCcp8SlRorFf
	FzqZuAnwJojIt+g9Tp2AxKeeccJvKeLmmTpC7bab/vM+fhDxv8r4C18isUwh2Hy/7Ii1NdDe2iA
	GyIKKrDIkj4AuNF7am+RoxrnJhec=
X-Gm-Gg: ASbGncsy44qFjfi+2E7qFk1w9vXh8ZSAvmTRIfTepUzJ5bdEoWdqCsUV4bdL2BPR4Yb
	4hiTKollXH57hpl8pN5hptIlLdNV2gMFVe3VaYtloiUKXocd4TMG5oZ15x/DR6iORgPdV97FqIw
	gvdH6CKuJVARROb8wkmnExAzZl+I0/
X-Google-Smtp-Source: AGHT+IEE3e5BgPIkpH3PMf1PKzRsDopcFRARItN/8WC6E8tL58phfxY+61M7GVgD7p2LWNjSgWJVRf3NE/huJFJeZ/4=
X-Received: by 2002:a05:6402:278c:b0:5e5:334e:86d9 with SMTP id
 4fb4d7f45d1cf-5e61505027fmr12828012a12.13.1741622353527; Mon, 10 Mar 2025
 08:59:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20210430232537.1131641-1-lukeshu@lukeshu.com> <20250224142744.279643-1-christian.couder@gmail.com>
 <98b4c9e7-4034-4692-bc86-f6b905dcc5aa@gmail.com>
In-Reply-To: <98b4c9e7-4034-4692-bc86-f6b905dcc5aa@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 10 Mar 2025 16:59:01 +0100
X-Gm-Features: AQ5f1JpCA37O1zZxM6mIWEiZUw1YyYYJrSPAYvn0WA_kxqDt0VzKQxvMAKzKlGU
Message-ID: <CAP8UFD1TyDQahYOm9D8ohU-F95XneOgk7fg5mSH_k+s3ZG7omg@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] fast-export, fast-import: add support for signed-commits
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Luke Shumaker <lukeshu@lukeshu.com>, Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Taylor Blau <me@ttaylorr.com>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Tue, Feb 25, 2025 at 3:53=E2=80=AFPM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Christian
>
> I've only glanced over this series,

Thanks for taking a look at it!

> but I did notice a memory leak
>
> On 24/02/2025 14:27, Christian Couder wrote:
> >
> >       + * The returned string has had the ' ' line continuation markers
> >      -+ * removed, and points to staticly allocated memory (not to memo=
ry
> >      ++ * removed, and points to statically allocated memory (not to me=
mory
>
> This corrects the spelling but the changes below remove the static
> buffer so the user is now responsible for freeing the returned string.
> That means this comment is wrong

Yeah, this part of the comment is wrong. I have changed it in the next
version to the following:

 * The returned string has had the ' ' line continuation markers
 * removed, and points to allocated memory that must be free()d (not
 * to memory within 'msg').

> and I don't see any corresponding
> changes to the callers to free the memory.

It is called by the following lines:

> >      -+       if ((signature =3D find_commit_multiline_header(commit_bu=
ffer_cursor + 1, "gpgsig", &commit_buffer_cursor)))
> >      -+               signature_alg =3D "sha1";
> >      -+       else if ((signature =3D find_commit_multiline_header(comm=
it_buffer_cursor + 1, "gpgsig-sha256", &commit_buffer_cursor)))
> >      -+               signature_alg =3D "sha256";
> >      ++       if (*commit_buffer_cursor =3D=3D '\n') {
> >      ++               if ((signature =3D find_commit_multiline_header(c=
ommit_buffer_cursor + 1, "gpgsig", &commit_buffer_cursor)))
> >      ++                       signature_alg =3D "sha1";
> >      ++               else if ((signature =3D find_commit_multiline_hea=
der(commit_buffer_cursor + 1, "gpgsig-sha256", &commit_buffer_cursor)))
> >      ++                       signature_alg =3D "sha256";
> >      ++       }

so the 'signature' variable points to the allocated memory, and then
it's used like this:

> >      @@ builtin/fast-export.c: static void handle_commit(struct commit =
*commit, struct r
> >               printf("%.*s\n%.*s\n",
> >                      (int)(author_end - author), author,
> >                      (int)(committer_end - committer), committer);
> >      -+       if (signature)
> >      -+               switch(signed_commit_mode) {
> >      ++       if (signature) {
> >      ++               switch (signed_commit_mode) {
> >       +               case SIGN_ABORT:
> >       +                       die("encountered signed commit %s; use "
> >       +                           "--signed-commits=3D<mode> to handle =
it",
> >      @@ builtin/fast-export.c: static void handle_commit(struct commit =
*commit, struct r
> >       +               case SIGN_STRIP:
> >       +                       break;
> >       +               }
> >      ++               free((char *)signature);

And eventually the memory is freed by the added call to free() above.

> >      ++       }

But yeah, the description of the changes since the previous version in
the cover letter might have done a better job of explaining this.
