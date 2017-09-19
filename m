Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A790B2047F
	for <e@80x24.org>; Tue, 19 Sep 2017 01:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750872AbdISBEF (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 21:04:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58189 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750747AbdISBEE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 21:04:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A4E995F38;
        Mon, 18 Sep 2017 21:04:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lwXo0VF7a0rbKd55Kw/k01Hy4RU=; b=S4t9zx
        pNmRd5TGSZ0TOxNLb+E683/2R3EV+JhGg21QvsnrDTw1aL8WkNMK+K4AtTyhLAHv
        hnHT1SEsodF20T2L2okQOwV60JqLfYd+7t4UM9CMslsCpfYZ78ZIkgXkxEjYVr4W
        F6M6JzE68M34PtdxXcUwZjQUB5dGAzxz28lNk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mPHkDV3q1xG50etKxJa4ARXZUWIJ+Ju3
        SkX7+hsDGsuGMN2XlUYtC/W7nxNkzT8EiykRGHV5KvefKqKAo/qAF+OcotYrFZMU
        VpF2W4Cj9caTVVciWgR8Cdu0MqPMJ84UxhoG/m9b9OT18EdyMRlYrEfFYZdrJjYo
        Cr63Rk7A9Hk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 91E3E95F37;
        Mon, 18 Sep 2017 21:04:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F21DB95F35;
        Mon, 18 Sep 2017 21:04:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Santiago Torres <santiago@nyu.edu>
Cc:     Shikher Verma <root@shikherverma.com>,
        Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC PATCH 0/2] Add named reference to latest push cert
References: <20170906093913.21485-1-root@shikherverma.com>
        <CAGZ79kbxDh11KxrKCk_VjmN06kzp7x4iVO6XTV=a-qBmm39K5A@mail.gmail.com>
        <20170907091133.zygswf3f6z2bedfo@weakknees.security.iitk.ac.in>
        <CAGZ79kZO_u21JeAsNq7p7X88i0wmP6kJcg=JbKp62Bxdm4d4Uw@mail.gmail.com>
        <20170916072106.yxpwmndzif3lr2dp@weakknees.security.iitk.ac.in>
        <xmqqa81uumq6.fsf@gitster.mtv.corp.google.com>
        <20170918142205.r5kwkq7ouy5zxisz@LykOS.localdomain>
Date:   Tue, 19 Sep 2017 10:04:01 +0900
In-Reply-To: <20170918142205.r5kwkq7ouy5zxisz@LykOS.localdomain> (Santiago
        Torres's message of "Mon, 18 Sep 2017 10:22:06 -0400")
Message-ID: <xmqqk20vsdmm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D60A04E-9CD6-11E7-8C74-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Santiago Torres <santiago@nyu.edu> writes:

>     - *if there is a hook* the blob is computed, but it is up to the
>       hook itself to store it *somewhere*. This makes me feel like it's
>       somewhat of a useless waste of computation if the hook is not
>       meant to handle it anyway(which is just a post-receive hook). I
>       find it rather weird that --signed is a builtin flag, and is
>       handled on the server side only partially (just my two cents).

The way it was envisioned to be used is that the repository meant to
be protected by collected push certs may not be trusted as the
permanent store for push certs by all hosting sites.  The hook may
be told the name of a blob to read its contents and is expected to
store it away to somewhere else.

The only reason why we use blob is because creating a blob in
respose to pushes being executed in parallel will result in
different blobs unless there is hash collision.  Instead of us
having to come up with and use a different mechanism to create a
unique temporary filename and feed that to hook, reusing blob as
such was the simplest.

> I understand the concurrency concerns, so I agree with stefan's
> solution, although I don't know how big of a deal it would be, if git
> already supports --atomic pushes (admittedly, I haven't checked if there
> are any guards in place for someone who pushes millions of refs
> atomically). It'd be completely understandable to have a setting to
> disable hadnling of --signed pushes and, ideally, a way to warn the user
> of this feature being disabled if --signed is sent.

I do not think atomic helps at all, when one atomic push updates
branch A while another atomic push updates branch B.  They can still
go in parallel, and their certificates must both be stored.  You can
somehow serialize them and create a single strand of pearls to
advance a single ref, or you can let both to fork two histories to
store the push certs from these two pushes and have somebody create
a merge commit to join the history.  

But the point is that we do not want such an overhead in core, as
all of that is a useless waste of the cycle for a site that wants to
store the push certificate away outside of the repository itself.
