Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF3218453A
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541510; cv=none; b=LjXLhVDIWYtgL8KqifsCLXpSP0LbQ46TpBFOZ7DKdg4POvE8wKJ2DEENYTBvkgyaD5Eb5e3aCHcCFuMIuaWBvSR+a9DH/9yFUEDVs4vBp+JQScXp1o4VpDWp1h5AZD+dzK4A0Ld/D1fibskgzCzku2Mz4p5egvZh3x2neeQ5StM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541510; c=relaxed/simple;
	bh=8LK3PQrkcHcksC/LiajRYMZKeUMCeOVLEQqUw74jWog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axBdIz6ZeHhKchpyu8IGpJ6XDgY0kycVpY+UIGUJvFn6vwqeSnM2rVCsUinwrVJFSAZGaLP9We9JkXSimuMers0W7QloFNBGuaizggzzyq3956H3TN2XbHW5K3T2hANY9/ogQ8G7csvkiWdqrfza4zHeBQ7KDw9EQ5v9HtP6C1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VZ5n6aQ0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b7OLVN/1; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VZ5n6aQ0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b7OLVN/1"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 33AD4114EA7D;
	Tue, 13 Aug 2024 05:31:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 13 Aug 2024 05:31:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723541508; x=1723627908; bh=BMPBENinN4
	0NmdvIC0g/9yDOmE53bRPzNitoiMd76Bo=; b=VZ5n6aQ0JYKj4cneGcDGu8VLjs
	szGjvVZrSLKTRFXulBPmHcn/VbYRaZKk3Co/P/dzlJQpj0CIv0UFXsPK2RdX/tIT
	S3oweo9R9mFvNMddsTov3gKHfqgZegzO3qCihMo4hHg/kAq7s7WGNiS9MAdh5Er7
	WJaio5mjwjkTfgdtUiTXCe1Oz4IBFGepJmy33RehxWeSV9cNEYifAHEczN/FwNEP
	CP3CCBjt1Wivl6B5jVmeXMLY5Taic1FEUgvtNHNux9l25j/ER/EZUu2ZQGCkUWSX
	kNI/KGP3LHslpEtfYOGI4+6k77+W1lna2gkv5S4qWfcdCemizkGdAnq1KyEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723541508; x=1723627908; bh=BMPBENinN40NmdvIC0g/9yDOmE53
	bRPzNitoiMd76Bo=; b=b7OLVN/1kzvh5YDpFgGjE3a8CZRUUXHGijye8PC+ELhy
	OEeokCSosp7ScGeNeK/39/D3Z7VXU6vWk3yZpk/sPp7XzMlq4UovzqWi3adRNth6
	+Kq1MD8TPWD1KphvMjz5p82RRyJyFW6IToYbAr38rIsz4dIunhnUJYMU43qRSflv
	vZXi/ZMopyL5cBCQ44BKlcUdqsEzI582fRjwIBThuK+YDnlYUeTz/NCIZF5CPbjc
	+n2Yq/NGqGefjUaOgXQO01srXOURccFINKmNJex5wjVrif9jbfm+d9K/deSb5Bn+
	3XOC3Azly6wY7K0pg7C41uW3WtgGn2i14ZhrqDCb+w==
X-ME-Sender: <xms:BCi7ZvrlnRThIDf1y3u-tI64rFuhK4ATF_9OTrPyXpG7uL2Cc0wt3g>
    <xme:BCi7ZpqjR7oC0pB9kln8ry4ZmB5dwEClAhfApyit7vdjcsi1acR6O1WK80Tm3M051
    FKPm5ytw8vcEOrweQ>
X-ME-Received: <xmr:BCi7ZsNc1QJ1yUJ5l4Yi634ts68AUkbbKT6ILcx_bgR2d4Du875dY2a-0APQHbgsd7feEOXQaTGE7uBNLFgx6g9Pm6uOMeb_S-tj3SGX4x_NfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrmhgv
    shesjhgrmhgvshhlihhurdhiohdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtoh
    hmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:BCi7Zi4d18iXR9Sprpu-EN101fjcI08eY0nyXYfPxL6jqfye9XyCZg>
    <xmx:BCi7Zu6Ees4Eq4mTARfTh_swjD_3Z8auzdwFfHY9UdErzFW6al_ztQ>
    <xmx:BCi7ZqgJ522VqZqu7xzxRfvCL6aNPnorz2AFrXPyGlvN0gXPiu8KOQ>
    <xmx:BCi7Zg6eiWeQ2T9WQyimNiuifjVZ72Fmjv-eygI_izUy7YnV8CsC1g>
    <xmx:BCi7Zru9mBiNLByfFxZKSQstMFvLxytuqrb7pfmjB6PeEkw5RzhPj98r>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:31:46 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c3a5a977 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:31:30 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:31:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 13/22] builtin/fast-export: plug leaking tag names
Message-ID: <254bbb7f6f20ed85b1ec894ffa515ab1ae4f38eb.1723540931.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723540931.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723540931.git.ps@pks.im>

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

