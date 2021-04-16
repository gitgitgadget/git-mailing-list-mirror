Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B688DC433B4
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 23:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90D656109F
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 23:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbhDPXQH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 19:16:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62456 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234209AbhDPXQG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 19:16:06 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E34A4B0C28;
        Fri, 16 Apr 2021 19:15:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5GtT5QiBWZk6/60K5pxCsFSj/IU=; b=p9UHsy
        y4ax4vEul8KKj8czTvMPPvw3hEdwxFN7b53KXkVpTB0v6ovL3J6ZKy4w53rjUezn
        VyRXnkcFTSBgMC0lnDTBveo/DDZ0u2TupwR743dFT2gORkuxY4bwGayOU1dL2fFk
        L3O2N+O3EluZCFc16MWeDZqOHKbf552ugTfSw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pT1YgdWoIVGMxOAkQkJyxGfreiXcCcGX
        jscugP19tfRDBeNW3GbHuURF1t3uVeWdRVFlFzyStJEDyModuQCZO5vwYagezrre
        cYjHm0U0ljbI4e2RBlSz5TluBR/SPcM7504mhs2AUs97xMMT+BcHdGaqZrPjTRQK
        blJp7OEjmME=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DAAB9B0C27;
        Fri, 16 Apr 2021 19:15:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 65E36B0C26;
        Fri, 16 Apr 2021 19:15:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 0/8] rev-list: implement object type filter
References: <cover.1617967252.git.ps@pks.im> <cover.1618234575.git.ps@pks.im>
        <YHVMEdeDv9ZeXRAU@coredump.intra.peff.net> <YHVQ9RPLk8/r+8mS@ncase>
        <YHgKiXRMq/1Fpg2x@coredump.intra.peff.net>
        <xmqqlf9hkhpp.fsf@gitster.g>
Date:   Fri, 16 Apr 2021 16:15:39 -0700
In-Reply-To: <xmqqlf9hkhpp.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        16 Apr 2021 15:06:10 -0700")
Message-ID: <xmqq4kg5kehw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9086F3A-9F09-11EB-B37F-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I think the only remaining issues are the comments on 5/8 on tests,
> then?  Hopefully we can have one more iteration to finalize the
> topic and merge it down to 'next'?
>
> Thanks.

I guess not.  I am guessing this topic is responsible for

  https://github.com/git/git/runs/2366364023?check_suite_focus=true#step:4:115
