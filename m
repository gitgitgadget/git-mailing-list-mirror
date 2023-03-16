Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C71C74A5B
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 22:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjCPWqS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Mar 2023 18:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjCPWqR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2023 18:46:17 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1A26BDEE
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 15:46:16 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5446a91c40cso29487987b3.18
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 15:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679006775;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PJrqgQKkpG4cf6e9+1p0TCzIiXpowxFnBo6HqiH1bM8=;
        b=TGTYda70zB4EUbJoD3fMfLvJaTWeGBbk4c1Cv+wLCzKo3Xc9i1333adfY3jS6//vfa
         llXBfskwhCU2qkPyJtLAjkEcVVD3Q7K+UliSQv27KyR/rNfpVcwqKtmQN14bNhsKQaOx
         SlpVTJmEZnvCkBuRVDwlSSXZXuv3l9nD8c8Ge6v+W0EzqCLHjge6NfzT9ujW1koEH4XY
         86DIExNFEpstgGOvCmT77utZwpaCdVh77qKJnPtvhAdFJsdv5i3sFugqZEJY99GJXosA
         znBTtNRiOM3MZgktye8O/BOd4MKRfLA9b4TMwxaxV5cyrNpsulMLyHwUo9jRXy0ZXU4Y
         f8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679006775;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PJrqgQKkpG4cf6e9+1p0TCzIiXpowxFnBo6HqiH1bM8=;
        b=h64K5aHSa1fRl96ajqpHfUf2LyeGSyR2ievtNeE9RD7zcmjyZBIMBUERV4q74UbVUn
         4F+uRUODwlR8vtldN6uXNG/EjnCBhDnG2Ds8jd8LqG92w882d80s/sLU+fyx+W65/Ttb
         lrNAd19UtEkfUQLKw+KcmNDhD5DO5xJld3Nl34L8ndvr2rZEYrh3yp5Otom204fds8Qx
         cRMvvcMC9S0fIrgh9lc7pH6DpjH8xuEfPdLwNz6kdLPMSSKz0fQfKDVxFrCkXGyenMPy
         un/7tSxTGpZXyM+Cse8mouDsoq5jxvK3pK4DxkQ+N+tyVMEPat+8wIe+KwrEq5nK14Di
         5Cfw==
X-Gm-Message-State: AO0yUKUnl5FoIzELUx8LQ0J+UvNWxncAH3Sm1JvyuAdM5mDYKFQGsybH
        NpQzDrwSiPxKCwntGyTlKKRxwnAC3qVcEg==
X-Google-Smtp-Source: AK7set9g3wVoUTRZ+DFgGiRIJJiC+1t3BdSGRe4FvTO6GwkqYhTg2z96oLYrG8cMQZ90o5FDkUxvACKWT+Ahqg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6902:312:b0:a58:af0b:5150 with SMTP
 id b18-20020a056902031200b00a58af0b5150mr24748966ybs.3.1679006775439; Thu, 16
 Mar 2023 15:46:15 -0700 (PDT)
Date:   Thu, 16 Mar 2023 15:46:13 -0700
In-Reply-To: <CAMP44s3hH0Gw71UAm10Os=6YJ4RAoAJxC3exN_jekMy6-JRsVg@mail.gmail.com>
Mime-Version: 1.0
References: <20230225180325.796624-1-alexhenrie24@gmail.com>
 <20230305050709.68736-1-alexhenrie24@gmail.com> <20230305050709.68736-4-alexhenrie24@gmail.com>
 <kl6l7cvsi006.fsf@chooglen-macbookpro.roam.corp.google.com>
 <CAMMLpeRGEETraueJTTV0tJSsycNYF24YX8n6h-pMp87VcCRJtQ@mail.gmail.com>
 <kl6lzg8cvby2.fsf@chooglen-macbookpro.roam.corp.google.com> <CAMP44s3hH0Gw71UAm10Os=6YJ4RAoAJxC3exN_jekMy6-JRsVg@mail.gmail.com>
Message-ID: <kl6lttykuxfu.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v6 3/3] rebase: add a config option for --rebase-merges
From:   Glen Choo <chooglen@google.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        tao@klerks.biz, gitster@pobox.com, newren@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        sorganov@gmail.com, calvinwan@google.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> --[no-]rebase-merges [--rebase-merges-mode=(rebase-cousins|no-rebase-cousins)]
>>
>> I don't think there would be any confusion.
>> [...]
>> (Having --rebase-merges-mode
>> be a no-op without --rebase-merges is probably even more confusing to
>> users, plus this would break backwards compatibility, so I don't think
>> this is a good idea at all.)
>
> I don't find it confusing. And how would it break backwards
> compatibility if --rebase-merges-mode doesn't exist now?

I meant that for the above example to work, we would need to have
`--[no-]rebase-merges` as a boolean that says whether we rebase merges at
all, and `--rebase-merges-mode=[whatever]` would tell us what mode to
use _if_ we were rebasing merges. This means that
`--rebase-merges=not-a-boolean` would become invalid.

We were in this position before, actually, with `git log -p -m`. The
conclusion on a recent series [1] is that having such a no-op flag was
probably a mistake (and unfortunately, one that is extremely hard to fix
due to backwards compatibility requirements), so introducing more no-op
flags is probably a bad idea :)

[1] https://lore.kernel.org/git/871qn5pyez.fsf@osv.gnss.ru
