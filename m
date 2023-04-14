Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BB2C77B71
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 17:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjDNROI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 13:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjDNROH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 13:14:07 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C4026AB
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 10:14:06 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id y11-20020a17090a600b00b0024693e96b58so18237311pji.1
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 10:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681492445; x=1684084445;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VKc3qk7zX14Oq+EHVHzBBrNlz8aty+2OLQzIjekxmUw=;
        b=UxN7YnE3MjH8JDwI2GBcVIcy/HbJmD+kWy84zoQUmuIcmtW78fqsJ4Y/16d7dpaKsC
         nCAWfsF7wy/aEOLCCR40NIv3z3Nfmg496UhPVzzQ+WuSlwgTyPz0mAYYptQS62OWnlVI
         1m5X5DmD5uaUr7U6oC/LJVKY++WGJ8ouWLls9qe3PPgEyKCd+ZzuWz1SjScxGGHFZz++
         bEHf1IIue5+PX6h2PXGC6iNxaJqaY4ca9MlQamdN0RPNgmT0lKIJSOms21HHErXEyvwa
         ZFCiaG5kTGOU6K1yKRvuWsITGUsK8Ngq7Xo61MEl/hxfLZitKy8eP3Hrf7jFixEeLiLm
         z21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681492445; x=1684084445;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VKc3qk7zX14Oq+EHVHzBBrNlz8aty+2OLQzIjekxmUw=;
        b=SyUf6PSotDxGp8wbqgILTi8AOUs+gPeLFPtrOwh1pIGb0QwKbfZSzniqbdrkHlnmzp
         xNoFCP6my5fxm//LNbJeZAuU465GaNIV/UnRdWLaT6sN6gxwDKCkNPIkQ6A/rVyRFT2y
         oQjvvFKVI/mfbHNycxrD8LZVST4mDq8KWln78VjnNU8CrGWGetJJMvgXrz1l4F59D88D
         gpJOvlWJX1N/cf1sx53V+58KJDcLuqjiZgqHXgvZNb3zl15ia09AyQ3qL5yvm0+f/8Ej
         kAmzzi5BUwAvrsJIe/baLuxBcea4FgJRxoWrz0RczTvHzOQX3bvBWhOseFFajPvU873h
         Z6dw==
X-Gm-Message-State: AAQBX9dvL5uoLOjUGxkYx1zae5wRFyIfnhSyyL0yGbowpciYhH4rzPxD
        3MUqQ8ugRsVLW9chguWgemc=
X-Google-Smtp-Source: AKy350ZRtf07703xit5So1JISisF61CSnwZBm7ioj2ojdHMfYS1D79BDRlZ6Gaq5innNCkQOwN/vYA==
X-Received: by 2002:a05:6a20:bc96:b0:d9:b024:4824 with SMTP id fx22-20020a056a20bc9600b000d9b0244824mr5344419pzb.26.1681492445303;
        Fri, 14 Apr 2023 10:14:05 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id y9-20020a62b509000000b0063a04905379sm3266172pfe.137.2023.04.14.10.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 10:14:04 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] doc: set actual revdate for manpages
References: <20230413074722.71260-1-felipe.contreras@gmail.com>
        <20230414070449.GA540206@coredump.intra.peff.net>
        <643949a57396c_5b7e62948d@chronos.notmuch>
        <xmqqildys97o.fsf@gitster.g>
Date:   Fri, 14 Apr 2023 10:14:04 -0700
In-Reply-To: <xmqqildys97o.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        14 Apr 2023 09:46:19 -0700")
Message-ID: <xmqqa5zas7xf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Formatted output from a repository working tree changes from
> "04/14/2023" to "2023-04-13".  The value change may be intended,...

Forgot to mention another thing.  While it may be a good idea to tie
the datestamp etched in the formatted result to that of the source
material, rather than the date the formatter happened to have been
run, the committer date is more appropriate than the author date for
that purpose, as the former is the date that the change made on the
latter date (which is earlier) has become a part of the whole, from
which the formatted result was produced.

It may not make a big practical difference:

 * For an individual who is trying out the changes just made, the
   committer time and the author time are likely identical.

 * For a release process, what is at the tip of the released branch
   is likely be the release notes and version bump, recorded by the
   releaser, and again the committer time and the author time are
   likely identical.

 * For results of a pull request, the times are likely identical for
   the merge commit.

but from the philosophical standpoint, it does matter.  Using the
committer time would give us one more justification to use one
single timestamp from the commit, when people complain "this manual
page, as opposed to the other one that was changed in the latest
release, has not seen any need to be updated for the past 3 years,
yet the formatted output for these two manual pages carry the same
date".
