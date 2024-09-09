Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2678178CDE
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725891008; cv=none; b=HEbQUjqTYI7HIvFhJ+6dadc6t7VknL2am9jI89YAKoDyhh9sSkHQP3NkoXUtXGV/YFA7WId3R+8PJRP5SbbbGrQSU6gdkSRCemu1R7BAbm1mCRcp+0ZDM6uQY0pnc+bJKj8qyb5axyrk/CQVVkPRfa2m1E9QL+R3hYhuUfHTTlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725891008; c=relaxed/simple;
	bh=VeBGziamomMNZLeL7UepS9O+VD4QR8XgNwaSPoceDbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g0Ri1lNn+Iz4PYir5Vi3pET/EGgxp2Feo96NFLSV/HTe4ryr72NzpXuIJVZRvixtBt1rcbJ/hinT7MvbvjYXg5uDUWEeb18gUeOl7bZiKgA7ONpMo1mRfGcsK32dlRS27u6fylfl3Xs7RT02Gs6P1RTJyjdjI/489ya3h2Ldjvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pz+gB4K3; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pz+gB4K3"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6d9f0cf5ae3so50093927b3.0
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 07:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725891005; x=1726495805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VeBGziamomMNZLeL7UepS9O+VD4QR8XgNwaSPoceDbs=;
        b=Pz+gB4K3joiaXnYJC/P3su+rKjxClntdK7od0RBfJPEQnbyrlfkocvdSMuFuoNY4r5
         aEK/2olXZzukFqXAChjeMHfFHXrFVsurwuYrHsbhDfFYKTndJbmyXVlhZSgQazGo2uQj
         fCEe0bpNJb7VLZ/opPa42wHwb2ycwPG2Zp7LAir2PbsIpS4mN7jLWxWMeTBAEkTAssHH
         K0xSlIkBHhV8dpIoFhP1HGJDsvRKNhgbkMuKFlzUOI201ZIJTXvRx8pnFqvLuFtT2yQA
         WFjgz+AP31/xSsfNVGIi3BWkUqtkaitEGYft4/6XsQwSN0k1pbR66aL8uDfFe1GIVA7v
         R7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725891006; x=1726495806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VeBGziamomMNZLeL7UepS9O+VD4QR8XgNwaSPoceDbs=;
        b=Qjei2Xaa93SgO4NMunkg44GBgnOCZAWHxHVHyp2CkzFsYt6lcX142+Uhgg6t3newHb
         gY20MbZ8LFWE2khGJjf4x4KYd9evMumImKeKp45MvCRi31fa0VLtfkYnqz7tog2oiOpY
         2EEglr7SYaYEIntOVp76MV713KkUcVhHdxwAs7TQsWEiSsONcO0og6hK5uHDGaS1z85/
         rFdllv2RN3Kj+EJVyEXeEYsq7KFiGvC3433Xo8iumroyRIPPQkegOSgWNGbHMej6kJ9V
         ji0JhvYFiBadGurlcOl9NYhmglE1htmOGtPX+O4tZyeKzUEaXoHvwYJDfxqHTIFfBOIH
         Gi8g==
X-Gm-Message-State: AOJu0Yz3SRiXnSft7augrH9vF2E8tbXum7P6D0g7TEVExp4UsX6fBRQk
	Ygw93q+a06GYIgzG7OGBZyYuxGZpXmk02t00sXT4uNPmvBKpxV42ks7u3SRO2Wj8aeKBNeXtCFh
	TAYxAj6S5sdGpWcP4eVDVYJl4IQg=
X-Google-Smtp-Source: AGHT+IG6cU0HO33catsT3H1V7r4KneiScZC6fUM9VTWIjQH8vnlmr9OJ8Kk/npABe9kNHC1XHTe3YX3lYpFRx/bXlQ4=
X-Received: by 2002:a05:690c:94:b0:664:c541:60e5 with SMTP id
 00721157ae682-6db4516b018mr119498057b3.36.1725891005428; Mon, 09 Sep 2024
 07:10:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906044222.4881-1-alexhenrie24@gmail.com> <xmqqwmjov772.fsf@gitster.g>
In-Reply-To: <xmqqwmjov772.fsf@gitster.g>
From: Alex Henrie <alexhenrie24@gmail.com>
Date: Mon, 9 Sep 2024 08:10:06 -0600
Message-ID: <CAMMLpeREE8VCUzdta6oFrHqT=ctOPYxKBBJ1=6j0QpbAMgrhGA@mail.gmail.com>
Subject: Re: [PATCH] apply: support --ours, --theirs, and --union for
 three-way merges
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, bert.wesarg@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 2:49=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:

> An unrelated #leftoverbits tangent.
>
> We probably should teach add "union" as a valid choice in
> .recursive_variant in merge-recursive.c:parse_merge_opt(), together
> with "ours" and "theirs" that are already supported.

I agree, that would be really nice, and it would simplify the tests
for `git apply -3 --union`.

The other changes you requested are done in v2. Thanks for the feedback!

-Alex
