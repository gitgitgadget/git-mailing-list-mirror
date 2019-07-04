Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF54B1F461
	for <e@80x24.org>; Thu,  4 Jul 2019 23:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfGDX5b (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jul 2019 19:57:31 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46626 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbfGDX5a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jul 2019 19:57:30 -0400
Received: by mail-io1-f66.google.com with SMTP id i10so15532522iol.13
        for <git@vger.kernel.org>; Thu, 04 Jul 2019 16:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NoPCEGmm+yhOXYHlRtggVPygF4gXnNm5p7FDRa1sl7g=;
        b=HqawTskvYYUzem0HiMe4ZiiXMPMqwOVK+aYdcJ655PYgLgy5wpdalZa1XBQyyjR+aN
         iVATqaRZ3rmfTfoF4jzXpIg05eI6Ndh4DY3pQrNMTx0EU8dt7EfWc+eaDGNCpK007+0a
         HFLxeX4BwWMAu8EGX/mUfA57s8FljPDsYv73ZeoZGaOaXN7Whun5yFSYzY/tW0SC0ryO
         bYI9rlzfvpk0uE8hGjuHiSg5xVnGAk924A55TAuwg66yHBH81OszcRU1PzGD5Ad15dak
         FqzeWLyI2jHAmxVSMHmEZIdCkTZ46K9UnZcykN9UTfuwDUUZ6K+Idt8+l3S2s/ILFlow
         bUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NoPCEGmm+yhOXYHlRtggVPygF4gXnNm5p7FDRa1sl7g=;
        b=j7HC2wJVDZnW+Jw9RyUv49g2UtP5Q6kRFdpXJhqPM9bBdsW8dU4/nDnDPXbWeciLYL
         48LlqiFfvl1dcGgx4XvA6KcMht5Hkz2rSe+36Z+dkIK7XBZHmd2G84K8fo6YXa7PkhiL
         Pz6KZ8e5BWx1at8glILvZYaZRhMCXcKz+Sar+ddwV0uYR6utOaVRXkj5eWTV1xSVPzYR
         HrM9/kxC4Ft05X1kaKOoNqtpbkgW5VvigTCsM77nWQX6kHDp94o+lvr1eAFk28t6E46u
         jTMA5K0G1cfF5/LymjchqREohr6I43RG6fkhgh0SGeprdHyjB6+qV8VV2hVPkvSyehGN
         bWZQ==
X-Gm-Message-State: APjAAAXGdiDrZ+IIb4tsNCJK7UjWlaksyYahrws6J8QbJjQlKsQsEqWx
        QV1VjKoLsfKH5DTelGQDRtLDqQ3ZhUKYLtVU+iqVZg==
X-Google-Smtp-Source: APXvYqw0NUsmXGPrqk5NOPPkOrMTL9xvVUzEPajFjKlFG0QY3DNb1kXLPE9W58+xpoYQ+7UXTG64B01lqxE3rA6aZWc=
X-Received: by 2002:a5d:8347:: with SMTP id q7mr836370ior.277.1562284650034;
 Thu, 04 Jul 2019 16:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190321131655.15249-1-pclouds@gmail.com> <20190329103919.15642-1-pclouds@gmail.com>
 <20190329103919.15642-8-pclouds@gmail.com> <20190702080611.GL21574@szeder.dev>
 <20190702090308.GA27775@ash> <xmqqa7dw4966.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqa7dw4966.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 5 Jul 2019 06:57:03 +0700
Message-ID: <CACsJy8Agbvn0OYiM8z_r6PAJW0Tov9eQyN3NviD8rLQKNdc45A@mail.gmail.com>
Subject: Re: [PATCH v6 07/27] checkout: inform the user when removing branch state
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Eckhard_Maa=C3=9F?= <eckhard.s.maass@googlemail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 3, 2019 at 12:51 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Duy Nguyen <pclouds@gmail.com> writes:
>
> > I agree, this is not "canceling". I think this series causes conflicts
> > with pw/clean-sequencer-state-upon-final-commit and the warning is
> > accidentally enabled (partly my fault since I named the argument
> > "verbose").
> >
> > Junio, in this conflict resolution (merging nd/switch-and-restore to
> > next), we should pass '0' instead of 'verbose' to
> > sequencer_post_commit_cleanup().
>
> Thanks for an update to the merge-fix.  What should the name of the
> parameter to the sequencer_post_commit_cleanup() funcion be then,
> though?  Perhaps we'd want an update after the topic graduates to
> the 'master' branch.

Definitely. I was thinking something with "warn" and "cancel", which
is more the the point. Probably warn_cancel_in_progress, or something.
-- 
Duy
