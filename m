Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C812C433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 23:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236421AbhK3XLI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 18:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbhK3XLF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 18:11:05 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D8EC061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 15:07:45 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id r25so28064140edq.7
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 15:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gFnOUMzswysLxhzvZSgLiKErz1xdrDA4HlN1e6ik7sM=;
        b=LrAm74PP6xvKh3KIIipTdR6X2Z4TJgJk2MTMW3W9lPw3WuWwcwSmcj0mRrLcCxI4jN
         e/uYGDbrE+I2qM5UYqqVvDINl3WWXiaJFVMWWnm76AKnWEX18nT4dDuMym3Edzh8Zm5s
         jccqVJ3SExpp8HoEbAIvCdkKWP8r2x76oJFkxbis3+OaZrpdFXuasvCcsvxRKk4zbXFu
         eVl4Vqh5YqIKUelbGUUXhnyPq1m1Ts5j1SVHMbifa4e1U9va0frx8x6KXc9Gce3bM2Fp
         64LMwrADvPnDqKwtYhXC7uNhCavvZLcdryrbPxGubrserDHxrHqHBgxZXIig4kenztmf
         TL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gFnOUMzswysLxhzvZSgLiKErz1xdrDA4HlN1e6ik7sM=;
        b=56rJdzYvfZ/lE2o9rnkYz1tCIH5F55IndSDJ63/AjoSzKsqWm5y4rcQ6tuZxNegKZx
         /TAqLnXa6kw8XHLwJ4R3yzZxVnMf+9f1akX04FXxP51cP2MKiOPwgXezuGn0qODNqx8M
         fsiEUIzMh2zBcAqJUqI/BO15QhA7o9crzsxk4KqKAuoGlzJtjyO3xu9yOnz6RBGoiTqw
         7PXL0dnzbBRNpxjVcoPt3RQcv5WHBQWab6xIbxrKiRsExZcKufhHgdDTmLoKlOk4gyO0
         F5epYs0O40VwGoOuYQ4OKC82ZHM8AXV1ogczPKRokGGZypFdpePATifX1QkRm5xmRDIq
         Yh+w==
X-Gm-Message-State: AOAM5304/8Fi+3pMV88lwD/Kun8Mu72eL3Ms0006kqrABVy45Gz8NONu
        GLulTbTUhQUGfoP5vPoj4D1fOfVGXtJsCBXa+QY=
X-Google-Smtp-Source: ABdhPJwkDijSIn6hWtPMDrsJ4QAWwfGWcnLe2uW9SlP/RDZ5+t3E7bGR+JH66cPFlp4SNgrRvZI1HhNb3st5+A71aXY=
X-Received: by 2002:a17:906:2f10:: with SMTP id v16mr2454834eji.434.1638313663585;
 Tue, 30 Nov 2021 15:07:43 -0800 (PST)
MIME-Version: 1.0
References: <xmqqzgpm2xrd.fsf@gitster.g>
In-Reply-To: <xmqqzgpm2xrd.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 30 Nov 2021 15:07:32 -0800
Message-ID: <CABPp-BHq4DnkCZZ+HcnGiZYKHpWJgzMBjMDuWbbTFYPesm2sXA@mail.gmail.com>
Subject: ns/tmp-objdir and ns/remerge-diff
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 30, 2021 at 6:49 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> The exception is 'ns/tmp-objdir' and a few topics that depend on it,
> which are kicked out of 'next' to give the base topic a chance to
> lose the two "fixup!" band-aid.  Careful re-reading of the topic by
> somebody with a fresh set of eyes (meaning, everybody, as this has
> been dormant for almost a month) is very much appreciated to move
> things forward.

ns/tmp-objdir had a re-roll that has not been picked up, at [1] --
perhaps because it's an combination of ns/tmp-objdir and
ns/batched-fsync (it'd be nicer to have those two split).  I gave the
ns/tmp-objdir part another read over and was only able to spot two
small things.  I think you should mark it as expecting a reroll based
on [2] ("Good catch. I'll fix this.") and [3] ("I'll take this
suggestion."), but I think it could be merged to next quickly after
that.

[1] https://lore.kernel.org/git/pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/CANQDOddCC7+gGUy1VBxxwvN7ieP+N8mQhbxK2xx6ySqZc6U7-g@mail.gmail.com/
[3] https://lore.kernel.org/git/CANQDOdd7EHUqD_JBdO9ArpvOQYUnU9GSL6EVR7W7XXgNASZyhQ@mail.gmail.com/

>  Also ns/remerge-diff that is Neeraj's rebase of the
> remerge-diff topic needs Elijah's Ack at least.

Mark it as expecting a re-roll; I've been waiting for ns/tmp-objdir to
settle so I can rebase on it.
