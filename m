Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07C281F42D
	for <e@80x24.org>; Tue,  3 Apr 2018 00:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754698AbeDCAbk (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 20:31:40 -0400
Received: from mail-pl0-f41.google.com ([209.85.160.41]:32851 "EHLO
        mail-pl0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754695AbeDCAbi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 20:31:38 -0400
Received: by mail-pl0-f41.google.com with SMTP id s10-v6so4454519plp.0
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 17:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y/gFOba6HrIRb+sqx8ni43KfLZlU11lmCZqYejpw6qU=;
        b=D+49Tav+gg+Atx+gcflZyDQoKWF/7l9BpzfehqsDffmgPAH9LO1XQbKVg5vV0dWP1l
         HvR2Ksb5HX8cXuXSuWLGZ7bRG+gjHaoCisWjZc+I28SMXu92k9tBsKaMe7wzIR+NPfOx
         fM5TDT1Ao+5ctsD9sPVRr4na1noennjyLn7OzB4gt6br7wBLLRaXYbDg2jThihAp6rjP
         yRsyE3utMoLs/VSkpG0LmJcTje7LWxh1A1WfG8qrUK1y2onWQ5xRDUcB7qOv6H+e6rOb
         EXCjqNhmiXGUmGIyHPxTQIOq0dVyb3vN7wIwPmMFdpNAPfxGWS7eanQbdn7/GEMEmVy4
         QW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y/gFOba6HrIRb+sqx8ni43KfLZlU11lmCZqYejpw6qU=;
        b=noD+nRVHuOwvwpSHTxdnaIc3Y+aXeSxP9MEMOc7txewbm6Xs1f15+k9SPqrZNr+C6L
         /LER2dlaGy9ZsxtGklx6AMaf30d5Dx7RHYCjFgU+zqvMS+r6WViR1yJBTzQOFiHwmRHc
         v5K4jWpOuyUMZXcRdQ1mJnaRdYmha5upCmUcI6YaLOr6mdePGIDqsLMfX49yjR4lcfR4
         mDqZy5kO3FmmXBX4VqajsX60gtT9M7cnyv7YrtRDaPKOrMbGncCnh7AdBSampH6BVLcL
         N8Xj1ES9czOlunoa2BZWE3vV2+/DmKimTAurlEUjGNsusTPND83RKXE6NgB4pGqCqFGc
         M+wg==
X-Gm-Message-State: AElRT7G2wQiEGOM+42nMwR0Vk9sCDVvNSU0Yn1Gj1awYAooR+IA9/nwm
        nscrYxERsI3hU88Os1ahRrK9Zg==
X-Google-Smtp-Source: AIpwx4/FICQfkX1kavqGEPy53ZRDN6iN82PhtLwrLhD+aIsrvJ4GE94VnvUrVy2jjYDqSE6uu/C3Bg==
X-Received: by 10.101.91.67 with SMTP id y3mr5603410pgr.264.1522715497555;
        Mon, 02 Apr 2018 17:31:37 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id p14sm2153927pgu.44.2018.04.02.17.31.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Apr 2018 17:31:36 -0700 (PDT)
Date:   Mon, 2 Apr 2018 17:31:35 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     jacob.keller@gmail.com, simon@ruderich.org, git@vger.kernel.org
Subject: Re: [PATCH 6/7] diff.c: decouple white space treatment for move
 detection from generic option
Message-Id: <20180402173135.a6ea2bc1154781abac4dc21b@google.com>
In-Reply-To: <20180402224854.86922-7-sbeller@google.com>
References: <20180402224854.86922-1-sbeller@google.com>
        <20180402224854.86922-7-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon,  2 Apr 2018 15:48:53 -0700
Stefan Beller <sbeller@google.com> wrote:

> In the original implementation of the move detection logic we assumed that
> the choice for ignoring white space changes is the same for the move
> detection as it is for the generic diff.  It turns out this is wrong.

I don't think we can say that this is wrong - just that we decided that
it would be useful to allow different whitespace handling methods when
calculating the diff and when detecting moves.

> There are a couple of things where the user wants to input their
> decision into the diff machinery:
> 
> * Whether or not to ignore white space for the general diff detection.
>   This is covered with the -w, -b options already.
> * Whether the move detection ought to pay attention to white spaces
>   in general. And if so, how are white spaces handled for the block
>   detection.
> 
> One example would be reviewing a current patch under discussion, that moves
> code around.  In that case, you may want to have the general diff machinery
> not ignore the white spaces (i.e. exact matching), as that will show you
> the diff as the patch sent. The code moved however may have another
> indentation level, such that you want to ignore white spaces for the move
> detection. The code may be in python, such that spaces matter for program
> flow, though. That is why you'd want each block to have the same change
> in white space.
> 
> This patch decouples white space treatment in the general diff machinery
> from the white space treatment in the move detection.
> 
> This adds all the the options for ignoring white space that the regular
> diff machinery has to the move detection, such that we can cover all the
> cases that were introduced in 7a55427094 (Merge branch
> 'jk/diff-color-moved-fix', 2017-11-06).

I would just write the above as follows:

  Allow the user to specify that whitespace should be ignored
  differently during detection of moved lines than during generation of
  added and removed lines. This is done by providing analogs to the
  --ignore-space-at-eol, -b, and -w options (namely,
  --color-moved-[no-]ignore-space-at-eol <fill in the rest>) that affect
  only the color of the output, and making the existing
  --ignore-space-at-eol, -b, and -w options no longer affect the color
  of the output.

(And if the above is not clear enough that this is a
backwards-incompatible change, we might need to call it out.)

> The example from above (different lines in the diff with -w for the regular
> diff) is covered in a test. Convert the existing tests to be more explicit
> on their choice of white space behavior in the move detection as the tests
> should not fail if the default is changed.

This statement is confusing to me - of course the tests should fail,
since we changed the defaults. I think it is sufficient to just mention
that whitespace handling has to be explicitly specified for the move
detection part.

> +--color-moved-[no-]ignore-all-space::
> +	Ignore whitespace when comparing lines when performing the move
> +	detection for --color-moved.  This ignores differences even if
> +	one line has whitespace where the other line has none.
> +--color-moved-[no-]ignore-space-change::
> +	Ignore changes in amount of whitespace when performing the move
> +	detection for --color-moved.  This ignores whitespace
> +	at line end, and considers all other sequences of one or
> +	more whitespace characters to be equivalent.
> +--color-moved-[no-]ignore-space-at-eol::
> +	Ignore changes in whitespace at EOL when performing the move
> +	detection for --color-moved.

Optional: I would reorder this to be in the same order as the analogous
options (--ignore-space-at-eol first, then -b, then -w).

> @@ -720,7 +720,7 @@ static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
>  
>  	return !xdiff_compare_lines(a->es->line, a->es->len,
>  				    b->es->line, b->es->len,
> -				    diffopt->xdl_opts);
> +				    diffopt->color_moved & XDF_WHITESPACE_FLAGS);
>  }
>  
>  static struct moved_entry *prepare_entry(struct diff_options *o,
> @@ -728,8 +728,9 @@ static struct moved_entry *prepare_entry(struct diff_options *o,
>  {
>  	struct moved_entry *ret = xmalloc(sizeof(*ret));
>  	struct emitted_diff_symbol *l = &o->emitted_symbols->buf[line_no];
> +	unsigned flags = o->color_moved & XDF_WHITESPACE_FLAGS;
>  
> -	ret->ent.hash = xdiff_hash_string(l->line, l->len, o->xdl_opts);
> +	ret->ent.hash = xdiff_hash_string(l->line, l->len, flags);
>  	ret->es = l;
>  	ret->next_line = NULL;

These 2 changes looked suspicious to me at first, but then I saw that
moved_entry_cmp() and prepare_entry() are only used during move
detection.

> @@ -1419,7 +1422,10 @@ test_expect_success 'move detection ignoring whitespace ' '
>  	EOF
>  	test_cmp expected actual &&
>  
> -	git diff HEAD --no-renames -w --color-moved --color |
> +	git diff HEAD --no-renames --color-moved --color \
> +		--color-moved-ignore-all-space \
> +		--color-moved-no-ignore-space-change \
> +		--color-moved-no-ignore-space-at-eol |
>  		grep -v "index" |
>  		test_decode_color >actual &&
>  	cat <<-\EOF >expected &&

This change (removal of -w) looked suspicious to me at first, but then I
saw that the "-w" was only used to trigger whitespace insensitivity
during the move detection phase. (The line in question was moved, so "-"
and "+" lines would have been generated in the diff anyway regardless of
whether whitespace was ignored.) Same as to the other test
modifications.

> +test_expect_success 'move detection only ignores white spaces' '

This seems to be "only move detection ignores white spaces", not as
written. I would title this "--color-moved-ignore-all-space only ignores
whitespace during move detection".

> +	q_to_tab <<-\EOF >function.c &&
> +	int func()
> +	{
> +	Qif (foo) {
> +	QQ// this part of the function
> +	QQ// function will be very long
> +	QQ// indeed. We must exceed both
> +	QQ// per-line and number of line
> +	QQ// minimums
> +	QQ;
> +	Q}
> +	Qbaz();
> +	Qbar();
> +	Q// more unrelated stuff
> +	}
> +	EOF

Could the sample data be more concise? In particular, a few lines should
be sufficient for before:

  a long line to exceed per-line minimum
  another long line to exceed per-line minimum
  original file

and after:

  Qa long line to exceed per-line minimum
  Qanother long line to exceed per-line minimum
  new file

Then the ordinary diff (with -w) will only have "-" and "+" for
"original file" and "new file", and the one with only
--color-moved-ignore-all-space would have "-" and "+" for all lines.

> +	# Make sure we get a different diff using -w ("moved function header")

-w is not "moved function header", maybe reword.
