Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F272AC19F28
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 14:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbiHCOcJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 10:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiHCOcI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 10:32:08 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5F819C0C
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 07:32:07 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id d1so11493567qvs.0
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 07:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VGQHZ7nBrjSHCxAGjFJzddKRbgc6b8qJuwd8zkePK4Q=;
        b=NPmr1/3+8JvX4AXw97b3E+YMsFFM8nBpT85w2ytKbcJBzxrUErns/WzPDKK988V/TO
         pY5ci7x+TC/j6nz4IrGn8pJNin4pR0pZGtODqpyiGHuiYKPpOluAftByOJ4ZVqybnGGc
         MD2ELTAkUBjo+wSQ80uJZVgrSM1CJr2q/53KzlZtMBD7mK7Idy4hx4rfSSncaiB/Ij/r
         f6zaJU0mDg95SYESBoi29ZnZ/rnx6u9yeQhhONYGGAV5xTOYQWVYJgjDxedGdonhwPAc
         fODFT09S8elDPdErgSuYpRXU3oirIacUWmcAa16643+uonG1vP6edeKmhBKjhJbKjpPC
         e4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VGQHZ7nBrjSHCxAGjFJzddKRbgc6b8qJuwd8zkePK4Q=;
        b=aKSxaJjZJUZmvKdSLanWLnFXakfLz8+URgxPC00K8TCZtqCfq4V3D8hFfuhgy3/tMG
         WtRdXeLD8mXyIylupZ3NSYKXKaJ6bnyzSe9atwBXPo09rS77ULXKV3M3bNX2PKJM9A2v
         cpLfHNlb8WC6GJK/KABH6oDCUpvdrUdJweKIGPmkkxTdYOezdYLFU0UxhItAq5L3qu8m
         tzjR0bwNNgPNT+Qk4XoRKFY0VW7s4rEpaCJu7nNez/WTTtX0E/CidJL5f99J+d6R/9sV
         TL6Uia7rzcuIB9hMqR2ZIUzBTjLeePkAyVQxNVBKT/Abwy6NEP0frWGGgRkQlSbtcpRm
         GetA==
X-Gm-Message-State: ACgBeo3NbNv/BU0YRfJDaVjpJNnPMGE6+4ugpfzQNM7TfmWKUX0rTOMk
        78wE1qDimM4gtuxFixSs91Zd
X-Google-Smtp-Source: AA6agR7fZb32Jdzu0KnsgBvLnx/tkxyV0s9xDQSfnoeFRFWhEYitfZHG8caYZWJtUnCxwJiNAap9Xw==
X-Received: by 2002:a0c:8170:0:b0:473:af82:9a77 with SMTP id 103-20020a0c8170000000b00473af829a77mr22246461qvc.87.1659537126340;
        Wed, 03 Aug 2022 07:32:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:d582:a76b:8dd3:e924? ([2600:1700:e72:80a0:d582:a76b:8dd3:e924])
        by smtp.gmail.com with ESMTPSA id n4-20020a05622a11c400b0031f229d4427sm1583524qtk.96.2022.08.03.07.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 07:32:05 -0700 (PDT)
Message-ID: <16b76622-0242-84be-5842-2dea39138643@github.com>
Date:   Wed, 3 Aug 2022 10:32:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 1/4] t1092: add tests for `git-rm`
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     vdye@github.com
References: <20220803045118.1243087-1-shaoxuan.yuan02@gmail.com>
 <20220803045118.1243087-2-shaoxuan.yuan02@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220803045118.1243087-2-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/3/2022 12:51 AM, Shaoxuan Yuan wrote:
> Add tests for `git-rm`, make sure it behaves as expected when
> <pathspec> is both inside or outside of sparse-checkout definition.

This is good to demonstrate that we already have feature parity,
even if it is because we expand the sparse index immediately.
 
> Also add ensure_not_expanded test to make sure `git-rm` does not
> accidentally expand the index when <pathspec> is within the
> sparse-checkout definition.

> +test_expect_failure 'sparse index is not expanded: rm' '
> +	init_repos &&
> +
> +	ensure_not_expanded rm deep/a &&
> +
> +	# test in-cone wildcard
> +	git -C sparse-index reset --hard &&
> +	ensure_not_expanded rm deep/* &&
> +
> +	# test recursive rm
> +	git -C sparse-index reset --hard &&
> +	ensure_not_expanded rm -r deep
> +'
> +

Instead of adding a test_expect_failure here, I would wait to add
this as a test_expect_success in patch 4.

Thanks,
-Stolee
