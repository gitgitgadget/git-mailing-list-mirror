Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91EAB1F462
	for <e@80x24.org>; Mon, 10 Jun 2019 16:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387489AbfFJQqf (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 12:46:35 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52860 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfFJQqf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 12:46:35 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3FD0A865B6;
        Mon, 10 Jun 2019 12:46:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GU7LmYEsZLtN
        nZelIuVosPoLnjo=; b=nDqMaYmHVY983nptxzG6+MqOFXPOpdOA//HjNMQVPJEp
        oejA9xaQCNCKT/yQmcbuLH1CMgtwdxRFkcZumBVro7tPlC0PJCOmuDnIhqJ0RB/9
        B1m/Dkk6Xv6Fda/wY+94yMNEB9TPdVl39bCRe8/qgVHYtgCj1NTbOG0xBnmvwq8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=tWMyUq
        PWFSnqa9U29DK9uxnaXf0TP+Ydge1mBBdntTbbyGr5gcTxLgNPEBQo8gehmSefKi
        i1HEXr4QJG+PeH8y9AjKrddZAnyZrzq/zKiTv6/uICZspCThk5P+ZcK8hOZsaGrB
        9EGInxhqWRYeAPv8gZ4CFOXYY5BVo9VCFkRfI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 37C81865B4;
        Mon, 10 Jun 2019 12:46:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5AE71865B1;
        Mon, 10 Jun 2019 12:46:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/3] t: add t0016-oidmap.sh
References: <20190609044907.32477-1-chriscool@tuxfamily.org>
        <20190609044907.32477-3-chriscool@tuxfamily.org>
        <20190609092259.GB24208@szeder.dev>
Date:   Mon, 10 Jun 2019 09:46:27 -0700
In-Reply-To: <20190609092259.GB24208@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Sun, 9 Jun 2019 11:22:59 +0200")
Message-ID: <xmqqftoho0bg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4C127B10-8B9F-11E9-98A6-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> So, 'test oidmap' from the previous patch prints the value we want to
> check with:
>
>     printf("%u\n", sha1hash(oid.hash));
>
> First, since object ids inherently make more sense as hex values, it
> would be more appropriate to print that hash with the '%x' format
> specifier, and then we wouldn't need Perl's hex() anymore, and thus
> could swap the order of the first four bytes in oidmap's hash without
> relying on Perl, e.g. with:
>
>   sed -e 's/^\(..\)\(..\)\(..\)\(..\).*/\4\3\2\1/'
>
> Second, and more importantly, the need for swapping the byte order
> indicates that this test would fail on big-endian systems, I'm afraid.
> So I think we need an additional bswap32() on the printing side, and
> then could further simplify 'test_oidhash':

Yup, if we are doing an ad-hoc t/helper/ command, we should strive
to make it help the driving scripts around it to become simpler, and
your suggestion to do s/%u/%x/ is a good example of doing so.

Thanks for a dose of sanity.  The goal of the series may be
worthwhile, and helping hands in improving its execution is very
much appreciated.
