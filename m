Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F68C6FD19
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 17:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjCPRdL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Mar 2023 13:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjCPRdK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2023 13:33:10 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4087C11176
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 10:32:55 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d12-20020a056a0024cc00b006256990dddeso1437066pfv.9
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 10:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678987975;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BJMpcUKIJAx3+2CHVq7QY80MgDcSE0pj9zjMzV22ei4=;
        b=JBUW7Ub2pPmGP4vv+mIs6kx9vgRVNcOmKn+kMqt+58y0fSoyKCuASVdOxqzRfMoGdW
         gnEXCPWLBFcOp6dH5naMfVuy+U4f8nJSO59R3w/JOpKvQ6BgBBUSj6uNJhvhpsoVu+Q4
         Ymb3KdhRqOpzATzM7mf9Uk/t5wDDk2uJ3KGrCnf2zsDPCyHlrUYIKT5/QKn/wirpfY0P
         A419fZPARl1lo/0B3fuIRM+Av6fsXlQbBSlppDxisMeCJyhjd0YX/8/HZTjoP3irH3Ev
         2xYUknxn0gR2RdvBYIobgurZ5x7n2/pBSLki6UbMzWupe5+gXh5J0n8KvTe6M0KTT3cs
         pGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678987975;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BJMpcUKIJAx3+2CHVq7QY80MgDcSE0pj9zjMzV22ei4=;
        b=Nwj42aUP7Ec3X5RI47JnRinHvg5oC8IDdgJlMfNnWtGXR4k4JGERWrcWh4agz6tZM+
         ZKfkXkOeZjZsIjhBhABcy80UNFL54mw3HXrxqG5JzFO1A84utn04m1+omECgRJzXB7XY
         IKnDbDTFBeO77HZADUYB2VzfKn/A5ForCmM2D5YJqqqxrfSz6n2QKZVv/FoXHlJ9K/Cw
         opTc9dXONdcxWnHZYUlS3EIYxvnCYP1mG79ew7qT+W61CttZrYjmMs+o6k09jBmxyCoD
         c6ALAFW3ZRumB6GfKVNl6yT2zH1Yw/gx2PkVMMUTiwtytnOUMzbMY07ICA0a0gHjZRSi
         Odow==
X-Gm-Message-State: AO0yUKUU8XNDqR3kUvS5Gi89E1Je9OxSbbmYeF3xOXsLrXerMJfVcTHh
        LFuf9HqZzkNjZu9Y+XuVm/0+KpGWNayKfQ==
X-Google-Smtp-Source: AK7set8J8ZI1AgHmjJ9gWonMgzSRJlRmwau/uGSGyBNlH9rXHpIc1lLFC/GTL+acxE7DveQgrcrdVRljKqw6fA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:903:1c2:b0:1a0:7630:8ef8 with SMTP id
 e2-20020a17090301c200b001a076308ef8mr1835177plh.2.1678987974783; Thu, 16 Mar
 2023 10:32:54 -0700 (PDT)
Date:   Thu, 16 Mar 2023 10:32:53 -0700
In-Reply-To: <CAMMLpeRGEETraueJTTV0tJSsycNYF24YX8n6h-pMp87VcCRJtQ@mail.gmail.com>
Mime-Version: 1.0
References: <20230225180325.796624-1-alexhenrie24@gmail.com>
 <20230305050709.68736-1-alexhenrie24@gmail.com> <20230305050709.68736-4-alexhenrie24@gmail.com>
 <kl6l7cvsi006.fsf@chooglen-macbookpro.roam.corp.google.com> <CAMMLpeRGEETraueJTTV0tJSsycNYF24YX8n6h-pMp87VcCRJtQ@mail.gmail.com>
Message-ID: <kl6lzg8cvby2.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v6 3/3] rebase: add a config option for --rebase-merges
From:   Glen Choo <chooglen@google.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, sorganov@gmail.com,
        calvinwan@google.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

>> > In the future, the default rebase-merges mode may change from
>> > no-rebase-cousins to rebase-cousins.
>>
>> I suspect a more likely future would be that the default is to rebase
>> 'evil' merges instead of trying to recreate merge commits, but of
>> course, the important thing is that we promote the default, not what the
>> default will be...
>
> Glen, do you have any more thoughts? At this point, the only thing
> that's keeping me from implementing Phillip's request to make
> --rebase-merges without an argument clobber rebase.rebaseMerges is
> your suspicion that we might need to change the default rebase-merges
> mode in the future, and I assume that we would want to use the
> rebase.rebaseMerges config option to facilitate the transition.

(Sorry for the late reply)

Ah, I don't really have more thoughts on the matter. I am fairly
confident that we would _like_ to change the default to rebase 'evil'
merges, but I don't know how likely that will be.

Perhaps it would help to enumerate the rules to see if it is too
confusing or not?

The behaviors we can tweak are:

- Whether to rebase merges or not (true, false, specified mode, or
  default)
- What mode to use when rebasing merges (specified mode or default)

And the sources are either CLI or config, with CLI always overriding
config.

Should we rebase a merge?

- If neither CLI or config tells us whether or not to rebase a merge,
  default to "don't rebase merges".
- If one of CLI or config tells us whether or not to rebase a merge,
  respect it.
- If both CLI or config tell us whether or not to rebase a merge,
  respect CLI and ignore config.

What mode should we use?

- If neither CLI or config tells us what mode to use, default to
  "no-rebase-cousins" (or whatever default we decide).
- If one of CLI or config tells us what mode to use, respect it.
- If both CLI or config tell us what mode to use, respect CLI and ignore
  config.

If users cleanly separate the two concepts, I think it is quite clear.
(I'm not advocating for this approach, but) e.g. if we pretend that each
behavior were configured separately, like:

--[no-]rebase-merges [--rebase-merges-mode=(rebase-cousins|no-rebase-cousins)]

I don't think there would be any confusion. (Having --rebase-merges-mode
be a no-op without --rebase-merges is probably even more confusing to
users, plus this would break backwards compatibility, so I don't think
this is a good idea at all.)

Your doc patch explains the rules pretty clearly, but perhaps it doesn't
explain this mental model clearly enough, hence the confusion. If we
don't find a good way to communicate this (I think it is clear, but
other reviewers seem yet unconvinced), I wouldn't mind taking Phillip's
suggestion to have "--rebase-merges" override
"rebase.rebaseMerges='specific-mode'".

>
> -Alex
