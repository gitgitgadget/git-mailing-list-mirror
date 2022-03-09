Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49967C433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 19:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237798AbiCITZ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 14:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237772AbiCITZr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 14:25:47 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5356BDF2A
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 11:24:36 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id w17-20020a056830111100b005b22c584b93so2465020otq.11
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 11:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7IhyJ+iYSHRKptdDawiVh0qOkRUsxeTiZfsJHFhUjPA=;
        b=LNl2nk38WIVvl2VkpqY70Z4KBFH+aBBiiH/lLrZo222vBJruqSfD+ynIOhQFPwyKHn
         0MOwSQpLZBnhb+2ZKrOQ8CKbFmukusoi5sjSQSlBXeFWQ6XXXFNVej9E8u43az/BldYs
         hH8n1YUOit8DeXJM7l5wCGwPMJa7M/fU0lZZepWBRMNeV4P/XWIGON0U5gV+dpKt/noF
         Rt9Tr2tEHJB36mlis9WezuE03rZnrdN4WR+garMpCHgqbhbGA1Ns6KZQrfqyuZFr72d5
         U7AdeuoXxGgX0xygcqnOilnj2yXT/pMeD4N7rwFeHSNWMappztVDun00ZmgbrylswdN3
         JmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7IhyJ+iYSHRKptdDawiVh0qOkRUsxeTiZfsJHFhUjPA=;
        b=lAHkObj/CzyoHfycgZtBxKkCp0u0/dx8iyg19A/Y2feja9Eakmbmf+3KpLkgIZNOkb
         t4Uo76ZT0bLbYQq9Cv5y2G93qP5r89rp7+xT932h/QCioWsblFa6vQJqR4IpctfvpYCS
         i0Z+QZzvl1zm+keGpLFyw39qiLRTroXRmRMtN3TNRnOSMjVUS7QNoyycAo9CfIAI/C+I
         6Jd2fDbNG6OiWgV08I5E9XoiX6OzAfKEj5yU7BdEsu+hrYnSypKliS06CsziAzdum1kC
         IPVnaay/+nlfeC3c4t0isOvmu54b01tDDbaACS+CPbOUT6V2+3l6eybxjZb/HqgzD3Mm
         Z6UQ==
X-Gm-Message-State: AOAM531pvOw8lT673wC2nE41wOPQb+dIE0tuIQdPgVqB0kP83uJiPMcw
        1AK7smVfB9r9Ga2n/OcBnYKI
X-Google-Smtp-Source: ABdhPJzR1gMDUG3TZfW3bk3KvD322vb8tF2On1raE8XicxgN2VeXD2TjVMsKglt6Csj7B2wsVC5AQQ==
X-Received: by 2002:a05:6830:2709:b0:5b0:69e:6b67 with SMTP id j9-20020a056830270900b005b0069e6b67mr687167otu.170.1646853875618;
        Wed, 09 Mar 2022 11:24:35 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id e3-20020a056870450300b000da5424e4b0sm1293509oao.50.2022.03.09.11.24.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 11:24:35 -0800 (PST)
Message-ID: <99c429f7-af5d-78ac-9888-9f4f58d01b62@github.com>
Date:   Wed, 9 Mar 2022 14:24:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 21/24] revisions API: release "reflog_info" in release
 revisions()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
 <patch-21.24-ccf276641d6-20220309T123321Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <patch-21.24-ccf276641d6-20220309T123321Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/9/2022 8:16 AM, Ævar Arnfjörð Bjarmason wrote:
> Add a missing reflog_walk_info_release() to "reflog-walk.c" and use it
> in release_revisions().
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  reflog-walk.c            | 26 ++++++++++++++++++++++++--
>  reflog-walk.h            |  1 +
>  revision.c               |  1 +
>  t/t0100-previous.sh      |  1 +
>  t/t1401-symbolic-ref.sh  |  2 ++
>  t/t1411-reflog-show.sh   |  1 +
>  t/t1412-reflog-loop.sh   |  2 ++
>  t/t1415-worktree-refs.sh |  1 +
>  8 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/reflog-walk.c b/reflog-walk.c
> index 8ac4b284b6b..4322228d122 100644
> --- a/reflog-walk.c
> +++ b/reflog-walk.c
> @@ -7,7 +7,7 @@
>  #include "reflog-walk.h"
>  
>  struct complete_reflogs {
> -	char *ref;
> +	const char *ref;
>  	const char *short_ref;

This seems like the opposite change from what I would
expect, because the 'const' implies non-ownership.

> -	free(array->ref);
> +	free((char *)array->ref);
> +	free((char *)array->short_ref);

This further makes the point that we should be keeping
non-const versions so we can clearly document ownership.

> +static void complete_reflogs_clear(void *util, const char *str)
> +{
> +	struct complete_reflogs *array = util;
> +	free_complete_reflog(array);
> +}

Is there a reason we don't do the cast inside?

	free_complete_reflog((struct complete_reflogs *)util);

Thanks,
-Stolee
