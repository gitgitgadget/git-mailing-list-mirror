Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F4771FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 19:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754994AbcH2TzL (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 15:55:11 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35939 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753436AbcH2TzK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 15:55:10 -0400
Received: by mail-wm0-f65.google.com with SMTP id i138so171769wmf.3
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 12:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=gYp2Yxh5fqC3w2PFEoruVmeE313UQdFqHZrTdVVNQ+o=;
        b=CMk4iK8BTFgQflTAwJKtRF4qSrBoce5VeQbaYsErmaTFA7B3LFgq7g79P1a7dnbXFe
         rg+MXEw8zwfPXmgzU4MJmCpArcGwPY0hJ8OVv4P4xDZMNt5nKXKwXelThWQD4A32VGlb
         grzpgP9Noqq9cxUEW+WpLxQNLlwwNWgCgcd2s1JwsGVoIq/jno7WnHfbUGUoYTTG3oMl
         iPDme5KS9G4YL2aQZZb0EbPkl90sIpXO9qrBKaHnMLNiNIr3JCj3OiH/7fdXOyZGfeip
         lyhQUv0h90kH5OJs2l0IePz/uPQLwus7Bh6TaCp0QRiD3txeXXThMlLlATI2Iz6TndeY
         EJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=gYp2Yxh5fqC3w2PFEoruVmeE313UQdFqHZrTdVVNQ+o=;
        b=TmzHU/roJBhziEbcp02ISdv3qJHuFcAYvR5iwa3p9uuzrmNE/+SNv3WVqetLFCKzIA
         pX6y4GegzyxBnpRfFAZpVcq7/qHx1mTBEw0w7PVIn/e62pD0BeO9RuSuItOP2O/l+hI2
         uQVdvx1qHgLZxLjT4FL0zTf5waOwfo7wClZI0aGwb0aN5bq+6rkRI4TIuyObIYykKJfS
         IC7zy/Nvqj+dgnnElTalR8TSfTb1qiKcClW94y1F9Mnjxbs9IBY6SJC64LG9aHUk/A+i
         /dCiDIFwxrc+inMVPZJBHcvij7rZx6gZE4607dYoiEYJPmPuqk7xMdKNi7JPGhuNrKIL
         eNiQ==
X-Gm-Message-State: AE9vXwN36eld3NxkIlDEIgg74G9mI4Ye5h8znoCuirOZn9rjqF9jFEVWEJcjfEdlEKa79g==
X-Received: by 10.194.98.139 with SMTP id ei11mr17164797wjb.19.1472500509371;
        Mon, 29 Aug 2016 12:55:09 -0700 (PDT)
Received: from [192.168.1.26] (afz108.neoplus.adsl.tpnet.pl. [83.25.155.108])
        by smtp.googlemail.com with ESMTPSA id g67sm320561wme.5.2016.08.29.12.55.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Aug 2016 12:55:08 -0700 (PDT)
Subject: Re: [PATCH 02/22] sequencer: use memoized sequencer directory path
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <d032a9d765aaca0655b1e363e67d9bf24864396c.1472457609.git.johannes.schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <10e19839-2875-2610-0af3-0b86831916f0@gmail.com>
Date:   Mon, 29 Aug 2016 21:54:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <d032a9d765aaca0655b1e363e67d9bf24864396c.1472457609.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 29.08.2016 o 10:04, Johannes Schindelin pisze:
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/commit.c |  2 +-
>  sequencer.c      | 11 ++++++-----
>  sequencer.h      |  5 +----
>  3 files changed, 8 insertions(+), 10 deletions(-)

Just a sidenote: it would be probably easier to read with *.h before
*.c (at least this particular one).

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 77e3dc8..0221190 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -173,7 +173,7 @@ static void determine_whence(struct wt_status *s)
>  		whence = FROM_MERGE;
>  	else if (file_exists(git_path_cherry_pick_head())) {
>  		whence = FROM_CHERRY_PICK;
> -		if (file_exists(git_path(SEQ_DIR)))
> +		if (file_exists(git_path_seq_dir()))
>  			sequencer_in_use = 1;
>  	}
>  	else

So it is more "Use memoized sequencer directory path" rather than
"sequencer: use memoized sequencer directory path" - it replaces
all occurrences of SEQ_DIR,... that's why it can be removed from
'sequencer.h'.

Though perhaps I misunderstood "sequencer: " prefix there.  Don't
mind me then.

> diff --git a/sequencer.c b/sequencer.c
> index b6481bb..4d2b4e3 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -21,10 +21,11 @@
>  const char sign_off_header[] = "Signed-off-by: ";
>  static const char cherry_picked_prefix[] = "(cherry picked from commit ";
>  
> -static GIT_PATH_FUNC(git_path_todo_file, SEQ_TODO_FILE)
> -static GIT_PATH_FUNC(git_path_opts_file, SEQ_OPTS_FILE)
> -static GIT_PATH_FUNC(git_path_seq_dir, SEQ_DIR)
> -static GIT_PATH_FUNC(git_path_head_file, SEQ_HEAD_FILE)
> +GIT_PATH_FUNC(git_path_seq_dir, "sequencer")
> +
> +static GIT_PATH_FUNC(git_path_todo_file, "sequencer/todo")
> +static GIT_PATH_FUNC(git_path_opts_file, "sequencer/opts")
> +static GIT_PATH_FUNC(git_path_head_file, "sequencer/head")

This also makes the ordering of memoized-path variables more
sensible.  Good work.

>  
>  static int is_rfc2822_line(const char *buf, int len)
>  {
> @@ -112,7 +113,7 @@ static void remove_sequencer_state(void)
>  {
>  	struct strbuf seq_dir = STRBUF_INIT;
>  
> -	strbuf_addstr(&seq_dir, git_path(SEQ_DIR));
> +	strbuf_addstr(&seq_dir, git_path_seq_dir());
>  	remove_dir_recursively(&seq_dir, 0);
>  	strbuf_release(&seq_dir);
>  }
> diff --git a/sequencer.h b/sequencer.h
> index 2ca096b..c955594 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -1,10 +1,7 @@
>  #ifndef SEQUENCER_H
>  #define SEQUENCER_H
>  
> -#define SEQ_DIR		"sequencer"
> -#define SEQ_HEAD_FILE	"sequencer/head"
> -#define SEQ_TODO_FILE	"sequencer/todo"
> -#define SEQ_OPTS_FILE	"sequencer/opts"
> +const char *git_path_seq_dir(void);

Right, I see this matches other git_path_*() functions declared in cache.h

>  
>  #define APPEND_SIGNOFF_DEDUP (1u << 0)
>  
> 

