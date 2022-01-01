Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168C7C433EF
	for <git@archiver.kernel.org>; Sat,  1 Jan 2022 14:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbiAAOjT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Jan 2022 09:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbiAAOjS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jan 2022 09:39:18 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B973C061574
        for <git@vger.kernel.org>; Sat,  1 Jan 2022 06:39:18 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so28046901pjp.0
        for <git@vger.kernel.org>; Sat, 01 Jan 2022 06:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a5ID8IDbuI9hbVHEHy4+09JJbRpaMHvoNzWzxAYDqIs=;
        b=i7ZDTIK/c0/I9hYtwFGCCFCxushVzwyH7YYjkLDCXb8SpU1GqFwDHlKu1UzR8E1H4k
         DAuHklKM6JuiHH1N2ow0LK/b2NDswmI6vJZD9//vhBQsFQvBCRN1e5ZUuueWbUGbx65r
         1Ko0uRoSsxoRm94uO8l/KxJ3hVfrZ/fy2sVwkb7sbULKvmH77KIZzvYzQcyUIpf7tO8L
         l9ub86k2NCUxO3ykcpj3eUuiyqB+QRJ8oumo8N09ZpEiWKIsnkd+OuuG9QyjLUmz4Xnt
         KHog58l2+xyTM+7mXPK5ix41z2uYagP1569haBzedMkpPmp+HtW11ATa0noiy64IWgVr
         dMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a5ID8IDbuI9hbVHEHy4+09JJbRpaMHvoNzWzxAYDqIs=;
        b=DgFZ18MnZlEYADA1UkSjjDvHCxzpAl8Ou80sxp9dVl8jdsh0EQttOl5l/M0xhxMaj+
         uXwa7MWYORUrLBJ4M3XGUNpJDuOga+8U82zRUbNWd+8heI/1aLQfcmzPck7LYeyjPkIY
         oNTmv994niXC/K13QrPod/5HCLrjkCF7knF3OZZ2p2udkavgtVg344ffhHXHoYjyrUPE
         0uNfPkvDBhe01UpzgjAmNstlKsw3IwUfVZSm/kFBS9iGrs8pKFfrjrYVyqCEvz7WU+b8
         eriXEOHKxhk4lJH9PapskQ+r5me4MxOopqzLgzXbmNKrK4pzhHBtYlginRu1xbuZHoJV
         SjmA==
X-Gm-Message-State: AOAM533VGS6v5zClMX3J5vefvwTCLyFD1mXWpnqomgXngpshezmMTBjU
        cNufRfFWuG9vza1735H2hAcKqQ5FpSc=
X-Google-Smtp-Source: ABdhPJyEU3Zb8NPQ9/ovJff4bUuVVN6zJMNZPD28lQHgRnT32HFnagQG/bgD5H18Bdj/NxQcHC5/iA==
X-Received: by 2002:a17:903:2350:b0:149:2efe:393a with SMTP id c16-20020a170903235000b001492efe393amr39408518plh.113.1641047957484;
        Sat, 01 Jan 2022 06:39:17 -0800 (PST)
Received: from LAPTOP-FJDAS7G4.localdomain ([157.40.153.25])
        by smtp.gmail.com with ESMTPSA id kb1sm38220053pjb.56.2022.01.01.06.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jan 2022 06:39:17 -0800 (PST)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     git@vger.kernel.org
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 0/1] making --set-upstream have default arguments
Date:   Sat,  1 Jan 2022 20:07:47 +0530
Message-Id: <20220101143748.2582-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211209101550.19582-1-chakrabortyabhradeep79@gmail.com>
References: <20211209101550.19582-1-chakrabortyabhradeep79@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Often developers want to set a remote branch (i.e. upstream branch)
for the local branch according to their `push.default` settings. For
example, beginners often (may be most of the beginners) run

	git push -u origin <current_branch_name>

If the `push.default` configuration is set, people may want to set
the upstream to that branch that satisfies the `push.default`
configuration. For example, if the `push.default` is set to
'current', developer may want to do like this -

	git push -u <default_repo> <current_branch>

So, it would be great if 'git push -u' (i.e. without <repo> and
<refspec>) by default do this. If `push.default` is not set or has
a value other than 'matching', it would do this - 

	git push -u <default_repo> <current_branch>

And for `push.default`= 'matching', it would set all the remote
maching branch as upstream of their respective matching local
branches. E.g. if 'branch1' and 'branch2' branches both exist in
the local as well as remote repo, 'git push -u' would set the remote
'branch1' as the upstream of local 'branch1' branch and remote
'branch2' branch would be set as the upstream of local 'branch2'
branch.

Note, 'git push -u' for push.default=matching, already works. 

This patch series addresses this.

In v0: argumentless 'git push -u' was blindly passing default remote
name and current branch's name as argv[0] and argv[1] respectively.
This was affecting `push.default` setting.

From v1: The default remote is still used for the <repository> value.
But <refspec> depends on the current push configurations. If
`push.default`='matching', it pushes to the upstream as it should and
sets upstream respectively. For other values of 'push.default', it
pushes to the remote branch with the same name as the current
branch and sets that branch as the upstream.

In v2 and v3: various test cases were added and improved

In current version: tests for 'git push -u' with other options are
added. This includes '-f', '--prune', '-d', '--mirror'.


Abhradeep Chakraborty (1):
  push: make 'set-upstream' have dafault arguments

 Documentation/git-push.txt |  10 +++
 builtin/push.c             |  11 +++-
 t/t5523-push-upstream.sh   | 125 +++++++++++++++++++++++++++++++++++++
 3 files changed, 144 insertions(+), 2 deletions(-)

Range-diff against v3:
1:  64655de6ca ! 1:  d154c7d1f6 push: make '-u' have default arguments
    @@ Metadata
     Author: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
     
      ## Commit message ##
    -    push: make '-u' have default arguments
    +    push: make 'set-upstream' have dafault arguments
     
         "git push -u" (set-upstream) requires where to push to and what
         to push.  Often people push only the current branch to update
    @@ t/t5523-push-upstream.sh: test_expect_success 'push -u :topic_2' '
     +	test_config remote.pushDefault upstream
     +}
     +
    ++check_empty_config() {
    ++	test_expect_code 1 git config "branch.$1.remote" &&
    ++	test_expect_code 1 git config "branch.$1.merge"
    ++}
    ++
     +for i in simple current upstream nothing
     +do
     +	test_expect_success 'push -u with push.default=$i' '
    @@ t/t5523-push-upstream.sh: test_expect_success 'push -u :topic_2' '
     +		git push -u &&
     +		check_config main upstream refs/heads/main
     +	'
    ++
    ++	test_expect_success 'push -u -f with push.default=$i' '
    ++		default_u_setup $i &&
    ++		git push -u -f &&
    ++		check_config main upstream refs/heads/main
    ++	'
     +done
     +
    -+check_empty_config() {
    -+	test_expect_code 1 git config "branch.$1.remote" &&
    -+	test_expect_code 1 git config "branch.$1.merge"
    -+}
    ++for i in simple current upstream nothing matching
    ++do
    ++	test_expect_success 'push -u --prune with push.default=$i' '
    ++		default_u_setup $i &&
    ++		git push upstream main:test_u215 &&
    ++		git push -u --prune >out &&
    ++		check_config main upstream refs/heads/main &&
    ++		test_i18ngrep "[deleted]" out &&
    ++		test_i18ngrep ! "Branch '"'"'test_u215'"'"' set up to track" out
    ++	'
    ++
    ++	test_expect_success 'push -u --mirror with push.default=$i' '
    ++		default_u_setup $i &&
    ++		test_might_fail git branch mirror1 &&
    ++		test_might_fail git branch mirror2 &&
    ++		git push -u --mirror &&
    ++		check_config main upstream  refs/heads/main &&
    ++		check_config mirror1 upstream refs/heads/mirror1 &&
    ++		check_config mirror2 upstream refs/heads/mirror2
    ++	'
    ++done
     +
    -+test_expect_success 'push -u with push.default=matching' '
    -+	default_u_setup matching &&
    -+	git branch test_u &&
    -+	git branch test_u2 &&
    -+	git push upstream main:test_u2 &&
    -+	git push -u &&
    -+	check_config main upstream refs/heads/main &&
    -+	check_config test_u2 upstream refs/heads/test_u2 &&
    -+	check_empty_config test_u
    ++for i in '' '-f'
    ++do
    ++
    ++	test_expect_success 'push -u $i with push.default=matching' '
    ++		default_u_setup matching &&
    ++		test_might_fail git branch test_u &&
    ++		test_might_fail git branch test_u2 &&
    ++		git push upstream main:test_u2 &&
    ++		git push -u $i &&
    ++		check_config main upstream refs/heads/main &&
    ++		check_config test_u2 upstream refs/heads/test_u2 &&
    ++		check_empty_config test_u
    ++	'
    ++done
    ++
    ++test_expect_success 'push -u -d will fail' '
    ++	git checkout main &&
    ++	test_might_fail git branch --unset-upstream &&
    ++	test_must_fail git push -u -d
     +'
     +
     +test_expect_success 'push -u --dry-run' '
-- 
2.34.1

