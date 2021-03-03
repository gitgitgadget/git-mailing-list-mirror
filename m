Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5797CC433E9
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D62864E56
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355292AbhCDAWE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1579047AbhCCHdy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 02:33:54 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660BAC061788
        for <git@vger.kernel.org>; Tue,  2 Mar 2021 23:33:13 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id s3so22685740otg.5
        for <git@vger.kernel.org>; Tue, 02 Mar 2021 23:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vDeMRxSRqbqmAZ/eKxBYkRnY8T35Et356OZqoqgETbU=;
        b=P7dP485im+Uof4u49q6XIOyXaMrvXk1+BluO5fFDns86u/r6PS6vjXqWbzgzkywAHP
         6tREoWk6qYJg5ZnOrEzH3Le/p3SUlzFzTWG6XDARTncfR3w6BsUaVHUAMNZhOeUqhd3l
         zqFcPI3f8vtR9vWrrUGXBbxtKHku41QDWtFdTGWPfbzqG5gIgKTFZ1igbgXdJiu+15it
         K4Zm9CotXVxeNuRhekc8paiofDcwnZaE5dqp19bhdUjSyOA7nAUM+FUXltITJqdRlHPx
         /1qqXwtEfOZy9lwl1MkN5NZKS+ebhqgSqapTGthTWfYw6e2ShWJJj+yvTwiK03zo7JhB
         w92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vDeMRxSRqbqmAZ/eKxBYkRnY8T35Et356OZqoqgETbU=;
        b=sESAmP6qsBddysDSP+WyFZP4jBCl/ATDerksX0gX7IAqcbjvs2BI3suNP4s5gSnLC5
         02Z2V2REkdZTZAoIwtkHoTJ3T/uh+zZgIkob8huZJ/rYBnXi4SaI9KvnASuKsNYX1M0d
         Aldb9RREcox3Jkviust29kvp92LnEnur1tRL9XaQVi6fRk9Dm2xQLKW9y0XfAjzUg9Is
         Cf+f1Iau1y0smQ7Lrg7ryC7G8bHoiixkG553pZBiCGYvn2JgOcQF3yQKrMdZLYgDWa5f
         h4As0/ZJfsXboPCiSKHSW6mUOB7/0p6dzURQ3+lNci4RhD5ExHH+n5i9IXA5QNtb0kjh
         7KDQ==
X-Gm-Message-State: AOAM533Usy1o2kbzrTyAfRrUnUUIU9EL5vMukqax63yHpe/DprElMzUZ
        Wn67cJhG/Vd/67+OdfF96YdoXRA3KVRQsetNjWg=
X-Google-Smtp-Source: ABdhPJwzTuTKYtb3UfI/TWKF2QSgYIA4AF66kLtBz0wZeraGBWlMNtyI9Wh2ske3Y9ZRrj9DnL+zf0SwzYfiBc2PQjE=
X-Received: by 2002:a9d:6b8b:: with SMTP id b11mr21531239otq.210.1614756792837;
 Tue, 02 Mar 2021 23:33:12 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210301084512.27170-4-charvi077@gmail.com>
 <xmqqh7lura1j.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqh7lura1j.fsf@gitster.c.googlers.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Wed, 3 Mar 2021 13:03:02 +0530
Message-ID: <CAPSFM5cgwX+NfsJ7Rib9xk0RGhTo4C35s2vTRG_Qxny=mwPk0Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] commit: add a reword suboption to --fixup
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2 Mar 2021 at 00:11, Junio C Hamano <gitster@pobox.com> wrote:
>
[...]
> > +     if (argc)
> > +             die(_("cannot combine reword option of --fixup with path %s"), *argv);
>
> I think our convention is to quote '%s' with a single-quote pair.
> See other error messages.
>
> commit.c:                       die_errno(_("could not read '%s'"), templat...
> commit.c:               die_errno(_("could not open '%s'"), git_path_commit...
> commit.c:       die(_("--author '%s' is not 'Name <email>' and matches no e...
> commit.c:               die(_("Invalid ignored mode '%s'"), ignored_arg);
> commit.c:               die(_("Invalid untracked files mode '%s'"), untrack...
> ...

I admit I forgot to add it. I will fix it.
