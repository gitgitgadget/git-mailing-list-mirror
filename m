Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD83CC25B08
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 16:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243939AbiHHQPP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 12:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243763AbiHHQPO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 12:15:14 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7521B8
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 09:15:12 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1CA4E1B5CF6;
        Mon,  8 Aug 2022 12:15:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eGb+nNaLSj8x6kGZ8eDFYJK2VPoIJ8zhKZu4Yw
        XRxYk=; b=CbntVPwmIQIA8IdnPFHv3r2G6yri3GCcm2mn4lw+lGV3560OCRS3z+
        80r28ZnQZS13tBHOv2yKy2pRu9m2HiYjDP5vBjrPHkcx3j45wV3Rh9tBBEdROeQo
        3zi0rD58+g7Qavm98o5PoTwWD6WbGtqPbB4w6wKEbOwJ6smF57k/0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 156CE1B5CF5;
        Mon,  8 Aug 2022 12:15:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9B4C11B5CF4;
        Mon,  8 Aug 2022 12:15:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH] [RFC] list-objects-filter: introduce new filter
 sparse:buffer=<spec>
References: <pull.1316.git.1659958159193.gitgitgadget@gmail.com>
Date:   Mon, 08 Aug 2022 09:15:06 -0700
In-Reply-To: <pull.1316.git.1659958159193.gitgitgadget@gmail.com> (ZheNing Hu
        via GitGitGadget's message of "Mon, 08 Aug 2022 11:29:19 +0000")
Message-ID: <xmqqczdau2yd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 44FD9E02-1735-11ED-82A8-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> Although we already had a `--filter=sparse:oid=<oid>` which
> can used to clone a repository with limited objects which meet
> filter rules in the file corresponding to the <oid> on the git
> server. But it can only read filter rules which have been record
> in the git server before.

Was the reason why we have "we limit to an object we already have"
restriction because we didn't want to blindly use a piece of
uncontrolled arbigrary end-user data here?  Just wondering.

