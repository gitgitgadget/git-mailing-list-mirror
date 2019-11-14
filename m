Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 697F81F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 02:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfKNCoQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 21:44:16 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62480 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfKNCoQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 21:44:16 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F2FE35B41;
        Wed, 13 Nov 2019 21:44:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=B5DCnI1Iugbv
        crq7ToxrTU4pnWo=; b=r7jBiYCGOFLW1LNwlA1xIbpto/UdhWT3chaQBEBHviJZ
        LfLNY3kvMZecjVQYPC7JRJZ46MH+2anuVtBDZlDLUV6wMvltT3Uf1yF6ZdpC8khv
        dA1ed97PJqHnDJYmllnWkF1kZdUMhkAOpFw1nCFojxBL2oAbD/TRd9keO773u5w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=q51UTq
        yz/ZZnugVQs8exp50T7Rov6a5b1MGDCxuC0aiJ7q/j7BKvHm8m+EHeZS06Vm/HRd
        f4gZFP4LA6XGmY81e20RxAlMcdyDXDo1ecd9s1WyuGhvGR9vOxlXQRgiGjMRxSYc
        mtz3IWI8Pb1mqZ5WHwSCChfPfGy7bY0cS5aGQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 552A035B3F;
        Wed, 13 Nov 2019 21:44:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 83EFE35B3E;
        Wed, 13 Nov 2019 21:44:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>, g@generichostname.pobox.com,
        =?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 09/10] pretty: implement 'summary' format
References: <cover.1572897736.git.liu.denton@gmail.com>
        <cover.1573241590.git.liu.denton@gmail.com>
        <e74eab6d21f655698ef8b6e1286b44ea070a7af7.1573241590.git.liu.denton@gmail.com>
        <08afdbcd-5972-05f9-ec8c-b12bd29d9030@web.de>
        <xmqqftiwl02i.fsf@gitster-ct.c.googlers.com>
        <20191111234710.GA23111@generichostname>
        <20191114003757.GR4348@szeder.dev>
Date:   Thu, 14 Nov 2019 11:44:12 +0900
In-Reply-To: <20191114003757.GR4348@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Thu, 14 Nov 2019 01:37:57 +0100")
Message-ID: <xmqqy2wj89dv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A4A11ACA-0688-11EA-AFBB-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> Yeah, it's as simple as adding:
>
>   { "reference",  CMIT_FMT_USERFORMAT,    1,      0, 0, "%C(auto)%h (%s=
, %as)" }
>
> Works like a charm, I've been using it for a few years now:
>
>   https://github.com/szeder/git/commit/3604d0c28e7e2da5415986468994ef71=
a972e4ed

The word "reference" does sound more to the point for the feature
than "summary", and it is nice to see that the required change is
essentially a single liner ;-)

> but never seriously considered for submission, because I didn't want
> to argue about removing the double-quotes around the subject, and

I personally do not care whether the title is naked or inside a
dq-pair, as that part is purely for human consumption.  Being for
human consumption, I guess we can argue that the shorter the better,
so we may want to standardise the recommendation we give in our
tutorials and such.

> couldn't be bothered to check the corner cases (e.g. what if a user
> sets a pretty format alias with the same name in the configuration?).

It would be already possible to collide with built-in names, like
"short", with or without your addition, wouldn't it?  Then that is
not an issue you would need to be worried about, right?

Thanks.
