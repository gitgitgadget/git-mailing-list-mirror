Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29B601FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 20:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754321AbcH2UXi (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 16:23:38 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35720 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752521AbcH2UXh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 16:23:37 -0400
Received: by mail-wm0-f68.google.com with SMTP id i5so261708wmg.2
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 13:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=VYrnadiuM7ORG6QVy/vGzX72LGQfnIS+2srXBtBn+hY=;
        b=bvnFMwxTP2RZ5iEXGBdKsmuGM9bbbMCyAxm3MkEXRC9ncVDTUIFckC5sMILb2db11Z
         UZJ/WnFmnOaxvm1+d9DWZEXDYogTjU+nxAT9EHftV/+X7ZZi87T526h7SF3oN5TTadPo
         SFWT4DDp8drcpfXK00Dr1KaYuT99jGExKmCG3oJ65u3o9z8e49Qmcj6zU02HwNaOwlbV
         yiywGXFoMPm0FWLQMD6swpq8vKIy7eXbjUwlEG5ztPHuAQWuOVNqEuIScD3Se+lNIrf8
         MTaaPnM+idF8Ic6PPCq/b4D6vks3qBBN/d4FhrEJz3Bnw+EpThpTL/IfDVe8ufLqwFlb
         1ZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=VYrnadiuM7ORG6QVy/vGzX72LGQfnIS+2srXBtBn+hY=;
        b=YLJz187TlLXgqlm4prfx4kYwi9KBY7x/7Y5//f0NT/DcQ4PP1EL3PB4EhMq80kENgZ
         PFvbzBTLjqywOZGkTdus4gaw3jSFFgxpYbKu5EqspyO8iaGNyKphAyi1JqjOXArjwiW+
         NBzD4j741q7pBxnpTgRe15+rbDuDHi+Ri312AwM2pnCFHg6ChFcoCx78i86TQrRFSqDV
         FnDzy5sfZD/4XW01gU/a/88CTZfVbmsraOR0/iUkV54iyw59d27svHOSC0oAYzw//MxM
         53ZDLGzdnBg1knr4df768v6sSn2sTDOqwe2+f9UGXhRw6ZsC/DxpPY9MbR5BdJJrHsRj
         KzKQ==
X-Gm-Message-State: AE9vXwPiDPpUF1B6YRpeLaT32woUfppsXZB6jo97AV7eRcIVEbEpNyhsVev/OPtTeTGsDw==
X-Received: by 10.194.187.7 with SMTP id fo7mr17264404wjc.162.1472502182650;
        Mon, 29 Aug 2016 13:23:02 -0700 (PDT)
Received: from [192.168.1.26] (afz108.neoplus.adsl.tpnet.pl. [83.25.155.108])
        by smtp.googlemail.com with ESMTPSA id b128sm15151253wmb.21.2016.08.29.13.23.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Aug 2016 13:23:01 -0700 (PDT)
Subject: Re: [PATCH 03/22] sequencer: avoid unnecessary indirection
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <e5e6c27038c7db226a787da6b7ee343b2b310654.1472457609.git.johannes.schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <90d26cba-0013-eb31-ba40-52f3e2f9d239@gmail.com>
Date:   Mon, 29 Aug 2016 22:22:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <e5e6c27038c7db226a787da6b7ee343b2b310654.1472457609.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 29.08.2016 o 10:04, Johannes Schindelin pisze:

> We really do not need the *pointer to a* pointer to the options in
> the read_populate_opts() function.

Right.
 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 4d2b4e3..14ef79b 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -809,11 +809,11 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
>  	return 0;
>  }
>  
> -static int read_populate_opts(struct replay_opts **opts)
> +static int read_populate_opts(struct replay_opts *opts)

Especially that other *_populate_*() use 'struct replay_opts *opts':

   read_populate_todo(struct commit_list **todo_list, struct replay_opts *opts)
   walk_revs_populate_todo(struct commit_list **todo_list, struct replay_opts *opts)

Though they use **todo_list, because they modify this list;
maybe that was why read_populate_opts was using **opts instead
of *opts?

>  {
>  	if (!file_exists(git_path_opts_file()))
>  		return 0;
> -	if (git_config_from_file(populate_opts_cb, git_path_opts_file(), *opts) < 0)
> +	if (git_config_from_file(populate_opts_cb, git_path_opts_file(), opts) < 0)
>  		return error(_("Malformed options sheet: %s"),
>  			git_path_opts_file());
>  	return 0;
> @@ -1038,7 +1038,7 @@ static int sequencer_continue(struct replay_opts *opts)
>  
>  	if (!file_exists(git_path_todo_file()))
>  		return continue_single_pick();
> -	if (read_populate_opts(&opts) ||
> +	if (read_populate_opts(opts) ||
>  			read_populate_todo(&todo_list, opts))
>  		return -1;
>  
> 

