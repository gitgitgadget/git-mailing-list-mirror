Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B60BC433E0
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 06:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0697864EB7
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 06:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhBSGMD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 01:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhBSGLk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 01:11:40 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89918C061756
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 22:11:00 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id d20so4768356oiw.10
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 22:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0hAcd6lkMHocKaEnOdLxqYRkVAZvuzFEIpMcf/WCvaM=;
        b=koRXWVMQhulIlQH2guUXM7xmJVfIcli+2vgVPepVDlCL1aTP/xrqg8Iwg/F8fV88PR
         qXjpp49Vd/i7hrvmsfnFz73MgitHC7Ttpf8FVGhiLY5ur/cyEgS53FlnpZJUuade5YSV
         8XCbpol/9Z6DxLzGi3ebMhJc9yAZ0JPf3U8aziEkJEph9BFqbRF5J5CVh4TrNfR4CjDV
         rJLmmJGEPUz3sStZn0aEFU7LZogYYrhR4jjRuQz+7pnvip03U6GceX9Q/1OehNJQUwe4
         imWiQ6ZVP9ZRCFRPr1cOQJEFKKroigeoS4SYFWGoMcYMu1RYaexkrI4Dxg2ysZ+lAzhT
         ecHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0hAcd6lkMHocKaEnOdLxqYRkVAZvuzFEIpMcf/WCvaM=;
        b=p1tnKY6KQwfjHY2WNGjp2Dz6XWnH2rQJjMQ0s0FKmzYK0PWD1kNu5MfgA7QUp/ASD+
         0UgZ/sHYkKggfdckjclUj4CzOO1qLdZ5eBWdLI7V+DuRoUybHLSIOOA90jDbR5qdcXhG
         LspC30W9LsGrNwlVijWsStUk0BJ3kSZaoZIGhg97fQDeYvkqcVUIUJCRJIqrGQTL4XWq
         LctGARWnzkOqLwgmpUtfELjkY4K73mUtVT2tp6OSPm8iN3iBc94gub3lcxHx2xvCAFaL
         TZ0GW4kryLrWES0kSHyMotJxb2HhaDSxzAeV2pQ2yEaiEYEcglo3C94C+TBQh2X/8Npc
         pWRw==
X-Gm-Message-State: AOAM533yN93U8pn8zCYhTTke4xzt/C+jlolUGzbsYo7AtzM77cKI0qhy
        uNaUaP11FRW/nl2+GJhphKUAx/G2SNUhz5q9EDg=
X-Google-Smtp-Source: ABdhPJz1/Wb3d1wak/lTwS+/sxfWpaf0xEi8lbI3lM4so8lbohsfrTJe0JcxA0xji6eO52J4o5eVFjqxeSU5RjWCU1U=
X-Received: by 2002:a05:6808:aa6:: with SMTP id r6mr5263938oij.163.1613715059960;
 Thu, 18 Feb 2021 22:10:59 -0800 (PST)
MIME-Version: 1.0
References: <20210217072904.16257-1-charvi077@gmail.com> <20210217073725.16656-1-charvi077@gmail.com>
 <20210217073725.16656-2-charvi077@gmail.com> <xmqq35xulbj0.fsf@gitster.g>
 <CAPSFM5ddkALLCU+k+Th=pvKHEaarr_45DSn=N5DCJu1o7_5-Eg@mail.gmail.com>
 <xmqqpn0xfal8.fsf@gitster.g> <xmqqpn0xdse8.fsf@gitster.g>
In-Reply-To: <xmqqpn0xdse8.fsf@gitster.g>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Fri, 19 Feb 2021 11:40:49 +0530
Message-ID: <CAPSFM5dL073pO4mDN=4ca-McFq3za09-J5hjSOpmeUkAMQseNA@mail.gmail.com>
Subject: Re: [PATCH 2/6] commit: add amend suboption to --fixup to create
 amend! commit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 19 Feb 2021 at 02:07, Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> >> ...Thanks, for pointing this out. Also, in the above method for
> >> alnum I think we can initialize an array of alnum[] instead of
> >> alphas[]. Or otherwise I was thinking to instead check:
> >>            if (!isalnum(*c) && *c == ':')
> >
> > Sure a loop is fine, or alnum[] is fine, or just alpha[] is OK, I
> > would think.  Do you foresee you'd need --fixup=chomp124:<commit>?
> > I somehow doubt it.
>
> Having said that, we may regret if we did not include some
> punctuation to allow for a multi-word keyword.  IOW, "alpha plus
> dash" might be a reasonable minimum.
>
> But what keyword --fixup=<keyword>:<commit> can take is entirely
> under our control, so it is not all that unreasonable if we just
> forced our developers some discipline to pick a single-word keyword
> for any of their future enhancements.  It's not like we are opening
> up extensibility to the end-users, who may complain that the way
> they can spell their new <keyword> is too limited.  So if we already
> have alpha[] and/or a helper function that does strspn(alpha) that
> we can reuse elsewhere, I do not think it is worth to try supporting
> punctuation.
>

Oh, yes punctuation is another point. Then for now maybe we can just make the
helper function to check for alpha[] only.

Thanks and Regards,
Charvi
