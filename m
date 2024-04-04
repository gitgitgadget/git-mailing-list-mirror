Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BCC55761
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 06:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712213902; cv=none; b=M1NnWwGRRBqH8StCkcImkeSzTpyusVXK7Kf++Nys5i8AYEFIk0tAjhWJ+S6RK4APwY8iLgMdiLk7MA6znqvEH8iqYQb55JKI/+0NqkYr41Wtm0VLRvAK7fh1MFXVAiXOo+I7C6FRubCP1TDF7X4NNqoZoEV0xYUQfYm52kC5Pr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712213902; c=relaxed/simple;
	bh=WnjINATqP6Oy9iLyZk0mxDtbFyAOrEgjgnaK1DjaJ/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nAI0SAu6jwcn+QtSXbJNfYspAsgf6Mz1RUugov9X5GuIzJjkFCW1VePqaAHG0Uqd/fzl1D1ryh++Rz5+UARIUVx7CtY8ldkw+kPJu6aVxw3ExrpkH2K5tV/HBxH/iwcBIUmApxNbEAVuGB4SUsCuBRGdLH4G3pF+3eJ8BHVW3og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PU/m/Gi3; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PU/m/Gi3"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6eae2b57ff2so592125b3a.2
        for <git@vger.kernel.org>; Wed, 03 Apr 2024 23:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712213900; x=1712818700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2KnaOuMdyoCOg3NRK6tIMr6nkuemXciKxusv+e891c=;
        b=PU/m/Gi3YHfhznFiM6/cVP7NMG0rvFXcDGP/D591RGWDidUqRLk/hUR6yq8YXz2WOC
         J0dtxQeD7a7zyKBdzAruPcSMjXPeAIjgs0rUWXZDOYxka6ERNqc96c1sv4JL34u/IVJV
         USQzBfh82IDhbza6DS3BUjTZVYz0NF7/cqukWPsTrWcfJpGh7YmNUTwdlve8M0z2f608
         fAx079oMJAHAyx7wY+kuDeSTRZvNTrJJzjLbiwMIkGRxvw+9dN5m4rZNMTkvi7QbGGXO
         kVXXnpFSfmbs+lAi1YTSxkQ4EYhh6vmAZI5odqH7nrVjK4V3F9z55CDPwmjxsOd4XOYE
         Np8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712213900; x=1712818700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2KnaOuMdyoCOg3NRK6tIMr6nkuemXciKxusv+e891c=;
        b=eNUgDFwHH07iaRWj8YQ6DHh0pe3ECY7OQyeZdhZpFVI9oWOrQSoGs85399HvDm3UJm
         s63PIrxM/Wu7cAgWHh7hO06hTsNZjrah3j7nCMvOzY73C0yMPSJale1cFyfsXlYnPQQN
         idD/ksH+iwG+yYdygi4syUWn4QaiQv4lu0CEJxziZ2JHGCbaFiDJClbMnskKPQLZ6Hj3
         ndOYNK6KYEHzXfx46gdB2DFqEd0+j39zXWoDzpk1Hbj4c14bIVORG3d/DJuXvCGYKrpk
         VWWpl6umeO+ylihNHDgS4WNa9mm4CSTxZxXp61XlWKnAPghA+BC24ow7KnH/mQ5gb3gV
         AfmA==
X-Gm-Message-State: AOJu0YyicFf8Q/ZcNCpGtKqR2KVYkq9Z12BSMroU0EXHXlOiFy7Wx1h4
	s+UWosmhLbIfVzlwlK8BreTTULi7CiTaJr4nzbLbWSfILmIUjA2Um7NWeqzjueWJdHffapTkR85
	2xS/XWHuVo0HKgoRngUCKfevK6H91FNO94NA=
X-Google-Smtp-Source: AGHT+IFGyDaP2HPGDwn+KdfbXNvYlgX2xBXSi//Gtbo++7VRNFdx/VN0e4tEMZZHfg/n/plxD4mS7Rnn+pNWhviUPv4=
X-Received: by 2002:a05:6a21:78a6:b0:1a1:6803:69a3 with SMTP id
 bf38-20020a056a2178a600b001a1680369a3mr2103637pzc.0.1712213899819; Wed, 03
 Apr 2024 23:58:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712078736.git.ps@pks.im> <cover.1712209149.git.ps@pks.im> <4877ab39212867e91058c60f99fe0dc2a592d583.1712209149.git.ps@pks.im>
In-Reply-To: <4877ab39212867e91058c60f99fe0dc2a592d583.1712209149.git.ps@pks.im>
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Thu, 4 Apr 2024 08:58:08 +0200
Message-ID: <CAOw_e7YeqEK4O=KWowMYGtRVMLwL3y6bWw2LRfC9TqJz06Esyg@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] reftable/writer: refactorings for `writer_add_record()`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 7:48=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
> +       /*
> +        * Try to add the record to the writer again. If this still fails=
 then
> +        * the record does not fit into the block size.
> +        *
> +        * TODO: it would be great to have `block_writer_add()` return pr=
oper
> +        *       error codes so that we don't have to second-guess the fa=
ilure
> +        *       mode here.
> +        */

The Go code returns a (size, boolean) tuple for the write routines
here, but that does not really work in the Git C style.

If you make the routines return error codes it suggests that the
in-memory write can fail for other reasons beyond "does not fit". Not
sure if that is really an improvement.

--=20
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen
