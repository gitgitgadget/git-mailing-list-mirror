Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E48D20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 21:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752139AbdASVpe (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 16:45:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58872 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751478AbdASVpd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 16:45:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF0405FE0C;
        Thu, 19 Jan 2017 16:45:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5fHM32AvbAHbcz5HTFP2d0VIW+Q=; b=LC//u7
        meO7/eOLiOGv32+RGeK9zCt2ZNXiHDVejhRPn22hWEwwPmx5NkZ9C/67t4ELo/ZS
        sEh8uBGWIxzO1clf6aAiBM5ppgsztCk5X3S49oKTwSN04OfVtmhfxrCBGoWabLof
        EbuK3MS/GBD/Fsi4RmX4AFHFBLvqTOsRG4BsY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ufurK7GGwYZHdFzUohDwsp/pw3MVFOxT
        /+8nE4zdMDWVbU/OllcP5yQ5oRyE9U+yB0+Zi7E0uOlO0vk2guRHTH3dHpFEykiF
        qctgXsna5gPlX8YdWtHWsKWa6ivBmUfKuowkKB7o0F5I2Oz/kRqvHDvwqj/Rdmbk
        MBrs6GhZ9m4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A6C7A5FE0B;
        Thu, 19 Jan 2017 16:45:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0CEB35FE0A;
        Thu, 19 Jan 2017 16:45:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        Andrew Arnott <Andrew.Arnott@microsoft.com>
Subject: Re: [PATCH v2 2/2] Be more careful when determining whether a remote was configured
References: <cover.1484687919.git.johannes.schindelin@gmx.de>
        <cover.1484860744.git.johannes.schindelin@gmx.de>
        <1605031b76025f4bd0e485705c34a25557bb75a1.1484860744.git.johannes.schindelin@gmx.de>
        <20170119213100.g72ml7r2khu7bvey@sigill.intra.peff.net>
Date:   Thu, 19 Jan 2017 13:45:29 -0800
In-Reply-To: <20170119213100.g72ml7r2khu7bvey@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 19 Jan 2017 16:31:01 -0500")
Message-ID: <xmqqy3y6yb9i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9957F44A-DE90-11E6-90FB-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'm trying to figure out why "fetch --multiple" wouldn't just take a url
> in the first place. I guess it is because multiple fetch is useless
> without refspecs (since otherwise you're just writing to FETCH_HEAD,
> which gets immediately overwritten).

This is probably a tangent, if FETCH_HEAD is overwritten, wouldn't
that be a bug in the implementation of --multiple?  I somehow
thought we had an option to tell second and subsequent "fetch" to
append to FETCH_HEAD instead of overwriting it.

