Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 424C4201A4
	for <e@80x24.org>; Mon, 15 May 2017 02:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751518AbdEOCfi (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 22:35:38 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36640 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbdEOCfh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 22:35:37 -0400
Received: by mail-pf0-f196.google.com with SMTP id n23so12868113pfb.3
        for <git@vger.kernel.org>; Sun, 14 May 2017 19:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EpuVZP618525IGtq82eOuQ4ehUE6w/k3inGBgXgHPWs=;
        b=azg7EoGj2ck3agAzVHBp6VzM4I+1RxqmwZg/nxGkj5Syi1ox5RqPqj9EnxYwl1OEOn
         pbLkAFL8t/+xCFW0PxZ3cgqETUkZeDW7R5HqZ4Zf3PDTWXUtwTu3YscV8eHzhNHcqDUT
         Nl9iOTMVag5WBJvM/yVZsa/8xp9N+xn7vsOISULCOENzpyvo7wgjWpgBPyqItTLth/i8
         QV7SsfpNO1LLJmlQmWpD68ntLOSprgq8wqJUveXTsWhpTjQeJUi3Wd8PO9xc2JBUU9h6
         hoALOY9IEQgvAKyTwTYGscWIyoL4FXn0r8UUyLKrBnS2FOSpHaPS/Yw9xd06rfdMvl9Y
         +mWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EpuVZP618525IGtq82eOuQ4ehUE6w/k3inGBgXgHPWs=;
        b=PJYVXaZjrsW7obADlAF3+5kXqjEwHKQcLkEFPaGkIJEZnBT48ATYl0yStm+NEQEC55
         BxqCapt41sxObx1IJtpxkkZQhWbcr4+BP0wfXyK415GmzIfwn0UAuS5uo8EPGTkFAJb3
         vOy03J4iq+uTLVlCu0zZ5WgKxODTQUWk1gqdp7/85Clq4+atiIqykhFjEmawh7fZh/d0
         ZlrXdk3ksA4CmRL+NkzsK2+gxGY4eYpQCWnqtMHtk1+xoMjbEk/b08I3xm9flkWMAsDy
         ESQko2F+0vMr55ihV9IzF7paFXy9DsezC3rRozHtmv0alTp8DZEaA7wD9h8wZNrAOUqE
         2QQg==
X-Gm-Message-State: AODbwcDqLxRkyhaXNoc2WSdRWGW6lo/K0Vn/dZ6zFN7QAZTQHWd2slS/
        zWNlN2udhlM7U7k7k5U=
X-Received: by 10.99.124.75 with SMTP id l11mr3784783pgn.211.1494815736537;
        Sun, 14 May 2017 19:35:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b170:f9ed:5f25:7ab5])
        by smtp.gmail.com with ESMTPSA id d13sm17089728pfl.12.2017.05.14.19.35.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 14 May 2017 19:35:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] builtin/log: honor log.decorate
References: <20170512221221.406645-1-sandals@crustytoothpaste.net>
        <20170514180058.842315-1-sandals@crustytoothpaste.net>
Date:   Mon, 15 May 2017 11:35:34 +0900
In-Reply-To: <20170514180058.842315-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 14 May 2017 18:00:58 +0000")
Message-ID: <xmqqy3tyx2x5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> The recent change that introduced autodecorating of refs accidentally
> broke the ability of users to set log.decorate = false to override it.
> When the git_log_config was traversed a second time with an option other
> than log.decorate, the decoration style would be set to the automatic
> style, even if the user had already overridden it.  Instead of setting
> the option in config parsing, set it in init_log_defaults instead.
>
> Add a test for this case.  The actual additional config option doesn't
> matter, but it needs to be something not already set in the
> configuration file.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> Changes from v2:
> * Add a test.  I tested that the config parsing both works with
>   additional options and also can be overridden from the command line.

Thanks, all.

Will queue with Acked-by by Alex and Reviewed-by by Jonathan.


>  builtin/log.c  |  4 ++--
>  t/t4202-log.sh | 12 ++++++++++++
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index b3b10cc1e..ec3258368 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -110,6 +110,8 @@ static void init_log_defaults(void)
>  {
>  	init_grep_defaults();
>  	init_diff_ui_defaults();
> +
> +	decoration_style = auto_decoration_style();
>  }
>  
>  static void cmd_log_init_defaults(struct rev_info *rev)
> @@ -410,8 +412,6 @@ static int git_log_config(const char *var, const char *value, void *cb)
>  		if (decoration_style < 0)
>  			decoration_style = 0; /* maybe warn? */
>  		return 0;
> -	} else {
> -		decoration_style = auto_decoration_style();
>  	}
>  	if (!strcmp(var, "log.showroot")) {
>  		default_show_root = git_config_bool(var, value);
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index f57799071..1c7d6729c 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -577,6 +577,18 @@ test_expect_success 'log.decorate configuration' '
>  
>  '
>  
> +test_expect_success 'log.decorate config parsing' '
> +	git log --oneline --decorate=full >expect.full &&
> +	git log --oneline --decorate=short >expect.short &&
> +
> +	test_config log.decorate full &&
> +	test_config log.mailmap true &&
> +	git log --oneline >actual &&
> +	test_cmp expect.full actual &&
> +	git log --oneline --decorate=short >actual &&
> +	test_cmp expect.short actual
> +'
> +
>  test_expect_success TTY 'log output on a TTY' '
>  	git log --oneline --decorate >expect.short &&
>  
