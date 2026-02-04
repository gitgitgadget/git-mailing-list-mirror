Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC11301010
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 11:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770203316; cv=none; b=Fvj/9FwTU7/9ryPSmmtIzLUxy0w/0w9iuDB8MPzFxUArTN0XM1+Y0RGUzD/GZXLABYsXXCU/qYCDAI247AnI+fbrNyLf/jLmZQibwxyM8CLENI/VA3o4dA2XD7atKRbc+uie/jfdvmfDvOztxFM6WD+MpoL/q88kfTrgqqqV5sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770203316; c=relaxed/simple;
	bh=WpW+B46Ot7L60rT1VhVgYNmrxxsLIbaxRGEfgW6IB/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IeqvUEipn2rSIvwaugQgFdz6ObCUHV3Mc2tI8bDVEMTtCY6aeEuxnM6ilRYpDn9/wnHueFknhgclGHJd8rXqfmDEeYNhCYLuN7vXMzA8IWipJuHVbUIgo+SXgvijshgLU2JYHQGZAKpOctQYAcbDK2Aqs1zlEFhld1OK4Dz9vKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gl1icHFG; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gl1icHFG"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so66765615e9.1
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 03:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770203314; x=1770808114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxXw1zYg9R44K59GrBlZc2GlTkvVLlTUA1qo79kHVLM=;
        b=gl1icHFGo+6S4WNLf70Iwl7E8MCgC9Q7DuPZD4JWkqWggsrb3DxrqfCTlCGTeeksDD
         /w6Lv0kaqwClHdYsL9hOrsdUgRXlLe6dhK51oGZU5fvrJYYLitBesCI2u3wF8+rK6nMK
         RKX0J0ltXrDGyerERpv5YDW8KggDRiXdyCCJhKdaKo8QfBj65BdhgvTqxmXj79edU3/9
         6cfs1h0TGs9w5t0TSN8fkG5aSZn1CZygyzd2pZOnaXs2HywePoIy9p0qGXe1yeZmZ6l9
         WwGU28QHNCEvlU6yBY6oUea8ArJ1UO+M/zl40Ffh1THV+rTTw/XZTKU3T2X6i/yj85hy
         BHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770203314; x=1770808114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MxXw1zYg9R44K59GrBlZc2GlTkvVLlTUA1qo79kHVLM=;
        b=waINqHpPu3RYGDZtvgvH5t9LZ+72DLVNXokM8W13TQZWQ1SYfB1jQi2TZmarEzPeUz
         vUzKplSZYsHd5XzfoQLolzRnH9qe5A1mkYGQje4odniwNlDJeEOHeL9ZzGjZc46AxhAR
         qQlONjQyHxBPyZXyyDNULh0CK4m7igy2yRc1Lx0U3uS2tY288QHOdauLYnScnzAhmNEG
         OcRTEz+2qsG6yAY0XuQlI1LOlLf/h6sTMr+t/f1GEedn7L4Y8T5Zd4OrEkWtieMTqccD
         MyNdRSxEX2Zwyo2EUw2pu8tsXX0zalDimzve8rtPZEK2OYn9VhE1OWIQbC5YESjbs92k
         lnlA==
X-Gm-Message-State: AOJu0YznUQQO2fC80rslTtCrYOtZfpadNP+mWHtePSyWbLjpJ2P9F9iy
	E65X3Rjr8G2Uh8oLxIRW4ivkGezPMCvNQ3SD6rrZH63AvumvR8EsHwBPILE+LA==
X-Gm-Gg: AZuq6aJg6VZv0S6XtpFTQOerYvCyysjqhogn+jylSP1NTeIiLAATd3gbAuEmee9SncL
	T+pqkluAl+pbS6CiPnoyGnKvwk5FYAl5Z1hCIFGNuVUj40qewR277JYPFjvUf1TC6mNngeC1kVV
	38G+/+9N6Dfb7ewRkX0mNKYWbYH1uDLbFVVQmAtXgFdrf8GiK72bFVwMNJ8bMcyo+4CMvMXAVSO
	gtMqUp3j5y/cwHLsLAENlRdNmEVClThkQgqNmwupcrHItCiDgndE/Oss4GesJFi6PLOfrz/ZWu8
	QH4dc0G26FpLXASIZrHPSKTPSED4ef2b4qYvKIGVt1gcq+ORbYmplNfcCOYAmfL0+bU5ze83To+
	P6p4xvPwdBbnNsTCEmBklXzLZHNNeo2OjrCO65g7uCukd0V7tBQ5+JNMJ5awk5ZR6DxlGj3Xn33
	bMEdgwiqxW9OiXgVusLGCbK7hjRTPvreUV5g2eEQMLMBDMkTiJ5M/UEVfeknJytYSlXzM24OjbK
	709w7lZZGyi09ai6VsFOGalHQI=
X-Received: by 2002:a05:600c:c042:b0:477:8b77:155e with SMTP id 5b1f17b1804b1-4830e950090mr22532945e9.15.1770203313692;
        Wed, 04 Feb 2026 03:08:33 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436180640f2sm5340096f8f.39.2026.02.04.03.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 03:08:33 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <avila.jn@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 0/8] Implement `promisor.storeFields` and `--filter=auto`
Date: Wed,  4 Feb 2026 12:08:05 +0100
Message-ID: <20260204110818.2919273-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.rc2.10.g12663a1c75.dirty
In-Reply-To: <20251223111113.47473-1-christian.couder@gmail.com>
References: <20251223111113.47473-1-christian.couder@gmail.com>
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

Patches 1/8 and 2/8 are the first part of the series and implement the
new "promisor.storeFields" configuration option. Patch 1/8 is a small
preparatory refactoring.

Patches from 3/8 to 8/8 implement the `--filter=auto` option:

  - Patches 3/8 and 4/8 are cleanups of "builtin/clone.c" and
    "builtin/fetch.c" respectively that make the `filter_options`
    variable local to cmd_clone() or cmd_fetch().

  - Patch 5/8 is a doc update as `--filter=<filter-spec>` wasn't
    documented for `git fetch`.

  - Patch 6/8 improves "list-objects-filter-options.{c,h}" to
    support the new 'auto' mode.

  - Patch 7/8 improves "promisor-remote.{c,h}" to support the new
    'auto' mode.

  - Patch 8/8 make the new 'auto' mode actually work by wiring up
    everything together.

CI Report
=========

All the tests pass, see:

https://github.com/chriscool/git/actions/runs/21665784738

Changes since v1
================

Thanks to Patrick Steinhardt and Jean-Noël Avila for reviewing the
previous version!

In patch 2/8:

  - A note has been added to the commit message to clarify why the new
    "promisor.storeFields" configuration variable might not be very
    useful for partial cloçne filters.
    
  - repo_config_set_gently() is used instead of
    repo_config_set_worktree_gently().

  - new_store_info() and free_store_info() have been renamed
    store_info_new() and store_info_free() respectively.

In patch 5/8:

  - The commit message has been clarified to say that we use the same
    words as in the `git clone`documentation and that we are not
    trying to improve on them.

  - Backticks have been added around "--filter=<filter-spec>".

In patch 6/8:

  - The commit message has been clarified to note that the new
    `allow_auto_filter` flag depends on the command not on user input.

  - A call to strbuf_addstr() has been indented better.

  - A `goto cleanup;` instruction has been added.

Patch 7/9 in v1 has been removed, as another way to combine filter has
been implemented (see below).

In patch 7/8:

  - A typo in the commit message subject has been fixed (missing 's').

  - The commit message has been fixed to say that `advertised_filte`
    is added in the current commit, not a previous one, and to remove
    a mention of `list_objects_filter_combine()` as the previous
    commit that introduced that function has been removed.

  - promisor_remote_construct_filter() now uses a temporary `struct
    list_objects_filter_options` to construct a combined filter
    (instead of `list_objects_filter_combine()`).

  - The comment on top of the declaration of
    promisor_remote_construct_filter() in "promisor-remote.h" has been
    improved a bit.

In patch 8/8:

  - Instead of using list_objects_filter_resolve_auto(), we use
    gently_parse_list_objects_filter() directly.

  - We unset `allow_auto_filter` before parsing the combined filter as
    it must not be 'auto'.

  - A die() message has been improved a bit.

Range diff since v1
===================

 1:  fcaffa7898 =  1:  e19b1518cd promisor-remote: refactor initialising field lists
 2:  9bcfa03987 !  2:  8f20baac17 promisor-remote: allow a client to store fields
    @@ Commit message
         available when the client needs to access the promisor remotes for a
         lazy fetch.
     
    -    In the same way, if it appears that it's better to use a different
    -    filter to access a promisor remote, it could be helpful if the client
    -    could automatically use it.
    -
         To allow this, let's introduce a new "promisor.storeFields"
         configuration variable.
     
    -    Like "promisor.checkFields" and "promisor.sendFields", it should
    -    contain a comma or space separated list of field names. Only the
    -    "partialCloneFilter" and "token" field names are supported for now.
    +    Note that for a partial clone filter, it's less interesting to have
    +    it stored on the client. This is because a filter should be used
    +    right away and we already pass a `--filter=<filter-spec>` option to
    +    `git clone` when starting a partial clone. Storing the filter could
    +    perhaps still be interesting for information purposes.
    +
    +    Like "promisor.checkFields" and "promisor.sendFields", the new
    +    configuration variable should contain a comma or space separated list
    +    of field names. Only the "partialCloneFilter" and "token" field names
    +    are supported for now.
     
         When a server advertises a promisor remote, for example "foo", along
         with for example "token=XXXXX" to a client, and on the client side
    @@ promisor-remote.c: static struct promisor_info *parse_one_advertised_remote(cons
     +			current ? current : "",
     +			advertised);
     +
    -+		repo_config_set_worktree_gently(repo, key, advertised);
    ++		repo_config_set_gently(repo, key, advertised);
     +		free(key);
     +
     +		return true;
    @@ promisor-remote.c: static struct promisor_info *parse_one_advertised_remote(cons
     +	bool store_token;
     +};
     +
    -+static struct store_info *new_store_info(struct repository *repo)
    ++static struct store_info *store_info_new(struct repository *repo)
     +{
     +	struct string_list *fields_to_store = fields_stored();
     +	struct store_info *s = xmalloc(sizeof(*s));
    @@ promisor-remote.c: static struct promisor_info *parse_one_advertised_remote(cons
     +	return s;
     +}
     +
    -+static void free_store_info(struct store_info *s)
    ++static void store_info_free(struct store_info *s)
     +{
     +	if (s) {
     +		promisor_info_list_clear(&s->config_info);
    @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
     -		if (should_accept_remote(accept, advertised, &config_info))
     +		if (should_accept_remote(accept, advertised, &config_info)) {
     +			if (!store_info)
    -+				store_info = new_store_info(repo);
    ++				store_info = store_info_new(repo);
     +			if (promisor_store_advertised_fields(advertised, store_info))
     +				reload_config = true;
     +
    @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
      
      	promisor_info_list_clear(&config_info);
      	string_list_clear(&remote_info, 0);
    -+	free_store_info(store_info);
    ++	store_info_free(store_info);
     +
     +	if (reload_config)
     +		repo_promisor_remote_reinit(repo);
 3:  629b1ba1af =  3:  9d53a79600 clone: make filter_options local to cmd_clone()
 4:  ab9105062d =  4:  b24907e6dc fetch: make filter_options local to cmd_fetch()
 5:  72924115c1 !  5:  90fb77360b doc: fetch: document `--filter=<filter-spec>` option
    @@ Commit message
         The `--filter=<filter-spec>` option is documented in most commands that
         support it except `git fetch`.
     
    -    Let's fix that and document that option properly in the same way as it
    -    is already documented for `git clone`.
    +    Let's fix that and document that option using the same words already
    +    used to document it for `git clone`.
    +
    +    Those words could probably be improved, but they are not wrong, so
    +    let's just use them for now and leave improving them for future work.
     
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
    @@ Documentation/fetch-options.adoc: linkgit:git-config[1].
      This is incompatible with `--recurse-submodules=(yes|on-demand)` and takes
      precedence over the `fetch.output` config option.
      
    -+--filter=<filter-spec>::
    ++`--filter=<filter-spec>`::
     +	Use the partial clone feature and request that the server sends
     +	a subset of reachable objects according to a given object filter.
     +	When using `--filter`, the supplied _<filter-spec>_ is used for
 6:  c2f18b2055 !  6:  b524b24024 list-objects-filter-options: support 'auto' mode for --filter
    @@ Commit message
     
         - Add a new `unsigned int allow_auto_filter : 1;` flag to
           `struct list_objects_filter_options` which specifies if "auto" is
    -      accepted or not.
    +      accepted or not by the current command.
         - Change gently_parse_list_objects_filter() to parse "auto" if it's
           accepted.
         - Make sure we die() if "auto" is combined with another filter.
    @@ Commit message
         If we ever want to give a meaning to combining "auto" with a different
         filter too, nothing prevents us to do that in future work either.
     
    +    Also note that the new `allow_auto_filter` flag depends on the command,
    +    not user choices, so it should be reset to the command default when
    +    `struct list_objects_filter_options` instances are reset.
    +
         While at it, let's add a new "u-list-objects-filter-options.c" file for
         `struct list_objects_filter_options` related unit tests. For now it
         only tests gently_parse_list_objects_filter() though.
    @@ list-objects-filter-options.c: int gently_parse_list_objects_filter(
     -	if (!strcmp(arg, "blob:none")) {
     +	if (!strcmp(arg, "auto")) {
     +		if (!filter_options->allow_auto_filter) {
    -+			strbuf_addstr(
    -+				errbuf,
    -+				_("'auto' filter not supported by this command"));
    ++			strbuf_addstr(errbuf,
    ++				      _("'auto' filter not supported by this command"));
     +			return 1;
     +		}
     +		filter_options->choice = LOFC_AUTO;
    @@ list-objects-filter-options.c: static int parse_combine_subfilter(
     +		goto cleanup;
     +
     +	result = (filter_options->sub[new_index].choice == LOFC_AUTO);
    -+	if (result)
    ++	if (result) {
     +		strbuf_addstr(errbuf, _("an 'auto' filter cannot be combined"));
    ++		goto cleanup;
    ++	}
      
     +cleanup:
      	free(decoded);
 7:  1b88355e66 <  -:  ---------- list-objects-filter-options: implement auto filter resolution
 8:  6ac8bf81f0 !  7:  4ec51ee88f promisor-remote: keep advertised filter in memory
    @@ Metadata
     Author: Christian Couder <chriscool@tuxfamily.org>
     
      ## Commit message ##
    -    promisor-remote: keep advertised filter in memory
    +    promisor-remote: keep advertised filters in memory
     
         Currently, advertised filters are only kept in memory temporarily
         during parsing, or persisted to disk if `promisor.storeFields`
    @@ Commit message
         promisor remotes the client accepted.
     
         To enable the client to construct a filter spec based on these filters,
    -    let's add a `promisor_remote_construct_filter(repo)` function.
    +    let's also add a `promisor_remote_construct_filter(repo)` function.
     
         This function:
     
         - iterates over all accepted promisor remotes in the repository,
         - collects the filters advertised for them (using `advertised_filter`
    -      which a previous commit added to `struct promisor_remote`), and
    -    - generates a single filter spec for them (using the
    -      `list_objects_filter_combine()` function added by a previous commit).
    +      added in this commit, and
    +    - generates a single filter spec for them.
     
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
    @@ promisor-remote.c: void mark_promisor_remotes_as_accepted(struct repository *r,
     +
     +char *promisor_remote_construct_filter(struct repository *repo)
     +{
    -+	struct string_list advertised_filters = STRING_LIST_INIT_NODUP;
     +	struct promisor_remote *r;
    -+	char *result;
    ++	struct list_objects_filter_options filter_options = LIST_OBJECTS_FILTER_INIT;
    ++	struct strbuf err = STRBUF_INIT;
    ++	char *result = NULL;
     +
     +	promisor_remote_init(repo);
     +
     +	for (r = repo->promisor_remote_config->promisors; r; r = r->next) {
     +		if (r->accepted && r->advertised_filter)
    -+			string_list_append(&advertised_filters, r->advertised_filter);
    ++			if (gently_parse_list_objects_filter(&filter_options,
    ++							     r->advertised_filter,
    ++							     &err)) {
    ++				warning(_("promisor remote '%s' advertised invalid filter '%s': %s"),
    ++					r->name, r->advertised_filter, err.buf);
    ++				strbuf_reset(&err);
    ++				continue;
    ++			}
     +	}
     +
    -+	result = list_objects_filter_combine(&advertised_filters);
    ++	if (filter_options.choice)
    ++		result = xstrdup(expand_list_objects_filter_spec(&filter_options));
     +
    -+	string_list_clear(&advertised_filters, 0);
    ++	list_objects_filter_release(&filter_options);
    ++	strbuf_release(&err);
     +
     +	return result;
     +}
    @@ promisor-remote.h: void mark_promisor_remotes_as_accepted(struct repository *rep
      int repo_has_accepted_promisor_remote(struct repository *r);
      
     +/*
    -+ * Use the filters from the accepted remotes to create a filter.
    ++ * Use the filters from the accepted remotes to create a combined
    ++ * filter (useful in `--filter=auto` mode).
     + */
     +char *promisor_remote_construct_filter(struct repository *repo);
     +
 9:  7c822499e2 !  8:  994ecb3317 fetch-pack: wire up and enable auto filter logic
    @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
     +		struct strbuf errbuf = STRBUF_INIT;
     +		char *constructed_filter = promisor_remote_construct_filter(r);
     +
    -+		list_objects_filter_resolve_auto(&args->filter_options,
    -+						 constructed_filter, &errbuf);
    ++		list_objects_filter_release(&args->filter_options);
    ++		/* The result of resolving an 'auto' filter must not be 'auto' */
    ++		args->filter_options.allow_auto_filter = 0;
    ++
    ++		if (constructed_filter)
    ++			gently_parse_list_objects_filter(&args->filter_options,
    ++							 constructed_filter,
    ++							 &errbuf);
    ++
     +		if (errbuf.len > 0)
    -+			die(_("couldn't resolve 'auto' filter: %s"), errbuf.buf);
    ++			die(_("couldn't resolve 'auto' filter '%s': %s"),
    ++			    constructed_filter, errbuf.buf);
     +
     +		free(constructed_filter);
     +		strbuf_release(&errbuf);


Christian Couder (8):
  promisor-remote: refactor initialising field lists
  promisor-remote: allow a client to store fields
  clone: make filter_options local to cmd_clone()
  fetch: make filter_options local to cmd_fetch()
  doc: fetch: document `--filter=<filter-spec>` option
  list-objects-filter-options: support 'auto' mode for --filter
  promisor-remote: keep advertised filters in memory
  fetch-pack: wire up and enable auto filter logic

 Documentation/config/promisor.adoc           |  33 +++
 Documentation/fetch-options.adoc             |  19 ++
 Documentation/git-clone.adoc                 |  25 +-
 Documentation/gitprotocol-v2.adoc            |  24 +-
 Makefile                                     |   1 +
 builtin/clone.c                              |  18 +-
 builtin/fetch.c                              |  50 ++--
 fetch-pack.c                                 |  28 +++
 list-objects-filter-options.c                |  37 ++-
 list-objects-filter-options.h                |   6 +
 list-objects-filter.c                        |   8 +
 promisor-remote.c                            | 232 +++++++++++++++++--
 promisor-remote.h                            |   7 +
 t/meson.build                                |   1 +
 t/t5710-promisor-remote-capability.sh        | 109 +++++++++
 t/unit-tests/u-list-objects-filter-options.c |  53 +++++
 transport.c                                  |   1 +
 17 files changed, 596 insertions(+), 56 deletions(-)
 create mode 100644 t/unit-tests/u-list-objects-filter-options.c

-- 
2.53.0.rc2.10.g12663a1c75.dirty

