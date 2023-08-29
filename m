Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2970C6FA8F
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 15:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237229AbjH2P4S (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 11:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237408AbjH2Pzq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 11:55:46 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483CE12F
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 08:55:43 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31768ce2e81so3812367f8f.1
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 08:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693324542; x=1693929342;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=chc/tIYPs2OpdLsIZ8PAW1Yu5wziidpyXd7GjmfBC8U=;
        b=Fmj3OHfUglOkGEnUDb6G0TSUvRLBRLorNJz24KpSEirPZfMWZovOlb0Kb1QGzLr0Es
         iY4sJO9pTChDtLQ6G6qPOjmCbMeivSGACbhitkckAbMdF126runWJhYbSzYVCcEomzSf
         d1KGP5new/1CX3T6Btu1g4uOzODBIkF5LO/8Ss1GuoWV1/KDsQxBtwcofJUTJGd53oPX
         CbSMeMzmbAbvD7vOhFv3zd42RTPzI0NVjpjyAOLnSjCf18b2MPwUW++K8oZEmH8kScim
         4u/BMpRU/sIJjTGZc+/T6pqlibf0iGyUduOWZqZZ5YOylXLDuHyfMT4/olk+rf3t/u5l
         Rc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693324542; x=1693929342;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=chc/tIYPs2OpdLsIZ8PAW1Yu5wziidpyXd7GjmfBC8U=;
        b=O9CLY7zlqtGXU/8kgeh+S/Rvis917uJ5W5RUzjQ9DNmHudcwEseZQ85aQfr9p6/0Cs
         pCpGGD9p8xRVkxksq03y297PlmXYmECpD0iYnPXvU5YPIEjnfbEcANoSoNO5hFVmM4XP
         4EAVU9wUGME7T8+NyHj6meCZYiNZrmKfW+g7R4NdjJV6IQjr8J4MU2rsLLRQedDY1HRX
         YUzwIUgBU8hg671pcG0YjNJYegtPX1sVweHqD9DxPUGIgXKuQFuZxbhDRxpMBUP6SQZ/
         0iLPCM6s0s+41N0tsDQ8+/wBhGqYXmdRwru09Fnwlmbu1AM91keuFr+ywn0hTV2n3+bc
         CR8w==
X-Gm-Message-State: AOJu0Yy9v+UDItDC8ndYs0QURPSMNh/2i9YVrw0bqhz5Gi+2kUHv88Ce
        c1eL+954NtE69wYe0EZT9it0ad+6WrrDxQ==
X-Google-Smtp-Source: AGHT+IHRsLLUycjGwgNzXQRcHsLNRBzalomfDCZ8UALc8FsN95X7D3/TXfN2v9bVaOPGuyTDmtNe4A==
X-Received: by 2002:a5d:4a86:0:b0:319:642f:93ad with SMTP id o6-20020a5d4a86000000b00319642f93admr19677569wrq.13.1693324541442;
        Tue, 29 Aug 2023 08:55:41 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600c46c600b00401dc20a070sm152019wmo.43.2023.08.29.08.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 08:55:41 -0700 (PDT)
Message-ID: <e65c93ec-0221-492b-b538-450b60cf1e59@gmail.com>
Date:   Tue, 29 Aug 2023 16:55:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 02/22] sequencer: mark repository argument as unused
Content-Language: en-US
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20230828214604.GA3830831@coredump.intra.peff.net>
 <20230828214717.GB3831137@coredump.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>
In-Reply-To: <20230828214717.GB3831137@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff

On 28/08/2023 22:47, Jeff King wrote:
> In sequencer_get_last_command(), we don't ever look at the repository
> parameter. It _should_ be used when calling into git_path_* functions,
> but the one we use here is declared with the non-REPO variant of
> GIT_PATH_FUNC(), and so just uses the_repository internally.
> 
> We could change the path helper to use REPO_GIT_PATH_FUNC(), but doing
> so piecemeal is not great. There are 41 uses of GIT_PATH_FUNC() in
> sequencer.c,

Wow, I knew there were quite a few but I hadn't realized there were that 
many. Changing them all to take a struct repository will be a big change 
and will make struct repo_cache_path a lot larger.

> and inconsistently switching one makes the code more
> confusing. Likewise, this one function is used in half a dozen other
> spots, all of which would need to start passing in a repository argument
> (with rippling effects up the call stack).
> 
> So let's punt on that for now and just silence any -Wunused-parameter
> warning.
> 
> Note that we could also drop this parameter entirely, as the function is
> always called directly, and not as a callback that has to conform to
> some external interface. But since we'd eventually want to use the
> repository parameter, let's leave it in place to avoid disrupting the
> callers twice.

I think that makes sense as we're going to need that argument 
eventually. I was curious as to why this function takes a repository 
argument. When the function was added in 4a72486de97 (fix 
cherry-pick/revert status after commit, 2019-04-16) it called 
parse_insn_line() which takes a repository argument. It was refactored 
in ed5b1ca10b (status: do not report errors in sequencer/todo, 
2019-06-27) and I failed to notice that the repository was unused 
afterwards.

Best Wishes

Phillip


> Signed-off-by: Jeff King <peff@peff.net>
> ---
>   sequencer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 82dc3e160e..41fd79d215 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2649,7 +2649,7 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
>   	return item->commit ? 0 : -1;
>   }
>   
> -int sequencer_get_last_command(struct repository *r, enum replay_action *action)
> +int sequencer_get_last_command(struct repository *r UNUSED, enum replay_action *action)
>   {
>   	const char *todo_file, *bol;
>   	struct strbuf buf = STRBUF_INIT;
