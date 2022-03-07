Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B81BC433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 21:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236407AbiCGVvk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 16:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbiCGVvj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 16:51:39 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380AC75605
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 13:50:44 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id t11so25475618wrm.5
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 13:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=r6bnBX5JEnYRGIYp4IgPZncCkO9at51zBDmkvHuw2YY=;
        b=LV0wmxXmqE75eOeizw31ToJ4vmKTZ0jSPzZJjNnUL72mXSSjBOMQjAR7pTlmFik0iJ
         a/RyRny0zb16IapltXkFRlEMm44EyUKkbG8C6ClogHIxDuOaQlFBAe2gj9tI/t2YmF7q
         DvspzoBaQNrUnkQwzyjf08XjfVWaHsHmWXHZazPU6q7Td9kTEI9nvaO+ljMFppWRg7Ef
         gWLUUuI2ETfZGUT4IF/UTBD+Q5lwrfQJEgsawvBguAtqI1AKX1Y4pam3tWp3iKhLoJAB
         sh6rsW5amPsWn/8r/F5zknUIWGBP5sk9ALDVWyoRxA3VstUznLlKAy+A//F5CEju0Z4O
         ne4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=r6bnBX5JEnYRGIYp4IgPZncCkO9at51zBDmkvHuw2YY=;
        b=mVv78RxIsrsAdekg5ZC1eI/BXjisklqTZgrxQ9lY2Pv2wRPTD63U3bzNU0r1wVsnEv
         03uR27hPryfPe/4I0md8d86gCOIC6MlDn1pfjxc/zo8+TIgwPxttF3kBTlt2XKKcrUxd
         HCINfK4SzZJmRKYwoFxz9MvkBLAQI/iAJk/5frxA42WhWA5uScHiV6G/bWi6mmklld9F
         afZf2+3wbj2c/IISBH5nVd0Nmpg+MdAZfZvIsu/dCnBZiRy2RJkPzecUu8Uz89HYWxQe
         o24Y3vr9a8px18nLsbMtBovbCMwpYnmMrhgC5Z8l8i9k0CtrDB8KItGj/o5TYnABQaFU
         bjvA==
X-Gm-Message-State: AOAM5330uGNFVJ6cuiJcz4OnH00/nAKHc1FeGgIPj+WO+pftfTnWlkg/
        eLuk10MrEs7u3XRJYqI8N2ob5g1y+MY=
X-Google-Smtp-Source: ABdhPJxxjFlLxcrHZHCc2hLXIyfOJLzutrkeFYVDo8GM7iOgi0Y8o0RPYxrBTNpYoCPw6r/GoLr/GQ==
X-Received: by 2002:a05:6000:1242:b0:1ef:846b:290a with SMTP id j2-20020a056000124200b001ef846b290amr9763325wrx.235.1646689842346;
        Mon, 07 Mar 2022 13:50:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q11-20020adfcd8b000000b001e320028660sm12064501wrj.92.2022.03.07.13.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 13:50:41 -0800 (PST)
Message-Id: <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Mar 2022 21:50:28 +0000
Subject: [PATCH v2 00/12] Partial bundles
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While discussing bundle-URIs [1], it came to my attention that bundles have
no way to specify an object filter, so bundles cannot be used with partial
clones.

[1]
https://lore.kernel.org/git/7fab28bf-54e7-d0e9-110a-53fad6244cc9@gmail.com/

This series provides a way to fix that by adding a 'filter' capability to
the bundle file format and allowing one to create a partial bundle with 'git
bundle create --filter=blob:none '.

There are a couple things that I want to point out about this implementation
that could use some high-level feedback:

 1. I moved the '--filter' parsing into setup_revisions() instead of adding
    another place to parse it. This works for 'git bundle' but it also
    allows it to be parsed successfully in commands such as 'git diff' which
    doesn't make sense. Options such as '--objects' are already being parsed
    there, and they don't make sense either, so I want some thoughts on
    this.

 2. If someone uses 'git clone partial.bdl partial' where 'partial.bdl' is a
    filtered bundle, then the clone will fail with a message such as

fatal: missing blob object '9444604d515c0b162e37e59accd54a0bac50ed2e' fatal:
remote did not send all necessary objects

This might be fine. We don't expect users to clone partial bundles or fetch
partial bundles into an unfiltered repo and these failures are expected. It
is possible that we could put in custom logic to fail faster by reading the
bundle header for a filter.

Generally, the idea is to open this up as a potential way to bootstrap a
clone of a partial clone using a set of precomputed partial bundles.


Updates in v2
=============

Thanks for the reviews, Jeff, Junio, and Ævar!

 * Commit message typos and grammar are improved.

 * Grammar in MyFirstObjectWalk.txt is improved.

 * Unnecessary line wrapping is unwrapped.

 * Final test to check unbundled repo is made more rigorous.

 * The new 'filter' capability is added to
   Documentation/technical/bundle-format.txt

 * Expanded docs for 'git bundle verify'.

 * Moved API docs gently_parse_list_objects_filter() to header.

 * Test name swaps '' with "" to evaluate $filter.

 * Added a new patch that helps git clone <bundle> fail gracefully when
   <bundle> is has a filter capability.

Thanks, -Stolee

Derrick Stolee (12):
  index-pack: document and test the --promisor option
  revision: put object filter into struct rev_info
  pack-objects: use rev.filter when possible
  pack-bitmap: drop filter in prepare_bitmap_walk()
  list-objects: consolidate traverse_commit_list[_filtered]
  MyFirstObjectWalk: update recommended usage
  bundle: safely handle --objects option
  bundle: parse filter capability
  rev-list: move --filter parsing into revision.c
  bundle: create filtered bundles
  bundle: unbundle promisor packs
  clone: fail gracefully when cloning filtered bundle

 Documentation/MyFirstObjectWalk.txt       | 44 +++++-------
 Documentation/git-bundle.txt              |  4 +-
 Documentation/git-index-pack.txt          |  8 +++
 Documentation/technical/bundle-format.txt | 11 ++-
 builtin/clone.c                           | 13 ++++
 builtin/pack-objects.c                    |  9 +--
 builtin/rev-list.c                        | 29 ++------
 bundle.c                                  | 86 +++++++++++++++++++----
 bundle.h                                  |  3 +
 list-objects-filter-options.c             | 17 +----
 list-objects-filter-options.h             | 20 ++++++
 list-objects.c                            | 25 +++----
 list-objects.h                            | 12 +++-
 pack-bitmap.c                             | 24 +++----
 pack-bitmap.h                             |  2 -
 reachable.c                               |  2 +-
 revision.c                                | 11 +++
 revision.h                                |  4 ++
 t/t5300-pack-object.sh                    |  4 +-
 t/t6020-bundle-misc.sh                    | 74 +++++++++++++++++++
 20 files changed, 278 insertions(+), 124 deletions(-)


base-commit: 45fe28c951c3e70666ee4ef8379772851a8e4d32
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1159%2Fderrickstolee%2Fbundle%2Fpartial-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1159/derrickstolee/bundle/partial-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1159

Range-diff vs v1:

  1:  a1eb4dceb0b =  1:  a1eb4dceb0b index-pack: document and test the --promisor option
  2:  3a88c99d9bc =  2:  3a88c99d9bc revision: put object filter into struct rev_info
  3:  d5edb193229 =  3:  d5edb193229 pack-objects: use rev.filter when possible
  4:  888774f6f28 =  4:  888774f6f28 pack-bitmap: drop filter in prepare_bitmap_walk()
  5:  ec57ed5c37f !  5:  bcb76a065bf list-objects: consolidate traverse_commit_list[_filtered]
     @@ Commit message
          traverse_commit_list() is the presence of the 'omitted' parameter, which
          is only non-NULL for one caller. We can consolidate these two methods by
          having one call the other and use the simpler form everywhere the
     -    'omitted' paramter would be NULL.
     +    'omitted' parameter would be NULL.
      
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
  6:  355c503157a !  6:  efc03168818 MyFirstObjectWalk: update recommended usage
     @@ Documentation/MyFirstObjectWalk.txt: function shows that the all-object walk is
      -- `struct list_objects_filter_options *filter_options`: This is a struct which
      -  stores a filter-spec as outlined in `Documentation/rev-list-options.txt`.
      -- `struct rev_info *revs`: This is the `rev_info` used for the walk.
     -+- `struct rev_info *revs`: This is the `rev_info` used for the walk. It
     -+  includes a `filter` member which contains information for how to filter
     -+  the object list.
     ++- `struct rev_info *revs`: This is the `rev_info` used for the walk. If
     ++  its `filter` member is not `NULL`, then `filter` contains information for
     ++  how to filter the object list.
       - `show_commit_fn show_commit`: A callback which will be used to handle each
         individual commit object.
       - `show_object_fn show_object`: A callback which will be used to handle each
  7:  1476a9495c5 !  7:  19694d5b255 bundle: safely handle --objects option
     @@ Commit message
      
          By populating the callback we prevent a segfault in the case of adding
          the --objects flag. This is really a redundant statement because the
     -    bundles are constructing a pack-file containing all objects in the
     +    command is constructing a pack-file containing all objects in the
          discovered commit range.
      
          Adding --objects to a 'git bundle' command might cause a slower command,
  8:  e7dbb46e6ac !  8:  898a7d94513 bundle: parse filter capability
     @@ Commit message
          bundle header, and demonstrate this understanding by adding a message to
          'git bundle verify'.
      
     +    Since we will use gently_parse_list_objects_filter() outside of
     +    list-objects-filter-options.c, make it an external method and move its
     +    API documentation to before its declaration.
     +
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
     + ## Documentation/technical/bundle-format.txt ##
     +@@ Documentation/technical/bundle-format.txt: and the Git bundle v2 format cannot represent a shallow clone repository.
     + == Capabilities
     + 
     + Because there is no opportunity for negotiation, unknown capabilities cause 'git
     +-bundle' to abort.  The only known capability is `object-format`, which specifies
     +-the hash algorithm in use, and can take the same values as the
     +-`extensions.objectFormat` configuration value.
     ++bundle' to abort.
     ++
     ++* `object-format` specifies the hash algorithm in use, and can take the same
     ++  values as the `extensions.objectFormat` configuration value.
     ++
     ++* `filter` specifies an object filter as in the `--filter` option in
     ++  linkgit:git-rev-list[1]. The resulting pack-file must be marked as a
     ++  `.promisor` pack-file after it is unbundled.
     +
       ## bundle.c ##
      @@
       #include "run-command.h"
     @@ bundle.h
      
       ## list-objects-filter-options.c ##
      @@ list-objects-filter-options.c: const char *list_object_filter_config_name(enum list_objects_filter_choice c)
     -  * expand_list_objects_filter_spec() first).  We also "intern" the arg for the
     -  * convenience of the current command.
     -  */
     + 	BUG("list_object_filter_config_name: invalid argument '%d'", c);
     + }
     + 
     +-/*
     +- * Parse value of the argument to the "filter" keyword.
     +- * On the command line this looks like:
     +- *       --filter=<arg>
     +- * and in the pack protocol as:
     +- *       "filter" SP <arg>
     +- *
     +- * The filter keyword will be used by many commands.
     +- * See Documentation/rev-list-options.txt for allowed values for <arg>.
     +- *
     +- * Capture the given arg as the "filter_spec".  This can be forwarded to
     +- * subordinate commands when necessary (although it's better to pass it through
     +- * expand_list_objects_filter_spec() first).  We also "intern" the arg for the
     +- * convenience of the current command.
     +- */
      -static int gently_parse_list_objects_filter(
      +int gently_parse_list_objects_filter(
       	struct list_objects_filter_options *filter_options,
     @@ list-objects-filter-options.h: struct list_objects_filter_options {
       /* Normalized command line arguments */
       #define CL_ARG__FILTER "filter"
       
     ++/*
     ++ * Parse value of the argument to the "filter" keyword.
     ++ * On the command line this looks like:
     ++ *       --filter=<arg>
     ++ * and in the pack protocol as:
     ++ *       "filter" SP <arg>
     ++ *
     ++ * The filter keyword will be used by many commands.
     ++ * See Documentation/rev-list-options.txt for allowed values for <arg>.
     ++ *
     ++ * Capture the given arg as the "filter_spec".  This can be forwarded to
     ++ * subordinate commands when necessary (although it's better to pass it through
     ++ * expand_list_objects_filter_spec() first).  We also "intern" the arg for the
     ++ * convenience of the current command.
     ++ */
      +int gently_parse_list_objects_filter(
      +	struct list_objects_filter_options *filter_options,
      +	const char *arg,
  9:  22c4fe9d4bc =  9:  aaa15d7d512 rev-list: move --filter parsing into revision.c
 10:  5393e74708d ! 10:  82d93fc62e2 bundle: create filtered bundles
     @@ Commit message
      
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
     + ## Documentation/git-bundle.txt ##
     +@@ Documentation/git-bundle.txt: verify <file>::
     + 	cleanly to the current repository.  This includes checks on the
     + 	bundle format itself as well as checking that the prerequisite
     + 	commits exist and are fully linked in the current repository.
     +-	'git bundle' prints a list of missing commits, if any, and exits
     +-	with a non-zero status.
     ++	'git bundle' prints the bundle's object filter and its list of
     ++	missing commits, if any, and exits with a non-zero status.
     + 
     + list-heads <file>::
     + 	Lists the references defined in the bundle.  If followed by a
     +
       ## bundle.c ##
      @@ bundle.c: static int write_pack_data(int bundle_fd, struct rev_info *revs, struct strvec *
       		     "--stdout", "--thin", "--delta-base-offset",
     @@ bundle.c: int create_bundle(struct repository *r, const char *path,
      +	 *    SHA1.
      +	 * 2. @filter is required because we parsed an object filter.
      +	 */
     -+	if (the_hash_algo != &hash_algos[GIT_HASH_SHA1] ||
     -+	    revs.filter)
     ++	if (the_hash_algo != &hash_algos[GIT_HASH_SHA1] || revs.filter)
      +		min_version = 3;
      +
      +	if (argc > 1) {
     @@ t/t6020-bundle-misc.sh: test_expect_success 'unfiltered bundle with --objects' '
       
      +for filter in "blob:none" "tree:0" "tree:1" "blob:limit=100"
      +do
     -+	test_expect_success 'filtered bundle: $filter' '
     -+		test_when_finished rm -rf .git/objects/pack &&
     ++	test_expect_success "filtered bundle: $filter" '
     ++		test_when_finished rm -rf .git/objects/pack cloned unbundled &&
      +		git bundle create partial.bdl \
      +			--all \
      +			--filter=$filter &&
     @@ t/t6020-bundle-misc.sh: test_expect_success 'unfiltered bundle with --objects' '
      +		The bundle uses this filter: $filter
      +		The bundle records a complete history.
      +		EOF
     -+		test_cmp expect actual
     ++		test_cmp expect actual &&
     ++
     ++		test_config uploadpack.allowfilter 1 &&
     ++		test_config uploadpack.allowanysha1inwant 1 &&
     ++		git clone --no-local --filter=$filter --bare "file://$(pwd)" cloned &&
     ++
     ++		git init unbundled &&
     ++		git -C unbundled bundle unbundle ../partial.bdl >ref-list.txt &&
     ++
     ++		# Count the same number of reachable objects.
     ++		reflist=$(git for-each-ref --format="%(objectname)") &&
     ++		git rev-list --objects --filter=$filter --missing=allow-any \
     ++			$reflist >expect &&
     ++		for repo in cloned unbundled
     ++		do
     ++			git -C $repo rev-list --objects --missing=allow-any \
     ++				$reflist >actual &&
     ++			test_cmp expect actual || return 1
     ++		done
      +	'
      +done
      +
 11:  ec51d0a50e6 ! 11:  ef17691a6b7 bundle: unbundle promisor packs
     @@ bundle.c: int unbundle(struct repository *r, struct bundle_header *header,
      
       ## t/t6020-bundle-misc.sh ##
      @@ t/t6020-bundle-misc.sh: do
     - 		The bundle uses this filter: $filter
     - 		The bundle records a complete history.
     - 		EOF
     --		test_cmp expect actual
     -+		test_cmp expect actual &&
     -+
     -+		# This creates the first pack-file in the
     -+		# .git/objects/pack directory. Look for a .promisor.
     -+		git bundle unbundle partial.bdl &&
     -+		ls .git/objects/pack/pack-*.promisor >promisor &&
     -+		test_line_count = 1 promisor
     - 	'
     - done
       
     + 		git init unbundled &&
     + 		git -C unbundled bundle unbundle ../partial.bdl >ref-list.txt &&
     ++		ls unbundled/.git/objects/pack/pack-*.promisor >promisor &&
     ++		test_line_count = 1 promisor &&
     + 
     + 		# Count the same number of reachable objects.
     + 		reflist=$(git for-each-ref --format="%(objectname)") &&
  -:  ----------- > 12:  382b9502f6b clone: fail gracefully when cloning filtered bundle

-- 
gitgitgadget
