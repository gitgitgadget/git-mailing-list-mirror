Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5370A2CCDB
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 03:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743479073; cv=none; b=Q4C6FzSXKlTNjGJk4zBlFLckSvsUkHmVbOy524vgOgamgYGaLp2md+yxpbYQZomR3kjS95RgZwwpTJWXMPl8sD47y4WaMN/kBLbkhQNLxzNZWx5NAUVa91NoEND755XAM5W38kHoXne+wLRHywpgRVxhElNK8af0AB6CDkbNJ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743479073; c=relaxed/simple;
	bh=2/dhV8Ntpy2398WMZd++SW0txpfa/iaN+H4TfGBzUvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=eCF9nmukDuoZSHnWI/5Qrflyn2y7suKVf3aVB+wmuX1X7A37yt2xl+wK3oDEZAcioMU4sTA37kheU3MuZlxajx89rKXe2AN0BDL89ZLfo8SBQtVxhzBed2MvghDRMMycac4pgi57YKOk3Sj4YxHvEEVBWlbr1HzuDeJx5PPdYjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3UdFco2; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3UdFco2"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30bf1d48843so44187651fa.2
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 20:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743479069; x=1744083869; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OurS7pHAzBK6OHcBxu1C1x0m+KHtHMP2fX4h2Sx//WI=;
        b=R3UdFco2g6dXOjLbDp7wc2ySHMgSLge+BZYrBxHKQVmMMKc2XJUq5xwye3k2o53iVZ
         CAtLIVOvy08VM47vEgfDhzxHp45s3C6BTOUhejvVqXa0fY4exLq3Ec5h5BUnXLshuJry
         PuObPsRqQoImwpE47pDFg9bj7Vai+dwDpKkUtg+EGJQ+COWTV1Kf0IVGoBl6rJ3Id7L1
         UBSkXeupmWjVQeSzR1pIfh6D2OL3dq6G6aNO0X25y8QEc0FJ/0mX78My8UUE/ZpdSA86
         kIFPOkjtHtgQAky2jXzEttIWrnpKDTx4nR2CiOvrm0IwLEhLq7hu/JcekGsyPW7z9g/H
         vD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743479069; x=1744083869;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OurS7pHAzBK6OHcBxu1C1x0m+KHtHMP2fX4h2Sx//WI=;
        b=CI+2vhflHefzU7YNOOj9wkJSBZCU6+GnLHA4bi0A3KnXTMi+hLafZAVIsF5nk2mAPg
         tpCDDMl7tx3C5LEipj5n+/0QHc/Aki3/mtJ/ObRJAzFpfGzTujpN12KbY3hyKbftrHxe
         QRWGbr6uztxMIl53Am0GhwQtq2Zb/neoP0Ey6Eg5z/0LquHKZ+NuLHbkvlVw/27nkQzW
         PrcTG+XIYmAnUpXIqj/SyS1k48/ei4Lipc2kdWo5EXReFUrvRjz95IFof5JZTL8WNTvd
         8MLM48+RuNciU37ZOFdyFMZWin0/WGPw//om3u96jrcwHpbscOvo9aGi96rD2z24cdm6
         psew==
X-Forwarded-Encrypted: i=1; AJvYcCW94L+JzcMTir90OwhbMVf6oIlArJLqSfpC7F7TfQWKW3ORObLMufDaBAlNGuosE4mYobo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSj4r1vtIDGw5sPuPH7Z+FTYP9BtBJEK9xqHjwP/T2WkqLYLvW
	iIp6JEHzjCgB9cRERhvSU4Fiv0vjncQKTrUa/m/DTrjqlFMyOa2RoVtcDe9omiwnt8GMBnxBFS5
	vCJRv6Sw0UwKfh7I6C5pb1YheCQQ=
X-Gm-Gg: ASbGncvrtXLZPnpd4hh57wqtOOnvWE8JMxN7ljsHnumJj9738tmU91vpR2GJEq61w22
	9oo3fXh8fR4Uo6TPupO55EBLDCtOOSOQGS/JOBTj9x+Oqm0a0r/Ey4WZmykv7Q4tGiCdaSS7CJR
	srXeTZiJL2zX3DYwpliCf6xHDtcUtczYNz7g==
X-Google-Smtp-Source: AGHT+IGFDX+zI99XfpsTiEGM0HQscm7MEWdqGF18LZ+EYNU7MQY8Q9svIjpC5ksg+LTyBvaRqN+aHbw1mHMpQVamFh4=
X-Received: by 2002:a2e:bcd0:0:b0:30b:edd8:886 with SMTP id
 38308e7fff4ca-30de023a7a4mr41686171fa.9.1743479068880; Mon, 31 Mar 2025
 20:44:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANM0SV2huiGtWMcP+eEkNBHoieeoXmy_fM7vAOwyoW4=FXw1pg@mail.gmail.com>
 <Z-s2p-ak-KpU6uaX@tapette.crustytoothpaste.net>
In-Reply-To: <Z-s2p-ak-KpU6uaX@tapette.crustytoothpaste.net>
From: Devste Devste <devstemail@gmail.com>
Date: Tue, 1 Apr 2025 05:44:17 +0200
X-Gm-Features: AQ5f1Jr6M6dYf3BcIIIhF2nSTVU_4VywxXDYFiBcEDEtF1CrzFHBR67FSQk6Pkc
Message-ID: <CANM0SV0Np+52vjoopvAJ88U3Ue0EF35iarwBpOozrBH9KbH2Uw@mail.gmail.com>
Subject: Re: --reset-author does not reset author date when used in
 post-commit hook
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Devste Devste <devstemail@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>your call to `git commit` will still invoke the
`prepare-commit-msg` (and possibly `commit-msg`) hook

Since I used --no-edit --no-verify in the example/hook, that shouldn't
be the case though?

>such as by using an alias that sets `TZ=UTC0` to commit.

Unfortunately, (at least on Windows) most tools and IDEs don't even
load a bashrc file (e.g. intellij) for their git UI, so that's not an
option (and setting the TZ as a global environment variable has
unwanted side effects, since it will set the timezone in various
applications randomly, e.g. Electron/Slack will use the TZ for some
but not for other things,...)


On Tue, 1 Apr 2025 at 02:43, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2025-03-31 at 20:19:30, Devste Devste wrote:
> > device time zone is not UTC0
> >
> > post-commit hook:
> > if [[ -n "${SKIP_POST_COMMIT+x}" ]] && [[ "$SKIP_POST_COMMIT" -eq 1 ]]
> > then
> > exit
> > fi
> >
> > TZ=UTC0 SKIP_POST_COMMIT=1 git commit --amend --reset-author --no-edit
> > --no-verify --no-post-rewrite --allow-empty --quiet
> >
> > ---
> >
> > Run:
> > git commit -m "foo"
> > git show -s --format="Commit: %h%nAuthor: %an%nAuthor Date:
> > %ad%nCommitter: %cn%nCommitter Date: %cd%nMessage: %s%n" HEAD
> >
> > Expected that both Author Date: and Committer Date: show +0000 as
> > timezone. Only committer date shows +0000, while author date shows
> > time zone of device.
> >
> > When manually running the post-commit code (TZ=UTC0 SKIP_POST_COMMIT=1
> > ...) it correctly resets the author date to +0000 too
> >
> > When manually setting the date using --date="$(date +%s) +0000"
> > instead of  --reset-author it also works correctly in post-commit
> > hook.
>
> I can reproduce this, except that I had to use `TZ=America/Toronto`
> since my system is in UTC.  A quick look at the code led me to a guess
> that ended up correct.
>
> The `git commit` code sets `GIT_AUTHOR_NAME`, `GIT_AUTHOR_EMAIL`, and
> `GIT_AUTHOR_DATE`.  The latter contains a timezone identifier.  As a
> consequence, when the hook is invoked, those values are set in the
> environment, and the subsequent `git commit` in the hook uses them.  You
> can see this by placing something like `env >/tmp/foo` in your hook and
> then reading the output.
>
> I will say that this is definitely not the intended use of the
> post-commit hook and I am very much not surprised that this doesn't work
> as you intended.  You could certainly fix it by unsetting those
> environment variables, but I'd encourage you to adopt a different
> approach, such as by using an alias that sets `TZ=UTC0` to commit.  That
> will be more likely to work in the future and will definitely be less
> brittle.
>
> For instance, your call to `git commit` will still invoke the
> `prepare-commit-msg` (and possibly `commit-msg`) hook, which might
> result in unexpected changes to your message or even a failure of the
> second commit.
> --
> brian m. carlson (they/them)
> Toronto, Ontario, CA
