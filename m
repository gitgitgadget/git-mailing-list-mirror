Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42723612F6
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848024; cv=none; b=QRQVKhQQ1MxF1eBcJlZXml7cjaA6rMVF1RtYxeI82CSuh53P7mO0VhnR3sc8Ye5YA+sIV/RvU/yWxTo2Hz1ft2eq+BKMKtLjp1NnxVMcFLWj+Y6p52csPOQ7jIQiSrJwzj0wfBmV4GFOEnlcoLImCgVvg6Jw1sWNkIy5IQYB534=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848024; c=relaxed/simple;
	bh=2TB4KgleRtRnQhsgjwgE+exAw7EzoITk1CmXNz2zcT4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u7tkdRox6iDSi9E7pAuRL5kz/zACyq4ZAJtYLA3uMpWsJ6hm//fcusa4o/stNKyN1KnvfaRNuZClU+07NSKOZqL3ftRQQjfT3dCSRpCaMEbNAVRC7XGtiOZAxDSd7iWn3SmiRb/KkyZyq+GnAIm3BhYfMiClWP6fgGq2N40kMy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I0ysq1hp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jKDFJDsG; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I0ysq1hp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jKDFJDsG"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id F1DBAEC05C5;
	Mon, 23 Feb 2026 07:00:22 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 23 Feb 2026 07:00:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771848022;
	 x=1771934422; bh=Zqf/jpGoW6zlf7nlwP+gqHzeEVjJ2RfV6BHunxgeyYI=; b=
	I0ysq1hpq4SqC6Q+9VRQyN8gC+gJ2q/+CiU7tyMNdJ0Z1B3lbzg7qsWWPmeZiQya
	1JL7pVL3bZFjno1VmLJppXzBjkNsGsCwE9feI4cl16/ObKMLoF/IxBs7yubP1Zh8
	+1m+ZmCwEBm7jt+1jyzUE4q17k+F8GL6qe0q5fyDhH0KscfshRvNadRHQaYR5Lqo
	69G00dLLpz7UfSilOxVa3bwqZ2GJ9+Eu9g5rlbNI53sT59eP+bxHgH/zohq9r7Jy
	l8KL/b+lmfUNmGessiL6VLKA+AL0WtaN3Dpag7drBAWtLiTyFEyGfGUkBuQxvXWR
	6Lf0n26nAxxWC5ohaPbhnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771848022; x=
	1771934422; bh=Zqf/jpGoW6zlf7nlwP+gqHzeEVjJ2RfV6BHunxgeyYI=; b=j
	KDFJDsG8v6MbbrIGfA7iMk6HJufbsn4CXZsy7dd3T2E/6wjXM54q4D9glvOiHqkG
	oNKtPkCCNY5BcMf1LdPCIOWB7WBF2QiUS2jnYZO6RGmhgwRyt1ve8GneLd25I/GY
	oot+DrfqMVQCDYSTgATGJYQZW2kZ//wvCXCyS7N9ZiX6Sus8oxfFjTVjzSw25alQ
	vQH/G1JQIL6gNxdBQRj9LVujQWbY+Qm/LsbCNOm5g+mP2o2noujWyPfEZO0Q8PCO
	COTpzZqyp47jBMDn9w05VWDILj1MsagAotghns+Vb7kkMSf+VkQ2xRHdqCrQZnED
	P5Ru9+db6+qzngpYdQUlw==
X-ME-Sender: <xms:VkGcaWiDCpO9xeLRA3rKPFc6RZaDChTxmpa1fCmN6_RIZ4iMtJEp3w>
    <xme:VkGcaedaOxML53wkXyxXv1UfXHslc25w_21GTdorDJ8avescj0OHXJWERjWKHB4aS
    sTfjJmM2lQhC4qpuEn9beIz4eY9reL6dYEDWGt76m5gSOzEx3h4ptY>
X-ME-Received: <xmr:VkGcabdGY9eBFMOZKEv-KExS8Lf0G77jJTAFm8OfzugdUSF9lGNanWyqVpQPG5e5kYC1ncafJQUTBO-FP4Haen6ZaJngideXQjWlpNj7rg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehoshifrghlugdrsghuugguvghnhhgrghgvnhesghhmgidruggvpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhk
    rddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:VkGcaY8JTLIqa-kDG25csRA036guXiLdna9hudRG4ydgNVo4PmlDDA>
    <xmx:VkGcaXkHLHdQLHoA8eHz-1fGaqvu0EpYeIGJ86R8O7conq9850tEsQ>
    <xmx:VkGcaa9lkyjbOcGjwuat5bIjnJyfRGgsZ3jitXzRc9ib3Lqxe-GwFQ>
    <xmx:VkGcaVmPRKG_aR4dRSJrGfA_9QiF2pU5ghPDVjUpNfMrt4f44C3CXQ>
    <xmx:VkGcaS8xOc86YgSLXxyple123RJdiwutfpL5K66mZCXcHuoPYgoeZ8nq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 07:00:22 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2eddb209 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 12:00:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 12:59:49 +0100
Subject: [PATCH v2 15/17] refs: replace `refs_for_each_glob_ref()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-pks-refs-for-each-unification-v2-15-515d48c8087b@pks.im>
References: <20260223-pks-refs-for-each-unification-v2-0-515d48c8087b@pks.im>
In-Reply-To: <20260223-pks-refs-for-each-unification-v2-0-515d48c8087b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
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
index b4ef4ffff0..ca7fc7289b 100644
--- a/refs.c
+++ b/refs.c
@@ -607,15 +607,6 @@ void normalize_glob_ref(struct string_list_item *item, const char *prefix,
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
index 3fa2c11c1f..b63775fa35 100644
--- a/refs.h
+++ b/refs.h
@@ -527,10 +527,6 @@ int refs_for_each_ref_in_prefixes(struct ref_store *refs,
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
index 074a75b859..4ddb3370c6 100644
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
2.53.0.536.g309c995771.dirty

