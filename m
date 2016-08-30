Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3F2F1F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 16:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755790AbcH3QH4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 12:07:56 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34443 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754817AbcH3QHz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 12:07:55 -0400
Received: by mail-wm0-f65.google.com with SMTP id q128so3820768wma.1
        for <git@vger.kernel.org>; Tue, 30 Aug 2016 09:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=5WT+RluOI9YYzuGRaAshbSsQr82/04IRoVro8iOds58=;
        b=J8WBsO+K+okYUkXwVFN6OViePCnHj68qSNl9O4qmuIORDCmM5eo5TpU3LIrP8Tl1RE
         LqdOQUIStHHfUJ+KlQWWXA/mRr7Ntn1+J9EsoEtKOpDhJXYLfOzZ65q+2HdtfbVp1SZJ
         5AQ7kK/GjmYaaBlYk9eZ5oUQFyBRHQjRTrSUs+UTzB/HHG07fxNu9SjH0k+pOmqtJcIC
         4HGiedBqf/slMRhQk1WrCrAZb1CzSPZa/RUF7Y4egNLUGdbh0DBxbK1xjYgMGFtA6oGo
         mxIQk9T5EeuWNPkfs81UE+/LwUYRk/NLg3JYqlqDY5HpLieDp2eS3JDtr4ot1RbLGMZ4
         dGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=5WT+RluOI9YYzuGRaAshbSsQr82/04IRoVro8iOds58=;
        b=M9XfqYF7N+cn8wcWHUVfK7H3507Dz10kfyHxUN0b9VE+wP9v8/mg7JFdaSM5FUnG7P
         +A2s5egw8wTFYqa8iaQQkiBF6YCsLyn8ZQkQzU/LSua5KJjsLfxn0YOwohhUmgtJIOkw
         xxjrVoFKB1hor951PwP+ieThDptOlaxFD/i2WZEC/ccVcRpacYd2T4nkRcnSr4IGV62b
         Ns2uE+9V1TXSVIuOBONNLjTYBQM7dQe3sfGB6itZXxSRRa47GGiZu9GhmUDsscfF/S+M
         5Q02uyb+IG52FI1cHwQit5InbU9vkBCF+6wjsx2ogvqJTe2/SF1aCsbWOdtTJdXsw++/
         iLBg==
X-Gm-Message-State: AE9vXwO20PD/SSiiA3vmT+d2NZ+7Juc+eNO4X0g1/do5Xay9lq8BhGdfxyReR8IbNGHvXg==
X-Received: by 10.194.175.38 with SMTP id bx6mr3887646wjc.47.1472573273615;
        Tue, 30 Aug 2016 09:07:53 -0700 (PDT)
Received: from [192.168.1.26] (dam9.neoplus.adsl.tpnet.pl. [83.23.12.9])
        by smtp.googlemail.com with ESMTPSA id o5sm4600816wmg.16.2016.08.30.09.07.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Aug 2016 09:07:52 -0700 (PDT)
Subject: Re: [PATCH 07/22] sequencer: future-proof read_populate_todo()
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <4043fd4b955d6a3bed1b187d9529d5382db5b961.1472457609.git.johannes.schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <cb4402e9-6765-961d-0d67-43b74db05ef1@gmail.com>
Date:   Tue, 30 Aug 2016 18:07:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <4043fd4b955d6a3bed1b187d9529d5382db5b961.1472457609.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 29.08.2016 o 10:04, Johannes Schindelin pisze:

> Over the next commits, we will work on improving the sequencer to the
> point where it can process the edit script of an interactive rebase. To
> that end, we will need to teach the sequencer to read interactive
> rebase's todo file. In preparation, we consolidate all places where
> that todo file is needed to call a function that we will later extend.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 8d79091..982b6e9 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -32,6 +32,11 @@ static const char *get_dir(const struct replay_opts *opts)
>  	return git_path_seq_dir();
>  }
>  
> +static const char *get_todo_path(const struct replay_opts *opts)
> +{
> +	return git_path_todo_file();
> +}

I guess that in the future commit the return value of get_todo_path()
would change depending on what sequencer is used for, cherry-pick or
interactive rebase, that is, contents of replay_opts...

> +
>  static int is_rfc2822_line(const char *buf, int len)
>  {
>  	int i;
> @@ -772,25 +777,24 @@ static int parse_insn_buffer(char *buf, struct commit_list **todo_list,
>  static int read_populate_todo(struct commit_list **todo_list,
>  			struct replay_opts *opts)
>  {
> +	const char *todo_file = get_todo_path(opts);

...and that's why you have added this temporary variable here, to
not repeat get_todo_path(opts) calculations...

>  	struct strbuf buf = STRBUF_INIT;
>  	int fd, res;
>  
> -	fd = open(git_path_todo_file(), O_RDONLY);
> +	fd = open(todo_file, O_RDONLY);
>  	if (fd < 0)
> -		return error_errno(_("Could not open %s"),
> -				   git_path_todo_file());
> +		return error_errno(_("Could not open %s"), todo_file);

... So that's why it is s/git_path_todo_file()/todo_file/ replacement,
and not simply...

>  	if (strbuf_read(&buf, fd, 0) < 0) {
>  		close(fd);
>  		strbuf_release(&buf);
> -		return error(_("Could not read %s."), git_path_todo_file());
> +		return error(_("Could not read %s."), todo_file);
>  	}
>  	close(fd);
>  
>  	res = parse_insn_buffer(buf.buf, todo_list, opts);
>  	strbuf_release(&buf);
>  	if (res)
> -		return error(_("Unusable instruction sheet: %s"),
> -			git_path_todo_file());
> +		return error(_("Unusable instruction sheet: %s"), todo_file);
>  	return 0;
>  }
>  
> @@ -1064,7 +1068,7 @@ static int sequencer_continue(struct replay_opts *opts)
>  {
>  	struct commit_list *todo_list = NULL;
>  
> -	if (!file_exists(git_path_todo_file()))
> +	if (!file_exists(get_todo_path(opts)))

...the s/git_path_todo_file()/git_todo_path(opts)/, isn't it?

>  		return continue_single_pick();
>  	if (read_populate_opts(opts) ||
>  			read_populate_todo(&todo_list, opts))
> 

Looks good; though I have not checked if all calling sites were converted.

Good work,
-- 
Jakub Narębski

