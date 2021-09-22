Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1A0C433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 20:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05003611C6
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 20:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237303AbhIVUC7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 16:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237356AbhIVUCq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 16:02:46 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22197C061767
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 13:01:08 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id eg28so14601128edb.1
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 13:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=KYGibvCXUvvEQB4E3owjIK1vLtuCeJTyG0KXxsxqUVI=;
        b=YFI3ekpr/Vyf6X2VgmbpToKJtSe5FY7fnusWLFbaauaue2oydWw1GDE2p3bfQ795F7
         l8i9br5oUvPY7anWcm/n6pgaLhdc6NrPMC236YTj7WnPQ/RcKmglcgh5IXI/Rr4F1QQQ
         yqSOOXochd2lR01OhHYh0Cc5a9z146CDFju1Cwf8FSIhM2EcKaNWDA/KtPLZYZKYRz7n
         fbEypYTI96bIUBqxgmCsbstVQfn3Hw+JDBnwfZkBGJjyg2rwhEJaTB7c9Nh7iF3Yz3vA
         SWS5F+dqIL+wgpJXjCssxeoKXSGddBKVDbWBa8b1s3jjL1EaCbr5DW6gDReSVPljHc9I
         MjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=KYGibvCXUvvEQB4E3owjIK1vLtuCeJTyG0KXxsxqUVI=;
        b=PA2ZrCOo3xVv+VKd5kLlcEI05+Sd1PHusMu4OVHNaBuI1lIdG9OqUt8XJx9zkb0HBN
         CCPBmzC+ktDgk3FrYWHRdxQnoigPvL6BR1HAWHUHoLaVLYPoJD+VgtlFcllDcoMLI+mZ
         PydpZpBVIJCUzfUzePBGGG0520x9bBpjq82DFNdgrKDXAN8Ll/iKe7v60JjLA4+P3iZI
         YcQGxln/qqQjiG/ynXj/gL19jRdIsMGh9AXtjlolU+avu4ar/gnbKM+crB6tFBgDfHgf
         jkkkqjuR5qJVRZtRreoAztl7XF1OHB+aKAOdQxFs5c8fmLRwnnAgobaxt9ClHiNit9mc
         E8og==
X-Gm-Message-State: AOAM530KuadvSwh3VIDyP4UWJE5hUzlp0cAzIRXz73c0k9RggLdbyFY1
        03OIFQXB7OHevcr0SM5QoHY=
X-Google-Smtp-Source: ABdhPJzxKaKUP0fSqYhIkWleEslkL865EP4upTkxAloaYXJ/BwLy1yevxBTgekqZkbfg1KNZsbiTbQ==
X-Received: by 2002:a17:906:2ec5:: with SMTP id s5mr1094972eji.192.1632340866654;
        Wed, 22 Sep 2021 13:01:06 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ec3sm1645934edb.72.2021.09.22.13.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:01:06 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        wolf@oriole.systems
Subject: Re: [PATCH] rev-parse: fix mismatch quoting of separator in the
 message
Date:   Wed, 22 Sep 2021 21:59:51 +0200
References: <20210922111744.675326-1-bagasdotme@gmail.com>
 <YUtqp+1Mwl2v0kuh@nand.local> <xmqqzgs45s15.fsf@gitster.g>
 <YUuHP41V9m7cIEBL@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YUuHP41V9m7cIEBL@nand.local>
Message-ID: <87bl4k7532.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 22 2021, Taylor Blau wrote:

> On Wed, Sep 22, 2021 at 12:28:22PM -0700, Junio C Hamano wrote:
>> Taylor Blau <me@ttaylorr.com> writes:
>>
>> > On Wed, Sep 22, 2021 at 06:17:45PM +0700, Bagas Sanjaya wrote:
>> >> There is a quoting mismatch quoting `--` separator in "no usage string
>> >> given...." message (`' instead of ``). Fix it.
>> >
>> > For what it's worth, I think that the `' style is typographic, since the
>> > pair look like English "smart quotes" (as opposed to straight quotes). I
>> > have no opinion about which is better, but I don't think the pre-image
>> > was necessarily a mistake.
>>
>> I thought that we try to avoid "smart quotes" in our messages.
>
> I think UTF-8 smart quotes are generally frowned upon in source code,
> but I didn't think we had any hard-and-fast rule about whether to prefer
> 'this' to `that' (for what it's worth, I prefer the former and it seems
> to be more common).

No comment on what's preferred, other than I wish we'd pick a style and
stick to it. Just a note that this used to be the way to do it in
e.g. the GNU guidelines, I see it isn't anymore though: [1].

1. https://www.gnu.org/prep/standards/standards.html#Quote-Characters-1
