Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B7B1E9B21
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 06:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741675776; cv=none; b=KRj0EdbPbORszUoijvsQ6m0dpnTMq7By4yLpG2BLJmEAPB4TREKismDHZQTSg6MkH90aZb1xMsYKS/cyoa4p1Vw7oNieBWWtTl1vod9C76DdR9G2zM1QDqk1Cm1T/EwJInqyOLrowN495frd/kq6Vyph0Z17MmH3dpxnbHs15uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741675776; c=relaxed/simple;
	bh=z5qljjjMrazn4vQRRsPnp6MS9Wbk3ch4jL9h6Xild34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ij2r6JlbrUT9BOHilrJo6Vw/GK79mjN17F21Zz+6sTwVqt4ONiMw2wO36Uwt+3H+ncvx6dVKrPsw1IOMta/wPJV0oBot+Me6N6xqvuGYepT9HYbm/tXfoulXy/mKWXEaSnNtgFH3Z8c1zdFsJ74/55sZdzCXKYDYBx54KCQeTSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhIECHq9; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhIECHq9"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-86cce5dac90so2243497241.0
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 23:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741675774; x=1742280574; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Al+gNKDEYPbhXIW9j2bgtezHkMrMDezSvYsHoVrb0xQ=;
        b=WhIECHq9IAjDQV5Hn0sMEMsAt6F+aAxCUzGGgR4I8HdT4JTAmm3TeM25pPPMKJPT7E
         fAV8NRJpTk/ZVwhuOlZpSdGD1RyjUsJuvAWX6xVNN54cpiyxh+aT5YS7xqGrJirGg/VF
         /9IQHtDueD4hDZAoyWJmBLmaLMKCj935cBXJD5mqlRjyW7IMnO+6AyCNqHrORmJp4M1+
         m9HDHsOXOEZ27vG2tq80w0ZkOZhnqzZe/LevzimSbdytiXVYohISyMMdPcUH40E42ZQr
         O0f0XIZCAFf/GtG0rROTdNGM7FkUdHrzb5WfTU4BPA9hwIjE34ed1ckSgQSSUCUc+JQA
         Xt2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741675774; x=1742280574;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Al+gNKDEYPbhXIW9j2bgtezHkMrMDezSvYsHoVrb0xQ=;
        b=YGB7pQmwxF5j0dHb00CENwJuoSnbpCSoyfWiQTWoMI/RBGguiPB0aCzf+leukvp5Nx
         FW2RAAgnczKYC1Cbi5ilLc0hBLgng4bC9q3gU/PaY3IcwfVWbSYQelizp6nk9xNwNQ4B
         taOTI8/cznmtJlgVnluc5GfQmvtQruM12JG9a25xfqTLRrRdw3RhK7Mpn8vNufOOOfUB
         lVoKv591mgYr8TdElMcx6z+D0IrKvIYTRiJy6gsVdAelQwotaFUpNhRkPId9ikhKg3WF
         mzKYIHGb869CrePvbcCS3ChyRxHCKBqyyXq8UyAJODtOosLr2duCrrUHp4/A6q1PRt/0
         xmlA==
X-Gm-Message-State: AOJu0Yzfn7o7vAZ4dcInMaoRQi3y3roNKesMDXMIBl7Y4cb2zFlEWA0R
	Q5PySSDM3eQiVIk49qqIvJjZiIYF47IyPFHuRbluhahSG4vFw9cHu1X3MyU45CXSyRVL9asJhaQ
	MWNuswoi1cB18aXfE3HQ/cZxPaK3cC1sBCjQ=
X-Gm-Gg: ASbGncsdI6OgEON/WherVb8auSg5BlgbyRCfIIghpFXZFgJOJXL0WSnWL4csHK9+h9e
	Wzv6bOaQ/Y3FgJFHuKatMak4I/UbQGWC+d9BtOGvvbOypTI/cpvqdkRekBE1zEio4SDeratkaIS
	ZRSh/ldkejhfFzs1RkpRcGTEipG6ySbT0DgDJSX2CJ1UpHJAfErB8InQVjWGppkS7PVEY2xw==
X-Google-Smtp-Source: AGHT+IFd1VGg2zq8+l/wz/4SaOejAl1RU0PH/V9Vz9alLGGmDhwAcanv6HWBKs1+OnmPKX3KqX/7nqQCRSf3RwMW3YQ=
X-Received: by 2002:a05:6102:3e16:b0:4bd:39a6:e98d with SMTP id
 ada2fe7eead31-4c30a346c43mr12074136137.0.1741675773793; Mon, 10 Mar 2025
 23:49:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311062440.3566116-1-05ZYT30@gmail.com> <20250311062440.3566116-2-05ZYT30@gmail.com>
In-Reply-To: <20250311062440.3566116-2-05ZYT30@gmail.com>
From: Yuting Zheng <05zyt30@gmail.com>
Date: Tue, 11 Mar 2025 14:49:23 +0800
X-Gm-Features: AQ5f1Jo3wEbymB1eG1WlzFre71OZmUutbmYVxKDFIcmflKdrhR5hza3EwqElbbo
Message-ID: <CAMvj1+r4K4ppX4GC_-1R5TjfhGcGGH6ccT5V51w-QS8nS+LZwA@mail.gmail.com>
Subject: Re: [GSoC PATCH v2 1/1] improve smtp authentication error handling logic
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

I am a new contributor; please forgive my mistake.
I mistakenly released the v2 patch without any code changes.
Please disregard this version and avoid reverting based on it.
I will release a corrected patch with the intended updates shortly.

Apologies for any inconvenience.

Best regards,
Zheng Yuting

On Tue, Mar 11, 2025 at 2:25=E2=80=AFPM Zheng Yuting <05zyt30@gmail.com> wr=
ote:
>
> ---
>  git-send-email.perl | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 798d59b84f..a012d61abb 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1419,19 +1419,19 @@ sub smtp_auth_maybe {
>                 die "invalid smtp auth: '${smtp_auth}'";
>         }
>
> -       # TODO: Authentication may fail not because credentials were
> +       # Authentication may fail not because credentials were
>         # invalid but due to other reasons, in which we should not
>         # reject credentials.
>         $auth =3D Git::credential({
>                 'protocol' =3D> 'smtp',
>                 'host' =3D> smtp_host_string(),
>                 'username' =3D> $smtp_authuser,
> -               # if there's no password, "git credential fill" will
> -               # give us one, otherwise it'll just pass this one.
>                 'password' =3D> $smtp_authpass
> +
>         }, sub {
>                 my $cred =3D shift;
> -
> +               my $result;
> +               my $error;
>                 if ($smtp_auth) {
>                         my $sasl =3D Authen::SASL->new(
>                                 mechanism =3D> $smtp_auth,
> @@ -1441,13 +1441,27 @@ sub smtp_auth_maybe {
>                                         authname =3D> $cred->{'username'}=
,
>                                 }
>                         );
> -
>                         return !!$smtp->auth($sasl);
> +               } else {
> +                       # Handle plain authentication errors
> +                       eval {
> +                               $result =3D $smtp->auth($cred->{'username=
'}, $cred->{'password'});
> +                               1; # Ensure true value is returned
> +                       } or do {
> +                               $error =3D $@ || 'Unknown error';
> +                       };
>                 }
> -
> -               return !!$smtp->auth($cred->{'username'}, $cred->{'passwo=
rd'});
> +               # Unified error handling logic
> +               if ($error) {
> +                       # Match temporary errors
> +                       if ($error =3D~ /timeout|temporary|greylist|throt=
tled|quota\s+exceeded|queue|overload|try\s+again|connection\s+lost|network\=
s+error/i) {
> +                               warn "SMTP temporary error: $error";
> +                               return 1;
> +                       }
> +                       return 0;
> +               }
> +               return !!$result;
>         });
> -
>         return $auth;
>  }
>
> --
> 2.49.0.rc0.57.gdb91954e18
