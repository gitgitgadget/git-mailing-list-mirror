Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 414A3208CD
	for <e@80x24.org>; Tue, 15 Aug 2017 23:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752623AbdHOXOT (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 19:14:19 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37914 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751095AbdHOXOS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 19:14:18 -0400
Received: by mail-pg0-f65.google.com with SMTP id 123so3483255pga.5
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 16:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5KI2tYgDmmT4K9h8AxKZulSm+1+KWbUQiclgfltBlFM=;
        b=SAPH8WvUM5Ux/UnnPT+24LsRtG1ZZkZWzQGClUdccQkPKowSMWG+YPLN23/8ImvliH
         u7i8eLdHQWOvPbHtEYvtWcM6ghae57geQokzbfHs0tXbZvlHg+fk8PGss1KeCA+vAxFn
         jk3+zhf+8yh8livMHSdnbERKmk1MvG8rSqcJke/J7aLlLVG0upwuFEbceRu6GmGgYgDF
         I0AySFuUsx85SDutnlq8LQusnQw4hWP/zWL37HNOTdZLF5XqeNWMxuqxEjMfz2ZjeDcD
         ie3H+Rd0ZlbB7O4H8Gx1QU0DYks5Pef490cRKjzWqoDHBciDsUyWn14q+XK6f0etST7B
         TOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5KI2tYgDmmT4K9h8AxKZulSm+1+KWbUQiclgfltBlFM=;
        b=TJyEbWDRaYz/+pKyrMCkLBtjSnBCtrUX5wPpcJybK6Cbww65CrQ8XPcLGu6z3FxVCF
         8Vk/P2HJSGtFzsUvlLoDCZrjFWyDszM4zDUqT5vlO95072nC1z3QeoK5A8Bof6Jy+dRf
         jTjB4qO6cN8PaWnKxdOKQN+M5ubOCdWlv4JXDPFkMcaD16p2uit0JlxbK6bujrQ1NBiH
         VgxXCqmMgfLOpx3Tz6dBXsPWdnXyJuFR6h040GGKb3VcwcScdpAwLc173ayGrCCxA9Dl
         H/OrKPr/02YTq0VHa5qsnqmeZypV7XzmEOEMMvM7xJLY90EbsqeZW79Aw7yubc0U2x6s
         sozQ==
X-Gm-Message-State: AHYfb5i1k8j3yKeLZ3xxBzlAyhLiByayhSvI27GaRVkJHKxtsMMZSd2p
        CkJwkE8aAjP6Cw==
X-Received: by 10.84.128.8 with SMTP id 8mr33023799pla.391.1502838857504;
        Tue, 15 Aug 2017 16:14:17 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5181:69ef:a50:cd47])
        by smtp.gmail.com with ESMTPSA id d4sm20523203pfj.59.2017.08.15.16.14.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Aug 2017 16:14:16 -0700 (PDT)
Date:   Tue, 15 Aug 2017 16:14:14 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] push: do not add submodule odb as an alternate when
 recursing on demand
Message-ID: <20170815231414.GF13924@aiede.mtv.corp.google.com>
References: <CAGZ79kZouNBxOKr7X8j6wqebp3Wh3cDqhYR-t_PxaF7AwQ0Wzg@mail.gmail.com>
 <20170815224332.22730-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170815224332.22730-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> Use is_submodule_populated_gently instead, which is simpler and
> cheaper.
[...]
> --- a/submodule.c
> +++ b/submodule.c
> @@ -966,7 +966,9 @@ static int push_submodule(const char *path,
>  			  const struct string_list *push_options,
>  			  int dry_run)
>  {
> -	if (add_submodule_odb(path))
> +	int code;
> +
> +	if (!is_submodule_populated_gently(path, &code))
>  		return 1;

Ah, I forgot about this detail.  I don't think it should block this
patch (so my Reviewed-by still stands), but I wonder why this needs to
be gentle.  add_submodule_odb is gentle so that is the conservative
thing to do, but that doesn't mean it is the *right* thing to do.

If this passed NULL instead of &code as the second argument, would
anything break?

Could there be a comment explaining what kind of error we are
expecting and why it is okay to continue when that error is
encountered without any error handling?

Thanks,
Jonathan
