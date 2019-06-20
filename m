Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D8151F4B7
	for <e@80x24.org>; Thu, 20 Jun 2019 20:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfFTUAn (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 16:00:43 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58667 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfFTUAn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 16:00:43 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 97B956BE35;
        Thu, 20 Jun 2019 16:00:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=LAmXzmrLNUjO
        mdLtT0bMjRRPMMM=; b=QvTL07h8szaWRaFoG7uMdrgf2t5S9JmvgmucI7YxfBNj
        7N9gBjY6mFnR11f+sMblp1mXbCY/aTzZPC4IDcnF53l/lXmRzlLBAo2xnWjbVbWn
        izCBs5asNAex6b8Qbqbov74tcUEiShZTV1OjbqMQxITh2pwelXWEgGLETxo13Hc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=BEGp6r
        /SHnLRmGu/JO1KaKiyBSWGHvh6WEZU5XYQCDJ3Kx1ebnoPz0ia+H9fr7ryHrmBIk
        I5du2d4MAuNBu1/ELfz3w47yDPfnHMdJAifOIqL9kM/4HOZRJkNI4BqOObsKlpf1
        jVN6N3+HCCuyf6u0QhMi9OCLZW7kBFdYZJzzA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 90AC46BE34;
        Thu, 20 Jun 2019 16:00:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 636156BE27;
        Thu, 20 Jun 2019 16:00:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] tests: make GIT_TEST_GETTEXT_POISON a boolean
References: <87imt18a2r.fsf@evledraar.gmail.com>
        <20190619233046.27503-4-avarab@gmail.com>
Date:   Thu, 20 Jun 2019 13:00:35 -0700
In-Reply-To: <20190619233046.27503-4-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 20 Jun 2019 01:30:43 +0200")
Message-ID: <xmqqtvckm3h8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1260A910-9396-11E9-8CDC-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the GIT_TEST_GETTEXT_POISON variable from being "non-empty?" to
> being a more standard boolean variable.
>
> Since it needed to be checked in both C code and shellscript (via test
> -n) it was one of the remaining shellscript-like variables. Now that
> we have "git env--helper" we can change that.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---

Hmph.  Even though I earlier said "we do not terribly mind breaking
developers and that is why we allow these patches", I have second
thoughts.  Turning "If it is empty, it is false" to "if you want to
say false, say it in one of those approved ways" is one thing.
Forcing SWITCH=3DYesPlease to be rewritten to SWITCH=3Dyes is quite
different---we are breaking everybody who would have to read and
follow po/README and t/README.

We _might_ have to grandfarther YesPlease as a special value that is
understood by "git env" (but not "git config") to ease the
transition, as that token has been used as a sample true value in
many places.

But let's read on.  Assuming that breaking those who hardcoded
YesPlease in their scripts is OK, this patch looked sensible.

Thanks.

