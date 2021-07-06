Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AD8C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 19:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 015F761C5B
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 19:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhGFT5i (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 15:57:38 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61910 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhGFT5h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 15:57:37 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B779F13513F;
        Tue,  6 Jul 2021 15:54:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qoJ9DraPpdJFccYYwbE2bqQSxnTpMaEhGxskkp
        CeCms=; b=SPPMobA6l91GbKpkKhQsBFHBZJZJHoJT42IZk1m22xL2hN5cs5c3XU
        iX2mUJnjI1Ckzr6QrAfe6rF/mD/ldA1eKHCtJDPE1U5oda5R8PkcOPbPdU4rm83O
        3oy9e4iiHJLOKAyJNW7WhRAQ4MKb43zA0jGxOzl7VQ+KTXYdNrWzk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B047113513E;
        Tue,  6 Jul 2021 15:54:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2EF0113513D;
        Tue,  6 Jul 2021 15:54:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2] refs: make explicit that ref_iterator_peel returns
 boolean
References: <pull.1006.git.git.1618484566164.gitgitgadget@gmail.com>
        <pull.1006.v2.git.git.1621438289354.gitgitgadget@gmail.com>
        <xmqqzgwqwcu1.fsf@gitster.g>
        <CAFQ2z_OUxrW_m5H_y62=Q_i0Kj3c4=2Kzf4hRwVwp-wGPcGayw@mail.gmail.com>
        <CAFQ2z_M-NmN2xVjoudzEqpAvugyRBQkKh+N4r_s_W=U99Uvwpg@mail.gmail.com>
Date:   Tue, 06 Jul 2021 12:54:54 -0700
In-Reply-To: <CAFQ2z_M-NmN2xVjoudzEqpAvugyRBQkKh+N4r_s_W=U99Uvwpg@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Tue, 6 Jul 2021 20:09:40 +0200")
Message-ID: <xmqqo8bfi5f5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0992F95A-DE94-11EB-9C97-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Thu, May 20, 2021 at 11:04 AM Han-Wen Nienhuys <hanwen@google.com> wrote:
>> > So this corresponds to the bottommost step in the series that is
>> > queued as hn/reftable, with the difference at the end of this
>> > message.
>> >
>> > Do you want me to replace that single step with this version and
>> > rebuild the remainder of the topic on top?
>>
>> Yes.
>>
>> I'm hoping this can graduate soon, so the hn/reftable topic becomes
>> smaller (I don't know what that means for your organization of the
>> seen branch).
>
> Any update on this? This wasn't queued for next, but I believe it should be.

Sorry, I thought you meant you wanted to fix up the bottommost
commit in that series, which I think was already done at 617480d7
(refs: make explicit that ref_iterator_peel returns boolean,
2021-05-19), and did not realize that you wanted a separate single
patch topic for this step, on top of which the remainder of the
other topic builds.

Will do.  Thanks.
