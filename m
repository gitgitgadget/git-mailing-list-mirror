Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35C3C433ED
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 09:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC48561474
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 09:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhD3Js0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 05:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhD3JsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 05:48:25 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9AEC06174A
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 02:47:37 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id i3so56195193edt.1
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 02:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=++dH5alRNSkU/BUjiTxE98dSdsP4O60o4WtbwJjSTqg=;
        b=ZOdyHaR5LCQZ88tQ2jJJ3BE3t4haJ1nQVYJG/7Uuh4E/pX69Gz+PFmirHxZc4SDyjp
         A4t79UGX7KHQ1fldzhLxTHwAiN6AlY0iEXQe37fd00k+rG/0/1Kyz9F4wz4n1SWhwp/o
         N9JxfByXwvIuBSmfkniercP9VHqmIQTlTAdHa9xd4sNsvU1rEYZSH/4ijnchZiCj+Ed4
         7jKk+6CG4KUqKVlGFlIYFVEku/6VfL+8E8xAdzi0x76zEn0KdpN3CWPRPZ8ZQrrIUHtY
         +yk59FNXHFdVF7lv3Y+gE2LOQQqobR6BjUORU6f6EygWJUVRoMWERgWT64lGzsSfPIcE
         QnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=++dH5alRNSkU/BUjiTxE98dSdsP4O60o4WtbwJjSTqg=;
        b=tWvlaZ2qkeLKbplfOsiypankJOAqU0tlQtnWe75eSUMiwh71gQcqXdxtNiNRHXCuu2
         t3Sd6oWzxOxUTWlj9vtS2uUqWdd+lv4LcqSHURfaDWdn+2PAC8H+0LYIMBJxDaILkaDZ
         j2SQVY1SGUMZR75vuaWvlgAhx6GkvMQ81ufbvDtAbNHwW0koEiuwy5x7kJU+YsVc1US9
         qfJkTUMnblNUNP2v7TkjoHekmFxXPinybVN4fzwDd7WGtQB2xdppIdHFkOgWMv77x0Qj
         eBn+iGXMqAKwj1bP4XTwKhrt/FKVfUw8vaAswhDwdRhRl8cVhfYM8ej4mZp38MWY74A7
         QmCw==
X-Gm-Message-State: AOAM533MzBwWQ3zl0CSBM5TAfuLlquuBgngJB2YMqzn+vuAzPZa1eJCR
        ekfn18v6X5ItrQETxx1FE50=
X-Google-Smtp-Source: ABdhPJyWyvFi/PoBmblaSYe+Boc0C36xNcgU7GMYdTPpOJo7cMEI4NrqfZKJpT9BdE2s28E2proFog==
X-Received: by 2002:aa7:d90d:: with SMTP id a13mr4736704edr.76.1619776056332;
        Fri, 30 Apr 2021 02:47:36 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id w14sm896310edj.6.2021.04.30.02.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 02:47:35 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Luke Shumaker <lukeshu@datawire.io>
Subject: Re: [PATCH v3 03/30] subtree: t7900: use test-lib.sh's test_count
Date:   Fri, 30 Apr 2021 11:45:10 +0200
References: <20210426174525.3937858-1-lukeshu@lukeshu.com>
 <20210427211748.2607474-1-lukeshu@lukeshu.com>
 <20210427211748.2607474-4-lukeshu@lukeshu.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210427211748.2607474-4-lukeshu@lukeshu.com>
Message-ID: <87wnskxfwo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 27 2021, Luke Shumaker wrote:

> From: Luke Shumaker <lukeshu@datawire.io>
>
> Use test-lib.sh's `test_count`, instead instead of having
> t7900-subtree.sh do its own book-keeping with `subtree_test_count` that
> has to be explicitly incremented by calling `next_test`.

This just retains an existing pattern and all that, but I think this
pattern of testing makes for hard to read & maintain tests. It looks
like all of these could just be:

    test_when_finished "rm -rf repo" &&
    git init repo &&
    [...]

I.e. the only thing that's being done here is to piggy-back on the test
count to create a unique repo.
