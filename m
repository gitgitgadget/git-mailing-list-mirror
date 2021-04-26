Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4405C433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 07:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2902611C0
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 07:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbhDZHIm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 03:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbhDZHHu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 03:07:50 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B58FC061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 00:07:08 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id e7so64310004edu.10
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 00:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8RG/pvYAFeYMZdB1q06OE6NS0QbAHt7DggcpbuARKj0=;
        b=pnFVnjWX9Vuav7ai2lbC+ptcPLtHuSLful9JRpBOEnxyXvKU8k8nyfHoSWrvyafi2X
         UeLwkXf1MMtBDeFz8X9UX+P5jq+DKsy58Sxg53UeGkshGKnQxlYDntFIrg1W4dOSBNU+
         4+F79G+6eoAnXM5/uO3tLGaXoIP1RFOlWlqVF5z8A7tIFJ9n/vjH7gQ/dNRTn1NeYwHa
         g7TOuLvC4C24Y6OBjf9Bhx4vgic4NwWK211VWwfT500HnEurXZS8+hvhe+ptRAWZY8ii
         7fEw+2G4ZF2ucL0hiUPRY/2iw+kgOlxkqj8+GtnSW+e+LcHLv1xyJ2Gpwkm26hBsFcJB
         44Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8RG/pvYAFeYMZdB1q06OE6NS0QbAHt7DggcpbuARKj0=;
        b=ZunQfxm/L/9ETepJ6fxLey3gOh0dpRuF0HqAk8YmUnLPjVy/QScX+FaKe50jn3qwZu
         YwlBrUPcijUF9mAhf6Mxcs6bl/BuqykhyWHzHHBORzOLgt0CV9eYtTB9/MxgQFzSE7w4
         maDTuHe96n3Zaa+yAWHPG7eES805XNgQCc/3/oRpQ/Pjn1z5gcL4OAyAl+tjfUeh7W6Z
         V6Hyart8mOtp8ny8TAC+QGNqQCj1a7h4q22aeUDIBdTEoaciXbzfN3Z5pwd77Xbd75E0
         biameAw31xuU8WdnDEz8uLNkH9SQuO8/XQxhFpuATkDp/cKNq9zHK2vW9VtjxgxZWaLm
         neAw==
X-Gm-Message-State: AOAM532a8b3we7XswwP/qerVYhR0ASNiL+/KAKR8HA9Fmgr15di8JrUO
        EDuAaI67X6ggKrxkqnC2cnUcK9KibvSzg0spW5QdMMclIdxBMA==
X-Google-Smtp-Source: ABdhPJxxj+OcqZnwwdVuRi8bXHf1Kyx6MyLtE3vpLBCx+GfyQpp8d7a/DNpWpEluD773/mtWmFfTenRaqYqg1ghfe3s=
X-Received: by 2002:a05:6402:1255:: with SMTP id l21mr19054227edw.362.1619420827000;
 Mon, 26 Apr 2021 00:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <fd40e12f-9649-1327-4bdb-dce5b5eed619@ramsayjones.plus.com> <473a11db-cbb5-58b9-b05d-cab2072d5d2f@gmail.com>
In-Reply-To: <473a11db-cbb5-58b9-b05d-cab2072d5d2f@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 26 Apr 2021 09:06:55 +0200
Message-ID: <CAP8UFD3hOqeF04Xdjn-o2FShuTPQ9ZUEVCWnhfzCqV6MtbvU4g@mail.gmail.com>
Subject: Re: [PATCH] bisect--helper: use BISECT_TERMS in 'bisect skip' command
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>,
        Trygve Aaberge <trygveaa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 25, 2021 at 10:18 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 25/04/21 07.18, Ramsay Jones wrote:
> >
> > This patch was created directly on top of commit e4c7b33747 and tested
> > with the test from Bagas Sanjaya [1] (ie the second version of the
> > stand-alone test file t6031-*.sh, rather than the newer patch that
> > adds the test to t6030-*.sh). I applied this patch to the current
> > master branch (@311531c9de55) and it also passed the test in [1].

Thanks Ramsay for your patch, it looks good to me!

> I have just sent v2 of t6030 version of my test [1]. Please test
> this patch against that v2 test. And if the test passes (breakage vanished),
> please update the test by do instructions in the FIXME comment lines of [1].

Thanks Bagas for your test! I will take a look at it soon.

My opinion is that it would be best if both patches (Ramsay's and
Bagas') were in the same patch series or even perhaps in the same
commit. If you prefer separate patches, maybe the first one could be
Ramsay's, and the second one Bagas' where indeed the instructions to
replace test_expect_failure with test_expect_success have been
followed.

> > @@ -1129,6 +1129,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
> >               break;
> >       case BISECT_SKIP:
> >               set_terms(&terms, "bad", "good");
> > +             get_terms(&terms);
>
> I'm not fluent in C, but I read these lines above as "ok, we set terms from
> &terms, bad and good as fallback in case the reference is empty; then we get these
> terms from the reference". Wouldn't it makes sense if we can say "get the terms
> from &terms" first, then "set the terms from the reference, if empty use bad
> and good as fallback"?

It might not be the best API for this (or the set_terms() and
get_terms() function could perhaps have better names), but anyway the
current situation is that set_terms(&terms, "bad", "good") is setting
the current terms to "bad"/"good" which is the default, and then
get_terms(&terms) is reading the terms stored in the BISECT_TERMS file
and using that to set the current terms. Also if the BISECT_TERMS file
doesn't exist, then get_terms(&terms) is doing nothing. So it seems to
me that Ramsay's patch is doing the right thing.

If get_terms(&terms) was used before set_terms(&terms, "bad", "good"),
then the current terms would always be "bad"/"good" even if the
BISECT_TERMS file contains valid terms different from "bad"/"good".
