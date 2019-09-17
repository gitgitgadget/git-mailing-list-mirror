Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AFC81F463
	for <e@80x24.org>; Tue, 17 Sep 2019 16:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbfIQQNt (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 12:13:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60352 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfIQQNs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 12:13:48 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9FAF92EE36;
        Tue, 17 Sep 2019 12:13:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9pV7ww4ibOyP
        2Km8xZDOywaYgBk=; b=SlAX6ROpZ9dsI9QNuJ3C0kWhODSVN0bWInQl2KW6a+/X
        i1iMiW8wZpEJcADf5ld2z35+WPmR/FS2JKPqbB5y9gMDBhQszDRkDBgNJiwvjrXa
        pPoKzjlTbUb0HvuDzF5Ot8Lb8vc09qHvDuM9j9s42dpnBWFYLggHDvGONloWFrg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=S97AfZ
        QiQ8EDSe1m+9uU05kbvd/p+56zh2VFdSQNOXqlJ7YyjbmmzpKlEwmTzFl7OvZNNk
        9FjCYxNFE6W5yihFxRwnTRowL1YwUyk6PJhTZp4dKkyr4BvWnz/K8dAOJQ+FLuGd
        1OMFnocOuEWBTga53PTbzJRSBGPr7idPQCbS0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 967E02EE35;
        Tue, 17 Sep 2019 12:13:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F214F2EE34;
        Tue, 17 Sep 2019 12:13:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/4] Makefile: run coccicheck on all non-upstream sources
References: <cover.1568309119.git.liu.denton@gmail.com>
        <cover.1568661443.git.liu.denton@gmail.com>
        <xmqqh85c9cyd.fsf@gitster-ct.c.googlers.com>
        <20190917081821.GF6190@szeder.dev>
Date:   Tue, 17 Sep 2019 09:13:44 -0700
In-Reply-To: <20190917081821.GF6190@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Tue, 17 Sep 2019 10:18:21 +0200")
Message-ID: <xmqq7e66aojr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 201C049E-D966-11E9-B661-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Mon, Sep 16, 2019 at 01:57:14PM -0700, Junio C Hamano wrote:
>> Queued; thanks.
>
> Nit: it would be nicer to queue this series on top of
> 'dl/compat-cleanup', because 'make coccicheck' errors out suggesting
> transformations in 'compat/mingw.c' that have only been applied in
> that series.

Yikes, yes I remember that you pointed it out already, yet I
forgot.  Will correct.

Thanks.
