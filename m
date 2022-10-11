Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7FFC433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 10:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJKK7L (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 06:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiJKK7K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 06:59:10 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B25D67156
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 03:59:09 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id d26so23415701eje.10
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 03:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jYFm2U8YNoJo3yUekse3b32/I/g3wISeBhtHogN/3PI=;
        b=pX2Me/UGBiiWjznsyCwLoWWKVqpkPDgqcUBZ6fwJnhnW5csEBqpU+CcYXEM9ZtU9er
         XKbEPnW0ROpTyUXPCGQtghLZ5WDYpckox6u1j1zXc/EGw7rr4I8F28RZBYhTaoP8x606
         qqgtjgrnr/RWRT/FykQuDTzNHZdzZhfjGfHNIgN84gM4/K+lswhdaM0eKHAyD/OX3Qzo
         PFQ0wKiVDJTJVux4RkpucO191Ord/EzNEA4uKhed7xCpe9FxJ6SxjxVAmGEh5GvGSF9C
         wYhRHoIETd/IRAhitWt8N4X3UvmSvccrBW9OIYtaMyJNXAvMycEDMX5x3sL24Ofou2cJ
         4MIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYFm2U8YNoJo3yUekse3b32/I/g3wISeBhtHogN/3PI=;
        b=nsTqMATPmRzCkTDYMSVAUH1Az9XWw6ljFHJ1tOxaqnUlVKcUZsMQx3MAkg9a/H/hZ4
         4rWEik8iMwihooYk5tQFhisl+zctfglcTxQWqrsfGSfguLV88UunZ4dXzS5q7oPFKius
         xXHrkVYbyJg/s9AyCGokdRBibdk8ZpPYy8BJHA1ERbONAmgTuYmH99nP9UXqM8Gn9bog
         rx1UmuWeYCb3cUHji7kUSrExV5gtGcXgicjWB5XAw/uLjOcqs7XXyznNpKh8jG/PbzOv
         D34TbEpnWldSpVQkVgPjpWaf/nPCtvmXG7fdlDw+rtmcRjc0CdqDfelyHhYEO2PMUGrv
         gP9A==
X-Gm-Message-State: ACrzQf33I1GMXkCTIK7MFO8pBdJPegGHneZxcgfemsMZ4COEQFGE+CaA
        ntO+dhSUBCTkidkQUnZLNHQ=
X-Google-Smtp-Source: AMsMyM5j6cAVF6p7+1k8q7CgziLa57Q0hmJHAIY0Fxo9+bUSqTWmF3W06agfsGtttawGTei54T8LxA==
X-Received: by 2002:a17:907:3f89:b0:78d:4cca:3643 with SMTP id hr9-20020a1709073f8900b0078d4cca3643mr18251994ejc.353.1665485947963;
        Tue, 11 Oct 2022 03:59:07 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id c2-20020a170906340200b0077a1dd3e7b7sm6790250ejb.102.2022.10.11.03.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 03:59:07 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oiCyY-003pGX-2D;
        Tue, 11 Oct 2022 12:59:06 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jacob@initialcommit.io, peff@peff.net,
        gitster@pobox.com
Subject: Re: [PATCH 5/7] shortlog: implement `--group=author` in terms of
 `--group=<format>`
Date:   Tue, 11 Oct 2022 12:57:41 +0200
References: <cover.1665448437.git.me@ttaylorr.com>
 <55a6ef7bc0082818fa51a0915c43002ede5c449f.1665448437.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <55a6ef7bc0082818fa51a0915c43002ede5c449f.1665448437.git.me@ttaylorr.com>
Message-ID: <221011.8635bupqx1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 10 2022, Taylor Blau wrote:

> Instead of handling SHORTLOG_GROUP_AUTHOR separately, reimplement it as
> a special case of the new `--group=<format>` mode, where the author mode
> is a shorthand for `--group='%aN <%aE>'.
>
> Note that we still need to keep the SHORTLOG_GROUP_AUTHOR enum since it
> has a different meaning in `read_from_stdin()`, where it is still used
> for a different purpose.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  builtin/log.c      |  1 +
>  builtin/shortlog.c | 23 ++++++++++++-----------
>  shortlog.h         |  1 +
>  3 files changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index ee19dc5d45..6b77e520b5 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1334,6 +1334,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
>  	log.in2 = 4;
>  	log.file = rev->diffopt.file;
>  	log.groups = SHORTLOG_GROUP_AUTHOR;
> +	shortlog_init_group(&log);
>  	for (i = 0; i < nr; i++)
>  		shortlog_add_commit(&log, list[i]);
>  
> diff --git a/builtin/shortlog.c b/builtin/shortlog.c
> index f708d96558..aac8c7afa4 100644
> --- a/builtin/shortlog.c
> +++ b/builtin/shortlog.c
> @@ -245,15 +245,6 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
>  	}
>  	oneline_str = oneline.len ? oneline.buf : "<none>";
>  
> -	if (log->groups & SHORTLOG_GROUP_AUTHOR) {
> -		strbuf_reset(&ident);
> -		format_commit_message(commit,
> -				      log->email ? "%aN <%aE>" : "%aN",
> -				      &ident, &ctx);
> -		if (!HAS_MULTI_BITS(log->groups) ||
> -		    strset_add(&dups, ident.buf))
> -			insert_one_record(log, ident.buf, oneline_str);
> -	}
>  	if (log->groups & SHORTLOG_GROUP_COMMITTER) {
>  		strbuf_reset(&ident);
>  		format_commit_message(commit,
> @@ -372,6 +363,16 @@ void shortlog_init(struct shortlog *log)
>  	log->format.strdup_strings = 1;
>  }
>  
> +void shortlog_init_group(struct shortlog *log)
> +{
> +	if (!log->groups)
> +		log->groups = SHORTLOG_GROUP_AUTHOR;
> +
> +	if (log->groups & SHORTLOG_GROUP_AUTHOR)

Nit (easier reading):

	if (!x)
	...
	else if (x & FLAG)
	...
