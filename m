Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CE351F404
	for <e@80x24.org>; Fri, 19 Jan 2018 19:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932690AbeASTM7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 14:12:59 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55927 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932551AbeASTMX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 14:12:23 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3559EC8EB0;
        Fri, 19 Jan 2018 14:12:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NimqwxhoIU8C
        tqZo6BGY9K00zOw=; b=dB7Ce3ON5wlY3k/i0AUGjoqnqpw3apjndMRkAoFdAxTE
        OF+yW+SDGUWBfkeTTF4R1NkB3BpBLtL61YwI/+KGokWXGmcQwgdf8uV/o2I/T4hs
        XLD9kykGad6ht9xP1qQRoin5pg0LKdFNueAcPi0PEdmsSpayPpNGRJQmWp7b6Lw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=U5Q4Sq
        9Xsg5w+SSBljZwvUA7JYr38MmbcP06qGqlSgFIVgVtKwtYSAHdE2NVXfr2JJf/uM
        fIPbwBtPKyO+p53i8bDnikhAg5uaGo9f6ZOpRemSeChFfiHxdHsL4bmAiYxu8Hvs
        wrmU6uHhUvcFa8Rxi5y8GvO6a6MEjCUScNagU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D87CC8EAF;
        Fri, 19 Jan 2018 14:12:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A4B17C8EAE;
        Fri, 19 Jan 2018 14:12:22 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, peff@peff.net,
        git@jeffhostetler.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2] packfile: use get_be64() for large offsets
References: <20180118141522.18294-1-szeder.dev@gmail.com>
Date:   Fri, 19 Jan 2018 11:12:21 -0800
In-Reply-To: <20180118141522.18294-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Thu, 18 Jan 2018 15:15:22 +0100")
Message-ID: <xmqqvafxpsru.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AD6AD87C-FD4C-11E7-A194-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> Junio,
> ...
> This patch can't be applied to 'maint' currently at 3013dff86 (Prepare
> for 2.15.2, 2017-12-06), as it is in case of 'ds/use-get-be64',
> because 'maint' doesn't have get_be64() yet (b2e39d006 (bswap: add 64
> bit endianness helper get_be64, 2017-09-22)).

Thanks for stopping me. =20

I do not always get to test anything not in 'next' in isolation
before I actually try to merge it there (at which time I would have
noticed), and you caught me in this one doing a short-cut "just
queue it somewhere and throw it in 'pu'".


