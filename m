Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B330ABE6C
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 10:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752056166; cv=none; b=mVzpbB8p/mIg4b/Bg79bdVlTKptuJMzCVsbHT4p6mNeZx9ssfU5K/ikewtiUqZbu8+HHxjYe5oNuvUtarZJxSytIiRjYR29jg9vrrpEEJ4zfgRFPfVx9FFBXYNQz715kx2nVhJXMdZ8qlk8iu1ONO86UU88uIulttU2CLn23mEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752056166; c=relaxed/simple;
	bh=CFaXhoFPZ3fNrDRyIX5+HH4PTxMu5imSceHsG9AxVp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OXuVoY+ypbpn5HVQFMQXNIeaCVv0GO4I7JgIw8zLsXTSXQP11CIDqJMi9zs9cs/i9IRTRzQwHVpCRemLm3NOvDElx8QAmRmUQ9jfSHLorbnPJzcmYMlwh5yGlvkp+Rjt7f/+bk3UHLu18Fl3lhkuPNbxUTUjaejWOI+aJUl47co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUqoienp; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUqoienp"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae361e8ec32so1060095466b.3
        for <git@vger.kernel.org>; Wed, 09 Jul 2025 03:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752056163; x=1752660963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xm19g84AEZZCLLu4e3Y9ULeoxObqdZzDcCH7F+Bp+3s=;
        b=jUqoienpVz0qM3JtTI1+Z5fZaal4cfJUNnD1Ad9orXZC4fSFE0USvN2rnzb7TV7tE5
         1C+94vEtxyVTUAGac5SmtCvV8E/p64ysEM2F3hh7ZKdK5i7JkwB9JQUOdJxludQF6n/4
         nJFJi8exI+wLLXQXuUdMahFxCtESom3KyVPnFw0ACehbWf4NK5ooqYtSgljrm8jLkXfW
         3tI3ype3NkKCpBxFg4eUCNqMg8tTcKfTIKvVuNtdywlT6GdQ2pg2LmGta82wc0+nCBY0
         OvtWb6KY6bzvwtHY9Dkr1FxgFaLwuzESBY1J0FinBcwSW6adZ6vJCFln/r6PuQZ0l0mD
         hTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752056163; x=1752660963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xm19g84AEZZCLLu4e3Y9ULeoxObqdZzDcCH7F+Bp+3s=;
        b=qHgp1FMBCuKJQYBf0VDhX+ZepD0ETB+Pb75eQ9CcOyJJlB548H/l/NSSNeIcZ9BCYb
         AHTKFWMZW1oSfp+X/y1h3vlWi72dJy2skpr4x5Mbwz2+QIJmncU3Jyiwn828n83MApC3
         rzpi+aaNeu+zbXQAn8gh28vqcHL0A7/48GsJOplET6aLHmEolVLE7A3rBLiFhTTyeNCL
         wSo2Jl78d5d4L+otekAyzFm71TkOG7ZAtxzch6rHkVraSAmye0i3zCdhCr4IyOpSI5ll
         JCBt0fM0bc8ZamsY5dtRdZm08iiQerb0PJjTmRceA7HsZEHTdaFk2Anm/VUYc1PrIh3V
         ZDSQ==
X-Gm-Message-State: AOJu0YwzSwrAwVN+9ETvOWf3PY0jNtSV0/uwRvxzklteRQtdyNnUEoD0
	HoIEfneb49zMqyPbJYK8VvERnh2+vd6yYLrJ65ISF4AmAAIgJCxeX5Wmd1oQyRUcOtdH8rQMb6F
	Rx7MyhItEKRyzIVvKbJmqUnseB8+WDjGZTQ==
X-Gm-Gg: ASbGncswx+tNxJX9MnB6dGoHnDQKaDDRIHiuIoibwH1A54PHU3mc5+4ryiUI3AoOXs3
	ZVmNNbzUVJTON60K5C7tVvjC8fUPMTMKzP7nL7SSt67KxMFhmD5+EYGNSkkLCL+P2a76MQZeSUD
	Hpg6DSRYcFI9gC+oRTmnC1FC4ghwtDk76hP5M8i/6OX/XOlg==
X-Google-Smtp-Source: AGHT+IEDT6CFm9tpkgKJ8B77hnA9XaQpkLWu5FGH6PHQb/mgHnLb0tCOJGF/3JTgsiZMlNiX1+xcRvtR3gQta6bAuzA=
X-Received: by 2002:a17:907:c24:b0:ad5:5b2e:655b with SMTP id
 a640c23a62f3a-ae6cf5fdfbfmr207643266b.25.1752056162521; Wed, 09 Jul 2025
 03:16:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619133630.727274-1-christian.couder@gmail.com>
 <20250708091738.4072857-1-christian.couder@gmail.com> <CABPp-BF6OvH8oh=jG_8fWoC5gW+9E+wx=uDEk1uerJTOva5isg@mail.gmail.com>
In-Reply-To: <CABPp-BF6OvH8oh=jG_8fWoC5gW+9E+wx=uDEk1uerJTOva5isg@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 9 Jul 2025 12:15:49 +0200
X-Gm-Features: Ac12FXwQQfwPK9Cx_NInAMHvzIQ43pCwZQCgZxLZQCT2R1ZJA11VJz5qZMPPkBI
Message-ID: <CAP8UFD2qpFTy0jtrKk4iQ1C+7dZDV7Abqrqz3J6qx2T4Jy0ESA@mail.gmail.com>
Subject: Re: [PATCH v5] fast-(import|export): improve on commit signature
 output format
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 1:08=E2=80=AFAM Elijah Newren <newren@gmail.com> wro=
te:
>
> On Tue, Jul 8, 2025 at 2:18=E2=80=AFAM Christian Couder
> <christian.couder@gmail.com> wrote:

> > diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fas=
t-import.adoc
> > index 250d866652..89dec1108f 100644
> > --- a/Documentation/git-fast-import.adoc
> > +++ b/Documentation/git-fast-import.adoc
> > @@ -445,7 +445,7 @@ one).
> >         original-oid?
> >         ('author' (SP <name>)? SP LT <email> GT SP <when> LF)?
> >         'committer' (SP <name>)? SP LT <email> GT SP <when> LF
> > -       ('gpgsig' SP <alg> LF data)?
> > +       ('gpgsig' SP <algo> SP <format> LF data)?
> >         ('encoding' SP <encoding> LF)?
> >         data
> >         ('from' SP <commit-ish> LF)?
> > @@ -518,13 +518,37 @@ their syntax.
> >  ^^^^^^^^
> >
> >  The optional `gpgsig` command is used to include a PGP/GPG signature
> > -that signs the commit data.
> > +or other cryptographic signature that signs the commit data.
> >
> > -Here <alg> specifies which hashing algorithm is used for this
> > -signature, either `sha1` or `sha256`.
> > +....
> > +       'gpgsig' SP <git-hash-algo> SP <signature-format> LF
> > +       data
>
> Should the `data` be moved to the line above, just to make it clear
> it's associated with it?  (Similar to the first line you changed in
> git-fast-import.adoc?)

Yeah, I have changed it in my current version.

> > +....
> > +
> > +The `gpgsig` command takes two arguments:
> > +
> > +* `<git-hash-algo>` specifies which Git object format this signature
> > +  applies to, either `sha1` or `sha256`. This allows to know which
> > +  representation of the commit was signed (the SHA-1 or the SHA-256
> > +  version) which helps with both signature verification and
> > +  interoperability between repos with different hash functions.
>
> Should there also be a note added that fast-import is limited on what
> signatures it can verify if extensions.compatObjectFormat is not set?

It cannot yet verify signatures, but yeah it's probably a good idea to
say that setting this config option might help with verifying
signatures when it will be able to do it. See below.

> > +* `<signature-format>` specifies the type of signature, such as
> > +  `openpgp`, `x509`, `ssh`, or `unknown`. This is a convenience for
> > +  tools that process the stream, so they don't have to parse the ASCII
> > +  armor to identify the signature type.
> > +
> > +A commit may have at most one signature for the SHA-1 object format
> > +(stored in the "gpgsig" header) and one for the SHA-256 object format
> > +(stored in the "gpgsig-sha256" header).
> > +
> > +See below for a detailed description of the `data` command which
> > +contains the raw signature data.
> > +
> > +Signatures are not yet checked in the current implementation though.
>
> ...or maybe that extra note could be added as a parenthetical comment
> here for now?

Yeah, in my current version, there is:

"Signatures are not yet checked in the current implementation
though. (Already setting the `extensions.compatObjectFormat`
configuration option might help with verifying both SHA-1 and SHA-256
object format signatures when it will be implemented.)"

[...]


> > +test_expect_success GPG 'export and import of doubly signed commit' '
> > +       git -C explicit-sha256 fast-export --signed-commits=3Dverbatim =
dual-signed >output &&
> > +       test_grep -E "^gpgsig sha1 openpgp" output &&
> > +       test_grep -E "^gpgsig sha256 openpgp" output &&
> > +
> > +       (
> > +               cd new &&
> > +               git fast-import &&
> > +               git cat-file commit refs/heads/dual-signed >actual &&
> > +               test_grep -E "^gpgsig " actual &&
> > +               test_grep -E "^gpgsig-sha256 " actual &&
> > +               IMPORTED=3D$(git rev-parse refs/heads/dual-signed) &&
> > +               if test "$GIT_DEFAULT_HASH" =3D "sha1"
> > +               then
> > +                       test $SHA1_B =3D $IMPORTED
> > +               else
> > +                       test $SHA256_B =3D $IMPORTED
> > +               fi
> > +       ) <output
>
> This last bit seems a bit fragile; could the redirection of output to
> the stdin of `git fast-import` be made specific to that one line
> instead of to the whole range of commands?

I used the same style as many other tests in this file. For example
there are already:

test_expect_success GPG 'signed-commits=3Dverbatim' '

    git fast-export --signed-commits=3Dverbatim --reencode=3Dno
commit-signing >output &&
    grep "^gpgsig sha" output &&
    grep "encoding ISO-8859-1" output &&
    (
        cd new &&
        git fast-import &&
        STRIPPED=3D$(git rev-parse --verify refs/heads/commit-signing) &&
        test $COMMIT_SIGNING =3D $STRIPPED
    ) <output

'

test_expect_success GPG 'signed-commits=3Dwarn-verbatim' '

    git fast-export --signed-commits=3Dwarn-verbatim --reencode=3Dno
commit-signing >output 2>err &&
    grep "^gpgsig sha" output &&
    grep "encoding ISO-8859-1" output &&
    test -s err &&
    (
        cd new &&
        git fast-import &&
        STRIPPED=3D$(git rev-parse --verify refs/heads/commit-signing) &&
        test $COMMIT_SIGNING =3D $STRIPPED
    ) <output

'

etc.

So to keep a consistent style in the tests, I would likely have to add
a preparatory commit that changes the style of all these existing
tests. Not sure it's worth it at this point.

> Otherwise, I very much appreciate the work to create a testcase with
> both signature types on a single commit.

Thanks for the kind words and for your reviews!
