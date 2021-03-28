Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5472C433C1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 01:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 824FA61991
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 01:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhC1BbD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 21:31:03 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56401 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhC1Baq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 21:30:46 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E41AE1222EF;
        Sat, 27 Mar 2021 21:30:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/wuPP14KztZg828md5PGJsGGlAk=; b=FcIkZS
        KbSCkkax2OuhwtmH3VZf+9Lgjk+0Jti1fGTeGpJhZiFkORDHD19CPFa/Xu/YH4bj
        hB3ZGe7Ub2mZmPtd7wX45Iom1YVXBnAAoPNNNFAjLgRpRVrQhA8ZaruaCqc3499N
        KHWBRUQwyTyg8j3/zAXlJBWIi/S2A6TYtNwBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DLtwZbrht1d2C3LT/6gmfg3/JuhrvHyy
        B/l32UvnJ96KhJ99OIT0hY6lmWVITSd4l6ZnFDPxN/WC1TOC92N5oBb6ZaKU+Uga
        se2npOygqZcJTwr6L0k7LClY1weSpuWnxvzZQlLXULr+YRj5dg3uFKlIJRFLqqUs
        PCs43hr5ZqU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D16621222EE;
        Sat, 27 Mar 2021 21:30:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 18C6D1222ED;
        Sat, 27 Mar 2021 21:30:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] sequencer: fix edit handling for cherry-pick and revert
 messages
References: <pull.988.git.git.1616742969145.gitgitgadget@gmail.com>
        <eda509dd-d2d5-0856-0c75-094d67257d54@iee.email>
        <CABPp-BHgQGYLobmYvyj4u=KLePosoCq2Y_JY6aUJOQcP_PB1iw@mail.gmail.com>
Date:   Sat, 27 Mar 2021 18:30:41 -0700
In-Reply-To: <CABPp-BHgQGYLobmYvyj4u=KLePosoCq2Y_JY6aUJOQcP_PB1iw@mail.gmail.com>
        (Elijah Newren's message of "Fri, 26 Mar 2021 08:12:37 -0700")
Message-ID: <xmqqsg4goyim.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3658689A-8F65-11EB-85F7-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> This 'Note the we' doesn't parse for me.
>
> Oops; should have been "Note that we".  Thanks for pointing it out;
> I'll fix it up with any other feedback that comes in.

In the meantime I'll locally tweak while queuing.
