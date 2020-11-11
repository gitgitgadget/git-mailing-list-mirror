Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B94C5517A
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F906208B3
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yLnbO4F6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgKKT34 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 14:29:56 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52838 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgKKT3z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 14:29:55 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 555D410E8FE;
        Wed, 11 Nov 2020 14:29:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BTuEq1JUkK0pL3yVLd6uh/6ME7c=; b=yLnbO4
        F62opRt0jEg7fdo5MQ4dGEYI25Q9GR5LU4iYMSGLvqparQ5r5TTcaCL9ZCJuOHaY
        6uj28bnANL6XqQrNKs0/HZB0UCTnKBMsbLMkYRrjwftpvDFpgS5xjqcmil4NnkHa
        IbYtPTi5z1lTFxcJeWaPBKhAmNUsIR1fCGTSY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TQZZfoC/R208LNILK2tmhpaLcMPb54Yk
        RDV96uaqxy7IvAD/Erb4XplExgWUkE6HbwLa9VN2qNFh1j/CbX6l8ZNbWvX8AVO7
        4PmrUlaAWyXaaK0Ttrotn5aM7AXmmEqJ+Z/9MfUu0nR3HrLGV8vAOOdLEAhLsseP
        PqDWS/QraSs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4D4DF10E8FD;
        Wed, 11 Nov 2020 14:29:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 999D310E8FC;
        Wed, 11 Nov 2020 14:29:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH 0/5] Remove now-unused git-parse-remote
References: <CAGZ79kb57HzJQ4VLFD_NMKvEnriPVXoAAPimg6BG_Z+PPjJ4aQ@mail.gmail.com>
        <20201111151754.31527-1-avarab@gmail.com>
        <20201111173738.GB9902@coredump.intra.peff.net>
Date:   Wed, 11 Nov 2020 11:29:49 -0800
In-Reply-To: <20201111173738.GB9902@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 11 Nov 2020 12:37:38 -0500")
Message-ID: <xmqqa6vn4rpu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 444939C4-2454-11EB-A5AC-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> To be clear, I find it pretty unlikely that anybody is using the rather
> esoteric functions in this file, but that's usually when I get most
> surprised. :)

I had the same thought when we removed unused functions the last
time, but then stopped worrying about it for this particular shell
library ;-)

> I expected to see a "delete" line for git-parse-remote.sh here. I
> thought at first maybe you were leaving the empty shell so that people
> could continue to source it (keeping the promise in the manpage, but not
> providing any actual functions). But it looks like the final patch stops
> building it at all, leaving the now-useless source file.

A good point.  I do not mind to see a reroll to remove it at the
end.
