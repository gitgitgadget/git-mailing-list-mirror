Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF4FC56202
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 05:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1343F206F4
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 05:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rHZLGxzY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387775AbgKZFcI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 00:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387771AbgKZFcI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 00:32:08 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F354C0613D4
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 21:32:08 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id h19so928724otr.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 21:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TI9ig6wJ8x+QhxtCG56HAwPQx4H8ERVxYN5KwAgmNpQ=;
        b=rHZLGxzYIzAu46vfmboonbaw3tF0hQJ5puv1k88rvfhdQT9+3O553qE/YuiCPc1C5I
         YtA9jYkOsQ0wbd273t9UriViTggwptHZ4lDakQleLkBbkv0u6IpWlrHInn+w51/n8TjM
         jJAiXZvkuF0akcqiLAmKqB1oLWgcqvuTcSbT4V9lCYh6qXXlTa1n2TK35o1Lh/R0e3NW
         KRm5EL6HzmFFqW4TdWmRrHYmLjpnO3EeDh5QpavK26vU2BJ/+i8xOcj34a4XKuLj/KJB
         9WfSZwhMjL7LwC4zzSwgRn4OFJneiGoDLd6TCopndntHfT0k9zEm/RbiWB3ggmWboonK
         foAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TI9ig6wJ8x+QhxtCG56HAwPQx4H8ERVxYN5KwAgmNpQ=;
        b=rm+KkaWw/InOTnWCWwA320kr176O95L7CQ+dw7IiVGs08MRpVBaZGFQQASqc/zoLYd
         Ad8p6C0YvPXjysI+M5Ut7MQwMsUe/BIUsNWcdC+5AaCZjc/zdSFTaqC2oBzPFGRymw73
         G4m0H3EaJOCdPKhs9OTl9aFxi4MsZTvRNOOnGHGUdxOrMm0Wfag1Q8Lia2WHgnobfFxl
         tLBIbVv23arU+G5dVI4HjGK5swN3/0eBwXW4ho/PvYTij/4Y1EmdKme3MLG+VrbAH5Iv
         h7lQnZoBqNrOQJOwRWbTb/T9fhDnbMG4fUxLGo2NeYz7YRE8OIPFb0JnixwlGFtsjPxf
         4D0w==
X-Gm-Message-State: AOAM531PHDlqRqEMkEcVQSrRhFgDgrWKBEveS52NTHO+csFQFsb3xQJ0
        gpR+JkLmzU2nWW7GZxpPDOpE+9wpCO+vyfAR8mE=
X-Google-Smtp-Source: ABdhPJwl7zEamwMob9q2vIp/DFzZ21Prdytvww6Q2iOXpmGvHcPoshc/KwJ3sz4YbwGwZ02M/G7QH4EiYsbNhhsmFy4=
X-Received: by 2002:a9d:365:: with SMTP id 92mr1230614otv.345.1606368727744;
 Wed, 25 Nov 2020 21:32:07 -0800 (PST)
MIME-Version: 1.0
References: <pull.919.git.git.1605891222.gitgitgadget@gmail.com> <xmqqlfepcceq.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqlfepcceq.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 25 Nov 2020 21:31:56 -0800
Message-ID: <CABPp-BF5GgpXdo+8TwBPPtxJWot+6h+9oLkWMTtiiqy_uNDKMw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix stash apply in sparse checkouts (and a submodule test)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 25, 2020 at 2:14 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Heavier usage of sparse-checkouts at $DAYJOB is commencing. And an issue
> > with git stash apply was found.
> >
> > git stash's implementation as a pipeline of forked commands presents some
> > problems, especially when implemented atop of three commands that all behave
> > differently in the presence of sparse checkouts. Add a testcase
> > demonstrating some issues with git stash apply in a repository with a
> > different set of sparse-checkout patterns at apply vs create time, clean up
> > the relevant section of git stash code, and incidentally fix a submodule
> > testcase unrelated to sparse checkouts. Provide some detailed commit
> > messages explaining the issues along the way.
> >
> > NOTE: I found a couple minor issues with other commands in sparse checkouts
> > while debugging this issue, but I don't yet have fixes for them and I can
> > submit them separately.
>
> Any comments on this from reviewers?  The second patch is a but too
> busy looking and I am having a bit of trouble convincing myself that
> it is doing the right thing.

Hmm, that diff is a little hard to read.  It's a removal of two
functions, and an addition of a new one, but the way the diff reads it
looks like I'm modifying the existing functions because it catches
some comment line markers and thinks they're similar.  Maybe it'd be
easier to read if I inserted that function elsewhere in the file?

I'll send a re-roll with that and add a comment or two to help explain
it (as well as fix up the small issues Chris highlighted).
