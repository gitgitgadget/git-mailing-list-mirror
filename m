Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9E7C3DA78
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 21:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjAQVhP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 16:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjAQVez (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 16:34:55 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533C74ED05
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 11:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1673985505; bh=x4KAvcQD0KyYjfmtRCoidOrIAzHOBwMbQYeU8MhLUHw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=fNwo+EBskj8YUjRG4CA0j/SY/9xhCKMRk4D9uZYMugy0gSwgjcaJMrSwtV3bfMAE+
         aQ5YTjrOHwNO22lkaaz5qtmGAtqKE6U5GrVpNqD/1dI0rVEG1I6ScLfviK6J3wqo6t
         aT/zZTPPjGO18eqWaJe0OkuEaLnoZlJorREpDJt2u+prXNsx7MqNpFOS0RsnTK759/
         7o+c39DeavPonLqRuGRPWbyAWQ0QF2fMWiKoeGqjQ26lADJzUkmzwBvigJlfA3S8V3
         pXelTEKh+dTlIi96mPcS78iM+Cg9kty52kEMnOOcWIDDOUhjWtj3MMX/zD4zr4JZ/2
         xYbueTrV6snng==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.69]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Ma0Pm-1pCFNM45hM-00WHbB; Tue, 17
 Jan 2023 20:58:25 +0100
Message-ID: <7e571cdd-c0fa-7519-848c-b0bc4613abab@web.de>
Date:   Tue, 17 Jan 2023 20:58:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v4 15/19] object-file.c: release the "tag" in check_tag()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
 <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
 <patch-v4-15.19-66c24afb893-20230117T151202Z-avarab@gmail.com>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <patch-v4-15.19-66c24afb893-20230117T151202Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1L+e7fe8kUPUea1kxkQAaPqz82P8qhGPaqHqaPUd4hhZADGVgMY
 v5bSCRkmp58ry1lxKYVcWjdkeYsQAVUu0HRhsYvMmk8fJpoLw57B3NXgb/+5yZqiLvarah0
 Vs5R8vNjN1J6vG1oXv9slcZOykOhnSLlcXa5um6EcHsAIsAytjuclITg0pPwDhdM0Ze5xOG
 Ci9x2d8iAzkMmeM+t0htA==
UI-OutboundReport: notjunk:1;M01:P0:1f/oECqMZak=;pGMmuvpWXKLj3e2/2GelnCPNUAU
 7Am/40Z4OCvJ0uhjq54why4JtzGbpKMpi0R6LdpxBmBj+MlmGf+EDjle/AJ6ESNrYZCFw4tMj
 M3eh/rei+DDd1/IclZt8gYuuN0iJ18YKUhZI0PAP6Ckye3euSkzWpkTD7jxBSZi46MzthaTNG
 Kr3smOaXxwid50OacwjxM/oZEprE7pcKJMCgknzV/jFukmWW6e0V9B+9gygAQIAbUDiTmnPty
 YPv/gBo8i7/z5zJttrhCR2eRy5wuCqsAHg2Sx2p5eg3aGdR1BBcna88y3Nr42oddhTVOBMm2O
 Mnz5Jleh8DNQFHLTmXgbGyRVONBhUeGMe6hllLEOsjFowfycTw8C8Tgf/huo8FZ0Bp4/V5pkq
 4wN4bmdiNQxccwBAafMh7U4NM27clYwr7NVHRZNtOFSBFTz8CAo73Alx8DY0fdhEIoOkd7Ldu
 Daj/ZuZRmcpbWWwn1UIMEjz7K4CYxKyg9OYDCdPotMeMjSP3kZN/sNFgzXn/USe6RNzYhq/cI
 j1DkvEBy6UTaY6y7PIIuhJx1e5J2W637sfi5IuZ6Mv5McPkduyjFU0VZZU6+r2y43TgB46SXK
 DI1usj+gtPfvOtvwuD8N+ggxGp/MC7Y58PBcdfY53yfBMk5qjtfC6Dk06QSVQigHgWIi9SKcX
 w541Ukd9oIwH+PfOpXsqYPslH/UYNqIgcGtCHnpfExglVIOYEJAL/7J8yt7Rmzo5aB6AHGX2S
 ALlAbE2nWurUDlD23JJ/3XQQ/56Ys8euus+yEIOuyiQGpjYhwVVPjCJWuiFcGfNGKmzQ9LC3O
 lK1J12gayFYjAb3yq9OqiC2ARMZxn1gYh3VtDtscNayokJxIoKJo4k4wOZmggfuNrboY4wb5D
 zoLgnM8VtD9eOixH7+AZL7OUSVv3dWyF5DAmhu5v2arLAgD5D5SUlMl/0f0HqHcfZBd28w+ex
 H3Pd7yCZW9PbFCTISmvlF7pSvpA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.01.23 um 18:11 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Fix a memory leak that's been with us ever since c879daa2372 (Make
> hash-object more robust against malformed objects, 2011-02-05). With
> "HASH_FORMAT_CHECK" (used by "hash-object" and "replace") we'll parse
> tags into a throwaway variable on the stack, but weren't freeing the
> "item->tag" we might malloc() when doing so.
>
> The clearing that release_tag_memory() does for us is redundant here,
> but let's use it as-is anyway. It only has one other existing caller,
> which does need the tag to be cleared.

Calling it is better than getting our hands dirty with tag internals
here.

There's similar leak in check_commit() in the same file, but plugging it
would require exporting unparse_commit().  Or perhaps using the heavy
hammer that is release_commit_memory()?  Anyway, it doesn't seem simple
to me, so that would be a patch for a separate series.

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
> index 80a0cd3b351..b554266aff4 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -2324,6 +2324,7 @@ static void check_tag(const void *buf, size_t size=
)
>  	memset(&t, 0, sizeof(t));
>  	if (parse_tag_buffer(the_repository, &t, buf, size))
>  		die(_("corrupt tag"));
> +	release_tag_memory(&t);
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
