Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09AC237A4F
	for <git@vger.kernel.org>; Sun,  2 Nov 2025 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762100446; cv=none; b=N58L6Cq691oPa/P9cELwEVoTeXbB4Uy6R9UhprO2qgOscOxhvDod0konAOj35Q9xRWI3W7sH4aiUhfx3yIDoo9A9d6WdqSm758VXDACuhjddBD+RtSnnzDZ31lXzK8RZrIcgib5NNWHjbAIW7S3cnESD4jIE/iuLbHQEsFB4eDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762100446; c=relaxed/simple;
	bh=cma3YIB42wGwxcHWW4cP80Jc2iR3CEMLF7jEO2dUdlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sy6nB0+Vo9N7QJ97X+oNL40DolWVEv7aNQRSWu7BXbqMNBJnLHPYuQjlCMLujCAXufQ5JI4S6Stre7yTFRPkr2w6fFslIv+Wd5QyW3F/RgM8dCmuw/+P3MsQ5+Dr4I9uHlJexaFPmEJcX415DO8JPWEAS7bDStc35MK6Sha3TIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cn+8U2Ex; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cn+8U2Ex"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b3c2c748bc8so484389266b.2
        for <git@vger.kernel.org>; Sun, 02 Nov 2025 08:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762100443; x=1762705243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ky/EckPgd6rru22QhtCgmAwQbF6W5HHezIilIdTBy/A=;
        b=cn+8U2Ex5tWVJx9zO5zPe283PHY0DntPsu+GpdV+GZAvaRpR+/B5j/4DEKicFld6Dx
         pB2/WnxGLFLjIz9ghnLYwek2JO6IzteYxPvG4h3U3zIlL5lpFhX1h0hFpSvEqoKZCgyQ
         5stmW3X8EX5ePdlG5FVwshs4i0k5UajfXL5199L8h2iUAUuvwIzdncNcbvJ3xuBVN8fV
         Tqt53vlOpsGgsSLGFXiYcI5kgJUbKoen+Bxkj5bGHsePhObTbGZR2uKhYXILg80ek4D8
         0ch4bSw4NkEcGSrsGIxYEa1scgJYRmt2l1P7iCQ4/Pa3wzIr7lV65I8LZVXUGP+X1z0g
         ZIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762100443; x=1762705243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ky/EckPgd6rru22QhtCgmAwQbF6W5HHezIilIdTBy/A=;
        b=siTYNiDtdLrsIzj7xPHYGvaaDgICx9u/5969pd4JuH5UonNu0pQnqnLpinI8kRsOGK
         zrZzhSY3VuD2k9ch8xFQzdv3GN5NRWq0Gad9opugk8i6mA4WOUE69KnnKjg3g2sEs1HL
         T6lp1C5YTRtFAPO+tbW06xCZwtLoZeCJDwA1RYLz8W1DdvN6righFmCVYd6uLK/eOxaM
         LDzx5PbDI8WFlHJd4LL/FpbPLya4JJsJBKfaWV11X0jdS65Tylf0m9/nY5gpC5eRP0O/
         qoOkeXY11L5BjonAUKa+neMq+BMpPr9ew4NG99MpzKLzbcxJHoi3zkzS1bYUWkoH2Jho
         STNg==
X-Gm-Message-State: AOJu0Yw4fJcok4+lhDzrpuLGznSsCnRbJQgGaYX0ywhqT45A3ZY4viNc
	Qh7iFguKlXTwcgsYfepk08suXQkZn2DlwFP+1wAC4TaCqXa+mjAWw4JcwEODTMzQEQjHVgBxyUz
	BzU97Bcnh+d2WmiyKHtgi8TQ13ExLjn4=
X-Gm-Gg: ASbGnctgh4ZdufLbxJAY53ZJHiWsNatViHZ3m4E6NO6m74P34y4MK1IcMCUPYfgBBUt
	PbOiJy/SGvJJCUcEjON+t6IHNpXmIUrkgoRB+yycPytJicr/2p5kwQcqMMvdZvOlt2UdIDwZ1Yw
	E5lCxJPIwNobUvt8WP68uZuOpP5M6Vq244rAfO62h1b02+tkvctsEcMHdwWdmEmGzc7TVpbMf65
	UMglL4+/A/ZuTRYl2XWw4CuYjhSC83Xm1NrCiDbGUfR2dA/eFYRt4DjqZeJ2PJDt7o/9RB77IuN
	FXEDDT+lAO+vf4Jpf3A=
X-Google-Smtp-Source: AGHT+IFAhjuAZHnhaFnNnyqbyZi93TNgsvNsDovq5Ee7RrzSfn5Yd7YdlVHMzhPusBHpFL2eS7MFfJt0pkxAQSlscqQ=
X-Received: by 2002:a17:906:e95:b0:b70:80e4:1c1a with SMTP id
 a640c23a62f3a-b7080e45922mr584619366b.21.1762100442816; Sun, 02 Nov 2025
 08:20:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501214057.371711-1-gitster@pobox.com> <cover.1759094936.git.ben.knoble+github@gmail.com>
 <5c97f580a9e77c464bc6bf4ed9ea8546711c6637.1759094936.git.ben.knoble+github@gmail.com>
 <a687ec17-8ee4-428e-bae5-063716d59a08@gmail.com>
In-Reply-To: <a687ec17-8ee4-428e-bae5-063716d59a08@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Sun, 2 Nov 2025 11:20:30 -0500
X-Gm-Features: AWmQ_bncIq10jAfiVQOzBW3UF2UH_Cvc7kb_3ZQLi1rcWJQdIW5xnUVsIY2a-v0
Message-ID: <CALnO6CC02MDThBJZg47ecZQnzdEE+tXPBcNzregduPvgkASceg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] config: values of pathname type can be prefixed
 with :(optional)
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Noah Pendleton <noah.pendleton@gmail.com>, Patrick Steinhardt <ps@pks.im>, Thranur Andul <thranur@gmail.com>, 
	Michael Grosser <grosser.michael@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Taylor Blau <me@ttaylorr.com>, Matheus Tavares <matheus.tavb@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Calvin Wan <calvinwan@google.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip

On Tue, Sep 30, 2025 at 11:26=E2=80=AFAM Phillip Wood <phillip.wood123@gmai=
l.com> wrote:
>
> Hi Ben
>
> On 28/09/2025 22:29, D. Ben Knoble wrote:
> > From: Junio C Hamano <gitster@pobox.com>
> >
> > Sometimes people want to specify additional configuration data
> > as "best effort" basis.  Maybe commit.template configuration file point=
s
> > at somewhere in ~/template/ but on a particular system, the file may no=
t
> > exist and the user may be OK without using the template in such a case.
> >
> > When the value given to a configuration variable whose type is
> > pathname wants to signal such an optional file, it can be marked by
> > prepending ":(optional)" in front of it.  Such a setting that is
> > marked optional would avoid getting the command barf for a missing
> > file, as an optional configuration setting that names a missing
> > file is not even seen.
>
> I think this would be a useful addition, we've had several people
> wanting to make blame.ignoreRevsFile optional and this provides a
> general way to do that.
>
> > --- a/config.c
> > +++ b/config.c
> > @@ -1279,11 +1279,23 @@ int git_config_string(char **dest, const char *=
var, const char *value)
> >
> >   int git_config_pathname(char **dest, const char *var, const char *val=
ue)
> >   {
> > +     int is_optional;
>
> This could be bool rather than int, the rest of the implementation looks
> good.

Agreed. For now I've split this change and the parseopt change to bool
as separate commits, but I'm indifferent to making them a single
change.

>
> > --- a/t/t7500-commit-template-squash-signoff.sh
> > +++ b/t/t7500-commit-template-squash-signoff.sh
> > @@ -46,6 +46,15 @@ commit_msg_is ()
> >       )
> >   '
> >
> > +test_expect_success 'nonexistent optional template file in config' '
> > +     test_config commit.template ":(optional)$PWD"/notexist &&
> > +     (
> > +             GIT_EDITOR=3D"echo hello >\"\$1\"" &&
>
> when git runs the editor this will be expanded to
>
>      sh -c 'echo hello >"$1" "$@"' 'echo hello >"$1"' path/to/file
>
> I think it should be
>
>      GIT_EDITOR=3D"echo hello >"
>
> instead
> > +             export GIT_EDITOR &&
> > +             git commit --allow-empty
>
> Maybe I'm missing something but don't we want to ensure that we have a
> non-empty message here? Also as it is a single command we can avoid the
> subshell with
>
>      GIT_EDITOR=3D"echo hello >" git commit
>
> Thanks
>
> Phillip

Great catch, thanks. I've certainly had some trouble with this
expansion before [1]. It looks like this has been fixed in the version
that was merged, so I'll avoid touching it further for now. And thanks
also to Junio for the updates here.

[1]:
