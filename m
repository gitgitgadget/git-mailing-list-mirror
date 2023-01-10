Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB24C54EBC
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 15:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238146AbjAJPJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 10:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238905AbjAJPJT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 10:09:19 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2DE34D5B
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 07:08:55 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id x7so1010993qtv.13
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 07:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SYcXh9417C1W5tMaH4UIwaMfCFu9BSbnVmxWGJJDEaY=;
        b=H0MDZwSDqlfmW+LxKjDXwDqY3EfDOae4EYw+3QYbc+b3txgPs4PEcqD7GckGxcBKh/
         y8paKYb/Toh/o0BOozgyxumlSeWzjSlHedo9hckf6ubc73KOtmb0yL6f1XWi2qyzMAln
         EEOi8MbUdNg/MNgkJ4ZArRCkCl46bcUtDjPm/uKOjBdTvg2QBrkJ0zWBoefeKWxSBRYI
         e4JY0POW5SVPicisAWwyRfbDGBdvBK5mCZrMJ/7C7jmmrJ2XAhjnjyfNHQmpfkMCzCQN
         e7ATvlmE/s2ia2ued0MbwBu53ckgmIGKHhGTyxDWrkGv/mbNVYz12gPTE8JslqbsS6eD
         nH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SYcXh9417C1W5tMaH4UIwaMfCFu9BSbnVmxWGJJDEaY=;
        b=Z8LLp/LorFeATFPHDg4ZvgN0QBp3rw9UMBYSkNy2aA99ggf8CfQHVbDTpb2PAJswe+
         Q4O0lTJeL5FPU+K+tGdMNJLWv+1/YlNCtZm6GS6kizZAfOUjEERczlnstG9Gra1FZxeF
         vS1wra2gm8RMtJY9R2EbLd/SINGO9USZ6bEnql+TFDsadYXTg0lEHaH3hEWQPzCgRyLm
         zGZAOp6Bd9u9vae2BQoyDnBYRk/xQl701ChK+n8lwrRPngSEGRjG/oasbexbU8kf8Zup
         FHIQAtofNDnhsWpkhYeh2s7aQHolCuKvpiMO8hpeib54FjMRXTmZ4FfS3szRHDffAK6j
         gL1Q==
X-Gm-Message-State: AFqh2kr2W10OO9LkVW1J2e/LOob4DdiODZV7i7VIQeY4cfaSED3kw2QQ
        duI97Bb1/lXzgWTvpUM02g/g
X-Google-Smtp-Source: AMrXdXs9AlmMQOS+8AQ/qf5KePEsEU+TIe9dIBgPN4k3ref5oQCdXzYowzythHRvmAH9URCA6+Ct2A==
X-Received: by 2002:ac8:5185:0:b0:3a7:e548:5e89 with SMTP id c5-20020ac85185000000b003a7e5485e89mr92289896qtn.49.1673363334272;
        Tue, 10 Jan 2023 07:08:54 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:3590:f4a:dde:5efd? ([2600:1700:e72:80a0:3590:f4a:dde:5efd])
        by smtp.gmail.com with ESMTPSA id r25-20020ac867d9000000b003431446588fsm6120105qtp.5.2023.01.10.07.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 07:08:53 -0800 (PST)
Message-ID: <6b92fad2-6b74-fddb-679c-8c8735e7103d@github.com>
Date:   Tue, 10 Jan 2023 10:08:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 5/5] treewide: always have a valid "index_state.repo"
 member
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <cover-0.5-00000000000-20230110T060340Z-avarab@gmail.com>
 <patch-5.5-b3b0e592101-20230110T060340Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <patch-5.5-b3b0e592101-20230110T060340Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/10/2023 1:17 AM, Ævar Arnfjörð Bjarmason wrote:
> When the "repo" member was added to "the_index" in [1] the
> repo_read_index() was made to populate it, but the unpopulated
> "the_index" variable didn't get the same treatment.
> 
> Let's do that in initialize_the_repository() when we set it up, and
> likewise for all of the current callers initialized an empty "struct
> index_state".

> +	struct index_state result = { .repo = state->repo };

> +	struct index_state wtindex = { .repo = the_repository };

> +	o.result.repo = r;

> +	struct index_state istate = { .repo = the_repository };

I think these initialization updates (along with the others I didn't
include) are satisfactory for now. What worries me is that future
consumers that create an index_state will need to remember to manually
initialize like this or risk hitting the BUG() statements in
read-cache.c.

The only alternative I can think about is to create an initialization
method, say "init_index_state(struct index_state *, struct repository *)",
that should be called before doing anything with an index_state. This
includes running a memset() to clear the struct, making these inline
initializers unnecessary.

However, I can't decide if that's actually an improvement. I think
things tip in favor of the init_index_state() method if there ever
becomes another member of struct index_state that _needs_ to be set
before the struct is "valid". I doubt that we would add such a thing
in the near future, so I recommend sticking with this patch as-is.

Thanks,
-Stolee
