Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688FEC4332F
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 17:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 521F16109F
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 17:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhKCRQm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 13:16:42 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62763 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhKCRQl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 13:16:41 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 21EAC1659AA;
        Wed,  3 Nov 2021 13:14:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9V+CAhm4s77C3WhupDu4RGyVfAv2qkLy9QZI6X
        fvNNo=; b=StL9V0gkYw0+jSBKvKdP7thSYgl7WgbT3vEuQn7H5uezgaTNn6XwP0
        +GnsYKz+oZAnhjGZCHi0u3htWsLnH8hyjklGYyqBXfK67Mmh0ef3GbRZ0o2/MF0Q
        rmQmGdsy/qEa+J9ejla1n19e5oiW4lNy7zC90dkDgtdtf+udhvPyM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 19AB01659A9;
        Wed,  3 Nov 2021 13:14:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B0E541659A5;
        Wed,  3 Nov 2021 13:14:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        newren@gmail.com, matheus.bernardino@usp.br, vdye@github.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v4 04/13] dir: fix pattern matching on dirs
References: <kl6lzgqnv2dn.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqq7ddr9z0i.fsf@gitster.g>
        <2f1d2e09-faf5-0caf-6be8-7bcede9fe8d1@gmail.com>
        <7a62be4e-aa69-8a79-4608-971b96ee4d7c@gmail.com>
        <211102.86pmri1rv7.gmgdl@evledraar.gmail.com>
        <1b9e4d3b-faa6-c9fc-c734-4720f9f832df@gmail.com>
Date:   Wed, 03 Nov 2021 10:14:00 -0700
In-Reply-To: <1b9e4d3b-faa6-c9fc-c734-4720f9f832df@gmail.com> (Derrick
        Stolee's message of "Wed, 3 Nov 2021 10:40:51 -0400")
Message-ID: <xmqq8ry588mf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 70A212BE-3CC9-11EC-BB46-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Those tests are quite exhaustive, but the test script is pretty
> inscrutable and the refactor you suggest is pretty major. I'd prefer
> to keep to the focused test for the sake of fixing this in time for
> the release.

Thanks, both.
