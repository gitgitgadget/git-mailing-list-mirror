Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3819C48BE5
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 12:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6F43610CA
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 12:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhFQMlR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 08:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbhFQMkt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 08:40:49 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC840C06175F
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 05:38:35 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id r16so6373869oiw.3
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 05:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qdwknwjx3CRfgkKOUkgxtq+CMeIy7ilDbE27kyg9Dec=;
        b=l9+yxhh8FkXgRv5cMaLGIByfP3O4UeJjhnAOqq+Wg7EcpjnRC+bNVKW7lcD5cYPCly
         nhrS82fER8KoJhiyC8Jo6HiaXBbV0Kse+BlAuT+x0s13dSTAzfWA3r5iyOGfHhtjLLqq
         h8sIVbFCMF2XNv9VZGGLsNv4ZS5dO+p5h/HbTrd7jZNkWEqgbaCluv2so3wgl/VD+VrK
         5vXv6pTqXhNxtc18SHLuwTeAJTaG0OG9HVcDyBuuHKdporGQzvV6/wUpDIfToCiE7QSp
         Q4UnjVIpD+RopuLyl97bV+vvaL+oCpMrccRsOK1o2Y0fhcMgvXe6AUMgIgHBZHLpMyeJ
         L9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qdwknwjx3CRfgkKOUkgxtq+CMeIy7ilDbE27kyg9Dec=;
        b=XaX6iR/GT8qI/Skz8NOm3h1nGIH1vwDoDHX+C27AeqE0Wfgzq3Bcn2GK2nGmw7lo9B
         OfJr1hzp9dJYdexwSsvJ6+6lkRHRmvFN3ZOyY5tRm997dFCiiYAHB2DSh1c8GUitSanH
         MCTyCKRhVfpH+Qjw9yOAqOdirRHVy0NX3cxai1zG7b/FphuR8fsh4kzr/KW7a/1Z3JU1
         2r+LSBOZviSKjilEeQyo6kNMhAvDdO1tJLfFsV9yUt4fI8P0zoaRpmguMavgmaN8ODsA
         TjLDYk7ydxKD/XSzlTcPgRNivbLhDl3UnalLHavp8rE7eh47cp8MYBEV8Z+AlzUYXRq+
         II+Q==
X-Gm-Message-State: AOAM530IEPBtXfWYoEwIvntpYGuGpYx7dM5Ep6waKo8P/b1WXlR9aV1J
        rsHyaZNSSgN9MuKD3n92YOvQpcfXyM8iX05j0CQ=
X-Google-Smtp-Source: ABdhPJx5s9q57yxtovElB5lO81lUamw6bx8AcTEcxYWVaK6dxrtN2WiI7fvl4xq81bWLwFedIg4R+Yyd7poU/o4ZZ7o=
X-Received: by 2002:aca:f482:: with SMTP id s124mr10351398oih.167.1623933515340;
 Thu, 17 Jun 2021 05:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqr1h1mc81.fsf@gitster.g>
In-Reply-To: <xmqqr1h1mc81.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 17 Jun 2021 05:38:24 -0700
Message-ID: <CABPp-BG53Kd7MhzE3hdq5fjBQVV2Ew3skcUCAuTfM5daP2wmZA@mail.gmail.com>
Subject: Contributions which I feel are dangerous and/or deceptive (Was: Re:
 What's cooking in git.git (Jun 2021, #06; Thu, 17))
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I hate doing this, but...

On Wed, Jun 16, 2021 at 7:58 PM Junio C Hamano <gitster@pobox.com> wrote:

> * fc/pull-cleanups (2021-06-15) 3 commits
>  - pull: trivial whitespace style fix
>  - pull: trivial cleanup
>  - pull: cleanup autostash check
>
>  Code cleanup.
>
>  Will merge to 'next'.

Please don't.

Let me quote from four recent emails, three of which will look
unrelated at first, and then I'll tie it together:

From https://lore.kernel.org/git/CABPp-BGrKjpjb5epv1nXcvn4Z1OHP4Uf6G1f9FARmwUcFVa96Q@mail.gmail.com/
:
(a quote of mine to Felipe)
"""
You clearly have talent.
With regards to the zdiff3 patches, I've stated above why I think you
haven't done your due diligence.  Sometimes people make mistakes;
that's something that can be corrected.  What I find egregious here is
that even when Peff and I have pointed out how more due diligence is
expected and needed, you've dug in to explain why you think your
course of action was reasonable (both here and in
https://lore.kernel.org/git/60c82a622ae66_e5292087f@natae.notmuch/).
That in my mind raises your submissions from careless to glaringly
cavalier.  Further, it makes me suspect we may continue to see you
repeat such behavior.  That worries me.
"""

From https://lore.kernel.org/git/CABPp-BEXtJtkkh9Diuo4e1K1ci=vggGxkLRDfkpOH12LM8TCfA@mail.gmail.com/
:
(another quote of mine to Felipe)
"""
...you
are willing to eschew what I view as even the most basic of
responsibilities in ensuring you are submitting valid patches, and
even worse, you are unwilling to change how you approach the project
even when those are pointed out to you.
"""

From https://lore.kernel.org/git/YMhx2BFlwUxZ2aFJ@coredump.intra.peff.net/ :
(a quote from Peff to Felipe)
"""
But much more important, in my opinion: that you would dismiss without
further investigation a report of a bug from the one person who actually
had experience running with the patch implies a level of carelessness
that I'm not comfortable with for the project.

I had already given up on having substantive discussion with you, but I
had hoped I could help the project by pointing out relevant facts in
areas that you were working in. But if a simple statement like "this
segfaulted for me" is not even useful, then I don't see much point in
communicating with you at all.
"""

From https://lore.kernel.org/git/60c887f678c88_e63320846@natae.notmuch/ :
(a quote from Felipe responding to me)
"""
> * `Reviewed-by:`, unlike the other tags, can only be offered by the
>   reviewer and means that she is completely satisfied that the patch
>   is ready for application.  It is usually offered only after a
>   detailed review.

Yeah, I read that after I sent v3. In this series I simply cherry-picked
it from a previous series.
"""

The first three quotes highlight what I feel is a reckless submission
from Felipe; from the threads you can read in the linked messages, I
believe he sees no problems in his approach and appears intent to
continue that course in the future.

But the fourth raises the alarm levels for me further.  In the fourth
quote, Felipe admits to having learned what "Reviewed-by" meant, then
cherry-picked a patch of his own with an inappropriate Reviewed-by and
resubmitted it anyway.  And he did not resubmit the series with the
error corrected when it was raised to his attention.  That feels
deceptive to me.

If I were in charge, at this point I would drop all of Felipe's
patches on the floor (not just the ones from these threads), and not
accept any further ones.  I am not in charge, though, and you have
more patience than me.  But I will not be reviewing or responding to
Felipe's patches further.  Please do not trust future submissions from
him that have an "Acked-by" or "Reviewed-by" from me, including
resubmissions of past patches.

I will allow Felipe to have the last word if he so chooses; I won't
respond further.
