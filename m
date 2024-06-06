Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C12138F9C
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 05:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717651797; cv=none; b=Rt/8ABnguq07wc9qNbAmsHQPOl9s5540SdPDHA2RN3vDp3zJbuLJUdnROViZOg4iEhe2J8AA+nAwRRc6qRNbR7oZL1MaIcAlzkFBxCFWJxZAlJVRuyxNUOw6CZwnlYFe9Qy11Zqbnz4Fjdxk8tD1obVfgQFg+zaohlS49pb3lbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717651797; c=relaxed/simple;
	bh=Ls33Nz1zgdq9zLOU6DLSCaa2hPQ6tcjWvTownYXN0Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAWAEN+mkUI2lat3DvFZ+slz/tQX3Fl5JTwrv8IWs5FP6bJTT+laPkGSGH5lzkKLWOj09nEDvAerzaw3IHhPEEcF69E6VRgOWvTjNuSmdRr4zlPCy5v3b21JASrExCRXfz/fSgcRZoYi82EbZFE6XVeEtsJVDwja759ksM8aLRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NZf6+Fwb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JeHdBhqg; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NZf6+Fwb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JeHdBhqg"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 0FE78180019C;
	Thu,  6 Jun 2024 01:29:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 06 Jun 2024 01:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717651793; x=1717738193; bh=T0Ujyg11Cq
	5UxLnkwmBGwMis6T8o8hBnXP+4hoGT3E8=; b=NZf6+Fwb88qWHFcLMZxpcqO5sf
	mabV0JPbpug3cY68IoEYu4/Kmd+GNFrtdVitWf4V6AuVUswX3+Yjmh07qtdGiIQH
	OQo0r3OMFSKXdDpC3DCwrrvXXL719arwp8ITL29NNrhNt8MIEpomL5+uPE+5gaGd
	yA1aUbRCxpKW50cNYcfjRaIP84/Xx721PFrI+jCFkpU52SHy8kM78hWIN4ZwSk9e
	NVMsCk6Z/K8vdgkZHOjkS+oKKqC9VmuqPN6dN5XrM5/UkwsYGLlx1YzWg+KRQJKM
	0fNdrO1TucP4I70IMw9IF/Fqvao3WwYLVs5MR3hm9pZwtispDHkK0nRRKAMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717651793; x=1717738193; bh=T0Ujyg11Cq5UxLnkwmBGwMis6T8o
	8hBnXP+4hoGT3E8=; b=JeHdBhqgKDgEGcpv582DYuqauomqZPPur/m4ngO7Vhfl
	bv3AUMS64Z92x+FVu2AlegLI5BnfEoGdKY2O57rT6oyiWWOcPhWd21/w6LJ02d1t
	1NRIJETrWYpMFt+dXdln0mrjiH9jbZxa+m0GsWNbMc+6djMHTyKQkp1dg9p2XezF
	gUtR4dp9igb9qXLDItIia2A7O2sYtzuf2L263PXkp8odr1//rGDbvtG3Xe7OvMAw
	v4TzuXK9AESYRrVWETBH3PfSgdy1nNdfSF4f4a8IiAacr9iaE/NbGhAbHMJBzt/T
	3UaZrE9VgV0HHMZKz4DgJtCSJcc/k8Wf8WLMSD37Bg==
X-ME-Sender: <xms:UUlhZj7bCgqqAAln9rHrxG6wjojapJ73ugmD_X4FmwQPW4VAukR2AA>
    <xme:UUlhZo4ptzDskywPm-1vWT3gYkG4l56Jqe6nMrIrVHiWEbTTPXusnE_kcxys9J0gD
    eDPhmAFJ6JPiD4krw>
X-ME-Received: <xmr:UUlhZqedmrf7GwyPVnMHcRf8WZzARBo6gbqSyd9Esslx4109J80Jx8s6iwafK8S3GFBJ7do96ctiyP6FNUldq74Kh7i8janwUKAFMErwfMjpbGJI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:UUlhZkKWUIME8oBNPFmZT6YLY49dqt0Emdxka1pSawQ7ysXHi5-z2g>
    <xmx:UUlhZnIKa02fnnRRuANU9v9QRlWoTY725iK8MyyHlSgLmNfgZCl3Iw>
    <xmx:UUlhZtx69B9nNt6C-y6kaz3kd4fBtt64ZmjnN6d-_W1TZX0Y3UFzJw>
    <xmx:UUlhZjKJ577sx-Voj_5xgNkfydbFCPvXUcIwUM9jUoAxe8woTi22Rw>
    <xmx:UUlhZkozltMn_fKZIrkBqeVy8BYPNw5OoXGi9edr1k4VKMqyOZnha-A9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 01:29:52 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9501e0a7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 05:29:21 +0000 (UTC)
Date: Thu, 6 Jun 2024 07:29:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 12/12] builtin/refs: new command to migrate ref storage
 formats
Message-ID: <ec0c6d3cf193307440da6909dfcda391ef54ec9d.1717649803.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1717649802.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MUOAB4XrN+u/pO2Z"
Content-Disposition: inline
In-Reply-To: <cover.1717649802.git.ps@pks.im>


--MUOAB4XrN+u/pO2Z
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
 Documentation/git-refs.txt |  61 ++++++++++
 Makefile                   |   1 +
 builtin.h                  |   1 +
 builtin/refs.c             |  75 ++++++++++++
 command-list.txt           |   1 +
 git.c                      |   1 +
 t/t1460-refs-migrate.sh    | 243 +++++++++++++++++++++++++++++++++++++
 8 files changed, 384 insertions(+)
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
index 0000000000..5b99e04385
--- /dev/null
+++ b/Documentation/git-refs.txt
@@ -0,0 +1,61 @@
+git-refs(1)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+NAME
+----
+git-refs - Low-level access to refs
+
+
+SYNOPSIS
+--------
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
diff --git a/command-list.txt b/command-list.txt
index c4cd0f352b..e0bb87b3b5 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -157,6 +157,7 @@ git-read-tree                           plumbingmanipul=
ators
 git-rebase                              mainporcelain           history
 git-receive-pack                        synchelpers
 git-reflog                              ancillarymanipulators           co=
mplete
+git-refs                                ancillarymanipulators           co=
mplete
 git-remote                              ancillarymanipulators           co=
mplete
 git-repack                              ancillarymanipulators           co=
mplete
 git-replace                             ancillarymanipulators           co=
mplete
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
2.45.2.409.g7b0defb391.dirty


--MUOAB4XrN+u/pO2Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhSUwACgkQVbJhu7ck
PpR6oQ//e1LE//xshocVvJC+MokjhFRjLBTLdxRQU22y2lzjDx0rCWk99bhGXbSj
dr/J/fo7Pyq2H+01qWBwuqDVFzKQAhJ1Oqs7GECdWk1F8G5jR5jaYTOJ8C2oOaO3
QetXSodUt3OgwM5cUZ5/6fBOBthUOU+y/e5jEiCWVOOrzrSD5qrrLFGBJkkgzk7T
W1++0HXcGHQCVt8NyPPkrgAP4EhXTtbJdeuA/j5uGMqsDV6Sj/QXvCNlF79BCttC
WqoC+mzdUsSo255BuXMEQ7HT48jBoJSXxp6YARTAIoGuDjcMg9iJ2RWQjJPmlFq3
w7CCP9nqoks0CQR3rwmTnDNBHqbZBBuy/JOd4PJo8SKTLbXytPLiuAPICOd37BVy
p9vo3y0EauM5ywaadg9a3b8Omiw+tcpsJEjr6kY040LDODzAUkq0+H7vedc4gKcJ
8VuMtNvbovBln06mfwbmD+GcxHrB+RSs9ULXMaZkSe3LTRebKWFt0wSofi6BwGjY
AG12EN3UsSlK4pR8TKhcpKa+49VPZmVxExuRxW1EWT+mpjvjM/LqcyR+FyRYSZUr
0Ljenh3EKhXcRO6wlXipZLa8JcC7rBERTa7OMl0BGuQaNbklZyttUUSYo6b+I2K1
uOr6OlUrU9kVQ+idQgu3uJPErNVSiJnZAwEI6qK/gitXvJbx59w=
=cSwu
-----END PGP SIGNATURE-----

--MUOAB4XrN+u/pO2Z--
