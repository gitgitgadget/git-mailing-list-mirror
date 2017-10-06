Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 689081FA21
	for <e@80x24.org>; Fri,  6 Oct 2017 01:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbdJFBRp (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 21:17:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56784 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751934AbdJFBRm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 21:17:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0816EA688C;
        Thu,  5 Oct 2017 21:17:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tHu7rueH95+Q
        RSaGJzzYT0oe5A4=; b=MzGqN09PhmfobUam8ggCcwO0nC5BTzjXO0CSya3JxJ1R
        IlKR49vs9ZvUshSO1s2Vg4cG7154YXjJtaEchRDqw3m32oFXsse4JRvhg2N8w8P0
        d8gPE8CKoDUKnqRm4YkEOev6WdfiRjdStvALlx3MkI9j5BJ1Oc26KMqR8zEiYEI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=NSSRfl
        Y3EE+oCg471JfvgigDPxtte+M8AIUMjY16Lr0ReQxbljz4oS5TjqkCDbpHFgwSTu
        +mZSYTVTXLJ58EUC+sDm3fHtsyQ1GGrV6DSFYikEzWd3lyQsaljrVq9esT2tPxUL
        2fTD4sUjal3TJG5IKFva2TucG4vV3CsAUhXYs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0041AA688B;
        Thu,  5 Oct 2017 21:17:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 70FB6A688A;
        Thu,  5 Oct 2017 21:17:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 01/12] sha1_file: do not leak `lock_file`
References: <xmqqy3osiwe6.fsf@gitster.mtv.corp.google.com>
        <cover.1507228170.git.martin.agren@gmail.com>
        <7f9a7a5d57bf76925e14111efdabe77f1c946e8d.1507228170.git.martin.agren@gmail.com>
Date:   Fri, 06 Oct 2017 10:17:39 +0900
In-Reply-To: <7f9a7a5d57bf76925e14111efdabe77f1c946e8d.1507228170.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Thu, 5 Oct 2017 22:32:03
 +0200")
Message-ID: <xmqqtvzdyszw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 263F7332-AA34-11E7-BA06-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> Bump `found` to the scope of the whole function and rearrange the "roll
> back or write?"-checks to a straightforward if-else on `found`. This
> also future-proves the code by making it obvious that we intend to take
> exactly one of these paths.
>
> Improved-by: Jeff King <peff@peff.net>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
> v2: Moved the rollback to the end to have an obvious if-else instead of
> retaining the original logic. Thanks Peff.

Yup, both are correct but this version is 10x easier to follow.
Thanks, both.

