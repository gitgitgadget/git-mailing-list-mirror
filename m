Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDB2C433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 17:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbiGRRfT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 13:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235834AbiGRRfO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 13:35:14 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70092CDCF
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 10:35:13 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id k7so6349816qkj.2
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 10:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZW5VP0ROfD76nsDDo0dMj9vazir9yG4WUcQHu6iS5Ic=;
        b=ZN5ObvicB+FtJvorLYfZJjxNEjOfveRyHzJ+RRnra7y2ODunzBRy60CsbWM5TAehC4
         paYHkHCiGUiLCq9ObK9PP2SEK+25yL7P2v53lgr8Omv57qwH86ZXvCIpRqWUk+c2v4es
         apE0opY3kkDFHFWt8TLMtGG8KQ1RyNfGjMP3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZW5VP0ROfD76nsDDo0dMj9vazir9yG4WUcQHu6iS5Ic=;
        b=Gn80gpGUjs479vrgoyjZhreJCB0Zhkrm+mGWtO+oqqA7A6eYRU/jVIxs59XmQ66faM
         I2Vwi+8tS59Guo+njxe0e5OOU5qr6GfwZDZpoowXd++xrVXkSVxdFaUeqShu4CNTiRMr
         bNnS9azMsaEVbvIDCkcwo0XXels1HnOgmwS0EMLH6QwR8x4H8HVEm+GEgVeVvcNKrkAU
         jj7SNf+xsUc0/+iqtyZKi3l/n2zj6lsKcqpXhbqfQi0UyCHmZYx/q/oXm3FnNeQ6pHPx
         oDGfsDxP5JFRT3/qEm9uqng3DHwGYEY7XxdOENU/Zhp3wGJ533Rf+AvjmWTTcUoT0jq3
         JgZA==
X-Gm-Message-State: AJIora8K9BBmQHq15W3qUyETv0p50YiSKFlTha2uDlpuxIEOIP2pGWm3
        VnIeAuIELizOCaBbUsP1HwfNX8pz7/268g==
X-Google-Smtp-Source: AGRyM1twSZLV1OkC0n2LSgSy0l2oZbOdO8eoBXeznjtj8HlqbgmonOtQWDR/I160r11Hr/D+/3TF+g==
X-Received: by 2002:a05:620a:4086:b0:6b1:e044:3f66 with SMTP id f6-20020a05620a408600b006b1e0443f66mr18458987qko.500.1658165713038;
        Mon, 18 Jul 2022 10:35:13 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-245.dsl.bell.ca. [209.226.106.245])
        by smtp.gmail.com with ESMTPSA id y13-20020a05620a25cd00b006af20edff0csm12136496qko.58.2022.07.18.10.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 10:35:12 -0700 (PDT)
Date:   Mon, 18 Jul 2022 13:35:11 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Stephen Finucane <stephen@that.guru>
Cc:     git@vger.kernel.org
Subject: Re: Feature request: provide a persistent IDs on a commit
Message-ID: <20220718173511.rje43peodwdprsid@meerkat.local>
References: <bdbe9b7c1123f70c0b4325d778af1df8fea2bb1b.camel@that.guru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bdbe9b7c1123f70c0b4325d778af1df8fea2bb1b.camel@that.guru>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 18, 2022 at 06:18:11PM +0100, Stephen Finucane wrote:
> ...to track evolution of a patch through time.
> 
> tl;dr: How hard would it be to retrofit an 'ChangeID' concept à la the 'Change-
> ID' trailer used by Gerrit into git core?

I just started working on this for b4, with the notable difference that the
change-id trailer is used in the cover letter instead of in individual
commits, which moves the concept of "change" from a single commit to a series
of commits. IMO, it's much more useful in that scope, because as series are
reviewed and iterated, individual patches can get squashed, split up or
otherwise transformed.

You can see my test commits here:
https://lore.kernel.org/linux-patches/20220707-my-new-branch-v1-0-8d355bae1bb5@linuxfoundation.org/

You will notice that each cover letter has the following in the basement:

    ---
    base-commit: 88084a3df1672e131ddc1b4e39eeacfd39864acf
    change-id: 20220707-my-new-branch-[uniquerandomstr]

There are 3 revisions of the series and you can locate all of them by
searching for that trailer:
https://lore.kernel.org/linux-patches/?q=%22change-id%3A+20220707-my-new-branch-1325e0e7fd1c%22

Note, that "b4 submit" is in the early experimental stage and will likely
undergo significant changes in the next few weeks, so I wouldn't treat it as
any more than curiosity at this point.

-K
