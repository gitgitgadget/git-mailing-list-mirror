Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8626C4361B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 15:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DBF423B45
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 15:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391654AbgLJPMD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 10:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391733AbgLJPLy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 10:11:54 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C1DC0613D6
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 07:11:13 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id w5so2093447wrm.11
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 07:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3kWiC6H1TGJe9d1D2VVn+jRteHb19tCfaIQBGiLO0ZU=;
        b=V7oA8bZ+52HXUvJsMDh1++al5SqTvBDfx9or6HWbWe/Z+Dqb5XJviDErFTrpnA0ah+
         M0nr5/6SA30AG37OcQfke/JdszX5fBW4lOtU1Uaq/2Q3BIUNpO9ZmjYl4czGH0sla8FT
         pzIWKsVoDmrZySb9POOWYHO3QC+gq/b9LBSh8OKq/JEHdIyqzv2PaZkXYNiCumPkv7DT
         XDTfQIwtbd+QAMNLWwaKPVs06h99uWnMLvHFltDNTEUtp8fFYWTse/usSwW6nGrdynfJ
         w9bGg6RIoHr2saCob/i/WOf8+zbMZY9wOmdMUyDLc6SdbDsTTKhO6LSsm7I/c1ymI3jX
         FHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3kWiC6H1TGJe9d1D2VVn+jRteHb19tCfaIQBGiLO0ZU=;
        b=rtLtgoE0Cts48NG0C2HpxoD6VbkOh14SEkuBq6amGVGP4aV1T3wE/3cW3onMRhQJI+
         eLpKW645SMzWmgCdO0STZMuxyKsxQXb/qIwnb3SzfuXoePVhqRjZST/F53jxc6DCNmLP
         rFUq5UM4Ulmun6tHHtmMSO6xKkFVfeiYiuEZMNpP3QkolOk+ozOI/qZw6B094ItA6bZE
         f9F1YbNcVA3nMqyYMksDzXfTLVJ6YSU6Lm3O2HZnDm/6WRFiD39j7PSPeawIloPJyNjp
         KOgygK0/JK2Nkw23XyWxgUKa8yY1U2X4Yhtz0ZDvJL5OWIO3iuhAhFhry7d8jOOCQdyW
         dp/A==
X-Gm-Message-State: AOAM533ago/HSMxA80eDx8JHJXyzgN7mbrkR2Fno6mW21eNuk7DKV8OS
        okl69E1NfX7aBvK85QHoubNS/HLzeYLZ2+17734=
X-Google-Smtp-Source: ABdhPJzm8Va2Au+BJifIWu692UrTVfDxx9oeGk+HtbKs0ZXGRzUea0dV+xdMtkfL15SfRMDU9RFu0nLFhl69VaG0dOU=
X-Received: by 2002:a5d:52c1:: with SMTP id r1mr8789989wrv.255.1607613072412;
 Thu, 10 Dec 2020 07:11:12 -0800 (PST)
MIME-Version: 1.0
References: <xmqqpn3j4ved.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2012091502000.25979@tvgsbejvaqbjf.bet>
 <xmqqk0tq1xf3.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2012100507450.25979@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.2012100543020.25979@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2012100543020.25979@tvgsbejvaqbjf.bet>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 10 Dec 2020 09:11:01 -0600
Message-ID: <CAMP44s3oobEe9FWJBkvH++rN-J28i169yyimLza2Xg4FRT2x2A@mail.gmail.com>
Subject: Re: fc/pull-merge-rebase, was Re: What's cooking in git.git (Dec
 2020, #01; Tue, 8)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 10, 2020 at 9:04 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> BTW I suspect that the test failures point to shortcomings in the patch
> series that should be addressed anyway. I saw at least one obvious
> omission: when `git pull -s <strategy>` is used, I find it relatively
> obvious that the user wanted that to imply `--merge`.

1. Those are not shortcomings [1]
2. The last patch is not meant to be applied today. That's why it's
prefixed as "future: ".

[1] https://gitlab.com/felipec/git/-/commit/29a28ad763d3231eb1e22867dcfa56e53c5b2be6

-- 
Felipe Contreras
