Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17F5C2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 21:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DDB82065D
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 21:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/fI9d+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731194AbgKIV4o (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 16:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729493AbgKIV4o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 16:56:44 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164A8C0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 13:56:44 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id s8so3378110wrw.10
        for <git@vger.kernel.org>; Mon, 09 Nov 2020 13:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9rJbmqmWbz6QWFoGiPMTpl9u84rZpF0dQ3c8tOq6zbc=;
        b=b/fI9d+I909a/1fV3Gs4bKfcvyxAd6io/C4wOm6mb49nQhMle+zcXIr5cv5EQrehlv
         RP9+94kFUWFTgckRR0eb4Ccxh/F5ABJxyLVKxRO+frDeWbQlsVwfT73Pei7JUjl/cfZb
         sFOeAGj2FG1UJkhhLTC1pin9Z4h/2nhDqEPKIZIrhrERPtLp5o2HAZvhrWvfdmhYuodY
         udIsGym37fKLlOsvQoPz7scPkRM65HtROnePraHwChuf2783gWpK9BpwydDJs6aq5m9o
         LPaS9m6dm6wl11gPOQWGefgEHamTIaPfklk+MGOKRj9SQZSuXYQsWnJGIgRaLSqYHc6u
         HpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9rJbmqmWbz6QWFoGiPMTpl9u84rZpF0dQ3c8tOq6zbc=;
        b=f0eKhwo4QfGZ0tambz2UnoM7kef9fTulQ9fQpouUcs7B9kpRFcDhL3Ll7wbvp+DYAk
         qltd6PMD3pC5Q8q+IkWmxuE+bUfsEjZX/l8m2xhj1YlIwlg2BY0cSh1LydoyRoeB0XhY
         5QeDr4rBsiYfglnzCv01BCu99mjWqcA5PT9iOoRVc38dYsNO8BuZvX4z6jLBKWYQj6ub
         9Jk84AkeL5AkkS+cOkvLyZabj3fc/HCK0Y83GXGxwZdeqZMwNCHmTxfz4POTwbgDZGu0
         e8lQvW36LBwEurdCTHrnuA0dBikvXU1EA5oThJmDXzyZizUarf8ASCquPnt22sUJck0w
         bE4Q==
X-Gm-Message-State: AOAM530UNh/dEEiAWwjqkZ44oJ1gFrUakynUlUfRecRxVn5+fa7ENzQd
        RvuPXHMvWSZttbld2Gws53zvMjj3mVkPiKM1bVc=
X-Google-Smtp-Source: ABdhPJxwlUslV6ltUNJWiri1e8j5WmgFsiPD2vHD5o9mIS7IKYPsmgjvn9zsDDlercaxBdjjhzZd+D60CVAsuJWX6yw=
X-Received: by 2002:a5d:4349:: with SMTP id u9mr19957782wrr.319.1604959002861;
 Mon, 09 Nov 2020 13:56:42 -0800 (PST)
MIME-Version: 1.0
References: <9717A684-9304-4A65-8566-19F946098455@gmail.com>
In-Reply-To: <9717A684-9304-4A65-8566-19F946098455@gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 9 Nov 2020 15:56:32 -0600
Message-ID: <CAMP44s3ZPJhej9JQir+Vo6LEQKDfgvJBVyUNPEEze0YTnTxU4g@mail.gmail.com>
Subject: Re: Completion for aliases that wrap aliases that wrap Git commands
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Fri, Nov 6, 2020 at 4:46 PM Philippe Blain
<levraiphilippeblain@gmail.com> wrote:

> I know nothing about Bash completions, but I'm wondering if that feature would
> be possible at all ?

Yeap. I just sent a patch for that:

https://lore.kernel.org/git/20201109215248.461167-1-felipe.contreras@gmail.com/

Cheers.

-- 
Felipe Contreras
