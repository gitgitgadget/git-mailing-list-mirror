Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C75C54EBE
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 10:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241334AbjAMKo4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 05:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240906AbjAMKoh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 05:44:37 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6367DE2A
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 02:41:28 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id j34-20020a05600c1c2200b003da1b054057so2750515wms.5
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 02:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/JXKCSNd59t2oGWHVem8hVrmdCqcFVSxAxbTeYuMkbc=;
        b=P/sVy3QsQ6suTODYX5k9LU1oh6dSNgJKj/2zKSWjn9Xe3FmDX3wMrFHLs347xBMNmx
         A3EyX0Wh0RHK3smuzEBx80N1DZzRGBuQTb1iBv/PcaBJcYEdbN1Osc/g8iIY+ktdztf9
         7zbFPxui4mP6KHKyR/CTwk1l/pJDXh8RSNyEKeSiV4TMDMpLVYHtwR6HlsC7R+F4x+Vp
         j8Ipkw0OoeBM7X/vctowvbnJwqFBN35RfGUsqIwAwxTCcHTsonmP2+i+3NowT6OPTGBP
         qFPnj+YY5CM7AyHXVciMgzyoBl9noc0IZ9I4/jLo6f2EmNLlpJ2qEO4pQniPBe7Ch8Zp
         KaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JXKCSNd59t2oGWHVem8hVrmdCqcFVSxAxbTeYuMkbc=;
        b=IPkwnJgfb6hdFUFmIhXYGO4yMCS5kKglVwQlI09FsNzKZL6wX9SS6/QOMI/cKaDqGn
         K1GMvEUSL5+e7H/kHmVK1sQO9oeCrF2xrZNXE03FR/qLl2r0CGW5krGhtWoe9i5dawnh
         skg7t1LKg1LqY8a2l73rul3f/AqwyEL9x9croibVJTJ1DUyDREHiWCsB/966lRVqNA3E
         kAcSzfRKFMFeeKKrZTQAN4YLH4yeS0zTOBVHVH/5RYl6VgN+PzGYOswpZsJKOlWVkjkd
         PW09zfWSFTX+Hs8dhrP62O/tdIgscFfoMnb2CbZ2HchNlv3yG0mFAdPcg4gC0S/E5eeb
         2dXA==
X-Gm-Message-State: AFqh2kp1d19JcgE8udbAp40DHTuxSpLIueR7DKjhizFcNpCFFzKfBYxZ
        rjDURCgIOEex/Tx8gLMJO78=
X-Google-Smtp-Source: AMrXdXsEJrF+yBw7YSxU3awEsvVUc5CAS+mRA0pA+G9wt6Xb0xQtbbAng5xUSvZxc5i9qb8SkAP8zw==
X-Received: by 2002:a05:600c:1c12:b0:3d3:5841:e8af with SMTP id j18-20020a05600c1c1200b003d35841e8afmr58624715wms.25.1673606486673;
        Fri, 13 Jan 2023 02:41:26 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c510900b003c6f8d30e40sm32969278wms.31.2023.01.13.02.41.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 02:41:26 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <b35f4a38-be15-5d43-73bd-3b336dc61ee9@dunelm.org.uk>
Date:   Fri, 13 Jan 2023 10:41:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 6/9] builtin/rebase.c: fix "options.onto_name" leak
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
 <cover-v2-0.9-00000000000-20230112T124201Z-avarab@gmail.com>
 <patch-v2-6.9-898bb7698fc-20230112T124201Z-avarab@gmail.com>
In-Reply-To: <patch-v2-6.9-898bb7698fc-20230112T124201Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 12/01/2023 12:45, Ævar Arnfjörð Bjarmason wrote:
> In [1] we started saving away the earlier xstrdup()'d
> "options.onto_name" assignment to free() it, but when [2] added this
> "keep_base" branch it didn't free() the already assigned value before
> re-assigning to "options.onto_name". Let's do that, and fix the memory
> leak.

As I said before I don't think this message makes any sense. It should 
just say that when --keep-base is given we need to free 
options.onto_name as it does not come from argv. As I also mentioned you 
do not need to add "free(to_free)" as it is unused at this point. 
Freeing it makes the reader wonder what was previously assigned to it.

Best Wishes

Phillip

> 1. 9dba809a69a (builtin rebase: support --root, 2018-09-04)
> 2. 414d924beb4 (rebase: teach rebase --keep-base, 2019-08-27)
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   builtin/rebase.c                 | 3 ++-
>   t/t3416-rebase-onto-threedots.sh | 1 +
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 0d8c050f6b3..b4857b89f19 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1660,7 +1660,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   		strbuf_addstr(&buf, options.upstream_name);
>   		strbuf_addstr(&buf, "...");
>   		strbuf_addstr(&buf, branch_name);
> -		options.onto_name = xstrdup(buf.buf);
> +		free(to_free);
> +		options.onto_name = to_free = xstrdup(buf.buf);
>   	} else if (!options.onto_name)
>   		options.onto_name = options.upstream_name;
>   	if (strstr(options.onto_name, "...")) {
> diff --git a/t/t3416-rebase-onto-threedots.sh b/t/t3416-rebase-onto-threedots.sh
> index ea501f2b42b..f8c4ed78c9e 100755
> --- a/t/t3416-rebase-onto-threedots.sh
> +++ b/t/t3416-rebase-onto-threedots.sh
> @@ -5,6 +5,7 @@ test_description='git rebase --onto A...B'
>   GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>   export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   . "$TEST_DIRECTORY/lib-rebase.sh"
>   
