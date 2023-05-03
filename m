Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04469C77B75
	for <git@archiver.kernel.org>; Wed,  3 May 2023 11:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjECLeY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 07:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjECLeW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 07:34:22 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA15268B
        for <git@vger.kernel.org>; Wed,  3 May 2023 04:34:20 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 7FDAA5C0151;
        Wed,  3 May 2023 07:34:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 03 May 2023 07:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683113659; x=1683200059; bh=c5
        RxgNJ2qY5UIBQnvMca4/hpID1nYhzPyVgPPB/Sec4=; b=RSoBUdnMe6acge80Ey
        MwbEI3oN9UGT9fHO7lKn0DPzd/+Nu/lOJyy+qaL7dxX3CLf6rXHfH5A/Cxliwr+p
        pxXPdyA5uagKWhd9BkeNWrkIlnf6Df/cC8TGeP8F4FyMrxusdB1nLfL/T53lUaNz
        wzhIvNLW/AnUYXbQGqOBfkz69mklT/9kmc876m1CSTxMpDnll32HI3fXpr84NX01
        HWx9Vllnv3wF1pAy9mHp44TeBQHHkVT1VDhAfItBK3lP4/oAdUqUZnDa81RA2Ckv
        wdwMOhHRJOAK0r/MpbwBoS1XT0K3urpakSLmgdDxrcaKKLJXoxOfo6zaqhtw7QXb
        Akng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683113659; x=1683200059; bh=c5RxgNJ2qY5UI
        BQnvMca4/hpID1nYhzPyVgPPB/Sec4=; b=LakahR7xCWUxUCdO/i4WK6cUYOy2y
        K6/UkAUo8s3rL8siikYfo1jAf0PcgmKM6rWoc8re4KMdxKxKrPEZtQfBxda25+KL
        UASVfJOyQ3pyeFxsdQK5EnaWsWgUTncicAwrHzQLMBlgVakBMBQMAuZbZsrR8UZ2
        Y8oDIDEMi6Ogul8nEY7TJQQK5d2MRjOosObukqBB6VAXLbH+vThMi0KpsUL2LYzY
        Pa36t2cqwfgoCeuw61XC1tYl8ecL/VjhQ3WonBUGGVO35hpPmbGaPTgsAxsbeQH9
        vml5SXjMKHzL6zlrs4Fq2++yWRrYtxgOpPiLWL28pMyPK6G6iMwBprkxw==
X-ME-Sender: <xms:u0ZSZF4e65qPN5Y1-TLW5MXuhhHjsL5TtUN7kQKWYiHdM49I6Izi0w>
    <xme:u0ZSZC5-Av4TiwBQV2J1ni_zDqRMl3s1dNS8_WY8fy5CoTbyY3BG09a4QJqbc4w4u
    wlPPdIsjbuKr4pEEw>
X-ME-Received: <xmr:u0ZSZMdlNZJZr1fLDmFQmzM2cBsqH2voJ4TKYgcooP4R2djAwPW-eVzj9Cw1uFqeVNXEKIsTPfJPiXrtHUd2Ox24D-v6GLicJJTAs3kM8AMv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvkedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:u0ZSZOKLhOQC5BPWYdZFkK-MSbiJnbyTHzffLRopp54BwrZvB-nQuw>
    <xmx:u0ZSZJJfuI5_rdCiiN43n_dVrsOmhscQe0EggHGcyeo5abLCHmqTSg>
    <xmx:u0ZSZHx53KFrKGmAo2IEYPSIYKKjd45e6UoUiQ_YIprnxi04gptqvg>
    <xmx:u0ZSZGGadAL8dgY5vcnacS6DOw9eNEDMqh1ZHSVFdwDU0vvN_pvguQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 May 2023 07:34:17 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 876b7842 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 3 May 2023 11:33:34 +0000 (UTC)
Date:   Wed, 3 May 2023 13:34:14 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v3 0/8] fetch: introduce machine-parseable output
Message-ID: <cover.1683113177.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CNK2m/XWgP0M9W3m"
Content-Disposition: inline
In-Reply-To: <cover.1681906948.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--CNK2m/XWgP0M9W3m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the third version of my patch series to introduce a
machine-parseable output for git-fetch(1).

Changes compared to v2:

    - A new commit that fixes `--no-recurse-submodules` not being
      honored for multi-remote fetches was added. This fixes issues that
      would otherwise be hit later in the patch series.

    - Tests were adjusted to explicitly verify stdout and stderr as
      standalone units instead of redirecting 2>&1.

    - Instead of introducing `--output-format` and a new "porcelain"
      format I've changed this to instead introduce `--porcelain`. What
      finally convinced me to go this way is Glen's list of preexisting
      commands that have `--porcelain`. So I decided to not be the only
      outlier here.

    - The DISPLAY_FORMAT_MAX macro was dropped in favor of Junio's
      proposal that uses designated initializers for the array.

    - Similar to `--negotiate-only`, the porcelain output is now
      incompatible with `--recurse-submodules=3D[yes|on-demand]`. This is
      done to avoid ambiguity when references in both the superproject
      and any of its submodules is updated.

Thanks again for all the feedback!

Patrick

Patrick Steinhardt (8):
  fetch: fix `--no-recurse-submodules` with multi-remote fetches
  fetch: split out tests for output format
  fetch: add a test to exercise invalid output formats
  fetch: fix missing from-reference when fetching HEAD:foo
  fetch: introduce `display_format` enum
  fetch: move display format parsing into main function
  fetch: move option related variables into main function
  fetch: introduce machine-parseable "porcelain" output format

 Documentation/fetch-options.txt |   6 +
 Documentation/git-fetch.txt     |   9 +
 builtin/fetch.c                 | 437 +++++++++++++++++++-------------
 t/t5510-fetch.sh                |  53 ----
 t/t5526-fetch-submodules.sh     |  31 +++
 t/t5574-fetch-output.sh         | 231 +++++++++++++++++
 6 files changed, 543 insertions(+), 224 deletions(-)
 create mode 100755 t/t5574-fetch-output.sh

Range-diff against v2:
-:  ---------- > 1:  4b2b0cfe15 fetch: fix `--no-recurse-submodules` with m=
ulti-remote fetches
1:  0d0d50d14c =3D 2:  6ebc7450ba fetch: split out tests for output format
2:  29d2c58914 ! 3:  78479922ac fetch: add a test to exercise invalid outpu=
t formats
    @@ t/t5574-fetch-output.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     +	test_when_finished "rm -rf clone" &&
     +	git clone . clone &&
     +
    -+	test_must_fail git -C clone -c fetch.output=3D fetch origin >actual =
2>&1 &&
    ++	test_must_fail git -C clone -c fetch.output=3D fetch origin >actual.=
out 2>actual.err &&
     +	cat >expect <<-EOF &&
     +	fatal: invalid value for ${SQ}fetch.output${SQ}: ${SQ}${SQ}
     +	EOF
    -+	test_cmp expect actual &&
    ++	test_must_be_empty actual.out &&
    ++	test_cmp expect actual.err &&
     +
    -+	test_must_fail git -C clone -c fetch.output=3Dgarbage fetch origin >=
actual 2>&1 &&
    ++	test_must_fail git -C clone -c fetch.output=3Dgarbage fetch origin >=
actual.out 2>actual.err &&
     +	cat >expect <<-EOF &&
     +	fatal: invalid value for ${SQ}fetch.output${SQ}: ${SQ}garbage${SQ}
     +	EOF
    -+	test_cmp expect actual
    ++	test_must_be_empty actual.out &&
    ++	test_cmp expect actual.err
     +'
     +
      test_expect_success 'fetch aligned output' '
3:  d1fb6eeae7 ! 4:  46e1266ab0 fetch: fix missing from-reference when fetc=
hing HEAD:foo
    @@ t/t5574-fetch-output.sh: test_expect_success 'fetch compact output' '
      	test_cmp expect actual
      '
     =20
    -+test_expect_success 'fetch output with HEAD and --dry-run' '
    ++test_expect_success 'fetch output with HEAD' '
     +	test_when_finished "rm -rf head" &&
     +	git clone . head &&
     +
    -+	git -C head fetch --dry-run origin HEAD >actual 2>&1 &&
    ++	git -C head fetch --dry-run origin HEAD >actual.out 2>actual.err &&
     +	cat >expect <<-EOF &&
     +	From $(test-tool path-utils real_path .)/.
     +	 * branch            HEAD       -> FETCH_HEAD
     +	EOF
    -+	test_cmp expect actual &&
    ++	test_must_be_empty actual.out &&
    ++	test_cmp expect actual.err &&
     +
    -+	git -C head fetch origin HEAD >actual 2>&1 &&
    -+	test_cmp expect actual &&
    ++	git -C head fetch origin HEAD >actual.out 2>actual.err &&
    ++	test_must_be_empty actual.out &&
    ++	test_cmp expect actual.err &&
     +
    -+	git -C head fetch --dry-run origin HEAD:foo >actual 2>&1 &&
    ++	git -C head fetch --dry-run origin HEAD:foo >actual.out 2>actual.err=
 &&
     +	cat >expect <<-EOF &&
     +	From $(test-tool path-utils real_path .)/.
     +	 * [new ref]         HEAD       -> foo
     +	EOF
    -+	test_cmp expect actual &&
    ++	test_must_be_empty actual.out &&
    ++	test_cmp expect actual.err &&
     +
    -+	git -C head fetch origin HEAD:foo >actual 2>&1 &&
    -+	test_cmp expect actual
    ++	git -C head fetch origin HEAD:foo >actual.out 2>actual.err &&
    ++	test_must_be_empty actual.out &&
    ++	test_cmp expect actual.err
     +'
     +
      test_expect_success '--no-show-forced-updates' '
4:  b545bf8bb9 ! 5:  acc0f7f520 fetch: introduce `display_format` enum
    @@ builtin/fetch.c: static void display_state_init(struct display_state=
 *display_st
     +		break;
     +	}
     +	default:
    -+		BUG("unexpected display foramt %d", display_state->format);
    ++		BUG("unexpected display format %d", display_state->format);
      	}
      }
     =20
5:  4990d35998 =3D 6:  cd23440128 fetch: move display format parsing into m=
ain function
6:  cfe84129ab =3D 7:  edbc31013f fetch: move option related variables into=
 main function
7:  0335e5eeb4 < -:  ---------- fetch: introduce new `--output-format` opti=
on
8:  d7c1bc1a80 ! 8:  e132d9494e fetch: introduce machine-parseable "porcela=
in" output format
    @@ Commit message
         information especially in the context of multi-remote fetches. But=
 as
         such a format would require us to print the remote for every single
         reference update due to parallelizable fetches it feels wasteful f=
or the
    -    most likely usecase, which is when fetching from a single remote. =
If
    -    usecases come up for this in the future though it is easy enough t=
o add
    -    a new "porcelain-v2" format that adds this information.
    +    most likely usecase, which is when fetching from a single remote.
    +
    +    In a similar spirit, a second restriction is that this cannot be u=
sed
    +    with `--recurse-submodules`. This is because any reference updates=
 would
    +    be ambiguous without also printing the repository in which the upd=
ate
    +    happens.
    +
    +    Considering that both multi-remote and submodule fetches are rather
    +    niche and likely not going to be useful for the majority of usecas=
es
    +    these omissions feel acceptable. If usecases for either of these c=
ome up
    +    in the future though it is easy enough to add a new "porcelain-v2"
    +    format that adds this information.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    - ## Documentation/config/fetch.txt ##
    -@@ Documentation/config/fetch.txt: fetch.pruneTags::
    -=20
    - fetch.output::
    - 	Control how ref update status is printed. Valid values are
    --	`full` and `compact`. Default value is `full`. See section
    --	OUTPUT in linkgit:git-fetch[1] for detail.
    -+	`full`, `compact` and `porcelain`. Default value is `full`.
    -+	See section OUTPUT in linkgit:git-fetch[1] for detail.
    -=20
    - fetch.negotiationAlgorithm::
    - 	Control how information about the commits in the local repository
    -
      ## Documentation/fetch-options.txt ##
     @@ Documentation/fetch-options.txt: linkgit:git-config[1].
    + --dry-run::
    + 	Show what would be done, without making any changes.
     =20
    - --output-format::
    - 	Control how ref update status is printed. Valid values are
    --	`full` and `compact`. Default value is `full`. See section
    --	OUTPUT in linkgit:git-fetch[1] for detail.
    -+	`full`, `compact` and `porcelain`. Default value is `full`.
    -+	See section OUTPUT in linkgit:git-fetch[1] for detail.
    -=20
    ++--porcelain::
    ++	Print the output to standard output in an easy-to-parse format for
    ++	scripts. See section OUTPUT in linkgit:git-fetch[1] for details.
    +++
    ++This is incompatible with `--recurse-submodules=3D[yes|on-demand]`.
    ++
      ifndef::git-pull[]
      --[no-]write-fetch-head::
    + 	Write the list of remote refs fetched in the `FETCH_HEAD`
    =20
      ## Documentation/git-fetch.txt ##
    -@@ Documentation/git-fetch.txt: The output of "git fetch" depends on t=
he transport method used; this
    - section describes the output when fetching over the Git protocol
    - (either locally or via ssh) and Smart HTTP protocol.
    -=20
    --The status of the fetch is output in tabular form, with each line
    --representing the status of a single ref. Each line is of the form:
    -+The output format can be chosen either via the `fetch.output` config
    -+(see linkgit:git-config[1]), or via the `--output-format` switch.
    -+Supported values include:
    -+
    -+For the `full` and `compact` output formats, the status of the fetch =
is
    -+output in tabular, with each line representing the status of a single
    -+ref. Each line is of the form:
    -=20
    - -------------------------------
    +@@ Documentation/git-fetch.txt: representing the status of a single re=
f. Each line is of the form:
       <flag> <summary> <from> -> <to> [<reason>]
      -------------------------------
     =20
    -+The `porcelain` output format is intended to be machine-parseable. In
    -+contrast to the human-readable output formats it thus prints to stand=
ard
    -+output instead of standard error. Each line is of the form:
    ++When using `--porcelain`, the output format is intended to be
    ++machine-parseable. In contrast to the human-readable output formats it
    ++thus prints to standard output instead of standard error. Each line is
    ++of the form:
     +
     +-------------------------------
     +<flag> <old-object-id> <new-object-id> <local-reference>
    @@ builtin/fetch.c: enum display_format {
      	DISPLAY_FORMAT_FULL,
      	DISPLAY_FORMAT_COMPACT,
     +	DISPLAY_FORMAT_PORCELAIN,
    - 	DISPLAY_FORMAT_MAX,
    - };
    -=20
    -@@ builtin/fetch.c: static const char * const display_formats[DISPLAY_=
FORMAT_MAX] =3D {
    - 	NULL,
    - 	"full",
    - 	"compact",
    -+	"porcelain",
      };
     =20
      struct display_state {
    @@ builtin/fetch.c: static void display_state_init(struct display_state=
 *display_st
     +		/* We don't need to precompute anything here. */
     +		break;
      	default:
    --		BUG("unexpected display foramt %d", display_state->format);
    -+		BUG("unexpected display format %d", display_state->format);
    + 		BUG("unexpected display format %d", display_state->format);
      	}
    - }
    -=20
     @@ builtin/fetch.c: static void print_compact(struct display_state *di=
splay_state,
      static void display_ref_update(struct display_state *display_state, c=
har code,
      			       const char *summary, const char *error,
    @@ builtin/fetch.c: static int prune_refs(struct display_state *display=
_state,
      					   summary_width);
      			warn_dangling_symref(stderr, dangling_msg, ref->name);
      		}
    +@@ builtin/fetch.c: static int add_remote_or_group(const char *name, s=
truct string_list *list)
    + 	return 1;
    + }
    +=20
    +-static void add_options_to_argv(struct strvec *argv)
    ++static void add_options_to_argv(struct strvec *argv,
    ++				enum display_format format)
    + {
    + 	if (dry_run)
    + 		strvec_push(argv, "--dry-run");
    +@@ builtin/fetch.c: static void add_options_to_argv(struct strvec *arg=
v)
    + 		strvec_push(argv, "--ipv6");
    + 	if (!write_fetch_head)
    + 		strvec_push(argv, "--no-write-fetch-head");
    ++	if (format =3D=3D DISPLAY_FORMAT_PORCELAIN)
    ++		strvec_pushf(argv, "--porcelain");
    + }
    +=20
    + /* Fetch multiple remotes in parallel */
    +@@ builtin/fetch.c: struct parallel_fetch_state {
    + 	const char **argv;
    + 	struct string_list *remotes;
    + 	int next, result;
    ++	enum display_format format;
    + };
    +=20
    + static int fetch_next_remote(struct child_process *cp,
    +@@ builtin/fetch.c: static int fetch_next_remote(struct child_process =
*cp,
    + 	strvec_push(&cp->args, remote);
    + 	cp->git_cmd =3D 1;
    +=20
    +-	if (verbosity >=3D 0)
    ++	if (verbosity >=3D 0 && state->format !=3D DISPLAY_FORMAT_PORCELAIN)
    + 		printf(_("Fetching %s\n"), remote);
    +=20
    + 	return 1;
    +@@ builtin/fetch.c: static int fetch_finished(int result, struct strbu=
f *out,
    + 	return 0;
    + }
    +=20
    +-static int fetch_multiple(struct string_list *list, int max_children)
    ++static int fetch_multiple(struct string_list *list, int max_children,
    ++			  enum display_format format)
    + {
    + 	int i, result =3D 0;
    + 	struct strvec argv =3D STRVEC_INIT;
    +@@ builtin/fetch.c: static int fetch_multiple(struct string_list *list=
, int max_children)
    +=20
    + 	strvec_pushl(&argv, "fetch", "--append", "--no-auto-gc",
    + 		     "--no-write-commit-graph", NULL);
    +-	add_options_to_argv(&argv);
    ++	add_options_to_argv(&argv, format);
    +=20
    + 	if (max_children !=3D 1 && list->nr !=3D 1) {
    +-		struct parallel_fetch_state state =3D { argv.v, list, 0, 0 };
    ++		struct parallel_fetch_state state =3D { argv.v, list, 0, 0, format =
};
    + 		const struct run_process_parallel_opts opts =3D {
    + 			.tr2_category =3D "fetch",
    + 			.tr2_label =3D "parallel/fetch",
    +@@ builtin/fetch.c: static int fetch_multiple(struct string_list *list=
, int max_children)
    +=20
    + 			strvec_pushv(&cmd.args, argv.v);
    + 			strvec_push(&cmd.args, name);
    +-			if (verbosity >=3D 0)
    ++			if (verbosity >=3D 0 && format !=3D DISPLAY_FORMAT_PORCELAIN)
    + 				printf(_("Fetching %s\n"), name);
    + 			cmd.git_cmd =3D 1;
    + 			if (run_command(&cmd)) {
    +@@ builtin/fetch.c: static int fetch_one(struct remote *remote, int ar=
gc, const char **argv,
    + 	return exit_code;
    + }
    +=20
    ++static int opt_parse_porcelain(const struct option *opt, const char *=
arg, int unset)
    ++{
    ++	enum display_format *format =3D opt->value;
    ++	*format =3D DISPLAY_FORMAT_PORCELAIN;
    ++	return 0;
    ++}
    ++
    + int cmd_fetch(int argc, const char **argv, const char *prefix)
    + {
    + 	const char *bundle_uri;
    +@@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const c=
har *prefix)
    + 			    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
    + 		OPT_BOOL(0, "dry-run", &dry_run,
    + 			 N_("dry run")),
    ++		OPT_CALLBACK_F(0, "porcelain", &display_format, NULL, N_("machine-r=
eadable output"),
    ++			       PARSE_OPT_NOARG|PARSE_OPT_NONEG, opt_parse_porcelain),
    + 		OPT_BOOL(0, "write-fetch-head", &write_fetch_head,
    + 			 N_("write fetched references to the FETCH_HEAD file")),
    + 		OPT_BOOL('k', "keep", &keep, N_("keep downloaded pack")),
    +@@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const c=
har *prefix)
    + 		fetch_config_from_gitmodules(sfjc, rs);
    + 	}
    +=20
    ++	if (display_format =3D=3D DISPLAY_FORMAT_PORCELAIN) {
    ++		switch (recurse_submodules_cli) {
    ++		case RECURSE_SUBMODULES_OFF:
    ++		case RECURSE_SUBMODULES_DEFAULT:
    ++			/*
    ++			 * Reference updates in submodules would be ambiguous
    ++			 * in porcelain mode, so we reject this combination.
    ++			 */
    ++			recurse_submodules =3D RECURSE_SUBMODULES_OFF;
    ++			break;
    ++
    ++		default:
    ++			die(_("options '%s' and '%s' cannot be used together"),
    ++			    "--porcelain", "--recurse-submodules");
    ++		}
    ++	}
    ++
    + 	if (negotiate_only && !negotiation_tip.nr)
    + 		die(_("--negotiate-only needs one or more --negotiation-tip=3D*"));
    +=20
    +@@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const c=
har *prefix)
    + 			max_children =3D fetch_parallel_config;
    +=20
    + 		/* TODO should this also die if we have a previous partial-clone? */
    +-		result =3D fetch_multiple(&list, max_children);
    ++		result =3D fetch_multiple(&list, max_children, display_format);
    + 	}
    +=20
    +=20
    +@@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const c=
har *prefix)
    + 		if (max_children < 0)
    + 			max_children =3D fetch_parallel_config;
    +=20
    +-		add_options_to_argv(&options);
    ++		add_options_to_argv(&options, display_format);
    + 		result =3D fetch_submodules(the_repository,
    + 					  &options,
    + 					  submodule_prefix,
    =20
      ## t/t5574-fetch-output.sh ##
    -@@ t/t5574-fetch-output.sh: test_expect_success 'fetch compact output =
with multiple remotes' '
    +@@ t/t5574-fetch-output.sh: test_expect_success 'fetch compact output'=
 '
      	test_cmp expect actual
      '
     =20
     +test_expect_success 'fetch porcelain output' '
    -+	test_when_finished "rm -rf porcelain-cfg porcelain-cli" &&
    ++	test_when_finished "rm -rf porcelain" &&
     +
     +	# Set up a bunch of references that we can use to demonstrate differ=
ent
     +	# kinds of flag symbols in the output format.
    @@ t/t5574-fetch-output.sh: test_expect_success 'fetch compact output w=
ith multiple
     +	# namespaces so that we can test that rejected and force-updated
     +	# references are reported properly.
     +	refspecs=3D"refs/heads/*:refs/unforced/* +refs/heads/*:refs/forced/*=
" &&
    -+	git clone . porcelain-cli &&
    -+	git clone . porcelain-cfg &&
    -+	git -C porcelain-cfg fetch origin $refspecs &&
    -+	git -C porcelain-cli fetch origin $refspecs &&
    ++	git clone . porcelain &&
    ++	git -C porcelain fetch origin $refspecs &&
     +
     +	# Now that we have set up the client repositories we can change our
     +	# local references.
    @@ t/t5574-fetch-output.sh: test_expect_success 'fetch compact output w=
ith multiple
     +	# Execute a dry-run fetch first. We do this to assert that the dry-r=
un
     +	# and non-dry-run fetches produces the same output. Execution of the
     +	# fetch is expected to fail as we have a rejected reference update.
    -+	test_must_fail git -C porcelain-cfg -c fetch.output=3Dporcelain fetc=
h --dry-run --prune origin $refspecs >actual-dry-run-cfg &&
    -+	test_must_fail git -C porcelain-cli fetch --output-format=3Dporcelai=
n --dry-run --prune origin $refspecs >actual-dry-run-cli &&
    -+	test_cmp actual-dry-run-cfg actual-dry-run-cli &&
    -+	test_cmp expect actual-dry-run-cfg &&
    ++	test_must_fail git -C porcelain fetch \
    ++		--porcelain --dry-run --prune origin $refspecs >actual &&
    ++	test_cmp expect actual &&
     +
     +	# And now we perform a non-dry-run fetch.
    -+	test_must_fail git -C porcelain-cfg -c fetch.output=3Dporcelain fetc=
h --prune origin $refspecs >actual-cfg &&
    -+	test_must_fail git -C porcelain-cli fetch --output-format=3Dporcelai=
n --prune origin $refspecs >actual-cli &&
    -+	test_cmp actual-cfg actual-cli &&
    -+	test_cmp expect actual-cfg &&
    -+
    -+	# Ensure that the dry-run and non-dry-run output matches.
    -+	test_cmp actual-dry-run-cfg actual-cfg
    ++	test_must_fail git -C porcelain fetch \
    ++		--porcelain --prune origin $refspecs >actual 2>stderr &&
    ++	test_cmp expect actual &&
    ++	test_must_be_empty stderr
     +'
     +
    - test_expect_success 'fetch output with HEAD and --dry-run' '
    ++test_expect_success 'fetch porcelain with multiple remotes' '
    ++	test_when_finished "rm -rf porcelain" &&
    ++
    ++	git clone . porcelain &&
    ++	git -C porcelain remote add second-remote "$PWD" &&
    ++	git -C porcelain fetch second-remote &&
    ++
    ++	test_commit --no-tag multi-commit &&
    ++	old_commit=3D$(git rev-parse HEAD~) &&
    ++	new_commit=3D$(git rev-parse HEAD) &&
    ++
    ++	cat >expect <<-EOF &&
    ++	  $old_commit $new_commit refs/remotes/origin/force-updated
    ++	  $old_commit $new_commit refs/remotes/second-remote/force-updated
    ++	EOF
    ++
    ++	git -C porcelain fetch --porcelain --all >actual 2>stderr &&
    ++	test_cmp expect actual &&
    ++	test_must_be_empty stderr
    ++'
    ++
    ++test_expect_success 'fetch porcelain refuses to work with submodules'=
 '
    ++	test_when_finished "rm -rf porcelain" &&
    ++
    ++	cat >expect <<-EOF &&
    ++	fatal: options ${SQ}--porcelain${SQ} and ${SQ}--recurse-submodules${=
SQ} cannot be used together
    ++	EOF
    ++
    ++	git init porcelain &&
    ++	test_must_fail git -C porcelain fetch --porcelain --recurse-submodul=
es=3Dyes 2>stderr &&
    ++	test_cmp expect stderr &&
    ++
    ++	test_must_fail git -C porcelain fetch --porcelain --recurse-submodul=
es=3Don-demand 2>stderr &&
    ++	test_cmp expect stderr
    ++'
    ++
    + test_expect_success 'fetch output with HEAD' '
      	test_when_finished "rm -rf head" &&
      	git clone . head &&
    -@@ t/t5574-fetch-output.sh: test_expect_success 'fetch output with HEA=
D and --dry-run' '
    - 	test_cmp expect actual
    +@@ t/t5574-fetch-output.sh: test_expect_success 'fetch output with HEA=
D' '
    + 	test_cmp expect actual.err
      '
     =20
    -+test_expect_success 'fetch porcelain output with HEAD and --dry-run' '
    ++test_expect_success 'fetch porcelain output with HEAD' '
     +	test_when_finished "rm -rf head" &&
     +	git clone . head &&
     +	COMMIT_ID=3D$(git rev-parse HEAD) &&
     +
    -+	git -C head fetch --output-format=3Dporcelain --dry-run origin HEAD =
>actual &&
    ++	git -C head fetch --porcelain --dry-run origin HEAD >actual &&
     +	cat >expect <<-EOF &&
     +	* $ZERO_OID $COMMIT_ID FETCH_HEAD
     +	EOF
     +	test_cmp expect actual &&
     +
    -+	git -C head fetch --output-format=3Dporcelain --dry-run origin HEAD:=
foo >actual &&
    ++	git -C head fetch --porcelain origin HEAD >actual &&
    ++	test_cmp expect actual &&
    ++
    ++	git -C head fetch --porcelain --dry-run origin HEAD:foo >actual &&
     +	cat >expect <<-EOF &&
     +	* $ZERO_OID $COMMIT_ID refs/heads/foo
     +	EOF
    ++	test_cmp expect actual &&
    ++
    ++	git -C head fetch --porcelain origin HEAD:foo >actual &&
     +	test_cmp expect actual
     +'
     +
--=20
2.40.1


--CNK2m/XWgP0M9W3m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRSRrUACgkQVbJhu7ck
PpTRKg//dCO86w+tW9t9P21UdbVJfqrkSaQ8i/fRbguV41VCgB+RDuotQntu1weu
AL15KyuAiAtPOzPS3JL/ydjdIC7+EQp5Wg1kJrqnqsWSV8F7TkJRaBgJFOIQbrVI
q/XIRVWbsxF2H97zThjmQqKc2POx1n8ziKQxR/9zUD/BP5/3DZwP6vhRGI6+aqrS
To07hADLlYGyigXmLm57Ptek6XOH+Ix8JMqeorPgeTvh6kvog2cKOo6v+OKiW9MF
0K52AEWms3s8Bi4Zili2yxOLt4Dp8/UbvVbp/Lty1qfUO7dth4SwyoEqBmXjjvQE
QsCWup15KATPur5ZPUvcbafZ2GsAR5nzeD864gJzDnfeQLUzExr2MHDdGqevR7cw
Lz++iwP8l4Wed88FqsWnGPhTEx7SltzbTfg/7HXI1jUueq6bOMPdEezlgG/shSoi
YK1imcS7nx8pQ9DqK4yMfA1oVBU8ut9c6r731Q7tPJOLOmN+KuJ92e93vyVQaV7t
zkrxcydIgXyIQfiR13iYGA07+CURq7dVzn2vF8MILgm5SWS4GdXXianncI1e+Ayj
BsRsG8AunxlnQxiuBfFSFuIl8czr0EgPw3fNpSIJT3y0o7ABVYxtx07KXtRUpqF5
xKhhXln0H8YvHwbUIDCU9PSdncdlWuZLjLUBEX1YMCHUqv/+tD8=
=pbal
-----END PGP SIGNATURE-----

--CNK2m/XWgP0M9W3m--
