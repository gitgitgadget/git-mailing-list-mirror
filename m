Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EE1C433B4
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 18:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6325B60FF3
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 18:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbhCaSgz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 14:36:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52935 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbhCaSgv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 14:36:51 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D4B9B7BB3;
        Wed, 31 Mar 2021 14:36:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VDr/TH7XG22ONABRkRYnK5OvntM=; b=EI2KAS
        OgClJQrO2ormWwEhUbkZnkOCdh18baWRaXNo1lihxKpRL4QDQ0jc8WOlwgeoh8yw
        evq5hLeDPoRTU9YProEr02AROZEQITYtvrpxS+vw9DyD+U8w1KQ3ublAR57ncbzZ
        bFLQA29sKmXrZF55xRP0Q/7+9JwhtP2qGPQbc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oGttoWhs4B2o7jpVudSxcAGcQU/KJj0h
        XNWE6/ur36dt2Ufn1QOlmof28odOlfkgl09sUMiVOpkeME2+JscB2m0JdC4V27HX
        B7EpKZs6ZeYUoPlAI8HeBVutpyCfWiDq/wS0E2gA3n+rwaDX1LUj7F6kwBQ56HUU
        5drgKDO71VU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 64988B7BB2;
        Wed, 31 Mar 2021 14:36:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C1761B7BA8;
        Wed, 31 Mar 2021 14:36:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 4/5] Makefile: add the ".DELETE_ON_ERROR" flag
References: <20210307132001.7485-1-avarab@gmail.com>
        <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
        <patch-4.6-2ff6359c273-20210329T161723Z-avarab@gmail.com>
        <xmqqblb1kd47.fsf@gitster.g> <87a6qlmt9f.fsf@evledraar.gmail.com>
        <YGM/i+k4r0q8FKg2@coredump.intra.peff.net>
        <xmqqft0cebft.fsf@gitster.g>
        <YGQdpkHAcFR/zNOx@coredump.intra.peff.net>
Date:   Wed, 31 Mar 2021 11:36:49 -0700
In-Reply-To: <YGQdpkHAcFR/zNOx@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 31 Mar 2021 02:58:46 -0400")
Message-ID: <xmqq35wb891a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0E31F6CC-9250-11EB-8E28-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I don't know how paranoid we want to be about this, especially the
> latter. My general inclination is to prefer "commit" systems as more
> robust, but it is just a Makefile.

;-)

As an old timer, I've written "gen >$@+ && mv $@+ $@" all the time
myself, but it is ugly and felt a bit too conservative.  I do not
think it is wise to overnight remove all the existing "generate in
temporary, move to the final" patterns and delegate $(MAKE) to take
care of failed generator with this mechanism, but I actually would
feel it probably gives us a cleaner Makefile in the longer term.  At
least "bugs in $(MAKE)" won't be our sole problem (i.e. all other
projects that rely on the feature would share the incentives to see
them fixed).

