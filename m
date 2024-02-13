Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1C65FEF0
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844915; cv=none; b=iTPZnHvJL/tyOQgG78p1TirSuTp7Rkzcweej35EAFdnJUKwiGkJ/Lx4zYIlBmOqvKHMgKPHsmZhv/DPVZSss0GxWScBmTyUxHT7p8ncOsEf0gpXMtYEasfQNNh6ebAqnx8T9sDzTQpBlDA7ZPpkeSow2bHvpTpAxdT4fEn5kvHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844915; c=relaxed/simple;
	bh=UxYnVDSwNodxiYxoUhPKmZH113lR97xP9WnCKD0PeE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/A0v2oT+s0TrEoKV9CCTfB0+m+ySYi4jc5QpJI5DULsUgBUDPv1RKDGwhtly/pGpe5mep2D2unDufGp8AM3j8Tgg8snxNXQc7k/lFU3brU2cAQZx78VcOByZFj7Q0I1ajGdXLUT46j/cOH7WMZtmqq8enjGGUDqxEzu0E8nNTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTKPxR+6; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTKPxR+6"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5119cfaeb9bso919893e87.1
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 09:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707844912; x=1708449712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djTXGNbZuGqyKuTSQbKwVEYJtS4pdpJJAwqttgQi+h8=;
        b=NTKPxR+67h9cV4kyUSljZ+M5ujNelVC0kIaJGk2h20378GU8B5plqTI0Zjh9GJgY+w
         AnBqbUklin9G1AymeoNTuCRc8HfPqB/ZZzJi0SKtRBDtnxYxM+VnSnzpF/4a8jBEn0qG
         pyX+WFUBWvHNDbpQi57Ya+O1a+dY0y7+ttD5cZ5tcIsw7eN6sBUQY8l9bocd2gVRhOY0
         cZ0U0hdKTKoPY0REvCOdcZCrF2MolTeHqdsd3SCIRJdnUK1uV8YGBwFGHnmkXlmeOKa9
         gtgNXEVfe8Zi1rwRT2L6sknYC05Oy8iJ3W4nvhhgcl1ZS7ywrXKmcoDd1v79P5mmTwsA
         gjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707844912; x=1708449712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djTXGNbZuGqyKuTSQbKwVEYJtS4pdpJJAwqttgQi+h8=;
        b=lnx+qB5HpjnDbhHhVIhbTd5JT0LJdgomoqQ/+SgdPo8um+NXnyYYD+5DRyxlxJ0h5N
         XpQOi3z4dToo1iK43ZCcXQZuDpNaS64IzfthuR02hOmvefl3SKEgsoJCoj2FJa8m36XM
         jr5ZVDfUcDK58ebFO+bw/2w59OM1eYT9tB0JK8LzFScvId+RJJwyYGS1Ehxk3NasagDB
         SQeakJQ9oRMjAhdN+mul+VHwNn7jPqKsb0edeP2e6aVqclvMl5zo+WICNF3OY6XJSZaG
         MIpIdvnAVDvTqqocQosL8eJynwPLDjNKEanHT4ZNjvt5dChEQbzvOloD/Rf0tdi311/U
         J0jw==
X-Forwarded-Encrypted: i=1; AJvYcCU3DdjySIUC6INrYMM1voqj5wDiTzWUaEsWKuJosCIKIWfG6kjWLmSGDKATo/lfhv0hEFkJJarz030ngLkZMXBejRxq
X-Gm-Message-State: AOJu0Yw95Mx11HCZ5TqlrtprLuc/gYSIEIma7F7syYbZXNbPxtje6v8s
	G1elKRJ+kj0PH00sa3DOiF+P2Fudx/2KtB8agK7CQDKXysXha+5V6NeM6NZuS0LWXMim5JC1DJQ
	/VZS6AmuqpkUjjy2mk5wt+mCI09h1z/wca2s=
X-Google-Smtp-Source: AGHT+IGwFG1vbDe9RkXr5UDjy0BRscYDa19rV+OYmCf3pMdV31+7JUR/9OzJYPeR588RGM6V9ruuZtmz7XwGlBRVZy0=
X-Received: by 2002:ac2:4554:0:b0:511:86ce:3913 with SMTP id
 j20-20020ac24554000000b0051186ce3913mr134134lfm.8.1707844911687; Tue, 13 Feb
 2024 09:21:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
 <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com> <11f854399db2b0da5d82cad910c3b86ca9c2e0db.1707196348.git.gitgitgadget@gmail.com>
 <CAP8UFD3wMD5SmfpP20jST4YndBdPX9U9qAbKh=4TnUzLkpULRA@mail.gmail.com> <owlyttmcb8ge.fsf@fine.c.googlers.com>
In-Reply-To: <owlyttmcb8ge.fsf@fine.c.googlers.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 13 Feb 2024 18:21:39 +0100
Message-ID: <CAP8UFD3Mx8TT0vZgNNAVBw1L3QBbRtbRL_mR1KGe6FNK77oMeg@mail.gmail.com>
Subject: Re: [PATCH v4 14/28] format_trailer_info(): teach it about opts->trim_empty
To: Linus Arver <linusa@google.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Christian Couder <chriscool@tuxfamily.org>, Junio C Hamano <gitster@pobox.com>, 
	Emily Shaffer <nasamuffin@google.com>, Josh Steadmon <steadmon@google.com>, 
	"Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 6:05=E2=80=AFPM Linus Arver <linusa@google.com> wro=
te:
> Christian Couder <christian.couder@gmail.com> writes:

> >>  static struct trailer_item *trailer_from_arg(struct arg_item *arg_tok=
)
> >>  {
> >>         struct trailer_item *new_item =3D xcalloc(1, sizeof(*new_item)=
);
> >> @@ -1101,6 +1087,15 @@ void format_trailer_info(const struct process_t=
railer_options *opts,
> >>                         strbuf_addstr(&tok, item->token);
> >>                         strbuf_addstr(&val, item->value);
> >>
> >> +                       /*
> >> +                        * Skip key/value pairs where the value was em=
pty. This
> >> +                        * can happen from trailers specified without =
a
> >> +                        * separator, like `--trailer "Reviewed-by"` (=
no
> >> +                        * corresponding value).
> >> +                        */
> >> +                       if (opts->trim_empty && !strlen(item->value))
> >> +                               continue;
> >> +
> >
> > Wasn't it possible to make this change in format_trailer_info() before
> > using format_trailer_info() to replace format_trailers()?
>
> It was certainly possible, but the choice to purposely time the
> addition/deletion of code like this was deliberate (see my comment
> above).

I would have thought that it would be better to make this change
earlier to avoid breaking tests.

> >>                         if (!opts->filter || opts->filter(&tok, opts->=
filter_data)) {
> >>                                 if (opts->separator && out->len !=3D o=
riglen)
> >>                                         strbuf_addbuf(out, opts->separ=
ator);
