Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB6F2D8DB9
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 10:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770890947; cv=none; b=XjjXZZc82wUc6Kc5Wh1SHp/1loxB53E9kj5K9fXRwiorr2nyz5Sw7E0tMokf33AFVFd3K1B4Z8fZDOkLqXhvAZKHMbmYvuC3yHMb9D5GmLphfoLL8aEPG2NVGQO9HirMhh4ejQY+PE4m8/T/+H3g5mnjLup3ksOS9bnb1WzLU2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770890947; c=relaxed/simple;
	bh=FPzIShhHFOWd+Gh3SMdg/mC02qHExjeeHUZO5tKVAJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fciSe14CdUmVwxusvoYvn6xnsXMkrht0ZvVdQzF7vWFhn+frbuZHRS9s3HwAJUQFGE5Ju1vXtNSxkG1wOPR/Fv8Vkj9whxTK4XfIp5+QD3KwgO+ND3N8GmKhVpQguqFa/zsbl7tRjufr+pUbmuerZjOzSLCir75x/zsNXvXA6b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUHAgfpQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUHAgfpQ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4834826e555so40306945e9.2
        for <git@vger.kernel.org>; Thu, 12 Feb 2026 02:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770890943; x=1771495743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHKNRl+ZbAH4zwyTep3sackHpg5Ol5xnXrlAVzmWtV8=;
        b=GUHAgfpQFxx68AleR6CEcKNyMd+Pk9srcFRa6w1v4+kW74zna0edAGzgsNERtw7+XW
         p614/umVvmruU6869wa5kZ4YBYm1C6ivcOc/wxEbRRQ091bw9sCGzHdmG4ju3GAOlNe6
         UqQHjklHM4ilEBSVFi364QFrdGE9hEjkN/A4OgGskks59SSOlAjbfiizZaPFa29gpItu
         Vdzk2z8JnLPma2UuH6tRFuk+lQ1BQyW71vQEHpg+IP8xpa1HxtykH4NpURl20HBnmltB
         nvBd0nCNxqDtm+OPKZY85x4b97ngYlEJQOoIqYhOVoxY2s9K9b3zbF+607yrphsT3kXV
         BHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770890943; x=1771495743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pHKNRl+ZbAH4zwyTep3sackHpg5Ol5xnXrlAVzmWtV8=;
        b=flUjKJspwyuel/p02xA6FX6f5PexPo4UsVD8oS9ZqGhF2GdZwF2s/HpOTxb9DHHMQ1
         QYHR0xIE9L8RYdQN/sfXckUnfafzCtotQ2u4o+CvLD8dIVFc0VUBRF/aoIyMeWrX8y7U
         fgrT5KgG5VsU25q7hOlk3v73Bq1j/E/T6LYNJSoVASLlrslFnd6lGmcdTwgsQXWoPmYL
         vhD+bVvnt6JFerFbLXsgCBfr0QCW5Q5vs5Sb0YJzeX09s8gzmFv5CC45BODTK0XQqNDo
         mMXWIr71/umJRRxYZBinkOs5j/P2kfAQzHa/7Zhy7HzPu5Vgabuj4Uxt/gc3uN+07o8M
         Srqg==
X-Gm-Message-State: AOJu0YxYpYxswM3a8SKFGFbtI1QIdItkigcabnhmVVwVPpina5KTNekW
	gadF4V0j6zh0igZewSnSdj51t29EXda2idwcONes7MnN3jsEEkTM66iYu5yS/g==
X-Gm-Gg: AZuq6aILQs48dAxYVbNo2u9k+TCMS0G85Z3SgMg3ZAGABc+vABK2d6/DVpeXUyHN0fh
	s9c8LxVqtSAgsZFhr5RAWcCYAlhccowu57+6pM+/Ba+dkXUyx+xlSwbIE2yYbf8CjN2sRZw8bPR
	y+SP14gQKjBOM/gVU+2RqDu6H+l3L3QeIyIIgr7IPoaNNG1GMSMSJnQA3Rhr1Fj0fR901eL4nyz
	eBND6dV6k7CxRUj42CNUFN2rTZW+vZ7AuvcHO2ArWx5nqw6su4fejg+zXmg+1chMoHAelkTi+gr
	kng990MAP1c85OEHg/ng3RsVZA4iBNypjUq1dEgoKl5M9bVnYqSAJ+lB1b6d1v4GuSD5WLq0z0B
	tgNHhKfpPZ31ht3TBpxBdx/K1IhLVJHIaiZ+Y+lwLrqIr+jEP57nn9uyGIuSmtACkFwilMEq9P+
	U1AFSFh45Uf+V/tXd3QVtloc1PTYyQUPU3Ps+9pAPGgVRc0cHTCLSXkgOQ1FyqOqN3jYGTZylrW
	ymyAuPuGpjPZRcGStTYwSudwlkVUPNDS8x1XK+EN37Fd//FYg==
X-Received: by 2002:a05:600c:4694:b0:47d:403e:4eaf with SMTP id 5b1f17b1804b1-483656c5578mr34014485e9.10.1770890943079;
        Thu, 12 Feb 2026 02:09:03 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783d3464csm12701151f8f.5.2026.02.12.02.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 02:09:02 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <avila.jn@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 0/9] Implement `promisor.storeFields` and `--filter=auto`
Date: Thu, 12 Feb 2026 11:08:31 +0100
Message-ID: <20260212100843.883623-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.70.g3d1fd9d397.dirty
In-Reply-To: <20260204110818.2919273-1-christian.couder@gmail.com>
References: <20260204110818.2919273-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduction
============

A previous patch series added the possibility to pass additional
fields, a "partialCloneFilter" and a "token" for each advertised
promisor remote, from a server to a client through the
"promisor-remote" capability.

On the client side though, it has so far only been possible to use
this new information to compare it with local information and then
decide if the corresponding advertised promisor remote is accepted or
not.

For the "token" it would be useful if it could be stored on the
client. For example in a setup where the client uses specialized
remote helpers which need a token to access the promisor remotes
advertised by the server, storing the token would allow the token to
be used when the client directly accesses a promisor remote for
example to lazy fetch some blobs it now needs.

To enable such a workflow, where the server can rotate tokens and the
client can have updated tokens from the server by simply fetching from
it, the first part of this series introduces a new
"promisor.storeFields" configuration option on the client side,
similar to the "promisor.checkFields" configuration option. When field
names, "token" or "partialCloneFilter", are listed in this new
configuration option, then the values of these field names transmitted
by the server are stored in the local configuration on the client
side.

Note that for security reasons, the corresponding remote name and url
of the advertised promisor remotes must have already been configured
on the client side. No new remote name nor url are configured.

For the "partialCloneFilter" field, simply storing the value is not
enough to enable dynamic updates. Currently, when a user initiates a
partial clone with `--filter=<filter-spec>`, that specific
<filter-spec> is saved in the client's local configuration (e.g.,
remote.origin.partialCloneFilter). Subsequent fetches then reuse this
value, ignoring suggestions from the server.

To avoid breaking this mechanism and still be able to use the
<filter-spec> that the server suggests for the promisor remotes that
the client accepts, the second part of this series introduces a new
`--filter=auto` mode for `git clone` and `git fetch`.

When `--filter=auto` is used, then "auto" is still saved as the
<filter-spec> for the server locally on the client, and then when a
fetch-pack happens, instead of passing just "auto", the actual filter
requested by the client is computed by combining the <filter-spec>s
that the server suggested for the promisor remotes that the client
accepted. This uses the "combine" filter mechanism that already exists
in "list-objects-filter-options.{c,h}".

This way by just using `--filter=auto` when cloning, a client makes
sure it will use the <filter-spec>s suggested by the server for the
promisor remotes it accepts.

This work is part of the "LOP" effort documented in:

  Documentation/technical/large-object-promisors.adoc

See that doc for more information on the broader context.

Overview of the patches
=======================

Patches 1/9 and 2/9 are the first part of the series and implement the
new "promisor.storeFields" configuration option. Patch 1/9 is a small
preparatory refactoring.

Patches from 3/9 to 9/9 implement the `--filter=auto` option:

  - Patches 3/9 and 4/9 are cleanups of "builtin/clone.c" and
    "builtin/fetch.c" respectively that make the `filter_options`
    variable local to cmd_clone() or cmd_fetch().

  - Patch 5/9 is a doc update as `--filter=<filter-spec>` wasn't
    documented for `git fetch`.

  - Patch 6/9 improves "list-objects-filter-options.{c,h}" to
    support the new 'auto' mode.

  - Patches 7/9 and 8/9 improves "promisor-remote.{c,h}" to support
    the new 'auto' mode.

  - Patch 9/9 make the new 'auto' mode actually work by wiring up
    everything together.

CI Report
=========

All the tests pass, see:

https://github.com/chriscool/git/actions/runs/21940309492

Changes since v2
================

Thanks to Patrick Steinhardt, Jean-Noël Avila and Junio Hamano for
reviewing the previous version!

The patch series has been rebased on top of current 'master' at
864f55e190 (The second batch, 2026-02-09) to avoid a small conflict.

In patch 2/9, new checks have been added to the "clone with
promisor.storeFields=partialCloneFilter" test. We now check that a
subsequent fetch can update the configuration.

In patch 4/9, a small change has been made to the arguments of
`backfill_tags()` in "builtin/fetch.c" to fix a conflict with 'master'.

In patch 5/9, the commit message has been improved.

In patch 7/9, `captured_filters` has been renamed `accepted_filters`.

Patch 8/9 is new. It changes the signature of
`promisor_remote_reply()` and allows this function to not assemble a
reply string if this is not needed by the caller.

Patch 9/9, has a number of small changes in "fetch-pack.c":

  - The call to `promisor_remote_reply()` is simplified a bit as it
    doesn't require a reply string to be assembled.

  - A comment has been reworded for clarity.

  - The call to `gently_parse_list_objects_filter()` and the check to
    error out in case it fails have been simplified.

Range diff since v2
===================

 1:  e19b1518cd =  1:  79255ceba7 promisor-remote: refactor initialising field lists
 2:  8f20baac17 !  2:  012aa7ef19 promisor-remote: allow a client to store fields
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with promisor.
     +	test_must_fail git -C client config remote.otherLop.partialCloneFilter >actual &&
     +
     +	# Check that the largest object is still missing on the server
    -+	check_missing_objects server 1 "$oid"
    ++	check_missing_objects server 1 "$oid" &&
    ++
    ++	# Change the configuration on the server and fetch from the client
    ++	git -C server config remote.lop.partialCloneFilter "blob:limit=7k" &&
    ++	GIT_NO_LAZY_FETCH=0 git -C client fetch \
    ++		--filter="blob:limit=5k" ../server 2>err &&
    ++
    ++	# Check that the fetch updated the configuration on the client
    ++	echo "blob:limit=7k" >expected &&
    ++	git -C client config remote.lop.partialCloneFilter >actual &&
    ++	test_cmp expected actual &&
    ++
    ++	# Check that user is notified when the new filter is stored
    ++	test_grep "Storing new filter from server for remote '\''lop'\''" err &&
    ++	test_grep "'\''blob:limit=8k'\'' -> '\''blob:limit=7k'\''" err
     +'
     +
      test_expect_success "clone with promisor.advertise set to 'true' but don't delete the client" '
 3:  9d53a79600 =  3:  f17a62e73e clone: make filter_options local to cmd_clone()
 4:  b24907e6dc !  4:  3c6e28dd84 fetch: make filter_options local to cmd_fetch()
    @@ builtin/fetch.c: static struct transport *prepare_transport(struct remote *remot
      		set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
      	}
     @@ builtin/fetch.c: static int backfill_tags(struct display_state *display_state,
    - 			 struct ref_transaction *transaction,
      			 struct ref *ref_map,
      			 struct fetch_head *fetch_head,
    --			 const struct fetch_config *config)
    -+			 const struct fetch_config *config,
    + 			 const struct fetch_config *config,
    +-			 struct ref_update_display_info_array *display_array)
    ++			 struct ref_update_display_info_array *display_array,
     +			 struct list_objects_filter_options *filter_options)
      {
      	int retcode, cannot_reuse;
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
      			 * the transaction and don't commit anything.
      			 */
      			if (backfill_tags(&display_state, transport, transaction, tags_ref_map,
    --					  &fetch_head, config))
    -+					  &fetch_head, config, filter_options))
    +-					  &fetch_head, config, &display_array))
    ++					  &fetch_head, config, &display_array, filter_options))
      				retcode = 1;
      		}
      
 5:  90fb77360b !  5:  3037d546b2 doc: fetch: document `--filter=<filter-spec>` option
    @@ Commit message
         The `--filter=<filter-spec>` option is documented in most commands that
         support it except `git fetch`.
     
    -    Let's fix that and document that option using the same words already
    -    used to document it for `git clone`.
    -
    -    Those words could probably be improved, but they are not wrong, so
    -    let's just use them for now and leave improving them for future work.
    +    Let's fix that and document this option. To ensure consistency across
    +    commands, let's reuse the exact description currently found in
    +    `git clone`.
     
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
 6:  b524b24024 =  6:  9ce57b88dc list-objects-filter-options: support 'auto' mode for --filter
 7:  4ec51ee88f !  7:  37042f7019 promisor-remote: keep advertised filters in memory
    @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
      	struct store_info *store_info = NULL;
      	struct string_list_item *item;
      	bool reload_config = false;
    -+	struct string_list captured_filters = STRING_LIST_INIT_DUP;
    ++	struct string_list accepted_filters = STRING_LIST_INIT_DUP;
      
      	if (!repo_config_get_string_tmp(the_repository, "promisor.acceptfromserver", &accept_str)) {
      		if (!*accept_str || !strcasecmp("None", accept_str))
    @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
     +			/* Capture advertised filters for accepted remotes */
     +			if (advertised->filter) {
     +				struct string_list_item *i;
    -+				i = string_list_append(&captured_filters, advertised->name);
    ++				i = string_list_append(&accepted_filters, advertised->name);
     +				i->util = xstrdup(advertised->filter);
     +			}
      		}
    @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
      	if (reload_config)
      		repo_promisor_remote_reinit(repo);
     +
    -+	/* Apply captured filters to the stable repo state */
    -+	for_each_string_list_item(item, &captured_filters) {
    ++	/* Apply accepted remote filters to the stable repo state */
    ++	for_each_string_list_item(item, &accepted_filters) {
     +		struct promisor_remote *r = repo_promisor_remote_find(repo, item->string);
     +		if (r) {
     +			free(r->advertised_filter);
    @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
     +		}
     +	}
     +
    -+	string_list_clear(&captured_filters, 1);
    ++	string_list_clear(&accepted_filters, 1);
     +
     +	/* Mark the remotes as accepted in the repository state */
     +	for (size_t i = 0; i < accepted->nr; i++) {
 -:  ---------- >  8:  dd17069aad promisor-remote: change promisor_remote_reply()'s signature
 8:  994ecb3317 !  9:  0f9675f477 fetch-pack: wire up and enable auto filter logic
    @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
      	struct strvec index_pack_args = STRVEC_INIT;
     +	const char *promisor_remote_config;
     +
    -+	if (server_feature_v2("promisor-remote", &promisor_remote_config)) {
    -+		char *remote_name = promisor_remote_reply(promisor_remote_config);
    -+		free(remote_name);
    -+	}
    ++	if (server_feature_v2("promisor-remote", &promisor_remote_config))
    ++		promisor_remote_reply(promisor_remote_config, NULL);
     +
     +	if (args->filter_options.choice == LOFC_AUTO) {
     +		struct strbuf errbuf = STRBUF_INIT;
     +		char *constructed_filter = promisor_remote_construct_filter(r);
     +
     +		list_objects_filter_release(&args->filter_options);
    -+		/* The result of resolving an 'auto' filter must not be 'auto' */
    ++		/* Disallow 'auto' as a result of the resolution of this 'auto' filter below */
     +		args->filter_options.allow_auto_filter = 0;
     +
    -+		if (constructed_filter)
    -+			gently_parse_list_objects_filter(&args->filter_options,
    -+							 constructed_filter,
    -+							 &errbuf);
    -+
    -+		if (errbuf.len > 0)
    ++		if (constructed_filter &&
    ++		    gently_parse_list_objects_filter(&args->filter_options,
    ++						     constructed_filter,
    ++						     &errbuf))
     +			die(_("couldn't resolve 'auto' filter '%s': %s"),
     +			    constructed_filter, errbuf.buf);
     +
    @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
     
      ## t/t5710-promisor-remote-capability.sh ##
     @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with promisor.storeFields=partialCloneFilter" '
    - 	check_missing_objects server 1 "$oid"
    + 	test_grep "'\''blob:limit=8k'\'' -> '\''blob:limit=7k'\''" err
      '
      
     +test_expect_success "clone and fetch with --filter=auto" '


Christian Couder (9):
  promisor-remote: refactor initialising field lists
  promisor-remote: allow a client to store fields
  clone: make filter_options local to cmd_clone()
  fetch: make filter_options local to cmd_fetch()
  doc: fetch: document `--filter=<filter-spec>` option
  list-objects-filter-options: support 'auto' mode for --filter
  promisor-remote: keep advertised filters in memory
  promisor-remote: change promisor_remote_reply()'s signature
  fetch-pack: wire up and enable auto filter logic

 Documentation/config/promisor.adoc           |  33 +++
 Documentation/fetch-options.adoc             |  19 ++
 Documentation/git-clone.adoc                 |  25 +-
 Documentation/gitprotocol-v2.adoc            |  24 +-
 Makefile                                     |   1 +
 builtin/clone.c                              |  18 +-
 builtin/fetch.c                              |  50 ++--
 connect.c                                    |   3 +-
 fetch-pack.c                                 |  24 ++
 list-objects-filter-options.c                |  37 ++-
 list-objects-filter-options.h                |   6 +
 list-objects-filter.c                        |   8 +
 promisor-remote.c                            | 256 +++++++++++++++++--
 promisor-remote.h                            |  17 +-
 t/meson.build                                |   1 +
 t/t5710-promisor-remote-capability.sh        | 123 +++++++++
 t/unit-tests/u-list-objects-filter-options.c |  53 ++++
 transport.c                                  |   1 +
 18 files changed, 626 insertions(+), 73 deletions(-)
 create mode 100644 t/unit-tests/u-list-objects-filter-options.c

-- 
2.53.0.70.g3d1fd9d397.dirty

