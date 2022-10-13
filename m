Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBF6C43217
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 07:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiJMHdm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 03:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJMHdl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 03:33:41 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF3611E45E
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 00:33:40 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id g13so582906ile.0
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 00:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oSmOv+Oxe+zZ/1zuZioc2cwjhBNAubYlFHvxQ+OTALI=;
        b=pecSOD6YuwZ3XuJ9iHvJdbXObmyvgVCSzCEVEYYPJCKuuIbhvKUYFWUZXkVqESG86Y
         qub8I3v1weOyh6yFnkVfwjmB0TVZyt60Q4URCT4p2oY+VKP9cH6NE1XWByGyG5FelT5P
         w5I9resJ759h+vJlDdX9KnrLa707xRX/HXOxBKmqzCYrIdaxomYtPpbl7/8bNn4iar6J
         0aZgolDFw9nme3auiAoqCVAaYhkeaMGFDVAYl5rleoXS7Sb6lAq3nStxENTIYyseLQX3
         1wa32vI3sFlkSFk6sUVp/+XTPfpC4BbmZ1SKtQzOktJC5DaHoLR1N/Ge1XS93zuK3GIJ
         DQ0Q==
X-Gm-Message-State: ACrzQf3nMNKRLi+iveOEFahNdHumZoiDXoGr00lwLaBPXkgVOw36gDD+
        j3SkbSPChbSCFvqSGqny2reTkP+rNlUopvJOPW4=
X-Google-Smtp-Source: AMsMyM7TOWXXUDmWn6CjMMwgVSvDK+hmJl/AW6+/T4kzwkCf211yNnl+cREWh25ExP5+hdIqBU4yhXNrObVxcZmrorw=
X-Received: by 2002:a05:6e02:1909:b0:2fc:7bd1:25c0 with SMTP id
 w9-20020a056e02190900b002fc7bd125c0mr7026226ilu.147.1665646419479; Thu, 13
 Oct 2022 00:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <CA+PPyiGHwupxZ=XrmL-1Y=tZyO5JCshD+ss9t9b5pZihM7vFug@mail.gmail.com>
In-Reply-To: <CA+PPyiGHwupxZ=XrmL-1Y=tZyO5JCshD+ss9t9b5pZihM7vFug@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 13 Oct 2022 03:33:28 -0400
Message-ID: <CAPig+cSq3fZ+L9Q6O3iYqFpf-BVCG4b1TQkYqOtNGPj_zZkX7A@mail.gmail.com>
Subject: Re: [Outreachy] Microproject selection
To:     NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 13, 2022 at 2:29 AM NSENGIYUMVA WILBERFORCE
<nsengiyumvawilberforce@gmail.com> wrote:
> I am reading through https://git.github.io/SoC-2022-Microprojects/ and
> and I found an interesting task I could do which is to "Modernize a
> test script".
>
> When I looked through the code, I found I could clean up t1002 as
> mentioned in https://lore.kernel.org/git/CAPig+cQpUu2UO-+jWn1nTaDykWnxwuEitzVB7PnW2SS_b7V8Hg@mail.gmail.com/
>
> Let me know if I should go ahead

t1002 might indeed be a reasonable microproject since it could use a
few of the same cleanups as mentioned in the email you cited. For a
microproject, we usually don't want you to take on a large task since
the aim of a microproject is for you to experience the patch
submission and review process, however, the cleanups t1002 needs are
each quite simple, so a multi-patch series would be appropriate. I
foresee a series consisting of two to four patches:

(1) reformat tests from:

    test_expect_success \
        'title' \
        'body1
        boy2'

to the modern form:

    test_expect_success 'title' '
        body1
        body2
    '

(2) fix indentation to use TABs rather than spaces

(3) optional: move the:

    cat >expected <<EOF
    -100644 X 0 nitfol
    +100644 X 0 nitfol
    EOF

into the tests (14 & 15) which need it rather than creating "expected"
in the global scope; at the same time, you might change `EOF` to
`\EOF`, but be sure to mention that change in the commit message if
you do so and explain why `\EOF` is preferred (see the "Recommended
style" section of t/README for details)

(4) optional: many tests use the unusual construct:

    if read_tree_u_must_succeed -m -u $treeH $treeM; then false; else :; fi

which would be expressed more naturally these days as:

    ! read_tree_u_must_succeed -m -u $treeH $treeM

In fact, if you want a smaller microproject, the optional item listed
last might be a decent microproject on its own without the other
changes.
