Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58400C4332F
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 02:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235130AbiKRCLC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 21:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235134AbiKRCK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 21:10:59 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3B985EC8
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 18:10:57 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 140so3562574pfz.6
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 18:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CEeKjAVs+UbgjrMgupv1lXaAc0YM0JJxy5TYwwZK5tQ=;
        b=ZmeUDP6VhvKoebpOd1mqugq6LEVUN7ihKw3F7dQDh5bfSOJrWOFQrCu3LBu2KqxDQn
         BckS35O7I/fMfcweyUQcFGBjRkOSoaeaZsuQBrOV73u5zAbBJsexHflLJkZmCa4XGQY2
         jE2zuncHhLkkgcbg2lb/vb4JsHC89tRD/8a8cY+/6KTWO4kaKrff1SUsQrqY4RElTgtH
         Mn6R+3fAaSIMEpUxKiOhQVpFnaCUcGolvkUeI65MtxJCt2a4CSBMR/fMAzLrf5x2WxtW
         I6+4FaIvFOh+QyHorTL9E3nG5iCRULil9vRrct7tmGZNiBRBsgEq8i0vfFWZL8Dyp7Ml
         u+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CEeKjAVs+UbgjrMgupv1lXaAc0YM0JJxy5TYwwZK5tQ=;
        b=rr2xIxd+pHN4waF3Cz+KECeSs8KJ1mpF/x8QLoEFuY7O+iu2Fjl3eWFo17qTFieXEq
         zQB0hPvluIdmZn40jP+XQ6qq30k4PJ1VsN4gGGcg7UxzG/9YIFmQnWuhwo7PtEjnS4Is
         +nd/NOTDIEgzAVOzOKCbjJTLpegmSl8JXtYAvFy7Tz9fQVheUE5ffdRp2Omw90KC6EnL
         P7ofPqqXOj9aYq2DorMW/g7SBmZyHwO2pnqM3REP+jYjSi7v8u/kAgfbql7fFZZowtOY
         ig2885gaNmBWpoaqVN+RaPW5LGPWpDIePbyHsGbpl7w40IETFf8TdbhSnyNaVm1Yrpo/
         xsaQ==
X-Gm-Message-State: ANoB5pnFfvxz4dIcGbC9VUmNOqPvC6PnGrCPc2RlB5ttnbtnrwQOlX35
        M/wRg0jQXgfPY5LUO//uOEEa
X-Google-Smtp-Source: AA0mqf5tkQR881pT11vVh6fTk4rSWOqnIUxmiFOsr4m69alRGaNtmNNu3HWgfcRxjtwoXTQInD2S6g==
X-Received: by 2002:aa7:9f0d:0:b0:56b:e16d:b08 with SMTP id g13-20020aa79f0d000000b0056be16d0b08mr5662196pfr.70.1668737457409;
        Thu, 17 Nov 2022 18:10:57 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id l12-20020a170903120c00b0016be834d54asm2079673plh.306.2022.11.17.18.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 18:10:56 -0800 (PST)
Message-ID: <8457ad4c-51c7-4c2d-8dbf-02a60045d288@github.com>
Date:   Thu, 17 Nov 2022 18:10:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] branch: clear target branch configuration before
 copying or renaming
Content-Language: en-US
To:     =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>,
        Git List <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
References: <f0b2d46c-2e9c-2630-2870-8ed550dd1606@gmail.com>
 <762c1e8f-fd0c-3b4b-94a0-709d8c9431e4@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <762c1e8f-fd0c-3b4b-94a0-709d8c9431e4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rubén Justo wrote:
> There are two problems with -m (rename) and -c (copy) branch operations.
> 
>  1. If we force-rename or force-copy a branch to overwrite another
>  branch that already has configuration, the resultant branch ends up
>  with the source configuration (if any) mixed with the configuration for
>  the overwritten branch.
> 
> 	$ git branch upstream
> 	$ git branch -t foo upstream  # foo has tracking configuration
> 	$ git branch bar              # bar has not
> 	$ git branch -M bar foo       # force-rename bar to foo
> 	$ git config branch.foo.merge # must return clear
> 	refs/heads/upstream

What happens if 'bar' has tracking info? You mentioned that the
configuration is "mixed" - does that mean 'foo' would have both the original
'foo's tracking info *and* 'bar's? 
> 
>  2. If we repeatedly force-copy a branch to the same name, the branch
>  configuration is repeatedly copied each time.
> 
> 	$ git branch upstream
> 	$ git branch -t foo upstream  # foo has tracking configuration
> 	$ git branch -c foo bar       # bar is a copy of foo
> 	$ git branch -C foo bar       # again
> 	$ git branch -C foo bar       # ..
> 	$ git config --get-all branch.bar.merge # must return one value
> 	refs/heads/upstream
> 	refs/heads/upstream
> 	refs/heads/upstream
> 
> Whenever we copy or move (forced or not) we must make sure that there is
> no residual configuration that will be, probably erroneously, inherited
> by the new branch.  To avoid confusions, clear any branch configuration
> before setting the configuration from the copied or moved branch.

I wasn't sure whether "transfer the source's tracking information to the
destination" was the desired behavior, but it looks like it is (per
52d59cc6452 (branch: add a --copy (-c) option to go with --move (-m),
2017-06-18)). Given that, I agree this is the right fix for the issue you've
identified.

> 
> Signed-off-by: Rubén Justo <rjusto@gmail.com>
> ---
>  builtin/branch.c  | 17 +++++++++++------
>  t/t3200-branch.sh | 19 +++++++++++++++++++
>  2 files changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/builtin/branch.c b/builtin/branch.c
> index a35e174aae..14664f0278 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -583,12 +583,17 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
>  
>  	strbuf_release(&logmsg);
>  
> -	strbuf_addf(&oldsection, "branch.%s", interpreted_oldname);
> -	strbuf_addf(&newsection, "branch.%s", interpreted_newname);
> -	if (!copy && git_config_rename_section(oldsection.buf, newsection.buf) < 0)
> -		die(_("Branch is renamed, but update of config-file failed"));
> -	if (copy && strcmp(interpreted_oldname, interpreted_newname) && git_config_copy_section(oldsection.buf, newsection.buf) < 0)
> -		die(_("Branch is copied, but update of config-file failed"));
> +	if (strcmp(interpreted_oldname, interpreted_newname)) {
> +		strbuf_addf(&oldsection, "branch.%s", interpreted_oldname);
> +		strbuf_addf(&newsection, "branch.%s", interpreted_newname);
> +
> +		delete_branch_config(interpreted_newname);
> +
> +		if (!copy && git_config_rename_section(oldsection.buf, newsection.buf) < 0)
> +			die(_("Branch is renamed, but update of config-file failed"));
> +		if (copy && git_config_copy_section(oldsection.buf, newsection.buf) < 0)
> +			die(_("Branch is copied, but update of config-file failed"));
> +	}

Makes sense. 

>  	strbuf_release(&oldref);
>  	strbuf_release(&newref);
>  	strbuf_release(&oldsection);
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 7f605f865b..c3b3d11c28 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -218,6 +218,25 @@ test_expect_success 'git branch -M should leave orphaned HEAD alone' '
>  	)
>  '
>  
> +test_expect_success 'git branch -M inherites clean tracking setup' '

s/inherites/inherits

> +	test_when_finished git branch -D moved &&
> +	git branch -t main-tracked main &&
> +	git branch non-tracked &&
> +	git branch -M main-tracked moved &&
> +	git branch --unset-upstream moved &&
> +	git branch -M non-tracked moved &&
> +	test_must_fail git branch --unset-upstream moved

If I'm reading this correctly, the test doesn't actually demonstrate that
'git branch -M' cleans up the tracking info, since 'moved' never has any
tracking info immediately before 'git branch -M'. The test could also be
more precise by verifying the upstream name matches. What about something
like this?

	test_when_finished git branch -D moved &&
	git branch -t main-tracked main &&
	git branch non-tracked &&

	# `moved` doesn't exist, so it starts with no tracking info
	echo main >expect &&
	git branch -M main-tracked moved &&
	git rev-parse --abbrev-ref moved@{upstream} >actual &&
	test_cmp expect actual &&

	# At this point, `moved` is tracking `main`
	git branch -M non-tracked moved &&
	test_must_fail git rev-parse --abbrev-ref moved@{upstream}

> +'
> +
> +test_expect_success 'git branch -C inherites clean tracking setup' '

s/inherites/inherits (same typo as before, just pointing it out so it's
easier to find)

> +	test_when_finished git branch -D copiable copied &&
> +	git branch -t copiable main &&
> +	git branch -C copiable copied &&
> +	git branch --unset-upstream copied &&
> +	git branch -C copied copiable &&
> +	test_must_fail git branch --unset-upstream copiable

This doesn't have the same issue as the other test (since 'copied' has no
tracking but 'copiable' does before both 'git branch -C' calls), but it
would still be nice to use the 'git rev-parse --abbrev-ref
<branch>@{upstream}' for more precision here. 

> +'
> +
>  test_expect_success 'resulting reflog can be shown by log -g' '
>  	oid=$(git rev-parse HEAD) &&
>  	cat >expect <<-EOF &&

