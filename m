Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8C7C49EA5
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 00:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C79B6137D
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 00:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbhFYBAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 21:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhFYBAl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 21:00:41 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9993C061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 17:58:20 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id t8so2130965ybt.10
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 17:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=X7hIfkaSYqVKpRWxWNu/ojSLGJPZSIEe+AUGRKY/whE=;
        b=Hl0SMy5ZdYOk4LN/ckACpEw568lhU6RLuE4UIOCL+WGYFUEPztBzI5oZ8sDElADBjp
         r8HjYj5RoysUZoYmBZy1nm39XhozCm+3MGjJNCx1nlO9HG6PLuIddRXKpt7SQo+yucES
         1rI7MerkJ/5dG0UnVR175Rkbs9Z3xw//z4pz4zK28Vdd1xurk0zfcmNvndAJuOntMX4E
         3VxSc+05CWc5dLdQheziaNcLSppD5H7uBaRGWXmufnkgl9IcuW4sopViVUf1YH7W5avZ
         eFbf3n2ja+GAJSF1VjaNk2Burf/0Adjfg3DC95kpGEE9tO6NAFN1FJZseb5DPwYB0uZC
         JoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=X7hIfkaSYqVKpRWxWNu/ojSLGJPZSIEe+AUGRKY/whE=;
        b=shlU8nlArwqd/D7UaJI3pGj2doqxWVGccpPEgylZEmbDyxz8rOX3JzRcGBI224qVxb
         0CK1RvAkS6uzscS6kcc6oncj00FEle5VRhx2RjhBISbgr9pNaaaKdgaUa5toPpISj49U
         RBw/7G+1Jr1e1JmVm4nm4sR/9e07TS/nfVjPiX6r7NVo37P7DFLYA0m2TG3T8wBt/51j
         ysqB4x6jOlM1qfG/R1x9D5h3EV7lu6YkwKinVFfltU8Z/zfDTuwE+GDZTRROJsPppYfi
         mWL+aMDbtXcGzQW6qxBJq8rKcPp5Z/bAeIpSKfW0d4vPi1FzbN5AI72hrUA1KWmpCEQg
         oevA==
X-Gm-Message-State: AOAM530lCoIwtJTzme+8AAiDxync3lklVThezgGBpN6MLlD6qmi5hNP5
        SKhR8ufUCNemZtx0aN9pN8N8oRtkwL7UWoQSR3c0ZYAf6BJ7Jw==
X-Google-Smtp-Source: ABdhPJwqX4kYrUFsDF/pMJvOAJhcKr1JRbnMZlJBkFojBy+siKXX1iB+eGhn+G/mOKnYDPKscAva7pNvBPMQqLDqcbY=
X-Received: by 2002:a25:f601:: with SMTP id t1mr7833250ybd.81.1624582699950;
 Thu, 24 Jun 2021 17:58:19 -0700 (PDT)
MIME-Version: 1.0
From:   Douglas Leonard <dleonard.dev@gmail.com>
Date:   Fri, 25 Jun 2021 09:58:04 +0900
Message-ID: <CADdMKP8kY-ry4ZWmp1hLCne328cC4thgavbkXOjdaNpD_ockSg@mail.gmail.com>
Subject: Re: subtree split includes unrelated commits
To:     pauli@indel.ch
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I hope I got this reply sent to the right thread.

> I found the issue to be related with the following change in git-subtree.sh:

> > Revision: 933cfeb90b5d03b4096db6d60494a6eedea25d03
> > Author: Dave Ware <davidw@realtimegenomics.com>
> > Date: 15.01.2016 01:41:43
> > Message:
> > contrib/subtree: fix "subtree split" skipped-merge bug

> > 'git subtree split' can incorrectly skip a merge even when both parents
> > act on the subtree, provided the merge results in a tree identical to
> > one of the parents. Fix by copying the merge if at least one parent is
> > non-identical, and the non-identical parent is not an ancestor of the
> > identical parent.

Hmm... I'm not expert on the implementation details of subtree split.
But I wonder if this should have said "if at least one parent is
non-subtree-identical"?  Maybe that's what was meant. I just went
through writing a similar "degenerate  merge" (to adopt the
filter-repo terminology for it) detection for git-alltrees, although
I'm not sure alltrees would handle this particular case to your liking
either.  I think I discard merges if either parent is
subtree-identical to the merge commit, probably keeping only the
matching branch, but I'm not sure that's always true, and that's
there, not here.

Cheers,
Doug
