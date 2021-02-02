Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EC1C433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 19:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DCC664E08
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 19:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239990AbhBBTk7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 14:40:59 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53789 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbhBBTkh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 14:40:37 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D7723110AA3;
        Tue,  2 Feb 2021 14:39:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m3EiDD7pEzMjHbrQD8wbydN/dN4=; b=GMk+9u
        kY4WHPq3N/uNAiH3bHTCaYA8y8XPRskHGlJsNTcllKheHR15GjiSPEyESo/MGpQr
        ADShNBpDmn7mdrLeu8MGISewqndK1B3U116SBSc04numNiJQUq7rUTx7D1J/+eF2
        N4Ps1ecw+VCQdspR4ymxPrON+xaHg8s+eLf3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wTho0EILEHruQ/0eWFXbpdhHC0UvedYf
        pxi+wunvLqlVRXXDLnfTIR216NW8S6ROX7PbDOF31bcgIdW88v9x9rwyb4MN1jc2
        14YYem0g2wX92Yut67dkNQDKSy4BxwNi3t4jxMrSWOhe2PxUjj7kCxnxT8KKSu+Q
        QKlR7ndotEs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D06A2110AA2;
        Tue,  2 Feb 2021 14:39:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AA831110AA1;
        Tue,  2 Feb 2021 14:39:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Thomas Ackermann via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Thomas Ackermann <th.acker@arcor.de>
Subject: Re: [PATCH v2 2/6] doc hash-function-transition: use SHA-1 and
 SHA-256 consistently
References: <pull.858.git.1612093734.gitgitgadget@gmail.com>
        <pull.858.v2.git.1612282749.gitgitgadget@gmail.com>
        <681ce4129dc35b6a61aac0dbd1b9b9d638a2b78d.1612282749.git.gitgitgadget@gmail.com>
Date:   Tue, 02 Feb 2021 11:39:45 -0800
In-Reply-To: <681ce4129dc35b6a61aac0dbd1b9b9d638a2b78d.1612282749.git.gitgitgadget@gmail.com>
        (Thomas Ackermann via GitGitGadget's message of "Tue, 02 Feb 2021
        16:19:05 +0000")
Message-ID: <xmqqft2egsxq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6873FCA0-658E-11EB-9B41-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Thomas Ackermann via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Thomas Ackermann <th.acker@arcor.de>
>
> Use SHA-1 and SHA-256 instead of sha1 and sha256  when referring
> to the hash type.

Ahh.  [1/6] was supposed to be only about formatting, and I found it
a bit irritating that it had some of these changes mixed in, as it
was not entirely clear to me that [1/6] covered all those lowercase
sha1 and sha256 instances, or just some of them.

Moving them from [1/6] to this step would help future readers by
reducing such irritation (I do not know if it is worth it until
I read through the series to the end).

> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---
>  .../technical/hash-function-transition.txt    | 122 +++++++++---------
>  1 file changed, 61 insertions(+), 61 deletions(-)

Thanks.
