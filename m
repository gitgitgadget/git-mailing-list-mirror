Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0069BC636C9
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 17:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D356C6100C
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 17:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237184AbhGURH1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 13:07:27 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52541 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237170AbhGURHY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 13:07:24 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 57DC9145FB4;
        Wed, 21 Jul 2021 13:48:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NlMmuG73scrNHol9Okabexxr8nykLggxA/q4sC
        uxk1A=; b=W0e1sObRSGVBqooligeiR1B5GJRoLUPFO9YgBgjNi9I9as1hiVdMvu
        ddnmzceswtpLKomRXCRuuX+57uaLS+V8V67Vt1yHAt5cakqFr5YkPbhs0Ay0MfKR
        4owBw1slnP2nkhrVX1Bp6i8L3225cFu1ylh2O60TlfI9NCawLEwyw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4F010145FB3;
        Wed, 21 Jul 2021 13:48:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8E53D145FB2;
        Wed, 21 Jul 2021 13:47:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 06/12] refs API: pass the "lock OID" to reflog "prepare"
References: <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
        <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com>
        <patch-06.12-295594fe8ae-20210720T102051Z-avarab@gmail.com>
        <xmqq35s7efb3.fsf@gitster.g>
Date:   Wed, 21 Jul 2021 10:47:56 -0700
In-Reply-To: <xmqq35s7efb3.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        21 Jul 2021 10:40:16 -0700")
Message-ID: <xmqqy29zd0dv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8B9E380-EA4B-11EB-8579-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> This obviously breaks the latest round of reftable topic, as it
> still wants this type to take const oid, and I do not think using
> on-filesystem lock as if we are using the files backend is not a
> good solution.

Sorry for redundant negation.  "I do not think it is a good solution
to have everybody pretend as if they are files backend when they
lock refs." was what I meant.

