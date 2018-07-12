Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F61C1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 16:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeGLQay (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 12:30:54 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34006 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbeGLQax (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 12:30:53 -0400
Received: by mail-wm0-f66.google.com with SMTP id s13-v6so2463334wmc.1
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 09:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PiN+SDgzOrCiXlHo+8BVJlWYPaL4WETyizNxwlfVhRg=;
        b=sI+/OfxwP5opgxN0orHApljF6yNkbMS1bDaWklJ/DlaeUOBmGn/1H7u4l82Houk8Y3
         UzcN3EMGhqnYIZkfYHfoF6TqK9xOWAU3IpArhTXZVYKSMYMaUdTKy9CjHtmrkheLfxVB
         4T9sfVyjkPPMMb0nzw/7b8I8Qre+49fB8TfvUXM1dFvh051ErQ1NZCeQjljNy8RhLKK3
         amQ0bCCxBkzUTEfsLZrIf9rQzXYkhtZwIwjwCy5JElnDEeZ3mBd9ySqzuX1TmI3HQgD4
         lU/ztm3VbV0lqSrYKScEzkk8W1ZrZgSiUQb3F116ohL5Z63QmLA9YpDEJ1ceBbpBhZty
         pruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PiN+SDgzOrCiXlHo+8BVJlWYPaL4WETyizNxwlfVhRg=;
        b=cladiShQ8w+J532hXTNLwFZizI8pcMGMHelKApqcycxjqzPp7hJnWGaKzccHgBy45R
         84qzDEwPhDb0bqdmHODWsR89jrQn74uAWZfuu0RW34jJlflHn+xYDRfmBejcP8UfdklL
         iof0InPhuNa4qddbPklyIL2BstZyHvk9XEfCwB+nIIjLdjP2NslNSrfk5VkPYiusdqOA
         vkwHI2y4UvqbiW2XXi0hBaJRq4zf5N8TQtomL1NPzbE3FuxBxTTnv1oahwMLImc4lrHk
         O62nfhhQ5JQtZjDMuiF212TqyntJ0VYmL22HSD1VoeVJ9XzGJ2VwGf4yIsQ3DP3vsw2d
         gueA==
X-Gm-Message-State: AOUpUlEOp7eigtRZvEvGINn+adBW//hiEZxEm2s8HA79OOr0iadFN/Bw
        PfYv4HKBNeNAMmBFn14UB6c=
X-Google-Smtp-Source: AAOMgpefLFvYpEyOvqwj7YgN/ImbFr4Pyil7i9doGstDbcjOp5BfMhFmSWFt5xNzZWXzgAY64QD2yg==
X-Received: by 2002:a1c:8010:: with SMTP id b16-v6mr1886103wmd.9.1531412436781;
        Thu, 12 Jul 2018 09:20:36 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h4-v6sm22371441wre.89.2018.07.12.09.20.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 09:20:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/3] merge: allow reading the merge commit message from a file
References: <pull.8.git.gitgitgadget@gmail.com>
        <9e2c1fe83178f7047d8f2aacaa961381a4894081.1531312689.git.gitgitgadget@gmail.com>
        <xmqqbmbd1l7i.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807121455130.75@tvgsbejvaqbjf.bet>
Date:   Thu, 12 Jul 2018 09:20:35 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1807121455130.75@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 12 Jul 2018 14:58:59 +0200 (DST)")
Message-ID: <xmqqpnzszar0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > +static int option_read_message(struct parse_opt_ctx_t *ctx,
>> > +			       const struct option *opt, int unset)
>> > +{
>> > +	struct strbuf *buf = opt->value;
>> > +	const char *arg;
>> > +
>> > +	if (unset)
>> > +		BUG("-F cannot be negated");
>> 
>> The message "-F cannot be negated" looks as if it is pointing out a
>> mistake by the end user, and does not mesh well with the real reason
>> why this is BUG() and is not die().
>> 
>> I understand that this is BUG() not die() because options[] array
>> tells this callback not to be called with unset by having the
>> PARSE_OPT_NONEG bit there.
>
> Okay. I would have appreciated some sort of indication what you prefer
> instead. I went with "--no-file?!?"

I have no strong preference; anything is OK as long as the message
is unique and points reading developer in the right direction, and
"--no-file?!?" signals quite strongly that the code is not expected
that it has to handle that option at this point (instead, it expects
somebody else has dealt with it), so it sounds fine.

I think doing all of these inside parse_options callback means that
you can have "merge -F file1 -F file2" and slurp contents from both
files as separate paragraphs.  I briefly wondered if --no-file is
something the end user might want to be able to use to discard what
has been read so far, but "merge -m msg -F file --no-file" would
have to discard everything, not just what we read from the file, so
it would not be useful with the structure of the message assembly
we have today, which this code builds on.

>> > +	if (ctx->opt) {
>> > +		arg = ctx->opt;
>> > +		ctx->opt = NULL;
>> > +	} else if (ctx->argc > 1) {
>> > +		ctx->argc--;
>> > +		arg = *++ctx->argv;
>> > +	} else
>> > +		return opterror(opt, "requires a value", 0);
>> > +
>> > +	if (buf->len)
>> > +		strbuf_addch(buf, '\n');
>> 
>> Do we assume that buf, if it is not empty, is properly terminated
>> with LF already?  I am wondering if the real reason we do these two
>> lines is to make sure we have a separating blank line between what
>> is already there (if there already is something) and what we add, in
>> which case the above would want to say
>> 
>> 	if (buf->len) {
>> 		strbuf_complete_line(buf);
>> 		strbuf_addch(buf, '\n');
>> 	}
>> 
>> instead.
>
> True. Thanks for the suggestion!
>
>> > +	if (ctx->prefix && !is_absolute_path(arg))
>> > +		arg = prefix_filename(ctx->prefix, arg);
>> > +	if (strbuf_read_file(buf, arg, 0) < 0)
>> > +		return error(_("could not read file '%s'"), arg);
>> > +	have_message = 1;
>> 
>> A similar question is what we would want to do when the file ends
>> with an incomplete line.  With "--log", we would be appending more
>> stuff to buf, and we'd want to complete such an incomplete line
>> before that happens, either here or in the code immediately before
>> "--log" is processed.
>
> This is what I inserted here:
>
> 	strbuf_complete_line(buf);

I had a slight suspicion that completing immediately before we
append anything in a later step in the codepath would be safer.
When we get a complaint: 

    'merge -F file' when I am not using '--log' or adding sign-off,
    adds an extra newline at the end when I deliberately give a file
    that ends with an incomplete line for such and such reasons.

I do not think I would have a good argument why the then-current
behaviour is not a bug but an intended behaviour.

And I do not think the fact that I am unable to fill "such and such"
above means such a complaint is nonsense---it merely indicates that
I lack imagination and that I am not thinking enough to accomodate
other people's needs.
