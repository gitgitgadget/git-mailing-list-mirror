Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B332FA0CE
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016871; cv=none; b=Ajc0Xv7dOtJzGvDgwOLDxglVxHERx0NvJWbJ6GRllaPsEbNe8ElNGuNuQ1mCe5/JEgjCIx3m4rd4v6YImq7/7dHyasKiXnyg2w78bZf/4HNCiRc2kHS7DmzX9J7BG3NU3Z5176e7ccL9Wd8eMgm0WFPvcRHme3f/5vGMTGfje6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016871; c=relaxed/simple;
	bh=dv+9ts1msjc62zpOX8wiW6ElXMKvKRHLB4U8F9a4Gcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFXrtHV/reGemrleL6c8GSSa79T3AMqu+xXn8MRhNbmB1kWedO/+noM52UWr1jEVPHHw5F4c+AIaXBqVLMRNM8pV2lcvXVCdqqKxg2+vtFU1cq5XYo59acWork2PqO/bEmvPuYS4JYMVhPNuQdqBICaE1L9ESIcO8x/c0uRK5Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnFNylOf; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnFNylOf"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6154655c8aeso7905258a12.3
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 09:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755016868; x=1755621668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HN2Lun84RNz3Dx7kgw7+BRqlv3BHCugJNmDwRNpFlgY=;
        b=mnFNylOfJgPxn4XBDHU31hfacKMdmesQjVSN5zJ+AIyTcSAfii4kKXP5euoVH6Cv3h
         aYvN5BbsCs85M8ka77IQyTZUNZMMMYoslgxvTh16seYuyMEzBMj/9kRZvyxZq0sI4eAp
         Q+aj7MzMM9tCzPc6iV1QHFkxW4S3OskdIn3uQxO1ccuIHDuwtNnNUA6fNZKjP5coBEgY
         581gLGT+DShHgBbnkr/2hUFhvmDscmQ938valJmn70+5gINDuXouWMj/0M0HKdAUdPVm
         qVumChCVJJBzlj/B+lCbYAcZi4zOUT1dGWV7usl0auuPKQtNnVDJivA40sVleKUcEjLX
         XDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755016868; x=1755621668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HN2Lun84RNz3Dx7kgw7+BRqlv3BHCugJNmDwRNpFlgY=;
        b=mfRy7gEvjSsmrUD+LDtVMEHmgSXoXxiR83gycVGGnjC1GKeASY6U6ViNh5DkFhAiBo
         ihONwyicPchFsTu6+WjYBFxTKFko3dH7VdlKhyMscA3US2YyxurTvZXKJNO7ooGLm7kD
         JMpTy5snaWqmKHbfFD9LS62ORuYmDCOBewwb1jtDeZGUlHsdCtRjrgVZ0ufKTvt/estu
         FXZa9ZqNy17k2udJFU0ZIafdc/sbg+rBoGJhk/nrm731kTv9oa1YPD/nDbq8R3l/IbzK
         AGNvIBICuZKGuuz1F7N+03qWg2qewGSuLMy2QGQR0dl5BVdvOzm7qWNXI9SaU1d6HRAf
         j8hQ==
X-Gm-Message-State: AOJu0Ywea2hpiA44W+AX0FfMI2VziA9XuSw8ZSFXDzuepvemCWAJ5Mxb
	jFO1qRWroE/aWnyo0FHI7k+HRmUVlwt0oJ18vTf6tQLlxcvQvKHP6doWJyzyHWhSuwG/8RBwhu6
	mEEY1XhpDjzx14bEn8a5nBOF8mXMJNyqqk1CP
X-Gm-Gg: ASbGncux+rxrgSii1M5yqrQ5ml2pOvLv3OmRJl8atjatwbxAelFCyuIn8NGfPINxaAC
	For+ObPb6+anAFwDdYDP4+iS3lLxhMnevGnSoYKTPkhO7Yi/jGCna8PLmLOZJmjlYBLAVhRxJSP
	NvFS4eFsLAwxFhMkDiljMCMssFUmrtVKjQYC9iXaphLQUWzPLcWwPd7CZ3WTG6u1bkaVK03pKKm
	0mLBwRsalSosyJG5uAJ7aWOZPYvwfvRkcd8rgQ=
X-Google-Smtp-Source: AGHT+IE6sSP5iH5HG3HvfWQeqhRkhqUbSncc0gc+Kf4rIHt9FA12bM8gLLqna8g/Zz8IDT9qBOO/JX1VANbYI3UKWN4=
X-Received: by 2002:a17:907:9444:b0:af8:f7be:ab8d with SMTP id
 a640c23a62f3a-afca3a2a287mr36121366b.36.1755016868086; Tue, 12 Aug 2025
 09:41:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250810160323.49372-1-ben.knoble+github@gmail.com>
 <20250811221706.67168-4-ben.knoble+github@gmail.com> <CAPig+cThhm8b2vE=vAHYc5cEA9n232Lwi1c+p=LV9hK4hz=0Hw@mail.gmail.com>
In-Reply-To: <CAPig+cThhm8b2vE=vAHYc5cEA9n232Lwi1c+p=LV9hK4hz=0Hw@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Tue, 12 Aug 2025 12:40:57 -0400
X-Gm-Features: Ac12FXy2qbumnC1WZ0Y3kdgWw80U_wPBMpNXHOgEZj3XMjpmTq3OIMWAPwB1ue8
Message-ID: <CALnO6CDaHZuC0=_Saccj3DuW-vaWs30PmwXf9dw1+AfsC34wWg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] t7005: sanitize test environment for subsequent tests
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 6:34=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
>
> On Mon, Aug 11, 2025 at 6:17=E2=80=AFPM D. Ben Knoble
> <ben.knoble+github@gmail.com> wrote:
> > Some of the editor tests manipulate the environment or config in ways
> > that affect future tests, but those modifications are visible to future
> > tests and create a footgun for them.
> >
> > Use test_config, subshells, single-command environment overrides, and
> > test helpers to automatically undo environment and config modifications
> > once finished.
> >
> > Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> > ---
> > diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
> > @@ -34,61 +34,57 @@
> > -TERM=3Ddumb
> > -export TERM
> >  test_expect_success 'dumb should error out when falling back on vi' '
> > -       test_must_fail git commit --amend
> > +       TERM=3Ddumb test_must_fail git commit --amend
> >  '
>
> Don't use one-shot environment variable assignments when calling shell
> functions. Instead, you can do this:
>
>     test_env TERM=3Ddumb test_must_fail git commit --amend
>
> or employ the standard assignment/export boilerplate:
>
>     TERM=3Ddumb &&
>     export TERM &&
>     test_must_fail git commit --amend
>
> References:
> https://lore.kernel.org/git/20240727053509.34339-1-ericsunshine@charter.n=
et/T/#u
> https://lore.kernel.org/git/20180713055205.32351-1-sunshine@sunshineco.co=
m/T/#u

Yep ;) I had the latter, switched (see range-diff, I think), and then
CI caught me. Why doesn't the local test run catch it, though?
