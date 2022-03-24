Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB88DC433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 18:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351453AbiCXSCn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 14:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236126AbiCXSCm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 14:02:42 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D327B53C4
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 11:01:09 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id g3so5555223plo.6
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 11:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8HdmE/JChM9YjWDG1sLjHqUNC5GO2ZsFLTz2tQVnG3k=;
        b=gVEr36/4Vqq7rm43rNFMzKrO1pdfGIfw6iJPnpDcTxIKQogYFGosKbLN2PtZ/8Oa9T
         SK4ZIWxfzCc3RkVzLYDXGD9Chnd78bSzrvT5yg3kxIVNPuL7Q19SbVJtb2blD1dKdIrU
         cnYZnIjd0sPLdk28DpS2Evd83wfYK407oqkU+SVKXcTPLvXcdJbd57BQJeNea9h8xXOA
         IEdvj3hBudoGrj9rt2mjt79vHPW5IUpdP+13EXNJpdKUeBJ0iIekpC1dTMvG9C1gn9Nx
         5PkfM57M0USkawIfe4dutG2+Uk3t4Xr/9tlZZ5xWZRuIXbcCAqANrLZRLfVO4X+vUxDR
         6PYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8HdmE/JChM9YjWDG1sLjHqUNC5GO2ZsFLTz2tQVnG3k=;
        b=nquhTxnFOrv8uCd+EKYCZ0DHMzsgizIB1DFCCziRpx/1ad6pqpjvcE1QxKse3yNCT5
         N4Vc5BQDo0O1/P5T8kqcs7RXIzOMTt5O8PWf2BFEYFgg46fTT+X9aguSM12/ZpvNR1FC
         pGbXVzrkmViyFSWw4UZlFrvdRdCkKFPTDXrEylrhD1c+jNVjNmuI6fsMea761o2fAz5Z
         EvVo+NOYrJRRAaszhTgei9zG40EhwgMPU07DvQOXxKE2J8U5iXYWlMcsOtPxYEQ2+Dyi
         9Qv6rf2QGS3QZRfpH6He7ZX2PUREUt0kk9QnvT1Z8OzlcXOoKODljqM38FUIRI6dgxGJ
         RQCA==
X-Gm-Message-State: AOAM531skh6V0HsJj2jx0eVaf+SfV24ofBo52+QDpZ/SMm5YR17MqW5e
        g7opTYzrJUOuzUZlUdIkrZlb
X-Google-Smtp-Source: ABdhPJzxQJfAhnMSqQMNb2RkdR5iUkJdmYsUxbTQ0TV3yKkqOVPSlLlavPrSXrssMo0+P9Hc0xp/bQ==
X-Received: by 2002:a17:902:cecb:b0:154:68b6:cf61 with SMTP id d11-20020a170902cecb00b0015468b6cf61mr6945456plg.12.1648144868458;
        Thu, 24 Mar 2022 11:01:08 -0700 (PDT)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id d18-20020a056a0010d200b004fa2e13ce80sm4228870pfu.76.2022.03.24.11.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 11:01:07 -0700 (PDT)
Message-ID: <fb16c818-288f-aa8b-cafd-cd418d84f194@github.com>
Date:   Thu, 24 Mar 2022 11:01:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/3] reset: make --no-refresh the only way to skip
 index refresh
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
References: <pull.1184.git.1647894889.gitgitgadget@gmail.com>
 <pull.1184.v2.git.1648059480.gitgitgadget@gmail.com>
 <6d424915-5c63-bebd-f3b5-f153a541d077@gmail.com> <xmqqsfr7jmtb.fsf@gitster.g>
 <xmqq7d8jjlwp.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqq7d8jjlwp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> ... as you suggested, I think mimicking how existing commands with
>> "--no-<option>" are shown, e.g. builtlin/update-ref.c does
>> "--no-deref",
>>
>>     $ git update-ref -h 2>&1 | grep deref
>>         --no-deref            update <refname> not the one it points to
>>     $ git grep 'OPT_BOOL.*"no-deref"'
>>     builtin/update-ref.c:		OPT_BOOL( 0 , "no-deref", &no_deref,
>>
>> would be a good approach.
>>
>>> The range-diff for the other changes looks good
>>
>> Thanks.
>>
>> #leftoverbit: we may want to discuss if it is a good idea to teach
>> OPT_BOOL() to list "--[no-]<option>" in "git cmd -h", instead of
>> just "--<option>".
> 
> 
> Unfortunately, I merged these already to 'next' before seeing your
> comment, so we'd need to go incremental.
> 
> How about this?
> 
> ----- >8 --------- >8 --------- >8 --------- >8 -----
> Subject: [PATCH] reset: show --no-refresh in the short-help
> 
> In the short help output from "git reset -h", the recently added
> "--[no-]refresh" option is shown like so:
> 
>         --refresh             skip refreshing the index after reset
> 
> which explains what happens when the option is given in the negative
> form, i.e. "--no-refresh".  We could rephrase the explanation to
> read "refresh the index after reset (default)" to hint that the user
> can say "--no-refresh" to override the default, but listing the
> "--no-refresh" form in the list of options would be more helpful.
> 
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/reset.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git c/builtin/reset.c w/builtin/reset.c
> index 1d89faef5e..344fff8f3a 100644
> --- c/builtin/reset.c
> +++ w/builtin/reset.c
> @@ -392,7 +392,7 @@ static int git_reset_config(const char *var, const char *value, void *cb)
>  int cmd_reset(int argc, const char **argv, const char *prefix)
>  {
>  	int reset_type = NONE, update_ref_status = 0, quiet = 0;
> -	int refresh = 1;
> +	int no_refresh = 0;
>  	int patch_mode = 0, pathspec_file_nul = 0, unborn;
>  	const char *rev, *pathspec_from_file = NULL;
>  	struct object_id oid;
> @@ -400,7 +400,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>  	int intent_to_add = 0;
>  	const struct option options[] = {
>  		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
> -		OPT_BOOL(0, "refresh", &refresh,
> +		OPT_BOOL(0, "no-refresh", &no_refresh,
>  				N_("skip refreshing the index after reset")),
>  		OPT_SET_INT(0, "mixed", &reset_type,
>  						N_("reset HEAD and index"), MIXED),
> @@ -519,7 +519,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>  			if (read_from_tree(&pathspec, &oid, intent_to_add))
>  				return 1;
>  			the_index.updated_skipworktree = 1;
> -			if (refresh && get_git_work_tree()) {
> +			if (!no_refresh && get_git_work_tree()) {
>  				uint64_t t_begin, t_delta_in_ms;
>  
>  				t_begin = getnanotime();

This looks good to me, and it's passing all of the relevant tests. Thank you
both for your help with this!
