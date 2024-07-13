Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A54C2F2A
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 09:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720862716; cv=none; b=Ij1Hxb/mkH53+LqTPGU7BmnPf/vVPlW2okq+ZV0CLaxhx+QzuM0b2KswcRUI31mfd4/jFCOkrsOphchUH7uRMbrFYrnz0kU0y2BNTEel0pVltPDsTqkS7ct4OuO2Q+yje08hAgz3vM1MZ+1Eo2Hiq2n/2CJcHyFjW4ZZQ02rEBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720862716; c=relaxed/simple;
	bh=lxMgcaC7veSP/64n3gDW2qV9k6ioN+1NMtC+oVUOid0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uV1pMODlIxvQ5/EWvhX1na0UtbvtsrtVc2E4pj0Oy6UV/Vs1QeOcwWYAb5uIfV9cBaLL1ZqSmVRpJgoW7ALc/7wA97U2dPOs8atLBUoem/j6+OG0jPBXwH7BAbzZCy9eKjOrKb3w+T5rWoQvNVeqW55P9rDYlkwt3/w2SFjn5A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtDbSaod; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtDbSaod"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fb3cf78fa6so17863525ad.1
        for <git@vger.kernel.org>; Sat, 13 Jul 2024 02:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720862714; x=1721467514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nkdBVaqxHF191eL8oqD4QhDOCt0IrpT+Ak/U/FNYPeM=;
        b=VtDbSaodPC8oTJ2QMj44hHQCff5mFBokWWT6diFpebTkyU5NytpD2Snrvt5wKionsb
         nWZeBHqK7RDTdKpLW5tcPzhxHL/wTqZSB87zgplvZcmyHPGaloMHQliF8yCmFiv1FEpC
         NcnxirYUXkOAnv2hTFNx5JBZE2ne/dCvsitMr8Vje4MJS/hwWwfYf4PbIKCtxfMXCiyg
         mQ3PY2twwjMLkp8oKwPdoduODqjpSl2BtxvqLpwRDf7QgsnlMgO/SF6rDydVqCHjZdTA
         X3JyVLe0iQZhE9a/SzwAEl5zTDVMMjBQBAkxB3GVUMhWpnKgXpY1MMcdvgC6j/QnzgUh
         Uw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720862714; x=1721467514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nkdBVaqxHF191eL8oqD4QhDOCt0IrpT+Ak/U/FNYPeM=;
        b=bnkmqLKuw1y7gxXpMRrCDC2JqoNfMx1gbNpWhAf4nS4IzkTdYJY4QwS7JTTk7Nd3Jz
         HXwDJgG1+qAsNg4Mr7HrT2j8Uwp6PEAUR+q4BxzSjF0l9JPJ7naLOWC5oDZwfQ+Gx/BZ
         uu3Sw645ZTV0iBGWpmk50NX7Abo+38oiM/3smAcfdacNLRUmgNpvmiP11QqMs5vCVU2b
         nMy3OyBvBrJ1nNWgdAoViP7O1PQTpWQJaUJym8oC6THG1cHO0mhawSm06GQggG5wy8eL
         g2ZWxvwouXjQVXT/zzXi6KXJYFXfNFsbaIZb5AFCVOMEF4C73W3VCEkTO1xam6CiqujI
         dtBw==
X-Gm-Message-State: AOJu0YwVEbFQYNbOhQIRewxdXyAcfQm3U1LrWTVEskE0zAI3PLOyBdtS
	2Wvw6EkXOj7/6oOH0Dbzemartkh8xdPZp4wyF/xeuYrkY2LTk5pdozxa1KVs
X-Google-Smtp-Source: AGHT+IE4zP3Ei/oNxqU582devSyRWmTUY/GX4+AeS3iEJDYVRdu6tk80Fw2UIU25XXZnhE6jSpWUUw==
X-Received: by 2002:a17:902:8305:b0:1fa:fc69:7a81 with SMTP id d9443c01a7336-1fbb6d54716mr89240355ad.29.1720862714307;
        Sat, 13 Jul 2024 02:25:14 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bbb0625sm6913925ad.93.2024.07.13.02.25.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Jul 2024 02:25:13 -0700 (PDT)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Git l10n discussion group <git-l10n@googlegroups.com>,
	Alexander Shopov <ash@kambanaria.org>,
	Jordi Mas <jmas@softcatala.org>,
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
Subject: [L10N] Kickoff for Git 2.46.0
Date: Sat, 13 Jul 2024 17:25:09 +0800
Message-Id: <20240713092509.29229-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Git v2.46.0-rc0 has been released, and it's time to start a new round of
git l10n.  This time there are 102 updated messages need to be translated
since the last release. Please send your pull request to the l10n
coordinator's repository below before this update window closes on
Sun, 28 Jul 2024.

    https://github.com/git-l10n/git-po/

The following description of our l10n workflow is from the "po/README.md"
file.


## The "po/git.pot" file is a generated file, no longer in the repository

The l10n coordinator does not need to generate the "po/git.pot" file every
time to start a new l10n workflow, and there is no "po/git.pot" file at all.

Everyone can generate the "po/git.pot" file with the command below:

    make po/git.pot

But we can also forget about it. By updating our corresponding "po/XX.po"
file, the "po/git.pot" file is automatically generated.


## Update the "po/XX.po" file, and start to translate

Before updating the "po/XX.po" file, l10n contributors should pull the latest
commits from the master branch of "git.git". E.g.:

    git pull --rebase git@github.com:git/git.git master

Then update the cooresponding "po/XX.po" file using the following command:

    make po-update PO_FILE=po/XX.po

Translate the uptodate "po/XX.po" file, and create a new commit.


## Refine your commits, send pull requests

In the "po/XX.po" file, there are location lines in comments like below:

    #: add-interactive.c:535 add-interactive.c:836 reset.c:136 sequencer.c:3505
    #: sequencer.c:3970 sequencer.c:4127 builtin/rebase.c:1261
    #: builtin/rebase.c:1671

These comments with file locations are useful for l10n contributors to locate
the context easily during translation. But these file locations introduce a
lot of noise and will consume a lot of repository storage. Therefore, we
should remove these file locations from the "po/XX.po" file.

To remove file locations in the "po/XX.po" file, you can use one of the
following two ways, but don't switch back and forth.

 * Keep the filenames, only remove locations (need gettext 0.19 and above):

        msgcat --add-location=file po/XX.po >po/XX.po.new
        mv po/XX.po.new po/XX.po

 * Remove both filenames and locations:

        msgcat --no-location po/XX.po >po/XX.po.new
        mv po/XX.po.new po/XX.po

After squashing trivial commits and removing file locations in the "po/XX.po"
file, send pull request to the l10n coordinator's repository below:

    https://github.com/git-l10n/git-po/


## Resolve errors found by the l10n CI pipeline for the pull request

A helper program hosted on "https://github.com/git-l10n/git-po-helper" can
help git l10n coordinator and git l10n contributors to check the conventions
of git l10n contributions, and it is also used in GitHub actions as l10n CI
pipeline to validate each pull request in the "git-l10n/git-po" repository.
Please fix the issues found by the helper program.


** Please note: The update window will close on Sun, 28 Jul 2024. **


--
Jiang Xin
