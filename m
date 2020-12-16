Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E0CC4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 15:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9E79233EA
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 15:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbgLPP2Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 10:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbgLPP2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 10:28:24 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67182C061794
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 07:27:44 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id dk8so25265107edb.1
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 07:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q5IZqVW5JtBYuM4bGDM+AtbEJxbHqkXKIxfEzj2+BKQ=;
        b=mtZWUgi0JTJ4Qsg3KtIcOUBqAY6Y1A4IOrGJhaVoc3PsrxIxGUeg9BcY0F+4MkZNU2
         5Pk9/k9rwhAAydfTCis1F6eq0+sVOMwWlIX1KjwYAys/aSO9zmXvtc3FMpx9RTzJRC/+
         SLmJ6l2b/o0tV1eKtzZ3eRAbnojh9KqH8G71c2NgkP5bOywOyetJZRQty2zCsdSX6NAv
         CqzLfQpEPBNB1xvaQwPtXnlaZ4niyz88OwXShJkdYHZFJAh6dJu7inIe7V9cSyXxoCZX
         j/Z28yz6rDSNhgUdxJKduTzXl9JD1CoS13l6Jk8AlWc3VsGgruWSuOs7n0JAtRWx8yL2
         6I9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q5IZqVW5JtBYuM4bGDM+AtbEJxbHqkXKIxfEzj2+BKQ=;
        b=hTsYQAZMmv9kOVGhIl7s90NHZH6IQSxna8lNP9yFFfJzm3fTMKZnwVA4Dp2ar+NfGw
         BqNIU1MeEbBbSsI3ESXLOClM0kg/Ldx4kfIX0zdricv4mrEOoqnyjBKLqjBsKUQG3reG
         vX+zbFJeRpYF25uTofhEz3UKoZnOqlLSoeDYJ5fRhEL/8es855OFOzweRxFZZ6665iHI
         VW+ska2OfFplKR4AqlE+uAJbVFzwAuhYLPtL/3UA5XIDeEE7yrySOunXoUPAXx3yVLF/
         LxphZKHATm6xmzrUwfeOCbTPdmP7VbMe/e4RgRgjB+/BsigeJHOqgfow4qXKxI6EztMy
         n13A==
X-Gm-Message-State: AOAM530Gmkgl3aD0Nc3TWXM5SPGhOCJDBOpMVm7YkMqvSdiA3HExZlhl
        m/oAWXBck4ODkoCihwq0U14/SlZbazlPcfdo/WA=
X-Google-Smtp-Source: ABdhPJxsAmamEuTeMCLxFWuIZN1drw1hKjS2R3UzqnzE+rdr3xvyVz5bGngkraHFLjhfl8nNp/YYQHJFTWFh5IzDtXg=
X-Received: by 2002:a05:6402:3049:: with SMTP id bu9mr34420762edb.127.1608132463130;
 Wed, 16 Dec 2020 07:27:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604521275.git.matheus.bernardino@usp.br> <cover.1608128666.git.matheus.bernardino@usp.br>
In-Reply-To: <cover.1608128666.git.matheus.bernardino@usp.br>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 16 Dec 2020 16:27:31 +0100
Message-ID: <CAP8UFD1xrJ=bfB0srkMjSFATs6ym5YPokgd5=RE_eA3x6oUQOg@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Parallel Checkout (part I)
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 16, 2020 at 3:50 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> The previous rounds got many great suggestions about patches 1 to 10,
> but not as many comments on the latter patches. Christian commented that
> patches 10 and 11 are too long/complex, making the overall series harder
> to review. So he suggested that I eject patches 10 to 19, and send them
> later in a separated part. This will hopefully make the series easier to
> review and move forward. (I also hope to include a desing doc in part 2
> to make those two bigger patches more digestible.)

Thanks, and yeah, sorry I suggested that privately, but should have
done it on the mailing list.

I actually think that patches 10 and 11 (which each one contains 400+
new lines) in the previous series should be mostly alone in a part 2,
with perhaps a part 3 that would have most of the rest, so
improvements and tests.

It might also be possible to split at least a bit a few things in
patches 10 and 11. For example I think it's ok to add new
configuration in a separate patch even if it's not used yet. It can
just reserve the name. That could be in part  2 then.

> Changes since v4:

From a quick look at the range-diff, it looks good to me!

Thanks,
Christian.
