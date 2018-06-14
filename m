Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96A7C1F403
	for <e@80x24.org>; Thu, 14 Jun 2018 19:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754749AbeFNTXW (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 15:23:22 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:41893 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754695AbeFNTXW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 15:23:22 -0400
Received: by mail-yw0-f196.google.com with SMTP id s201-v6so2532266ywg.8
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 12:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZwiiXy8dfps4NLfMviMB3jle0GNnjz2XczC6dbw6KTg=;
        b=BGKc1frfoethj0Wiv2ewZtwqb8BVAlcODXF6FoKI1RAeid7RJHRjXX+I6a0091C92z
         5uQ/GiQ6ishSd9bem5LFAsfcT26WM2aSBP8UHoN4EfWzsJjhOl5HLPPBtlhU6D/SvQd4
         RsPsEKkAWeqg0w9we21//vdyzFfWylHgc3yMkR4q/vucUYQ3eiwg7CB0wXUQ//7XKXJe
         eCqyLmTckSholME0Kww9YGmXhQ5zYJUwCW7L7p+67f0LoIlNoqYs2+3eGRiJAhK0rZUP
         f6BKZVqCPzS1yEV1Re2UpfgiV4WmHdbNJZSlc5Xs+MBPmijf9NJyDKgj7qbkcKK1pWAl
         H8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZwiiXy8dfps4NLfMviMB3jle0GNnjz2XczC6dbw6KTg=;
        b=mg18fRTg6rNYqqwGAcjie6pt6aWiReC68ideUYTFAcEY4G9ZKaO6zLREuAHXNaJk03
         e6hac4L5um7Ha0/3sBRhURPpJ3z/D2+pQiQ20jid/78w3AKykdMvCDdiegGMzCKmbNjm
         iS9rwylFEh0M4LjqjhZhbWERSynQ5gwYTyNZPT4jyRsF2B3TJNpidglSTvBFfUUwR+/x
         25DwhEvwWrHxP1JqSSFK0eciVwGC8jhWnEXPyvz4ZItJz0roaquow+Qor4HfjqHth9H1
         8JF5Q+OWx3BEAnnFo/u8ApBIXzgAuTSrkOYzlsi4Y/o+4rhzLWUxuluRvBIkI0dUowjH
         37MA==
X-Gm-Message-State: APt69E1tdze51t3637zM0J72YMWkq0Eohwf1dbixZJ1OxHEuWn2r289i
        XTy/tFKW8T3/76OC98vphu/k2CIyopTfZrRWu8i4VA==
X-Google-Smtp-Source: ADUXVKLINLcx0UV8T4x8f0s08FChTFhyyNqxfdd4b/nseSAcWC/p/Z+krO+yAe94I1huFyuDSWGJ+FwiffLRmzC8RrI=
X-Received: by 2002:a81:360a:: with SMTP id d10-v6mr2239057ywa.421.1529004200964;
 Thu, 14 Jun 2018 12:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180605175144.4225-1-bmwill@google.com> <20180613213925.10560-1-bmwill@google.com>
 <20180613213925.10560-4-bmwill@google.com>
In-Reply-To: <20180613213925.10560-4-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 14 Jun 2018 12:23:09 -0700
Message-ID: <CAGZ79kake79otttmGaD3nUgK=d+HQPwhjDtW9EWNaiqTO9SqLw@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] upload-pack: test negotiation with changing repository
To:     Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 13, 2018 at 2:39 PM Brandon Williams <bmwill@google.com> wrote:
>
> Add tests to check the behavior of fetching from a repository which
> changes between rounds of negotiation (for example, when different
> servers in a load-balancing agreement participate in the same stateless
> RPC negotiation). This forms a baseline of comparison to the ref-in-want
> functionality (which will be introduced to the client in subsequent
> commits), and ensures that subsequent commits do not change existing
> behavior.
>
> As part of this effort, a mechanism to substitute strings in a single
> HTTP response is added.

This patch looks good to me.
Thanks,
Stefan
