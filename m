Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2D6C433DB
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 01:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E761E23A5A
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 01:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731634AbhAOBpj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 20:45:39 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53255 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731572AbhAOBpi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 20:45:38 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 75047111BEE;
        Thu, 14 Jan 2021 20:44:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hIYiOVOBM7+iJtyTMJKeYANlohg=; b=Vd5z3K
        MPNlSi6JQ6VEe7uLpvSS0tFth3WJ+jC8dFjVsv6fNPcfvPOQzPpuTFBF4cbpSDKZ
        +AoL00LMk56yUnhyNtCA49EcwPpkdd15G+9LE+sEA7ZKyIXodXu5ha7YjL3rxRZu
        1rtEHcK87Gzgv19zr+02y/h0wQBqemdof3Fns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GhM/ClTuKRMst3Br6GATX+xW+HENxmZO
        cvSvUbC8ASab/mkRZRrhdPqh56UJzIUaUCUSbwaYcgU0YHs4Gw+/saTcHDGQd/jz
        ct1d+H5znHvNb3bLffWCCuLA6txWciYz8zkvFIz1Zy/0bEF5jMFs6WT6BWY75uGm
        TU6NNJNUDqQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6D03C111BED;
        Thu, 14 Jan 2021 20:44:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B3406111BEC;
        Thu, 14 Jan 2021 20:44:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2021, #02; Fri, 8)
References: <xmqqk0sni68g.fsf@gitster.c.googlers.com>
        <871reu752k.fsf@evledraar.gmail.com>
        <xmqqk0slg5ph.fsf@gitster.c.googlers.com>
        <X/oosXBJlyt/IrOr@camp.crustytoothpaste.net>
        <xmqq4kjpelza.fsf@gitster.c.googlers.com>
        <X/uvhc5Hpu792qA/@camp.crustytoothpaste.net>
        <xmqqeeir8fdg.fsf@gitster.c.googlers.com>
        <87k0si5k75.fsf@evledraar.gmail.com> <YADZSsVqyGnArF0n@google.com>
Date:   Thu, 14 Jan 2021 17:44:52 -0800
In-Reply-To: <YADZSsVqyGnArF0n@google.com> (Emily Shaffer's message of "Thu,
        14 Jan 2021 15:52:42 -0800")
Message-ID: <xmqq4kjjvuqz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 439F0C04-56D3-11EB-A1B3-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Secondly: it seems like a restatement of the goals of this patch would
> help guide a discussion of designs; I would be so pleased to see a
> cleaner solution than any that's been proposed so far, because I agree
> that this feature is not perfect. So please append what I have missed:
>
> Axiom: The current Git solution for avoiding deadnaming is insufficient.
> Axiom: We want to improve Git's solution for avoiding deadnaming.
> (That is, I don't think either of these statements are or should be up
> for discussion.)

Another one [*1*]:

Axiom: It is, by nature of how Git works, impossible to come up with
a solution that avoids deadnaming perfectly.  The best we can do is
to aim for "good enough".

> Goal: Projects which are contributed to by trans individuals who
> transition during their contribution period should provide a good,
> supportive experience, which does not deadname the individual.
> Goal: Git's performance should not suffer unduly from any change unless
> necessary.
> Goal: Project maintainers should have an understanding of the threat
> model (e.g. automated tools scraping for names, malicious individuals
> with time on their hands and experience with the project, etc)

Goal: the design should clearly describe the thread model it
supports, so that "good enough" can be judged against it.



[Footnote]

*1* This may be clear from what both you and I said about perfection
and being good enough.  I usually do not like to see people punt for
an imperfect solution too early without even trying, but in a case
like this where we know perfection is theoretically impossible, it
is a totally different story.
