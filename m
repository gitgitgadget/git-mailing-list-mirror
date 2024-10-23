Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DD11CDA0F
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729702301; cv=none; b=jkANyUBAx5B+wMVnASKGibxLbOVgdUyNze77H03JSrCCqrOpA+JyBKsf97gWYuIh932Fvw3yuzI5cGGPKTmtRZFfWdOL+2N4vGrchqvCGe90XiXn9Phx7uVulzBVKngjiW6CM4/9tfPw5m8E60rQUTawBoE/X45zrlebx5MftcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729702301; c=relaxed/simple;
	bh=iVbZEEIvG3y+TV4H93lz7MDaMtwfeBqOl8RqdQ+VE2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PhdKzuEvIOdz11RLlwGsCCjpuBifZnaqu8mYM13kwZsFqhNwtnfW0eN0ZXTWkkVi12XJo5dxoBhdxlA9++HzrgcG3EeocU0L6NkfqDDRuGu7dGS2KEtR+7FE7XlkIXbAnCeH3MWO+p/REGzK0uvFu6V0mY5t/+9WorBFYTTjpbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWe99MKr; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWe99MKr"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-431688d5127so47416215e9.0
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 09:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729702298; x=1730307098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwwqmquTXd0SGa5D7gA6xSj3/MWBiAU2jyPgUo/z2q0=;
        b=lWe99MKrXyCzY/JXKVBLjNtuqKdE0sVYFCnTq/yWXn9SARiOAPwx85KONr5KU6/mwV
         BLOAzHXsmwpsfNxAwlMqTqbI6THQhxl+xDwuC0aIRLqfj8fuYpczmsTe6uuCPdKSFneq
         Y8dGcXtdNJaW8IrpspOqF9pN2xj9f4UzfCH01iAnmNIefT5ClS0l9qdP1jaJIU774/8E
         i/6CI1z1ITKsHRQImUv35Udr2hP4XIdHwtjUNopxPUufMd5rJULuPq9bH58sgdrq7POp
         52duaGB9F4AEQRPFeerE4mxl70Q5rTp1P0qMms60TpnfQmDAYund4OtdTqjZgQDWzsvA
         yxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729702298; x=1730307098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nwwqmquTXd0SGa5D7gA6xSj3/MWBiAU2jyPgUo/z2q0=;
        b=Flq6xNtwnUIXlDfqtht39YRJexGDzHP+rbdsjYRvfUIckFwTpw1pIJgb+iFi7hUEuc
         8kceYL2hkJVB+jFqLQODGaGUXyETH041BNsI/u0RyB+uyxZMJ6KZow7TZomWM0L2B/+7
         raYeUN673E97a9tF7y+n8lWEQtl+bbMZaCrCQ1CQXWM+Tc+6b+5dUlYqfl9qE/4Jg1fO
         Y+3o3K/+G72hwUlSLgafT4ZLHYWjFFPpdSmcrIAaZupuzUjYGHKrzv04zWj2O1M+KbWD
         dKlrxgab1ekty8cIMiSOmmvbPB9GEyRFYWC10TT9Y03l4H9Tg/QCpBD7rRkx5o0+sJP5
         MBWw==
X-Forwarded-Encrypted: i=1; AJvYcCXBxbEaeTo0is0RJcwCIl9VmZX0YWnCr99YrMjuTVnU0JHsog15nhGG1CaulXgIB9XxGno=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfrtV/MU2Mh9iqWj3CmbxWxI3YKmfRMGa42l928NfYp7ODBIYq
	1ECWtqxEkpWw6CbY1XijrdXlzjvsbqYjXKo7MCBQqCMJ0qTiJCeL8mzWZLJlazRIvDvgr0+U2OQ
	UXFyY3rofn8TkoEgh5SDrIJUfy7KPhbvwgJA+QA==
X-Google-Smtp-Source: AGHT+IEyhDCI8uEgINl/19kZGQHC6kuRJIxNgH3hWrL1KJtZoGM79ON3CjtDQn4nsoP77Nm3Gpwmt5n+x2svg9lbJTk=
X-Received: by 2002:a05:600c:1d06:b0:426:8884:2c58 with SMTP id
 5b1f17b1804b1-4318412acb5mr25679865e9.4.1729702298097; Wed, 23 Oct 2024
 09:51:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1817.v3.git.1729521495497.gitgitgadget@gmail.com>
 <pull.1817.v4.git.1729534340786.gitgitgadget@gmail.com> <ZxiUTbmGpeK3KnOx@pks.im>
In-Reply-To: <ZxiUTbmGpeK3KnOx@pks.im>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Wed, 23 Oct 2024 17:51:28 +0100
Message-ID: <CADYq+fbb6e0z9V41gurNps53RMxOeZgO++c0HSwc8BMPpgakyA@mail.gmail.com>
Subject: Re: [PATCH v4] notes: teach the -e option to edit messages in editor
To: Patrick Steinhardt <ps@pks.im>
Cc: Samuel Adekunle Abraham via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, Junio C Hamano <gitster@pobox.com>, 
	Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 7:14=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Oct 21, 2024 at 06:12:20PM +0000, Samuel Adekunle Abraham via Git=
GitGadget wrote:
> > From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
> > diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> > index 99137fb2357..813dfd8db97 100755
> > --- a/t/t3301-notes.sh
> > +++ b/t/t3301-notes.sh
> > @@ -1567,4 +1567,67 @@ test_expect_success 'empty notes do not invoke t=
he editor' '
> >       git notes remove HEAD
> >  '
> >
> > +test_expect_success 'git notes add with -m/-F invokes editor with -e' =
'
> > +     test_commit 19th &&
> > +     echo "edited" >expect &&
> > +     MSG=3D"$(cat expect)" git notes add -m "initial" -e &&
> > +     git notes show >actual &&
> > +     test_cmp expect actual &&
> > +     git notes remove HEAD &&
> > +
> > +     # Add a note using -F and edit it
> > +     echo "initial" >note_file &&
> > +     MSG=3D"$(cat expect)" git notes add -F note_file -e &&
> > +     git notes show >actual &&
> > +     test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'git notes append with -m/-F invokes the editor wi=
th -e' '
> > +     test_commit 20th &&
> > +     cat >expect <<-EOF &&
> > +             initial
> > +
> > +             edited
> > +     EOF
>
> Nit: we typically align the contents of HERE docs with `cat`. I'm not a
> huge fan of it and had been struggling with it initially, as well, but
> coding style is subjective anyway and it's totally fine that one doesn't
> agree with everything.
>
> In any case, I don't think this warrants a reroll of this patch, just
> to keep it in mind for future patches you may send.
>

Okay, I will keep that in mind. Thanks
> [snip]
> > +test_expect_success 'git notes append aborts when editor fails with -e=
' '
> > +     test_commit 22nd &&
> > +     echo "foo-file-1" >note_1 &&
> > +
> > +     # Try to append a note with -F and -e, but make the editor fail
> > +     test_env GIT_EDITOR=3D"false" test_must_fail git notes append -F =
note_1 -e &&
> > +
> > +     # Verify that no note was added due to editor failure
> > +     test_must_fail git notes show
> > +'
> > +
>
> Nice.
>
> Thanks, this looks good to me overall.
>
> Patrick

Thank you very much, I really appreciate.
Abraham Samuel.
