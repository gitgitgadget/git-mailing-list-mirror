Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FC61B946
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 21:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707254049; cv=none; b=DGK0xWngldwOw4lxfxWxwbCMkaryaINtGKqwvfC2BmlsveV2NxX8lrKvov2lw6hNh0SvKLomquUYWWIq58RgAZHVAgM88icNdA47rTJhLPbblmpy/FoPjUVd32R11/1wsKdwUQgQXGo9jQYSrraQCkqR4dpg1lSQ+or3QZRVgMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707254049; c=relaxed/simple;
	bh=xV0SzWLxPqQSfI8x5P+WUuhudxLg9zuITvxP4ExMuwQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=HJ3AaUjsVpfMtmV9TUQ/f0+ldxPxp1EtF6Mk/HsHDlSx0AbOBGzLXi5/gXzAWjq6msj+JOb6vWnQXw58sRoNzPUWU0rQmRlk1mrp+UqAOk+elcabC4FuRCRz7LwfcNN76TJlSIQS9pW7oaI4DZiAbausmumFGN73fDGYfsB/c9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=VS5yNY30; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VS5yNY30"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a38392b9917so120862766b.1
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 13:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1707254045; x=1707858845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xV0SzWLxPqQSfI8x5P+WUuhudxLg9zuITvxP4ExMuwQ=;
        b=VS5yNY30WGH3apVxPNrvDjpN/yhPEPDBxaK5zvY6SHG4/Mszvg9tERD7+brqzFRppd
         tTeMfkp3Au/7IzAP4/ysB7Z+cmgABlaQh7ggggNrn3P9fcJCmMGayjA//BlBMKcpx5ZI
         u5SryliAz0kqFXKAbJSsWpcWCAuPV42A5J4AwYUvl1om/TCCsKSAHyWpwymRRVfvEbVc
         g8cvpDsHxY51ktDc49BIVTdzQ++Jh6HsWcD7ExbXHwrPuCYVbLzD9COxVe8K3fhw813M
         SvieHZ0zJ8Gdm8CP+DkKRRadB/poXH5RrOhOH6LzN2xLR6muM5H7H9TF/UAzYJdwNhiX
         W+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707254045; x=1707858845;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xV0SzWLxPqQSfI8x5P+WUuhudxLg9zuITvxP4ExMuwQ=;
        b=f7AmP0KWWLfFmTsT+FjZxL5BHZR+aFNnCVK6gi2Nvb76vY0u9tdzdKMSwlkBYJwGmC
         hcJ/mhEd1KnndJp1CJ3l81gj8nMT8D68WeTzn9oPcuAZTWL26neBbhlnyFytolQkKDiU
         LoHLk4olKVWOWRe+G0UjQbZZuUIez/2DyHPI2L3BgK1ww1huPNnlDTZiGs3f9IqiJwhZ
         T1drEZhgj1GlpTAqf9Nb4ZQw198JtNW8Ula3B5nYiBUb0EfVx6VlNE2hhwNVGHjgrAxm
         HRcy+s1mLlSPnOdINDAz8+vmOHLQCcEIXaIgCrWJTuTPlv/pozHJn6Znw4ip/55yOWDz
         UHRQ==
X-Gm-Message-State: AOJu0YwND8ucG1lugsdeV30EXDBDabSOWMY7ugAUzJJbMdg+gLtbdfkD
	WAYix8cBPPye4Tc3UaWhsMhMM487/WAjZy+21LrnuxZHCRdGJc8=
X-Google-Smtp-Source: AGHT+IF0NhUbYLWllM3XCDwE+gUPKaiX4BjvleIxm/UsvCrx0WOCsji2RcoMi+2gAhj3+irr9kz0bw==
X-Received: by 2002:a17:906:f203:b0:a38:4f52:cd01 with SMTP id gt3-20020a170906f20300b00a384f52cd01mr1003555ejb.53.1707254045291;
        Tue, 06 Feb 2024 13:14:05 -0800 (PST)
Received: from [127.0.0.1] (dynamic-077-010-084-133.77.10.pool.telefonica.de. [77.10.84.133])
        by smtp.gmail.com with ESMTPSA id ty5-20020a170907c70500b00a38259eec59sm1179128ejc.144.2024.02.06.13.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 13:14:04 -0800 (PST)
Date: Tue, 6 Feb 2024 22:14:04 +0100 (GMT+01:00)
From: Tobias Boesch <tobias.boesch@googlemail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Message-ID: <e897282f-ac33-4f1e-903a-b6fb69e0c55e@googlemail.com>
In-Reply-To: <ZcFhNPRprfMqeRu1@tapette.crustytoothpaste.net>
References: <beeab03c564e94861ab339d26c4e135b879a1ccd.camel@googlemail.com> <ZcFhNPRprfMqeRu1@tapette.crustytoothpaste.net>
Subject: Re: git-gui desktop launcher
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <e897282f-ac33-4f1e-903a-b6fb69e0c55e@googlemail.com>

5 Feb 2024 23:29:10 brian m. carlson <sandals@crustytoothpaste.net>:

> On 2024-02-05 at 20:12:10, Tobias Boesch wrote:
>>
>> .desktop file proposal
>>
>> [Desktop Entry]
>> Name=3Dgit gui
>
> I don't know whether this is the official name of the project or not.
> Perhaps someone else can comment on what the capitalization and
> punctuation of this entry should be.
>

From the official documentation [1] it reads "git-gui"

[1] https://git-scm.com/docs/git-gui

>> Comment=3DA portable graphical interface to Git
>> Exec=3D/bin/bash -c 'if [[ "$0" =3D "/bin/bash" ]]; then git gui; else c=
d
>> "$0" && git gui; fi' %F
>
> It's not guaranteed that bash even exists on the system, let alone that
> it's in /bin.=C2=A0 For example, this wouldn't work on most of the BSDs.
> This would need to be templated using SHELL_PATH and written in POSIX
> sh (e.g., no `[[`).
>

I see. I'll try to look into it. If someone knows how to do that let me kno=
w.

>> Icon=3D/usr/share/git-gui/lib/git-gui.ico
>
> This would also need to be given an appropriate location based on the
> build parameters.
>

Is it about the build parameters of the build of git(-gui), or about the do=
wnstream distros are building?
So git leaves this empty and the packagers full this out?

>> Type=3DApplication
>> Terminal=3Dfalse
>> Categories=3DDevelopment;
>>
>>
>> I think upstream has any interest to add this. Therefore I ask here."
>>
>> -------------------------
>>
>> The arch package maintainer proposed to try to to add this to upstream
>> before just putting it into the arch package.
>> Here I am asking if it could be added to git.
>
> If you wanted to send a suitable patch for the file such that it were
> appropriately built as part of the build process and installed, then we
> could probably accept it. Such patches are usually created by using
> `git format-patch` on one or multiple commits and then sent using `git
> send-email`.=C2=A0 You can take a look at `Documentation/SubmittingPatche=
s`
> for more details.
>

That is the plan. I don't know if I get the installation part fine for test=
ing it, but sending a patch should be possible. Sure.

> I think such functionality would be generally useful, and probably be
> beneficial to a wide variety of distributors.
> --

Nice to hear. Thanks
