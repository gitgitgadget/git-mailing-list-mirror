Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3062BC433F5
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 14:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiJDOZA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 10:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJDOYy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 10:24:54 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AC61081
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 07:24:50 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id v130-20020a1cac88000000b003bcde03bd44so283015wme.5
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 07:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date;
        bh=x5Dwr8l4CeCTi56Y6JGoj+Rb7lhC/yuEjyEPT4zmFpI=;
        b=URJ+JK6+G9n7GaeHqpk6Gna11z4W0ABV6BNZwryDQ4bFAsVXsVED9hZD7YmTvtmaUb
         gbaC9/vtRPFmQS2hIl7gtWC/1BlR8tAg1RgLf58Nc+gxqAVSruYey4tL90+/JdyXnYrX
         6Mta8CAWOl1lERnebomRej9l/0Oh39fB2V7hjr5CKB9u5vcT3eG3CUso7fLVTKEYaU5J
         +vjRoLVuUKRTznyEz2rdJrwxD//dPPd4HBtonLyOmM71o3fgXJzuQYoZ4SZaLKefjKBc
         KNterGynTj2lc+psrwUMoO6fJZA5o5b8ADFhfXG7L07tqjO9lCHpA6LRWe0/za/cQHFw
         WSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date;
        bh=x5Dwr8l4CeCTi56Y6JGoj+Rb7lhC/yuEjyEPT4zmFpI=;
        b=us0MAz3mfq1zk3FkxIEx7nDth2Vps3Mx47ezV8vXVGhQyXSq2kOImDrk6CgE/b3/sV
         LKc/rJ8UbWeVpBay491a31rXBB44CWWjQ+7sUTJmme5hc+1MfuZ/O8NZahM8aeQlA2LM
         rq3Ijs4ETvZpf0UjvDAJZprtim5DY5XC33uNLF8F5/ku70kq1/FD620ToDVLiFUkuM8J
         naQl4ZSvvNZd9V/PKYKbvsHD4LvzlwKS7D/oAnMBrjKSfJ5YeEcyhqgiCK8ds2PjmNT8
         dmFkIfKOvyh38VZK4RKH9LhPZ/mN4axaOPlSJdcMM+lErsO8OzKEAnmooWVufkdjBuG5
         bahg==
X-Gm-Message-State: ACrzQf0NJ9E+WJx1z/Veqi6aqQyRLeSMslbLX8mT1jNWr308kDCgMCIr
        iPdDq2gceubW1fDjcoKzCTc=
X-Google-Smtp-Source: AMsMyM75Msoksdz18TclpcVSUt1/FiZN7mS8tY2Rj2pnMIJUbNMK84i8QFV+9K7b1r8SEd4kYRTKMA==
X-Received: by 2002:a7b:cb91:0:b0:3b4:75b9:5a4b with SMTP id m17-20020a7bcb91000000b003b475b95a4bmr11534wmi.33.1664893489524;
        Tue, 04 Oct 2022 07:24:49 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id m38-20020a05600c3b2600b003b4ff30e566sm4421311wms.3.2022.10.04.07.24.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 07:24:49 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <2a1c3861-c752-4f40-59d3-803a62cd1bc2@dunelm.org.uk>
Date:   Tue, 4 Oct 2022 15:24:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 00/10] Add the Git Change command
Content-Language: en-US
To:     Christophe Poucet via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Christophe Poucet <christophe.poucet@gmail.com>
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
In-Reply-To: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Chris

On 23/09/2022 19:55, Christophe Poucet via GitGitGadget wrote:
> I'm reviving the original git evolve work that was started by
> sxenos@google.com
> (https://public-inbox.org/git/20190215043105.163688-1-sxenos@google.com/)
> 
> This work is intended to make it easier to deal with stacked changes.
> 
> The following set of patches introduces the design doc on the evolve command
> as well as the basics of the git change command.

Our test suite can be a little tricky to get started with and I was impatient to
check the basic functionality of these patches so I've written some simple
example tests for the change command and a couple of fixups to make them pass.

Best Wishes

Phillip

---- >8 ----

 From a7c38d0f388e4d8a1f3debcc3069a7fb43084eda Mon Sep 17 00:00:00 2001
From: Phillip Wood <phillip.wood@dunelm.org.uk>
Date: Tue, 4 Oct 2022 15:12:36 +0100
Subject: [PATCH 1/3] fixup! evolve: add support for writing metacommits

---
  metacommit.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/metacommit.c b/metacommit.c
index d2b859a4d3..8f970fa104 100644
--- a/metacommit.c
+++ b/metacommit.c
@@ -296,7 +296,7 @@ int record_metacommit_withresult(
         if (override_change) {
                 string_list_clear(changes, 0);
                 overridden_head = get_change_head(chtable, override_change);
-               if (!overridden_head) {
+               if (overridden_head) {
                         /* This is an existing change */
                         old_head = &overridden_head->head;
                         if (!force) {
-- 
2.37.3.947.g1b8ba4da7f.dirty


 From cc7e8ba0b1a90268ced85d3f0c91aed49f2246d6 Mon Sep 17 00:00:00 2001
From: Phillip Wood <phillip.wood@dunelm.org.uk>
Date: Tue, 4 Oct 2022 15:15:32 +0100
Subject: [PATCH 2/3] fixup! evolve: implement the git change command

---
  t/t9999-changes.sh | 126 +++++++++++++++++++++++++++++++++++++++++++++
  1 file changed, 126 insertions(+)
  create mode 100755 t/t9999-changes.sh

diff --git a/t/t9999-changes.sh b/t/t9999-changes.sh
new file mode 100755
index 0000000000..9e58925b23
--- /dev/null
+++ b/t/t9999-changes.sh
@@ -0,0 +1,126 @@
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
+test_done
-- 
2.37.3.947.g1b8ba4da7f.dirty


 From 7784f253fa799dd11fcbc81fe815fb387af52d97 Mon Sep 17 00:00:00 2001
From: Phillip Wood <phillip.wood@dunelm.org.uk>
Date: Tue, 4 Oct 2022 15:16:05 +0100
Subject: [PATCH 3/3] fixup! evolve: add the git change list command

---
  builtin/change.c   | 16 +++++-----------
  t/t9999-changes.sh | 11 +++++++++++
  2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/builtin/change.c b/builtin/change.c
index 07d029d82d..888ef648fa 100644
--- a/builtin/change.c
+++ b/builtin/change.c
@@ -34,9 +34,8 @@ static int change_list(int argc, const char **argv, const char* prefix)
                 OPT_END()
         };
         struct ref_filter filter;
-       /* TODO: See below
         struct ref_sorting *sorting;
-       struct string_list sorting_options = STRING_LIST_INIT_DUP; */
+       struct string_list sorting_options = STRING_LIST_INIT_DUP;
         struct ref_format format = REF_FORMAT_INIT;
         struct ref_array array;
         int i;
@@ -53,19 +52,15 @@ static int change_list(int argc, const char **argv, const char* prefix)
  
         filter_refs(&array, &filter, FILTER_REFS_CHANGES);
  
-       /* TODO: This causes a crash. It sets one of the atom_value handlers to
-        * something invalid, which causes a crash later when we call
-        * show_ref_array_item. Figure out why this happens and put back the sorting.
-        *
-        * sorting = ref_sorting_options(&sorting_options);
-        * ref_array_sort(sorting, &array); */
-
         if (!format.format)
                 format.format = "%(refname:lstrip=1)";
  
         if (verify_ref_format(&format))
                 die(_("unable to parse format string"));
  
+       sorting = ref_sorting_options(&sorting_options);
+       ref_array_sort(sorting, &array);
+
         for (i = 0; i < array.nr; i++) {
                 struct strbuf output = STRBUF_INIT;
                 struct strbuf err = STRBUF_INIT;
@@ -79,8 +74,7 @@ static int change_list(int argc, const char **argv, const char* prefix)
         }
  
         ref_array_clear(&array);
-       /* TODO: see above
-       ref_sorting_release(sorting); */
+       ref_sorting_release(sorting);
  
         return 0;
  }
diff --git a/t/t9999-changes.sh b/t/t9999-changes.sh
index 9e58925b23..9312eba86d 100755
--- a/t/t9999-changes.sh
+++ b/t/t9999-changes.sh
@@ -123,4 +123,15 @@ test_expect_success 'forced non-fast forward update succeeds' '
         test_must_be_empty err
  '
  
+test_expect_success 'list changes' '
+       cat >expect <<-\EOF &&
+       metas/another-one
+       metas/one
+       metas/three
+       metas/two
+       EOF
+       git change list >actual &&
+       test_cmp expect actual
+'
+
  test_done
-- 
2.37.3.947.g1b8ba4da7f.dirty
