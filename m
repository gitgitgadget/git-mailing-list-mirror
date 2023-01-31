Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA97BC636CC
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 13:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjAaN31 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 08:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjAaN3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 08:29:25 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F62611650
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 05:29:23 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so12462525wmb.2
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 05:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEaoXB2dGnDl02IuHaXXB2DdlRQBqBifyuZCp05n+rs=;
        b=Z9t0cmoKh/VdiLffrl/3/hgNnqllR/KZqAq/WzYWVHqRW5II+feG9pgMEq/kk6IYHu
         afFliPk3D9qoGXW0uH8iau3ahLA4/gDMP2Pbrc2ZrQlH80Op2E4jzFV51Wb2ONvczWNl
         nPe21tkflAR7KXYwWCpidNhI0Ui8n9wQKMJQ86UjCRU/q6zwGsQzaGjfZB9rmRJ2wa3r
         9MasdzGQn6Rgkc9OZsqX1PerOhKhXzbFQMNqjufxCfMQPNlpa6qrmCRfh5KykZS4JnHa
         4MxeCSWu/uN5J7kmiIyWZ5DD+oFJLlye+qZS0QnyYvP8NhrG3PsKM0tx10kmmnV8ku/9
         3Ixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LEaoXB2dGnDl02IuHaXXB2DdlRQBqBifyuZCp05n+rs=;
        b=r+76iyEeGRW0zO9bHBONRdnxUwEOgep/nIfprkkfnMj6VZ1vPU+HXWiT1luyo6M5q+
         XMHsfzEb7kv1yje3D2P9T0g/WLZFtpub/O+AvTS+pLR/JK9qKyh0uT9ToPWpr9BkOLzq
         ltLLNG0ZbpnmznP0vOrEdQdIzOGR2oCgTi/yE3YQyCRNzGd7jvTO7fXo6tZ1fRPfQIpP
         QFkb4O2tXG1x90ny6RRBAwxnRfBxsFG5a7UxkBvDjCR5F3f10HsY5NEhADpkQZ6H6J/1
         uEmfhHx6SIbEI24rm9frEALiwEHSKE9mAHKcOj4AGS+LQ0UpIIwQw24zAFMgn2b0cG5Z
         2IGA==
X-Gm-Message-State: AO0yUKUGPgFoetvFKzSm4IDIiClPoi/nMqlBZ2xRJpKDNesgJ6z2//z5
        YxrGO9e9GHQMl4tm4e8N4+fjSKopHgo=
X-Google-Smtp-Source: AK7set8N8HPGB0PuH7YRkIy05Uq0GlIueFw4lqnwLKYEfErZ8HRIygEXfZFIJibbT6bSkFLnNdYWuw==
X-Received: by 2002:a05:600c:22c1:b0:3dd:e86e:8805 with SMTP id 1-20020a05600c22c100b003dde86e8805mr580510wmg.5.1675171761694;
        Tue, 31 Jan 2023 05:29:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v2-20020adfe282000000b002bdec340a1csm14571317wri.110.2023.01.31.05.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 05:29:21 -0800 (PST)
Message-Id: <pull.1454.v3.git.1675171759.gitgitgadget@gmail.com>
In-Reply-To: <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
References: <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Jan 2023 13:29:08 +0000
Subject: [PATCH v3 00/11] Bundle URIs V: creationToken heuristic for incremental fetches
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

 * (New in v3) Patch 1 tests the behavior of 'git bundle verify' and 'git
   bundle unbundle' when in the strange situation where a prerequisite
   commit exists in the object store but is not closed under reachability
   (necessarily not reachable from refs, too). This helps motivate the new
   Patch 2.
 * (New in v3) Patch 2 updates the behavior in verify_bundle() to use the
   check_connected()
 * Patch 3 creates a test setup demonstrating a creationToken heuristic. At
   this point, the Git client ignores the heuristic and uses its ad-hoc
   strategy for ordering the bundles.
 * Patches 4 and 5 teach Git to parse the bundle.heuristic and
   bundle.<id>.creationToken keys in a bundle list.
 * Patch 6 teaches Git to download bundles using the creationToken order.
   This order uses a stack approach to start from the maximum creationToken
   and continue downloading the next bundle in the list until all bundles
   can successfully be unbundled. This is the algorithm required for
   incremental fetches, while initial clones could download in the opposite
   order. Since clones will download all bundles anyway, having a second
   code path just for clones seemed unnecessary.
 * Patch 7 teaches git clone --bundle-uri to set fetch.bundleURI when the
   advertised bundle list includs a heuristic that Git understands.
 * Patch 8 updates the design document to remove reference to a bundle.flag
   option that was previously going to indicate the list was designed for
   fetches, but the bundle.heuristic option already does that.
 * Patch 9 teaches git fetch to check fetch.bundleURI and download bundles
   from that static URI before connecting to remotes via the Git protocol.
 * Patch 10 introduces a new fetch.bundleCreationToken config value to store
   the maximum creationToken of downloaded bundles. This prevents
   downloading the latest bundle on every git fetch command, reducing waste.
 * Patch 11 adds new tests for interesting incremental fetch shapes. Along
   with other test edits in other patches, these revealed several issues
   that required improvement within this series. These tests also check
   extra cases around failed bundle downloads.


Updates in v3
=============

 * Patches 1 and 2 are replacements for v3's patch 1. Instead of skipping
   the reachability walk, make it slightly more flexible by using
   check_connected(). The first patch adds tests that cover this behavior,
   which was previously untested.
 * Patch 6 replaces the "stack_operation" label with a "move" label.
 * Patch 9 simplifies nested ifs to use &&.
 * Patch 11 updates some incorrect test comments.


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

Derrick Stolee (11):
  bundle: test unbundling with incomplete history
  bundle: verify using check_connected()
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
 builtin/fetch.c                        |   6 +
 bundle-uri.c                           | 249 ++++++++-
 bundle-uri.h                           |  28 +-
 bundle.c                               |  75 ++-
 t/t5558-clone-bundle-uri.sh            | 672 ++++++++++++++++++++++++-
 t/t5601-clone.sh                       |  46 ++
 t/t5750-bundle-uri-parse.sh            |  37 ++
 t/t6020-bundle-misc.sh                 |  40 ++
 t/test-lib-functions.sh                |   8 +
 13 files changed, 1149 insertions(+), 57 deletions(-)


base-commit: 4dbebc36b0893f5094668ddea077d0e235560b16
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1454%2Fderrickstolee%2Fbundle-redo%2FcreationToken-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1454/derrickstolee/bundle-redo/creationToken-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1454

Range-diff vs v2:

  1:  b3828725bc8 <  -:  ----------- bundle: optionally skip reachability walk
  -:  ----------- >  1:  f9b0cc872ac bundle: test unbundling with incomplete history
  -:  ----------- >  2:  20c29d37f9c bundle: verify using check_connected()
  2:  427aff4d5e5 =  3:  45cdf9d13a7 t5558: add tests for creationToken heuristic
  3:  f6f8197c9cc =  4:  49bf10e0fd4 bundle-uri: parse bundle.heuristic=creationToken
  4:  12efa228d04 =  5:  ff629bc119b bundle-uri: parse bundle.<id>.creationToken values
  5:  7cfaa3c518c !  6:  366db5f6931 bundle-uri: download in creationToken order
     @@ bundle-uri.c: static int download_bundle_to_file(struct remote_bundle_info *bund
      +
      +				/* Try looking deeper in the list. */
      +				move_direction = 1;
     -+				goto stack_operation;
     ++				goto move;
      +			}
      +
      +			/* We expect bundles when using creationTokens. */
     @@ bundle-uri.c: static int download_bundle_to_file(struct remote_bundle_info *bund
      +		 * previous step.
      +		 */
      +
     -+stack_operation:
     ++move:
      +		/* Move in the specified direction and repeat. */
      +		cur += move_direction;
      +	}
  6:  17c404c1b83 =  7:  b59c4e2d390 clone: set fetch.bundleURI if appropriate
  7:  d491070efed =  8:  83f49b37c69 bundle-uri: drop bundle.flag from design doc
  8:  59e57e04968 !  9:  314c60f2ae4 fetch: fetch from an external bundle URI
     @@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const char *prefix)
       	if (dry_run)
       		write_fetch_head = 0;
       
     -+	if (!git_config_get_string_tmp("fetch.bundleuri", &bundle_uri)) {
     -+		if (fetch_bundle_uri(the_repository, bundle_uri, NULL))
     -+			warning(_("failed to fetch bundles from '%s'"), bundle_uri);
     -+	}
     ++	if (!git_config_get_string_tmp("fetch.bundleuri", &bundle_uri) &&
     ++	    fetch_bundle_uri(the_repository, bundle_uri, NULL))
     ++		warning(_("failed to fetch bundles from '%s'"), bundle_uri);
      +
       	if (all) {
       		if (argc == 1)
  9:  6a1504b1c3a ! 10:  4e0465efd19 bundle-uri: store fetch.bundleCreationToken
     @@ bundle-uri.c: static int fetch_bundles_by_token(struct repository *r,
       			}
       		}
       
     -@@ bundle-uri.c: stack_operation:
     +@@ bundle-uri.c: move:
       		cur += move_direction;
       	}
       
 10:  676522615ad ! 11:  c968b63feba bundle-uri: test missing bundles with heuristic
     @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'http clone with bundle.heurist
      +	test_remote_https_urls <trace-clone-2.txt >actual &&
      +	test_cmp expect actual &&
      +
     -+	# Only base bundle unbundled.
     ++	# bundle-1 and bundle-3 could unbundle, but bundle-4 could not
      +	git -C download-2 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
      +	cat >expect <<-EOF &&
      +	refs/bundles/base
     @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'http clone with bundle.heurist
      +	test_remote_https_urls <trace-clone-3.txt >actual &&
      +	test_cmp expect actual &&
      +
     -+	# All bundles failed to unbundle
     ++	# fake.bundle did not unbundle, but the others did.
      +	git -C download-3 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
      +	cat >expect <<-EOF &&
      +	refs/bundles/base

-- 
gitgitgadget
