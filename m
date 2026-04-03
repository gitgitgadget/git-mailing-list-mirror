Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5040B3368BF
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 01:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775180857; cv=none; b=G56+S/oK0WDpvyTnEMVhdgasxh8+Ate+HTiaqRLQyvcBnvlapQNDnvvon0hRByTq9UbJp3X8kQ6AeKowrFCD+Yv4Y7GeSeJ0orqFULLEdHieoYMati29z25pHqsj7i3ZpArin3N89WAl0S4ugI+ACQp6DaG7Fn9+7Rd3WUGwH0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775180857; c=relaxed/simple;
	bh=kwMD4huNvCMvQFwL0zsKDTOJ2zfowlKzN4uyevcAyQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N6sWuhDkLodigiPROyH5dcIHjmcnofHZt6ojDloFu06TFBaLNguaUbcmf9cmmhVs87zrOV5+SjTmOa/+N2nMyBU79ONZOcDra/VGvymRNveJqY0sJlsmOXkstUu1Lx3gSBuJ0CAvQzAwMEzN8y6v2ZAn/7HfNnb9gEWIy3mQY2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJkn8n+a; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJkn8n+a"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64eaf8aa893so1311088d50.3
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 18:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775180855; x=1775785655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X8eCzVBb47L80zwpeIdr2u6VDjAdL3tu/0en8Yu1OHc=;
        b=TJkn8n+a2MP7w1zBFmGca8Mo+KsY+JIhQT2E4RzJrtAyj5SAFGXcBxfTf/VkbxWrw5
         VGAH2W1fLK6kO9TSdz3+wIfxUuuulvmf/LB6rNUSTkFE2lA1MiHFf1NKip2WB0bIgXnr
         43Pj+qr9nyvuO9SNGrvRdoj+ZQdVukQjO19G9VIQ69bBcDhOaXZXYQ1eJ/9ftOhscFc7
         BgGTlAzFC/4iOwbe9iJ0E+QBZNt3XL+MDsRvro4IlNC9mmOcKeuDgMcNtVNbkEtMImo+
         sQN8YI3nOP2Ysxd7FCoL7NW8yv0TOeNM1IGepEK3FTEkvJxtAWIS2TkYUsAWtE2k6o/i
         jqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775180855; x=1775785655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8eCzVBb47L80zwpeIdr2u6VDjAdL3tu/0en8Yu1OHc=;
        b=AwICRUioZIPcehHlnbxvLgWkttc9dX60Pz89TK9VbYL6751E4uqkmsnvuBAJrqsJRk
         ihXvsMR0SBDpw57d6r5BM64VaiGOiKhVOWNKPKnvZIx5qOGWUrOE1BV14emSPt8uxSBQ
         Ikl0GpR/2JnyYZc0WI5bwP0KC//L4XIBW2OmQMCeIFM6u2kq/59+KFEVxLenrTTUHzKJ
         aAHF/w5Ls7G3r/VwUIvMYOikXAhVL9RqwtAtKVivkoq3lnPznZN4VHx4sEn8cYJaEzuy
         Sr//WrfFv3hFowMnhb8s8PFXTE+TYMV6lj7vRCJ06i0LRwuK+XkDzG3kxFd7HJPEj7ew
         rHJA==
X-Gm-Message-State: AOJu0Yyujvdj1Ks9WPdGFtfHDn9jLbXcI6AC74CCleRDXnc45Itj9zxj
	C74t60mtIWiM+6WPe8FT5+SL2TBoZqHx8iDvtJyquR5CWB9KifKhWX0Q0BPT+XLg
X-Gm-Gg: AeBDieuf9emjL6t6OB4XVPDBBRuqfdW2yLJHMn4mBVZC7OndP9dVKD9ciAAPVzJcnKd
	HufApX9/V501PyqrsSwhjQTVQiqgNyWxXbF3U2vlR7EKygCkerBvYjQufGOuP6SY3F6xxvTWvOQ
	1y2HsW+vl327hkK01jF6OK3qGJnyyETrQZqpPPJu4yNKrxhSYZ1c7iSIPFYrXTcTYSfcgLDvuM3
	tviu12ruaGfG8pBgq7uZq3DFeSiMSYlgHtjOcCz8xORmUi2enbzMWolF0K/zQ12WVDU7+/jebHu
	S1DqfUlK0J29Ua5kDxnzz6sJOIbtN5R5EE9h3e5pixx7VDd+/S41hP5upUDXBXFljnnTWX7EUud
	UtODaGYqYelqq3FewBLrJBNxFWbPLFJ3N2KTTQe+OmVXEZCPpsoXNrjEjqOcf/+4KX0rb7PH07b
	fwixbMTXX0oPP4MZtrEN+aV+H1JapFZV3AgPRgyJXK4DwvaUgu9iWG5WLZKBWmFAAL2+bkzWH3/
	k2jFOyqDw2FaGBmQqSmG3ZblE4CDmzL5FhUAfotmfYX/L19R0uuQ+EYifl4GuNhVIFh1W38vvl1
	Pv/1cPeyzMs=
X-Received: by 2002:a05:690c:c248:b0:799:198d:8c78 with SMTP id 00721157ae682-7a4d8ea73c1mr16683027b3.46.1775180854945;
        Thu, 02 Apr 2026 18:47:34 -0700 (PDT)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e8343d3sm17064077b3.16.2026.04.02.18.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 18:47:34 -0700 (PDT)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Git l10n discussion group <git-l10n@googlegroups.com>,
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
Subject: [L10N] Kickoff for Git 2.54.0 translations
Date: Fri,  3 Apr 2026 09:47:26 +0800
Message-ID: <20260403014729.1519952-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.51.0.rc2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Git v2.54.0-rc0 has been released, and we are starting a new round of
localization for Git 2.54.0. Since the last release, 182 catalog entries need
to be translated. Please open a pull request against the l10n coordinator
repository (URL below) before the update window closes on Sat, 18 Apr 2026.

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


**Reminder: the update window closes on Sat, 18 Apr 2026.**


--
Jiang Xin
