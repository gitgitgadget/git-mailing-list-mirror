Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A767C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 15:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F49661B71
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 15:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbhG0Pw3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 11:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhG0Pw2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 11:52:28 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D36C061757
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 08:52:27 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id l17so16544646ljn.2
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 08:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gx6PNDjhlgELwu1M5yYvzcXFX0nl2eTDJIihw/D6y54=;
        b=pMQGU4tHCbI+ADq9s3qg6wyTO4TiYjgfyDI7aLKLt57Rm2VbWlYw1BtPtsbsXXYzcG
         vTVnHmM65dIvmDeGL3Dse4RWjJ/7uhT1tsDK//TTONuUDNxhpPZp9OQKCS3MqRKkgXyP
         wePl0G9xsJgDszrJuzM7wZfKlfBa7Keo9tNBd0bsZpLoaHWE5Y5rs2TAYV5MxXbkoS25
         uv/YTCY67eylxQQmHR1Xoq3n+WEpUdHIP8omIYsNEL2AgwT/81iZF5F05g+bW5gPXg6E
         RuVi5QpFLFLsLf1lQNcmhwG9R8pBppqfaRmiCyKUAg/d0rpTCwzZDWa1kjK6uFBXrWCk
         4siQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gx6PNDjhlgELwu1M5yYvzcXFX0nl2eTDJIihw/D6y54=;
        b=d8F4EEf1LydvFT6BuDyiH9g8ihFmugTkaDaI9L0SmXCj81/u3NMaTK20974th+kgKr
         L8zoivAbYKvyN/dGEXiNWfvOOtM9Y9ooRdoKI/gitXhIbN3oFIHs+OFlHp8vQDylLC7E
         qMnoeIDpTmrYkndYJinpvphTQEa37BONNx+/YfsUFTY9OM8pysV+GPtezzzDQmy7OKl9
         ymrdgFl1CpSGQifUy3H50A674dr6ar7rY3xSuA53s5bUlQJp6r3W+IpNqtEEYm2wcFkI
         d2kB8zd9KDKBCjF8S9Z4c46uxjJfxeFvfW9PazzE8pjxitVqN7XAC9JZ4xsNP2pnzwup
         /d9w==
X-Gm-Message-State: AOAM533RFIIBGyhyRl3+Djdp2Dx+vYs3cebUtg8XfOz+RBh6kqhCcQVS
        UcRawD5ODn9/1MLnAMplgWQ8NmjfjczfYLrGUUk=
X-Google-Smtp-Source: ABdhPJxjIT5ofVCI9/WuQSRM/7DfSloz97rUQy7IMrkORyxd6fOnHhsoYmgYq175Ijiwrmw4J+RKekG6T1SjYpun1AE=
X-Received: by 2002:a2e:94ce:: with SMTP id r14mr16042268ljh.36.1627401145895;
 Tue, 27 Jul 2021 08:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210721134650.1866387-1-felipe.contreras@gmail.com>
 <CAHk-=whf-9kNV3y5G-VVA2K5EZCnvv94paAEj6p=i2R4RM2emQ@mail.gmail.com>
 <xmqqeebregns.fsf@gitster.g> <CAMMLpeTL92cDmMHsE3iuhHQrVjwLFWHxE0CwD+uDBoPGAQCrkg@mail.gmail.com>
 <xmqqwnpcdu1w.fsf@gitster.g>
In-Reply-To: <xmqqwnpcdu1w.fsf@gitster.g>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Tue, 27 Jul 2021 09:52:14 -0600
Message-ID: <CAMMLpeQ-Qpct4TX__KVuCyjbgxtB49qTMRHYc9R9-o0cRu4MuA@mail.gmail.com>
Subject: Re: [PATCH v2] pull: introduce --merge option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Git List Mailing <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 27, 2021 at 2:45 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
> > Junio, would you be willing to accept adding -m without adding --merge also?
>
> My gut feeling is that "-m" without "--merge" in the context of
> "pull" is extremely unlikely to fly well.
>
> As "git pull" is a "git fetch" followed by a "git merge" (or "git
> rebase"), it takes the union of common command line options from
> both phases, and "git merge" takes "-m 'message'" which is an option
> fairly familiar to users (since it comes from "git commit").  Even
> if we are never going to pass "-m message" from "git pull" down to
> underlying "git merge", squatting on short and common "-m" would be
> a bad idea.

Thanks for the explanation. I forgot that "-m" usually means
"message". That does seem like a good reason to not use "-m" for
"merge".

-Alex
