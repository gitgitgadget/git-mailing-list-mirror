Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA0B17993
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 00:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762217432; cv=none; b=Qx2cPzRfxjQML9Vb9ts25qaghtGTtP5plGzCquU8TUCp2BBg+2cr4nb8XkHeNsstidLReDPJlRXi1S1ndCe5xzNVs7xtoR7GMsQTqO9LVJ/9aAybQIp8nFrLVOr3yaPljMafVsF9ki2NJdGif98WfdGp1PbJGVcMGchBg10eKtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762217432; c=relaxed/simple;
	bh=GTtNOiZBomHL7kddG+4T5SAv/Gt2RsRpaKOXSKdxKWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W8mX1wF6qrQjtBll/z/aYhGMOlJzazw1tzMWDwEBCyJoDi1F19SIlcukF9rohEQt6sVAgnmVv5AQ1cmQYsnshBTJlQLmF1xzz0F667NKGYVuum8Qlp7Tv+26PBWaX4qzQsWkkgOEYq7eC0BbcoEH3XdQC2kA1SlxDcT/AUuQza8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Er8+RKET; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Er8+RKET"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-63bc1aeb427so5063413d50.3
        for <git@vger.kernel.org>; Mon, 03 Nov 2025 16:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762217430; x=1762822230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W7wdDB3aRukSAhOUDxiYUSqqKI0bB32ToYprpL5+NaM=;
        b=Er8+RKETsEC9vY/l0mYshZckZqEoG6cEVV1xAMAvYdzgRvnl3Z/SIr1cTzXrR+mDu0
         /4t2+MCEAIExIO90ozFI2wfavEbjSJTEtfC9s627vWnwT+qu/KDD3sESVuir2GtTIOac
         DY1nK5eTz676dM/UOiRwvqpeJecojXkO03Um5KtOSJeDl7MdDE0qjHPpPqAsfA/LbeAp
         tGtAfu3gB/qPe4pZWrM3GSm3KNjvE2JDSswoxcEdzF2Hruwl6DmYskpeuAPqhrDnNvDP
         G2Cbj0DbYvcd6LUlAsIwB3GF7hxR48OlCancnOzP1eqHGfg0S9m5jBlK4krelwlEBYtp
         65AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762217430; x=1762822230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7wdDB3aRukSAhOUDxiYUSqqKI0bB32ToYprpL5+NaM=;
        b=iglZLhtyjv+LHKvYX9BwGyncTEA3kD7o/Sl6poyW+Pi/qZLo3Bd/uLV6X1qdBmLaMz
         cr0Pc5ui++JHi9I6+m/hrgBUVI8qkAu9eSWTKIXtIgbFeFDGFmA9rOeew18HKQLD22ud
         D1QELLlGVZxcwqcAYhK+JP4dFmSJMPkhYOmenmrKXWKqBe8sPdsLugq6lCGFzbw2tHOu
         rWM8yb2DqP/XWoXWDLW6ifCzSg+0WUT4hvsmaIj35c4dFH56JXIVr/gyTEtlNdUFTKg+
         i4YqfZ6OfvLrSM5ddxqpM/+7R9t/1vyZJDNLJrYCFTb5ed4/fgKJk5DGaKDf+AZVIc+C
         XDcQ==
X-Gm-Message-State: AOJu0YzvjNwTcapryIjbDRHR31pnEtoTCkqXKnWI2Fu8KCJCyBHEpoGK
	g6OX7zmSjqskZ6nQszn6jzdZpWLV4UfP10kD81efQqZnsrcfTZuHURJTykQkcz97ytw=
X-Gm-Gg: ASbGnctn+PkBfA6XQPdjRjnKz8J/LmnWWH3jECKeM0UDxtdWq8EBUTnzTxSOulCtRmF
	Dx53E5GdhPq7rU5cohyj15m9K9aUMZsFTnYP4HdWgkpTOat3lObZcdb3ZqmK49ukY3M1ztNL9sY
	wXRHyZRTpdrDpM9chbk0ZaE3Up6U47aN2pVtVSC/IdAn2Pa6ihs+Ur2mroD5oyWwkdigb5Mp9Ma
	HF9s+cLlt8N9w69NnuTOEkCMEbfbW7XDXwY1ddQhcnljk4PTX//+cXDnPDQ7eNvLHsH2EmykCoP
	0mEdkETT937scVO4Y3NLxY2FxOXiDbbCcbQwUhZc0oyXl4y8vrEXQuhlAbtWlkdMq9HZj/OpkAq
	RRnQAf8m1Cz2kUKwssjj87FproVlc07XmaVDRQHNHz9/CNlg6Jy2HEPE9KukIcGJnS6/sPfgmNS
	eGPJLA5io8d1HqCUWMEhAbpoNiz3tTKAWd/sXEbISNc34M+fKJ+w3gKnXTcs0CaJt0nFm4LUi8
X-Google-Smtp-Source: AGHT+IGqmi91Z7IvTu7WFlpi/xcQQ1CXO/I2HPGkx3Br0bpSM9e4EuCcZ0B7wLkWbSQe/LBK1HViVg==
X-Received: by 2002:a05:690e:251a:10b0:63f:bb1b:b63c with SMTP id 956f58d0204a3-63fbb1bbce9mr3067450d50.2.1762217429764;
        Mon, 03 Nov 2025 16:50:29 -0800 (PST)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63fc9467097sm221982d50.11.2025.11.03.16.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 16:50:29 -0800 (PST)
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
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Jordi Mas <jmas@softcatala.org>,
	=?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
	Phillip Szelat <phillip.szelat@gmail.com>,
	=?UTF-8?q?S=C3=A9bastien=20Helleu?= <flashcode@flashtux.org>,
	insolor <insolor@gmail.com>,
	Kateryna Golovanova <kate@kgthreads.com>,
	=?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= <vnwildman@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= <pclouds@gmail.com>,
	Ray Chen <oldsharp@gmail.com>,
	=?UTF-8?q?=E4=BE=9D=E4=BA=91?= <lilydjwg@gmail.com>,
	Fangyi Zhou <me@fangyi.io>,
	Franklin Weng <franklin@goodhorse.idv.tw>
Subject: [L10N] Kickoff for Git 2.52.0
Date: Mon,  3 Nov 2025 19:50:14 -0500
Message-ID: <20251104005021.800425-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.51.0.rc2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Git v2.52.0-rc0 has been released, and it's time to start a new round of
Git localization.  This time there are 84 updated messages that need to
be translated since the last release. Please send your pull request
to the l10n coordinator's repository below before this update window
closes on Sat, 15 Nov 2025.

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

Then update the corresponding "po/XX.po" file using the following command:

    make po-update PO_FILE=po/XX.po

Translate the uptodated "po/XX.po" file, and create a new commit.


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


** Please note: The update window will close on Sat, 15 Nov 2025. **


--
Jiang Xin
