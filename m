Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E59401F453
	for <e@80x24.org>; Wed,  7 Nov 2018 08:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbeKGSVc (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 13:21:32 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44720 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbeKGSVc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 13:21:32 -0500
Received: by mail-wr1-f67.google.com with SMTP id j17-v6so11327760wrq.11
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 00:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=s2n/oZwFgyBamQNKCm6n5VdlkN+Kz93oLx+BQ7jw9Gc=;
        b=b97r6i/YK+JrEx+F8GbHqFrTmrfEqjvLf2H+xBHRvO62xTuTvl8CKZpCqVAT0MgUKd
         SLRkfvhlcGIvrEhL1mpb8hPkP6AFxfWxFf+38m8XSz+YrNylrqBbF61boiZIew7Q0uU7
         qMTs9KgjWuLkLl/Hn/oeV16rm5rmFVSk50FgeFkFdZav1hVzfeqHPYJyZfDSQKzoLmyj
         5YSz6FEgYgVsnJPVR75ADf5s8JHQawzdb3suiiTqcjg8RbmcJTKE6YMF8OYjWmSZexOX
         iC365EHl4ZHrDA8r4svNO1kUWrDiBJMXoQaXPONUsN/lenTy5i3pLkvIa0nMogFq3XEd
         jcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=s2n/oZwFgyBamQNKCm6n5VdlkN+Kz93oLx+BQ7jw9Gc=;
        b=tW/zbYipgfLqEEkr1oBxhUO+3Iz2SsV31pqEyTjznuiKV9/sTDA5/6LnRxNuoiH1K6
         QwAD3VUORCW7bH7HILS9RSOTV1rxWW6qI23eKWaSJe8UVvjSbRQh0stYWpixfYyGEDLT
         l4EpEaZhI6kfCXpP3qoJ1TRRKXP7U86eQ7M2NmEhtviE6pbK4IwtiQG0ojNZiiqDiWMA
         6NBLNf96L0+cyMxZLMna43EA3LePnMaXq9qeLUwjewR6DqOxBpAo5cHovaByff706MBQ
         qxy1//tgmR+NuE+hcbOvZDlOJHV3Ar9/BWseA6yvDroom1WJnaHmOPyLKege6W+vC8zi
         INZw==
X-Gm-Message-State: AGRZ1gIref8zobbt0kSmXN3+fOk6UFIBGdSZTM8diZycrgoVhM5aK5m9
        c0S/st23iHwJx/ZsR9cHFgw=
X-Google-Smtp-Source: AJdET5dAUpreV/FCjMwi50LdpvbjTY3bRQXFbqFmxmRVsCnzqzoEgzWp78af7hJKiE1hW6zAa/V9yQ==
X-Received: by 2002:adf:8444:: with SMTP id 62-v6mr939916wrf.251.1541580727128;
        Wed, 07 Nov 2018 00:52:07 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w11-v6sm22145435wrr.96.2018.11.07.00.52.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 00:52:06 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 1/1] pack-objects: ignore ambiguous object warnings
References: <pull.68.git.gitgitgadget@gmail.com>
        <pull.68.v2.git.gitgitgadget@gmail.com>
        <002868ee6bec3dac38749d0f05bf2db8da0969a5.1541536484.git.gitgitgadget@gmail.com>
        <20181106211234.GA8383@sigill.intra.peff.net>
        <xmqqftwdd54p.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 07 Nov 2018 17:52:05 +0900
In-Reply-To: <xmqqftwdd54p.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 07 Nov 2018 10:54:14 +0900")
Message-ID: <xmqq7ehpclsa.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The fix here is similar to 4c30d50 "rev-list: disable object/refname
> ambiguity check with --stdin".  While the get_object_list() method
> reads the objects from stdin, turn warn_on_object_refname_ambiguity
> flag (which is usually true) to false.  Just for code hygiene, save
> away the original at the beginning and restore it once we are done.

I actually think this is a bit too broad.  The calling process of
this program does know that it is feeding list of raw object names
(prefixed with ^ for negative ones), but the codepath this patch
touches does not know who is calling it with what.  It would be
safer to introduce a mechanism for the caller to tell this codepath
not to bother checking refnames, as it knows it is feeding the raw
object names and not refnames.

After all, you can feed things like "refs/heads/master" from the
standard input of "git pack-objects --revs", no?

> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/pack-objects.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index d1144a8f7e..f703e6df9b 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -2988,6 +2988,7 @@ static void get_object_list(int ac, const char **av)
>  	struct rev_info revs;
>  	char line[1000];
>  	int flags = 0;
> +	int save_warning;
>  
>  	init_revisions(&revs, NULL);
>  	save_commit_buffer = 0;
> @@ -2996,6 +2997,9 @@ static void get_object_list(int ac, const char **av)
>  	/* make sure shallows are read */
>  	is_repository_shallow(the_repository);
>  
> +	save_warning = warn_on_object_refname_ambiguity;
> +	warn_on_object_refname_ambiguity = 0;
> +
>  	while (fgets(line, sizeof(line), stdin) != NULL) {
>  		int len = strlen(line);
>  		if (len && line[len - 1] == '\n')
> @@ -3022,6 +3026,8 @@ static void get_object_list(int ac, const char **av)
>  			die(_("bad revision '%s'"), line);
>  	}
>  
> +	warn_on_object_refname_ambiguity = save_warning;
> +
>  	if (use_bitmap_index && !get_object_list_from_bitmap(&revs))
>  		return;
