Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4E9C48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 14:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F3B261493
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 14:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhFOOkQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 10:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhFOOkP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 10:40:15 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C3AC061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 07:38:09 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id k25so22986152eja.9
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 07:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ez+eYwCa7A000IwbQzHgL66Kyc+3n+e4AMr0DWW+1R0=;
        b=G/TXwDm9nwLzuVCVGe188TlyYUGng9SU0QqEVikHYKEN6IYCugDYQSbqiw736hC49V
         IsDupoHkdc4RME23yEcxJYr4z65qA/tQotQyBz8L3O9fFdisa0JSUYHA2pT+CISGG3rJ
         a+coJPDRjzxJfjjGkcNDTz2aW7cVtsJemOAU0YzxM8pJPDJh5JxQcIy5uvWjrW6xFyvu
         y2hh650qqmQqwaSltl5GWN091Aw6QZehExcLufoemciVMJULDSVZsyi8YujLDpadooWR
         Kx3SS+smeSD0WHWJLhijanJYGSMNtl84mtRuzvqzp+HPwS/BJd9kmxFbgz0/4ZVOMFkj
         QiwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ez+eYwCa7A000IwbQzHgL66Kyc+3n+e4AMr0DWW+1R0=;
        b=kKbH5nICQ0Ibhx4Sdh943/ACW0FEDhuud1wNFZOmkZA8IBeDnEMjU71QGulcLGLTTP
         I4Yi7fWvne6p+rY5IBJ6rLw20r0vOyUFWWdY/8Go+ub9xInzJBrh1R1VGyC7Qhd718px
         3jG5liFAJtcWaV2xaRCFGSSqow74c182OoUcPWtcyTmZ0gQh6zaXILD3XgycmGEbtJgY
         7TeGdxj557pV++f3fehOY+ivos49jYfzBWAamGGybDn1myFN+kSNiOqUG/7UZRwr1G8h
         oiSwLltXQP65f+PpE1sa0zlQpi6R7CUWj6xVg9pwa3WW7s62USjrejxMXOp37dK/Aw2R
         Qrow==
X-Gm-Message-State: AOAM5309vVfS9tfwcGsZoCcXdUL4ovKpHc/EB8Xxrgi4eee23kFD2zyk
        Qg1NcUVVMjXNAJ61SHTmqMM=
X-Google-Smtp-Source: ABdhPJyvSwcg/cK/7R9Bqa4flU7uO7DTgeXeIrgux+xB0bBCwNmksppD4k4FH6SGmJUd7aeqlEaYFw==
X-Received: by 2002:a17:906:1982:: with SMTP id g2mr21220514ejd.184.1623767888320;
        Tue, 15 Jun 2021 07:38:08 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id c14sm10140825ejm.4.2021.06.15.07.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 07:38:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: Re: Making split commit graphs pick up new options (namely
 --changed-paths)
Date:   Tue, 15 Jun 2021 16:35:47 +0200
References: <871r9a2dol.fsf@evledraar.gmail.com>
 <YMJKcHpN/gL5U6KK@nand.local> <87mtrx1cdr.fsf@evledraar.gmail.com>
 <YMKzOgOU9lj9Nt0z@nand.local>
 <e85bb66a-d70d-1861-07ef-82a74bcce4d7@gmail.com>
 <YMOzDGOo/HbqzkPa@nand.local>
 <eb5e2df7-25d8-a878-78ba-cca771265978@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <eb5e2df7-25d8-a878-78ba-cca771265978@gmail.com>
Message-ID: <87fsxjyz01.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 15 2021, Derrick Stolee wrote:

> On 6/11/2021 3:01 PM, Taylor Blau wrote:
>> On Fri, Jun 11, 2021 at 01:47:28PM -0400, Derrick Stolee wrote:
>> (FWIW, I had to re-read 8d84097f96 (commit-graph: expire commit-graph
>> files, 2019-06-18) which mentions that a configuration variable would be
>> introduced to change the expiration window, but we don't have any such
>> configuration option. It also doesn't make any mention of handling this
>> problem on Windows, which made me think that the unlink() calls weren't
>> checking their return values by accident when in fact it was probably on
>> purpose.)
>
> That config option never appeared, probably because ignoring the
> unlink() return was sufficient to get around this problem. Thanks
> for digging in and making sure I remembered this correctly.

Isn't the whole ignoring the return value of unlink() Windows-specific
code? There's no issue with unlinking a file someone else has open on
POSIX systems, indeed unlinking a file you just created (but hold a FD
to) is a common pattern for getting a temporary file that you don't need
to unlink on atexit(). It's just not used in e.g. Git's codebase because
of portability concerns.

So not a big deal at all, but I wonder if there should be a warning
there on !Windows, if you can't unlink a file on a POSIX system that
suggests e.g. a persistent permission problem that won't be going away
if you ignore it.
