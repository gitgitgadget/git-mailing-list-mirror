Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2DDEEAA
	for <git@vger.kernel.org>; Sat, 29 Mar 2025 07:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743232590; cv=none; b=RBn4pYxqF9iEtOfBmh/iVMruXEQNwMUUC5VoDfG35ogIOK87En/N7Ow+F4GJ6/TgFZ6GBh3CS38fni7N04jHyd1QQdlxfPxw9mLhA4pkYb4+zYF5PlM0sQ9O0pGdxvMp/VJW/UtjdwMsfc7S5Dorfmmco3e6Kkh4NhrEfWom0ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743232590; c=relaxed/simple;
	bh=hlk2nk9Ty3W2gTOyB2gmPZ3DZ8zt97epz7cKm8Ick7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QHM1bPd7J1Bu4YFecagXxIROg4+tRL3EfqzWOYBmy8LanGFGEN34gFq2jK/a/+sI0YsMc7WnX6O23NLSEOqs4B0pY1PXbL/kYSYXy+4uqsCfX/rcXoSwPMWGztC5ggIOVaQ/pYWpq7DcAF/K4U6wVYQ6y4MOcz0p7LgEEeRQKIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnL14s/F; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnL14s/F"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e616736458so520148a12.3
        for <git@vger.kernel.org>; Sat, 29 Mar 2025 00:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743232587; x=1743837387; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XiYvGle8t6YWypC5kkxcBoZBcBbdxincT9S5r3ZB/V4=;
        b=VnL14s/FOfxX5YU3Y0QtCWHtFpFKjHjyjdeWbHJbX8mR4IJQlTbuP3CbPa6ZOT4/0S
         FTJsbQ3gjJjijjboMPm2fqn14aKnlBMqm8ejnwN1Pbi9fgZGxKKJjKgfVLcScsb5WCrQ
         jqUkGJv6nylS37AqNwt4gOszBHHM5AEwPsVpzDl6mO2gv2DXElXPebhEGSHo+wFlSmDv
         U85CLnYX+k7fFqhvxwOCNoETFTDyUIlbF0Ua9LWzqoYzf7JxxWsZBdLaW5chBP8OryQn
         kIfUZWU0XBKDH1JQ1uEYqc+/W/H+H+hEk1vmBk9C2GG6piKjMvJtAbJQLBQnCPH1bhny
         Favg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743232587; x=1743837387;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XiYvGle8t6YWypC5kkxcBoZBcBbdxincT9S5r3ZB/V4=;
        b=F7toBPz7ZYAtrYcN6yf+mZGN+aFZF5Pzv1gA/gdx3Pa5t5L31MoYZFSFM4J76XqIS5
         mXrhDhhvQuBGWF/rcUM7wFAKjadAIh7CxWoJQ6+38a++BviZgg53Yt3fsO8tjTEHuMpS
         b2MjU90DtCtNfVfAgnfjFTio06bKkgD1or41iqx08NwtgzF3SptTHvblNxtbbRqXhQvR
         XXpxHi1d98r0Z0cz3/QG9Tejm3qOAFHwmMFp2tcLfuAb8GRT6HEXViNco6fMFwDSsbIo
         IoQr3+zoB+EKAmp5GPStgmEmuJvy1wAb3w0ubnmDGYsUrHTak2/EEOk/zE6KfWk0iluP
         XUfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbrynIeWgMrjBt+Jql/ritDibdLWplIqbuMfWPjI2B+p2SCr+1IAt9H8bOHJRjyqVgB+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5EtW9HqvQSfeDsgosSWa+XsFjwDwCWDySylhA7ZpxGfjTxcXK
	ENGwyqz4HQxi1bt9dgGjP77ktdx/iI8xcq92czB14MgNGiN4OgG5jqCqwy0yAiG/GuFLVNB/+Be
	LnTP+qiAdqFA79mxOLPA9suoWGqPeQ+4UnnI=
X-Gm-Gg: ASbGncuNGq/yTkv7b9dgtFUq3GMCLppYOXOsu+KTO3yxI/lK3izcYP/Pf2ruJthwO8Q
	95HV7+f48EjyFyXLujotm+jkGbGY/LWBsnCojMOBO7N+1EYjNw38ASc0/8Me61AXxQ0pR4AbayN
	1oNNOcuj9UM8MuknfSw+PoVeEabsYuxkpmSzP9rUX5eDezIPDImn6cceg=
X-Google-Smtp-Source: AGHT+IGChEhjY23gkphZw2CaJIuNedkhfZ12gX2T62/XXFjHCtlxQQvTpe+bNE+QsF0cgWciEh8+2/T4CWoY1OEzQGg=
X-Received: by 2002:a05:6402:4403:b0:5ed:9f0f:352e with SMTP id
 4fb4d7f45d1cf-5edfce94d26mr560209a12.4.1743232586431; Sat, 29 Mar 2025
 00:16:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
 <20250218-b4-pks-meson-contrib-v1-6-c3edd292beb8@pks.im> <CAGJzqs=+mL_GyXfR44iQ6o6L+gb=D7DWm2Bq4eW19XhuEFuHew@mail.gmail.com>
 <Z7RrbZqq9VrTg-Bz@pks.im>
In-Reply-To: <Z7RrbZqq9VrTg-Bz@pks.im>
From: M Hickford <mirth.hickford@gmail.com>
Date: Sat, 29 Mar 2025 07:15:00 +0000
X-Gm-Features: AQ5f1Jq0nELNFoICtQ_hUYU-jbfTOiTMpDsQRpul1l1kBHj3yvdmuzg9h_6ZW0c
Message-ID: <CAGJzqsm4c7b+mO=Gya-zzaUsQ0c5CSrtG08Wgshu7-6epH6J3Q@mail.gmail.com>
Subject: Re: [PATCH 06/12] meson: wire up credential helpers
To: Patrick Steinhardt <ps@pks.im>
Cc: M Hickford <mirth.hickford@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Feb 2025 at 11:14, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Tue, Feb 18, 2025 at 10:11:23AM +0000, M Hickford wrote:
> > > Note that ideally, we'd also wire up t0303 to be executed with each of
> > > the credential helpers to verify their functionality. Unfortunately
> > > though, none of them pass the test suite right now, so this is left for
> > > a future change.
> >
> > Out of curiosity, which tests failed?
>
> Basically all of them. I originally had the patch at the bottom of this
> email. With that in place, we re-run t0303 for every configured
> credential helper, where `GIT_TEST_CREDENTIAL_HELPER` is set to the
> respective credential helper under test. We have to disable parallel
> tests there because the test state directories would otherwise conflict
> with one another.
>
> Now you can for example:
>
>     $ meson setup build -Dcredential_helpers=libsecret,netrc
>     $ meson test -C build t0303-*
>
> And that shows failures like:
>
>     --- expect-stderr   2025-02-18 11:09:33.323668205 +0000
>     +++ stderr  2025-02-18 11:09:33.347668278 +0000
>     @@ -1,2 +1,4 @@
>     +
>     +** (process:75536): CRITICAL **: 11:09:33.339: lookup failed: GDBus.Error:org.freedesktop.DBus.Error.ServiceUnknown: The name org.freedesktop.secrets was not provided by any .service files
>      askpass: Username for 'https://example.com':
>      askpass: Password for 'https://askpass-username@example.com':
>     error: last command exited with $?=1
>     not ok 1 - helper (/home/pks/Development/git/build/contrib/credential/libsecret/git-credential-libsecret) has no existing data
>
> I might be missing how exactly to set all of this up so that things
> actually work. Maybe I have to do something specific for each of the
> helpers via `GIT_TEST_CREDENTIAL_HELPER_SETUP`. But t0303 isn't wired up
> via our Makefiles for any of the helpers, as far as I can see, so I'm
> unable to figure out what such a setup would look like.
>
> Any hints would be welcome.

Before you can use git-credential-libsecret, you'd need to install
gnome-keyring, run gnome-keyring-daemon, and create a keyring
(choosing a password, can be empty).
https://unix.stackexchange.com/a/548005/7732
