Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08E8C433EF
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 12:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiATMgM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 07:36:12 -0500
Received: from mout.web.de ([212.227.17.12]:54501 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230448AbiATMgH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 07:36:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1642682155;
        bh=OR+/ZUHuStXtamf5fNKlzBq0hYK2NqqnfhXmzDRy1ts=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=KaOstnjcIgfG6tJHfrrQA/W2ngZViwK1nv736QzCxCX/mcxUe3bltTjikxXQeV1QQ
         7h+vWhWO5NlvDvo0VMEyZIOCqbwS723LqCw3RCQhRQT5RU04utsXJa4wlquyy7jBj4
         oZs8YaXr7lx8a4CcZa+Y8xALTEDR/tmarGJP6iTg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mt8gF-1mHKc60X17-00tTwd; Thu, 20
 Jan 2022 13:35:55 +0100
Message-ID: <c3c26192-aee9-185a-e559-b8735139e49c@web.de>
Date:   Thu, 20 Jan 2022 13:35:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: [PATCH] branch,checkout: fix --track documentation
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, chooglen@google.com,
        Junio C Hamano <gitster@pobox.com>
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1640039978.git.steadmon@google.com>
 <dcba40e2c4001611f837f612cc5ee7890c653aff.1640039978.git.steadmon@google.com>
 <220111.86a6g3yqf9.gmgdl@evledraar.gmail.com>
 <55d5327a-9c6c-7fd8-b540-e710259c0694@web.de>
 <220120.864k5ymx55.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <220120.864k5ymx55.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sNEbQa7J4WgRT9Ulahiv6/U3ysUqOfoemTtFqpEeJTk1yiT96nn
 +6v5W93aQv7nc6J5DUgDPP314OIKvwBmu4akrch1ZMf7JkulZ+aTHlBxxnfsUBvbiV8o37A
 +SHlt8Kam3xwRXyLx0XyRaJqsYyKwelZbuccWI3k2LdxnFccWA2HBEYgFpLaVlNjPBx/+ZO
 s7yZTT3hVny3VCa6Zrd/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:q/2nqExjCWI=:U86nxNDSraWndTdkaNms4F
 douVk/7gTzaC1CSq0cNCSq1AlHjawZ/EBA0ZTllOyfRgx1anmlkQgFOZVfdk9/3/nYPwE12Rt
 8BkKiG8cU4k6m7p1AWiYTw/Q1fUCWoZU3oqFBnKHlBXsUisJJ9h5T5rbCTk6HVU6VLv6hV0ln
 6+FkNYCDs6lHPiOYxi5/g1r7ygqDeo373R2TtAm2sLjqAFnEqRRTpAR3rHNqIVVX/30clP0Fw
 Fkpk2GdIarq9VspR3YtwKH99sMN6VLQMOqxXFTxI3lgpCvZtonVD/8FqHSA12365tcpmsKzmV
 LhPsAdkzoMEfkxXuy8x5bXqnWuAEjvb0V+dtw831o3F+Oj2ByU6ZMxL1pl8ILdMT7zoiwnoLE
 5IgegkHWAnxByOQ0b4NQKp7nUfGByoeFQyh8SzbnVM0syhfdBocJ7ZIXgGzniwTtxe5zJwoZo
 gGqNfu5ijx39zDMPLNkwezr2tB7OZcJyFvlOQQyjSrq2rBa84JQbysIQeA563kASkxnYspEzJ
 kaDuRdfmJTg71ZZIpcXNW7qANy7lPs+RcAVDhq54ooATHsSck5KLvfde+7hqKCAjGyvJC5xWh
 LrD6RvMUgZvNE+HtE/tjXoFy7Znj4QQQb2q8q/xhuBl6thZr7BAH8OxpyVQddz6B+x3oRTWrL
 yQm0hPaT6TTfT9O9ykMW41gwS296UL80OOt+KEKLprhgEBJnXzFi+z2EHFP7fn876nLUCr7e8
 a+DC1bGR7RPjW3WujWBS2tjLwur7XlkL59VwhAn4wnrHa+ECtcfB6qbqd5jmFbMRlzXxgRGzE
 JxPiN+gqGJCLFDQOwGvmO+QCUGaea5/1M2RuMyfntfCNOtcvfZcJyNPb4t8Dbbl16dnq7VPTu
 UEOmnBd9L4jplgUajXnzFKzMOmxPFhrn4NOqF7eNnAYLBXP3kfOgdmrpeGGpSMPKst+U+9e46
 TE0O7M4vNOJwGsKb3zOt5mLyaEdFn3lA5OrzKzqwlqB8K4XnJys5G9kdqKZxDpGAP+Q2agFFs
 ZRxGqOmo+tWauEDSJsUPrISoq6OnGLcoMXXG4GXj+Bdd0cV+1iXNC5l6954lGfafYEHVyNmH1
 FYDUWUppfR4bCY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document that the accepted variants of the --track option are --track,
=2D-track=3Ddirect, and --track=3Dinherit.  The equal sign in the latter t=
wo
cannot be replaced with whitespace; in general optional arguments need
to be attached firmly to their option.

Put "direct" consistently before "inherit", if only for the reasons
that the former is the default, explained first in the documentation,
and comes before the latter alphabetically.

Mention both modes in the short help so that readers don't have to look
them up in the full documentation.  They are literal strings and thus
untranslatable.  PARSE_OPT_LITERAL_ARGHELP is inferred due to the pipe
and parenthesis characters, so we don't have to provide that flag
explicitly.

Mention that -t has the same effect as --track and --track=3Ddirect.
There is no way to specify inherit mode using the short option, because
short options generally don't accept optional arguments.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/git-branch.txt   | 12 ++++++------
 Documentation/git-checkout.txt |  2 +-
 builtin/branch.c               |  2 +-
 builtin/checkout.c             |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 2d52ae396b..731e340cbc 100644
=2D-- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 	[--points-at <object>] [--format=3D<format>]
 	[(-r | --remotes) | (-a | --all)]
 	[--list] [<pattern>...]
-'git branch' [--track [direct|inherit] | --no-track] [-f] <branchname> [<=
start-point>]
+'git branch' [--track[=3D(direct|inherit)] | --no-track] [-f] <branchname=
> [<start-point>]
 'git branch' (--set-upstream-to=3D<upstream> | -u <upstream>) [<branchnam=
e>]
 'git branch' --unset-upstream [<branchname>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
@@ -206,7 +206,7 @@ This option is only applicable in non-verbose mode.
 	Display the full sha1s in the output listing rather than abbreviating th=
em.

 -t::
=2D--track [inherit|direct]::
+--track[=3D(direct|inherit)]::
 	When creating a new branch, set up `branch.<name>.remote` and
 	`branch.<name>.merge` configuration entries to set "upstream" tracking
 	configuration for the new branch. This
@@ -216,11 +216,11 @@ This option is only applicable in non-verbose mode.
 	upstream when the new branch is checked out.
 +
 The exact upstream branch is chosen depending on the optional argument:
-`--track` or `--track direct` means to use the start-point branch itself =
as the
-upstream; `--track inherit` means to copy the upstream configuration of t=
he
-start-point branch.
+`-t`, `--track`, or `--track=3Ddirect` means to use the start-point branc=
h
+itself as the upstream; `--track=3Dinherit` means to copy the upstream
+configuration of the start-point branch.
 +
-`--track direct` is the default when the start point is a remote-tracking=
 branch.
+`--track=3Ddirect` is the default when the start point is a remote-tracki=
ng branch.
 Set the branch.autoSetupMerge configuration variable to `false` if you
 want `git switch`, `git checkout` and `git branch` to always behave as if=
 `--no-track`
 were given. Set it to `always` if you want this behavior when the
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.t=
xt
index 2a90ea6cd0..9f37e22e13 100644
=2D-- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -156,7 +156,7 @@ of it").
 	linkgit:git-branch[1] for details.

 -t::
=2D--track [direct|inherit]::
+--track[=3D(direct|inherit)]::
 	When creating a new branch, set up "upstream" configuration. See
 	"--track" in linkgit:git-branch[1] for details.
 +
diff --git a/builtin/branch.c b/builtin/branch.c
index 0c8d8a8827..4ce2a24754 100644
=2D-- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -638,7 +638,7 @@ int cmd_branch(int argc, const char **argv, const char=
 *prefix)
 		OPT__VERBOSE(&filter.verbose,
 			N_("show hash and subject, give twice for upstream branch")),
 		OPT__QUIET(&quiet, N_("suppress informational messages")),
-		OPT_CALLBACK_F('t', "track",  &track, N_("mode"),
+		OPT_CALLBACK_F('t', "track",  &track, "(direct|inherit)",
 			N_("set branch tracking configuration"),
 			PARSE_OPT_OPTARG,
 			parse_opt_tracking_mode),
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6a5dd2a2a2..0bc2e63510 100644
=2D-- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1549,7 +1549,7 @@ static struct option *add_common_switch_branch_optio=
ns(
 {
 	struct option options[] =3D {
 		OPT_BOOL('d', "detach", &opts->force_detach, N_("detach HEAD at named c=
ommit")),
-		OPT_CALLBACK_F('t', "track",  &opts->track, N_("mode"),
+		OPT_CALLBACK_F('t', "track",  &opts->track, "(direct|inherit)",
 			N_("set branch tracking configuration"),
 			PARSE_OPT_OPTARG,
 			parse_opt_tracking_mode),
=2D-
2.34.1
