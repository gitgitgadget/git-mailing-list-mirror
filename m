Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33A8C201A4
	for <e@80x24.org>; Mon, 15 May 2017 03:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752646AbdEODzp (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 23:55:45 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34039 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751799AbdEODzo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 23:55:44 -0400
Received: by mail-pg0-f66.google.com with SMTP id u187so15254805pgb.1
        for <git@vger.kernel.org>; Sun, 14 May 2017 20:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tabfZfoExBhmG0cmnZbAmvdOC2rU7F19w+q5bt6Y2OI=;
        b=Lm2Iw1AK6CtOut8mIEdMd5iSps9G5lfGnL17yYl8H6wq84ZDNtaS4o8RyjXdWlK/y2
         zJsQU70CNeMOtMNMwjWg5r3Lwyc2HryxoItaWTcdWrQhIHDxIAOvc9A2F40EYfXKzFgR
         wadjL5rmNNuI6kucANH0weGFISl+GMUOeLBDHVwcRUrun71g8TqbimPnn7JBF44OYuh6
         gv/9ImgrvGNalUnFSLrGHIlZXFlYSe5V2OpzkUNCAmqYXFhWISYCtz7gXK79HNhoM8yM
         jmmLLzcAYD+gQ9uhcDxXfBdqGQqhTcziXIEBgTaQAO5Xp2Tgq/sY4vu0m9CWXlNxCW50
         y6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tabfZfoExBhmG0cmnZbAmvdOC2rU7F19w+q5bt6Y2OI=;
        b=qgjisG2uRc5DWuocncfTtXzX8pGXfwSdSkAULt7iEjktG8D4waX3bZwQCZs9oWQanz
         IuBb52x89GRlXOnHRdWax75QwH+5qknMXJWtzsY1sqWrMA4+khmJzrxK4cdR/UHTKnOu
         12/SZ6wxkFNJfBlEmZxyd6ji7uI9xlA2ftds8ywV22F7L8t5GpmPIVx+Cvtj2aZu3Ukr
         iDgGo+10BPI77pJryo62ayz+21j7lIpLAkWT0EmE5ODy4qnFaMlXvpFq0WRdVBbhxI4v
         31QRq31qv+5Sq4a9W7mtFwYn6eD86O1L4JwoLcB1Uap3b3i5RIaeWkkHO6tyyMMVkUXF
         khVA==
X-Gm-Message-State: AODbwcC1yirbUYbWIuSi+7bWQAso+Hmh8VArpG8nDIsCn2grlLoW9Zwh
        iQnrFnlUZVzi6RMmBZc=
X-Received: by 10.98.11.205 with SMTP id 74mr4112567pfl.214.1494820543814;
        Sun, 14 May 2017 20:55:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b170:f9ed:5f25:7ab5])
        by smtp.gmail.com with ESMTPSA id x21sm20812883pfa.71.2017.05.14.20.55.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 14 May 2017 20:55:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brian Malehorn <bmalehorn@gmail.com>
Cc:     peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCH] interpret-trailers: obey scissors lines
References: <20170514035652.rn5npxxflku6s5k4@sigill.intra.peff.net>
        <20170514083349.24979-1-bmalehorn@gmail.com>
        <20170514083349.24979-2-bmalehorn@gmail.com>
Date:   Mon, 15 May 2017 12:55:42 +0900
In-Reply-To: <20170514083349.24979-2-bmalehorn@gmail.com> (Brian Malehorn's
        message of "Sun, 14 May 2017 01:33:49 -0700")
Message-ID: <xmqqk25iwz7l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brian Malehorn <bmalehorn@gmail.com> writes:

> If a commit message is being edited as "verbose", it will contain a
> scissors string ("-- >8 --") and a diff:
>
>     my subject
>
>     # ------------------------ >8 ------------------------
>     # Do not touch the line above.
>     # Everything below will be removed.
>     diff --git a/foo.txt b/foo.txt
>     index 5716ca5..7601807 100644
>     --- a/foo.txt
>     +++ b/foo.txt
>     @@ -1 +1 @@
>     -bar
>     +baz
>
> interpret-trailers doesn't interpret the scissors and therefore places
> trailer information after the diff. A simple reproduction is:
>
>     git config commit.verbose true
>     GIT_EDITOR='git interpret-trailers --in-place --trailer Acked-by:me' \
>         git commit --amend
>
> This commit resolves the issue by teaching "git interpret-trailers" to
> obey scissors the same way "git commit" does.

I'd prefer to see s/obey scissors lines/honor the cut line/, and the
last paragraph rephrased somewhat, perhaps like:

        Subject: interpret-trailers: honor the cut line

        If a commit message is edited with the "verbose" option, the
        buffer will have a cut line and diff after the log message,
        like so:

             my subject

             # ------------------------ >8 ------------------------
             # Do not touch the line above.
             # Everything below will be removed.
             diff --git a/foo.txt b/foo.txt
             index 5716ca5..7601807 100644
             --- a/foo.txt
             +++ b/foo.txt
             @@ -1 +1 @@
             -bar
             +baz

        "git interpret-trailers" is unaware of the cut line, and
        assumes the trailer block would be at the end of the whole
        thing.  This can easily be seen with:

             $ GIT_EDITOR='git interpret-trailers --in-place --trailer Acked-by:me' \
               git commit --amend -v

        Teach "git interpret-trailers" to notice the cut-line and
        ignore the remainder of the input when looking for a place
        to add new trailer block.  This makes it consistent with how
        "git commit -v -s" inserts a new Signed-off-by: line.

        This can be done by the same logic as the existing helper
        function, wt_status_truncate_message_at_cut_line(), uses,
        but it wants the caller to pass a strbuf to it.  Because the
        helper function ignore_non_trailer() used by the command
        takes a <pointer, length> pair, not a strbuf, steal the
        logic from wt_status_truncate_message_at_cut_line() to
        create a new wt_status_strip_scissors() helper function that
        takes <poiter, length> pair, and make ignore_non_trailer()
        call it to help "interpret-trailers".  Since there is only
        one caller of wt_status_truncate_message_at_cut_line() in
        cmd_commit(), rewrite it to call wt_status_strip_scissors()
        helper instead and remove the old helper that no longer has
        any caller.

The last paragraph would have saved me from getting puzzled.

The mention of "'commit -v -s' works that way, too" was my attempt
to justify why it is OK to make this change unconditionally to
intepret-trailers, but I am still not 100% convinced with that
reasoning (or your original log message) that it is a safe thing to
do.  It is not like its sole purpose is to serve as GIT_EDITOR for
the "git commit" command.

The patch text itself looks sensible.  

We still need to see your patch with your sign-off, though.

Thanks.
