Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F3BC433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 03:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83FD064EE9
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 03:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhCDD23 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 22:28:29 -0500
Received: from mail-ej1-f49.google.com ([209.85.218.49]:46478 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbhCDD2R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 22:28:17 -0500
Received: by mail-ej1-f49.google.com with SMTP id r17so46528638ejy.13
        for <git@vger.kernel.org>; Wed, 03 Mar 2021 19:28:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QN7m0I0j8bTsdEo5xo1SYa6fRWbM3h60PDqUhN1pHJU=;
        b=N6QAedPwQsQEAmkUUbkepiOieBRz2AfkAx1SR7FisF5LpGCFZVJyg1snPJfGFeindc
         BWRCg8XHyX4pQoC9tflcHWhopUgOzTguLoN0z6O121krZ6PWIUxudLxNMApGK2YD8x/9
         Dk6TuPfFO5XUT3Kk7ps+1/CfeTeZncIysc1ItP5QUHqCbkPWPWNiiA7+94Y69Ksq6CsO
         6KKTXmj0i0gE12OZ68XxHE/vjcE0FSzfcIYwz50SZIiVLQ64Eav/QcPwUCUTWLagAfZ1
         KKXaXQ+CIZbhXwOdmCbWSAfdeoAjjFYi3zVH72AC4/DoeHQqzgJp1qAFAmWTkkaKLA8W
         oIJA==
X-Gm-Message-State: AOAM532dvSMQIxr1/x/jN6z9Dyh8dkmCdIZ/DSTq2QA8BrAsVCHtPL1A
        LWWOoWf5nsC3nJN5ediwW+T6kWeHY1Grh9/+fcw=
X-Google-Smtp-Source: ABdhPJz80GH1O1MZhCbEv6yJLlCqaylC6QjvKDRwrr4KyREEA9akDOZRVzWdgA+7L2DZWWDc/I4PA+9uwTA5oN9fQZw=
X-Received: by 2002:a17:906:3105:: with SMTP id 5mr2016828ejx.168.1614828456172;
 Wed, 03 Mar 2021 19:27:36 -0800 (PST)
MIME-Version: 1.0
References: <pull.885.git.1614269753194.gitgitgadget@gmail.com>
 <pull.885.v2.git.1614588030233.gitgitgadget@gmail.com> <YD9Qv/sTDmOE9jlq@generichostname>
 <xmqqpn0fg2ls.fsf@gitster.c.googlers.com> <CAOLTT8RdXC+KQNupU1TQdPh-tQO+syd6WJe85GzieE3uWt2ibA@mail.gmail.com>
In-Reply-To: <CAOLTT8RdXC+KQNupU1TQdPh-tQO+syd6WJe85GzieE3uWt2ibA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 3 Mar 2021 22:27:25 -0500
Message-ID: <CAPig+cTncEC4njnu+FB9tKwu20xi_UuL4TWW3_zD3drD3fyrHw@mail.gmail.com>
Subject: Re: [PATCH v2] format-patch: allow a non-integral version numbers
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 3, 2021 at 9:08 PM ZheNing Hu <adlternative@gmail.com> wrote:
> What we are arguing now is whether it is necessary to add
> "aginst v<previous_count>" to the patch when the non-integer version
> number + rangediff/interdiff is required. Denton's point of view may be
> similar to that of Eric before.

Yes, it sounds as if Denton and I share the same point of view.

> Here are my personal thoughts:
>
> Of course this `previous count` can be used in a very small range, but
> I think it
>  doesn't hurt to keep it, because even if you don't use it, `format
> patch` will still
> output "Range-diff", which will not break any known functions. It can
> only be said
> that `previous count` provides an option for submitters to know the
> previous version
>  for reviewers. In this regard, I agree with Junio's point of view.

I'm not outright opposed to supporting non-numeric, non-integer
reroll-counts, but I also don't see a big need for it. As mentioned
earlier, Denton is the only person I recall who sends fractional
re-rolls, so it's not obvious that there is a big advantage to adding
such support and complicating the code just for one person. Also, when
Denton does send fractional re-rolls, he typically does so for just a
single patch out of a longer series, and he doesn't (I think) provide
a range-diff or interdiff for the patch. So, for Denton's intended
use-case, this entire discussion about "Range-diff against v$V" and
"Interdiff against v$V" seems superfluous. That is, the simple logic:

    if reroll_count specified and is integer:
        s = "Range-diff against v${reroll_count -1}:"
    else
        s = "Range-diff:"

satisfies Denton's case without the complication of adding a
--previous-count switch. This probably explains why Denton doesn't see
a need for the extra complexity of --previous-count.

So, some ways forward are:

(1) drop this topic altogether since it so far seems of interest to
only a single person (Denton) -- nobody else has asked for it

(2) support non-integer reroll-count but just use the simple logic
shown above for constructing the "Range-diff/Interdiff against"
header; this leaves the door open for Junio's idea(s) of allowing the
user to specify --previous-count and automatically determining the
previous reroll-count by scanning a directory

(3) continue refining the changes made by this patch until reviewers
are happy with it (which might take a few more re-rolls)

I lean toward #1, but wouldn't be opposed to #2 or #3 either.
