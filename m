Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BD6C433F5
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 18:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351928AbiDTSmT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 14:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238461AbiDTSmS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 14:42:18 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE20123142
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 11:39:31 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 46ED9184CA1;
        Wed, 20 Apr 2022 14:39:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=btVEuhtV1UhRxz/++ypNl5M8wHCXWS7LgP/uVO
        NAdG0=; b=NGjgETiZjeObxzqWvWm6yu2mU3uVzRmAxaXzst4fzrBzf7FB+Z1CaJ
        1VVKId5YiqaVF6diWdtAoJ5X1IjJP3lFI6gSmXcZRM2FQ6Mt8fGXmiYS1FbW1s+n
        V/BzV4zkhw0oAp+NKPLye4Fj67i0Zu9JNuZg6SoKJurPey243jqcc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3ED0B184C9F;
        Wed, 20 Apr 2022 14:39:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C2E41184C9E;
        Wed, 20 Apr 2022 14:39:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 1/8] rebase --apply: remove duplicated code
References: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
        <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
        <a4320f2fcf35f180e1c585be4105194f1555a874.1650448612.git.gitgitgadget@gmail.com>
        <xmqq35i7r4rj.fsf@gitster.g>
Date:   Wed, 20 Apr 2022 11:39:26 -0700
In-Reply-To: <xmqq35i7r4rj.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        20 Apr 2022 11:25:36 -0700")
Message-ID: <xmqqwnfjppk1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 35691B36-C0D9-11EC-B64D-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> -	strbuf_reset(&msg);
>
> This is unnecessary, because we have released immediately before.

Sorry. I meant "reset is unnecessary and it is the right thing to
remove it here", but I just realized it can be misread to say "this
change is unnecessary".
