Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC34C433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 23:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6E9C2085B
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 23:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AE/WumQ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgFPXJl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 19:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgFPXJl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 19:09:41 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E9AC061573
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 16:09:40 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id t23so117952vkt.5
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 16:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=41Bjmm9ESXQ+8F6kWgJEW49hds67NItjgnOsLd5MEmU=;
        b=AE/WumQ/z68VVcY0GcSO3UDuIvgDB0r2dd1sBZIT88+LFP7GhPpIOUW4SHADXCRxhg
         YrvhdDyYi93j29/QPZ3EbBked/y3ygxOpWBec/hJzgLky3Dmg5rxtZDUY3ua0X6X5Inv
         /HErefuQwBlrFyaVwx5m6+zX/2y5Xw/IQj9cpsEgnKEp9B1K968CgwivKTLWVjObLDER
         9G3AwZqw5FRlkecQPdel7a91hI5cM/Tzfmfej6dXEFADzGtzH80i8bJIJkYNcJ79VEqk
         CXsK4oQ3C9l2kT2YAj+/y33XElFk8+8yPlgNcIoU02EGCSZfSBbs8iPQhHWsixETg5Le
         +Hxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=41Bjmm9ESXQ+8F6kWgJEW49hds67NItjgnOsLd5MEmU=;
        b=lUxIZWMOVMeqmmumWAd4Jx1acc4/yIMhdxKGadgSQlZDzEw2JjR9Zo4kUVQRMmL5/I
         urB4v6n4V+uI3k1sMD2int4qSBhUT0mf+MMNMMLk4JOmGxcKAVEN6ZyjuLdHaWfdYcOz
         Exb8yN9rDV5ZcKkA1j3TieAsgvRJVwZef6Ypnimavs1WHmzy9RDO94PZ/fAKMbxkn6dG
         UaVaA16dkebHUSJiBn29BcZ1J05RVXLxusTeqsUquiVqgAY7LplTG9EXBRDRRxA6raJj
         YAPCUKYFkWDYyRw/LhG/KXm5EAhGXLqP9lJld/vUeBRV0J/mTHN5rQTUxpWSY85kO+dY
         hn7g==
X-Gm-Message-State: AOAM530NmJBe/1gJbrMmkHZG0l7efFpFCK4PH1vZeTsUYrW3psA5ienW
        YOko3p0PuhEGTjSiAS8+kI7FjqvDvuPUSGbu1wMOy1VUsds=
X-Google-Smtp-Source: ABdhPJwZEDfppJBUtKIjAUNDvAbzaO242+hmWQq7z77KLy26ADCFAi5/XhR1137nFtcc/waSj4SOK7Z5uAwaYt9vhN4=
X-Received: by 2002:a1f:b202:: with SMTP id b2mr3757112vkf.86.1592348979517;
 Tue, 16 Jun 2020 16:09:39 -0700 (PDT)
MIME-Version: 1.0
From:   Kaue Doretto Grecchi <kauedg@gmail.com>
Date:   Tue, 16 Jun 2020 20:09:28 -0300
Message-ID: <CAMWmj-xA2f0rT=NZqkR8iE-o4k7=Y20mSev_D_rdmzUfOOeyKA@mail.gmail.com>
Subject: Re: git-for-windows supporting public shaming and repressing
 community's opinion
To:     peff@peff.net
Cc:     git@vger.kernel.org, kauedg@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I agree about the "he did it first" point and that's not what I'm
bringing up here. The discussion is
drifting from the main statement: the git-for-windows maintainers were
biased and blocked (by *selectively* applying the CoC) people who
disagreed on politically motivated changes, to which the community has
clearly manifested against.

> I do notice you've also been blocked from the project.
A very, very disproportional action. Hiding my comment *when it was
made* would be enough. People are allowed to make mistakes and defend
themselves.

> AFAICT the hiding of comments and the blocking of people happened more or less at the same time (from the perspective of the commenters).
> Maintainers of projects aren't reading comments in real-time.
The repo's crew had plenty of time and opportunity to act on bad
behaviour and when they did, it was selective. If a comment goes
against the CoC, it doesn't go against it *after other comments* or
when the debate gets heated. I understand that the timing of the
events can't be clearly demonstrated from a plain-text message but I'm
very sure of what happened there.

> I'm open to the notion that a maintainer is abusing their power and silencing dissent under the guise of the CoC. But I don't really see evidence of that here.
Just consider that the user mlvzk wasn't blocked or banned from the
project. He did not even have his comment deleted, even it suggesting
some nazi-like actions (come on, icons to identify dangerous people?
What about a yellow star?). And his comment wasn't hidden until some
time after people were blocked. I'd be glad to get the list of users
who liked his comment but it's blocked.

Isn't it disproportional, considering that user A suggests an open
witch hunt and user B uses mild "bad language"?


> OK. Thank you for making us aware of your viewpoint. It sounds like there's no specific action you're asking to be taken, so I'll leave it at this response for now.
I think it was clear that the repo's maintainers, or at least one of
them, is willingly ignoring the community's manifestation using the
CoC as muzzle to enforce his/their political beliefs. This is what my
first message is about. There were 490 downvotes on the first issue's
message and 133 "pro" manifestations. The issue should be closed in
respect to the community.

> I'm not sure what you're asking here.
That the git-for-windows team (or member) should be reprehended for
not accepting the community's decision and opinion and being selective
on their bannings. Their (his) actions send a very nasty message to
the community, that, basically, we don't matter in the discussion. And
that it reflects on git's reputation.
