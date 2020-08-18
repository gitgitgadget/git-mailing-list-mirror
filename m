Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E85C433E1
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 04:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADE422072A
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 04:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bebOH2np"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbgHREBv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 00:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgHREBv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 00:01:51 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CF4C061389
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 21:01:50 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id q4so12346602qvu.6
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 21:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6P7tSNbbmTsfC81DaFRmmMF7B3gRVWfDYoLFxlbtAmk=;
        b=bebOH2np0hl12cPyJYRYrh0N+49ZYC3m0y+q9uBKs6I2gUcrt8611QYtHM0Bfsd9gs
         N4d1CDHMxLVofG+883zvIhTA/3BebV/0QVa8DaYb0WZAZKvT/YHpMHtMdBSc4xIFtEeJ
         /rdo+3uuVAM9zrLuqC4HvcmnmmfJmAR0cPmEmf8x7y/KlCUasb5PF8KCjra5lGPA933F
         FYjnMq+SM+Hb0mEdXpcMkvtV0DXrNkIFuGcKmpry6NPvFq/iDPDIJJw7wmaRzygfKxMc
         HqkcXGdAt+Vl+3N4tAbM8tpksbM4JaPvnPxRMD9s5E/heCxZ/I/mri/GxG+g85M35HXa
         Oknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6P7tSNbbmTsfC81DaFRmmMF7B3gRVWfDYoLFxlbtAmk=;
        b=OwJGi4AywcgMcRT/+gboEW1PnLaehgY2GJY1DSJ9dM6rICQVXFA+LnFwNZ6vqnjzQM
         LhDUSdV0Q8gc7z0VUpxJ+fzkWBpwmeN9keQMzSZYuQsiyL2ReZRjAQ21jz6BJLlyucCD
         rYdQ7idOcQuCnz2YY9k0qMEHLAfCQ+T2eMwcy+rtD/S3gRTYSgM8OnhDtXkGEo5GBJjS
         8ez4f5ApFVlMKG4oSgDRsFMy7hgCsXvas/9gzMHeoetk5hruDcuIIFFUJBXOMx8Rm414
         D7xIxUqLoB9rXgnR5ipkL7ZHiHJJdQ9yOzDG+ZuF5bcRmOQaJQIPS33bKP8pj6WJq20k
         n8HQ==
X-Gm-Message-State: AOAM5338nEceSIh6ViXwPK9wXDBaweZcIAtxRp5CHUXZ8QYf4LliLU3T
        yNxtpvKXDm7aYcrSfOfFZO6kN8GfkXk36W8qZ0eAgoBppIduXSWDEbHQmo+dwgX0X4m4rdy/s+M
        dkuq2qZS9wHl0LNF13C3JD6FBvO4JiZ3Q9gW/z2genMXmTgiF8k1Yd5n5xoqbH3bZgGZUU1D/kP
        iU
X-Google-Smtp-Source: ABdhPJzr8C2/PVyALrVAbzzvIy4tvJCtD/NhoDVcZDOSG+UAPmC/tshUs9IRNXUQtDvD5eHKJZzxZ7ABpsJjFBdxIwyZ
X-Received: by 2002:a05:6214:1467:: with SMTP id c7mr17243024qvy.233.1597723310012;
 Mon, 17 Aug 2020 21:01:50 -0700 (PDT)
Date:   Mon, 17 Aug 2020 21:01:30 -0700
In-Reply-To: <20200724223844.2723397-1-jonathantanmy@google.com>
Message-Id: <cover.1597722941.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200724223844.2723397-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH v3 0/7] Lazy fetch with subprocess
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, stolee@gmail.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches are based on jc/no-update-fetch-head, once again.

I've addressed most reviewer comments by expanding commit messages and
fixing the cascading "if" issue in patch 3.

> Would "git fetch" be the only user potentially benefit from being
> able to dereference a tag that already exists locally and ignore
> missing ones?  I wonder if teaching deref_tag() a new flag would be
> a better alternative to keep the separation of concerns at different
> layers.

Right now, I think so - "fetch" is a special case of having to avoid
infinite loops when lazy fetching, and of being able to tolerate missing
ref targets. I don't think most other commands are like that.

Jonathan Tan (7):
  negotiator/noop: add noop fetch negotiator
  fetch: allow refspecs specified through stdin
  fetch: avoid reading submodule config until needed
  fetch: only populate existing_refs if needed
  fetch-pack: do not lazy-fetch during ref iteration
  promisor-remote: lazy-fetch objects in subprocess
  fetch-pack: remove no_dependents code

 Documentation/config/fetch.txt            |   5 +-
 Documentation/git-fetch.txt               |   4 +
 Documentation/technical/partial-clone.txt |  13 +-
 Makefile                                  |   1 +
 builtin/fetch-pack.c                      |   4 -
 builtin/fetch.c                           |  42 ++++-
 fetch-negotiator.c                        |   5 +
 fetch-pack.c                              | 189 +++++++++-------------
 fetch-pack.h                              |  14 --
 negotiator/noop.c                         |  44 +++++
 negotiator/noop.h                         |   8 +
 promisor-remote.c                         |  46 +++---
 remote-curl.c                             |   6 -
 repo-settings.c                           |   2 +
 repository.h                              |   1 +
 submodule-config.c                        |   8 +-
 t/t0410-partial-clone.sh                  |   2 +-
 t/t4067-diff-partial-clone.sh             |   8 +-
 t/t5554-noop-fetch-negotiator.sh          |  22 +++
 t/t5601-clone.sh                          |   2 +-
 t/t5616-partial-clone.sh                  |  20 +++
 transport.c                               |   4 -
 transport.h                               |   7 -
 23 files changed, 255 insertions(+), 202 deletions(-)
 create mode 100644 negotiator/noop.c
 create mode 100644 negotiator/noop.h
 create mode 100755 t/t5554-noop-fetch-negotiator.sh

Range-diff against v2:
1:  35bdd372ae ! 1:  5b3b49d123 negotiator/null: add null fetch negotiator
    @@ Metadata
     Author: Jonathan Tan <jonathantanmy@google.com>
     
      ## Commit message ##
    -    negotiator/null: add null fetch negotiator
    +    negotiator/noop: add noop fetch negotiator
     
    -    Add a null fetch negotiator. This is introduced to allow partial clones
    +    Add a noop fetch negotiator. This is introduced to allow partial clones
         to skip the unneeded negotiation step when fetching missing objects
         using a "git fetch" subprocess. (The implementation of spawning a "git
         fetch" subprocess will be done in a subsequent patch.) But this can also
    @@ Documentation/config/fetch.txt: fetch.negotiationAlgorithm::
      	server. Set to "skipping" to use an algorithm that skips commits in an
      	effort to converge faster, but may result in a larger-than-necessary
     -	packfile; The default is "default" which instructs Git to use the default algorithm
    -+	packfile; or set to "null" to not send any information at all, which
    ++	packfile; or set to "noop" to not send any information at all, which
     +	will almost certainly result in a larger-than-necessary packfile, but
     +	will skip the negotiation step.
     +	The default is "default" which instructs Git to use the default algorithm
    @@ Makefile: LIB_OBJS += mergesort.o
      LIB_OBJS += midx.o
      LIB_OBJS += name-hash.o
      LIB_OBJS += negotiator/default.o
    -+LIB_OBJS += negotiator/null.o
    ++LIB_OBJS += negotiator/noop.o
      LIB_OBJS += negotiator/skipping.o
      LIB_OBJS += notes-cache.o
      LIB_OBJS += notes-merge.o
    @@ fetch-negotiator.c
      #include "fetch-negotiator.h"
      #include "negotiator/default.h"
      #include "negotiator/skipping.h"
    -+#include "negotiator/null.h"
    ++#include "negotiator/noop.h"
      #include "repository.h"
      
      void fetch_negotiator_init(struct repository *r,
    @@ fetch-negotiator.c: void fetch_negotiator_init(struct repository *r,
      		skipping_negotiator_init(negotiator);
      		return;
      
    -+	case FETCH_NEGOTIATION_NULL:
    -+		null_negotiator_init(negotiator);
    ++	case FETCH_NEGOTIATION_NOOP:
    ++		noop_negotiator_init(negotiator);
     +		return;
     +
      	case FETCH_NEGOTIATION_DEFAULT:
      	default:
      		default_negotiator_init(negotiator);
     
    - ## negotiator/null.c (new) ##
    + ## negotiator/noop.c (new) ##
     @@
     +#include "cache.h"
    -+#include "null.h"
    ++#include "noop.h"
     +#include "../commit.h"
     +#include "../fetch-negotiator.h"
     +
    @@ negotiator/null.c (new)
     +	 * This negotiator does not emit any commits, so there is no commit to
     +	 * be acknowledged. If there is any ack, there is a bug.
     +	 */
    -+	BUG("ack with null negotiator, which does not emit any commits");
    ++	BUG("ack with noop negotiator, which does not emit any commits");
     +	return 0;
     +}
     +
    @@ negotiator/null.c (new)
     +	/* nothing to release */
     +}
     +
    -+void null_negotiator_init(struct fetch_negotiator *negotiator)
    ++void noop_negotiator_init(struct fetch_negotiator *negotiator)
     +{
     +	negotiator->known_common = known_common;
     +	negotiator->add_tip = add_tip;
    @@ negotiator/null.c (new)
     +	negotiator->data = NULL;
     +}
     
    - ## negotiator/null.h (new) ##
    + ## negotiator/noop.h (new) ##
     @@
    -+#ifndef NEGOTIATOR_NULL_H
    -+#define NEGOTIATOR_NULL_H
    ++#ifndef NEGOTIATOR_NOOP_H
    ++#define NEGOTIATOR_NOOP_H
     +
     +struct fetch_negotiator;
     +
    -+void null_negotiator_init(struct fetch_negotiator *negotiator);
    ++void noop_negotiator_init(struct fetch_negotiator *negotiator);
     +
     +#endif
     
    @@ repo-settings.c: void prepare_repo_settings(struct repository *r)
      	if (!repo_config_get_string(r, "fetch.negotiationalgorithm", &strval)) {
      		if (!strcasecmp(strval, "skipping"))
      			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
    -+		else if (!strcasecmp(strval, "null"))
    -+			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_NULL;
    ++		else if (!strcasecmp(strval, "noop"))
    ++			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_NOOP;
      		else
      			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_DEFAULT;
      	}
    @@ repository.h: enum fetch_negotiation_setting {
      	FETCH_NEGOTIATION_NONE = 0,
      	FETCH_NEGOTIATION_DEFAULT = 1,
      	FETCH_NEGOTIATION_SKIPPING = 2,
    -+	FETCH_NEGOTIATION_NULL = 3,
    ++	FETCH_NEGOTIATION_NOOP = 3,
      };
      
      struct repo_settings {
     
    - ## t/t5554-null-fetch-negotiator.sh (new) ##
    + ## t/t5554-noop-fetch-negotiator.sh (new) ##
     @@
     +#!/bin/sh
     +
    -+test_description='test null fetch negotiator'
    ++test_description='test noop fetch negotiator'
     +. ./test-lib.sh
     +
    -+test_expect_success 'null negotiator does not emit any "have"' '
    ++test_expect_success 'noop negotiator does not emit any "have"' '
     +	rm -f trace &&
     +
     +	test_create_repo server &&
    @@ t/t5554-null-fetch-negotiator.sh (new)
     +	test_create_repo client &&
     +	test_commit -C client we_have &&
     +
    -+	test_config -C client fetch.negotiationalgorithm null &&
    ++	test_config -C client fetch.negotiationalgorithm noop &&
     +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch "$(pwd)/server" &&
     +
     +	! grep "fetch> have" trace &&
2:  00ad7dd875 = 2:  9f277f1631 fetch: allow refspecs specified through stdin
3:  8b4a522a13 ! 3:  fda9f834f6 fetch: avoid reading submodule config until needed
    @@ Metadata
      ## Commit message ##
         fetch: avoid reading submodule config until needed
     
    -    Teach "git fetch" to avoid reading the submodule config until necessary.
    -    This allows users to avoid the lazy-fetching of this potentially missing
    -    config file by specifying the --recurse-submodules=no command line
    -    option.
    +    In "fetch", there are two parameters submodule_fetch_jobs_config and
    +    recurse_submodules that can be set in a variety of ways: through
    +    .gitmodules, through .git/config, and through the command line.
    +    Currently "fetch" handles this by first reading .gitmodules, then
    +    reading .git/config (allowing it to overwrite existing values), then
    +    reading the command line (allowing it to overwrite existing values).
    +
    +    Notice that we can avoid reading .gitmodules if .git/config and/or the
    +    command line already provides us with what we need. In addition, if
    +    recurse_submodules is found to be "no", we do not need the value of
    +    submodule_fetch_jobs_config.
    +
    +    Avoiding reading .gitmodules is especially important when we use "git
    +    fetch" to perform lazy fetches in a partial clone because the
    +    .gitmodules file itself might need to be lazy fetched (and otherwise
    +    causing an infinite loop).
    +
    +    In light of all this, avoid reading .gitmodules until necessary. When
    +    reading it, we may only need one of the two parameters it provides, so
    +    teach fetch_config_from_gitmodules() to support NULL arguments. With
    +    this patch, users (including Git itself when invoking "git fetch" to
    +    lazy-fetch) will be able to guarantee avoiding reading .gitmodules by
    +    passing --recurse-submodules=no.
     
         Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
     
    @@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const char *prefix)
      		if (deepen_relative < 0)
     
      ## submodule-config.c ##
    -@@ submodule-config.c: struct fetch_config {
    - static int gitmodules_fetch_config(const char *var, const char *value, void *cb)
    +@@ submodule-config.c: static int gitmodules_fetch_config(const char *var, const char *value, void *cb)
      {
      	struct fetch_config *config = cb;
    --	if (!strcmp(var, "submodule.fetchjobs")) {
    -+	if (!strcmp(var, "submodule.fetchjobs") && config->max_children) {
    - 		*(config->max_children) = parse_submodule_fetchjobs(var, value);
    + 	if (!strcmp(var, "submodule.fetchjobs")) {
    +-		*(config->max_children) = parse_submodule_fetchjobs(var, value);
    ++		if (config->max_children)
    ++			*(config->max_children) =
    ++				parse_submodule_fetchjobs(var, value);
      		return 0;
    --	} else if (!strcmp(var, "fetch.recursesubmodules")) {
    -+	} else if (!strcmp(var, "fetch.recursesubmodules") &&
    -+		   config->recurse_submodules) {
    - 		*(config->recurse_submodules) = parse_fetch_recurse_submodules_arg(var, value);
    + 	} else if (!strcmp(var, "fetch.recursesubmodules")) {
    +-		*(config->recurse_submodules) = parse_fetch_recurse_submodules_arg(var, value);
    ++		if (config->recurse_submodules)
    ++			*(config->recurse_submodules) =
    ++				parse_fetch_recurse_submodules_arg(var, value);
      		return 0;
      	}
    + 
4:  77bc83e7f2 ! 4:  a5554cd27f fetch: only populate existing_refs if needed
    @@ Metadata
      ## Commit message ##
         fetch: only populate existing_refs if needed
     
    -    When fetching tags, Git only writes tags that do not already exist in
    -    the client repository. This necessitates an iteration over all the refs,
    -    but fetch performs this iteration even if no tags are fetched.
    +    In "fetch", get_ref_map() iterates over all refs to populate
    +    "existing_refs" in order to populate peer_ref->old_oid in the returned
    +    refmap, even if the refmap has no peer_ref set - which is the case when
    +    only literal hashes (i.e. no refs by name) are fetched.
     
    -    This issue is more severe in a partial clone because the iteration over
    -    refs also checks that the targets of those refs are present,
    -    necessitating a lazy fetch if the target is missing.
    +    Iterating over refs causes the targets of those refs to be checked for
    +    existence. Avoiding this is especially important when we use "git fetch"
    +    to perform lazy fetches in a partial clone because a target of such a
    +    ref may need to be itself lazy-fetched (and otherwise causing an
    +    infinite loop).
     
    -    Therefore, iterate over the refs only when necessary. The user can avoid
    -    this iteration by refraining from fetching tags, for example, by passing
    -    --no-tags as an argument. A subsequent patch will also teach Git to use
    -    "git fetch" to lazy-fetch missing objects in a partial clone, thus also
    -    making use of this change.
    +    Therefore, avoid populating "existing_refs" until necessary. With this
    +    patch, because Git lazy-fetches objects by literal hashes (to be done in
    +    a subsequent commit), it will then be able to guarantee avoiding reading
    +    targets of refs.
     
         Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
     
5:  d42e98ff07 ! 5:  f56c24dd1b fetch-pack: do not lazy-fetch during ref iteration
    @@ Metadata
      ## Commit message ##
         fetch-pack: do not lazy-fetch during ref iteration
     
    -    Teach "fetch-pack" not to lazy fetch whenever iterating over refs. This
    -    is done by using the raw form of ref iteration and by dereferencing tags
    -    ourselves.
    +    In order to determine negotiation tips, "fetch-pack" iterates over all
    +    refs and dereferences all annotated tags found. This causes the
    +    existence of targets of refs and annotated tags to be checked. Avoiding
    +    this is especially important when we use "git fetch" (which invokes
    +    "fetch-pack") to perform lazy fetches in a partial clone because a
    +    target of such a ref or annotated tag may need to be itself lazy-fetched
    +    (and otherwise causing an infinite loop).
    +
    +    Therefore, teach "fetch-pack" not to lazy fetch whenever iterating over
    +    refs. This is done by using the raw form of ref iteration and by
    +    dereferencing tags ourselves.
     
         Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
     
6:  55d2e5a4cc = 6:  4e72ca6258 promisor-remote: lazy-fetch objects in subprocess
7:  e8f16d6908 = 7:  3ff9d034e9 fetch-pack: remove no_dependents code
-- 
2.28.0.220.ged08abb693-goog

