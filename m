Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885653D88E9
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776266077; cv=none; b=pBopbyAm0j+oZ45fvMoMIQgTIXeMxCHTc9Tx7UPmhB3jqY/HYG2yknyWl0Kf1uSg3QooxDMOtfRjc36IIEQnXVSZVuDMh2nkxY7Y0RCy+ldBFjAy2/q00cDFrRrIwD61se2vDwqkCHw/RkMAs7Gs8HUObyLoOU8UcJxTUwlUubs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776266077; c=relaxed/simple;
	bh=AZkJ3+sQCGhdKnG4x9UA+pwb3no028n7+TuGph9+49I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MZem5syuzoPR0ySVKPiLTb+TnLEXmcHY1z6W1I7W3eJpf57o0+/pXmhHkftyYCmuoOGlC3YUaxJDYa1XXxrg3F1l8pBTPcIRdD8j9fTqwerFNH49Pel+LRqTn+iAXouDFaRpwLb9VPcHBRLDxscD9YNsK8jF6vfaHHaEInF9GaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDuYWMEA; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDuYWMEA"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cb5c9ba82bso1065671085a.2
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 08:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776266074; x=1776870874; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZbKk8QAxEwBFLmadRjMuu+oswI2EbaXJtvsXI7YJ3g=;
        b=HDuYWMEAe6ESDsEld/8TcKb7vy2tjc+zeXTxQYNIkdt1Nhy8+pb5cZh1aas2cwFdo8
         tAj0rvL/KHAxK2v8u5ebpHboIGA22gMBs+E1+m5ausa9c6vYLwY1+tmxM2u4AiM5G/0A
         UJkA5gza4WtLtHH2wnypjaJ8pbjJeb4EaeI0GxoBPgrG2QxPsg7koR9U95bGz3YnTVa4
         0jyowUmUVZ2wZAvDf3ThIoMg0pr7tyQIANE39zsl4CKftaOo2xgoSAy9yqSB3+dbtrjg
         qdipekiaJ4D2vTtN53BJAQhqTK2iv5vsWG1DglAeVm2grB0WJE/qiGyKoiyb2EfVbgMK
         3vlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776266074; x=1776870874;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UZbKk8QAxEwBFLmadRjMuu+oswI2EbaXJtvsXI7YJ3g=;
        b=kOChyv9ee3BKebGNnZajqGa26MfGUP0zthxQI1eur8omWV5+KqySXkIThk4C6+0GW8
         3Yjln34L9EXUdESthggqRxjDZlLU1fQroecnPJMh0m21NsYFl1SDA39fDE3bVDRMT8Qh
         RF93smBAdjt7On5reYRXqz6tbkB0jGhLYg8S7K2ZNOSbLbJJF09lcVsZjbnY1maMD3UQ
         oapucNVBbd+wf0vl1XDVyOW1AXpel5mizgscdNpfwnKxny2TsYPSEkuFqACtMmvGpbfz
         QlHsMPn+gHk2ZZ4UzU2YHm+ocS1RTGJPBlQcIZq7oCFT2a9l3kvPXocOLm35QgXL8lvW
         n0iA==
X-Gm-Message-State: AOJu0Yy4oASBlrhI8Q0xBjd5CwyfRS9Cg4ePp2NdC1dX/Y8XKxfyqdYG
	7c7kbsMbPXSsqTl4FqLjVMcoBoiAGwqYfXjSTgfuoWAnrR1WaIFW+iSrP0e4Dw==
X-Gm-Gg: AeBDiessccf45KPdXmoWUQk0R4QStp86MdybhmguV3qbetA6xPqAptZ2U3SzLBNJj1s
	CwAw7go0btsqRv4J2dxxjJQd37W3PngII0mihFZEWhnhC1uuEm6pAn4dQz2pEkobW8xQ8L3x+zk
	uR8JiMIGsC1ojwnTvLuC/M2X2iy8H8KRX2DrAGDu6FB4fu82WdWFvCdb28ko1s7DBAW5HvbZ0bI
	eWu/lotuxw5hKsFs+d1o92ZCIXMNIiKF/oSkenXJSE14+J6BA5NDXyX3d5o+P8xiQMyt/HEcu/f
	PeBUqdKgC8da0JKLLvyF2P3m9kUl1v6TD3MQgZYAIV5/4Oebxv/st3IvcsUNMLglFkWypbaZ2Lf
	Oxfa50YhBCaQFPnZiBbfZu9QfKbpwYzLFBp5AdyPZJ8KJtb9TAMFTd+DG/1LmxfBIJHDSHvpLTg
	y+R2kXdQXjbWF6EbgKkirwgIkT
X-Received: by 2002:a05:620a:1987:b0:8cf:dfc9:c09c with SMTP id af79cd13be357-8ddccb2f697mr3133451285a.10.1776266073885;
        Wed, 15 Apr 2026 08:14:33 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.13.164])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4ef33af5dsm139219685a.16.2026.04.15.08.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:14:33 -0700 (PDT)
Message-Id: <49c80cef2e25ecadf894cf42661d39dc82493f47.1776266066.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
References: <pull.2085.git.1775658970.gitgitgadget@gmail.com>
	<pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 15:14:24 +0000
Subject: [PATCH v2 5/7] fetch: add --negotiation-require option for
 negotiation
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
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Add a new --negotiation-require option to 'git fetch', which ensures
that certain ref tips are always sent as 'have' lines during fetch
negotiation, regardless of what the negotiation algorithm selects.

This is useful when the repository has a large number of references, so
the normal negotiation algorithm truncates the list. This is especially
important in repositories with long parallel commit histories. For
example, a repo could have a 'dev' branch for development and a
'release' branch for released versions. If the 'dev' branch isn't
selected for negotiation, then it's not a big deal because there are
many in-progress development branches with a shared history. However, if
'release' is not selected for negotiation, then the server may think
that this is the first time the client has asked for that reference,
causing a full download of its parallel commit history (and any extra
data that may be unique to that branch). This is based on a real example
where certain fetches would grow to 60+ GB when a release branch
updated.

This option is a complement to --negotiation-restrict, which reduces the
negotiation ref set to a specific list. In the earlier example, using
--negotiation-restrict to focus the negotiation to 'dev' and 'release'
would avoid those problematic downloads, but would still not allow
advertising potentially-relevant user brances. In this way, the
'require' version solves the problem I mention while allowing
negotiation to pick other references opportunistically. The two options
can also be combined to allow the best of both worlds.

The argument may be an exact ref name or a glob pattern. Non-existent
refs are silently ignored.

Also add --negotiation-require to 'git pull' passthrough options.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/fetch-options.adoc | 19 +++++++
 builtin/fetch.c                  | 10 ++++
 builtin/pull.c                   |  3 +
 fetch-pack.c                     | 96 ++++++++++++++++++++++++++++++--
 fetch-pack.h                     | 10 +++-
 t/t5510-fetch.sh                 | 66 ++++++++++++++++++++++
 transport.c                      |  4 +-
 transport.h                      |  6 ++
 8 files changed, 206 insertions(+), 8 deletions(-)

diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index c07b85499f..85ffc5b32b 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -73,6 +73,25 @@ See also the `fetch.negotiationAlgorithm` and `push.negotiate`
 configuration variables documented in linkgit:git-config[1], and the
 `--negotiate-only` option below.
 
+`--negotiation-require=<revision>`::
+	Ensure that the given ref tip is always sent as a "have" line
+	during fetch negotiation, regardless of what the negotiation
+	algorithm selects.  This is useful to guarantee that common
+	history reachable from specific refs is always considered, even
+	when `--negotiation-restrict` restricts the set of tips or when
+	the negotiation algorithm would otherwise skip them.
++
+This option may be specified more than once; if so, each ref is sent
+unconditionally.
++
+The argument may be an exact ref name (e.g. `refs/heads/release`) or a
+glob pattern (e.g. `refs/heads/release/{asterisk}`).  The pattern syntax
+is the same as for `--negotiation-restrict`.
++
+If `--negotiation-restrict` is used, the have set is first restricted by
+that option and then increased to include the tips specified by
+`--negotiation-require`.
+
 `--negotiate-only`::
 	Do not fetch anything from the server, and instead print the
 	ancestors of the provided `--negotiation-tip=` arguments,
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 57b2b667ff..b60652e6b1 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -99,6 +99,7 @@ static struct transport *gsecondary;
 static struct refspec refmap = REFSPEC_INIT_FETCH;
 static struct string_list server_options = STRING_LIST_INIT_DUP;
 static struct string_list negotiation_tip = STRING_LIST_INIT_NODUP;
+static struct string_list negotiation_require = STRING_LIST_INIT_NODUP;
 
 struct fetch_config {
 	enum display_format display_format;
@@ -1615,6 +1616,13 @@ static struct transport *prepare_transport(struct remote *remote, int deepen,
 			strbuf_release(&config_name);
 		}
 	}
+	if (negotiation_require.nr) {
+		if (transport->smart_options)
+			transport->smart_options->negotiation_require = &negotiation_require;
+		else
+			warning(_("ignoring %s because the protocol does not support it"),
+				"--negotiation-require");
+	}
 	return transport;
 }
 
@@ -2583,6 +2591,8 @@ int cmd_fetch(int argc,
 				N_("report that we have only objects reachable from this object")),
 		OPT_STRING_LIST(0, "negotiation-restrict", &negotiation_tip, N_("revision"),
 				N_("report that we have only objects reachable from this object")),
+		OPT_STRING_LIST(0, "negotiation-require", &negotiation_require, N_("revision"),
+				N_("ensure this ref is always sent as a negotiation have")),
 		OPT_BOOL(0, "negotiate-only", &negotiate_only,
 			 N_("do not fetch a packfile; instead, print ancestors of negotiation tips")),
 		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
diff --git a/builtin/pull.c b/builtin/pull.c
index 821cc6699a..973186ecdc 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1002,6 +1002,9 @@ int cmd_pull(int argc,
 		OPT_PASSTHRU_ARGV(0, "negotiation-restrict", &opt_fetch, N_("revision"),
 			N_("report that we have only objects reachable from this object"),
 			0),
+		OPT_PASSTHRU_ARGV(0, "negotiation-require", &opt_fetch, N_("revision"),
+			N_("ensure this ref is always sent as a negotiation have"),
+			0),
 		OPT_BOOL(0, "show-forced-updates", &opt_show_forced_updates,
 			 N_("check for forced-updates on all updated branches")),
 		OPT_PASSTHRU(0, "set-upstream", &set_upstream, NULL,
diff --git a/fetch-pack.c b/fetch-pack.c
index baf239adf9..a0029253f1 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -25,6 +25,7 @@
 #include "oidset.h"
 #include "packfile.h"
 #include "odb.h"
+#include "object-name.h"
 #include "path.h"
 #include "connected.h"
 #include "fetch-negotiator.h"
@@ -332,6 +333,41 @@ static void send_filter(struct fetch_pack_args *args,
 	}
 }
 
+static int add_oid_to_oidset(const struct reference *ref, void *cb_data)
+{
+	struct oidset *set = cb_data;
+	if (odb_has_object(the_repository->objects, ref->oid, 0))
+		oidset_insert(set, ref->oid);
+	return 0;
+}
+
+static void resolve_negotiation_require(const struct string_list *negotiation_require,
+					struct oidset *result)
+{
+	struct string_list_item *item;
+
+	if (!negotiation_require || !negotiation_require->nr)
+		return;
+
+	for_each_string_list_item(item, negotiation_require) {
+		if (!has_glob_specials(item->string)) {
+			struct object_id oid;
+			if (repo_get_oid(the_repository, item->string, &oid))
+				continue;
+			if (!odb_has_object(the_repository->objects, &oid, 0))
+				continue;
+			oidset_insert(result, &oid);
+		} else {
+			struct refs_for_each_ref_options opts = {
+				.pattern = item->string,
+			};
+			refs_for_each_ref_ext(
+				get_main_ref_store(the_repository),
+				add_oid_to_oidset, result, &opts);
+		}
+	}
+}
+
 static int find_common(struct fetch_negotiator *negotiator,
 		       struct fetch_pack_args *args,
 		       int fd[2], struct object_id *result_oid,
@@ -347,6 +383,7 @@ static int find_common(struct fetch_negotiator *negotiator,
 	struct strbuf req_buf = STRBUF_INIT;
 	size_t state_len = 0;
 	struct packet_reader reader;
+	struct oidset negotiation_require_oids = OIDSET_INIT;
 
 	if (args->stateless_rpc && multi_ack == 1)
 		die(_("the option '%s' requires '%s'"), "--stateless-rpc", "multi_ack_detailed");
@@ -474,7 +511,25 @@ static int find_common(struct fetch_negotiator *negotiator,
 	trace2_region_enter("fetch-pack", "negotiation_v0_v1", the_repository);
 	flushes = 0;
 	retval = -1;
+
+	/* Send unconditional haves from --negotiation-require */
+	resolve_negotiation_require(args->negotiation_require,
+				    &negotiation_require_oids);
+	if (oidset_size(&negotiation_require_oids)) {
+		struct oidset_iter iter;
+		oidset_iter_init(&negotiation_require_oids, &iter);
+
+		while ((oid = oidset_iter_next(&iter))) {
+			packet_buf_write(&req_buf, "have %s\n",
+					 oid_to_hex(oid));
+			print_verbose(args, "have %s", oid_to_hex(oid));
+		}
+	}
+
 	while ((oid = negotiator->next(negotiator))) {
+		/* avoid duplicate oids from --negotiation-require */
+		if (oidset_contains(&negotiation_require_oids, oid))
+			continue;
 		packet_buf_write(&req_buf, "have %s\n", oid_to_hex(oid));
 		print_verbose(args, "have %s", oid_to_hex(oid));
 		in_vain++;
@@ -584,6 +639,7 @@ done:
 		flushes++;
 	}
 	strbuf_release(&req_buf);
+	oidset_clear(&negotiation_require_oids);
 
 	if (!got_ready || !no_done)
 		consume_shallow_list(args, &reader);
@@ -1305,12 +1361,26 @@ static void add_common(struct strbuf *req_buf, struct oidset *common)
 
 static int add_haves(struct fetch_negotiator *negotiator,
 		     struct strbuf *req_buf,
-		     int *haves_to_send)
+		     int *haves_to_send,
+		     struct oidset *negotiation_require_oids)
 {
 	int haves_added = 0;
 	const struct object_id *oid;
 
+	/* Send unconditional haves from --negotiation-require */
+	if (negotiation_require_oids) {
+		struct oidset_iter iter;
+		oidset_iter_init(negotiation_require_oids, &iter);
+
+		while ((oid = oidset_iter_next(&iter)))
+			packet_buf_write(req_buf, "have %s\n",
+					 oid_to_hex(oid));
+	}
+
 	while ((oid = negotiator->next(negotiator))) {
+		if (negotiation_require_oids &&
+		    oidset_contains(negotiation_require_oids, oid))
+			continue;
 		packet_buf_write(req_buf, "have %s\n", oid_to_hex(oid));
 		if (++haves_added >= *haves_to_send)
 			break;
@@ -1358,7 +1428,8 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 			      struct fetch_pack_args *args,
 			      const struct ref *wants, struct oidset *common,
 			      int *haves_to_send, int *in_vain,
-			      int sideband_all, int seen_ack)
+			      int sideband_all, int seen_ack,
+			      struct oidset *negotiation_require_oids)
 {
 	int haves_added;
 	int done_sent = 0;
@@ -1413,7 +1484,8 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 	/* Add all of the common commits we've found in previous rounds */
 	add_common(&req_buf, common);
 
-	haves_added = add_haves(negotiator, &req_buf, haves_to_send);
+	haves_added = add_haves(negotiator, &req_buf, haves_to_send,
+			       negotiation_require_oids);
 	*in_vain += haves_added;
 	trace2_data_intmax("negotiation_v2", the_repository, "haves_added", haves_added);
 	trace2_data_intmax("negotiation_v2", the_repository, "in_vain", *in_vain);
@@ -1657,6 +1729,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	struct ref *ref = copy_ref_list(orig_ref);
 	enum fetch_state state = FETCH_CHECK_LOCAL;
 	struct oidset common = OIDSET_INIT;
+	struct oidset negotiation_require_oids = OIDSET_INIT;
 	struct packet_reader reader;
 	int in_vain = 0, negotiation_started = 0;
 	int negotiation_round = 0;
@@ -1729,6 +1802,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				state = FETCH_SEND_REQUEST;
 
 			mark_tips(negotiator, args->negotiation_restrict_tips);
+			resolve_negotiation_require(args->negotiation_require,
+						    &negotiation_require_oids);
 			for_each_cached_alternate(negotiator,
 						  insert_one_alternate_object);
 			break;
@@ -1747,7 +1822,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 					       &common,
 					       &haves_to_send, &in_vain,
 					       reader.use_sideband,
-					       seen_ack)) {
+					       seen_ack,
+					       &negotiation_require_oids)) {
 				trace2_region_leave_printf("negotiation_v2", "round",
 							   the_repository, "%d",
 							   negotiation_round);
@@ -1883,6 +1959,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		negotiator->release(negotiator);
 
 	oidset_clear(&common);
+	oidset_clear(&negotiation_require_oids);
 	return ref;
 }
 
@@ -2181,12 +2258,14 @@ void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
 			   const struct string_list *server_options,
 			   int stateless_rpc,
 			   int fd[],
-			   struct oidset *acked_commits)
+			   struct oidset *acked_commits,
+			   const struct string_list *negotiation_require)
 {
 	struct fetch_negotiator negotiator;
 	struct packet_reader reader;
 	struct object_array nt_object_array = OBJECT_ARRAY_INIT;
 	struct strbuf req_buf = STRBUF_INIT;
+	struct oidset negotiation_require_oids = OIDSET_INIT;
 	int haves_to_send = INITIAL_FLUSH;
 	int in_vain = 0;
 	int seen_ack = 0;
@@ -2197,6 +2276,9 @@ void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
 	fetch_negotiator_init(the_repository, &negotiator);
 	mark_tips(&negotiator, negotiation_restrict_tips);
 
+	resolve_negotiation_require(negotiation_require,
+				    &negotiation_require_oids);
+
 	packet_reader_init(&reader, fd[0], NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE |
 			   PACKET_READ_DIE_ON_ERR_PACKET);
@@ -2221,7 +2303,8 @@ void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
 
 		packet_buf_write(&req_buf, "wait-for-done");
 
-		haves_added = add_haves(&negotiator, &req_buf, &haves_to_send);
+		haves_added = add_haves(&negotiator, &req_buf, &haves_to_send,
+				       &negotiation_require_oids);
 		in_vain += haves_added;
 		if (!haves_added || (seen_ack && in_vain >= MAX_IN_VAIN))
 			last_iteration = 1;
@@ -2273,6 +2356,7 @@ void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
 
 	clear_common_flag(acked_commits);
 	object_array_clear(&nt_object_array);
+	oidset_clear(&negotiation_require_oids);
 	negotiator.release(&negotiator);
 	strbuf_release(&req_buf);
 }
diff --git a/fetch-pack.h b/fetch-pack.h
index 6c70c942c2..1daea8c542 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -23,6 +23,13 @@ struct fetch_pack_args {
 	 */
 	const struct oid_array *negotiation_restrict_tips;
 
+	/*
+	 * If non-empty, ref patterns whose tips should always be sent
+	 * as "have" lines during negotiation, regardless of what the
+	 * negotiation algorithm selects.
+	 */
+	const struct string_list *negotiation_require;
+
 	unsigned deepen_relative:1;
 	unsigned quiet:1;
 	unsigned keep_pack:1;
@@ -93,7 +100,8 @@ void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
 			   const struct string_list *server_options,
 			   int stateless_rpc,
 			   int fd[],
-			   struct oidset *acked_commits);
+			   struct oidset *acked_commits,
+			   const struct string_list *negotiation_require);
 
 /*
  * Print an appropriate error message for each sought ref that wasn't
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 0d87494794..ec30b81c71 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1507,6 +1507,72 @@ test_expect_success 'CLI --negotiation-restrict overrides remote config' '
 	test_grep ! "fetch> have $BETA_1" trace
 '
 
+test_expect_success '--negotiation-require includes configured refs as haves' '
+	test_when_finished rm -f trace &&
+	setup_negotiation_tip server server 0 &&
+
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
+		--negotiation-restrict=alpha_1 \
+		--negotiation-require=refs/tags/beta_1 \
+		origin alpha_s beta_s &&
+
+	ALPHA_1=$(git -C client rev-parse alpha_1) &&
+	test_grep "fetch> have $ALPHA_1" trace &&
+	BETA_1=$(git -C client rev-parse beta_1) &&
+	test_grep "fetch> have $BETA_1" trace
+'
+
+test_expect_success '--negotiation-require works with glob patterns' '
+	test_when_finished rm -f trace &&
+	setup_negotiation_tip server server 0 &&
+
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
+		--negotiation-restrict=alpha_1 \
+		--negotiation-require="refs/tags/beta_*" \
+		origin alpha_s beta_s &&
+
+	BETA_1=$(git -C client rev-parse beta_1) &&
+	test_grep "fetch> have $BETA_1" trace &&
+	BETA_2=$(git -C client rev-parse beta_2) &&
+	test_grep "fetch> have $BETA_2" trace
+'
+
+test_expect_success '--negotiation-require is additive with negotiation' '
+	test_when_finished rm -f trace &&
+	setup_negotiation_tip server server 0 &&
+
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
+		--negotiation-require=refs/tags/beta_1 \
+		origin alpha_s beta_s &&
+
+	BETA_1=$(git -C client rev-parse beta_1) &&
+	test_grep "fetch> have $BETA_1" trace
+'
+
+test_expect_success '--negotiation-require ignores non-existent refs silently' '
+	setup_negotiation_tip server server 0 &&
+
+	git -C client fetch --quiet \
+		--negotiation-restrict=alpha_1 \
+		--negotiation-require=refs/tags/nonexistent \
+		origin alpha_s beta_s 2>err &&
+	test_must_be_empty err
+'
+
+test_expect_success '--negotiation-require avoids duplicates with negotiator' '
+	test_when_finished rm -f trace &&
+	setup_negotiation_tip server server 0 &&
+
+	ALPHA_1=$(git -C client rev-parse alpha_1) &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
+		--negotiation-restrict=alpha_1 \
+		--negotiation-require=refs/tags/alpha_1 \
+		origin alpha_s beta_s &&
+
+	test_grep "fetch> have $ALPHA_1" trace >matches &&
+	test_line_count = 1 matches
+'
+
 test_expect_success SYMLINKS 'clone does not get confused by a D/F conflict' '
 	git init df-conflict &&
 	(
diff --git a/transport.c b/transport.c
index a3051f6733..d1b0e9eda0 100644
--- a/transport.c
+++ b/transport.c
@@ -464,6 +464,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.stateless_rpc = transport->stateless_rpc;
 	args.server_options = transport->server_options;
 	args.negotiation_restrict_tips = data->options.negotiation_restrict_tips;
+	args.negotiation_require = data->options.negotiation_require;
 	args.reject_shallow_remote = transport->smart_options->reject_shallow;
 
 	if (!data->finished_handshake) {
@@ -495,7 +496,8 @@ static int fetch_refs_via_pack(struct transport *transport,
 					      transport->server_options,
 					      transport->stateless_rpc,
 					      data->fd,
-					      data->options.acked_commits);
+					      data->options.acked_commits,
+					      data->options.negotiation_require);
 			ret = 0;
 		}
 		goto cleanup;
diff --git a/transport.h b/transport.h
index cdeb33c16f..8737f23008 100644
--- a/transport.h
+++ b/transport.h
@@ -48,6 +48,12 @@ struct git_transport_options {
 	 */
 	struct oid_array *negotiation_restrict_tips;
 
+	/*
+	 * If non-empty, ref patterns whose tips should always be sent
+	 * as "have" lines during negotiation.
+	 */
+	const struct string_list *negotiation_require;
+
 	/*
 	 * If allocated, whenever transport_fetch_refs() is called, add known
 	 * common commits to this oidset instead of fetching any packfiles.
-- 
gitgitgadget

