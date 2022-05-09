Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45925C433EF
	for <git@archiver.kernel.org>; Mon,  9 May 2022 15:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238473AbiEIPiq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 11:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238435AbiEIPio (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 11:38:44 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093AF238D77
        for <git@vger.kernel.org>; Mon,  9 May 2022 08:34:50 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id r17so9531852iln.9
        for <git@vger.kernel.org>; Mon, 09 May 2022 08:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mPXluc9PIlVvvLDZpb+8FnknIp89VLtveoWBuOTvB2s=;
        b=M7FanTf6QlYCwg7zQ/aqkw7M58jYldjf4QuBQG6f4p6Vn4JXZhdhsTrEy2/3biJjEL
         r8BTu5c7dj+A/GHytUZWFBhctyvDlPYNWB9wABLQwxwXkUew192ILry+jyebsuqOlWGx
         BIsoz1af/4oW+TaZXmquJLQAvp9F/PPvVRtbj4CLpzMwpCZvl0tqeCNK1JWOCcVm1b8v
         sEAcdlpx7Zxy+Yu1rJ/9lprCcP1esrfmQ5+jK2p1SXMPq7JhG3vjhzChP5ISGUlQOcq4
         oqzCV2qzfg1lZCoC/NKTnHA/sPUPNdk/ggEz5YYp4e973kLn7jujC8SsbtRZFNbOAhP0
         B2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mPXluc9PIlVvvLDZpb+8FnknIp89VLtveoWBuOTvB2s=;
        b=GUSo7kb3711FYG9cqqpFPk/a7LFbdIZ0pnGf5KVUtcR7bDS/MV4aLeM1QChDul+l27
         U70YioGRlDGKo7RpFpwdHH4aND5rSou+u+ijyCHeAeAzUinC58EPcrP0rmd9tXaq0V9z
         zmjwXDj94RBTKyzaS4c79EQ5wfGJ+C/CfTvNeqqLG0FRAPK/cGFkOha61B99ffaO554Q
         R2+s2npMNG98Wb/RhjlhDiOuSwn0ILYW1Is6JNJFYBmCHlKZThFoxcz6JoTnpIAomsYY
         gZ/Q8V5Ex3SHhGJ2yVGM6pcm1nuyVSUfXSU8Ni/sGja5NKcMD74imSGwrl+ZKslSj/Gq
         aDOQ==
X-Gm-Message-State: AOAM530yLLQDwYnpEO6xc3/VRQkss/AM/JNdF3e8TlNIcz+buvH4xBVu
        OjZI7cfaUrSEiZEUGUrhYuWXag==
X-Google-Smtp-Source: ABdhPJxIt2ng/hgNzirbY8ouMFzV8NKwG/Nm1tKS2+eisk8JaiD7UTIPR/BfJwCYVzNjM5aj+vd88g==
X-Received: by 2002:a05:6e02:194c:b0:2cf:294b:28bf with SMTP id x12-20020a056e02194c00b002cf294b28bfmr7204504ilu.51.1652110489381;
        Mon, 09 May 2022 08:34:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w19-20020a056e0213f300b002cde6e352c0sm3237467ilj.10.2022.05.09.08.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 08:34:48 -0700 (PDT)
Date:   Mon, 9 May 2022 11:34:48 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>,
        Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v4] builtin/remote.c: teach `-v` to list filters for
 promisor remotes
Message-ID: <Ynk0mADTSJU/xVUd@nand.local>
References: <pull.1227.v3.git.1651933221216.gitgitgadget@gmail.com>
 <pull.1227.v4.git.1652095969026.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1227.v4.git.1652095969026.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 09, 2022 at 11:32:48AM +0000, Abhradeep Chakraborty via GitGitGadget wrote:
> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
>
> `git remote -v` (`--verbose`) lists down the names of remotes along with
> their URLs. It would be beneficial for users to also specify the filter
> types for promisor remotes. Something like this -

This version looks like it has addressed many (all?) of the comments
previously discussed during review. On a quick scan, the code and tests
look good to my eyes, too.

But there was a good question raised by Phillip in

    https://lore.kernel.org/git/ab047b4b-6037-af78-1af6-ad35ac6d7c90@iee.email/

that I didn't see addressed in your response, which was "why not put
this behind a new `--show-partial-filter` option"?

I share (what I think is) Junio's feeling that having information that
is readily available from e.g., running "git config --get
remote.<name>.partialObjectFilter" seems redundant. I could understand
forcing a user to know the config key's name feels like a hurdle. But
cluttering the output of `git remote -v` seems like the wrong solution
to that hurdle.

But I can see where it _would_ be useful. So it would be nice to be able
to turn the extra output on in those cases, but _only_ those cases, and
a flag would be a nice way to go about doing that.

Thanks,
Taylor
