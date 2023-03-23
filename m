Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB157C76196
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 19:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjCWTbP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 15:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjCWTbN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 15:31:13 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1855CC3E
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:31:08 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id l27so13427515wrb.2
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679599867;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L4paM067cuIQBZys4fxSyR4/AsfZp2FqlY/CMjs9c8w=;
        b=GFxhNITVyEFCaGFpdmyVqN/PyQbENVz6rhedxuuU/2EUPM1ac4QzTtBPtDu9MChA8G
         bLjD9WfY47hH6PglZwVv4NXCadGaR+S8lxVPlAv8DH2c8xVCpC6T2+S+laH7lbh8EPmV
         ZwwG3kM8Xw3b7aCJ5Xj5aQKcKPwEFPhv9u8PUu9nloMyBMMiKsNGUzvQ+dB1v6zDRnvw
         xjyyiyOAxWydQR5GsBqy2iBRqvljBXh1ivfNJ/vw+ge0jm0S2fspjjhiH/FSDrVIgHTl
         ZUpcWROCgY0t4iqrDxpyRC+auuMCZejXzziBTH5XxIJ8QRp8s/zx8ozOTwz5F1JrpgFY
         RNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679599867;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4paM067cuIQBZys4fxSyR4/AsfZp2FqlY/CMjs9c8w=;
        b=Adaq0rUk2z/PDGruoy3mUrz/hX5OuD3thepxAh2lZrq69N23N3GUvNrieqXWR2beNX
         zVBqfy8DQ5PbH/4USWojDj9fUq0RtVZrtNZ0jtLw51LQ4AntT7koUhi9RYxL7sPhI1iV
         GugZoaESBiUyZsSWd6OSzmNKGtmF4nc+tS+C3kr2SDlE6F8A2XszCsNCOgzrc7gORPah
         f1/39hvRysW4TQtXaPkG/YMs7DGl3ZDIaSdzQeJmZPDI+rxm+cLVp+DEVThqLEyJ0CfL
         +CyV3ob6HpXIO5GA7eCNr6LVxOsYqXcVHPp+XKmQ7bd5d4zbKCPpohFGDQWAzXljvYXO
         yVYQ==
X-Gm-Message-State: AAQBX9f0gQePlB4Hppc/0YqIHIg6WlS62gIo9dwAqPnYH5nIaI5yiZ0H
        A9/cnmptdYaxX1nA4F6PozQ=
X-Google-Smtp-Source: AKy350ZRSEsIr3i2NRYhqs7Ipf/MALd2m4rxzHFtV+CRoxxFbTSAEFwYb85xJnWGvYejV8Pc2EYnow==
X-Received: by 2002:adf:de08:0:b0:2d4:5117:f4b with SMTP id b8-20020adfde08000000b002d451170f4bmr3483561wrm.26.1679599867357;
        Thu, 23 Mar 2023 12:31:07 -0700 (PDT)
Received: from [192.168.1.212] ([90.253.29.198])
        by smtp.gmail.com with ESMTPSA id s15-20020a5d6a8f000000b002d743eeab39sm10063879wru.58.2023.03.23.12.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 12:31:07 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <47558c14-ba2c-18ec-0532-b21fdfd223f8@dunelm.org.uk>
Date:   Thu, 23 Mar 2023 19:31:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 5/8] rebase: preserve interactive todo file on checkout
 failure
Content-Language: en-US
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
References: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
 <20230323162235.995574-6-oswald.buddenhagen@gmx.de>
In-Reply-To: <20230323162235.995574-6-oswald.buddenhagen@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Oswald

On 23/03/2023 16:22, Oswald Buddenhagen wrote:
> Creating a suitable todo file is a potentially labor-intensive process,
> so be less cavalier about discarding it when something goes wrong (e.g.,
> the user messed with the repo while editing the todo).

I was thinking about this problem the other day in the context of 
rescheduling commands when they cannot be executed because they would 
overwrite an untracked file. My thought was that we should prepend a 
"reset" command to the todo list so that the checkout happened when the 
user continued the rebase. How does this patch ensure the checkout 
happens when the user continues the rebase?

Best Wishes

Phillip

> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> ---
>   builtin/rebase.c              | 1 +
>   sequencer.c                   | 4 ++++
>   sequencer.h                   | 1 +
>   t/t3404-rebase-interactive.sh | 3 ++-
>   4 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index a309addd50..728c869db4 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -153,6 +153,7 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
>   	replay.keep_redundant_commits = (opts->empty == EMPTY_KEEP);
>   	replay.quiet = !(opts->flags & REBASE_NO_QUIET);
>   	replay.verbose = opts->flags & REBASE_VERBOSE;
> +	replay.precious_todo = opts->flags & REBASE_INTERACTIVE_EXPLICIT;
>   	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
>   	replay.committer_date_is_author_date =
>   					opts->committer_date_is_author_date;
> diff --git a/sequencer.c b/sequencer.c
> index b1c29c8802..f8a7f4e721 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4570,6 +4570,10 @@ static int checkout_onto(struct repository *r, struct replay_opts *opts,
>   		.default_reflog_action = sequencer_reflog_action(opts)
>   	};
>   	if (reset_head(r, &ropts)) {
> +		// Editing the todo may have been costly; don't just discard it.
> +		if (opts->precious_todo)
> +			exit(1);  // Error was already printed
> +
>   		apply_autostash(rebase_path_autostash());
>   		sequencer_remove_state(opts);
>   		return error(_("could not detach HEAD"));
> diff --git a/sequencer.h b/sequencer.h
> index 1a3e616af2..a1b8ca6eb1 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -47,6 +47,7 @@ struct replay_opts {
>   	int keep_redundant_commits;
>   	int verbose;
>   	int quiet;
> +	int precious_todo;
>   	int reschedule_failed_exec;
>   	int committer_date_is_author_date;
>   	int ignore_date;
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index ff0afad63e..c625aad10a 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -288,13 +288,14 @@ test_expect_success 'abort' '
>   '
>   
>   test_expect_success 'abort with error when new base cannot be checked out' '
> +	test_when_finished "git rebase --abort ||:" &&
>   	git rm --cached file1 &&
>   	git commit -m "remove file in base" &&
>   	test_must_fail git rebase -i primary > output 2>&1 &&
>   	test_i18ngrep "The following untracked working tree files would be overwritten by checkout:" \
>   		output &&
>   	test_i18ngrep "file1" output &&
> -	test_path_is_missing .git/rebase-merge &&
> +	test_path_is_dir .git/rebase-merge &&
>   	rm file1 &&
>   	git reset --hard HEAD^
>   '
