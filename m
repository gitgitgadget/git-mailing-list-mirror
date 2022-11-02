Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC32C4332F
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 20:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiKBUeP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 16:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKBUeN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 16:34:13 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCAB5FAB
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 13:34:11 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id g13so81926ile.0
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 13:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PbE0Vt5/wP+FT5A9RjQ7NfIMfH8aA5LfslVxNfmKl+Y=;
        b=Qex/34t8qe7kXEXZ6PJvB7Ui8/tDoK4LHrz1hNMH2PnnDFqoZHJ7c8ruM4MYbilrZj
         qk/M1NzGWSDv74LkA5KibvK95pDJ9Ct3kEXikHRm0s+btmzyL9vwVsYPPFpxekmn5znV
         bTSghzmf4jg8VjBDvw6ovfF2BXGV1BoYbYkuKmmTQKKqVklg+M8VLZZvGygiaes9fQG6
         zTDYKtPw8MiKCBmCuY3KftomR+3imTSLh+Tr3UN9EkOyU21z1Zv4HmEojfWDKCj5Y/rn
         fg8zpnf5vp+QrzKQ15DKZLQ7MVbhkVqrOSnIxYOVRkMOVHut6jBCXsN9jHhDcwkhnP3s
         zOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PbE0Vt5/wP+FT5A9RjQ7NfIMfH8aA5LfslVxNfmKl+Y=;
        b=6PVXHtglQoc/w55BCCygxAG7fMLa+kgcnJjo47kxj61sAgLPCfqP3OQgaKgFAyHPzv
         PrPHj9iXMYI3gOf9459wt1ByFLupmK73IhKVgSTTnydX7wK4vC4hxQltTueArTphaZoX
         ioy262oEFnGLE1aAZbAW3C4RP9kkYEyKHOT1RvJpQL34YAyG53IAkAd/EUp0GArRP5oK
         Ks5bGljLj6CL4s0BFHOrtmi2ZQQj+gK7siqYZh8kLzJK0cXLRg0DWy8FhgNZSdKXanTc
         fbJlEUSIT+irrFtzWRQuiy8w+tBVKWerwJstmB+PWFpYWpSmKCL5s+mWjKNnu3aPITxm
         Ct5w==
X-Gm-Message-State: ACrzQf3ZSq+fO8IES2h3I6wjhvWuLNqEEhWQrg3kXxLpd8CPlHDbA33e
        Eys5qsuE8ZeDWgqX3kDqtCVj0RtBMLHsCLo/AShr8EgkCM0=
X-Google-Smtp-Source: AMsMyM4frU6vzXBZeak8ISqb9nx5n67napAbP0dSvM1rOH8MdcgSSUmK7GqrBuIkA5A5O4Ge+/o7mkTJsUishef+i1w=
X-Received: by 2002:a05:6e02:1287:b0:2ff:dd33:8483 with SMTP id
 y7-20020a056e02128700b002ffdd338483mr15668666ilq.21.1667421251068; Wed, 02
 Nov 2022 13:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1384.git.1665839050813.gitgitgadget@gmail.com>
 <pull.1384.v2.git.1667002005494.gitgitgadget@gmail.com> <8abc5272-4e01-e793-5155-ea116e9ad4fd@jeffhostetler.com>
In-Reply-To: <8abc5272-4e01-e793-5155-ea116e9ad4fd@jeffhostetler.com>
From:   Rudy Rigot <rudy.rigot@gmail.com>
Date:   Wed, 2 Nov 2022 15:34:00 -0500
Message-ID: <CANaDLWJmWiA2HwXSA5z-uaz+wg3f0WNTePkaG3omrcQ-Jri4VQ@mail.gmail.com>
Subject: Re: [PATCH v2] status: long status advice adapted to recent capabilities
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks a lot for all that feedback. Honestly you're way more familiar
than I am with both how the underlying features work, and how to best
contribute this change, so I'm comfortable taking your advice pretty
much blindly.


> Let me suggest an alternative commit message.  We want to lead with a
> "command" -- as in: "make Git do this" or "teach Git to do this".  Then
> explain why.

Oops, sorry for missing this. Well, your commit message suggestion
is flawless, I will reuse this as is. Thanks a lot for spending
time polishing it.


> I hate to suggest a complete rewrite
> [...]
> Something like that.  Hope this helps.  (And again, sorry for the
rewrite.)

There's absolutely nothing to apologize about. This is great! I
will also reuse as is. Here too, thanks a lot for the time spent
on this!


> small nit: we should have a final LF at the end of the file.

Sounds good, will fix.


> I'm going to skip over the test cases because I'm running
> short on time this afternoon.

That's all good, I need to align my submission to all this and
resubmit anyway, so you got time! I'm pretty confident about them
too, a lot more than in the phrasing of the user-facing content
I had.


> Also, we should refer to the documentation via `git help` rather
> than as a link to the website.

Oops, I didn't realize people were getting the same content from
either. I will fix.


> I'm not sure I like the various mixture of messages here.  Maybe
> it would be better with a single simple message:

That's the one thing I'm a bit concerned about, that I would like
to discuss more if that's ok.

The current confusion we're seeing with users of our very large repo,
is that they run git status the first time and notice it being slow
(~30s), and then they see the current advice message advising that
they're supposed to do something about it. What they don't know, is
that untrackedcache and fsmonitor were already set for their
environment, by the script setting their entire environment up.

I don't think it is unusual for users to not necessarily know how
their environment was configured (either because someone/something
else did it for them, or because they forgot what they did for
this specific repo, for instance).

So with that, I worry about the phrasing "See 'git help status' for
information on how to improve this." in that use case, because
it implies that there is something they are expected to go improve,
while that was already done.

Here are some solution ideas:

* Changing the wording for all use cases to not convey that they
must do anything about it. For instance just "See 'git help status'".
(I don't love this because I could imagine users being puzzled about
why Git is telling them this, then.)
* Informing the user of their current caching situation in ways
that they can deduce whether or not they should be doing something
about it. That's what I was attempting to do here, but reading your
help content, I think I got something wrong: I didn't realize the
cache would only need to warm up with untrackedcache + fsmonitor,
and not with untrackedcache alone. So with that an improvement could
be to only display "but this is currently being cached." when both
untrackedcache + fsmonitor are on, and not display anything different
when only untrackedcache is on then when it's not.
* Not displaying this advice message when fsmonitor is on, since
the best possible optimization was already applied. Not loving it,
because some could also still want untracked files off on top of it.
Also, it doesn't resolve the frustration of noticing git status being
slow the first time.

For now if you don't mind, I'll change things to the 2nd proposal up
there, but this is not because I'm rejecting your guidance and insisting
that adding a line here is the right solution to the situation of
environments that were already optimized, and I'm not sure what
is. But I do worry that telling those users that they should optimize
things while they/someone already did will surely be confusing.

I'll work on the other fixes, and I am deeply interested in your
thoughts about this one. Thanks a lot for working through this with
me.
