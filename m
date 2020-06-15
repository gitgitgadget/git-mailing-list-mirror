Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F9FC433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 22:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54034207DD
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 22:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1g0Hwnm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgFOWiU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgFOWiU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 18:38:20 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0560BC08C5C2
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 15:38:20 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id m2so14422281otr.12
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 15:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G1/asHjwgrWqR5W0bcMtll10mwaK3M1q37HK0aB3jKk=;
        b=P1g0HwnmRbXOwhdQeyJswvIQ8bsDCn5Usvt12wD4VM2NL3AQJagSZsL/qLYrZXt+7l
         CLDNECRLyI5CSzy0ZQW6B+NlloQW2X3b5/GxsVWocHQO7CaSwW0OczVdL9N1Fm0oNgmg
         cqCc2rsCWglvHGfTlT2BfCVWAFMv7ZkKtaEU2akZvK+Msnb4nrblc449YNHLNvy/pk+m
         IjWqHehiodugzyQRSP1N5p5c9fbEO8I8h+o7IKau84fP+X26icv98vN5KisicO6Kxyd0
         w+h6q/M8EJjc64sRz98dDW22y8nDLLtjzPzpeMAzssfdfHC/p4QzPFhXHNdEWK/3i/Yi
         rn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G1/asHjwgrWqR5W0bcMtll10mwaK3M1q37HK0aB3jKk=;
        b=P6EdSmNIfBXciPNxbv0O/vBYqDHYOGJmjVEuDJB6dO7GMRZe/64nqubY7kAvoB/LSU
         BPIUp8RM5/YJgfSZi9cfkeUlZkFT5H18HL3TU+pzmAJN7L2NkoNZhs+qXh/FJjtROhq/
         fOG8VZ8xrmj873ZpyFZBzlCYfnXdJFFD4dNoRQuMoxTPAexqLLjg/Jv9EV3UHmiCHI5G
         3/7fFj+fQkWoMNjHgQkZKynYfZFVdHnAYfpY+Qghm1smlXUsv7qxYKxvalWZsGk1AwxO
         kHN/iPr/cs5aesrbUfoYYjmspY/ooFk6IcfP749mYKVmM2urrxNyBHUheJP7CxrjOVqp
         oOYg==
X-Gm-Message-State: AOAM533beNxRneFr6w2qJbJNPu7tA2VJ+yWm7+07lLLJbUvwkZclSBw6
        oblKqbuEq2+HbSbZ7LX40cEXyBQ6gZvw/ZnC2fI=
X-Google-Smtp-Source: ABdhPJwshzzeQYaeotR/aBx65C/qI3yY/pOJarQuhHf7VA7KFoOeAx4ve33dZUHe7u9wA8xYK1D/YzruF7FAPsjukkw=
X-Received: by 2002:a9d:6c07:: with SMTP id f7mr160446otq.345.1592260699178;
 Mon, 15 Jun 2020 15:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200615205722.GG71506@syl.local>
In-Reply-To: <20200615205722.GG71506@syl.local>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 15 Jun 2020 15:38:08 -0700
Message-ID: <CABPp-BE3UAeMKCtwnTf-5ifVhveRPzQfT1T+sHsm_LDOubCHCQ@mail.gmail.com>
Subject: Re: Consensus on a new default branch name
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        James Ramsay <jramsay.com.au@syl.local>,
        Bryan Turner <bturner@atlassian.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 15, 2020 at 2:01 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> So, I would like to form some consensus here as to what the new name should be,
> if that is something we're committing to doing. This way, we can make this
> decision now (and allow hosts to make their corresponding changes) while still
> giving us on the list some time to work on the implementation across one or
> more release boundaries.
>
> My interpretation thus far is that 'main' is the planned replacement for
> 'master'. Consensus seems to have formed around this name [5], but if that's
> incorrect--or there are yet-unvoiced opinions that you would like to share--now
> is the time to discuss further.

As I stated in the other thread[1], I'm happy 'default' isn't winning
because I think it can lead to ambiguity about the meaning of the
phrase "default branch" (particularly when someone changes HEAD on the
server to point to anything other than "refs/heads/default").  I don't
think "main branch" poses similar issues, as it's not a phrase I've
seen used that much (in contrast to "default branch").  Also,
"default" being ambiguous bothers me personally more than other terms
being ambiguous, as per my story in the other thread.  However, it's
possible that there is documentation or guides somewhere that have
used "main branch" in the past and could become ambiguous with the
proposed change, and thus would benefit from updates.

In fact, just to verify, I did a quick search of the git codebase and
found 38 uses of "default branch".  There were also 9 uses of "main
branch", but almost all of those were actually referring to a CVS
repository and importing from there which I find innocuous.  There was
one in git-log.txt that looked problematic to me, though -- it should
probably be reworded when we do the master->main renaming.

Hope that helps,
Elijah

[1] https://lore.kernel.org/git/CABPp-BF8vo_fCbM1ct0MYFhQcVmPwfq7_Q3Fd+SnM0=gVmxkrQ@mail.gmail.com/
