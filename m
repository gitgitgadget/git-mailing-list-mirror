Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15109C001B0
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 15:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjHGPyB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 11:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjHGPyA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 11:54:00 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BD1F0
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 08:53:59 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 64A0D22658;
        Mon,  7 Aug 2023 11:53:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4gtGhotah3pk
        pp/BnW3BIDqoPUNmPIsci5r87n3nFEs=; b=Y6zN4pFFQVJiYnKhfbwlciDHlUyy
        ObvcuNknbIIHJCOvwLLpuDhnO2wU2jboyzn2qeXJ5xH0X804gIWEyNUIdWsKIz2H
        mYGNcTMjjUtajMt6Bm89ATV/WCz7E1fZgu31hI6QwXE3Arptr59M94mpViXVNmFl
        fgWYQxLzB1sFxUQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5E19A22657;
        Mon,  7 Aug 2023 11:53:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E5A6422655;
        Mon,  7 Aug 2023 11:53:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Arver <linusa@google.com>
Cc:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/5] trailer: add tests to check defaulting behavior
 with --no-* flags
References: <pull.1564.git.1691210737.gitgitgadget@gmail.com>
        <6b427b4b1e82b1f01640f1f49fe8d1c2fd02111e.1691210737.git.gitgitgadget@gmail.com>
        <xmqqjzu7irhw.fsf@gitster.g> <owlyfs4vbeus.fsf@fine.c.googlers.com>
        <owly7cq7bbr9.fsf@fine.c.googlers.com>
Date:   Mon, 07 Aug 2023 08:53:54 -0700
In-Reply-To: <owly7cq7bbr9.fsf@fine.c.googlers.com> (Linus Arver's message of
        "Sun, 06 Aug 2023 23:35:38 -0700")
Message-ID: <xmqqbkfij1bh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9D5D1AEA-353A-11EE-9CD6-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Arver <linusa@google.com> writes:

>>> If I am reading the code correctly, --where=3Dvalue overrides the
>>> trailer.where variable and nothing else, and --no-where stops the
>>> overriding of the trailer.where variable.  Ditto for the other two
>>> with their relevant configuration variables.
>>
>> That is also my understanding. Will update to remove the "all" wording=
.
>
> Hmph, actually it also overrides any applicable "trailer.<token>.where"
> configurations (these <token>-specific configurations override the
> "trailer.where" configuration where applicable). Still, the "all
> configuration variables" wording should be updated, probably like this:
>
>     =E2=80=BA  Specify where all new trailers will be added.  A setting
>     =E2=80=BA  provided with '--where' overrides the `trailer.where` an=
d any
>     =E2=80=BA  applicable `trailer.<token>.where` configuration variabl=
es
>     =E2=80=BA  and applies to all '--trailer' options until the next oc=
currence of
>     =E2=80=BA  '--where' or '--no-where'.

Yup, that was what I meant.  I found it troubling that the "all"
phrasing felt like it meant all trailer.* configurations, not just
the "where" thing.  Your new description looks good.

Thanks.

