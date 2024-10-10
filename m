Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608421D0DCA
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 20:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728590998; cv=none; b=lJ/ZkWvUt/G1R+MwyJlKbgDENjvimso65wF74QvaXVJY9Oe3u+fhzSr3sgYH4O1ETHl1t9kJvGcBUh77GfkxJMoYCscrs4c2Juo6J3TfKiVzc5QWxTCpwQ01JHdWFVsrCaP0BmHftyl1+mUk2Uj0Fwls4AQEjguScQLhBGRv+TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728590998; c=relaxed/simple;
	bh=Z0KS9JtW6ByUuq2cxL/jcfaFuQaltWY1aq0ZPvlFRVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fuAHirSzZU5QONmjjONT79pE6AE3wCNckMz6U//qvD4ZV5woBza9suQcqbZy31EiRxUdZcvPdCngCXn3f6xBrHGrM8o3ueCEf2rrV1BEIpTo0H1z4pZD4T+woJ9Okx/CKI9w+Ey3cJXSFV2ccRpBFS+9+2iH8d9h4SlVkExRJ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LzyOYNmO; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LzyOYNmO"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53997328633so2201354e87.3
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 13:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728590994; x=1729195794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUHDGjYsoR29jrG6mzF9jpxOPGYQfUNyHj6OaYtwfYY=;
        b=LzyOYNmOK3qHDoSJLRsoyfAFHLdIbyUHl6S9UYdNahkuEJqbR6f2+kq1AEERTPgqVh
         Hjzz1kOC0eZe7GMqVqCrXbIgTeKTnGo1u6woLOg4RS5UYUHMQLIszysLWer1Op5cz74f
         Lpg3AL89VMD8dqbVuYgl0Xk4/z2jvcEPmwfydo8XPF6qW2c8p/ZeVOgiyDO0jeslvnDz
         QyZjfUp21Ks4+ca9QG8rm+D8JzVE5u1qj/Qc9vfY23oaC8z8p/Xm9lTW9yx2dt6qpL0A
         WG3IGiT+xMhznzeuSlhKQVqP18QH2lLCl+1CbC2Hey/i4Ydo+PmDiY9gMDCov4UYmkTE
         mgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728590994; x=1729195794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZUHDGjYsoR29jrG6mzF9jpxOPGYQfUNyHj6OaYtwfYY=;
        b=aSnHH77G9nw7gP/8RAQZELoCdw70fdSlYui8rOhnJ7TVHfdRuVcCrF8l+gjE7+NApQ
         pFcrBtJz4S5XY/nnxPB/sZozFo21Ro82FQvN317A4bPO2w0wY7VDoZwFZ+6Bysz+kMEL
         jY3LQhdU2SvNymlLJUeo3nP7VwNanchg2B6rWPNUgw4Z+p5er+KDP7kKojvzx+QY/5uD
         X/x9FiuuVgl5Rwdud6cKo/xk45PEm++tfpG1rtCPoGY2iwf9IDTyiBHWDbQulij8muqE
         i9Ffwe3FccFedClbKOPuPevkI5sT8MHigHoaoCaN0mcuXzA12gt9BUm+SnsHGn0gqNS6
         1qqQ==
X-Gm-Message-State: AOJu0Yxhn9Kofh/++Wx+cSs9bxMZm3YFUszIhvD/CwggAfw/1JAqLNOi
	75gbszDZSPI5JdTs41SpCKXeV/Icaa5DVbSSL3iBN3t0Qwi2Ivs8ypnWigaKYqYBVwGM6XI6e69
	qWuEOcqllj5/O9uqcpGZK3S7oSo6vqzOqrCITvquL2GtHh2fqLw==
X-Google-Smtp-Source: AGHT+IH6dk/lw0EqV+QpX/1gqDsC2mMsKGOQWOHCCv6cFay0FeQqbU8+jxdruMM4leODykK3mZ2uP5eusUCSxnHgsYM=
X-Received: by 2002:a05:6512:3a8d:b0:539:9155:e8c1 with SMTP id
 2adb3069b0e04-539da3b1e0cmr28325e87.8.1728590994166; Thu, 10 Oct 2024
 13:09:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728582927.git.karthik.188@gmail.com> <e22ffbe0f65971579809d817984766af12898127.1728582927.git.karthik.188@gmail.com>
 <CAO_smVjuseH6WJgU5CRg5kyZ7J1mgqLjrvxzapR0xB6XvQ7VdA@mail.gmail.com> <CAOLa=ZQ=-GwnCX7CP6sqmoArphQuUNbfcCje2_64k9g8yJ1PBA@mail.gmail.com>
In-Reply-To: <CAOLa=ZQ=-GwnCX7CP6sqmoArphQuUNbfcCje2_64k9g8yJ1PBA@mail.gmail.com>
From: Kyle Lippincott <spectral@google.com>
Date: Thu, 10 Oct 2024 13:09:38 -0700
Message-ID: <CAO_smVgasPSWEH3UOnGo-wvKT-nE-pYmG-L8gHPCajBthGmndg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] clang-format: change column limit to 96 characters
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com, toon@iotcl.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 12:49=E2=80=AFPM karthik nayak <karthik.188@gmail.c=
om> wrote:
>
> Kyle Lippincott <spectral@google.com> writes:
>
> > On Thu, Oct 10, 2024 at 11:00=E2=80=AFAM Karthik Nayak <karthik.188@gma=
il.com> wrote:
> >>
> >> The current value for the column limit is set to 80. While this is as
> >> expected, we often prefer readability over this strict limit. This mea=
ns
> >> it is common to find code which extends over 80 characters. So let's
> >> change the column limit to be 96 instead. This provides some slack so =
we
> >> can ensure readability takes preference over the 80 character hard
> >> limit.
> >>
> >> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> >> ---
> >>  .clang-format | 5 ++++-
> >>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/.clang-format b/.clang-format
> >> index 41969eca4b..684ab32d28 100644
> >> --- a/.clang-format
> >> +++ b/.clang-format
> >> @@ -12,7 +12,10 @@ UseTab: Always
> >>  TabWidth: 8
> >>  IndentWidth: 8
> >>  ContinuationIndentWidth: 8
> >> -ColumnLimit: 80
> >> +
> >> +# While we recommend keeping column limit to 80, we want to also prov=
ide
> >> +# some slack to maintain readability.
> >> +ColumnLimit: 96
> >>
> >>  # C Language specifics
> >>  Language: Cpp
> >> --
> >> 2.47.0
> >>
> >>
> >
> > I think this means that the next automated `clang-format` invocation
> > will un-wrap lines that were wrapped at 80 columns (not characters)
> > but fit in 96 columns. Modifying this setting and running
> > `clang-format -i *.{c,h}` produces a lot of diffs of that kind. I
> > don't think there's a way of setting a soft column limit in
> > clang-format.
>
> Ah! Good point.
>
> > Personally, I'd be fine with a higher column limit, but we'd need to
> > make a conscious change to the style guidelines for that.
>
> With this, I would say that the best choice here would be to actually
> set it to 0 like the previous version. So that we don't actually enforce
> the column limit.
>
> We could perhaps set the value here in the '.clang-format' to 0. While
> also setting 'max_line_length =3D 95' in the '.editorconfig'. That would
> mean that we don't enforce a width, but we nudge editors to wrap at 95
> characters. Here contributors would still have the power to decide the
> adequate width as needed.

One thing to be cautious of is column vs character distinctions.
Because we use tabs[^1], one character regularly has a display width
of 8 columns.

[^1]: Another personal opinion, and this is going to be very
contentious so please don't think that others agree with me on this,
because I suspect I'm in the minority: tabs are a massive mistake. The
*only* benefit we get from our current use of tabs is smaller source
files, and we get numerous headaches because of them. I could go on
about this, because I have Opinions here, but this probably isn't the
right place ;)
