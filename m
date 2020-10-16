Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A85C43457
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 15:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B0BE20866
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 15:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIe9IQ6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410278AbgJPPdB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 11:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404478AbgJPPcy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 11:32:54 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CFBC0613D6
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 08:32:53 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id e23so2857271wme.2
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 08:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VbzDCv7aoFu5IU7YFRlAf5jY8QEDHx4mxdMEW1ojOZ4=;
        b=MIe9IQ6PVbuLYVtjGVDjkMTkgEIYGo+zPoCSw/kkxOs3JlaD4omLDlBacy4GvNhMld
         GL7Xx8F+0K7YwjT0Be6TkZS095ChzOyaRNNSqgoEcqUIB1BDhoXQwi2TSv5NjMHt7EYB
         9f1okqHglpOWgoVL0N5avNM8+diSkzQN61JrOvggwo73ejHgG5FbW+R3z8qLEm32x1v7
         ks8gmmYs7EHVP0kYZDJZyuk9Gw1zCCH+qQs82f2F3LykzQBfDBOfwibN1ADaaZm3ss0k
         ndNMjc465VqrfvBbdRP/c76XY4AeAA5HJwPMnP1hLRfk2rMKVBOYc7ywJoY0IFI/i+Wh
         HIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VbzDCv7aoFu5IU7YFRlAf5jY8QEDHx4mxdMEW1ojOZ4=;
        b=Ul6d10OzNTLuJEB9rKv6XzstgOAF+4yxCYO6gaRlzeq6SSgIwI3hb4gtWtlJgvuOcX
         hwKTL0rAgKHqsgUEFlSAuCfgDQWiQDHq+Caow5sFWtD18j3U3Xpvli3d6EKUzNPfLs/v
         IdUKwRqY/fA553E93CjSYVr4qmZRyAKBMZERQAtL3BCU+cQdmi+Q+/w2MUZj2s7Dq/DY
         Hbho141xVnYLL/MZxAxviuBAxtBzGJ0E7Mv/8F4BMyb2BvH1oaxizBY1ZQoWXgkdz/0Z
         ZoNCljnVOf78wHXTUfnOIdKA6uFMcDNYXE9hpiZd2Zi517yHYHFXRsl+/Xmzj91aEfFD
         0tug==
X-Gm-Message-State: AOAM53166s+hBK0sTGQzglKV2I2aAWytMld6Djs4r0YnNXt8bK8x4dLU
        p6P6A2iWPx6w+OMTJF6OohB0DaQOa0A=
X-Google-Smtp-Source: ABdhPJwYUGXHI5j414buTpiEyJdwnhbdc+uwl1Xe5YEmC/bfNRkxyG6Hr6qMoEcdzSghx8vC8wg4GA==
X-Received: by 2002:a1c:a184:: with SMTP id k126mr4329739wme.39.1602862372166;
        Fri, 16 Oct 2020 08:32:52 -0700 (PDT)
Received: from [192.168.1.240] (48.45.90.146.dyn.plus.net. [146.90.45.48])
        by smtp.gmail.com with ESMTPSA id 88sm4236701wrl.76.2020.10.16.08.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 08:32:51 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/2] diff: add -I<regex> that ignores matching changes
To:     =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>,
        git@vger.kernel.org
References: <20201012091751.19594-1-michal@isc.org>
 <20201015072406.4506-1-michal@isc.org> <20201015072406.4506-3-michal@isc.org>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <afd3b1cf-b883-6df5-bea5-28f8e06d8702@gmail.com>
Date:   Fri, 16 Oct 2020 16:32:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201015072406.4506-3-michal@isc.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michał

Thanks for working on this, it will be a useful addition. Unfortunately 
there's a use-after-free error see below

On 15/10/2020 08:24, Michał Kępień wrote:
> Add a new diff option that enables ignoring changes whose all lines
> (changed, removed, and added) match a given regular expression.  This is
> similar to the -I/--ignore-matching-lines option in standalone diff
> utilities and can be used e.g. to ignore changes which only affect code
> comments or to look for unrelated changes in commits containing a large
> number of automatically applied modifications (e.g. a tree-wide string
> replacement).  The difference between -G/-S and the new -I option is
> that the latter filters output on a per-change basis.
> 
> Use the 'ignore' field of xdchange_t for marking a change as ignored or
> not.  Since the same field is used by --ignore-blank-lines, identical
> hunk emitting rules apply for --ignore-blank-lines and -I.  These two
> options can also be used together in the same git invocation (they are
> complementary to each other).
> 
> Rename xdl_mark_ignorable() to xdl_mark_ignorable_lines(), to indicate
> that it is logically a "sibling" of xdl_mark_ignorable_regex() rather
> than its "parent".
> 
> Signed-off-by: Michał Kępień <michal@isc.org>
> ---
>   Documentation/diff-options.txt |  5 ++++
>   diff.c                         | 28 ++++++++++++++++++++
>   diff.h                         |  4 +++
>   t/t4013-diff-various.sh        | 33 ++++++++++++++++++++++++
>   xdiff/xdiff.h                  |  4 +++
>   xdiff/xdiffi.c                 | 47 ++++++++++++++++++++++++++++++++--
>   6 files changed, 119 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 573fb9bb71..ee52b65e46 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -687,6 +687,11 @@ endif::git-format-patch[]
>   --ignore-blank-lines::
>   	Ignore changes whose lines are all blank.
>   
> +-I<regex>::
> +--ignore-matching-lines=<regex>::
> +	Ignore changes whose all lines match <regex>.  This option may
> +	be specified more than once.
> +
>   --inter-hunk-context=<lines>::
>   	Show the context between diff hunks, up to the specified number
>   	of lines, thereby fusing hunks that are close to each other.
> diff --git a/diff.c b/diff.c
> index 2bb2f8f57e..677de23352 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3587,6 +3587,8 @@ static void builtin_diff(const char *name_a,
>   		if (header.len && !o->flags.suppress_diff_headers)
>   			ecbdata.header = &header;
>   		xpp.flags = o->xdl_opts;
> +		xpp.ignore_regex = o->ignore_regex;
> +		xpp.ignore_regex_nr = o->ignore_regex_nr;
>   		xpp.anchors = o->anchors;
>   		xpp.anchors_nr = o->anchors_nr;
>   		xecfg.ctxlen = o->context;
> @@ -3716,6 +3718,8 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
>   		memset(&xpp, 0, sizeof(xpp));
>   		memset(&xecfg, 0, sizeof(xecfg));
>   		xpp.flags = o->xdl_opts;
> +		xpp.ignore_regex = o->ignore_regex;
> +		xpp.ignore_regex_nr = o->ignore_regex_nr;
>   		xpp.anchors = o->anchors;
>   		xpp.anchors_nr = o->anchors_nr;
>   		xecfg.ctxlen = o->context;
> @@ -5203,6 +5207,22 @@ static int diff_opt_patience(const struct option *opt,
>   	return 0;
>   }
>   
> +static int diff_opt_ignore_regex(const struct option *opt,
> +				 const char *arg, int unset)
> +{
> +	struct diff_options *options = opt->value;
> +	regex_t *regex;
> +
> +	BUG_ON_OPT_NEG(unset);
> +	regex = xmalloc(sizeof(*regex));
> +	if (regcomp(regex, arg, REG_EXTENDED | REG_NEWLINE))
> +		return error(_("invalid regex given to -I: '%s'"), arg);
> +	ALLOC_GROW(options->ignore_regex, options->ignore_regex_nr + 1,
> +		   options->ignore_regex_alloc);
> +	options->ignore_regex[options->ignore_regex_nr++] = regex;
> +	return 0;
> +}
> +
>   static int diff_opt_pickaxe_regex(const struct option *opt,
>   				  const char *arg, int unset)
>   {
> @@ -5491,6 +5511,9 @@ static void prep_parse_options(struct diff_options *options)
>   		OPT_BIT_F(0, "ignore-blank-lines", &options->xdl_opts,
>   			  N_("ignore changes whose lines are all blank"),
>   			  XDF_IGNORE_BLANK_LINES, PARSE_OPT_NONEG),
> +		OPT_CALLBACK_F('I', "ignore-matching-lines", options, N_("<regex>"),
> +			       N_("ignore changes whose all lines match <regex>"),
> +			       0, diff_opt_ignore_regex),
>   		OPT_BIT(0, "indent-heuristic", &options->xdl_opts,
>   			N_("heuristic to shift diff hunk boundaries for easy reading"),
>   			XDF_INDENT_HEURISTIC),
> @@ -6405,6 +6428,11 @@ void diff_flush(struct diff_options *options)
>   	DIFF_QUEUE_CLEAR(q);
>   	if (options->close_file)
>   		fclose(options->file);
> +	for (i = 0; i < options->ignore_regex_nr; i++) {
> +		regfree(options->ignore_regex[i]);
> +		free(options->ignore_regex[i]);
> +	}
> +	free(options->ignore_regex);

If I run `git log -p -I foo` then the address sanitizer reports

AddressSanitizer: heap-use-after-free xdiff/xdiffi.c:1027 in 
record_matches_regex

after it has printed the diff for the first commit. I think freeing the 
regex here is the cause of the problem.

Best Wishes

Phillip

>   	/*
>   	 * Report the content-level differences with HAS_CHANGES;
> diff --git a/diff.h b/diff.h
> index 11de52e9e9..a402227b80 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -234,6 +234,10 @@ struct diff_options {
>   	 */
>   	const char *pickaxe;
>   
> +	/* -I<regex> */
> +	regex_t **ignore_regex;
> +	size_t ignore_regex_nr, ignore_regex_alloc;
> +
>   	const char *single_follow;
>   	const char *a_prefix, *b_prefix;
>   	const char *line_prefix;
> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index 5c7b0122b4..efaaee2ef0 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -6,6 +6,7 @@
>   test_description='Various diff formatting options'
>   
>   . ./test-lib.sh
> +. "$TEST_DIRECTORY"/diff-lib.sh
>   
>   test_expect_success setup '
>   
> @@ -473,4 +474,36 @@ test_expect_success 'diff-tree --stdin with log formatting' '
>   	test_cmp expect actual
>   '
>   
> +test_expect_success 'diff -I<regex>' '
> +	test_seq 50 >I.txt &&
> +	sed -e "s/13/ten and three/" -e "/7\$/d" <I.txt >J.txt &&
> +	echo >>J.txt &&
> +
> +	test_expect_code 1 git diff --no-index --ignore-blank-lines -I"ten.*e" -I"^[124-9]" I.txt J.txt >actual &&
> +	cat >expect <<-\EOF &&
> +	diff --git a/I.txt b/J.txt
> +	--- a/I.txt
> +	+++ b/J.txt
> +	@@ -34,7 +31,6 @@
> +	 34
> +	 35
> +	 36
> +	-37
> +	 38
> +	 39
> +	 40
> +	EOF
> +	compare_diff_patch expect actual &&
> +
> +	test_expect_code 1 git diff --stat --no-index --ignore-blank-lines -I"ten.*e" -I"^[124-9]" I.txt J.txt >actual &&
> +	cat >expect <<-\EOF &&
> +	 I.txt => J.txt | 1 -
> +	 1 file changed, 1 deletion(-)
> +	EOF
> +	test_cmp expect actual &&
> +
> +	test_expect_code 129 git diff --no-index --ignore-matching-lines="^[124-9]" --ignore-matching-lines="^[124-9" I.txt J.txt >output 2>&1 &&
> +	test_i18ngrep "invalid regex given to -I: " output
> +'
> +
>   test_done
> diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
> index 032e3a9f41..7a04605146 100644
> --- a/xdiff/xdiff.h
> +++ b/xdiff/xdiff.h
> @@ -79,6 +79,10 @@ typedef struct s_mmbuffer {
>   typedef struct s_xpparam {
>   	unsigned long flags;
>   
> +	/* -I<regex> */
> +	regex_t **ignore_regex;
> +	size_t ignore_regex_nr;
> +
>   	/* See Documentation/diff-options.txt. */
>   	char **anchors;
>   	size_t anchors_nr;
> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> index bd035139f9..380eb728ed 100644
> --- a/xdiff/xdiffi.c
> +++ b/xdiff/xdiffi.c
> @@ -998,7 +998,7 @@ static int xdl_call_hunk_func(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
>   	return 0;
>   }
>   
> -static void xdl_mark_ignorable(xdchange_t *xscr, xdfenv_t *xe, long flags)
> +static void xdl_mark_ignorable_lines(xdchange_t *xscr, xdfenv_t *xe, long flags)
>   {
>   	xdchange_t *xch;
>   
> @@ -1019,6 +1019,46 @@ static void xdl_mark_ignorable(xdchange_t *xscr, xdfenv_t *xe, long flags)
>   	}
>   }
>   
> +static int record_matches_regex(xrecord_t *rec, xpparam_t const *xpp) {
> +	regmatch_t regmatch;
> +	int i;
> +
> +	for (i = 0; i < xpp->ignore_regex_nr; i++)
> +		if (!regexec_buf(xpp->ignore_regex[i], rec->ptr, rec->size, 1,
> +				 &regmatch, 0))
> +			return 1;
> +
> +	return 0;
> +}
> +
> +static void xdl_mark_ignorable_regex(xdchange_t *xscr, const xdfenv_t *xe,
> +				     xpparam_t const *xpp)
> +{
> +	xdchange_t *xch;
> +
> +	for (xch = xscr; xch; xch = xch->next) {
> +		xrecord_t **rec;
> +		int ignore = 1;
> +		long i;
> +
> +		/*
> +		 * Do not override --ignore-blank-lines.
> +		 */
> +		if (xch->ignore)
> +			continue;
> +
> +		rec = &xe->xdf1.recs[xch->i1];
> +		for (i = 0; i < xch->chg1 && ignore; i++)
> +			ignore = record_matches_regex(rec[i], xpp);
> +
> +		rec = &xe->xdf2.recs[xch->i2];
> +		for (i = 0; i < xch->chg2 && ignore; i++)
> +			ignore = record_matches_regex(rec[i], xpp);
> +
> +		xch->ignore = ignore;
> +	}
> +}
> +
>   int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
>   	     xdemitconf_t const *xecfg, xdemitcb_t *ecb) {
>   	xdchange_t *xscr;
> @@ -1038,7 +1078,10 @@ int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
>   	}
>   	if (xscr) {
>   		if (xpp->flags & XDF_IGNORE_BLANK_LINES)
> -			xdl_mark_ignorable(xscr, &xe, xpp->flags);
> +			xdl_mark_ignorable_lines(xscr, &xe, xpp->flags);
> +
> +		if (xpp->ignore_regex)
> +			xdl_mark_ignorable_regex(xscr, &xe, xpp);
>   
>   		if (ef(&xe, xscr, ecb, xecfg) < 0) {
>   
> 
