Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 735991F859
	for <e@80x24.org>; Wed, 31 Aug 2016 20:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932362AbcHaU4Z (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 16:56:25 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36332 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761117AbcHaU4W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 16:56:22 -0400
Received: by mail-wm0-f68.google.com with SMTP id i138so9476980wmf.3
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 13:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=048LAkblBKxSQcrhYPLB/sRR7T0tqYO/yqrqsHZOcPM=;
        b=YbI6nDZ4vbslJAgKcmr9eW/dz471tSQ105jflixrLyGYCQy40l709FVS9aDht2HJ3d
         0pZdyhML3rLKOeKqSp1ApbuVoEq8r9w7HPa+u8u1LNZT1PBP2tvaF4gNKi0ex3NZ1q1G
         8KQxtiK3J+VEo3cG7+/4flfFiFL32bs1xTsiouAsamka/dSWbFJ9LYdzCgOp1kpA2RE1
         7npDokNGL4frJEXENaujQ8dx2WOibZNEofSDqAXe72pIlvVRpjn8unAJYMlgGq6dkTef
         cV6U+Jmg8GC7KO7AoyW3x4l/GPmAqFxdWvF4SKKLqKnCTR73ixfLCS92ugHVhwbKNkdf
         ml6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=048LAkblBKxSQcrhYPLB/sRR7T0tqYO/yqrqsHZOcPM=;
        b=Qe02Do9OrGj0Clk7x/CezF+MuJHTNsAO/849R+npVeDXI8ufOhpRGGQ1r1pnxB5/IH
         Yre0D77pvJgjF0HcYi0IyU0qUQuz6BOfYwaF5cO/0M55jgs9h3F2wI9j5coGxwM+NGzc
         2NmUxVVoWnMG1ArgrFcv5yxdeG53WiRWuL2GVW0Qs2pZzaOwYELljoa2gMFicn4DNJ3e
         DKUDWx04sbV/AlpraOTV4gRxUqdeYVlyxLAgh1HkvQ1d9KANyqbLg3/9TaFlXtZknpiu
         3FRalxz42hYN5slI6Z6u5LRU23ygzodJCFwHy8FB0AURahnSDJPdTSOO+joZQWyjV63L
         Y/Lw==
X-Gm-Message-State: AE9vXwNLa/11HiRtNtjlyV9HtRzP2i1OzqPuyFdyYVkqbNh20s5z+XpM0Xqtn0H4+s3Qdg==
X-Received: by 10.194.149.113 with SMTP id tz17mr10674789wjb.64.1472676980999;
        Wed, 31 Aug 2016 13:56:20 -0700 (PDT)
Received: from [192.168.1.26] (enu134.neoplus.adsl.tpnet.pl. [83.20.10.134])
        by smtp.googlemail.com with ESMTPSA id 4sm25457961wmu.2.2016.08.31.13.56.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Aug 2016 13:56:20 -0700 (PDT)
Subject: Re: [PATCH 17/22] sequencer: allow editing the commit message on a
 case-by-case basis
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <96adba0eee05a7b2b46b726f7e231b6732e80882.1472457609.git.johannes.schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <fa2a0783-afaa-0aa5-877c-24b3513d4bae@gmail.com>
Date:   Wed, 31 Aug 2016 22:56:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <96adba0eee05a7b2b46b726f7e231b6732e80882.1472457609.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 29.08.2016 o 10:06, Johannes Schindelin pisze:

> In the upcoming commits, we will implement more and more of rebase
> -i's functionality. One particular feature of the commands to come is
> that some of them allow editing the commit message while others don't,
> i.e. we cannot define in the replay_opts whether the commit message
> should be edited or not.

It's a nice, pretty and self contained refactoring step.  Small
enough that it is easy to review.

I would like to have in the commit message that it is sequencer_commit()
function that needs to rely on new parameter, instead of on a property
of command (of its replay_opts).  And that currently it simply passes
the buck to caller, which uses opts->edit, but in the future the
caller that is rebase -i would use todo_item and replay_opts based
expression.

> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 6 +++---
>  sequencer.h | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index e094ac2..7e17d14 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -478,7 +478,7 @@ static char **read_author_script(void)
>   * (except, of course, while running an interactive rebase).
>   */
>  int sequencer_commit(const char *defmsg, struct replay_opts *opts,
> -			  int allow_empty)
> +			  int allow_empty, int edit)
>  {
>  	char **env = NULL;
>  	struct argv_array array;
> @@ -513,7 +513,7 @@ int sequencer_commit(const char *defmsg, struct replay_opts *opts,
>  		argv_array_push(&array, "-s");
>  	if (defmsg)
>  		argv_array_pushl(&array, "-F", defmsg, NULL);
> -	if (opts->edit)
> +	if (edit)
>  		argv_array_push(&array, "-e");
>  	else if (!opts->signoff && !opts->record_origin &&
>  		 git_config_get_value("commit.cleanup", &value))
> @@ -779,7 +779,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
>  	}
>  	if (!opts->no_commit)
>  		res = sequencer_commit(opts->edit ? NULL : git_path_merge_msg(),
> -			opts, allow);
> +			opts, allow, opts->edit);
>  
>  leave:
>  	free_message(commit, &msg);
> diff --git a/sequencer.h b/sequencer.h
> index 9f63c31..fd02baf 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -50,7 +50,7 @@ int sequencer_rollback(struct replay_opts *opts);
>  int sequencer_remove_state(struct replay_opts *opts);
>  
>  int sequencer_commit(const char *defmsg, struct replay_opts *opts,
> -			  int allow_empty);
> +			  int allow_empty, int edit);
>  
>  extern const char sign_off_header[];
>  
> 

