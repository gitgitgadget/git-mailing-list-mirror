Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F1A12E55
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 02:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708914102; cv=none; b=Qgs0Dn2rmzA39lf/tNODxqgiEBhBZA64PhxqOe7FWPzepUgb06T97rLrGAcYg778pCa1GU8skbpdm1Lc3rfZ/ab709TQs3q3ctUjioA7Ur48mGYE+a9wg4najm8FCS50IYT8GUInOwwdPIruZCfPxzWrzB6YsV1CGM/Ud09THSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708914102; c=relaxed/simple;
	bh=yT17cjsZGtTTJJjIm8zIa0LMgor7IOmDkZWpKueEOm0=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=Xg0HGBuv8HBXWdiZLSjEBUVoI2GMh/UnATaceelEr6JpC9fESFxqkDFmKAxjT7npEG4qV/i6z+4HmjuV7F9t5r9YdWvpz24EkGzaCIq2AAIY5qfHNQN4iyaSgPrxQzLR/bNumlJa3tIJ1SLc+ESsgemz3YPt2565a9MBBbGiOK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVNtlGMN; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVNtlGMN"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-787c2e38161so103248685a.1
        for <git@vger.kernel.org>; Sun, 25 Feb 2024 18:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708914100; x=1709518900; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yT17cjsZGtTTJJjIm8zIa0LMgor7IOmDkZWpKueEOm0=;
        b=iVNtlGMNoRzju72HN6eXt6ST0tf9/MQ4MbZZ9uVklixuZgptcMD7XR+t5AjMNJXtxR
         3VLwaLv/r67MdJ9cAUIe0hy/hbx9Uy2oLZ/0WqOot1AiD+rGS5KQSASIS6zICOGN5Pgd
         2tzcC0YRiRPUgH4DsjBxOXzSuMPYqRLRGYAalgsNRzYEpymzO54CQ8HZdkor3zrKPBjh
         uiLySQbYvuB2Kie2PLGolA+SEnE6zMCIrkSVIHYDQhOlori5hA6RMfuWeoL2gk7m6iP1
         AjzBQ8dVW8vHZ2suaAxVfqx/vU0LxBUiiE/W4H1qTeVcVBndubq7N+0ov13r4nwbZiBG
         pZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708914100; x=1709518900;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yT17cjsZGtTTJJjIm8zIa0LMgor7IOmDkZWpKueEOm0=;
        b=KT5s6wPJ3gzgODUs/czBblLpiYSxRAwlsWjgYhGSYCumqDA8p7hE/lc3SAlF1rNGC2
         Blqr809+Ayd3FeMTgNYyRc/BxdIOfVa2jQmYomG7eqtcJcohzqtw/i7ybW8xKT6OofnT
         MrNDySVCb1yJDz6oTVJKd5Tvk8/sZ4lbKbKREGSejDRsZip5R9VHFfQ/v7Bz2MzNFK42
         Cg9EkxEJfTbPoMcHwphXGGbkpbaPhC/7mRVwdd+DHCK0d33azrA/c9X8/rChAD6ux5kI
         uECTlXwE5ESCozFtj6PKaVHy/vNEkH4myW7sVq/yoL0X9uVGN8Bsva4k71tiiL9Fj1U+
         S/Fg==
X-Gm-Message-State: AOJu0YwBDxaZrmILm4b2rAofsMP1u7V5sredyqSRYnaXN+U4sGAcEvFX
	TrE5PkQ4GEmK7U11/zq/Ovo7orTBhS0ZeYbnyr5bqrMJpGpupEJkw6rUxzN+
X-Google-Smtp-Source: AGHT+IEp45ndQSmqbDEWj5XNwpMUSVHNkdAO4u8xKdJXs/24+tii8Rh9iZzLyRr1DDurF/b+BvEh/w==
X-Received: by 2002:a05:620a:44:b0:787:a0f0:f14b with SMTP id t4-20020a05620a004400b00787a0f0f14bmr6897129qkt.73.1708914099781;
        Sun, 25 Feb 2024 18:21:39 -0800 (PST)
Received: from zivdesk (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id b19-20020a05620a0cd300b007872e1cc921sm1994409qkj.73.2024.02.25.18.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 18:21:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Brian Lyles" <brianmlyles@gmail.com>
To: <phillip.wood@dunelm.org.uk>
In-Reply-To: <83070e02-8e6b-43d2-819d-2272fe895c75@gmail.com>
Cc: <git@vger.kernel.org>, <newren@gmail.com>, 
	<me@ttaylorr.com>, <gitster@pobox.com>
Subject: Re: [PATCH v2 8/8] cherry-pick: add `--empty` for more robust redundant
	 commit handling
Message-ID: <17b748518feffc50.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Mon, 26 Feb 2024 02:21:38 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip

On Sun, Feb 25, 2024 at 10:57=E2=80=AFAM <phillip.wood123@gmail.com> wrote:

>> How concerned are you about the current implementation? Does it make
>> sense to you to defer this suggestion to a future series that cleans up
>> the tests to do more user-oriented checks?
>=20
> I think adding tests that follow a pattern we want to change is just=20
> storing up work for the future and makes it less likely we'll improve=20
> things because it will be more work to do so.

That's fair. I'll rework these in v3. Thanks!

--=20
Thank you,
Brian Lyles
