Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB95C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 13:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238583AbiFONJj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 09:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbiFONJi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 09:09:38 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281721F625
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 06:09:37 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id u8so8768729qvj.2
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 06:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9BDI8QxRf6MZ0MIwZYfndD3JPjwi0HEFrtkKDpmab4c=;
        b=NtQG1EsLaSr598t13JjdbFlZe7LsBZeHtOmyOZjRJN6/ZXiSVyS1I9oocSZNjNRXxe
         JQS8t23jSUWaz7oXDoehxV7ZMPPsuNeOkWcTctFO+13XDzR3E3lDPyPcVaypyjre7mhe
         eBcfj8gRm62MX8aFndnAlf3fEKsYVlhXXeGEvaPXj67Zxx/kijQPQA9I6vY+/pfCfTdm
         MpWTuQzEL6+g39hMHfVRROFfSobdVA47jqsXjpbEnlD7Md9RdpiRIxcXeOFJ/5jxMeT2
         b5v+r0jH1bpUuwy92IVq8ku2IOQuyu5qDIRBgK1Yx4Sd0fs+O2vyLFFFAbHDfYjvu+Ag
         FGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9BDI8QxRf6MZ0MIwZYfndD3JPjwi0HEFrtkKDpmab4c=;
        b=SdG6OZnl/YEUKIz1zaEK2S05XTDJP0oXGi8YPdhBusi+I38fzpzP8Ej1YTyBt3lv+6
         hqyip8IZV76gogdAW0xStSnZicqG1ZhHglSyAzz2A372JVcbMR4WeW7PMXV+G8Rc95/j
         K9DQUI3ooXZcgpVnsN/bXUFV/u0b9u20jmjNsC7XxJdKaX9tlJUvhnF14ggeEQnjkCiq
         Ee7cKBYs08tatLMGO8bIXTvj5RZ+Zddb6tW5z0sJphEt2VTs/UQluvD6nr9qVppkJCKN
         BILD6fGmeMdeqvuWE7f9e1UfhXOrL3ZfC98hzN0aBVxPuTIqXi4CjOOunXPt4aHrWa8h
         kAHg==
X-Gm-Message-State: AJIora9Hk+zzWBJRUvsBRUHn3vLMeQR2PzA93vN76I4tHteSeZA/lU4S
        U1SqDhEaaz7BDClgs5L41oUsTRdfls2M
X-Google-Smtp-Source: AGRyM1uDTT8VGsTSin4FI5SgW9RDJsji+rEzJ9e4oc4kd5kyjWehMdZsnPvIELjSkVHWdOhXj5epKw==
X-Received: by 2002:a05:6214:4013:b0:467:d600:76ea with SMTP id kd19-20020a056214401300b00467d60076eamr7763186qvb.70.1655298576179;
        Wed, 15 Jun 2022 06:09:36 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:900f:fa9e:132:1bde? ([2600:1700:e72:80a0:900f:fa9e:132:1bde])
        by smtp.gmail.com with ESMTPSA id g7-20020ac85807000000b00304f7449e17sm9863226qtg.93.2022.06.15.06.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 06:09:35 -0700 (PDT)
Message-ID: <57a7393d-add0-468a-a276-5241c2c84065@github.com>
Date:   Wed, 15 Jun 2022 09:09:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH] send-pack.c: add config push.useBitmaps
Content-Language: en-US
To:     Kyle Zhao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Kyle Zhao <kylezhao@tencent.com>
References: <pull.1263.git.1655291320433.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1263.git.1655291320433.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/15/22 7:08 AM, Kyle Zhao via GitGitGadget wrote:
> From: Kyle Zhao <kylezhao@tencent.com>
> 
> This allows you to disabled bitmaps for "git push". Default is false.

s/disabled/disable/

> Bitmaps are designed to speed up the "counting objects" phase of
> subsequent packs created for clones and fetches.
> But in some cases, turning bitmaps on does horrible things for "push"
> performance[1].

I would rephrase this message body as follows:

  Reachability bitmaps are designed to speed up the "counting objects"
  phase of generating a pack during a clone or fetch. They are not
  optimized for Git clients sending a small topic branch via "git push".
  In some cases (see [1]), using reachability bitmaps during "git push"
  can cause significant performance regressions.

  Add a new "push.useBitmaps" config option to disable reachability
  bitmaps during "git push". This allows reachability bitmaps to still
  be used in other areas, such as "git rev-list --use-bitmap-index".

> [1]: https://lore.kernel.org/git/87zhoz8b9o.fsf@evledraar.gmail.com/

> +
> +push.useBitmaps::
> +	If this config and `pack.useBitmaps` are both "true", git will
> +	use pack bitmaps (if available) when git push. Default is false.

Rewording slightly:

  If this config and `pack.useBitmaps` are both `true`, then Git will
  use reachability bitmaps during `git push`, if available (disabled
  by default).

> \ No newline at end of file

Please fix this missing newline.

I'm glad that this references `pack.useBitmaps`. I wonder if that
config is sufficient for your purposes: do you expect to use your
bitmaps to generate pack-files in any other way than "git push"?

That is: are you serving remote requests from your repo with your
bitmaps while also using "git push"? Or, are you using bitmaps
only for things like "git rev-list --use-bitmap-index"?

I just want to compare this with `pack.useSparse` which targets
"git push", but focuses entirely on the pack-creation part of the
operation. Since the existence of reachability bitmaps overrides
the sparse algorithm, this does not affect Git servers (who should
have a reachability bitmap).

I just want to be sure that using pack.useBitmaps=false would not
be sufficient for your situation (and probably most situations).


> diff --git a/send-pack.c b/send-pack.c
> index bc0fcdbb000..d6091571caa 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -84,6 +84,8 @@ static int pack_objects(int fd, struct ref *refs, struct oid_array *advertised,
>  		strvec_push(&po.args, "--progress");
>  	if (is_repository_shallow(the_repository))
>  		strvec_push(&po.args, "--shallow");
> +	if (!args->use_bitmaps)
> +		strvec_push(&po.args, "--no-use-bitmap-index");

Here is where you specify the lower-level pack creation only
when sending a pack. It is very focused. Good.

> +	int use_bitmaps = 0;

> +	git_config_get_bool("push.usebitmaps", &use_bitmaps);
> +	if (use_bitmaps)
> +		args->use_bitmaps = 1;

You can instead write this as:

	if (!git_config_get_bool("push.usebitmaps", &use_bitmaps))
		args->use_bitmaps = use_bitmaps;

> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index dedca106a7a..ee0b912a5e8 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1865,4 +1865,15 @@ test_expect_success 'push warns or fails when using username:password' '
>  	test_line_count = 1 warnings
>  '
>  
> +test_expect_success 'push with config push.useBitmaps' '
> +	mk_test testrepo heads/main &&
> +	git checkout main &&
> +	GIT_TRACE=1 git push testrepo main:test >/dev/null 2>stderr &&

Just use "err" instead of "stderr".

> +	grep "no-use-bitmap-index" stderr &&
> +
> +	git config push.useBitmaps true &&
> +	GIT_TRACE=1 git push testrepo main:test2 >/dev/null 2>stderr &&
> +	! grep "no-use-bitmap-index" stderr
> +'

I believe this test is correct, but it might be worth looking
into test_subcommand if you can determine the exact subcommand
arguments you are looking for.

Thanks,
-Stolee
