Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D26C433ED
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 16:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B69B86113B
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 16:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352771AbhDNQgy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 12:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351853AbhDNQgx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 12:36:53 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298A6C061574
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 09:36:31 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id u16so3910652oiu.7
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 09:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Biv1Jnn0TKxhgEnDl7IHFxjH6D8j8XrvEjLBOrDl/8o=;
        b=Zoh/BdglToOWIG0y4a8VXxqJYH2Dw6Ui2eE06D07vdzeL8f+t1iJvZzXU68ljSffL4
         WtO8FyMoOx6EldWQ2VqXEMG5CWtPL4MCN88/hdpcVUf422p3zq2tVnB1cEOQpXyfDS+f
         DROTnA+esoN6x+xCVOfuqal1xShnxTP4wGOXAQ7Tlwe21I/rYgMXMVXPOcGUpnDE7+tE
         aXpbNCiWrXs45hnRuOgpdd0U+y1JbRpSPzowRdfl5bmWd4h3sRGjeYPzt591MQ5Pdt5x
         TOp3MjDV2goxCMYQjcUEsjTzhr2uPeyN96Q1XMkRX2TpKoCC/Hom7Df7fjhQaBZxrvol
         tPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Biv1Jnn0TKxhgEnDl7IHFxjH6D8j8XrvEjLBOrDl/8o=;
        b=etKW/LK+Tfm4qakqtAKpkYJLNjgfzhMHDoJAEtmtUj14v717RdiPuYTwhC3JWFcwA8
         BM9gqEzS9P94NnYCbKOc8D/I9jzmEKOpYjsjyZOqdVwr9HeWFyCoGkekDAkyc+Zp8EDn
         aXNFXcJV2HEVjipD5cnu7xRH+nJT7iK/F3zSath4fn4IvA8f4LKvbzaK2TEO2aXdf4pf
         jCS0A0iIddG3KzzUyMN1psFNY0CEvpmc7Dpf/I4KGisIiFeTQ6DCaFbFk8fKvzPch11y
         zgEKSR6VZKnM99NuCD8+BM93qi8J2fVFxnuMS3hwjaOJChE0DKwLnCsQzI138vDhFAYO
         RMKQ==
X-Gm-Message-State: AOAM532oOBO/CzuWiV8p0hx7peTBZwLM8en/ip/Re9JwKQ23zGWFRLBy
        y8fTsXup6UP9r6zLt417zcwd21tAIUE1WoDCLxE=
X-Google-Smtp-Source: ABdhPJxarpu4dXWdR0FREv3xwF8jPleKX5TqRcLjxyEzei9WPhvfcaePSevM66OSARtOHiiYsaY4aQ8FpJd7t4JfwFk=
X-Received: by 2002:aca:6545:: with SMTP id j5mr3020929oiw.31.1618418190471;
 Wed, 14 Apr 2021 09:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615588108.git.matheus.bernardino@usp.br> <cover.1617914011.git.matheus.bernardino@usp.br>
In-Reply-To: <cover.1617914011.git.matheus.bernardino@usp.br>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 14 Apr 2021 09:36:19 -0700
Message-ID: <CABPp-BGFfqOLg4tt85f-F-TJEXTDQFfAvRuui6VCctcd0FB5sQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] add/rm: honor sparse checkout and warn on sparse paths
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 8, 2021 at 1:41 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> Make `rm` honor sparse checkouts, and make both `rm` and `add` warn
> when asked to update sparse entries.
>
> There are two changes since v3:
>
> - `test_i18ncmp` and `test_i18ngrep` were replaced by `test_cmp` and
>   `grep`
>
> - The flag added in patch 5 now makes refresh_index() completely ignore
>   skip_worktree entries, instead of just suppressing their matches on
>   the seen[] array. The previous implementation was not necessarily
>   wrong but, as Junio pointed out, it was rather odd to keep matching
>   the entries if we no longer want to use the matches.
>
>   As "side effects", the new version of the flag also makes
>   refresh_index() refrain from both:
>
>   (1) checking and warning if skip_worktree entries matching the given
>   pathspec are unmerged.
>
>   (2) marking skip_worktree entries matching the given pathspec with
>   CE_UPTODATE.
>
>   The change (1) is actually interesting because `git add` doesn't
>   update skip_worktree entries, and thus, it doesn't make much sense to
>   warn if they are unmerged. Besides, we will already warn if the user
>   requests to update such entries, anyway. And finally, unmerged
>   entries should not have the skip_worktree bit set in the first place.
>   (`git merge` should clean this bit when writing the new index, and
>   neither `git sparse-checkout` nor `git update-index` allow to set the
>   bit on an unmerged entry.)
>
>   Change (2) is perhaps not very beneficial, but it is also not harmful.
>   The only practical difference we get by not setting the CE_UPTODATE
>   flag in the skip_worktree entries is that, when writing a new index at
>   the end of `git add --refresh`, do_write_index() will start checking
>   if these entries are racy clean. Note that it already does that for
>   all the skip_worktree entries that do not match the user-given
>   pathspecs. And, in fact, this behavior distinction based on the
>   pathspec only happens with `--refresh`. Plain `git add` and other
>   options don't mark any skip_worktree entry with CE_UPTODATE
>   (regardless of the pathspecs) and thus, all these entries are checked
>   when writing the index. So `git add --refresh` will only do what the
>   other options already do.

Sorry for the delay.  These two changes sound good to me, and the
range-diff looks reasonable.

>   (Additionally, as I mentioned in [1], there might actually be at least
>   one advantage in checking if the skip_worktree entries are racy clean.
>   But this is a very specific case, and it's probably a topic for a
>   another thread :)
>
> [1]: https://lore.kernel.org/git/CAHd-oW4kRLjV9Sq3CFt-V1Ot9pYFzJggU1zPp3Hcuw=qWfq7Mg@mail.gmail.com/

This I'm a bit surprised by.  I thought the outcome there was that you
didn't want to mark skip_worktree entries as CE_UPTODATE in order to
force them to be stat'd in the future when someone clears the
skip_worktree bit.  (And that we'd expect the sparse-checkout
add/disable command to be the likely one to handle that, though if
users use `git update-index --no-skip-worktree PATH` then they'd also
be responsible for any refreshing as well.)  Am I misunderstanding?
