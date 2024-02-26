Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCEB5CDF5
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 10:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708942409; cv=none; b=nQtqtg4eO/gCQF5oO/vu59bCqssBhWNE2CJ7mGq/KScPLAanyDpvLcMlHmClw+adRBr6g8fcKwgfP6ihgZ9n0vXlZOPv/1X7zQS94WVV+3xS+cL0KY4IaURzdQW9lA4bYD16skdM9Dl6Gz8iz2wQiQxWqQBMN6Yk0XLWZDz5HiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708942409; c=relaxed/simple;
	bh=h+E3U9FxQHGn7EbtzRFic1ybgF5UhcJ/LJctZkNcgI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IhTFGBztB64wMmdvuTvpYClVldyvAVJMgmGn1Hq9dPBtF8LGDjDK4+PFONlQP3Pq9Tw2dscn68/FykzzwuNOdF/wOvJlEHm/p502tFHakz2fmhEFh11ntI6I6Bq1U3SXrsOC32f4QVEyR7/7a/2ZDcpFpKQFAutqox+B4yMAavo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7FQ2slr; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7FQ2slr"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d24a727f78so41017281fa.0
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 02:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708942406; x=1709547206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+E3U9FxQHGn7EbtzRFic1ybgF5UhcJ/LJctZkNcgI4=;
        b=N7FQ2slrkn9TO61CF5Vb2BuvXChyFUdjl6guyoDqj38Z7eHlfDtmuSsEMx3QCHdpdt
         zsl2Yd58x9+w2dNOJ2kUkJ1en5sjy6iJwkei8V0RYk/9B1AdPXWjz/XJZ8lC/3w5JC9q
         U71su+T2MbmYnj2oh+h//lQlSGJgB+F0joIxHOiNg7PRkKApO3kFD3SyO6aMohwqO1bf
         dbJkJH6iQzZzj9fHVVO8H3GsWrs54PWaBB++NJMRNtyyFPOLXF+7sSL26W6NfPwrNsJ1
         dCg4j/68qqDPv5axILoyWS28mC0HQzuUtW6RPegxuzE+EsjZ5VbvssgSSZU3wSl3KqlW
         tt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708942406; x=1709547206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+E3U9FxQHGn7EbtzRFic1ybgF5UhcJ/LJctZkNcgI4=;
        b=HV0jh3m0qBFv5aVZJd+wRC3IQg5NdBIpw4M3gI4PgtMvtX5W0PERieqxRaBj79k5P2
         m4Z6E2OdSFHydYXXJoP8xn3m5fDcZfwq+8o7szrT5ER9v32ou1vR25l04Br4igRFQOme
         Gr0aVT/Cu1tILlrCrPlgyoDNDE4dEm9dnRTa6MLI4c1q6cKldKRw9crU3wM7QEptVo4M
         Yx2qKOE4mSeDcnPM5KqS/v/EqaviJQaNXzPf6WSEhAhW2+SL4rjbjzmgbdkTTcU3xV3T
         yi7sIFTVWHizy46mdhEDNQ4RC7SAVtVQelvn8c40Ey5WHlYIbNEkNuN9Q+sO3dz3oLpC
         H2sQ==
X-Gm-Message-State: AOJu0Yx6Am+mmUEkFu2GSR3bYhpRkNzi969CF3SgrEO3doQoiRdhCOFm
	79IHB9kCshBfw+NoaV2vS0UCW3N0VUicaLpoLbULi6jK2xiaf6xuetyEwqMuV4Lh8y0QtI2JWu+
	WOI3Eur1X1E4E5cPveXgmlw2bucctneudBzA=
X-Google-Smtp-Source: AGHT+IEpe/TcLgHPDzlWhoXwAIpvFe/m0cXl16qV29g/YndT53lVcMOhZKdnCg/KQsQ7ySa9K2VTTyLerNQ97VU4hCQ=
X-Received: by 2002:ac2:46c4:0:b0:512:fcc2:16b3 with SMTP id
 p4-20020ac246c4000000b00512fcc216b3mr1707318lfo.31.1708942405643; Mon, 26 Feb
 2024 02:13:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219172214.7644-1-vincenzo.mezzela@gmail.com> <20240219172214.7644-2-vincenzo.mezzela@gmail.com>
In-Reply-To: <20240219172214.7644-2-vincenzo.mezzela@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 26 Feb 2024 11:13:13 +0100
Message-ID: <CAP8UFD3153ZMEeEU3yPdBQZMzJxqgtX5YdxKwWfnVVwZKqHn-Q@mail.gmail.com>
Subject: Re: [GSOC][RFC PATCH 1/1] t: t7301-clean-interactive: Use test_path_is_(missing|file)
To: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

About the subject, instead of "t: t7301-clean-interactive: Use ...",
something like "t7301-clean-interactive: use ..." or "t7301: use ..."
would be better. First because there is no need for both "t:" and
"t7301-clean-interactive:" for the "area" part of the subject. Only
one "area" part is enough. Second because the first word after the
"area" part should not be capitalized. See:
https://git-scm.com/docs/SubmittingPatches/#summary-section

On Mon, Feb 19, 2024 at 6:22=E2=80=AFPM Vincenzo Mezzela
<vincenzo.mezzela@gmail.com> wrote:
>
> Replace test -(f|e) with the appropriate helper functions provided by
> test-lib-functions.sh

I think your commit message should explain why it's better to use
test_path_is_(missing|file) instead of test -(f|e).

Also replacing `test ! -f` with `test_path_is_missing` might be wrong
if it's Ok to have a directory instead of a file (in which case the
latter would fail while the former would work). So a few words about
why it's Ok to do it here would be nice.

Thanks!
