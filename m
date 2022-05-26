Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25316C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 01:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237746AbiEZBUP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 21:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiEZBUO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 21:20:14 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7B49CF72
        for <git@vger.kernel.org>; Wed, 25 May 2022 18:20:13 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 026F4198336;
        Wed, 25 May 2022 21:20:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1ZHrMGkQro/i
        oHbdnoCSFuFiMwTjFnRXb2WtYnnbNiU=; b=XvfWemw63eVzYBn80g1sJmuqNRj4
        cRk5WoQYxgkKAuuMfvZxnCo5oKKgTH8tP8A/XbaTo/fvj6sf93FxQErrITWJldhe
        ttL1chLPjEaO76WHkU+uhWjfru7aFrJdNrMvL9xEYd/BhizKeQmH9V1T6lhCiy4u
        HKJeUk/lMHS2Qgw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EF8E7198334;
        Wed, 25 May 2022 21:20:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 325DD198333;
        Wed, 25 May 2022 21:20:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>, John Cai <johncai86@gmail.com>
Subject: Re: [RFC PATCH 0/3] trace2: log "signal" end events if we invoke BUG()
References: <RFC-cover-0.3-00000000000-20220525T234908Z-avarab@gmail.com>
Date:   Wed, 25 May 2022 18:20:08 -0700
In-Reply-To: <RFC-cover-0.3-00000000000-20220525T234908Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 26 May
 2022 02:30:41
        +0200")
Message-ID: <xmqq8rqp3x9z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FBA9DE4C-DC91-11EC-B1A5-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> (depending on the TZ) that he'd encountered trace2 event streams
> without an "exit" event, which as discussed can be seen from usage.c
> is due to our invoking of abort() there.

Josh, is this related to the "in rare cases" thing we discussed on
the "run-command: don't spam trace2_child_exit()" thread?

https://lore.kernel.org/git/4616d09ffa632bd2c9e308a713c4bdf2a1328c3c.1651=
179450.git.steadmon@google.com/

