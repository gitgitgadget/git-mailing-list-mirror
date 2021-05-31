Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6E4C47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 925876124C
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbhEaRu1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 13:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbhEaRtr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 13:49:47 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE5BC061375
        for <git@vger.kernel.org>; Mon, 31 May 2021 10:31:27 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id j1so5156463oie.6
        for <git@vger.kernel.org>; Mon, 31 May 2021 10:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=++A5kE9NcT6NhlyBg4hou9SVFcsGvsvk+uoJMH4iAQI=;
        b=HWVGbuIAho5sD1oXHCHEfNrEy8zpx7USpTycPDWZtPdLqdSpKLO6WCfiCL8Gdmv4tT
         y+2nbpEb3UXgvpMt2K3MVZ4P0bpJnEicrKmfw3cQ5/uZAFmx3QWC23ntarQ0qkqFYNuY
         hZ230cy8GwyHCoOlmEE44c1jmLjvSEmwoMLjXiGUkTpkE0Y6yoTg786eVmkpIjXoAfvV
         /gx+H/Q69CPVqLFWSw90PAI4P8H4TDBLk1KbbP3uMtVqDKEszYdLZ8ZuMkPA0w/sgp2M
         YbhrXvTh4/C141On3Gtw56CKSlNVy//cKo/sxRsUZtRQsIG5zIwgIMsa57NX4WitAtIF
         aieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=++A5kE9NcT6NhlyBg4hou9SVFcsGvsvk+uoJMH4iAQI=;
        b=JAiZOmiuPRWM0LNzU0Sa/J/3UnjRW0nn2UKUwZF98sPXnutPRqzCfyfoa8N6K++eLt
         f3hmGIP+ZEuYui5r12uCNjd20LPPicRUwP9d9AOj7c1r6qw3YTYhQFeDuzgSY7oSInU1
         Lfg9F4NMK5KPYQjNSJYeP0PdupxB0MDsVzBrom4aSVIhJb26CiD8sJPi6YXJRR4jn0Hp
         nVyvikgaDBZObwQXCVWkMVZJJQ2DusScr7rcwMDqJqOAy5uUiHppgb6UmW5AnE7OzLBX
         CdqzqTdyvGY356lm4/w9H10nNYHNJrdlvvZlbudc1PlU7O+KcipxYpKWhGMbDwo8zd5I
         i58w==
X-Gm-Message-State: AOAM532HQSqXXUH1SSA0McgoOQYfeMU4ctvxLJnI4HzaBlWYZ8+Lu6YY
        arCooQWprdizKp8XgjkAGrU=
X-Google-Smtp-Source: ABdhPJzWJJ719g8vSIbP3uiyKU77AkT54BQddje+KEcg1Z/4t3wVRefgq5rQUO5f7zASyRGWpf5Fhg==
X-Received: by 2002:aca:3704:: with SMTP id e4mr144309oia.154.1622482286354;
        Mon, 31 May 2021 10:31:26 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id s24sm2924408ooh.28.2021.05.31.10.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 10:31:25 -0700 (PDT)
Date:   Mon, 31 May 2021 12:31:24 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Mathias Kunter <mathiaskunter@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60b51d6c93c7d_279c820856@natae.notmuch>
In-Reply-To: <5fa7e3f4-60a0-c3b1-83f2-054ed38e5683@gmail.com>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
 <20210529071115.1908310-7-felipe.contreras@gmail.com>
 <acfafe6e-b0f3-ba2e-71f0-9bcc09b9d612@gmail.com>
 <60b3e2ceee840_ee4c20823@natae.notmuch>
 <3e5c2303-030e-928e-af57-8e2be8f3ce86@gmail.com>
 <60b4fd4db5dee_24d282088c@natae.notmuch>
 <5fa7e3f4-60a0-c3b1-83f2-054ed38e5683@gmail.com>
Subject: Re: [PATCH v2 6/6] doc: push: explain default=simple correctly
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mathias Kunter wrote:
> Am 31.05.21 um 17:14 schrieb Felipe Contreras:
> >> In your above example, I'm in centralized workflow, but I can still push
> >> the fix-1 branch to origin without having to configure an upstream
> >> branch for it.
> > 
> > No, you can't:
> > 
> >    % git push
> >    fatal: The current branch fix-1 has no upstream branch.
> >    To push the current branch and set the remote as upstream, use
> > 
> >        git push --set-upstream origin fix-1
> > 
> > Isn't that problem the one you originally described [1]?
> 
> It is.
> 
> > Maybe you are thinking this patch series implements the fix I proposed:
> > it doesn't.
> 
> Yes, I thought so. Sorry for the confusion. When I asked "will your 
> provided patch fix these failing push commands" you answered "It's not 
> really a patch (yet), but yeah: it will". So that's why I thought so.

I have not yet sent the patch to change the current behavior.

First I sent a bunch of patches to reorganize the code so it's more
clear what it's actually doing.

Once those patches are merged, then I will probably send the one to
change the behavior.

I will include you in the Cc list when I do so.

> My point simply is: For the sake of easiness of use, I think the 
> following should work with the default settings of git:
> 
>     git clone $url
>     git checkout -b fix-1
>     # do commits
>     git push           # should push to origin/fix-1
>     # others push to origin/fix-1 (but no local changes)
>     git pull           # should pull from origin/fix-1

I agree.

> Will this be implemented?

It's hard do say, but it probably won't.

All my suggestions for improvement are mostly disregarded, and
considering *nobody* has said a word about whether or not the current
behavior makes sense, I don't think there are very good chances of
changing it.

Consider my last mail "git push default doesn't make sense" [1]: nobody
replied.

But maybe that's my fault, because even though I broke the In-Reply-To
in order to start a new thread, it seems mail handling software still
uses References (incorrectly IMO).

So maybe if I start a new thread completely fresh people will notice,
and reply.

I will do so with a patch once I'm done with the reorganization.


In my experience you need to convince either Junio Hamano, or Jeff King
for any change in behavior to happen, and until they do comment on this
one it's fair to say it won't happen.

Cheers.

[1] https://lore.kernel.org/git/60b15cd2c4136_2183bc20893@natae.notmuch/

-- 
Felipe Contreras
