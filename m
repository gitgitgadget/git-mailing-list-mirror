Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A89C433FE
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 15:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiJCPoA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 11:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJCPn7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 11:43:59 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8701C43F
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 08:43:58 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id b7so9736910wrq.9
        for <git@vger.kernel.org>; Mon, 03 Oct 2022 08:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=J0kVaDldsTuCM+fkd1xAO3x+W+toLSQBbFVuyeXXlS4=;
        b=SWaZLaiOc3P9ZCtVPpgvLEZtnjOvejzwjsJ9NfwDg7ks5d7fqy9KOfDHPFIOljM/bG
         w6nK120QxliV2VIHrELg1EBlCvGDGP27EyTZ7c15zAuJiFUc+pv0Xe92re1znnr6Fm/a
         rAQ0w6/F1JiZbZKx2SpSTi5wnJ6K1LAPzPRszCHvLfm4B8e1o46w+NViRlIOR9uKaYFX
         fNhqXHDPFGFEGM1ZhVFj6liJqJZnME8xC5gFK7AjlsfEt11AR28mUp+ydPwDoNSHUmMm
         WhbyoN7AABYmLQnBYA4+wu9BGXdH6xHf4ZtnLL/oyxJlJp8dHOHZ5PGvnWYnGoBeJihi
         cOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=J0kVaDldsTuCM+fkd1xAO3x+W+toLSQBbFVuyeXXlS4=;
        b=WZ0sq+lDIiupzFrM7KgHK3tTS4l/Xp9zf3QxhVrlrbmjNwJlLE63MI/Nj1FThpxEQt
         dQhqgFETJNBMrLW+Zsq+kmrtcck8o9kDIwT9EOnDdWPuA7YJCm3GYSl2OFlm/5v0i6Gk
         FfpDIksZvrzkHNxHLdCTDrPiJBsNrZBG0gQ5De6RA3ClBq8SCyvZWmp+Tj88h7c462ul
         kJq3ahYLayNiMkJ7v/e19LhHnpuzYf76C1UFF7Pv8QRj9khUK5FHAYKiYFcIWtFgHnrM
         2NJVKMjyvPu4aku7vNX32XYD/9ttppKXZjyVGxG2sgr6HtDyXTmdEZwbvtLSVyZMby7M
         1Tmg==
X-Gm-Message-State: ACrzQf3I7YdycxyLPb7HzLPBEuUnTW+S39CSmDPlOwzAgjWexTI5iULz
        SRUIpnushrT7d+kwpvYY2jE=
X-Google-Smtp-Source: AMsMyM7Ok1oI08VOOd6oA1rPW55Uk9/iklCzoTTlsfJKG7ylVANscNGiRyzc7XP+KiuvvPR03RFCXQ==
X-Received: by 2002:a05:6000:1a8f:b0:228:e3c3:679 with SMTP id f15-20020a0560001a8f00b00228e3c30679mr13302007wry.281.1664811836752;
        Mon, 03 Oct 2022 08:43:56 -0700 (PDT)
Received: from localhost (78-131-14-129.pool.digikabel.hu. [78.131.14.129])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c2cd200b003a63a3b55c3sm17934495wmc.14.2022.10.03.08.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 08:43:56 -0700 (PDT)
Date:   Mon, 3 Oct 2022 17:43:54 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Tim Jaacks <timjaacks@posteo.de>
Cc:     git@vger.kernel.org
Subject: Re: Bash completion for git aliases containing nested subcommands
Message-ID: <20221003154354.GC7659@szeder.dev>
References: <em8d7ca854-51a3-4cb5-aaf9-30ed37b4194b@acer-switch-tim>
 <20221003142437.GB7659@szeder.dev>
 <1839e62f930.285a.8a94aeaa49923dfb9a7d55a303990d0a@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1839e62f930.285a.8a94aeaa49923dfb9a7d55a303990d0a@posteo.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 03, 2022 at 03:07:10PM +0000, Tim Jaacks wrote:
> Hi Gabor,
> 
> thanks a lot for your detailed reply! I tried that and it works, thank you.
> 
> Just another small follow-up question, out of curiosity: I noticed that zsh
> handles the alias completion correctly out of the box (using the exact same
> gitconfig file). I don't have any dedicated zsh completion file, just
> installed zsh via apt. Do you know why and how zsh handles this differently?

There are not only one but two Zsh completion scripts for Git:

  - Ours, which is essentially a wrapper around our Bash completion
    script, so it shouldn't work for your alias, and it has to be
    installed manually, so I doubt that this is what you tried.

  - One that's shipped with Zsh, with all the bells and whistles that
    Zsh's completion system offers.  It's not maintained by the Git
    project, and I have no idea how it works, but I guess it works
    sufficiently differently to make your use case work.

