Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538E5C433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F082364F21
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbhCQVH2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 17:07:28 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52561 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbhCQVHE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 17:07:04 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3BBFA135A3F;
        Wed, 17 Mar 2021 17:07:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bF9uP4V7y5WC
        O3c/PVSdxTYBFqQ=; b=WQug6kTBcJqG2BJgas2pQUiwsY5QVXJeVPrttd0Aiup8
        DKLuFMhXr0eGSaJt/sTs/9CF351jyYGaGvG7Ryw4Pw4JwnBLteGt5EqqLXWb0x34
        /SdyyIFa2jugEDH/CnZlGenBhntIBXJkniQBYELvL8ihpRC7a+s61lCLb7Hre2A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=tT9gOD
        8TfC5OGhvnE/s2nWP/pD+l+bYqzqd1h+Q9Y2TLmzqltaO4UVYK/n9FaUOYG2wLLo
        sUiEsReCa9rHXWKPm0+mltPzw0sl9LFf2YUakocw/FmXChQfpdYj3DDv/CpRc7Rn
        DR3TuyZr2xsQLHLIIThAUFtg0B+6z86BruW1M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 33970135A3E;
        Wed, 17 Mar 2021 17:07:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 72C6B135A3B;
        Wed, 17 Mar 2021 17:07:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v5 00/19] fsck: API improvements
References: <20210316161738.30254-1-avarab@gmail.com>
        <20210317182054.5986-1-avarab@gmail.com>
Date:   Wed, 17 Mar 2021 14:06:59 -0700
In-Reply-To: <20210317182054.5986-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 17 Mar 2021 19:20:35 +0100")
Message-ID: <xmqqk0q5trpo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B7C99268-8764-11EB-B3D9-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> A v5 with changes suggested by Derrick Stolee. Link to v4:
> https://lore.kernel.org/git/20210316161738.30254-1-avarab@gmail.com/
>
> Changes:
>
>  * 1/19 is new, it's a simple refactoring of some git_config() code in
>    fsck.c code I changed recently.

The new step makes sense.  I think the series and my comment e-mails
crossed, and all of my comments on the previous round still applies
(including the fsck-cb.c thing, which I think should be added to its
sole user index-pack.c, not to fsck.c).

Thanks, will queue.
