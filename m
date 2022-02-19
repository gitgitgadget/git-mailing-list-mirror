Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E75DC433F5
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 05:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbiBSFbg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 00:31:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiBSFbe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 00:31:34 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9815C19FACE
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 21:31:15 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id s24so12499090edr.5
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 21:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Ap3wPzC57A+zZJjgQuJSkMQuNDAmVo6dmLk6dMK08Io=;
        b=Kxx5g41MpC3kkpA0RptMGIN6gW+iic25YD1W+Gh5dpv9astZAulTAfCA0V2b+OPCdv
         jg/ZDFt6E6dTIn9IvVTUuCPXDgKFFoBmRcXdf/xs69UQkn4W/cFOWKwtANCWoFuYbhll
         2Zhm79WiT/7il6EbihpOrILzIG04/ktxeVBt4SY2yf6SMfnAkfOXOqUf/H1aXyD0JYEu
         SBIsGpNC9fhugvV+p9NSadYsUntCRM81CgymMJeAeWy4XP3BrVsBPgAlkuTfw4nV8gcR
         u8u1CXWyspS2MXXflTUEwUmhQ5fNRzqNQQhPfwYStv0JbNWLFGYedllNxkbA8Q20A2mi
         Q/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Ap3wPzC57A+zZJjgQuJSkMQuNDAmVo6dmLk6dMK08Io=;
        b=Qr2K+KyM6Hg0N7Jseij4iUAO4bcMF/j573kLOVDZ7Y1UFqRVnfRlBH1KeH0Bgy8Mld
         K1o4Q5ZRZCQ2RAUCW94cMPLuwfti50FmovvqOaKgmAWwGrGeMnuVQbjEGFbr375ld3Vd
         o5maf+v51S45GTTOiMZA7qFpuY2HFU41im7FN43zpJYleZsBHylfDFPfluXWiHtgRkvV
         khB8pEYPIL+QMIWD3IrRKMCaMJ26G9ZKjS+XifjThfSFBi6/I4cI5HzGhtfJ7MiIhPos
         m8zEYYf8IqiQAEdYWgx6gjLWTO/ZCqFUecgxUtsvGdWXa/YRBQuzbuxZAqEQBiZczLRJ
         ampw==
X-Gm-Message-State: AOAM530v3HJdinkoqcZ7yaA7w24P+7do1x4uBRbNNCicvi45kfqGWGnT
        tszGIl1JEh+/qYjDkLjb2dI=
X-Google-Smtp-Source: ABdhPJxGGcFY1BfXBF0TcapCEcHFpvgbwu3uFg8kYLL6J32rFtdEJAHV4bOEBtZFB+na3WGsQ227sQ==
X-Received: by 2002:aa7:c98a:0:b0:410:b8fa:6faa with SMTP id c10-20020aa7c98a000000b00410b8fa6faamr11700094edt.117.1645248673724;
        Fri, 18 Feb 2022 21:31:13 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id fy37sm2722329ejc.219.2022.02.18.21.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 21:31:12 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nLIKu-004mdb-53;
        Sat, 19 Feb 2022 06:31:12 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v11 13/13] ls-tree.c: support --object-only option for
 "git-ls-tree"
Date:   Sat, 19 Feb 2022 06:24:36 +0100
References: <cover.1644319434.git.dyroneteng@gmail.com>
 <e6d98f2560281e46e4ef2121692a54f796919b59.1644319434.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <e6d98f2560281e46e4ef2121692a54f796919b59.1644319434.git.dyroneteng@gmail.com>
Message-ID: <220219.86zgmne82n.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 08 2022, Teng Long wrote:

> We usually pipe the output from `git ls-trees` to tools like
> `sed` or `cut` when we only want to extract some fields.
>
> When we want only the pathname component, we can pass
> `--name-only` option to omit such a pipeline, but there are no
> options for extracting other fields.
>
> Teach the "--object-only" option to the command to only show the
> object name. This option cannot be used together with
> "--name-only" or "--long" , they are mutually exclusive (actually
> "--name-only" and "--long" can be combined together before, this
> commit by the way fix this bug).
>
> In terms of performance, there is no loss comparing to the
> "master" (2ae0a9c), here are the
> results of the performance tests in my environment based on linux
> repository:

I think given the re-arrangement in this v11 it would make sense to
change the commit messageto say:

 * This is an alias for --format=3D%(objectname)
 * Per benchmark XYZ it's faster

I.e. this:

>     $hyperfine --warmup=3D10 "/opt/git/master/bin/git ls-tree -r HEAD"
>     Benchmark 1: /opt/git/master/bin/git ls-tree -r HEAD
>     Time (mean =C2=B1 =CF=83):     105.8 ms =C2=B1   2.7 ms    [User: 85.=
7 ms, System: 20.0 ms]
>     Range (min =E2=80=A6 max):   101.5 ms =E2=80=A6 111.3 ms    28 runs
>
>     $hyperfine --warmup=3D10 "/opt/git/ls-tree-oid-only/bin/git ls-tree -=
r HEAD"
>     Benchmark 1: /opt/git/ls-tree-oid-only/bin/git ls-tree -r HEAD
>     Time (mean =C2=B1 =CF=83):     105.0 ms =C2=B1   3.0 ms    [User: 83.=
7 ms, System: 21.2 ms]
>     Range (min =E2=80=A6 max):    99.3 ms =E2=80=A6 109.5 ms    27 runs
>
>     $hyperfine --warmup=3D10 "/opt/git/master/bin/git ls-tree -r -l HEAD"
>     Benchmark 1: /opt/git/master/bin/git ls-tree -r -l HEAD
>     Time (mean =C2=B1 =CF=83):     337.4 ms =C2=B1  10.9 ms    [User: 308=
.3 ms, System: 29.0 ms]
>     Range (min =E2=80=A6 max):   323.0 ms =E2=80=A6 355.0 ms    10 runs
>
>     $hyperfine --warmup=3D10 "/opt/git/ls-tree-oid-only/bin/git ls-tree -=
r -l HEAD"
>     Benchmark 1: /opt/git/ls-tree-oid-only/bin/git ls-tree -r -l HEAD
>     Time (mean =C2=B1 =CF=83):     337.6 ms =C2=B1   6.2 ms    [User: 309=
.4 ms, System: 28.1 ms]
>     Range (min =E2=80=A6 max):   330.4 ms =E2=80=A6 349.9 ms    10 runs

Is surely more relevant if compared to master & that --format.

> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  Documentation/git-ls-tree.txt |  7 ++++-
>  builtin/ls-tree.c             | 16 ++++++++++-
>  t/t3104-ls-tree-format.sh     | 12 +++++++++
>  t/t3105-ls-tree-oid.sh        | 51 +++++++++++++++++++++++++++++++++++
>  4 files changed, 84 insertions(+), 2 deletions(-)
>  create mode 100755 t/t3105-ls-tree-oid.sh
>
> diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
> index db29a9efb5..21045dd163 100644
> --- a/Documentation/git-ls-tree.txt
> +++ b/Documentation/git-ls-tree.txt
> @@ -10,7 +10,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git ls-tree' [-d] [-r] [-t] [-l] [-z]
> -	    [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev=
[=3D<n>]] [--format=3D<format>]
> +	    [--name-only] [--name-status] [--object-only] [--full-name] [--full=
-tree] [--abbrev[=3D<n>]] [--format=3D<format>]
>  	    <tree-ish> [<path>...]
>=20=20
>  DESCRIPTION
> @@ -59,6 +59,11 @@ OPTIONS
>  --name-only::
>  --name-status::
>  	List only filenames (instead of the "long" output), one per line.
> +	Cannot be combined with `--object-only`.
> +
> +--object-only::
> +	List only names of the objects, one per line. Cannot be combined
> +	with `--name-only` or `--name-status`.

Hrm, I regret that in my version of v11 11/13 I didn't add to all of these =
something like:
=20=20=20=20
    This is equivalent to specifying `--format=3D...`, but for both this
    option and that exact format the command takes a hand-optimized
    codepath instead of going through the generic formatting mechanism.

Or whatever, and perhaps have everything after ", but for[...]" part of
the generic FORMAT section (no need to say it for every option).
=20=20=20=20
>=20=20
>  --abbrev[=3D<n>]::
>  	Instead of showing the full 40-byte hexadecimal object
> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> index ba96bcf602..9819a24186 100644
> --- a/builtin/ls-tree.c
> +++ b/builtin/ls-tree.c
> @@ -20,6 +20,7 @@ static int line_termination =3D '\n';
>  #define LS_SHOW_TREES (1 << 2)
>  #define LS_NAME_ONLY (1 << 3)
>  #define LS_SHOW_SIZE (1 << 4)
> +#define LS_OBJECT_ONLY (1 << 5)
>  static int abbrev;
>  static int ls_options;
>  static struct pathspec pathspec;
> @@ -37,6 +38,7 @@ static const char *format;
>  static const char *default_format =3D "%(objectmode) %(objecttype) %(obj=
ectname)%x09%(path)";
>  static const char *long_format =3D "%(objectmode) %(objecttype) %(object=
name) %(objectsize:padded)%x09%(path)";
>  static const char *name_only_format =3D "%(path)";
> +static const char *object_only_format =3D "%(objectname)";
>  struct show_tree_data {
>  	unsigned mode;
>  	enum object_type type;
> @@ -53,6 +55,7 @@ static const  char * const ls_tree_usage[] =3D {
>  enum {
>  	MODE_UNSPECIFIED =3D 0,
>  	MODE_NAME_ONLY,
> +	MODE_OBJECT_ONLY,
>  	MODE_LONG,
>  };
>=20=20
> @@ -67,6 +70,8 @@ static int fast_path(void){
>  	} else if (!strcmp(format, name_only_format)) {
>  		shown_fields =3D FIELD_PATH_NAME;
>  		return 1;
> +	} else if (!strcmp(format, object_only_format)) {
> +		shown_fields =3D FIELD_OBJECT_NAME;
>  	}
>  	return 0;
>  }
> @@ -143,7 +148,10 @@ static int parse_shown_fields(void)
>  		shown_fields =3D FIELD_PATH_NAME;
>  		return 0;
>  	}
> -
> +	if (cmdmode =3D=3D MODE_OBJECT_ONLY) {
> +		shown_fields =3D FIELD_OBJECT_NAME;
> +		return 0;
> +	}
>  	if (!ls_options || (ls_options & LS_RECURSIVE)
>  	    || (ls_options & LS_SHOW_TREES)
>  	    || (ls_options & LS_TREE_ONLY))
> @@ -267,6 +275,10 @@ static int show_tree(const struct object_id *oid, st=
ruct strbuf *base,
>  	if (type =3D=3D OBJ_BLOB && (ls_options & LS_TREE_ONLY))
>  		return 0;
>=20=20
> +	if (shown_fields =3D=3D FIELD_OBJECT_NAME) {
> +		printf("%s%c", find_unique_abbrev(oid, abbrev), line_termination);
> +		return recurse;
> +	}
>  	if (shown_fields =3D=3D FIELD_PATH_NAME) {
>  		baselen =3D base->len;
>  		strbuf_addstr(base, pathname);
> @@ -304,6 +316,8 @@ int cmd_ls_tree(int argc, const char **argv, const ch=
ar *prefix)
>  			    MODE_NAME_ONLY),
>  		OPT_CMDMODE(0, "name-status", &cmdmode, N_("list only filenames"),
>  			    MODE_NAME_ONLY),
> +		OPT_CMDMODE(0, "object-only", &cmdmode, N_("list only objects"),
> +			    MODE_OBJECT_ONLY),
>  		OPT_SET_INT(0, "full-name", &chomp_prefix,
>  			    N_("use full path names"), 0),
>  		OPT_BOOL(0, "full-tree", &full_tree,
> diff --git a/t/t3104-ls-tree-format.sh b/t/t3104-ls-tree-format.sh
> index e08c83dc47..c0ffc8e1c3 100755
> --- a/t/t3104-ls-tree-format.sh
> +++ b/t/t3104-ls-tree-format.sh
> @@ -46,6 +46,12 @@ test_expect_success 'ls-tree --format=3D<name-only-lik=
e>' '
>  		"--name-only"
>  '

This looks much better/less complex than in earlier rounds.

> +test_expect_success 'ls-tree --format=3D<object-only-like>' '
> +	test_ls_tree_format \
> +		"%(objectname)" \
> +		"--object-only"
> +'
> +
>  test_expect_success 'ls-tree combine --format=3D<default-like> and -t' '
>  	test_ls_tree_format \
>  	"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
> @@ -78,4 +84,10 @@ test_expect_success 'ls-tree hit fast-path with --form=
at=3D<name-only-like>' '
>  	git ls-tree --format=3D"%(path)" -r HEAD >actual &&
>  	test_cmp expect actual
>  '
> +
> +test_expect_success 'ls-tree hit fast-path with --format=3D<object-only-=
like>' '
> +	git ls-tree -r --object-only HEAD >expect &&
> +	git ls-tree --format=3D"%(objectname)" -r HEAD >actual &&
> +	test_cmp expect actual
> +'
>  test_done

So, you and I came up with independent tests for these two.

I wonder if this can be re-arranged so that we can share the tests, and
perhaps test all for both the --format and --object-onnly in some
for-loop, or maybe it's not worth it.

> diff --git a/t/t3105-ls-tree-oid.sh b/t/t3105-ls-tree-oid.sh
> new file mode 100755
> index 0000000000..992bb26bfa
> --- /dev/null
> +++ b/t/t3105-ls-tree-oid.sh
> @@ -0,0 +1,51 @@
> +#!/bin/sh
> +
> +test_description=3D'git ls-tree objects handling.'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +test_commit A &&
> +test_commit B &&
> +mkdir -p C &&
> +test_commit C/D.txt &&
> +find *.txt path* \( -type f -o -type l \) -print |
> +xargs git update-index --add &&
> +tree=3D$(git write-tree) &&
> +echo $tree
> +'
> +
> +test_expect_success 'usage: --object-only' '
> +git ls-tree --object-only $tree >current &&
> +git ls-tree $tree >result &&
> +cut -f1 result | cut -d " " -f3 >expected &&
> +test_cmp current expected
> +'
> +
> +test_expect_success 'usage: --object-only with -r' '
> +git ls-tree --object-only -r $tree >current &&
> +git ls-tree -r $tree >result &&
> +cut -f1 result | cut -d " " -f3 >expected &&
> +test_cmp current expected
> +'
> +
> +test_expect_success 'usage: --object-only with --abbrev' '
> +git ls-tree --object-only --abbrev=3D6 $tree >current &&
> +git ls-tree --abbrev=3D6 $tree >result &&
> +cut -f1 result | cut -d " " -f3 >expected &&
> +test_cmp current expected
> +'
> +
> +test_expect_success 'usage: incompatible options: --name-only with --obj=
ect-only' '
> +test_expect_code 129 git ls-tree --object-only --name-only $tree
> +'
> +
> +test_expect_success 'usage: incompatible options: --name-status with --o=
bject-only' '
> +test_expect_code 129 git ls-tree --object-only --name-status $tree
> +'
> +
> +test_expect_success 'usage: incompatible options: --long with --object-o=
nly' '
> +test_expect_code 129 git ls-tree --object-only --long $tree
> +'
> +
> +test_done

This whole test block seems to have lost its indentation since the v10.
