Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E47D5200B9
	for <e@80x24.org>; Mon,  7 May 2018 14:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752495AbeEGONP (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 10:13:15 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34862 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752483AbeEGONO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 10:13:14 -0400
Received: by mail-wm0-f65.google.com with SMTP id o78-v6so15752545wmg.0
        for <git@vger.kernel.org>; Mon, 07 May 2018 07:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uFMk6H82KPVIyVWRIAec9k7Pk0WLDwrFL9UCYG6DF5w=;
        b=R6//MrYPmpyMF7qgsFwYOu9HuzyaVSj4UgyWJ26kmELMEOCOeeU4ricuBOanMM8p1I
         9YuTnIuXmguwoMZMZ9mbGAUp7AWY7KO+tt/6aIVzBbAncDi4iQerPlNlAEdHC/ANOs2Q
         mwNbve9WEX19BdWipchlipUtunNqdjO1PAUGGHnsGjRRjgr6BVK+bRezZg6nytLlzsul
         /yWGy6Is/VYHFaQXBnRoJih4+b2hn9djyPl71C2x4QftwbkRmcCKuxNU679CvdjcPlJa
         Hd3qY4gIZ2Oi6otlSuau/qZC7xr6njVQtxhG2wEmRs7eA8IHyoq8MJyNf3efMQxyVrS2
         4ldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uFMk6H82KPVIyVWRIAec9k7Pk0WLDwrFL9UCYG6DF5w=;
        b=unEFvqvfuNOzN5Yklcrn1CwvgIG0BqN5QF22Yw53VZgXNSPrK7RppYxWtPwUs8eqYU
         dzRXPYkCYr8TVQ1FwUAL9y03jVgzgIXL6Y23BtpYcoZS7n7bXfUFVTl8lmNtFUEecpOy
         CpWn+wiEd8nZfwxJ0R4xdtPdKkaQyzBaJ6R1LAcYYSCKsPshg7YMnF3QtZs/L/MxVfL/
         tL1jJNAZzyet7CcCl4yOO8Q5GhsYID4WHeOqFsVCugpXniWux8LyLV6NijYpar91+zie
         QgACxfhnJDRvejbBoo9OJqGgRrlCbsx5+3kGQ3BOpcbgG19WJCYGr9o3wz2HtY/9Aw0H
         fD4A==
X-Gm-Message-State: ALKqPweoVzOHXbvJGoMtC6ermsWN9V7dMd/auoPz8CxdyiJ/A1Ioe5w2
        pls6ji5edEJxdl5Hmy8Icn3ybr8C
X-Google-Smtp-Source: AB8JxZpcYPFWhsBvZwStYXzJKcE9oEMogu1bAC+li/pNlUf+a0d1XfrIREL9DQO+uQLaoX7OJfa1Sw==
X-Received: by 10.28.18.71 with SMTP id 68mr879909wms.74.1525702393198;
        Mon, 07 May 2018 07:13:13 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e7-v6sm26689331wrn.88.2018.05.07.07.13.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 07:13:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, l.s.r@web.de,
        martin.agren@gmail.com, peff@peff.net, sunshine@sunshineco.com
Subject: Re: [PATCH v4 5/7] builtin/grep.c: add '--column' option to 'git-grep(1)'
References: <20180421034530.GB24606@syl.local>
        <cover.1525488108.git.me@ttaylorr.com>
        <9a596d53d6b2523bc94e58678aa43e68068859b6.1525488108.git.me@ttaylorr.com>
Date:   Mon, 07 May 2018 23:13:12 +0900
In-Reply-To: <9a596d53d6b2523bc94e58678aa43e68068859b6.1525488108.git.me@ttaylorr.com>
        (Taylor Blau's message of "Fri, 4 May 2018 19:43:02 -0700")
Message-ID: <xmqqk1sfpn9j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index 18b494731f..5409a24399 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -13,7 +13,7 @@ SYNOPSIS
>  	   [-v | --invert-match] [-h|-H] [--full-name]
>  	   [-E | --extended-regexp] [-G | --basic-regexp]
>  	   [-P | --perl-regexp]
> -	   [-F | --fixed-strings] [-n | --line-number]
> +	   [-F | --fixed-strings] [-n | --line-number] [--column]
>  	   [-l | --files-with-matches] [-L | --files-without-match]
>  	   [(-O | --open-files-in-pager) [<pager>]]
>  	   [-z | --null]
> @@ -169,6 +169,9 @@ providing this option will cause it to die.
>  --line-number::
>  	Prefix the line number to matching lines.
>  
> +--column::
> +	Prefix the 1-indexed column number of the first match on non-context lines.
> +

Two questions.

 - It is fine that the leftmost column is 1, but what does this
   number count?  The number of bytes on the same line before the
   first byte of the hit (plus 1)?  The display width of the initial
   non-matching part of the line (plus 1) on a fixed-width terminal?
   The number of "characters"?  Something else?

 - Does --column combined with -v make any sense?  If not, shouldn't
   the command error out when both are given at the same time?
