Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEE4C352A4
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 02:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336F22070A
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 02:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vI2O1S12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbgBKCBr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 21:01:47 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33347 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbgBKCBq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 21:01:46 -0500
Received: by mail-ed1-f66.google.com with SMTP id r21so2838929edq.0
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 18:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B0yaOO/T9GVLpbzFLcgs3X5AWuUvUR2yGGn63DOFBrg=;
        b=vI2O1S12eaKVkZI2nN29d/pGUE+sJkWJaZfOzfaX0/fIv00hiOj73kGh1RoBgtPfNr
         wfDQKxNmngLpiwtzE7Vuu79fvEPXbBHjIBzaz+8+tdqZZELLpsWsiAT5W1teJz4g93po
         EBvYx4Yk5nrlxS5JabYCfw49jFEuPMF/USp25yL/9SnMsr5biK0DJ1RHTzqPbeem1dU7
         Vl4myTAnm6S2GAv0i1t5b6U6Oh9702OQGgRlCdrla2HXfr2tDtGoiwi4yd5H8AAAfLGA
         ox7EZv577PuoV8NzJWlf94B6UsKou8djqgskfyPRoG1g6FZlvgePNQhL5MUl9YGxDzUJ
         6UcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B0yaOO/T9GVLpbzFLcgs3X5AWuUvUR2yGGn63DOFBrg=;
        b=lS4BKd9tVv+WTzD2OGi0Fuk8CmgaNaP4t28HOfA0wTvMfhf6+4c+xzv9Ci/NxWHWGA
         8KGomIwVrN9/DJFoTpMe1mL4ds9z1yA+vi0c4bIQEtctP80w7XdJPOgmAfgUCE/1kNxK
         nVc6ossX4jTdgjd2ZIpYGFoc+5hTWjJXikebfgoD8VDL2B33za3zl/qgadbm/2LJVT2g
         bFBnCq/atJ5ZTW0ZpXYN1EJsk/v6v9JBpcpq+socvkKrtQwScx1ZUbQCHyPtZ9paoM4Y
         HpVMH3XK54Rf9w1HgaOXgaYNYqqae+7NTzScVkTQlXS61CXQn+/g/GBOM8qVxvKvdaNc
         pm6Q==
X-Gm-Message-State: APjAAAWfHbZBjyrVzuq2+XZOVoa/UPwtJig8DElWYOAOoNwsB/X3MYRV
        E7Qm7iTtnnWI8imTG9YehvFZoacSb5wvh4kocUo=
X-Google-Smtp-Source: APXvYqw5f5QWXU9znuDnTzXe2g7pwm4c1GSIpYCHTN9xJ01H6WhkGCy6NUeeZduaiOEgbgu2cjJeehZJfmPiUnCmYYA=
X-Received: by 2002:a17:906:edc7:: with SMTP id sb7mr3648055ejb.367.1581386505035;
 Mon, 10 Feb 2020 18:01:45 -0800 (PST)
MIME-Version: 1.0
References: <pull.548.git.1581311049547.gitgitgadget@gmail.com> <xmqqeev2xdq8.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqeev2xdq8.fsf@gitster-ct.c.googlers.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Tue, 11 Feb 2020 15:01:33 +1300
Message-ID: <CACg5j26RAEdABySzpDEYmo4m+HDPn9jNDP087d3K9gCro4m-Sg@mail.gmail.com>
Subject: Re: [PATCH] advice: refactor advise API
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 11, 2020 at 11:46 AM Junio C Hamano <gitster@pobox.com> wrote:
>
>
> As I outlined in [1], I think the over-simplified
> "advise_ng(<advise.key>, _(<message>), ...)"  would be too limited
> to replace the current users, without a pair of helper functions,
> one to just check for the guarding advise.key, and the other to
> unconditionally show the message (i.e. the latter is what the
> current advise() is).
>

I agree with adding the first helper, specially after Peff's comments,
but I don't see why we would keep the current advise() which
unconditionally shows the message...
As far as I understand from a previous discussion [3], that's a wrong
usage that we need to avoid, quoting from [3]:
```
If there are many other places that calls to advise() are made
without getting guarded by the toggles defined in advice.c, we
should fix them, I think.
```

> >     [1]
> >     https://public-inbox.org/git/xmqqzhf5cw69.fsf@gitster-ct.c.googlers.com/
[3] https://public-inbox.org/git/xmqqpng1eisc.fsf@gitster-ct.c.googlers.com/
