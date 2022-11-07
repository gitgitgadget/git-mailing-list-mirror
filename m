Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECBCC433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 20:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbiKGUUc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 15:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiKGUU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 15:20:27 -0500
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB271EAC0
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 12:20:23 -0800 (PST)
Received: by mail-io1-f50.google.com with SMTP id y6so9832258iof.9
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 12:20:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BC89WuSD9OzrDhpE95qqoIKHeHR+9iib1bigGjbfomg=;
        b=tq8b/ZwfD/9APxgymBHjIOQN5hTLYC0W6mPcGErZQ4GAW/7/LW3qkPLB/D+2wAEBE/
         /TxH6uqNIsVb06I2tBatRxmfGS5j8k0KiCcaPRgez3z90rKL+udr570PPZyPOHLgmekM
         B0z9Jl27YCKpbjk2MBkWn5iNunVPuV5WF8d/8ENnpLYQouo5YD3pfonKVe/wnQGGjaNt
         OVF/y8gQN1cxyxvpArS3Zw6BhmcXhsUpAOCO97ycQv0iyH6phGzP025nltuBrbRfpP32
         pQgwxwBDCJZMNchEorOmQu7LcmDxM1+DINBIHCnyV2ZkF3KB4tOu6RaLaPkDcD2qZwDH
         bnVQ==
X-Gm-Message-State: ACrzQf2w2PGfORxrVVEhUMuNjRD3id70sNfp0gCKiADIHWtwkzpjsNvQ
        BArWSoEajtfMAZ7jnBbvlvMRXv7A9TEeWSU39bvXd+e6
X-Google-Smtp-Source: AMsMyM5Qk7vjYrFtFHn7fAw7C/dDoR+dM1EPAMk+pmq6wOdz6NwIEDradoDuJrK2Wf+D0LD/46DJBnn9qKWE47iqd00=
X-Received: by 2002:a5d:8251:0:b0:6ca:d7ff:375c with SMTP id
 n17-20020a5d8251000000b006cad7ff375cmr30533375ioo.197.1667852423227; Mon, 07
 Nov 2022 12:20:23 -0800 (PST)
MIME-Version: 1.0
References: <pull.1384.v2.git.1667002005494.gitgitgadget@gmail.com>
 <pull.1384.v3.git.1667424467505.gitgitgadget@gmail.com> <0e2de99a-da7e-f65f-aefe-117fb468ce55@github.com>
In-Reply-To: <0e2de99a-da7e-f65f-aefe-117fb468ce55@github.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 7 Nov 2022 15:20:12 -0500
Message-ID: <CAPig+cTHbM6sXCkMHaDVNs6JJG-5pN-4Nf5tpBrOtYC82=8VvQ@mail.gmail.com>
Subject: Re: [PATCH v3] status: long status advice adapted to recent capabilities
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Rudy Rigot <rudy.rigot@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 7, 2022 at 3:07 PM Derrick Stolee <derrickstolee@github.com> wrote:
> On 11/2/22 5:27 PM, Rudy Rigot via GitGitGadget wrote:> +UNTRACKED FILES AND STATUS SPEED
> > +test_expect_success 'when core.untrackedCache true, and fsmonitor' '
> > +    git config core.untrackedCache true &&
> > +     git config core.fsmonitor true &&
> > +    git status | sed "s/[0-9]\.[0-9][0-9]/X/g" >../actual &&
> > +    test_cmp "$DATA/with_untrackedcache_with_fsmonitor" ../actual &&
> > +    rm -fr ../actual
> > +'
> > +
> > diff --git a/t/t7065/no_untrackedcache_no_fsmonitor b/t/t7065/no_untrackedcache_no_fsmonitor
> > diff --git a/t/t7065/with_untrackedcache_no_fsmonitor b/t/t7065/with_untrackedcache_no_fsmonitor
> > diff --git a/t/t7065/with_untrackedcache_with_fsmonitor b/t/t7065/with_untrackedcache_with_fsmonitor
>
> These files are small enough that I think I'd rather see them
> be created in the test script. You can use this kind of syntax:
>
>         cat >expect <<-\EOF
>         <file contents here>
>         EOF &&
>
> and then the test is self-contained. This is particularly
> helpful when a test fails due to some future change in this
> message.

I've been meaning to respond to say the exact same thing about using
here-doc instead.

Also, the new tests seem to have an oddball mixture of indentation
using spaces and TAB. They should be using TAB only.
