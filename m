Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6191AC88A
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 06:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753426716; cv=none; b=cXrKZx2NM96P9HjeCzhKmeRvs1Yg27RSiWEpVOo3UM5e7GDKoZ8WZefQVoIhnxKl064TjAn9hDBkPZ4BH9oHKEHt3vWInIDl8YmVE+xhc12OsMPiBmuAsgk5y/lbalGy7Cj7YtcAqyjLqptHq8Yj9MUW24HzulAFLwIaYb0/Rto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753426716; c=relaxed/simple;
	bh=34/XGCJAoGTmxm9k1NcuaK3etWlsnWFGqaezJOIwg0M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=pPMkdJx1TQ07mrjI4sYMiDfr9CdhRU1O/LGuKhemec9URq/hrhRShSxG3fQMeoPuxBUhOv3nahnc4twMwR7iehrLs2dJhZX1kOgzjmnFQm2bHDVsEhOyjLARuYB9Z0p7Ngh9ymEF6F0kTmdbNJ3woUUtM24l9S9GZOlhNhz99JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HakcKKmT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MczgE7mz; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HakcKKmT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MczgE7mz"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AF81B1400253;
	Fri, 25 Jul 2025 02:58:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 25 Jul 2025 02:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753426712;
	 x=1753513112; bh=7PaMuREksSZoc8cNxWKOa7IwNttD9iuozTs8FzPqoSs=; b=
	HakcKKmTuepV/79yaqP3txzpQeLTFZ7QTd2+rc3PbfBK3cfNkszLYrIq3y5n5dxH
	he+xjmr8vSyTq8xN4bVETfMRay2ifdrMpsWCWKwNireFh1yYciCLOiXxULBHEWpp
	DLobCNOMe5vANoycTC0pmSeJesMFLtFyPoUSW7i0N+ps19IEyWUOpyjqmSMn4pQK
	yqTi5EgBJoYKIFc8iZVibQ4s5T96bo32xNzEmhbhbT1SF7rYd0AA825pXdM1MRsW
	chgIYsO9GxlSdKDcJm36JNmCbnWyTJRJ2oMCviGkxBezeES61Ck/vA+Kv3CNioJY
	lt6iu1BbibSvoHzZMEOM6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753426712; x=
	1753513112; bh=7PaMuREksSZoc8cNxWKOa7IwNttD9iuozTs8FzPqoSs=; b=M
	czgE7mz/pa/5VMtTBnhzQM8Y9HB0lBwZKFX8IAvdiMq5WkFR2/riDZmhPnEd3qUF
	CvZD303W5fXrpNpW0WRI0RDJrXVuzZKvLtGkTRYC4gHNKPaIzrZk1kA+dY2Kn8MN
	YTPXNYF9yRGFnazr5xOJGeRAS+bh4uzahDjw2O908GVqHSv95f4nKAqalEw+Ds9T
	QsvhDjy2NaRHT8i2YfEo9mSu6Jn5s1Uo9gNRFTj7DXHA9dZ73tRiYW5WIE8CGbdo
	DvPK3KtifhVJ6+lt9mN6VHDhBejohilCWr/fWG3AjWq/Z4SFx+DNRXYRoYoe1wwk
	W1Z+lAZNB/quDd2YFAsBQ==
X-ME-Sender: <xms:GCuDaHHor-wQQ2WTBK6FQt0_TbspbweoIARIHAA3lstgIBHUKUc4nA>
    <xme:GCuDaMzYqmDq9SD5y_HV3G5QzimGGi8_FyKS3vjpDEwIjLLpbIWgadySFb1ZALcCr
    zF3M26kexvrAyz0PQ>
X-ME-Received: <xmr:GCuDaJkGg09SKqYPjqwamQZCjODvJMpMg2ggOmaQ3usTof6haA_RYrqCbnXjbL9eirykR-j8tKZwr7xcpZflM7Pii5_8zlT-tzSO62hd-Nj_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekvdekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epteeuueehhffhiedtueehtddtieekfedtudehtdehfefhgeffveeggedthfehuedvnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeei
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshiivg
    guvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghl
    rdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:GCuDaFkUObwdA4QooPtaJ4yR86B882EaN-Nt4-hD0HzfXzYZwUF8xg>
    <xmx:GCuDaLy-0evOV6Miv46LTeVHtC7m-k1Rsw0vnUG-IEaPwP5kLy6ckg>
    <xmx:GCuDaKqUA8V9wlCGLvIq13uxUS-Dk5oA4xDt8nlPUOQgbWgUmw3-hA>
    <xmx:GCuDaK4MnZES7p6zPypeRCdWrM91SWiU5kteNfvRoKgsIRt93w0PAw>
    <xmx:GCuDaPlSbXaPsxi42vaSGSsTgSAUMbctkx4CtalWzzfYUM5lh7TLI26l>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Jul 2025 02:58:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a03a4773 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Jul 2025 06:58:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/8] refs: fix migration of reflog entries
Date: Fri, 25 Jul 2025 08:58:22 +0200
Message-Id: <20250725-pks-reflog-append-v2-0-e4e7cbe3f578@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA4rg2gC/32NSw7CIBCGr9LM2jEwfbvyHqYLLGM7UQsBQzRN7
 y72AC6//7lC5CAc4VSsEDhJFLdkoEMB42yWiVFsZiBFtWqJ0N8jBr493ITGe14sNmWlW7KdudI
 IueezLe998zJkniW+XPjsF0n/1H9rSaNC3ZVc91VvWTfnnDnKE4Zt274P6M5ErwAAAA==
X-Change-ID: 20250722-pks-reflog-append-634172d8ab2c
In-Reply-To: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Toon Claes <toon@iotcl.com>
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

Thanks!

Patrick

---
Patrick Steinhardt (8):
      Documentation/git-reflog: convert to use synopsis type
      builtin/reflog: improve grouping of subcommands
      refs: export `ref_transaction_update_reflog()`
      builtin/reflog: implement subcommand to write new entries
      ident: fix type of string length parameter
      refs: fix identity for migrated reflogs
      refs: stop unsetting REF_HAVE_OLD for log-only updates
      refs: fix invalid old object IDs when migrating reflogs

 Documentation/git-reflog.adoc |  76 +++++++++++++++++--------------
 builtin/reflog.c              | 103 ++++++++++++++++++++++++++++++++++--------
 ident.c                       |   2 +-
 ident.h                       |   2 +-
 refs.c                        |  60 +++++++++++++-----------
 refs.h                        |  24 +++++++++-
 refs/files-backend.c          |  25 ++++++++--
 refs/refs-internal.h          |   3 +-
 refs/reftable-backend.c       |  26 +++++++----
 t/meson.build                 |   1 +
 t/t1421-reflog-write.sh       |  99 ++++++++++++++++++++++++++++++++++++++++
 t/t1460-refs-migrate.sh       |  22 ++++++---
 12 files changed, 338 insertions(+), 105 deletions(-)

Range-diff versus v1:

1:  a5f91e51802 = 1:  19a1df63ee6 Documentation/git-reflog: convert to use synopsis type
2:  3b39a73a942 ! 2:  807cc393337 builtin/reflog: improve grouping of subcommands
    @@ Metadata
      ## Commit message ##
         builtin/reflog: improve grouping of subcommands
     
    -    The way subcommands of git-reflog(1) are layed out does not make any
    +    The way subcommands of git-reflog(1) are laid out does not make any
         immediate sense. Reorder them such that read-only subcommands precede
         writing commands for a bit more structure.
     
    @@ Documentation/git-reflog.adoc: SYNOPSIS
      
      DESCRIPTION
      -----------
    +@@ Documentation/git-reflog.adoc: actions, and in addition the `HEAD` reflog records branch switching.
    + 
    + The "list" subcommand lists all refs which have a corresponding reflog.
    + 
    +-The "expire" subcommand prunes older reflog entries. Entries older
    +-than `expire` time, or entries older than `expire-unreachable` time
    +-and not reachable from the current tip, are removed from the reflog.
    +-This is typically not used directly by end users -- instead, see
    +-linkgit:git-gc[1].
    ++The "exists" subcommand checks whether a ref has a reflog.  It exits
    ++with zero status if the reflog exists, and non-zero status if it does
    ++not.
    + 
    + The "delete" subcommand deletes single entries from the reflog, but
    + not the reflog itself. Its argument must be an _exact_ entry (e.g. "`git
    +@@ Documentation/git-reflog.adoc: The "drop" subcommand completely removes the reflog for the specified
    + references. This is in contrast to "expire" and "delete", both of which
    + can be used to delete reflog entries, but not the reflog itself.
    + 
    +-The "exists" subcommand checks whether a ref has a reflog.  It exits
    +-with zero status if the reflog exists, and non-zero status if it does
    +-not.
    ++The "expire" subcommand prunes older reflog entries. Entries older
    ++than `expire` time, or entries older than `expire-unreachable` time
    ++and not reachable from the current tip, are removed from the reflog.
    ++This is typically not used directly by end users -- instead, see
    ++linkgit:git-gc[1].
    + 
    + OPTIONS
    + -------
    +@@ Documentation/git-reflog.adoc: Options for `show`
    + `git reflog show` accepts any of the options accepted by `git log`.
    + 
    + 
    ++Options for `delete`
    ++~~~~~~~~~~~~~~~~~~~~
    ++
    ++`git reflog delete` accepts options `--updateref`, `--rewrite`, `-n`,
    ++`--dry-run`, and `--verbose`, with the same meanings as when they are
    ++used with `expire`.
    ++
    ++Options for `drop`
    ++~~~~~~~~~~~~~~~~~~
    ++
    ++--all::
    ++	Drop the reflogs of all references from all worktrees.
    ++
    ++--single-worktree::
    ++	By default when `--all` is specified, reflogs from all working
    ++	trees are dropped. This option limits the processing to reflogs
    ++	from the current working tree only.
    ++
    ++
    + Options for `expire`
    + ~~~~~~~~~~~~~~~~~~~~
    + 
    +@@ Documentation/git-reflog.adoc: which didn't protect objects referred to by reflogs.
    + 	Print extra information on screen.
    + 
    + 
    +-Options for `delete`
    +-~~~~~~~~~~~~~~~~~~~~
    +-
    +-`git reflog delete` accepts options `--updateref`, `--rewrite`, `-n`,
    +-`--dry-run`, and `--verbose`, with the same meanings as when they are
    +-used with `expire`.
    +-
    +-Options for `drop`
    +-~~~~~~~~~~~~~~~~~~
    +-
    +---all::
    +-	Drop the reflogs of all references from all worktrees.
    +-
    +---single-worktree::
    +-	By default when `--all` is specified, reflogs from all working
    +-	trees are dropped. This option limits the processing to reflogs
    +-	from the current working tree only.
    +-
    + GIT
    + ---
    + Part of the linkgit:git[1] suite
     
      ## builtin/reflog.c ##
     @@
3:  ce7a5409eec ! 3:  1fe1c93db2f refs: export `ref_transaction_update_reflog()`
    @@ Commit message
     
         In a subsequent commit we'll add another user that wants to write reflog
         entries. This requires them to call `ref_transaction_update_reflog()`,
    -    but that functino is local to "refs.c".
    +    but that function is local to "refs.c".
     
         Export the function to prepare for the change. While at it, drop the
         `flags` field, as all callers are for now expected to use the same flags
    @@ refs.h: int ref_transaction_update(struct ref_transaction *transaction,
      			   struct strbuf *err);
      
     +/*
    -+ * Similar to`ref_transaction_update`, but this function is only for adding
    ++ * Similar to `ref_transaction_update`, but this function is only for adding
     + * a reflog update. Supports providing custom committer information. The index
    -+ * field can be utiltized to order updates as desired. When not used, the
    ++ * field can be utiltized to order updates as desired. When set to zero, the
     + * updates default to being ordered by refname.
     + */
     +int ref_transaction_update_reflog(struct ref_transaction *transaction,
4:  c0a7e9031dd ! 4:  38835607a92 builtin/reflog: implement subcommand to write new entries
    @@ Documentation/git-reflog.adoc: SYNOPSIS
      git reflog delete [--rewrite] [--updateref]
      	[--dry-run | -n] [--verbose] <ref>@{<specifier>}...
      git reflog drop [--all [--single-worktree] | <refs>...]
    +@@ Documentation/git-reflog.adoc: The "exists" subcommand checks whether a ref has a reflog.  It exits
    + with zero status if the reflog exists, and non-zero status if it does
    + not.
    + 
    ++The "write" subcommand writes a single entry to the reflog of a given
    ++reference. This new entry is appended to the reflog and will thus become
    ++the most recent entry. Both the old and new object IDs must not be
    ++abbreviated and must point to existing objects. The reflog message gets
    ++normalized.
    ++
    + The "delete" subcommand deletes single entries from the reflog, but
    + not the reflog itself. Its argument must be an _exact_ entry (e.g. "`git
    + reflog delete master@{2}`"). This subcommand is also typically not used
     
      ## builtin/reflog.c ##
     @@
    @@ builtin/reflog.c
      #include "config.h"
      #include "gettext.h"
     +#include "hex.h"
    -+#include "odb.h"
    ++#include "object-store.h"
      #include "revision.h"
      #include "reachable.h"
      #include "wildmatch.h"
    @@ builtin/reflog.c: static int cmd_reflog_drop(int argc, const char **argv, const
     +	const char *ref, *message;
     +	int ret;
     +
    -+	argc = parse_options(argc, argv, prefix, options, reflog_drop_usage, 0);
    ++	argc = parse_options(argc, argv, prefix, options, reflog_write_usage, 0);
     +	if (argc != 4)
     +		usage_with_options(reflog_write_usage, options);
     +
    @@ builtin/reflog.c: static int cmd_reflog_drop(int argc, const char **argv, const
     +	ret = get_oid_hex_algop(argv[1], &old_oid, repo->hash_algo);
     +	if (ret)
     +		die(_("invalid old object ID: '%s'"), argv[1]);
    -+	if (!is_null_oid(&old_oid) && !odb_has_object(repo->objects, &old_oid, 0))
    ++	if (!is_null_oid(&old_oid) && !has_object(the_repository, &old_oid, 0))
     +		die(_("old object '%s' does not exist"), argv[1]);
     +
     +	ret = get_oid_hex_algop(argv[2], &new_oid, repo->hash_algo);
     +	if (ret)
     +		die(_("invalid new object ID: '%s'"), argv[2]);
    -+	if (!is_null_oid(&new_oid) && !odb_has_object(repo->objects, &new_oid, 0))
    ++	if (!is_null_oid(&new_oid) && !has_object(the_repository, &new_oid, 0))
     +		die(_("new object '%s' does not exist"), argv[2]);
     +
     +	message = argv[3];
    @@ t/t1421-reflog-write.sh (new)
     +	)
     +'
     +
    -+test_expect_success 'nonexistent old object ID' '
    ++test_expect_success 'nonexistent object IDs' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
     +	(
     +		cd repo &&
    -+		test_must_fail git reflog write refs/heads/something $(test_oid deadbeef) $ZERO_OID first 2>err &&
    -+		test_grep "old object .* does not exist" err
    ++		test_must_fail git reflog write refs/heads/something $(test_oid deadbeef) $ZERO_OID old-object-id 2>err &&
    ++		test_grep "old object .* does not exist" err &&
    ++		test_must_fail git reflog write refs/heads/something $ZERO_OID $(test_oid deadbeef) new-object-id 2>err &&
    ++		test_grep "new object .* does not exist" err
     +	)
     +'
     +
    -+test_expect_success 'nonexistent new object ID' '
    ++test_expect_success 'abbreviated object IDs' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
     +	(
     +		cd repo &&
    -+		test_must_fail git reflog write refs/heads/something $ZERO_OID $(test_oid deadbeef) first 2>err &&
    -+		test_grep "new object .* does not exist" err
    ++		test_must_fail git reflog write refs/heads/something 12345 $ZERO_OID old-object-id 2>err &&
    ++		test_grep "invalid old object ID" err &&
    ++		test_must_fail git reflog write refs/heads/something $ZERO_OID 12345 new-object-id 2>err &&
    ++		test_grep "invalid new object ID" err
    ++	)
    ++'
    ++
    ++test_expect_success 'reflog message gets normalized' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		test_commit initial &&
    ++		COMMIT_OID=$(git rev-parse HEAD) &&
    ++		git reflog write HEAD $COMMIT_OID $COMMIT_OID "$(printf "message\nwith\nnewlines")" &&
    ++		git reflog show -1 --format=%gs HEAD >actual &&
    ++		echo "message with newlines" >expected &&
    ++		test_cmp expected actual
     +	)
     +'
     +
    @@ t/t1421-reflog-write.sh (new)
     +		EOF
     +
     +		git reflog write refs/heads/something $COMMIT_OID $COMMIT_OID second &&
    ++		# Note: the old object ID of the second reflog entry is broken.
    ++		# This will be fixed in subsequent commits.
     +		test_reflog_matches . refs/heads/something <<-EOF
     +		$ZERO_OID $COMMIT_OID $SIGNATURE	first
    -+		$COMMIT_OID $COMMIT_OID $SIGNATURE	second
    ++		$ZERO_OID $COMMIT_OID $SIGNATURE	second
     +		EOF
     +	)
     +'
5:  15fddba8b21 = 5:  7b6c0d00668 ident: fix type of string length parameter
6:  588d7a397f9 ! 6:  8caa2899d25 refs: fix identity for migrated reflogs
    @@ Commit message
         bug is fixed we'll make the reflog verification in t1450 stricter, and
         that will catch both this bug here and the other bug.
     
    +    Note that we also add two new `name` and `mail` string buffers to the
    +    callback structures and splice them through to the callbacks. This is
    +    done so that we can avoid allocating a new buffer every time we compute
    +    the committer information.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## refs.c ##
    @@ refs.c: static int migrate_one_reflog_entry(struct object_id *old_oid,
     +
      	date = show_date(timestamp, tz, DATE_MODE(NORMAL));
      	strbuf_reset(data->sb);
    - 	/* committer contains name and email */
    +-	/* committer contains name and email */
     -	strbuf_addstr(data->sb, fmt_ident("", committer, WANT_BLANK_IDENT, date, 0));
     +	strbuf_addstr(data->sb, fmt_ident(data->name->buf, data->mail->buf, WANT_BLANK_IDENT, date, 0));
      
7:  fea43d4a3f9 ! 7:  e2ed6164a7c refs: stop unsetting REF_HAVE_OLD for log-only updates
    @@ Commit message
         refs: stop unsetting REF_HAVE_OLD for log-only updates
     
         The `REF_HAVE_OLD` flag indicates whether a given ref update has its old
    -    object ID set. If so, the value of that field is used to verify whteher
    +    object ID set. If so, the value of that field is used to verify whether
         the current state of the reference matches this expected state. It is
         thus an important part of mitigating races with a concurrent process
         that updates the same set of references.
    @@ Commit message
     
         But unsetting this flag also removes a useful signal, namely that the
         caller _did_ provide an old object ID for a given reflog entry. This
    -    signal is useful to determine whether we have to resolve the refname
    -    manually to figure out the current state, or whether we should just go
    -    with what the caller has provided.
    +    signal will become useful in a subsequent commit, where we add a new
    +    flag that tells the transaction to use the provided old and new object
    +    IDs to write a reflog entry. The `REF_HAVE_OLD` flag is then used as a
    +    signal to verify that the caller really did provide an old object ID.
     
    -    This actually causes real issues when migrating reflogs, as we don't
    -    know to actually use the caller-provided old object ID when writing
    -    those entries. Instead, reflog entries simply end up with the all-zero
    -    object ID.
    -
    -    Stop unsetting the flag so that we can use it as this described signal,
    -    which we'll do in a subsequent commit. Skip checking the old object ID
    -    for log-only updates so that we don't expect it to match the current
    -    on-disk state.
    +    Stop unsetting the flag so that we can use it as this described signal
    +    in a subsequent commit. Skip checking the old object ID for log-only
    +    updates so that we don't expect it to match the current on-disk state.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ refs.c: int repo_migrate_ref_storage_format(struct repository *repo,
      
      int ref_update_expects_existing_old_ref(struct ref_update *update)
      {
    --	return (update->flags & REF_HAVE_OLD) &&
    -+	return (update->flags & (REF_HAVE_OLD | REF_LOG_ONLY)) == REF_HAVE_OLD &&
    ++	if (update->flags & REF_LOG_ONLY)
    ++		return 0;
    ++
    + 	return (update->flags & REF_HAVE_OLD) &&
      		(!is_null_oid(&update->old_oid) || update->old_target);
      }
    - 
     
      ## refs/files-backend.c ##
     @@ refs/files-backend.c: static enum ref_transaction_error split_symref_update(struct ref_update *update,
    @@ refs/files-backend.c: static int files_transaction_finish_initial(struct files_r
      			BUG("initial ref transaction with old_sha1 set");
      
     
    + ## refs/refs-internal.h ##
    +@@ refs/refs-internal.h: enum ref_transaction_error ref_update_check_old_target(const char *referent,
    + 
    + /*
    +  * Check if the ref must exist, this means that the old_oid or
    +- * old_target is non NULL.
    ++ * old_target is non NULL. Log-only updates never require the old state to
    ++ * match.
    +  */
    + int ref_update_expects_existing_old_ref(struct ref_update *update);
    + 
    +
      ## refs/reftable-backend.c ##
     @@ refs/reftable-backend.c: static enum ref_transaction_error prepare_single_update(struct reftable_ref_stor
      	if (ret > 0) {
8:  24b5261d882 ! 8:  2382633e2e3 refs: fix invalid old object IDs when migrating reflogs
    @@ refs/reftable-backend.c: static enum ref_transaction_error prepare_single_update
      	if ((u->flags & REF_HAVE_NEW) && !is_null_oid(&u->new_oid) &&
      	    !(u->flags & REF_SKIP_OID_VERIFICATION) &&
     
    + ## t/t1421-reflog-write.sh ##
    +@@ t/t1421-reflog-write.sh: test_expect_success 'simple writes' '
    + 		EOF
    + 
    + 		git reflog write refs/heads/something $COMMIT_OID $COMMIT_OID second &&
    +-		# Note: the old object ID of the second reflog entry is broken.
    +-		# This will be fixed in subsequent commits.
    + 		test_reflog_matches . refs/heads/something <<-EOF
    + 		$ZERO_OID $COMMIT_OID $SIGNATURE	first
    +-		$ZERO_OID $COMMIT_OID $SIGNATURE	second
    ++		$COMMIT_OID $COMMIT_OID $SIGNATURE	second
    + 		EOF
    + 	)
    + '
    +
      ## t/t1460-refs-migrate.sh ##
     @@ t/t1460-refs-migrate.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
      
    @@ t/t1460-refs-migrate.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     +print_all_reflog_entries () {
     +	repo=$1 &&
     +	test-tool -C "$repo" ref-store main for-each-reflog >reflogs &&
    -+	cat reflogs | while read reflog
    ++	while read reflog
     +	do
     +		echo "REFLOG: $reflog" &&
     +		test-tool -C "$repo" ref-store main for-each-reflog-ent "$reflog" ||
     +		return 1
    -+	done
    ++	done <reflogs
     +}
     +
      # Migrate the provided repository from one format to the other and

---
base-commit: d82adb61ba2fd11d8f2587fca1b6bd7925ce4044
change-id: 20250722-pks-reflog-append-634172d8ab2c

