Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BC0258EDB
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 10:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089122; cv=none; b=SUDmbZ2O5oiLhoGUzJEBvTjELpZeUb9wjx8HFZCfwl8r9sulao92CP1vR2M7KWGoQ6crmDmXrcCcZVjhbBZPMKrxlGZ+a35xola1gdlXVKBoXawMhzS/WdJthu8s1jtE75btuQqMMJ0eXkYPxujvfE8Uf14h51mllbdtZ1nklHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089122; c=relaxed/simple;
	bh=d1A7qnmTv/Dltnk4iAHIYp4x/Cn1lE7sHDKoOMmYYmQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=q3nWYZwlNDpAdLiTQipvR+TiS7nD2Vgh05rMb6/jRkS8PFEtrjkfITP5YWCFC0v57cjvURHWH4pC43HWYeZpgN8VGUgDxG77InfSi5G2wS8hkb4AxZSLCz7Y+hBH1lC5JZeVXH27h0UuwpjOkHGidJ7tNgjA/v7FB0Y3Q1vPcKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJ9lKwQ9; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJ9lKwQ9"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64b5ed53d0aso14106176a12.3
        for <git@vger.kernel.org>; Tue, 30 Dec 2025 02:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767089118; x=1767693918; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=02yNPzHlbT6Z/P5BkvrqNRe9DPus2ZUy3C3ij/dIC5M=;
        b=EJ9lKwQ9BKnos0BIV5zGbudO/OkVmQxsWUzGVqJ16G9bNo/CdQKoTl2t37ZD0yJDbO
         wj1URkcmgdx0KxSFT1JicPYPrMYNueQ9m4xVdmtOmu6RfAvehPHrTz0mfanfWMwDyHQ+
         8KAZZ6PNScyyu7Nm4ZFoCj2tCdFGDf68+PhbTO9a7P4Ep3+rkV480Ored6dOhuWNeDd5
         YCd5m+bhImtunB01ex0Lm8AME8V7GNks5rT6RG5zG/zPCinrgQC9IVL2nCjl1O4iGGV0
         r2dd8CLlnq52Pce+hVq5sOBicxgnblYwzUaNGocbf8HAxLP9I4p8uhC5ke9tM8ELtdx6
         HnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767089118; x=1767693918;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=02yNPzHlbT6Z/P5BkvrqNRe9DPus2ZUy3C3ij/dIC5M=;
        b=ttd7hKS+3YepvCDUXaIjPAdZWfsHOPIR/bWpq+iDd5lg76CxXtUS8OOo4OHuIk4Z5Q
         ygTO4id1zEgHps+bFdjFs3ifvmjQAyloscNWzSDMzpk77DAHGorzU8MHP8+eL/Lq6SAN
         mNPS7PkLq8NYL265KPTGflwTMx8G+/8WcBPjYODqOxR5kpK9Tj0CumrBWIrSdBxTmjLC
         QgQmPlsArN/G7Rm1Gsi9I27VokreTcXvMup9p/nPfhxSBQx6tuC/O+vaA3Gelgk7FKa8
         lo3hSXwISEUt2k6GhClkMDbRY40KKuGe7dX3XtBdPUa+g529rwsQDBBLEiRq608kzgF5
         yTzw==
X-Gm-Message-State: AOJu0YwpdDlU8ifSY6RDykUdLWvTYNIHlsxScXrDUk3oyi35pmL2o5Kr
	4lfI1JpMnrR0pgR/k2SgPrFr9vl5V6+zgtomKQMjCSoBcQbnlvHil5bXRX8Gy7tBQDvGiqpqJUd
	alMHJc0BViv8ltsJT6YcNpi/sinlj7KedldEy
X-Gm-Gg: AY/fxX50OsQL9XopvTZiNHEcezmgrKXptuKghqZPbzdv6icVnH2WfFMXye7NnefyQML
	VVNDVT6vq6RH32BSceK7xKJfy+rA/Sos44fWdMcrhpFCVLhAg8wXwsWC6cr7Fh6bAN5lvX/+cm/
	7l0vFjxFDLxijqfmtAgZxlazyZD18KMQWLOTgCqV8YlG9MSQ/omF7Ff1mRyISCV74FqmY5nDHtT
	66lF2OBCgAJenX2JPdmDxBTqmzsPL3ODuUuHb/pnTJeQdWmYWFll7MwZnb2fmLvRy9uPGMckP8L
	SkdkYi62zlJ+z5yn2gRetxb3F+jPVIuJV9S6lE2RXnGmQv7Vil3NiDWF5EzqmR/rpSPx1vS7lDO
	j2pJXo7eNK+EX
X-Google-Smtp-Source: AGHT+IHIOnbiAcFzCaT5hGuISu4EatMyPUOVRTnvnDU6e84qSVa2+kgyo50IwDgmJ7tDTSykubhPGYJqYUD/kH/6Arg=
X-Received: by 2002:a17:907:6d0f:b0:b72:d001:7653 with SMTP id
 a640c23a62f3a-b8036f0f183mr3238229066b.19.1767089118067; Tue, 30 Dec 2025
 02:05:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 30 Dec 2025 11:05:05 +0100
X-Gm-Features: AQt7F2q4nUIoDkkuE8DTNeC8izd-MPJ4aGNEQITXfu174-3asksx4dr-9JoAGxQ
Message-ID: <CAP8UFD3Fg6x5kS31qWWRP-84NmJGpbriMh3xK8VDxt2eos9nzg@mail.gmail.com>
Subject: Draft of Git Rev News edition 130
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	karthik nayak <karthik.188@gmail.com>, Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Chris Torek <chris.torek@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Justin Tobler <jltobler@gmail.com>, 
	"Randall S. Becker" <rsbecker@nexbridge.com>, David Bohman <debohman@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-130.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/813

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on Thursday
January 1st, 2026.

Thanks,
Christian.
