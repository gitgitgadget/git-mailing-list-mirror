Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D4913BACE
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 11:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673089; cv=none; b=IbS1xqSs1VIvL17DbUTndArz3A6dyfvrPLMCAU5juOQbTf+36a0v3x1lRccsicO0A7K6Cd/t6yo+2aUNDJqTadhejEQmhtYGetDJHz4UzVnRd0LygleyOgy9SmATTDf94bHd1o/YgiDTnfj/UQvAAt1QeYnv5IDFA0/kuATCkqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673089; c=relaxed/simple;
	bh=OjXgmO3xe2LW8YCuEx8IMJewywvsxl8lEs+BSeLzOpE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=NZlqa+0LBz7CQPcp50vtsX7pVmZVM4o9OQtOPDBhGQ4tO9uT6kaFj1DOAJ0YR2wY2vcxQmwrJ7LhkUB4VCBDkJmh8JPf8vcv+gyZFOX4+034sszDalc8/l3nXToLV3JkCin7wpDrRoSAI4P+KstytdJ0w0SSkee6Qgy8EMIjq7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIsNyYTG; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIsNyYTG"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7c3e1081804so2433181a12.3
        for <git@vger.kernel.org>; Mon, 26 Aug 2024 04:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724673087; x=1725277887; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OjXgmO3xe2LW8YCuEx8IMJewywvsxl8lEs+BSeLzOpE=;
        b=UIsNyYTG5DQg2z3N1m/1tpOqgGjOuHJUR61PDVgIIWYbkfjGVcFdGOZh4mUCNJD1ln
         fKGhbYVqTj5x64dGVqbR0rD02r49fLMsZypH3XHn3wKP4QvFWUfDXBcuFTmbV+HJXJCc
         csh4EgwJDFMAKfGtvob4VsnMp6CfxnGFMbjSOypbXHaGzd9TudNug1VBOX2gcMU1apQz
         HvKPedR7DR0MgQ53q9PpO5o90MFV2R7zXirniYCXJcwTYVvDsAlP6wUT1PSnyTdj5XJ4
         VwQKYLICK+G3nKcrkQrZaEK0qop+Xyv3utNC47U8CU1wyEZSDKZyuyBQo1cVj2EK/WHV
         iArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724673087; x=1725277887;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OjXgmO3xe2LW8YCuEx8IMJewywvsxl8lEs+BSeLzOpE=;
        b=jsr2bEt+8T4iW6YqnbfGOUIZsm4Z1K5oyj0LC3jEMQjFoGnK4Z/bAYNSVyP6K6aWFj
         xngm+OR+ql4L9I4E8MW8NO5a010wW1gkvrtqEU0YdtHLR2yVGR2uHPw/uzWBUyAsJNd9
         vljWgO73LmFdXFMcsHh2aZVRoxoqsdhA5DgyiLEEBsuLfLFjf/nKc4CM3aXiVgyJ/yLI
         5RRJrAxHhzGSiGrfSuAZ8ZgXYrAPSqp98QAmf+EAm75GCVI0CuNx+jYy79v9VLJwulTQ
         pj/pw3v/azdW8ovZqEVU1fZ16H9Vrm3hQqJnnRGh+XhfJNEyOVR19dHGQQOX85b2fsZ8
         nZ9A==
X-Gm-Message-State: AOJu0YwgoBQFauy+D8TbWgFiFDr48sI6XfcykeLrcQz1L+fxyvgpzKRp
	kUARbsIn9vAMpZUYTqQ58ekCzQcXMOZ1Csc0hf8AP2aRv83w/5PuCc5asJ1MZ+BRv9K2ARcJh77
	CaM2Ws6Fcr4MzZXAhOR0OiWUcgLDxp+lef88=
X-Google-Smtp-Source: AGHT+IETY6moRmXNYRed8De2FMrbE754gG0yHCz63J/7RZl6FInSxAb6SMvP6E0BJGNEmrw/FtIWCtPRm4onLtTXXi8=
X-Received: by 2002:a17:90b:3549:b0:2c9:58dd:e01d with SMTP id
 98e67ed59e1d1-2d646bc6dafmr8686222a91.14.1724673086904; Mon, 26 Aug 2024
 04:51:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Shubham Kanodia <shubhamsizzles@gmail.com>
Date: Mon, 26 Aug 2024 17:20:50 +0530
Message-ID: <CAG=Um+1wTbXn_RN+LOCrpZpSNR_QF582PszxNyhz5anVHtBp+w@mail.gmail.com>
Subject: Improvement: `git-maintenance` to allow configuring of remotes to fetch
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

`git-maintenance` aims to improve the health & performance of
especially large git repositories.
A part of git maintenance tasks is `prefetch`.

However, at the moment, it prefetches all objects from all branches =E2=80=
=94

> The prefetch task updates the object directory with the latest objects fr=
om all registered remotes.

This seems non-optimal for repositories where users use the main
repository to fork branches (instead of personal forks) as the remote
could have thousands of refs and objects from branches that a user may
not care about, leading to a very large prefetch dir.

For large repositories, it might instead be helpful to only fetch
objects on `main` or `master` because those are the ones most likely
to be used by users.

To this effect, git maintenance should perhaps expose a
maintenance.prefetch.refs setting that subsets prefetching only to
certain references.

Is this something that has been raised before / is in works by any
chance or something that would be an acceptable contribution?

--=20
Regards,
Shubham Kanodia
