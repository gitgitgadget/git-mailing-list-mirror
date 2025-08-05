Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE9C25A2B4
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 15:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754406709; cv=none; b=LFaOOdT2G32CefkZeYlChCGpoLgHhqkahX1fwOhRveHg6IWQ3735XZPlQuBjPYsLIl77pgKhNz3mwmMbIdToGcT8OJttDxBCJqiNRD8kGREdcLD3qeW8g6LRkv/2MzG8iXS3KUcWxfTzUmqEorqJ/kzprgHGRKKAzyDH57lxDkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754406709; c=relaxed/simple;
	bh=FjUvWkv9cawQV8VHDPBdHg7IA5SNDNmF4DpI2F5lYps=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=DQtCkO/HNo04Bgmt3s6ag28MjqVcHpa7RScPnNlcWNggT5ZNiaYpIWcgUZrx3foGVDD++OOuEaOjWUKOspzJ9qowNoUAmzRYK2hzkvub3I8I6t4jbErXmBkDmQhrmgVArXBjcbM2n4zcQD2Id2L2LQUbiYXXD5osFd8ZRNPloRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fd9KGPvO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PNI13qX9; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fd9KGPvO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PNI13qX9"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 8738FEC013B;
	Tue,  5 Aug 2025 11:11:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 05 Aug 2025 11:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754406706;
	 x=1754493106; bh=w3b4ra+evhpxzQtEtVVShP2RE0IPjudoAX2fG0LPIZk=; b=
	fd9KGPvOGFxknDt/VY8mxp+TPQA1qa6LNEqrVqMSlsVE2cnTQ/jIXcl2/iC0Zd3C
	KtOrJU1RdgZlK/zNnm1GWibpsYKV7XB1iR8QSececcxBqewqpgHLnmviCKAlIohf
	5G6NZ5oQ/oFvLwXWzMyNMs70Qo3Nykc3MYIFyJCCptfUlS3hr7q9o7mZgCr3bi68
	DrZWUK04yiZkalMmD8XyWGliN0BOSORiwupyeDMeQVEUU9Ysz+G2uFRYdRddP9+o
	L5SuAIXnivHdKcWoEo/GVgy/Oi4QVI39//lPIQvjtGVsy/PPmPrlU55tNjDYX3h6
	IPPbtsIvXR+0cSIEFFHgwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754406706; x=
	1754493106; bh=w3b4ra+evhpxzQtEtVVShP2RE0IPjudoAX2fG0LPIZk=; b=P
	NI13qX9Iu2a35UxldJA2Ragr7Hes6gmSCkLDnbw3IESoYH11NYT68ejgCJvUHYKE
	H0pBvizRNesYE7jCd1JgVSaVZ6MCTn2rkqCUT+86lmGnfzyFcfDcG6JnBK1EfiXw
	vQvMTaeMXY4hRGh/RMZgciVVpkIvr/ew1Hynwl0H9Ygm9AdU321pQgsAlNVxkghE
	ekQZCpeN5tPsIAkxCBCK7y+QCi7IUtdpMPE/u8NtRVEsFWi2YPFqxU4ACuskbSKU
	sKGx4uI/WKOZHiQQf/7DTMDMqDKg2q9igwCV9ZCeBzvCCZwfm4WGHVNr89YuNr4z
	MGwoQjWfGaNNRyl89h+WA==
X-ME-Sender: <xms:Mh-SaB-DejwWwI2M8EhjEqgkSQB9Pa2AVrS4NkjnYg5JAqKxhtQY7Q>
    <xme:Mh-SaCmDqRvEsJPqizB0tob140qrIJc66hJS9Wtmrnn-i0nQ7mjDMDCreppeEdtQA
    07esovUI04muv4E0Q>
X-ME-Received: <xmr:Mh-SaOxjXJiAxJOMbc5IGXSfHwEzJMk950IbdFuVzXGnNOh-viSOYL9LbWFQLBEeWAhZBQscxoRjVdl6xIVEMHGdG46SEF7eODbVn3SYgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeuvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    ledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghp
    thhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshiivgguvghrrd
    guvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
    pdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtth
    hopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:Mh-SaE7DLCjIN_psF0DjBWaaOCw2Qjcg5A_sf9kpkIm5Fn3KDcMoJA>
    <xmx:Mh-SaGXyEBQatXhiVi97ySnO-ETeZfo4ZLQFJsEM6T9jJdew0T4qPQ>
    <xmx:Mh-SaELvIJlZEJl2sbxxflQemZV_uGyRUh8hkuibULvBu0aTbJlcMw>
    <xmx:Mh-SaAsSnw73M9rO0bm3yVdtBbn3AiDniepE0jXbpzsHQmHYFLcChQ>
    <xmx:Mh-SaCCyELm0goJ4EVGcJMTXmv18Ve_MjKjIx8bdPeq5smlTOTy1aG27>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 11:11:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f0e1abae (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 5 Aug 2025 15:11:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 0/9] refs: fix migration of reflog entries
Date: Tue, 05 Aug 2025 17:11:30 +0200
Message-Id: <20250805-pks-reflog-append-v5-0-050997db09d5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACMfkmgC/33OQQ6CMBAF0KuQrq1pZ1oKrryHcQF0Ko0KhBqiI
 dzdwkIxIS7/dN6fjixQ7ymwQzKyngYffNvEoHcJq+qiuRD3NmYGArQwALy7Bt6Tu7UXXnQdNZa
 nqKQBmxUlVCy6Lj7759J5Osdc+/Bo+9dyYpDz9F/bILngMkPSucotyfQYd/b+zuaqAdZcb3GIn
 BSZqiR02mQ/HNc83+IYeZ5KZVEKJwz+cPXlmVBbXM2fR5DoyBkQ4sOnaXoDELNrR2wBAAA=
X-Change-ID: 20250722-pks-reflog-append-634172d8ab2c
In-Reply-To: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Toon Claes <toon@iotcl.com>, Jeff King <peff@peff.net>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Ben Knoble <ben.knoble@gmail.com>
X-Mailer: b4 0.14.2

Hi,

after the announcement that "reftable" will become the default backend
in Git 3.0 I've revived the efforts to implement this backend in
libgit2. I'm happy to report that this implementation is almost done by
now: out of 3000 tests only four are failing now.

For two of these tests I have been completely puzzled why those are
failing, as everything really looked perfectly fine in libgit2. As it
turned out, the bug wasn't in libgit2 though, but in Git. Namely, the
way we migrate reflog entries between storage formats is broken in two
ways:

  - The identity we write into the reflog entries is wrong.

  - The old commit ID of reflog entries is always set to all-zeroes.
    This is what caused the libgit2 tests to fail, as I used `git refs
    migrate` to convert test repositories to use reftables.

This patch series fixes both of these issues. Furthermore, it also adds
a new `git reflog write` subcommand to write new reflog entries for a
specific reference. This command was helpful to reproduce some test
constellations in libgit2.

Changes in v2:
  - !!! The base of this topic has changed so that it sits on top of
    v2.50.1. This is done so that we can backport this change to older
    release tracks.
  - A couple of typo fixes and clarifications for commit messages.
  - Reorder sections in git-reflog(1) manpage according to the
    reordering we have in the synopsis.
  - Add a section for the new `write` command.
  - Improve test coverage for the `git reflog write` command.
  - Avoid `cat`ing a file into a Bash loop.
  - Remove a stale comment.
  - Make `ref_update_expects_existing_old_ref()` a bit more straight
    forward.
  - Link to v1: https://lore.kernel.org/r/20250722-pks-reflog-append-v1-0-183e5949de16@pks.im

Changes in v3:
  - `git reflog write` now requires fully-qualified refnames.
  - A new commit that plugs one part of the race around splitting of
    reflogs for HEAD in the "files" backend.
  - Link to v2: https://lore.kernel.org/r/20250725-pks-reflog-append-v2-0-e4e7cbe3f578@pks.im

Changes in v4:
  - Improve one of the tests to use an existing abbreviated object ID
    instead of a non-existing one to make sure that we indeed fail due
    to the abbreviation.
  - Don't abort the transaction when HEAD has been racily updated, but
    drop the log-only update instead.
  - Link to v3: https://lore.kernel.org/r/20250729-pks-reflog-append-v3-0-9614d310f073@pks.im

Changes in v5:
  - Revert back to the logic that aborts the transaction if we see a
    racy HEAD update. It's the pragmatic thing to do for an edge case
    that is very unlikely to ever happen.
  - Link to v4: https://lore.kernel.org/r/20250804-pks-reflog-append-v4-0-13213fef7200@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (9):
      Documentation/git-reflog: convert to use synopsis type
      builtin/reflog: improve grouping of subcommands
      refs: export `ref_transaction_update_reflog()`
      builtin/reflog: implement subcommand to write new entries
      ident: fix type of string length parameter
      refs: fix identity for migrated reflogs
      refs/files: detect race when generating reflog entry for HEAD
      refs: stop unsetting REF_HAVE_OLD for log-only updates
      refs: fix invalid old object IDs when migrating reflogs

 Documentation/git-reflog.adoc |  76 +++++++++++++------------
 builtin/reflog.c              | 103 +++++++++++++++++++++++++++-------
 ident.c                       |   2 +-
 ident.h                       |   2 +-
 refs.c                        |  60 +++++++++++---------
 refs.h                        |  24 +++++++-
 refs/files-backend.c          |  65 +++++++++++++++++++---
 refs/refs-internal.h          |   3 +-
 refs/reftable-backend.c       |  26 ++++++---
 t/meson.build                 |   1 +
 t/t1421-reflog-write.sh       | 126 ++++++++++++++++++++++++++++++++++++++++++
 t/t1460-refs-migrate.sh       |  22 +++++---
 12 files changed, 403 insertions(+), 107 deletions(-)

Range-diff versus v4:

 1:  dd5a8065de =  1:  56319ac4ea Documentation/git-reflog: convert to use synopsis type
 2:  6cb5f94795 =  2:  d294ddc23f builtin/reflog: improve grouping of subcommands
 3:  6ba62d6b33 =  3:  9b28228df6 refs: export `ref_transaction_update_reflog()`
 4:  e5630532ba =  4:  936223d8c8 builtin/reflog: implement subcommand to write new entries
 5:  3a5f13aeb2 =  5:  78a3d896c7 ident: fix type of string length parameter
 6:  1d3ac825e1 =  6:  b164e5ef4a refs: fix identity for migrated reflogs
 7:  35cbf4a06f !  7:  e5817d65bf refs/files: detect race when generating reflog entry for HEAD
    @@ Commit message
         manually resolving the old object ID of that entry, we now use the same
         old state as for the parent update.
     
    +    If we detect such a racy update we abort the transaction. This is a bit
    +    heavy-handed: the user didn't even ask us to write a reflog update for
    +    "HEAD", so it might be surprising if we abort the transaction. That
    +    being said:
    +
    +      - Normal users wouldn't typically hit this case as we only hit the
    +        relevant code when committing to a branch that is being pointed to
    +        by "HEAD" directly. Commands like git-commit(1) typically commit to
    +        "HEAD" itself though.
    +
    +      - Scripted users that use git-update-ref(1) and related plumbing
    +        commands are unlikely to hit this case either, as they would have to
    +        update the pointed-to-branch at the same as "HEAD" is being updated,
    +        which is an exceedingly rare event.
    +
    +    The alternative would be to instead drop the log-only update completely,
    +    but that would require more logic that is hard to verify without adding
    +    infrastructure specific for such a test. So we rather do the pragmatic
    +    thing and don't worry too much about an edge case that is very unlikely
    +    to happen.
    +
         Unfortunately, this change only helps with the second race. We cannot
         reliably plug the first race without locking the HEAD reference at the
         start of the transaction. Locking HEAD unconditionally would effectively
    @@ refs/files-backend.c
      struct ref_lock {
      	char *ref_name;
      	struct lock_file lk;
    -@@ refs/files-backend.c: int parse_loose_ref_contents(const struct git_hash_algo *algop,
    - 	return 0;
    - }
    - 
    --static void unlock_ref(struct ref_lock *lock)
    -+static int unlock_ref(struct ref_lock *lock)
    - {
    - 	lock->count--;
    - 	if (!lock->count) {
    - 		rollback_lock_file(&lock->lk);
    - 		free(lock->ref_name);
    - 		free(lock);
    -+		return 1;
    - 	}
    -+	return 0;
    - }
    - 
    - /*
     @@ refs/files-backend.c: static enum ref_transaction_error split_head_update(struct ref_update *update,
      
      	new_update = ref_transaction_add_update(
    @@ refs/files-backend.c: static enum ref_transaction_error split_head_update(struct
      
      	/*
      	 * Add "HEAD". This insertion is O(N) in the transaction
    -@@ refs/files-backend.c: struct files_transaction_backend_data {
    -  *   the referent to transaction.
    -  * - If it is an update of head_ref, add a corresponding REF_LOG_ONLY
    -  *   update of HEAD.
    -+ *
    -+ * Returns 0 on success, 1 in case the update needs to be dropped or a negative
    -+ * error code otherwise.
    -  */
    - static enum ref_transaction_error lock_ref_for_update(struct files_ref_store *refs,
    - 						      struct ref_update *update,
     @@ refs/files-backend.c: static enum ref_transaction_error lock_ref_for_update(struct files_ref_store *re
      
      	update->backend_data = lock;
    @@ refs/files-backend.c: static enum ref_transaction_error lock_ref_for_update(stru
     +
     +		/*
     +		 * Check that "HEAD" didn't racily change since we have looked
    -+		 * it up. If it did we remove the reflog-only updateg from the
    -+		 * transaction again.
    ++		 * it up. If it did we must refuse to write the reflog entry.
     +		 *
     +		 * Note that this does not catch all races: if "HEAD" was
     +		 * racily changed to point to one of the refs part of the
    @@ refs/files-backend.c: static enum ref_transaction_error lock_ref_for_update(stru
     +		 */
     +		if (!(update->type & REF_ISSYMREF) ||
     +		    strcmp(update->parent_update->refname, referent.buf)) {
    -+			if (unlock_ref(lock))
    -+				strmap_remove(&backend_data->ref_locks,
    -+					      update->refname, 0);
    -+
    -+			memmove(transaction->updates + update_idx,
    -+				transaction->updates + update_idx + 1,
    -+				(transaction->nr - update_idx - 1) * sizeof(*transaction->updates));
    -+			transaction->nr--;
    -+
    -+			ret = 1;
    ++			strbuf_addstr(err, "HEAD has been racily updated");
    ++			ret = REF_TRANSACTION_ERROR_GENERIC;
     +			goto out;
     +		}
     +
    @@ refs/files-backend.c: static enum ref_transaction_error lock_ref_for_update(stru
      		if (update->flags & REF_NO_DEREF) {
      			/*
      			 * We won't be reading the referent as part of
    -@@ refs/files-backend.c: static int files_transaction_prepare(struct ref_store *ref_store,
    - 					  head_ref, &refnames_to_check,
    - 					  err);
    - 		if (ret) {
    -+			if (ret > 0)
    -+				continue;
    - 			if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
    - 				strbuf_reset(err);
    - 				ret = 0;
 8:  00caacba94 =  8:  06c98ff66f refs: stop unsetting REF_HAVE_OLD for log-only updates
 9:  2271b80a90 =  9:  a3f8e9bee3 refs: fix invalid old object IDs when migrating reflogs

---
base-commit: d82adb61ba2fd11d8f2587fca1b6bd7925ce4044
change-id: 20250722-pks-reflog-append-634172d8ab2c

