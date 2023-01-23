Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2837C05027
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 15:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjAWPW5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 10:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbjAWPWa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 10:22:30 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AFB29158
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 07:22:02 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso4752769wmb.0
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 07:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRbFeByoHD2MEpg6/VCGALwOcKSks6mhP3eKdhIbdGo=;
        b=bqxzgl2cKnOluv7gP+BKP2wD27OnKj1Q0aMvv3cx4acaeVZu2NeABgCuXIJfLtyTAe
         a1m45BA6CXpC1sea2UvG/ZrpvKlvr9hbYVZv20KVg/7WQHW5xR5rQx8XlerZrlDKyk7v
         NGLhDJ4iLSP2I+zc8UiB5tduS+D4x+mbVFdrTsAeJzpmfygpEKA90VV9nrir2CPKx1je
         fXAi4rl/wOt7s1nMozO66HfKC8tsqDn9a8G38s9oYyiINJRs230Ep4ebxHrmnVf//T9S
         jP3KlsiWIMicuZPwxcDJwlSJLR+OtPL2VgkDLTrso8TbDddyBBF/wQPfyfTl1npJREBI
         sDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRbFeByoHD2MEpg6/VCGALwOcKSks6mhP3eKdhIbdGo=;
        b=lktLnV9WcDIaZ1bfu17jaZZYIawBrNWu6dG+Jv+1JwYKeBGVPtP7bvEWvUFSJM8gUr
         qevnWKNZ2g252s230toPZJIgRcqOBQa+4h5z4DKcTU8ICxTvQ0sdQFfwuVlrtWMueDg2
         nc5LN0OKoC/U8nM/aPyVRYraxqtdHrN6TRFbE8jP5Ag/GyZ6S7afiWtcJyMMTXUZIwVj
         SXZHJ1TLCm42H4dxz3YWFJRrPjyf/WcVHni+D/F1wMZ9FJfWdPOceW54s2G1vlQC8iTJ
         IdVwQchn3HOpAHW0hcCJT2wkwU9dKPT7Sps3IRiLy0o/AerdapPd9Pvoy7L7xuYMzXlC
         ezjA==
X-Gm-Message-State: AFqh2koW3bNgffTnHlSut1DCBrlouV6vWbCZEZGjL2A4Z5zz82lDYGLE
        DtpvKYWk0w+/dh2X/brj0uZJbcZM+NU=
X-Google-Smtp-Source: AMrXdXtjTP0SQig1pOcKLl6gVZpMglvi4zxkX+TKEamy6izuEP7OKTIU4y0t8mYBgBnAoo5fC+lX5A==
X-Received: by 2002:a05:600c:510b:b0:3db:d3f:a919 with SMTP id o11-20020a05600c510b00b003db0d3fa919mr21231437wms.1.1674487312508;
        Mon, 23 Jan 2023 07:21:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o4-20020a1c7504000000b003da28dfdedcsm12696872wmc.5.2023.01.23.07.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:21:52 -0800 (PST)
Message-Id: <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
In-Reply-To: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Jan 2023 15:21:40 +0000
Subject: [PATCH v2 00/10] Bundle URIs V: creationToken heuristic for incremental fetches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        avarab@gmail.com, steadmon@google.com, chooglen@google.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fifth part to the bundle URIs feature follows part IV (advertising via
protocol v2) which recently merged to 'master', so this series is based on
'master'.

This part introduces the concept of a heuristic that a bundle list can
advertise. The purpose of the heuristic is to hint to the Git client that
the bundles can be downloaded and unbundled in a certain order. In
particular, that order can assist with using the same bundle URI to download
new bundles from an updated bundle list. This allows bundle URIs to assist
with incremental fetches, not just initial clones.

The only planned heuristic is the "creationToken" heuristic where the bundle
list adds a 64-bit unsigned integer "creationToken" value to each bundle in
the list. Those values provide an ordering on the bundles implying that the
bundles can be unbundled in increasing creationToken order and at each point
the required commits for the ith bundle were provided by bundles with lower
creationTokens.

At clone time, the only difference implied by the creationToken order is
that the Git client does not need to guess at the order to apply the
bundles, but instead can use the creationToken order to apply them without
failure and retry. However, this presents an interesting benefit during
fetches: the Git client can check the bundle list and download bundles in
decreasing creationToken order until the required commits for these bundles
are present within the repository's object store. This prevents downloading
more bundle information than required.

The creationToken value is also a promise that the Git client will not need
to download a bundle if its creationToken is less than or equal to the
creationToken of a previously-downloaded bundle. This further improves the
performance during a fetch in that the client does not need to download any
bundles at all if it recognizes that the maximum creationToken is the same
(or smaller than) a previously-downloaded creationToken.

The creationToken concept is documented in the existing design document at
Documentation/technical/bundle-uri.txt, including suggested ways for bundle
providers to organize their bundle lists to take advantage of the heuristic.

This series formalizes the creationToken heuristic and the Git client logic
for understanding it. Further, for bundle lists provided by the git clone
--bundle-uri option, the Git client will recognize the heuristic as being
helpful for incremental fetches and store config values so that future git
fetch commands check the bundle list before communicating with any Git
remotes.

Note that this option does not integrate fetches with bundle lists
advertised via protocol v2. I spent some time working on this, but found the
implementation to be distinct enough that it merited its own attention in a
separate series. In particular, the configuration for indicating that a
fetch should check the bundle-uri protocol v2 command seemed best to be
located within a Git remote instead of a repository-global key such as is
being used for a static URI. Further, the timing of querying the bundle-uri
command during a git fetch command is significantly different and more
complicated than how it is used in git clone.


What Remains?
=============

Originally, I had planned on making this bundle URI work a 5-part series,
and this is part 5. Shouldn't we be done now?

There are two main things that should be done after this series, in any
order:

 * Teach git fetch to check a bundle list advertised by a remote over the
   bundle-uri protocol v2 command.
 * Add the bundle.<id>.filter option to allow advertising bundles and
   partial bundles side-by-side.

There is also room for expanding tests for more error conditions, or for
other tweaks that are not currently part of the design document. I do think
that after this series, the feature will be easier to work on different
parts in parallel.


Patch Outline
=============

 * (New in v2) Patch 1 adds a new VERIFY_BUNDLE_SKIP_REACHABLE flag for
   verify_bundle() which is called by unbundle(); this fixes a probable
   exposed by patch 10 where a bundle would fail to unbundle due to the "are
   the required commits reachable from refs?" check.
 * Patch 2 creates a test setup demonstrating a creationToken heuristic. At
   this point, the Git client ignores the heuristic and uses its ad-hoc
   strategy for ordering the bundles.
 * Patches 3 and 4 teach Git to parse the bundle.heuristic and
   bundle.<id>.creationToken keys in a bundle list.
 * Patch 5 teaches Git to download bundles using the creationToken order.
   This order uses a stack approach to start from the maximum creationToken
   and continue downloading the next bundle in the list until all bundles
   can successfully be unbundled. This is the algorithm required for
   incremental fetches, while initial clones could download in the opposite
   order. Since clones will download all bundles anyway, having a second
   code path just for clones seemed unnecessary.
 * Patch 6 teaches git clone --bundle-uri to set fetch.bundleURI when the
   advertised bundle list includs a heuristic that Git understands.
 * Patch 7 updates the design document to remove reference to a bundle.flag
   option that was previously going to indicate the list was designed for
   fetches, but the bundle.heuristic option already does that.
 * Patch 8 teaches git fetch to check fetch.bundleURI and download bundles
   from that static URI before connecting to remotes via the Git protocol.
 * Patch 9 introduces a new fetch.bundleCreationToken config value to store
   the maximum creationToken of downloaded bundles. This prevents
   downloading the latest bundle on every git fetch command, reducing waste.
 * (New in v2) Patch 10 adds new tests for interesting incremental fetch
   shapes. Along with other test edits in other patches, these revealed
   several issues that required improvement within this series. These tests
   also check extra cases around failed bundle downloads.


Updates in v2
=============

 * Patches 1 and 10 are new.
 * I started making the extra tests in patch 10 due to Victoria's concern
   around failed downloads. I extended the bundle list in a way that exposed
   other issues that are fixed in this version. Unfortunately, the test
   requires the full functionality of the entire series, so the tests are
   not isolated to where the code fixes are made. One thing that I noticed
   in the process is that some of the tests were using the local-clone trick
   to copy full object directories instead of copying only the requested
   object set. This was causing confusion in how the bundles were applying
   or failing to apply, so the tests are updated to use http whenever
   possible.
 * In Patch 2, I created a new test_remote_https_urls helper to get the full
   download list (in order). In this patch, the bundle download order is not
   well-defined, but is modified in later tests when it becomes
   well-defined.
 * In Patch 3, I updated the connection between config value and enum value
   to be an array of pairs instead of faking a hashmap-like interface that
   could be dangerous if the enum values were assigned incorrectly.
 * In Patch 5, the 'sorted' list and its type was renamed to be more
   descriptive. This also included updates to "append_bundle()" and
   "compare_creation_token_decreasing()" to be more descriptive. This had
   some side effects in Patch 8 due to the renames.
 * In Patch 5, I added the interesting bundle shape to the commit message to
   remind us of why the creationToken algorithm needs to be the way it is. I
   also removed the "stack" language in favor of discussing ranges of the
   sorted list. Some renames, such as "pop_or_push" is changed to
   "move_direction", resulted from this change of language.
 * The assignment of heuristic from the local list to global_list was moved
   into Patch 5.
 * In Patch 5, one of the tests removed bundle-2 because it allows a later
   test for git fetch to demonstrate the interesting behavior where bundle-4
   requires both bundle-2 and bundle-3.
 * In Patch 6, the fetch.bundleURI config is described differently,
   including dropping the defunct git fetch --bundle-uri reference and
   discussing that git clone --bundle-uri will set it automatically.
 * Patch 8 no longer refers to a config value starting with "remote:". It
   also expands a test that was previously not expanded in v1.
 * Patch 9 updates the documentation for fetch.bundleURI and
   fetch.bundleCreationToken to describe how the user should unset the
   latter if they edit the former.
 * Much of Patch 9's changes are due to context changes from the renames in
   Patch 5. However, it also adds the restriction that it will not attempt
   to download bundles unless their creationToken is strictly greater than
   the stored token. This ends up being critical to the failed download
   case, preventing an incremental fetch from downloading all bundles just
   because one bundle failed to download (and that case is tested in patch
   10).
 * Patch 10 adds significant testing, including several tests of failed
   bundle downloads in various cases.

Thanks,

 * Stolee

Derrick Stolee (10):
  bundle: optionally skip reachability walk
  t5558: add tests for creationToken heuristic
  bundle-uri: parse bundle.heuristic=creationToken
  bundle-uri: parse bundle.<id>.creationToken values
  bundle-uri: download in creationToken order
  clone: set fetch.bundleURI if appropriate
  bundle-uri: drop bundle.flag from design doc
  fetch: fetch from an external bundle URI
  bundle-uri: store fetch.bundleCreationToken
  bundle-uri: test missing bundles with heuristic

 Documentation/config/bundle.txt        |   7 +
 Documentation/config/fetch.txt         |  24 +
 Documentation/technical/bundle-uri.txt |   8 +-
 builtin/clone.c                        |   6 +-
 builtin/fetch.c                        |   7 +
 bundle-uri.c                           | 257 +++++++++-
 bundle-uri.h                           |  28 +-
 bundle.c                               |   3 +-
 bundle.h                               |   1 +
 t/t5558-clone-bundle-uri.sh            | 672 ++++++++++++++++++++++++-
 t/t5601-clone.sh                       |  46 ++
 t/t5750-bundle-uri-parse.sh            |  37 ++
 t/test-lib-functions.sh                |   8 +
 13 files changed, 1091 insertions(+), 13 deletions(-)


base-commit: 4dbebc36b0893f5094668ddea077d0e235560b16
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1454%2Fderrickstolee%2Fbundle-redo%2FcreationToken-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1454/derrickstolee/bundle-redo/creationToken-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1454

Range-diff vs v1:

  -:  ----------- >  1:  b3828725bc8 bundle: optionally skip reachability walk
  1:  39eed914878 !  2:  427aff4d5e5 t5558: add tests for creationToken heuristic
     @@ Commit message
          meantime, create tests that add creation tokens to the bundle list. For
          now, the Git client correctly ignores these unknown keys.
      
     +    Create a new test helper function, test_remote_https_urls, which filters
     +    GIT_TRACE2_EVENT output to extract a list of URLs passed to
     +    git-remote-https child processes. This can be used to verify the order
     +    of these requests as we implement the creationToken heuristic. For now,
     +    we need to sort the actual output since the current client does not have
     +    a well-defined order that it applies to the bundles.
     +
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
       ## t/t5558-clone-bundle-uri.sh ##
      @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone HTTP bundle' '
     - 	test_config -C clone-http log.excludedecoration refs/bundle/
       '
       
     -+# usage: test_bundle_downloaded <bundle-name> <trace-file>
     -+test_bundle_downloaded () {
     -+	cat >pattern <<-EOF &&
     -+	"event":"child_start".*"argv":\["git-remote-https","$HTTPD_URL/$1"\]
     -+	EOF
     -+	grep -f pattern "$2"
     -+}
     -+
       test_expect_success 'clone bundle list (HTTP, no heuristic)' '
      +	test_when_finished rm -f trace*.txt &&
      +
     @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone bundle list (HTTP, no he
      -	git -C clone-list-http cat-file --batch-check <oids
      +	git -C clone-list-http cat-file --batch-check <oids &&
      +
     -+	for b in 1 2 3 4
     -+	do
     -+		test_bundle_downloaded bundle-$b.bundle trace-clone.txt ||
     -+			return 1
     -+	done
     ++	cat >expect <<-EOF &&
     ++	$HTTPD_URL/bundle-1.bundle
     ++	$HTTPD_URL/bundle-2.bundle
     ++	$HTTPD_URL/bundle-3.bundle
     ++	$HTTPD_URL/bundle-4.bundle
     ++	$HTTPD_URL/bundle-list
     ++	EOF
     ++
     ++	# Sort the list, since the order is not well-defined
     ++	# without a heuristic.
     ++	test_remote_https_urls <trace-clone.txt | sort >actual &&
     ++	test_cmp expect actual
       '
       
       test_expect_success 'clone bundle list (HTTP, any mode)' '
     @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone bundle list (HTTP, any m
       '
       
      +test_expect_success 'clone bundle list (http, creationToken)' '
     ++	test_when_finished rm -f trace*.txt &&
     ++
      +	cp clone-from/bundle-*.bundle "$HTTPD_DOCUMENT_ROOT_PATH/" &&
      +	cat >"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
      +	[bundle]
     @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone bundle list (HTTP, any m
      +		creationToken = 4
      +	EOF
      +
     -+	git clone --bundle-uri="$HTTPD_URL/bundle-list" . clone-list-http-2 &&
     ++	GIT_TRACE2_EVENT="$(pwd)/trace-clone.txt" git \
     ++		clone --bundle-uri="$HTTPD_URL/bundle-list" \
     ++		"$HTTPD_URL/smart/fetch.git" clone-list-http-2 &&
      +
      +	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
     -+	git -C clone-list-http-2 cat-file --batch-check <oids
     ++	git -C clone-list-http-2 cat-file --batch-check <oids &&
     ++
     ++	cat >expect <<-EOF &&
     ++	$HTTPD_URL/bundle-1.bundle
     ++	$HTTPD_URL/bundle-2.bundle
     ++	$HTTPD_URL/bundle-3.bundle
     ++	$HTTPD_URL/bundle-4.bundle
     ++	$HTTPD_URL/bundle-list
     ++	EOF
     ++
     ++	# Since the creationToken heuristic is not yet understood by the
     ++	# client, the order cannot be verified at this moment. Sort the
     ++	# list for consistent results.
     ++	test_remote_https_urls <trace-clone.txt | sort >actual &&
     ++	test_cmp expect actual
      +'
      +
       # Do not add tests here unless they use the HTTP server, as they will
       # not run unless the HTTP dependencies exist.
       
     +
     + ## t/test-lib-functions.sh ##
     +@@ t/test-lib-functions.sh: test_region () {
     + 	return 0
     + }
     + 
     ++# Given a GIT_TRACE2_EVENT log over stdin, writes to stdout a list of URLs
     ++# sent to git-remote-https child processes.
     ++test_remote_https_urls() {
     ++	grep -e '"event":"child_start".*"argv":\["git-remote-https",".*"\]' |
     ++		sed -e 's/{"event":"child_start".*"argv":\["git-remote-https","//g' \
     ++		    -e 's/"\]}//g'
     ++}
     ++
     + # Print the destination of symlink(s) provided as arguments. Basically
     + # the same as the readlink command, but it's not available everywhere.
     + test_readlink () {
  2:  9007249b948 !  3:  f6f8197c9cc bundle-uri: parse bundle.heuristic=creationToken
     @@ Commit message
          bundle-uri' to print the heuristic value and verify that the parsing
          works correctly.
      
     +    As an extra precaution, create the internal 'heuristics' array to be a
     +    list of (enum, string) pairs so we can iterate through the array entries
     +    carefully, regardless of the enum values.
     +
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
       ## Documentation/config/bundle.txt ##
     @@ bundle-uri.c
       #include "config.h"
       #include "remote.h"
       
     -+static const char *heuristics[] = {
     -+	[BUNDLE_HEURISTIC_NONE] = "",
     -+	[BUNDLE_HEURISTIC_CREATIONTOKEN] = "creationToken",
     ++static struct {
     ++	enum bundle_list_heuristic heuristic;
     ++	const char *name;
     ++} heuristics[BUNDLE_HEURISTIC__COUNT] = {
     ++	{ BUNDLE_HEURISTIC_NONE, ""},
     ++	{ BUNDLE_HEURISTIC_CREATIONTOKEN, "creationToken" },
      +};
      +
       static int compare_bundles(const void *hashmap_cmp_fn_data,
     @@ bundle-uri.c: void print_bundle_list(FILE *fp, struct bundle_list *list)
       	fprintf(fp, "\tversion = %d\n", list->version);
       	fprintf(fp, "\tmode = %s\n", mode);
       
     -+	if (list->heuristic)
     -+		printf("\theuristic = %s\n", heuristics[list->heuristic]);
     ++	if (list->heuristic) {
     ++		int i;
     ++		for (i = 0; i < BUNDLE_HEURISTIC__COUNT; i++) {
     ++			if (heuristics[i].heuristic == list->heuristic) {
     ++				printf("\theuristic = %s\n",
     ++				       heuristics[list->heuristic].name);
     ++				break;
     ++			}
     ++		}
     ++	}
      +
       	for_all_bundles_in_list(list, summarize_bundle, fp);
       }
     @@ bundle-uri.c: static int bundle_list_update(const char *key, const char *value,
      +		if (!strcmp(subkey, "heuristic")) {
      +			int i;
      +			for (i = 0; i < BUNDLE_HEURISTIC__COUNT; i++) {
     -+				if (!strcmp(value, heuristics[i])) {
     -+					list->heuristic = i;
     ++				if (heuristics[i].heuristic &&
     ++				    heuristics[i].name &&
     ++				    !strcmp(value, heuristics[i].name)) {
     ++					list->heuristic = heuristics[i].heuristic;
      +					return 0;
      +				}
      +			}
     @@ bundle-uri.h: enum bundle_list_mode {
      +	BUNDLE_HEURISTIC_CREATIONTOKEN,
      +
      +	/* Must be last. */
     -+	BUNDLE_HEURISTIC__COUNT,
     ++	BUNDLE_HEURISTIC__COUNT
      +};
      +
       /**
  3:  a1808f0b10c =  4:  12efa228d04 bundle-uri: parse bundle.<id>.creationToken values
  4:  57c0174d375 !  5:  7cfaa3c518c bundle-uri: download in creationToken order
     @@ Commit message
          strategy implemented here provides that short-circuit where the client
          downloads a minimal set of bundles.
      
     +    However, we are not satisfied by the naive approach of downloading
     +    bundles until one successfully unbundles, expecting the earlier bundles
     +    to successfully unbundle now. The example repository in t5558
     +    demonstrates this well:
     +
     +     ---------------- bundle-4
     +
     +           4
     +          / \
     +     ----|---|------- bundle-3
     +         |   |
     +         |   3
     +         |   |
     +     ----|---|------- bundle-2
     +         |   |
     +         2   |
     +         |   |
     +     ----|---|------- bundle-1
     +          \ /
     +           1
     +           |
     +     (previous commits)
     +
     +    In this repository, if we already have the objects for bundle-1 and then
     +    try to fetch from this list, the naive approach will fail. bundle-4
     +    requires both bundle-3 and bundle-2, though bundle-3 will successfully
     +    unbundle without bundle-2. Thus, the algorithm needs to keep this in
     +    mind.
     +
          A later implementation detail will store the maximum creationToken seen
          during such a bundle download, and the client will avoid downloading a
          bundle unless its creationToken is strictly greater than that stored
     @@ bundle-uri.c: static int download_bundle_to_file(struct remote_bundle_info *bund
       	return 0;
       }
       
     -+struct sorted_bundle_list {
     ++struct bundles_for_sorting {
      +	struct remote_bundle_info **items;
      +	size_t alloc;
      +	size_t nr;
      +};
      +
     -+static int insert_bundle(struct remote_bundle_info *bundle, void *data)
     ++static int append_bundle(struct remote_bundle_info *bundle, void *data)
      +{
     -+	struct sorted_bundle_list *list = data;
     ++	struct bundles_for_sorting *list = data;
      +	list->items[list->nr++] = bundle;
      +	return 0;
      +}
      +
     -+static int compare_creation_token(const void *va, const void *vb)
     ++/**
     ++ * For use in QSORT() to get a list sorted by creationToken
     ++ * in decreasing order.
     ++ */
     ++static int compare_creation_token_decreasing(const void *va, const void *vb)
      +{
      +	const struct remote_bundle_info * const *a = va;
      +	const struct remote_bundle_info * const *b = vb;
     @@ bundle-uri.c: static int download_bundle_to_file(struct remote_bundle_info *bund
      +				  struct bundle_list *list)
      +{
      +	int cur;
     -+	int pop_or_push = 0;
     ++	int move_direction = 0;
      +	struct bundle_list_context ctx = {
      +		.r = r,
      +		.list = list,
      +		.mode = list->mode,
      +	};
     -+	struct sorted_bundle_list sorted = {
     ++	struct bundles_for_sorting bundles = {
      +		.alloc = hashmap_get_size(&list->bundles),
      +	};
      +
     -+	ALLOC_ARRAY(sorted.items, sorted.alloc);
     ++	ALLOC_ARRAY(bundles.items, bundles.alloc);
      +
     -+	for_all_bundles_in_list(list, insert_bundle, &sorted);
     ++	for_all_bundles_in_list(list, append_bundle, &bundles);
      +
     -+	QSORT(sorted.items, sorted.nr, compare_creation_token);
     ++	QSORT(bundles.items, bundles.nr, compare_creation_token_decreasing);
      +
      +	/*
     -+	 * Use a stack-based approach to download the bundles and attempt
     -+	 * to unbundle them in decreasing order by creation token. If we
     -+	 * fail to unbundle (after a successful download) then move to the
     -+	 * next non-downloaded bundle (push to the stack) and attempt
     -+	 * downloading. Once we succeed in applying a bundle, move to the
     -+	 * previous unapplied bundle (pop the stack) and attempt to unbundle
     -+	 * it again.
     ++	 * Attempt to download and unbundle the minimum number of bundles by
     ++	 * creationToken in decreasing order. If we fail to unbundle (after
     ++	 * a successful download) then move to the next non-downloaded bundle
     ++	 * and attempt downloading. Once we succeed in applying a bundle,
     ++	 * move to the previous unapplied bundle and attempt to unbundle it
     ++	 * again.
      +	 *
      +	 * In the case of a fresh clone, we will likely download all of the
      +	 * bundles before successfully unbundling the oldest one, then the
     @@ bundle-uri.c: static int download_bundle_to_file(struct remote_bundle_info *bund
      +	 * repo's object store.
      +	 */
      +	cur = 0;
     -+	while (cur >= 0 && cur < sorted.nr) {
     -+		struct remote_bundle_info *bundle = sorted.items[cur];
     ++	while (cur >= 0 && cur < bundles.nr) {
     ++		struct remote_bundle_info *bundle = bundles.items[cur];
      +		if (!bundle->file) {
     -+			/* Not downloaded yet. Try downloading. */
     -+			if (download_bundle_to_file(bundle, &ctx)) {
     -+				/* Failure. Push to the stack. */
     -+				pop_or_push = 1;
     ++			/*
     ++			 * Not downloaded yet. Try downloading.
     ++			 *
     ++			 * Note that bundle->file is non-NULL if a download
     ++			 * was attempted, even if it failed to download.
     ++			 */
     ++			if (fetch_bundle_uri_internal(ctx.r, bundle, ctx.depth + 1, ctx.list)) {
     ++				/* Mark as unbundled so we do not retry. */
     ++				bundle->unbundled = 1;
     ++
     ++				/* Try looking deeper in the list. */
     ++				move_direction = 1;
      +				goto stack_operation;
      +			}
      +
     @@ bundle-uri.c: static int download_bundle_to_file(struct remote_bundle_info *bund
      +			 * unbundled. Try unbundling again.
      +			 */
      +			if (unbundle_from_file(ctx.r, bundle->file)) {
     -+				/* Failed to unbundle. Push to stack. */
     -+				pop_or_push = 1;
     ++				/* Try looking deeper in the list. */
     ++				move_direction = 1;
      +			} else {
     -+				/* Succeeded in unbundle. Pop stack. */
     -+				pop_or_push = -1;
     ++				/*
     ++				 * Succeeded in unbundle. Retry bundles
     ++				 * that previously failed to unbundle.
     ++				 */
     ++				move_direction = -1;
     ++				bundle->unbundled = 1;
      +			}
      +		}
      +
     @@ bundle-uri.c: static int download_bundle_to_file(struct remote_bundle_info *bund
      +
      +stack_operation:
      +		/* Move in the specified direction and repeat. */
     -+		cur += pop_or_push;
     ++		cur += move_direction;
      +	}
      +
     -+	free(sorted.items);
     ++	free(bundles.items);
      +
      +	/*
      +	 * We succeed if the loop terminates because 'cur' drops below
     @@ bundle-uri.c: static int fetch_bundle_list_in_config_format(struct repository *r
      +	 * it advertises are expected to be bundles, not nested lists.
      +	 * We can drop 'global_list' and 'depth'.
      +	 */
     -+	if (list_from_bundle.heuristic == BUNDLE_HEURISTIC_CREATIONTOKEN)
     ++	if (list_from_bundle.heuristic == BUNDLE_HEURISTIC_CREATIONTOKEN) {
      +		result = fetch_bundles_by_token(r, &list_from_bundle);
     -+	else if ((result = download_bundle_list(r, &list_from_bundle,
     ++		global_list->heuristic = BUNDLE_HEURISTIC_CREATIONTOKEN;
     ++	} else if ((result = download_bundle_list(r, &list_from_bundle,
       					   global_list, depth)))
       		goto cleanup;
       
     @@ bundle-uri.c: int fetch_bundle_list(struct repository *r, struct bundle_list *li
       	for_all_bundles_in_list(&global_list, unlink_bundle, NULL);
      
       ## t/t5558-clone-bundle-uri.sh ##
     -@@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone bundle list (HTTP, any mode)' '
     - '
     - 
     - test_expect_success 'clone bundle list (http, creationToken)' '
     -+	test_when_finished rm -f trace*.txt &&
     -+
     - 	cp clone-from/bundle-*.bundle "$HTTPD_DOCUMENT_ROOT_PATH/" &&
     - 	cat >"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
     - 	[bundle]
      @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone bundle list (http, creationToken)' '
     - 		creationToken = 4
     - 	EOF
     + 	git -C clone-list-http-2 cat-file --batch-check <oids &&
       
     --	git clone --bundle-uri="$HTTPD_URL/bundle-list" . clone-list-http-2 &&
     -+	GIT_TRACE2_EVENT=$(pwd)/trace-clone.txt \
     -+	git clone --bundle-uri="$HTTPD_URL/bundle-list" \
     -+		clone-from clone-list-http-2 &&
     - 
     - 	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
     --	git -C clone-list-http-2 cat-file --batch-check <oids
     -+	git -C clone-list-http-2 cat-file --batch-check <oids &&
     -+
     -+	for b in 1 2 3 4
     -+	do
     -+		test_bundle_downloaded bundle-$b.bundle trace-clone.txt ||
     -+			return 1
     -+	done
     + 	cat >expect <<-EOF &&
     +-	$HTTPD_URL/bundle-1.bundle
     +-	$HTTPD_URL/bundle-2.bundle
     +-	$HTTPD_URL/bundle-3.bundle
     ++	$HTTPD_URL/bundle-list
     + 	$HTTPD_URL/bundle-4.bundle
     ++	$HTTPD_URL/bundle-3.bundle
     ++	$HTTPD_URL/bundle-2.bundle
     ++	$HTTPD_URL/bundle-1.bundle
     ++	EOF
     ++
     ++	test_remote_https_urls <trace-clone.txt >actual &&
     ++	test_cmp expect actual
      +'
      +
     -+test_expect_success 'clone bundle list (http, creationToken)' '
     ++test_expect_success 'clone incomplete bundle list (http, creationToken)' '
      +	test_when_finished rm -f trace*.txt &&
      +
      +	cp clone-from/bundle-*.bundle "$HTTPD_DOCUMENT_ROOT_PATH/" &&
     @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone bundle list (http, creat
      +	[bundle "bundle-1"]
      +		uri = bundle-1.bundle
      +		creationToken = 1
     -+
     -+	[bundle "bundle-2"]
     -+		uri = bundle-2.bundle
     -+		creationToken = 2
      +	EOF
      +
      +	GIT_TRACE2_EVENT=$(pwd)/trace-clone.txt \
      +	git clone --bundle-uri="$HTTPD_URL/bundle-list" \
     -+		clone-from clone-token-http &&
     ++		--single-branch --branch=base --no-tags \
     ++		"$HTTPD_URL/smart/fetch.git" clone-token-http &&
      +
     -+	test_bundle_downloaded bundle-1.bundle trace-clone.txt &&
     -+	test_bundle_downloaded bundle-2.bundle trace-clone.txt
     ++	cat >expect <<-EOF &&
     + 	$HTTPD_URL/bundle-list
     ++	$HTTPD_URL/bundle-1.bundle
     + 	EOF
     + 
     +-	# Since the creationToken heuristic is not yet understood by the
     +-	# client, the order cannot be verified at this moment. Sort the
     +-	# list for consistent results.
     +-	test_remote_https_urls <trace-clone.txt | sort >actual &&
     ++	test_remote_https_urls <trace-clone.txt >actual &&
     + 	test_cmp expect actual
       '
       
     - # Do not add tests here unless they use the HTTP server, as they will
      
       ## t/t5601-clone.sh ##
      @@ t/t5601-clone.sh: test_expect_success 'auto-discover multiple bundles from HTTP clone' '
       	grep -f pattern trace.txt
       '
       
     -+# Usage: test_bundle_downloaded <bundle-id> <trace-filename>
     -+test_bundle_downloaded () {
     -+	cat >pattern <<-EOF &&
     -+	"event":"child_start".*"argv":\["git-remote-https","$HTTPD_URL/$1.bundle"\]
     -+	EOF
     -+	grep -f pattern "$2"
     -+}
     -+
      +test_expect_success 'auto-discover multiple bundles from HTTP clone: creationToken heuristic' '
      +	test_when_finished rm -rf "$HTTPD_DOCUMENT_ROOT_PATH/repo4.git" &&
      +	test_when_finished rm -rf clone-heuristic trace*.txt &&
     @@ t/t5601-clone.sh: test_expect_success 'auto-discover multiple bundles from HTTP
      +		    -c transfer.bundleURI=true clone \
      +		"$HTTPD_URL/smart/repo4.git" clone-heuristic &&
      +
     -+	# We should fetch all bundles
     -+	for b in everything new newest
     -+	do
     -+		test_bundle_downloaded $b trace-clone.txt || return 1
     -+	done
     ++	cat >expect <<-EOF &&
     ++	$HTTPD_URL/newest.bundle
     ++	$HTTPD_URL/new.bundle
     ++	$HTTPD_URL/everything.bundle
     ++	EOF
     ++
     ++	# We should fetch all bundles in the expected order.
     ++	test_remote_https_urls <trace-clone.txt >actual &&
     ++	test_cmp expect actual
      +'
      +
       # DO NOT add non-httpd-specific tests here, because the last part of this
  5:  d9c6f50e4f2 !  6:  17c404c1b83 clone: set fetch.bundleURI if appropriate
     @@ Documentation/config/fetch.txt: fetch.writeCommitGraph::
       	`git push -f`, and `git log --graph`. Defaults to false.
      +
      +fetch.bundleURI::
     -+	This value stores a URI for fetching Git object data from a bundle URI
     -+	before performing an incremental fetch from the origin Git server. If
     -+	the value is `<uri>` then running `git fetch <args>` is equivalent to
     -+	first running `git fetch --bundle-uri=<uri>` immediately before
     -+	`git fetch <args>`. See details of the `--bundle-uri` option in
     -+	linkgit:git-fetch[1].
     ++	This value stores a URI for downloading Git object data from a bundle
     ++	URI before performing an incremental fetch from the origin Git server.
     ++	This is similar to how the `--bundle-uri` option behaves in
     ++	linkgit:git-clone[1]. `git clone --bundle-uri` will set the
     ++	`fetch.bundleURI` value if the supplied bundle URI contains a bundle
     ++	list that is organized for incremental fetches.
      
       ## builtin/clone.c ##
      @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       	strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
      
       ## bundle-uri.c ##
     -@@ bundle-uri.c: static int fetch_bundle_list_in_config_format(struct repository *r,
     - 	 * it advertises are expected to be bundles, not nested lists.
     - 	 * We can drop 'global_list' and 'depth'.
     - 	 */
     --	if (list_from_bundle.heuristic == BUNDLE_HEURISTIC_CREATIONTOKEN)
     -+	if (list_from_bundle.heuristic == BUNDLE_HEURISTIC_CREATIONTOKEN) {
     - 		result = fetch_bundles_by_token(r, &list_from_bundle);
     --	else if ((result = download_bundle_list(r, &list_from_bundle,
     -+		global_list->heuristic = BUNDLE_HEURISTIC_CREATIONTOKEN;
     -+	} else if ((result = download_bundle_list(r, &list_from_bundle,
     - 					   global_list, depth)))
     - 		goto cleanup;
     - 
      @@ bundle-uri.c: static int unlink_bundle(struct remote_bundle_info *info, void *data)
       	return 0;
       }
     @@ bundle-uri.h: int bundle_uri_parse_config_format(const char *uri,
        * Given a bundle list that was already advertised (likely by the
      
       ## t/t5558-clone-bundle-uri.sh ##
     -@@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone bundle list (http, creationToken)' '
     - 	test_bundle_downloaded bundle-2.bundle trace-clone.txt
     +@@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone incomplete bundle list (http, creationToken)' '
     + 		--single-branch --branch=base --no-tags \
     + 		"$HTTPD_URL/smart/fetch.git" clone-token-http &&
     + 
     ++	test_cmp_config -C clone-token-http "$HTTPD_URL/bundle-list" fetch.bundleuri &&
     ++
     + 	cat >expect <<-EOF &&
     + 	$HTTPD_URL/bundle-list
     + 	$HTTPD_URL/bundle-1.bundle
     +@@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone incomplete bundle list (http, creationToken)' '
     + 	test_cmp expect actual
       '
       
      +test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
     @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone bundle list (http, creat
      +
      +	test_cmp_config -C fetch-http-4 "$HTTPD_URL/bundle-list" fetch.bundleuri &&
      +
     -+	# The clone should copy two files: the list and bundle-1.
     -+	test_bundle_downloaded bundle-list trace-clone.txt &&
     -+	test_bundle_downloaded bundle-1.bundle trace-clone.txt &&
     ++	cat >expect <<-EOF &&
     ++	$HTTPD_URL/bundle-list
     ++	$HTTPD_URL/bundle-1.bundle
     ++	EOF
     ++
     ++	test_remote_https_urls <trace-clone.txt >actual &&
     ++	test_cmp expect actual &&
      +
      +	# only received base ref from bundle-1
      +	git -C fetch-http-4 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
  6:  afcfd27a883 =  7:  d491070efed bundle-uri: drop bundle.flag from design doc
  7:  1627fc158b1 !  8:  59e57e04968 fetch: fetch from an external bundle URI
     @@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const char *prefix)
       	if (dry_run)
       		write_fetch_head = 0;
       
     -+	if (!git_config_get_string_tmp("fetch.bundleuri", &bundle_uri) &&
     -+	    !starts_with(bundle_uri, "remote:")) {
     ++	if (!git_config_get_string_tmp("fetch.bundleuri", &bundle_uri)) {
      +		if (fetch_bundle_uri(the_repository, bundle_uri, NULL))
      +			warning(_("failed to fetch bundles from '%s'"), bundle_uri);
      +	}
     @@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const char *prefix)
       			die(_("fetch --all does not take a repository argument"));
      
       ## t/t5558-clone-bundle-uri.sh ##
     +@@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone incomplete bundle list (http, creationToken)' '
     + 	EOF
     + 
     + 	test_remote_https_urls <trace-clone.txt >actual &&
     +-	test_cmp expect actual
     ++	test_cmp expect actual &&
     ++
     ++	# We now have only one bundle ref.
     ++	git -C clone-token-http for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
     ++	cat >expect <<-\EOF &&
     ++	refs/bundles/base
     ++	EOF
     ++	test_cmp expect refs &&
     ++
     ++	# Add remaining bundles, exercising the "deepening" strategy
     ++	# for downloading via the creationToken heurisitc.
     ++	cat >>"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
     ++	[bundle "bundle-2"]
     ++		uri = bundle-2.bundle
     ++		creationToken = 2
     ++
     ++	[bundle "bundle-3"]
     ++		uri = bundle-3.bundle
     ++		creationToken = 3
     ++
     ++	[bundle "bundle-4"]
     ++		uri = bundle-4.bundle
     ++		creationToken = 4
     ++	EOF
     ++
     ++	GIT_TRACE2_EVENT="$(pwd)/trace1.txt" \
     ++		git -C clone-token-http fetch origin --no-tags \
     ++		refs/heads/merge:refs/heads/merge &&
     ++
     ++	cat >expect <<-EOF &&
     ++	$HTTPD_URL/bundle-list
     ++	$HTTPD_URL/bundle-4.bundle
     ++	$HTTPD_URL/bundle-3.bundle
     ++	$HTTPD_URL/bundle-2.bundle
     ++	EOF
     ++
     ++	test_remote_https_urls <trace1.txt >actual &&
     ++	test_cmp expect actual &&
     ++
     ++	# We now have all bundle refs.
     ++	git -C clone-token-http for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
     ++
     ++	cat >expect <<-\EOF &&
     ++	refs/bundles/base
     ++	refs/bundles/left
     ++	refs/bundles/merge
     ++	refs/bundles/right
     ++	EOF
     ++	test_cmp expect refs
     + '
     + 
     + test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
      @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
       	cat >expect <<-\EOF &&
       	refs/bundles/base
     @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'http clone with bundle.heurist
      +		refs/heads/left:refs/heads/left \
      +		refs/heads/right:refs/heads/right &&
      +
     -+	# This fetch should copy two files: the list and bundle-2.
     -+	test_bundle_downloaded bundle-list trace1.txt &&
     -+	test_bundle_downloaded bundle-2.bundle trace1.txt &&
     -+	! test_bundle_downloaded bundle-1.bundle trace1.txt &&
     ++	cat >expect <<-EOF &&
     ++	$HTTPD_URL/bundle-list
     ++	$HTTPD_URL/bundle-2.bundle
     ++	EOF
     ++
     ++	test_remote_https_urls <trace1.txt >actual &&
     ++	test_cmp expect actual &&
      +
      +	# received left from bundle-2
      +	git -C fetch-http-4 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
     @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'http clone with bundle.heurist
      +		creationToken = 4
      +	EOF
      +
     -+	# This fetch should skip bundle-3.bundle, since its objets are
     ++	# This fetch should skip bundle-3.bundle, since its objects are
      +	# already local (we have the requisite commits for bundle-4.bundle).
      +	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
      +		git -C fetch-http-4 fetch origin --no-tags \
      +		refs/heads/merge:refs/heads/merge &&
      +
     -+	# This fetch should copy three files: the list, bundle-3, and bundle-4.
     -+	test_bundle_downloaded bundle-list trace2.txt &&
     -+	test_bundle_downloaded bundle-4.bundle trace2.txt &&
     -+	! test_bundle_downloaded bundle-1.bundle trace2.txt &&
     -+	! test_bundle_downloaded bundle-2.bundle trace2.txt &&
     -+	! test_bundle_downloaded bundle-3.bundle trace2.txt &&
     ++	cat >expect <<-EOF &&
     ++	$HTTPD_URL/bundle-list
     ++	$HTTPD_URL/bundle-4.bundle
     ++	EOF
     ++
     ++	test_remote_https_urls <trace2.txt >actual &&
     ++	test_cmp expect actual &&
      +
      +	# received merge ref from bundle-4, but right is missing
      +	# because we did not download bundle-3.
  8:  51f210ddeb4 !  9:  6a1504b1c3a bundle-uri: store fetch.bundleCreationToken
     @@ Commit message
          When checking the same bundle list twice, this strategy requires
          downloading the bundle with the maximum creationToken again, which is
          wasteful. The creationToken heuristic promises that the client will not
     -    have a use for that bundle if its creationToken value is the at most the
     +    have a use for that bundle if its creationToken value is at most the
          previous creationToken value.
      
          To prevent these wasteful downloads, create a fetch.bundleCreationToken
     @@ Commit message
      
       ## Documentation/config/fetch.txt ##
      @@ Documentation/config/fetch.txt: fetch.bundleURI::
     - 	first running `git fetch --bundle-uri=<uri>` immediately before
     - 	`git fetch <args>`. See details of the `--bundle-uri` option in
     - 	linkgit:git-fetch[1].
     + 	linkgit:git-clone[1]. `git clone --bundle-uri` will set the
     + 	`fetch.bundleURI` value if the supplied bundle URI contains a bundle
     + 	list that is organized for incremental fetches.
     +++
     ++If you modify this value and your repository has a `fetch.bundleCreationToken`
     ++value, then remove that `fetch.bundleCreationToken` value before fetching from
     ++the new bundle URI.
      +
      +fetch.bundleCreationToken::
      +	When using `fetch.bundleURI` to fetch incrementally from a bundle
     @@ Documentation/config/fetch.txt: fetch.bundleURI::
      +	This value is used to prevent downloading bundles in the future
      +	if the advertised `creationToken` is not strictly larger than this
      +	value.
     +++
     ++The creation token values are chosen by the provider serving the specific
     ++bundle URI. If you modify the URI at `fetch.bundleURI`, then be sure to
     ++remove the value for the `fetch.bundleCreationToken` value before fetching.
      
       ## bundle-uri.c ##
      @@ bundle-uri.c: static int fetch_bundles_by_token(struct repository *r,
       {
       	int cur;
     - 	int pop_or_push = 0;
     + 	int move_direction = 0;
      +	const char *creationTokenStr;
     -+	uint64_t maxCreationToken;
     ++	uint64_t maxCreationToken = 0, newMaxCreationToken = 0;
       	struct bundle_list_context ctx = {
       		.r = r,
       		.list = list,
      @@ bundle-uri.c: static int fetch_bundles_by_token(struct repository *r,
       
     - 	for_all_bundles_in_list(list, insert_bundle, &sorted);
     + 	for_all_bundles_in_list(list, append_bundle, &bundles);
       
     -+	if (!sorted.nr) {
     -+		free(sorted.items);
     ++	if (!bundles.nr) {
     ++		free(bundles.items);
      +		return 0;
      +	}
      +
     - 	QSORT(sorted.items, sorted.nr, compare_creation_token);
     + 	QSORT(bundles.items, bundles.nr, compare_creation_token_decreasing);
       
      +	/*
      +	 * If fetch.bundleCreationToken exists, parses to a uint64t, and
     @@ bundle-uri.c: static int fetch_bundles_by_token(struct repository *r,
      +				   "fetch.bundlecreationtoken",
      +				   &creationTokenStr) &&
      +	    sscanf(creationTokenStr, "%"PRIu64, &maxCreationToken) == 1 &&
     -+	    sorted.items[0]->creationToken <= maxCreationToken) {
     -+		free(sorted.items);
     ++	    bundles.items[0]->creationToken <= maxCreationToken) {
     ++		free(bundles.items);
      +		return 0;
      +	}
      +
       	/*
     - 	 * Use a stack-based approach to download the bundles and attempt
     - 	 * to unbundle them in decreasing order by creation token. If we
     + 	 * Attempt to download and unbundle the minimum number of bundles by
     + 	 * creationToken in decreasing order. If we fail to unbundle (after
     +@@ bundle-uri.c: static int fetch_bundles_by_token(struct repository *r,
     + 	cur = 0;
     + 	while (cur >= 0 && cur < bundles.nr) {
     + 		struct remote_bundle_info *bundle = bundles.items[cur];
     ++
     ++		/*
     ++		 * If we need to dig into bundles below the previous
     ++		 * creation token value, then likely we are in an erroneous
     ++		 * state due to missing or invalid bundles. Halt the process
     ++		 * instead of continuing to download extra data.
     ++		 */
     ++		if (bundle->creationToken <= maxCreationToken)
     ++			break;
     ++
     + 		if (!bundle->file) {
     + 			/*
     + 			 * Not downloaded yet. Try downloading.
     +@@ bundle-uri.c: static int fetch_bundles_by_token(struct repository *r,
     + 				 */
     + 				move_direction = -1;
     + 				bundle->unbundled = 1;
     ++
     ++				if (bundle->creationToken > newMaxCreationToken)
     ++					newMaxCreationToken = bundle->creationToken;
     + 			}
     + 		}
     + 
      @@ bundle-uri.c: stack_operation:
     - 		cur += pop_or_push;
     + 		cur += move_direction;
       	}
       
     --	free(sorted.items);
     +-	free(bundles.items);
      -
       	/*
       	 * We succeed if the loop terminates because 'cur' drops below
     @@ bundle-uri.c: stack_operation:
       	 */
      +	if (cur < 0) {
      +		struct strbuf value = STRBUF_INIT;
     -+		strbuf_addf(&value, "%"PRIu64"", sorted.items[0]->creationToken);
     ++		strbuf_addf(&value, "%"PRIu64"", newMaxCreationToken);
      +		if (repo_config_set_multivar_gently(ctx.r,
      +						    "fetch.bundleCreationToken",
      +						    value.buf, NULL, 0))
     @@ bundle-uri.c: stack_operation:
      +		strbuf_release(&value);
      +	}
      +
     -+	free(sorted.items);
     ++	free(bundles.items);
       	return cur >= 0;
       }
       
      
       ## t/t5558-clone-bundle-uri.sh ##
     +@@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone incomplete bundle list (http, creationToken)' '
     + 		"$HTTPD_URL/smart/fetch.git" clone-token-http &&
     + 
     + 	test_cmp_config -C clone-token-http "$HTTPD_URL/bundle-list" fetch.bundleuri &&
     ++	test_cmp_config -C clone-token-http 1 fetch.bundlecreationtoken &&
     + 
     + 	cat >expect <<-EOF &&
     + 	$HTTPD_URL/bundle-list
     +@@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone incomplete bundle list (http, creationToken)' '
     + 	GIT_TRACE2_EVENT="$(pwd)/trace1.txt" \
     + 		git -C clone-token-http fetch origin --no-tags \
     + 		refs/heads/merge:refs/heads/merge &&
     ++	test_cmp_config -C clone-token-http 4 fetch.bundlecreationtoken &&
     + 
     + 	cat >expect <<-EOF &&
     + 	$HTTPD_URL/bundle-list
      @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
       		"$HTTPD_URL/smart/fetch.git" fetch-http-4 &&
       
       	test_cmp_config -C fetch-http-4 "$HTTPD_URL/bundle-list" fetch.bundleuri &&
      +	test_cmp_config -C fetch-http-4 1 fetch.bundlecreationtoken &&
       
     - 	# The clone should copy two files: the list and bundle-1.
     - 	test_bundle_downloaded bundle-list trace-clone.txt &&
     + 	cat >expect <<-EOF &&
     + 	$HTTPD_URL/bundle-list
      @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
     + 		git -C fetch-http-4 fetch origin --no-tags \
       		refs/heads/left:refs/heads/left \
       		refs/heads/right:refs/heads/right &&
     - 
      +	test_cmp_config -C fetch-http-4 2 fetch.bundlecreationtoken &&
     -+
     - 	# This fetch should copy two files: the list and bundle-2.
     - 	test_bundle_downloaded bundle-list trace1.txt &&
     - 	test_bundle_downloaded bundle-2.bundle trace1.txt &&
     + 
     + 	cat >expect <<-EOF &&
     + 	$HTTPD_URL/bundle-list
      @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
       	EOF
       	test_cmp expect refs &&
     @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'http clone with bundle.heurist
      +		git -C fetch-http-4 fetch origin --no-tags \
      +		refs/heads/left:refs/heads/left \
      +		refs/heads/right:refs/heads/right &&
     -+	test_bundle_downloaded bundle-list trace1b.txt &&
     -+	! test_bundle_downloaded bundle-1.bundle trace1b.txt &&
     -+	! test_bundle_downloaded bundle-2.bundle trace1b.txt &&
     ++
     ++	cat >expect <<-EOF &&
     ++	$HTTPD_URL/bundle-list
     ++	EOF
     ++	test_remote_https_urls <trace1b.txt >actual &&
     ++	test_cmp expect actual &&
      +
       	cat >>"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
       	[bundle "bundle-3"]
       		uri = bundle-3.bundle
      @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
     + 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
       		git -C fetch-http-4 fetch origin --no-tags \
       		refs/heads/merge:refs/heads/merge &&
     - 
      +	test_cmp_config -C fetch-http-4 4 fetch.bundlecreationtoken &&
     -+
     - 	# This fetch should copy three files: the list, bundle-3, and bundle-4.
     - 	test_bundle_downloaded bundle-list trace2.txt &&
     - 	test_bundle_downloaded bundle-4.bundle trace2.txt &&
     + 
     + 	cat >expect <<-EOF &&
     + 	$HTTPD_URL/bundle-list
      @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
       	refs/bundles/left
       	refs/bundles/merge
     @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'http clone with bundle.heurist
      +	# No-op fetch
      +	GIT_TRACE2_EVENT="$(pwd)/trace2b.txt" \
      +		git -C fetch-http-4 fetch origin &&
     -+	test_bundle_downloaded bundle-list trace2b.txt &&
     -+	! test_bundle_downloaded bundle-1.bundle trace2b.txt &&
     -+	! test_bundle_downloaded bundle-2.bundle trace2b.txt &&
     -+	! test_bundle_downloaded bundle-3.bundle trace2b.txt &&
     -+	! test_bundle_downloaded bundle-4.bundle trace2b.txt
     ++
     ++	cat >expect <<-EOF &&
     ++	$HTTPD_URL/bundle-list
     ++	EOF
     ++	test_remote_https_urls <trace2b.txt >actual &&
     ++	test_cmp expect actual
       '
       
       # Do not add tests here unless they use the HTTP server, as they will
  -:  ----------- > 10:  676522615ad bundle-uri: test missing bundles with heuristic

-- 
gitgitgadget
