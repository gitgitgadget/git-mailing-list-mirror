Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3ABCC433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 19:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiGUTez (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 15:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGUTey (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 15:34:54 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA16988F1D
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:34:53 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id m10so1990508qvu.4
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ICcRSTtcJuYPx/t/1CMI/Zvugf9Rn5Zg8MI/Msglu+Y=;
        b=ZBOhyEEzG/G5zypgtmmN9wqlHNDQwQd5GXLFrPlZvBmqLt2AKvWt8495YqJdInoyZR
         RDGXftS5O2+7yEi22WO2Gflo3oUDPyrMI3QEVNP8e0JoyaRRWYtA5U9KAZxfK1sUlviS
         0EhawmHrPkRHtXtdNLJzmPgZOt1d1h1kJuCrrmVOQUGRTbGY0NYDMSv02iEB5a9UOLIK
         ePVB1Y8PIaUcQnMy6bIiFI62snXvlr/t7GZiFIBUwb6hmABmF1k87AmsDu9GFkak18r3
         Hwp2OGtpjxN1EYCALeGtI+KQG7Rvj3B3LCx388jRZvCnd0L7aQKiVfwqHv+AkM0kLqpV
         7WeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ICcRSTtcJuYPx/t/1CMI/Zvugf9Rn5Zg8MI/Msglu+Y=;
        b=eaVXrldmOKEOcQLGJr0L1rcp28ev6+haYdmMgTotN+bP3VrkpzKYf2FdKNTUncG7vh
         L7Q9houB00tpuM/cOkPw69aDsZpYDlfJZhmnwXQD63X3XpdIp1JR/38D9eUrEKhHU/gE
         BU7i9NeUYzf9GI1I83m8xCqu5Fx13y5zNrZrHOt6gbfnouRlZRNVUsYJMA/YNVBpfLQZ
         YjozDBJ0hsknkYejhnAbhiVB4Y6Wsluw0/XgVhCK3Kr+1GKCkN76GWa9MJ5tyV8cAlye
         GuHlagkdx/QhcvD2XPAxM7xEelu6/Ruis65aSL5aPhaAudo8TpXugYILLAiIbtq5/Syb
         2Z2w==
X-Gm-Message-State: AJIora+VtL63jfU/mQuU2q9rdLzC915OCyF7OUG9ztpvoFlvo7AQqB8C
        E/Xrt58zs4baxp06sziA+aMWmx6Pqkh0D2kVl4o=
X-Google-Smtp-Source: AGRyM1trXv3+1TCvE/iLVNv1gOmFhAEktHsT2V7eZka8RGYBd/juJED3PJhzxntQSD4UYdNUgBt4pPKzVr4puq5aHho=
X-Received: by 2002:ad4:5ae9:0:b0:473:62ef:601a with SMTP id
 c9-20020ad45ae9000000b0047362ef601amr94408qvh.69.1658432092825; Thu, 21 Jul
 2022 12:34:52 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BEK+SJh2uF=rrM-f1u9diMQJ7D3H0fJLdzWpyOww=ys+w@mail.gmail.com>
 <xmqqy1wmlbnn.fsf@gitster.g>
In-Reply-To: <xmqqy1wmlbnn.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 21 Jul 2022 12:34:42 -0700
Message-ID: <CABPp-BEqWX3Nr2HDxwS9d-_QjcKb_jS=fSjsP_Pbutw7-P5gbg@mail.gmail.com>
Subject: Re: Question: How to find the commits in the ancestry path of seen
 down to _and_ including a given topic?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 21, 2022 at 8:37 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > A simple question that I'm spinning out of [1]: How can I get `git
> > log` to show the commits in the ancestry path from seen, back to *and
> > including* a given topic (but not commits from unrelated topics)?
>
> Drawing of a sample history, please.
>
> I feel stupid asking this, but I do not think I even understand what
> the question is X-<.
>
> Commits that are ancestors of 'seen' and are descendants of the tip
> of the topic?

What you said *plus* commits from the topic itself.  From this graph:

    A---B---C---J---K <-- main
            |\       \
            | \       N---------------O---P---Q <-- seen
            |  \     /               /
            |   L---M  <-- topic    /
             \                     /
              D---E---F---G---H---I  <-- other_topic

I want the commits L-Q.  If I run

   git log --ancestry-path topic..seen

I only get N-Q, missing L & M.  If I run

   git log --ancestry-path main..seen

then I get D-Q, providing me with D-I and J-K that I don't want.

The closest I seem to be able to get is

   git log --ancestry-path topic~${commits_in_topic_minus_one}..seen

which includes all commits I want except the first commit of the topic
branch.


An example, from git.git; 5b893f7d81 is a topic (ab/submodule-cleanup)
with 12 commits, and ac0248bfba is some older version of 'next' .  I
want all 12 commits in that topic plus all commits that are both
descendants of that tip and ancestors of that old version of 'next',
which adds up to 36 commits.  (Note that this includes the 12 commits
in ab/submodule clean, 9 commits from gc/submodule-use-super-prefix
since that happens to be a descendant of ab/submodule-cleanup, and
about 15 merge commits from merging other topics into next, but does
not include those other 15 topics.)  If I run (notice the "11" instead
of "12"):

   git log --oneline --ancestry-path 5b893f7d81~11..ac0248bfba | wc -l

it reports 35 commits -- it's just missing the first commit from the
topic.  If I change "11" to "12" to try to get that first commit too:

   git log --oneline --ancestry-path 5b893f7d81~11..ac0248bfba | wc -l

then it reports 228 commits, 192 of which I don't want.
