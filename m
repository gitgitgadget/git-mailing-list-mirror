Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D083FC433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 17:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FF3820823
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 17:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ix+FuVuP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405156AbgFXRFu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:05:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63147 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404208AbgFXRFu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 13:05:50 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3D743CA3E4;
        Wed, 24 Jun 2020 13:05:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a7jC3NiK8iKNMhGG8/qAp9D2Rb8=; b=Ix+FuV
        uPV55+cbPJh45A+KMS2oLdOvY06+yCsyJuY2HCCeIJ3dFb0StznQRdDL196tLxlO
        X+qI/ZyBKkuN9fpBC20P/p4a8mxtcNwoEVjHPwycLGGjmphFH4m3+B1CeOU+DD9B
        6KreJXEG2W5AOfHWU/6DE5+WgOAAWpiYTyCVY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fok4gR3VidiiYgbN1LYJZQDQFlAvAT4y
        u+DTHkLIV6JPtKT3yQRVHfIK1K7FbyJMZgflIyMAmZ+nUvbfnpORX2U3A94GTNvA
        b8IRaMLoK68DYGmiIIapOkoDhJN8GgqDbviMxIxwX5gwpHHyvCoZUGtES1sEROcU
        1HafirjAJLg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3581BCA3E3;
        Wed, 24 Jun 2020 13:05:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7FA83CA3E2;
        Wed, 24 Jun 2020 13:05:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/3] Accommodate for pu having been renamed to seen
References: <pull.668.git.1592924655.gitgitgadget@gmail.com>
        <pull.668.v2.git.1593010120.gitgitgadget@gmail.com>
        <xmqqtuz08ofa.fsf@gitster.c.googlers.com>
Date:   Wed, 24 Jun 2020 10:05:43 -0700
In-Reply-To: <xmqqtuz08ofa.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 24 Jun 2020 08:38:01 -0700")
Message-ID: <xmqqd05o75so.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F1919E0E-B63C-11EA-A836-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
>> Changes since v1:
>>
>>  * Rebased onto master (no conflicts, so it is safe, and it is more robust
>>    than basing the patches on seen which already contains v1 of these
>>    patches).
>
> Thanks, I actually wanted to include it in 'maint', so I'll queue on
> the same base (no conflicts, so it is safe, and it will be in a
> maintenance release if we are going to issue one).

By the way, I find myself typing 'pu' all the time, even though I've
been using 'seen' for almost 48 hours by now.  My private tooling
all have been updated to work with 'seen', but it seems that it
takes time to retrain muscle memory.  I'll see if I can fully adjust
before the next week starts.

I do not know how many of you regularly have interacted with 'pu'
and now need to go through the same adjustment as I do.  Sorry for
using you as a guinea pig for an experiment for you know what to
gauge the cost.

