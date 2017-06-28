Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED33B2023D
	for <e@80x24.org>; Wed, 28 Jun 2017 03:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753412AbdF1Dbg (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 23:31:36 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33156 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752633AbdF1Dbf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 23:31:35 -0400
Received: by mail-pf0-f194.google.com with SMTP id e199so7190130pfh.0
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 20:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=reUEGLo4v2z2xLp2S4hItogTdoFXR6a47F4TPsCDYw8=;
        b=INomacL+RBYB3IBpd7rBcjlnc7aKM6Y70oY8B9986A7a6XHdJrketRDUpc6Bs6p1+l
         wr23NG3x6CQygrCFJKzm4WDCbVRN6aArWkdDtNk/gVuGEN0wH7HKZ1RoY91SenEEkOhK
         AqfvUX9wtDLHTBZADf5/9AnZxXbJUIVcxN2y+MtAS5CLI1QZGvSVZyN1nwwTZEiNzrig
         vKgTiyJTUhj3Ff3lSCA9Y1jjQxyeo9iRL94nxj0WxlUR3yxv68jszdKahX2YZJXdKHlM
         6eH54G0l2BroDOcuLdr1LjKd2D7tvftEeI39Pil6/jISHabzLX6qT4cjrZYR3DAtEfCp
         fDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=reUEGLo4v2z2xLp2S4hItogTdoFXR6a47F4TPsCDYw8=;
        b=lbVGSccTNCbCM3yQ59HPfwnJkCEreLne94oVNtkCKZzLchS4zEPNuxoyUtoS0xf9KJ
         agRwxR9PJGZ/Dfyp1G4iyyWKy71XpbH9ZJAs3BERta4J7++indbnCroQSFalMaZA4hIO
         h4sSjRfbNYt8ojK7hX94IRCp64/H9Kr8ts9QQ+bB01+iVWmHhq//l8THabC0EaNUDLYt
         fsqodIZ1uA6x6k7jYHemjDZO/la0HrVYtxd0+DL0+XeQNpF0zi7O3HI8HMxWwHsILvQ0
         O2ufYYKPzU7ff3eaJ/jH72TN9ZF8MoasS7iAcKQKqCWIU7HXRe4t4Y2DY3SUlaLxv5r1
         VMgQ==
X-Gm-Message-State: AKS2vOz1UE9M9a+C0U75WYLKb2zGHUjhqOk86xrU7n/yqTlLIaBOX13I
        5N0pbF5i8IMRM9VbWxw=
X-Received: by 10.98.36.19 with SMTP id r19mr1747457pfj.95.1498620694227;
        Tue, 27 Jun 2017 20:31:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3095:bb54:d256:9ca9])
        by smtp.gmail.com with ESMTPSA id f85sm1210351pfj.6.2017.06.27.20.31.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 20:31:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net
Subject: Re: [PATCH 5/6] diff.c: omit uninteresting moved lines
References: <20170628005651.8110-1-sbeller@google.com>
        <20170628005651.8110-6-sbeller@google.com>
Date:   Tue, 27 Jun 2017 20:31:32 -0700
In-Reply-To: <20170628005651.8110-6-sbeller@google.com> (Stefan Beller's
        message of "Tue, 27 Jun 2017 17:56:50 -0700")
Message-ID: <xmqqwp7wyei3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> It is useful to have moved lines colored, but there are annoying corner
> cases, such as a single line moved, that is very common. For example
> in a typical patch of C code, we have closing braces that end statement
> blocks or functions.
>
> While it is technically true that these lines are moved as they show up
> elsewhere, it is harmful for the review as the reviewers attention is
> drawn to such a minor side annoyance.
>
> One of the first solutions considered, started off by these hypothesis':

Hypotheses is the plural form of that word, I think.

>   (a) The more blocks of the same code we have, the less interesting it is.
>   (b) The shorter a block of moved code is the less need of markup there
>       is for review.
>
>       Introduce a heuristic which drops any potential moved blocks if their
>       length is shorter than the number of potential moved blocks.
>
>       This heuristic was chosen as it is agnostic of the content (in other
>       languages or contents to manage, we may have longer lines, e.g. in
>       shell the closing of a condition is already 2 characters. Thinking
>       about Latex documents tracked in Git, there can also be some
>       boilerplate code with lots of characters) while taking both
>       hypothesis' into account. An alternative considered was the number
>       of non-whitespace characters in a line for example.

It was puzzling what the above two paragraphs were.  I took (a) and
(b) were the hypotheses, and the two above, and also the next
paragraphs, were the design that fell out of them.  But that is not
what is happening.  You changed your mind and settled on the design
in the next paragraph.

Perhaps we can do without all of the "I thought about this but it
didn't make sense" that is longer than the solution in the patch?

> Thinking further about this, a linear relation between number of moved
> blocks and number of lines of code seems like a bad idea to start with.
> So let's start with a simpler solution of hardcoding the number of lines
> to 3.
>
> Note, that the length is applied across all blocks to find the 'lonely'
> blocks that pollute new code, but do not interfere with a permutated
> block where each permutation has less lines than 3.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  diff.c | 11 ++++++++++-
>  diff.h |  1 +
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/diff.c b/diff.c
> index 015c854530..1d93e98e3a 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -853,7 +853,8 @@ static void mark_color_as_moved(struct diff_options *o,
>  {
>  	struct moved_entry **pmb = NULL; /* potentially moved blocks */
>  	int pmb_nr = 0, pmb_alloc = 0;
> -	int n, flipped_block = 1;
> +	int n, flipped_block = 1, block_length = 0;
> +
>  
>  	for (n = 0; n < o->emitted_symbols->nr; n++) {
>  		struct hashmap *hm = NULL;
> @@ -880,11 +881,19 @@ static void mark_color_as_moved(struct diff_options *o,
>  		}
>  
>  		if (!match) {
> +			if (block_length < COLOR_MOVED_MIN_BLOCK_LENGTH) {
> +				for (i = 0; i < block_length + 1; i++) {
> +					l = &o->emitted_symbols->buf[n - i];
> +					l->flags &= ~DIFF_SYMBOL_MOVED_LINE;
> +				}
> +			}
>  			pmb_nr = 0;
> +			block_length = 0;
>  			continue;
>  		}
>  
>  		l->flags |= DIFF_SYMBOL_MOVED_LINE;
> +		block_length++;
>  
>  		if (o->color_moved == COLOR_MOVED_PLAIN)
>  			continue;
> diff --git a/diff.h b/diff.h
> index 9298d211d7..cc1224a93b 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -195,6 +195,7 @@ struct diff_options {
>  		COLOR_MOVED_DEFAULT = 2,
>  		COLOR_MOVED_ZEBRA_DIM = 3,
>  	} color_moved;
> +	#define COLOR_MOVED_MIN_BLOCK_LENGTH 3
>  };
>  
>  void diff_emit_submodule_del(struct diff_options *o, const char *line);
