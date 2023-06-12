Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760A5C88CB6
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 18:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237224AbjFLSLE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 14:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbjFLSLC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 14:11:02 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB8EE69
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 11:11:01 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-25bf88c5989so461063a91.1
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 11:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686593460; x=1689185460;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U+tx8eYVZxSHHkJo47ScsEf8UBpBEhAgKJjKapbt8SM=;
        b=qP4zeuhQrYEHsbGvjQK+xixR7OOXC4MHIXd1bnb2ANd3py+pB6yqxxukvhI0Qk0Rdt
         QDtLEae1UOV/qwdY4rMNuj4DJFVKYNEs7nWbAON2zs74VvtXSxOVRnWj2IrKxXAFl6+u
         ozsKvD74sE65HHeryzgOAeUdddtZWAboSJVUAm+8FxVTrjJUPz7BtvS8wYJLQLYeVPE8
         TNTZsaT6a3aAHd3pt810uxiVRzhRf8GymRtNf8soRd4Fe/Vz/UWaRjSlWsPf5g0RcWwC
         ycz1H0P98GdU/OqXtFBkjGdUZkcrNiRxwLuk44H34arnkiz7NJWhsd/o9XMJdVLz7aCb
         oppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686593460; x=1689185460;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U+tx8eYVZxSHHkJo47ScsEf8UBpBEhAgKJjKapbt8SM=;
        b=YpJm18KFORFIVZHkGQHrL1WZLRaVCdD4cCQ2HQCXDEjOe9xxCsvL6IUSoSm6kYPNmz
         fg1i6sCyrbH2VgHVzSIvsZdZbPH5Ywsx7WLLcWzgsUcT2V6j3hpml1vCecsSU8gqJAVL
         n15qATcSmivapsfwiY8P1bV06YkJSjvpo+uIAyTgn+UP2F4Vqg86S5Q5tTngRNYKAJHj
         6q3w/GCleunWEsBsi3dEQ3RLd7QD4smK3wIhfncBNeVf1BGMoi9fdKY0JHLUjXBwZ7+F
         jRs24Tt8gNXUYRaC/f6gXUo0lnf9jhnqQ6tYR55vr/gaJBY9nXHu2BaKacaPOk1yWNkt
         gnOw==
X-Gm-Message-State: AC+VfDyuZXJgEsiovu/vUs6KaX0t3jbgcr/qLmUUr4KaRYU0XSfBshuS
        pBnHC7aMUMx9RZ0V9/oY1QBk7TX6Jpr9Dw==
X-Google-Smtp-Source: ACHHUZ4+BLOHlXczQbCW+jHcU4mjcUmxk7L/JPn2dtyuatqqtEsd3E4n9AgOfEmiSms8wp6Ep0fwjwJc+qVudw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:90a:e552:b0:25b:d9be:ef79 with SMTP
 id ei18-20020a17090ae55200b0025bd9beef79mr787254pjb.2.1686593460453; Mon, 12
 Jun 2023 11:11:00 -0700 (PDT)
Date:   Mon, 12 Jun 2023 11:10:58 -0700
In-Reply-To: <49509708-c0a1-2439-a551-cab05d944b66@github.com>
Mime-Version: 1.0
References: <pull.1536.git.1684883872.gitgitgadget@gmail.com>
 <pull.1536.v2.git.1685064781.gitgitgadget@gmail.com> <506a2cf8c73549bc8f9761b56532ef08ed220da4.1685064781.git.gitgitgadget@gmail.com>
 <kl6lr0qwno2q.fsf@chooglen-macbookpro.roam.corp.google.com> <49509708-c0a1-2439-a551-cab05d944b66@github.com>
Message-ID: <kl6lttvcft59.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 3/3] repository: move 'repository_format_worktree_config'
 to repo scope
From:   Glen Choo <chooglen@google.com>
To:     Victoria Dye <vdye@github.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Cc:     derrickstolee@github.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> For example, in addition to what you mentioned here w.r.t. '.hash_algo',
> there are also differences in how 'repository_format_partial_clone' is
> assigned: it's deep-copied in 'check_repository_format', but shallow-copied
> (then subsequently NULL'd in the 'struct repository_format' to avoid freeing
> the pointer when the struct is disposed of) in 'discover_git_directory()' &
> 'setup_git_directory_gently()'. 

Thanks for the analysis and explanation. It's quite a pain that the
various sites are similar but subtly different.

> If we were to settle on a single "copy repository format settings" function,
> it's not obvious what the "right" approach is. We could change
> 'check_repository_format()' to the shallow-copy-then-null like the others:
> its two callers (in 'init-db.c' and 'path.c') don't use the value of
> 'repository_format_partial_clone' in 'struct repository_format' after
> calling 'check_repository_format()'. But, if we did that, it'd introduce a
> side effect to the input 'struct repository_format', which IMO would be
> surprising behavior for a function called 'check_<something>()'. Conversely,
> unifying on a deep copy or adding a flag to toggle deep vs. shallow copy
> feels like unnecessary complexity if we don't actually need a deep copy.
>
> Beyond the smaller subtleties, there's the larger question (that you sort of
> get at with the questions around 'discover_git_directory()') as to whether
> we should more heavily refactor or consolidate these setup functions. The
> similar code implies "yes", but such a refactor feels firmly out-of-scope
> for this series. A smaller change (e.g. just moving the assignments into
> their own function) could be less of a diversion, but any benefit seems like
> it'd be outweighed by the added churn/complexity of a new function.

I don't agree that this refactor is out of scope. I think we agree that
the refactor is desirable, but if we apply the same heuristics in the
future, the next author to copy a member from 'repository_format' to
'repository' could do the same and we'd never end up with the refactor
we wanted. I strongly feel that if we don't put in a concerted effort
into such refactors along the way, we end up creating more of the churn
that made our lives harder in the first place.

I sympathize with the 'out-of-scope' sentiment, though, and I find it
frustrating when a simple change starts growing in scope because a
reviewer suggests fixing oddities in the codebase that I didn't think
were in scope. In that vein, I think the helper function can simplify
the in-scope things even if we punt on the difficult-to-reason-about
parts.

E.g. we could support both deep and shallow copying, like:

  /*
   * Copy members from a repository_format to repository.
   *
   * If 'src' will no longer be read after copying (e.g. it will be
   * cleared soon), pass a nonzero value so that pointer members will be
   * moved to 'dest' (NULL-ed and shallow copied) instead of being deep
   * copied.
   */
  void copy_repository_format(struct repository *dest,
                              struct repository_format *src,
                              int take_ownership);

And in discover_git_directory(), where we don't copy .hash_algo, we
could leave the code as-is and put a FIXME to figure out if we should
use the helper function or drop the copying entirely.

(I'm somewhat convinced that we can just do shallow copying, though.
Inspecting check_repository_format() shows that it calls
clear_repository_format() right afterwards, so we really don't need the
deep copy there. Using shallow copying seems to work just fine here [1].
I'll ping Jonathan Tan to see if there was a good reason to deep copy.)

[1] https://github.com/chooglen/git/actions/runs/5246795137/jobs/9476098535

> In any case, sorry for the long-winded response. I'd initially tried to
> implement your feedback, but every time I did I'd get stopped up on the
> things I mentioned above. So, rather than continue to put off responding to
> this thread, I tried to capture what kept stopping me from moving forward -
> hopefully it makes (at least a little bit of) sense!

Thanks for being receptive to the feedback in the first round. I really
appreciate the response, and I agree that discussing this was a better
way forward than being stuck.
