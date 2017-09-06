Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AC15209AB
	for <e@80x24.org>; Wed,  6 Sep 2017 19:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752408AbdIFTwJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 15:52:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59661 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752306AbdIFTwI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 15:52:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6819B98A02;
        Wed,  6 Sep 2017 15:52:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=03zUyexOTFoTxxfU4RFENNQ7t
        QU=; b=NJk5c6KS9UyjiMqoXDQ2jywaPsg5TRsvRlleVaLfY7rEI1OqDZQp/a8G5
        SspJb+4UZQ5gNnJs1IqwwCuqci/tCYbLxwGkEE5qTVP5YrYMJbHCChrywo72hTZi
        QPXHsur9IeRVoslUFvj+o377FiV/aZT562yuDBpTk+4y36lAWI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=fAPJ86Ij36PzfHIEcdE
        fiu46zaV4BcvSj+Obvs6h0KxEYuSOw6CYfSZ5vg5EzmawGpyFqWLqIJmhyT+RdNl
        zQ96k3Cu5CYUlARyzRG+ux8FhQwFt/t+7LSGvdmUaQocE30OEVnsi2CtXctDelqk
        EAiT9OLjyF9IW88vXfaJSJNM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5EFA598A01;
        Wed,  6 Sep 2017 15:52:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B4FE798A00;
        Wed,  6 Sep 2017 15:52:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] refs/files-backend: add longer-scoped copy of string to list
References: <CAN0heSqn59sFF3A-eQ593G+ZDWnO9pKM5F=sgiSQk+prUr-nSQ@mail.gmail.com>
        <4b4c0d178ad2216eecbc49fb6f54dd8a1d1ac119.1504024261.git.martin.agren@gmail.com>
        <91e365b5-6a5d-1e1c-ab7a-579efa7c1ae8@alum.mit.edu>
        <CAN0heSqa8OnPnkd1xbyZ=QN9qg_8OaxBYnwzOZDDA3g+uGE71g@mail.gmail.com>
        <xmqq60cxcvjk.fsf@gitster.mtv.corp.google.com>
        <CAN0heSqnrPUEgP-BgvuHuVrDG2ifuHHDOPPmxiXJ73u4-PrOng@mail.gmail.com>
        <20170905203622.6fs3hr7zfa7mwpqn@sigill.intra.peff.net>
        <xmqqmv68bzvj.fsf@gitster.mtv.corp.google.com>
        <CAN0heSr0AWj-QwchX2DPzkZs9cx1gsfUTevN4JD1Ze=2t-YZiQ@mail.gmail.com>
Date:   Thu, 07 Sep 2017 04:52:06 +0900
Message-ID: <xmqqtw0f4nbt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DD434856-933C-11E7-9ECF-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> Junio: The topic is in pu as ma/split-symref-update-fix. Re-roll or new
> topic or as a separate "patch 4/3" for you to place on top, any
> preference?

Until a topic hits 'next', you solely own it and it is mostly up to
you how to go about improving it.  My preference would be much less
relevant than what the end result would require, i.e....

> If we re-roll, would you prefer Peff's much smaller take on patch 2
> (strbuf_release where it matters, instead of sprinkling "goto out" all
> over)? I think me and him agreed that we'd be fine either way. I'd reus=
e
> my commit message, if I get his sign-off and "From:".

... if we take Peff's approach, then rerolling the whole thing would
be the only approach that makes sense---incremental update would
make the resulting history less readable.  Between two approaches I
do not have a strong preference either way---it's a choice that can
be made between you and Peff.

> Obviously, if Michael or anyone else has any input, I'm open to that as
> well..

Sure.
