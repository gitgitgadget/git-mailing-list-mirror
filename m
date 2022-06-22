Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA52C433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 05:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357055AbiFVFwW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 01:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbiFVFwT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 01:52:19 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CDC36681
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 22:52:18 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D491813C181;
        Wed, 22 Jun 2022 01:52:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=RMNbxku4iwIE
        nBalsSomwj4wSSA/mzVZp2Vz0bz1Wu0=; b=vF9bHLaAPy/c2RM9FdrMdkRJG/KU
        V2VVOvcRbABNrqaKHXdX42Dz5+v0zdDitTvk/XPUfXWOXbaGOfU9n65RYWteRITK
        qWQuWowpj8jQQkwMx47YSlw7Cs53mCBzH/Lg+GJdf//zVAFCcf2oRQ5HZRBMtijw
        KU2vEMDidF2pmQI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CA6A713C180;
        Wed, 22 Jun 2022 01:52:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F21EC13C17F;
        Wed, 22 Jun 2022 01:52:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        rsbecker@nexbridge.com,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/10] fetch tests: remove redundant test_unconfig()
References: <xmqqa6a5g0m3.fsf@gitster.g>
        <cover-00.10-00000000000-20220621T222854Z-avarab@gmail.com>
        <patch-01.10-6236f4475fc-20220621T222854Z-avarab@gmail.com>
Date:   Tue, 21 Jun 2022 22:52:15 -0700
In-Reply-To: <patch-01.10-6236f4475fc-20220621T222854Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 22 Jun
 2022 00:34:13
        +0200")
Message-ID: <xmqq4k0d8cts.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 78F009B8-F1EF-11EC-8F4D-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The test_unconfig() calls here were added as boilerplate in
> 737c5a9cde7 (fetch: make --prune configurable, 2013-07-13), and then
> faithfully reproduced in e249ce0ccdb (fetch tests: add scaffolding for
> the new fetch.pruneTags, 2018-02-09). But they were never necessary,

unnecessary because ...?

is it because nothing has happened in this directory before?

is it because these will all be overriden by the command line
options?

is it because of something else?

> so let's remove them.


> This actually improves our test coverage, as we'll now be asserting
> that whatever configuration we leave here (in the "one" block below)
> won't affect this particular "git fetch" command.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/t5510-fetch.sh | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index 4620f0ca7fa..d784a761ba0 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -874,10 +874,6 @@ test_configured_prune_type () {
>  		git tag -f newtag &&
>  		(
>  			cd one &&
> -			test_unconfig fetch.prune &&
> -			test_unconfig fetch.pruneTags &&
> -			test_unconfig remote.origin.prune &&
> -			test_unconfig remote.origin.pruneTags &&
>  			git fetch '"$cmdline_setup"' &&
>  			git rev-parse --verify refs/remotes/origin/newbranch &&
>  			git rev-parse --verify refs/tags/newtag
