Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096A0C433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 23:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349605AbiFCXOq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 19:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349596AbiFCXOo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 19:14:44 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9111727CF8
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 16:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1654298052;
        bh=01bEjogA+hXfYe9N2z9GzzUVA5qLN1tDL6qgOaeu0rs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=mUFmTZtad1wyK2K/2NYHsaxBBjdt2sVRafD4EPJcQOnFFszIWmjRT9VAOD0poEHjk
         Jy7s5ar00rPpekq8j1u4rfQu2Yvv4zUJiYbpZOUsCPov1rlOJVUou+PrbOp8Ug73Vw
         dbZhCGIzKHy0sA/444QihyFTL+uhJVnk/B+GWmP8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MfKxV-1nH2zf0qmh-00gTvo; Sat, 04
 Jun 2022 01:14:12 +0200
Message-ID: <5b3e0d7c-e507-2edc-0cbc-5dd54883a8b3@web.de>
Date:   Sat, 4 Jun 2022 01:14:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 05/15] refs/packed-backend.c: add a BUG() if iter is
 NULL
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jinoh Kang <luke1337@theori.io>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
 <RFC-patch-05.15-46e0c307941-20220603T183608Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <RFC-patch-05.15-46e0c307941-20220603T183608Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g0d8Pa4Qyk001yhQNkj0gTm+X7aVPRW1ZW3NxLEkk9DBlSuklfk
 SyVxbtqVc83d8Z2Vy/xkEP7qki0Mh82Oe8hQGGo7qjsX6REFbioJflOg8sSndM4zWIDGjwG
 bg2yYANix8jmTjfkNUoGOj5jAtifktVH0QVJMjiE5S/yu/jEg8tJrJ09+ZQXCFG2K2Dk7jF
 v+qSxM51tp7hJLz4BKvOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C4LkhsHR/5Y=:SrnTtU+qiHNe9yeOh387oX
 QomL/Y+cXxUdN/nSq+oPiA+CclbEBbmOwDq1OTdiNJb5+ULSfn+yT2hugPE+AWaT3kxADw5MH
 sLNkfCSywUguf60ZuIfZrlYECt8r88L0LZh1aopcnwBTxDNAPZ7kabUE0U+9dTdgYHd3iNcq6
 5Z2hLfr+rzq05xMbsGW1RKeBbRjBE0DMUNfEyzfF6WyW8aNxFWf23OQlS4fKMKAfP4rQtKA2R
 clpGz6nMqRrtO2xVwYtApqFEX4jBDLtPFRbLqMRjJF+oI+l5+JC5OrxT1idW/9Q7uxyQwGnCE
 dePZldDyz0W4GDKT2OcgBr6gZ/t8f35XsLwhD4vq1bAjOscw1HQpAo1OXaub5Eyx5+yzNGYkE
 5D4r/OPsU9iJuTF9dOIA4gGuA01bgw/xMGUhk17s9fmHdN90EYyzGbTj74ztjziljkGqFYkvY
 NcznCKmes3RxI5PVrEdcH5YHOY7HvoTeXnP1h8mvJdIA2qqFwUTkgoN/rzn7sZYTZcV21Hj3I
 RaDlwXPm9BoWMrL2idH6SVzfMIEzkgArG3MXgBJjwIwsFUzp6naAqHtkY+pcyAqbfQCIuajWJ
 W+pdzkEHklU3qfu+N7VYVmvdRQt6YIdeZfoh2WIL/c/sGqGUa/OzUSsCJqlh2hTkNuelkl5Wh
 kThtN2/NMcFyAs/LHmAl2Cx7XjxAeUio6x8rBXpKLvnngFVKqrLvVPR2gQrU0Uvfuuoe7QmIf
 9kO3u5OzAlzszBih7wEJ1/BMBdlhlbyM+QlrcGyduwaG4gMH7R+LoewtnvnvhSo//tcWLbvVM
 iOToFM4pg+KqLie+JdOtvNt8fx/c33Cgr9sMbm8nHkhH85ytYZ6JNovPOIXWP8zEdX9fUTDke
 1yiSJ4nmdjMtMBoIDanvsWiLHiZBQXDRIDcFdJQRhVR9qWKYb5m1TQpy63Kt6wajtwvhjyDP8
 MpO++2gO9io8RPdKIHMiADQC84aht8/6Ge+N5utmluVbcU53QrHKBSALjB2vXTbYiUUxkIIPX
 Zw4I7c3HmXxpESW/tBf1UiNgjogVmxFU3siQPsM/HalQnQ1SECrgbCYLVx6OXoFgMpsYEqzDn
 nj32YhTaD8lYNIkxcIqRqe3YdUwRjZ80xvS
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.06.22 um 20:37 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Adjust code added in 2775d8724d7 (packed_ref_store: implement
> reference transactions, 2017-09-08) to BUG() out in a case there GCC
> v12's -fanalyzer flagged that the "iter->oid" seen in the context was
> reachable where iter was NULL.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  refs/packed-backend.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 97b68377673..65991bbcaf5 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -1226,6 +1226,8 @@ static int write_with_updates(struct packed_ref_st=
ore *refs,
>  			struct object_id peeled;
>  			int peel_error =3D ref_iterator_peel(iter, &peeled);

Some peel backends dereference iter, e.g. packed_ref_iterator_peel() from
the same file.

>
> +			if (!iter)
> +				BUG("must have iter if cmp < 0");

So if iter can be NULL at this point, then it must be checked before the
ref_iterator_peel() call above, no?

*Can* it be NULL, though?  The code in question is a bit complicated and
it's late around here, but I cannot see how cmp < 0 and !iter can both
be true at this place in the code.  An optimizing compiler will probably
optimize out the added check and string.  Mine does (clang 13); you can
check if yours does the same using:

  $ make refs/packed-backend.o && grep "must have" refs/packed-backend.o

>  			if (write_packed_entry(out, iter->refname,
>  					       iter->oid,
>  					       peel_error ? NULL : &peeled))
