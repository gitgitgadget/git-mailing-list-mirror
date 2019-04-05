Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CE6F20248
	for <e@80x24.org>; Fri,  5 Apr 2019 00:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbfDEAhC (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 20:37:02 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:43147 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfDEAhB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 20:37:01 -0400
Received: by mail-ua1-f67.google.com with SMTP id n16so1512305uae.10
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 17:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w6ZIDIQZzW9wmRNE6q8d2zD7HcVUvaIhRxupog8iNZM=;
        b=s3HNJClgPjfMHKA5B6xSIwavF07YiaY04JJA2mMg3HHLRY9c6S31mnzT9FW/KsH229
         iJfEeLT1Hf5lOMYvNQN/wo1KlV+tn2BWN2MvZNnM69JusuBVbUbJA5m3pnb2E0ACJW0b
         NoUCLx0Fxrg2itGRPZ2EcLBdPBi0av7Wrhb+xR6B7ORG5nWJm1RbLsnaBQ+DEiEbNNWg
         CQarMOhwdSdCUepkW9spH2qGTfxe84hXrkMXrn8FmH0a0n383/UoJd0YcZwmF2v5ZNy7
         bNGyeXW/uSCR4fqSAMuWeQwj9Tysmma/r2O8YEIwQkZbp9vIwaTuRC0AdkGkkdDD/J8z
         IVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w6ZIDIQZzW9wmRNE6q8d2zD7HcVUvaIhRxupog8iNZM=;
        b=doWczxy5dMU6hm5K4viGiuRg9E0W3e1LJHjwAjcAg7NZd3R3ub+NtUSERhRy4ie4qY
         dW3FHl/qEOAKkPQeQZUOPtqs/pCEpMYlpl9A+vQXGFV5dwrYbRR7NKcYpowdCS45NUfA
         lflkIKwxeeQmilY0jY6dAaOcV0T1J0lbUhcdwTz2Q4xPvHKMwh7suqqV/PWmztwiy252
         vnUg1ILQPdm9OWa/wr6bs3MF1DVmM1sfbZqTayvzIASN+4KYS2AFD4Up84abzUEq7gmN
         TofS/Z1FkHGLi4CE7KPBYsgfTiaMMmXbbHIMm4VTLUHHubn9k0AlEDIS/Hp/UDBIDvIA
         8LZQ==
X-Gm-Message-State: APjAAAX18ygQKwer4sVvYk8jBNxv8fyDEJy5vmS1hVL0eYR+YrEs3bKY
        SXc5C86UBX0VkUuTsiSqrJ3T+G2DZXZEiQMhujE=
X-Google-Smtp-Source: APXvYqxtkKpSfiOdglmnuUzslSltl3xnrBfzC3ZjouFuyTjGrieXPp31ahUrjeo9Sa5mz+eckPbtXfRiaNyE8MZD5s4=
X-Received: by 2002:ab0:2653:: with SMTP id q19mr5651768uao.76.1554424620030;
 Thu, 04 Apr 2019 17:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <1bd9ee28bc8726490ec0a93286056beeb147fc49.1554183429.git.liu.denton@gmail.com>
 <20190402230345.GA5004@dev-l> <xmqqzhp7sfw4.fsf@gitster-ct.c.googlers.com>
 <20190403213318.GA14137@dev-l> <20190404020226.GG4409@sigill.intra.peff.net> <xmqqftqyf76a.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqftqyf76a.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 4 Apr 2019 17:36:48 -0700
Message-ID: <CABPp-BHBq64-4jO4=rxUsA2WV5keh86wrai87i=oLTzXdcTb=w@mail.gmail.com>
Subject: Re: [PATCH v2.5 2/2] tag: prevent nested tags
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Robert Dailey <rcdailey.lists@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 4, 2019 at 2:31 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > I do still think it is likely to be a mistake. I think Junio's point,
> > though is: who cares if the mistake was made? For the most part you can
> > continue to use the tag as if the mistake had never been made, because
> > Git peels through multiple layers as necessary.
>
> Nicely said.
>
> If we forget to peel, that is a bigger problem, but I do not think
> it makes any sense to single out tag-of-tag as "curious" and forbid
> it, when we silently allow tag-of-blob or tag-of-tree happily.
>
> An opt-in (i.e. default to false) tag.allowTaggingOnlyCommits I do
> not have any problem with, and I could be persuaded into taking an
> opt-out (i.e. default to true) tag.forbidTaggingAnythingButCommits
> configuration, perhaps, though.

I'm slightly in favor of the tag.forbidTaggingAnythingButCommits
route.  Two reasons:

  * Even core git commands can't handle these properly after more than
a decade, making me suspect that tools in the greater git ecosystem
are going to fail to handle them too.  In more detail...  Some
examples: fast-export with --tag-of-filtered-object=rewrite fails on
tags of tags and tags of blobs.  Without that flag, I think
fast-export munges tags of tags, but maybe that was only under some
other special case; I don't remember right now.  Also, filter-branch
munges tags of tags (though maybe that's documented; it may have
decided that tags of tags are an error in need of fixing with no flag
for users to opt out).  Considering core tools that have been part of
git for over a decade mishandle tags of anything other than commits
(or maybe even treat them as erroneous), I don't see why we'd expect
tools outside of git to handle them correctly.  Thus, I think it'd be
nice if people had to specify some kind of way to state they are sure
they want to tag something other than a commit.

  * The only two repositories I know of and have access to which has
such tags are linux.git (a tag of a tree) and git.git (a tag of a blob
and four or so tags of tags).  Further, these tags are all pretty old
too.  So, I think disallowing the creation of tags of non-commit
objects would be unlikely to negatively impact existing users.


Though, on the flipside, given how rare these seem to be in practice,
it might not be worth the effort.  Certainly not at the top of my
priority list.

Elijah
