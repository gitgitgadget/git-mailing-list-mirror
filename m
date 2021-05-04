Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6BCC433B4
	for <git@archiver.kernel.org>; Tue,  4 May 2021 21:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB1CD613B4
	for <git@archiver.kernel.org>; Tue,  4 May 2021 21:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbhEDVRG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 17:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbhEDVRE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 17:17:04 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1F9C061574
        for <git@vger.kernel.org>; Tue,  4 May 2021 14:16:09 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id b3-20020a05620a0cc3b02902e9d5ca06f2so5587338qkj.19
        for <git@vger.kernel.org>; Tue, 04 May 2021 14:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ANtDgT+MK+tzqJwECuIuJtApiRvmiwy8ZTD/aVn1x88=;
        b=NAO3i/OKt6iXy43tiiFR2exH75GgwT9W1GDhyO39DncZS4Bo90jd4jhQNYE31MyKZn
         0uC3Wn5MSWg0XzpJeiDu2dK7O7tdbyJp9t+LWZbD3oImjFTJhxvlXWyZr9+0qOGUO0XD
         GHzb8zW2rjwZNCX9wE66QSddNmdvo6XmmT3Wg1ygXExiNjT0wFA8uPcUdobw8RLFyhIV
         WzclBdTvtjZ4f0Qlxz9cgmE5D2z4fhNq1l7Zh5KHOT7U488AgPsHKbwhnFp/L5xVksMn
         fwdc5d9AFfhiyuzzH2ifTj2qFRcvfVTRhUc05nUpcWeyNoFoWXXLB0E4eoF8Yu0594fb
         IXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ANtDgT+MK+tzqJwECuIuJtApiRvmiwy8ZTD/aVn1x88=;
        b=Sh/lGhVkZhm9CUJzxzJqiYPEZmfI5JJJwjHbtuZZ13rXhnGudideNfXhKohNJZEV7t
         V52/KvGbE0YEfmfXpKHuGzS7WdURus3fKVDlKKqIlWfrANJliHGNJhapKzAR/82Oo/LW
         nT+P9boZusC8TZ/mnaqmPYQhZgWtrUCVOdGVbWt8g40FMf5f0ULWo07XRYK6QYjkSiwb
         ascMALOP2NJs5ooSkKVAcAn3h1Ic1a6Kl++1xBH3AUK5RuOuQznQoqHv8R1xPkvfDLQ6
         xgp2gIVcu6dtjIhyREkk8+hVdS9tId9uXQnfQAyfDCGsCnlHIFolBb8B4golcEMEu8Y/
         Tt+w==
X-Gm-Message-State: AOAM5305jBf/Sf+DOpRkkAe2tLjW7XwW6bAi8wHXVEs4OaczU7DngZg3
        /sMtFc2/jbgP1hPyIvnknIJO2Xazu00f+P0Ag8tnbfKENyMupxHyh0DcgxyYhvCMi8DlsHoiFsv
        dcboTTbQZ4VDQPC/pA9+19odjbrEGl2WcIH/xPilzfPABTPAJTHPznEEYgr5CkqflwhLK4soAPY
        16
X-Google-Smtp-Source: ABdhPJxghhDUZTRQ0603w0ecbE2gCoRc9nAwtRw7t3dTMlVG4RUmXuaYY/SM2gi8YF2iGZcpYQG8u80LdrjjMeLj3vIu
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:58e:: with SMTP id
 bx14mr27365537qvb.39.1620162968230; Tue, 04 May 2021 14:16:08 -0700 (PDT)
Date:   Tue,  4 May 2021 14:15:57 -0700
In-Reply-To: <cover.1617929278.git.jonathantanmy@google.com>
Message-Id: <cover.1620162764.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1617929278.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH v2 0/5] Push negotiation
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the review, Junio and Stolee.

The first patch in version 1 has been merged to master, I believe, so
here are the remaining 5 patches.

As Stolee pointed out, some tests in version 1 fail when
GIT_TEST_PROTOCOL_VERSION is set to 0. I have corrected that, but there
is one test that still fails in t5601. That seems to also fail in
"master". I'll see if I can fix it and send a separate patch for that.

Jonathan Tan (5):
  fetch-pack: refactor process_acks()
  fetch-pack: refactor add_haves()
  fetch-pack: refactor command and capability write
  fetch: teach independent negotiation (no packfile)
  send-pack: support push negotiation

 Documentation/config/push.txt           |   7 +
 Documentation/technical/protocol-v2.txt |   8 +
 builtin/fetch.c                         |  27 ++-
 fetch-pack.c                            | 246 ++++++++++++++++--------
 fetch-pack.h                            |  14 ++
 object.h                                |   2 +-
 send-pack.c                             |  61 +++++-
 t/t5516-fetch-push.sh                   |  35 ++++
 t/t5701-git-serve.sh                    |   2 +-
 t/t5702-protocol-v2.sh                  |  89 +++++++++
 transport-helper.c                      |  10 +
 transport.c                             |  30 ++-
 transport.h                             |   6 +
 upload-pack.c                           |  18 +-
 14 files changed, 455 insertions(+), 100 deletions(-)

Range-diff against v1:
-:  ---------- > 1:  8102570374 fetch-pack: refactor process_acks()
-:  ---------- > 2:  57c3451b2e fetch-pack: refactor add_haves()
-:  ---------- > 3:  6871d0cec6 fetch-pack: refactor command and capability write
1:  3ebe4ada28 ! 4:  1de34a6dce fetch: teach independent negotiation (no packfile)
    @@ Commit message
         There are 2 code paths that do not go through fetch_refs_via_pack() that
         needed to be individually excluded: the bundle transport (excluded
         through requiring smart_options, which the bundle transport doesn't
    -    support) and transport helpers that do not support takeover.
    -    Fortunately, none of these support protocol v2.
    +    support) and transport helpers that do not support takeover. If or when
    +    we support independent negotiation for protocol v0, we will need to
    +    modify these 2 code paths to support it. But for now, report failure if
    +    independent negotiation is requested in these cases.
     
         Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    @@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const char *prefix)
     +		const struct object_id *oid;
     +
     +		if (!remote)
    -+			die(_("Must supply remote when using --negotiate-only"));
    ++			die(_("must supply remote when using --negotiate-only"));
     +		gtransport = prepare_transport(remote, 1);
     +		if (gtransport->smart_options) {
     +			gtransport->smart_options->acked_commits = &acked_commits;
    @@ fetch-pack.c
      #include "fsck.h"
      #include "shallow.h"
     +#include "commit-reach.h"
    ++#include "commit-graph.h"
      
      static int transfer_unpack_limit = -1;
      static int fetch_unpack_limit = -1;
    @@ fetch-pack.c: struct ref *fetch_pack(struct fetch_pack_args *args,
     +{
     +	struct object_array *a = data;
     +
    -+	add_object_array(parse_object(the_repository, oid), "", a);
    ++	add_object_array(lookup_object(the_repository, oid), "", a);
     +	return 0;
     +}
     +
    ++static void clear_common_flag(struct oidset *s)
    ++{
    ++	struct oidset_iter iter;
    ++	const struct object_id *oid;
    ++	oidset_iter_init(s, &iter);
    ++
    ++	while ((oid = oidset_iter_next(&iter))) {
    ++		struct object *obj = lookup_object(the_repository, oid);
    ++		obj->flags &= ~COMMON;
    ++	}
    ++}
    ++
     +void negotiate_using_fetch(const struct oid_array *negotiation_tips,
     +			   const struct string_list *server_options,
     +			   int stateless_rpc,
    @@ fetch-pack.c: struct ref *fetch_pack(struct fetch_pack_args *args,
     +	int in_vain = 0;
     +	int seen_ack = 0;
     +	int last_iteration = 0;
    ++	timestamp_t min_generation = GENERATION_NUMBER_INFINITY;
     +
     +	fetch_negotiator_init(the_repository, &negotiator);
     +	mark_tips(&negotiator, negotiation_tips);
    @@ fetch-pack.c: struct ref *fetch_pack(struct fetch_pack_args *args,
     +				   &received_ready)) {
     +			struct commit *commit = lookup_commit(the_repository,
     +							      &common_oid);
    -+			if (commit)
    ++			if (commit) {
    ++				timestamp_t generation;
    ++
    ++				parse_commit_or_die(commit);
     +				commit->object.flags |= COMMON;
    ++				generation = commit_graph_generation(commit);
    ++				if (generation < min_generation)
    ++					min_generation = generation;
    ++			}
     +			in_vain = 0;
     +			seen_ack = 1;
     +			oidset_insert(acked_commits, &common_oid);
    @@ fetch-pack.c: struct ref *fetch_pack(struct fetch_pack_args *args,
     +			do_check_stateless_delimiter(stateless_rpc, &reader);
     +		if (can_all_from_reach_with_flag(&nt_object_array, COMMON,
     +						 REACH_SCRATCH, 0,
    -+						 GENERATION_NUMBER_ZERO))
    ++						 min_generation))
     +			last_iteration = 1;
     +	}
    ++	clear_common_flag(acked_commits);
     +	strbuf_release(&req_buf);
     +}
     +
    @@ fetch-pack.h: struct ref *fetch_pack(struct fetch_pack_args *args,
     +/*
     + * Execute the --negotiate-only mode of "git fetch", adding all known common
     + * commits to acked_commits.
    ++ *
    ++ * In the capability advertisement that has happened prior to invoking this
    ++ * function, the "wait-for-done" capability must be present.
     + */
     +void negotiate_using_fetch(const struct oid_array *negotiation_tips,
     +			   const struct string_list *server_options,
    @@ t/t5702-protocol-v2.sh: test_expect_success 'deepen-relative' '
     +
     +	setup_negotiate_only "$SERVER" "$URI" &&
     +
    -+	git -C client fetch \
    ++	git -c protocol.version=2 -C client fetch \
     +		--no-tags \
     +		--negotiate-only \
     +		--negotiation-tip=$(git -C client rev-parse HEAD) \
    @@ t/t5702-protocol-v2.sh: test_expect_success 'packfile-uri with transfer.fsckobje
     +
     +	setup_negotiate_only "$SERVER" "$URI" &&
     +
    -+	git -C client fetch \
    ++	git -c protocol.version=2 -C client fetch \
     +		--no-tags \
     +		--negotiate-only \
     +		--negotiation-tip=$(git -C client rev-parse HEAD) \
    @@ t/t5702-protocol-v2.sh: test_expect_success 'packfile-uri with transfer.fsckobje
     +	echo "s/ wait-for-done/ xxxx-xxx-xxxx/" \
     +		>"$HTTPD_ROOT_PATH/one-time-perl" &&
     +
    -+	test_must_fail git -C client fetch \
    ++	test_must_fail git -c protocol.version=2 -C client fetch \
     +		--no-tags \
     +		--negotiate-only \
     +		--negotiation-tip=$(git -C client rev-parse HEAD) \
    @@ transport.h: struct git_transport_options {
      	struct oid_array *negotiation_tips;
     +
     +	/*
    -+	 * If set, whenever transport_fetch_refs() is called, add known common
    -+	 * commits to this oidset instead of fetching any packfiles.
    ++	 * If allocated, whenever transport_fetch_refs() is called, add known
    ++	 * common commits to this oidset instead of fetching any packfiles.
     +	 */
     +	struct oidset *acked_commits;
      };
2:  bd55d6ba36 ! 5:  d38a8b7d66 send-pack: support push negotiation
    @@ t/t5516-fetch-push.sh: test_expect_success 'fetch with pushInsteadOf (should not
     +	git push testrepo $the_first_commit:refs/remotes/origin/first_commit &&
     +	git -C testrepo config receive.hideRefs refs/remotes/origin/first_commit &&
     +	echo now pushing without negotiation &&
    -+	GIT_TRACE2_EVENT="$(pwd)/event" git push testrepo refs/heads/main:refs/remotes/origin/main &&
    ++	GIT_TRACE2_EVENT="$(pwd)/event" git -c protocol.version=2 push testrepo refs/heads/main:refs/remotes/origin/main &&
     +	grep_wrote 5 event && # 2 commits, 2 trees, 1 blob
     +
     +	# Same commands, but with negotiation
    @@ t/t5516-fetch-push.sh: test_expect_success 'fetch with pushInsteadOf (should not
     +	mk_empty testrepo &&
     +	git push testrepo $the_first_commit:refs/remotes/origin/first_commit &&
     +	git -C testrepo config receive.hideRefs refs/remotes/origin/first_commit &&
    -+	GIT_TRACE2_EVENT="$(pwd)/event" git -c push.negotiate=1 push testrepo refs/heads/main:refs/remotes/origin/main &&
    ++	GIT_TRACE2_EVENT="$(pwd)/event" git -c protocol.version=2 -c push.negotiate=1 push testrepo refs/heads/main:refs/remotes/origin/main &&
     +	grep_wrote 2 event # 1 commit, 1 tree
     +'
     +
    @@ t/t5516-fetch-push.sh: test_expect_success 'fetch with pushInsteadOf (should not
     +	mk_empty testrepo &&
     +	git push testrepo $the_first_commit:refs/remotes/origin/first_commit &&
     +	git -C testrepo config receive.hideRefs refs/remotes/origin/first_commit &&
    -+	GIT_TRACE_PACKET="$(pwd)/trace" GIT_TEST_PROTOCOL_VERSION=0 GIT_TRACE2_EVENT="$(pwd)/event" \
    ++	GIT_TEST_PROTOCOL_VERSION=0 GIT_TRACE2_EVENT="$(pwd)/event" \
     +		git -c push.negotiate=1 push testrepo refs/heads/main:refs/remotes/origin/main 2>err &&
     +	grep_wrote 5 event && # 2 commits, 2 trees, 1 blob
     +	test_i18ngrep "push negotiation failed" err
-- 
2.31.1.527.g47e6f16901-goog

