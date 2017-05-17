Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8849D2023D
	for <e@80x24.org>; Wed, 17 May 2017 05:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751104AbdEQFTj (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 01:19:39 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34782 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbdEQFTi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 01:19:38 -0400
Received: by mail-pg0-f67.google.com with SMTP id u187so383881pgb.1
        for <git@vger.kernel.org>; Tue, 16 May 2017 22:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jrLGtRsBwRzRBlWnw9l8npbRYTxQNVAB50gj1/spOqo=;
        b=irhxwFFa8IG/u/6E7/0LpKtW11jETKrbyVN8Fku3F1aimb91PNdQuXOs9t+T63cstt
         E1uljGlOlFxa28ura80zwZ4aljyLceTbS08eCh7Kc/PQrJZX/uiWT5AwJs4LhRnTHp+Y
         msSjg3b5N6T4wTVqadUrl2Mo/YrUkklmUOHWAfrcWJzt5MAzrDJuq8JdcEQ9ODtBJISX
         xz6FRBKyLufk5HjQv9rcK+18VutDMF8Au1BBVMi/htYeT0qSyg/Br+YLgQ8atB0wJqIV
         Bpvlsv8gtV8zHvdaP4eDl6jqHz9StcZG6U7FQkjiXrLII6ibcjzSNJgr+d52yhGJd3jc
         eO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jrLGtRsBwRzRBlWnw9l8npbRYTxQNVAB50gj1/spOqo=;
        b=rcYkR2v4H810LN4xvs+7YJINqH6XGFwwgoZmBDdU6PM21AlAPwE3QEwjEFivZf42ET
         NLv+UMDCPm6Gw8WHOi1lG22PsD0BPFoJ69d+KKFPHGe3EUR3/grhB0PVMQ9gfmfPvfQE
         oFzoNrhJqPdzCeVVdwln8usveNJ/Y3FqaWjoviEXwxbxpGSyV0d81lpbBXS2iP1ovgEX
         xF67yKf6LkAbWOV9jUQqAEWRlZiFM3Vf3o5AoIvDC7oKBy10KA9uVsFkj2OC4WZSgI+O
         TpEvGpj53rW/v7ctW/rNgWr+feqaNo35H3ZlbvXLN2/wsmlbcGEVrEI4rmFEUpxlXk5G
         09Jw==
X-Gm-Message-State: AODbwcBDZEnHnzq6XOtZCgIdIwVW9RHBD8kQRXqnCidEUioJmtzMRYZO
        V6K+QdPn6uz+lQ==
X-Received: by 10.98.27.194 with SMTP id b185mr1841692pfb.101.1494998377555;
        Tue, 16 May 2017 22:19:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:78bf:56b6:7690:fdbd])
        by smtp.gmail.com with ESMTPSA id z64sm1268812pfd.20.2017.05.16.22.19.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 22:19:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, jonathantanmy@google.com,
        bmwill@google.com, peff@peff.net, mhagger@alum.mit.edu
Subject: Re: [PATCHv2 12/20] submodule.c: convert show_submodule_summary to use emit_line_fmt
References: <20170514040117.25865-1-sbeller@google.com>
        <20170517025857.32320-1-sbeller@google.com>
        <20170517025857.32320-13-sbeller@google.com>
Date:   Wed, 17 May 2017 14:19:36 +0900
In-Reply-To: <20170517025857.32320-13-sbeller@google.com> (Stefan Beller's
        message of "Tue, 16 May 2017 19:58:49 -0700")
Message-ID: <xmqq8tlwxdp3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> In a later patch, I want to propose an option to detect&color
> moved lines in a diff, which cannot be done in a one-pass over
> the diff. Instead we need to go over the whole diff twice,
> because we cannot detect the first line of the two corresponding
> lines (+ and -) that got moved.
>
> So to prepare the diff machinery for two pass algorithms
> (i.e. buffer it all up and then operate on the result),
> move all emissions to places, such that the only emitting
> function is emit_line_0.
>
> This prepares the code for submodules to go through the
> emit_line function.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  diff.c      | 20 +++++++---------
>  diff.h      |  5 ++++
>  submodule.c | 78 ++++++++++++++++++++++++++++++-------------------------------
>  submodule.h |  9 +++----
>  4 files changed, 56 insertions(+), 56 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 690794aeb8..7c8d6a5d12 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -516,8 +516,8 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
>  	ecbdata->blank_at_eof_in_postimage = (at - l2) + 1;
>  }
>  
> -static void emit_line(struct diff_options *o, const char *set, const char *reset,
> -		      int add_line_prefix, int sign, const char *line, int len)
> +void emit_line(struct diff_options *o, const char *set, const char *reset,
> +	       int add_line_prefix, int sign, const char *line, int len)
>  {
>  	int has_trailing_newline, has_trailing_carriage_return;
>  	FILE *file = o->file;
> @@ -547,10 +547,10 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
>  		fputc('\n', file);
>  }
>  
> -static void emit_line_fmt(struct diff_options *o,
> -			  const char *set, const char *reset,
> -			  int add_line_prefix,
> -			  const char *fmt, ...)
> +void emit_line_fmt(struct diff_options *o,
> +		   const char *set, const char *reset,
> +		   int add_line_prefix,
> +		   const char *fmt, ...)

Interesting...

> -static void show_submodule_header(FILE *f, const char *path,
> -		const char *line_prefix,
> +static void show_submodule_header(struct diff_options *o, const char *path,
>  		struct object_id *one, struct object_id *two,
>  		unsigned dirty_submodule, const char *meta,
>  		const char *reset,

Is this ONLY called when the caller wants its output inserted to the
"diff" (or "log -p") output?  If so, I think it makes sense to pass
'o', but if the function is oblivious that it is driven to produce
part of a "diff", it feels wrong to pass 'o'.  The original was
taking a "FILE *" and line_prefix, so it is rather clear that the
answer to the question is "yes, this is very closely tied to diff
output".  Now you have access to 'o', so you do not need to pass
them separately.  Good.

Each line in its output, when incorporated in "diff" or "log -p"
output, must be prefixed with the line-prefix to accomodate users of
"log --graph", so I guess it cannot be helped.  Your calls to
emit_line_fmt() below seems to ask the line-prefix to be added,
which is good, too.

How does capturing these lines help moved line detection, by the
way?  These must never be matched with any other added or removed
line in the real patch output.

> @@ -426,11 +419,11 @@ static void show_submodule_header(FILE *f, const char *path,
>  	int fast_forward = 0, fast_backward = 0;
>  
>  	if (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
> -		fprintf(f, "%sSubmodule %s contains untracked content\n",
> -			line_prefix, path);
> +		emit_line_fmt(o, NULL, NULL, 1,
> +			      "Submodule %s contains untracked content\n", path);
>  	if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
> -		fprintf(f, "%sSubmodule %s contains modified content\n",
> -			line_prefix, path);
> +		emit_line_fmt(o, NULL, NULL, 1,
> +			      "Submodule %s contains modified content\n", path);
>  
>  	if (is_null_oid(one))
>  		message = "(new submodule)";

emit_line() and emit_line_fmt() are both inappropriate names for a
global function.  These are very closely tied to diff generation, so
we probably want to see some form of "diff" in their names.  

The fact that it is clear because its first parameter is "struct
diff_options" is insufficient---"you cannot tell what context the
function is meant to be used by only looking at its name" is
certainly solved by its function signature, but the other issue with
an overly generic name is that other codepaths in different contexts
may want to use such a short and sweet name.

Thanks.
