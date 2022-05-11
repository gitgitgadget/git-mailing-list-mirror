Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6841C433EF
	for <git@archiver.kernel.org>; Wed, 11 May 2022 01:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240082AbiEKBLn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 21:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240076AbiEKBLg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 21:11:36 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2EE6C0D8
        for <git@vger.kernel.org>; Tue, 10 May 2022 18:11:30 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 38EFA18C063;
        Tue, 10 May 2022 21:11:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bu3hG4wQ9vkqyjv2r0L7WclzgR/9P7LhcrwIXK
        0yHX8=; b=pOmFl0cF6i9ol+eCqePHtfsfsbDActiTsB4SUjv96IGJM5kcRuH/nk
        bxYBTJKzjblESc/Q0xYqain1mjY0ADrt1Hyo8t3ZZZ0tSIHzuH5x6bSf5bCRTlu/
        RBl3sYVwouFxSm+2McxIaeOqhL+T4rp0Pe01QLHMSOIqTdu1AX8x0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 31E6A18C061;
        Tue, 10 May 2022 21:11:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D006F18C060;
        Tue, 10 May 2022 21:11:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 1/3] t: regression git needs safe.directory when
 using sudo
References: <20220507163508.78459-1-carenas@gmail.com>
        <20220510174616.18629-1-carenas@gmail.com>
        <20220510174616.18629-2-carenas@gmail.com>
        <xmqqczgl6nua.fsf@gitster.g>
        <CAPUEspgGZeF8LA5PZNF87=+zZLKvWLqWtpD5YUBUON4gq_TaDg@mail.gmail.com>
        <xmqqwnet3qcv.fsf@gitster.g>
        <CAPUEspjppJh3+obLoNpP8ckHz=-0G=MEUUBHnrab6=Znv+RiUg@mail.gmail.com>
Date:   Tue, 10 May 2022 18:11:24 -0700
In-Reply-To: <CAPUEspjppJh3+obLoNpP8ckHz=-0G=MEUUBHnrab6=Znv+RiUg@mail.gmail.com>
        (Carlo Arenas's message of "Tue, 10 May 2022 17:56:37 -0700")
Message-ID: <xmqqh75w50w3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 478674E6-D0C7-11EC-9B14-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> one option would be to consolidate its use with the root repository
> that gets created in patch 3, which I could have done originally
> instead of just using the ones you provided almost AS-IS, or as you
> pointed out we could remove the safety net since it is not needed and
> it is buggy anyway.

I agree that there is no point to chown the directory, especially if
it does not offer any additional safety of any sort.  And quite
honstly, a test that is designed to be run ONLY in a very controlled
CI environment, it does not need one that complicates the tests.

Thanks.
