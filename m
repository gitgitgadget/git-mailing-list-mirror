Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1B8C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 23:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344857AbiCJXnS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 18:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243342AbiCJXnS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 18:43:18 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB0019DEAD
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 15:42:16 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id u10-20020a63df0a000000b0037886b8707bso3702989pgg.23
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 15:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pIUh/WPUKtnzdiChCdvc9BjOXvHsqiGDlpXGmujlBBY=;
        b=HuzsJsLyY8/A/CgLL5McR0FUgqRJMw8r5ER97wTYTEEWFo/4JoqPN9LBQn3utJKcr7
         176zcpmOoFGqUudlVf8UNE8S6tMb/UVfBjn7nGHOWvO+Y/ZMWjIqyRoEjr9+Dsx4uZJ8
         VPsfgQo1t7wOiAkm86+2jGK8qSfWX6P/R0b4JvIFntbd4Y5biEp9RNP6wW1EJt1Rr7+d
         Wk/fefRYsBqEBCjcFYxHhS2SptQkK3g5JaIg7pj3lsOqhGIcn+9e9Z6jPexZOCK+POyA
         mTkFpOKv5v5j088Xmwi+7WuTQ7gm/Rr8tFMOTry7sRb1JLIUkfwOst63pl2RBmqGG+v9
         31Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pIUh/WPUKtnzdiChCdvc9BjOXvHsqiGDlpXGmujlBBY=;
        b=6tnkT3JG/u83Q72nApE+xvrZX0PVSRGAxa5CKCM+PcdBT06aGMInf4Ih0dPbFm7x12
         lU4wfLW+Bzh0JixVJISeF1XY6xW+FYdS0fLCR1NcG5YqnncOgSITYVcWOtTXu47lcsf7
         BYZQLVF8dzRIq11eC03fNbVGkqMhAXUL3qXW3ti/KDD5rpJaCyiPP+O68TgXD3IBvBqb
         axsCc47GsOHYmKfVpKq5fxj/sTWE+3Qgv2/cC8ldProrPPHxR+Yq9kVUEO8ZjfuJKrnr
         XodwOM12fHUUV4cqFEEzbhXMhIkaSLu80EbCuuiqZot/3lw9DTF40g+PWhID8vJNEb05
         /WWw==
X-Gm-Message-State: AOAM531d6SOynRtWNH8p1E6iZxVDyWddc+5I0bKB61UneOPPImTkBMII
        I5F4tPgfPUgX5dQH2r3bWUTIWreWNV6YEQ==
X-Google-Smtp-Source: ABdhPJxu01J244XHlYnW4hcogPHKIplU9dAsKkXyQwEe0Ez6u4BCc1KCALnaO1KKfzKJipx+PlnCfiuF4ZcCmg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1a42:b0:4d1:e81a:64cb with SMTP
 id h2-20020a056a001a4200b004d1e81a64cbmr7633677pfv.78.1646955735611; Thu, 10
 Mar 2022 15:42:15 -0800 (PST)
Date:   Thu, 10 Mar 2022 15:42:12 -0800
In-Reply-To: <xmqqwnh1bgr4.fsf@gitster.g>
Message-Id: <kl6l4k45s7cb.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220310004423.2627181-1-emilyshaffer@google.com>
 <20220310004423.2627181-3-emilyshaffer@google.com> <xmqqtuc6h83m.fsf@gitster.g>
 <kl6la6dxsczx.fsf@chooglen-macbookpro.roam.corp.google.com> <xmqqwnh1bgr4.fsf@gitster.g>
Subject: Re: [PATCH v9 2/3] introduce submodule.hasSuperproject record
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index bef9ab22d4..f53808d995 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -2672,6 +2677,11 @@ static int run_update_procedure(int argc, const char **argv, const char *prefix)
>>                                             &update_data.update_strategy);
>>
>>         free(prefixed_path);
>> +       /*
>> +        * This entry point is always called from a submodule, so this is a
>> +        * good place to set a hint that this repo is a submodule.
>> +        */
>> +       git_config_set("submodule.hasSuperproject", "true");
>>         return update_submodule2(&update_data);
>>  }
>
> That matched my tentative resolution I made last night, but what do
> you think about this part of the test added by the patch?
>
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index 11cccbb333..ec2397fc69 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -1061,4 +1061,12 @@ test_expect_success 'submodule update --quiet passes quietness to fetch with a s
>  	)
>  '
>  
> +test_expect_success 'submodule update adds submodule.hasSuperproject to older repos' '
> +	(cd super &&
> +	 test_unconfig submodule.hasSuperproject &&
> +	 git submodule update &&
> +	 test_cmp_config -C submodule true --type=bool submodule.hasSuperproject
> +	)
> +'
> +
>  test_done
>
> We go to "super", make sure that superproject does not have
> submodule.hasSuperproject set, run "git submodule update", and see
> if the configuration file in "submodule" subdirectory has the
> variable set.  It does not clear the variable from the submodule
> before starting, so the variable given to the submodule when it was
> cloned would be there, even if "git submodule update" failed to set
> it.
>
> I am wondering if it should do something like the attached instead.
>
> We
>
>  * clear the variable from "super" and "super/submodule"
>    repositories;
>
>  * run "git submodule update";
>
>  * ensure that "git submodule update" did not touch "super/.git/config";
>
>  * ensure that "git submodule update" added the variable to
>    "super/submodule/.git/config".
>
> Clearing the variable from "super" is technically wrong because the
> repository is set up as a submodule of "recursivesuper" and if we
> had further tests, we should restore it in "super", but the point is
> that we are makng sure "git submodule update" sets the variable in
> the configuration file of the submodule, and not in the superproject's. 

Yes, the test you've described is closer to what I thought the original
test was trying to do. Seeing this test pass gave me a false sense of
confidence hm..

> With the conflict resolution above, this "corrected" test fails and
> shows that superproject's configuration file is updated after "git
> submodule update".
>
> This series alone, without your topic, this "corrected" test fails,
> and that is where my "are we sure we are mucking with the
> configuration file in the submodule"? comes from.

Yeah looks like we aren't in the submodule after all:

		out=$(git submodule--helper run-update-procedure \
			  ${wt_prefix:+--prefix "$wt_prefix"} \
			  ${GIT_QUIET:+--quiet} \
			  ${force:+--force} \
			  ${just_cloned:+--just-cloned} \
			  ${nofetch:+--no-fetch} \
			  ${depth:+"$depth"} \
			  ${update:+--update "$update"} \
			  ${prefix:+--recursive-prefix "$prefix"} \
			  ${sha1:+--oid "$sha1"} \
			  ${subsha1:+--suboid "$subsha1"} \
			  "--" \
			  "$sm_path")

This says "do the update at this submodule path", but this is being run
from the superproject.

So I suppose the way forward is one of the following:

- Revert my original suggestion
- Revert my original suggestion AND remove the git_config_set from
  "module_clone()" (before this, we unconditionally set this value in
  git-submodule.sh anyway)
- Set the config in the submodule even though we are running from the
  superproject (this is possible, ensure_core_worktree() does this).

In any case, sorry for the faulty suggestion :(
