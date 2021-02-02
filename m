Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16DBC433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 19:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7054164E43
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 19:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240137AbhBBTzc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 14:55:32 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56753 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbhBBTzI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 14:55:08 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F2DB195054;
        Tue,  2 Feb 2021 14:54:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f+Tyo3F9Z3bVmqxQohZpeK2U9j4=; b=SmgrfU
        2euxm4dnBPTQTNv/3qN6l1zF+LnOpC6DsbjxkzN/2xJnfEfMq2kwrHS3ewYNM4c/
        aPW+7VnyO2jYbR3OWZqa6Orl0gRf7RLMoVkCiD1Xi7ZKP/MSozL3Lm/r5raobl8o
        HOtSQ4mH1BTFrAmW/MHh3ISM3nIkLwCZ/0u40=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SykvvQB37FkVbAS3O1dMJL2vFJpj4u5y
        hIrDmHb55UV/qq1SfDEKiyOc0KT9NxPCXJDzeszoaVo+ovBYHLDZsewO47lD2Xz1
        JzOW8+Nz4OBRw2hiRJ0gEbtwMk91tSU30L7Y/DInwrPqlJP36b7o+EO5OQn1OK4T
        jY1M6QNbh10=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E8EFE95053;
        Tue,  2 Feb 2021 14:54:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7214E95052;
        Tue,  2 Feb 2021 14:54:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Thomas Ackermann via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Thomas Ackermann <th.acker@arcor.de>
Subject: Re: [PATCH v2 5/6] doc hash-function-transition: move rationale
 upwards
References: <pull.858.git.1612093734.gitgitgadget@gmail.com>
        <pull.858.v2.git.1612282749.gitgitgadget@gmail.com>
        <711a37969b6f51922c12555534d9c4634cde6021.1612282749.git.gitgitgadget@gmail.com>
Date:   Tue, 02 Feb 2021 11:54:20 -0800
In-Reply-To: <711a37969b6f51922c12555534d9c4634cde6021.1612282749.git.gitgitgadget@gmail.com>
        (Thomas Ackermann via GitGitGadget's message of "Tue, 02 Feb 2021
        16:19:08 +0000")
Message-ID: <xmqqbld2gs9f.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7143FB80-6590-11EB-B439-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Thomas Ackermann via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Thomas Ackermann <th.acker@arcor.de>
>
> Move rationale for new hash function to beginning of document
> so that it appears before the concrete move to SHA-256 is described.
>
> Remove details about SHA-1 weaknesses. Instead add references
> to the details of how the new hash function was chosen.
>
> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---
>  .../technical/hash-function-transition.txt    | 62 +++++--------------
>  1 file changed, 16 insertions(+), 46 deletions(-)

Hmph, this might turn out to be a bit more controversial than its
worth.  I'd summon/cc a few people from the original discussion.

> -Over time some flaws in SHA-1 have been discovered by security
> -researchers. On 23 February 2017 the SHAttered attack
> -(https://shattered.io) demonstrated a practical SHA-1 hash collision.
> +Over time some flaws in SHA-1 have been discovered by security researchers.
>  
>  Git v2.13.0 and later subsequently moved to a hardened SHA-1
> -implementation by default, which isn't vulnerable to the SHAttered
> -attack.
> +implementation by default, but SHA-1 is still believed to be weak.

Even if we've hardended against one particular form of attack, we
still have incentive to switch away from SHA-1.  It is unclear why
we just do not add ", but ..." to the original and instead remove
the half-sentence about sha1dc.

> @@ -57,6 +47,19 @@ SHA-1 still possesses the other properties such as fast object lookup
>  and safe error checking, but other hash functions are equally suitable
>  that are believed to be cryptographically secure.
>  
> +Choice of Hash
> +--------------
> +There were several contenders for a successor hash to SHA-1, including
> +SHA-256, SHA-512/256, SHA-256x16, K12, and BLAKE2bp-256.
> +
> +In late 2018 the project picked SHA-256 as its successor hash.
> +
> +See 0ed8d8da374 (doc hash-function-transition: pick SHA-256 as
> +NewHash, 2018-08-04) and numerous mailing list threads at the time,
> +particularly the one starting at
> +https://lore.kernel.org/git/20180609224913.GC38834@genre.crustytoothpaste.net/
> +for more information.

I personally think this is referring too much to external document
for typical readers, and lost too much relative to the original.  I
do not mind losing the history of how we reached the conclusion that
SHA-1 is no longer viable at all, but I am not sure if we want to
lose the list of criteria we used when choosing (i.e. stronger than
SHA-1, 256-bit, quality implementations, etc.) from this section.

> -The hash to replace this hardened SHA-1 should be stronger than SHA-1
> -was: we would like it to be trustworthy and useful in practice for at
> -least 10 years.
> -
> -Some other relevant properties:
> -
> -1. A 256-bit hash (long enough to match common security practice; not
> -   excessively long to hurt performance and disk usage).
> -
> -2. High quality implementations should be widely available (e.g., in
> -   OpenSSL and Apple CommonCrypto).
> -
> -3. The hash function's properties should match Git's needs (e.g. Git
> -   requires collision and 2nd preimage resistance and does not require
> -   length extension resistance).
> -
> -4. As a tiebreaker, the hash should be fast to compute (fortunately
> -   many contenders are faster than SHA-1).
