Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC1331F403
	for <e@80x24.org>; Wed, 13 Jun 2018 18:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935043AbeFMSkt (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 14:40:49 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:39053 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934975AbeFMSks (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 14:40:48 -0400
Received: by mail-yb0-f193.google.com with SMTP id m137-v6so1282984ybm.6
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 11:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4396+5476EFAshDcDyDazZfWa+Api1UFcbsAj6HPANA=;
        b=Me3CRN0P1V7jyFfqTLc0z/PPeSud3ssjChu1hUFz5wKqoa9djAE6SsMik+hyT2iZT8
         KkSg7BWn3fK17Wn+8/V13sUHieK4oF46i8fIaKL9xAItdXwIvCZD9Jn2e2lZZNYYuV+M
         O9DRXxmySj8MhKYzLJLoO3/oa5coJcglV8qxDm5iMTuR0alRxnXipiJDhqwQqPQHGPJ9
         O8iMYpEDv59iaOZRqHrsSkDOEDgdva9OzB4TiiRyJ2qxriIOqBpm7qfFOz5zT9WCjCkw
         yt+qezxv0yUyirktw7B6lo5dB0ThlcF/mC7WsLFzYHCh9yrZBRAyeoZ8R/jwNRhn661I
         lpVw==
X-Gm-Message-State: APt69E1fHV8f3Wc17mMaT+BK8Lr30bfK8MFxrtm+kqzMNqRFo4X8jhJv
        XgLBk6LX9iafir1mapus7RhXn//EmML3rYVnBIc=
X-Google-Smtp-Source: ADUXVKJowg27hIEjRCEhucos7sro0mEXqJpc4Svxty1AUPFXHDnLIy5S6dSixZz6raHDJIdfMuY2mTH127Uk9EHptLI=
X-Received: by 2002:a25:a268:: with SMTP id b95-v6mr3010258ybi.295.1528915247728;
 Wed, 13 Jun 2018 11:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180613142207.14385-1-lintonrjeremy@gmail.com>
 <CAPig+cQ1s7QFjEFrOHMYZR8qja5yTjV5D3ksUXXqFL61YthA3g@mail.gmail.com> <xmqqy3fi5ygz.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqy3fi5ygz.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 13 Jun 2018 14:40:36 -0400
Message-ID: <CAPig+cR5kMissKxsA8-0kvZGPmzm=KiPcyhhH9kQBR8EN-GsLg@mail.gmail.com>
Subject: Re: [PATCH v2] packfile: Correct zlib buffer handling
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeremy Linton <lintonrjeremy@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 13, 2018 at 2:32 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > On this project, the character mnemonic "NUL" is typically used, not
> > "null" or "NULL" (which is typically reserved for pointers), so:
> > s/null/NUL/g
>
> Correct but I did not think it is a per-project preference; rather,
> "NUL is the name of the byte" is universal ;-)

Yes, the _mnemonic_ NUL is universal, but the character itself is
sometimes named or described as the "null character". I was just being
pedantic when "this project", by which I meant that we (on this
project) prefer the mnemonic "NUL" over longhand "null character",
whereas other projects may perhaps prefer "null character" or not
care.
