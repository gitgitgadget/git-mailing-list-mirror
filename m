Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A79AC433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 20:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D21A2074D
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 20:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RvilWFBn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732281AbgJOUXf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 16:23:35 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53265 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730465AbgJOUXf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 16:23:35 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 72531F8370;
        Thu, 15 Oct 2020 16:23:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=maluQdSYd7Uv+hkE0exFhW7RlvE=; b=RvilWF
        Bn+ZhKSDFpK+pTCXb1unJ25wvmrWLVtFHnoXWvKJisygyvusoMkNHq4jf42CSdYE
        k2VwikW1uiarAVoz2uAo6R9MEsdvVCVI9gOmEJErP5BpD3clXn+D4VLmJeRfcXd4
        Y2Juns2WH2c8gQzbhuvZjZu1WVbenL8zvd9ec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Tls/EPF9fLFJ5yVpp4sUMEfFLWKtNwd5
        0Rju5biUb7tlrRdzrCnxXrf0MZKC+ti3gGjhyh1tpJqC28lvwcrWULG2L9aApzFX
        WkIQfBtFp0+Z8ZO4Ng4X1i1u3b6s+2eS/bX/wd/1c7Npw/znwO711rKyjztl5ZWt
        /QvwSujRW3I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6C720F836F;
        Thu, 15 Oct 2020 16:23:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B0911F836E;
        Thu, 15 Oct 2020 16:23:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nipunn Koorapati <nipunn1313@gmail.com>,
        Alex Vandiver <alexmv@dropbox.com>
Subject: Re: [PATCH] dir.c: fix comments to agree with argument name
References: <pull.757.git.1602766160815.gitgitgadget@gmail.com>
        <20201015160725.GA1104947@coredump.intra.peff.net>
        <xmqqk0vrfi1r.fsf@gitster.c.googlers.com>
        <20201015194158.GA1490964@coredump.intra.peff.net>
Date:   Thu, 15 Oct 2020 13:23:29 -0700
In-Reply-To: <20201015194158.GA1490964@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 15 Oct 2020 15:41:58 -0400")
Message-ID: <xmqqsgafdyri.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A756B00-0F24-11EB-98F3-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Anyway.  Nipunn, can you fix both of them in the same commit, as
>> they are addressing a problem from the same cause (i.e. we are no
>> longer SHA-1 centric).
>
> The v2 that Nipunn sent with "oid" in the comment looks good to me.

OK, then all is good.  Thanks.
