Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77BEC433FE
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 01:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7762E23406
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 01:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437984AbgLLBGL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 20:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437982AbgLLBF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 20:05:57 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A2DC0613CF
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 17:05:17 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id q18so3230774wrn.1
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 17:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jaOIEKVHA+FNpdxSSFQMP+9csrvUTpz7GVYgX/++5+o=;
        b=HgOKN9aM/mCV6ygK/PqjAFnitmaJZGwHXQzmzjZX29Oy8pT48iKvmJOhfhY24q4RRm
         ibxXEDS/K4c232fap16tAgRNHyUfs1t4RCJzkcEAZfMIfK7K2wlSs3GPz7mZ/GV1BO8j
         3v1XkJxgRuIwYqrE8zAySeToHHQbFfwfepvVKTmgWtE/NIQB5lMQihko9E4ct0ww/Ljb
         wVb6OHwfuUgvoBXt0WhFQ20dSTaGb4mqPa7jxide6eGj5Eg3mVzOe8N4Dj4FBGcYpATb
         tGF03FscREXABR3vWBIE/SndaKo3zx4HEX3MvA27HjZ6oITR90MOZMnDldrx1nhXRs/h
         Rmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jaOIEKVHA+FNpdxSSFQMP+9csrvUTpz7GVYgX/++5+o=;
        b=m0Tp625PY6Ct/0T4/r5Gm814okxyjz+At3T2mVYVkTbdsiQKaWrPDUqrCrZ1yyB5gF
         3qxcBt5FFcD8XRFfNV2U9olQUzX1JqwRzS8/+fU10bPnzA+Ykztc7+0WXLvoz6DSlIKt
         6ih2dqWnMJ4a7IAdsfbyJm9CQAZ9gg1a5+RuRRAS2Lod0Ai5cfUfZirYIEqfjZW/7mZc
         /CBm9HTlHmYsxIuX2zFFjZ67psAROs8nZ82TKJjBas5Eg5GUpaV4dCEzYaMUlc4976JJ
         l4f8IL23s9qdCRWfZEtBU1QtgkskdmaS/BGQdHyC0bt5qPdy0z/xNHC9E8FvRiiDh+pO
         EuhA==
X-Gm-Message-State: AOAM533cKei9VBOHjLBA78xL6Uy44sCp8Z5+mLhAFd471FXJVFdc7R1Z
        S3RRFoU3QSCu1xH6maZ+MqZZ0hWIQs+24UXjBRMxhL6dHSA=
X-Google-Smtp-Source: ABdhPJw16cc8BDhLg9pFRAjQhMoNt2YaYOGRx3A+fMTCETPwvA0wm25Ap5x448QEG/Q7S2GeheUmLkmWzroJdzJQq8A=
X-Received: by 2002:a5d:68c9:: with SMTP id p9mr16662553wrw.139.1607735115891;
 Fri, 11 Dec 2020 17:05:15 -0800 (PST)
MIME-Version: 1.0
References: <20201210100538.696787-1-felipe.contreras@gmail.com>
 <20201210100538.696787-3-felipe.contreras@gmail.com> <xmqqy2i4ltnv.fsf@gitster.c.googlers.com>
 <CAMP44s170qZuZqmh_gVLGgJJ5005HzDM0fdQKQamjHkZCOu7_Q@mail.gmail.com> <xmqq360bj3kt.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq360bj3kt.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 11 Dec 2020 19:05:04 -0600
Message-ID: <CAMP44s1v+ESk9y8WC8rKPb61KD_kUoM9F1gO-TZhEEgOzUAPTw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] pull: move default warning
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 11, 2020 at 6:00 PM Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:

> > Should actually be something like:
> >
> >         if (rebase_unspecified && !can_ff)
> >                 die("Not a fast-forward; must either merge or rebase");
>
> The illustration I gave in the message you are responding to was
> made in the context of patch 2/3; with patch 3/3 where can_ff
> exists, it would not become like what you gave above.  It should
> instead become
>
>         if (rebase_unspecified && !opt_ff && !can_ff) {
>                 if (opt_verbosity >= 0 && advice_pull_non_ff)
>                         show_advice_pull_non_ff();
>                 die("not a fast-forward; must merge or rebase");
>         }
>
> i.e. when we can fast-forward, we do not trigger the "you must
> specify rebase/merge" message, and we do not trigger the "not a
> fast-forward" error.

It's not the !can_ff part I'm trying to highlight, it's the lack of
advice *after* we have decided to flip the switch.

As I said in another thread: I don't think we have any long
condescending error in any other command.

Cheers.

-- 
Felipe Contreras
