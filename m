Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFEFC4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 21:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B041222522
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 21:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503597AbgLNVFH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 16:05:07 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51230 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503618AbgLNVE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 16:04:58 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 28521AA0F5;
        Mon, 14 Dec 2020 16:04:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=3p1RRte4Li2vRs9OUREVTH1RNo4=; b=YsOP1IlmDhHFZm3qv0UQ
        VcfgwY0Fmit1K4i+D2uktBbrdEJoAdjLFNxbxzsjoIrCMu6B7GxwyKYlucvq59R7
        L0SKa0TGCJmNvoG3KnCOU0prLffdd9ZdKIR+ITp7z98+a8vOSrP2itJCiVRRu1t1
        Gsct+qkj7Pot0YTSJuvatXY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=e0mxm7w3mQ6lN3NpDA9ClEmXq120RTh4amDUahT/gj8XKU
        hdiBup1SHysf29KunotK4ljdTfyPVlntLEZPkE2svro1vhHrGzbQG3D3bpkmnMvb
        5Us0eklL71t+xbn9yw2b0sfzqPYd2RE09EVbWtF5zBg+8o7svpINE4ebzY/UY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E3EEAA0F4;
        Mon, 14 Dec 2020 16:04:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7D397AA0F3;
        Mon, 14 Dec 2020 16:04:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?Q?V=C3=ADt?= Ondruch <vondruch@redhat.com>
Subject: Re: [PATCH v5 3/3] pull: display default warning only when non-ff
References: <20201210100538.696787-1-felipe.contreras@gmail.com>
        <20201210100538.696787-4-felipe.contreras@gmail.com>
        <xmqqzh2kitn9.fsf@gitster.c.googlers.com>
        <CAMP44s0wjfZ9TeQzpJvVD-OzFA47HFd87TABiJo3Ec9H8j-fjA@mail.gmail.com>
        <xmqqa6ujj3s4.fsf@gitster.c.googlers.com>
        <xmqq1rfvgtvx.fsf@gitster.c.googlers.com>
        <5fd4e94317d67_bc1eb208da@natae.notmuch>
Date:   Mon, 14 Dec 2020 13:04:14 -0800
Message-ID: <xmqqo8iwje0h.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EC748B5C-3E4F-11EB-AA03-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> The original author of this test cared that pulling c1 with --rebase
>> into c0 succeeds, and that it does not give the error message.
>
> I prefer not to attempt to read minds (plus, the author might have not
> cared that the pulling succeeds), and anyway; that's not what matters.
> ...
> Again, I don't particularly care to mindread what the test authors might
> have cared about.

You do not have to read mind.  What is written in the test is clear
enough: run "git pull --rebase . c1" into c0 and see what happens.
