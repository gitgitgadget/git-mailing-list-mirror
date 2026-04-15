Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C266E3806A6
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776266073; cv=none; b=LLhEKMmmT9NBbmD8p93TYviyFFWk1di69sUKGrQR/SyU4c1SzPHkTMVCyJeZK/X1ZU++cLoItCaIDV5yAhdS+BoUxQkF7NhDvtwxiGNV36hegq61296cbsDmxGKTgGxvAxy9Jx1UH2rJOLTJRUq20MKyC2jGAhuGmkMal+OSU3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776266073; c=relaxed/simple;
	bh=AtlSMD86Oq0FgIClle1uNyshXnH4OC8JDNPXt3VsXOo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PT/3ngalsbJW6H/MlhRRQgWyJmdNfzZivWgjVkpxWdOmxbEIR0UkqqB2RXA7kB8GYhFGanwA/ygCqaUmaiEMxyJAhlFCFNhauMXAWJ/xjB9cPDnzmC7lNO/ARTvZrP2sg2O4l6t0RWVQefDD/HtCvLmkIVClUzcDxGREHMqrqUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXCGsBgm; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXCGsBgm"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cfd122d78fso963588685a.3
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 08:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776266068; x=1776870868; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7yDxp2EAUhDYOk6hKFWVp7FexchU5GbvjqjJAGvag4=;
        b=VXCGsBgm2k6zJGRgeYzozGiNAiYZyzv2kNz6C+b9zHljCMyl47PuPx+3s9Spgv3fe2
         6SR1B3UW57IL50pkwGsQwTG0EWRkFXLSIpc5Dky5CZv9SaC708+gnQSuH+Ihb+xDfwJb
         B9onSSzpjjw3XewOM8g7Ye3wJQzyRUKg9l4HJo3j1M/sT1F/ootyN4ziAVXeSgLSZrYX
         bDPVpTIm+j0Rj0I+Lki/qClTZOSTV4SrssRcKIZAzDyO+fhV6Gsl9rlmBj4Dhz8gjJBe
         blWAoUy2l2lw8qAvmn1aLa81ghnZ5SJT7M9vmdNwCb5CR5NLQsOKJSzq/auMZUcbf2ii
         qrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776266068; x=1776870868;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H7yDxp2EAUhDYOk6hKFWVp7FexchU5GbvjqjJAGvag4=;
        b=E0BNo3S/huPc0d8SvudfjG/5jEu5lR9Xfni/I87ZztK2d9ewFRAfMJKiq4aRcDchRV
         eNDJ5meqybITTHA1b/CRU9IzhaZZsxbN/3xYvk7v3QtIDsRcbLmrFvM9pHDsgKbwcfTr
         7IPTuRKrkUl/OkW+REEN/sWijm9TDQ2GwNNUzUH/3w4WIB5yrIZdHQXr7NDqgDm1GUts
         J+NQ8voV5CdgNFpZJuNJCKKvO97ZNkgJcm4ta56re6S+ZjrF7n31/5QsNySmpbRcBXrp
         fbeReDdiCsT+AdjkidolsKnQXLFTwtDIAcVCuGJMdphr6PwTPc9VojLZNldjhkAMzMtr
         VKVg==
X-Gm-Message-State: AOJu0YwK6F2Ii60bLPdj/vhqoNv26iVYzIhts+6iOZi1BrTfJptKWzY/
	cTj4AuLnrMadqEj4yfeLOShFIuPeejxNYHoxR8hbBkRYDuGM8xZehUMVboy3ZQ==
X-Gm-Gg: AeBDievdH6itEdaZsqRDtEDbwURIRZYr+Cbk6K4rxWwJvnbLfB6WGeocHTk/vHoFCOo
	s4OMWVM9yNMTQaQ/w+1Zi9Js1Mph2O/PYmQRojG6PmRqHFNpmbtXQ/meaOjWZxQqQNoWrZmoKDy
	nq6nTWcSXiW7gRzo26Kvar2BVmWN6pJ7Tf/X6Gut528bLESMOkSen0uGsnDdT2eZcw8R54AgKkb
	tZecRcU8cGG8qx4A+W3kE7+kMrIxb5Q8mdw4movhAKRdDNh/JxgJiB7Rxty25Hs10IaSCYUAwYz
	gx61ZOn8NeavBKMqypYopuCApof/9LIueFEFJmsbEWOt5Zz7s3jZfaY8gZAnTEhnd1R5SovjIT8
	ZpOOFoB/WDYKcbzHAXoygT32vZXM7DXt6Tn59e7F3JX7TtZF+Vd51U5CbM7wJOWk00N+EQ6GryI
	8uRfn3DO5h+dLFWOxCP55wzt84
X-Received: by 2002:a05:622a:4a83:b0:50d:71aa:6b67 with SMTP id d75a77b69052e-50dd5d16905mr319435941cf.53.1776266067792;
        Wed, 15 Apr 2026 08:14:27 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.13.164])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1afc597fsm14814991cf.24.2026.04.15.08.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:14:27 -0700 (PDT)
Message-Id: <pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
In-Reply-To: <pull.2085.git.1775658970.gitgitgadget@gmail.com>
References: <pull.2085.git.1775658970.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 15:14:19 +0000
Subject: [PATCH v2 0/7] fetch: rework negotiation tip options
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>

Fetch negotiation aims to find enough information from haves and wants such
that the server can be reasonably confident that it will send all necessary
objects and not too many "extra" objects that the client already has.
However, this can break down if there are too many references, since Git
truncates the list of haves based on a few factors (a 256 count limit or the
server sending an ACK at the right time).

We already have the --negotiation-tip feature to focus the set of references
that are used in negotiation, but I feel like this is designed backwards.
I'd rather that we have a way to say "this is an important set of refs, but
feel free to add more refs if needed" than "only use these refs for
negotiation".

Here's an example that demonstrates the problem. In an internal monorepo,
developers work off of the 'main' branch so there are thousands of user
branches that each add a few commits different from the 'main' branch.
However, there is also a long-lived 'release' branch. This branch has a
first-parent history that is parallel to 'main' and each of those commits is
a merge whose second parent is a commit from 'main' that had a successful CI
run. There are additional changes in the 'release' branch merge commits that
add some changelog data, so there is a nontrivial set of novel blob content
in that branch and not just a different set of commits.

The problem we had was that our georeplication system was regularly fetching
from the origin and trying to get all data from all reachable branches. When
the 'release' branch updated, the client would run out of haves before
advertising its copy of the 'release' branch, but it would still list the
new 'release' tip as a want. The server would then think that the client had
never fetched that branch before and would send all of the changelog data
from the whole history of the repo. (This led to a lot of downstream
problems; we mitigated by setting a refspec that stopped fetching the
'release' branch, but this is not ideal.)

What I'd like is a mechanism to say "always advertise the client's version
of 'main' and 'release' but also opportunistically include some user
branches".

Based on my understanding, the '--negotiation-tip' option is close but not
quite what I want. I could have the client only advertise 'release' and
'main' and never advertise any user branches. But then we'd download all
content from each user branch every time it updates. Perhaps this would
happen even with opportunistic inclusion of more haves, but I'd like to
explore this area more.

There's also an issue that the '--negotiation-tip' feature doesn't seem to
have a config key that enables it without CLI arguments. This is something
that we could consider independently.

This patch series adds a new '--negotiation-require' option that does what I
want: it makes sure that these references are used for 'have's during
negotiation. In order to help clarify the difference between this and
'--negotiation-tip', I first create a synonym called
'--negotiation-restrict'.

Both of these options get 'remote.*.negotiation(Require|Restrict)' config
options that enable their behavior by default.

During development, I had briefly considered only using config values, but
that required some strange changes to care about the remote name in the
transport layer. This was most different in the 'git push' integration. When
I discovered the '--negotiation-tip' feature during the process, that gave
me a clear pattern to follow with the addition of a config on top.


Updates in v2
=============

This version is a near-complete rewrite based on feedback around the names
of the previous option and config. The --negotiation-restrict option is new
and the ability to set it via config is also new.

I did try to be more careful around translatable error messages, too.

Thanks, -Stolee

Derrick Stolee (7):
  t5516: fix test order flakiness
  fetch: add --negotiation-restrict option
  transport: rename negotiation_tips
  remote: add remote.*.negotiationRestrict config
  fetch: add --negotiation-require option for negotiation
  remote: add negotiationRequire config as default for
    --negotiation-require
  send-pack: pass negotiation config in push

 Documentation/config/remote.adoc |  40 ++++++++
 Documentation/fetch-options.adoc |  27 ++++++
 builtin/fetch.c                  |  59 ++++++++++--
 builtin/pull.c                   |   6 ++
 fetch-pack.c                     | 114 +++++++++++++++++++---
 fetch-pack.h                     |  14 ++-
 remote.c                         |  12 +++
 remote.h                         |   2 +
 send-pack.c                      |  34 +++++--
 send-pack.h                      |   2 +
 t/t5510-fetch.sh                 | 159 +++++++++++++++++++++++++++++++
 t/t5516-fetch-push.sh            |  32 ++++++-
 t/t5702-protocol-v2.sh           |   4 +-
 transport-helper.c               |   2 +-
 transport.c                      |  16 ++--
 transport.h                      |  10 +-
 16 files changed, 489 insertions(+), 44 deletions(-)


base-commit: 6e8d538aab8fe4dd07ba9fb87b5c7edcfa5706ad
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2085%2Fderrickstolee%2Fmust-have-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2085/derrickstolee/must-have-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2085

Range-diff vs v1:

 1:  540a5682b4 = 1:  466c56abe0 t5516: fix test order flakiness
 -:  ---------- > 2:  9a25b0fade fetch: add --negotiation-restrict option
 -:  ---------- > 3:  0f89665aee transport: rename negotiation_tips
 -:  ---------- > 4:  a731f4fc87 remote: add remote.*.negotiationRestrict config
 2:  8b39eb9e6c ! 5:  49c80cef2e fetch: add --must-have option for negotiation
     @@ Metadata
      Author: Derrick Stolee <stolee@gmail.com>
      
       ## Commit message ##
     -    fetch: add --must-have option for negotiation
     +    fetch: add --negotiation-require option for negotiation
      
     -    Add a --must-have option to git fetch that specifies ref patterns whose
     -    tips should always be sent as "have" commits during negotiation,
     -    regardless of what the negotiation algorithm selects.
     +    Add a new --negotiation-require option to 'git fetch', which ensures
     +    that certain ref tips are always sent as 'have' lines during fetch
     +    negotiation, regardless of what the negotiation algorithm selects.
      
     -    Each value is either an exact ref name (e.g. refs/heads/release) or a
     -    glob pattern (e.g. refs/heads/release/*). The pattern syntax is the same
     -    as for --negotiation-tip.
     +    This is useful when the repository has a large number of references, so
     +    the normal negotiation algorithm truncates the list. This is especially
     +    important in repositories with long parallel commit histories. For
     +    example, a repo could have a 'dev' branch for development and a
     +    'release' branch for released versions. If the 'dev' branch isn't
     +    selected for negotiation, then it's not a big deal because there are
     +    many in-progress development branches with a shared history. However, if
     +    'release' is not selected for negotiation, then the server may think
     +    that this is the first time the client has asked for that reference,
     +    causing a full download of its parallel commit history (and any extra
     +    data that may be unique to that branch). This is based on a real example
     +    where certain fetches would grow to 60+ GB when a release branch
     +    updated.
      
     -    This is useful when certain references are important for negotiation
     -    efficiency but might be skipped by the negotiation algorithm or excluded
     -    by --negotiation-tip. Unlike --negotiation-tip which restricts the have
     -    set, --must-have is additive: the negotiation algorithm still runs and
     -    advertises its own selected commits, but the refs matching --must-have
     -    are sent unconditionally on top of those.
     +    This option is a complement to --negotiation-restrict, which reduces the
     +    negotiation ref set to a specific list. In the earlier example, using
     +    --negotiation-restrict to focus the negotiation to 'dev' and 'release'
     +    would avoid those problematic downloads, but would still not allow
     +    advertising potentially-relevant user brances. In this way, the
     +    'require' version solves the problem I mention while allowing
     +    negotiation to pick other references opportunistically. The two options
     +    can also be combined to allow the best of both worlds.
      
     -    If --negotiation-tip is used, the have set is first restricted by that
     -    option and then increased to include the tips specified by --must-have.
     +    The argument may be an exact ref name or a glob pattern. Non-existent
     +    refs are silently ignored.
      
     -    Due to the comparision with --negotiation-tip, a previously untranslated
     -    warning around --negotiation-tip is converted into a translatable string
     -    with a swap for which option that is relevant.
     -
     -    Getting this functionality to work requires moving these options through
     -    the transport API layer.
     +    Also add --negotiation-require to 'git pull' passthrough options.
      
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
     @@ Documentation/fetch-options.adoc: See also the `fetch.negotiationAlgorithm` and
       configuration variables documented in linkgit:git-config[1], and the
       `--negotiate-only` option below.
       
     -+`--must-have=<revision>`::
     ++`--negotiation-require=<revision>`::
      +	Ensure that the given ref tip is always sent as a "have" line
      +	during fetch negotiation, regardless of what the negotiation
      +	algorithm selects.  This is useful to guarantee that common
      +	history reachable from specific refs is always considered, even
     -+	when `--negotiation-tip` restricts the set of tips or when the
     -+	negotiation algorithm would otherwise skip them.
     ++	when `--negotiation-restrict` restricts the set of tips or when
     ++	the negotiation algorithm would otherwise skip them.
      ++
      +This option may be specified more than once; if so, each ref is sent
      +unconditionally.
      ++
      +The argument may be an exact ref name (e.g. `refs/heads/release`) or a
      +glob pattern (e.g. `refs/heads/release/{asterisk}`).  The pattern syntax
     -+is the same as for `--negotiation-tip`.
     ++is the same as for `--negotiation-restrict`.
      ++
     -+If `--negotiation-tip` is used, the have set is first restricted by that
     -+option and then increased to include the tips specified by `--must-have`.
     ++If `--negotiation-restrict` is used, the have set is first restricted by
     ++that option and then increased to include the tips specified by
     ++`--negotiation-require`.
      +
       `--negotiate-only`::
       	Do not fetch anything from the server, and instead print the
     @@ builtin/fetch.c: static struct transport *gsecondary;
       static struct refspec refmap = REFSPEC_INIT_FETCH;
       static struct string_list server_options = STRING_LIST_INIT_DUP;
       static struct string_list negotiation_tip = STRING_LIST_INIT_NODUP;
     -+static struct string_list must_have = STRING_LIST_INIT_NODUP;
     ++static struct string_list negotiation_require = STRING_LIST_INIT_NODUP;
       
       struct fetch_config {
       	enum display_format display_format;
      @@ builtin/fetch.c: static struct transport *prepare_transport(struct remote *remote, int deepen,
     - 		if (transport->smart_options)
     - 			add_negotiation_tips(transport->smart_options);
     - 		else
     --			warning("ignoring --negotiation-tip because the protocol does not support it");
     -+			warning(_("ignoring %s because the protocol does not support it"), "--negotiation-tip");
     -+	}
     -+	if (must_have.nr) {
     + 			strbuf_release(&config_name);
     + 		}
     + 	}
     ++	if (negotiation_require.nr) {
      +		if (transport->smart_options)
     -+			transport->smart_options->must_have = &must_have;
     ++			transport->smart_options->negotiation_require = &negotiation_require;
      +		else
     -+			warning(_("ignoring %s because the protocol does not support it"), "--must-have");
     - 	}
     ++			warning(_("ignoring %s because the protocol does not support it"),
     ++				"--negotiation-require");
     ++	}
       	return transport;
       }
     + 
      @@ builtin/fetch.c: int cmd_fetch(int argc,
     - 		OPT_IPVERSION(&family),
     - 		OPT_STRING_LIST(0, "negotiation-tip", &negotiation_tip, N_("revision"),
       				N_("report that we have only objects reachable from this object")),
     -+		OPT_STRING_LIST(0, "must-have", &must_have, N_("revision"),
     + 		OPT_STRING_LIST(0, "negotiation-restrict", &negotiation_tip, N_("revision"),
     + 				N_("report that we have only objects reachable from this object")),
     ++		OPT_STRING_LIST(0, "negotiation-require", &negotiation_require, N_("revision"),
      +				N_("ensure this ref is always sent as a negotiation have")),
       		OPT_BOOL(0, "negotiate-only", &negotiate_only,
       			 N_("do not fetch a packfile; instead, print ancestors of negotiation tips")),
       		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
      
     + ## builtin/pull.c ##
     +@@ builtin/pull.c: int cmd_pull(int argc,
     + 		OPT_PASSTHRU_ARGV(0, "negotiation-restrict", &opt_fetch, N_("revision"),
     + 			N_("report that we have only objects reachable from this object"),
     + 			0),
     ++		OPT_PASSTHRU_ARGV(0, "negotiation-require", &opt_fetch, N_("revision"),
     ++			N_("ensure this ref is always sent as a negotiation have"),
     ++			0),
     + 		OPT_BOOL(0, "show-forced-updates", &opt_show_forced_updates,
     + 			 N_("check for forced-updates on all updated branches")),
     + 		OPT_PASSTHRU(0, "set-upstream", &set_upstream, NULL,
     +
       ## fetch-pack.c ##
      @@
       #include "oidset.h"
     @@ fetch-pack.c: static void send_filter(struct fetch_pack_args *args,
      +static int add_oid_to_oidset(const struct reference *ref, void *cb_data)
      +{
      +	struct oidset *set = cb_data;
     -+	oidset_insert(set, ref->oid);
     ++	if (odb_has_object(the_repository->objects, ref->oid, 0))
     ++		oidset_insert(set, ref->oid);
      +	return 0;
      +}
      +
     -+static void resolve_must_have(const struct string_list *must_have,
     -+			      struct oidset *result)
     ++static void resolve_negotiation_require(const struct string_list *negotiation_require,
     ++					struct oidset *result)
      +{
      +	struct string_list_item *item;
      +
     -+	if (!must_have || !must_have->nr)
     ++	if (!negotiation_require || !negotiation_require->nr)
      +		return;
      +
     -+	for_each_string_list_item(item, must_have) {
     ++	for_each_string_list_item(item, negotiation_require) {
      +		if (!has_glob_specials(item->string)) {
      +			struct object_id oid;
      +			if (repo_get_oid(the_repository, item->string, &oid))
     @@ fetch-pack.c: static int find_common(struct fetch_negotiator *negotiator,
       	struct strbuf req_buf = STRBUF_INIT;
       	size_t state_len = 0;
       	struct packet_reader reader;
     -+	struct oidset must_have_oids = OIDSET_INIT;
     ++	struct oidset negotiation_require_oids = OIDSET_INIT;
       
       	if (args->stateless_rpc && multi_ack == 1)
       		die(_("the option '%s' requires '%s'"), "--stateless-rpc", "multi_ack_detailed");
     @@ fetch-pack.c: static int find_common(struct fetch_negotiator *negotiator,
       	flushes = 0;
       	retval = -1;
      +
     -+	/* Send unconditional haves from --must-have */
     -+	resolve_must_have(args->must_have, &must_have_oids);
     -+	if (oidset_size(&must_have_oids)) {
     ++	/* Send unconditional haves from --negotiation-require */
     ++	resolve_negotiation_require(args->negotiation_require,
     ++				    &negotiation_require_oids);
     ++	if (oidset_size(&negotiation_require_oids)) {
      +		struct oidset_iter iter;
     -+		oidset_iter_init(&must_have_oids, &iter);
     ++		oidset_iter_init(&negotiation_require_oids, &iter);
      +
      +		while ((oid = oidset_iter_next(&iter))) {
      +			packet_buf_write(&req_buf, "have %s\n",
     @@ fetch-pack.c: static int find_common(struct fetch_negotiator *negotiator,
      +	}
      +
       	while ((oid = negotiator->next(negotiator))) {
     -+		/* avoid duplicate oids from --must-have */
     -+		if (oidset_contains(&must_have_oids, oid))
     ++		/* avoid duplicate oids from --negotiation-require */
     ++		if (oidset_contains(&negotiation_require_oids, oid))
      +			continue;
       		packet_buf_write(&req_buf, "have %s\n", oid_to_hex(oid));
       		print_verbose(args, "have %s", oid_to_hex(oid));
     @@ fetch-pack.c: done:
       		flushes++;
       	}
       	strbuf_release(&req_buf);
     -+	oidset_clear(&must_have_oids);
     ++	oidset_clear(&negotiation_require_oids);
       
       	if (!got_ready || !no_done)
       		consume_shallow_list(args, &reader);
     @@ fetch-pack.c: static void add_common(struct strbuf *req_buf, struct oidset *comm
       		     struct strbuf *req_buf,
      -		     int *haves_to_send)
      +		     int *haves_to_send,
     -+		     struct oidset *must_have_oids)
     ++		     struct oidset *negotiation_require_oids)
       {
       	int haves_added = 0;
       	const struct object_id *oid;
       
     -+	/* Send unconditional haves from --must-have */
     -+	if (must_have_oids) {
     ++	/* Send unconditional haves from --negotiation-require */
     ++	if (negotiation_require_oids) {
      +		struct oidset_iter iter;
     -+		oidset_iter_init(must_have_oids, &iter);
     ++		oidset_iter_init(negotiation_require_oids, &iter);
      +
      +		while ((oid = oidset_iter_next(&iter)))
      +			packet_buf_write(req_buf, "have %s\n",
     @@ fetch-pack.c: static void add_common(struct strbuf *req_buf, struct oidset *comm
      +	}
      +
       	while ((oid = negotiator->next(negotiator))) {
     -+		if (must_have_oids && oidset_contains(must_have_oids, oid))
     ++		if (negotiation_require_oids &&
     ++		    oidset_contains(negotiation_require_oids, oid))
      +			continue;
       		packet_buf_write(req_buf, "have %s\n", oid_to_hex(oid));
       		if (++haves_added >= *haves_to_send)
     @@ fetch-pack.c: static int send_fetch_request(struct fetch_negotiator *negotiator,
       			      int *haves_to_send, int *in_vain,
      -			      int sideband_all, int seen_ack)
      +			      int sideband_all, int seen_ack,
     -+			      struct oidset *must_have_oids)
     ++			      struct oidset *negotiation_require_oids)
       {
       	int haves_added;
       	int done_sent = 0;
     @@ fetch-pack.c: static int send_fetch_request(struct fetch_negotiator *negotiator,
       
      -	haves_added = add_haves(negotiator, &req_buf, haves_to_send);
      +	haves_added = add_haves(negotiator, &req_buf, haves_to_send,
     -+			       must_have_oids);
     ++			       negotiation_require_oids);
       	*in_vain += haves_added;
       	trace2_data_intmax("negotiation_v2", the_repository, "haves_added", haves_added);
       	trace2_data_intmax("negotiation_v2", the_repository, "in_vain", *in_vain);
     @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
       	struct ref *ref = copy_ref_list(orig_ref);
       	enum fetch_state state = FETCH_CHECK_LOCAL;
       	struct oidset common = OIDSET_INIT;
     -+	struct oidset must_have_oids = OIDSET_INIT;
     ++	struct oidset negotiation_require_oids = OIDSET_INIT;
       	struct packet_reader reader;
       	int in_vain = 0, negotiation_started = 0;
       	int negotiation_round = 0;
      @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
     - 		reader.me = "fetch-pack";
     - 	}
     + 				state = FETCH_SEND_REQUEST;
       
     -+	resolve_must_have(args->must_have, &must_have_oids);
     -+
     - 	while (state != FETCH_DONE) {
     - 		switch (state) {
     - 		case FETCH_CHECK_LOCAL:
     + 			mark_tips(negotiator, args->negotiation_restrict_tips);
     ++			resolve_negotiation_require(args->negotiation_require,
     ++						    &negotiation_require_oids);
     + 			for_each_cached_alternate(negotiator,
     + 						  insert_one_alternate_object);
     + 			break;
      @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
       					       &common,
       					       &haves_to_send, &in_vain,
       					       reader.use_sideband,
      -					       seen_ack)) {
      +					       seen_ack,
     -+					       &must_have_oids)) {
     ++					       &negotiation_require_oids)) {
       				trace2_region_leave_printf("negotiation_v2", "round",
       							   the_repository, "%d",
       							   negotiation_round);
     @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
       		negotiator->release(negotiator);
       
       	oidset_clear(&common);
     -+	oidset_clear(&must_have_oids);
     ++	oidset_clear(&negotiation_require_oids);
       	return ref;
       }
       
     -@@ fetch-pack.c: void negotiate_using_fetch(const struct oid_array *negotiation_tips,
     +@@ fetch-pack.c: void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
       			   const struct string_list *server_options,
       			   int stateless_rpc,
       			   int fd[],
      -			   struct oidset *acked_commits)
      +			   struct oidset *acked_commits,
     -+			   const struct string_list *must_have)
     ++			   const struct string_list *negotiation_require)
       {
       	struct fetch_negotiator negotiator;
       	struct packet_reader reader;
       	struct object_array nt_object_array = OBJECT_ARRAY_INIT;
       	struct strbuf req_buf = STRBUF_INIT;
     -+	struct oidset must_have_oids = OIDSET_INIT;
     ++	struct oidset negotiation_require_oids = OIDSET_INIT;
       	int haves_to_send = INITIAL_FLUSH;
       	int in_vain = 0;
       	int seen_ack = 0;
     -@@ fetch-pack.c: void negotiate_using_fetch(const struct oid_array *negotiation_tips,
     - 			   add_to_object_array,
     - 			   &nt_object_array);
     +@@ fetch-pack.c: void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
     + 	fetch_negotiator_init(the_repository, &negotiator);
     + 	mark_tips(&negotiator, negotiation_restrict_tips);
       
     -+	resolve_must_have(must_have, &must_have_oids);
     ++	resolve_negotiation_require(negotiation_require,
     ++				    &negotiation_require_oids);
      +
     - 	trace2_region_enter("fetch-pack", "negotiate_using_fetch", the_repository);
     - 	while (!last_iteration) {
     - 		int haves_added;
     -@@ fetch-pack.c: void negotiate_using_fetch(const struct oid_array *negotiation_tips,
     + 	packet_reader_init(&reader, fd[0], NULL, 0,
     + 			   PACKET_READ_CHOMP_NEWLINE |
     + 			   PACKET_READ_DIE_ON_ERR_PACKET);
     +@@ fetch-pack.c: void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
       
       		packet_buf_write(&req_buf, "wait-for-done");
       
      -		haves_added = add_haves(&negotiator, &req_buf, &haves_to_send);
      +		haves_added = add_haves(&negotiator, &req_buf, &haves_to_send,
     -+				       &must_have_oids);
     ++				       &negotiation_require_oids);
       		in_vain += haves_added;
       		if (!haves_added || (seen_ack && in_vain >= MAX_IN_VAIN))
       			last_iteration = 1;
     -@@ fetch-pack.c: void negotiate_using_fetch(const struct oid_array *negotiation_tips,
     +@@ fetch-pack.c: void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
       
       	clear_common_flag(acked_commits);
       	object_array_clear(&nt_object_array);
     -+	oidset_clear(&must_have_oids);
     ++	oidset_clear(&negotiation_require_oids);
       	negotiator.release(&negotiator);
       	strbuf_release(&req_buf);
       }
     @@ fetch-pack.c: void negotiate_using_fetch(const struct oid_array *negotiation_tip
       ## fetch-pack.h ##
      @@ fetch-pack.h: struct fetch_pack_args {
       	 */
     - 	const struct oid_array *negotiation_tips;
     + 	const struct oid_array *negotiation_restrict_tips;
       
      +	/*
      +	 * If non-empty, ref patterns whose tips should always be sent
      +	 * as "have" lines during negotiation, regardless of what the
      +	 * negotiation algorithm selects.
      +	 */
     -+	const struct string_list *must_have;
     ++	const struct string_list *negotiation_require;
      +
       	unsigned deepen_relative:1;
       	unsigned quiet:1;
       	unsigned keep_pack:1;
     -@@ fetch-pack.h: void negotiate_using_fetch(const struct oid_array *negotiation_tips,
     +@@ fetch-pack.h: void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
       			   const struct string_list *server_options,
       			   int stateless_rpc,
       			   int fd[],
      -			   struct oidset *acked_commits);
      +			   struct oidset *acked_commits,
     -+			   const struct string_list *must_have);
     ++			   const struct string_list *negotiation_require);
       
       /*
        * Print an appropriate error message for each sought ref that wasn't
      
       ## t/t5510-fetch.sh ##
     -@@ t/t5510-fetch.sh: test_expect_success REFFILES "HEAD is updated even with conflicts" '
     - 	)
     +@@ t/t5510-fetch.sh: test_expect_success 'CLI --negotiation-restrict overrides remote config' '
     + 	test_grep ! "fetch> have $BETA_1" trace
       '
       
     -+test_expect_success '--must-have includes configured refs as haves' '
     ++test_expect_success '--negotiation-require includes configured refs as haves' '
      +	test_when_finished rm -f trace &&
      +	setup_negotiation_tip server server 0 &&
      +
     -+	# With --negotiation-tip restricting tips, only alpha_1 is
     -+	# normally sent. --must-have should also include beta_1.
      +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
     -+		--negotiation-tip=alpha_1 \
     -+		--must-have=refs/tags/beta_1 \
     ++		--negotiation-restrict=alpha_1 \
     ++		--negotiation-require=refs/tags/beta_1 \
      +		origin alpha_s beta_s &&
      +
      +	ALPHA_1=$(git -C client rev-parse alpha_1) &&
     @@ t/t5510-fetch.sh: test_expect_success REFFILES "HEAD is updated even with confli
      +	test_grep "fetch> have $BETA_1" trace
      +'
      +
     -+test_expect_success '--must-have works with glob patterns' '
     ++test_expect_success '--negotiation-require works with glob patterns' '
      +	test_when_finished rm -f trace &&
      +	setup_negotiation_tip server server 0 &&
      +
      +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
     -+		--negotiation-tip=alpha_1 \
     -+		--must-have="refs/tags/beta_*" \
     ++		--negotiation-restrict=alpha_1 \
     ++		--negotiation-require="refs/tags/beta_*" \
      +		origin alpha_s beta_s &&
      +
      +	BETA_1=$(git -C client rev-parse beta_1) &&
     @@ t/t5510-fetch.sh: test_expect_success REFFILES "HEAD is updated even with confli
      +	test_grep "fetch> have $BETA_2" trace
      +'
      +
     -+test_expect_success '--must-have is additive with negotiation' '
     ++test_expect_success '--negotiation-require is additive with negotiation' '
      +	test_when_finished rm -f trace &&
      +	setup_negotiation_tip server server 0 &&
      +
     -+	# Without --negotiation-tip, all local refs are used as tips.
     -+	# --must-have should add its refs unconditionally on top.
      +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
     -+		--must-have=refs/tags/beta_1 \
     ++		--negotiation-require=refs/tags/beta_1 \
      +		origin alpha_s beta_s &&
      +
      +	BETA_1=$(git -C client rev-parse beta_1) &&
      +	test_grep "fetch> have $BETA_1" trace
      +'
      +
     -+test_expect_success '--must-have ignores non-existent refs silently' '
     ++test_expect_success '--negotiation-require ignores non-existent refs silently' '
      +	setup_negotiation_tip server server 0 &&
      +
      +	git -C client fetch --quiet \
     -+		--negotiation-tip=alpha_1 \
     -+		--must-have=refs/tags/nonexistent \
     ++		--negotiation-restrict=alpha_1 \
     ++		--negotiation-require=refs/tags/nonexistent \
      +		origin alpha_s beta_s 2>err &&
      +	test_must_be_empty err
      +'
      +
     -+test_expect_success '--must-have avoids duplicates with negotiator' '
     ++test_expect_success '--negotiation-require avoids duplicates with negotiator' '
      +	test_when_finished rm -f trace &&
      +	setup_negotiation_tip server server 0 &&
      +
     -+	# Configure a ref that will also be a negotiation tip.
     -+	# fetch should still complete successfully.
      +	ALPHA_1=$(git -C client rev-parse alpha_1) &&
      +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
     -+		--negotiation-tip=alpha_1 \
     -+		--must-have=refs/tags/alpha_1 \
     ++		--negotiation-restrict=alpha_1 \
     ++		--negotiation-require=refs/tags/alpha_1 \
      +		origin alpha_s beta_s &&
      +
     -+	# alpha_1 should appear as a have
      +	test_grep "fetch> have $ALPHA_1" trace >matches &&
      +	test_line_count = 1 matches
      +'
      +
     - . "$TEST_DIRECTORY"/lib-httpd.sh
     - start_httpd
     - 
     + test_expect_success SYMLINKS 'clone does not get confused by a D/F conflict' '
     + 	git init df-conflict &&
     + 	(
      
       ## transport.c ##
      @@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
       	args.stateless_rpc = transport->stateless_rpc;
       	args.server_options = transport->server_options;
     - 	args.negotiation_tips = data->options.negotiation_tips;
     -+	args.must_have = data->options.must_have;
     + 	args.negotiation_restrict_tips = data->options.negotiation_restrict_tips;
     ++	args.negotiation_require = data->options.negotiation_require;
       	args.reject_shallow_remote = transport->smart_options->reject_shallow;
       
       	if (!data->finished_handshake) {
     @@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
       					      data->fd,
      -					      data->options.acked_commits);
      +					      data->options.acked_commits,
     -+					      data->options.must_have);
     ++					      data->options.negotiation_require);
       			ret = 0;
       		}
       		goto cleanup;
     @@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
       ## transport.h ##
      @@ transport.h: struct git_transport_options {
       	 */
     - 	struct oid_array *negotiation_tips;
     + 	struct oid_array *negotiation_restrict_tips;
       
      +	/*
      +	 * If non-empty, ref patterns whose tips should always be sent
      +	 * as "have" lines during negotiation.
      +	 */
     -+	const struct string_list *must_have;
     ++	const struct string_list *negotiation_require;
      +
       	/*
       	 * If allocated, whenever transport_fetch_refs() is called, add known
 3:  fbc98b0cbb ! 6:  081f904c07 remote: add mustHave config as default for --must-have
     @@ Metadata
      Author: Derrick Stolee <stolee@gmail.com>
      
       ## Commit message ##
     -    remote: add mustHave config as default for --must-have
     +    remote: add negotiationRequire config as default for --negotiation-require
      
     -    Add a new multi-valued config option remote.<name>.mustHave that
     -    specifies ref patterns whose tips should always be sent as "have"
     -    commits during fetch negotiation with that remote.
     +    Add a new 'remote.<name>.negotiationRequire' multi-valued config option
     +    that provides default values for --negotiation-require when no
     +    --negotiation-require arguments are specified over the command line.
     +    This is a mirror of how 'remote.<name>.negotiationRestrict' specifies
     +    defaults for the --negotiation-restrict arguments.
      
     -    Parse the option in handle_config() following the same pattern as
     -    remote.<name>.serverOption. Store the values in a string_list on struct
     -    remote so they are available per-remote.
     +    Each value is either an exact ref name or a glob pattern whose tips
     +    should always be sent as 'have' lines during negotiation. The config
     +    values are resolved through the same resolve_negotiation_require()
     +    codepath as the CLI options.
      
     -    In builtin/fetch.c, when no --must-have options are given on the command
     -    line, use the remote.<name>.mustHave config values as the default. If
     -    the user explicitly provides --must-have on the CLI, the config is not
     -    used, giving CLI precedence.
     +    This option is additive with the normal negotiation process: the
     +    negotiation algorithm still runs and advertises its own selected
     +    commits, but the refs matching the config are sent unconditionally
     +    on top of those heuristically selected commits.
      
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## Documentation/config/remote.adoc ##
     -@@ Documentation/config/remote.adoc: priority configuration file (e.g. `.git/config` in a repository) to clear
     - the values inherited from a lower priority configuration files (e.g.
     - `$HOME/.gitconfig`).
     +@@ Documentation/config/remote.adoc: command-line option.  If `--negotiation-restrict` (or its synonym
     + `--negotiation-tip`) is specified on the command line, then the config
     + values are not used.
       
     -+remote.<name>.mustHave::
     ++remote.<name>.negotiationRequire::
      +	When negotiating with this remote during `git fetch` and `git push`,
      +	the client advertises a list of commits that exist locally.  In
      +	repos with many references, this list of "haves" can be truncated.
     @@ Documentation/config/remote.adoc: priority configuration file (e.g. `.git/config
      ++
      +Each value is either an exact ref name (e.g. `refs/heads/release`) or a
      +glob pattern (e.g. `refs/heads/release/*`).  The pattern syntax is the same
     -+as for `--negotiation-tip`.
     ++as for `--negotiation-restrict`.
      ++
     -+These config values are used as defaults for the `--must-have` command-line
     -+option.  If `--must-have` is specified on the command line, then the config
     -+values are not used.
     ++These config values are used as defaults for the `--negotiation-require`
     ++command-line option.  If `--negotiation-require` is specified on the
     ++command line, then the config values are not used.
      ++
      +This option is additive with the normal negotiation process: the
      +negotiation algorithm still runs and advertises its own selected commits,
     -+but the refs matching `remote.<name>.mustHave` are sent unconditionally on
     -+top of those heuristically selected commits.  This option is also used
     -+during push negotiation when `push.negotiate` is enabled.
     ++but the refs matching `remote.<name>.negotiationRequire` are sent
     ++unconditionally on top of those heuristically selected commits.  This
     ++option is also used during push negotiation when `push.negotiate` is
     ++enabled.
      +
       remote.<name>.followRemoteHEAD::
       	How linkgit:git-fetch[1] should handle updates to `remotes/<name>/HEAD`
       	when fetching using the configured refspecs of a remote.
      
       ## Documentation/fetch-options.adoc ##
     -@@ Documentation/fetch-options.adoc: is the same as for `--negotiation-tip`.
     - +
     - If `--negotiation-tip` is used, the have set is first restricted by that
     - option and then increased to include the tips specified by `--must-have`.
     +@@ Documentation/fetch-options.adoc: is the same as for `--negotiation-restrict`.
     + If `--negotiation-restrict` is used, the have set is first restricted by
     + that option and then increased to include the tips specified by
     + `--negotiation-require`.
      ++
      +If this option is not specified on the command line, then any
     -+`remote.<name>.mustHave` config values for the current remote are used
     -+instead.
     ++`remote.<name>.negotiationRequire` config values for the current remote
     ++are used instead.
       
       `--negotiate-only`::
       	Do not fetch anything from the server, and instead print the
      
       ## builtin/fetch.c ##
      @@ builtin/fetch.c: static struct transport *prepare_transport(struct remote *remote, int deepen,
     - 			transport->smart_options->must_have = &must_have;
       		else
     - 			warning(_("ignoring %s because the protocol does not support it"), "--must-have");
     -+	} else if (remote->must_have.nr) {
     -+		if (transport->smart_options)
     -+			transport->smart_options->must_have = &remote->must_have;
     + 			warning(_("ignoring %s because the protocol does not support it"),
     + 				"--negotiation-require");
     ++	} else if (remote->negotiation_require.nr) {
     ++		if (transport->smart_options) {
     ++			transport->smart_options->negotiation_require = &remote->negotiation_require;
     ++		} else {
     ++			struct strbuf config_name = STRBUF_INIT;
     ++			strbuf_addf(&config_name, "remote.%s.negotiationRequire", remote->name);
     ++			warning(_("ignoring %s because the protocol does not support it"),
     ++				config_name.buf);
     ++			strbuf_release(&config_name);
     ++		}
       	}
       	return transport;
       }
      
       ## remote.c ##
      @@ remote.c: static struct remote *make_remote(struct remote_state *remote_state,
     - 	refspec_init_push(&ret->push);
       	refspec_init_fetch(&ret->fetch);
       	string_list_init_dup(&ret->server_options);
     -+	string_list_init_dup(&ret->must_have);
     + 	string_list_init_dup(&ret->negotiation_restrict);
     ++	string_list_init_dup(&ret->negotiation_require);
       
       	ALLOC_GROW(remote_state->remotes, remote_state->remotes_nr + 1,
       		   remote_state->remotes_alloc);
      @@ remote.c: static void remote_clear(struct remote *remote)
     - 	FREE_AND_NULL(remote->http_proxy);
       	FREE_AND_NULL(remote->http_proxy_authmethod);
       	string_list_clear(&remote->server_options, 0);
     -+	string_list_clear(&remote->must_have, 0);
     + 	string_list_clear(&remote->negotiation_restrict, 0);
     ++	string_list_clear(&remote->negotiation_require, 0);
       }
       
       static void add_merge(struct branch *branch, const char *name)
      @@ remote.c: static int handle_config(const char *key, const char *value,
     - 	} else if (!strcmp(subkey, "serveroption")) {
     - 		return parse_transport_option(key, value,
     - 					      &remote->server_options);
     -+	} else if (!strcmp(subkey, "musthave")) {
     + 		if (!value)
     + 			return config_error_nonbool(key);
     + 		string_list_append(&remote->negotiation_restrict, value);
     ++	} else if (!strcmp(subkey, "negotiationrequire")) {
      +		if (!value)
      +			return config_error_nonbool(key);
     -+		string_list_append(&remote->must_have, value);
     ++		string_list_append(&remote->negotiation_require, value);
       	} else if (!strcmp(subkey, "followremotehead")) {
       		const char *no_warn_branch;
       		if (!strcmp(value, "never"))
      
       ## remote.h ##
      @@ remote.h: struct remote {
     - 	char *http_proxy_authmethod;
       
       	struct string_list server_options;
     -+	struct string_list must_have;
     + 	struct string_list negotiation_restrict;
     ++	struct string_list negotiation_require;
       
       	enum follow_remote_head_settings follow_remote_head;
       	const char *no_warn_branch;
      
       ## t/t5510-fetch.sh ##
     -@@ t/t5510-fetch.sh: test_expect_success '--must-have avoids duplicates with negotiator' '
     +@@ t/t5510-fetch.sh: test_expect_success '--negotiation-require avoids duplicates with negotiator' '
       	test_line_count = 1 matches
       '
       
     -+test_expect_success 'remote.<name>.mustHave used as default for --must-have' '
     ++test_expect_success 'remote.<name>.negotiationRequire used as default for --negotiation-require' '
      +	test_when_finished rm -f trace &&
      +	setup_negotiation_tip server server 0 &&
      +
     -+	# No --must-have on CLI; config should be used as default.
     -+	git -C client config --add remote.origin.mustHave refs/tags/beta_1 &&
     ++	git -C client config --add remote.origin.negotiationRequire refs/tags/beta_1 &&
      +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
     -+		--negotiation-tip=alpha_1 \
     ++		--negotiation-restrict=alpha_1 \
      +		origin alpha_s beta_s &&
      +
      +	ALPHA_1=$(git -C client rev-parse alpha_1) &&
     @@ t/t5510-fetch.sh: test_expect_success '--must-have avoids duplicates with negoti
      +	test_grep "fetch> have $BETA_1" trace
      +'
      +
     -+test_expect_success 'remote.<name>.mustHave works with glob patterns' '
     ++test_expect_success 'remote.<name>.negotiationRequire works with glob patterns' '
      +	test_when_finished rm -f trace &&
      +	setup_negotiation_tip server server 0 &&
      +
     -+	git -C client config --add remote.origin.mustHave "refs/tags/beta_*" &&
     ++	git -C client config --add remote.origin.negotiationRequire "refs/tags/beta_*" &&
      +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
     -+		--negotiation-tip=alpha_1 \
     ++		--negotiation-restrict=alpha_1 \
      +		origin alpha_s beta_s &&
      +
      +	BETA_1=$(git -C client rev-parse beta_1) &&
     @@ t/t5510-fetch.sh: test_expect_success '--must-have avoids duplicates with negoti
      +	test_grep "fetch> have $BETA_2" trace
      +'
      +
     -+test_expect_success 'CLI --must-have overrides remote.<name>.mustHave' '
     ++test_expect_success 'CLI --negotiation-require overrides remote.<name>.negotiationRequire' '
      +	test_when_finished rm -f trace &&
      +	setup_negotiation_tip server server 0 &&
      +
     -+	# Config says beta_2, CLI says beta_1; only CLI should be used.
     -+	git -C client config --add remote.origin.mustHave refs/tags/beta_2 &&
     ++	git -C client config --add remote.origin.negotiationRequire refs/tags/beta_2 &&
      +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
     -+		--negotiation-tip=alpha_1 \
     -+		--must-have=refs/tags/beta_1 \
     ++		--negotiation-restrict=alpha_1 \
     ++		--negotiation-require=refs/tags/beta_1 \
      +		origin alpha_s beta_s &&
      +
      +	BETA_1=$(git -C client rev-parse beta_1) &&
     @@ t/t5510-fetch.sh: test_expect_success '--must-have avoids duplicates with negoti
      +	test_grep ! "fetch> have $BETA_2" trace
      +'
      +
     - . "$TEST_DIRECTORY"/lib-httpd.sh
     - start_httpd
     - 
     + test_expect_success SYMLINKS 'clone does not get confused by a D/F conflict' '
     + 	git init df-conflict &&
     + 	(
 4:  6c227f18ab ! 7:  7cccf59beb send-pack: pass --must-have for push negotiation
     @@ Metadata
      Author: Derrick Stolee <stolee@gmail.com>
      
       ## Commit message ##
     -    send-pack: pass --must-have for push negotiation
     +    send-pack: pass negotiation config in push
      
     -    When push.negotiate is enabled, send-pack spawns a 'git fetch
     -    --negotiate-only' subprocess to discover common commits. Previously
     -    this subprocess had no way to include must-have refs in the
     -    negotiation.
     +    When push.negotiate is enabled, 'git push' spawns a child 'git fetch
     +    --negotiate-only' process to find common commits.  Pass
     +    --negotiation-require and --negotiation-restrict options from the
     +    'remote.<name>.negotiationRequire' and
     +    'remote.<name>.negotiationRestrict' config keys to this child process.
      
     -    Add a must_have field to send_pack_args, set it from the transport
     -    layer where the remote struct is available, and pass explicit
     -    --must-have arguments to the negotiation subprocess. This approach
     -    directly passes the resolved config values rather than relying on the
     -    subprocess to read remote config, which is more robust when the URL
     -    alone is used as the remote identifier.
     +    When negotiationRestrict is configured, it replaces the default
     +    behavior of using all remote refs as negotiation tips. This allows
     +    the user to control which local refs are used for push negotiation.
     +
     +    When negotiationRequire is configured, the specified ref patterns
     +    are passed as --negotiation-require to ensure their tips are always
     +    sent as 'have' lines during push negotiation.
     +
     +    This change also updates the use of --negotiation-tip into
     +    --negotiation-restrict now that the new synonym exists.
      
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
     @@ send-pack.c: static void reject_invalid_nonce(const char *nonce, int len)
       
       static void get_commons_through_negotiation(struct repository *r,
       					    const char *url,
     -+					    const struct string_list *must_have,
     ++					    const struct string_list *negotiation_require,
     ++					    const struct string_list *negotiation_restrict,
       					    const struct ref *remote_refs,
       					    struct oid_array *commons)
       {
      @@ send-pack.c: static void get_commons_through_negotiation(struct repository *r,
     - 			nr_negotiation_tip++;
     + 	child.no_stdin = 1;
     + 	child.out = -1;
     + 	strvec_pushl(&child.args, "fetch", "--negotiate-only", NULL);
     +-	for (ref = remote_refs; ref; ref = ref->next) {
     +-		if (!is_null_oid(&ref->new_oid)) {
     +-			strvec_pushf(&child.args, "--negotiation-tip=%s",
     +-				     oid_to_hex(&ref->new_oid));
     +-			nr_negotiation_tip++;
     ++
     ++	if (negotiation_restrict && negotiation_restrict->nr) {
     ++		struct string_list_item *item;
     ++		for_each_string_list_item(item, negotiation_restrict)
     ++			strvec_pushf(&child.args, "--negotiation-restrict=%s",
     ++				     item->string);
     ++		nr_negotiation_tip = negotiation_restrict->nr;
     ++	} else {
     ++		for (ref = remote_refs; ref; ref = ref->next) {
     ++			if (!is_null_oid(&ref->new_oid)) {
     ++				strvec_pushf(&child.args, "--negotiation-tip=%s",
     ++					     oid_to_hex(&ref->new_oid));
     ++				nr_negotiation_tip++;
     ++			}
       		}
       	}
      +
     -+	if (must_have) {
     ++	if (negotiation_require && negotiation_require->nr) {
      +		struct string_list_item *item;
     -+		for_each_string_list_item(item, must_have)
     -+			strvec_pushf(&child.args, "--must-have=%s",
     ++		for_each_string_list_item(item, negotiation_require)
     ++			strvec_pushf(&child.args, "--negotiation-require=%s",
      +				     item->string);
      +	}
      +
     @@ send-pack.c: int send_pack(struct repository *r,
       	if (push_negotiate) {
       		trace2_region_enter("send_pack", "push_negotiate", r);
      -		get_commons_through_negotiation(r, args->url, remote_refs, &commons);
     -+		get_commons_through_negotiation(r, args->url, args->must_have,
     ++		get_commons_through_negotiation(r, args->url,
     ++					       args->negotiation_require,
     ++					       args->negotiation_restrict,
      +					       remote_refs, &commons);
       		trace2_region_leave("send_pack", "push_negotiate", r);
       	}
     @@ send-pack.h: struct repository;
       
       struct send_pack_args {
       	const char *url;
     -+	const struct string_list *must_have;
     ++	const struct string_list *negotiation_require;
     ++	const struct string_list *negotiation_restrict;
       	unsigned verbose:1,
       		quiet:1,
       		porcelain:1,
     @@ t/t5516-fetch-push.sh: test_expect_success 'push with negotiation does not attem
       	! grep "Fetching submodule" err
       '
       
     -+test_expect_success 'push with negotiation and remote.<name>.mustHave' '
     -+	test_when_finished rm -rf musthave &&
     -+	mk_empty musthave &&
     -+	git push musthave $the_first_commit:refs/remotes/origin/first_commit &&
     -+	test_commit -C musthave unrelated_commit &&
     -+	git -C musthave config receive.hideRefs refs/remotes/origin/first_commit &&
     ++test_expect_success 'push with negotiation and remote.<name>.negotiationRequire' '
     ++	test_when_finished rm -rf negotiation_require &&
     ++	mk_empty negotiation_require &&
     ++	git push negotiation_require $the_first_commit:refs/remotes/origin/first_commit &&
     ++	test_commit -C negotiation_require unrelated_commit &&
     ++	git -C negotiation_require config receive.hideRefs refs/remotes/origin/first_commit &&
     ++	test_when_finished "rm event" &&
     ++	GIT_TRACE2_EVENT="$(pwd)/event" \
     ++		git -c protocol.version=2 -c push.negotiate=1 \
     ++		-c remote.negotiation_require.negotiationRequire=refs/heads/main \
     ++		push negotiation_require refs/heads/main:refs/remotes/origin/main &&
     ++	test_grep \"key\":\"total_rounds\" event &&
     ++	grep_wrote 2 event # 1 commit, 1 tree
     ++'
     ++
     ++test_expect_success 'push with negotiation and remote.<name>.negotiationRestrict' '
     ++	test_when_finished rm -rf negotiation_restrict &&
     ++	mk_empty negotiation_restrict &&
     ++	git push negotiation_restrict $the_first_commit:refs/remotes/origin/first_commit &&
     ++	test_commit -C negotiation_restrict unrelated_commit &&
     ++	git -C negotiation_restrict config receive.hideRefs refs/remotes/origin/first_commit &&
      +	test_when_finished "rm event" &&
      +	GIT_TRACE2_EVENT="$(pwd)/event" \
      +		git -c protocol.version=2 -c push.negotiate=1 \
     -+		-c remote.musthave.mustHave=refs/heads/main \
     -+		push musthave refs/heads/main:refs/remotes/origin/main &&
     ++		-c remote.negotiation_restrict.negotiationRestrict=refs/heads/main \
     ++		push negotiation_restrict refs/heads/main:refs/remotes/origin/main &&
      +	test_grep \"key\":\"total_rounds\" event &&
      +	grep_wrote 2 event # 1 commit, 1 tree
      +'
     @@ transport.c: static int git_transport_push(struct transport *transport, struct r
       	args.atomic = !!(flags & TRANSPORT_PUSH_ATOMIC);
       	args.push_options = transport->push_options;
       	args.url = transport->url;
     -+	args.must_have = &transport->remote->must_have;
     ++	args.negotiation_require = &transport->remote->negotiation_require;
     ++	args.negotiation_restrict = &transport->remote->negotiation_restrict;
       
       	if (flags & TRANSPORT_PUSH_CERT_ALWAYS)
       		args.push_cert = SEND_PACK_PUSH_CERT_ALWAYS;

-- 
gitgitgadget
