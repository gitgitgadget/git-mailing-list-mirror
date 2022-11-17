Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8A2C433FE
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 22:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240812AbiKQWT2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 17:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240076AbiKQWTB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 17:19:01 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A214887A7F
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 14:18:13 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id v28so3100378pfi.12
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 14:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wxzbS+YKdPs9Dv/VKsld6X5ovecHEbD2iTZemo6HnKg=;
        b=arlbdNdlq9rhnEVjgnE4idi46faz1NXt5TaxWLjFg/EeHihc4xTNenDBSZvQKBL7mz
         Jlehpiig8tn0fBwdimsY0k5oa8qWEL4KqwuMd+QlU00zgDyUd3UX150QBbcYMx/pYpz3
         84+YnGq3PV8slMcNOibiAi9DAl94KEXdN87U5GBiGiUAiY6pClQxPKjX1Uw+imxdYebJ
         FVn94auGth/iYr42lEO+iMoxH8bpQ7t7A+TIuTOYhQBv8LMiaqWVFW8JJRmXdLl0deG8
         X6CAJJLSWy72UlLs4un5TJTZ6sSqBxqOe6o5AIuHiwfyx0enZNmGkNt6mCsK0E0K5q6l
         bptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wxzbS+YKdPs9Dv/VKsld6X5ovecHEbD2iTZemo6HnKg=;
        b=zsjm1CEeK+IM0ihzLiwMGo3pL8T3yIEHUXSSO/RRa5vQZCe9BJyvWXvw6L/15JYi2I
         YZXsmNYxXml7ST+zYIO/soionFIou30DWO6zn5Z97pFW2/cjNJuVUibBOEcGnRxJFCus
         Qw1TfQz/eQdcbnj0LWfbTgYel99q1wOLtR/FIlqCgW3rFnRnoMtpTaktIiW9+sHD/DIm
         O2bAKw0QNfZ2JMIRZ41RxeWGRVBM78/znaIYeLkMkw6FXW7hx9gb6/EWI676P8aKUICe
         j2kzqKRPbNMmQnxfhRorwUGv6GfdPmRDL7VZV9fEprNcqdaFI4pbLaA3B+z+yOmjL8Gb
         +KfQ==
X-Gm-Message-State: ANoB5pm+lGyzBZCZASzqYRr0bY4aqNOvdkyHgyIfvE/kf5jpn5sPTbBY
        i8ePdItX0gOYgSiaoJvIPJxXIIlmV7CO
X-Google-Smtp-Source: AA0mqf7T7E4KiyjSeU8ex7yIU2QhaY51yLM4eqWaoWJiRO6geIq9ergT5JFp1vHqZFZ+aGRVmgryEQ==
X-Received: by 2002:a63:5007:0:b0:45f:beda:4116 with SMTP id e7-20020a635007000000b0045fbeda4116mr3948325pgb.618.1668723493005;
        Thu, 17 Nov 2022 14:18:13 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id b73-20020a621b4c000000b0056265011136sm1648171pfb.112.2022.11.17.14.18.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 14:18:12 -0800 (PST)
Message-ID: <9125ea40-3078-2ca3-493c-56703144f37e@github.com>
Date:   Thu, 17 Nov 2022 14:18:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] branch: force-copy a branch to itself via @{-1} is a
 no-op
Content-Language: en-US
To:     =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>,
        Git List <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
References: <f0b2d46c-2e9c-2630-2870-8ed550dd1606@gmail.com>
 <db182322-1383-4311-8baa-c4a9aeed3b4d@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <db182322-1383-4311-8baa-c4a9aeed3b4d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rubén Justo wrote:
> Since 52d59cc645 (branch: add a --copy (-c) option to go with --move
> (-m), 2017-06-18) we can copy a branch to make a new branch with the
> '-c' (copy) option or to overwrite an existing branch using the '-C'
> (force copy) option.  A no-op possibility is considered when we are
> asked to copy a branch to itself, to follow the same no-op introduced
> for the rename (-M) operation in 3f59481e33 (branch: allow a no-op
> "branch -M <current-branch> HEAD", 2011-11-25).  To check for this, in
> 52d59cc645 we compared the branch names provided by the user, source
> (HEAD if omitted) and destination, and a match is considered as this
> no-op.
> 
> Since ae5a6c3684 (checkout: implement "@{-N}" shortcut name for N-th
> last branch, 2009-01-17) a branch can be specified using shortcuts like
> @{-1}.  This allows this usage:
> 
> 	$ git checkout -b test
> 	$ git checkout -
> 	$ git branch -C test test  # no-op
> 	$ git branch -C test @{-1} # oops
> 	$ git branch -C @{-1} test # oops
> 
> As we are using the branch name provided by the user to do the
> comparison, if one of the branches is provided using a shortcut we are
> not going to have a match and a call to git_config_copy_section() will
> happen.  This will make a duplicate of the configuration for that
> branch, and with this progression the second call will produce four
> copies of the configuration, and so on.

This is a clear explanation of what the issue is and why it's happening.

> 
> Let's use the interpreted branch name instead for this comparison.
> 
> The rename operation is not affected.
> 
> Signed-off-by: Rubén Justo <rjusto@gmail.com>
> ---
>  builtin/branch.c                      |  6 +++---
>  t/t3204-branch-name-interpretation.sh | 10 ++++++++++
>  2 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 15be0c03ef..a35e174aae 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -584,13 +584,13 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
>  	strbuf_release(&logmsg);
>  
>  	strbuf_addf(&oldsection, "branch.%s", interpreted_oldname);
> -	strbuf_release(&oldref);
>  	strbuf_addf(&newsection, "branch.%s", interpreted_newname);
> -	strbuf_release(&newref);
>  	if (!copy && git_config_rename_section(oldsection.buf, newsection.buf) < 0)
>  		die(_("Branch is renamed, but update of config-file failed"));
> -	if (copy && strcmp(oldname, newname) && git_config_copy_section(oldsection.buf, newsection.buf) < 0)
> +	if (copy && strcmp(interpreted_oldname, interpreted_newname) && git_config_copy_section(oldsection.buf, newsection.buf) < 0)

I double-checked that 'interpreted_oldname' and 'interpreted_newname' are
always set (and not only when a shortcut name is used), and they are. So,
this does exactly what you intend.

>  		die(_("Branch is copied, but update of config-file failed"));
> +	strbuf_release(&oldref);
> +	strbuf_release(&newref);
>  	strbuf_release(&oldsection);
>  	strbuf_release(&newsection);
>  }
> diff --git a/t/t3204-branch-name-interpretation.sh b/t/t3204-branch-name-interpretation.sh
> index 793bf4d269..3399344f25 100755
> --- a/t/t3204-branch-name-interpretation.sh
> +++ b/t/t3204-branch-name-interpretation.sh
> @@ -57,6 +57,16 @@ test_expect_success 'create branch with pseudo-qualified name' '
>  	expect_branch refs/heads/refs/heads/qualified two
>  '
>  
> +test_expect_success 'force-copy a branch to itself via @{-1} is no-op' '
> +	git branch -t copiable main &&
> +	git checkout copiable &&
> +	git checkout - &&
> +	git branch -C @{-1} copiable &&
> +	git config --get-all branch.copiable.merge >actual &&
> +	echo refs/heads/main >expect &&
> +	test_cmp expect actual
> +'
> +

And the test is straightforward and demonstrates the fix. Thanks for the
well-written patch, this looks good to me! 

