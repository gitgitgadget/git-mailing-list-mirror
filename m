Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668F7C001B0
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 20:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbjHKUwB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 16:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236851AbjHKUv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 16:51:58 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF28A30FD
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 13:51:54 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-686baf1c2fbso3230308b3a.0
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 13:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691787114; x=1692391914;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eqEkMal/hcFaE1PBtHTaDtblD9N4piun8nhy2n96KN4=;
        b=gBQxFX/3F0bNGs8xu4QuaauDVr6yAQPzSHtrvMHZS9cN99AJnylxHZ88sDyI+CHf/Y
         5aIh8+in7lPBb3eVQp/kIh16n8sSlKjXJIxUvd+v2TvbLeSsbf9+wPMN8bBTfTt6epyJ
         yrByOwf1QD1FOk7OaQhAq3f07L5fsrtyFyEN/sbHxkP5aLlB8ED1/4Ugn1GPH2BzZOhM
         O8yZDqWBIFQV25wImmYvAdr2/RRumvJgw6cT7qktEABKfGC52tJkRZckrDBERerA7Wj1
         WSEcugSf/iQAGewxnkq52cRQ/CujIaS5kzBqCTkVIigGHQOYt4N3Q5xe3BGhIJ2RqQ2l
         iR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691787114; x=1692391914;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eqEkMal/hcFaE1PBtHTaDtblD9N4piun8nhy2n96KN4=;
        b=KyvX7XcZIR0iclrsZySz4MjsGb3TcL+kXTzN7eu0Gcfc6zdaJZ7U0TBf7hi/UmgTF3
         7Uz8EgqLG6pnsmHk9Hovl43vaScwqmbYm5FKGyTF0hn7rl9Eybug5bkv4BLtcmmGbUVu
         l53KFeIjE6aSEwWZsUjV+4BwcrVXxAcoO05n/i12UYsAjmbxu8QYytlEyuzGT3azF/Li
         ARrslcGt8zPqNUB92YFoGXGygCTWv0XwKES4qIguMm78QzkVLOEouYfQ8HvvDl6p/It5
         mIc5L5jFmXJEFbahsQh4LNRIdW0yTsNE2R8YsSYaE3wVGBps4RKv8Wvi8r+tWeZyQd85
         Dh7g==
X-Gm-Message-State: AOJu0YwANIcIb3hCyfbHBMQZ8ZucwJEkGVblfe77Q/lFEEUMv1SwbNFX
        55rA/5H5LddZDHR08RSY3tdU5DD4vSVPSA==
X-Google-Smtp-Source: AGHT+IFxkKc4Y/LSC4WrMyZa+7948QYMqu65yS3H/SP9H+v7D9QVwrP7rZEhEXB3sS2Dej+/7wjxKabQEd871w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1ad3:b0:678:e0b1:7f28 with SMTP
 id f19-20020a056a001ad300b00678e0b17f28mr1194512pfv.6.1691787114421; Fri, 11
 Aug 2023 13:51:54 -0700 (PDT)
Date:   Fri, 11 Aug 2023 13:51:45 -0700
In-Reply-To: <owlyjzu2fjz9.fsf@fine.c.googlers.com>
Mime-Version: 1.0
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
 <1fc060041db11b3df881cb2c7bd60630dc011a15.1691211879.git.gitgitgadget@gmail.com>
 <kl6ly1im8ma5.fsf@chooglen-macbookpro.roam.corp.google.com> <owlyjzu2fjz9.fsf@fine.c.googlers.com>
Message-ID: <kl6l8rah8fq6.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 4/5] trailer: teach find_patch_start about --no-divider
From:   Glen Choo <chooglen@google.com>
To:     Linus Arver <linusa@google.com>,
        Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Arver <linusa@google.com> writes:

> I don't see why we should preserve the if-statement and associated
> strlen() call if we can just get rid of it.

Here are some reasons:

- Without compiler optimizations, it is faster.
- Subjectively, I find the early return easier to understand.

I don't think I need to nitpick over such a tiny issue though, so I'm
okay either way.
