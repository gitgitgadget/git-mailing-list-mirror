Return-Path: <SRS0=CKFy=AO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22923C433DF
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 20:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E736B20890
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 20:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Klr1xm1Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgGCUq5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jul 2020 16:46:57 -0400
Received: from mout.gmx.net ([212.227.17.21]:48145 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbgGCUq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jul 2020 16:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593809200;
        bh=vHK6Ziw+tJ+I7A8N3F7k1RASR6kkdTraCHA/WLO3wn8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Klr1xm1YE2CqbSOd6BNwc5phLmHhsGpgexk3XACTW96hekG1kdYkUWqI9za/4mSIY
         1m4LmXC6fjUhlEk2NX9CXeWj7iD2gDbP1XZiGkvrZfg6UalwEakox24ZKf3LgxZrqv
         WYRbzUS+f9gW4l7Z84TnXB7nEbWd6qGe5FbnnDTo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.26.78] ([213.196.213.64]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6KYb-1ikveI2tk9-016jcj; Fri, 03
 Jul 2020 22:46:39 +0200
Date:   Fri, 3 Jul 2020 22:46:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
cc:     git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
        liu.denton@gmail.com, kaartic.sivaraam@gmail.com,
        pc44800@gmail.com, stefanbeller@gmail.com, pclouds@gmail.com
Subject: Re: [PATCH 4/4] submodule: port submodule subcommand 'summary' from
 shell to C
In-Reply-To: <20200702192409.21865-5-shouryashukla.oo@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2007031712160.50@tvgsbejvaqbjf.bet>
References: <20200702192409.21865-1-shouryashukla.oo@gmail.com> <20200702192409.21865-5-shouryashukla.oo@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:OtAGN0L9erQ/nFwZ3tvzJtumfDPTLkD3EFfroCfnpPPbfqYbXj+
 Fa80kn/TIiCK+ariQu5vttEWAYUSfW9tDxbjcteMrbmuZ7W5C3SUWTwFu7ZW9C6MyN81a72
 ZlPUthfQDD0b7Uzy+uC4+ztIm7i4MOo9oiAzywPIiFtk+oFXjiaegl+NE7LB5s+DomDHs9o
 089Z4vujY25tiUmysGeGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2RmAxJOHJVo=:0Ib5gDYxCvoBYnVkxL7AKF
 TLlyD0w3OHF1HYJeZ74WhgoASbyJkMRwlaT2mxFcHxZFsL/1eNWd61SMLd4h3MwLBxTMpnSKQ
 uHOLUzgiB8T3XIclGPC6L7ERxC1rFafQOOqTbeejEgke0A+Rq8D5BYHiB9kmBEpO7ZMp1vboC
 83buTPS660EJUnkBcrYizbQibIHYoZL9Miler1jh56jb3YzG6BYN72HW714utigcB6tROB6jJ
 lGejBseGUEoI+61VQEPI8r5MDNv/ePbSRX4VIVrugTf8FtFY0JCb34kDDwAtrF+iGaj8VQyLM
 +WtTX3fmUuvh+27WxGLW3B1tIdUkc1sWnffevtkGIrlj9/yLxgJJhxQGFYanjTJsSVqUyWkp1
 rg5icByfkhtFY6u4vvl4Uq9XSOw0f7ecHybhz5HbBwg/n+8be8n3us4NwYFbExAgs4z5WgZFe
 9Xsfe7nWPurE0jpFizN6/WQX4Ur2Y2CXDKxCTEILgswp59xyASyknFjDuD6zo61V1acyc8cZq
 tZtZSIPzwu6Pu0NDQ1YU4viqoyrTZukACfUuzDpVArm7rrKzDEmVj2SP2Zn5e5Te6QQUiu1ZY
 /wKtWrPd9x++10Zw4jXrpfa1J1nu5W868datVj4RpTLj/am6g9zlWppEihpeNLLF5hxU4nfKw
 QSKcRuEyTNl0anXJs5YnLkxM9NxbU8vHfrcVd7NCXuf9dCA3HZEnkf1kXzorpXQ9vwZ3UlxAh
 eKhfIzkTfU6Mr5ZCf0N25BDG/RZy1P4BDUbzCK1zcGof0n4mqAaK900Ga4x2qQptwum+Vobev
 7Alx6k9642q6ZpcVK1AI7gPdV1j6Od0z801AdQfzgupD13NusIROEctN803FCLmGLpAaY7SX2
 4Kb/CWgd1jdiYgzji7bng0YJTC/OgZMt9+DgOmLdFB2TWIkR2RHSZG8Ikz1bJKT5oO4xuQbgt
 LIgGRAlEl8vWR4ljRLGBRVlmxaic/II2qXCj1zufupOojgw5ZyXeNuYP9RAFs0LGdzPKZpLsl
 wuzK3JyPSLkwfRn7Y4wxmkx+8VTnAu/4h1NlZZVdYxzA9UbwMmyOz7rfsjiefukDmjOcUqlyB
 20xL1Zj3EdFQ2KYMyM1qdbmVCVoQyUHZx5pgbadclYg/YAB6SGYUPLnmUhIowTmL5ENXaiW0C
 VeTkI/EYwUz14cBwrm2F/OlpFqrfJmuCBv3TGbkXBKxej8StGIEbrkpLeaVUPbepyxkeLhYUc
 TaG+Cq5t+E5GLQUuP34gTEGxQ/huncbyyTBb7xg==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya,

[exchanging Stefan Beller's dysfunct @google address for their private
one; I encourage you to do the same in the next iteration, probably
by editing the `Mentored-by:` line.]

On Fri, 3 Jul 2020, Shourya Shukla wrote:

> From: Prathamesh Chavan <pc44800@gmail.com>
>
> The submodule subcommand 'summary' is ported in the process of
> making git-submodule a builtin. The function cmd_summary() from
> git-submodule.sh is ported to functions module_summary(),
> compute_summary_module_list(), prepare_submodule_summary() and
> generate_submodule_summary(), print_submodule_summary().
>
> The first function module_summary() parses the options of submodule
> subcommand and also acts as the front-end of this subcommand.
> After parsing them, it calls the compute_summary_module_list()

Missing full-stop, and probably the sentence also wanted to say "function"
at the end.

> The functions compute_summary_module_list() runs the diff_cmd,
> and generates the modules list, as required by the subcommand.
> The generation of this module list is done by the using the

s/the using/using/

> callback function submodule_summary_callback(), and stored in the
> structure module_cb.

This explains nicely what the patch does. But the commit message should
not really repeat what can be readily deduced from the patch; It should
focus on the motivation and on interesting background information that is
_not_ readily deduced from the patch.

For example, I see that `$diff_cmd` is called twice in the shell script
version, once to "get modified modules cared by user" and then _again_,
with that list of modified modules.

I would have liked to see a reasoning in the commit message that explains
why this has to be so in the C version. I get why it is complicated in a
shell script (which lacks proper objects, after all), but I would have
expected the C version to be able to accumulate the information with a
single pass.

(Before writing the following paragraph, I actually reviewed the patch
from bottom to top, in the caller->callee direction.)

Ah. I see that this indeed is the case: there is only one pass in the C
version. That's a useful piece of metadata for the commit message, I
think, much more useful than describing the call tree of the functions.

Another thing worth mentioning in the commit message is that we use the
combination of setting a child_process' working directory to the submodule
path and then calling `prepare_submodule_repo_env()` which also sets
`GIT_DIR` to `.git`, so that we can be certain that those spawned
processes will not access the superproject's ODB by mistake.

When reading my suggestions, please keep in mind that I reviewed the
functions in caller->callee order, i.e. I started at the end of the patch
and then worked my way up.

All in all, I like the function structure, but I think there is still a
bit room for improvement in a v2.

> Once the module list is generated, prepare_submodule_summary()
> further goes through the list and filters the list, for
> eventually calling the generate_submodule_summary() function.
>
> The function generate_submodule_summary() takes care of generating
> the summary for each submodule and then calls the function
> print_submodule_summary() for printing it.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Stefan Beller <sbeller@google.com>
> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
>  builtin/submodule--helper.c | 451 ++++++++++++++++++++++++++++++++++++
>  git-submodule.sh            | 186 +--------------
>  2 files changed, 452 insertions(+), 185 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index eea3932c40..1dbdb934f1 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -927,6 +927,456 @@ static int module_name(int argc, const char **argv=
, const char *prefix)
>  	return 0;
>  }
>
> +struct module_cb {
> +	unsigned int mod_src;
> +	unsigned int mod_dst;
> +	struct object_id oid_src;
> +	struct object_id oid_dst;
> +	char status;
> +	const char *sm_path;
> +};
> +#define MODULE_CB_INIT { 0, 0, NULL, NULL, '\0', NULL }
> +
> +struct module_cb_list {
> +	struct module_cb **entries;
> +	int alloc, nr;
> +};
> +#define MODULE_CB_LIST_INIT { NULL, 0, 0 }
> +
> +struct summary_cb {
> +	int argc;
> +	const char **argv;
> +	const char *prefix;
> +	unsigned int cached: 1;
> +	unsigned int for_status: 1;
> +	unsigned int quiet: 1;
> +	unsigned int files: 1;
> +	int summary_limit;
> +};
> +#define SUMMARY_CB_INIT { 0, NULL, NULL, 0, 0, 0, 0, 0 }
> +
> +enum diff_cmd {
> +	DIFF_INDEX,
> +	DIFF_FILES
> +};
> +
> +static int verify_submodule_object_name(const char *sm_path,
> +					  const char *sha1)
> +{
> +	struct child_process cp_rev_parse =3D CHILD_PROCESS_INIT;
> +
> +	cp_rev_parse.git_cmd =3D 1;
> +	cp_rev_parse.no_stdout =3D 1;
> +	cp_rev_parse.dir =3D sm_path;

So here we specify `sm_path` as current working directory.

> +	prepare_submodule_repo_env(&cp_rev_parse.env_array);

And this implicitly sets `GIT_DIR=3D.git`. Good.

> +	argv_array_pushl(&cp_rev_parse.args, "rev-parse", "-q",
> +			 "--verify", NULL);
> +	argv_array_pushf(&cp_rev_parse.args, "%s^0", sha1);

After this, we should also append `--` to make sure that we're not parsing
this as a file name.

Two comments about naming: `sha1` is pretty misleading here, as we do not
require it to be a SHA-1 (especially in the future in which we switch to
SHA-256). Besides, what we're really asking for (via that `^0` suffix) is
a committish. Therefore, I would propose to use `committish` both in the
parameter name as well as the function name.

> +
> +	if (run_command(&cp_rev_parse))
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static void print_submodule_summary(struct summary_cb *info, int errmsg=
,
> +				      int total_commits, int missing_src,
> +				      int missing_dst, const char *displaypath,
> +				      int is_sm_git_dir, struct module_cb *p)
> +{
> +	if (p->status =3D=3D 'T') {
> +		if (S_ISGITLINK(p->mod_dst))
> +			printf(_("* %s %s(blob)->%s(submodule)"),
> +				 displaypath, find_unique_abbrev(&p->oid_src, 7),

The shell script version does this:

                sha1_abbr_src=3D$(GIT_DIR=3D"$name/.git" git rev-parse --s=
hort $sha1_src 2>/dev/null ||
                        echo $sha1_src | cut -c1-7)

That is not quite the same, as it looks for the abbreviation _in the
submodule_, not in the current project. So I think `find_unique_abbrev()`
is not correct here.

The funny thing is that we _already_ will have called `git rev-parse
=2D-verify` for both `p->oid_src` and `p->oid_dst` in the submodule, in th=
e
caller of this function! And while we throw away the result, and while we
do not pass `--short`, there is no reason why we shouldn't be able to do
precisely that.

> +				 find_unique_abbrev(&p->oid_dst, 7));
> +		else
> +			printf(_("* %s %s(submodule)->%s(blob)"),
> +				 displaypath, find_unique_abbrev(&p->oid_src, 7),
> +				 find_unique_abbrev(&p->oid_dst, 7));
> +	} else {
> +		printf("* %s %s...%s",
> +			displaypath, find_unique_abbrev(&p->oid_src, 7),
> +			find_unique_abbrev(&p->oid_dst, 7));
> +	}
> +
> +	if (total_commits < 0)
> +		printf(":\n");
> +	else
> +		printf(" (%d):\n", total_commits);
> +
> +	if (errmsg) {
> +		/*
> +		 * Don't give error msg for modification whose dst is not
> +		 * submodule, i.e. deleted or changed to blob
> +		 */
> +		if (S_ISGITLINK(p->mod_src)) {
> +			if (missing_src && missing_dst) {
> +				printf(_("  Warn: %s doesn't contain commits %s and %s\n"),
> +				       displaypath, oid_to_hex(&p->oid_src),
> +				       oid_to_hex(&p->oid_dst));
> +			} else if (missing_src) {
> +				printf(_("  Warn: %s doesn't contain commit %s\n"),
> +				       displaypath, oid_to_hex(&p->oid_src));
> +			} else {
> +				printf(_("  Warn: %s doesn't contain commit %s\n"),
> +				       displaypath, oid_to_hex(&p->oid_dst));
> +			}
> +		}
> +	} else if (is_sm_git_dir) {
> +		struct child_process cp_log =3D CHILD_PROCESS_INIT;
> +
> +		cp_log.git_cmd =3D 1;
> +		cp_log.dir =3D p->sm_path;
> +		prepare_submodule_repo_env(&cp_log.env_array);

Since the working directory is set to the top-level directory of the
submodule, and since `prepare_submodule_repo_env()` sets `GIT_DIR` to
`.git`, I think that the `is_sm_git_dir` condition is unnecessary. In
fact, the entire `is_sm_git_dir` parameter (and local variable in the
caller, see more on that below) can go away.

> +		argv_array_pushl(&cp_log.args, "log", NULL);
> +
> +		if (S_ISGITLINK(p->mod_src) && S_ISGITLINK(p->mod_dst)) {
> +			if (info->summary_limit > 0)
> +				argv_array_pushf(&cp_log.args, "-%d",
> +						 info->summary_limit);
> +
> +			argv_array_pushl(&cp_log.args, "--pretty=3D  %m %s",
> +					 "--first-parent", NULL);
> +			argv_array_pushf(&cp_log.args, "%s...%s",
> +					 oid_to_hex(&p->oid_src),
> +					 oid_to_hex(&p->oid_dst));
> +		} else if (S_ISGITLINK(p->mod_dst)) {
> +			argv_array_pushl(&cp_log.args, "--pretty=3D  > %s",
> +					 "-1", oid_to_hex(&p->oid_dst), NULL);
> +		} else {
> +			argv_array_pushl(&cp_log.args, "--pretty=3D  < %s",
> +					 "-1", oid_to_hex(&p->oid_src), NULL);
> +		}
> +		run_command(&cp_log);
> +	}
> +	printf("\n");
> +}

It looks as if there is a whole lot of `oid_to_hex(&p->oid_src)` in that
function. Together with the realization that we need the abbreviated
version of that at least in one place, and the other realization that we
already call `rev-parse --verify` for both `oid_src` and `oid_dst` in the
caller of this function, it seems to suggest itself that we would actually
want to pass the `--short` option, too, and to capture the output, and
pass it down to `print_submodule_summary()` _instead of_ `missing_src` and
`missing_dst` (e.g. as `src_abbrev` and `dst_abbrev`).
> +
> +static void generate_submodule_summary(struct summary_cb *info,
> +				       struct module_cb *p)
> +{
> +	int missing_src =3D 0;
> +	int missing_dst =3D 0;
> +	char *displaypath;
> +	int errmsg =3D 0;
> +	int total_commits =3D -1;
> +	int is_sm_git_dir =3D 0;
> +	struct strbuf sm_git_dir_sb =3D STRBUF_INIT;
> +
> +	if (!info->cached && oideq(&p->oid_dst, &null_oid)) {
> +		if (S_ISGITLINK(p->mod_dst)) {
> +			/*
> +			 * NEEDSWORK: avoid using separate process with
> +			 * the help of the function head_ref_submodule()

I don't quite understand this comment. There is no `head_ref_submodule()`
function.

> +			 */
> +			struct child_process cp_rev_parse =3D CHILD_PROCESS_INIT;
> +			struct strbuf sb_rev_parse =3D STRBUF_INIT;
> +
> +			cp_rev_parse.git_cmd =3D 1;
> +			cp_rev_parse.no_stderr =3D 1;
> +			cp_rev_parse.dir =3D p->sm_path;
> +			prepare_submodule_repo_env(&cp_rev_parse.env_array);
> +
> +			argv_array_pushl(&cp_rev_parse.args, "rev-parse",
> +					 "HEAD", NULL);
> +			if (!capture_command(&cp_rev_parse, &sb_rev_parse, 0)) {
> +				strbuf_strip_suffix(&sb_rev_parse, "\n");
> +				get_oid_hex(sb_rev_parse.buf, &p->oid_dst);
> +			}
> +			strbuf_release(&sb_rev_parse);
> +		} else if (S_ISLNK(p->mod_dst) || S_ISREG(p->mod_dst)) {
> +			struct child_process cp_hash_object =3D CHILD_PROCESS_INIT;
> +			struct strbuf sb_hash_object =3D STRBUF_INIT;
> +
> +			cp_hash_object.git_cmd =3D 1;
> +			argv_array_pushl(&cp_hash_object.args, "hash-object",
> +					 p->sm_path, NULL);
> +			if (!capture_command(&cp_hash_object,
> +					     &sb_hash_object, 0)) {
> +				strbuf_strip_suffix(&sb_hash_object, "\n");
> +				get_oid_hex(sb_hash_object.buf, &p->oid_dst);
> +			}
> +			strbuf_release(&sb_hash_object);

It would probably be shorter, less error-prone, and quicker to use
`index_fd()` directly.

BTW I am not quite sure that this code does the correct thing in case of a
symlink: it hashes the contents of the symlink target (if it is a file,
otherwise it errors out). But that is hardly an issue introduced by the
conversion, that's just copied from `git-submodule.sh`.

> +		} else {
> +			if (p->mod_dst)
> +				die(_("unexpected mode %d\n"), p->mod_dst);

Hmm. This does not match what the shell script version does:

                        *)
                                # unexpected type
                                eval_gettextln "unexpected mode \$mod_dst"=
 >&2
                                continue ;;

I think we should also just write the message to `stderr` and continue,
not `die()`.

In addition to that, I am missing the C code for this case:

                        000000)
                                ;; # removed

It is quite possible that our test suite does not cover this case (or did
the test suite fail for you?). If that is indeed the case, it would be
really good to add a test case as part of this patch series, to gain
confidence in the correctness of the conversion.

> +		}
> +	}
> +
> +	strbuf_addstr(&sm_git_dir_sb, p->sm_path);

I have to admit that I am not loving the name `sm_git_dir_sb`. Why not
`submodule_git_dir`? I guess you copied it from elsewhere in
`submodule--helper.c`...

> +	if (is_nonbare_repository_dir(&sm_git_dir_sb))
> +		is_sm_git_dir =3D 1;

So here, we verify whether there is a repository at `p->sm_path`. I don't
see that in the shell script version:

                missing_src=3D
                missing_dst=3D

                test $mod_src =3D 160000 &&
                ! GIT_DIR=3D"$name/.git" git rev-parse -q --verify $sha1_s=
rc^0 >/dev/null &&
                missing_src=3Dt

                test $mod_dst =3D 160000 &&
                ! GIT_DIR=3D"$name/.git" git rev-parse -q --verify $sha1_d=
st^0 >/dev/null &&
                missing_dst=3Dt

Let's read a bit further.

> +
> +	if (is_sm_git_dir && S_ISGITLINK(p->mod_src))
> +		missing_src =3D verify_submodule_object_name(p->sm_path,
> +							   oid_to_hex(&p->oid_src));

Ah, and `verify_submodule_object_name()` uses `p->sm_path` as working
directory. But that's not what the shell script version did: it specified
the `GIT_DIR` explicitly.

And by using the `prepare_submodule_repo_env()` function in
`verify_submodule_object_name()`, we specify `GIT_DIR` implicitly, as I
pointed out in my comment on that function.

So I think that `is_sm_git_dir` might be

> +
> +	if (is_sm_git_dir && S_ISGITLINK(p->mod_dst))
> +		missing_dst =3D verify_submodule_object_name(p->sm_path,
> +							   oid_to_hex(&p->oid_dst));
> +
> +	displaypath =3D get_submodule_displaypath(p->sm_path, info->prefix);
> +
> +	if (!missing_dst && !missing_src) {
> +		if (is_sm_git_dir) {
> +			struct child_process cp_rev_list =3D CHILD_PROCESS_INIT;
> +			struct strbuf sb_rev_list =3D STRBUF_INIT;
> +			char *range;
> +
> +			if (S_ISGITLINK(p->mod_src) && S_ISGITLINK(p->mod_dst))
> +				range =3D xstrfmt("%s...%s", oid_to_hex(&p->oid_src),
> +						oid_to_hex(&p->oid_dst));
> +			else if (S_ISGITLINK(p->mod_src))
> +				range =3D xstrdup(oid_to_hex(&p->oid_src));
> +			else
> +				range =3D xstrdup(oid_to_hex(&p->oid_dst));
> +
> +			cp_rev_list.git_cmd =3D 1;
> +			cp_rev_list.dir =3D p->sm_path;
> +			prepare_submodule_repo_env(&cp_rev_list.env_array);

Again, due to setting the working directory to `p->sm_path` and
(implicitly, via `prepare_submodule_repo_env()`) `GIT_DIR` to `.git`, I do
not think that we have to guard this block beind `is_sm_git_dir`.

> +
> +			argv_array_pushl(&cp_rev_list.args, "rev-list",
> +					 "--first-parent", range, "--", NULL);

Since `argv_array_push()` duplicates the strings, anyway, we can totally
avoid the need for the `range` variable:

			if (IS_GITLINK(p->mod_src) && IS_GITLINK(p->mod_dst))
				argv_array_pushf(&cp_rev_list.args, "%s...%s",
						 oid_to_hex(&p->oid_src),
						 oid_to_hex(&p->oid_dst));
			else
				argv_array_push(&cp_rev_list.args, IS_GITLINK(p->mod_src) ?
						oid_to_hex(&p->oid_src) :
						oid_to_hex(&p->oid_dst));

> +			if (!capture_command(&cp_rev_list, &sb_rev_list, 0)) {
> +				if (sb_rev_list.len)
> +					total_commits =3D count_lines(sb_rev_list.buf,
> +								    sb_rev_list.len);

That's actually not necessary. `git rev-list --count` will give you a nice
number, no need to capture a potentially large amount of memory only to
count the lines.

This may also make the patch obsolete that makes `count_lines()` public.

> +				else
> +					total_commits =3D 0;
> +			}

> +
> +			free(range);
> +			strbuf_release(&sb_rev_list);
> +		}
> +	} else {
> +		errmsg =3D 1;
> +	}

I am missing the equivalent for these lines here:

                t,)
                        errmsg=3D"$(eval_gettext "  Warn: \$display_name d=
oesn't contain commit \$sha1_src")"
                        ;;
                ,t)
                        errmsg=3D"$(eval_gettext "  Warn: \$display_name d=
oesn't contain commit \$sha1_dst")"
                        ;;
                t,t)
                        errmsg=3D"$(eval_gettext "  Warn: \$display_name d=
oesn't contain commits \$sha1_src and \$ ha1_dst")"
                        ;;

I am not quite sure whether it is a good idea to leave it to the
`print_submodule_summary()` function to generate the `errmsg`. I think I'd
rather have it a `char *` than an `int`.

> +
> +	print_submodule_summary(info, errmsg, total_commits,
> +				missing_src, missing_dst,
> +		      		displaypath, is_sm_git_dir, p);
> +
> +	free(displaypath);
> +	strbuf_release(&sm_git_dir_sb);
> +}
> +
> +static void prepare_submodule_summary(struct summary_cb *info,
> +				      struct module_cb_list *list)
> +{
> +	int i;
> +	for (i =3D 0; i < list->nr; i++) {
> +		struct module_cb *p =3D list->entries[i];
> +		struct child_process cp_rev_parse =3D CHILD_PROCESS_INIT;
> +
> +		if (p->status =3D=3D 'D' || p->status =3D=3D 'T') {
> +			generate_submodule_summary(info, p);
> +			continue;
> +		}
> +
> +		if (info->for_status) {
> +			char *config_key;

Since the `config_key` is only used within the `if()` block it would be
better to declare it within that block.

> +			const char *ignore_config =3D "none";

Since the only value we ever care about is "all", how about turning this
into an `int`, setting it to `0` here, and later assigning it to
`!strcmp(value, "all")` and `!strcmp(sub->ignore, "all")`, respectively?

I mean, I get it. Unix shell scripts are all about passing around text.
And it is much easier to just translate that to C faithfully. But that
does not make it good C code. C has data types, and proper C code makes
use of that.

> +			const char *value;

If you want to save on lines, you can cuddle this together with other
declarations of the same type. Even so, it could be scoped more narrowly.

> +			const struct submodule *sub =3D submodule_from_path(the_repository,
> +									  &null_oid,
> +									  p->sm_path);
> +
> +			if (sub && p->status !=3D 'A') {

Good. The shell script version _always_ retrieved the `.ignore` config
value, even if the `status` is `A`. Your version is much better.

But why bother calling `submodule_from_path()` if the status is `A`?

I could actually see the `const struct submodule *sub;` declaration be
pulled out of this scope, and combining the `if (info->for_status &&
p->status !=3D 'A'), and the moving the assignment of `sub` into the `else
if ((sub =3D submodule_from_path(r, &null_oid, p->sm_path)) &&
sub->ignore)`.

That would save us one entire indentation level.

> +				config_key =3D xstrfmt("submodule.%s.ignore",
> +						     sub->name);
> +				if (!git_config_get_string_const(config_key, &value))
> +					ignore_config =3D value;
> +				else if (sub->ignore)
> +					ignore_config =3D sub->ignore;
> +
> +				free(config_key);
> +				if (!strcmp(ignore_config, "all"))
> +					continue;
> +			}
> +		}
> +
> +		/* Also show added or modified modules which are checked out */
> +		cp_rev_parse.dir =3D p->sm_path;
> +		cp_rev_parse.git_cmd =3D 1;
> +		cp_rev_parse.no_stderr =3D 1;
> +		cp_rev_parse.no_stdout =3D 1;
> +
> +		argv_array_pushl(&cp_rev_parse.args, "rev-parse",
> +				 "--git-dir", NULL);
> +
> +		if (!run_command(&cp_rev_parse))

I wonder whether we really need to waste an entire spawned process on
figuring out whether `p->sm_path` refers to an active repository. Wouldn't
`is_submodule_active(r, p->sm_path)` fulfill the same purpose?

> +			generate_submodule_summary(info, p);
> +	}
> +}
> +
> +static void submodule_summary_callback(struct diff_queue_struct *q,
> +				       struct diff_options *options,
> +				       void *data)
> +{
> +	int i;
> +	struct module_cb_list *list =3D data;
> +	for (i =3D 0; i < q->nr; i++) {
> +		struct diff_filepair *p =3D q->queue[i];
> +		struct module_cb *temp;
> +
> +		if (!S_ISGITLINK(p->one->mode) && !S_ISGITLINK(p->two->mode))
> +			continue;
> +		temp =3D (struct module_cb*)malloc(sizeof(struct module_cb));
> +		temp->mod_src =3D p->one->mode;
> +		temp->mod_dst =3D p->two->mode;
> +		temp->oid_src =3D p->one->oid;
> +		temp->oid_dst =3D p->two->oid;
> +		temp->status =3D p->status;
> +		temp->sm_path =3D xstrdup(p->one->path);
> +
> +		ALLOC_GROW(list->entries, list->nr + 1, list->alloc);
> +		list->entries[list->nr++] =3D temp;
> +	}
> +}
> +
> +static const char *get_diff_cmd(enum diff_cmd diff_cmd)
> +{
> +	switch (diff_cmd) {
> +	case DIFF_INDEX: return "diff-index";
> +	case DIFF_FILES: return "diff-files";
> +	default: BUG("bad diff_cmd value %d", diff_cmd);
> +	}
> +}
> +
> +static int compute_summary_module_list(char *head,
> +				         struct summary_cb *info,
> +				         enum diff_cmd diff_cmd)
> +{
> +	struct argv_array diff_args =3D ARGV_ARRAY_INIT;
> +	struct rev_info rev;
> +	struct module_cb_list list =3D MODULE_CB_LIST_INIT;
> +
> +	argv_array_push(&diff_args, get_diff_cmd(diff_cmd));
> +	if (info->cached)
> +		argv_array_push(&diff_args, "--cached");
> +	argv_array_pushl(&diff_args, "--ignore-submodules=3Ddirty", "--raw",
> +			 NULL);
> +	if (head)
> +		argv_array_push(&diff_args, head);
> +	argv_array_push(&diff_args, "--");
> +	if (info->argc)
> +		argv_array_pushv(&diff_args, info->argv);
> +
> +	git_config(git_diff_basic_config, NULL);
> +	init_revisions(&rev, info->prefix);
> +	rev.abbrev =3D 0;
> +	precompose_argv(diff_args.argc, diff_args.argv);
> +
> +	diff_args.argc =3D setup_revisions(diff_args.argc, diff_args.argv,
> +					 &rev, NULL);
> +	rev.diffopt.output_format =3D DIFF_FORMAT_NO_OUTPUT | DIFF_FORMAT_CALL=
BACK;
> +	rev.diffopt.format_callback =3D submodule_summary_callback;
> +	rev.diffopt.format_callback_data =3D &list;
> +
> +	if (!info->cached) {
> +		if (diff_cmd =3D=3D  DIFF_INDEX)

Please substitute the double-space by a single one.

> +			setup_work_tree();
> +		if (read_cache_preload(&rev.diffopt.pathspec) < 0) {
> +			perror("read_cache_preload");
> +			return -1;
> +		}
> +	} else if (read_cache() < 0) {
> +		perror("read_cache");
> +		return -1;
> +	}
> +
> +	if (diff_cmd =3D=3D DIFF_INDEX)
> +		run_diff_index(&rev, info->cached);
> +	else
> +		run_diff_files(&rev, 0);
> +	prepare_submodule_summary(info, &list);
> +	return 0;
> +}
> +
> +static int module_summary(int argc, const char **argv, const char *pref=
ix)
> +{
> +	struct summary_cb info =3D SUMMARY_CB_INIT;
> +	int cached =3D 0;
> +	int for_status =3D 0;
> +	int quiet =3D 0;
> +	int files =3D 0;
> +	int summary_limit =3D -1;
> +	struct child_process cp_rev =3D CHILD_PROCESS_INIT;
> +	struct strbuf sb =3D STRBUF_INIT;
> +	enum diff_cmd diff_cmd =3D DIFF_INDEX;
> +	int ret;
> +
> +	struct option module_summary_options[] =3D {
> +		OPT__QUIET(&quiet, N_("Suppress output of summarising submodules")),
> +		OPT_BOOL(0, "cached", &cached,
> +			 N_("Use the commit stored in the index instead of the submodule HEA=
D")),
> +		OPT_BOOL(0, "files", &files,
> +			 N_("To compare the commit in the index with that in the submodule H=
EAD")),
> +		OPT_BOOL(0, "for-status", &for_status,
> +			 N_("Skip submodules with 'ignore_config' value set to 'all'")),
> +		OPT_INTEGER('n', "summary-limit", &summary_limit,
> +			     N_("Limit the summary size")),
> +		OPT_END()
> +	};
> +
> +	const char *const git_submodule_helper_usage[] =3D {
> +		N_("git submodule--helper summary [<options>] [commit] [--] [<path>]"=
),
> +		NULL
> +	};
> +
> +	argc =3D parse_options(argc, argv, prefix, module_summary_options,
> +			     git_submodule_helper_usage, 0);
> +
> +	if (!summary_limit)
> +		return 0;
> +
> +	cp_rev.git_cmd =3D 1;
> +	argv_array_pushl(&cp_rev.args, "rev-parse", "-q", "--verify",
> +			 argc ? argv[0] : "HEAD", NULL);

Oy. Why not simply call `get_oid()`? No need to spawn a new process.

> +
> +	if (!capture_command(&cp_rev, &sb, 0)) {
> +		strbuf_strip_suffix(&sb, "\n");
> +		if (argc) {
> +			argv++;
> +			argc--;
> +		}
> +	} else if (!argc || !strcmp(argv[0], "HEAD")) {
> +		/* before the first commit: compare with an empty tree */
> +		struct stat st;
> +		struct object_id oid;
> +		if (fstat(0, &st) < 0 || index_fd(&the_index, &oid, 0, &st, 2,
> +						  prefix, 3))
> +			die("Unable to add %s to database", oid.hash);

Umm. The original reads:

                # before the first commit: compare with an empty tree
                head=3D$(git hash-object -w -t tree --stdin </dev/null)

It does not actually read from `stdin`. It reads from `/dev/null`,
redirected to the input. And what it _actually_ does is to generate the
OID of the empty tree.

But we already _have_ the OID of the empty tree! It's
`the_hash_algo->empty_tree`.

I hope that this is covered by the test suite. Please check that. The test
would succeed with your version, but only because tests are run with
`stdin` redirected from `/dev/null` by default.

> +		strbuf_addstr(&sb, oid_to_hex(&oid));
> +		if (argc) {
> +			argv++;
> +			argc--;
> +		}
> +	} else {
> +		strbuf_addstr(&sb, "HEAD");
> +	}

The conversion to C would make for a fine excuse to simplify the logic.

> +	if (files) {
> +		if (cached)
> +			die(_("--cached and --files are mutually exclusive"));
> +		diff_cmd =3D DIFF_FILES;
> +	}
> +
> +	info.argc =3D argc;
> +	info.argv =3D argv;
> +	info.prefix =3D prefix;
> +	info.cached =3D !!cached;
> +	info.for_status =3D !!for_status;
> +	info.quiet =3D quiet;
> +	info.files =3D files;
> +	info.summary_limit =3D summary_limit;
> +
> +	ret =3D compute_summary_module_list((diff_cmd =3D=3D DIFF_FILES) ? NUL=
L : sb.buf,
> +					   &info, diff_cmd);

It would be better to pass the OID as `struct object_id *`, not as string.

Other than that, this patch nicely follows previous conversions from Unix
shell scripts to C.

Well done,
Johannes

> +	strbuf_release(&sb);
> +	return ret;
> +}
> +
>  struct sync_cb {
>  	const char *prefix;
>  	unsigned int flags;
> @@ -2341,6 +2791,7 @@ static struct cmd_struct commands[] =3D {
>  	{"print-default-remote", print_default_remote, 0},
>  	{"sync", module_sync, SUPPORT_SUPER_PREFIX},
>  	{"deinit", module_deinit, 0},
> +	{"summary", module_summary, SUPPORT_SUPER_PREFIX},
>  	{"remote-branch", resolve_remote_submodule_branch, 0},
>  	{"push-check", push_check, 0},
>  	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 43eb6051d2..899b8a409a 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -59,31 +59,6 @@ die_if_unmatched ()
>  	fi
>  }
>
> -#
> -# Print a submodule configuration setting
> -#
> -# $1 =3D submodule name
> -# $2 =3D option name
> -# $3 =3D default value
> -#
> -# Checks in the usual git-config places first (for overrides),
> -# otherwise it falls back on .gitmodules.  This allows you to
> -# distribute project-wide defaults in .gitmodules, while still
> -# customizing individual repositories if necessary.  If the option is
> -# not in .gitmodules either, print a default value.
> -#
> -get_submodule_config () {
> -	name=3D"$1"
> -	option=3D"$2"
> -	default=3D"$3"
> -	value=3D$(git config submodule."$name"."$option")
> -	if test -z "$value"
> -	then
> -		value=3D$(git submodule--helper config submodule."$name"."$option")
> -	fi
> -	printf '%s' "${value:-$default}"
> -}
> -
>  isnumber()
>  {
>  	n=3D$(($1 + 0)) 2>/dev/null && test "$n" =3D "$1"
> @@ -831,166 +806,7 @@ cmd_summary() {
>  		shift
>  	done
>
> -	test $summary_limit =3D 0 && return
> -
> -	if rev=3D$(git rev-parse -q --verify --default HEAD ${1+"$1"})
> -	then
> -		head=3D$rev
> -		test $# =3D 0 || shift
> -	elif test -z "$1" || test "$1" =3D "HEAD"
> -	then
> -		# before the first commit: compare with an empty tree
> -		head=3D$(git hash-object -w -t tree --stdin </dev/null)
> -		test -z "$1" || shift
> -	else
> -		head=3D"HEAD"
> -	fi
> -
> -	if [ -n "$files" ]
> -	then
> -		test -n "$cached" &&
> -		die "$(gettext "The --cached option cannot be used with the --files o=
ption")"
> -		diff_cmd=3Ddiff-files
> -		head=3D
> -	fi
> -
> -	cd_to_toplevel
> -	eval "set $(git rev-parse --sq --prefix "$wt_prefix" -- "$@")"
> -	# Get modified modules cared by user
> -	modules=3D$(git $diff_cmd $cached --ignore-submodules=3Ddirty --raw $h=
ead -- "$@" |
> -		sane_egrep '^:([0-7]* )?160000' |
> -		while read -r mod_src mod_dst sha1_src sha1_dst status sm_path
> -		do
> -			# Always show modules deleted or type-changed (blob<->module)
> -			if test "$status" =3D D || test "$status" =3D T
> -			then
> -				printf '%s\n' "$sm_path"
> -				continue
> -			fi
> -			# Respect the ignore setting for --for-status.
> -			if test -n "$for_status"
> -			then
> -				name=3D$(git submodule--helper name "$sm_path")
> -				ignore_config=3D$(get_submodule_config "$name" ignore none)
> -				test $status !=3D A && test $ignore_config =3D all && continue
> -			fi
> -			# Also show added or modified modules which are checked out
> -			GIT_DIR=3D"$sm_path/.git" git rev-parse --git-dir >/dev/null 2>&1 &&
> -			printf '%s\n' "$sm_path"
> -		done
> -	)
> -
> -	test -z "$modules" && return
> -
> -	git $diff_cmd $cached --ignore-submodules=3Ddirty --raw $head -- $modu=
les |
> -	sane_egrep '^:([0-7]* )?160000' |
> -	cut -c2- |
> -	while read -r mod_src mod_dst sha1_src sha1_dst status name
> -	do
> -		if test -z "$cached" &&
> -			is_zero_oid $sha1_dst
> -		then
> -			case "$mod_dst" in
> -			160000)
> -				sha1_dst=3D$(GIT_DIR=3D"$name/.git" git rev-parse HEAD)
> -				;;
> -			100644 | 100755 | 120000)
> -				sha1_dst=3D$(git hash-object $name)
> -				;;
> -			000000)
> -				;; # removed
> -			*)
> -				# unexpected type
> -				eval_gettextln "unexpected mode \$mod_dst" >&2
> -				continue ;;
> -			esac
> -		fi
> -		missing_src=3D
> -		missing_dst=3D
> -
> -		test $mod_src =3D 160000 &&
> -		! GIT_DIR=3D"$name/.git" git rev-parse -q --verify $sha1_src^0 >/dev/=
null &&
> -		missing_src=3Dt
> -
> -		test $mod_dst =3D 160000 &&
> -		! GIT_DIR=3D"$name/.git" git rev-parse -q --verify $sha1_dst^0 >/dev/=
null &&
> -		missing_dst=3Dt
> -
> -		display_name=3D$(git submodule--helper relative-path "$name" "$wt_pre=
fix")
> -
> -		total_commits=3D
> -		case "$missing_src,$missing_dst" in
> -		t,)
> -			errmsg=3D"$(eval_gettext "  Warn: \$display_name doesn't contain com=
mit \$sha1_src")"
> -			;;
> -		,t)
> -			errmsg=3D"$(eval_gettext "  Warn: \$display_name doesn't contain com=
mit \$sha1_dst")"
> -			;;
> -		t,t)
> -			errmsg=3D"$(eval_gettext "  Warn: \$display_name doesn't contain com=
mits \$sha1_src and \$sha1_dst")"
> -			;;
> -		*)
> -			errmsg=3D
> -			total_commits=3D$(
> -			if test $mod_src =3D 160000 && test $mod_dst =3D 160000
> -			then
> -				range=3D"$sha1_src...$sha1_dst"
> -			elif test $mod_src =3D 160000
> -			then
> -				range=3D$sha1_src
> -			else
> -				range=3D$sha1_dst
> -			fi
> -			GIT_DIR=3D"$name/.git" \
> -			git rev-list --first-parent $range -- | wc -l
> -			)
> -			total_commits=3D" ($(($total_commits + 0)))"
> -			;;
> -		esac
> -
> -		sha1_abbr_src=3D$(GIT_DIR=3D"$name/.git" git rev-parse --short $sha1_=
src 2>/dev/null ||
> -			echo $sha1_src | cut -c1-7)
> -		sha1_abbr_dst=3D$(GIT_DIR=3D"$name/.git" git rev-parse --short $sha1_=
dst 2>/dev/null ||
> -			echo $sha1_dst | cut -c1-7)
> -
> -		if test $status =3D T
> -		then
> -			blob=3D"$(gettext "blob")"
> -			submodule=3D"$(gettext "submodule")"
> -			if test $mod_dst =3D 160000
> -			then
> -				echo "* $display_name $sha1_abbr_src($blob)->$sha1_abbr_dst($submod=
ule)$total_commits:"
> -			else
> -				echo "* $display_name $sha1_abbr_src($submodule)->$sha1_abbr_dst($b=
lob)$total_commits:"
> -			fi
> -		else
> -			echo "* $display_name $sha1_abbr_src...$sha1_abbr_dst$total_commits:=
"
> -		fi
> -		if test -n "$errmsg"
> -		then
> -			# Don't give error msg for modification whose dst is not submodule
> -			# i.e. deleted or changed to blob
> -			test $mod_dst =3D 160000 && echo "$errmsg"
> -		else
> -			if test $mod_src =3D 160000 && test $mod_dst =3D 160000
> -			then
> -				limit=3D
> -				test $summary_limit -gt 0 && limit=3D"-$summary_limit"
> -				GIT_DIR=3D"$name/.git" \
> -				git log $limit --pretty=3D'format:  %m %s' \
> -				--first-parent $sha1_src...$sha1_dst
> -			elif test $mod_dst =3D 160000
> -			then
> -				GIT_DIR=3D"$name/.git" \
> -				git log --pretty=3D'format:  > %s' -1 $sha1_dst
> -			else
> -				GIT_DIR=3D"$name/.git" \
> -				git log --pretty=3D'format:  < %s' -1 $sha1_src
> -			fi
> -			echo
> -		fi
> -		echo
> -	done
> +	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper summary ${GIT_QUIE=
T:+--quiet} ${prefix:+--prefix "$prefix"} ${for_status:+--for-status} ${fi=
les:+--files} ${cached:+--cached} ${summary_limit:+-n $summary_limit} "$@"
>  }
>  #
>  # List all submodules, prefixed with:
> --
> 2.27.0
>
>
