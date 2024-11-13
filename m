Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C8F18BBA2
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 21:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731535070; cv=none; b=oKM7WUB/XDR1v+hwvaWSozIZ5sTWtN0WUl+UmMRVe4vyzYI05FzDGizDfg3rnDn+ODF4J2oyag6EnFfsTeqBsrzNybbMQkQG5CCKu237Pw0iksEIAtQu5BZznW5DA2yB/1d7xvH+jTcQCrc3fxlzqE3WQID4mlT1xLV6iyxOElg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731535070; c=relaxed/simple;
	bh=mbiFr4dfBq6eVG8WhWm2W27AwKLiOwQKw3RBz1XlsIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZV8LagUu63x4ZLx98LrCDtyNFXfuowFlt2O6El7hU1gCawMigoCenMKpv4tSrY+ICDcV+YWBlcWFRbIer6ygX5pSAPYAbLaAAz6zfjTea3H7678dD6Tm+pCtemjfMKZPY+g9rAX2/geL2l1ZgDSUHd18zZHscdcYxXFi1e0zfTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOFEroDI; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOFEroDI"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cf764a3a2dso251206a12.0
        for <git@vger.kernel.org>; Wed, 13 Nov 2024 13:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731535067; x=1732139867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQEasfDDWID9YhwyyB6laeDt4YF4okVgsusnuaurlHU=;
        b=BOFEroDIc9PY7++s6L9S5spafTFoFJCVaIJ/qeSg5vBi1bnk2QNLfB13cIS2nUjWpv
         mMnDT1X3tQuXeFsDle68HE1jFznUqokkxnU9VP23ATmAI+EDdOk/CFTRX7lJetU4ZNF7
         qTPM+foB5JX0FanYIp1ThB73OTsEfmcgGKg9kCUDC1kvYFBRUprmrcPIcoV2Y3CMZ742
         WkACWAnnx3qr/L6PnGjfaSkMTHte6mB0EXFRNZPvH29nRQ+rpE/dv4jNnPDW+JA+bPcf
         WayrHzvebAxP25ks5dlo4CtfPdBe1AEnEZxiuCQYh9opw4Uw5CiQtWI7nJs9ustQhqOF
         2p4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731535067; x=1732139867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQEasfDDWID9YhwyyB6laeDt4YF4okVgsusnuaurlHU=;
        b=A7QQ34gWOBXPGvp5kvLFhcJVN9jCrYGjmpZcYYFbTDsJ0Y6q971bua0c6fOwkxfk1R
         3ZON7H6izpwKyoGgTUuufI2h6gU8fuANDXWNfnsJLDMXJODi3pmbGG7EtRQXB2RNBYJJ
         hu8pKolF4a+nvzMWrYrjnoF6gquu9wUOEO1he123VMilEIxgpRM+N50g7jflKB/vktSt
         L+9xQcucH/WfbCSVT8iiVGoTkCe4FcAQUaIoaRLhObwcixPpuNr/dzzr8w4e7b4XLVVj
         FnmZBo6SKJsLoEdphFBYwPp6ZoudOo3lXJxpylFJye5fB7uWtk4EcLaD4ZeM7cZ5MwMI
         HD1g==
X-Gm-Message-State: AOJu0YwDbwgdlwwi8SxIZnjAtU3sDfii0XYa2w8dIp332wzYXieaBsD5
	N3AURf2OghEL6/KDI6b5r8KWy1grL+Rb2JslmH2PciAfxX5S5ACWE6maC5wuqbDwZ7g7FEYJyRd
	4Fb2AmwEYGnWaOiN4Wk342S2EXWeYlRWQ
X-Google-Smtp-Source: AGHT+IHIZB/+fCtefVZuDbWwEO0sjAYjnPBrNnMN8VmqU6KwebL2kdKnsNAJPrN86+QhaDbVmPQd0HC+WEaWQW0HnTc=
X-Received: by 2002:a05:6402:35cb:b0:5cf:9f1:c53 with SMTP id
 4fb4d7f45d1cf-5cf754f57f0mr1158921a12.6.1731535066778; Wed, 13 Nov 2024
 13:57:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABpqQ_u4GG28L9KGX+HXiOv2AVAL7sckRBN4a99pCyeaQS+n_w@mail.gmail.com>
In-Reply-To: <CABpqQ_u4GG28L9KGX+HXiOv2AVAL7sckRBN4a99pCyeaQS+n_w@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 13 Nov 2024 22:57:34 +0100
Message-ID: <CAP8UFD0_+=5xmw6y5qiO22KMZhExLyZ=5HRjYphLD66vt0LLNg@mail.gmail.com>
Subject: Re: Trailers Containing Underscore or Dot Characters
To: =?UTF-8?B?44G144GY44KS?= <ffjlabo@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 13, 2024 at 8:40=E2=80=AFAM =E3=81=B5=E3=81=98=E3=82=92 <ffjlab=
o@gmail.com> wrote:
>
> Hi everyone,
> First of all, thank you for making such a tool. I am grateful to use
> this tool every day.
>
> I encountered the issue with trailers containing Underscore or Dot charac=
ters.
> I don't know if this behavior is OK as a specification, or not. So I
> created the post.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> I added coommit with trailers which have "_" or "." in each key.
> ```
> git commit -m "Test" --trailer "test_hoge: fuga" --trailer "test.hoge:
> fuga" --trailer "test-hoge: fuga"
> ```
> What did you expect to happen? (Expected behavior)
> I expcted that they are shown like this.
> ```
> # git show
>     Test
>     test_hoge: fuga
>     test.hoge: fuga
>     test-hoge: fuga
> ```
>
> What happened instead? (Actual behavior)
>
> Actually, some of them are unexpected value.
> ```
> # git show
> commit 70afae811def2345bead6660e0f3183662c9f4df (HEAD -> master)
> Author: Your Name <you@example.com>
> Date:   Wed Nov 13 08:28:19 2024 +0300
>     Test
>     test_hoge: fuga:
>     test.hoge: fuga:
>     test-hoge: fuga
> ```
>
> What's different between what you expected and what actually happened?
>
> The one for `--trailer "test-hoge: fuga"` is finished with nothing.
> But The others for ones which have "_" or "." are finished with ":".

Yeah, that's because '-' is allowed in trailer keys while '_' and '.' are n=
ot.

The underlying issue is that when we are given a full commit message
that might contain trailers and we have to parse it and find the
trailers in it, the more special characters we allow in trailer keys,
the higher the risk that regular text will be wrongly considered
trailer keys.

> Anything else you want to add:
>
> I want to use such characters to add some key-value received other
> service (e.g. GitHub Actions) as is.
> Is there any chance that characters like _ and . will be allowed in
> the trailer's key?

It's true that for trailers that are passed through --trailer options,
we could probably relax the restrictions for trailer keys. We could
also add config options to be more flexible in the general case. I
think patches implementing these could be well received.

> By the way, I tried the investigation for the current specification.
> I hope this is helpful in some way.
>
> [1] This behavior occured when executing `git interpret-trailers`.
> ```
> # echo msg > msg
> # git interpret-trailers --trailer "test_hoge: test" --trailer
> "test.hoge: test" --trailer "test-hoge: test" --in-place msg
> ```
> ```
> # cat msg
> msg
> test_hoge: test:
> test.hoge: test:
> test-hoge: test
> ```

Yeah `git commit --trailer ...` and `git interpret-trailers ...` use
the same underlying trailer parsing code.

> [2] There might be the cause in the process of the persing trailers.
> if they have such characters, the whole of the trailer option values
> are interpreted as one token even though they have ":" if they have
> such characters.
>
> I checked the source code at
> - parse_trailers_from_command_line_args
> https://github.com/git/git/blob/564d0252ca632e0264ed670534a51d18a689ef5d/=
trailer.c#L748C1-L764C4
> - -> find_separator
> https://github.com/git/git/blob/564d0252ca632e0264ed670534a51d18a689ef5d/=
trailer.c#L614C1-L642C1

Yeah, find_separator() could definitely have options to be more
relaxed about what a trailer key is.

Best,
Christian.
