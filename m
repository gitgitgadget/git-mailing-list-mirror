Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27262C43217
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 13:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354110AbiDONk0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 09:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350321AbiDONkI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 09:40:08 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17986DEA3
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 06:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1650029842;
        bh=927heXNW/JVPPi3+LB1ohYMBPltALGUqtIfXMWTmDCg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=dygGhOh4k/+tA0MRmlKmaO9x1z/u18/YBOAAbDbdeQFvhRhvpSIRhORPB/4IEbqYI
         fyeSwc0GI2Pvbyt55GtMRBPyx4DkxgO06+umpwpeb+10C+X51bjS6NZRj+voWn7gPc
         ijWynToLdMXQW1NTnQkwahLuAGncrNlWIBjoaZLY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.27.144]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2SL5-1o4yD72Uxz-013YGp; Fri, 15
 Apr 2022 15:37:22 +0200
Message-ID: <4321a9dd-bb82-e2fe-5449-395f998378c5@web.de>
Date:   Fri, 15 Apr 2022 15:37:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [RFC PATCH 2/2] reftable: don't memset() a NULL from failed
 malloc()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
References: <20220415083058.29495-1-carenas@gmail.com>
 <RFC-cover-0.2-00000000000-20220415T101740Z-avarab@gmail.com>
 <RFC-patch-2.2-364d1194a95-20220415T101740Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <RFC-patch-2.2-364d1194a95-20220415T101740Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z/uc8+yYkdTPq/dXq58InvI/khN1RbdDJVCvIMYUVUOJQB253fZ
 sb6iIE5ZgUqrBtfRJCztLC/gGaWiBIv7E57ca4ul+TZEi9ysO46SnxKZZ4ajmvegZb/DUTi
 NPa6qbE9ISCxQniv65dWqBaYam4qyZ72e++Cp6IpcUrqW52aEaiqx47aD5huQa1x2zLuRWq
 rkJ3ucUZBdCrz78MeOQtQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dO09Tvu5dU4=:PV6wNpv3sZnCvLTMv0DcCa
 p45Rnm1cJ/M9/3K1DOcUj6mc3BsrfNu0VfR2l+EgQSM7mnChCPEMCWNAsUS5DbGSW9fxo101i
 XQ1YPkLThmMF/iQWeXyNUGX4C0USVNCmOpMrkqjkcFkVgss1zwanQy4TotsdPtdlljjxOIh+t
 H4ZpcVRp65tPNe3ESmb5i2PFytBKl6gK64kNIVOXoLcawERy9mUV7MufUgMsnikjH7/HnpWUU
 QKghoXEe470cMDNAB2Df0mKDQHB/BhVbFy1EVBuj7i26B5jDbdy++c2mJTLCl4fO95C+n/wbR
 YKX17fUMY+sZSCGQa1OYlQW4ZwKk+nDi+8UBvbMJX5/eDY0/YqxUVZ+ubGbmIUfMhhS3Gw1da
 4X48a2lSLMLdG8ZDnIKeupA1qB4Xs0rey2aVp9D4dNVW8LZLTVoiEZXj/pht35gOe6tSCSJKG
 RRBIGCT9/J6oA/Uqojj/LkZ1Vto5AfoL4JDh192BRFfFpukKjRUOyCPsPVsPVu5sOk4zHo1LM
 j/W3AXxmgPMOgycvTv0WxftiZaSJZi6ctVyIHjOeIufrvP20MZUiFU0TFyd9TkLvQ7CKKw3yV
 wpo0FTOasqdgFiZdGLt1jhyYQ4OTZNvj5t2a3eITC52h1D+y7ZElmj3aEUrUHaoAbkDQ1ST/r
 cMZ2f7Qap3SJIx1YpKeQWVqo8bgVwSOnnALycDUPy9cgI0A4dhhGqQk3IMuMBjB7jGC9w0dQ6
 BH0vFtA3e2MKBR1sZMURUwrkRYg/2uVYqCk80UCxn5JoYh+mdQbs0+dsjkTyMaWyBPzTHpudM
 EVsL0nXanJtWSavdIzc5wdY8hi9C/L/LKIeK7Zw1+u22Q9Ti+W2cUxPcB6JFycYy6QwhRp2qW
 7WPtbn0RgZg0qlh+03oGYdnMpIRVshB5znTIMFQt4VrW8B6j70Rg9qIPx8njSrh3824F38kNU
 lcF9d4nXzmOQbV+rEr1qvHz6FGNlbf2YjaOeblvG0tBmHWluNS63xAPhSlMXWge/VSxFcWsQP
 QOv4Q1E3lJcKHNEjZUU0ic85sbOA1kplnJHmO/X7puTveLlLZk5vHyB56Ozwvnsyug==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.04.22 um 12:21 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Return NULL instead of possibly feeding a NULL to memset() in
> reftable_calloc(). This issue was noted by GCC 12's -fanalyzer:
>
> 	reftable/publicbasics.c: In function =E2=80=98reftable_calloc=E2=80=99:
> 	reftable/publicbasics.c:43:9: error: use of possibly-NULL =E2=80=98p=E2=
=80=99 where non-null expected [CWE-690] [-Werror=3Danalyzer-possible-null=
-argument]
> 	   43 |         memset(p, 0, sz);
> 	      |         ^~~~~~~~~~~~~~~~
> 	[...]
>
> This bug has been with us ever since this code was added in
> ef8a6c62687 (reftable: utility functions, 2021-10-07).

Not sure it's a bug, or limited to this specific location.  AFAICS it's
more a general lack of handling of allocation failures in the reftable
code.  Perhaps it was a conscious decision to let the system deal with
them via segfaults?

When the code is used by Git eventually it should use xmalloc and
xrealloc instead of calling malloc(3) and realloc(3) directly, to
handle allocation failures explicitly, and to support GIT_ALLOC_LIMIT.
This will calm down the analyzer and extend the safety to the rest of
the reftable code, not just this memset call.

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  reftable/publicbasics.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/reftable/publicbasics.c b/reftable/publicbasics.c
> index 0ad7d5c0ff2..a18167f5ab7 100644
> --- a/reftable/publicbasics.c
> +++ b/reftable/publicbasics.c
> @@ -40,6 +40,8 @@ void reftable_free(void *p)
>  void *reftable_calloc(size_t sz)
>  {
>  	void *p =3D reftable_malloc(sz);
> +	if (!p)
> +		return NULL;
>  	memset(p, 0, sz);

This function is calloc(3) reimplemented, except it can't make use of
pre-zero'd blocks of memory and doesn't multiply element size and count
for the caller while checking for overflow, making it slower and harder
to use securely. :-/

>  	return p;
>  }
