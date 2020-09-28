Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7C1C2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 19:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B38A82065D
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 19:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Hx1fvHip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgI1Tvr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 15:51:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58580 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgI1Tvr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 15:51:47 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AE6B4EE1F7;
        Mon, 28 Sep 2020 15:51:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/5DJbNwY8YCjgrfjKgaLz63FfEw=; b=Hx1fvH
        ipYOl8BvuPg2MMOJIswvblaFp3bwVVBNo9Yz2jHW6PeKIdNfkyVsrpScqsbp/Tbd
        J27jyolInt+Pdor90H8IbC5ZvrF1GCE5Ac+j9nb0ByysrWHxx2D02qF9kQ9pPrAm
        zbCZ0vot1MqipjA8q0XfqvjUgzhWbCcOOLRLA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Uf/eChCeItFylCijEEa02au9g2g6hk2c
        Qmk431DhqJupnBHXOgX3JMyZ7KHr6NsJJ75dNNX3B/nFgI67fusj0xVMxbvSw1mQ
        zLJ4TUufWhPW15KGs43IumHpyXCtqiNnu6AoYcpj1dIpYw/N2q+uFdiCI/jUvkOd
        M9MwJ+kyQgc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A65A1EE1F6;
        Mon, 28 Sep 2020 15:51:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A833AEE1F5;
        Mon, 28 Sep 2020 15:51:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v8 0/3] push: add "--[no-]force-if-includes"
References: <20200926114626.28823-1-shrinidhi.kaushik@gmail.com>
        <20200927141747.78047-1-shrinidhi.kaushik@gmail.com>
        <xmqqtuvhn6yx.fsf@gitster.c.googlers.com>
        <20200928174619.GB24813@szeder.dev>
        <20200928193400.GA88208@mail.clickyotomy.dev>
Date:   Mon, 28 Sep 2020 12:51:41 -0700
In-Reply-To: <20200928193400.GA88208@mail.clickyotomy.dev> (Srinidhi Kaushik's
        message of "Tue, 29 Sep 2020 01:04:00 +0530")
Message-ID: <xmqq4knhn0he.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0828E096-01C4-11EB-B445-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:

>> That build runs the test suite with a bunch of GIT_TEST_* knobs
>> enabled, and the last two tests added in this series fail when run as:
>> 
>>   GIT_TEST_COMMIT_GRAPH=1 ./t5533-push-cas.sh
>  
> Thanks for the heads-up. It turns out that "in_merge_bases_many()"
> returns different results depending on "GIT_TEST_COMMIT_GRAPH".
> Initially I thought that it might be related to batching the entries,
> but that is not the case.
>
> One of the tests that is failing is:
>   cd src &&
>   git switch branch &&
>   test_commit I &&
>   git switch master &&
>   test_commit J &&
>   git pull --rebase origin master &&
>   git push --force-if-includes --force-with-lease="master"
>
> Here, we are testing to check if forced updates are allowed after
> the remote changes have been incorporated locally, which is true
> in this case and should pass.
>
> "in_merge_bases_many()" used in the check as follows:
> ...
> Unfortunately, I am unfamiliar with the code, and not sure why this
> happens; I remember Junio mention [2] something about generation
> numbers could it be related to that?

Now it's time to summon the commit-graph folks.  I think we should
assume that it a bug in the code with commit-graph if it produces a
result that is different from the code without, until we prove
otherwise (e.g. in a history with clock-skew, traditional traversal
of A..B could give a wrong result where commit-graph may produce a
correct result.  I however think the topology-based merge-base
computation does not suffer from the same issue).

Thanks.  
