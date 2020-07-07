Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1436AC433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 22:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D400B2075B
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 22:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yYw293MC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbgGGW3o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 18:29:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55224 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgGGW3n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 18:29:43 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 82D2B70BBB;
        Tue,  7 Jul 2020 18:29:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sfSnpcDPFJLyIUts7aFT0CP0YV4=; b=yYw293
        MCZSVeYORdVXYqgG2Xl8QbROkJLwB7KcKWlsNMb3oAtE+PpInNXvDcHKwKXk2zpd
        yy+Wzh0FdTI5tGrYGqdbkbEfcua57mZAHDe48A6ZX/PvNlcSB8jwx5aWsUtZbchz
        RR2lKP04bxo1QOODMJAfokYJ1tIdAev6ctKj8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Q72xe2YNjYz/m9wIc7FX5kvYDAfQ46br
        z34Kz2YGvrIyZSXucE0UEtcrd1TVVDBfA2QaDIrGop+0q9gcHe3UhovteRjhbI3W
        jNR51T2BKNjLBFmVegZgY3tnp4PtA22cEaSr3nVl6GgB7V/MJIPB/Z+SzbM/TmWZ
        0+5yCynRcWs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7AAD070BBA;
        Tue,  7 Jul 2020 18:29:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 020E170BB8;
        Tue,  7 Jul 2020 18:29:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RESEND PATCH v2 0/5] t: replace incorrect test_must_fail usage (part 6)
References: <cover.1593576601.git.liu.denton@gmail.com>
        <cover.1594101831.git.liu.denton@gmail.com>
        <xmqqblkr3x6q.fsf@gitster.c.googlers.com>
        <xmqq7dvf3uwc.fsf@gitster.c.googlers.com>
        <xmqqwo3f2cx6.fsf@gitster.c.googlers.com>
        <20200707222155.GA27311@generichostname>
Date:   Tue, 07 Jul 2020 15:29:40 -0700
In-Reply-To: <20200707222155.GA27311@generichostname> (Denton Liu's message of
        "Tue, 7 Jul 2020 18:21:55 -0400")
Message-ID: <xmqqo8or2c2z.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 59647862-C0A1-11EA-B220-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Thanks. For the final version of this series, we should either queue
> your patch or the one I just sent[0] just after the patch for t7107 so
> that it comes before the we flip the switch on test_must_fail and also
> so that the patches show up in increasing numerical order.

Ah, our mails crossed.  Surely the fix to cvs test must come before
the final step that tightens the test_must_fail helper.

