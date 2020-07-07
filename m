Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC62C433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 22:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C375920738
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 22:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lmIW6jHI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbgGGWLj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 18:11:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58634 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbgGGWLj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 18:11:39 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 99420E05F7;
        Tue,  7 Jul 2020 18:11:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ralz75dZaWBHMrHUZW/3bhBMCto=; b=lmIW6j
        HIMUGUlOOseHaLUw0WTa2tr0/LK7PnM/bjbTCeKgdDsf+8iw7nZA72AMCZ136l2R
        RBLOvk+SNOSHnDnY5+TvKvhVrWGPhL44saOLWcKXJpgAJGuovHzNDtoscGLUwKeT
        JV+HwsPm2PpPiW36ITBWi5bPSR0vwxB/MhXK4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pntd8vvAm36ZKqnPKEapzi8PTtUGjCwo
        qkogvro2NfMx9bDNrC4qIAUPvgugw5oZuN725LT41YTkdfwoUmXAgo1VmsrX6XP3
        vhHs/62ZkY8kU+vabMjTld9KOfHSPiLcUZ5raSOck5k6b8SSBjLKC+/BF0Etf/vq
        ekyHKN83ONU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 913E2E05F6;
        Tue,  7 Jul 2020 18:11:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DB223E05F5;
        Tue,  7 Jul 2020 18:11:34 -0400 (EDT)
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
Date:   Tue, 07 Jul 2020 15:11:33 -0700
In-Reply-To: <xmqq7dvf3uwc.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 07 Jul 2020 13:57:55 -0700")
Message-ID: <xmqqwo3f2cx6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D2054006-C09E-11EA-BC0D-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> Changes since v1:
>>>
>>> * Add a code comment to force_color()
>>>
>>> * Do not allow nested env's in test_must_fail_acceptable()
>>>
>>> * Clean up the env-processing case code
>>>
>>> * Give an example on how to use `!`.
>>
>> Thanks for a resend.  Now part #5 is in 'master', I can queue these
>> directly on top.
>
> It seems that the patch series lacks coverage for t9400 where we
> have
>
> test_expect_success 'cvs server does not run with vanilla git-shell' '
> 	(
> 		cd cvswork &&
> 		CVS_SERVER=$WORKDIR/remote-cvs &&
> 		export CVS_SERVER &&
> 		test_must_fail cvs log merge
> 	)
> '
>
> which obviously needs to be converted before we declare that it is a
> hard error to feed a non-git command to test_must_fail.

For today's integration cycle, I added a fix-up at the tip of the topic

https://github.com/git/git/commit/dde09ce2b7dd62eafda6339c1c31ccfeb0f39cee
