Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCF1C43219
	for <git@archiver.kernel.org>; Wed, 25 May 2022 15:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245358AbiEYPue (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 11:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245312AbiEYPu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 11:50:29 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87A6AE24B
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:50:26 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EDD7A194269;
        Wed, 25 May 2022 11:50:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XgIvdIijsmB9d/x/jd5ojGQqejr6Wd/n8MQhIG
        px2lY=; b=LrBLcQ3oJoUkg9KRV7ZUjaKhZ6i0RAqX4c7LRa5s+kJA1u/rKBYzGM
        h6APwzQkz268NkN4TkTolkSD+fJ2055qMeB+HlFXZi12X2NXiBEhoaLpKPPysKip
        9DKJC1gh2lV9AnUNqBqMKcXlMsEbNYxR2tba3atmXHROEtFfzTASk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E664E194268;
        Wed, 25 May 2022 11:50:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7DFBD194266;
        Wed, 25 May 2022 11:50:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Ed Maste <emaste@FreeBSD.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] ci: update Cirrus-CI image to FreeBSD 12.3
References: <20220524165823.18804-1-levraiphilippeblain@gmail.com>
        <20220525125112.86954-1-levraiphilippeblain@gmail.com>
Date:   Wed, 25 May 2022 08:50:21 -0700
In-Reply-To: <20220525125112.86954-1-levraiphilippeblain@gmail.com> (Philippe
        Blain's message of "Wed, 25 May 2022 08:51:12 -0400")
Message-ID: <xmqqsfoxa9xe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 62CF0ACA-DC42-11EC-80C6-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> The FreeBSD CI build (on Cirrus-CI) has been failing in
> 't9001-send-email.sh' for quite some time, with an error from the
> runtime linker relating to the Perl installation:
>
>     $ GIT_SEND_EMAIL_NOTTY=1 git send-email \
>     '--from=Example <from@example.com>' '--to=nobody@example.com' \
>     '--smtp-server=/tmp/cirrus-ci-build/t/trash directory.t9001-send-email/fake.sendmail' \
>     --compose '--subject=foo' 0001-Second.patch
>     ld-elf.so.1: /usr/local/lib/perl5/5.32/mach/CORE/libperl.so.5.32: Undefined symbol "strerror_l@FBSD_1.6"

It does sound like the image has a broken build of Perl.  Is that
something FreeBSD folks might care about, or they already know but
they are happy with newer versions they support already?

> This first instance is in t9001.6 but it fails similarly in several tests
> in this file.
>
> The FreeBSD image we use is FreeBSD 12.2, which is unsupported since
> March 31st, 2022 [1]. Switching to a supported version, 12.3,
> makes this error disappear [2].
>
> Change the image we use to FreeBSD 12.3.

Thanks.  Will queue.
