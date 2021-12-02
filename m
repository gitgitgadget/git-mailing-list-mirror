Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECB9C433F5
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 18:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376626AbhLBSnc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 13:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348134AbhLBSn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 13:43:29 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7B2C061757
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 10:40:06 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id l16so633886wrp.11
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 10:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tbm8LP+GQmxiRLKk4IaXQbKrXlklfHAqd61jMTjQWZ4=;
        b=D7E9e2H+LNfngP30KXB5kTo6i+j1BrIZ2F2lLZ6kS6FMIzJUB3ac9kGOePKX+V89Ir
         L+V4W62xVStRMRdO1O/umj/FejxHPU2Y1FDARun5Jibkq3MbGgcMDwNLnbW5DvxSgXCc
         ks8ToY5i4vykOqUX/aNC7Yg+UDpuDtbE5d4Kol4uVmv+MqhmUMZs6dcEeGGDoycnU53O
         Cnj6Ct49YVLq6pwbdXyC+rV1sF8nRbG/APCBMMKvBAp/dh+CRsNq3dOcNkwoS6JAwH62
         g3N4LH7dotdz7YVC2Fa+snaTT7vSS4LtmZ7Dwu26L1obKxY11Ws+uoUJD/QlO24bygI0
         bpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tbm8LP+GQmxiRLKk4IaXQbKrXlklfHAqd61jMTjQWZ4=;
        b=qsCBZSjdiW5x1+EmDZaNfrP60VvdZuOyOHKT9BQ0oyw30opU8V7AneD5HtmIohTIAH
         UzemgszBbE99w9SbeeAOliNzp5NJMew0FbG8eu8vJXK8kUNrxOxXBkvUuHfSv//UM6iJ
         1zQiM+jhKiw+84i+GZjD6Gk1w8k5c49pFxuLvTMoq+L6nbdntfCIGXPhjdjay4rwwcWK
         ZdjMmSHRPUDPfYH2EJfk2Jpb+70XA8K3O8Dh58Nr1/wQLiwTdjOtW0zfx3zeJp8I7pZQ
         Lo6Zaugcg4cSzgbaZmDasaqylUEtjypRtZFaG+7ZU9caUg4nYuKzFnH/Db/rAjNkDlnG
         0lqw==
X-Gm-Message-State: AOAM532eI8JeNBD09c4vm9eDRfknVgfwMRgrPb8HJk0G1/6gJSojjtaa
        4qTR0j1gLFFapwWr7DJlQ0nETiGNcYk=
X-Google-Smtp-Source: ABdhPJzzfQEqcy9KS+rt4JaO6lE54jEfVls0s98Yjjnz3GOVZyOvnGYobJvh1Mulv7Qc9G3FS+Y1SQ==
X-Received: by 2002:adf:bbc2:: with SMTP id z2mr15961380wrg.582.1638470404165;
        Thu, 02 Dec 2021 10:40:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n184sm2896495wme.2.2021.12.02.10.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 10:40:03 -0800 (PST)
Message-Id: <pull.1147.v3.git.git.1638470403.gitgitgadget@gmail.com>
In-Reply-To: <pull.1147.v2.git.git.1638211786.gitgitgadget@gmail.com>
References: <pull.1147.v2.git.git.1638211786.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 02 Dec 2021 18:39:54 +0000
Subject: [PATCH v3 0/8] Allow writing invalid OIDs into refs for testing purposes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

this covers a few cases of direct filesystem access to the ref database in
tests.

v3:

 * parse symbolic constants in ref-store test-helper.

Han-Wen Nienhuys (8):
  test-ref-store: remove force-create argument for create-reflog
  test-ref-store: parse symbolic flag constants
  test-ref-store: plug memory leak in cmd_delete_refs
  refs: update comment.
  refs: introduce REF_SKIP_OID_VERIFICATION flag
  refs: introduce REF_SKIP_REFNAME_VERIFICATION flag
  t1430: remove refs using test-tool
  t1430: create valid symrefs using test-helper

 refs.c                         |  7 +--
 refs.h                         | 16 +++++-
 refs/files-backend.c           | 53 ++++++++++---------
 t/helper/test-ref-store.c      | 78 ++++++++++++++++++++++++----
 t/t1006-cat-file.sh            |  5 +-
 t/t1405-main-ref-store.sh      |  8 ++-
 t/t1406-submodule-ref-store.sh |  2 +-
 t/t1430-bad-ref-name.sh        | 93 ++++++++++++++++++----------------
 t/t3800-mktag.sh               |  6 ++-
 9 files changed, 175 insertions(+), 93 deletions(-)


base-commit: abe6bb3905392d5eb6b01fa6e54d7e784e0522aa
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1147%2Fhanwen%2Fskip-verification-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1147/hanwen/skip-verification-v3
Pull-Request: https://github.com/git/git/pull/1147

Range-diff vs v2:

 -:  ----------- > 1:  3649ef6d0fa test-ref-store: remove force-create argument for create-reflog
 -:  ----------- > 2:  3cdebd2dbca test-ref-store: parse symbolic flag constants
 1:  7fa5c247c8b ! 3:  536005d65a2 test-ref-store: plug memory leak in cmd_delete_refs
     @@ Commit message
      
       ## t/helper/test-ref-store.c ##
      @@ t/helper/test-ref-store.c: static int cmd_delete_refs(struct ref_store *refs, const char **argv)
     - 	unsigned int flags = arg_flags(*argv++, "flags");
     + 	unsigned int flags = arg_flags(*argv++, "flags", transaction_flags);
       	const char *msg = *argv++;
       	struct string_list refnames = STRING_LIST_INIT_NODUP;
     --
      +	int result;
     + 
       	while (*argv)
       		string_list_append(&refnames, *argv++);
       
 2:  82971ddbfcf = 4:  466b4451015 refs: update comment.
 3:  93fe3f03fb2 ! 5:  89d692a34b8 refs: allow skipping OID verification
     @@ Metadata
      Author: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Commit message ##
     -    refs: allow skipping OID verification
     +    refs: introduce REF_SKIP_OID_VERIFICATION flag
      
     -    This introduces the REF_SKIP_OID_VERIFICATION flag, which lets the ref-store
     -    test helper write non-existent or unparsable objects into the ref storage.
     +    This lets the ref-store test helper write non-existent or unparsable objects
     +    into the ref storage.
      
          Use this to make t1006 and t3800 independent of the files storage backend.
      
     @@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *ref
       
       			/*
      
     + ## t/helper/test-ref-store.c ##
     +@@ t/helper/test-ref-store.c: static int cmd_create_symref(struct ref_store *refs, const char **argv)
     + static struct flag_definition transaction_flags[] = {
     + 	FLAG_DEF(REF_NO_DEREF),
     + 	FLAG_DEF(REF_FORCE_CREATE_REFLOG),
     ++	FLAG_DEF(REF_SKIP_OID_VERIFICATION),
     + 	{ NULL, 0 },
     + };
     + 
     +
       ## t/t1006-cat-file.sh ##
      @@ t/t1006-cat-file.sh: test_expect_success 'the --allow-unknown-type option does not consider replaceme
       	# Create it manually, as "git replace" will die on bogus
     @@ t/t1006-cat-file.sh: test_expect_success 'the --allow-unknown-type option does n
      -	mkdir -p .git/refs/replace &&
      -	echo $head >.git/refs/replace/$bogus_short_sha1 &&
      +	test_when_finished "test-tool ref-store main delete-refs 0 msg refs/replace/$bogus_short_sha1" &&
     -+	test-tool ref-store main update-ref msg "refs/replace/$bogus_short_sha1" $head $ZERO_OID 1024 &&
     ++	test-tool ref-store main update-ref msg "refs/replace/$bogus_short_sha1" $head $ZERO_OID REF_SKIP_OID_VERIFICATION &&
       
       	cat >expect <<-EOF &&
       	commit
     @@ t/t3800-mktag.sh: check_verify_failure () {
       		# update-ref
      -		echo "$bad_tag" >"bad-tag/$tag_ref" &&
      +		test-tool -C bad-tag ref-store main delete-refs 0 msg "$tag_ref" &&
     -+		test-tool -C bad-tag ref-store main update-ref msg "$tag_ref" $bad_tag $ZERO_OID 1024 &&
     ++		test-tool -C bad-tag ref-store main update-ref msg "$tag_ref" $bad_tag $ZERO_OID REF_SKIP_OID_VERIFICATION &&
       
       		# Unlike fsck-ing unreachable content above, this
       		# will always fail.
     @@ t/t3800-mktag.sh: check_verify_failure () {
       
      -		echo "$bad_tag" >"bad-tag/$tag_ref" &&
      +		test-tool -C bad-tag ref-store main delete-refs 0 msg "$tag_ref" &&
     -+		test-tool -C bad-tag ref-store main update-ref msg "$tag_ref" $bad_tag $ZERO_OID 1024 &&
     ++		test-tool -C bad-tag ref-store main update-ref msg "$tag_ref" $bad_tag $ZERO_OID REF_SKIP_OID_VERIFICATION &&
       
       		printf "%s tag\t%s\n" "$bad_tag" "$tag_ref" >expected &&
       		git -C bad-tag for-each-ref "$tag_ref" >actual &&
 4:  0a297f0c3e8 ! 6:  af9e94935bf refs: add REF_SKIP_REFNAME_VERIFICATION flag
     @@ Metadata
      Author: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Commit message ##
     -    refs: add REF_SKIP_REFNAME_VERIFICATION flag
     +    refs: introduce REF_SKIP_REFNAME_VERIFICATION flag
      
          Use this flag with the test-helper in t1430, to avoid direct writes to the ref
          database.
     @@ refs.h: struct ref_transaction *ref_transaction_begin(struct strbuf *err);
       /*
        * Add a reference update to transaction. `new_oid` is the value that
      
     + ## t/helper/test-ref-store.c ##
     +@@ t/helper/test-ref-store.c: static struct flag_definition transaction_flags[] = {
     + 	FLAG_DEF(REF_NO_DEREF),
     + 	FLAG_DEF(REF_FORCE_CREATE_REFLOG),
     + 	FLAG_DEF(REF_SKIP_OID_VERIFICATION),
     ++	FLAG_DEF(REF_SKIP_REFNAME_VERIFICATION),
     + 	{ NULL, 0 },
     + };
     + 
     +
       ## t/t1430-bad-ref-name.sh ##
      @@ t/t1430-bad-ref-name.sh: TEST_PASSES_SANITIZE_LEAK=true
       
     @@ t/t1430-bad-ref-name.sh: test_expect_success 'fast-import: fail on invalid branc
       test_expect_success 'git branch shows badly named ref as warning' '
      -	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
      -	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
     -+	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID 2048 &&
     -+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
     ++	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
     ++	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
       	git branch >output 2>error &&
       	test_i18ngrep -e "ignoring ref with broken name refs/heads/broken\.\.\.ref" error &&
       	! grep -e "broken\.\.\.ref" output
     @@ t/t1430-bad-ref-name.sh: test_expect_success 'fast-import: fail on invalid branc
       test_expect_success 'branch -d can delete badly named ref' '
      -	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
      -	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
     -+	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID 2048 &&
     -+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
     ++	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
     ++	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
       	git branch -d broken...ref &&
       	git branch >output 2>error &&
       	! grep -e "broken\.\.\.ref" error &&
     @@ t/t1430-bad-ref-name.sh: test_expect_success 'branch -d can delete badly named r
       test_expect_success 'branch -D can delete badly named ref' '
      -	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
      -	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
     -+	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID 2048 &&
     -+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
     ++	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
     ++	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
       	git branch -D broken...ref &&
       	git branch >output 2>error &&
       	! grep -e "broken\.\.\.ref" error &&
     @@ t/t1430-bad-ref-name.sh: test_expect_success 'branch -D cannot delete absolute p
       
       test_expect_success 'git branch cannot create a badly named ref' '
      -	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
     -+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
     ++	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
       	test_must_fail git branch broken...ref &&
       	git branch >output 2>error &&
       	! grep -e "broken\.\.\.ref" error &&
     @@ t/t1430-bad-ref-name.sh: test_expect_success 'git branch cannot create a badly n
       
       test_expect_success 'branch -m cannot rename to a bad ref name' '
      -	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
     -+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
     ++	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
       	test_might_fail git branch -D goodref &&
       	git branch goodref &&
       	test_must_fail git branch -m goodref broken...ref &&
     @@ t/t1430-bad-ref-name.sh: test_expect_success 'branch -m cannot rename to a bad r
       test_expect_failure 'branch -m can rename from a bad ref name' '
      -	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
      -	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
     -+	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID 2048 &&
     ++	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
      +
     -+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
     ++	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
       	git branch -m broken...ref renamed &&
       	test_cmp_rev main renamed &&
       	git branch >output 2>error &&
     @@ t/t1430-bad-ref-name.sh: test_expect_failure 'branch -m can rename from a bad re
       
       test_expect_success 'push cannot create a badly named ref' '
      -	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
     -+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
     ++	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
       	test_must_fail git push "file://$(pwd)" HEAD:refs/heads/broken...ref &&
       	git branch >output 2>error &&
       	! grep -e "broken\.\.\.ref" error &&
     @@ t/t1430-bad-ref-name.sh: test_expect_failure 'push --mirror can delete badly nam
       		test_commit two &&
       		git checkout --detach &&
      -		cp .git/refs/heads/main .git/refs/heads/broken...ref
     -+		test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID 2048
     ++		test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION
       	) &&
       	git -C src push --mirror "file://$top/dest" &&
       	git -C dest branch >output 2>error &&
     @@ t/t1430-bad-ref-name.sh: test_expect_failure 'push --mirror can delete badly nam
       
       test_expect_success 'rev-parse skips symref pointing to broken name' '
      -	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
     -+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
     ++	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
       	git branch shadow one &&
      -	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
     -+	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID 2048 &&
     ++	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
       	printf "ref: refs/heads/broken...ref\n" >.git/refs/tags/shadow &&
       	test_when_finished "rm -f .git/refs/tags/shadow" &&
       	git rev-parse --verify one >expect &&
     @@ t/t1430-bad-ref-name.sh: test_expect_success 'rev-parse skips symref pointing to
       test_expect_success 'for-each-ref emits warnings for broken names' '
      -	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
      -	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
     -+	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID 2048 &&
     -+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
     ++	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
     ++	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
       	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
       	test_when_finished "rm -f .git/refs/heads/badname" &&
       	printf "ref: refs/heads/main\n" >.git/refs/heads/broken...symref &&
     @@ t/t1430-bad-ref-name.sh: test_expect_success 'for-each-ref emits warnings for br
       test_expect_success 'update-ref -d can delete broken name' '
      -	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
      -	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
     -+	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID 2048 &&
     -+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
     ++	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
     ++	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
       	git update-ref -d refs/heads/broken...ref >output 2>error &&
       	test_must_be_empty output &&
       	test_must_be_empty error &&
     @@ t/t1430-bad-ref-name.sh: test_expect_success 'update-ref -d can delete broken na
       test_expect_success 'branch -d can delete broken name' '
      -	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
      -	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
     -+	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID 2048 &&
     -+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
     ++	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
     ++	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
       	git branch -d broken...ref >output 2>error &&
       	test_i18ngrep "Deleted branch broken...ref (was broken)" output &&
       	test_must_be_empty error &&
     @@ t/t1430-bad-ref-name.sh: test_expect_success 'branch -d can delete broken name'
       test_expect_success 'update-ref --no-deref -d can delete symref to broken name' '
      -	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
      -	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
     -+	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID 2048 &&
     ++	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
      +
     -+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
     ++	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
       	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
       	test_when_finished "rm -f .git/refs/heads/badname" &&
       	git update-ref --no-deref -d refs/heads/badname >output 2>error &&
     @@ t/t1430-bad-ref-name.sh: test_expect_success 'update-ref --no-deref -d can delet
       test_expect_success 'branch -d can delete symref to broken name' '
      -	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
      -	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
     -+	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID 2048 &&
     ++	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
      +
     -+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
     ++	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
       	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
       	test_when_finished "rm -f .git/refs/heads/badname" &&
       	git branch -d badname >output 2>error &&
     @@ t/t1430-bad-ref-name.sh: test_expect_success 'branch -d can delete dangling symr
       test_expect_success 'update-ref -d can delete broken name through symref' '
      -	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
      -	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
     -+	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID 2048 &&
     ++	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
      +
     -+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
     ++	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
       	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
       	test_when_finished "rm -f .git/refs/heads/badname" &&
       	git update-ref -d refs/heads/badname >output 2>error &&
 5:  06c8ff7df15 ! 7:  d4f1d209468 t1430: remove refs using test-tool
     @@ Commit message
       ## t/t1430-bad-ref-name.sh ##
      @@ t/t1430-bad-ref-name.sh: test_expect_success 'rev-parse skips symref pointing to broken name' '
       	git branch shadow one &&
     - 	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID 2048 &&
     + 	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
       	printf "ref: refs/heads/broken...ref\n" >.git/refs/tags/shadow &&
      -	test_when_finished "rm -f .git/refs/tags/shadow" &&
     -+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/tags/shadow" &&
     ++	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/tags/shadow" &&
       	git rev-parse --verify one >expect &&
       	git rev-parse --verify shadow >actual 2>err &&
       	test_cmp expect actual &&
      @@ t/t1430-bad-ref-name.sh: test_expect_success 'for-each-ref emits warnings for broken names' '
     - 	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID 2048 &&
     - 	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
     + 	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
     + 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
       	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
      -	test_when_finished "rm -f .git/refs/heads/badname" &&
     -+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/badname" &&
     ++	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/badname" &&
       	printf "ref: refs/heads/main\n" >.git/refs/heads/broken...symref &&
      -	test_when_finished "rm -f .git/refs/heads/broken...symref" &&
     -+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...symref" &&
     ++	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...symref" &&
       	git for-each-ref >output 2>error &&
       	! grep -e "broken\.\.\.ref" output &&
       	! grep -e "badname" output &&
      @@ t/t1430-bad-ref-name.sh: test_expect_success 'update-ref --no-deref -d can delete symref to broken name'
       
     - 	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
     + 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
       	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
      -	test_when_finished "rm -f .git/refs/heads/badname" &&
     -+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/badname" &&
     ++	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/badname" &&
       	git update-ref --no-deref -d refs/heads/badname >output 2>error &&
       	test_path_is_missing .git/refs/heads/badname &&
       	test_must_be_empty output &&
      @@ t/t1430-bad-ref-name.sh: test_expect_success 'branch -d can delete symref to broken name' '
       
     - 	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
     + 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
       	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
      -	test_when_finished "rm -f .git/refs/heads/badname" &&
     -+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/badname" &&
     ++	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/badname" &&
       	git branch -d badname >output 2>error &&
       	test_path_is_missing .git/refs/heads/badname &&
       	test_i18ngrep "Deleted branch badname (was refs/heads/broken\.\.\.ref)" output &&
     @@ t/t1430-bad-ref-name.sh: test_expect_success 'branch -d can delete symref to bro
       test_expect_success 'update-ref --no-deref -d can delete dangling symref to broken name' '
       	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
      -	test_when_finished "rm -f .git/refs/heads/badname" &&
     -+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/badname" &&
     ++	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/badname" &&
       	git update-ref --no-deref -d refs/heads/badname >output 2>error &&
       	test_path_is_missing .git/refs/heads/badname &&
       	test_must_be_empty output &&
     @@ t/t1430-bad-ref-name.sh: test_expect_success 'update-ref --no-deref -d can delet
       test_expect_success 'branch -d can delete dangling symref to broken name' '
       	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
      -	test_when_finished "rm -f .git/refs/heads/badname" &&
     -+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/badname" &&
     ++	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/badname" &&
       	git branch -d badname >output 2>error &&
       	test_path_is_missing .git/refs/heads/badname &&
       	test_i18ngrep "Deleted branch badname (was refs/heads/broken\.\.\.ref)" output &&
      @@ t/t1430-bad-ref-name.sh: test_expect_success 'update-ref -d can delete broken name through symref' '
       
     - 	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
     + 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
       	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
      -	test_when_finished "rm -f .git/refs/heads/badname" &&
     -+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/badname" &&
     ++	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/badname" &&
       	git update-ref -d refs/heads/badname >output 2>error &&
       	test_path_is_missing .git/refs/heads/broken...ref &&
       	test_must_be_empty output &&
     @@ t/t1430-bad-ref-name.sh: test_expect_success 'update-ref -d can delete broken na
       test_expect_success 'update-ref --no-deref -d can delete symref with broken name' '
       	printf "ref: refs/heads/main\n" >.git/refs/heads/broken...symref &&
      -	test_when_finished "rm -f .git/refs/heads/broken...symref" &&
     -+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...symref" &&
     ++	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...symref" &&
       	git update-ref --no-deref -d refs/heads/broken...symref >output 2>error &&
       	test_path_is_missing .git/refs/heads/broken...symref &&
       	test_must_be_empty output &&
     @@ t/t1430-bad-ref-name.sh: test_expect_success 'update-ref --no-deref -d can delet
       test_expect_success 'branch -d can delete symref with broken name' '
       	printf "ref: refs/heads/main\n" >.git/refs/heads/broken...symref &&
      -	test_when_finished "rm -f .git/refs/heads/broken...symref" &&
     -+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...symref" &&
     ++	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...symref" &&
       	git branch -d broken...symref >output 2>error &&
       	test_path_is_missing .git/refs/heads/broken...symref &&
       	test_i18ngrep "Deleted branch broken...symref (was refs/heads/main)" output &&
     @@ t/t1430-bad-ref-name.sh: test_expect_success 'branch -d can delete symref with b
       test_expect_success 'update-ref --no-deref -d can delete dangling symref with broken name' '
       	printf "ref: refs/heads/idonotexist\n" >.git/refs/heads/broken...symref &&
      -	test_when_finished "rm -f .git/refs/heads/broken...symref" &&
     -+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...symref" &&
     ++	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...symref" &&
       	git update-ref --no-deref -d refs/heads/broken...symref >output 2>error &&
       	test_path_is_missing .git/refs/heads/broken...symref &&
       	test_must_be_empty output &&
     @@ t/t1430-bad-ref-name.sh: test_expect_success 'update-ref --no-deref -d can delet
       test_expect_success 'branch -d can delete dangling symref with broken name' '
       	printf "ref: refs/heads/idonotexist\n" >.git/refs/heads/broken...symref &&
      -	test_when_finished "rm -f .git/refs/heads/broken...symref" &&
     -+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...symref" &&
     ++	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...symref" &&
       	git branch -d broken...symref >output 2>error &&
       	test_path_is_missing .git/refs/heads/broken...symref &&
       	test_i18ngrep "Deleted branch broken...symref (was refs/heads/idonotexist)" output &&
 6:  3c100702fda ! 8:  ca7f8aea3d9 t1430: create valid symrefs using test-helper
     @@ Commit message
      
       ## t/t1430-bad-ref-name.sh ##
      @@ t/t1430-bad-ref-name.sh: test_expect_success 'rev-parse skips symref pointing to broken name' '
     - 	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
     + 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
       	git branch shadow one &&
     - 	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID 2048 &&
     + 	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
      -	printf "ref: refs/heads/broken...ref\n" >.git/refs/tags/shadow &&
      +	test-tool ref-store main create-symref refs/tags/shadow refs/heads/broken...ref msg &&
     - 	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/tags/shadow" &&
     + 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/tags/shadow" &&
       	git rev-parse --verify one >expect &&
       	git rev-parse --verify shadow >actual 2>err &&
      @@ t/t1430-bad-ref-name.sh: test_expect_success 'update-ref --no-deref -d can delete symref to broken name'
     - 	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID 2048 &&
     + 	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
       
     - 	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
     + 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
      -	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
      +	test-tool ref-store main create-symref refs/heads/badname refs/heads/broken...ref msg &&
     - 	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/badname" &&
     + 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/badname" &&
       	git update-ref --no-deref -d refs/heads/badname >output 2>error &&
       	test_path_is_missing .git/refs/heads/badname &&
     -@@ t/t1430-bad-ref-name.sh: test_expect_success 'branch -d can delete symref to broken name' '
     - 	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID 2048 &&
     +@@ t/t1430-bad-ref-name.sh: test_expect_success 'update-ref --no-deref -d can delete symref to broken name'
       
     - 	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
     + test_expect_success 'branch -d can delete symref to broken name' '
     + 	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
     +-
     + 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
      -	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
      +	test-tool ref-store main create-symref refs/heads/badname refs/heads/broken...ref msg &&
     - 	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/badname" &&
     + 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/badname" &&
       	git branch -d badname >output 2>error &&
       	test_path_is_missing .git/refs/heads/badname &&
      @@ t/t1430-bad-ref-name.sh: test_expect_success 'branch -d can delete symref to broken name' '
     @@ t/t1430-bad-ref-name.sh: test_expect_success 'branch -d can delete symref to bro
       test_expect_success 'update-ref --no-deref -d can delete dangling symref to broken name' '
      -	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
      +	test-tool ref-store main create-symref refs/heads/badname refs/heads/broken...ref msg &&
     - 	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/badname" &&
     + 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/badname" &&
       	git update-ref --no-deref -d refs/heads/badname >output 2>error &&
       	test_path_is_missing .git/refs/heads/badname &&
      @@ t/t1430-bad-ref-name.sh: test_expect_success 'update-ref --no-deref -d can delete dangling symref to brok
     @@ t/t1430-bad-ref-name.sh: test_expect_success 'update-ref --no-deref -d can delet
       test_expect_success 'branch -d can delete dangling symref to broken name' '
      -	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
      +	test-tool ref-store main create-symref refs/heads/badname refs/heads/broken...ref msg &&
     - 	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/badname" &&
     + 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/badname" &&
       	git branch -d badname >output 2>error &&
       	test_path_is_missing .git/refs/heads/badname &&
     -@@ t/t1430-bad-ref-name.sh: test_expect_success 'update-ref -d can delete broken name through symref' '
     - 	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID 2048 &&
     +@@ t/t1430-bad-ref-name.sh: test_expect_success 'branch -d can delete dangling symref to broken name' '
       
     - 	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
     + test_expect_success 'update-ref -d can delete broken name through symref' '
     + 	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
     +-
     + 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
      -	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
      +	test-tool ref-store main create-symref refs/heads/badname refs/heads/broken...ref msg &&
     - 	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/badname" &&
     + 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/badname" &&
       	git update-ref -d refs/heads/badname >output 2>error &&
       	test_path_is_missing .git/refs/heads/broken...ref &&

-- 
gitgitgadget
