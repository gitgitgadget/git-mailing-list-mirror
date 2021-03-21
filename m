Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PI_IMPORTANCE_HIGH,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7FFC433C1
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 06:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDC4D61930
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 06:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhCUGSv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 02:18:51 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53570 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhCUGS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 02:18:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 23389117339;
        Sun, 21 Mar 2021 02:18:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FV7rFxRpazZjaOwmX5vqZiQflWc=; b=MBsy8g
        GdJUQmlewf0GFJXVUsy9hHgYLUMMuQ8O3QCFAnJJC1be2cdgmkmv/nzC/pccPSIn
        CydfQNathjiFJuN4LVSA4tRXCsBCfCrtL76Dfx0cpWaJFpaWWFaWnw8Tr+bpu1Tt
        Cd2OUJpJN1TW8B55oBSdca9T8mdBHwOOgP87M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lRNAiwtGPP8w3LL5Wt8K3+BU5VROKdCs
        5/SUEINiMDTvS47pFDNINQLhjaZBWo7DAmB/Kb7/rNNYL2cX7kiRSlEVjHJWVzmF
        DosUozn4wW50ihIyu1H3UaaEPg3Vvm0bZ86vJRe0cY022whGqqZSP2OWR75q21Js
        FxQrEUlIUZM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0F54E117337;
        Sun, 21 Mar 2021 02:18:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EA7E8117336;
        Sun, 21 Mar 2021 02:18:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Georgios Kontaxis via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Georgios Kontaxis <geko1702+commits@99rst.org>
Subject: Re: [PATCH] gitweb: redacted e-mail addresses feature.
References: <pull.910.git.1616283780358.gitgitgadget@gmail.com>
        <xmqqft0pcagu.fsf@gitster.g>
Importance: high
Date:   Sat, 20 Mar 2021 23:18:21 -0700
In-Reply-To: <xmqqft0pcagu.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
        20 Mar 2021 23:00:33 -0700")
Message-ID: <xmqqblbdc9n6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3D217CE6-8A0D-11EB-855C-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> And more importantly, I do not see why it should be made impossible
> to override per repository/project in a multi-tenant installation.
> Some projects may be more "privacy" sensitive than others.  Those
> who want to use tighter setting should be able to enable it even
> when the side-wide default is set to false, no?

To answer an inevitable and natural follow-up question preemptively,
the primary reason why we have the override => 0 mechanism is so
that site administrators can disable certain expensive features
(like blame, snapshot, etc.) no matter what each project hosted by
them wish.

And hiding contributor identity would not be a choice that is based
on how expensive the feature is to run.
