Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C16BC05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 18:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjBFSfh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 13:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjBFSfg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 13:35:36 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF052B0A5
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 10:35:34 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id g13so8313265ple.10
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 10:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RBplbduvkH5/XvFSkGt2qlLmZoxjTtDLv09IxjG+nTY=;
        b=iQvVR4DpN3aFvS6riAeKpZszJeDUrIk1c9NDm0mSxZtuPg+DWwAQhAFvJvIBeJHety
         0wO2jyzg3Xz+Ys/RDJT0RdyskQZjjfEadJlOr0AgNtFHNYLofR9IcX7MfxFdh+Ix0FHi
         1NCtu6vRNa4LTVT93YAl6eD7f7IDovB5nIcLSo6dYdfMnlebI4pmoCRVC1BC4h3lGkkP
         Q5J09KcDix/5y/Y5x/I5C81sYKJSvMyZSWO1AEPCeQKYnSo0Su9zYnK/+ka9lprdrBYV
         RetJ7Wh0XS7ae8TZvJUuhcsRbA+oG4Jjlwf7Lj/udlhNnoog1iETtuXi4zXPCntX3iOK
         gR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RBplbduvkH5/XvFSkGt2qlLmZoxjTtDLv09IxjG+nTY=;
        b=a9n0WPxEPVwYZzSHj2enzNUjUMxeVy/+ztBIi/dtXAQFLaAPzOXZJ1rBaxDl80lhTZ
         ov40zUWCTPqsSnYPobIzWEfFB8+GtKoq12nGq8OMR8vg4S3W7R5xw7Am+NXvp9Wf7uMq
         xmLTGVoW+o6MfqdyCVIAUee9OqD+oj4ra46iN4VrUIdZUlLvSbSs/1DwIjtoZSGmd1xQ
         5elhz9totTtohhCs1t2YKZFmxsh8tUYnovYQ9nbOr21htn0ua9IVjRnERvX+rH3EUrPs
         7lBuV0K+s7v2aSr0FJdD3mdjJE8PAdyezGmveu8X5Cvk4ugYLzcK9MvIfAL/QOgHe5KW
         iAtw==
X-Gm-Message-State: AO0yUKWs1qGkmuGRsf5qlJf7G/92NnhhMJnFn90h09d7uAtahYTGaCqk
        HGdnpK2G+Jrfu1f3rgofiIpDqAT+dEY=
X-Google-Smtp-Source: AK7set/UU3kJGDtYhZSsQQtAjalTUlJb7VexEoD5V52XSpKcG2aQFzvS9Zv7lDlT7LXbIfK2vz8wRg==
X-Received: by 2002:a17:902:e88e:b0:195:e9d4:5380 with SMTP id w14-20020a170902e88e00b00195e9d45380mr26974520plg.56.1675708533582;
        Mon, 06 Feb 2023 10:35:33 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id w22-20020a170902d71600b00174c1855cd9sm2877893ply.267.2023.02.06.10.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 10:35:33 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2023, #01; Thu, 2)
References: <xmqqr0v7o0pp.fsf@gitster.g> <871qn5pyez.fsf@osv.gnss.ru>
Date:   Mon, 06 Feb 2023 10:35:32 -0800
In-Reply-To: <871qn5pyez.fsf@osv.gnss.ru> (Sergey Organov's message of "Sat,
        04 Feb 2023 12:33:56 +0300")
Message-ID: <xmqqedr28wwb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>
>> * so/diff-merges-more (2022-12-18) 5 commits
>>  - diff-merges: improve --diff-merges documentation
>>  - diff-merges: issue warning on lone '-m' option
>>  - diff-merges: support list of values for --diff-merges
>>  - diff-merges: implement log.diffMerges-m-imply-p config
>>  - diff-merges: implement [no-]hide option and log.diffMergesHide config
>>
>>  Assorted updates to "--diff-merges=X" option.
>>
>>  May want to discard.  Breaking compatibility does not seem worth it.
>>  source: <20221217132955.108542-1-sorganov@gmail.com>
>
> Hi Junio,
>
> This does not break any compatibility, as far as me and I believe
> reviewers of these series are aware.

The last paragraphs in the review two months ago still describe what
this series does fairly accurately, I think.

    These patches do look like a good approach to solve the first point
    among the "two problems" in the previous round. Thanks for working
    on it.

    IIRC, the previous round (why is this round marked as v1, by the
    way?) was reviewed by some folks, so lets wait to hear from them
    how this round does better.

    Unfortunately, I do not think of any "solution" that would avoid
    breaking folks, if its end goal is to flip the default, either by
    hardcoding or with a configuration variable.  IOW, the other one
    among the "two problems" in the previous round sounds unsolvable.
    We should question if it was really an "issue" worth "resolving",
    though.

