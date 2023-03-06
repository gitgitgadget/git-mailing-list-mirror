Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB3FC61DA4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 22:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjCFWWn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 17:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCFWWm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 17:22:42 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB766F48E
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 14:22:04 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id cj27-20020a056a00299b00b005f1ef2e4e1aso6078981pfb.6
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 14:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678141324;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ldp1d4eeF+tpHqD4lYxsb3YhqScXpNlklcls9SgiEH4=;
        b=PrSAZP6+Ogr6+zq6A9yi+vUdJYlK6ztyKV+fU0mi9pZhhTwhKu0kYs5FEATv+pEGJ1
         4SK3UeAWo/3suNndTC7VMRxouW0hw0p9VIqt/MJTzL/qdLvv1DTGJArzauO3qJ6TIIHy
         igo2ZzHYBb6vKFYlbBhEGQzhwjJ0q2X0xC2zGpeqBTBjMHHxB/g0UDu4vZPs/ugmn6NB
         Faq9iykSKBBFTDUHuNhJ+fC/ZNIi/RmmONP/Gz5TVcYR1T/0aYfjHf4Ex3Qy40gQs9fk
         4rGK+En1oH+NhkbDnruZn9Waw4etinvxCK9zWl4vyWL1MjpQ/lF5RGTRjtsxTefL2bA3
         7ovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678141324;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ldp1d4eeF+tpHqD4lYxsb3YhqScXpNlklcls9SgiEH4=;
        b=ZHPoozEgiC2HpjqqeoOUkg7lCxurh+6rddb/Mfn7DJz/ewPUMAgewYU/y9YmWrMeEj
         9TuwnvkWpeMeRVI+JrtLxCfDh3K6BaBult1vsV+Ep05T9Vx3llZaQCCPAlVCU9T+WoYv
         HQUip0g0viVDfhfXvNU/yodEVwopG5w8lmNU+vTjsDVMm/9McQalgjNPHoVV5yMUL9kX
         KBJ7GuHcVqDNQLCv9y5tLWSyypVBhZICkAw+XUJJH7dLA1/7DjP74MDEKPXaDzR6WrIl
         Rn7dhijzSnpNP8FqGMAFh6GlOn6zKZt7lENZy4yqLq64ye4GihueJNV7/HCethV8ZCU+
         mrxA==
X-Gm-Message-State: AO0yUKUaPn0LGw+S7YWcehxWkDIoo8r8nF2VOSQxOdJh1IQr/OvAKbiB
        /YHlzfCgfXDAcg5tbifjz1ZCNj/hgjcs0g==
X-Google-Smtp-Source: AK7set/2Uy9cCyIly+DpNc4hZ6ssE7FJYnzFX+Wh5qVY2DJQAim4T7H+df52NQcv4S7MznP1fUgLz49ggBk4Lg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:903:328e:b0:19b:456:6400 with SMTP id
 jh14-20020a170903328e00b0019b04566400mr5123708plb.7.1678141323990; Mon, 06
 Mar 2023 14:22:03 -0800 (PST)
Date:   Mon, 06 Mar 2023 14:22:02 -0800
In-Reply-To: <87wn3zqefx.fsf@osv.gnss.ru>
Mime-Version: 1.0
References: <xmqqr0v7o0pp.fsf@gitster.g> <871qn5pyez.fsf@osv.gnss.ru>
 <kl6lr0v2i0gn.fsf@chooglen-macbookpro.roam.corp.google.com>
 <87wn4tej2f.fsf@osv.gnss.ru> <kl6lh6v43s4g.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqr0u7ku3j.fsf@gitster.g> <87wn3zqefx.fsf@osv.gnss.ru>
Message-ID: <kl6lzg8pcygl.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: so/diff-merges-more (was Re: What's cooking in git.git (Feb 2023,
 #01; Thu, 2))
From:   Glen Choo <chooglen@google.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

>> but I have been under the impression that the remainder were OK
>> clean-ups.  Perhaps it is mostly because I read them so long ago and
>> forgot the details X-<.
>
> It's not a cleanup, it's rather adding missed feature that allows to get
> precise '-m' behavior with --diff-merges.
> ...
> However, by making such decision we lost ability to provide exact
> behavior of -m using --diff-merges= set of options. This has been
> pointed out later to me in the list, and felt obliged to finish
> implementation by providing the feature.
>
>   --diff-merges=hide
>
> is exactly that.

This is exactly the "immortaliz[ing] a mistake" that I mentioned
upthread, by turning a UX wart (-m doesn't imply -p) that neither of us
likes into a feature. I'd be in favor of getting rid of the wart
altogether (i.e. let's find a path that lets us make -m imply -p in the
future), but not rebranding it as a feature.

>>> I'm not convinced that the series makes sense without
>>> "log.diffMerges-m-imply-p":
>>>
>>> * The main patch is
>>>
>>>     diff-merges: implement [no-]hide option and log.diffMergesHide config
>>>
>>>   which gives us a way to redefine "-m" as "--diff-merges=hide
>>>   --diff-merges=on". However, we haven't seen any compelling reasons to
>>>   use --diff-merges=hide [1].
>
> I think --diff-merges should be complete and be able to provide exact "-m"
> behavior, rendering the latter pure shortcut.
>
> Complete orthogonal interfaces are good thing by themselves, and useful
> applications of them are often found later. That's common knowledge.

For the user who wants it, yes, but these interfaces come with a
maintenance cost and a cost to the user who just wants the simpler
interface.

I think that our goals here are actually the same: we both want Git to
be as simple and usable as possible. We disagree on whether this series
makes Git simpler or more complex (and I don't think either of us will
change our minds any time soon), but I think we can agree on an overall
direction. With that in mind, I'd be willing to discuss other approaches
that get us closer to "-m implies -p", if you have any.

>>> I'm also fairly convinced that if we go
>>>   back in time, "-m" wouldn't have the semantics of 'do nothing unless
>>>   -p is also given', and I don't think we should immortalize a mistake
>>>   by giving it an explicit option.
>
> Yep, and I provided a config option that fixes this mistake. What's
> wrong about it? The complete orthogonal interface finalized by the
> aforementioned feature allows me to achieve this goal easily.

Addressed above.

