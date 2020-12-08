Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2E8C433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF88E239ED
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgLHAVQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbgLHAVP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:21:15 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E256C061749
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:20:29 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id z7so14534720wrn.3
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bEIDwH1LlIQ9EE5mnRBE/8sH7YpsgZ1PnUKd2f40CTE=;
        b=LQj4rkqypdADndc//utBks/M9xj/sidUd22G95tkMnTr4YVzKeElc+Vr8gnXij0jxE
         j3+hMzZjeZCuj3h0NYgtFz+CZNMOFn11eKO7iTHckbOtwM6tVnh5qRU9qri/Ld5YhHiI
         AIihIcU3UV26faj77hCiLIQe2cTufb66qK1dOIbHS2wv9oGp05cKq3hJoaXJXyQUFSGK
         wyzqKRtxoCreW3y2t5UigEd6XUa/sJMlQkrfdFpMRg4QGv6S3uZ+wxpZCneCsU9H7zh+
         OAVW20jCF6L8Kw7vXMXQc0Vy9U6H1d8EABiP4PYYfZHj6PUd416GlYkZXdv5WAc7kwzH
         OKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bEIDwH1LlIQ9EE5mnRBE/8sH7YpsgZ1PnUKd2f40CTE=;
        b=SCtaUE42pXwnhveYUBEZrVj1D9LMLhhduAQqrK+RGnTbkg6Z/w/rBf0w8UrEBfFzEB
         BuzA84cUCGofXbqopdT6npJQg2EM6UTc7Njk15vmPYMeGjdWaPcsTDOC8xTXE+dZwmT1
         txjEkbVlubmWqrjoPJ0qo370/dlHu9W+lyBp2cajVu4mzZGyuB9DUjBeRh5X1nV7sq56
         lPHqBQJDaAEOqyvBI4cEz5VR148tgYCmfe07BO0BxKmkjkhZ6qZ+vc4djEpCj5LmJwSq
         t/n3hIxU/YLuaUAf11rLK3kcULu0dZ6N0mKeKAIxwFTEFTakJmj7TPtob6kMi8AYU10t
         cPig==
X-Gm-Message-State: AOAM533ehGzXNgdeV6BWel2y8hKJ/VnDjlp6GG7jOjkKH5TPLCGTHA7b
        M8Rht6d2b33UvZoDbKPtie4HsWne0doh8pnfZzE=
X-Google-Smtp-Source: ABdhPJz90AhrGSyNf1OI8uZGciZBzhNAhZcoXeZHUt8wOBaQpuEHNy9QZ5zQHq20NtAFL1/ddB/spvuZiSuDZ8qWOYk=
X-Received: by 2002:a5d:474f:: with SMTP id o15mr22726524wrs.100.1607386828203;
 Mon, 07 Dec 2020 16:20:28 -0800 (PST)
MIME-Version: 1.0
References: <20201205195313.1557473-1-felipe.contreras@gmail.com>
 <20201205195313.1557473-2-felipe.contreras@gmail.com> <xmqq8sa99wh3.fsf@gitster.c.googlers.com>
 <CAMP44s1ZDXzGfEqpTeiG=aGAYK40ebnBLQKAbA7KGtcePGARfw@mail.gmail.com>
 <CABPp-BEkKMuZHWJ8mrFUFm3okDDsMHeZZNxtGzgq-RLLddMxdw@mail.gmail.com> <xmqqblf58b99.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqblf58b99.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 7 Dec 2020 18:20:17 -0600
Message-ID: <CAMP44s3jmCBaZKM1rEfTA7=HR-gr3TfHK2tH+wACsHwYYWT7iA@mail.gmail.com>
Subject: Re: [PATCH v3 01/16] doc: pull: explain what is a fast-forward
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>, Git <git@vger.kernel.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 7, 2020 at 5:08 PM Junio C Hamano <gitster@pobox.com> wrote:

> I thought that the idea that the word can be used as a verb, after
> discussing advise() messages that tells the users that they can
> "merge, rebase or fast-forward", was given and not something anybody
> needs to be explained about.

I removed that in the latest version, precisely because you can't tell
git pull to resolve a diverging branch situation by doing a
"fast-forward". It's only merge or rebase.

-- 
Felipe Contreras
