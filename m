Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22EBC432C3
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F71D20674
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbhAZWDq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:03:46 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64856 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388366AbhAZTgw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 14:36:52 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C9737112954;
        Tue, 26 Jan 2021 14:36:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=EneInwIyVjQ4
        kiHA3SCCf5ddVaI=; b=rCPdsr7wYlS7IZg6dBzhDNfwulRzcYwQ41CXxVe+85tu
        seI/B5mOxDyG+ruIQ/gv5WWKY+nt00BbmnFMjNVUEL07D/zGQD00TUdsynG5iONw
        eUbfO1Xe17DEefK0N6E/1IuxrxQeIdLwW6BONyog9iQfgsvQYoklX04QkJyHytI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=EDB0kS
        AMBc4hMbg/rIPoYyXoe812r5IY7qBQU8DKXrquHoihKc8xmb8sfHcB0nuyABiMWO
        vbzJU1tAg44aA6VFQzQuxhAqwrt1t1KMhZJ17cGn5scgkDY3X92IVxmAOsqUoH5T
        msu6r/e8gh4xZ3QWcOE3t933qwHvMvezFFnLE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C2941112953;
        Tue, 26 Jan 2021 14:36:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0FF27112950;
        Tue, 26 Jan 2021 14:36:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Beat Bolli <dev+git@drbeat.li>,
        Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH] grep/log: remove hidden --debug and --grep-debug options
References: <20210125233651.31537-1-avarab@gmail.com>
Date:   Tue, 26 Jan 2021 11:35:59 -0800
In-Reply-To: <20210125233651.31537-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 26 Jan 2021 00:36:51 +0100")
Message-ID: <xmqqv9bj1of4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B87A7A16-600D-11EB-ACB2-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Remove the hidden "grep --debug" and "log --grep-debug" options added
> in 17bf35a3c7b (grep: teach --debug option to dump the parse tree,
> 2012-09-13).
>
> At the time these options seem to have been intended to go along with
> a documentation discussion and to help the author of relevant tests to
> perform ad-hoc debugging on them[1].
>
> Reasons to want this gone:
>
>  1. They were never documented, and the only (rather trivial) use of
>     them in our own codebase for testing is something I removed back
>     in e01b4dab01e (grep: change non-ASCII -i test to stop using
>     --debug, 2017-05-20).
>
>  2. Googling around doesn't show any in-the-wild uses I could dig up,
>     and on the Git ML the only mentions after the original discussion
>     seem to have been when they came up in unrelated diff contexts, or
>     that test commit of mine.

I do not expect anybody uses it; just get rid of it and we'd be
fine.

> The need for this debugging aid for the composed grep/log patterns
> seems to have passed, and the desire to dump the JIT config seems to
> have been another one-off around the time we had JIT-related issues on
> the PCREv2 codepath. That the original author of this debugging
> facility seemingly hasn't noticed the bad output since then[2] is
> probably some indicator.
>
> 1. https://lore.kernel.org/git/cover.1347615361.git.git@drmicha.warpmai=
l.net/
> 2. https://lore.kernel.org/git/xmqqk1b8x0ac.fsf@gitster-ct.c.googlers.c=
om/
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/grep.c |   5 ---
>  grep.c         | 101 +------------------------------------------------
>  grep.h         |   1 -
>  revision.c     |   2 -
>  4 files changed, 2 insertions(+), 107 deletions(-)

Thanks.

Loss of a member in the struct is a sure way to ensure that all
codepaths are covered or we would quickly see that compilers barf.
The changes look good.

> diff --git a/builtin/grep.c b/builtin/grep.c
> index ca259af4416..55d06c95130 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -216,8 +216,6 @@ static void start_threads(struct grep_opt *opt)
>  		int err;
>  		struct grep_opt *o =3D grep_opt_dup(opt);
>  		o->output =3D strbuf_out;
> -		if (i)
> -			o->debug =3D 0;
>  		compile_grep_patterns(o);
>  		err =3D pthread_create(&threads[i], NULL, run, o);
> =20
> @@ -936,9 +934,6 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
>  			   N_("indicate hit with exit status without output")),
>  		OPT_BOOL(0, "all-match", &opt.all_match,
>  			N_("show only matches from files that match all patterns")),
> -		OPT_SET_INT_F(0, "debug", &opt.debug,
> -			      N_("show parse tree for grep expression"),
> -			      1, PARSE_OPT_HIDDEN),
>  		OPT_GROUP(""),
>  		{ OPTION_STRING, 'O', "open-files-in-pager", &show_in_pager,
>  			N_("pager"), N_("show matching files in the pager"),
> diff --git a/grep.c b/grep.c
> index efeb6dc58db..21f0ee03be9 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -400,8 +400,6 @@ static void compile_pcre1_regexp(struct grep_pat *p=
, const struct grep_opt *opt)
> =20
>  #if defined(PCRE_CONFIG_JIT) && !defined(NO_LIBPCRE1_JIT)
>  	pcre_config(PCRE_CONFIG_JIT, &p->pcre1_jit_on);
> -	if (opt->debug)
> -		fprintf(stderr, "pcre1_jit_on=3D%d\n", p->pcre1_jit_on);
> =20
>  	if (p->pcre1_jit_on)
>  		study_options =3D PCRE_STUDY_JIT_COMPILE;
> @@ -508,8 +506,6 @@ static void compile_pcre2_pattern(struct grep_pat *=
p, const struct grep_opt *opt
>  	}
> =20
>  	pcre2_config(PCRE2_CONFIG_JIT, &p->pcre2_jit_on);
> -	if (opt->debug)
> -		fprintf(stderr, "pcre2_jit_on=3D%d\n", p->pcre2_jit_on);
>  	if (p->pcre2_jit_on) {
>  		jitret =3D pcre2_jit_compile(p->pcre2_pattern, PCRE2_JIT_COMPLETE);
>  		if (jitret)
> @@ -535,9 +531,6 @@ static void compile_pcre2_pattern(struct grep_pat *=
p, const struct grep_opt *opt
>  			BUG("pcre2_pattern_info() failed: %d", patinforet);
>  		if (jitsizearg =3D=3D 0) {
>  			p->pcre2_jit_on =3D 0;
> -			if (opt->debug)
> -				fprintf(stderr, "pcre2_jit_on=3D%d: (*NO_JIT) in regex\n",
> -					p->pcre2_jit_on);
>  			return;
>  		}
>  	}
> @@ -616,8 +609,6 @@ static void compile_fixed_regexp(struct grep_pat *p=
, struct grep_opt *opt)
>  	if (opt->ignore_case)
>  		regflags |=3D REG_ICASE;
>  	err =3D regcomp(&p->regexp, sb.buf, regflags);
> -	if (opt->debug)
> -		fprintf(stderr, "fixed %s\n", sb.buf);
>  	strbuf_release(&sb);
>  	if (err) {
>  		char errbuf[1024];
> @@ -812,87 +803,6 @@ static struct grep_expr *compile_pattern_expr(stru=
ct grep_pat **list)
>  	return compile_pattern_or(list);
>  }
> =20
> -static void indent(int in)
> -{
> -	while (in-- > 0)
> -		fputc(' ', stderr);
> -}
> -
> -static void dump_grep_pat(struct grep_pat *p)
> -{
> -	switch (p->token) {
> -	case GREP_AND: fprintf(stderr, "*and*"); break;
> -	case GREP_OPEN_PAREN: fprintf(stderr, "*(*"); break;
> -	case GREP_CLOSE_PAREN: fprintf(stderr, "*)*"); break;
> -	case GREP_NOT: fprintf(stderr, "*not*"); break;
> -	case GREP_OR: fprintf(stderr, "*or*"); break;
> -
> -	case GREP_PATTERN: fprintf(stderr, "pattern"); break;
> -	case GREP_PATTERN_HEAD: fprintf(stderr, "pattern_head"); break;
> -	case GREP_PATTERN_BODY: fprintf(stderr, "pattern_body"); break;
> -	}
> -
> -	switch (p->token) {
> -	default: break;
> -	case GREP_PATTERN_HEAD:
> -		fprintf(stderr, "<head %d>", p->field); break;
> -	case GREP_PATTERN_BODY:
> -		fprintf(stderr, "<body>"); break;
> -	}
> -	switch (p->token) {
> -	default: break;
> -	case GREP_PATTERN_HEAD:
> -	case GREP_PATTERN_BODY:
> -	case GREP_PATTERN:
> -		fprintf(stderr, "%.*s", (int)p->patternlen, p->pattern);
> -		break;
> -	}
> -	fputc('\n', stderr);
> -}
> -
> -static void dump_grep_expression_1(struct grep_expr *x, int in)
> -{
> -	indent(in);
> -	switch (x->node) {
> -	case GREP_NODE_TRUE:
> -		fprintf(stderr, "true\n");
> -		break;
> -	case GREP_NODE_ATOM:
> -		dump_grep_pat(x->u.atom);
> -		break;
> -	case GREP_NODE_NOT:
> -		fprintf(stderr, "(not\n");
> -		dump_grep_expression_1(x->u.unary, in+1);
> -		indent(in);
> -		fprintf(stderr, ")\n");
> -		break;
> -	case GREP_NODE_AND:
> -		fprintf(stderr, "(and\n");
> -		dump_grep_expression_1(x->u.binary.left, in+1);
> -		dump_grep_expression_1(x->u.binary.right, in+1);
> -		indent(in);
> -		fprintf(stderr, ")\n");
> -		break;
> -	case GREP_NODE_OR:
> -		fprintf(stderr, "(or\n");
> -		dump_grep_expression_1(x->u.binary.left, in+1);
> -		dump_grep_expression_1(x->u.binary.right, in+1);
> -		indent(in);
> -		fprintf(stderr, ")\n");
> -		break;
> -	}
> -}
> -
> -static void dump_grep_expression(struct grep_opt *opt)
> -{
> -	struct grep_expr *x =3D opt->pattern_expression;
> -
> -	if (opt->all_match)
> -		fprintf(stderr, "[all-match]\n");
> -	dump_grep_expression_1(x, 0);
> -	fflush(NULL);
> -}
> -
>  static struct grep_expr *grep_true_expr(void)
>  {
>  	struct grep_expr *z =3D xcalloc(1, sizeof(*z));
> @@ -973,7 +883,7 @@ static struct grep_expr *grep_splice_or(struct grep=
_expr *x, struct grep_expr *y
>  	return z;
>  }
> =20
> -static void compile_grep_patterns_real(struct grep_opt *opt)
> +void compile_grep_patterns(struct grep_opt *opt)
>  {
>  	struct grep_pat *p;
>  	struct grep_expr *header_expr =3D prep_header_patterns(opt);
> @@ -993,7 +903,7 @@ static void compile_grep_patterns_real(struct grep_=
opt *opt)
> =20
>  	if (opt->all_match || header_expr)
>  		opt->extended =3D 1;
> -	else if (!opt->extended && !opt->debug)
> +	else if (!opt->extended)
>  		return;
> =20
>  	p =3D opt->pattern_list;
> @@ -1016,13 +926,6 @@ static void compile_grep_patterns_real(struct gre=
p_opt *opt)
>  	opt->all_match =3D 1;
>  }
> =20
> -void compile_grep_patterns(struct grep_opt *opt)
> -{
> -	compile_grep_patterns_real(opt);
> -	if (opt->debug)
> -		dump_grep_expression(opt);
> -}
> -
>  static void free_pattern_expr(struct grep_expr *x)
>  {
>  	switch (x->node) {
> diff --git a/grep.h b/grep.h
> index b5c4e223a8f..5248c6ef7ea 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -136,7 +136,6 @@ struct grep_opt {
>  	int word_regexp;
>  	int fixed;
>  	int all_match;
> -	int debug;
>  #define GREP_BINARY_DEFAULT	0
>  #define GREP_BINARY_NOMATCH	1
>  #define GREP_BINARY_TEXT	2
> diff --git a/revision.c b/revision.c
> index 1bb590ece78..657e5502532 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2489,8 +2489,6 @@ static int handle_revision_opt(struct rev_info *r=
evs, int argc, const char **arg
>  	} else if ((argcount =3D parse_long_opt("grep", argv, &optarg))) {
>  		add_message_grep(revs, optarg);
>  		return argcount;
> -	} else if (!strcmp(arg, "--grep-debug")) {
> -		revs->grep_filter.debug =3D 1;
>  	} else if (!strcmp(arg, "--basic-regexp")) {
>  		revs->grep_filter.pattern_type_option =3D GREP_PATTERN_TYPE_BRE;
>  	} else if (!strcmp(arg, "--extended-regexp") || !strcmp(arg, "-E")) {
