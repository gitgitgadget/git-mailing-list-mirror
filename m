Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D19C433E1
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 07:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38E6B20786
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 07:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfCEZZ4l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgH0Hrg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgH0Hr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 03:47:28 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D66CC061264
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 00:47:27 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id m22so5328744ljj.5
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 00:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=j/lnWg2zqvlkLTwyUJ7mVB/Zk9YIuRNPiIV/vU8872g=;
        b=dfCEZZ4lQz6D9hs+tUFFGwCrYcYSCRsSP9uLq9hhZbxA19wq8jM325/W6fy/3Yhv2/
         VHt9LiNebwt4GppnBVQ9WINxdJWEu6Nott2KJNQqfKVFLktSiKEqA4kS7OjnxIYddFwM
         40LLTHfXpnwsKrq6IVqy+TS85X2t2EttjOtJwhmJRS2vDBenXWVdIa1os5aRskFLsJoJ
         jezVRb2fUOTCZVS5ZWUQLbSJRHzCSLZ4qAVNFrwRepawj+l7APUrjtNXkHSRm7l4CVU1
         VPkSzGC4R6l8ToBVdBFSDaib8/No1K7RQVVFgvMHsw8SjxB24YKCHhFOj/sSvK+ySCRV
         0n1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=j/lnWg2zqvlkLTwyUJ7mVB/Zk9YIuRNPiIV/vU8872g=;
        b=W6UvBN36Gic0LMg0Zm4PNeHH3Jeg1WJzspdOeXjMFZLL0vDYR3uiJzhoprWUdJiF5H
         GCnktXsmZJK5KXLMR8rlP7Okka37xjLcMpRP3SdYP2/wsM1dkqJKCcZ8Dnt2ySmfD0Uz
         lDPwujZX0/k6XaTCJOmULDdwCaNRtDs+7GMN+0gyzRpfoAB9j0sBrgY9byMwhp19fHmj
         Khyt/vBYMYvwXjM4H/teCMULB5Bc7lnKQM9HUU6FdMMIzEK4egYhS04bC6ktWxpt1hcS
         y8jc7UuUH4kIO+J6xUGUTn2kcSfDLtSbaAo6xzWVuKYWQOejN2inUUUAjhARcnUW6oEl
         upag==
X-Gm-Message-State: AOAM530We819mVoqQ3wFiCP9Iko4wKAcxKrf2XOu9mhmYBEXHxttk06K
        wWG20/Wad1WSVoCFIlwZFfjuBQk+d0gSt91dEwrTHYs8DG4F4XQP
X-Google-Smtp-Source: ABdhPJxkEk97wd1izST5g9Q/KMXH0Abdey7EODp5eJMxaV5sWEtwB5GLGLcF2OpHX/nbUVjd9DZe4MsLCF/reOMCi6E=
X-Received: by 2002:a2e:9dca:: with SMTP id x10mr8492737ljj.396.1598514445235;
 Thu, 27 Aug 2020 00:47:25 -0700 (PDT)
MIME-Version: 1.0
From:   Toni Brkic <brkict@gmail.com>
Date:   Thu, 27 Aug 2020 09:47:13 +0200
Message-ID: <CAF2SHyBYZ7=vcL4sPdP=T9zRCBrwW_z0-o1v9=gC4=oPqv4oXQ@mail.gmail.com>
Subject: feature request - add --only-author option to git push
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry if this mail list is not used for feature requests/discussions.
This was the best list I found.
Let me know if should post it somewhere else.

I would like to be able to configure git so that when doing git push
git checks that I am author of
all patches that are being pushed. If I am not authour it should not do push.

The reason for this is that a common mistake that happens when working
with gerrit (at least for me)

Person A has uploaded patch1
I need patch1 to continue development and cherry pick it to my repo.
Person A uploads new version of patch1
I have finished my patch and push to gerrit. What then happens is that
I have an older version of patch1 and thus overwrite the new version
by Person A

Maybe there is some way already to do this, but I could not find
anything when searching.

BR,

Toni
