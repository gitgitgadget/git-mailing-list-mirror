Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF03714F112
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 19:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760643505; cv=none; b=u9xyV1IL4j8ncich0iRoPIDJoOCBWTHKs8ndiD9H2DBXMg+M5yIa61GJs6j5DQePXHLKU7HISft0gla3/LnvU4ka3A/+NIkq0ovlAk0qW2b54fg43+pRJcJJjHR6ox1sIIcQ3k/07rZFQfxDc63wUsa/nZ8doluzMbyMe7a5GdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760643505; c=relaxed/simple;
	bh=is6ijBTxkn7wh6J3bQQXtNx6GjZuhwAfyn/852nThco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ndEKhvm3LvDY0ac9vmtD9Ird2+i8i41LZDBSsdaD8oVZ4Koy2Qw7wFt9XFTK6cpNNj3T8awlt9uAemqjiCzdELGZmtzDNTuLflOo5DFvuXE+iFNnOHiPnBSMdhrI+nIaPj4MhTbl412cV1oYqOxyiVwZriHBLP81FkKgdKA8PF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/iSsW6R; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/iSsW6R"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-7960d69f14bso10060066d6.2
        for <git@vger.kernel.org>; Thu, 16 Oct 2025 12:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760643502; x=1761248302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3bme5e0o6PtCWjBnxWcOPCayDoRf7toQL6xQ2j/2iY=;
        b=Z/iSsW6RGnxSjlNGwhsTUuivEpHy2iu6rSgK1UtOFmcEZAE9vt5seFn3mnHmF1cqwn
         2EoOElUyjgZShbvv87oaALVrdgDxmuUX25PCalT/zNWx5H3tPosWkNCtPNgs4mvk/s3H
         OtHoA1WbGiuz4Csdlbmf3KGh9FvxkSyT+gOmHDgV1srnGbzAcGkIzjR/HZANs5trEaGw
         TKIwVSmNBceDs6gVG6ZIvmQkssdD1qEZsIjokCI0se+28bFbb4M4umo+W1cMWKlstv3V
         NMw3KHRH9cv5y+OeQwG5zLFJtFmjVR8SI2eZ+vsb/nkQSgsM7TdfxYu2ASP+kWXahVk1
         4MDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760643502; x=1761248302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3bme5e0o6PtCWjBnxWcOPCayDoRf7toQL6xQ2j/2iY=;
        b=NDqxxxQcN2nS79mzpsHbicLHPPH/+4unTa1mnsjG+096+TtA2+umv74+xXbUfFg4fz
         EypJfWPdLEqdvMhFits0Agzgzh1Ltt39XKKaxQx34lgDmQYU5ImOkrPfbqvQE/R/vgGK
         jEj/cfYjMD3AHpYXReC1seaHwXp3C+OGovztkiJo3EgMZRxlGpGIJaLN/kH5zsJ24iWd
         UxgCBE5MGfhYg1SH/5K865rqHbkIuvSQ/VPBrKFjhoB0k0yjydN4zVc1yxNZwNcNDW+A
         WbBJZXsuO7HxaLqnEfxFunwiE6mAmLmLRMOkdQNLJUJseCHHUO+/7dhwOUhjuhydbXVJ
         OE7w==
X-Gm-Message-State: AOJu0YwTP5kOzfzP5Q2ktEtoHnHtP/yjB8yPBWid+Um2YM8GGuH85HjR
	47Ew0nP/8xUxnwFkbcZSbJk9mf81tfwihMscD3ITiwhn/qlZryeDqB6E+un2fSFA6EqSqtNcr0w
	RzCpUqvgeTuX+/m5vvReAUw4O/SEWWrA=
X-Gm-Gg: ASbGncvgyqoOJPjK4dUv9ayk3FaVhp3q5+Db3qftY4JNuRl/3+L4txLjdDga9/NVhns
	0Gh5QBmcdRg0yFTS/M0OFsld7s9G5i0Odf9C6rNMv12b9h8Sob5tgfdsmtzyBj7FG/NMpTp/ACP
	VaQw1rOUVWmx2A81Oeoh4J1wLzWeYPfGka8khZYWLRarWD/te2/xIJnev4QyjNCypqcENQpepjG
	E20JhTUZUeCc1PFDH8nW5nCJSmYTcq1CnBBcF6SzyNq7B3V0D6swh6QbxLu7aFjQnA8ZUwJo5Vn
	l1z1cP9jmgRzNBpGeMI0gQ==
X-Google-Smtp-Source: AGHT+IHh1FYiq7iuqBymzA9CmlPq9UZa82YpBkGEg8b3/ZVEAn2a5cnhHbCtC6EA8j7K0OzPjt6213dBpZtuX7n+Gvg=
X-Received: by 2002:a05:6214:33c4:b0:87c:224c:64e8 with SMTP id
 6a1803df08f44-87c224c712cmr11235016d6.45.1760643502484; Thu, 16 Oct 2025
 12:38:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016184420.78268-1-okhuomonajayi54@gmail.com> <xmqq4iry4r3e.fsf@gitster.g>
In-Reply-To: <xmqq4iry4r3e.fsf@gitster.g>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Thu, 16 Oct 2025 20:38:11 +0100
X-Gm-Features: AS18NWBIfkwVPZ7gcwf0Ka2Iz8pbLHjw_Z1SczE72uLmFjD3QrxE0hM56nHmHg0
Message-ID: <CAFpMFfBe7+pMUL8aaDkGkPUaE9RhCW25OJhJy69EcukgSFn9+A@mail.gmail.com>
Subject: Re: [PATCH] gpg-interface: trim only CR characters that precede LF
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio,
Haha, I smiled at your =E2=80=9Cteh=E2=80=9D comment =E2=80=94 I myself oft=
en make teh same typo
Thanks a lot for catching the typo and for the detailed feedback on
style and indentation.
I=E2=80=99ll fix the tab/space mix, shorten the long line, and use your
suggested comment wording in the next revision

On Thu, Oct 16, 2025 at 7:52=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:
>
> >  /*
> > - * Strip CR from the line endings, in case we are on Windows.
> > - * NEEDSWORK: make it trim only CRs before LFs and rename
> > + * Trim CR characters only when they appear before LF (\r\n) line endi=
ngs.
> > + * This avoids removing legitimate lone CRs from teh content.
>
> "teh" -> "the".  I know, I myself often make teh same typo.
>
> >   */
> > -static void remove_cr_after(struct strbuf *buffer, size_t offset)
> > +static void trim_cr_before_lf(struct strbuf *buffer, size_t offset)
>
> In other words, this normalizes crlf to lf line ending.
>
> >  {
> >       size_t i, j;
> >
> >       for (i =3D j =3D offset; i < buffer->len; i++) {
> > -             if (buffer->buf[i] !=3D '\r') {
> > +          /* skip CR only if it comes right before LF */
> > +             if (buffer->buf[i] =3D=3D '\r' && i + 1 < buffer->len && =
buffer->buf[i+1] =3D=3D '\n')
>
> Are two different mixture of tabs and spaces used in the above two
> lines?  I think they wanted to begin at the same column.
>
> Also, the second line is overly long that it does not even fit on my
> 92-column wide terminal (yes, 80 is the limit, but this will let a
> line in the patches quoted a few times to still fit, as long as the
> patch honors the 80-column limit).
>
> > +                 continue;
>
> >                       if (i !=3D j)
> >                               buffer->buf[j] =3D buffer->buf[i];
> >                       j++;
> > -             }
> > +
>
> Do we need a blank line here?  I dunno.
>
> >       }
> >       strbuf_setlen(buffer, j);
> >  }
> > @@ -1023,8 +1026,10 @@ static int sign_buffer_gpg(struct strbuf *buffer=
, struct strbuf *signature,
> >       }
> >       strbuf_release(&gpg_status);
> >
> > -     /* Strip CR from the line endings, in case we are on Windows. */
> > -     remove_cr_after(signature, bottom);
> > +     /* Trim carriage returns (CR) only when they appear before line f=
eeds (LF),.
> > +     *  mainly for handling Windows-style line endings
> > +     */
>
>         /* Convert CRLF to LF, in case we are on Windows */
>
> > +     trim_cr_before_lf(signature, bottom);
> >
> >       return 0;
> >  }
> > @@ -1110,8 +1115,10 @@ static int sign_buffer_ssh(struct strbuf *buffer=
, struct strbuf *signature,
> >                       ssh_signature_filename.buf);
> >               goto out;
> >       }
> > -     /* Strip CR from the line endings, in case we are on Windows. */
> > -     remove_cr_after(signature, bottom);
> > +     /* Trim carriage returns (CR) only when they appear before line f=
eeds (LF),
> > +     *  mainly for handling Windows-style line endings.
> > +     */
> > +     trim_cr_before_lf(signature, bottom);
>
> Ditto.
>
> >
> >  out:
> >       if (key_file)
