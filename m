Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3F1C678D4
	for <git@archiver.kernel.org>; Thu,  2 Mar 2023 00:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjCBAh4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Mar 2023 19:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCBAhz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2023 19:37:55 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2BA30F0
        for <git@vger.kernel.org>; Wed,  1 Mar 2023 16:37:53 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id in9-20020a17090b438900b00237161acdfcso415305pjb.1
        for <git@vger.kernel.org>; Wed, 01 Mar 2023 16:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677717473;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DXjUBD0868y7Z4bgjCQTVZdh3VsefEw0y3rxRfqT/gc=;
        b=nC4Pc7ED+xGaV35c0ZtIKalfueH8FaeZGTl2dSyVwfLbeq1Z2/NpDTSs7mlzpBXNoD
         7qKze8QsYBGiKU13THOxhOdBBw2GU5T6jYCl/+2Y83VY9qyg5yfhaItyDAjCTMVUALqZ
         yVKMQ+s1IiRBSLeeVYuNqOPcAWZdUm5Kbo36KGyYtAx6rjtBRKRxo01JPv9N8eAXIfLX
         jTvTGBBo+zV3bYpaTLnD7digxLeHrs8mu7sSdUNGGuNuI5wn6zRUWlvlpQ340ik7vZ9B
         pM/3wrjK3RYXTWu+SMy3vl577QWlDVeRBGKaqTPk/pOvXt3o43UWICoD2jGXEsILT7Ne
         uf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677717473;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DXjUBD0868y7Z4bgjCQTVZdh3VsefEw0y3rxRfqT/gc=;
        b=qPms3tpnjnUySsahmUUzyKUefSqBWzqKZ/pT39KLT8kiJZ/C/Y3g/VLPh4eDVqbwVp
         Nvr9HPgj88lzFcxaIPHh8heKmLByLqai6YYdoS5V+ZPICy4+X3hoolT9Z3U5zXGGT80Q
         Ml8a1FZCZEkYZLzaeQ997rKdAKHHNS4WXLg8m83J/wVI4CbZB7/fhTrD/d/ERomppcf3
         d2wgFg6Jf+XHhDqdWcSmgOHQqm+4m58Mgecu34ijjJafAiGwnJ/2rEaJfAx+NgLeVeu6
         /HAt88ofdFLqOxxFpt2jTRT/R5NwlMfsiN+aK6ZTqj/Wg6NxrpWL3L4Nu2koHTFpz8fG
         liug==
X-Gm-Message-State: AO0yUKUAoaqructF1PvSzijTOYSTmg6YW6Ic01/9rLubofpz6uoi3fKf
        OZqa1Cj7+mgNIvH17rDhahWP4+maoMT1ug==
X-Google-Smtp-Source: AK7set9yVNh+o9ALANXzZ0zGn71BuWH6Y/XRcnD0IUDFlX1VFdbJpk4LT21V7nUb2zmWRJdObwu5iPy7B31TNQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:d49:b0:592:5696:89ee with SMTP
 id n9-20020a056a000d4900b00592569689eemr3160604pfv.3.1677717473170; Wed, 01
 Mar 2023 16:37:53 -0800 (PST)
Date:   Wed, 01 Mar 2023 16:37:51 -0800
In-Reply-To: <87wn4tej2f.fsf@osv.gnss.ru>
Mime-Version: 1.0
References: <xmqqr0v7o0pp.fsf@gitster.g> <871qn5pyez.fsf@osv.gnss.ru>
 <kl6lr0v2i0gn.fsf@chooglen-macbookpro.roam.corp.google.com> <87wn4tej2f.fsf@osv.gnss.ru>
Message-ID: <kl6lh6v43s4g.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: so/diff-merges-more (was Re: What's cooking in git.git (Feb 2023,
 #01; Thu, 2))
From:   Glen Choo <chooglen@google.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

>>   If the goal is to reduce typing, then we could add a different CLI
>>   flag that would behave like "-m -p", or we could teach "git diff" to
>>   accept proper single-character flags. Either of these options would be
>>   more discoverable and cleaner.
>
> The only drawback of this is that this leaves "-m" inconsistent with no
> apparent reason.
> [...]
> Then, out of curiosity, what do you think was the reason to change
> "--cc" behavior to match that of "-c"? To save typing? To me, changing
> "-m" accordingly is an improvement to the overall feel of git interface,
> the same way as changing "--cc" was.

FWIW, I agree that having an inconsistent "-m" is quite an eyesore, and
there isn't a particularly good reason for it.

The unfortunate reality of Hyrum's law is that some 'mistakes' or CLI
cleanups are difficult or even downright impossible to fix. I'd consider
"-m on its own does nothing" one of those.

> All you say is understood and are valid arguments, but then we will
> continue to face pretty valid confusion of why "-m" behaves differently
> from "-c/--cc/--remerge". I personally don't care, provided I get a way
> to make it behave sanely, and that's what "log.diffMerges-m-imply-p"
> patch does.

We could say, e.g.:

  "-m" is inconsistent, but we can't change it for backwards
  compatibility reasons. Please do not use it, use "-d" instead, because
  that is more sensible.

> As a kind of complaint, it was simple 1 patch from Junio once upon a
> time to change "--cc" to a sane behavior of implying -p, and now it
> takes rounds and rounds to do the same for -m. This is rather sad.

It is not because Junio has special privileges or anything of the sort,
though. My understanding is that it was just an accident that "-m"
_happened_ to be misused by enough people that we deemed that breakage
unacceptable, whereas "--cc" just _happened_ to be fixable.

FWIW, I might have also been on your side when we rolled back the first
"-m" implies "-p" change, but the consensus since then is that breaking
backwards compatibility just isn't worth it in this case, and it would
take a herculean effort to change that consensus. It might not be
completely impossible though, more on that later...

> Finally, event without "log.diffMerges-m-imply-p", the rest of the
> series still makes sense, so if the conclusion is to remove it, let's
> still merge the rest, please! Let me know, and I'll then remove the
> patch and will change documentation accordingly.

Oops. Sorry, I missed this the first time I read this message. This
alone should have warranted a response.

I'm not convinced that the series makes sense without
"log.diffMerges-m-imply-p":

* The main patch is

    diff-merges: implement [no-]hide option and log.diffMergesHide config

  which gives us a way to redefine "-m" as "--diff-merges=hide
  --diff-merges=on". However, we haven't seen any compelling reasons to
  use --diff-merges=hide [1]. I'm also fairly convinced that if we go
  back in time, "-m" wouldn't have the semantics of 'do nothing unless
  -p is also given', and I don't think we should immortalize a mistake
  by giving it an explicit option.

  All the other patches in their current form are dependent on this
  patch going in.

* diff-merges: support list of values for --diff-merges

  This only makes sense if we want to accept multiple values, which we
  don't without the main patch.

* diff-merges: issue warning on lone '-m' option
  diff-merges: improve --diff-merges documentation

  These are docs and UX cleanups as a result of the main patch.

_Maybe_ the number of lone "-m" users will shrink over time to the point
where we could make the switch? We could prepare for that by warning
that lone "-m" is a no-op now, but might imply "-p" at some point in the
future, and then after X amount of time, we might say that users have
had enough warning and actually change the default. I find this
unlikely, but not impossible. However, the patches don't prepare us for
this path, and that would deserve new patches and a different discussion
from what we've been having.

1. https://lore.kernel.org/git/kl6lilimepli.fsf@chooglen-macbookpro.roam.corp.google.com/
