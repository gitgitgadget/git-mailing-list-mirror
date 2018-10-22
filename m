Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1896A1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 22:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbeJWGx2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 02:53:28 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42496 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeJWGx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 02:53:27 -0400
Received: by mail-ed1-f65.google.com with SMTP id b7-v6so39474102edd.9
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 15:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=66Cx41gle9mWoICi0BQ0hGWCwIUCD765rDbKphk1ocs=;
        b=MTWAiP2rEAT8lkbvVA3QRO8LW8WRcPWGvEZI4WpoAWChB+L9+QaIbyDDeE15K/dPeI
         RN11IAeryGApyLQjqpLEeGP8D8gJVkRKDGTXgTG0ID8ff26jv+MT0uw6aMLxbyq5Cpcn
         pb8xzLkrFU83IgwNlOjYJqh1O9YDwfh9+K206NGrw9Hh97fDkpH/z196PQu0eLXjTA7z
         St+t5pl0Ea3AnTUR1BA1GZyqojJQuQOI5afCl9/OfiELUpqJHbPCCbtg3mrOAJQ90BRm
         eoSGK6tGJCCV/bt46g2DAXN7/cBkHn/dpqGM5YzEpkWlivJbwPYWjVQDyDCTqpwcSuZv
         l6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=66Cx41gle9mWoICi0BQ0hGWCwIUCD765rDbKphk1ocs=;
        b=n65uXZ2dStb8XmGiuBy4j5/Mzu2jruLrkiTSwvuTLn6eItVWTHJD38/OJcVvzv/PDi
         HVm+03DCxsceFe0TpBuLrN6aKa7mvBz6kOI9s1trerLZhhAmlA+tGoh+VW/naRjhwDmo
         O9LuRqG+PU/FcUm2uBvi84r+804b3YRDbZ0s54WY/bUgXLa4ToBg3ktbSjhmFN14RkBV
         XvavNBnhj9bnMDUCCtTwWlMPNGgO1OUslus+CPoZvzDsp9Ol/821lzavga7MJQrbdT/s
         VA3551kY8+La+Zxnhk/lIBWCWodIMs5WwEGSK9DYp/k0OOsIlgTlkPjdavRB1hfTLUAs
         TwFQ==
X-Gm-Message-State: ABuFfoh96RCiKbMYfANLyi5AXKHO0TsDbWbY6hGUBUxYLWeJaeUIKIwY
        zqUl6tF/eHLRT4BgKcB5SEf5yd+P
X-Google-Smtp-Source: ACcGV62qKrx/arwHofGHraJ9D1A1+csmTZ/Akx21f5k+EVOrHXrCUNOg5ZB5cEe9jqXSEonxoa8vlg==
X-Received: by 2002:a17:906:34d3:: with SMTP id h19-v6mr1473233ejb.115.1540247579816;
        Mon, 22 Oct 2018 15:32:59 -0700 (PDT)
Received: from szeder.dev (x4db968d4.dyn.telefonica.de. [77.185.104.212])
        by smtp.gmail.com with ESMTPSA id n41-v6sm14090503edd.7.2018.10.22.15.32.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 15:32:58 -0700 (PDT)
Date:   Tue, 23 Oct 2018 00:32:56 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Alban Gruin <alban.gruin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 3/3] rebase (autostash): use an explicit OID to apply
 the stash
Message-ID: <20181022223256.GI30222@szeder.dev>
References: <pull.52.git.gitgitgadget@gmail.com>
 <pull.52.v2.git.gitgitgadget@gmail.com>
 <07140a71dd9ed3f709970f0ce5eb6aa014417b25.1540246499.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <07140a71dd9ed3f709970f0ce5eb6aa014417b25.1540246499.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 22, 2018 at 03:15:05PM -0700, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> When `git stash apply <argument>` sees an argument that consists only of
> digits, it tries to be smart and interpret it as `stash@{<number>}`.
> 
> Unfortunately, an all-digit hash (which is unlikely but still possible)
> is therefore misinterpreted as `stash@{<n>}` reflog.
> 
> To prevent that from happening, let's append `^0` after the stash hash,
> to make sure that it is interpreted as an OID rather than as a number.

Oh, this is clever.

FWIW, all patches look good to me, barring the typo below.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/rebase.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 418624837..30d58118c 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -253,6 +253,8 @@ static int apply_autostash(struct rebase_options *opts)
>  
>  	if (read_one(path, &autostash))
>  		return error(_("Could not read '%s'"), path);
> +	/* Ensure that the hash is not mistake for a number */

s/mistake/mistaken/

> +	strbuf_addstr(&autostash, "^0");
>  	argv_array_pushl(&stash_apply.args,
>  			 "stash", "apply", autostash.buf, NULL);
>  	stash_apply.git_cmd = 1;
> -- 
> gitgitgadget
