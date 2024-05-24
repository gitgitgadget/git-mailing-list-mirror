Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E13985930
	for <git@vger.kernel.org>; Fri, 24 May 2024 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545717; cv=none; b=ZgVeQTlOysis08FnIad9ISpSmIV/HT1l5pZ5H+z//Ropfpuzyao9XJzvtL0WLX2knZEeMduk34y9jbAsMUU1uSqQiRMIwCc1yqlB/BZBZJEiHMrrfNAW2vVMw31uaBEjytoDZrOeJndOOxMLmUKG19kBmnuL9BOSwQU6AG/d/A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545717; c=relaxed/simple;
	bh=/R/2AbbXrVYuTFYzeLVJEMAhYpoLzwY1H151BDfM6gM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5odF7z6Dlg4FvxQK+soeJ9ezaVD3jSzY0XhhWQWLWK87uaVccIDgGkxvcNtHHYSpqps6CGPfL4nFLMq/UtC83VQXLkOSHyHKh7mjFypot+8rqVEoIFTYpcYqz37sU9kljDZu7u9jrLbWoPiuukqegHJJQz5Z4a62ubIss8Bptg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bAH/hLFG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HmNI0cXM; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bAH/hLFG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HmNI0cXM"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 44024138012D;
	Fri, 24 May 2024 06:15:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 24 May 2024 06:15:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716545714; x=1716632114; bh=Jz1+1D2d1p
	sK1wBSigZM7fWPYh1CFZ0MGLvCLfumx6g=; b=bAH/hLFGttblCKqiibCXj7MNIA
	5D5hc7e9v3aVNV3hxphdjznXWxeGcsbS5uouOv7hIjUeon4W1Tu7S6OA6sgC3+Bx
	kVUx5TWEeBwknVB6g+EqHy2++OOXW8UdKCaDHssan1bvi8sPuK18szqA79dr0vjh
	EpztsZ0v8Ty/44nTraLJ/ElvYtPL9Va6CuBNWRJMhsc6QJP5yMtJ+psnMoMF7Tbh
	wG13++jgOgXC9Nf/6jKer3wZ+qXbnHmzRfGu5lxaPnGunceYP8KCxIAL4j/DeK2e
	9ryXbJu1A5pEM6hCEkRIFisluxYqEe4X5RgnMZ/PR5rrH2YUbuUVEHw2Ud6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716545714; x=1716632114; bh=Jz1+1D2d1psK1wBSigZM7fWPYh1C
	FZ0MGLvCLfumx6g=; b=HmNI0cXMZlPMCmkMktaZ+6NRmD9f98/S8Gp/PGxQgEKQ
	2/FpNHqV6nS5U1IoIAvLcu0BAEOgdFjOn+gylix+m+NN70H9GnXx/+0t89hAA4ot
	QYVK2z5Xfc9rvQAFCCXbDA0A4tpj8yBaUmDcvbERyaADFquwrw2wBC8pocOuc4gE
	ToT0koO/o4quhUMio7uOqMxSFJt8XiLT2uHKj3IQ4QOqj+YI0bAgEgYc6Eokzdv/
	wB5sU7QjFi36gk39uunL0mPQSW3tCRz+dPowCkOmXtAKhCVCuXZv5QRs2zzePVH4
	lL937Srxbj/CEig72sxrEhoGOZdU8sKiqtsC89ZMwQ==
X-ME-Sender: <xms:smhQZoHF1MCt3rgaBfOl46a27LDss5KMQpIHiwWPUhnlZmOn03aJpQ>
    <xme:smhQZhUa7Hxvbv3YbzGi9y6c_eiKeNir67_KLV5ektDStkDAt_e2Z3_ydJfuMpfbZ
    qAVoxDzntJjdpq-Nw>
X-ME-Received: <xmr:smhQZiJRsogeyq-xhKBemGbQS1EUjgKPEp8VbFIQztmOSz8afATTxKWlCdMnXftXMA0jOv-0NHL0hqidEBNAukK8JZnHJl2mF2Fj9t2nhzJjG_s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:smhQZqGDDPUCPZY7BQy1l3suAazzuTWnMwxEtKZV54dD3Yy9DKfYZQ>
    <xmx:smhQZuV1Rsfv5rmRVYjtEjTGtbVndq3lgcJwkOOiBGdRBokNdTo0yg>
    <xmx:smhQZtOM7uyP8FIkKeNubTVPs1H8NwWGNETFOqlbCupwXULqigTJdg>
    <xmx:smhQZl0ZOXO3xg2xQHuxO59u0uogmfKHDnVJ-6XcPyzLiaRlJUfRuw>
    <xmx:smhQZtSZXgE5ciWH3uusD2ulBzhcKmXUX7w2SYcki8zjEoRnFJrREtf2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 06:15:13 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b05be614 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 10:15:10 +0000 (UTC)
Date: Fri, 24 May 2024 12:15:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 9/9] builtin/refs: new command to migrate ref storage
 formats
Message-ID: <0df17a51b43e1e9d007328aad6457363876b2e1d.1716545235.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1716545235.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="da5qmlKBV8Tu0PFk"
Content-Disposition: inline
In-Reply-To: <cover.1716545235.git.ps@pks.im>


--da5qmlKBV8Tu0PFk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Introduce a new command that allows the user to migrate a repository
between ref storage formats. This new command is implemented as part of
a new git-refs(1) executable. This is due to two reasons:

  - There is no good place to put the migration logic in existing
    commands. git-maintenance(1) felt unwieldy, and git-pack-refs(1) is
    not the correct place to put it, either.

  - I had it in my mind to create a new low-level command for accessing
    refs for quite a while already. git-refs(1) is that command and can
    over time grow more functionality relating to refs. This should help
    discoverability by consolidating low-level access to refs into a
    single executable.

As mentioned in the preceding commit that introduces the ref storage
format migration logic, the new `git refs migrate` command still has a
bunch of restrictions. These restrictions are documented accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitignore                 |   1 +
 Documentation/git-refs.txt |  62 ++++++++++
 Makefile                   |   1 +
 builtin.h                  |   1 +
 builtin/refs.c             |  75 ++++++++++++
 git.c                      |   1 +
 t/t1460-refs-migrate.sh    | 243 +++++++++++++++++++++++++++++++++++++
 7 files changed, 384 insertions(+)
 create mode 100644 Documentation/git-refs.txt
 create mode 100644 builtin/refs.c
 create mode 100755 t/t1460-refs-migrate.sh

diff --git a/.gitignore b/.gitignore
index 612c0f6a0f..8caf3700c2 100644
--- a/.gitignore
+++ b/.gitignore
@@ -126,6 +126,7 @@
 /git-rebase
 /git-receive-pack
 /git-reflog
+/git-refs
 /git-remote
 /git-remote-http
 /git-remote-https
diff --git a/Documentation/git-refs.txt b/Documentation/git-refs.txt
new file mode 100644
index 0000000000..3f73ad6aa6
--- /dev/null
+++ b/Documentation/git-refs.txt
@@ -0,0 +1,62 @@
+git-refs(1)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+NAME
+----
+
+git-refs - Low-level access to refs
+
+SYNOPSIS
+--------
+
+[verse]
+'git refs migrate' --ref-format=3D<format> [--dry-run]
+
+DESCRIPTION
+-----------
+
+This command provides low-level access to refs.
+
+COMMANDS
+--------
+
+migrate::
+	Migrate ref store between different formats.
+
+OPTIONS
+-------
+
+The following options are specific to 'git refs migrate':
+
+--ref-format=3D<format>::
+	The ref format to migrate the ref store to. Can be one of:
++
+include::ref-storage-format.txt[]
+
+--dry-run::
+	Perform the migration, but do not modify the repository. The migrated
+	refs will be written into a separate directory that can be inspected
+	separately. The name of the directory will be reported on stdout. This
+	can be used to double check that the migration works as expected doing
+	performing the actual migration.
+
+KNOWN LIMITATIONS
+-----------------
+
+The ref format migration has several known limitations in its current form:
+
+* It is not possible to migrate repositories that have reflogs.
+
+* It is not possible to migrate repositories that have worktrees.
+
+* There is no way to block concurrent writes to the repository during an
+  ongoing migration. Concurrent writes can lead to an inconsistent migrated
+  state. Users are expected to block writes on a higher level. If your
+  repository is registered for scheduled maintenance, it is recommended to
+  unregister it first with git-maintenance(1).
+
+These limitations may eventually be lifted.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index cf504963c2..2d702b552c 100644
--- a/Makefile
+++ b/Makefile
@@ -1283,6 +1283,7 @@ BUILTIN_OBJS +=3D builtin/read-tree.o
 BUILTIN_OBJS +=3D builtin/rebase.o
 BUILTIN_OBJS +=3D builtin/receive-pack.o
 BUILTIN_OBJS +=3D builtin/reflog.o
+BUILTIN_OBJS +=3D builtin/refs.o
 BUILTIN_OBJS +=3D builtin/remote-ext.o
 BUILTIN_OBJS +=3D builtin/remote-fd.o
 BUILTIN_OBJS +=3D builtin/remote.o
diff --git a/builtin.h b/builtin.h
index 28280636da..7eda9b2486 100644
--- a/builtin.h
+++ b/builtin.h
@@ -207,6 +207,7 @@ int cmd_rebase(int argc, const char **argv, const char =
*prefix);
 int cmd_rebase__interactive(int argc, const char **argv, const char *prefi=
x);
 int cmd_receive_pack(int argc, const char **argv, const char *prefix);
 int cmd_reflog(int argc, const char **argv, const char *prefix);
+int cmd_refs(int argc, const char **argv, const char *prefix);
 int cmd_remote(int argc, const char **argv, const char *prefix);
 int cmd_remote_ext(int argc, const char **argv, const char *prefix);
 int cmd_remote_fd(int argc, const char **argv, const char *prefix);
diff --git a/builtin/refs.c b/builtin/refs.c
new file mode 100644
index 0000000000..02401afa4e
--- /dev/null
+++ b/builtin/refs.c
@@ -0,0 +1,75 @@
+#include "builtin.h"
+#include "parse-options.h"
+#include "refs.h"
+#include "repository.h"
+#include "strbuf.h"
+
+#define REFS_MIGRATE_USAGE \
+	N_("git refs migrate --ref-format=3D<format> [--dry-run]")
+
+static int cmd_refs_migrate(int argc, const char **argv, const char *prefi=
x)
+{
+	const char * const migrate_usage[] =3D {
+		REFS_MIGRATE_USAGE,
+		NULL
+	};
+	const char *format_str =3D NULL;
+	enum ref_storage_format format;
+	unsigned int flags =3D 0;
+	struct option options[] =3D {
+		OPT_STRING_F(0, "ref-format", &format_str, N_("format"),
+			N_("specify the reference format to convert to"),
+			PARSE_OPT_NONEG),
+		OPT_BIT(0, "dry-run", &flags,
+			N_("perform a non-destructive dry-run"),
+			REPO_MIGRATE_REF_STORAGE_FORMAT_DRYRUN),
+		OPT_END(),
+	};
+	struct strbuf errbuf =3D STRBUF_INIT;
+	int err;
+
+	argc =3D parse_options(argc, argv, prefix, options, migrate_usage, 0);
+	if (argc)
+		usage(_("too many arguments"));
+	if (!format_str)
+		usage(_("missing --ref-format=3D<format>"));
+
+	format =3D ref_storage_format_by_name(format_str);
+	if (format =3D=3D REF_STORAGE_FORMAT_UNKNOWN) {
+		err =3D error(_("unknown ref storage format '%s'"), format_str);
+		goto out;
+	}
+
+	if (the_repository->ref_storage_format =3D=3D format) {
+		err =3D error(_("repository already uses '%s' format"),
+			    ref_storage_format_to_name(format));
+		goto out;
+	}
+
+	if (repo_migrate_ref_storage_format(the_repository, format, flags, &errbu=
f) < 0) {
+		err =3D error("%s", errbuf.buf);
+		goto out;
+	}
+
+	err =3D 0;
+
+out:
+	strbuf_release(&errbuf);
+	return err;
+}
+
+int cmd_refs(int argc, const char **argv, const char *prefix)
+{
+	const char * const refs_usage[] =3D {
+		REFS_MIGRATE_USAGE,
+		NULL,
+	};
+	parse_opt_subcommand_fn *fn =3D NULL;
+	struct option opts[] =3D {
+		OPT_SUBCOMMAND("migrate", &fn, cmd_refs_migrate),
+		OPT_END(),
+	};
+
+	argc =3D parse_options(argc, argv, prefix, opts, refs_usage, 0);
+	return fn(argc, argv, prefix);
+}
diff --git a/git.c b/git.c
index 637c61ca9c..683bb69194 100644
--- a/git.c
+++ b/git.c
@@ -594,6 +594,7 @@ static struct cmd_struct commands[] =3D {
 	{ "rebase", cmd_rebase, RUN_SETUP | NEED_WORK_TREE },
 	{ "receive-pack", cmd_receive_pack },
 	{ "reflog", cmd_reflog, RUN_SETUP },
+	{ "refs", cmd_refs, RUN_SETUP },
 	{ "remote", cmd_remote, RUN_SETUP },
 	{ "remote-ext", cmd_remote_ext, NO_PARSEOPT },
 	{ "remote-fd", cmd_remote_fd, NO_PARSEOPT },
diff --git a/t/t1460-refs-migrate.sh b/t/t1460-refs-migrate.sh
new file mode 100755
index 0000000000..f7c0783d30
--- /dev/null
+++ b/t/t1460-refs-migrate.sh
@@ -0,0 +1,243 @@
+#!/bin/sh
+
+test_description=3D'migration of ref storage backends'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
+. ./test-lib.sh
+
+test_migration () {
+	git -C "$1" for-each-ref --include-root-refs \
+		--format=3D'%(refname) %(objectname) %(symref)' >expect &&
+	git -C "$1" refs migrate --ref-format=3D"$2" &&
+	git -C "$1" for-each-ref --include-root-refs \
+		--format=3D'%(refname) %(objectname) %(symref)' >actual &&
+	test_cmp expect actual &&
+
+	git -C "$1" rev-parse --show-ref-format >actual &&
+	echo "$2" >expect &&
+	test_cmp expect actual
+}
+
+test_expect_success 'setup' '
+	rm -rf .git &&
+	# The migration does not yet support reflogs.
+	git config --global core.logAllRefUpdates false
+'
+
+test_expect_success "superfluous arguments" '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_must_fail git -C repo refs migrate foo 2>err &&
+	cat >expect <<-EOF &&
+	usage: too many arguments
+	EOF
+	test_cmp expect err
+'
+
+test_expect_success "missing ref storage format" '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_must_fail git -C repo refs migrate 2>err &&
+	cat >expect <<-EOF &&
+	usage: missing --ref-format=3D<format>
+	EOF
+	test_cmp expect err
+'
+
+test_expect_success "unknown ref storage format" '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_must_fail git -C repo refs migrate \
+		--ref-format=3Dunknown 2>err &&
+	cat >expect <<-EOF &&
+	error: unknown ref storage format ${SQ}unknown${SQ}
+	EOF
+	test_cmp expect err
+'
+
+ref_formats=3D"files reftable"
+for from_format in $ref_formats
+do
+	for to_format in $ref_formats
+	do
+		if test "$from_format" =3D "$to_format"
+		then
+			continue
+		fi
+
+		test_expect_success "$from_format: migration to same format fails" '
+			test_when_finished "rm -rf repo" &&
+			git init --ref-format=3D$from_format repo &&
+			test_must_fail git -C repo refs migrate \
+				--ref-format=3D$from_format 2>err &&
+			cat >expect <<-EOF &&
+			error: repository already uses ${SQ}$from_format${SQ} format
+			EOF
+			test_cmp expect err
+		'
+
+		test_expect_success "$from_format -> $to_format: migration with reflog f=
ails" '
+			test_when_finished "rm -rf repo" &&
+			git init --ref-format=3D$from_format repo &&
+			test_config -C repo core.logAllRefUpdates true &&
+			test_commit -C repo logged &&
+			test_must_fail git -C repo refs migrate \
+				--ref-format=3D$to_format 2>err &&
+			cat >expect <<-EOF &&
+			error: migrating reflogs is not supported yet
+			EOF
+			test_cmp expect err
+		'
+
+		test_expect_success "$from_format -> $to_format: migration with worktree=
 fails" '
+			test_when_finished "rm -rf repo" &&
+			git init --ref-format=3D$from_format repo &&
+			git -C repo worktree add wt &&
+			test_must_fail git -C repo refs migrate \
+				--ref-format=3D$to_format 2>err &&
+			cat >expect <<-EOF &&
+			error: migrating repositories with worktrees is not supported yet
+			EOF
+			test_cmp expect err
+		'
+
+		test_expect_success "$from_format -> $to_format: unborn HEAD" '
+			test_when_finished "rm -rf repo" &&
+			git init --ref-format=3D$from_format repo &&
+			test_migration repo "$to_format"
+		'
+
+		test_expect_success "$from_format -> $to_format: single ref" '
+			test_when_finished "rm -rf repo" &&
+			git init --ref-format=3D$from_format repo &&
+			test_commit -C repo initial &&
+			test_migration repo "$to_format"
+		'
+
+		test_expect_success "$from_format -> $to_format: bare repository" '
+			test_when_finished "rm -rf repo repo.git" &&
+			git init --ref-format=3D$from_format repo &&
+			test_commit -C repo initial &&
+			git clone --ref-format=3D$from_format --mirror repo repo.git &&
+			test_migration repo.git "$to_format"
+		'
+
+		test_expect_success "$from_format -> $to_format: dangling symref" '
+			test_when_finished "rm -rf repo" &&
+			git init --ref-format=3D$from_format repo &&
+			test_commit -C repo initial &&
+			git -C repo symbolic-ref BROKEN_HEAD refs/heads/nonexistent &&
+			test_migration repo "$to_format" &&
+			echo refs/heads/nonexistent >expect &&
+			git -C repo symbolic-ref BROKEN_HEAD >actual &&
+			test_cmp expect actual
+		'
+
+		test_expect_success "$from_format -> $to_format: broken ref" '
+			test_when_finished "rm -rf repo" &&
+			git init --ref-format=3D$from_format repo &&
+			test_commit -C repo initial &&
+			test-tool -C repo ref-store main update-ref "" refs/heads/broken \
+				"$(test_oid 001)" "$ZERO_OID" REF_SKIP_CREATE_REFLOG,REF_SKIP_OID_VERI=
FICATION &&
+			test_migration repo "$to_format" &&
+			test_oid 001 >expect &&
+			git -C repo rev-parse refs/heads/broken >actual &&
+			test_cmp expect actual
+		'
+
+		test_expect_success "$from_format -> $to_format: pseudo-refs" '
+			test_when_finished "rm -rf repo" &&
+			git init --ref-format=3D$from_format repo &&
+			test_commit -C repo initial &&
+			git -C repo update-ref FOO_HEAD HEAD &&
+			test_migration repo "$to_format"
+		'
+
+		test_expect_success "$from_format -> $to_format: special refs are left a=
lone" '
+			test_when_finished "rm -rf repo" &&
+			git init --ref-format=3D$from_format repo &&
+			test_commit -C repo initial &&
+			git -C repo rev-parse HEAD >repo/.git/MERGE_HEAD &&
+			git -C repo rev-parse MERGE_HEAD &&
+			test_migration repo "$to_format" &&
+			test_path_is_file repo/.git/MERGE_HEAD
+		'
+
+		test_expect_success "$from_format -> $to_format: a bunch of refs" '
+			test_when_finished "rm -rf repo" &&
+			git init --ref-format=3D$from_format repo &&
+
+			test_commit -C repo initial &&
+			cat >input <<-EOF &&
+			create FOO_HEAD HEAD
+			create refs/heads/branch-1 HEAD
+			create refs/heads/branch-2 HEAD
+			create refs/heads/branch-3 HEAD
+			create refs/heads/branch-4 HEAD
+			create refs/tags/tag-1 HEAD
+			create refs/tags/tag-2 HEAD
+			EOF
+			git -C repo update-ref --stdin <input &&
+			test_migration repo "$to_format"
+		'
+
+		test_expect_success "$from_format -> $to_format: dry-run migration does =
not modify repository" '
+			test_when_finished "rm -rf repo" &&
+			git init --ref-format=3D$from_format repo &&
+			test_commit -C repo initial &&
+			git -C repo refs migrate --dry-run \
+				--ref-format=3D$to_format >output &&
+			grep "Finished dry-run migration of refs" output &&
+			test_path_is_dir repo/.git/ref_migration.* &&
+			echo $from_format >expect &&
+			git -C repo rev-parse --show-ref-format >actual &&
+			test_cmp expect actual
+		'
+	done
+done
+
+test_expect_success 'migrating from files format deletes backend files' '
+	test_when_finished "rm -rf repo" &&
+	git init --ref-format=3Dfiles repo &&
+	test_commit -C repo first &&
+	git -C repo pack-refs --all &&
+	test_commit -C repo second &&
+	git -C repo update-ref ORIG_HEAD HEAD &&
+	git -C repo rev-parse HEAD >repo/.git/FETCH_HEAD &&
+
+	test_path_is_file repo/.git/HEAD &&
+	test_path_is_file repo/.git/ORIG_HEAD &&
+	test_path_is_file repo/.git/refs/heads/main &&
+	test_path_is_file repo/.git/packed-refs &&
+
+	test_migration repo reftable &&
+
+	echo "ref: refs/heads/.invalid" >expect &&
+	test_cmp expect repo/.git/HEAD &&
+	echo "this repository uses the reftable format" >expect &&
+	test_cmp expect repo/.git/refs/heads &&
+	test_path_is_file repo/.git/FETCH_HEAD &&
+	test_path_is_missing repo/.git/ORIG_HEAD &&
+	test_path_is_missing repo/.git/refs/heads/main &&
+	test_path_is_missing repo/.git/logs &&
+	test_path_is_missing repo/.git/packed-refs
+'
+
+test_expect_success 'migrating from reftable format deletes backend files'=
 '
+	test_when_finished "rm -rf repo" &&
+	git init --ref-format=3Dreftable repo &&
+	test_commit -C repo first &&
+
+	test_path_is_dir repo/.git/reftable &&
+	test_migration repo files &&
+
+	test_path_is_missing repo/.git/reftable &&
+	echo "ref: refs/heads/main" >expect &&
+	test_cmp expect repo/.git/HEAD &&
+	test_path_is_file repo/.git/refs/heads/main
+'
+
+test_done
--=20
2.45.1.216.g4365c6fcf9.dirty


--da5qmlKBV8Tu0PFk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQaK4ACgkQVbJhu7ck
PpQ5AQ//UfdwulQGplccDjehyOEJ9ZjaQ6BXO+xRb41Bkzf78ow18t2iJIZLwozx
7/J6lLo07B1Ik1WS3xGGpLf++uPl1Scxe9kS3nj7OLjucTW2YvSc72Q6Ac3JKm+Q
hIqqk3zIdb3Qlrelj58HmbmHCewlnF+mD3CXtNQjo/TheiQIgKRIjRa/AU8AviOW
uky/fYgrOQDYeljPxUUZm/6ICJzf3NuqoZXRGfbm3P0B6ERc86ZxebzvDUTdy8hp
Qw0/SJ0W5D/qehqCLLbC54pTNgw9+6+zca03Nxvu5qYYYadU+sNRTaOOspXxP268
WHJfN1OiyCLa/rKVOC64xPhRontpV+37xuEzjxE8TyCzKwib/iqRG0X0O4KUWR7Q
UZi+olcRAZPp9wGA7mcKNA/7Rsl8TY7BAFd4mvmGR4iepFbs524DdgWpd3Q97sQU
HNgmsdS7HHqraTg633hMrKAafaR+WgkKMjWsB5VttmXwxfDLHjed9gHDziTsyrFi
UKRWygQdbFUmwuXkbRPG0OzV5AhybgpN0v0HSEiHGiuYLYF7LjO6Q+r5szmZLft5
/Td/JUZwzmONQu+d83Uq7fyO5b/xPSUjAHnCniqeRmnh6nZ6yo8gkiTRx7kPafuQ
WSUtaYg2AuqWn9LRRsOco3ZuLiI261SBVmTsaGdBJCFJbLpQ+YE=
=D7Z2
-----END PGP SIGNATURE-----

--da5qmlKBV8Tu0PFk--
