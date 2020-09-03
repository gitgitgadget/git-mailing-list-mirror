Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AB8C433E2
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 19:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C84720722
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 19:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="na0m0TjV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbgICTcl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 15:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbgICTck (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 15:32:40 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FE0C061244
        for <git@vger.kernel.org>; Thu,  3 Sep 2020 12:32:39 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id a65so3966610wme.5
        for <git@vger.kernel.org>; Thu, 03 Sep 2020 12:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XpNGYRl4A+qoNp5F+dl03UGgFXNT3D5XsASgQfFG7lw=;
        b=na0m0TjV5ANrcQncCK4tKyBZkMsKQJO9q16BKkq8Byp0syFl7telYLsdo0HFx/BTDV
         UlXLCov1VyoVqyAy3kjOezQgxM0rPCyiUOhwTRtYlDDUli0XUEHoQ/VOwz8MPialo12C
         nsMqoBp4ZU2jftnNYZXzll29W255CTqpThA4IszTATzyEFnSIf8RxjaMLjX+pN8sx8hp
         xIzpD/Oiuqv+iP2x8vo3dXokJANkBFyDQ4bFblNLoHmqR4bNhvHWvCAsDhjReURAqFuK
         3AzszUmxCeiVEmA+XQ0UF9YhHabI5/Ax7Xe72rqSRnD5X1JXSfhnP+Mb7k1RtOnmKkUN
         FFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XpNGYRl4A+qoNp5F+dl03UGgFXNT3D5XsASgQfFG7lw=;
        b=ShbGM5vhPAmXjKJRXyR5fSS8E4LyGo8mYyaJnMoic2e+8A2WUvEmcQ81xLGROvaJMC
         H7hp6lNcCfONVCfRfaTH3BxcbEDWU9ntii4Q6gXpUWmZJzR4byi0JoeK399aLV1ATx6D
         rkiyHJv+XOozUmBOJ8nt4jEc1r3/Bxco5csACSqZr3/ZFznxXoeVJQOXntTJO2Ck0aeY
         kjvl8LGDtbTAC77Tweg0nx7KFpLf6HsiURuaAJJucK2hWJvUFvLH0bdi3ve/wn4HFgSL
         Aot5j9FwJKqYEzCeG8ZAiEJlmI9gzx+JRumhCBCuWgESchJG9uQc7YVNZsS/cl4kRSUG
         Rx5Q==
X-Gm-Message-State: AOAM5339/SGyna5PKbxtOsW965ZSP93U0gKV76ZQmYQUWyDAK1Ug3ATo
        4yZZviLNrgLk6oofjZQPe3rGB7KV03rfKXBdptE=
X-Google-Smtp-Source: ABdhPJy3HK8+mI9n72hNF93fR/U8HeCN4EIgPBFbDAhbJ01aFqwxwErY8Cy7r/bz/BY7XB9Z1v2SxI+lej3F9vShQH0=
X-Received: by 2002:a1c:9c13:: with SMTP id f19mr3449569wme.97.1599161558500;
 Thu, 03 Sep 2020 12:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAG0OSgeb0jcUmkjp+yzCPYkxQWCZFy3gYM9o7TfBGvtf4M08NQ@mail.gmail.com>
 <xmqqa6y6ah8h.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqa6y6ah8h.fsf@gitster.c.googlers.com>
From:   Victor Toni <victor.toni@gmail.com>
Date:   Thu, 3 Sep 2020 21:32:09 +0200
Message-ID: <CAG0OSgcUi6sKJQmUEd4-Lu5qAiQqKk7X7aSRvRtcBWkcKj4f1g@mail.gmail.com>
Subject: Re: Aborting git rebase --edit-todo
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> It is rather unusual (or almost always wrong) to have a totally
> empty commit log or initial todo list, so it is understandable for
> Git in these situations to stop without doing anything further.
>
> There is no other sensible interpretations of what you are telling
> Git to you by returning an empty buffer---it is extremely unlikely
> you want to create a commit with no log message (without explicitly
> allowing it with --allow-empty-message, the command is likely to
> fail anyway), and it is extremely unlikely that you wanted to just
> reset the tip of the branch to the --onto commit.
>
> Once an interactive rebase session has started and you are given the
> remainder of the steps to edit and you give an empty buffer back,
> however, there are two possible interpretations that are equally
> sensible, I would think.
>
>  - One is that you are signaling that you are done with the rebase
>    session and all the remaining commits are to be discarded.
>
>  - The other is that you botched editing the todo list, and you wish
>    Git to give you another chance to edit it again.
>
> I think the implementor chose the first interpretation.  The "drop"
> insn is a relatively recent invention, and back when it was missing
> from the vocabulary, I do not think it was possible to say " discard
> all the rest" without emptying the todo list, so that design is
> understandable.
>
> Now we have the "drop" verb, the latter interpretation becomes
> possible without making it impossible for the user to express the
> former.  It might be a good idea to
>
>  (1) save away the original before allowing --edit-todo to edit,
>
>  (2) open the editor, and
>
>  (3) when getting an empty buffer back, go back to step (2) using
>      the back-up made in step (1).
>
> Either way, the todo list editor buffer can have additional comment
> instructing what happens when the buffer is emptied.
>

Personally I would like to see your approach (1,2,3) implemented
because it is not destructive. If the user wants to achieve something
different he can retry.
Option / interpretation a)

>  - One is that you are signaling that you are done with the rebase
>    session and all the remaining commits are to be discarded.

is more difficult to recover from. (I'm still thankful for `.git/logs/HEAD`)
