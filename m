Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F55028DB3
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 07:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713165763; cv=none; b=KFeH12GvE7nCEZpot6wrgmGdDfm7Lv03xqPF0v8mMzv7jw5RPw0HWPXczD216gJMxrxJ2wh50F/bIB0Ygc10ltUGGEDkso3xWum/gHyIswsq+q7AZzTHWUccGSf7MnMm56ElYToCoky3u6xwyDK25JAAQeJWztmuVMD6dD31qUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713165763; c=relaxed/simple;
	bh=O+dpVs2yF8rxDjauiY6RDw/csWHOortJMnpE7LK1DxM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ha/Nhy5mRG5C/jjU6rB3+wu5VuV+g+FJwlkuZkCCRmq925/3cujZRYNRQnH9aEg3uGkQiovwdW9rEmndDPZxL8RqWodhnHKkUCZiTCN1DWZgHEHDTtIvpcY5tZyIBsS/v51awj4oXeVMS9gifc0vznSKtJFYBqCh8mhHo7Iy4h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O35qkcf1; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O35qkcf1"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5e152c757a5so1429899a12.2
        for <git@vger.kernel.org>; Mon, 15 Apr 2024 00:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713165760; x=1713770560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TN455AMdPojrQH5k+UL829ZE6GlhMGegqZJgDQWb6X0=;
        b=O35qkcf1GLiHT4iPHS0haDn5xNGayxXYTRbE3Prpuh9gaSjdSTEf8Mt2VUZfnUY8ia
         HvqnevP35YGGTplgyWTt1Y+VkBWg6FGWZe0hH3NWBicleitysGuwUep0s0zzOh0APAhM
         sMplNFogcfkiz+yVIap6WaKvhpWiDfxsHWyerhsReaN613Hefbl5uMnCUbOApgj9oODG
         kZurlWQtzLSagbnsn2qgg+1lWJbVgAOSuvkzVxrHthrt3F1WqZw9Kg1LhkL169sAsrp8
         m82ad+x8K/Sk/H/P1W2VMWfGQR59Yn9IAzD1eheq5Loo5n2HUNeeQ4pm/ai4UwZHAPN0
         zRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713165760; x=1713770560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TN455AMdPojrQH5k+UL829ZE6GlhMGegqZJgDQWb6X0=;
        b=gONDdpfSseZ0X6UqBhpuDDLC1I7lTm12itPgvUVS9rRcpoR0kjReL6Ef+ovH5OpsvC
         4O8cDdCqSXKto5gfgMeKmTIDldUE4csQAhc2I95PB0LBssnb2OcVkQaPvwnJtV0fPEFV
         Dd9gU1tL1LHAmzkq5qs7id7mrkUQTkHo9POyhxn4LVValXjqmbnvJ+V7cHGit6DnH+Eb
         Wo2T6wRy0p4jctTYlfcLKVkOgyvDq2WvD0NmsMrdmVZbfXnAUpHDvZwaCgkgXvXWNEil
         kKESX4IhR9M2PYM96qt4hL7p+4BhAma4ke7sFLS8EhJQBPBpnhuv/RNAtrj881UG8K/U
         EwHQ==
X-Gm-Message-State: AOJu0YwnBCNwi4c6nW+DR7kgnBoeD0TNneg5xSr+utwD+hnkSckrjlUL
	kWUrLtP9LUB+P9pY++gh+YfpfyQ9tG7uzBmWIMdpewRcIe0qnoQEyyuB91Pf
X-Google-Smtp-Source: AGHT+IGHxmRHE25RP/1lBxaTXEUUjlhs/RGEgSEGfmPpIRhyzAqBYhVyJ5rEWHa1Apl33D8OTK0h6Q==
X-Received: by 2002:a05:6a20:4326:b0:1a3:a984:4b8b with SMTP id h38-20020a056a20432600b001a3a9844b8bmr9436461pzk.50.1713165760439;
        Mon, 15 Apr 2024 00:22:40 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id gm7-20020a056a00640700b006ecfdcc2de9sm6816553pfb.10.2024.04.15.00.22.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2024 00:22:40 -0700 (PDT)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Alexander Shopov <ash@kambanaria.org>,
	Jordi Mas <jmas@softcatala.org>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	Jimmy Angelakos <vyruss@hellug.gr>,
	=?UTF-8?q?Christopher=20D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Alessandro Menti <alessandro.menti@alessandromenti.it>,
	Gwan-gyeong Mun <elongbug@gmail.com>,
	Arusekk <arek_koz@o2.pl>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	Emir SARI <bitigchi@me.com>,
	Arkadii Yakovets <ark@cho.red>,
	=?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= <vnwildman@gmail.com>,
	=?UTF-8?q?V=C5=A9=20Ti=E1=BA=BFn=20H=C6=B0ng?= <newcomerminecraft@gmail.com>,
	Teng Long <dyroneteng@gmail.com>,
	Yi-Jyun Pan <pan93412@gmail.com>,
	Git l10n discussion group <git-l10n@googlegroups.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
Subject: [L10N] Kickoff for Git 2.45.0
Date: Mon, 15 Apr 2024 15:22:26 +0800
Message-Id: <20240415072226.15005-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Before the upcoming release of v2.45.0-rc0, let's start a new round of
l10n for Git 2.45.0.  This time there are 78 updated messages need to be
translated since the last release. Please send your pull request to the
l10n coordinator's repository below before this update window closes on
Sun, 28 Apr 2024.

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


** Please note: The update window will close on Sun, 28 Apr 2024. **


--
Jiang Xin
