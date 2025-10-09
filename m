Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574452E0415
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 11:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760007790; cv=none; b=b+1m0kthRkawYbOij/ifsyN+jks9JHzzBgFOpWwPKNTu74WooA7HKCTtxP/e1s2C4vLVMOyKlbc5nhwOq+KS4/LOFQl/4uhoKL9hNZF6HGsdAlyFOs/JmhIelKEeSpcdho96eloorAbkhX7hPMdcpdEgQwXk1Vw+wxp376aZdxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760007790; c=relaxed/simple;
	bh=fzx5dSl/g03hsIw8VjbYBOAV6wh1N7SE/6dgGEEXHFo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ciD5V/0FldRM6GIvjNLNxClGKB5B5uQ7rpgv+1b8UfnCu+wNundPytNl0y/cCrE//FxURi4xJXzcpPekB52fx6IA2JVA/cIM+ksct3H2Wlug/z94EtFnrUGx3joh16WDA1EUILmEIwuqGftRSpRLk5/bFhG6C7ATtJ6X6oell+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvFPMRU1; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvFPMRU1"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-856cbf74c4aso113818885a.2
        for <git@vger.kernel.org>; Thu, 09 Oct 2025 04:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760007785; x=1760612585; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afSoJl7WVzcfZcl+P7vLc6HdySQ+UzhbWw7MLLDG5UY=;
        b=KvFPMRU1/uH/24kzIEj3FKpRijSc/HGJJGu7/Ac2+YZWvwVaCufviZw9tHiEp7CBaE
         kMedN3ilpcK5pGId/g775P2COhsl7naEzk9/PGzXspnHG6IJU/r1Mcaf2/8bNhrpAzvC
         v0W37kNfQK+DafgVd5nP2QvWWhULeogGy85rtFEnzBsaepJnvH1P50F8IkHmIEZCZU10
         RU5qi+ooIUlkk+2VtzL89FcVit8cNwAcStizwIp2rYrKtXg1xr9cfgv3uhMD/or5blMU
         aO/i6PS1o1m1/mE9CF0eZbJcuGXNQz/srXKhF1FuiDFFJpaVZtu6zF92O9Y/IXyaT4vt
         Ygjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760007785; x=1760612585;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afSoJl7WVzcfZcl+P7vLc6HdySQ+UzhbWw7MLLDG5UY=;
        b=kTRJS1AirAIiZCWJa8uEh1udta7Azn8ltwwH/a5oTFR5Tn8QicgGZ7egeWsUdQqzL1
         7NxrkNf7hOchFIv9YitymukH2oHinUsfFlJQuXl/XRzaD1gkzjwYf49HuR+oMhTNzUmK
         eDohUjx7SQUzmt3Y8x+D1+w9UnIPSBjG6bfPcWsv2Cz+nShGgtRvqn7k6htT6Nl0tsr6
         bvIBie9e2kv1vm3dyOk2S3VlJ3XPzdN2m5KR+yVaPo8yuJly2iNEO/qMvzb1LJvHIC5e
         tg23YhcJ6AFNc5w5aIFaOIrIeVukc0WrI7eDeza1irOoAqmslQkBuhDSUUM4Uz3ciJ7E
         oHzQ==
X-Gm-Message-State: AOJu0Yyu/taloaBJgowbwXQMGT7ZkpyYGkoe0r9fszqgRa0+UCDkbv4P
	+SUnLO/EOln+rYNOAjN9mIOzrJq0QQWnpRT6k1HtRfI67M5IoTvfLX6dWyslMbso
X-Gm-Gg: ASbGncsKmc9Wr12H1CfTu6aj8KaPgN/0OsooKjD+sY0vDx348/LeqRnAFTt2kG5JUyL
	yb2nAm2AC1J3kcnDOZAYyXCg+p0FiFkVKvO4+if4RjkyZyMyAPVLwXrCs8EQlPbChO8va5g6si0
	C9QAoskvcwMw+jKApdlU2LQV6hwchI6gzoYGCLacTbHtNRMEL2LIGv/APcly31AFYMUHWVkmvd+
	A4v1bZSd+YFUu7NaKBm6nBbF93kcYLvEWR/7PjUXNi/bT5PUyFKzWW52GJHptYK8dcln/a+hrF7
	s0UrnJY1L/vs9ntAETYwbjT0E42owxHe3XpJO70AO20tCHQ0qstZ8xM+JZFap5cYMQ3CuBGTkpG
	Wp/amzHDR1yEL47hI8jnUxljVQlYebEGtjIUsrorsxhqa91oWmO7wYyt0yPe5eTeRVqfBiuo=
X-Google-Smtp-Source: AGHT+IFd9QCTh8NL0ckYNZqtMRoMuxWgnT6yyzPMJH4YUfm/J9vC1KwDOcud+HdaAKbT+FD3ZkHknA==
X-Received: by 2002:a05:620a:6914:b0:811:76d4:6d4c with SMTP id af79cd13be357-88351de7e2dmr891602485a.10.1760007784979;
        Thu, 09 Oct 2025 04:03:04 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.223.97])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-884a2273e9dsm169668985a.47.2025.10.09.04.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 04:03:04 -0700 (PDT)
Message-Id: <pull.2067.v2.git.git.1760007783388.gitgitgadget@gmail.com>
In-Reply-To: <pull.2067.git.git.1759750539721.gitgitgadget@gmail.com>
References: <pull.2067.git.git.1759750539721.gitgitgadget@gmail.com>
From: "Miroma via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Oct 2025 11:03:03 +0000
Subject: [PATCH v2] stash: show correct entries count
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
    Miroma <its.miroma@proton.me>,
    Miroma <its.miroma@proton.me>

From: Miroma <its.miroma@proton.me>

Currently, 'stash apply' internally calls 'status' to show a summary of
what the command did. This also happens with 'stash pop', which roughly
corresponds to 'apply' + 'drop'.

When the configuration 'status.showStash' is set, 'status' shows a count
of stashed entries. This leads to the following, confusing, output:

```sh
$ # assuming there are two stashed entries
$ git stash pop
...
Your stash currently has 2 entries
Dropped refs/stash@{0} (abc123...)
$ # when actually...
$ git status --show-stash
...
Your stash currently has 1 entry
```

This patch changes the output format to the following, no matter the
value of 'status.showStash':

```sh
$ # assuming there's a stashed entry
$ git stash pop
...
Dropped refs/stash@{0} (abc123...)
Your stash now has 0 entries
```

This new output is only shown if the stash count has changed, which can
happen with the following subcommands:
'drop', 'pop', 'branch', 'store', 'push', 'save'.

Helped-by: Karthik Nayak <karthik.188@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Miroma <its.miroma@proton.me>
---
    stash: show correct entries count

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2067%2Fits-miroma%2Fstash-no-status-showStash-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2067/its-miroma/stash-no-status-showStash-v2
Pull-Request: https://github.com/git/git/pull/2067

Range-diff vs v1:

 1:  32a45cf3d2 < -:  ---------- stash: don't show irrelevant entry count in status
 -:  ---------- > 1:  1118bd68ac stash: show correct entries count


 builtin/stash.c  | 31 ++++++++++++++++++--
 t/t3903-stash.sh | 75 ++++++++++++++++++++++++++++--------------------
 wt-status.c      |  2 +-
 wt-status.h      |  1 +
 4 files changed, 75 insertions(+), 34 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 1977e50df2..1bee391fb2 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -32,6 +32,7 @@
 #include "add-interactive.h"
 #include "oid-array.h"
 #include "commit.h"
+#include "wt-status.h"
 
 #define INCLUDE_ALL_FILES 2
 
@@ -585,6 +586,20 @@ static void unstage_changes_unless_new(struct object_id *orig_tree)
 		die(_("could not write index"));
 }
 
+static int previous_stash_count = -1;
+
+static void print_stash_status(bool quiet)
+{
+	int stash_count;
+	stash_count = count_stash_entries();
+
+	if (quiet || stash_count == previous_stash_count || previous_stash_count == -1)
+		return;
+
+	printf_ln(Q_("Your stash now has %d entry",
+		"Your stash now has %d entries", stash_count), stash_count);
+}
+
 static int do_apply_stash(const char *prefix, struct stash_info *info,
 			  int index, int quiet)
 {
@@ -705,7 +720,7 @@ restore_untracked:
 			     absolute_path(repo_get_work_tree(the_repository)));
 		strvec_pushf(&cp.env, GIT_DIR_ENVIRONMENT"=%s",
 			     absolute_path(repo_get_git_dir(the_repository)));
-		strvec_push(&cp.args, "status");
+		strvec_pushl(&cp.args, "status", "--no-show-stash", NULL);
 		run_command(&cp);
 	}
 
@@ -756,6 +771,8 @@ static int reflog_is_empty(const char *refname)
 
 static int do_drop_stash(struct stash_info *info, int quiet)
 {
+	previous_stash_count = count_stash_entries();
+
 	if (!reflog_delete(info->revision.buf,
 			   EXPIRE_REFLOGS_REWRITE | EXPIRE_REFLOGS_UPDATE_REF,
 			   0)) {
@@ -805,6 +822,8 @@ static int drop_stash(int argc, const char **argv, const char *prefix,
 		goto cleanup;
 
 	ret = do_drop_stash(&info, quiet);
+	print_stash_status(quiet);
+
 cleanup:
 	free_stash_info(&info);
 	return ret;
@@ -836,6 +855,8 @@ static int pop_stash(int argc, const char **argv, const char *prefix,
 	else
 		ret = do_drop_stash(&info, quiet);
 
+	print_stash_status(quiet);
+
 cleanup:
 	free_stash_info(&info);
 	return ret;
@@ -875,6 +896,8 @@ static int branch_stash(int argc, const char **argv, const char *prefix,
 	if (!ret && info.is_stash_ref)
 		ret = do_drop_stash(&info, 0);
 
+	print_stash_status(0);
+
 cleanup:
 	free_stash_info(&info);
 	return ret;
@@ -1062,6 +1085,7 @@ static int do_store_stash(const struct object_id *w_commit, const char *stash_ms
 	struct stash_info info;
 	char revision[GIT_MAX_HEXSZ];
 
+	previous_stash_count = count_stash_entries();
 	oid_to_hex_r(revision, w_commit);
 	assert_stash_like(&info, revision);
 
@@ -1119,6 +1143,7 @@ static int store_stash(int argc, const char **argv, const char *prefix,
 	}
 
 	ret = do_store_stash(&obj, stash_msg, quiet);
+	print_stash_status(quiet);
 
 out:
 	object_context_release(&dummy);
@@ -1914,6 +1939,7 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 
 	ret = do_push_stash(&ps, stash_msg, quiet, keep_index, patch_mode,
 			    &add_p_opt, include_untracked, only_staged);
+	print_stash_status(quiet);
 
 	clear_pathspec(&ps);
 	free(pathspec_from_file);
@@ -1982,6 +2008,7 @@ static int save_stash(int argc, const char **argv, const char *prefix,
 	ret = do_push_stash(&ps, stash_msg, quiet, keep_index,
 			    patch_mode, &add_p_opt, include_untracked,
 			    only_staged);
+	print_stash_status(quiet);
 
 	strbuf_release(&stash_msg_buf);
 	return ret;
@@ -2291,7 +2318,7 @@ static int do_export_stash(struct repository *r,
 			.r = r, .items = iter,
 		};
 		if (refs_for_each_reflog_ent_reverse(get_main_ref_store(r),
-						     "refs/stash",
+						     ref_stash,
 						     collect_stash_entries,
 						     &cb_data) && cb_data.count)
 			goto out;
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 0bb4648e36..d3af50e404 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -49,7 +49,7 @@ diff_cmp () {
 	rm -f "$1.compare" "$2.compare"
 }
 
-setup_stash() {
+setup_stash () {
 	echo 1 >file &&
 	git add file &&
 	echo unrelated >other-file &&
@@ -60,13 +60,15 @@ setup_stash() {
 	git add file &&
 	echo 3 >file &&
 	test_tick &&
-	git stash &&
+	git stash | tail -n 1 >actual &&
 	git diff-files --quiet &&
 	git diff-index --cached --quiet HEAD
 }
 
-test_expect_success 'stash some dirty working directory' '
-	setup_stash
+test_expect_success 'stash reports stash count' '
+	setup_stash &&
+	echo "Your stash now has 1 entry" >expect &&
+	test_cmp expect actual
 '
 
 cat >expect <<EOF
@@ -145,12 +147,14 @@ test_expect_success 'stash drop complains of extra options' '
 
 test_expect_success 'drop top stash' '
 	git reset --hard &&
-	git stash list >expected &&
+	git stash list >expect &&
 	echo 7 >file &&
 	git stash &&
-	git stash drop &&
+	git stash drop | tail -n 1 >msg-actual &&
+	echo "Your stash now has 1 entry" >msg-expect &&
+	test_cmp msg-expect msg-actual &&
 	git stash list >actual &&
-	test_cmp expected actual &&
+	test_cmp expect actual &&
 	git stash apply &&
 	test 3 = $(cat file) &&
 	test 1 = $(git show :file) &&
@@ -236,14 +240,18 @@ test_expect_success 'drop stash reflog updates refs/stash with rewrite' '
 
 test_expect_success 'stash pop' '
 	git reset --hard &&
-	git stash pop &&
+	git stash pop | tail -n 1 >actual &&
+	echo "Your stash now has 0 entries" >expect &&
+	test_cmp expect actual &&
 	test 3 = $(cat file) &&
 	test 1 = $(git show :file) &&
 	test 1 = $(git show HEAD:file) &&
 	test 0 = $(git stash list | wc -l)
 '
 
-cat >expect <<EOF
+echo "Your stash now has 0 entries" >expect
+
+cat >expect1 <<EOF
 diff --git a/file2 b/file2
 new file mode 100644
 index 0000000..1fe912c
@@ -253,7 +261,7 @@ index 0000000..1fe912c
 +bar2
 EOF
 
-cat >expect1 <<EOF
+cat >expect2 <<EOF
 diff --git a/file b/file
 index 257cc56..5716ca5 100644
 --- a/file
@@ -263,7 +271,7 @@ index 257cc56..5716ca5 100644
 +bar
 EOF
 
-cat >expect2 <<EOF
+cat >expect3 <<EOF
 diff --git a/file b/file
 index 7601807..5716ca5 100644
 --- a/file
@@ -289,17 +297,18 @@ test_expect_success 'stash branch' '
 	git stash &&
 	echo baz >file &&
 	git commit file -m second &&
-	git stash branch stashbranch &&
+	git stash branch stashbranch | tail -n 1 >actual &&
+	test_cmp expect actual &&
 	test refs/heads/stashbranch = $(git symbolic-ref HEAD) &&
 	test $(git rev-parse HEAD) = $(git rev-parse main^) &&
 	git diff --cached >output &&
-	diff_cmp expect output &&
-	git diff >output &&
 	diff_cmp expect1 output &&
+	git diff >output &&
+	diff_cmp expect2 output &&
 	git add file &&
 	git commit -m alternate\ second &&
 	git diff main..stashbranch >output &&
-	diff_cmp output expect2 &&
+	diff_cmp output expect3 &&
 	test 0 = $(git stash list | wc -l)
 '
 
@@ -427,7 +436,9 @@ test_expect_success 'stash an added file' '
 	git reset --hard &&
 	echo new >file3 &&
 	git add file3 &&
-	git stash save "added file" &&
+	git stash save "added file" | tail -n 1 >actual &&
+	echo "Your stash now has 6 entries" >expect &&
+	test_cmp expect actual &&
 	! test -r file3 &&
 	git stash apply &&
 	test new = "$(cat file3)"
@@ -683,12 +694,12 @@ test_expect_success 'stash show format defaults to --stat' '
 	echo bar >>file &&
 	STASH_ID=$(git stash create) &&
 	git reset --hard &&
-	cat >expected <<-EOF &&
+	cat >expect <<-EOF &&
 	 file | 1 +
 	 1 file changed, 1 insertion(+)
 	EOF
 	git stash show ${STASH_ID} >actual &&
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'stash show - stashes on stack, stash-like argument' '
@@ -701,9 +712,9 @@ test_expect_success 'stash show - stashes on stack, stash-like argument' '
 	echo bar >>file &&
 	STASH_ID=$(git stash create) &&
 	git reset --hard &&
-	echo "1	0	file" >expected &&
+	echo "1	0	file" >expect &&
 	git stash show --numstat ${STASH_ID} >actual &&
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'stash show -p - stashes on stack, stash-like argument' '
@@ -716,7 +727,7 @@ test_expect_success 'stash show -p - stashes on stack, stash-like argument' '
 	echo bar >>file &&
 	STASH_ID=$(git stash create) &&
 	git reset --hard &&
-	cat >expected <<-EOF &&
+	cat >expect <<-EOF &&
 	diff --git a/file b/file
 	index 7601807..935fbd3 100644
 	--- a/file
@@ -726,7 +737,7 @@ test_expect_success 'stash show -p - stashes on stack, stash-like argument' '
 	+bar
 	EOF
 	git stash show -p ${STASH_ID} >actual &&
-	diff_cmp expected actual
+	diff_cmp expect actual
 '
 
 test_expect_success 'stash show - no stashes on stack, stash-like argument' '
@@ -736,9 +747,9 @@ test_expect_success 'stash show - no stashes on stack, stash-like argument' '
 	echo foo >>file &&
 	STASH_ID=$(git stash create) &&
 	git reset --hard &&
-	echo "1	0	file" >expected &&
+	echo "1	0	file" >expect &&
 	git stash show --numstat ${STASH_ID} >actual &&
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'stash show -p - no stashes on stack, stash-like argument' '
@@ -748,7 +759,7 @@ test_expect_success 'stash show -p - no stashes on stack, stash-like argument' '
 	echo foo >>file &&
 	STASH_ID=$(git stash create) &&
 	git reset --hard &&
-	cat >expected <<-EOF &&
+	cat >expect <<-EOF &&
 	diff --git a/file b/file
 	index 7601807..71b52c4 100644
 	--- a/file
@@ -758,7 +769,7 @@ test_expect_success 'stash show -p - no stashes on stack, stash-like argument' '
 	+foo
 	EOF
 	git stash show -p ${STASH_ID} >actual &&
-	diff_cmp expected actual
+	diff_cmp expect actual
 '
 
 test_expect_success 'stash show --patience shows diff' '
@@ -766,7 +777,7 @@ test_expect_success 'stash show --patience shows diff' '
 	echo foo >>file &&
 	STASH_ID=$(git stash create) &&
 	git reset --hard &&
-	cat >expected <<-EOF &&
+	cat >expect <<-EOF &&
 	diff --git a/file b/file
 	index 7601807..71b52c4 100644
 	--- a/file
@@ -776,7 +787,7 @@ test_expect_success 'stash show --patience shows diff' '
 	+foo
 	EOF
 	git stash show --patience ${STASH_ID} >actual &&
-	diff_cmp expected actual
+	diff_cmp expect actual
 '
 
 test_expect_success 'drop: fail early if specified stash is not a stash ref' '
@@ -915,7 +926,7 @@ test_expect_success 'apply: show same status as git status (relative to ./)' '
 		sane_unset GIT_MERGE_VERBOSITY &&
 		git stash apply
 	) |
-	sed -e 1d >actual && # drop "Saved..."
+	sed -e 1,2d >actual && # drop "Your stash now has 1 entry" and "Saved..."
 	test_cmp expect actual
 '
 
@@ -959,9 +970,11 @@ test_expect_success 'store updates stash ref and reflog' '
 	STASH_ID=$(git stash create) &&
 	git reset --hard &&
 	test_path_is_missing bazzy &&
-	git stash store -m quuxery $STASH_ID &&
+	git stash store -m quuxery $STASH_ID | tail -n 1 >actual &&
+	echo "Your stash now has 1 entry" >expect &&
+	test_cmp expect actual &&
 	test $(git rev-parse stash) = $STASH_ID &&
-	git reflog --format=%H stash| grep $STASH_ID &&
+	git reflog --format=%H stash | grep $STASH_ID &&
 	git stash pop &&
 	grep quux bazzy
 '
diff --git a/wt-status.c b/wt-status.c
index 454601afa1..6bdf71efee 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -983,7 +983,7 @@ static int stash_count_refs(struct object_id *ooid UNUSED,
 	return 0;
 }
 
-static int count_stash_entries(void)
+int count_stash_entries(void)
 {
 	int n = 0;
 	refs_for_each_reflog_ent(get_main_ref_store(the_repository),
diff --git a/wt-status.h b/wt-status.h
index 4e377ce62b..daccde0b6e 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -151,6 +151,7 @@ size_t wt_status_locate_end(const char *s, size_t len);
 void wt_status_append_cut_line(struct strbuf *buf);
 void wt_status_add_cut_line(struct wt_status *s);
 void wt_status_prepare(struct repository *r, struct wt_status *s);
+int count_stash_entries(void);
 void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
 /*

base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
-- 
gitgitgadget
