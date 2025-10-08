Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E211DD543
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 12:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759928192; cv=none; b=LyIU5xbLIq4m4vIac+d2bOSuw/NZAKW100EzjviJZxNFzManXdVLkKgKqLbsf01QjxT44Gt4gDQdWfbSOmDUChxN24xVXCJWDvoh1LyzrRyRrB9BkFd76OQkYbXz/hCq1DLvF8pXl6Nx34rB3zX36wwS740JabseyqTrhBrDk1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759928192; c=relaxed/simple;
	bh=Qzn5sM3HCdsYXH3RQQLkt0W0Iuu/CvPjcDx9gbzTJ8w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=DJFheYM8zq1SS7zipZjtSVyA+VWcBTk3434Bf/wdS9Q1sD8ExohdM4QT5YfG/tJbtouWLfqX2tKkVYhsNjl5y3s+ihg2e9jvQs6iEYQj+QhHAn4+7ZyvisjcSzSmZWxw2+XjhBta6/u1sUO9SbU/NWTStRQurGTTA0Bbxww03pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiNkTQsW; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiNkTQsW"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6318855a83fso747812a12.2
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 05:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759928189; x=1760532989; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qzn5sM3HCdsYXH3RQQLkt0W0Iuu/CvPjcDx9gbzTJ8w=;
        b=QiNkTQsWYizkfGAndi1RLZ5tATvT4bwTur/UniRrchRY+/u4GYoUWwLv9C3wim75ce
         CimM0ZzZ4bkrIFK7xRDAM4pbWTJY5v+dZ8cN4lClOK48M0gKYHpjPXfIFI+Nxms6iNjA
         6JsbTjADdeoOe1vl5/KkA5zckPwkWC6XeTpl9NT6awz5l4RjgteAetUx/MZ/v35/JIpB
         Mevb5/PfmDDbJtoKu7xsGxoe8w4+oouyigKEQVf0RxU+2i7o5lVrjD5/nDb8txXRoDr6
         wgDm6e60pMc8O5mH5PbhzXNY4lqigNLACs1RDYR9sjL5jfxkUeIZSppXeM89IZFKpz3M
         ENag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759928189; x=1760532989;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qzn5sM3HCdsYXH3RQQLkt0W0Iuu/CvPjcDx9gbzTJ8w=;
        b=FfNBPhrV7y81LE3CzYV4fnswE1sGNHKU4pP9pKH8sb4iM5rJxv5jjB+SO69oh3r0b3
         qPAzfBPURPVX/lB8W8zQuY+GyKEpCUX3K5ATdlMKhXb7HjGOg1bvqHRrBQiXFVrg0aFH
         h+KTEV4Vi4oSA4/BkPfGnVUKAwIjjaPGIko6J4s86D00O1fTVVB/oBkaKhBrVKv/MVvF
         VzetGvD+3P1Iwj37rtMA9pF7W4eVd+OulfD5inE1JCTmdmtzIpU4G5nSNvyOfrBMDzfu
         RMcITHimqc3IKj/n7+UiZM66veeMflvxy2esGK4yPzCxR0hnokFu25PiSHduV9zGoWit
         lRWw==
X-Gm-Message-State: AOJu0YygwHTuRLDzkm54syeerLw+x0R6bLWRMB8Hg2kgG3sEPxY+i1Vv
	bhoG4QdnvTCvjwRKlBgwPtUFPMXkafDlI318RyVYnjoH0HzyqNVpZfzYGpegJYZkBrsPKss3CsZ
	vyaW7OnshoW1MegDwKQO6GiI9wpQOj/gcP44+p3o=
X-Gm-Gg: ASbGncvFBBHLoTFbttJd3gGKJZAi8xyjivI4ItAmJHd2yngWw729a/4vCPYzo4ZR7Lq
	Zzc+FH25WF/aAzDGJOHhUrOUDKLTYFq8rOgUu7Bc1lEqbK+19WGtam+/Q3JidaZ4wWR1YL/hnJj
	vbsRXvt+vPRY1zTt7FnFguLV60ifNeF99mdASGmZ4Eo5F5ldTM9nQgZvD3mSQkm1B4Juk76FX/y
	qrzXUoIOXWAMzMAUqgMqdfabNwJr70Kwg==
X-Google-Smtp-Source: AGHT+IHwTqgAXxfy8D6FN4qpQEA6hi1DfuqxdQNLRResyfolZXZBgZx1As5O3Ov12BJAx+CqcbsFstovLhY0M8c8G3w=
X-Received: by 2002:a05:6402:254f:b0:637:e4d1:aeff with SMTP id
 4fb4d7f45d1cf-639d5c3ebc3mr3451073a12.19.1759928188556; Wed, 08 Oct 2025
 05:56:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Immaculate Atim <immaculateatim56@gmail.com>
Date: Wed, 8 Oct 2025 15:56:17 +0300
X-Gm-Features: AS18NWC7pQ30qmdoKq_sson-htSq2oBHdaCJY3E9lNh6F3-ogzJQROLjU5j7d4g
Message-ID: <CAJXmEzSBzfXEarvjGzKhpvkcJr0yxucyw0DZ01ne-HfVxh7T7g@mail.gmail.com>
Subject: [Outreachy] - Introduction
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Git Community,

My name is Immaculate Atim and I=E2=80=99m an Outreachy applicant. I am so
interested in contributing to Git while working on the project,
Refactor in order to reduce Git=E2=80=99s global state. I am still going
through the project material provided on the outreachy website so I
can get started to work on my micro-project. I will let you know my
progress soon.

Looking forward to collaborating with you all.
