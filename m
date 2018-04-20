Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 301E81F404
	for <e@80x24.org>; Fri, 20 Apr 2018 00:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753862AbeDTAZL (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 20:25:11 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:46500 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753817AbeDTAZK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 20:25:10 -0400
Received: by mail-wr0-f173.google.com with SMTP id d1-v6so18418371wrj.13
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 17:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7i94FGAtCcm2MEBWrEQGsm71LsgsXzN6J2onuE0QXrc=;
        b=RemmJaw+Jtid/QIZV8GQZ4scyEngzWPyfltU7zrZle5D+Bno9OXZGOR6c3xqwxsKiz
         JJDpvk3bhIMGb0wS0iHUX6Rp5EWrJIAL3Y81YsYNS825ZRdISLMJHZS1pD0UoDaU4tHW
         Ast1DAyU1vIfGeqcKTe/1PcYk3C+B3Qr9Awtfp/Oi8Eea0ILfFM/0mf5ONNPlnpjDwVE
         CMazdlM/welwqTI5H8ih+snr5qMOQQt8Ow8g6eant1s0uj0AeMfkWhL3fbxPwqzYIKkM
         yVZSptKUBJYejPUOsAY+tSZebLHwGgbh5qYnTsAZYjmckg18YuSy+J9ziWQ/6cmX8aOm
         R1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7i94FGAtCcm2MEBWrEQGsm71LsgsXzN6J2onuE0QXrc=;
        b=EQITF6o7JnuUKTbWOT9t+dL7l+FwAMVsW7u4n9u55LNmy1DXq72Ppt7KrMaKe+/8XF
         /5iy247cuz1xcYQ3ECZYZWsUjcAoGw/CnDF01VlAy/ba6uObhj4MIXYfPPm6oUjjmlBe
         g0Ge3I4sRu7paLfUDNKVLFxlYNHN8QU8EhndX0cX1B+uJO3NB9Gai2U6bWmI8dJbQJkq
         MDurTg7DrN2uVttucpULd8ijnC4ju4a+7TBIJNJWkQoh4d/4x53CrmWQF1cxWXerckeD
         Ow9jNaNVtrkQAPQSEfALbUnTp1ZDmf4+xSts7fR//xvjaDDOhOa4KisNV/XL9JQ79K4n
         jHBA==
X-Gm-Message-State: ALQs6tCLKFGiilzdv1qNygnn1k04VPlsOlmUf9QHsBCBk47W1nKIIXDt
        V9cE68prUuorVFpv0nSVQdM=
X-Google-Smtp-Source: AIpwx49PK7vioPglyb4wM50wNfPyvB3rNt99usGF6WpTW12e8gFUO9LluCxTPLqs9tmLb/r0RtAgwg==
X-Received: by 10.28.113.22 with SMTP id m22mr450020wmc.115.1524183908649;
        Thu, 19 Apr 2018 17:25:08 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 4-v6sm10172239wrz.58.2018.04.19.17.25.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Apr 2018 17:25:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/7] replace: "libify" create_graft()
References: <0f0942043678fe76f8d654306482ee26fac643f0.1523617836.git.johannes.schindelin@gmx.de>
        <cover.1524125760.git.johannes.schindelin@gmx.de>
        <1f1c64314088383570dd2232e08a88c8df3298f5.1524125760.git.johannes.schindelin@gmx.de>
Date:   Fri, 20 Apr 2018 09:25:07 +0900
In-Reply-To: <1f1c64314088383570dd2232e08a88c8df3298f5.1524125760.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Thu, 19 Apr 2018 10:17:31 +0200
        (DST)")
Message-ID: <xmqqh8o6d8rg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> It is quite convenient to simply die() in builtins, in the absence of
> proper exception handling, because it allows us to just go belly up
> without having to implement error handling chains.
>
> Of course, for reusable library functions, this is a big no-no, so we
> (try to) restrict the usage of die() to one-shot commands, i.e. places
> where we know that the caller does not want to, say, give the user a
> useful high-level error message, i.e. a message that the function calling
> die() could not possibly know.
>
> The problem with this reasoning is that sooner or later, pretty much all
> useful functions will *need* to be libified: the more useful a function,
> the more likely it is to be called from a call chain where the outer
> function implements a high-level operation that needs to provide
> additional advice to the user in case of failure.
>
> This is the case here: the create_graft() function is useful enough to be
> called in a loop, say, in the upcoming patch to convert a graft file in
> one fell swoop. Therefore, this function must not be allowed to die(), nor
> any of its callees.

All of the first three paragraphs are already widely known to the
project, and I do not think you need to verbosely repeat it, if
brevity demands it.

One thing that the proposed log message for this step would be far
more useful to say is that the current callers of create_graft() is
fine with the behaviour change (i.e. prepared to act on an error
return).

Also it may want to say why the other die() we see in this function
in the pre-context is OK.  I actually think it is not OK and should
return error(not a valid object name) the same way (I suspect that
this is mere omission/mistake, and you did not intend to leave it
dying).  As long as the caller is prepared to deal with an error
return, that is, which was the previous point.

FWIW, I fully agree with the goal of making this (or other pieces
that would be useful if they were reusable) reusable.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/replace.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/replace.c b/builtin/replace.c
> index 935647be6bd..43264f0998e 100644
> --- a/builtin/replace.c
> +++ b/builtin/replace.c
> @@ -395,7 +395,9 @@ static int create_graft(int argc, const char **argv, int force)
>  
>  	if (get_oid(old_ref, &old_oid) < 0)
>  		die(_("Not a valid object name: '%s'"), old_ref);
> -	commit = lookup_commit_or_die(&old_oid, old_ref);
> +	commit = lookup_commit_reference(&old_oid);
> +	if (!commit)
> +		return error(_("could not parse %s"), old_ref);
>  
>  	buffer = get_commit_buffer(commit, &size);
>  	strbuf_add(&buf, buffer, size);
