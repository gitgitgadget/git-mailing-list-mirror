Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E74429B79B
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 06:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781331427; cv=none; b=c0v9dDPSMec9KZYWW3nlVZegI9MZZwcV78CiQxL+UnFAPvL5QavBvYGCCmJWDuzkL+ZTyc52SckqzyO4eWIgLNDaYOQiO3OdHhcTEfbG+5fUiBFmrPsvzLZt1oq9v8SVF1FZfQJaZBjLFUjdejkkfwtjpGjDiJq7PPtXrjgLjA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781331427; c=relaxed/simple;
	bh=gEJK+D8QKaOeVuxK3TgdTLwOmMi8QVi0tM+/gSk3eQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=orfcvt5E3qBgk+xtJu1qKjhm7kutZr5ZRb+BQyI3Ujd1JHIkxmmH2hlOgZgUx69rjgjGDs9ULDGMhi7TgJyHvdQFZv1BWjDhqQuC43rM0sVdGb69YMHTxTtPRB3kXN4Uh7hXTYmbCSwMTPTLjctZys02JYFHwMfQzDGcQBvFGzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdJsBkGg; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdJsBkGg"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7dd3f176f84so17206047b3.0
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 23:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781331425; x=1781936225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O+YARymFfb0l+JXIO4cLykV7JYydUbAtX0DC38zUz84=;
        b=YdJsBkGgaT2Pj1D6ObN9RDaIB9RFxZEbDOiFXeSgIk01hUFPlr9pqroKNUn36zKBi3
         VXkBFctRukl+qeOX50SZCmx+mMgoyN4RBd2Y/nrx7lVQn/7YWasqa4CUK9FMc2KsDTIK
         KOFvF9C610gVdEGh2PG/t/kv5QCExLKepSpZGzlFHv/8Pmq0JrPWqxOwW/hbG2gqHQER
         L2Dt4e1z6f8dIxaqscu4Bx+MuivSg0pnRJVJhtbT/rPy7Qhgy9YhoyFgJG56e5G14V5Q
         vYT2Jmi9+3WPFnrHSXTsOoV6aQwk6OFY6oU5SFSD1hpAWfpKwwJUhXzhhO6T8hCxNPfX
         6OxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781331425; x=1781936225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+YARymFfb0l+JXIO4cLykV7JYydUbAtX0DC38zUz84=;
        b=NLhLJvqd6OUs1cgjf7gZquOWNY6jZMxzpH5w9E/vEJszl6096EXpL8m3S/R8RfM42B
         67fH0nWmWMy8Ywf3Kjs97QZF6rrscpsr+JRO4jTB3c/mHU/R8WDQhvOwY8d1julX9Osk
         9/Q0a3eIr7ty5+B3h1Gu8QXSw9Bjo8+I7NhBT6Qjko6a/aouYdV0Jw/OtdLBxMQL3PCs
         uD3SoDGpAGW+c+md32RZyKbXHxj3/L8CvfXwtcGySqGSY7MyKyVUCr7gN3Rd/gBhRIvP
         6gy/oTEYy8OavTp38ZQZXFi91rrdXbESBtUOnS1bpWiZEKE0r3OcNDjX5ba2/5CgNogf
         TNHg==
X-Gm-Message-State: AOJu0Yxg/cqJYjyRo2Bn8E6gCkcpyMWc6nZnqhz3ZnFBVe1xioG8PohB
	hSDfpaxz7LcNLQgD9YjDg7aB3pk5DvOYhqpQHHdeipJ/k6esi8rOAljp1OWxaA==
X-Gm-Gg: Acq92OHJEWdH7a8mmPcZUp62ZSb3qM8wl3ETHkWUKT2woXmFLQKkYvlKmyrqaOsQDEF
	rlFriuvm0PAyE4hQIreHzQp2RFlt5haYInKVT4Uci6xtiETBHpmGArwIwu6REmkC1CdNw3/SL/j
	5v2UdUcUCEMyKuqEEe+a2XgcQA9+VRy05jdbaQ0Uu7PdxPqmvAPlKRyfFR7Hpak3sPwKePzt+Bm
	pnHcsGgSVUZRgYJmq7Hw7Va2HUR660aDikgZA+H5Y/2/MSa1EaCC00yTgy6OsBW2b+cAqPKkOA2
	JQ8dZhKEiP8CPcno8ICm3dkzfIjp47loKK/fR1IPh6A4WdFzW8QNEThh90jn1aZjdSTWD9g0hGS
	8kngT4PZ+3B+ard9D3urmlj+ufniqc3hhuyIBLlwGknFFAXeleKWqx1jQcmV4nG96M1oKpQ1p4j
	LEqsnxI/ebsd4RRe1uFads74pJltYxZSGPj4kKmmATKCOvLAz7xifiQd2Qb4LTStx7WlCBysjvV
	lZtaHWpMKhLXnlSkd6YRLK3MAWVHls8b/9vgn2oXogRfezVKrWZZLI91wbHiYzx7RJoIACS9kDK
	LbZZ3pK1Oa0=
X-Received: by 2002:a05:690c:6183:b0:7dc:8dc5:ded3 with SMTP id 00721157ae682-7f7bac02857mr56103037b3.7.1781331425203;
        Fri, 12 Jun 2026 23:17:05 -0700 (PDT)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7f7716e359bsm19180587b3.43.2026.06.12.23.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 23:17:04 -0700 (PDT)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Alexander Shopov <ash@kambanaria.org>,
	Mikel Forcada <mikel.forcada@gmail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	Emir SARI <bitigchi@me.com>,
	Arkadii Yakovets <ark@cho.red>,
	=?UTF-8?q?V=C5=A9=20Ti=E1=BA=BFn=20H=C6=B0ng?= <newcomerminecraft@gmail.com>,
	Teng Long <dyroneteng@gmail.com>,
	Yi-Jyun Pan <pan93412@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
Subject: [L10N] Kickoff for Git 2.55.0 translations
Date: Sat, 13 Jun 2026 14:16:56 +0800
Message-ID: <20260613061658.1767987-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.51.0.rc2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Git v2.55.0-rc0 has been released, and we are starting a new round of
localization for Git 2.55.0. Since the last release, 125 catalog entries need
to be translated. Please open a pull request against the l10n coordinator
repository (URL below) before the update window closes on Sat, 27 Jun 2026.

    https://github.com/git-l10n/git-po/

The workflow below is adapted from `po/README.md`.


## The `po/git.pot` file is generated and not kept in the repository

The l10n coordinator no longer generates `po/git.pot` before each round, and
that file is not committed to the repository.

You can build it locally with:

    make po/git.pot

This step is optional: when you refresh your `po/XX.po` file (see below),
`po/git.pot` is generated automatically as part of the process.


## Refresh `po/XX.po` before you translate

Before updating `po/XX.po`, pull the latest commits from the `master` branch
of `git-l10n/git-po`, for example:

    git pull --rebase git@github.com:git-l10n/git-po.git master

Then refresh `po/XX.po` against the current sources with:

    make po-update PO_FILE=po/XX.po


## AI-assisted translation

Using AI coding tools together with `po/AGENTS.md`, l10n contributors can
translate a freshly generated `po/XX.po` with a prompt such as:

    Translate po/XX.po with reference to po/AGENTS.md

Please treat any AI-generated output as a draft. It should be reviewed and
approved by someone who understands both the technical context and the target
language. The best outcomes combine AI-assisted speed with human judgment,
cultural nuance, and community review.


## Set up filter drivers for `po/XX.po` before you commit

Comments in `po/XX.po` may include source location lines like:

    #: add-interactive.c:334

Those locations help translators find context in the source, but they add
noise and consume a lot of repository space, so we strip them from `po/XX.po`
before commits.

Content filters are configured for `po/XX.po` files so that the clean filter
removes location comments (`#: ...` lines) from what Git commits. Inspect
the active filter with:

    git check-attr filter po/XX.po

Configure whichever filter driver matches your setup for `po/XX.po`, or
configure both:

    git config --global filter.gettext-no-location.clean \
               "msgcat --no-location -"

    git config --global filter.gettext-no-line-number.clean \
               "msgcat --add-location=file -"

After you commit your `po/XX.po` changes, open a pull request against the
l10n coordinator repository:

    https://github.com/git-l10n/git-po/


## Address feedback from the l10n CI on your pull request

The helper at https://github.com/git-l10n/git-po-helper helps the Git l10n
coordinator and contributors check Git l10n contribution conventions. It also
runs in GitHub Actions as the l10n CI pipeline that validates each pull request
to the `git-l10n/git-po` repository. Please address any issues it reports.


**Reminder: the update window closes on Sat, 27 Jun 2026.**


--
Jiang Xin
