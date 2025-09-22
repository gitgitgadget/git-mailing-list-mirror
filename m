Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAD77D098
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 01:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758505161; cv=none; b=oWrNXOBq2nOyOXKCymGZY8YbFAgg/5hq4WBV3XkYxRFbIBguib+4BhZtcaW4r5JDum+PRbGpBVt71iFfYzpfdDVFqNS14oU1FWpnHxTcLswiiLRcTNgEmghhuBveQNX0OyAltGpIkKHZtuVCT2uqo95GeZ5+pGk+e5AApliCuh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758505161; c=relaxed/simple;
	bh=fvSA6CKjnLNXfFFloaQ5tIETo+buWoOJBjWsI5Yio2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tQGgtp0GCg/w6L+2m9SUG0JivKeHZBFyWzsTKjUlskakgpj4bKienTVryAbAne59ju5IhYDB4PuJVxLpAaFYagH/vBlwDWZpIS9c2zk318RRfgAD4StoJiPN1zUPVUaXGhddWaUMw2WedIa2XU4GgqpCaBhD07DRJXMTTCzW7Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9Ie2EyV; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9Ie2EyV"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-ea5d856ac28so2655910276.1
        for <git@vger.kernel.org>; Sun, 21 Sep 2025 18:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758505158; x=1759109958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2d4SzLC93DziLhYbCwKjlQbLfuY7Qt75+GHWrrnasI=;
        b=T9Ie2EyVhWIb/QedG5XRNzjovEhfL1ehCaOS5/BN15hXQBO9OvbCU48sCSOawXJolZ
         grSKCq4br6lHwuBvm61Ey1fuNjrOFh2zo4Q/0YKtSSmXSoipoxX5ZG3cYgjrR8i98aHA
         KDJAYQ+u7uCJ2sP7HvOnxjHhLZYCRWg0dHQ1yUPYIGSEx7gdT/13z4xF6EWI9GR6Iybz
         uCjEsXfIy00m8piqshi4h6ZW4nf0nK8dmQWri3hs8a1m01SINjktQve8NcxfK2BFGLXv
         yIFJqynhKoTCNK7YgDgxLarwl7whPOHkPv38rHf6KU7CHiVgx+fS7qJdEtIVFSIpFkbg
         wlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758505158; x=1759109958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V2d4SzLC93DziLhYbCwKjlQbLfuY7Qt75+GHWrrnasI=;
        b=EkVsIP2cLRtlMcoYPO2hbfF/KLF855Z4PgsMPMAXRqqa247r2wPJLew1W8uuPviHRx
         4OFUyNXuDXdDeigJ/zTXxu6YXPexnJGDN2Iw5DlQp4qHaLRiu5PY4MvvUJklciuJ5UgN
         rSJfeGvnTZ6OmSr/CCN/mcOuQ42H4IkJsFFZ/i/xpeakH+1XNfN5GO/0eyEGGWlfHeoz
         2MbJHVUKZXf/hGxfVfD/MjVXH9qq9uVuSmqjzC+W9jGwFsw6b2dpdchRW6Pz0aAa8DmJ
         /GUAawqsTzuSVCT352Gk7MdqZj01Y+wokPIrI+87Rsd5mFfHJmv1ELcXhMHrqHbX3xL3
         slQg==
X-Gm-Message-State: AOJu0YzM3nyKkF1J4VIbZdnqUdIPxaqfHNRV0F3TwaiqIn15963EZoF2
	Qd2NSTYOLSfdrXuzFTIKtASIssyp3x4+pKGVqqmZlSmfjTBimvp8poRRhwE8wg==
X-Gm-Gg: ASbGncvX/26Lolk3TacJif/XFjDVfNANrsOMimd+axm3aVwVclOMfF5H+xYz3Nr7JIm
	1pPuWzn7TyN0qQoqNUKIsw/X3bxQ35HKcZfLnO/6uoZ1h9/o04RFEO5PyDZv9PEfWcuvShXbk4q
	Ej92+grswRhilKO3wsGoPHQ637ISa9KeCRGgd6oxiUAiAqSMQFNyJxaH7JdsK935x6jtaOVSbQS
	17S56gbBqa3IwfJ9GpoiXKc3g/CQM36xgEVXpiQL51YOwgvQ7us1JsOCvsiGsFfoviUBnUwr8go
	ELvTEBhRg1MHvvp0Jqh7TsYSyUc8fJud28pDzSeVDfLKOX1eFslmC8/WYX3CeFN0TsHrwSvBxBO
	Aj+Z9BkqZ3Hskq3DjQ4DiRjAPkK1aihoD3WMufhdc9ac+PqLHNboNkCtRyF+VZhKChTcOMkt+g5
	9Rbh+6QNcsBo8a
X-Google-Smtp-Source: AGHT+IHplPSVXATz+Cd0L9cmuaLlq3/z1Ba6JhWO3HI4T5BCIPNyR0/sIoDDabYShdydqfWlU5HiRQ==
X-Received: by 2002:a05:690c:6b0a:b0:723:b16a:d07 with SMTP id 00721157ae682-73d3ef2f00amr98886457b3.53.1758505158262;
        Sun, 21 Sep 2025 18:39:18 -0700 (PDT)
Received: from localhost.localdomain (69-77-149-20.skybest.com. [69.77.149.20])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-633bcd05dd7sm3942069d50.7.2025.09.21.18.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 18:39:17 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 0/4] Teach git-stash to use --index from config
Date: Sun, 21 Sep 2025 21:39:02 -0400
Message-ID: <cover.1758505011.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1757982870.git.ben.knoble+github@gmail.com>
References: <cover.1757982870.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes from v2:
- use "rational" tests (check interactions between CLI, config; drop
  duplicate tests) thanks to Phillip's review

Changes from v1:
- configure --index via config
- drop BreakingChanges related work

With stash.index=true, git-stash(1) command now tries to reinstate the
index by default in the "apply" and "pop" modes. Not doing so creates a
common trap: "git stash apply" is not the reverse of "git stash push"
because carefully staged indices are lost and have to be manually
recreated. OTOH, this mode is not always desirable and may create more
conflicts when applying stashes. Use "--no-index" to disable this behavior.

Cf. <CAPx1GvcxyDDQmCssMjEnt6JoV6qPc5ZUpgPLX3mpUC_4PNYA1w@mail.gmail.com>,
<c5a811ac-8cd3-c389-ac6d-29020a648c87@gmail.com>.

PS I've left some new t3903 tests as copy-pasta for now to get feedback
on the rest of the series; there are bits of that file that could use an
update to the modern style (e.g., not using "test 1 = $(cat file)").
Since some new tests are substantially similar to old tests that use
this style, such cleanup is /probably/ warranted but will delay eyeballs
on the core of this series.

Published-as: https://github.com/benknoble/git/tree/stash-apply-index
v1: https://lore.kernel.org/git/20250510183358.36806-1-ben.knoble+github@gmail.com/
v2: https://lore.kernel.org/git/cover.1757982870.git.ben.knoble+github@gmail.com/

D. Ben Knoble (4):
  t3903: reduce dependencies on previous tests
  t3905: remove unneeded blank line
  stash: refactor private config globals
  stash: honor stash.index in apply, pop modes

 Documentation/config/stash.adoc    |  5 ++++
 builtin/stash.c                    | 17 ++++++++-----
 t/t3903-stash.sh                   | 40 ++++++++++++++++++++++++++++++
 t/t3905-stash-include-untracked.sh |  1 -
 4 files changed, 56 insertions(+), 7 deletions(-)

Diff-intervalle contre v2 :
1:  1328eb8eac = 1:  1328eb8eac t3903: reduce dependencies on previous tests
2:  8ac06ad62d = 2:  8ac06ad62d t3905: remove unneeded blank line
3:  bf0a561ce3 = 3:  bf0a561ce3 stash: refactor private config globals
4:  585e124467 ! 4:  8e6cafbf3a stash: honor stash.index in apply, pop modes
    @@ builtin/stash.c: static int git_stash_config(const char *var, const char *value,
     
      ## t/t3903-stash.sh ##
     @@ t/t3903-stash.sh: setup_stash()
    - 	test 1 = $(git show HEAD:file)
    + 	)
      '
      
    -+test_expect_success 'apply stashed changes with stash.index' '
    -+	test_config stash.index true &&
    -+	git reset --hard HEAD^ &&
    -+	echo 5 >other-file &&
    -+	git add other-file &&
    -+	test_tick &&
    -+	git commit -m other-file &&
    -+	git stash apply &&
    -+	test 3 = $(cat file) &&
    -+	test 2 = $(git show :file) &&
    -+	test 1 = $(git show HEAD:file)
    -+'
    -+
    - test_expect_success 'apply stashed changes (including index)' '
    - 	git reset --hard HEAD^ &&
    - 	echo 6 >other-file &&
    -@@ t/t3903-stash.sh: setup_stash()
    - 	test 1 = $(git show HEAD:file)
    - '
    - 
    -+test_expect_success 'drop top stash with stash.index' '
    -+	test_config stash.index true &&
    -+	git reset --hard &&
    -+	git stash list >expected &&
    -+	echo 7 >file &&
    -+	git stash &&
    -+	git stash drop &&
    -+	git stash list >actual &&
    -+	test_cmp expected actual &&
    -+	git stash apply &&
    -+	test 3 = $(cat file) &&
    -+	test 2 = $(git show :file) &&
    -+	test 1 = $(git show HEAD:file)
    -+'
    -+
    - test_expect_success 'drop middle stash' '
    - 	git reset --hard &&
    - 	echo 8 >file &&
    -@@ t/t3903-stash.sh: setup_stash()
    - 	test 1 = $(git show HEAD:file)
    - '
    - 
    -+test_expect_success 'drop middle stash with stash.index' '
    -+	test_config stash.index true &&
    -+	git reset --hard &&
    -+	echo 8 >file &&
    -+	git stash &&
    -+	echo 9 >file &&
    -+	git stash &&
    -+	git stash drop stash@{1} &&
    -+	test 2 = $(git stash list | wc -l) &&
    -+	git stash apply &&
    -+	test 9 = $(cat file) &&
    -+	test 1 = $(git show :file) &&
    -+	test 1 = $(git show HEAD:file) &&
    -+	git reset --hard &&
    -+	git stash drop &&
    -+	git stash apply &&
    -+	test 3 = $(cat file) &&
    -+	test 2 = $(git show :file) &&
    -+	test 1 = $(git show HEAD:file)
    -+'
    -+
    - test_expect_success 'drop middle stash by index' '
    - 	git reset --hard &&
    - 	echo 8 >file &&
    -@@ t/t3903-stash.sh: setup_stash()
    - 	test 0 = $(git stash list | wc -l)
    - '
    - 
    -+test_expect_success 'stash pop with stash.index' '
    -+	test_config stash.index true &&
    -+	git reset --hard &&
    -+	setup_stash &&
    -+	git stash pop &&
    -+	test 3 = $(cat file) &&
    -+	test 2 = $(git show :file) &&
    -+	test 1 = $(git show HEAD:file) &&
    -+	test 0 = $(git stash list | wc -l)
    -+'
    -+
    - cat >expect <<EOF
    - diff --git a/file2 b/file2
    - new file mode 100644
    -@@ t/t3903-stash.sh: setup_stash()
    - 	test_must_be_empty output.out
    - '
    - 
    -+test_expect_success 'pop -q works and is quiet with stash.index' '
    -+	# Added file, deleted file, modified file all staged for commit
    -+	echo foo >new-file &&
    -+	echo test >file &&
    -+	git add new-file file &&
    -+	git rm other-file &&
    ++test_expect_success 'stash.index=true implies --index' '
    ++	# setup for a few related tests
    ++	test_commit file base &&
    ++	echo index >file &&
    ++	git add file &&
    ++	echo working >file &&
     +	git stash &&
     +
    -+	test_config stash.index true &&
    -+	git stash pop -q >output.out 2>&1 &&
    -+	echo test >expect &&
    -+	git show :file >actual &&
    ++	test_when_finished "git reset --hard" &&
    ++	git -c stash.index=true stash apply &&
    ++	echo index >expect &&
    ++	git show :0:file >actual &&
     +	test_cmp expect actual &&
    -+	test_must_be_empty output.out
    ++	echo working >expect &&
    ++	test_cmp expect file
     +'
     +
    - test_expect_success 'pop -q --index works and is quiet' '
    - 	echo foo >file &&
    - 	git add file &&
    -@@ t/t3903-stash.sh: setup_stash()
    - 	test_path_is_file bar
    - '
    - 
    -+test_expect_success 'stash -- <pathspec> stashes and restores the file with stash.index' '
    -+	test_config stash.index true &&
    -+	>foo &&
    -+	>bar &&
    -+	git add foo bar &&
    -+	git stash push -- foo &&
    -+	test_path_is_file bar &&
    -+	test_path_is_missing foo &&
    -+	git stash pop --no-index &&
    -+	test_path_is_file foo &&
    -+	test_path_is_file bar
    ++test_expect_success 'stash.index=true overridden by --no-index' '
    ++	test_when_finished "git reset --hard" &&
    ++	git -c stash.index=true stash apply --no-index &&
    ++	echo base >expect &&
    ++	git show :0:file >actual &&
    ++	test_cmp expect actual &&
    ++	echo working >expect &&
    ++	test_cmp expect file
     +'
     +
    - test_expect_success 'stash -- <pathspec> stashes in subdirectory' '
    - 	mkdir sub &&
    - 	>foo &&
    -@@ t/t3903-stash.sh: setup_stash()
    - 	test_path_is_file bar
    - '
    - 
    -+test_expect_success 'stash -- <pathspec> stashes in subdirectory with stash.index' '
    -+	test_config stash.index true &&
    -+	rm -r sub &&
    -+	mkdir sub &&
    -+	>foo &&
    -+	>bar &&
    -+	git add foo bar &&
    -+	(
    -+		cd sub &&
    -+		git stash push -- ../foo
    -+	) &&
    -+	test_path_is_file bar &&
    -+	test_path_is_missing foo &&
    -+	git stash pop --no-index &&
    -+	test_path_is_file foo &&
    -+	test_path_is_file bar
    ++test_expect_success 'stash.index=false overridden by --index' '
    ++	test_when_finished "git reset --hard" &&
    ++	git -c stash.index=false stash apply --index &&
    ++	echo index >expect &&
    ++	git show :0:file >actual &&
    ++	test_cmp expect actual &&
    ++	echo working >expect &&
    ++	test_cmp expect file
     +'
     +
    - test_expect_success 'stash with multiple pathspec arguments' '
    - 	>foo &&
    - 	>bar &&
    -@@ t/t3903-stash.sh: setup_stash()
    - 	test_path_is_file extra
    - '
    - 
    -+test_expect_success 'stash with multiple pathspec arguments with stash.index' '
    -+	test_config stash.index true &&
    -+	>foo &&
    -+	>bar &&
    -+	>extra &&
    -+	git add foo bar extra &&
    -+	git stash push -- foo bar &&
    -+	test_path_is_missing bar &&
    -+	test_path_is_missing foo &&
    -+	test_path_is_file extra &&
    -+	git stash pop --no-index &&
    -+	test_path_is_file foo &&
    -+	test_path_is_file bar &&
    -+	test_path_is_file extra
    -+'
    -+
    - test_expect_success 'stash with file including $IFS character' '
    - 	>"foo bar" &&
    - 	>foo &&
    -@@ t/t3903-stash.sh: setup_stash()
    - 	test_path_is_file bar
    - '
    - 
    -+test_expect_success 'stash with file including $IFS character with stash.index' '
    -+	test_config stash.index true &&
    -+	>"foo bar" &&
    -+	>foo &&
    -+	>bar &&
    -+	git add foo* &&
    -+	git stash push -- "foo b*" &&
    -+	test_path_is_missing "foo bar" &&
    -+	test_path_is_file foo &&
    -+	test_path_is_file bar &&
    -+	git stash pop --no-index &&
    -+	test_path_is_file "foo bar" &&
    -+	test_path_is_file foo &&
    -+	test_path_is_file bar
    -+'
    -+
    - test_expect_success 'stash with pathspec matching multiple paths' '
    - 	echo original >file &&
    - 	echo original >other-file &&
    -@@ t/t3903-stash.sh: setup_stash()
    - 	test_path_is_file bar
    - '
    - 
    -+test_expect_success 'stash without verb with pathspec with stash.index' '
    -+	test_config stash.index true &&
    -+	>"foo bar" &&
    -+	>foo &&
    -+	>bar &&
    -+	git add foo* &&
    -+	git stash -- "foo b*" &&
    -+	test_path_is_missing "foo bar" &&
    -+	test_path_is_file foo &&
    -+	test_path_is_file bar &&
    -+	git stash pop --no-index &&
    -+	test_path_is_file "foo bar" &&
    -+	test_path_is_file foo &&
    -+	test_path_is_file bar
    -+'
    -+
    - test_expect_success 'stash -k -- <pathspec> leaves unstaged files intact' '
    - 	git reset &&
    - 	>foo &&
    -
    - ## t/t3904-stash-patch.sh ##
    -@@
    - 	verify_state dir/foo work head
    - '
    - 
    -+test_expect_success 'git stash -p with stash.index' '
    -+	test_config stash.index true &&
    -+	set_state HEAD HEADfile_work HEADfile_index &&
    -+	set_state dir/foo work index &&
    -+	test_write_lines y n y | git stash save -p &&
    -+	git reset --hard &&
    -+	git stash apply &&
    -+	verify_state HEAD HEADfile_work HEADfile_index &&
    -+	verify_state dir/foo head index
    -+'
    -+
    - test_expect_success 'git stash -p --no-keep-index' '
    - 	set_state HEAD HEADfile_work HEADfile_index &&
    - 	set_state bar bar_work bar_index &&
    -
    - ## t/t3905-stash-include-untracked.sh ##
    -@@
    - 
    - . ./test-lib.sh
    - 
    --test_expect_success 'stash save --include-untracked some dirty working directory' '
    -+setup() {
    - 	echo 1 >file &&
    - 	git add file &&
    - 	test_tick &&
    -@@
    - 	git stash --include-untracked &&
    - 	git diff-files --quiet &&
    - 	git diff-index --cached --quiet HEAD
    -+}
    -+
    -+test_expect_success 'stash save --include-untracked some dirty working directory' '
    -+	setup
    - '
    - 
    - test_expect_success 'stash save --include-untracked cleaned the untracked files' '
    -@@
    - 	test_cmp untracked_expect untracked/untracked
    - '
    - 
    -+test_expect_success 'stash pop after save --include-untracked leaves files untracked again with stash.index' '
    -+	git init repo &&
    -+	test_when_finished rm -r repo &&
    -+	(
    -+		cd repo &&
    -+		git config stash.index true &&
    -+		setup &&
    -+		cat >expect <<-EOF &&
    -+		MM file
    -+		?? HEAD
    -+		?? actual
    -+		?? expect
    -+		?? file2
    -+		?? untracked/
    -+		EOF
    -+
    -+		git stash pop &&
    -+		git status --porcelain >actual &&
    -+		test_cmp expect actual &&
    -+		echo 1 >expect_file2 &&
    -+		test_cmp expect_file2 file2 &&
    -+		echo untracked >untracked_expect &&
    -+		test_cmp untracked_expect untracked/untracked
    -+	)
    -+'
    -+
    - test_expect_success 'clean up untracked/ directory to prepare for next tests' '
    - 	git clean --force --quiet -d
    - '
    -@@
    - 	test_path_is_file bar
    - '
    - 
    -+test_expect_success 'stash push with $IFS character with stash.index' '
    -+	test_config stash.index true &&
    -+	>"foo bar" &&
    -+	>foo &&
    -+	>bar &&
    -+	git add foo* &&
    -+	git stash push --include-untracked -- "foo b*" &&
    -+	test_path_is_missing "foo bar" &&
    -+	test_path_is_file foo &&
    -+	test_path_is_file bar &&
    -+	git stash pop --no-index &&
    -+	test_path_is_file "foo bar" &&
    -+	test_path_is_file foo &&
    -+	test_path_is_file bar
    -+'
    -+
    - test_expect_success 'stash previously ignored file' '
    - 	cat >.gitignore <<-EOF &&
    - 	ignored
    + test_done

base-commit: 1ee85f0e215f22b0878d0ad4b2445d12bbb63887
-- 
2.48.1

