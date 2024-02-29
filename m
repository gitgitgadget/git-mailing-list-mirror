Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E128200A6
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 22:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709247209; cv=none; b=TVFXSG8MaDMBX+nXaicsQJ4poGR9zvMtsWk3UdKIEzZAkOFdk2SUW8m1g1nPsDP6S41HhPIYnSTplfDWptxDt7N0qydJxUwA6rBtRKwt8Jbz5RpJlB37uwnb2X1zDE3c1Xv++rFrN31FP6Qv2XovEOOVEYXpB5mTCDsseQII0Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709247209; c=relaxed/simple;
	bh=soWtPiifcwrnpH+VmRkIqgOC21IFuHrD2qbYxlkCKZE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lm2uI+xCB89WfrPMqurLUUV7pGYGFxAXB38oz3ofhB4vphT3/2FamAWDu2nY2+Q2EzTiTstlVlR2bVZj9vWTySPbX7zAhoEcXB/rSIKSIoUbibGq1mH1dcKPnX9rCerS/cb963Bd/Ww7dZaC0kkxhem5niNnltq36Jtio+ISCw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WFwjxY8Q; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WFwjxY8Q"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6e4e4572980so1302417b3a.3
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 14:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709247208; x=1709852008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2+o1WPgtMBWV6D4+w760SpuODsIUs/JQ37lZS+kRbhA=;
        b=WFwjxY8Qrb+9S0G50JK93Qb+nw3oKx2c8w8wAB6oC4Rp3d4+1YZP/CcRc9LXo4H7oP
         thAmDTfd0qZOSIFhEtC99FLUyipJj++BkkYkLbFQguvlbgP18TsuC2iA0ja/kEpu/BEs
         pTWRVYdN8FMpGpTv7F9JoHJMptZiU+fMIy2ficRsgAQFCvJEngswCEwRZ0SYMkdFxEfX
         ib9gNkpFhIfNKK+ldZJIaZHbq8WV3SehOL3Al46T6b4xg8eSzW+n5M6J/iGPMfQMrVnE
         V/3+xcIHd+rV4HNsD6nt9kyMsjoqqUMP9N+yNmB4M37/ct38yozp62b04WIyt3YHSRVu
         e23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709247208; x=1709852008;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2+o1WPgtMBWV6D4+w760SpuODsIUs/JQ37lZS+kRbhA=;
        b=RAvDPRBBouSbrbmIrkkpg2lfAOw28Y4Rl88UEGNpoTmflrUUahRDuAQFKatI7f5dJj
         tXtIu/v7j2TtbV+w+hfJQsgZfWl1fMJMhKOOSqlkVu7tUpr1rvDW5M0/WHR2e34ga6aw
         ErllcygepnaMGjA5GK5fYnYCHScvKCvl5oOitk6rrx6T2hALfzOGAfnnG4GaqU5mTAdD
         qk57IwNxh5QQMVn3PTaSbWodxpyp79PiW+mujgHUNWJv4x1RkGhIre37c9Moj8qUnpDZ
         Vq2QPhjmOVxt4rrWLuJQRggjX/dDBB87FXfQjJlQXqx3dqBOdZcRYAH2d8jmF3jFXP2H
         d51w==
X-Gm-Message-State: AOJu0Yw7IOvgveZDpBrED7n60AnpX6x9tt6RKDmGHbEhf27wIaAuSAlh
	DcyCP64BH4iMoxIm88Pq06bYx1pd0YEWLzhIS+vPXbKPGlD3/DSjm8YVe/XmRprpRUhsaaEbUyO
	rFg==
X-Google-Smtp-Source: AGHT+IFoKUlVh0e41j7ERyAtThZRoc9zG8NRqGEgnXoU+sZ+y+XeQGosLNOYAjkQY7CvcZ2azB+Eky3QfGo=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6a00:1991:b0:6e5:d5b:3eff with SMTP id
 d17-20020a056a00199100b006e50d5b3effmr1262pfl.0.1709247207604; Thu, 29 Feb
 2024 14:53:27 -0800 (PST)
Date: Thu, 29 Feb 2024 14:53:25 -0800
In-Reply-To: <CAP8UFD3KbbRApC3ktgegsi_oBDpzX_89v0QGvWoHQ057hKjbbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
 <pull.1632.v5.git.1708124950.gitgitgadget@gmail.com> <b2a0f7829a1c5f2822e9a896ffe3744587ff1298.1708124951.git.gitgitgadget@gmail.com>
 <CAP8UFD3KbbRApC3ktgegsi_oBDpzX_89v0QGvWoHQ057hKjbbg@mail.gmail.com>
Message-ID: <owlyr0gu51cq.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v5 5/9] trailer: start preparing for formatting unification
From: Linus Arver <linusa@google.com>
To: Christian Couder <christian.couder@gmail.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Sat, Feb 17, 2024 at 12:09=E2=80=AFAM Linus Arver via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Linus Arver <linusa@google.com>
>>
>> Currently there are two functions for formatting trailers in
>> <trailer.h>:
>>
>>     void format_trailers(const struct process_trailer_options *,
>>                          struct list_head *trailers, FILE *outfile);
>>
>>     void format_trailers_from_commit(struct strbuf *out, const char *msg=
,
>>                                      const struct process_trailer_option=
s *opts);
>>
>> and although they are similar enough (even taking the same
>> process_trailer_options struct pointer) they are used quite differently.
>> One might intuitively think that format_trailers_from_commit() builds on
>> top of format_trailers(), but this is not the case. Instead
>> format_trailers_from_commit() calls format_trailer_info() and
>> format_trailers() is never called in that codepath.
>>
>> This is a preparatory refactor to help us deprecate format_trailers() in
>> favor of format_trailer_info() (at which point we can rename the latter
>> to the former). When the deprecation is complete, both
>> format_trailers_from_commit(), and the interpret-trailers builtin will
>> be able to call into the same helper function (instead of
>> format_trailers() and format_trailer_info(), respectively). Unifying the
>> formatters is desirable because it simplifies the API.
>>
>> Reorder parameters for format_trailers_from_commit() to prefer
>>
>>     const struct process_trailer_options *opts
>>
>> as the first parameter, because these options are intimately tied to
>> formatting trailers. And take
>>
>>     struct strbuf *out
>>
>> last, because it's an "out parameter" (something that the caller wants
>> to use as the output of this function).
>
> Here also I think the subject could be more specific like for example:
>
> "trailer: reorder format_trailers_from_commit() parameters"

Applied, thanks.

>> diff --git a/trailer.c b/trailer.c
>> index d23afa0a65c..5025be97899 100644
>> --- a/trailer.c
>> +++ b/trailer.c
>> @@ -1083,10 +1083,10 @@ void trailer_info_release(struct trailer_info *i=
nfo)
>>         free(info->trailers);
>>  }
>>
>> -static void format_trailer_info(struct strbuf *out,
>> +static void format_trailer_info(const struct process_trailer_options *o=
pts,
>>                                 const struct trailer_info *info,
>>                                 const char *msg,
>> -                               const struct process_trailer_options *op=
ts)
>> +                               struct strbuf *out)
>
> Ok, so it's not just format_trailers_from_commit() parameters that are
> reordered, but also format_trailer_info() parameters. It would be nice
> if the commit message mentioned it.

Agreed. Will do.
