Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD56C678D4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 09:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjCFJjR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 04:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjCFJjP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 04:39:15 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E5F1BAEA
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 01:39:14 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id h11so8091446wrm.5
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 01:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678095553;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nmoYByc7hT9Rbe2q3WSn27zbZGiHl3J8wqxqd/LI1/8=;
        b=q0qZi970UgcXiGWE2BVDf8CfiSpLt+RQ8Bydx55m9fJV3+SMGKfR8m+hJ0VwTAluzY
         WqzNibueWeYr++r4r7/HrxHeC4gjaWNJpSiB2ixT1j5je4cCMvRZkIyRROinHhzMDAlB
         zaELPWXg/aF4+kYuFfww2VrM7ishD4DF8wlgVsZ/ZXgA0dxXucMGWS8wB3IodG+J68wf
         O/Pp0E7DSGyVyRPkicArxzz9YE640ruixfsaEdJEM0LXxXmZmYK8ioTuJI2TrezJaDys
         /iLJABG+KirOMzFOhGaEUwYOZfqO1ISMD/eT5xMa8AIBr5x6HDTT/LTqxZ3sEwFtkVCp
         rRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678095553;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmoYByc7hT9Rbe2q3WSn27zbZGiHl3J8wqxqd/LI1/8=;
        b=FL8Ci/8GahqwM1q6i0d4lFQn5BdqlOaplfCCynBV2WyzYiDs4r0sJSrw3cMLXuuVE3
         r4qh3Cbuqutt4PiTOK5LVjoQWKfJ0AbSeXORYNIPRfTJPJ/ks+eD9Wpoz7HxqwQraBQk
         Whh1zoCj1ZuIYHp/SXWNiK9hsy64nq+6uWA43Q3OpesUu//JqwKum/SYWAdvVTdyGXkL
         MO02Flq1yHp44ktRmHqSnOCBdM4CAucirmLznh8WVZ7elWWWIvWvFPZdEqfkxCYV6dBe
         1bEBzjeB6AW38SSb8bbPnLrZDDANeOQ/I2H0s/7aKD4txE38fkYKFGXyMKyp24xyfVgH
         nHmQ==
X-Gm-Message-State: AO0yUKWQ5O/aZWOLzRZfa7AoECFzpucVai6alygLbvgBrdWZ/Z3NQGFc
        rqZNmGLZk5MgpccmmVs+6oD9VSBC8IU=
X-Google-Smtp-Source: AK7set8/x2amQaryi4C4XScTJXUG6A8Lqc7eC0P4lOV1eE2Lpauvy/3PfdKCFoOjcOv86IMyveNYGw==
X-Received: by 2002:adf:ffc7:0:b0:2c5:532a:98c4 with SMTP id x7-20020adfffc7000000b002c5532a98c4mr9836138wrs.33.1678095552901;
        Mon, 06 Mar 2023 01:39:12 -0800 (PST)
Received: from [192.168.1.212] ([90.248.23.119])
        by smtp.gmail.com with ESMTPSA id g11-20020adffc8b000000b002c7b229b1basm9355234wrr.15.2023.03.06.01.39.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 01:39:12 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <0ba2f495-892c-3e27-a32c-9f136e86fc26@dunelm.org.uk>
Date:   Mon, 6 Mar 2023 09:39:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] add -p: obey diff.noprefix option if set
Content-Language: en-US
To:     Jeff King <peff@peff.net>, Marcel Partap <mpartap@gmx.net>
Cc:     git@vger.kernel.org
References: <20230304123900.358048-1-mpartap@gmx.net>
 <ZAWnDUkgO5clf6qu@coredump.intra.peff.net>
In-Reply-To: <ZAWnDUkgO5clf6qu@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/03/2023 08:40, Jeff King wrote:
> On Sat, Mar 04, 2023 at 01:39:00PM +0100, Marcel Partap wrote:
> There are two options, I think.
> 
> One is that we have a similar issue with color. To handle that, we
> generate the diff twice, once with color and once without. We could
> probably do the same thing here, by sticking the "--no-prefix" part with
> the color setup. Though it turns out to be a little tricky to do because
> of the way the code is written, and IIRC there are probably some corner
> cases lurking (e.g., after splitting, I think we'll try to re-colorize
> the diff headers ourselves).
> 
> The second is to just remember that we set noprefix and to add the
> matching "-p0". Unfortunately we have to do so in a few places, but it's
> not _too_ bad (and possibly some refactoring could make it less ugly).
> Something like:

I think that is the better approach. Looking at how we handle 
diff.algorithm we should maybe add a "noprefix" member to "struct 
add_i_state" and initialize it in init_add_i_state() (which is in 
add-interactive.c). That way we're consistent with the existing code and 
we don't need to keep calling git_config_get_bool() whenever we want the 
value of diff.noPrefix.

> diff --git a/add-patch.c b/add-patch.c
> index 520faae9cba..6e5390621c0 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -1189,13 +1189,16 @@ static int run_apply_check(struct add_p_state *s,
>   			   struct file_diff *file_diff)
>   {
>   	struct child_process cp = CHILD_PROCESS_INIT;
> +	int noprefix;
>   
>   	strbuf_reset(&s->buf);
>   	reassemble_patch(s, file_diff, 1, &s->buf);
>   
>   	setup_child_process(s, &cp,
>   			    "apply", "--check", NULL);
>   	strvec_pushv(&cp.args, s->mode->apply_check_args);
> +	if (!git_config_get_bool("diff.noprefix", &noprefix) && noprefix)
> +		strvec_pushf(&cp.args, "-p1");

I think you meant "-p0" here

Best Wishes

Phillip

>   	if (pipe_command(&cp, s->buf.buf, s->buf.len, NULL, 0, NULL, 0))
>   		return error(_("'git apply --cached' failed"));
>   
> @@ -1695,7 +1698,10 @@ static int patch_update_file(struct add_p_state *s,
>   			apply_for_checkout(s, &s->buf,
>   					   s->mode->is_reverse);
>   		else {
> +			int noprefix;
>   			setup_child_process(s, &cp, "apply", NULL);
> +			if (!git_config_get_bool("diff.noprefix", &noprefix) && noprefix)
> +				strvec_pushf(&cp.args, "-p0");
>   			strvec_pushv(&cp.args, s->mode->apply_args);
>   			if (pipe_command(&cp, s->buf.buf, s->buf.len,
>   					 NULL, 0, NULL, 0))
> 
>>   add-patch.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> We'd probably want at least one test using "add -p" with diff.noprefix
> (probably in t3701). That would demonstrate that the feature works, as
> well as protect it from future regressions (the test suite doesn't fail
> even with your broken patch because no test sets noprefix).
> 
> -Peff
