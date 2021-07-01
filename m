Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2AAC11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 11:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A7C76147D
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 11:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236339AbhGALab (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 07:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236282AbhGALaa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 07:30:30 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5D4C061756
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 04:27:58 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id r16so7936121ljk.9
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 04:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=GMMLrALIWbcDkiZQQKxsxc7mLQZUCiATIfc/Bc/pPrQ=;
        b=QH8SDrzYyjUw4Cmpbe+UK7FE9lvAXYKIiNZS1b0N3e9l0YwBnFuDR4Wsi+mDP4z3qr
         jSHX0ooYCMfV57imTT/9Ofeblla1AHz7bMU0EVnHh0iPhQg6RsaSu7vilmtSko8CVEgQ
         gvZ17KIoham9hApc29fR6Bh4rkiW4vlMtrpD4SP5sCVBUROZ9aKFeHrxAy0bWuYzRefD
         wGIwTnIa9Da3ckFQ1zRh3TM730WkX21l9ukVyUkiYXohNpcN2Bvq8wodf8J+ZYJhJTiO
         6Go6/gEmQkRFVfp3tuGbI27ow9FJrmyftOrWbjNdtJjeUQ1fBkt6tO9wt3kHSr0A3zaX
         LOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=GMMLrALIWbcDkiZQQKxsxc7mLQZUCiATIfc/Bc/pPrQ=;
        b=fiubwoyrHk5Z8+guAQ4PPlktreX7P1Kp4XwepnD98qao77tXSUuHImW64gHUOMXJvi
         U+OeXzkXf/oKJxE5RTitRRMuftHt2LueU3m90zR+TnfwIQ+BL/dDIIMDzT9LSYVXNBsp
         b4HwJ+L0m29zCpY+M3RZbHxkylsToKmZO5PPsk0V7RIGRma7cnRwxJxkLH/zrCJXsP22
         Ztj8Q+s3lGZ8ibXa3HeKSbUzEmxEGkCus1D8s+lJYBSKGkgZuxrmUJWSc2/ro6ss3tor
         8VXF+ftnYVhdwqb59bDPTbWle/uzeQv7NzmDpVFwrGr8QW19ikXYhYlfuzTEO2iwq9xd
         besQ==
X-Gm-Message-State: AOAM530JpeTRd9SJd4X6ee9Dn1AlSPQHWpRMyDiHf33SqZFBaJvAKLaY
        kcjLjZ+r37ZtECexkha5UwFbnuVrRuo=
X-Google-Smtp-Source: ABdhPJwzhxLUnj95XjNWV6f1wkF7TKQf6R0g+t3zth/AC9Cz7eC8haHwOZeLS46/q/3rj4sBVyOpUA==
X-Received: by 2002:a05:651c:93:: with SMTP id 19mr11924401ljq.140.1625138876678;
        Thu, 01 Jul 2021 04:27:56 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id n27sm107111lfh.99.2021.07.01.04.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 04:27:56 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Martin <git@mfriebe.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: PATCH: improve git switch documentation
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
        <xmqqk0mcy6g2.fsf@gitster.g>
        <b667ca37-b3cb-fce2-a298-63c3b839089d@mfriebe.de>
        <xmqqpmw4uwh2.fsf@gitster.g>
        <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
        <xmqqy2arrmba.fsf@gitster.g>
        <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de>
Date:   Thu, 01 Jul 2021 14:27:55 +0300
In-Reply-To: <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de> (Martin's
        message of "Thu, 1 Jul 2021 12:06:17 +0200")
Message-ID: <87wnqaclz8.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin <git@mfriebe.de> writes:

> On 01/07/2021 00:59, Junio C Hamano wrote:
>> Martin <git@mfriebe.de> writes:
>>
>>> And yes, for the documentation, it *should* be clear that, removing a
>>> branch, removes the
>>> commits on it.
>>> But then it must be said, that the branch is first removed. That is
>>> not currently the case.
>> Sorry, but I still do not see how it makes any difference if the
>> branch is first removed and then made to point at somewhere else, or
>> the branch gets just moved without any explicit or impolicit
>> removal.  A branch cannot point at two different commits at the same
>> time, so the end result is that the commit at the old tip is no
>> longer pointed at by the branch after the update.
>
> Well all very obvious, if you know git well.
>
> Let's take a step back. How exactly is the word "branch" actually defined? Well it does not matter.
> What matters is, how the word is used.
> What does a person mean, when they speak of the branch?
>
> And the answer is, it's not always clear.

Yep. The "branch" may mean a "chain of commits" or a "symbolic reference
to the tip of the branch", or even both, depending on the context.

It's somewhat similar to "file" vs "file name" in UNIX. You in fact
don't remove files in UNIX, you remove file names that refer to files
(entities on disk), yet "remove file" and "rename file" are often
used, even though they are not technically correct.

To me it's essential feature of Git that when you, say, "remove branch",
you only delete the symbolic reference, not any chain of commits, and
documentation should not contradict this where it uses the term
"branch".

>
> In the above conversation, we use "branch" to speak of the "pointer to a single commit".
> We do not include any commits, when speaking of the "branch".
> (And this is how it is used in the docs, as far as I can find)
>
> However a lot of people use "branch" to refer to the commits within.
> "Push a branch to a remote". That obviously means the objects (e.g. commits) in the branch.
> The doc says (and yes I am getting a bit picky here)
>>>> Updates remote refs using local refs, while sending objects necessary to complete the given refs.
> "complete the given ref". The ref is given by the branch, and
> completing means afaik "to make something part of"
> Maybe a mistake made, because "branch" is (according to my
> observation) so commonly (mis-)used to include the objects.
>
> Anyway, can we agree, that there are people who  (mistakenly)
> use/understand "branch" as including the objects?
> Enough people to call it a "common mistake".
> If so, then we should not ignore this.

I don't see this as a mistake. A branch is a chain of commits. It's just
using of short term "branch" without further clarification that could
lead to confusion.

>
> With this use of "branch" in mind, (re-)creating an existing  branch
> on a new startpoint, does to the inexperienced user read like a
> rebase. It recreates all the commits. The fact that as an experienced
> user, I shake my head in disbelief, does not change this.

Some understanding of underlying Git model is inevitable here. I'd
suggest to use "branch name" and other means to disambiguate description
instead of trying to describe what happens using wrong underlying model.

>
> But true, my attempt on adding "the old branch is removed" does not either.
> So not sure which wording will do best.
> Probably
>        "Creates a new empty branch at <start point>"
>
> Even though "empty" may be a sloppy usage too....
>

Yes, it's sloppy. There are no empty branches from Git point of view, so
this is not an option for proper documentation. Any branch has at least
one commit, the one the branch name is pointing at. It's entirely user
interpretation how many of the commits from the chain the Git branch has
they consider their branch "contains".

Overall, if we aim at clear documentation, we need to define our
documentation terms as precise as possible, and then use them
consistently.

For example:

"branch": a chain of commits

"branch tip": the most recent commit in a branch

"branch name": specific type of symbolic reference pointing to a branch tip

It's then up to the user to learn a few simple basics required for
proper understanding of documentation and behavior.

Thanks,

-- 
Sergey Organov
