Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29E477F11
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 06:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618356; cv=none; b=PUldTLtNJOyJL52eH7SXZwiDMJ6L/JzSQsTH4f607SCEk5Ekyj5LG3sBVBTH33ZKnOCZkIjgnNrkdPnwmYwN1NpCC/qATYIC55YprC9vhR9e3pTKsD8Sg82fnT6mZwNS//nPOk+phAO3npPGEtvdQrCA9dRxWQ7JmOMy18BL3aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618356; c=relaxed/simple;
	bh=8LK3PQrkcHcksC/LiajRYMZKeUMCeOVLEQqUw74jWog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHMGgrp7zi1fHzux3UIChqE//6lVFi8cGvmXkrOHtU+fxumh2gY59Flh5Jb3zkLQJMmXUhWoy3uDxZ5U9LaKcSRY/VuGSbsja6LdrOAxqhVt6GhjHyC5nbpd4sPpUTaWF40eCuA5X2GAOefbJ168O//ZF4BYEiYflwz/dU7GJNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i7wYjHr6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jKlH56f0; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i7wYjHr6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jKlH56f0"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3F9E41151A90;
	Wed, 14 Aug 2024 02:52:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 14 Aug 2024 02:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723618354; x=1723704754; bh=BMPBENinN4
	0NmdvIC0g/9yDOmE53bRPzNitoiMd76Bo=; b=i7wYjHr6WWV1vRgnldmtpSbnLX
	H0zTSfP3mxY5mcuTR00VoHuChVJzAaCZf3W92yAuI7+2dmIKd6h29QxFhJ6KLqN4
	85ODey5G1GdaeLR3eHyqR4EUjqY/PnMrRHEJGUrokPrvvJWEzbeVhmVDJYpIf1UC
	2UZ2rwpdcFZ3cRjlVu71ILRqXvIu06m3H+0cHM2lJo7bSkvlAYCVomeaxmNtpudO
	0tf2bQzGc8pVg0RpMrtlmxN0wAquIvTgmuQrwrK+cDA9AszBWUyPMqJnNnuoU7Qn
	b4pMhpb1eri/xr21Ex3e86l9HTV03h5ArBkbVefd216FtmIWBbYO+e6lccrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723618354; x=1723704754; bh=BMPBENinN40NmdvIC0g/9yDOmE53
	bRPzNitoiMd76Bo=; b=jKlH56f0ypk6dUsaPNy1SC/CLtXldksfBnf+ERSN2Oli
	GOcjEZaPDuDLGn3LC9bJaDGw0Gr6QpN8TOqYx6ZW8/ierHxFKP9sK0wYcqSeLBEV
	5YOhpt6BnrVneAEJanZBuEeU63ewpybIrGtQOLBk1vAVKcFWi7nIYsTz4yui+EeX
	IMZyVZMItdPfWZt4GKDXk7CfYIPnnl9DZPssakktvlR7lRrfFAwut0ME2Rwx2lt3
	X7GZq5SMmDhVGSeimvSquDAveibYoROxOFvkK74kHGfiktKj0/KklF2YfFmisKM7
	rQoL3wwFK1cMkgCRvlBnuHx2rkhS9iL6P1AhPxcDGg==
X-ME-Sender: <xms:MlS8ZlxrZflSqllw6t1mthy5XUXYBTYyCXw9eFHFMsQ8LPeseRiAvQ>
    <xme:MlS8ZlR6aVc75fPRawWp7_n4lir1pN8t-6XNQDW02-wDPGBQkYe5M5NYt9_w_JEuQ
    Qi8pLB2dZVrSpZ23A>
X-ME-Received: <xmr:MlS8ZvXloJAeF_N1pdZyD6oo1xl2lvy2ZmFpYVmN1sV5l4ku1luMkFfWFx5xBckwgf3WkXH-f6aOg5dWjEOxm3eUyRTq0p45oxUP3KrkMP70Ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtfedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehp
    hhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvse
    htthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhioh
X-ME-Proxy: <xmx:MlS8Znhz29uA1d_7KD42cvw1TqbfNjDhnEq3YxBdEt2FIxBEKZYT-g>
    <xmx:MlS8ZnC-EYVH58byiyp7KuTy_o0s4M9mIFOPyNTu1UvvZIbuj3EOeA>
    <xmx:MlS8ZgJSzcmhY-y06eh6A8y5dbNU8WQuk2vVwQn-_xsU4mRwkz6zoQ>
    <xmx:MlS8ZmBIjywlCUD49vu_bBBw5A4m8iGYyNuvU20w7jM6uTw9BaC7vA>
    <xmx:MlS8Zp1ftO4blqsy-ldiOLYeAZSEnPR0Lg3cpOoT3zpvyhWtRVtjrYYG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 02:52:32 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b8a04be1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 06:52:14 +0000 (UTC)
Date: Wed, 14 Aug 2024 08:52:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v4 13/22] builtin/fast-export: plug leaking tag names
Message-ID: <b4096e971fe2fb3c1a6d5f763e08dc62eb6f3d38.1723614263.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723614263.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723614263.git.ps@pks.im>

When resolving revisions in `get_tags_and_duplicates()`, we only
partially manage the lifetime of `full_name`. In fact, managing its
lifetime properly is almost impossible because we put direct pointers to
that variable into multiple lists without duplicating the string. The
consequence is that these strings will ultimately leak.

Refactor the code to make the lists we put those names into duplicate
the memory. This allows us to properly free the string as required and
thus plugs the memory leak.

While this requires us to allocate more data overall, it shouldn't be
all that bad given that the number of allocations corresponds with the
number of command line parameters, which typically aren't all that many.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fast-export.c            | 17 ++++++++++++-----
 t/t9351-fast-export-anonymize.sh |  1 +
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index fe92d2436c..f253b79322 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -42,8 +42,8 @@ static int full_tree;
 static int reference_excluded_commits;
 static int show_original_ids;
 static int mark_tags;
-static struct string_list extra_refs = STRING_LIST_INIT_NODUP;
-static struct string_list tag_refs = STRING_LIST_INIT_NODUP;
+static struct string_list extra_refs = STRING_LIST_INIT_DUP;
+static struct string_list tag_refs = STRING_LIST_INIT_DUP;
 static struct refspec refspecs = REFSPEC_INIT_FETCH;
 static int anonymize;
 static struct hashmap anonymized_seeds;
@@ -901,7 +901,7 @@ static void handle_tag(const char *name, struct tag *tag)
 	free(buf);
 }
 
-static struct commit *get_commit(struct rev_cmdline_entry *e, char *full_name)
+static struct commit *get_commit(struct rev_cmdline_entry *e, const char *full_name)
 {
 	switch (e->item->type) {
 	case OBJ_COMMIT:
@@ -932,14 +932,16 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 		struct rev_cmdline_entry *e = info->rev + i;
 		struct object_id oid;
 		struct commit *commit;
-		char *full_name;
+		char *full_name = NULL;
 
 		if (e->flags & UNINTERESTING)
 			continue;
 
 		if (repo_dwim_ref(the_repository, e->name, strlen(e->name),
-				  &oid, &full_name, 0) != 1)
+				  &oid, &full_name, 0) != 1) {
+			free(full_name);
 			continue;
+		}
 
 		if (refspecs.nr) {
 			char *private;
@@ -955,6 +957,7 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 			warning("%s: Unexpected object of type %s, skipping.",
 				e->name,
 				type_name(e->item->type));
+			free(full_name);
 			continue;
 		}
 
@@ -963,10 +966,12 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 			break;
 		case OBJ_BLOB:
 			export_blob(&commit->object.oid);
+			free(full_name);
 			continue;
 		default: /* OBJ_TAG (nested tags) is already handled */
 			warning("Tag points to object of unexpected type %s, skipping.",
 				type_name(commit->object.type));
+			free(full_name);
 			continue;
 		}
 
@@ -979,6 +984,8 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 
 		if (!*revision_sources_at(&revision_sources, commit))
 			*revision_sources_at(&revision_sources, commit) = full_name;
+		else
+			free(full_name);
 	}
 
 	string_list_sort(&extra_refs);
diff --git a/t/t9351-fast-export-anonymize.sh b/t/t9351-fast-export-anonymize.sh
index 156a647484..c0d9d7be75 100755
--- a/t/t9351-fast-export-anonymize.sh
+++ b/t/t9351-fast-export-anonymize.sh
@@ -4,6 +4,7 @@ test_description='basic tests for fast-export --anonymize'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup simple repo' '
-- 
2.46.0.46.g406f326d27.dirty

