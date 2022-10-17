Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454EFC433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 21:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiJQVEW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 17:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiJQVES (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 17:04:18 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242D172952
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 14:04:16 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C75521485E5;
        Mon, 17 Oct 2022 17:04:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QKa6zYTIT/PICrOmdM+JtALkJU3OszSwvax7w8
        SAnqw=; b=vh4nWTHZl2QU9vGTWmoJJhgw/JDtW9M2BKiXze21KFqsXqoA5/Vt5c
        UDMn8gRWTQDjkBiiIfMgkQI2idWo4xK3PRkTJILg8Eu2ozvZFSj6/5LeXH/UCBWp
        pPId2UUsscOu2j0+cTJI+CtX+SsvozkIvoKd8ntwclhChPy8/t6XI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BF2A91485E1;
        Mon, 17 Oct 2022 17:04:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 30EA11485E0;
        Mon, 17 Oct 2022 17:04:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        derrickstolee@github.com, vdye@github.com
Subject: Re: [PATCH] builtin/repack.c: remove redundant pack-based bitmaps
References: <393fd4c6db78cd694e6d4dfcf24f17e2850ccd99.1665601403.git.me@ttaylorr.com>
        <Y02YzYS172skpbAb@coredump.intra.peff.net>
        <221017.868rlejn4z.gmgdl@evledraar.gmail.com>
        <Y02shQFeXkwYd2g6@coredump.intra.peff.net>
Date:   Mon, 17 Oct 2022 14:04:13 -0700
In-Reply-To: <Y02shQFeXkwYd2g6@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 17 Oct 2022 15:27:01 -0400")
Message-ID: <xmqqlepeyxf6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 414415B4-4E5F-11ED-A50C-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Really, both here and remove_redundant_pack() should probably be using
> unlink_or_warn(). Though if you did want to notice the race on deleting
> the actual .pack file, it would need to be hand-coded.

Yeah, unlink_or_warn() would probably be the right way to go.

Other than that, the patch looks good to you folks?

Thanks.
