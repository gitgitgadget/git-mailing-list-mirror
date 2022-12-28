Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C959C4332F
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 22:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbiL1W0I (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 17:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiL1W0G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 17:26:06 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B43613EA8
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 14:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1672266358; bh=nw8kHkkI9UYTQJ9FG7Cis0PMiaMiBVcebKfDEz7BqQY=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=D9rzbaLwU7q7A+W9b0YP6JDZzs65DrE2aDPD4diHOPkoEdPoAUBvXxVKjEMXY8PmF
         RO0D73C0YkB3uxy5lp/NHzDQRdVynqgsJLru3VvLBPgmfdbx297AKlshT9Ju+Jaf7t
         iHNfS/4Ph/SVJ6NwtpKELcI81XuXQEMIRt8QXWhkXx5LKNdBvvOZfmI+adWzUOmjwY
         yiW+wsGH12Q4VNxQzdPJPgesY0IMdbtqFg0TPLO6lZ3IkD8+aH256wV4gsbWhSsE0S
         mzqt3BZ3vTvfTNz41PRLr/Mzvs1pJ8bITNh7BYFegWCInayIKtThs+yCZN5ERpGp9H
         c19Hv1Y/PQd+g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MmQYd-1oSpnD37J3-00i4YN; Wed, 28
 Dec 2022 23:25:58 +0100
Message-ID: <b6cd3023-2d9f-b1bd-d8e8-16dca4899cfb@web.de>
Date:   Wed, 28 Dec 2022 23:25:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 18/20] object-file.c: free the "t.tag" in check_tag()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
 <patch-18.20-aa4df0e1b5c-20221228T175512Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <patch-18.20-aa4df0e1b5c-20221228T175512Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Kl14U0HZ3Xcvms6Mza9q0DzcqLsqLgvZfaBZD2kZDsaeGzd38Oq
 9QUI2CWhA6/uP3FO0seIZnWBgpXTpz0uo3Q750H61b6mOnWZSJEo0B6fjb+yTU+cwfxC1J3
 NLc7zT29ZwD4poAsccZTTxo1pCLawlZQ5uaUTgJlPI1zsdaIEqw5IZCEuSDfKiTgJeDg0nu
 seS4SqiKozI6COmuZ+NHA==
UI-OutboundReport: notjunk:1;M01:P0:JoDpzOUtKqo=;hOseh62LGuC85nhywDXktyE2LLv
 66JclXvJPsMDqr9dy+iOH+EHfL8a1Ae28TTEK2Za8uahSiG7E19/8DuHPpQcWZTV42aKL4bmk
 jAoSXURMJHkgEMk2Ofvv5aNMibxDbpr8GxBXqSrx5l0HLt2YptJGOpJI60IIUoVjCHSLxTA3q
 Ra5UiGF5St13pYwFbKyasl1rRLD2RSE2ATPUMmdzDazJAnIxURYKScnpLcM6u2i6McFFK+EoN
 JgNQWI09fPq1gNt2qmkasRDLBqp1R8AOCCWgnspwox0XqgDap0WtZnIGGtLp2ce9jzs7cdtU7
 uyePibnKN2teEMnIb55CWI+Gh+/Mxqe3EAYTRuPcPh73rOJrnQBxeFMCJoPbXy0As2NwAAzcL
 X9KaPAZdP4pO9ExKl0CmQ8d501khwStsgWe04sgauk/3yjOoPMqSPPyDHl2JwB7rn6E4B/ojk
 D/bPwfW8ge27hOazI5yUdR/zuvOzPiY5BatXI1PJl8JoULREQF5Bp6UJzCWO/BnwgGr7MrNhB
 VYVM4krOq+AV5qwi+jDyvulI/YlBVdJ7deDBvcuh3/HHKgyU8wF5aiMFref6UeI4IQ+O0FHpj
 UqyW3rxypJ4qhaS7Q2L5aPINbjhKONrxFrN99rvkzyNWNLmI7KRc8gpzO3O1uGyieeJKY3/Og
 +Rey/uKvms47Rl7x9FfQRnXifiQbhI970sjTJe++wFsn4RMTJgFdGA7YInDvyWXjN7rWAWPjv
 xWrJtKStf9v0WGf416ZirkVacXtBHccbldNY0tdXyoFqbcH5wbo8YNRvCrZVgbaMu0qhjaim+
 ikiweNjz/H35Bf0cwdRfNoOQcMnjz+wfPqd7iloUm6VYwtjTryj9kziRNccxLXbY7g5yDYT/7
 k9DG7/KiWfvtHmroPVGQEivGM5CZQdM1us/hRjqlS3rygEaKSPQu7R57QU5GYy6yrXtFacT/N
 yPEuc+TUCwZ2Zmjx2oyDmiNjRjY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.12.22 um 19:00 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Fix a memory leak that's been with us ever since c879daa2372 (Make
> hash-object more robust against malformed objects, 2011-02-05). With
> "HASH_FORMAT_CHECK" (used by "hash-object" and "replace") we'll parse
> tags into a throwaway variable on the stack, but weren't freeing the
> "item->tag" we might malloc() when doing so.
>
> Mark the tests that now pass in their entirety as passing under
> "SANITIZE=3Dleak", which means we'll test them as part of the
> "linux-leaks" CI job.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  object-file.c         | 1 +
>  t/t3800-mktag.sh      | 1 +
>  t/t5302-pack-index.sh | 2 ++
>  3 files changed, 4 insertions(+)
>
> diff --git a/object-file.c b/object-file.c
> index c1b71c28347..36ed6c3122c 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -2331,6 +2331,7 @@ static void check_tag(const void *buf, size_t size=
)
>  	memset(&t, 0, sizeof(t));
>  	if (parse_tag_buffer(the_repository, &t, buf, size))
>  		die(_("corrupt tag"));
> +	free(t.tag);

Better use release_tag_memory() instead to avoid leaking knowledge of tag
internals, no?

>  }
>
>  static int index_mem(struct index_state *istate,
> diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
> index e3cf0ffbe59..d3e428ff46e 100755
> --- a/t/t3800-mktag.sh
> +++ b/t/t3800-mktag.sh
> @@ -4,6 +4,7 @@
>
>  test_description=3D'git mktag: tag object verify test'
>
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
>  ###########################################################
> diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
> index b0095ab41d3..54b11f81c63 100755
> --- a/t/t5302-pack-index.sh
> +++ b/t/t5302-pack-index.sh
> @@ -4,6 +4,8 @@
>  #
>
>  test_description=3D'pack index with 64-bit offsets and object CRC'
> +
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
>  test_expect_success 'setup' '
