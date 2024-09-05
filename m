Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C83115532A
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 22:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725574674; cv=none; b=dlsw163qJ+vsFsyzQIVc181FerFvSyaNYfGMP9vQshp9PVROhIUdX02lymleSXEUOQUUgSnjMWGzMR8ZdsHZMWsD6QfO2/xZgUvAUyLUM5ViJPiOduEibG6lhO6gUnLBYDQKGXB6T+q+YM5Z9qGMWM6YqntcfR9sfmXRxYjNou8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725574674; c=relaxed/simple;
	bh=V2YpUTDYRBaNtr4qD3p6lXwav46Gg2hssMw+3C2dxF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMg6bb1Jn6q35vazC4zSYqo6LIV5rh3HeE2bpoTlf1gwWTROp7PIu8Liu5qGtYZQvaQbAEoYdAT8TJYedqHRBopSxG2HLI2LIx1hwtKvn+t54DIlwP0klMd7O5diMYkK9EZnlA7FmaDFEDd8AeAacZOa2loq+yHm3Wxackw1shI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8jJBS0U; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8jJBS0U"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c27067b81aso1521691a12.0
        for <git@vger.kernel.org>; Thu, 05 Sep 2024 15:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725574672; x=1726179472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbfRDyMNVTgvRt256a4tEbb6F4ownz7J9gG29IaJiDQ=;
        b=I8jJBS0UNO4g8XQXXVBlvi8eKxUyRztDevKIO7rOojHgroG9Gi5ctwjS2XjpGOD3Xq
         ZqOlcfmYY0yJbxtiO46kiy3EpRIEX1dwqZEnV9NfzKvU4DVxV+UW8gwekoWluLHuiHs3
         ZQRbt0qe0ZTOPdMzqcQUmhIZcIGw2ERmVNg8CtxUV35wOCx8e3U0P9VmhI6uCgNqaLPb
         N0GhoiTvuYGPGz/u+YSsUa+k49BaqMcLGzfpHrDoh8APMa8DA6cYaIh3aDBPd6tWu11u
         Vs834/BEbu8cjpE87Li6A4VriY8PzM+0F/cxpUo+jM54eSoC3Eisx4FlIW//nzTkWSEA
         6ZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725574672; x=1726179472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LbfRDyMNVTgvRt256a4tEbb6F4ownz7J9gG29IaJiDQ=;
        b=IIeWyDLKTpqoCQt4Amffl8muQPSu49veAEz8UDy4vIn8VSM1YCJ8ihhJ46n86Y286O
         dXZagflxiIyKn9IFNOHGv/VnuDJYUONG9+tJzhHs/eAQ1egg46V3uOpBZg9xhE8Gcm9x
         j/GI15dkecsBXG64RyR9ncTDlIbY5gSin95CA7S+XUF7qCSifSKL0Wuv8p2R4H3zV9uf
         S3HC3QtOQz9oFQhQtTXVLJGIvbvgMrKFM3YC3llM17T+6ADAfkvS9NzA/GhYOZiOlyqB
         5igaPj/KyOreEqi6POWbNWy+a28A1OiHzc7FpZQgPhcprxZp7aRLFFqqi99I9vEXqeVd
         4M/A==
X-Gm-Message-State: AOJu0YxxX8GzdWfxMabjLXbdEM/pwu7BW6kANvjxnV6aah7F+lfla/IJ
	M8R2lUzFVndoR+SViZOKZMGm7iqu4cKumH1cs62zAGdO9wGKMzqr5iwqOJilTmSDlVpX4Ei+sIU
	pskzxSE7kI+rYqbQkaGvF2vCj7po=
X-Google-Smtp-Source: AGHT+IFI1BMuWaNU1x0HmWvLN/WvtOAIss3ZV00h01Lt0mFvY5zb1Iv/OpfUYqdtSeqO60ps1p0xZluUhpEFXF111GM=
X-Received: by 2002:a17:907:2d22:b0:a86:8230:ebae with SMTP id
 a640c23a62f3a-a897fad73demr1907712766b.65.1725574671397; Thu, 05 Sep 2024
 15:17:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANrWfmSMbR+8oGsCzOygBA0sFSmMwUmCy=qQEsa16RWcztYaQA@mail.gmail.com>
 <xmqqplpi5em7.fsf@gitster.g>
In-Reply-To: <xmqqplpi5em7.fsf@gitster.g>
From: Han Jiang <jhcarl0814@gmail.com>
Date: Fri, 6 Sep 2024 10:17:39 +1200
Message-ID: <CANrWfmRmELO3ZxOZs2i5LvekK+fe3N2zfMebJosmzvkkdrG+AQ@mail.gmail.com>
Subject: Re: `git log FETCH_HEAD` only logs whatever happens to be the first
 among the fetched refs (instead of all the fetched refs)
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Got it, Thanks! I clearly remembered that "using first line" stuff was
mentioned in the documentation/progit, but can only find the `git
merge` part now. False memory=F0=9F=98=B0.

On Fri, Sep 6, 2024 at 3:01=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> This is totally expected.  FETCH_HEAD is only special to "git
> merge".  When FETCH_HEAD is used as if it were a ref, everybody else
> uses only the first entry.
>
