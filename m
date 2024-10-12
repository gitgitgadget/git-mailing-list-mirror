Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF9B4315F
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 06:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728714500; cv=none; b=gUDF86BBsTx4d8WHK0Q1F5Ms6yos8ulnQr/pEDCtkCPZoVzv71xEk0ZuXvk4EkO33OnjzO2GdSkJGP+iVlHZEIFt9cC4zDXdqfAIfS48seoYUX7r+sgvwEktyI+7l4HRIcJWecHFXP/JxPGsLycgNzAoVYTeavIktqPVrYFk4a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728714500; c=relaxed/simple;
	bh=ZqxKu8wSYJ7t/QPVSMapJMu6tjITOhpd+hSlm33pLt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gSgKoczqyWnHWxm3RhYKhOVVXP57YKIlUQ50mVk1NdAICmQXnc3soYW+5bhmiFBw8HgTE8e6BGPc04VqKzacDPB/eA0gkweH2Xy/XB3wt+CsEnhtV+wGWImh6UwhdBzlV/L69/L2CROUJ9T5RhLTzZDgcraMnlRwCIvJpbYxdrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYr04ZSP; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYr04ZSP"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c94861ee25so952300a12.0
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 23:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728714496; x=1729319296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kV1JWvtbL+MROSUs4pgTKYxXXOxUSjA/FdtG8lIxXzk=;
        b=IYr04ZSP1/DNI+WXGVbrOnBcEXHf4vZbRly5cY+MSknz/krFhP3xVB7CzDF6QWdW+q
         safgeAMDXp9+HLHPvy2/7jSnOvXtcL8RQ/GFIFuCNHvEx4aJr3hj5G2RpM/mMZlA5kLm
         2yRRJSQ64N+m9wJl30fJwAJzsvw9gyYrvqgE2kAmiWTUeB3gnVI8gj+OWBgMdmEJKflA
         Ro0E+DyvdK5FDzOqTOMQ8x/uJUmksyB02TXR9/8MhzHbWUC6QAYKnyofLfnWsJxsGsbi
         V8KupbKcpxKh3Z3axChMSkaJNONgjy5ggcRMMPK/RD8ohVTN5gH7tR6MGMYAMuRL4io0
         dHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728714496; x=1729319296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kV1JWvtbL+MROSUs4pgTKYxXXOxUSjA/FdtG8lIxXzk=;
        b=IVIQW7XYxgK1PhMRs6P69Mf7l0yII1daOAibRwQegvPn5s3eg9FVcOcmquNJ9vXK/8
         7cdhvap0pUp6byOYN2z9VllSqejrV6g/23mWK1uue2NNWuIxe/NR4hl0/fTGb6GC0U8T
         jT12DZLd76g2eM83+thrLIwVK1uLy3jLwTx1Tw/NSNAO/mByUOp0F5uKwZbyqyVWDEeU
         /KNam0GNyFhmhaX4PTjagd8Z9HkkSRAQX3NnfymhNmE1TOTYEnFT6QBPwO1vg32uCpA7
         ZBWGFgOEmRW9bPjbDyvBjb6nW/wp8dByCR+4z4luk8pV3Hz07+LVBVMXXjQj8RLyYCvD
         tzqw==
X-Forwarded-Encrypted: i=1; AJvYcCXhkgdEkQ9G27tTuwJyo+kl9loHbGo2j+UGzVzofkYYp+w83XtNdyJyceGrKs1a69GBIRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB4OxKUCigfR7GxdivRPygPVHPf8RN6ZkOZ07z9FhyF5/qYEsS
	NZ6LsEYt00upWSvsBbv9slb2s+aBBpIy5Pnyd7AapvN0otE/FyfzTVgNkSTmtzchZPDYA8C6jEK
	GDbGTFdrRukS3z+oJa6WExpTm
X-Google-Smtp-Source: AGHT+IHk/wBaJa1JteA8T0L2HOl+lKzMH7bIXnrzaOdifzBL/uMcl8YTba+2z6Ru5jdZ9y2Zbo4jucabwL3SVYcmgCY=
X-Received: by 2002:a05:6402:26d1:b0:5c5:da5e:68e with SMTP id
 4fb4d7f45d1cf-5c95ac09876mr1901672a12.3.1728714495413; Fri, 11 Oct 2024
 23:28:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqzfnaedh6.fsf@gitster.g> <20241011235959.596136-1-chizobajames21@gmail.com>
 <CAPig+cSRJXoZfXdBmWt8md78t-6c2NBjeR=PK=RaKqLoCjxXMw@mail.gmail.com>
In-Reply-To: <CAPig+cSRJXoZfXdBmWt8md78t-6c2NBjeR=PK=RaKqLoCjxXMw@mail.gmail.com>
From: Chizoba ODINAKA <chizobajames21@gmail.com>
Date: Sat, 12 Oct 2024 07:28:04 +0100
Message-ID: <CACwP9aoDGN_Oaw3-JyjyaH-jKO5wbFYhkeJrV4gTRr2TcRfE1g@mail.gmail.com>
Subject: Re: [Outreachy][PATCH v4] t6050: avoid pipes with upstream Git commands
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: gitster@pobox.com, git@vger.kernel.org, phillip.wood@dunelm.org.uk, 
	ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 12 Oct 2024 at 06:35, Eric Sunshine <sunshine@sunshineco.com> wrote=
:
>
> On Fri, Oct 11, 2024 at 8:00=E2=80=AFPM <chizobajames21@gmail.com> wrote:
> > In pipes, the exit code of a chain of commands is determined by
> > the final command. In order not to miss the exit code of a failed
> > Git command, avoid pipes instead write output of Git commands
> > into a file.
> > For better debugging experience, instances of "grep" were changed
> > to "test_grep". "test_grep" provides more context in case of a
> > failed "grep".
> >
> > Signed-off-by: Chizoba ODINAKA <chizobajames21@gmail.com>
> > ---
> > diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
> > @@ -344,7 +374,8 @@ test_expect_success 'test --format medium' '
> > -       git replace -l --format medium | sort >actual &&
> > +       git replace -l --format medium >actual &&
> > +       sort actual -o actual &&
> >         test_cmp expected actual
>
> Although `sort -o` is POSIX, it may not be supported by all platforms
> on which Git is built. Moreover, as far as I can tell, `sort -o` is
> not used at all in the Git test suite, so we should be wary of using
> it here. Therefore, rather than introducing a novel use of this
> command, which might possibly break on some platform, instead stick
> with what is known to work without problem:
>
>     git replace -l --format medium >output &&
>     sort output >actual &&

Fixed. Thanks Eric.
