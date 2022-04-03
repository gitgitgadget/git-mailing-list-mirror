Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06676C433EF
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 15:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347747AbiDCPWH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 11:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbiDCPWG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 11:22:06 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F82F366BC
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 08:20:11 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d29so4852197wra.10
        for <git@vger.kernel.org>; Sun, 03 Apr 2022 08:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eRVBRB/FNqRpUdVJBFGtBXPlnmw42ulOm/e3UcTeQpI=;
        b=NNApgEoSt8Xoc25lY2/PbDEnn0ebINGXW647RYWDAhJ6xwiYmQz9Gv2WpXGkUogg9e
         34LKo5GIVVox+RcO+TtmBInzDZwDDU2En8h+MXwkx8NoMqV+Oazo0J/LUHYHA0v4RiTG
         O+y2JBB32qT9Z3iAroE72VTwUGaZi2bQFkCbgE2+LdADZxD+5W6czVKed2Wa6hgeSjCJ
         alAcrDuOpW9XonO8YvguQ0hz5aYClIMbsMBLq6wlDJN9w0fOdPHRsK2SBX9uoS6hbj/Y
         WM1Wd3N7GnZJXHk+aacx8dVUxcjno1mSPsiOfZptsMa17PpBddXhX0M83Nyez9U/1D4g
         Ru1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eRVBRB/FNqRpUdVJBFGtBXPlnmw42ulOm/e3UcTeQpI=;
        b=meyavfSywQ1uyutd7A077YqssnsZ5368N3bp4rpJPp5KyWZr20spebB70wW47zNN6b
         CuqCmf9jJfyoFYiImKYM8JgRUxcIkZn3cTbPNxkbwxO5fowXokFU12UtOIVsZd5x9wAJ
         TSbWuX9WlsmwuPIy6QsmRq9ROw8MEzKQ6s/E4FOdOxboxdnY0pseaHrOeW+w7PPcVz6i
         WRLbmMicCa7zMFWCKeNeZZOLXIgtHjoEMQDBivwuOhLT1mg0Ig5pI0BY6cjD1AGwgsrG
         vI/SR9g1tiSGuoe/ygYcYAwYjVq+uJGH4GP8dHH/UmEmnRPBS+CkxlsI0aPFfXg9SDcz
         /haQ==
X-Gm-Message-State: AOAM531/rn4dBcILuQGVKPxWWkipFA44nzXDTRKENW0QzbraiYCHCTFx
        l2rCxTLzQjVP+KiLOA50dho=
X-Google-Smtp-Source: ABdhPJxQumZzX03sONL7Q7igNFscrydrCTOBjea1vfGeRwWBfeu9z3ozqlEOQNt202GqsvX5ep23kQ==
X-Received: by 2002:adf:eb08:0:b0:205:e198:e39a with SMTP id s8-20020adfeb08000000b00205e198e39amr13965041wrn.553.1648999209858;
        Sun, 03 Apr 2022 08:20:09 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.224])
        by smtp.gmail.com with ESMTPSA id v13-20020adfe28d000000b0020375f27a5asm7278873wri.4.2022.04.03.08.20.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 08:20:09 -0700 (PDT)
Message-ID: <e71173fc-1b75-cc1e-df8e-efad512bf173@gmail.com>
Date:   Sun, 3 Apr 2022 16:19:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 23/27] revisions API: release "reflog_info" in release
 revisions()
Content-Language: en-GB-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
 <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
 <patch-v5-23.27-0e9745d9ee1-20220402T102002Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <patch-v5-23.27-0e9745d9ee1-20220402T102002Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

[It appears I forgot to press send earlier]

On 02/04/2022 11:49, Ævar Arnfjörð Bjarmason wrote:
> Add a missing reflog_walk_info_release() to "reflog-walk.c" and use it
> in release_revisions().
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   reflog-walk.c            | 24 +++++++++++++++++++++++-
>   reflog-walk.h            |  1 +
>   revision.c               |  1 +
>   t/t0100-previous.sh      |  1 +
>   t/t1401-symbolic-ref.sh  |  2 ++
>   t/t1411-reflog-show.sh   |  1 +
>   t/t1412-reflog-loop.sh   |  2 ++
>   t/t1415-worktree-refs.sh |  1 +
>   8 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/reflog-walk.c b/reflog-walk.c
> index 8ac4b284b6b..7aa6595a51f 100644
> --- a/reflog-walk.c
> +++ b/reflog-walk.c
> @@ -8,7 +8,7 @@
>   
>   struct complete_reflogs {
>   	char *ref;
> -	const char *short_ref;
> +	char *short_ref;

As this struct is only used internally I think changing the type rather 
than casting when we free it makes sense.

Best Wishes

Phillip

>   	struct reflog_info {
>   		struct object_id ooid, noid;
>   		char *email;
> @@ -51,9 +51,16 @@ static void free_complete_reflog(struct complete_reflogs *array)
>   	}
>   	free(array->items);
>   	free(array->ref);
> +	free(array->short_ref);
>   	free(array);
>   }
>   
> +static void complete_reflogs_clear(void *util, const char *str)
> +{
> +	struct complete_reflogs *array = util;
> +	free_complete_reflog(array);
> +}
> +
>   static struct complete_reflogs *read_complete_reflog(const char *ref)
>   {
>   	struct complete_reflogs *reflogs =
> @@ -116,6 +123,21 @@ void init_reflog_walk(struct reflog_walk_info **info)
>   	(*info)->complete_reflogs.strdup_strings = 1;
>   }
>   
> +void reflog_walk_info_release(struct reflog_walk_info *info)
> +{
> +	size_t i;
> +
> +	if (!info)
> +		return;
> +
> +	for (i = 0; i < info->nr; i++)
> +		free(info->logs[i]);
> +	string_list_clear_func(&info->complete_reflogs,
> +			       complete_reflogs_clear);
> +	free(info->logs);
> +	free(info);
> +}
> +
>   int add_reflog_for_walk(struct reflog_walk_info *info,
>   		struct commit *commit, const char *name)
>   {
> diff --git a/reflog-walk.h b/reflog-walk.h
> index e9e00ffd479..8076f10d9fb 100644
> --- a/reflog-walk.h
> +++ b/reflog-walk.h
> @@ -8,6 +8,7 @@ struct reflog_walk_info;
>   struct date_mode;
>   
>   void init_reflog_walk(struct reflog_walk_info **info);
> +void reflog_walk_info_release(struct reflog_walk_info *info);
>   int add_reflog_for_walk(struct reflog_walk_info *info,
>   			struct commit *commit, const char *name);
>   void show_reflog_message(struct reflog_walk_info *info, int,
> diff --git a/revision.c b/revision.c
> index 40f59c441f7..e972addd8fc 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2955,6 +2955,7 @@ void release_revisions(struct rev_info *revs)
>   	clear_pathspec(&revs->prune_data);
>   	release_revisions_mailmap(revs->mailmap);
>   	free_grep_patterns(&revs->grep_filter);
> +	reflog_walk_info_release(revs->reflog_info);
>   }
>   
>   static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
> diff --git a/t/t0100-previous.sh b/t/t0100-previous.sh
> index 69beb59f627..a16cc3d2983 100755
> --- a/t/t0100-previous.sh
> +++ b/t/t0100-previous.sh
> @@ -5,6 +5,7 @@ test_description='previous branch syntax @{-n}'
>   GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>   export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   test_expect_success 'branch -d @{-1}' '
> diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
> index 132a1b885ac..9fb0b90f252 100755
> --- a/t/t1401-symbolic-ref.sh
> +++ b/t/t1401-symbolic-ref.sh
> @@ -1,6 +1,8 @@
>   #!/bin/sh
>   
>   test_description='basic symbolic-ref tests'
> +
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   # If the tests munging HEAD fail, they can break detection of
> diff --git a/t/t1411-reflog-show.sh b/t/t1411-reflog-show.sh
> index 0bb319b944a..3770ceffafd 100755
> --- a/t/t1411-reflog-show.sh
> +++ b/t/t1411-reflog-show.sh
> @@ -4,6 +4,7 @@ test_description='Test reflog display routines'
>   GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>   export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   test_expect_success 'setup' '
> diff --git a/t/t1412-reflog-loop.sh b/t/t1412-reflog-loop.sh
> index 977603f7f1c..ff30874f940 100755
> --- a/t/t1412-reflog-loop.sh
> +++ b/t/t1412-reflog-loop.sh
> @@ -1,6 +1,8 @@
>   #!/bin/sh
>   
>   test_description='reflog walk shows repeated commits again'
> +
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   test_expect_success 'setup commits' '
> diff --git a/t/t1415-worktree-refs.sh b/t/t1415-worktree-refs.sh
> index a3e6ea08088..3b531842dd4 100755
> --- a/t/t1415-worktree-refs.sh
> +++ b/t/t1415-worktree-refs.sh
> @@ -2,6 +2,7 @@
>   
>   test_description='per-worktree refs'
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   test_expect_success 'setup' '
