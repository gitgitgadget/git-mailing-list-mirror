Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06979C77B6E
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 22:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjDMWTS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 18:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjDMWTR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 18:19:17 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9A426BE
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 15:19:16 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id m18so16480995plx.5
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 15:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1681424356; x=1684016356;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RS48dKJVlv/8rN6zrzK/GMTOvV1y6gYa92DyzoGL78o=;
        b=KG2UA7v8TY6XIbRcuLduHtKIAxI7Z6R6SJs+3kCvw9lseRZQxXDBOMSikQCh1kA9eB
         KSeZOo4Dzdhz/380rsjFsT99ZDCNPyYcRbT7HxySvZc2eXmqb5GiBcN1JiobtoadAqbU
         4V0UBgzjVWI1QcgAS3yoa9WwzJ3dtlVoX2l1TLvjMHwx3aq7QduU24e0YLGH1qTh5AZx
         Q07iy0SpKZPFFwg8qJzmn4j5/83fkXDe5OVFUO2sRrnb6QENfnl0NsDgItKBj0rfItrb
         xCwT+oDUS55UVLvGh/kZQPFdR2J3xIOuz4Q5Ce7WOBcKCJ/IyOPJy539Zaw3Fg2HW1aj
         ID+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681424356; x=1684016356;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RS48dKJVlv/8rN6zrzK/GMTOvV1y6gYa92DyzoGL78o=;
        b=M2YTMzVocAMQ/1BPOZ7c62t1WODShOn62FlVP7iRF3403JPnLPwXvipeM5NKd54MBz
         kQkJqtIYvnoCN3NJLuri+JxaSKqVkGozhkiY8GW/4gUrY/+6bRYSfEIfcqYlRl0WGAvd
         WsGsUJjolCqohPmq42eiKQEZlk7YavX1Ryxc454Wd9txrsRryeS5ibY4GRZw79WDKCZc
         KMyjS2x3925cgvaP4Uta8SV2ZRLuhzEys8ncocQOfsFZXkWNwNxf1y+s63cWsT31k9ow
         /6OWk5Q6F0W83QYFVS1q93R/Vv8YGBVumiWie6Mcpy5Wo6uDCE8KObhCrykVZ+dJpmMi
         zc9Q==
X-Gm-Message-State: AAQBX9e0E+vcZ4EER5YFs/V7blVcxKYsv4W3R7fQR9akS16MGWqHe5CO
        PghpBfZjzXnsc7zObuFZAjuo
X-Google-Smtp-Source: AKy350bvkHwKZn7iVWcuJmghSs5sk/mxDfK1wL1T9rOpPIoZa/K7dyxE8L4/VskFmxphDUtKRHpIMg==
X-Received: by 2002:a17:90a:fc6:b0:237:97a3:1479 with SMTP id 64-20020a17090a0fc600b0023797a31479mr3563605pjz.28.1681424355709;
        Thu, 13 Apr 2023 15:19:15 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id s5-20020a170902a50500b001a04d37a4acsm1950959plq.9.2023.04.13.15.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 15:19:15 -0700 (PDT)
Message-ID: <df61d79b-8234-d3fd-5eb5-614d1b97d046@github.com>
Date:   Thu, 13 Apr 2023 15:19:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: What's cooking in git.git (Apr 2023, #03; Tue, 11)
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqo7ns69sz.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
Cc:     Raghul Nanth A <nanth.raghul@gmail.com>,
        Shuqi Liang <cheskaqiqi@gmail.com>
In-Reply-To: <xmqqo7ns69sz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> * rn/sparse-diff-index (2023-04-10) 1 commit
>  - diff-index: enable sparse index
> 
>  "git diff-index" command has been taught to work better with the
>  sparse index.
> 
>  Comments?
>  source: <20230408112342.404318-1-nanth.raghul@gmail.com>

I just sent a review of the newest version [1] with some minor nits &
questions that may prompt a re-roll (depending on the author's/others'
thoughts).

[1] https://lore.kernel.org/git/62821012-4fc3-5ad8-695c-70f7ab14a8c9@github.com/

> * rn/sparse-describe (2023-04-03) 1 commit
>  - describe: enable sparse index for describe
> 
>  "git describe --dirty" learns to work better with sparse-index.
> 
>  Will merge to 'next'?
>  source: <20230403164749.246001-1-nanth.raghul@gmail.com>

This looks good to me, agreed that it's ready for 'next'.

> * sl/sparse-write-tree (2023-04-04) 1 commit
>   (merged to 'next' on 2023-04-10 at 0cd39c23b1)
>  + write-tree: integrate with sparse index
> 
>  "git write-tree" learns to work better with sparse-index.
> 
>  Will merge to 'master'.
>  source: <20230404003539.1578245-1-cheskaqiqi@gmail.com>

Sorry for getting to this one so late - I did have some comments [2] on the
tests in this patch that weren't addressed. However, I'm fairly certain the
integration itself is correct, so I may just submit the test updates as a
separate patch in the (near-ish?) future.

[2] https://lore.kernel.org/git/9d0309bd-943c-dd51-97cf-59721eda78f7@github.com/

> * sl/diff-files-sparse (2023-03-22) 2 commits
>  - diff-files: integrate with sparse index
>  - t1092: add tests for `git diff-files`
> 
>  Teach "diff-files" not to expand sparse-index unless needed.
> 
>  Comments?
>  source: <20230322161820.3609-1-cheskaqiqi@gmail.com>

I also just sent a review for this one [3] [4], with similar nits &
questions to those in the 'diff-index' integration.

[3] https://lore.kernel.org/git/4ffff8e9-3e03-9c5f-4a42-b9102ed24e66@github.com/
[4] https://lore.kernel.org/git/c382017a-8c65-24ba-5092-6b46428d8b9b@github.com/

