Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEF5C433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 14:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbhLJORX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 09:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbhLJORX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 09:17:23 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CB3C061746
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 06:13:48 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d9so15175009wrw.4
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 06:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8LkIuIsMheeqc3c9BKNh7cdHGWTnqgeRlOvGdn4GhQs=;
        b=TSITd79D/Bx/AYqdUZd8Rw04hfuasFthaJulA6HfM5WPTffEJKNieePvXK2w50TSkk
         oMb1dJ/RpFKmOyqWP3lKCprjkwKQ6qJpLPSyuX6nfAqhQb8Vo+xc+T7o0COOh5MEupK1
         PKZRq9fAE56XYcNC9+i8EtFN1vRdQZQ4L5mOTwKT2tHFILMhvNtaz8WJTd3/S6Zhlbar
         gUs/kkDruEQsYW/2tRa/4dJoYuAPyCOFowxzjnRBHWTV1WlkgxOLJ9luzc0R+TbON5Ix
         8wQSye/7ChwuEs+XWIhcV+6pewqcT/Gdf92ofShtDJ0gVnN/u1OHpp3Aqbb6ExHX8wQQ
         yHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8LkIuIsMheeqc3c9BKNh7cdHGWTnqgeRlOvGdn4GhQs=;
        b=J0jJoKTi7kfo7ZLNVzkRZIfsPpUivKh59CbSFZxZsZJdc7MP5PCn1oGKF1/R35J5wE
         FPiIvODP5rnBHYuuLtOEKI//zK4XnLa9q19/08QB8VrX7P23NPwV8B5HRCDKUOpS2foe
         teVuTL7B2nIcfow3YxIx+dYy9OyK9IvHpfCAIkUXbIDcUNhT0jLm8xEA8lpbj9dDhiKF
         z0Xv0Yq2t0nETfIAwHYuASxhsgJrAgQ0R4z33RZj37k76x9F1jCg87dvVxPueJFSBANa
         FXrlUBriTremcLe72cAJii+669bVNeCfieQ+sxdofhZT7uGleU1QNRJIhc4J08nVP5aV
         /Vhw==
X-Gm-Message-State: AOAM532YFkCpTlsjG5BGnTkpNZJP8yVXeTOojL1ln5yehLkTmpK6BbNK
        8Ufpa4x7bfcz1IlXEEichxU=
X-Google-Smtp-Source: ABdhPJyJ+19DRFTjEK62YDahgp0GumGeJM8kZ1+UbLSmSUaK4sg5DiGN9+LfE+vLl0Jf0EX0yAtQzQ==
X-Received: by 2002:adf:fbd0:: with SMTP id d16mr14816978wrs.107.1639145626857;
        Fri, 10 Dec 2021 06:13:46 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id f3sm2665271wrm.96.2021.12.10.06.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 06:13:46 -0800 (PST)
Message-ID: <53fdf2c2-1e01-a105-6a20-8115f88b39f6@gmail.com>
Date:   Fri, 10 Dec 2021 14:13:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: builtin add interactive regression
Content-Language: en-US
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
References: <20211209193625.GA3294@szeder.dev>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20211209193625.GA3294@szeder.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/12/2021 19:36, SZEDER Gábor wrote:
> Hi,
> 
> This morning 'git add --patch' told me "Sorry, cannot split this hunk"
> even though that hunk in question was definitely splittable.  Then I
> spent my lunch break trying to reproduce the issue, and it turned out
> to be a regression in the builtin add interactive (I have
> 'add.interactive.useBuiltin=true' in my config).  The following test
> demonstrates this issue:
> 
>    ---  >8  ---
> 
> #!/bin/sh
> 
> test_description='test'
> . ./test-lib.sh
> 
> test_expect_success 'builtin interactive add cannot split hunk?!' '
> 	printf "%s\n" 1 2 >file &&
> 	echo a >zzzz &&
> 	git add file zzzz &&
> 	git commit -m initial &&
> 	cat >file <<-\EOF &&
> 	1
> 	add a line
> 	2
> 	add a line at the end (this is important!)
> 	EOF
> 	echo "modify one more file (this, too, is important!)" >zzzz &&
> 
> 	git diff file &&
> 
> 	git -c add.interactive.useBuiltin=false add -u -p >expect &&
> 	git -c add.interactive.useBuiltin=true add -u -p >actual &&
> 	# Uh-oh, "s" (for splitting the hunk) is missing!
> 	test_cmp expect actual
> '
> 
> test_done
> 
>    ---  8<  ---
> 
> This fails with:
> 
>    + git -c add.interactive.useBuiltin=false add -u -p
>    + git -c add.interactive.useBuiltin=true add -u -p
>    + test_cmp expect actual
>    --- expect	2021-12-09 19:21:23.354461170 +0000
>    +++ actual	2021-12-09 19:21:23.358461215 +0000
>    @@ -7,7 +7,7 @@
>     +add a line
>      2
>     +add a line at the end (this is important!)
>    -(1/1) Stage this hunk [y,n,q,a,d,s,e,?]?
>    +(1/1) Stage this hunk [y,n,q,a,d,e,?]?
>     diff --git a/zzzz b/zzzz
>     index 7898192..84e1b35 100644
>     --- a/zzzz
>    error: last command exited with $?=1
>    not ok 1 - builtin interactive add cannot split hunk?!
> 
> So the builtin add interactive doesn't even offer the 's - split the
> current hunk into smaller hunks' option, but my finger memory pressed
> 's' anyway, and then it told me that "Sorry..." message.  The scripted
> version can split the hunk just fine.

Thanks for the easy reproduction recipe, the hunk below makes it
pass. We're already checking marker at the very end of the loop
but we need to do it after the end of each diff (I think the perl
version only processes one diff at a time so does not have to
worry about this). If anyone wants to take this forward please
do, if not I'll try and find some time later next week to turn it
into a proper patch with a commit message and test.

Best Wishes

Phillip

---- >8 -----
diff --git a/add-patch.c b/add-patch.c
index 8c41cdfe39..4c2db78460 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -472,6 +472,14 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
                         eol = pend;
  
                 if (starts_with(p, "diff ")) {
+                       if (marker == '-' || marker == '+')
+                               /*
+                                * Last hunk ended in non-context line
+                                * (i.e. it appended lines to the
+                                * file, so there are no trailing
+                                * context lines).
+                                */
+                               hunk->splittable_into++;
                         ALLOC_GROW_BY(s->file_diff, s->file_diff_nr, 1,
                                    file_diff_alloc);
                         file_diff = s->file_diff + s->file_diff_nr - 1;

