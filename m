Return-Path: <SRS0=BQqG=A5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431FDC433E0
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 01:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F75A2076A
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 01:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlIL8ZEL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgGRBQ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 21:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgGRBQ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 21:16:26 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE1AC0619D2
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 18:16:25 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id dm12so5065512qvb.9
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 18:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=cvewZMneMaUzP9TKMw6vW+pgd7ZpVxmNMlacShZdXqc=;
        b=YlIL8ZELr13MRM6PYXtTXknqe23aXF9vXKItEUZvFmJIw/U+Sp6Kt9gXiyjgTSGOLE
         4v18pn2Ke1Vb7VIPpgPRX5CAszCZrmlnekP8XesGJDkhI6tG0vUBuFJm5CGOCGwPRvOB
         lMXufI4xoxTcC+wU1AIm5bV5dJTyYnXXJLQcrUcT8u50zJ/vov2Ocza7e7nGJl1JbbzQ
         P1etjRm4p2Xh17j0qqg2KDAKACwgrw5cMdTQC36lWnYkb6zeqHqWSofR6FdU5wgm48cg
         0BajKkcgS29sE/tvrCo/5UU24sviKGZQBAPWnmomfiB/1Ei/qaPWG0dJBpJ2twRQmu+0
         OgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cvewZMneMaUzP9TKMw6vW+pgd7ZpVxmNMlacShZdXqc=;
        b=AGMInpB57/WqwS5/hy0GDgTtChfqEMf8NU1sJrPdtf/WE68On34ZO5nSrqtKUs4GqF
         x1dDH4bqs8YD4VphYaVQ9eEyVTqKIzuJ0gKp/7L/hhJp8awWXDZZ7RgLNNnhb7mNXLrh
         kByEdF714iQC3OybiBy2IBgUhbGU8tYyOIEGp9sUndaIObcQXCmXy4wGdEk0Qxc2MHyg
         m/4L6JaNnFeFLMQIEwJbxEYcxkiXvovzWxIlmeKzoXQHj21hxu7XQa9c877W5NhJmCnQ
         ZXEmo/aIbGk1OvpKyb90V1yuAJs7eMRn7h0MT4Jgkk0CsEGrreBosbf4n2A6rhKfitqB
         rTfQ==
X-Gm-Message-State: AOAM532rONFN4w13BMfDrpMLtwLR9zTrQsXWCY5/tBm0n0HO/wiehkST
        4bgJtNVzEIIXvCACqJWJkR5RfNwIQvI=
X-Google-Smtp-Source: ABdhPJxcn1TryuE5jCjM+n836qGArtE86dHLYGXfw6fUlJJ6EZce8JVCkGzlpYRq+qWDm0U6porm9A==
X-Received: by 2002:a0c:82a2:: with SMTP id i31mr11837440qva.106.1595034984875;
        Fri, 17 Jul 2020 18:16:24 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:212e:dedb:cfe2:fbec? ([2600:1700:e72:80a0:212e:dedb:cfe2:fbec])
        by smtp.gmail.com with ESMTPSA id h197sm11731718qke.51.2020.07.17.18.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 18:16:24 -0700 (PDT)
Subject: Re: [ANNOUNCE] Git for Windows 2.28.0-rc1
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
References: <20200718011007.6808-1-johannes.schindelin@gmx.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8ed2217b-f04d-f7f7-4c1d-5010aee92f5d@gmail.com>
Date:   Fri, 17 Jul 2020 21:16:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:79.0) Gecko/20100101
 Thunderbird/79.0
MIME-Version: 1.0
In-Reply-To: <20200718011007.6808-1-johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/17/2020 9:10 PM, Johannes Schindelin wrote:
> Dear Git users,
> 
> I hereby announce that Git for Windows 2.28.0-rc1 is available from:
> 
>     https://github.com/git-for-windows/git/releases/tag/v2.28.0-rc1.windows.1

While this (automated) email came from Johannes, I want to point
out that I'm taking point on this and the remaining releases of
Git for Windows in the 2.28.0 cycle while Johannes takes a well-
deserved vacation.

Please continue to use the issue tracker at
https://github.com/git-for-windows/git/issues for any problems.
Also, don't hesitate to CC me.

Thanks,
-Stolee
