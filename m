Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45ED9C7EE23
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 17:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjB0RSu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 12:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjB0RSr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 12:18:47 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7E41F934
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 09:18:42 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so10876877pjh.0
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 09:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DN1sH5QsZZ3daHhsQk2wbhl3IJxWPtVtVBW0N3l5qSw=;
        b=J3kXS9cyTrUf4HnJMEl6PNOuoHd4nxMaBUkRhOq4TJ+iH+zEdsw8paICyEoMxbS5tf
         nXJU/QqLHXOVdsGVYFuG8VVyr9VFmyyOEDjCxb4wvi88m3QtXZxgF2WfKqxufmTldZhw
         E+2CJGO+kE3ox2LobxF1PFEXAXu6zaKZsQV2ECGe4uR5LS4TQkqde70Ab2xe1Ov7b/bt
         Amx2TllHV05ba4IJKR1DtsW2c5iYy7mY136CEqO+bIYpH37I0DkWyIkhC1UtSCphqSJZ
         bY485SjdN8cpRxB8CQ6YkQlHcRV3zTa5o9RT6OA42NE3gUftpQitGuKWSwBVx7s6yjFX
         w8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DN1sH5QsZZ3daHhsQk2wbhl3IJxWPtVtVBW0N3l5qSw=;
        b=VQiM155pg2Wbkav+y0+WX4gPo7nk0UNgeDuykxFxqhvv1VyR9CBfsawYWa2lhdNAJS
         hpz+hFCE5w6IxKbLA4XfP1C9JqiAdCDYF4Bxt+mIYB6o5/hIyKRmyvUNzqaP2zrFBB9v
         5Jw07Nv4vijOI1MEq6BcD6whc3D1DzPU3p/ZfZydqaLRpUmSrCW4WXDMsT2c3MaTr1B/
         1Na9/dzmzXs9zRDF/+6xvsxo4CbGd0vOaMuYv1aGc+Djn7x70GMNmcPXhaB0ODm6DL48
         UdVR3++ThLeJ17mnGgw0Nv3QsGcQD/05C0bnr2r2H1SKfVGF9JWXySko3Q2ypGIZLc5S
         aVPw==
X-Gm-Message-State: AO0yUKUZKcIL7nHgejjj13a5Z5PyfClgh4CJt/297rRZ2SIfBztl2dH4
        eCXayiRvyfUXp+bykh8C5VhnaoOObQYzYDE=
X-Google-Smtp-Source: AK7set9P0L3S4GTWDASEg5wTZkj99jt+MxtIDNXzcb1cfVHHN/XO14cfPs+Pf8TnJhLdMknUc7GA/Q==
X-Received: by 2002:a17:903:783:b0:19c:d537:754 with SMTP id kn3-20020a170903078300b0019cd5370754mr10138241plb.56.1677518321899;
        Mon, 27 Feb 2023 09:18:41 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902ed4400b0019324fbec59sm4848024plb.41.2023.02.27.09.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 09:18:41 -0800 (PST)
Message-ID: <315e70e0-ac1f-2f19-f1cc-6b8b24ffb1fc@github.com>
Date:   Mon, 27 Feb 2023 09:18:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [RFC PATCH 1/1] check-attr: integrate with sparse-index
Content-Language: en-US
To:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org
References: <20230227050543.218294-1-cheskaqiqi@gmail.com>
 <20230227050543.218294-2-cheskaqiqi@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230227050543.218294-2-cheskaqiqi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang wrote:

Just a heads-up, I was CC'd only on the cover letter (and not this patch). 

> Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>

Even in an RFC (or maybe *especially* in an RFC?), it's important to provide
some context around what you're doing in a patch/why you're doing it. It
seems like you provided that information in your cover letter [1], though,
so I think this "series" would be better off submitted as a single patch,
with the cover letter contents...

> ---

...right here! That is, below the '---' line but before the diff summary.

[1] https://lore.kernel.org/git/20230227050543.218294-1-cheskaqiqi@gmail.com/

>  builtin/check-attr.c                     |  3 +++
>  t/t1092-sparse-checkout-compatibility.sh | 19 +++++++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/builtin/check-attr.c b/builtin/check-attr.c
> index 0fef10eb6b..f85b91ebba 100644
> --- a/builtin/check-attr.c
> +++ b/builtin/check-attr.c
> @@ -112,6 +112,9 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
>  
>  	git_config(git_default_config, NULL);
>  
> +	prepare_repo_settings(the_repository);
> +	the_repository->settings.command_requires_full_index = 0;

The test below doesn't do anything special related to the sparse index, so
this change is unnecessary (and, as far as I can tell, will break in some
usage of 'git check-attr'). If you're only looking for feedback on testing,
it'd better to leave this out.

> +	
>  	argc = parse_options(argc, argv, prefix, check_attr_options,
>  			     check_attr_usage, PARSE_OPT_KEEP_DASHDASH);
>  
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 801919009e..b28010aa5c 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -2055,4 +2055,23 @@ test_expect_success 'grep sparse directory within submodules' '
>  	test_cmp actual expect
>  '
>  
> +test_expect_success 'check-attr pathspec inside sparse definition' '
> +	init_repos &&
> +
> +	run_on_all touch deep/test.c &&
> +	echo "*.c diff=cpp -crlf myAttr" >>.gitattributes &&

Is there a specific reason you wanted to create a new file, rather than use
something in the existing structure (e.g. 'deep/a'?). If not, I'd recommend
using the existing file structure setup by the test in the 'setup' test at
the beginning of the file.

> +	run_on_all cp ../.gitattributes . &&
> +	test_all_match git add .gitattributes &&
> +	test_all_match git commit -m "add .gitattributes" &&
> +	
> +	run_on_all git reset --hard &&

Unless I'm missing something, there's nothing to 'reset' here? Same for the
other 'reset's you have below. If they're not needed, they should be
removed.

> +	test_all_match echo "deep/test.c" | git check-attr --stdin  -a &&

In addition to testing that all of them match, it would be helpful to see
*which* attributes are reported. The test 'ls-files' demonstrates one way of
doing that sort of test.

> +
> +	run_on_all git reset --hard &&
> +	test_all_match git check-attr -a  deep/test.c &&

Besides the things already noted in my earlier comments, these scenarios
seem reasonable.

> +
> +	run_on_all git reset --hard &&
> +	test_all_match git check-attr -a  --cached deep/test.c 

'deep/test.c' isn't in the index, so AFAICT this should return nothing.
While the case of an untracked file is interesting, I think that would be
*in addition to* a test on a file that exists in the index, e.g. 'deep/a'.

> +'> +
>  test_done

