Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131D1C636C9
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 23:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5FCF613D2
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 23:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhGOXXp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 19:23:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63159 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhGOXXo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 19:23:44 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A573DDC68;
        Thu, 15 Jul 2021 19:20:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7yNfYqIVntjP
        UNhaqb9b1tsN/3aO6fVP9ESYKgnpygA=; b=wPPLWweRKd74DWHPQ5zYRL2Dk5Wc
        qhMTA3G/e1mjZ9wxGps+pLapCgYmW3NTf02Is1W6JqzMjXThLiFQfSsEIzlIMS4A
        02rIYxFDKCkFKFXLI/tHwn18xvuuflOSaeJkWzMmTmZEa4fUd+ufjAtpDGFUVEFt
        jo8S1Yuj3sSgrlk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 92DBBDDC67;
        Thu, 15 Jul 2021 19:20:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 24A7ADDC66;
        Thu, 15 Jul 2021 19:20:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 0/4] Rename/copy limits -- docs, warnings, and new
 defaults
References: <pull.1044.v2.git.git.1626225153.gitgitgadget@gmail.com>
        <pull.1044.v3.git.git.1626309924.gitgitgadget@gmail.com>
Date:   Thu, 15 Jul 2021 16:20:49 -0700
In-Reply-To: <pull.1044.v3.git.git.1626309924.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Thu, 15 Jul 2021 00:45:20
        +0000")
Message-ID: <xmqq8s27rwoe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4AD3337C-E5C3-11EB-B694-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Fix a few small issues with documentation and warnings around the limit=
s for
> the quadratic portion of rename (&copy) detection, and bump the default
> limits.
>
> Discussion on bumping the limits can be found at [1]. Although it appea=
rs we
> generally agree we could switch to an unlimited setting for
> merge.renameLimit, that would require some changes to progress bars to
> notify users how to take action once things start taking a while. So, f=
or
> now, just bump the limits.
>
> [1]
> https://lore.kernel.org/git/CABPp-BFzp3TCWiF1QAVSfywDLYrz=3DGOQszVM-sw5=
p0rSB8RWvw@mail.gmail.com/T/#u
>
> Changes since v2:
>
>  * Change the meaning of "0" to actually mean unlimited, and modify the
>    documentation to mention that.
>  * Added 'currently' to descriptions to make it clear the defaults are
>    likely to change (again).
>  * Added a brief explanation of the exhaustive portion of rename detect=
ion,
>    as requested by =C3=86var (though, honestly, I think the thing that =
actually
>    helps people pick values for the limit is the warning that tells peo=
ple
>    that rename detection was skipped and how high they need to set the =
limit
>    if they want to redo the operation and get renames).

Looks sensible.  The final phrase chosen ("exhaustive" part) does
sound easy-to-understand, too.

