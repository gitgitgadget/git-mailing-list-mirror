Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01479C433F5
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 15:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiJEPBu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 11:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiJEPAg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 11:00:36 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C0B13F33
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 07:59:46 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n40-20020a05600c3ba800b003b49aefc35fso1181102wms.5
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 07:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=/656IiA4aplyyvwwBmcrs7o2BwfT6cSv3CahXfMfufE=;
        b=NzzsH8TRYL8pNm6nyUSCMZ5qWF0gMw4h3KoXSoeO/bMzkdAkflXBrhwQ+znHX/A6QX
         4mU7fDiONQfT13shqTuKMRcsBaUTgwS2jhZXQep9EiARvgA9QixIrQY99SobUoAUAZQV
         Qx7oDNgzrjRkq/wrLXmMXuvRRC4tXByaq79Igl6U03hCPhaSSFLFLggTrPR7O4uogO2g
         /pTvMdnddfNfM8Oh/O9Bda7S6WVXlvQ2oVu9H23WN1sIGeApPT1rkqHGpgMMIfUEYWlz
         mLs+t/WVSoE5XSFbrKRKRpC2x7qaX1Q373JVgt75OGavQUenK5iroxQ7S7VFDn0wbfQw
         e+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/656IiA4aplyyvwwBmcrs7o2BwfT6cSv3CahXfMfufE=;
        b=ki8XDhbMuV8ZxONQWrFjEOSGOlL/q3IN7274+Pvq/MJ5e2qZ4wyhDObhtjCSkigsbW
         v9kXc/E3HgS4ooBmpxUvDoIzRH2mcXrjg/gXIYc1m2wp+mYJeskh5crKoQnhuGc5q2z4
         wzVGxcXeMOmVEXcLiOj+RstBdGK2aAp1FSlenvHIjVZgZx/tlOAO0G9Q0QQPfXLurA6R
         IMT9noGkbpAUGUEivyoNAsR9KMmTBLvr90vU+Qa3O8CzwjukIXtbS6a7W8KvajtqCFBU
         2Yndy7/NdEcz8aZ8oygjhZ5aStisa2YsoGkCc9uYwX55tAWN6obOsie2EhBXZKjKwmC+
         1ZHw==
X-Gm-Message-State: ACrzQf0/L3TfX3mhpiwOOcSy7bKvM7Yx0kUdm1V+a991A/oPpNm8i3kn
        X33dmkvA2Tbo+R5Izu8gf8isE8RjfCA=
X-Google-Smtp-Source: AMsMyM4NkfYufbjWLWDgEav5y3/59T6xTJBOwdOWz9DUtpe18As8PVSiKwHhT0lI3PAW7BAT5L05cg==
X-Received: by 2002:a1c:7912:0:b0:3c0:a1a7:e622 with SMTP id l18-20020a1c7912000000b003c0a1a7e622mr424842wme.138.1664981970115;
        Wed, 05 Oct 2022 07:59:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k16-20020adfd850000000b0022e3538d305sm12431215wrl.117.2022.10.05.07.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 07:59:29 -0700 (PDT)
Message-Id: <37042b58cda070bd562d7f64d654bd407e8572e4.1664981958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1356.v2.git.1664981957.gitgitgadget@gmail.com>
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
        <pull.1356.v2.git.1664981957.gitgitgadget@gmail.com>
From:   "Chris Poucet via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Oct 2022 14:59:17 +0000
Subject: [PATCH v2 10/10] evolve: add tests for the git-change command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jerry Zhang <jerry@skydio.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Chris Poucet <poucet@google.com>,
        Christophe Poucet <christophe.poucet@gmail.com>,
        Chris Poucet <poucet@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Chris Poucet <poucet@google.com>

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Chris Poucet <poucet@google.com>
---
 t/t9990-changes.sh | 148 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 148 insertions(+)
 create mode 100755 t/t9990-changes.sh

diff --git a/t/t9990-changes.sh b/t/t9990-changes.sh
new file mode 100755
index 00000000000..11fbd8ba49c
--- /dev/null
+++ b/t/t9990-changes.sh
@@ -0,0 +1,148 @@
+#!/bin/sh
+
+test_description='git change - low level meta-commit management'
+
+. ./test-lib.sh
+
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+test_expect_success 'setup commits and meta-commits' '
+       for c in one two three
+       do
+               test_commit $c &&
+               git change update --content $c >actual 2>err &&
+               echo "Created change metas/$c" >expect &&
+               test_cmp expect actual &&
+               test_must_be_empty err &&
+               test_cmp_rev refs/metas/$c $c || return 1
+       done
+'
+
+# Check a meta-commit has the correct parents Call with the object
+# name of the meta-commit followed by pairs of type and parent
+check_meta_commit () {
+       name=$1
+       shift
+       while test $# -gt 0
+       do
+               printf '%s %s\n' $1 $(git rev-parse --verify $2)
+               shift
+               shift
+       done | sort >expect
+       git cat-file commit $name >metacommit &&
+       # commit body should consist of parent-type
+           types="$(sed -n '/^$/ {
+                       :loop
+                       n
+                       s/^parent-type //
+                       p
+                       b loop
+                   }' metacommit)" &&
+       while read key value
+       do
+               # TODO: don't sort the first parent
+               if test "$key" = "parent"
+               then
+                       type="${types%% *}"
+                       test -n "$type" || return 1
+                       printf '%s %s\n' $type $value
+                       types="${types#?}"
+                       types="${types# }"
+               elif test "$key" = "tree"
+               then
+                       test_cmp_rev "$value" $EMPTY_TREE || return 1
+               elif test -z "$key"
+               then
+                       # only parse commit headers
+                       break
+               fi
+       done <metacommit >actual-unsorted &&
+       test -z "$types" &&
+       sort >actual <actual-unsorted &&
+       test_cmp expect actual
+}
+
+test_expect_success 'update meta-commits after rebase' '
+       (
+               set_fake_editor &&
+               FAKE_AMEND=edited &&
+               FAKE_LINES="reword 1 pick 2 fixup 3" &&
+               export FAKE_AMEND FAKE_LINES &&
+               git rebase -i --root
+       ) &&
+
+       # update meta-commits
+       git change update --replace tags/one --content HEAD~1 >out 2>err &&
+       echo "Updated change metas/one" >expect &&
+       test_cmp expect out &&
+       test_must_be_empty err &&
+       git change update --replace tags/two --content HEAD@{2} &&
+       oid=$(git rev-parse --verify metas/two) &&
+       git change update --replace HEAD@{2} --replace tags/three \
+               --content HEAD &&
+
+       # check meta-commits
+       check_meta_commit metas/one c HEAD~1 r tags/one &&
+       check_meta_commit $oid c HEAD@{2} r tags/two &&
+       # NB this checks that "git change update" uses the meta-commit ($oid)
+       #    corresponding to the replaces commit (HEAD@2 above) given on the
+       #    commandline.
+       check_meta_commit metas/two c HEAD r $oid r tags/three &&
+       check_meta_commit metas/three c HEAD r $oid r tags/three
+'
+
+reset_meta_commits () {
+    for c in one two three
+    do
+       echo "update refs/metas/$c refs/tags/$c^0"
+    done | git update-ref --stdin
+}
+
+test_expect_success 'override change name' '
+       # TODO: builtin/change.c expects --change to be the full refname,
+       #       ideally it would prepend refs/metas to the string given by the
+       #       user.
+       git change update --change refs/metas/another-one --content one &&
+       test_cmp_rev metas/another-one one
+'
+
+test_expect_success 'non-fast forward meta-commit update refused' '
+       test_must_fail git change update --change refs/metas/one --content two \
+               >out 2>err &&
+       echo "error: non-fast-forward update to ${SQ}refs/metas/one${SQ}" \
+               >expect &&
+       test_cmp expect err &&
+       test_must_be_empty out
+'
+
+test_expect_success 'forced non-fast forward update succeeds' '
+       git change update --change refs/metas/one --content two --force \
+               >out 2>err &&
+       echo "Updated change metas/one" >expect &&
+       test_cmp expect out &&
+       test_must_be_empty err
+'
+
+test_expect_success 'list changes' '
+       cat >expect <<-\EOF &&
+metas/another-one
+metas/one
+metas/three
+metas/two
+EOF
+       git change list >actual &&
+       test_cmp expect actual
+'
+
+test_expect_success 'delete change' '
+       git change delete metas/one &&
+       cat >expect <<-\EOF &&
+metas/another-one
+metas/three
+metas/two
+EOF
+       git change list >actual &&
+       test_cmp expect actual
+'
+
+test_done
-- 
gitgitgadget
