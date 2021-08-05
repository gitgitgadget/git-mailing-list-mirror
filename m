Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,GB_FAKE_RF_SHORT,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE20C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 16:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1359B61159
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 16:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhHEQ1R (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 12:27:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63186 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbhHEQ1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 12:27:16 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A59FE62B4;
        Thu,  5 Aug 2021 12:27:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NeXjRN6/YisY3gu2xY/5r//wDOqs0TnYHMd3kf
        zmDxw=; b=SC+845R0kcyF41h4TwR1ooZGh5r/YDEfLjGD4pSeaZ/87LgWUemDWP
        wRmVZJyhXM4T8djeBDeN/fUwGRZt/HUXjHHxpTLSMhyNRmO7qnWxRnhHv6gQNPoR
        HeE+VD0KXUWIIX5QMZnGFJJT97tdBDtSJ6WwypBp0a39pQAQFckUA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7CEABE62B3;
        Thu,  5 Aug 2021 12:27:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 72A4CE62B2;
        Thu,  5 Aug 2021 12:27:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: speed up loading of refs via commit graph
References: <08519b8ab6f395cffbcd5e530bfba6aaf64241a2.1628085347.git.ps@pks.im>
        <YQr/vLNjZomIe1ME@coredump.intra.peff.net> <YQt/g0iZxAVgw66o@ncase>
        <YQvRTpJ0NGakTy9W@ncase>
Date:   Thu, 05 Aug 2021 09:26:59 -0700
In-Reply-To: <YQvRTpJ0NGakTy9W@ncase> (Patrick Steinhardt's message of "Thu, 5
        Aug 2021 13:53:50 +0200")
Message-ID: <xmqqtuk3luwc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F5DC03A6-F609-11EB-B669-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> I've put some more time into this. If rebased on top of v4 of [1], then
> we can also use `parse_commit_in_graph_gently()` to further speed this
> up from 15.8 seconds to 11.6 seconds with below patch. It's the same
> memory/speed tradeoff as I'm doing in [1].

Sounds good.

> I guess I'd still like to treat both series separately for now given
> that [1] is more involved compared to this patch series here. I'll then
> do a follow-up when (if?) both series have landed.

During the pre-release freeze (cf. https://tinyurl.com/gitCal), new
topics will not "land" anywhere so you have two weeks or so to
stabilize the base topic.  I would prefer not to have to worry about
inter-dependent multiple topics anyway, especially the ones that are
not relevant to the upcoming release during a pre-release period.

Thanks.
