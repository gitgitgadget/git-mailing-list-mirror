Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45512489890
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 22:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786573803; cv=none; b=C1Oxc4lF/vtlqBAYOkTGg2crQthK1tFCnwJ+HICt8lBnQTa35mnlqGuwcfkAfA1pZtvk2xJowjwsvQEHKmtC5C8JjrYCm59ba+ZirJ+Xl4ksIFSGijQPVkORWKo2Sj8A1cpbdcIu3bLAbrA4iB94mQMHUKJXYXEH8rYmQhtH3tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786573803; c=relaxed/simple;
	bh=bXpvtKQtibr9314onaJN/7b3BC6A5HY20A9PWuThbys=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=myEuywyJT6wTX98eOThsCD7B/uKYMwQUm/PiLDxh22qZtK2qQMgJSBa+UfFvTqkVT7+5vRXNmi7BgJNHsUtj1Hj4hrxxElvtfjYN1bvM2f+ddT55JmvtRbgQm3WT4x2IKx8/N2Sil+VlUisEj7jMPUiOZFByZMCAwu5lcxaJTb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWeSjb3p; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWeSjb3p"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92f0b5ed131so7095685a.3
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 15:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786573800; x=1787178600; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2qcoZxT6iaP9/rNcnwRe9OJqx5yebqZflQJWgSMMg08=;
        b=dWeSjb3pEDH1HY19Sp8zAoNxF1sKoJpIuHhPqoPBzbegZbIqBvUk2EUy/5PmHrsPHz
         ey/wH6sko/Lbpoce3iicsa1TMB8AzKYFAvN+QtFK+BUYb/yqAzurggz9hwGALgOYrhyR
         z4cO6x2iQVN4DSVN7s61Dq6YeAb0JHq3NsvoC3sJK6ah56nOOJvVtLGxJB5nI7gqB1rQ
         ohIBs3T1bboRCc4GxVu55rdLIAAYQpslezdBfmQgEHK5tesjhqaXbsG6+kttqipSbtSM
         1cKnfJ4ASeAiQm/3zZOOoDzc7fYxp2XwVpQuN+o11QghV7s3ZieCQ7SjPO8Dbc+LiZJN
         GC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786573800; x=1787178600;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2qcoZxT6iaP9/rNcnwRe9OJqx5yebqZflQJWgSMMg08=;
        b=K+JOJ71S6hoQO5EzSy1f1DUp9qLk4SI/q49py1fhEw4It6NGheBfVaBDW2tDWKypKF
         BTcGT3FZw1FmKB9FGbHv8JfT8ciu0w+U27PrPMhGyHHI/ICrcLHvKNsptQMGc2g0wsXf
         PwWl5HBJYixEBKAm5bIfpqhMfL3NqL6dkyQZ8v8SQqWVkcDsY46Xl519wBmIhXeq+332
         2aLGI/W0kpaWL2fHWn2CzAhSkj+vdhoQefUiHih9tgUFw6l7vKqMjkFmQwIiSrR821Q5
         iQ0d6tej9x4YEuTbxt7DYcIYab2kjbaM8qaBNIAuwD+keeMfNg7rie4WpuFaMHkmiTeu
         v8IA==
X-Gm-Message-State: AOJu0YzChF+DHg7Glalym7v04s6oGmc2RWs2Ci35WYVcYso8vZzHHUmA
	BkYiRHZo9k4Jv76dNSjdUNlddDhsH1wHr931JQ09pxk/A5i+rdVREkGM
X-Gm-Gg: AR+sD138zTL0kLKV/beTxbps+7jYdTo9sDD4tsfMa7+DwYvxrEE8cYB8LjOw7/XTcOX
	GQWoo1lAlzQ0Mt2VpbwevTRrkPx0AU6IDyquBgpyzGeH+DRWi9qBSEtb0FSlhCP0ldhkPs+D/Yf
	OHyfyD1QAlNBRGfgbI53F8cVRDa9Mvzf6Q6KGGc5C1cg0AWgzSD1v+skgrTOCKlPlnGew09CBIN
	e8eX+t+Ak4DuJdxPj5whGWtuAHCgkOEKaRv0zT6Thsaitt4cpAcC/p7hMPFvxHbtcMyDO694O3q
	v6nlK+sB7N2ake9v3I4aUfRh4UXBYeT3V9vy0xSKiqeBxOpjc71Ata82RYDLROBak0ysQcGnqWc
	DIqqym8pnlhuQtmaT4iDJiHzhG01twPROSubN3Dv9Z66FY+AlvpKZWyQbWympZgahb2NabdKHzm
	FyXFSg0STTtK0S7jBxAO+ffsqgnNei7hdBxOK6w/xoVQB3qJDCjl7mxNX+B082ZzF+4UvsloB/1
	TgwPKl+fuFP/cVJgyAvsrq8QZYhsbANs+1PYyeHhmcAqL4GJa+nfGTACx4imfT4yc6PU1z3Y/Ad
	zdclgaOw8cZV4UEUb5oMTacvxxvSkL8QTusb3tRcuXF5NqM=
X-Received: by 2002:a05:620a:6cc6:b0:92e:fc45:3472 with SMTP id af79cd13be357-936bfa79334mr158123685a.29.1786573799629;
        Wed, 12 Aug 2026 15:29:59 -0700 (PDT)
Received: from smtpclient.apple ([2600:1004:b06b:3fb:b5c6:fbf:449e:d509])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936c1b54199sm12207885a.33.2026.08.12.15.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 15:29:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] packfile: fix perf regression with many packs
Date: Wed, 12 Aug 2026 18:29:47 -0400
Message-Id: <6EA76E66-E80C-4F19-8806-FAE8294ACFB7@gmail.com>
References: <pull.2202.git.1786561870638.gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
 Johannes Schindelin <johannes.schindelin@gmx.de>
In-Reply-To: <pull.2202.git.1786561870638.gitgitgadget@gmail.com>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: iPhone Mail (23D8133)

> Le 12 ao=C3=BBt 2026 =C3=A0 15:15, Johannes Schindelin via GitGitGadget <g=
itgitgadget@gmail.com> a =C3=A9crit :
>=20
> =EF=BB=BFFrom: Johannes Schindelin <johannes.schindelin@gmx.de>
>=20
> Since 589127caa730 (packfile: move list of packs into the packfile
> store, 2025-10-30), there is a performance regression when many
> packfiles need to be loaded: `packfile_store_add_pack()` now calls
> `packfile_list_remove_internal()` to detect whether the packfile was
> _already_ in the list, if if so, move it to the end of the list. This
> function linearly scans the existing list before every insertion. Newly
> loading N packs therefore has complexity O(N=C2=B2).
>=20
> In one reported use case (https://github.com/microsoft/git/issues/970),
> N equals 37,815 and caused a slow-down of a simple `git rev-parse
> --short HEAD` (which is regularly executed as part of `GIT_PS1`) from
> 0.4s to 4.5s. In another, heavily exercised CI scenario, clone times
> increased from under 2 minutes to over half an hour.
>=20
> Let's fix this by establishing a fast path for known-new packfiles.
>=20
> The keen reader will note that there is currently only a single,
> "known-new" caller of the `packfile_list_append()` function, and wonder
> why not simply remove this check whether the packfile already exists in
> the list? Originally, when above-mentioned commit introduced that logic,
> there was a second caller in `prepare_midx()`, which would have required
> that check, but that caller was removed in 6aff1f25a046 (packfile:
> always add packfiles to MRU when adding a pack, 2025-10-30). Still, the
> function is declared in a header file, and to avoid any problems with
> in-flight or downstream callers, it is safer to extend the signature to
> be explicit whether or not to skip that check.
>=20
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>    packfile: fix perf regression with many packs
>=20
>    This issue was spotted by a Microsoft Git user with the massive amount
>    of packfiles typical of an average, long-running monorepo checkout.

As a different kind of intermediate solution, would turning on maintenance f=
or that user=E2=80=99s checkout help? (Not sure that would help CI clone tim=
es unless the server repacks, of course.)=
