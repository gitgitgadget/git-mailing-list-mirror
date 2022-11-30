Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E931BC433FE
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 18:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiK3SPh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 13:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiK3SPQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 13:15:16 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE7E89AFB
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 10:14:08 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id pa16-20020a17090b265000b0020a71040b4cso12258535pjb.6
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 10:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NNgyT7wDd+re+gcmJny1WO1kb0PLP9BW/CoQKAnnq9Y=;
        b=fcXE3U3W/kmO99yGTrF+OUFSnYoPQqj0cobXvNp0A18E59wV7wNGkaiWiFvsDOEVLe
         xld51AGqUSRT95lVk5VoLzQ5QfpC8JmdmEuYEcqN6P0Neal9HF4sc8Igzvz1AGcxPOYW
         EzzTMjm1yuMYvwLAIBQKkZWPEaAEXvyH0wd15TXFKIXwusZ8SpQG4eaUcxd6qGNKSfHZ
         go3dQNoBDMuEcBRQPLkV0NOmCZ8beK3q9BW2tyWB8UG4hUabkHOXRkXGvrY359Ce6qro
         rFMZslD+uctTc5+6JsgN8k/csDCPazs/NXY5b/snIEriyV/hHBVUssdyMPV7WLSwGb45
         p8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NNgyT7wDd+re+gcmJny1WO1kb0PLP9BW/CoQKAnnq9Y=;
        b=H3wtEh0RlNesEmOgMD1Y0WLy4bXUoYj+F9zeCaexh+7oy7Qa25rIfBmuwXl8cq8Mgf
         3au+d+Ah2ihV0l1ZXZasdrpXw/siHQyFyT/+6iujMty839qaVvIpR18lSpTjJ9SAYRoD
         h+vUpL8jqKk+Jgi8QhdQzSqut1MRBHCINFESoOs+jlEw+CN93sqqQ1EXrp0dqRgolZKc
         1vmwDZbhWSlodP+3ikAg9LRJ2dFSqBsrEjqPUW0S25j82N0wuqhaG0nj8DgLGSKke8iq
         bKlwTN2D1RHHo+tqGWfKJ24gmP9J7O8YG94v/iFVBKXo8wNFI0JVXryYfbr9vjfR0oIv
         X36w==
X-Gm-Message-State: ANoB5pnBoAmIifGSynIZx19HgBSY6zpLygYRLWBZ7t2ZbQGWuJp732jm
        xo961XDnSnuHeKcd3pRt4ILmPl5yY9ZXvw==
X-Google-Smtp-Source: AA0mqf542SPEEYs3Hmwu6uz4jo2xj0LTfGsxO92jJsenHWwHdbbkWtb/XiOm4ut+NseflIOrb35yzgpfAjs6XA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:bf06:b0:17b:d6ad:94c8 with SMTP
 id bi6-20020a170902bf0600b0017bd6ad94c8mr57166522plb.110.1669832047561; Wed,
 30 Nov 2022 10:14:07 -0800 (PST)
Date:   Wed, 30 Nov 2022 10:14:05 -0800
In-Reply-To: <xmqqilix150o.fsf@gitster.g>
Mime-Version: 1.0
References: <xmqqsfi22j67.fsf@gitster.g> <kl6lsfi1d1tf.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqilix150o.fsf@gitster.g>
Message-ID: <kl6lh6ygqphu.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: ab/remove--super-prefix and -rc0 (was What's cooking in git.git
 (Nov 2022, #07; Tue, 29))
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> Hm, it looks like ab/remove--super-prefix missed the preview release..
>> Per the discussion ending at [1] I think my one-patch fix to "git
>> fetch" [2] should have made it into the release (it's pretty low-risk
>> and doesn't introduce too much churn to ab/remove--super-prefix). Is it
>> too late for that?
>
> Nobody seemed to have commented on [2].  Is this fixing recent
> regressions, or is it more like addressing an "if it hurts, do not
> do it then" problem?

=C3=86var did comment on the patch in [2], but unfortunately it happened on
the thread ending at [1] (and others), so it's not easy to follow.

It's solidly in the latter category. I don't think this has ever worked.
c.f. https://lore.kernel.org/git/kl6lsfiivcau.fsf@chooglen-macbookpro.roam.=
corp.google.com/

> The fact alone that these questions need to be asked _now_ is a good
> indication that it is way too late for this cycle, I would have to
> say.

At any rate, we shouldn't be rushing review, so this is fair (though
unfortunate). Let's continue counting on ab/remove--super-prefix and
ignoring my one patch, then.

>
> Thanks.
