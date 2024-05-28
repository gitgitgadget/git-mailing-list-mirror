Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026B08F48
	for <git@vger.kernel.org>; Tue, 28 May 2024 06:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716877934; cv=none; b=eK8cY0LV0IpsBifgjiew/BJg9xLb5wv9R/FVomplXbGxw65IlkiZ93/PMUF6HaXOy05a6fosPoZZxdnhltLQbAVNV6L6QASCqm410QyGtwlU5oWuHHxgVg1s5yStfbX7an8DITJvaSf4brO6p0r/NvX8xyrIhdY+Dny28a9JCjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716877934; c=relaxed/simple;
	bh=3lB0mQM9rGKArezw/ZCMRlnz7vVf+aNYVzvpOrbVg/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2Ml0rghf197V5vgPt0dIYLTc7cwiaW5jejXyDmMfTD6RY30omBgRL8ZcbLFLYLGqKLl9uM/MkmFr4XYhBOc5M+ltVFIT7hc5LAOk7SzUftirE+0AVoSgJ3vax8mqTWVSk0Rcvp4d0KeJLg3V49Vhh2ezUwFnv9oZGAzdA055Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lTNcBmcE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kSw0Kpll; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lTNcBmcE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kSw0Kpll"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 184F813800A8;
	Tue, 28 May 2024 02:32:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 28 May 2024 02:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716877931; x=1716964331; bh=6M7SvIoSC5
	wS2sG80EEbJpkVHwUJl0BzbhebbmRvk9g=; b=lTNcBmcE5h/wd/9VhVSAKNDE01
	0S6wkge7wFdUuNFpGmowwcpD2W92tIWxNOpti4xMlxObDlNUFGBkVFSDwxt55i4o
	EtE3a1Q5f8WJyKGNGL7K7+0glvR9dWzvlPOJaA1FkS17bMQcSg/EZPCZv45AjkKZ
	4B9p7ZmjUubnCGm8mv9jqwLo7A21/PSikaqYJqBGoa9uhL+cYiKaXpxMi5YcCHTC
	fG+xpJtP4J/JhX+Tvq/6dY4Kz+QRFZPstt0F1NOmXiirg8DFkhV8Vylj2Qo80mrp
	76rQOiziejr2M6JeJkEd7eRqMl6NqwkLeNeIEouwDq30dbqvAbGtLzIrA0bQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716877931; x=1716964331; bh=6M7SvIoSC5wS2sG80EEbJpkVHwUJ
	l0BzbhebbmRvk9g=; b=kSw0KpllqZxVjA08K1NrWC+XmMkdtpcrMBQ7xBAMk5kt
	ut2mxQ/qL+CswwnLvu8rXEWg6nH7G+GRwcAO+pSaEhCettslzJxH/hVO2L5G6DKQ
	T4BIBCYsS0pFqci6j0HFTDpvITSmAIUv2zovybR6rW74ElNp0rxbamlpnPV7g1X4
	KAjnP3pu2Whdp2WZcXGYUoy+7MnzyBWXsTMtd/BhGo8QZrxpuLEpVwCBWVsqWoCX
	3UrSTD/3uZFKYfNF1mAqKnRMrDBVQvEh/tJtuRBkD4juSikRVvVpQ7ppnExKenBb
	MSPEySU/5/ptA6va5RXC9Y/w+kzWmclhyheBbLIV9A==
X-ME-Sender: <xms:anpVZnCjCqMN88eoElaqEz_TjJMVEVUMOMziYcxx_tDyk2V3K_P2KQ>
    <xme:anpVZthSlA1dLA50IjyDTiH8smrxLOSoNWZ-K58x1-amBeqIS0KUWSeFHg9o3H5RX
    oQ5k9CHFfRHLy7c6g>
X-ME-Received: <xmr:anpVZimuFbH1PBo2njvQfyZHCKHN3LSgH3r5lZs3fnAVbzUhnIflMiOjUQb7F99O9y2CyOat1qFNi52T6u9tmA4XtWAgP35wx-7RNOObMdXP9P7o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejhedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:anpVZpxpY0EtnnEWqdL3uHWbFfuNg5l44goEFNINrxP8pJot4e3VVA>
    <xmx:anpVZsTjSQix7W0kRTmm1Wq8xWmPHCsAK9csaoLQWZGwyMjQrgFzlQ>
    <xmx:anpVZsaurlsGWTqfmC8kwP5Qi3CQYy8U2fHjEcbiQyWCfZXJhMkvXQ>
    <xmx:anpVZtTfiz9N_bTGsm913KirhLVj08xOLt3fhomzaQrXkVaTwnQ-zQ>
    <xmx:a3pVZhJojX3Abmfn9llobFyup3wyHvPeoeyyb70moLjuKMv1YmibxH49>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 May 2024 02:32:09 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8d54e190 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 May 2024 06:31:58 +0000 (UTC)
Date: Tue, 28 May 2024 08:32:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 12/12] builtin/refs: new command to migrate ref storage
 formats
Message-ID: <d832414d1f8a7c8d9ec3ade13e11dd509c0ab641.1716877224.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1716877224.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="28silu9yzlFdO0gw"
Content-Disposition: inline
In-Reply-To: <cover.1716877224.git.ps@pks.im>


--28silu9yzlFdO0gw
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
index 0000000000..3e9c05185a
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
+	can be used to double check that the migration works as expected before
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
index 0000000000..46dcd150d4
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
+		NULL,
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
2.45.1.246.gb9cfe4845c.dirty


--28silu9yzlFdO0gw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZVemYACgkQVbJhu7ck
PpSS6g//ZzkxwwSM27l3mg+dJs26ZFSWw9C26Fa78uY6MQsUHey1cUw1EJ+3OsP0
YcZ/bFOxL/SBYB8hDX6V+2abzdt9pL+FhJlcy+j/EbUHQj1WXmF7AkFg49iEEqPS
FvyQVgRscSGtIGXifNztSbswBYU//Og0eM8Jt6lcTIF1bVmNIZd83pTXjQ7UMBGs
xiKaCQZFMOmcuWPQfKDA80yi8VoYxFnkcM8L86PFNo5jWk00MtDgmW2YhXSO4bpY
sYZqYo9MeR6Y+6sj+pKo6TjYcM3j1eCObqqKm1KvjB2brdfHcwKm8rJDPFOMefle
VD6x69agvkGj/EO6KoZoYco6Ex1aHY7oS3+uXejkzhmAukFRYOa1eaBAZFqVfAMI
sdK+nKVmsGYJKeKyjlPUgE+L5Wsah6Skb4WlZrGpaAhbJUmZHAsdNRAaX9lzOtlB
4tY1ttF03ysl35HsxetSr6n7ZdKXY65SyxrjOSHp+aIA7mucoC17aYXTjE/sqsnE
Ny91pG+1WNz1UPEbiAI+vhE6fvBVfnGB9byIVh05ARMlx0q5XNoK7CVZ/2gNpPli
5CJvBZ7T/t4M8yYV69lRCEUMlkfkMmv9MS8S9mm0EDnwkTdvRG0QOix4V/3VFMo6
topNpvV9UKIcJ/I5D//Plth50YtYL46ox6XbaK0L35xPsk15I1M=
=pGws
-----END PGP SIGNATURE-----

--28silu9yzlFdO0gw--
