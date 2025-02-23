Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8890A335BA
	for <git@vger.kernel.org>; Sun, 23 Feb 2025 10:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740306594; cv=none; b=AHO2zUxA33L0QrwsvNRHTz+tYcaQPugki88+ydVHsDc48NM80KyC9fO8+vh0yEIq6PoYo3Xr6X1Z7n34gcU5vCocLr6XV1pv38PcM50Wdc+bTYOlGuUJEq3IBytnx/tgVWs7sZ926UE4fiaTYfJf+WPuRxAnjkUs4ZIfxphe1i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740306594; c=relaxed/simple;
	bh=+3SJ1L2+gtwSbDAvmh7dLc3x7jJ95ttgzPCWeTTvNv8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=WDw/91R+xPDEWWOr3ZFpTSLS1wG72ktvOJYfnrX9ZxmpJf/zh4fDVzMypLj/wv3sTuaAVY71IdkZizghptreJ5JWPFReMO1qUX1WtWe2fZRWysbcP7jQ9G5nIK5/OPfObz47dzg/F6GNRdXi63Ab1d7DbijEaLi7NjrgyMjXn3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYWv2Obx; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYWv2Obx"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3078fb1fa28so27346381fa.3
        for <git@vger.kernel.org>; Sun, 23 Feb 2025 02:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740306590; x=1740911390; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+3SJ1L2+gtwSbDAvmh7dLc3x7jJ95ttgzPCWeTTvNv8=;
        b=mYWv2ObxgREuXOGgwtgoKWJEQcmHEJo652YLPrDW/y/zY4f64X8zTZJA80Yrpc08/J
         O9hkpRGiGN4+qdP89iDpxZ3Q3haPwzxkLJ+Dl3DIo5TdTopVxu3l57mE8iOi2FFgKv51
         uzdN0sNM7yu7liwP6vndn8ZWA9s1dvUbSwi2wmm0Y3ci7FvvIp2KAYF/y0/b42J7J0oK
         SzTsMtDQrQdCWoc8ySGC02g6rn0XmSSHCoB+mHtCfkVvpJLXT+I50c4Ze5ixgAs2XUsG
         ZJ5WM2vGESEZiGxkvUnsaoNCZWJjbBks2Bq7LZROgfEDNv+fR68aY0QXrjY7dhzaU+Ov
         soMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740306590; x=1740911390;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+3SJ1L2+gtwSbDAvmh7dLc3x7jJ95ttgzPCWeTTvNv8=;
        b=fRWqwAP78xjxvevrTcqkyyCTvp2UFYMjUcLgjxU1Ct1hMq2khQWA2I2hi7EEm0Eihd
         g2w5U5xNRXyFYG3A3aRWY7cEQDxHQEF3ctkSi8uM/muBuytq9nb8EDZHcRANXIQ375/z
         d6Rht0PGCiSVBFCokEh/rOlfZApJBHGiedkObCUHTH5me8LdKy6c6/YTyj92yJ2B/pxO
         VC14GcgXR3fonmk1Vn2Nko+T2uHS1J0T1x9m2vWPhF7cqyAEasbLQcet1eTL2UoLJ1Le
         NNhKENDH+a9xI+FQuf+NtW29e+TIRcrm/1niYAntPy1EmS1r+vaLuAjfTbOt/1vimjqa
         YuCg==
X-Gm-Message-State: AOJu0YxlyYW/VmWX4xFNAoyaYjvwDj2d87SuqawgmcE++ZX93TsIvTUW
	ZfvX3ugrXQYuC77TGYUfSoyEFAwolYP4UR6YtYp1l4++upfjNW32UotpdM2kwJa2KlbcrMrFYL1
	FnESLYNxmYSp8l3oO8OddPWva/3C7PeuEVnA=
X-Gm-Gg: ASbGnct/OszJiAQWLSwol722HwX2dmjPXv/EK6MDd0osNo8xBWN+ejomA+RF6ivh+KL
	Vny+qImSXuzcCSxWIH0fdFrDOR0XkTVRB96FHbXxlXe7D9kjwdCbVNzOasFAyI3XW+cGHVgP7sW
	3aDYTj
X-Google-Smtp-Source: AGHT+IFqciOBayOigRC1aapgtZ17zGskt1Hl/oKMvODYjiOI3Hzu12fSb5uE6r7cqqJ7VUpt4QRLoKu8hhGOUZCR5dI=
X-Received: by 2002:a2e:80d8:0:b0:307:e6a5:ed57 with SMTP id
 38308e7fff4ca-30a5b18ae3dmr27786001fa.13.1740306589342; Sun, 23 Feb 2025
 02:29:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Devste Devste <devstemail@gmail.com>
Date: Sun, 23 Feb 2025 11:29:38 +0100
X-Gm-Features: AWEUYZnm_9RQiYQV75Y5AFvqFv1B0or7PccJnxNs-9UKO5ElnRBNpULNOSuUbck
Message-ID: <CANM0SV2XOTQ2Mna1B_sX0EF0ffohcrexh1EO5d4G0=sqdmxQtA@mail.gmail.com>
Subject: Diff rename detection performance issues
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I have a merge commit that includes 2 modified (!) files:
hello/foo/stubs/example.php
hello/world.php

I want to only get the changes introduced by the merge commit and
exclude any changes in /foo/stubs/:
git diff -l0 --name-status --find-renames "$sha"^'!' -- ':!*/foo/stubs/*'

Git takes more than 4 minutes to generate this diff, since
hello/foo/stubs/example.php is a huge file.
When using --no-renames (instead of --find-renames) it's much, much faster.
And without the example.php file, the diff takes less than 1 second
instead of 4+ minutes.

Funnily enough, when I have a merge commit that contains only that 1
excluded file, it's the same behavior.

1) if there's only a single file in a commit, why does --find-renames
cause a slowdown? There's nothing that could have been renamed in that
case (probably the same for --find-copies)

2) could rename detection be "delayed" to only run/check if there are
actually additions/deletions (and possibly only check those)? If a
commit only contains modifications (unlike in a really, really 0.0001%
edge case) but no additions+deletions it's extremely unlikely that
there's a rename, so detection could be skipped altogether?
