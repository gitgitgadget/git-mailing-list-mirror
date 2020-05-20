Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435EAC433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 16:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DD4B20759
	for <git@archiver.kernel.org>; Wed, 20 May 2020 16:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHkooo92"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgETQcV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 12:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETQcU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 12:32:20 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209A3C061A0F
        for <git@vger.kernel.org>; Wed, 20 May 2020 09:32:20 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id r25so3498129oij.4
        for <git@vger.kernel.org>; Wed, 20 May 2020 09:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vvHQTVlg4VF+53ai828MvybWgCb+oc+5Vjo+3BXo9Fg=;
        b=fHkooo92ID4datweTpZ6zdTrHFNbGyKexO+m9MRFvBfAAu8llbbrzeHG/UV1bnMO8w
         7thDhbKWompabhiY1eS15pM82yAsLqtAN519mWaDPLQY8kAXGeGUklRqfLc8N6cWp4LJ
         l++mksLLJUSsbVmVKGxsdwtMoX4TxJ10zFyIaOgt8iON2sxOnyf8LazbjqX+N38mu44M
         jaymLB6YlTfKfRBNgd7FoynQyce709G+u1b5Xp0QWTLsGZV4q21GLP/9PyklonWVgl7F
         cGR8wvI91dc697TtE9NkBZd+nmN+ckMIiinnz/aX5jAA4daVdvhUb9CAI+iCZWT7zsT7
         +PDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vvHQTVlg4VF+53ai828MvybWgCb+oc+5Vjo+3BXo9Fg=;
        b=oA1w7cgfxB+1sM7X+8ZZf2zw+0Vgsv7biUD+XQYQ9+YCj6iGfmLFy/erA7dtm/nsup
         9HDfHp6JTwWHROqSjZZ1vPkbSUp2aA/6Bj6FwtlFsaf28w0HUziF2FwwKjU1lMEi1D+5
         ZpjCfyTfDSU9ImaBpUsvdCrpoQABD0ApxtgpSHQEfzeIdrCynJOCVobBRnupgm10pTv0
         XFohmbpyCNOZ5SEQoPWonCtwb/hHtO1PT4UE+n+ZUHCkzJ6D87h0fCp2EBtAUzMiyBLv
         8y9EbI8/FZgv3xkVGLlT5pNLaOeo/QwwrVmsAv847zsoZHbUJgAanA/oeGafriHz44DY
         x+kA==
X-Gm-Message-State: AOAM530BZYXv9OYlJQC0iBfJt0xreOLFTRJ6Q9KZwleEEbRm46dLeITt
        rMXnl1JPCzoUiz3QJFKl4rfOEo0tyJwXtaiDlVO7p+9M
X-Google-Smtp-Source: ABdhPJydSH9rsCKokhTTSZdzD9LIPtEE3LtYtAdshotoHzZISVDL7J7A9n1u8spo1x88ykZNKRlh6WvhtMeP9HEfnbw=
X-Received: by 2002:aca:3f44:: with SMTP id m65mr3861583oia.167.1589992339397;
 Wed, 20 May 2020 09:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.627.git.1588857462.gitgitgadget@gmail.com>
 <5bfe3f3fc8a99b3d4fdd4286da17cd935090c614.1588857462.git.gitgitgadget@gmail.com>
 <xmqqk11n2xf3.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqk11n2xf3.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 20 May 2020 09:32:08 -0700
Message-ID: <CABPp-BH=DQr3cFvAvWoCOna-RV8MsWy+FNO0x4GN1QVMsYimeg@mail.gmail.com>
Subject: Re: [PATCH 01/10] unpack-trees: avoid array out-of-bounds error
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, newren@gmaill.com,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 7, 2020 at 3:29 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Derrick Stolee <dstolee@microsoft.com>
> >
> > The loop in warn_conflicted_path() that checks for the count of entries
> > with the same path uses "i+count" for the array entry. However, the loop
> > only verifies that the value of count is below the array size. Fix this
> > by adding i to the condition.
> >
> > I hit this condition during a test of the in-tree sparse-checkout
> > feature, so it is exercised by the end of the series.
> >
> > Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> > ---
> >  unpack-trees.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/unpack-trees.c b/unpack-trees.c
> > index 9a3ccd9d083..4f880f2da90 100644
> > --- a/unpack-trees.c
> > +++ b/unpack-trees.c
> > @@ -563,10 +563,11 @@ static int warn_conflicted_path(struct index_state *istate,
> >       add_rejected_path(o, WARNING_SPARSE_UNMERGED_FILE, conflicting_path);
> >
> >       /* Find out how many higher stage entries at same path */
> > -     while (++count < istate->cache_nr &&
> > +     while (i + ++count < istate->cache_nr &&
> >              !strcmp(conflicting_path,
> >                      istate->cache[i+count]->name))
> >               /* do nothing */;
>
> Eek.  Yes, it is obvious that the original is wrong once you point
> it out.  But "i + ++count" looks like a line noise, and funny way
> that lines are wrapped in the original does not help X-<.

Eek, indeed.  :-(

> We may want to fix the style and the grammar while we are at it,
> perhaps like the attached.
>
> In any case, thanks for a fix.
>
>  unpack-trees.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 6bbf58d28e..c38938d96c 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -562,11 +562,11 @@ static int warn_conflicted_path(struct index_state *istate,
>
>         add_rejected_path(o, WARNING_SPARSE_UNMERGED_FILE, conflicting_path);
>
> -       /* Find out how many higher stage entries at same path */
> -       while (++count < istate->cache_nr &&
> -              !strcmp(conflicting_path,
> -                      istate->cache[i+count]->name))
> -               /* do nothing */;
> +       /* Find out how many higher stage entries are at same path */
> +       while ((++count) + i < istate->cache_nr &&
> +              !strcmp(conflicting_path, istate->cache[count + i]->name))
> +               ; /* do nothing */
> +
>         return count;
>  }

Thanks, both.
