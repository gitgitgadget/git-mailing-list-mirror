Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1FA3358D3
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 08:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771575913; cv=none; b=SRaWtdHyNp8QOLqbTiJOaVhOpinVODsj4/e17f+itcpJFCNAC+20+p7xpRwVGtouicM+pWW7BP1UAb6fB8X96PpBay9saaQVvRMXHqxR3hb1KwVd0Ely82xGKKa771KzqGhLLauGQcHsAhudDIPX36VhY6et9ifTO6GBL2ZEwLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771575913; c=relaxed/simple;
	bh=PFppWiqdBoMjahJ2GtpqsnDZ2tiua8kSq9jMewN27k4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eV2B3rrRJMqBkKI/iDPU3N+q9R6yMEJCOQ6kp4nPJcwNWV9JwM7CVe/Cm6iUqs9bSdvuIbgQYFOS1FJZ/W7UYVpVt0lOZpPNC+mrpPKiCRA+/4MCWkxSrtHF674P6omT0WlVm6JFdmIVIwQK75jkQkihABThO1dkHEYXnXu91IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ib92CPUX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G9kOG2ug; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ib92CPUX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G9kOG2ug"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 83BF67A0011;
	Fri, 20 Feb 2026 03:25:11 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 20 Feb 2026 03:25:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771575911;
	 x=1771662311; bh=n7QwrpFQlPeNUM026Xl9cnTGEMJxdVJXqP0XY75fTbQ=; b=
	ib92CPUXAhq0dGZ86719TqGyCiFBP8wc/B+GeMWbDjiE3UPpu6HqDXiJyiBilR0b
	gSWpsS92D3ZHOh8X1zOvGI3ruVnwxMQ1H06m+A26XeLByR2DvpfhVzz0hioiBmW2
	fVDP+cpkotJ7z8k3+5WR3NZEY23elzM4rbQgx0Ht0uDLjd1BP5JGic6XY5JWldVP
	S7rwv5gkxo30araTcOsSyGd3NcrpjLA7zXVEMOzAMSJdYt7/tD3TjW2MXw8zBVEG
	KjHIdaCLWGSZTBQei36kztXQYer7BPWeuzk+mg9YW57nhNKzaABGFdjziSnT9qot
	GuWzmfqTu7cdsVwpVl3CUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771575911; x=
	1771662311; bh=n7QwrpFQlPeNUM026Xl9cnTGEMJxdVJXqP0XY75fTbQ=; b=G
	9kOG2ugilOzwhlfCczfIXhTodAS9P1WKw/N9JK9BpUWiSCzgp6krLPISP+FUMp49
	Ft7A5VlyRAvwDsuMj5rafT8/vlcmQO0HVaQkE7TIBjerPiKqXZcPp0CzbrxgvswR
	aLkqHeau4EC8PY0LfjRRCgJ4pzR6J0gV9YH22QSjnGQ6LMRaz2M/0JsoVzIistIn
	M0iuiN15BJlhD+s6FdEBpq+E//4CwQyKEx9pDkr/k56KHWFJOGDg9ZQNkaG62GUF
	8wFsFwLfOGRxXcfwMCin25QM0EcI8dpvGPVckgMMav54POZafVad8OA1LO7I/zFK
	7YdaQgimrstA5iMwqlePQ==
X-ME-Sender: <xms:ZxqYabQ8BkBtLUs8FneuCjnG9MlI4-1DMcZDZ-dwgh3jFWoFsHJKfg>
    <xme:ZxqYaSwwtcPMseBUqda49fTxRN1Je-4da0nB4-QsqRWNikI4fz-U3ar-K38qAYIkp
    F84c1y1m3fAvIlYCq9LJ60SP5-JwmpAbJHXFRuG-UW0mdDm3CDRDDE>
X-ME-Received: <xmr:ZxqYaecARuJqf-7HtF7p-dk_RhQ5ST-uDovlm_LcWNkbGkay-Lk08pXkyoqINCpc1EUSU6mVGB4gbo5U1Tc0GmtOJ4eLnu9pnUm_DTaWvdJ->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdejleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:ZxqYaWI1bIsJaOLLUaJvOrmA9uzv-l5h6o0vSk0rJcUN-_eFaLmEFg>
    <xmx:ZxqYaXFEJ7EG5OV4jJyrLDY7irHR-VQyr3BsfNRKw9-wvsisJR6zdQ>
    <xmx:ZxqYaYqV-WiR2sn28CXEqCBbRs4wBhTIcS2gYjHovsR2K1dVcS9QIw>
    <xmx:ZxqYaYRaa1FlExj_4sHEvKdYVBeJotOV1fyORHHfVCEbpnGIqHBRLQ>
    <xmx:ZxqYafDi_q_L1KayrkustE8pwe-l65qgIoowBl0uAFHCDRVvgrUIqN9I>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 03:25:10 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4441cf36 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 08:25:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Feb 2026 09:24:19 +0100
Subject: [PATCH 15/17] refs: replace `refs_for_each_glob_ref()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-pks-refs-for-each-unification-v1-15-17170bd99de1@pks.im>
References: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
In-Reply-To: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Replace calls to `refs_for_each_glob_ref()` with the newly introduced
`refs_for_each_ref_ext()` function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 7 +++++--
 notes.c         | 7 +++++--
 refs.c          | 9 ---------
 refs.h          | 4 ----
 revision.c      | 7 +++++--
 5 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index a3bc7e9380..a3323fbfd7 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1542,6 +1542,9 @@ static void add_negotiation_tips(struct git_transport_options *smart_options)
 
 	for (i = 0; i < negotiation_tip.nr; i++) {
 		const char *s = negotiation_tip.items[i].string;
+		struct refs_for_each_ref_options opts = {
+			.pattern = s,
+		};
 		int old_nr;
 		if (!has_glob_specials(s)) {
 			struct object_id oid;
@@ -1553,8 +1556,8 @@ static void add_negotiation_tips(struct git_transport_options *smart_options)
 			continue;
 		}
 		old_nr = oids->nr;
-		refs_for_each_glob_ref(get_main_ref_store(the_repository),
-				       add_oid, s, oids);
+		refs_for_each_ref_ext(get_main_ref_store(the_repository),
+				      add_oid, oids, &opts);
 		if (old_nr == oids->nr)
 			warning("ignoring --negotiation-tip=%s because it does not match any refs",
 				s);
diff --git a/notes.c b/notes.c
index 090c48bbd5..51a7ef9f83 100644
--- a/notes.c
+++ b/notes.c
@@ -952,8 +952,11 @@ void string_list_add_refs_by_glob(struct string_list *list, const char *glob)
 {
 	assert(list->strdup_strings);
 	if (has_glob_specials(glob)) {
-		refs_for_each_glob_ref(get_main_ref_store(the_repository),
-				       string_list_add_one_ref, glob, list);
+		struct refs_for_each_ref_options opts = {
+			.pattern = glob,
+		};
+		refs_for_each_ref_ext(get_main_ref_store(the_repository),
+				      string_list_add_one_ref, list, &opts);
 	} else {
 		struct object_id oid;
 		if (repo_get_oid(the_repository, glob, &oid))
diff --git a/refs.c b/refs.c
index 1fa16facb8..e11ee94013 100644
--- a/refs.c
+++ b/refs.c
@@ -605,15 +605,6 @@ void normalize_glob_ref(struct string_list_item *item, const char *prefix,
 	strbuf_release(&normalized_pattern);
 }
 
-int refs_for_each_glob_ref(struct ref_store *refs, refs_for_each_cb cb,
-			   const char *pattern, void *cb_data)
-{
-	struct refs_for_each_ref_options opts = {
-		.pattern = pattern,
-	};
-	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
-}
-
 const char *prettify_refname(const char *name)
 {
 	if (skip_prefix(name, "refs/heads/", &name) ||
diff --git a/refs.h b/refs.h
index 1d21999ae1..f408367b01 100644
--- a/refs.h
+++ b/refs.h
@@ -526,10 +526,6 @@ int refs_for_each_ref_in_prefixes(struct ref_store *refs,
 				  const struct refs_for_each_ref_options *opts,
 				  refs_for_each_cb cb, void *cb_data);
 
-/* iterates all refs that match the specified glob pattern. */
-int refs_for_each_glob_ref(struct ref_store *refs, refs_for_each_cb fn,
-			   const char *pattern, void *cb_data);
-
 /*
  * references matching any pattern in "exclude_patterns" are omitted from the
  * result set on a best-effort basis.
diff --git a/revision.c b/revision.c
index da7737ce28..8a6a871b1c 100644
--- a/revision.c
+++ b/revision.c
@@ -2814,10 +2814,13 @@ static int handle_revision_pseudo_opt(struct rev_info *revs,
 		handle_refs(refs, revs, *flags, refs_for_each_remote_ref);
 		clear_ref_exclusions(&revs->ref_excludes);
 	} else if ((argcount = parse_long_opt("glob", argv, &optarg))) {
+		struct refs_for_each_ref_options opts = {
+			.pattern = optarg,
+		};
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
-		refs_for_each_glob_ref(get_main_ref_store(the_repository),
-				       handle_one_ref, optarg, &cb);
+		refs_for_each_ref_ext(get_main_ref_store(the_repository),
+				      handle_one_ref, &cb, &opts);
 		clear_ref_exclusions(&revs->ref_excludes);
 		return argcount;
 	} else if ((argcount = parse_long_opt("exclude", argv, &optarg))) {

-- 
2.53.0.414.gf7e9f6c205.dirty

