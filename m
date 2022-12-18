Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497BAC4332F
	for <git@archiver.kernel.org>; Sun, 18 Dec 2022 03:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiLRDKh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 22:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLRDKf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 22:10:35 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948C3633C
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 19:10:34 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id t2so5975504ply.2
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 19:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PjaVC/dSfQ60Z0IU8/dOI30BKuDtIZix4KKBR29cx8A=;
        b=layDyvq8lDSv8g1B1xruPKqYyvn9q1t/UdDg/2NbrnWqvJgdOJb3DmacBk0ywud6LN
         9Lm44M8zj3ZCeI5e3cKD1oztt5/ykwMEJn0JjAnIqAzwXUf3/heJ0Au9OZLD2h38/rju
         2vrT0EpV3aRh2GDb4DNIYb82lIej4TWseyIusBA2N2DTAbMT4mklynBZ4KGiZNf40UoZ
         QBRjxSFFUDURMTKpCMa0QdgntmR+KWEJw5iSy48BCnODCLiq3ps97FVwSBpSvtWV9/m5
         2QQpk/7JBPNiGSAuaKXm7+HbtJfV7K+WaXRI9jXpa1rlgGG+794CzPmEOZBHQSj5cIaN
         ovbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PjaVC/dSfQ60Z0IU8/dOI30BKuDtIZix4KKBR29cx8A=;
        b=wGT0YJ4YOC+aVNsfKRsANqyqFwWpMF5++wCwFC1oFBFktFBnbO09KXzlt3Ynnqxae4
         HFElTZZ/RJogHH8q7Lx9IKnCgwNUrQuEwMLu/l6ZtSpTkjgP7ykNHvRbS+wBdZpK+IAU
         n1AQny13oKGyeWONf0+8Z41gQavy1Eqo+Pn8HTrpeTzXh90HFHDqd1cWYXMdXl++6nuR
         FaQ7idMgNuUkNRj5V5Y3njqNmWLcrnt23zBCODclTHcauxl+k11t0SpadFhBV4NECANi
         QXFBCm9OhbelakTJa9MMY9FS/uN14A/9FdHcQnal9lGDoBsJ/0nm0caSyOw2wTGlmWcv
         QmSA==
X-Gm-Message-State: ANoB5pko/FsfEHp8tEtOR7ZrUnbXearrvrVscAJVUDeWg9Jx1iy7/Hay
        oNNzRc68n1LRiy1LiEJY04I=
X-Google-Smtp-Source: AA0mqf7Ak1aETPSX53Q9Nz4D8+PSfSFf2aWIuHu55v+WOITsfRDPmck2yb2wu+3fqEMDNY3+uwuh6Q==
X-Received: by 2002:a17:902:ce07:b0:180:f32c:7501 with SMTP id k7-20020a170902ce0700b00180f32c7501mr39023186plg.0.1671333033823;
        Sat, 17 Dec 2022 19:10:33 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902da8500b00188fdae6e0esm4254151plx.44.2022.12.17.19.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 19:10:33 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>,
        Glen Choo <chooglen@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v1 0/5] diff-merges: more features to fix '-m'
References: <kl6lilimepli.fsf@chooglen-macbookpro.roam.corp.google.com>
        <20221217132955.108542-1-sorganov@gmail.com>
Date:   Sun, 18 Dec 2022 12:10:33 +0900
In-Reply-To: <20221217132955.108542-1-sorganov@gmail.com> (Sergey Organov's
        message of "Sat, 17 Dec 2022 16:29:50 +0300")
Message-ID: <xmqqbko1xv86.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> The last attempt to fix '-m' option for "git log" to imply '-p', to
> make it consistent with similar options (-c/--cc), was called by the
> request on the mailing list, here:

In retrospect, this old attempt may probably shouldn't have been
done, as there wasn't really a compelling need to change the
behaviour of "-m".  The "combined diff" options were "if specified,
give output" from day one, unlike "-m" which was "modify the
behaviour of '-p' if given" for a long time.  Changing any
established behaviour risks breaking the exising users and the
upside must outweigh the risk.  There wasn't overwhelming upside
back then to risk, and of course it backfired, ...

> However, the suggested (and accepted at first) patch series:
>
> https://lore.kernel.org/git/20210520214703.27323-11-sorganov@gmail.com/#t
>
> appeared to have two problems:
>
> * --diff-merges options are incomplete and have no way to provide
>   exact existing '-m' semantics.
>
> * implying '-p' by '-m' by default broke some legacy uses of
>   "git log --firt-parent -m".

... like so.  Without learning from the experience, we may repeat
doing the same thing over and over and expecting different outcome,
but it would not give us a very good end-user experience if it
breaks them every time we try doing that.

> Due to this, the last patch of those patch series has been later
> reverted:
>
> https://lore.kernel.org/git/YQyUM2uZdFBX8G0r@google.com/
>
> effectively leaving the issue unresolved.

Fairly accurate description.

These patches do look like a good approach to solve the first point
among the "two problems" in the previous round. Thanks for working
on it.

IIRC, the previous round (why is this round marked as v1, by the
way?) was reviewed by some folks, so lets wait to hear from them
how this round does better.

Unfortunately, I do not think of any "solution" that would avoid
breaking folks, if its end goal is to flip the default, either by
hardcoding or with a configuration variable.  IOW, the other one
among the "two problems" in the previous round sounds unsolvable.
We should question if it was really an "issue" worth "resolving",
though.
