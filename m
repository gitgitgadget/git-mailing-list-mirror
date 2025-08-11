Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEA2125B9
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 22:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754950633; cv=none; b=oTpaHAL0rQiAhmdezlYYVbCad2rQl6Yjp4zBdG3BUbtInjUR5Lonwwuf5tqbIYwgjj5bTCtDy4ISYB6yyJZ+K2UPW597ye8oQbXeMnsW2+75HbVk50vvYkd7p1dIiuizbFn3ndzgIlO5xnAhD7O5583krjHQ17lProYhTQCjUso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754950633; c=relaxed/simple;
	bh=0C2rfsub2afhvWs5eGKd6IvjBOEOqQ44bbdAUsUZMsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EZqJ5n1Kbo5Q8iB9yD8PhFor6lA0EyDMzEBRa77rWX9RieluilW7+DRI6GNE3uhyhj+jv74W8/qcwyLWblqYADVHpUaH+uyNgyd094ECmfdtJI1nFx89f22But14UwKUYwIYcvyZb/HivshLbNzem+5SdkcC+IsT0sjXrUkE9Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyHRKadM; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyHRKadM"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e8fd07da660so3882017276.2
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 15:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754950630; x=1755555430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSxKK22zIU6B8gwaMOR+pB/fP9ZN72L9W2pQ3LUj79E=;
        b=lyHRKadMU9LzGSQZyKD02wxX0tJao4/ZaJpYHbMP1TgpMDK5fyMgxsr9zd1fmjx7R4
         /qjFL/2ZiDydAQoVTV+lFoeX3JFqZ7FxGU225lPGbS9xelSJVOzzpxP+i51z+pynl7Dy
         CElVtHlhM7PbqZIJCZV1paBmeEJfAbdK7ZYxt7LVccdvbbjQkLOgQc68CK1H1VUigAxF
         CJXMIThiAYENiL29jWEsPi72PuXQGzFDOVGEqMGD173kf7dH8vbkxY1NIml7E7JXfa5S
         9DGSv8uowEbt7Fs45FxrMOZ3cQ3jhI9Opx9IbF9uRL13OKHUbVS+fH1hAmAdpWOlM8s7
         o7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754950630; x=1755555430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iSxKK22zIU6B8gwaMOR+pB/fP9ZN72L9W2pQ3LUj79E=;
        b=bheVlKvwzh64eRX7lweKWhhztq1HmJ4OSGtL+5jYBVZf4e9jYb1Hz5BMdUAaY7bfNL
         b3BhGr0ssOBivCK14cxE3n2/obb2vVUkIlu/8FJaINg5lyyKyhFR3tFjAENoSabo9tss
         DmYJLzgTTw2ulWlHkBGRsD5V9xg7t/paM9y8uDdHmIA/+F39zJ/CDXpo0Ckgfv/k+X3L
         oGzlNo98/l3defqKCCoTtCvok2aOtnc+9ppVivbVZzr+JoiCyCu3oLGPuBVRGG13MgMx
         +3BXI/9rXnNQxtBAvzUyp9Gc1i3Wrwdyd7Jrs62GeAOakwhPrqjcGpAsO72Vzg1rfFzC
         jwBg==
X-Gm-Message-State: AOJu0YwSMMhQA+e7h6f4vhKEGeulOC4JIoVCp+GCK7N6x15ciUkIhY5+
	LfksIrjpRdabUEFgqxBTpR7J/o9bFbUUNeqniPGsliV6S6OyKcZQhK7dgQKQN5GD
X-Gm-Gg: ASbGncvMjUGa3Va/3bhdvE7G840Pl6lLowwf7PTfnPk7qlVGAvLMT8hrCv4Gnz/e13Z
	9GKAV1A1PInjktZQia8IDxTUdXLGjS1Tb9uVDlmfrvPiORS6N+oeSk+8TWcPEAt/vhYqr0cTbIV
	lvx5WIJwy7Upuy2UQoMEsCnbajXDHn9xPsZg5GXniAeBoN7gY6MwQ/prwzU6Y1iiAUFaN4cR3rl
	rVaUvVlTmvB4a2rwfJ6mQ0+99RxsoWIxifkWgSSERNUJSl233QxyfYzX/eGFRiTfSm42QyfH9kx
	lUiBjG3ZcqITUCXv/dxDT3sdVHNKrVOv+CUqmIJIw4kTl4myz4vQ3R1Ki/pK/qrMXWyuCYX4xj2
	fdxPDV3+m8VZhudJMUqqRUoX1f4LRSrdAOWTjs/7uw60HcKaApci+p4vjuht2EEwqpdfZmOU=
X-Google-Smtp-Source: AGHT+IE0N2t1KAYKPzo/jBRnngsMyAYQkwk4jv+o9iF/Z/oUdgfK8na5B8dxbDLayRWOcWvnOOBRcA==
X-Received: by 2002:a05:6902:1145:b0:e90:b002:c8cf with SMTP id 3f1490d57ef6-e90b002cc7bmr6674413276.22.1754950629765;
        Mon, 11 Aug 2025 15:17:09 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:7d40:489a:fc5:8804])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e917b3ec714sm176217276.11.2025.08.11.15.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 15:17:09 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 0/4] clean up some code around editors
Date: Mon, 11 Aug 2025 18:16:51 -0400
Message-ID: <20250811221706.67168-1-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250810160323.49372-1-ben.knoble+github@gmail.com>
References: <20250810160323.49372-1-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes from v2:
- shuffle setup code and use more helpers in 1/4
- insert 2/4 to stop abusing --exec-path
- improve environment-cleansing idioms in {2 => 3}/4

Thanks especially to Phillip's encyclopaedic knowledge of test helpers ;)

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
v2: https://lore.kernel.org/git/20250810160323.49372-1-ben.knoble+github@gmail.com/
Published-as: https://github.com/benknoble/tree/editor-cleanup

D. Ben Knoble (4):
  t7005: use modern test style
  t7005: stop abusing --exec-path
  t7005: sanitize test environment for subsequent tests
  editor: use standard strvec API to receive environment for external
    editors

 builtin/commit.c  |   2 +-
 editor.c          |  10 ++--
 editor.h          |   7 ++-
 t/t7005-editor.sh | 147 +++++++++++++++++++---------------------------
 4 files changed, 69 insertions(+), 97 deletions(-)

Diff-intervalle contre v2 :
1:  e7629202a1 ! 1:  8ad2904a18 t7005: use modern test style
    @@ Metadata
      ## Commit message ##
         t7005: use modern test style
     
    -    Tests in t7005 mask Git error codes and do not use our nice helpers for
    -    comparing results. Improve that, and drop a few old-style blank lines
    -    while at it.
    +    Tests in t7005 mask Git error codes and do not use our nice test
    +    helpers. Improve that, move some code into the setup test, and drop a
    +    few old-style blank lines while at it.
     
    +    Best-viewed-with: --ignore-all-space
         Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
     
      ## t/t7005-editor.sh ##
    @@ t/t7005-editor.sh
     -
      '
      
    - if ! expr "$vi" : '[a-z]*$' >/dev/null
    -@@
    - fi
    - 
    - test_expect_success setup '
    +-if ! expr "$vi" : '[a-z]*$' >/dev/null
    +-then
    +-	vi=
    +-fi
     -
    +-for i in GIT_EDITOR core_editor EDITOR VISUAL $vi
    +-do
    +-	cat >e-$i.sh <<-EOF
    +-	#!$SHELL_PATH
    +-	echo "Edited by $i" >"\$1"
    +-	EOF
    +-	chmod +x e-$i.sh
    +-done
    +-
    +-if ! test -z "$vi"
    +-then
    +-	mv e-$vi.sh $vi
    +-fi
    +-
    + test_expect_success setup '
    ++	if ! expr "$vi" : "[a-z]*$" >/dev/null
    ++	then
    ++		vi=
    ++	fi &&
    ++
    ++	for i in GIT_EDITOR core_editor EDITOR VISUAL $vi
    ++	do
    ++		write_script e-$i.sh <<-EOF || return 1
    ++			echo "Edited by $i" >"\$1"
    ++		EOF
    ++	done &&
    ++
    ++	if ! test -z "$vi"
    ++	then
    ++		mv e-$vi.sh $vi
    ++	fi &&
    + 
      	msg="Hand-edited" &&
      	test_commit "$msg" &&
    - 	echo "$msg" >expect &&
    +-	echo "$msg" >expect &&
     -	git show -s --format=%s > actual &&
    -+	git show -s --format=%s >actual &&
    - 	test_cmp expect actual
    +-	test_cmp expect actual
     -
    ++	test_commit_message HEAD -m "$msg"
      '
      
      TERM=dumb
      export TERM
      test_expect_success 'dumb should error out when falling back on vi' '
     -
    - 	if git commit --amend
    - 	then
    - 		echo "Oops?"
    -@@
    +-	if git commit --amend
    +-	then
    +-		echo "Oops?"
    +-		false
    +-	else
    +-		: happy
    +-	fi
    ++	test_must_fail git commit --amend
      '
      
      test_expect_success 'dumb should prefer EDITOR to VISUAL' '
    @@ t/t7005-editor.sh
      	git commit --amend &&
     -	test "$(git show -s --format=%s)" = "Edited by EDITOR"
     -
    -+	echo "Edited by EDITOR" >expect &&
    -+	git show -s --format=%s >actual &&
    -+	test_cmp expect actual
    ++	test_commit_message HEAD -m "Edited by EDITOR"
      '
      
      TERM=vt100
    @@ t/t7005-editor.sh
      		git --exec-path=. commit --amend &&
     -		git show -s --pretty=oneline |
     -		sed -e "s/^[0-9a-f]* //" >actual &&
    -+		git show -s --pretty=oneline >show &&
    -+		<show sed -e "s/^[0-9a-f]* //" >actual &&
    - 		test_cmp expect actual
    +-		test_cmp expect actual
    ++		test_commit_message HEAD expect
      	'
      done
    + 
     @@
      	esac
      	test_expect_success "Using $i (override)" '
      		git --exec-path=. commit --amend &&
     -		git show -s --pretty=oneline |
     -		sed -e "s/^[0-9a-f]* //" >actual &&
    -+		git show -s --pretty=oneline >show &&
    -+		<show sed -e "s/^[0-9a-f]* //" >actual &&
    - 		test_cmp expect actual
    +-		test_cmp expect actual
    ++		test_commit_message HEAD expect
      	'
      done
    + 
     @@
      	echo "echo space >\"\$1\"" >"e space.sh" &&
      	chmod a+x "e space.sh" &&
      	GIT_EDITOR="./e\ space.sh" git commit --amend &&
     -	test space = "$(git show -s --pretty=format:%s)"
     -
    -+	echo space >expect &&
    -+	git show -s --pretty=tformat:%s >actual &&
    -+	test_cmp expect actual
    ++	test_commit_message HEAD -m space
      '
      
      unset GIT_EDITOR
    @@ t/t7005-editor.sh
      	git commit --amend &&
     -	test space = "$(git show -s --pretty=format:%s)"
     -
    -+	echo space >expect &&
    -+	git show -s --pretty=tformat:%s >actual &&
    -+	test_cmp expect actual
    ++	test_commit_message HEAD -m space
      '
      
      test_done
-:  ---------- > 2:  9451e4f0f6 t7005: stop abusing --exec-path
2:  0467e33ed0 ! 3:  61cb116780 t7005: sanitize test environment for subsequent tests
    @@ Commit message
         that affect future tests, but those modifications are visible to future
         tests and create a footgun for them.
     
    -    Use test_config, subshells, and test helpers to automatically undo
    -    environment and config modifications once finished.
    +    Use test_config, subshells, single-command environment overrides, and
    +    test helpers to automatically undo environment and config modifications
    +    once finished.
     
         Best-viewed-with: --ignore-all-space
         Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
     
      ## t/t7005-editor.sh ##
     @@
    - 	test_cmp expect actual
    + 	test_commit_message HEAD -m "$msg"
      '
      
     -TERM=dumb
     -export TERM
      test_expect_success 'dumb should error out when falling back on vi' '
    --	if git commit --amend
    --	then
    --		echo "Oops?"
    --		false
    --	else
    --		: happy
    --	fi
    -+	(
    -+		TERM=dumb &&
    -+		export TERM &&
    -+		if git commit --amend
    -+		then
    -+			echo "Oops?"
    -+			false
    -+		else
    -+			: happy
    -+		fi
    -+	)
    +-	test_must_fail git commit --amend
    ++	TERM=dumb test_must_fail git commit --amend
      '
      
      test_expect_success 'dumb should prefer EDITOR to VISUAL' '
    @@ t/t7005-editor.sh
     -	VISUAL=./e-VISUAL.sh &&
     -	export EDITOR VISUAL &&
     -	git commit --amend &&
    --	echo "Edited by EDITOR" >expect &&
    --	git show -s --format=%s >actual &&
    -+	(
    -+		TERM=dumb &&
    -+		export TERM &&
    -+		EDITOR=./e-EDITOR.sh &&
    -+		VISUAL=./e-VISUAL.sh &&
    -+		export EDITOR VISUAL &&
    ++	TERM=dumb EDITOR=./e-EDITOR.sh VISUAL=./e-VISUAL.sh \
     +		git commit --amend &&
    -+		echo "Edited by EDITOR" >expect &&
    -+		git show -s --format=%s >actual
    -+	) &&
    - 	test_cmp expect actual
    + 	test_commit_message HEAD -m "Edited by EDITOR"
      '
      
     -TERM=vt100
     -export TERM
    --for i in $vi EDITOR VISUAL core_editor GIT_EDITOR
    --do
    + for i in $vi EDITOR VISUAL core_editor GIT_EDITOR
    + do
     -	echo "Edited by $i" >expect
     -	unset EDITOR VISUAL GIT_EDITOR
     -	git config --unset-all core.editor
    @@ t/t7005-editor.sh
     -		export $i
     -		;;
     -	esac
    --	test_expect_success "Using $i" '
    --		git --exec-path=. commit --amend &&
    --		git show -s --pretty=oneline >show &&
    --		<show sed -e "s/^[0-9a-f]* //" >actual &&
    --		test_cmp expect actual
    --	'
    --done
    -+test_expect_success 'Using individual editors' '
    -+	test_when_finished "test_unconfig --unset-all core.editor" &&
    -+	(
    -+		TERM=vt100 &&
    -+		export TERM &&
    -+		for i in $vi EDITOR VISUAL core_editor GIT_EDITOR
    -+		do
    -+			sane_unset EDITOR VISUAL GIT_EDITOR &&
    -+			test_might_fail git config --unset-all core.editor &&
    -+			echo "Edited by $i" >expect &&
    + 	test_expect_success "Using $i" '
    +-		PATH="$PWD:$PATH" git commit --amend &&
    +-		test_commit_message HEAD expect
    ++		if test "$i" = core_editor
    ++		then
    ++			test_config core.editor ./e-core_editor.sh
    ++		fi &&
    ++		(
     +			case "$i" in
    -+			core_editor)
    -+				git config core.editor ./e-core_editor.sh
    -+				;;
     +			[A-Z]*)
     +				eval "$i=./e-$i.sh" &&
     +				export $i
     +				;;
     +			esac &&
    -+			git --exec-path=. commit --amend &&
    -+			git show -s --pretty=oneline >show &&
    -+			<show sed -e "s/^[0-9a-f]* //" >actual &&
    -+			test_cmp expect actual
    -+		done
    -+	)
    -+'
    ++			PATH="$PWD:$PATH" TERM=vt100 git commit --amend
    ++		) &&
    ++		test_commit_message HEAD -m "Edited by $i"
    + 	'
    + done
      
     -unset EDITOR VISUAL GIT_EDITOR
     -git config --unset-all core.editor
    @@ t/t7005-editor.sh
     -		;;
     -	esac
     -	test_expect_success "Using $i (override)" '
    --		git --exec-path=. commit --amend &&
    --		git show -s --pretty=oneline >show &&
    --		<show sed -e "s/^[0-9a-f]* //" >actual &&
    --		test_cmp expect actual
    +-		PATH="$PWD:$PATH" git commit --amend &&
    +-		test_commit_message HEAD expect
     -	'
     -done
     +test_expect_success 'Using editors with overrides' '
    @@ t/t7005-editor.sh
     +				export $i
     +				;;
     +			esac &&
    -+			git --exec-path=. commit --amend &&
    -+			git show -s --pretty=oneline >show &&
    -+			<show sed -e "s/^[0-9a-f]* //" >actual &&
    -+			test_cmp expect actual
    ++			PATH="$PWD:$PATH" git commit --amend &&
    ++			test_commit_message HEAD expect || exit 1
     +		done
     +	)
     +'
    @@ t/t7005-editor.sh
      test_expect_success 'editor with a space' '
      	echo "echo space >\"\$1\"" >"e space.sh" &&
     @@
    - 	test_cmp expect actual
    + 	test_commit_message HEAD -m space
      '
      
     -unset GIT_EDITOR
    @@ t/t7005-editor.sh
     -	git config core.editor \"./e\ space.sh\" &&
     +	test_config core.editor \"./e\ space.sh\" &&
      	git commit --amend &&
    - 	echo space >expect &&
    - 	git show -s --pretty=tformat:%s >actual &&
    + 	test_commit_message HEAD -m space
    + '
3:  4a9bb52470 = 4:  ea269f2442 editor: use standard strvec API to receive environment for external editors

base-commit: 112648dd6bdd8e4f485cd0ae11636807959d48be
-- 
2.48.1

