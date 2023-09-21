Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFAAE7D0AE
	for <git@archiver.kernel.org>; Thu, 21 Sep 2023 21:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjIUVlq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Sep 2023 17:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbjIUVld (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2023 17:41:33 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0685B421
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 14:18:54 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 343841FA30;
        Thu, 21 Sep 2023 17:18:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=EZcp3Db6G7iq4956Djs4HctdNuKL7ciX2dOOpz
        0stx4=; b=SBiPKk6990Gvsux3AMHROTe4gT9hZkD+AFSPELbsoliqxwYmmSRmbF
        x4tYGKqWu8m5GrRf3pwsnrQHVGc0UQAhqU5Nm68DGgKoNEgNarme2x4NW/LoCG41
        A2HIFDtnDZqUM1qWSbcKzRDNWED+a/KSXGQUFQjFQ/Y9Q+VUMNGNQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2D40A1FA2F;
        Thu, 21 Sep 2023 17:18:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B33D11FA2C;
        Thu, 21 Sep 2023 17:18:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] test-lib: set UBSAN_OPTIONS to match ASan
In-Reply-To: <20230921041825.GA2814583@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 21 Sep 2023 00:18:25 -0400")
References: <20230921041825.GA2814583@coredump.intra.peff.net>
Date:   Thu, 21 Sep 2023 14:18:49 -0700
Message-ID: <xmqqwmwj443q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 75C0F4AE-58C4-11EE-B42E-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So that's garbage memory which would _usually_ cause us to segfault, but
> UBSan catches it and complains first about the alignment. That makes
> sense, but the weird thing is that UBSan then exits instead of aborting,
> so our test_might_fail call considers that an acceptable outcome and the
> test "passes".

t4058 unexpectedly succeeding vaguely rings a bell to me, too, but
it has been sporadic.  The changes are obviously the right thing to
do.

Thanks, queued.

