Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BC4CA0EC2
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 21:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349491AbjIKVdn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244042AbjIKSy7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 14:54:59 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55AF1B6
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 11:54:54 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A00DC37485;
        Mon, 11 Sep 2023 14:54:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=3+F+RZbd5mSEmbm4/ldTkuVqbx1FbvqcFcwYzw
        F/KFU=; b=RWFPmuU2cS2WjrxRgBmednejtrpMpv08DwB0JcgBm8qsWx1D30CNy0
        a/WoNJtDH0RoApDmS5KIeOIHLLeu2NWliOuBf/tBOfRC4+nsyzdrX6yhuofqTVt4
        OZ13bDHhNXGvM0pU00LMHlewFfpadzc2krev9KHYYVL6xLr9YfXXw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 97B7D37484;
        Mon, 11 Sep 2023 14:54:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0255E37483;
        Mon, 11 Sep 2023 14:54:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Linus Arver <linusa@google.com>
Subject: Re: [PATCH v2 5/6] trailer: rename *_DEFAULT enums to *_UNSPECIFIED
In-Reply-To: <52958c3557c34992df59e9c10f098f457526702c.1694240177.git.gitgitgadget@gmail.com>
        (Linus Arver via GitGitGadget's message of "Sat, 09 Sep 2023 06:16:16
        +0000")
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
        <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
        <52958c3557c34992df59e9c10f098f457526702c.1694240177.git.gitgitgadget@gmail.com>
Date:   Mon, 11 Sep 2023 11:54:42 -0700
Message-ID: <xmqqr0n4v8ul.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ABC68B38-50D4-11EE-B4FD-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> Do not use *_DEFAULT as a suffix to the enums, because the word
> "default" is overloaded. The following are two examples of the ambiguity
> of the word "default":

In this case these are left unspecified to use the default; while it
is not wrong per-se to say *_DEFAULT, using *_UNSPECIFIED makes it
more obvious.

> So instead of using "*_DEFAULT", use "*_UNSPECIFIED" because this
> signals to the reader that the *_UNSPECIFIED value by itself carries no
> meaning (it's a zero value and by itself does not "default" to anything,
> necessitating the need to have some other way of getting to a useful
> value).

It gets tempting to initialize a variable to the default and arrange
the rest of the system so that the variable set to the default
triggers the default activity.  Such an obvious solution however
cannot be used when (1) being left unspecified to use the default
value and (2) explicitly set by the user to a value that happens to
be the same as the default have to behave differently.  I am not
sure if that applies to the trailers system, though.

Thanks.


PS.  Glen's old e-mail address is no longer valid and there is no
forwarding done by @google.com mailservers, it seems.  Can you tell
GGG to drop the address (optionally replace it with his new address)?
