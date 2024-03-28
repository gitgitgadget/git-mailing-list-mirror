Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5382C13775B
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 19:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711652512; cv=none; b=KZRq00Pe1Bh9z+rTCpBfqfuPAazvO15Z4eq0cuNijXVeRDQtqQ22S5MJhGCn3oISqIBXEwIfrREL8o0MIaWv9aUQJpC4UD8MECf7P4fxfNNSW5qXDdnxw0A6tfmNXb3tIlHwmhGjnHMUzgxWBAikqSr24o35vCCU2XF6ThtU+Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711652512; c=relaxed/simple;
	bh=w556MD/jFhKPbxIcANmnxxiUYxZ+49LzwmyULe+Ktco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TK+v05QCOCX9WdUS9k8oetK0/deXpUcC2N4LQ2/OBfsNndK+3FcoBqGSuvaYq99r7BEEFPlnDLBJL545GzmIV13m6kssdoSHH51COCujLmxcHOE8aYbz2ZUXTUr694m+bsjg3AQu8QRWbB0l76Ifk0YTIsHWlEsPvCDERlYpAvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ah41mxOV; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ah41mxOV"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a470d7f77eeso171928766b.3
        for <git@vger.kernel.org>; Thu, 28 Mar 2024 12:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711652507; x=1712257307; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pzzpAB4kWhKE/tYEkwN1EIU1L0P+6pOzb4GHyd4Y+so=;
        b=Ah41mxOVvaE1kJL0ZLrDmwKFQIFiwjsenkWKfZ2kXSWRz2wOinQNpWF1UOrcIUNtoQ
         DCjlJPESi9UtEsNk4lghdcWDYTeEmMhIpUMN7xoFIOwuV6OMgIYggFByOG3OTzwvo3pI
         3Oj/VIjps/TkcwToCm3XY2aQ3lKMtaUMmm3cSsuBoOhjr0TqIU69TwQ2mSaPO2j/a0K3
         ruQRTzIQ/pNV+3UP46c96uqXhsF39O9TbsrK91wSkUQvKWP5J7wysIYK6ET1pSRuVhQq
         PN4eZ67dO49jeHY+WnPGLvL4BiaC3WUlrAEMQatbd+SMUXsNfgwZPG4xXki8iG+Zn4Mt
         dsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711652507; x=1712257307;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pzzpAB4kWhKE/tYEkwN1EIU1L0P+6pOzb4GHyd4Y+so=;
        b=V42XGRWJNglp932GMHRhAjbLi1e+ZBFne4C8oW81h0DHbo/Ep3PJWbDi899msavIMV
         X9GYbQECjWarnGTvVZ0HZRoBGTmZ02/3IuHUgYJt+aNq5k8jGyOJmK6xsxiqNdr/YqiA
         uZyCI5Mk4RFCjlNUV9KduLehAwjXeLK79YEHsNX4AzzrrlLBJmB3b72VfaluQp2uDkfk
         zjIlm0AQhph/Wa5R0y5XlF7SmpJENx61kpG6QPyzGUxCTJ3r+UNtya+jhEz+hr7MUOO2
         sm18vky3iG94cOuueCCcDk0CCf2ytHRAIUBMedjZrXWi4RaH3EefkJxCaRSd3r8wBZd3
         mtUw==
X-Forwarded-Encrypted: i=1; AJvYcCV7wh5mNthRqkvPFcSGahlKaov3ryKMLny/vf9dQEZfLuPEg2LzFoBKqlGkVlz7g8AGRAip9pDGvvJVY3lfxoMls81f
X-Gm-Message-State: AOJu0YzrNzqUu1ADBohsFVBp4eqqu7d9OzjeSTBB1oInRjNM1dxc2hca
	q3aiBS6f4GTHG2c640zrG4PGo8NRryOGxdOg5u8UV1UkxnlPXNVOJLTj8sdnYOW/RrM2Kn8UBg5
	8P/sMo9LrX1l3+cToz3UCcmgwimQ=
X-Google-Smtp-Source: AGHT+IEWP6a/ptHkkxhaCYqg/6BJdYoEyuaOBO1CVIwITTQNTxPn8hNsmIP2nwmkZdP9hhmjI49l3ZKuF+fmQQLsbS4=
X-Received: by 2002:a17:906:bf2:b0:a47:df55:cf6c with SMTP id
 z18-20020a1709060bf200b00a47df55cf6cmr83598ejg.63.1711652507516; Thu, 28 Mar
 2024 12:01:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHfn=+snXChcPFiEgxvK=XFCq2uVMKQTyfrN9RNfAod18d0V=Q@mail.gmail.com>
 <xmqqo7ayuwpi.fsf@gitster.g> <a9cffbe4aadd319760635ca6d5b4f465@manjaro.org>
 <xmqq1q7uusin.fsf@gitster.g> <1b81a013dd0faccdc24fe018fd740755@manjaro.org>
In-Reply-To: <1b81a013dd0faccdc24fe018fd740755@manjaro.org>
From: Eugenio Bargiacchi <svalorzen@gmail.com>
Date: Thu, 28 Mar 2024 20:01:36 +0100
Message-ID: <CAHfn=+tsrgAyUUqUkq4TpXcABr7=ZcH+cna+vwALJqZ3H8LxFA@mail.gmail.com>
Subject: Re: Better visual separation of hunks in `git add -p`
To: Dragan Simic <dsimic@manjaro.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Here's a possible solution, or better said a new configuration option,
> which I've been thinking about for a while...  When running "add -p",
> displayed chunks can sometimes become confusing or a bit hard on the
> eyes, but simply clearing the screen _before_ displaying any new step
> (i.e. a new chunk, interactive help, etc.) could make it much easier
> on the eyes.  It would be a new option, of course.

In my head, an option to print an arbitrary string would be amazing,
since then if wanted one can print a special character that clears the
screen, or simply add some space, or something else.

On Thu, 28 Mar 2024 at 19:29, Dragan Simic <dsimic@manjaro.org> wrote:
>
> On 2024-03-28 19:21, Junio C Hamano wrote:
> > Dragan Simic <dsimic@manjaro.org> writes:
> >
> >> Here's a possible solution, or better said a new configuration option,
> >> which I've been thinking about for a while...  When running "add -p",
> >> displayed chunks can sometimes become confusing or a bit hard on the
> >> eyes, but simply clearing the screen _before_ displaying any new step
> >> (i.e. a new chunk, interactive help, etc.) could make it much easier
> >> on the eyes.  It would be a new option, of course.
> >
> > Or your 'p' option can have a 'P' variant that clears before prints.
> > I have this feeling that even those who want clearing of the screen,
> > they do not want it always on, when many of their hunks are 7 lines
> > long.
>
> That would be even better.  Though, would adding new short command-line
> option to git-add be frowned upon?
