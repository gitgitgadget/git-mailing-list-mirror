Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A7251F463
	for <e@80x24.org>; Fri, 20 Sep 2019 21:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbfITVrn (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 17:47:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61170 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfITVrm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 17:47:42 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B516C2FE80;
        Fri, 20 Sep 2019 17:47:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JfrGGS+8CqDY
        a9grnGjI4U9rY7c=; b=wwXCAy33zzi/yS9UC4KuYtzTmIKlhD/Tv85/nV9WolmU
        pdHIEJPqYCVRIpxAykal2l+2o1lcGp8x5E2ljdfHc7U9oV98b//sWmo0ioWIlcSv
        j/SkxTQBS9bbCovTJYNL6a8pgACTVu6QUIqSceOT0VEasos7yZT8iJowE8TuPSg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=irasUD
        EUXyWlXyteZvLTWVGd1Hbk2StGFOiBL1PgIzCvdg0ZGQ0CxvdD0XUjTZh/hVY0in
        eT+gDdy319gi8K2yzvNjuNG1C3/k0/65XPiJrxjUK6XG0P773rVMufqEPhhmZzZQ
        bf277HRepc20/2XZreRHENRgFWMEL2X76W1uE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC4A32FE7F;
        Fri, 20 Sep 2019 17:47:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 189552FE7E;
        Fri, 20 Sep 2019 17:47:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 01/15] t6120-describe: correct test repo history graph in comment
References: <20190919214712.7348-1-szeder.dev@gmail.com>
        <20190919214712.7348-2-szeder.dev@gmail.com>
Date:   Fri, 20 Sep 2019 14:47:38 -0700
In-Reply-To: <20190919214712.7348-2-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Thu, 19 Sep 2019 23:46:56 +0200")
Message-ID: <xmqqv9tmskqt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 449B2610-DBF0-11E9-9860-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> At the top of 't6120-describe.sh' an ASCII graph illustrates the
> repository's history used in this test script.  This graph is a bit
> misleading, because it swapped the second merge commit's first and
> second parents.

Hmm...

> +#       ,---o----o----o-----.
> +#      /   D,R   e           \
> +#  o--o-----o-------------o---o----x
> +#      \    B            /
> +#       `---o----o----o-'
> +#                A    c

What's the first parent of the merge between 'B' and 'c' in this
picture and how does the reader figure it out?  What about the same
question on the direct parent of 'x'?  Is it generally accepted that
a straight line denotes the first ancestry, or something?  I do not
offhand see between these two the new one is a clear improvement.

I do agree with the issue with illustrating topology, and it is an
issue worth addressing.  In the past when the order of parents
mattered, I experimented to find ways to depict them clearly,
without much success.  One of the things I tried was to label the
parents, like so:

> -                       B
> -        .--------------o---1o---2o----x
> -       /                   2    1
> - o----o----o----o----o----.    /
> -       \        A    c        /
> -        .------------o---o---o
> -                   D,R   e

but I did not find it very satisfactory.

In any case, since this step is about "improving" the illustration,
I'd like to see a clear improvement.  Perhaps an extra comment that
says "straight line is the first parent chain" next to the drawing
might qualify as such.

Thanks.
