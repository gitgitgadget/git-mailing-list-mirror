Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821E1C433DF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 14:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A6062083B
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 14:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nf+pYsDI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgHSO4W (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbgHSO4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 10:56:16 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B17FC061383
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 07:56:16 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id g26so21851912qka.3
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 07:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=m+raWtpZsyTlfZIwFSSsEmQ1hmP9WDm7v8peIPL2C3M=;
        b=Nf+pYsDI7wd8CSSuCB6SFTZgf9NyQJ8JUIHNpigG7ilaPdxYqbTkoFxpVe3G6Pi2ST
         jFRgI6jDLct97Z3Od15g0xiQ8aKCJQJmwGZUHhlsQLYcyDCrFy/LZkhE/fDYFHmnTybF
         gOtZQm+oXxEAjtJxbo2v1Gu9xRM3JhtOBmdcgbSoIxicXYm9Qs1qO2+/6CKknpaiqxHk
         UytsGqAiAP5zXHtAEkgwQQlQePiFzS5YYS3NAMwoiH+R8ZcVF5dStLTWXqoDSXoegvmD
         sSun5V+xp6Zlna4DRfeXeWEn1qwyq9+i6EZKBp6QnsjlbqxhurepRC0AALyUHLxv/4bY
         IUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m+raWtpZsyTlfZIwFSSsEmQ1hmP9WDm7v8peIPL2C3M=;
        b=hMioHd83flpkbfZhZZO9bNJVd3Obl84eExUHXJdhmdgV23mGQogU6JNT8SZ2YhLuU4
         +40Ttv4vzmsvOgYAOniNjk6rkjh5hr4eoU3+2gfxYRGd2KLF8YApyOtA8+lCbEEJPmmf
         L4PeqrM5UppYjb/j6qaecxpiA1/eXmPJku3R0+PpjVRkUtDgBJzOUvn0Eoh7UiHPEhZf
         /ULpiw7IZ72KiYJkhPnk+N+KaQtMj8KhH0Kc4UsdKI6Acdh3ADM6KwJKGZq6ZP+aZ/ES
         Rt+tKVTlK/e03FtBqPqWJKhl74ab2JAnIVYZfItmzB+idTR/7YdzaVpXdiVRVQc2UIBW
         LRgQ==
X-Gm-Message-State: AOAM532JVkppIhSEzlgJy5VttlZ4yIZZHWtt+tBzkuNb+TqoWNoQo7Ru
        +IL0Yjr62R6+Nw1fdic/qnyRyRZdEu9eXQ==
X-Google-Smtp-Source: ABdhPJxJ3PdAAOawlVD7FFQDKdXOKyfplh7dok/SO6bZ2a/tKR+d0RrZ7+u/RYNVGbT48zPov2xmyg==
X-Received: by 2002:a05:620a:1653:: with SMTP id c19mr22091439qko.501.1597848975477;
        Wed, 19 Aug 2020 07:56:15 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:641b:4ef3:c176:5ed3? ([2600:1700:e72:80a0:641b:4ef3:c176:5ed3])
        by smtp.gmail.com with ESMTPSA id t69sm24597087qka.73.2020.08.19.07.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 07:56:14 -0700 (PDT)
Subject: Re: What's cooking in git.git (Aug 2020, #04; Tue, 18)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>
References: <xmqqft8jwov1.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9bb7995e-4e69-00b3-eb7a-54412638cb7f@gmail.com>
Date:   Wed, 19 Aug 2020 10:56:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <xmqqft8jwov1.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/18/2020 6:50 PM, Junio C Hamano wrote:
> * ds/maintenance-part-1 (2020-08-18) 11 commits
>  - maintenance: add trace2 regions for task execution
>  - maintenance: add auto condition for commit-graph task
>  - maintenance: use pointers to check --auto
>  - maintenance: create maintenance.<task>.enabled config
>  - maintenance: take a lock on the objects directory
>  - maintenance: add --task option
>  - maintenance: add commit-graph task
>  - maintenance: initialize task array
>  - maintenance: replace run_auto_gc()
>  - maintenance: add --quiet option
>  - maintenance: create basic maintenance runner
>  (this branch is used by ds/maintenance-part-2; uses jc/no-update-fetch-head; is tangled with jt/lazy-fetch.)

Is this "is tangled with jt/lazy-fetch" related to the
fact that jc/no-update-fetch-head was part of my branches,
or are we colliding in other interesting ways?

Thanks,
-Stolee
