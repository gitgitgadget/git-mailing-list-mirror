Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9793BC433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 17:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 793B1611BF
	for <git@archiver.kernel.org>; Tue, 18 May 2021 17:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351373AbhERRth (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 13:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351367AbhERRtg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 13:49:36 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83197C061760
        for <git@vger.kernel.org>; Tue, 18 May 2021 10:48:18 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id q7-20020a9d57870000b02902a5c2bd8c17so9380693oth.5
        for <git@vger.kernel.org>; Tue, 18 May 2021 10:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tcB1lO77Wo4Bmn9mfXagwxSEJx8u10sCibhzwYNLZ4w=;
        b=ec3i0FvtLr09JgGQVBohkYPYjEoSfQLNIDbW86VQW8ZHKyQzRKmUGtPF6JvwPskpek
         XtjFi3fh2XXLtJHH7J72CwvWFuWTwRADO3HN1u/N+fH4BUgorTUN0HZlToFfsu9KcXWs
         aA4Ai5ELesZJkXJQ3BYoSyr7PvoI0mk5ho9f/DYYiR7bra0geD+ujTHMoTT9f0hYEwhW
         7/OcfA8Thxq//QPaOl63bzA4aDowWfnaW7vF1TRsNe1Lm7OufRagPu/02yFn6tv/ud5u
         wn7PnhEHupyZ/NsgptwtGLQiEe4hv/aOI5Jkr7Zh0tK/oVFlvuUYMAvO7iclAjJsQbvb
         xrow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tcB1lO77Wo4Bmn9mfXagwxSEJx8u10sCibhzwYNLZ4w=;
        b=kI/4EH5/mpFdgLR54aejFLwH1cBkRA0UzvlJWe9s28nVxYSQpvF+XtHLa0Fq0E47vl
         Vw97HvuNUOB2AB2Q3a6GqSKPAnO28KNfqWyhJZ65YNjeYc+aOht4qqs89tMjwKqrUVJf
         E2z2XgwgoiVvpADZa5a3MDyJvBAETnSLJNeN1m/R3/ucf2e4jhzFyVdezYD/r2PNWUZo
         olY2YopmghSR8YuqIZM1uroCBSRolIG1BViIhtCY+eGip4rFfJJ1k7GFmGgOrT28ejHK
         BwlE3m2s9BfsJSuPnUlisjdWja6kBMP2BDK+4JXqDIqh2HfV7Dd2U8UiFNne+F9EeSW3
         pNuQ==
X-Gm-Message-State: AOAM530uWcwDz+VqYWSePoSlMc5uf3S0jxNoDNnPnG7MgI6V0d040nki
        BIn/uat8cnxDpyGmE2P0TnCJpADU+AMwpEiFefc=
X-Google-Smtp-Source: ABdhPJyh/VaLooIbkU7jJXj6Ngs6m+FPgPDavxwTEvuh0Zhrf3vuaINL83A7Ys64UZyTxazvJ3yyD6Dxc0ciWhyYPb4=
X-Received: by 2002:a9d:67c5:: with SMTP id c5mr5094978otn.162.1621360097827;
 Tue, 18 May 2021 10:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
 <pull.932.v3.git.1621017072.gitgitgadget@gmail.com> <8aa41e749471df3bd9d593b8f55db6506eafea12.1621017072.git.gitgitgadget@gmail.com>
 <CABPp-BFx9=7j5LrLnQwzxba+i7_cAEXngzyt9rfOJfBuqOPBsw@mail.gmail.com> <ddeda8ec-bc21-1f62-5d0e-839be74f1ec8@gmail.com>
In-Reply-To: <ddeda8ec-bc21-1f62-5d0e-839be74f1ec8@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 18 May 2021 10:48:06 -0700
Message-ID: <CABPp-BHXNLTcQC=XmPoaVoy8xLKpru3yuJU1DfJVpOf_tJy8Yg@mail.gmail.com>
Subject: Re: [PATCH v3 02/12] sparse-index: include EXTENDED flag when expanding
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 18, 2021 at 7:57 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 5/17/2021 9:33 PM, Elijah Newren wrote:
> > On Fri, May 14, 2021 at 11:31 AM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>
> >> From: Derrick Stolee <dstolee@microsoft.com>
> >>
> >> When creating a full index from a sparse one, we create cache entries
> >> for every blob within a given sparse directory entry. These are
> >> correctly marked with the CE_SKIP_WORKTREE flag, but they must also be
> >> marked with the CE_EXTENDED flag to ensure that the skip-worktree bit is
> >> correctly written to disk in the case that the index is not converted
> >> back down to a sparse-index.
> >
> > This seems odd to me.  When sparse-index is not involved and we are
> > just doing simple sparse checkouts, do we mark CE_SKIP_WORKTREE
> > entries with CE_EXTENDED?  I can't find any code that does so.
> >
> > Is it possible that the setting of CE_EXTENDED is just a workaround
> > that happens to force the index to be written in cases where the logic
> > is otherwise thinking it can get away without one?  Or is there
> > something I'm missing about why the CE_EXTENDED flag is actually
> > needed here?
>
> This is happening within the context of ensure_full_index(), so we
> are creating new cache entries and want to mimic what they would
> look like on-disk. Something within do_write_index() discovers that
> since CE_SKIP_WORKTREE is set, then also CE_EXTENDED should be set
> in order to ensure that the on-disk representation has enough room
> for the CE_SKIP_WORKTREE bit.

Yeah, I think it's this part:

        /* reduce extended entries if possible */
        cache[i]->ce_flags &= ~CE_EXTENDED;
        if (cache[i]->ce_flags & CE_EXTENDED_FLAGS) {
            extended++;
            cache[i]->ce_flags |= CE_EXTENDED;
        }

>
> I suppose this might not have a meaningful purpose other than when
> I compare a full index against an expanded sparse-index and check
> if their flags match.

Ah, you're just setting this flag in advance of do_write_index() being
called so that you can compare in memory values and check they match
without doing a write-to-disk-and-read-back cycle.  Makes sense, but
it'd be nice to see this in the commit message.
