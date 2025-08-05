Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F154A1F541E
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 19:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754421537; cv=none; b=WGiYIheIF+NG9Rj7LmJhsiQc/yIv6yCcO4o+PiMGF2SVIzjui3YVFmGY8jF3qsiYk3/yWYGx4rJcTSfRa1NKGQG3SFmZCLrAYRIRCwv6lqdeqnlg5hVOXlDembTb1siAezt284K3/Y1ImnB2Z6nfDWuKds5d5vCP0JPAyC+OEtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754421537; c=relaxed/simple;
	bh=y4AAAiPXov3+D0B+PqELCh3tDkRNMrFGO1vVrCShhuI=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=IKFpdIlH6e9ICcmg45BhfygWZmmn72wm8/BcLIf3v2EwZoIUkAJDviH/3YLPIhvRjmJQwPYJbXsqRCoZF9J9FHB2m7FoJB/SJRwDA/0avLxlnXcY3WHJOzqXhZgSEaycdzYHF7Y/Df2bFZnNaN5lry0mbHkIN9GyiYGFezxb5Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5AYbI5a; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5AYbI5a"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e8fe4942e68so3069050276.2
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 12:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754421535; x=1755026335; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gV+v9JMHHVImAp69YJ2b8fWivVYdHXw7Z4m9O40zkeM=;
        b=R5AYbI5atJJht7Qzq7BNPmJK60GN0O3UArUoVj9lzpWp+PUOj450XiFuVRwJ1hUWLb
         xrq+gM4LGzNB9ePM+KBGQk0gpSCQ/wR7k+RyPVOBxGXFv2E+irlFKhI8bzCObL1sjZd0
         OySVdgbui3rinTzK7FA/yPZDfWrez4j9P061Ywzj8qUFIBaEDrA5JcwfHAPQU7msMPW0
         jUSEKjR0mg0hPk0SzG9pygAlxy4TEYlXXFPy95sqiBgVaExazXer4BVrA6kuVY9+FDwc
         WS+bduL1xX+eghbOj1g3AOiSoiLV9NaKXNvfnvl1ACbiw0xf9UuiRQTzW0ng80Ccfnlg
         BpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754421535; x=1755026335;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gV+v9JMHHVImAp69YJ2b8fWivVYdHXw7Z4m9O40zkeM=;
        b=FAWUd7fCEk/kHH7eVrZcVLt/KhdsLC05rAoZiZ5PxkrI19/F6+Arze8JrI4V7YxM3W
         W6EDOyr8kWmtOQIKKJYldTfOg32pY5fOsqIr5tk8Vk5eR5eC8a8Sw/Y9y7zevP2IjQsO
         IftHXlCvDBNwZe0GfTR3qeZHHRmoH+ofS1Dijcajx7HNpkFj5uwnTnqGJQyh7RUjrioX
         OJntBoHhY365sZlItd86oyF6PR/xcmqUDJNHfjj7mRQe9FUpDxug0vp3SS6TTKQKwtjY
         YgPTYhA4BFyjySyrxmWGD3ozzsYBLX2XfcG3gvP1WbQIE7VuOzqe89ErjttD1SBhCCjp
         2OCg==
X-Gm-Message-State: AOJu0Yx3AOn691Uk4ugCjiF8RSI1Uj3RrLa9t/TzwGMrTyR63bM5Q00r
	aY3bajFjUKGKJtzwXiqbXAoC4MZKcUAxnYyZVMzUq5HUoNfJCAmX7+lj
X-Gm-Gg: ASbGncs9/oJQzWMaAATZZ52sfXfOuqGHjEIei0lC+Gi2mwm04nVZPkTJ1e5IYI1WPzH
	spWMIfg/4rocg/koT5Y194lkVJQujgLmypO9ZlBE++cCdfUHdqA8dn35+hw3sV9Nd+s8C4oG6sh
	9VDJAb+5+OXdwkeQZ+jzJpzu4ArYM1DL6yQ2OGqGMJs//T75TW9oK8RkxPGNbKzWdRi7nhPRu7m
	U1UgmIBJPWQ4hC1IL8eWOxnsG80JZ1qyP4qeoUwItOARwIxKLByd9wvbByNoJtDz+pELZ/9P2C6
	dy3JMc0UTC8DDFjvEsOM/mdR7Fg1gymbts+GVswowFZuyPO4YeX09mFztCN/QNBnQPktilBAvvN
	2XTPGBNjXIfUh0ClfgsH4giQ5FlWUD+P5AGjuztcpx0lPiz2uYMI=
X-Google-Smtp-Source: AGHT+IEe1sbg+aHdRHFrYt9lFBEwDU7WxfdensE1DraH+fE6LiYWKjzz0ojMZpKYEDTdVsb3Igk8Zg==
X-Received: by 2002:a05:6902:3382:b0:e8e:a59:898c with SMTP id 3f1490d57ef6-e9028831487mr456813276.6.1754421534620;
        Tue, 05 Aug 2025 12:18:54 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:81fd:b609:9cb0:d77c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8ff21f0793sm2940610276.38.2025.08.05.12.18.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 12:18:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: What's cooking in git.git (Aug 2025, #01; Sun, 3)
Date: Tue, 5 Aug 2025 15:18:43 -0400
Message-Id: <7923AA49-A1E9-4E56-9397-0443481B97B8@gmail.com>
References: <xmqqectpziz9.fsf@gitster.g>
Cc: git@vger.kernel.org, Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <xmqqectpziz9.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (21F90)


> Le 5 ao=C3=BBt 2025 =C3=A0 15:06, Junio C Hamano <gitster@pobox.com> a =C3=
=A9crit :
>=20
> =EF=BB=BF"D. Ben Knoble" <ben.knoble@gmail.com> writes:
>=20
>> With apologies for the mail noise, but I can't seem to reproduce any
>> failures here on 371c45b569 (Merge branch 'dk/help-all' into seen,
>> 2025-08-04), which is the latest seen I can find.
>=20
> When I report a public CI failure, I'd try to give an exact URL, but
> otherwise the failure would have been seen in my local environment,
> and because I tend to refrain from pushing out a know-to-be-broken
> tree, it is unsurprising if 371c45b569 did not fail.
>=20
> That commit does not have lo/repo-info, I suspect.  I didn't know
> exactly which topic was causing, but the error was observed when
> "repo --help-all" was given, so perhaps some interactions between
> these two topics.

I did also try a merge between 371c=E2=80=A6 and lo/repo-info with similar s=
uccess. :/

If you happen to find such a faulty tree again, would you consider publishin=
g a broken branch I can fetch?=
