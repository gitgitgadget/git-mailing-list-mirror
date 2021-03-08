Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D935C433E6
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 18:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D407A6522E
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 18:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhCHS62 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 13:58:28 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64021 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhCHS6B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 13:58:01 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CD494136466;
        Mon,  8 Mar 2021 13:58:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LLbT9x1FDfz5A8DCVIDIpQSOkRo=; b=pRZXRo
        P/vIorGQnStbqgs9Qk1ENBa/iSIZhnsp5y/QFhFS0CG7Mv4zNwMnqiz+a98Oewfp
        fiCDULJBh69NonhZrb7LD/j+b6SGCojgbuYrORtpMwtjrSl4hZs+LBb5vaxSrXut
        di8v4c7csYKP9dNjl6HBBwNyJ6SVnuSFk5jp8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Vu4oLEEZD2Qh3cPz29OkD8H4BHrOw8xo
        DOKEYltZy4MBRza525juoic2VehZuJOCQAF9PtBcctqbqHCaMwtWJguOcTlBKDj9
        rDjjOrt2e0oWqjhhvr8ENWLAb9rc88nLThgcoppeOtBYG6cpFPMGvxhPK7zVs0ip
        /LhbF5ClJgY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C6310136465;
        Mon,  8 Mar 2021 13:58:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 19004136463;
        Mon,  8 Mar 2021 13:57:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Andrzej Hunt <andrzej@ahunt.org>
Subject: Re: [PATCH 0/7] Fix all leaks in t0001
References: <pull.899.git.1615228580.gitgitgadget@gmail.com>
Date:   Mon, 08 Mar 2021 10:57:56 -0800
In-Reply-To: <pull.899.git.1615228580.gitgitgadget@gmail.com> (Andrzej Hunt
        via GitGitGadget's message of "Mon, 08 Mar 2021 18:36:13 +0000")
Message-ID: <xmqqk0qh5v7v.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 32A9D24E-8040-11EB-A37A-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com> writes:

> hand: fixing or suppressing these leaks should make it easier to spot leaks
> that have more significant user impact (it's entirely plausible that no real
> impactful leaks exist).

Even if there is no leaks that matter exist now, to help maintain
that state, suppressing false positives would be useful, provided if
such checkers are run sufficiently often.
