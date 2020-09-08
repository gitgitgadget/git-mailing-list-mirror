Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AF6C43461
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 22:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF1D3207DE
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 22:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKIooB5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgIHW5I (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 18:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgIHW5I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 18:57:08 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7180C061573
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 15:57:07 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k15so846295wrn.10
        for <git@vger.kernel.org>; Tue, 08 Sep 2020 15:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ki5O1ohrKZ1RzJcn816UfwYPQhg3R3cVL1GH5hIK/TU=;
        b=iKIooB5HhdD1EWGelrF8VbY8etY94+NwsdUIx4eV9PcHoBpJy0Vji5jn/BmrJaadO1
         dqC117ByxG3tdvHuzcNYPvZ+6WDyaKPcJpfU+bNBZfBIvAmVlhqJy2WAn7wPVopFeGW5
         SMn076KUzU/r7r1HGsF7jsQXAwEM65vGdLwgEjrAqBi+kLl3VzVMXQqnsudZvbQW9OSQ
         YyjwVUoHFhLP69XIYmXlWO1m7VrEvaRCvdYj+R2j7l3y+fe4BTK9VJEaP4uOAt1H2RIM
         xZa99Ka9VA96b1aZ4g8PWks2Lc6Ung/L128osG0jUqes1NEZP1s0DQeTwd8Wg5GWGNhA
         D9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ki5O1ohrKZ1RzJcn816UfwYPQhg3R3cVL1GH5hIK/TU=;
        b=FV8FsXnjGCPGFYaNq39Jb8KtolwSkfqsHM5uI66UATlTLN19RCJmLIhnu/Hd4MrZjH
         dB4tYHN5/ptt9+g8+Q4QC2I/SLQD0om+Ka6yjgkOTHXLdfWCSjax0KNoU46YuV1Gh+sB
         D1tsYe0T94XrYGzev8F2MNP7+/ooMenJYQlDf7IsKlytL5wlGfOxfKsvCRLI4Cgg/lpH
         TVhTXAJmNME+fiyn8YYI2sDm2jt/uVx/4FyXFwTADEzGD/4GiSzX8yk5HYy+gQ36rDge
         CfrSuvLcONijkAZMb4/R55hl9eQeHBfcc2ahDW0v/nhGGyOeHSZJyTe03I0r8Fg7cj3A
         e47g==
X-Gm-Message-State: AOAM532r1zGWkPnBIwkCJkeF7dvbMjXbZaVDoktFm63uLl3MjWhjUEpE
        blN52iX18LfS1vqCObig8WZuCKnEjNGYXVyBMEU=
X-Google-Smtp-Source: ABdhPJxYG6XEU4t+G0Uwn4llq33dUtynSPT/R/MIQIzkrMJxHnWJ3yislXxlBcpOfeXRgP0iV54ooFE95jsP51FG4yM=
X-Received: by 2002:adf:a443:: with SMTP id e3mr817705wra.146.1599605826480;
 Tue, 08 Sep 2020 15:57:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200908013013.1099937-1-sandals@crustytoothpaste.net> <20200908205224.4126551-1-gitster@pobox.com>
In-Reply-To: <20200908205224.4126551-1-gitster@pobox.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Tue, 8 Sep 2020 15:56:56 -0700
Message-ID: <CAPx1GvddM_B9Lehg8pX2yEXgiHL5vKYiabiCsjKhKHDnhQTx4g@mail.gmail.com>
Subject: Re: [PATCH 0/6] quote_path() clean-ups
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 8, 2020 at 1:56 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> So, this is an alternative approach to tackle the same issue
> <xmqq4ko8yxp9.fsf@gitster.c.googlers.com> tried to address.  It
> ended up to be more involved than I would have liked, but it was
> primarily because it needed some function signature changes.


Not that it necessarily means much, but I gave the whole series
a quick eyeball scan and it looks good. I like the idea of using one
consistent "quote the path" routine.

Chris
