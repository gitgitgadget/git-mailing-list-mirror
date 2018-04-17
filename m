Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D4961F404
	for <e@80x24.org>; Tue, 17 Apr 2018 03:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeDQDRf (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 23:17:35 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35993 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751793AbeDQDRe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 23:17:34 -0400
Received: by mail-wr0-f194.google.com with SMTP id q13so27836754wre.3
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 20:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xwlCWb6ZflixwE4pOpMx44t6+KoCcWLeDq7TtTH+P8I=;
        b=gzOln8nYupFroPnKnXd2Uk2thMUY1dVr4OO0WQdmQwjc2N1tD5npY9EiiQ00DstMGS
         M8ALWJ06bbn6D8CMaSanzJpNjjrFKprtiFOOlUI6bfoMbCz+VSzSYIsfwUq/9v8Pj9Ed
         AOyZZMfi2bqsHqmDWyZ03dhfUzyWgsy2awlhjotSz4VhUPg9DKDK7plUjvlsEnPiFc03
         +eGmpm1puU5ayTAD5lb+NW802jDVs2iM//gpltLC9D8YUPlXNno9eLsPN+WKnVUB0+U4
         RR8x+ixZKiu7/pcqpRD0/TTNsYf96n+EHBwp8Yn5gTowsuBj4pAfEyiWrJqkAeclC8/W
         HUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xwlCWb6ZflixwE4pOpMx44t6+KoCcWLeDq7TtTH+P8I=;
        b=kPQ5kZpxsC74yWTxggu1K45nFhVfs91qSsuAjqX3KN0ixAsqCoz6QJG+LrqoVeujRg
         Xkik28oTVlW2CIftuI5lZCbYOKBKiZQfFUwvXFqpNJtwPOjrt0hxb7ibFD57iZ9qXQA3
         nVAwqTntbNLIh5LjTMoEbGbnHgiWJy9SEEHLxwB78fL8YS6jN6TX42qu+nGRBOzSXE9S
         gFGygE4npl77YIb+jKUB/M63hJxkO+gNB1IP0wnliEgRahQebvqPVFF3FPj7nM6XewpW
         UJo74OSL0T3+x9qo0+0Rd69tPxecHwwiGb5oBPKcU2McasWToS3FkLrv296mXvM/sD+d
         WZ+g==
X-Gm-Message-State: ALQs6tC3MP/H7dxGCvo/NfH7J6B3RI3E9dZJhdVUo1qFE7eqGJb/YZbT
        Kq8jmeC/SxSn849CbpK6MFg=
X-Google-Smtp-Source: AIpwx4/2Pif6WC46KlIjP7wEBV1p16O4S+IxoSeixXLLvn++Vpj++fEg0I7M2m63aFmk4tiwSKuUUw==
X-Received: by 10.28.145.139 with SMTP id t133mr424626wmd.138.1523935052776;
        Mon, 16 Apr 2018 20:17:32 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u138sm10631620wmu.24.2018.04.16.20.17.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Apr 2018 20:17:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH 1/2] builtin/blame: dim uninteresting metadata lines
References: <20180416220955.46163-1-sbeller@google.com>
        <20180416220955.46163-2-sbeller@google.com>
Date:   Tue, 17 Apr 2018 12:17:31 +0900
In-Reply-To: <20180416220955.46163-2-sbeller@google.com> (Stefan Beller's
        message of "Mon, 16 Apr 2018 15:09:54 -0700")
Message-ID: <xmqqk1t6v7w4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> @@ -316,10 +318,11 @@ static const char *format_time(timestamp_t time, const char *tz_str,
>  #define OUTPUT_PORCELAIN	010
>  #define OUTPUT_SHOW_NAME	020
>  #define OUTPUT_SHOW_NUMBER	040
> -#define OUTPUT_SHOW_SCORE      0100
> -#define OUTPUT_NO_AUTHOR       0200
> +#define OUTPUT_SHOW_SCORE	0100
> +#define OUTPUT_NO_AUTHOR	0200

I wondered what these are about; they are about aligning with HT
assuming 8-place tab stop like the other lines.

>  #define OUTPUT_SHOW_EMAIL	0400
> -#define OUTPUT_LINE_PORCELAIN 01000
> +#define OUTPUT_LINE_PORCELAIN 	01000

But then this line has SP plus HT here; it should have been just a
single HT (i.e. replace a single SP with HT), to be consistent.

> +#define OUTPUT_COLOR_LINE	02000
>  
>  static void emit_porcelain_details(struct blame_origin *suspect, int repeat)
>  {
> @@ -375,6 +378,7 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
>  	struct commit_info ci;
>  	char hex[GIT_MAX_HEXSZ + 1];
>  	int show_raw_time = !!(opt & OUTPUT_RAW_TIMESTAMP);
> +	const char *color = "", *reset = "";
>  
>  	get_commit_info(suspect->commit, &ci, 1);
>  	oid_to_hex_r(hex, &suspect->commit->object.oid);
> @@ -384,6 +388,19 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
>  		char ch;
>  		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? GIT_SHA1_HEXSZ : abbrev;
>  
> +		if (!(opt & OUTPUT_ANNOTATE_COMPAT)) {
> +			if (opt & OUTPUT_COLOR_LINE) {
> +				if (cnt > 0) {
> +					color = repeated_meta_color;
> +					reset = GIT_COLOR_RESET;
> +				} else  {
> +					color ="";

You need a SP after '=' that assigns an empty string to 'color'.

> +					reset = "";
> +				}
> +			}
> +			fputs(color, stdout);
> +		}

This fputs() should be hidden to the case where color is *NOT* an
empty string, no?  In any case, it should be inside "if color-line
is in effect" block, I would think.

Users of "git annotate" would not pass the --color option, so I do
not think the outer if () block is worth the loss of readability due
to increased indent level.  

I would say that it is a job of the caller of git_config() to make
sure color.blame.lines would not take effect when the command is
annotate, if what you are worried about is the configuration in this
code.

> @@ -433,6 +450,9 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
>  			printf(" %*d) ",
>  			       max_digits, ent->lno + 1 + cnt);
>  		}
> +		if (!(opt & OUTPUT_ANNOTATE_COMPAT) &&
> +		    (opt & OUTPUT_COLOR_LINE))
> +			fputs(reset, stdout);

Likewise.

> @@ -949,8 +979,12 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>  
>  	blame_coalesce(&sb);
>  
> -	if (!(output_option & OUTPUT_PORCELAIN))
> +	if (!(output_option & OUTPUT_PORCELAIN)) {
>  		find_alignment(&sb, &output_option);
> +		if (!*repeated_meta_color &&
> +		    (output_option & OUTPUT_COLOR_LINE))
> +			strcpy(repeated_meta_color, GIT_COLOR_DARK);
> +	}

This code does not check OUTPUT_ANNOTATE_COMPAT because it assumes
that OUTPUT_COLOR_LINE won't be in output_option when we are working
in annotate compatibility mode.  The deeper codepaths we saw above
should do the same.  It should be enough to drop color-line when
anno-compat is set, or something like that, immediately after
reading the config and overriding them from the command line.

> diff --git a/color.h b/color.h
> index cd0bcedd08..196be16058 100644
> --- a/color.h
> +++ b/color.h
> @@ -30,6 +30,7 @@ struct strbuf;
>  #define GIT_COLOR_BLUE		"\033[34m"
>  #define GIT_COLOR_MAGENTA	"\033[35m"
>  #define GIT_COLOR_CYAN		"\033[36m"
> +#define GIT_COLOR_DARK		"\033[1;30m"
>  #define GIT_COLOR_BOLD_RED	"\033[1;31m"
>  #define GIT_COLOR_BOLD_GREEN	"\033[1;32m"
>  #define GIT_COLOR_BOLD_YELLOW	"\033[1;33m"

I wonder if it is worth adding a new color only to give this a
different default.  

Traditionally, we use CYAN for lines that are less interesting than
others (e.g. hunk header), so reusing it might make the life easier
to the users, especially because I envision that we may want to
introduce another "logical" level to give another redirection
between the configuration keys like color.diff.frag and
color.blame.repeatedlines and the actual ANSI sequence like
"\033[36m".  I.e. we update the system so that these two
configuration keys take "uninteresting" (which is one of the
"logical" colors) by default, and then map "uninteresting" to
"\033[36m" at the physical level by default.  The users could then
change the mapping from "uninteresting" to "\033[1;30m" and
consistently modify both diff.frag and blame.repeated if they wanted
to.  Of course, if they want them to be different, they can come up
with a different "logical" color and split the two.  And from that
point of view, adding new colors to the default set we have above
will make life harder for the end users.


