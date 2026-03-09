Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A4E2D592F
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 17:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078710; cv=pass; b=VqRJf6VV07wzN0lfGkqSGyv++Lcb1l9sUBO78mv3ch0hlC/Bq3LIzYdgjG/vzbcaOlk5Wv3bOzHjTUYR83m05KygyRixuipWbKU3yiv43wGgOGm9qMlOZbz7lsPogZiMX9VblmsFEXspU192ABQpQW737CEubTU2F2XrFt9Qgpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078710; c=relaxed/simple;
	bh=l3SIwYSsxVxxR7MYeeFR/XMVHmaDNgpLZ2YEJwo7d00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxIKwLLQoemSF9519sGB307Sw9CR/+WH7mi8ZqjsCiMCRPinxXdSk8kq3Dg86D3R1McaAv/zkEozAvbLihai4C8oFEYIxK/4Dn+9X/9wG62z7LWZJ0AXPzdI2Ac9sfQ90e7dLdie0PSCuYgKiLBedrPZKVlJjKr1IRy4+0e6294=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWwAfeHH; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWwAfeHH"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-89a05955720so113016526d6.2
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 10:51:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773078708; cv=none;
        d=google.com; s=arc-20240605;
        b=fYIrJhk/wiy8zoBPk480rtPhKIzEP4fHWIZZv0SYhaTA+1AYUcmN0Iv0q1WYlLwK+U
         w4HLu20DJlFfbj2A/v3EWupgqkwQB3H2hLHquFbeH+tmDBnpc8zr1jUmQ40zo1USDver
         X5iBAo0wpsskASo0Z44bu3TswD6Pjfz8HBX1EbCP4Y58dJNSpqHIJuzbO+7qeoByvt87
         5tytgX+7rU4Ib3RVOpAZespuucXrP/S+P1gLbWuL+uVWK7grviiEsWe4Z4DAZr0hraeB
         H6LCg6zbwGCHKOvc9/BziARBraCbRjsG2lshGDhz3su8+EUJ8VSkedmN0U5eLqrLbGVE
         eIjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EReSUrQDsNDps2OjoEXkrpE0X4sAnwJb0opiRuDr2Qk=;
        fh=es5oIIS7Ht3rdwnRiymi9Q1gKobich8W7Ac5TL4Brq8=;
        b=FRJ/vo7pfZ0mQKOvyvL5CVY3Y/cPNp+yq8rPUUjvCgrAQzVbHQMu8eHim8lWdrqw6R
         Jisp+rWlJRM7J5QXqM+JD3GuryZtCnOZ7Xv2I3A/RmcjCvBrEsNenJ8YlYYGdgywM0QV
         3VXPnALibMK/2xBvYDl8LN/HVDxs2s86rcH6T6l5Q3ewWOpNhWdb0hZtJYbCU5NdDT8q
         LE8h5HDDf6eg/ONn8ZAKhugUvkNhsXcRApeFHm/6JpDEqAX3CkS8Fp6Ne+HBF892sjQa
         n60FOlIRLjmVmu9ZjMnmUtBH1Ifrbn+wJhDm5+iOjI+CgkyHEKcmECrsri27IXwcDMlX
         ip1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773078708; x=1773683508; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EReSUrQDsNDps2OjoEXkrpE0X4sAnwJb0opiRuDr2Qk=;
        b=MWwAfeHHRxRgSZ1lsEadaDRoaOSYewagatFBbHf7nC9oype4NwlwUGJW7Paw7pm5V1
         unQiXV5QwJ9s5/M0OvuWw+nIfyKM4T44lTr5ktFrELLrEjO5ZbPh8aAOR66JgsOrRPwg
         +WVhEEjUKYrWhayxwXvaLuLvAOf4hh4SlC4Ac0zSYQ1sp1QcGFLEYn+qYzA1yycCVdbY
         2ai6CDrMpWc9Or7yRYiXvhN6knOuJp9ZVQM45SqhMTTCiAlgY+fjNHbDN9y6JPMk4zOY
         DunF929+vAbKNJdN8kveWQTkynY9gm0U5jkjODyombZRIs1lNzA016R91+lbTEt1Tx5l
         0rMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773078708; x=1773683508;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EReSUrQDsNDps2OjoEXkrpE0X4sAnwJb0opiRuDr2Qk=;
        b=Viu6/t8kl3pjUYgGcBF1+BlRUTj43bpsxi+zRHn1gc4qYI3No+vnE1A71GP61/i5xF
         s1GQcV5gk3AukMERxHQ67m/5uFAVXsDrRBgA8aeHbzwW3XsnY5QVmP4Douvs57FlvzYN
         88HiNthzqYSUEbq9t59p7wvTo5WRa/GnBHnigMsCWYtmlcHd8pY2leU+0yN2aHaBBEnI
         K0mGiGCrk2KfXoyqjDeXGJRnUnZs56Y1XAWm75k++4f09eOPL58MCkdJceR88rhlKZea
         Pxp+QSBftoBi3Hs5+78jMzfNByexChFmqEAatkI1FV8IxqOEr9RIBQGBGMp3sNHnbaNO
         VpLA==
X-Forwarded-Encrypted: i=1; AJvYcCVnHuqiLX9xIxQy/6VkMw7AsuSMYB2oB8+RJ3VxO74qYJScOhbGePU4xdigPvhkaBG1jQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTDol6BCjF6/tDGGS5TIF5f2tYPX1j4v18s7Mahm9EMqYMscEN
	1AYOJ1H7nB6UrtvD/mWtCbXsbWRNaKIoMV0j4kWUXMq6bKrFMcNtbbc5c1iSnfE0zoLKqxO1YD8
	FTx628ABHvZkFFfnYC84Z2BCFghOr3Uc=
X-Gm-Gg: ATEYQzyknnOlpMev3KR+pDYuHFihNyG9kn5gT/59ACZ9xvFNuofeecARF7aTzrYXg9X
	wdFiykqw/gsXZiK8uSxShxURxKOWEJkcuiFC6CQTs7xKrwHWK3ktb8vONDe/Gj2JXGi5oXvfHwl
	96QPMicvzm1vTTQk8sdyzVz0WzPyURc1n+niPBIiAZdeMB4uToyVDTaJJLv83AVDZSO1PbVQ145
	Fd+BfIAFesg2+fH2KcOpaZd/jLQ+yEoLX0KhrODOir06v/QAlWyc0IYAbXt6JLtAjg6t/1OhZFQ
	UJumuuU=
X-Received: by 2002:a05:6214:d0d:b0:89a:8be:9d3c with SMTP id
 6a1803df08f44-89a30a340d4mr175523456d6.16.1773078708038; Mon, 09 Mar 2026
 10:51:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301190017.53539-1-dronarajgyawali@gmail.com>
 <20260308183756.31860-1-dronarajgyawali@gmail.com> <f03d40072ab106d1a0a7852718d42f56@purelymail.com>
 <6e3d373f2f41232ca9015c39ae0ea67d@purelymail.com> <xmqq1pht6nyx.fsf@gitster.g>
In-Reply-To: <xmqq1pht6nyx.fsf@gitster.g>
From: Dronaraj Gyawali <dronarajgyawali@gmail.com>
Date: Mon, 9 Mar 2026 23:36:36 +0545
X-Gm-Features: AaiRm50ujo6BCCmEDZtNAPqNmoitm1SStZAbF0OSimLQZBEBbAoZC06zWt3ypVc
Message-ID: <CAJtK1FO56BhCo7DgtFVgMRi9yNv92_jV1i1LfEx_G2uauR+jnw@mail.gmail.com>
Subject: Re: [PATCH v2] Make 'trust_executable_bit' repository-scoped
To: Junio C Hamano <gitster@pobox.com>
Cc: cat@malon.dev, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Junio,

I have sent a new updated series of changes  that aligns with the
actual code structure.
There was some confusion regarding work flow by my side. I am still learning..

Thanks for earlier review and guidance.

Best regards,
dorna

On Mon, 9 Mar 2026 at 20:52, Junio C Hamano <gitster@pobox.com> wrote:
>
> cat@malon.dev writes:
>
> >> Hi drona,
> >>
> >> Thanks for the update! Just a quick heads-up: it looks like
> >> you forgot to CC Junio (gitster@pobox.com) on this iteration.
>
> No strong need to Cc the maintainer when the patch is not ready to
> be applied, even though it may be nice.  I'll be seeing it either
> way as I rarely look at my mailbox and use the mailing list archive
> at lore.kernel.org my primary source of Git patches anyway.
>
> There were discussions on pros and cons moving global recipients of
> configuration values into a dynamically allocated strucrure, which
> can change when they are parsed and when bad values in them result
> in warnings, depending on the way the change is done, and excellent
> pieces of advice have been given by Phillip Wood.  If anything, a
> change like this should ask for input from him.
>
> >> Additionally, I think it's a good practice to respond to
> >> reviews before sending new patches.
>
> Absolutely.
>
> >>>     if (!strcmp(var, "core.filemode")) {
> >>> +           prepare_repo_settings(the_repository);
> >>>             the_repository->settings.trust_executable_bit =
> >>> git_config_bool(var, value);
> >>>             return 0;
> >>>     }
> >>
> >> Regarding the code, calling 'prepare_repo_settings()' inside
> >> 'git_default_core_config()' defeats the purpose of lazy-loading,
> >> doesn't it?
> >>
> >> if (!strcmp(var, "core.filemode")) {
> >>      prepare_repo_settings(the_repository);
> >>      the_repository->settings.trust_executable_bit = git_config_bool(var,
> >> value);
> >>      return 0;
> >> }
> >>
> >> I think the standard practice is to drop the variable from
> >> 'environment.c' completely and read it directly inside
> >> 'repo-settings.c: prepare_repo_settings()' using
> >> 'repo_config_get_bool()'.
>
> This "v2" applies to a mythical codebase where trust_executable_bit
> is somehow a member in the settings structure, which I do not think
> we have.
>
