Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF18C433C1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 02:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CB5861925
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 02:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhC2CE2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 22:04:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54817 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhC2CEU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 22:04:20 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 826C4BF952;
        Sun, 28 Mar 2021 22:04:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=iiS/OrR09qc9
        FUtkyuMj6oKDXO4=; b=uRZllbx3L/IsTL9jMO0gzXadSGVxP6RMCSDjhOQJuNO3
        usYzVnLzeCVvFCK2xaDdayB5vHgoyl6cOh8Pzn0q2RwuKv3fxUnqp3+ndUNCsGSB
        tcKl/0ibNyHaweDTGiSJTIBPhjoD4BuTHZSNDXgJ//kYQMSlSut9h9+45HbDEos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=rBe8yD
        DZ25kwT5YaQutOqGMgZc0Y+SXkQLHn9YkylUw4uDgX/tQvpsDbjlqDoOru2PahjI
        rDrrAj/W1UyH3vu/RnUC/c3ortIeJL8G6ZKYT4SFJDT0iliAASXiHLfIYx9g7GnH
        4zuE2HtJpodjc05wD3pPlf6H5Oft8SxH8fd6w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A801BF951;
        Sun, 28 Mar 2021 22:04:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F3935BF950;
        Sun, 28 Mar 2021 22:04:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v6 02/19] fsck.h: use designed initializers for
 FSCK_OPTIONS_{DEFAULT,STRICT}
References: <20210317182054.5986-1-avarab@gmail.com>
        <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
        <patch-02.20-b17c982293e-20210328T130947Z-avarab@gmail.com>
        <YGC5pzAOycCePCU6@satellite>
Date:   Sun, 28 Mar 2021 19:04:18 -0700
In-Reply-To: <YGC5pzAOycCePCU6@satellite> (Ramsay Jones's message of "Sun, 28
        Mar 2021 18:15:19 +0100")
Message-ID: <xmqqblb2lnq5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1253E3EC-9033-11EB-B7D4-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> On Sun, Mar 28, 2021 at 03:15:34PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>> Refactor the definitions of FSCK_OPTIONS_{DEFAULT,STRICT} to use
>> designated initializers. This allows us to omit those fields that
>> aren't initialized to zero or NULL.
>
> s/aren't/are/

Thanks; tweak applied while queuing.

> [I apologize in advance - I am using mutt for the first time to reply
> to a ML post and I don't know if I should be using L-ist-reply or a
> g-roup-reply! :D ]

FWIW, on lore (reading via nntp), the message I am responding to
looks just fine.

