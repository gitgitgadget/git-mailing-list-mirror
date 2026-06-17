Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3459F3546CC
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 10:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781691377; cv=none; b=cmzTK0L3KRfx8Dp8s6NPbEVeJDUw92luevMKPwN/Ni0pnMJlco+FD4I7LVK5YOO6h/KS1Cne5og/9kqSjMJxlGYTlsHjL0ehaFvwlGsEvfLwE97K6djCc9WYTypcCnsL3D7KllBtY4E9FrQsWiQ+1A85Y7h/OK9iUz4UdoHYd00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781691377; c=relaxed/simple;
	bh=r1awzMW717cfBFNnN8vZMI/ou6Nac1Z9/3LHHEqe2uA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=ARDiG0qgm6XgDbvOKNwPzUT+0KRQXpY3FyyhXim/Yl8i6l4jtRl1o5gGtWQ/1Ww9ccZudX7u5k5GI88NN5glarL3nsKMjkGBlwabrPerJ63qFvx1G/42LhfPpK06nJjdynkSSbPySM1Hnqa+9xysE42QzzZGSG6MmMX5xVGmwOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HMb4WY5r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bcOrhrYF; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HMb4WY5r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bcOrhrYF"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 886741D000B5;
	Wed, 17 Jun 2026 06:16:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 17 Jun 2026 06:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781691374;
	 x=1781777774; bh=i0EtEJ5iAh/+Gk3alK80lllIAOQbml2QwS7jkVJscfA=; b=
	HMb4WY5r2W/t597fyR0xNh3VsL3A99808x8T8TP5BunE45/WNm3jEMVLEbiyBXyy
	JnZb/Qh0CxrRsth9HQc4cSv9MxvTHQaO/D6rf/tVpGkXLxerBFFWXHcDvOT2AqSi
	Gk+DUa+KusbulI7vOy7GTD4VNI2yT9NbnFJiNxjakYNopWQdanJLFbc7MLus92/c
	eUlXLJBac7Rd+LTySkPtFeO7RZkL2MT50kSC+psyFylc+yVs1w5807xfmpuQAta2
	KGpRM8FaY+Dmu8UxFVGj7MPAEF12B02vD3Ag5/WF4UXp79pVtRdMY+PMMI/X+DLu
	x+evqUKJIRpSttWt4ksbFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781691374; x=
	1781777774; bh=i0EtEJ5iAh/+Gk3alK80lllIAOQbml2QwS7jkVJscfA=; b=b
	cOrhrYFPcFY7IbL5bft2SWdFV4A7oOdE4mhZ/nYI1C82ZBlrEOAAbffVObZ45USf
	ZM2FQ4oQBXde/1utif9axBVtVVDudrv3TTX0dboXyevLe/cvrGFCbzjaX3Dqr3Jg
	PdNDfjr3BM1zFCUkGeBMa6Phh49dQywItJOBov8NXFUPqeOIiwNlI1CoGqQCbuXX
	IzUwGAWOoHvjuUW3FnmrHql4Mzrnbi7zMhZimOsNdcnwfIjpPBXmHccpnwyOqP0N
	knDpn5iAqOYzJ9a1SvM6YHYZqWllXPPY7aAwmjfTMQtT2QOlhAsmeOK4D6XRM0Cq
	eb0qy2ddK+MZn8ljqtR3A==
X-ME-Sender: <xms:7XMyareK8SbT9yW_Eq4nB-Ud0n-jtKrKSQk6mNRefWQyCFUnUP9OQw>
    <xme:7XMyanMZwAJLlSPJsI9YeUA5ACCrqbqENwrgqNK0ughuUurAmu5LBc6-x6FrJdbdm
    n0mgFk1pkdWMu_e68FdGDlfVm3TA_Nk-h1V8t0FsvXoxAKQU29DEg>
X-ME-Received: <xmr:7XMyaiIe9SaTmgQQiYwk50_-PcrEov7CsrRCjnfsxCZnUzKvifO9FnHi9SvDcNHu3eDqpq2KbzeyBO19zZ_n0qo-ufT3QrjJ_RcPg-s>
X-ME-Proxy-Cause: dmFkZTGgX990GssBn8/U+WsMvO91K7PfXaCCKoZYt0Jn70Nc8N7BptrezYeA/meHjKkanS
    b9NE8iF4ULuuOU1g0L3xtmCLEaAyvZfbMXGHwk6RqXBZQVbeOMs5BYyF/NSPJxOs7FVVn4
    AAunUA53/unywpKTbhJIBvdQm+BodLJHzcqMp+jKtP9EYcqSFkPHzl/Mm++TGXt/BmxYtw
    DgOmyru7xXqBqWhcS3VOHK9+fhsNd22BmRQy8sAEJqk7iKnvPh/InSSJTBaLrfXeabU8g7
    kKn/ST884AM21NwfM7lxy0hZjWiS7SHp8zU6FhKUmwTytbe6IqPaLBTe/hbHG471Me2JY4
    Q4iUIzYMc3pL/Tegs7NQOgs72GAJjnnl1dPek63sqX3shAs65hwhhePDC/IOSQRw40z5pa
    LfYADWKRYgg0eVAQEn9t5hX+QwBTSO1fpSnrMnvpnlm2f76yuEP1ge4JhwJxSUJDzasDWS
    aIn8fsfThTO8uHHXbiQ2Ky3BN6fRNXaQgAJAMEZNjIzs1atZ3JtbTTDvtScDe370EqfqrV
    eQvJwgD2nXFnGdI2/37MHSjn8Fj80DvW4YClTPYKTxuZlIArsFL/U/t7qCtv05MYvUaRLV
    9urkn6xNhsLzmpRVe5E40F7e/rt/wR3imkXByJ9dksiU8fWkyz4xPePhRrzw
X-ME-Proxy: <xmx:7XMyaoGpojpf_FJ8e3KpdTHtdF3w_8DB01rLD8gotRbM_A9OQ74tVA>
    <xmx:7XMyaqSPPiYclvJdJLzY98sbocpIc5FxEMaQnhdiYrpowvaxoI169Q>
    <xmx:7XMyakFseL4RH4aGKyOsjb6NJzKRbyH4PWRSTvUYkBhJHJ6IKsv8XQ>
    <xmx:7XMyam8wCVD5fHp_2ZMbIlFIt_PvI36-XvTJybhyN9u2s4lRNBXnOA>
    <xmx:7nMyam1ATfaIhrvUaBQOu__ZNSsyPP5c_D0yC9whrmwuPLSLjn5L9Q_F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 06:16:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bfd258c0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jun 2026 10:16:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/5] builtin/refs: add ability to write references
Date: Wed, 17 Jun 2026 12:15:57 +0200
Message-Id: <20260617-pks-refs-writing-subcommands-v2-0-07f3d18336f9@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN1zMmoC/42NQQ6CMBAAv0L27Jq2CSX15D8Mh5YWWA2FdBE1h
 L9b8AMeJ5nMrMAhUWC4FCuksBDTGDOoUwFNb2MXkHxmUEJpoaXG6cGYQsv4SjRT7JCfrhmHwUb
 PWNmqcqF03hoHOTFlk95H/lb/OOv30Mx7czd64nlMn+O/yN37c7VIFGjaUknjtBTGX7N+pgHqb
 du+s4uENdcAAAA=
X-Change-ID: 20260616-pks-refs-writing-subcommands-7a77be5bda9b
In-Reply-To: <20260616-pks-refs-writing-subcommands-v1-0-9f5219b6109d@pks.im>
References: <20260616-pks-refs-writing-subcommands-v1-0-9f5219b6109d@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Hi,

Reference-related functionality in Git is currently spread across many
different commands: git-update-ref(1), git-for-each-ref(1),
git-show-ref(1), git-pack-refs(1) and git-symbolic-ref(1). This makes it
hard for users to discover what functionality we have available to work
with references.

We have thus started to consolidate this functionality into git-refs(1),
which is a toolbox of everything related to references. Until now, the
command doesn't handle functionality of git-update-ref(1).

This patch series backfills most of the functionality by introducing
three new commands:

  - `git refs delete` to delete references. This is the equivalent of
    `git update-ref -d`.

  - `git refs update` to update references. This is the equivalent of
    `git update-ref <refname> <oldvalue> <newvalue>`.

  - `git refs rename` to rename a reference, including its reflog. This
    does not have an equivalent in git-update-ref(1), but is inspired by
    and supersedes [1].

Changes in v2:
  - Add a new "create" subcommand.
  - Consistently quote in error messages.
  - Consistently use `<old-value>` in the synopsis.
  - Don't return negative exit codes.
  - Improve documentation of "update" subcommand to mention that you can
    create and delete branches.
  - Add tests to verify that we can use "update" to do this, both in
    racy and raceless ways.
  - Add missing calls to `repo_config()`.
  - Drop useless `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME` variable.
  - Link to v1: https://patch.msgid.link/20260616-pks-refs-writing-subcommands-v1-0-9f5219b6109d@pks.im

Thanks!

Patrick

[1]: <xmqqv7brz9ba.fsf@gitster.g>

---
Patrick Steinhardt (5):
      builtin/refs: drop `the_repository`
      builtin/refs: add "delete" subcommand
      builtin/refs: add "update" subcommand
      builtin/refs: add "create" subcommand
      builtin/refs: add "rename" subcommand

 Documentation/git-refs.adoc |  40 +++++++
 builtin/refs.c              | 222 ++++++++++++++++++++++++++++++++++--
 t/meson.build               |   4 +
 t/t1464-refs-delete.sh      | 130 +++++++++++++++++++++
 t/t1465-refs-update.sh      | 268 ++++++++++++++++++++++++++++++++++++++++++++
 t/t1466-refs-create.sh      | 151 +++++++++++++++++++++++++
 t/t1467-refs-rename.sh      | 131 ++++++++++++++++++++++
 7 files changed, 938 insertions(+), 8 deletions(-)

Range-diff versus v1:

1:  cfbc247e81 = 1:  6d0c5bd06f builtin/refs: drop `the_repository`
2:  f5f33e5c5b ! 2:  db55d87116 builtin/refs: add "delete" subcommand
    @@ Documentation/git-refs.adoc: git refs list [--count=<count>] [--shell|--perl|--p
      		   [ --stdin | (<pattern>...)]
      git refs exists <ref>
      git refs optimize [--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]
    -+git refs delete [--message=<reason>] [--no-deref] <ref> [<oldvalue>]
    ++git refs delete [--message=<reason>] [--no-deref] <ref> [<old-value>]
      
      DESCRIPTION
      -----------
    @@ Documentation/git-refs.adoc: optimize::
      
     +delete::
     +	Delete the given reference. This subcommand mirrors `git update-ref -d`
    -+	(see linkgit:git-update-ref[1]). When `<oldvalue>` is given, the
    ++	(see linkgit:git-update-ref[1]). When `<old-value>` is given, the
     +	reference is only deleted after verifying that it currently contains
    -+	`<oldvalue>`.
    ++	`<old-value>`.
     +
      OPTIONS
      -------
    @@ builtin/refs.c
      	N_("git refs optimize " PACK_REFS_OPTS)
      
     +#define REFS_DELETE_USAGE \
    -+	N_("git refs delete [--message=<reason>] [--no-deref] <ref> [<oldvalue>]")
    ++	N_("git refs delete [--message=<reason>] [--no-deref] <ref> [<old-value>]")
     +
      static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
      			    struct repository *repo)
    @@ builtin/refs.c: static int cmd_refs_optimize(int argc, const char **argv, const
     +	};
     +	struct object_id oldoid;
     +	const char *refname;
    ++	int ret;
     +
     +	argc = parse_options(argc, argv, prefix, opts, refs_delete_usage, 0);
     +	if (argc < 1 || argc > 2)
    @@ builtin/refs.c: static int cmd_refs_optimize(int argc, const char **argv, const
     +		if (repo_get_oid_with_flags(repo, argv[1], &oldoid, GET_OID_SKIP_AMBIGUITY_CHECK))
     +			die(_("invalid old object ID: '%s'"), argv[1]);
     +		if (is_null_oid(&oldoid))
    -+			die(_("cannot delete object with null old object ID"));
    ++			die(_("cannot delete reference with null old object ID"));
     +	}
     +
    -+	return refs_delete_ref(get_main_ref_store(repo), message, refname,
    -+			       argc == 2 ? &oldoid : NULL, flags);
    ++	ret = refs_delete_ref(get_main_ref_store(repo), message, refname,
    ++			      argc == 2 ? &oldoid : NULL, flags);
    ++
    ++	if (ret < 0)
    ++		ret = 1;
    ++	return ret;
     +}
     +
      int cmd_refs(int argc,
    @@ t/t1464-refs-delete.sh (new)
     +
     +test_description='git refs delete'
     +
    -+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    -+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    -+
     +. ./test-lib.sh
     +
     +setup_repo () {
3:  1fc1bed619 ! 3:  85f07a2cb0 builtin/refs: add "update" subcommand
    @@ Documentation/git-refs.adoc
     @@ Documentation/git-refs.adoc: git refs list [--count=<count>] [--shell|--perl|--python|--tcl]
      git refs exists <ref>
      git refs optimize [--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]
    - git refs delete [--message=<reason>] [--no-deref] <ref> [<oldvalue>]
    + git refs delete [--message=<reason>] [--no-deref] <ref> [<old-value>]
     +git refs update [--message=<reason>] [--no-deref] [--create-reflog] <ref> <new-value> [<old-value>]
      
      DESCRIPTION
      -----------
     @@ Documentation/git-refs.adoc: delete::
      	reference is only deleted after verifying that it currently contains
    - 	`<oldvalue>`.
    + 	`<old-value>`.
      
     +update::
    -+	Update the given reference to point at `<new-value>`. This subcommand
    -+	mirrors `git update-ref` (see linkgit:git-update-ref[1]). When
    -+	`<old-value>` is given, the reference is only updated after verifying
    -+	that it currently contains `<old-value>`.
    ++	Update the given reference to point at `<new-value>`. If `<old-value>`
    ++	is given, the reference is only updated after verifying that it
    ++	currently contains `<old-value>`. As a special case, an all-zeroes
    ++	`<new-value>` deletes the branch, whereas an all-zeroes `<old-value>`
    ++	ensures that the branch does not yet exist.
     +
      OPTIONS
      -------
      
    +@@ Documentation/git-refs.adoc: include::pack-refs-options.adoc[]
    + 
    + The following options are specific to commands which write references:
    + 
    ++`--create-reflog`::
    ++	Create a reflog for the reference even if one would not ordinarily be
    ++	created.
    ++
    + `--message=<reason>`::
    + 	Use the given <reason> string for the reflog entry associated with the
    + 	update. An empty message is rejected.
     
      ## builtin/refs.c ##
     @@
      #define REFS_DELETE_USAGE \
    - 	N_("git refs delete [--message=<reason>] [--no-deref] <ref> [<oldvalue>]")
    + 	N_("git refs delete [--message=<reason>] [--no-deref] <ref> [<old-value>]")
      
     +#define REFS_UPDATE_USAGE \
     +	N_("git refs update [--message=<reason>] [--no-deref] [--create-reflog] <ref> <new-value> [<old-value>]")
    @@ builtin/refs.c
      			    struct repository *repo)
      {
     @@ builtin/refs.c: static int cmd_refs_delete(int argc, const char **argv, const char *prefix,
    - 			       argc == 2 ? &oldoid : NULL, flags);
    + 	return ret;
      }
      
     +static int cmd_refs_update(int argc, const char **argv, const char *prefix,
    @@ builtin/refs.c: static int cmd_refs_delete(int argc, const char **argv, const ch
     +	};
     +	struct object_id newoid, oldoid;
     +	const char *refname;
    ++	int ret;
     +
     +	argc = parse_options(argc, argv, prefix, opts, refs_update_usage, 0);
     +	if (argc < 2 || argc > 3)
    @@ builtin/refs.c: static int cmd_refs_delete(int argc, const char **argv, const ch
     +	refname = argv[0];
     +	if (repo_get_oid_with_flags(repo, argv[1], &newoid,
     +				    GET_OID_SKIP_AMBIGUITY_CHECK))
    -+		die(_("invalid new object ID: %s"), argv[1]);
    ++		die(_("invalid new object ID: '%s'"), argv[1]);
     +	if (argc == 3 &&
     +	    repo_get_oid_with_flags(repo, argv[2], &oldoid,
     +				    GET_OID_SKIP_AMBIGUITY_CHECK))
    -+		die(_("invalid old object ID: %s"), argv[2]);
    ++		die(_("invalid old object ID: '%s'"), argv[2]);
     +
    -+	return refs_update_ref(get_main_ref_store(repo), message, refname,
    -+			       &newoid, argc == 3 ? &oldoid : NULL, flags,
    -+			       UPDATE_REFS_DIE_ON_ERR);
    ++	ret = refs_update_ref(get_main_ref_store(repo), message, refname,
    ++			      &newoid, argc == 3 ? &oldoid : NULL, flags,
    ++			      UPDATE_REFS_MSG_ON_ERR);
    ++
    ++	if (ret < 0)
    ++		ret = 1;
    ++	return ret;
     +}
     +
      int cmd_refs(int argc,
    @@ t/t1465-refs-update.sh (new)
     +	)
     +'
     +
    ++test_expect_success 'update can create a new branch with oldvalue' '
    ++	test_when_finished "rm -rf repo" &&
    ++	setup_repo repo &&
    ++	(
    ++		cd repo &&
    ++		A=$(git rev-parse A) &&
    ++		git refs update refs/heads/foo $A $ZERO_OID 2>err &&
    ++		test_ref_matches refs/heads/foo $A
    ++	)
    ++'
    ++
    ++test_expect_success 'update can create a new branch without oldvalue' '
    ++	test_when_finished "rm -rf repo" &&
    ++	setup_repo repo &&
    ++	(
    ++		cd repo &&
    ++		A=$(git rev-parse A) &&
    ++		git refs update refs/heads/foo $A 2>err &&
    ++		test_ref_matches refs/heads/foo $A
    ++	)
    ++'
    ++
    ++test_expect_success 'update refuses to create preexisting branch' '
    ++	test_when_finished "rm -rf repo" &&
    ++	setup_repo repo &&
    ++	(
    ++		cd repo &&
    ++		A=$(git rev-parse A) &&
    ++		B=$(git rev-parse B) &&
    ++		git refs update refs/heads/foo $A &&
    ++		test_must_fail git refs update refs/heads/foo $B $ZERO_OID 2>err &&
    ++		test_grep "reference already exists" err &&
    ++		test_ref_matches refs/heads/foo $A
    ++	)
    ++'
    ++
    ++test_expect_success 'update can delete a branch with oldvalue' '
    ++	test_when_finished "rm -rf repo" &&
    ++	setup_repo repo &&
    ++	(
    ++		cd repo &&
    ++		A=$(git rev-parse A) &&
    ++		git refs update refs/heads/foo $A 2>err &&
    ++		git refs update refs/heads/foo $ZERO_OID $A 2>err &&
    ++		test_must_fail git refs exists refs/heads/foo
    ++	)
    ++'
    ++
    ++test_expect_success 'update can delete a branch without oldvalue' '
    ++	test_when_finished "rm -rf repo" &&
    ++	setup_repo repo &&
    ++	(
    ++		cd repo &&
    ++		A=$(git rev-parse A) &&
    ++		git refs update refs/heads/foo $A 2>err &&
    ++		git refs update refs/heads/foo $ZERO_OID 2>err &&
    ++		test_must_fail git refs exists refs/heads/foo
    ++	)
    ++'
    ++
    ++test_expect_success 'update refuses to delete a branch with mismatching value' '
    ++	test_when_finished "rm -rf repo" &&
    ++	setup_repo repo &&
    ++	(
    ++		cd repo &&
    ++		A=$(git rev-parse A) &&
    ++		B=$(git rev-parse B) &&
    ++		git refs update refs/heads/foo $A 2>err &&
    ++		test_must_fail git refs update refs/heads/foo $ZERO_OID $B 2>err &&
    ++		test_grep " but expected " err &&
    ++		git refs exists refs/heads/foo
    ++	)
    ++'
    ++
    ++test_expect_success 'update refuses to create preexisting branch' '
    ++	test_when_finished "rm -rf repo" &&
    ++	setup_repo repo &&
    ++	(
    ++		cd repo &&
    ++		A=$(git rev-parse A) &&
    ++		B=$(git rev-parse B) &&
    ++		git refs update refs/heads/foo $A &&
    ++		test_must_fail git refs update refs/heads/foo $B $ZERO_OID 2>err &&
    ++		test_grep "reference already exists" err &&
    ++		test_ref_matches refs/heads/foo $A
    ++	)
    ++'
    ++
    ++
     +test_expect_success 'update with invalid new value fails' '
     +	test_when_finished "rm -rf repo" &&
     +	setup_repo repo &&
-:  ---------- > 4:  03036ef730 builtin/refs: add "create" subcommand
4:  aadedb14e1 ! 5:  65f0ee4f03 builtin/refs: add "rename" subcommand
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## Documentation/git-refs.adoc ##
    -@@ Documentation/git-refs.adoc: git refs exists <ref>
    - git refs optimize [--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]
    - git refs delete [--message=<reason>] [--no-deref] <ref> [<oldvalue>]
    +@@ Documentation/git-refs.adoc: git refs optimize [--all] [--no-prune] [--auto] [--include <pattern>] [--exclude
    + git refs create [--message=<reason>] [--no-deref] [--create-reflog] <ref> <new-value>
    + git refs delete [--message=<reason>] [--no-deref] <ref> [<old-value>]
      git refs update [--message=<reason>] [--no-deref] [--create-reflog] <ref> <new-value> [<old-value>]
    -+git refs rename [--message=<reason>] <oldref> <newref>
    ++git refs rename [--message=<reason>] <old-ref> <new-ref>
      
      DESCRIPTION
      -----------
     @@ Documentation/git-refs.adoc: update::
    - 	`<old-value>` is given, the reference is only updated after verifying
    - 	that it currently contains `<old-value>`.
    + 	`<new-value>` deletes the branch, whereas an all-zeroes `<old-value>`
    + 	ensures that the branch does not yet exist.
      
     +rename::
     +	Rename the reference `<oldref>` to `<newref>`. The old reference must
    @@ Documentation/git-refs.adoc: update::
      OPTIONS
      -------
      
    -@@ Documentation/git-refs.adoc: include::pack-refs-options.adoc[]
    - 
    - The following options are specific to commands which write references:
    - 
    -+`--create-reflog`::
    -+	Create a reflog for the reference even if one would not ordinarily be
    -+	created.
    -+
    - `--message=<reason>`::
    - 	Use the given <reason> string for the reflog entry associated with the
    - 	update. An empty message is rejected.
     
      ## builtin/refs.c ##
     @@
    @@ builtin/refs.c
      	N_("git refs update [--message=<reason>] [--no-deref] [--create-reflog] <ref> <new-value> [<old-value>]")
      
     +#define REFS_RENAME_USAGE \
    -+	N_("git refs rename [--message=<reason>] <oldref> <newref>")
    ++	N_("git refs rename [--message=<reason>] <old-ref> <new-ref>")
     +
      static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
      			    struct repository *repo)
      {
     @@ builtin/refs.c: static int cmd_refs_update(int argc, const char **argv, const char *prefix,
    - 			       UPDATE_REFS_DIE_ON_ERR);
    + 	return ret;
      }
      
     +static int cmd_refs_rename(int argc, const char **argv, const char *prefix,
    @@ builtin/refs.c: static int cmd_refs_update(int argc, const char **argv, const ch
     +		OPT_END(),
     +	};
     +	const char *oldref, *newref;
    ++	int ret;
     +
     +	argc = parse_options(argc, argv, prefix, opts, refs_rename_usage, 0);
     +	if (argc != 2)
    @@ builtin/refs.c: static int cmd_refs_update(int argc, const char **argv, const ch
     +	if (message && !*message)
     +		die(_("refusing to perform update with empty message"));
     +
    ++	repo_config(repo, git_default_config, NULL);
    ++
     +	oldref = argv[0];
     +	newref = argv[1];
     +
     +	if (check_refname_format(oldref, 0))
    -+		die(_("invalid ref format: %s"), oldref);
    ++		die(_("invalid ref format: '%s'"), oldref);
     +	if (check_refname_format(newref, 0))
    -+		die(_("invalid ref format: %s"), newref);
    ++		die(_("invalid ref format: '%s'"), newref);
     +
     +	if (!refs_ref_exists(get_main_ref_store(repo), oldref))
     +		die(_("reference does not exist: '%s'"), oldref);
     +	if (refs_ref_exists(get_main_ref_store(repo), newref))
     +		die(_("reference already exists: '%s'"), newref);
     +
    -+	return refs_rename_ref(get_main_ref_store(repo), oldref, newref, message);
    ++	ret = refs_rename_ref(get_main_ref_store(repo), oldref, newref, message);
    ++
    ++	if (ret < 0)
    ++		ret = 1;
    ++	return ret;
     +}
     +
      int cmd_refs(int argc,
      	     const char **argv,
      	     const char *prefix,
     @@ builtin/refs.c: int cmd_refs(int argc,
    - 		REFS_OPTIMIZE_USAGE,
    + 		REFS_CREATE_USAGE,
      		REFS_DELETE_USAGE,
      		REFS_UPDATE_USAGE,
     +		REFS_RENAME_USAGE,
    @@ builtin/refs.c: int cmd_refs(int argc,
      	};
      	parse_opt_subcommand_fn *fn = NULL;
     @@ builtin/refs.c: int cmd_refs(int argc,
    - 		OPT_SUBCOMMAND("optimize", &fn, cmd_refs_optimize),
    + 		OPT_SUBCOMMAND("create", &fn, cmd_refs_create),
      		OPT_SUBCOMMAND("delete", &fn, cmd_refs_delete),
      		OPT_SUBCOMMAND("update", &fn, cmd_refs_update),
     +		OPT_SUBCOMMAND("rename", &fn, cmd_refs_rename),
    @@ builtin/refs.c: int cmd_refs(int argc,
     
      ## t/meson.build ##
     @@ t/meson.build: integration_tests = [
    -   't1463-refs-optimize.sh',
        't1464-refs-delete.sh',
        't1465-refs-update.sh',
    -+  't1466-refs-rename.sh',
    +   't1466-refs-create.sh',
    ++  't1467-refs-rename.sh',
        't1500-rev-parse.sh',
        't1501-work-tree.sh',
        't1502-rev-parse-parseopt.sh',
     
    - ## t/t1466-refs-rename.sh (new) ##
    + ## t/t1467-refs-rename.sh (new) ##
     @@
     +#!/bin/sh
     +

---
base-commit: 700432b2ba22603a0bcb71475c9c333d17c9b0d1
change-id: 20260616-pks-refs-writing-subcommands-7a77be5bda9b

