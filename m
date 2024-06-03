Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B542231F
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407073; cv=none; b=c5PuWAjM7k+TMyMn4sev6lWtvDoLZ+Wk4fhL1vHmJ5vg7SrKkAaWGYIBqPzpgx9Ua1cMRlYWRz7ySyZRETZoesxAOzrouNBfsWyJGhSrg0u83ZeGE4fTqm3xXzNj0lcVydudeCJ0qG8koII0yelfe2Z9ExxzsaT8jxO8lrueQrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407073; c=relaxed/simple;
	bh=0F//TsEt988JICUmQBRR+08lPkdDy302UkLIPmgiwl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ok1ajFyYY2GQNyn1ukSgfw5dhs4BfDW3zgdkrXK1FbX+6BmRwiv8R1BdhjjAHAVncWT6spZz6BQaL5LQ4pZtMxSCUhlvS+NR29vUNjONMg3OCYjmlXJtUFD8XVc5htiCrUrgJzoWT/8raeWqkthAWeniYXXAruVrUXGPZtGNlPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GUafex2V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qy+rzqKz; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GUafex2V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qy+rzqKz"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 4673218000EB;
	Mon,  3 Jun 2024 05:31:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 03 Jun 2024 05:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407069; x=1717493469; bh=/Hx+QuqG9u
	A0FomJYJTZBDM4a1ESGBtTnZSumv5EY0Q=; b=GUafex2VwoPgfDxxo04payuxrN
	8zcncYEw5vkd4HzAqJ+JH6OkovmApzVLycP3NwltG0s2+fvln78EQ3iySDd7N5OE
	Nx8AWisdEZtEkV/SZKwf97Yh/FnxXLETsgA7k9RIb/cvnl9Dc1Ce6rC8og+t+Q4y
	VoyIYTzvVJFuPAOANDCKsDaWqsZRrQ2DBmfs8yJc73g1cSw/HhuI6XuJ5GgNc8Iy
	5mpHrby7UX1kt7s6EPc0PXY7V/Xs7wHqJa3BCWFJsyvRqRSAPxiM0XTdkTsWZoSq
	HuCdr6mD3FiVjz7Y40RamTWaCbZfCnd3/W4B9H4JcEw5TnRtjUFxlF2DeADg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407069; x=1717493469; bh=/Hx+QuqG9uA0FomJYJTZBDM4a1ES
	GBtTnZSumv5EY0Q=; b=Qy+rzqKzt0fZNQzQvfVHyHEF/9huYi9XzFx3bvSi5QVK
	7UGLZC9uWWDAWDS+tK88aL4iSeo9TDfU53VuOA474Ob08UtRK/74Ofn/GqdzD/lE
	zkWqj72mVuTOLdfV6yYfcyx3bWkNTpI5NJghox+ZPGtpoEHxd9MuoTjVnRgRTTqC
	9I6o81bejpWuKxMF41oPXrnonCVx3oVOCsR8wn7WJuiM66OHqCGjfgD6qo8zeG3Q
	lccmqpvYhglrDiQBhqX9SWGrAgQZ6M2Xr/tLZyTTrVsJ9dhc5jIPp2kspDDnpksZ
	RlfjLkzRO2/GWLCEgDXyE4sL7xPwuqENWY48kGX6UA==
X-ME-Sender: <xms:XY1dZnk1_AtC7RY2T-bJ0Aag8TVmMi7YswfaJe0xxakbY8GSMcZwLg>
    <xme:XY1dZq2W7zNGmOOkuVF9Aa9Vf4xX8prcHSd8rOX9R2afc7HsJRQG-U0Qd1ifdDHh_
    DxqjpIwvC0rQhA8Mg>
X-ME-Received: <xmr:XY1dZtrtPkMHnpyx0gA4i-Zx4suyJqUnmj3td5qlhwvjq3MjgfVI_1LryqKqFCMUCklnOCz4nl2eZLHyTM1fS8Y_E510xYirGM_Zry8dTDZJsMJi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:XY1dZvmNWMGhbIQs5ttrTgR7nnS_KJUdoJix9kd71fThNlacBX_E1Q>
    <xmx:XY1dZl3tEe5RHYah0C4of7oQmCIHD74MbV2_I5IAFXq_Ol_jmjQwdw>
    <xmx:XY1dZus6hnFsrWwK1lmji6pTKwCvS3YlsdVZvgmL51DuMm4bRBXCRg>
    <xmx:XY1dZpXJV3zpZbEuWJ_oHQFCy2uh1Ys3MZp38nGEITKIrkGDSt2dBA>
    <xmx:XY1dZt_tXHW9zsjFslyxH6rJ_90fLF3iw9NCNwID2G27mD0O_BZkHOXB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:31:08 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d86f6d9a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:30:44 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:31:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 12/12] builtin/refs: new command to migrate ref storage
 formats
Message-ID: <83cb3f8c96508e8584041e636a40ccb3d745a8eb.1717402363.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1717402363.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qVLZeID4wdeq5vDF"
Content-Disposition: inline
In-Reply-To: <cover.1717402363.git.ps@pks.im>


--qVLZeID4wdeq5vDF
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
2.45.1.410.g58bac47f8e.dirty


--qVLZeID4wdeq5vDF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdjVkACgkQVbJhu7ck
PpQ6ew/9HlD/E358l2ajKo95eaQZtyYqvDVCzW6Ib8/ycME+Has+JNHd07Kvc0Q2
ix5lEXh93F7R6ww3wmSJnIeEkDQXmPm/BWAj+Lnjm7OARTUh4lWQoir7ctHN49YK
oNR1A/Mo2WhNlBcKXwTKmX204KyBaP9OOns6xaFBuU1qEY9YHm7yTgcs6YJDOm/h
eRnRBw4SuC/B7/7+zm3oeb1v0NmbYI+4d/MSDla1N2RP9Snb5u+JCWt9HPmtiQCJ
boDKVwiOwSOGc04hidM8UwktUi6r1gUNSloX1IGmjAnABZwm105hTKxUvftKVGzs
43KrqHHd072S528AS84NF/CZY94nhdPyJ9XrhouHawjKssFK9cb7ia81V8B6+kLB
9pcfcIGugGVPn75VmTJjpDlpt43Tv7QjS+iHV7BMVQEBdlS8OILyuISLIKLdnrsY
DokYnmeV/h0CclVuVln8ROx31nwjlg1BvFa3qS50/b02Dhtu/0LRwThQWK2CCcqw
vyRLmE6VsyurOcziUQ+dc6izTn7RfLI41kJRA9gj3YQab7lqFyxWubVurm/SplCf
0maC/uEHkUHvXzsgdjiSEQI9TBqbIfpDqDCsiimZ20jy94QNtxhgQ4deIOKklCnt
g3VsTtCwK5uPb9T82lcvzndZInLt8wTTTy/otUmStqjnm3P1wPA=
=gegM
-----END PGP SIGNATURE-----

--qVLZeID4wdeq5vDF--
