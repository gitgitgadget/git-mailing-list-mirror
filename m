Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB283C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 18:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344435AbiHRSvb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 14:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344724AbiHRSvZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 14:51:25 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D711094EF1
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 11:51:23 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id s18-20020a170902ea1200b0016f11bfefe4so1419849plg.14
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 11:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:in-reply-to:date:from:to
         :cc;
        bh=TyuMx8yshHRfzKYftyMjQYQjs7ybOj8AY7Hfdf0H5iE=;
        b=taQf8S/vCYyAIH4QRbJsiMlWvZDHI03Qzxx+JAP39qrZIcIEIR/k1X6a7n/jPtwgDN
         NUOQ9aCEeV1Jbkke6U9wLUEIP/HhJEkE/YWcVVxPyM/ZVw3JHPJX9EWwgUn+7xi6RnHl
         SJgXQbWGhF4m1Ib3alVQxkeB0oarBr5lLrtp2Gf7iRopXAxQjBUC6q1ok1yk6NXswfFI
         S8IKGke22+5JF/PPPLBZlI1ebIDBjSQUWHbOTfDs3p/kyWakPZR3yMUnGT7V2ZeYp8Sg
         kRgSNWWj50XdCztkI7evzla3d/XiUeU9ehNfEwqvbWzhiVmcm2ldq+6Y7f/82bzsWd4W
         WWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc;
        bh=TyuMx8yshHRfzKYftyMjQYQjs7ybOj8AY7Hfdf0H5iE=;
        b=y/6uNWithRm3a0cGMNymCwzuWKZ+x6xsYqRu8R2Iylj0tme6XHzf9PrNRdjlwsE9al
         SsYIQMxqJAYWMKNXn6X6OwhtfsBV1BlJASYYmeg/zgJuL80V8qMDPWEMImiduBdoy1RH
         DcB0EKjUvdWf8EZRqGdeAaj2+8yAsc6/C3VqmGdTmyFh48LGCUELlOdi0A+oU0Ef0s9x
         16uEKKAnAwKwPuP6rVS4zvyLvfBa2u08Ol70cUYOaMBdpwrEeW+cdduNDvr0I1zqEECO
         kEvObqzTsmPyoEhyK8c7W8f+P4AvyDJXP28mAN17swLqNOdw9QqTImVSmcO4vbdrjOyK
         aGJw==
X-Gm-Message-State: ACgBeo1IEJuYlS2szKzVEWbDebZimfIDCr6iEYFlRDK4qLR5Im8k47cH
        HVIy/sn6mnFddmJNIZUofjX5e/iXmXJrta0=
X-Google-Smtp-Source: AA6agR7kkC+dXeftLYdoFcXCaZzilxXlORdN927YzXjH9g/xhirRybWCfExP5wHGS4Bp84S0TdAViV1YXsH0Si0=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a63:1b55:0:b0:41e:2cc8:4296 with SMTP id
 b21-20020a631b55000000b0041e2cc84296mr3341299pgm.510.1660848683318; Thu, 18
 Aug 2022 11:51:23 -0700 (PDT)
Date:   Thu, 18 Aug 2022 18:51:10 +0000
In-Reply-To: <01c63ea5feefd57721bdcab9f0a30d9c0112e753.1660575688.git.gitgitgadget@gmail.com>
Message-Id: <20220818185111.4062955-1-calvinwan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: Re: [PATCH v4 1/3] hide-refs: add hook to force hide refs
From:   Calvin Wan <calvinwan@google.com>
To:     Sun Chao via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        Sun Chao <16657101987@163.com>, Sun Chao <sunchao9@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sun,

A couple of us from the mailing list reviewed your patch yesterday during
review club and I'm going to summarize our thoughts here.

Starting with you commit message, it is not entirely clear what your
series is trying to achieve. While you do attempt to set the scene in
the first paragraph, it would be better to go into more detail of how a
user would use this hook. Do you already have something like this
working downstream for you at your company? If so, that would be a good
reference to provide context for readers. If not, try to sell your use
case better to us by providing examples and anything else this could be
useful for. Your commit message should also have a broad description of
the changes, explain difficult/tricky changes, and dicuss
tradeoffs/complexity.  

As Junio has noted, there is a lot going on here. For example, changes
you make to pre-existing functionality should come with an explanation.
One way to manage this complexity for reviewers is by splitting up your
changes into more logically different commits.

For your tests, they should show a working example of thie feature, the
motivation behind the feature, and a description of the interface. The
structure of the tests is also confusing and there seem to be many
unnecessary tests. It is OK to be verbose and obvious in tests -- it is
very important for reviewers and others looking at your tests to easily
understand what each test is doing.

"Sun Chao via GitGitGadget" <gitgitgadget@gmail.com> writes:
> From: Sun Chao <sunchao9@huawei.com>
> 
> Gerrit is implemented by JGit and is known as a centralized workflow system
> which supports reference-level access control for repository. If we choose
> to work in centralized workflow like what Gerrit provided, reference-level
> access control is needed and we might add a reference filter hook
> `hide-refs` to hide the private data.

Why is Gerrit being centralized relevant to ref-level access control?

> 
> This hook would be invoked by 'git-receive-pack' and 'git-upload-pack'
> during the reference discovery phase, each reference will be filtered
> with this hook. The hook executes once with no arguments for each
> 'git-upload-pack' and 'git-receive-pack' process. Once the hook is invoked,
> a version number and server process name ('uploadpack' or 'receive') will
> send to it in pkt-line format, followed by a flush-pkt. The hook should
> respond with its version number.
> 
> During reference discovery phase, each reference will be filtered by this
> hook. In the following example, the letter 'G' stands for 'git-receive-pack'
> or 'git-upload-pack' and the letter 'H' stands for this hook. The hook
> decides if the reference will be hidden or not, it sends result back in
> pkt-line format protocol, a response "hide" means the references will hide
> to the client and can not fetch its private data even in protocol V2.

What is the reasoning behind special casing v2 here? Is it possible
you're confusing remote helper protocol and wire protocol?

> +static int lazy_load_hidden = 0;
> +// lazy load hidden refs for protocol V2
> +void lazy_load_hidden_refs(void) {
> +	lazy_load_hidden = 1;
> +}
> +

What does lazy_load_hidden do?

I know this is a lot to go thru for your first patch series, but please
don't get discouraged! Feel free to ask any questions if you're confused
about any of the feedback. We didn't dive too deeply into the specifics
of your code since we believe there are higher level fundamental issues
you should address first. There has also been similar discussion regarding
differing ACLs within a single repository so it is probably worth a read
here[1].

[1] <CAJoAoZmsuwYCA8XGziEA-qwghg9h22Af98JQE1AuHHBRfQgrDA@mail.gmail.com>
