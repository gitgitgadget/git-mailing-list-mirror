Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6356FC433B4
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 05:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DD346139E
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 05:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242758AbhDFFhY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 01:37:24 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54206 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbhDFFhX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 01:37:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 363E7117B85;
        Tue,  6 Apr 2021 01:37:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K5A+1vQc3Iaz59KP9QmU7HpxsJE=; b=P6qE8i
        ZseQVSzSTmE4prmLkj9HsP5KEhydGQO9RUkWW0bn/3s9LQJJo5E6I75tnFLuCtLs
        n8Nn1rnYWmmx/W0l1ZVVfs7Gb2KrHkOZshC/FYskuATc9tRU1/y7gMLXOEwKOZWV
        x/VVVhNsDitk17Rj2igB9UH6bp4cR/0iSkSPI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CJXwfsRtY/dyEIk5LBhzBfl23oUBUOpc
        VeR2sAcdVYgGRD3OOsXzqEMB79qSLTgjU3veA2gVN6dpH3yZpP4g/VjUfuNKAiQd
        nK3+h1QFmtpqPTVO9v0us7SDJ2YlFYpAK5P1Lx9U4r+yvomUPkPPyqoMdyx05XFe
        K2ufXbVjyD4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2E616117B84;
        Tue,  6 Apr 2021 01:37:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 74A04117B83;
        Tue,  6 Apr 2021 01:37:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v6] [GSOC] trailer: add new trailer.<token>.cmd config
 option
References: <pull.913.v5.git.1617185147.gitgitgadget@gmail.com>
        <pull.913.v6.git.1617369973328.gitgitgadget@gmail.com>
        <xmqqim544dl4.fsf@gitster.g>
        <CAP8UFD0AZWey045qK=9h8nVCVwK09s=t-=Z7OVBpvr4LAvSLUw@mail.gmail.com>
        <xmqq8s5x7ht1.fsf@gitster.g>
        <CAP8UFD17=BxHRkb7nmC8XsiGet+J=Adzqv4P6d9jzgnKXT9LJw@mail.gmail.com>
        <CAP8UFD08Lagij6oqpOJkpbzMLRgQ08=mDfiyf1qXyD5VW6Ae7A@mail.gmail.com>
        <CAOLTT8TrJn+V-4WijCfi=q5JpvfBj_oMfWRx9TX-0Cs5uShmOg@mail.gmail.com>
Date:   Mon, 05 Apr 2021 22:37:11 -0700
In-Reply-To: <CAOLTT8TrJn+V-4WijCfi=q5JpvfBj_oMfWRx9TX-0Cs5uShmOg@mail.gmail.com>
        (ZheNing Hu's message of "Tue, 6 Apr 2021 13:16:14 +0800")
Message-ID: <xmqqpmz82cu0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 23D0EA12-969A-11EB-A326-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

>> By the way it might be better to first have a patch that clarifies the
>> existing documentation of ".command", before the patch that adds
>> ".cmd". This way the first patch that only clarifies the documentation
>> could be backported to maintenance branches of old releases.
>
> This first patch should explain errors of ".command", and then explain that
> we will no longer use it, right?

If I am reading what Christian wrote correctly, I think it is not
"errors of .command" but to clarify the misleading description
(especially around the "as if <token>=<value> were added at the
beginning").  As if nothing is planned for its deprecation.


