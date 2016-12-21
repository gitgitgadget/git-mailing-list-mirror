Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1F991FF40
	for <e@80x24.org>; Wed, 21 Dec 2016 18:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755151AbcLUSyI (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 13:54:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58453 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754398AbcLUSyH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 13:54:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 40E8958F11;
        Wed, 21 Dec 2016 13:54:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gZe1NmRjIevMXZzUd6MUxRvCS4U=; b=PEAC4h
        tHXHUxEwav0jXOkvEh6V6CBASwDPCL0w1yrXnCHijJ24MmJTWM5psqqoqfQsrBPI
        qSIaw2XYcfBkluv1qznMA4SXgBbZk1Dv7imGkdGUIu2nNk15HvPJW4PYGn+ecH7W
        x5mgvMjyJUgcGkb2A6AeKZTtnejT10ZWHW8sg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QWH/po67BJYYGSizqKufbBimgZmIgflx
        gujOfG5iGqWj4thuPNh4iiUzetr5prq8RHoJjn2BYQ+bTVyu9GcTu7OeLo/YE31k
        qbM0+TlEM4KGc52TdmccrGGn/sUI4oAbFEIzgfl5XgfV1c0rYHjQqkxPcFVkakEy
        XmZHmzKFVpo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 37EB858F10;
        Wed, 21 Dec 2016 13:54:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9DFFE58F0F;
        Wed, 21 Dec 2016 13:54:05 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH] winansi_isatty(): fix when Git is used from CMD
References: <cover.1481454992.git.johannes.schindelin@gmx.de>
        <42ddc270ea04e01e899cc479063e5d602e4a4448.1481454992.git.johannes.schindelin@gmx.de>
        <129f000c-49c1-0e75-26b3-c96e9b442443@kdbg.org>
        <xmqqy3zfsq4q.fsf@gitster.mtv.corp.google.com>
        <5977e71d-da58-7cb0-bc69-343bb3a1341d@kdbg.org>
        <ffc6a7a0-4ae4-b755-0b09-5bcd7114a2e6@kdbg.org>
        <alpine.DEB.2.20.1612201732160.54750@virtualbox>
        <xmqqtw9yleop.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1612211857480.155951@virtualbox>
Date:   Wed, 21 Dec 2016 10:54:04 -0800
In-Reply-To: <alpine.DEB.2.20.1612211857480.155951@virtualbox> (Johannes
        Schindelin's message of "Wed, 21 Dec 2016 18:59:42 +0100 (CET)")
Message-ID: <xmqqlgv9i04z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D8C8AD16-C7AE-11E6-BAC3-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I prepared a patch series based on `pu`, on top of Hannes' patch, and I
> also prepared a branch that is based on `master`, obviously without
> Hannes' patch.

I think the latter is what you have at

 $ git fetch https://github.com/dscho/git mingw-isatty-fixup-master

If that is correct, I am inclined to fetch that and queue it on
'pu', replacing Hannes's patch, and then to ask him to Test/Ack it.

Thanks.
