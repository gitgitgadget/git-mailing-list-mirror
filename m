Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 327FD1F731
	for <e@80x24.org>; Wed,  7 Aug 2019 05:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfHGFid (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 01:38:33 -0400
Received: from mout.web.de ([212.227.15.4]:41859 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbfHGFib (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 01:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1565156305;
        bh=rOTWg2SSiP1o1qfDURRGQomEJFKgqIUf7gUl385M6x8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=qyoMBLCLFOSE82H+so1kSoUtzS1c5ycVVZ9DaJdVE2eHaSp3lxdPxZuhGsBN0Kjm+
         45nJd9QCE5plgvx2Y1+VlS3r5z+ynH/sE7ieErAF6bmLTs/kO7apKW9lPxb/iJH2wm
         1RkbnYBlbu9pBK6j8FpQU6bfwPuNn7ZbCI5IF6Ic=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M9ome-1i1oEr2rl2-00B6uT; Wed, 07
 Aug 2019 07:38:25 +0200
Subject: Re: [RFC PATCH v3 2/3] grep: make PCRE2 aware of custom allocator
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, avarab@gmail.com,
        michal.kiedrowicz@gmail.com
References: <20190806085014.47776-1-carenas@gmail.com>
 <20190806163658.66932-1-carenas@gmail.com>
 <20190806163658.66932-3-carenas@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <ab8a378c-0a60-9554-b2dd-ecb3d05229cb@web.de>
Date:   Wed, 7 Aug 2019 07:38:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806163658.66932-3-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0To3bR7/D9WYv5sjEQpKOyWWYbnXpyqNlvms9F9L5s2iDVi9A3D
 3tB1b8VuS5a7jwHIF1M9E/CeeDgT3enTsR/+qi7f2jmmzSRG47BitMSTSl+TknF8Qz7RRbz
 N6EvOm3mC6Uv0LZbYvFOeRTbyEohCcyzP92BenrNFBDl79YoWJWN0+k8o1crYZCIJdpl/5n
 SW7Rhldvm1vCi3oJUBvew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W/Ob1hTXcDo=:U1bdX5G2BqAnCGCC8EekHg
 PDF3t6z33OT2qSjH9RFnnFJLHrA/2UjS8HJFfa0OUZx9AaekYE5hgv3shyEOklhv8gx0W5yIg
 pz96XwKIjtpT/+FMkqSYnvEl4tFLCbbxnRuL5J6EebRJalhIyDY98S4h5Jb27pfQWHDPYMZNe
 zLZAo844EEaDLWMY0GyJoKDSyKvsTmIhAEVpKcmrtYeirYiMvsVbJcvJIWQQpmcsLMPc1Frt9
 OL4NTQ/CrNPg9k6IOGiQZ95e/N+yieaVz4/C/VpfgkpZr/iVftKYGCRTmlsRzUYu9xDiSCL+K
 zY52xclY5iHzae/0mxcXFj6N2Q1W61oKORibUnI9jlPF9RIFUyxA42kz8a4Zn1E+mmezckdS7
 W0RRagj1DbwZcCf8BJoQ4zFRm8o9ngBCb/uef9vLnxAH1UUOCHQaEjBYftA7B+W9AS5uQrOS3
 SnudGmjrvdSWmqoCCgcCBLL1V2yT2zqKpCvSsB1OjIubisYHQ1WcWRbALOfm20kAR9G9AxpK3
 P+kjvzurrlN42/h7xWBRKTIH8a8J4Xtl1YEiTEZlYe68dmTBL1YfXnrHL5jJfQTtYnktFFAGp
 wChKOHHQzSLPMpkXVYNbu/JlVPt+KY7Spw/i+SznCxrkzBu9RE9yNJxaCfyYCBhJTqvMH/hMe
 N5zpO5xHHR/nqfAaok9z/jbx4EDIKOQfXKLNxdgIKrfC5jZKsoIFsSeCB5/wmeCRER3L6f1jA
 Wm/Hu9lFVssg6DmpH7HT0pX1Y7PUG7yGaJsg+mNZY4Y4If725xegParITFmiAVNG3Iss2IY4c
 wtBX3dgsxZcI5h+gBFOe0pHszAiHpe1MdNK0K78jUXC3753XES0BnZQxdFzBIS4GpPNxedsvr
 NEBcMhk869kUoDqPdOE+b5i9qCakRMmwhQLZ1EdYGx9flg1tQLY3bJ9Mi6Rjl/ZFWKt4QrhF2
 jw9AdiQbMc6qxwA72pw8/7DDyBOegxVhg+VpnvsNCKOcNFapQCHidZe2AbPac6pmSLYnkq3sH
 zEYvN59Pi2b58hg8t7CglJx47UQVvCEusL1yRepu2/HyF08mVc9fQ2U64s/7WIugjxsVfsyDD
 n2hWTBdiWXzbGFMwx2tU7pg1kXAXSKtA+ZrvyW0FnjQXY2LMGp7REFonDAYLz86HUvR+UrLni
 YThkU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.08.19 um 18:36 schrieb Carlo Marcelo Arenas Bel=C3=B3n:
> 94da9193a6 (grep: add support for PCRE v2, 2017-06-01) didn't include
> a way to override the system allocator, and so it is incompatible with
> USE_NED_ALLOCATOR.  The problem was made visible when an attempt to
> avoid a leak in a data structure that is created by the library was
> passed to NED's free for disposal triggering a segfault in Windows.
>
> PCRE2 requires the use of a general context to override the allocator
> and therefore, there is a lot more code needed than in PCRE1, including
> a couple of wrapper functions.
>
> Extend the grep API with a "destructor" that could be called to cleanup
> any objects that were created and used globally.
>
> Update builtin/grep to use that new API, but any other future
> users should make sure to have matching grep_init/grep_destroy calls
> if they are using the pattern matching functionality (currently only
> relevant when using both NED and PCRE2)
>
> Move some of the logic that was before done per thread (in the workers)
> into an earlier phase to avoid degrading performance

Which logic is moved?  In the patch I basically only see additions.

>, but as the use
> of PCRE2 with NED is better understood it is expected more of its
> functions will be instructed to use the custom allocator as well as
> was done in the original code[1] this work was based on.
>
> [1] https://public-inbox.org/git/3397e6797f872aedd18c6d795f4976e1c579514=
b.1565005867.git.gitgitgadget@gmail.com/

I'm not sure I understand that part.  Do you mean there are gaps of
knowledge about nedmalloc and/or PCRE2 and/or their interaction?  And
someone is working on closing those gaps, and is going to submit more
patches in the process?

Your patch uses a custom global context only if USE_NED_ALLOCATOR is
defined, while [1] does it unconditionally.  The latter is easier to
debug and requires less preprocessor directives.  What's the upside
of your approach?

>
> Reported-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  builtin/grep.c |  1 +
>  grep.c         | 36 +++++++++++++++++++++++++++++++++++-
>  grep.h         |  1 +
>  3 files changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 560051784e..e49c20df60 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -1145,5 +1145,6 @@ int cmd_grep(int argc, const char **argv, const ch=
ar *prefix)
>  		run_pager(&opt, prefix);
>  	clear_pathspec(&pathspec);
>  	free_grep_patterns(&opt);
> +	grep_destroy();
>  	return !hit;
>  }
> diff --git a/grep.c b/grep.c
> index 0154998695..3e5bdf94a6 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -16,6 +16,22 @@ static int grep_source_is_binary(struct grep_source *=
gs,
>
>  static struct grep_opt grep_defaults;
>
> +#ifdef USE_LIBPCRE2
> +static pcre2_general_context *pcre2_global_context;
> +
> +#ifdef USE_NED_ALLOCATOR
> +static void *pcre2_malloc(PCRE2_SIZE size, MAYBE_UNUSED void *memory_da=
ta)
> +{
> +	return malloc(size);

Should this be xmalloc() to get consistent out-of-memory handling?

> +}
> +
> +static void pcre2_free(void *pointer, MAYBE_UNUSED void *memory_data)
> +{
> +	return free(pointer);
> +}
> +#endif
> +#endif
> +
>  static const char *color_grep_slots[] =3D {
>  	[GREP_COLOR_CONTEXT]	    =3D "context",
>  	[GREP_COLOR_FILENAME]	    =3D "filename",
> @@ -153,6 +169,7 @@ int grep_config(const char *var, const char *value, =
void *cb)
>   *
>   * If using PCRE make sure that the library is configured
>   * to use the right allocator (ex: NED)
> + * if any object is created it should be cleaned up in grep_destroy()
>   */
>  void grep_init(struct grep_opt *opt, struct repository *repo, const cha=
r *prefix)
>  {
> @@ -188,6 +205,13 @@ void grep_init(struct grep_opt *opt, struct reposit=
ory *repo, const char *prefix
>  		color_set(opt->colors[i], def->colors[i]);
>  }
>
> +void grep_destroy(void)
> +{
> +#ifdef USE_LIBPCRE2
> +	pcre2_general_context_free(pcre2_global_context);
> +#endif
> +}
> +
>  static void grep_set_pattern_type_option(enum grep_pattern_type pattern=
_type, struct grep_opt *opt)
>  {
>  	/*
> @@ -319,6 +343,11 @@ void append_header_grep_pattern(struct grep_opt *op=
t,
>  void append_grep_pattern(struct grep_opt *opt, const char *pat,
>  			 const char *origin, int no, enum grep_pat_token t)
>  {
> +#if defined(USE_LIBPCRE2) && defined(USE_NED_ALLOCATOR)
> +	if (!pcre2_global_context && opt->ignore_case && has_non_ascii(pat))
> +		pcre2_global_context =3D pcre2_general_context_create(
> +					pcre2_malloc, pcre2_free, NULL);
> +#endif
>  	append_grep_pat(opt, pat, strlen(pat), origin, no, t);
>  }
>
> @@ -507,9 +536,14 @@ static void compile_pcre2_pattern(struct grep_pat *=
p, const struct grep_opt *opt
>
>  	p->pcre2_compile_context =3D NULL;
>
> +	/* pcre2_global_context is initialized in append_grep_pattern */
>  	if (opt->ignore_case) {
>  		if (has_non_ascii(p->pattern)) {
> -			character_tables =3D pcre2_maketables(NULL);
> +#ifdef USE_NED_ALLOCATOR
> +			if (!pcre2_global_context)
> +				BUG("pcre2_global_context uninitialized");

[1] initializes on demand.  Why not do that?  To avoid race conditions
that would lead to occasional double-allocation of the global context?

> +#endif
> +			character_tables =3D pcre2_maketables(pcre2_global_context);
>  			p->pcre2_compile_context =3D pcre2_compile_context_create(NULL);

Don't you want to pass pcre2_global_context here as well?  And [1] even
uses it in some more places.

Oh, that's the "expected more" when "better understood" part from the
commit message, right?

Basically I'd expect the custom global context to be used for all PCRE2
allocations; I can't think of a reason for mixing allocators (e.g.
system malloc for PCRE2 regexes and nedmalloc for everything else).

>  			pcre2_set_character_tables(p->pcre2_compile_context, character_table=
s);
>  		}
> diff --git a/grep.h b/grep.h
> index 1875880f37..526c2db9ef 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -189,6 +189,7 @@ struct grep_opt {
>  void init_grep_defaults(struct repository *);
>  int grep_config(const char *var, const char *value, void *);
>  void grep_init(struct grep_opt *, struct repository *repo, const char *=
prefix);
> +void grep_destroy(void);
>  void grep_commit_pattern_type(enum grep_pattern_type, struct grep_opt *=
opt);
>
>  void append_grep_pat(struct grep_opt *opt, const char *pat, size_t patl=
en, const char *origin, int no, enum grep_pat_token t);
>
