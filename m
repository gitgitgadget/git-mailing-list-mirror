Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAD05CB8
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 04:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745813071; cv=none; b=rsZMAO5Ur/AymkJ/DHiAUblszflSQLNbPVYbf+NL3m2WZ/zuB0xGxn1u+fbnPRmrC/ZQClwF1kyDmp0pQyq2gXEI6tkylhV1/dDTVp85fC61sKfF36N+3J/esNZsBm2QXAiSu3SkmNxxeuJqsi0D9Qf4WJOaPkB4JTj+CNr3Q+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745813071; c=relaxed/simple;
	bh=5HrsBJgKQKoZTnSTgFGo0lk5Y+ORa7VnBRrDMbCuYtk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=KJ+/GUi9yHMuTHxaumnyzx7E+4WPxdSWM+YVUfkM8y50JkcqcRp2N8kn1f26Pt3qDeWOGsdSxmTbYidQkyl3WMrWM3iZjcwsFlA6qwCvRcFYU/WQRWDLjkm/N3k8DSfon35Vi5vf21aNF9M7BPRoplRq5ktojqVR8XonZar627Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEw/pZcq; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEw/pZcq"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3105ef2a06cso43107021fa.2
        for <git@vger.kernel.org>; Sun, 27 Apr 2025 21:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745813067; x=1746417867; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5HrsBJgKQKoZTnSTgFGo0lk5Y+ORa7VnBRrDMbCuYtk=;
        b=fEw/pZcq+gGbp1Bqg7o9CAa4QeeJBree6jLKhxYQ85k6md1/vm7uoVr14TZ9XJ4upV
         Xtw2UGZAmt48mr9GHl5EoKMlKzlShpuZL3HpTRB9Eg9oJF5lW8GCWiuJtz41/mApWt9r
         aQv4XdkW19iD+p12fyQWD4rpVUdhz0IL+BGIykgNmxWGBL74lEVLOUi5MwP1tgZC7quA
         Ta5+XKlDuCXWqo+S5EquXWqYREWCOAAf9dbGUKHLh+nIysfd7uVnkKPsZt9kvNeptjTq
         +azYkG/xc49l8T2uG7BKMUGVPyKqRsqqTNzRC+X9AMu5UZQF/DCvln6BOlZirTszXH7N
         m9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745813067; x=1746417867;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5HrsBJgKQKoZTnSTgFGo0lk5Y+ORa7VnBRrDMbCuYtk=;
        b=FH3RJmD6JIUq4V9qYFO+R3ex++BzgAYOjv5CTjSeY/DA16/wrMC1QyWAJTS/UTI2Fg
         s7HMnVkU/HtX2JhGqRZQq3GGHkmpXKo9zALpIfBwLSdJvwcXJLTwClotxBRnna9Lmyr2
         ssbne0sptJwSd19nmd7QvsuwRlaFocUovvXvUt1SWNers6R82dOwIdPo0sU+uOO2Tk93
         sHYieDSt7uZKQSANN9uWpitJotrgrhhueGl5RY0JkJjnr/Qs/IkEdgrTqxFijqBgOYF3
         i6KjxfN5foKv1u1zAOZ88qrRplusK8kI6cJloh44F033TaB2fI6BR3PWwspoN8GgIob/
         5XjQ==
X-Gm-Message-State: AOJu0YwIYph3lQHULNgQ1aQ8fbsvseVNaOcvIKaPoL5cS7/3shSbDF59
	cXcbgK/7fAQTchxC4CpzMhxWagMC95QpqomCVEcDVAMeW9nm7TpTGVHhGXw+ii4R/JMuXSkowQ7
	let8Sc9UjJs9eWN9c0V3k0P4FDtPE9pYEcnE=
X-Gm-Gg: ASbGncteFBlG0YTf0BW/6gNARg56+z1SdOg58PuPbsyp2uol5zRJz03ZWB9um7Oqq1W
	ln6HVmCFwKe5FfLClvFOYB9sebW6eWWa/90wZDRx5JeLMqQ6iNz+RyJLJVKAZC/sTRu3Tzh96MO
	xZkBpZVnCnNJb8tuaXe/M2Ew==
X-Google-Smtp-Source: AGHT+IFjmO+f+Gci0PkLruLTyBrv0MpC9I46JtGe0/fHQHtEXAhAmsE+tIEAmhMHn3MJUe/SoUd6BYBOwVfVu2Y9fjc=
X-Received: by 2002:a2e:b8ca:0:b0:30b:aabf:fc4 with SMTP id
 38308e7fff4ca-31906e30783mr32052361fa.21.1745813066664; Sun, 27 Apr 2025
 21:04:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Pavel Pavlov <pavlov.pavel@gmail.com>
Date: Mon, 28 Apr 2025 06:04:14 +0200
X-Gm-Features: ATxdqUFKSWI6DgpRd-FYorK3HMN5f_sgIFC6mSJ1hq5HlA16sgDYPmju12-bbQc
Message-ID: <CAG_s-qqdzzB=ft4ibymVNfx8o0puFDTOnuwtHrvwgEyUP8Mfig@mail.gmail.com>
Subject: Shallow checkout of submodules
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I've noticed that in some cases shallow checkout of submodules checks
out the entire history (and takes longer to fetch and make much larger
size repo).

I created two repos to show the issue.
https://github.com/pps83/submodule-test-ok
https://github.com/pps83/submodule-test-bad

Both are effectively identical: a readme file with a shallow submodule.
submodule-test-ok links to
https://github.com/pps83/brotli-master-min/tree/1e6f9b4b4c98f6f99ba9a860cbb982346631df80
submodule-test-bad links to
https://github.com/pps83/brotli-master/tree/1e6f9b4b4c98f6f99ba9a860cbb982346631df80

Note, the hashes are identical (repos are different
`brotli-master-min` vs `brotli-master`).

If you checkout submodule-test-bad
```
git clone https://github.com/pps83/submodule-test-bad.git
cd submodule-test-bad
time git submodule update --progress --init --force
cd ..
```
entire `submodule-test-bad` is 34MB and takes a long time to fetch (if
you are in some remote location with slow internet).

If you checkout submodule-test-ok
```
git clone https://github.com/pps83/submodule-test-ok.git
cd submodule-test-ok
time git submodule update --progress --init --force
cd ..
```
entire `submodule-test-ok` is only 2.9MB and takes a second to fetch.
At the end the only difference is in the `.git` folders, while
contents of these two repos are identical.

Not sure if that's a git issue, or github. But the issue happens
because of the default branch settings in the repo. In short, shallow
checkout of a submodule from a non-default branch on github results in
a full checkout.

Thanks,
Pavel
