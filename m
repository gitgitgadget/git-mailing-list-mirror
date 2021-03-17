Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54474C433DB
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16EEB64F65
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbhCQSsV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:48:21 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56862 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbhCQSsM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 14:48:12 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4C4CD134CB2;
        Wed, 17 Mar 2021 14:48:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=DYiQpV5gmi4k
        UsDJY3L3rRhXCnQ=; b=SwErUdQACxWdSdR+HabKmZdDeGEGZFutl2RHuc5QKjjE
        j9FpZpdcSiTBvAjJA+hiVnBL4hB6FKWClTrBiblI9w6zXDo1asnTT0q+JCypGE63
        2VIZ0bdPTJDXB+vbluMaaUmwyFFgcjf5PcT6od8oCb9MX/MbcL1klYeaTen26As=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Lkaj2R
        cgLhEeh7OEuSGnxKt/OKypZ3DvvhQBdkCx9lz/d/fmD0BzI2XcLGbAfeDWSqYw8k
        zdhUbjdN5zvn4i3ZjEAwykk9QPLZ4Cw1r1OVed0UnZJw+VhHmPl50KTiBXdg3w8S
        SCoryjVqocRKz1QoqqU4tlqL5SzQQKcUTvxew=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 436B9134CB1;
        Wed, 17 Mar 2021 14:48:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 533C5134CAF;
        Wed, 17 Mar 2021 14:48:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v4 11/22] fsck.h: move
 FSCK_{FATAL,INFO,ERROR,WARN,IGNORE} into an enum
References: <20210306110439.27694-1-avarab@gmail.com>
        <20210316161738.30254-12-avarab@gmail.com>
Date:   Wed, 17 Mar 2021 11:48:07 -0700
In-Reply-To: <20210316161738.30254-12-avarab@gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 16 Mar 2021 17:17:27 +0100")
Message-ID: <xmqqo8fhvcpk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5173A624-8751-11EB-BD9A-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Move the FSCK_{FATAL,INFO,ERROR,WARN,IGNORE} defines into a new
> fsck_msg_type enum.

Nice.

> Untangling that would take some more work, since we expose the new
> "enum fsck_msg_type" to both. Similar to "enum object_type" it's not
> worth structuring the API in such a way that only those who need
> FSCK_{ERROR,WARN} pass around a different type.
