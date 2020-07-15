Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8064C433E3
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 18:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0C7E20657
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 18:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ni9rdoae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgGOS6j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 14:58:39 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58282 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGOS6j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 14:58:39 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 05AE9DE84A;
        Wed, 15 Jul 2020 14:58:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zu2WufyESybJ+EXH5k+J/LWg9Eg=; b=Ni9rdo
        aeyz8Vgwzn+UijeYiwRA3rIHbe/hGDMPxMU3wUw6wdHbhjLPwCjPvEhvaMs2zGTW
        bDv5vR1SwmlCWNNJIY2Rw3fxZ6PNI7898Xw0lVeOtWUuceueevb91Bc18+nC21WI
        CMb2DWa/w6lqtG/QjuCaKXX5RbwNGQpT7cWC0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Zbc9HOZUBkkG8mQAVFTno7Zz+tjobDj/
        92INu4SVOVIaH6j0lhoYiG7H5ePkiT3JJW1i1E9WF5ZpSkILYeTNlXl/73O+cWmD
        dr1epXMoC95sFhudZWODQzA6pTeMTBO2639+OFzZHV0SO7oB/a55rgJeJjO5kBoZ
        abCntfHmIik=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F2FEFDE849;
        Wed, 15 Jul 2020 14:58:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 41C08DE848;
        Wed, 15 Jul 2020 14:58:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, dstolee@microsoft.com,
        peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCH] commit-graph: fix "Collecting commits from input" progress line
References: <56403dd377b996d21a4da1e01ffd6e691ac120bd.1589407014.git.me@ttaylorr.com>
        <20200710190238.16376-1-szeder.dev@gmail.com>
        <20200715183347.GH11341@szeder.dev>
        <d343c802-bb5a-5bad-5914-5cbcd50b80e5@gmail.com>
Date:   Wed, 15 Jul 2020 11:58:34 -0700
In-Reply-To: <d343c802-bb5a-5bad-5914-5cbcd50b80e5@gmail.com> (Derrick
        Stolee's message of "Wed, 15 Jul 2020 14:43:42 -0400")
Message-ID: <xmqq8sfkk3l1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2FECBBF2-C6CD-11EA-B6D8-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Thanks for the ping. I forgot to chime in with my :+1: on
> this patch. Outside of the small typo in the commit message,
> this is ready to ship.
>
> Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

Thanks, both.  Will queue.
