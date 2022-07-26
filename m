Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A746CC00144
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 19:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239654AbiGZTz0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 15:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiGZTzW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 15:55:22 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A36BF45
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 12:55:20 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h8so21528595wrw.1
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 12:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bAsZ6TdyzWh2eARWcnQ9kjOLWMQxdyr5OUCyOeXbwJ4=;
        b=PYn+E4zLwiJ5bRSC5202cFiCfQAxenbg4v9fus7Meu5XKPmJXn1Ok8tYpGTIRPvq22
         GfMZAuBXByVhxSJZedB3a5sQLZzUomalwLvZRU27xQAViJQyXzWYW2RbZvLroDkqnrQb
         yyrhAji1HRBOxnWIxobgY3ngSl8D7uc1BOBKvw0DfFEqIMlalzISLUX8yQXqpKteb1lM
         VE2+BMcL26A9mxRsm+RqlLK0356iOX303s+8ewdm0hf6PbBbZCj9xo/D9cs0m8Txgehm
         zyH9560Tw9q0v+fY2xvumIBz/OMS2xf3q4M6hdrnadYy/PUVzf+XLzJv1a0/5d7vbxOs
         uTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bAsZ6TdyzWh2eARWcnQ9kjOLWMQxdyr5OUCyOeXbwJ4=;
        b=SrQLOHyPal8comi7VnlaTpyVg0++xzSdA5c6yitUYQHQFe1AnQbPT2WH5HVEab54os
         onvt0KOiXw2daaQiqGZtnQMS4joX1lfG5ezdZC7vwZyZvPOJL5fb5VLNInv9VyywRiaT
         RCvAxzeWsrJM0uBJk67zQQ1oOw7bp0farI73l8XNIiR2j61vnXGzSWz6Vzl8FxH+g6Y/
         /eZgYe0qNmL6NOrHwZkMfLWMTTkogU8IZq8ThJFjJQyavk2KJXKS62+fjcVEHLomlswK
         8rQ0HGzkrgospSZ2NjZM4CKq+IOf5T/HVrXEQ2Eb0OhRomdNFLd0yvPUZrs74tfVmACo
         t1Mg==
X-Gm-Message-State: AJIora9zkE5jF5z7jlpLQIvbEfMSrcIiHSKkYCX/vyuJzf/0qoby35x8
        6GT6VLzPpe35z23BrQac+PHcw4oivmM=
X-Google-Smtp-Source: AGRyM1upeo+PybpGNdesRsVJEGEHOcbsjc8WI/GQ1PJJggwffE9mwjUJdrCSrvWyR3jmyPGDxb08mA==
X-Received: by 2002:adf:df83:0:b0:21e:beac:61f9 with SMTP id z3-20020adfdf83000000b0021ebeac61f9mr1043489wrl.125.1658865319282;
        Tue, 26 Jul 2022 12:55:19 -0700 (PDT)
Received: from localhost (94-21-23-94.pool.digikabel.hu. [94.21.23.94])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bce06000000b003a35516ccc3sm9582113wmc.26.2022.07.26.12.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 12:55:18 -0700 (PDT)
Date:   Tue, 26 Jul 2022 21:55:16 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 01/20] git.c: update NO_PARSEOPT markings
Message-ID: <20220726195516.GA2264@szeder.dev>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220725123857.2773963-2-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220725123857.2773963-2-szeder.dev@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 25, 2022 at 02:38:38PM +0200, SZEDER Gábor wrote:
> Our Bash completion script can complete --options for commands using
> parse-options even when that command doesn't have a dedicated
> completion function, but to do so the completion script must know
> which commands use parse-options and which don't.  Therefore, commands
> not using parse-options are marked in 'git.c's command list with the
> NO_PARSEOPT flag.
> 
> Update this list, and remove this flag from the commands that by now
> use parse-options.
> 
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  git.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/git.c b/git.c
> index e5d62fa5a9..c4282f194a 100644
> --- a/git.c
> +++ b/git.c

> @@ -627,7 +627,7 @@ static struct cmd_struct commands[] = {
>  	{ "verify-tag", cmd_verify_tag, RUN_SETUP },
>  	{ "version", cmd_version },
>  	{ "whatchanged", cmd_whatchanged, RUN_SETUP },
> -	{ "worktree", cmd_worktree, RUN_SETUP | NO_PARSEOPT },
> +	{ "worktree", cmd_worktree, RUN_SETUP },

This hunk is wrong, 'worktree' does not use parse_options().  I was
fooled by seeing its (empty) 'struct option' array, thinking that then
it must surely use parse_options(), but it only uses that options
array to pass it to usage_with_options().

This NO_PARSEOPT flag should be removed in the last patch of the
series, when I convert cmd_worktree() to handle its subcommands with
parse_options().

>  	{ "write-tree", cmd_write_tree, RUN_SETUP },
>  };
>  
> -- 
> 2.37.1.633.g6a0fa73e39
> 
