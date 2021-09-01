Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287B6C4320A
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 12:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED7BB6101B
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 12:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243981AbhIAMW4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 08:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbhIAMW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 08:22:56 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B95C061575
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 05:21:59 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v10so4207249wrd.4
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 05:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=iNqF6X6LtXgQMThQkrgtgRXK9DoKih4397e9xkdWpPA=;
        b=CHeuUdnKdZDI7vbY3T79OkXa3f2d6CvXIDW1VRkIvyLS7WiGQvRT89MHHY5O29BSYG
         fyqHDtPRHR2pwxvgXJyIUgYDqALp5Jjy64T7rXz1AjzEFyzMVIQruTPx+TV6v5GdvSio
         czhJDwvOsKdw8B6rCv0G4MuF1VHb5eHlrjZJuYcaLXNZo/p3bS0l1N94XMHOqB2mdmHP
         Wdd0gMXth4oHgcz6nhsPeqIB49majx3yo8UTzf0/o2ZkdZ7hW4UXHhMC1rxpN0BmycC5
         UcstdYhmqtnUYbQ47LEW7EuKLFBL5CLhYfTJJ7IB4oyfadaeux7H0W/1Vm+ZCMVaM5Rz
         AlCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=iNqF6X6LtXgQMThQkrgtgRXK9DoKih4397e9xkdWpPA=;
        b=oWNJzsKquQmB3XzYHz0vw3RO9swRBHlWlD67PUdaG73Gp+lCpjIgQVc66ihICAlkNn
         EKGn8UbaB7LXNWMOkrhHv9o0ZNaEZacOFpeC2i2pSFNIpIPOArBN/WWtDNXtX4Pok2K9
         23PMlmVspPzGmwI/9j9I0t0Wvn6Hqlcd7DXPYOxvfJdTIt8CNZtrn5SL5Rhh54scxWUD
         svc4UAH+PZRLLvsuFhpP81zP1TKBjRf9pkBO1Lcf5VyU3MdLEkhCm/+nXLKK9yuoElRP
         Sk6pr7O8AjAEMS0es5jxMTt4FFbHkmRzccH6jebu5qgbqP/15Jm/VoB1jBWzv/5Fntmu
         nelw==
X-Gm-Message-State: AOAM532XhSNAz4ChaZ6EnXcy5OjexxFLHOIYd1TnqZHCkMm96XfKUws7
        f5phR/7Lw170crOQeBpLjvL2LRqJ6lQqmQ==
X-Google-Smtp-Source: ABdhPJyXIAskbWpKz+JYtxEz7o0Kbo5WIvF/VjNFik+wmwa2LNm0lsheLZ+PqBQADz9+HLgRYcFz6A==
X-Received: by 2002:adf:ed0c:: with SMTP id a12mr37187009wro.102.1630498917924;
        Wed, 01 Sep 2021 05:21:57 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id t14sm21197578wrw.59.2021.09.01.05.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 05:21:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 5/7] rebase: drop support for `--preserve-merges`
Date:   Wed, 01 Sep 2021 14:21:30 +0200
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
 <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
 <eb738b1bf05dceb1d119e3adcd732d968407c757.1630497435.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <eb738b1bf05dceb1d119e3adcd732d968407c757.1630497435.git.gitgitgadget@gmail.com>
Message-ID: <8735qowknu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 01 2021, Johannes Schindelin via GitGitGadget wrote:

> -	struct strbuf script_snippet = STRBUF_INIT, buf = STRBUF_INIT;
> +	struct strbuf script_snippet = STRBUF_INIT;

You end up removing all uses of script_snippet except the
strbuf_release() for it, so this & that can be removed too.
