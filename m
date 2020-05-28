Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631C4C433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 00:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0666C206DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 00:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GdtEIQg5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbgE1An0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 20:43:26 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53661 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgE1AnY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 20:43:24 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B34E7CD692;
        Wed, 27 May 2020 20:43:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7nqvRBb+GqNN2zOGxmm54a7frAw=; b=GdtEIQ
        g5Fajx2LE5gRj3KaQFZxHgNKZFF9IUNp2ww6CiUFA8T0/e9eEgl2BR5BsyzW+4WE
        T+kB6yBjTEcLkSmtVTclQwfpH3A8efewSSNZahVoboiJFLbpGj+AQ6F0Ff5sn5Vb
        IEn0qxW/IC/3YdV3KjTbPnkExQPWaedTkpS5A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=weHaRy0KfW+ncrFsmjfLaWauqZno9bJz
        aEKPnh1MUyRHe/99Fp5hHdes9b4hNe0Rxd2OXJItcip1JXcXT02bXD12hwIGJxO3
        t14/GjuhOzm8EEZC3AZGfuidwWUn3r6BEN89QoOj3UzGF5LJILqfJH/HP25hnymA
        iGp+ldb/xnk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AC261CD691;
        Wed, 27 May 2020 20:43:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 02A8CCD690;
        Wed, 27 May 2020 20:43:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: jn/experimental-opts-into-proto-v2, was Re: What's cooking in git.git (May 2020, #09; Tue, 26)
References: <xmqqsgfmmt2c.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2005270526280.56@tvgsbejvaqbjf.bet>
        <xmqq1rn5kpzi.fsf@gitster.c.googlers.com>
        <20200527235808.GD56118@google.com>
Date:   Wed, 27 May 2020 17:43:18 -0700
In-Reply-To: <20200527235808.GD56118@google.com> (Jonathan Nieder's message of
        "Wed, 27 May 2020 16:58:08 -0700")
Message-ID: <xmqqeer46g9l.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A275BD0-A07C-11EA-9AC8-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> I have been wondering about the same thing, and if it were not using
>> its own custom way to read the configuration, it would have been a
>> non-brainer to merge it down before the release.
>
> Hm, do you have more detail about this?  git_config_get_bool feels
> very standard and non-custom.
>
> Do you mean that you would like it to go in repo-settings.c?

No.  I fully accept your reasoning in the proposed log message why a
handcrafted query to the config system is done in the location the
patch adds a call.  There is nothing wrong with the patch.

But that means that the way it uses the "experimental" variable is
different from the battle-tested way it has been used, which makes
it less than "non-brainer".  It may not be risky after all, but
still.  This late in the cycle, the fewer things we need to worry
about, the better.
>
>>                                                   But this late in
>> the cycle, I'd rather not.
>
> Sure, I can understand.
>
> Would this be something to put on "master" soon after the release?

That was exactly what I had in mind.

