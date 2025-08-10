Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524F014AD2D
	for <git@vger.kernel.org>; Sun, 10 Aug 2025 16:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754841814; cv=none; b=bpal2+PLHxwCkDyS5KlTmR9LyrVjY4KkP3dAXyIyGTHL0PemGhzBAiwe1OurDPYJambYnosZHOXcvIhugA15d/ZLNOV7CP9P/pU3j9HPjkPzGn8x9ww9Yf53s/YJVdSzWf2GvWhZgx/EX3bL2KSoxv2O2OPFPAPmekaqZePGk8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754841814; c=relaxed/simple;
	bh=qhlqpeeOoWA9StQVGmFMeT9XDQps9xuwgVx+blDCaks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=inF0fp1RINVAF5g/tI2d8MszkyQKcKmlDXGmOwl6YnoUquhLjno15hHNeaeeduaVZW42Y16+ID/LnWPKX6nDLvJwnqhfmmF23rPppRLmwxi1/BP4necl3yGqJMaL3JkqfTVF1kTAsKZXbCeUg4B/o6BYHn3CiausN6qgILVgcsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABiJ/4Jz; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABiJ/4Jz"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71b71a8d5f0so41096117b3.3
        for <git@vger.kernel.org>; Sun, 10 Aug 2025 09:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754841810; x=1755446610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9WPQGbLmBgTI9J2INqnhlIglejr0grrpA347O9Tu2U=;
        b=ABiJ/4Jzh3gfUzxeMlU58crZiquaPa7v1V4LzlOTpzNl6HKmQafEa1fF58iVO1B2q/
         04Fjme5Ge1Pp1efzOwEWPYZha22f54AmgIhkUBYLGaF6X69FJq+0/0+z9Jksa7Pz0HTw
         6rhKIESYS0VP8757uQMAQujGRyTp6uWQ+sT/E0wUAYZDSE0ZN0HrlTpo0y1puXhpPYa/
         rwV5eCubDlQZELwm4xe7aqF08tmT85xiJCNcLZIf25JoFewSrc9TGSNSRGQgZsOIQGwl
         zdGdPNwaefYFeIE0/FGvzoYKqzSF6r+mkw0zgNtHafGOJsgKMjCGN18qaawisBjTzkvd
         lCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754841810; x=1755446610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B9WPQGbLmBgTI9J2INqnhlIglejr0grrpA347O9Tu2U=;
        b=dHv6zpm22UXJ5BQCZWYGc4/RG1ddQuAaGH9nUWnv7DuxXY+mrBdmvgXWROelGuT0+X
         nV79d5c9ThmQQ7v8/fC+l7KSw+2w20lBSnwgpD9zx2lR72J4vmdmqAodHhljABAWsar7
         pVCB6MtPmBgRF56GjPNF70tL7Gvaj6Ukj/wtlTazaA2jOUsOHn+GtTI/MbpnDhmzR1zC
         JukqXKUQKEbILbyWPsLUJjHv4LE8XAdK67vN4QfY4nNgZO62FYX+beMM/zfrgqH2oOAU
         5mnUfxhRB4FMWtxwctxwRJ01vR+VboVl55U8U1e08qyBBVIb551qncVjBcXy1ZmD6B0w
         wd8g==
X-Gm-Message-State: AOJu0Yxo5rD6VN9kc9Y5HsIOz6p75wgRB4flyY8P6Qujcse9w5nwRQ12
	WyvEJu0vMINOU4weqVz0qjbnZS8yNeXFvgHluWjKl5EPqSqv9vKUVQ7uTJbrX4TJ
X-Gm-Gg: ASbGncuzRn2Qh3C9bMX+vUUO9Ox8DYZZoFddHfJ/eSIk7rnAxt/2FsRiSGrdANPAtyW
	s2tCoiGnQV0bVMMjfz4c6T4lN3q5ZGSvmuTuhAM+fWMTygGIePqpN4Se6kAo+0d/PZBNjBin4t2
	WpnBktAjs7Op2shNA2hbS5EYErkKEhjWUMHYwR12y6TwpuqGtAiI5PL2CN9SoiUYzXvdAf1Gbgu
	KygXbjYjV+lSLNafLcL+AhtpHZFiGDAgeYr74kMilG7iW4zWEVi5B/vQJlnouw5goyA/uqAGXKu
	NZBstahWnKEW+Euk+O2uihj4X8iNUXgBzHUCtSMumxrjhi1Ka9M67tyZeMZRPttwG3ID8m1vpe4
	aikU8H2GohT7srnwGZ8hvpFvqp6xUVO+3PrQdtMvft6k0Kh+Mt3cVmXdFNzlLR/SVBc7SQJop
X-Google-Smtp-Source: AGHT+IF0b3p/9k7oBBaE3FSE0ara5FPMty2r4Go4QUCd8LFQHf31caqvVxtWEyUwLHeDI/2IewNx4A==
X-Received: by 2002:a05:690c:9a8a:b0:71a:51f:81a7 with SMTP id 00721157ae682-71bf0e13d6amr120562027b3.26.1754841809349;
        Sun, 10 Aug 2025 09:03:29 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:dc6d:d141:d6d7:493e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a3a999esm64149937b3.2.2025.08.10.09.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 09:03:28 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 0/3] clean up some code around editors
Date: Sun, 10 Aug 2025 12:03:16 -0400
Message-ID: <20250810160323.49372-1-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250520193506.95199-1-ben.knoble+github@gmail.com>
References: <20250520193506.95199-1-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes from v1:
- add a prep patch with style fixes to t7005
- rework the environment munging to use subshells, per Phillip Wood's
  suggestion

This reroll of the previous exec-path series is simplified to contain
only the first 2 cleanup patches, which were largely acked by the list.
Drop the controversial and broken PATH munging.

Also, this version is (still) based on a later master 112648dd6b (Merge
branch 'master' of https://github.com/j6t/git-gui, 2025-08-04) than the
original from May.

These patches clean up some old code in the editor tests and subsystem
that does not use our modern idioms.

v1: https://lore.kernel.org/git/20250520193506.95199-1-ben.knoble+github@gmail.com/
Published-as: https://github.com/benknoble/tree/editor-cleanup

D. Ben Knoble (3):
  t7005: use modern test style
  t7005: sanitize test environment for subsequent tests
  editor: use standard strvec API to receive environment for external
    editors

 builtin/commit.c  |   2 +-
 editor.c          |  10 +--
 editor.h          |   7 ++-
 t/t7005-editor.sh | 152 ++++++++++++++++++++++++----------------------
 4 files changed, 89 insertions(+), 82 deletions(-)

Diff-intervalle :
-:  ---------- > 1:  e7629202a1 t7005: use modern test style
1:  a37db65107 ! 2:  0467e33ed0 t7005: sanitize test environment for subsequent tests
    @@ Commit message
         t7005: sanitize test environment for subsequent tests
     
         Some of the editor tests manipulate the environment or config in ways
    -    that affect future tests (because they test a sequence of overrides),
    -    but those modifications are visible to future tests and create a footgun
    -    for them.
    +    that affect future tests, but those modifications are visible to future
    +    tests and create a footgun for them.
     
    -    We can't make the environment-munging override tests undo their
    -    modifications because they rely on editor variables overriding other
    -    previously-set editor variables.
    -
    -    Use test_config and undo environment modifications once finished.
    +    Use test_config, subshells, and test helpers to automatically undo
    +    environment and config modifications once finished.
     
    +    Best-viewed-with: --ignore-all-space
         Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
     
      ## t/t7005-editor.sh ##
     @@
    - 	'
    - done
    + 	test_cmp expect actual
    + '
    + 
    +-TERM=dumb
    +-export TERM
    + test_expect_success 'dumb should error out when falling back on vi' '
    +-	if git commit --amend
    +-	then
    +-		echo "Oops?"
    +-		false
    +-	else
    +-		: happy
    +-	fi
    ++	(
    ++		TERM=dumb &&
    ++		export TERM &&
    ++		if git commit --amend
    ++		then
    ++			echo "Oops?"
    ++			false
    ++		else
    ++			: happy
    ++		fi
    ++	)
    + '
    + 
    + test_expect_success 'dumb should prefer EDITOR to VISUAL' '
    +-	EDITOR=./e-EDITOR.sh &&
    +-	VISUAL=./e-VISUAL.sh &&
    +-	export EDITOR VISUAL &&
    +-	git commit --amend &&
    +-	echo "Edited by EDITOR" >expect &&
    +-	git show -s --format=%s >actual &&
    ++	(
    ++		TERM=dumb &&
    ++		export TERM &&
    ++		EDITOR=./e-EDITOR.sh &&
    ++		VISUAL=./e-VISUAL.sh &&
    ++		export EDITOR VISUAL &&
    ++		git commit --amend &&
    ++		echo "Edited by EDITOR" >expect &&
    ++		git show -s --format=%s >actual
    ++	) &&
    + 	test_cmp expect actual
    + '
    + 
    +-TERM=vt100
    +-export TERM
    +-for i in $vi EDITOR VISUAL core_editor GIT_EDITOR
    +-do
    +-	echo "Edited by $i" >expect
    +-	unset EDITOR VISUAL GIT_EDITOR
    +-	git config --unset-all core.editor
    +-	case "$i" in
    +-	core_editor)
    +-		git config core.editor ./e-core_editor.sh
    +-		;;
    +-	[A-Z]*)
    +-		eval "$i=./e-$i.sh"
    +-		export $i
    +-		;;
    +-	esac
    +-	test_expect_success "Using $i" '
    +-		git --exec-path=. commit --amend &&
    +-		git show -s --pretty=oneline >show &&
    +-		<show sed -e "s/^[0-9a-f]* //" >actual &&
    +-		test_cmp expect actual
    +-	'
    +-done
    ++test_expect_success 'Using individual editors' '
    ++	test_when_finished "test_unconfig --unset-all core.editor" &&
    ++	(
    ++		TERM=vt100 &&
    ++		export TERM &&
    ++		for i in $vi EDITOR VISUAL core_editor GIT_EDITOR
    ++		do
    ++			sane_unset EDITOR VISUAL GIT_EDITOR &&
    ++			test_might_fail git config --unset-all core.editor &&
    ++			echo "Edited by $i" >expect &&
    ++			case "$i" in
    ++			core_editor)
    ++				git config core.editor ./e-core_editor.sh
    ++				;;
    ++			[A-Z]*)
    ++				eval "$i=./e-$i.sh" &&
    ++				export $i
    ++				;;
    ++			esac &&
    ++			git --exec-path=. commit --amend &&
    ++			git show -s --pretty=oneline >show &&
    ++			<show sed -e "s/^[0-9a-f]* //" >actual &&
    ++			test_cmp expect actual
    ++		done
    ++	)
    ++'
    + 
    +-unset EDITOR VISUAL GIT_EDITOR
    +-git config --unset-all core.editor
    +-for i in $vi EDITOR VISUAL core_editor GIT_EDITOR
    +-do
    +-	echo "Edited by $i" >expect
    +-	case "$i" in
    +-	core_editor)
    +-		git config core.editor ./e-core_editor.sh
    +-		;;
    +-	[A-Z]*)
    +-		eval "$i=./e-$i.sh"
    +-		export $i
    +-		;;
    +-	esac
    +-	test_expect_success "Using $i (override)" '
    +-		git --exec-path=. commit --amend &&
    +-		git show -s --pretty=oneline >show &&
    +-		<show sed -e "s/^[0-9a-f]* //" >actual &&
    +-		test_cmp expect actual
    +-	'
    +-done
    ++test_expect_success 'Using editors with overrides' '
    ++	(
    ++		TERM=vt100 &&
    ++		export TERM &&
    ++		for i in $vi EDITOR VISUAL core_editor GIT_EDITOR
    ++		do
    ++			echo "Edited by $i" >expect &&
    ++			case "$i" in
    ++			core_editor)
    ++				git config core.editor ./e-core_editor.sh
    ++				;;
    ++			[A-Z]*)
    ++				eval "$i=./e-$i.sh" &&
    ++				export $i
    ++				;;
    ++			esac &&
    ++			git --exec-path=. commit --amend &&
    ++			git show -s --pretty=oneline >show &&
    ++			<show sed -e "s/^[0-9a-f]* //" >actual &&
    ++			test_cmp expect actual
    ++		done
    ++	)
    ++'
      
    -+unset EDITOR VISUAL GIT_EDITOR
    -+git config --unset-all core.editor
      test_expect_success 'editor with a space' '
      	echo "echo space >\"\$1\"" >"e space.sh" &&
    - 	chmod a+x "e space.sh" &&
     @@
    - 
    + 	test_cmp expect actual
      '
      
     -unset GIT_EDITOR
      test_expect_success 'core.editor with a space' '
    --
     -	git config core.editor \"./e\ space.sh\" &&
     +	test_config core.editor \"./e\ space.sh\" &&
      	git commit --amend &&
    - 	test space = "$(git show -s --pretty=format:%s)"
    --
    - '
    - 
    - test_done
    + 	echo space >expect &&
    + 	git show -s --pretty=tformat:%s >actual &&
2:  5450c99f59 = 3:  4a9bb52470 editor: use standard strvec API to receive environment for external editors

base-commit: 112648dd6bdd8e4f485cd0ae11636807959d48be
-- 
2.48.1

