Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B8081F731
	for <e@80x24.org>; Wed,  7 Aug 2019 13:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729929AbfHGNI5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 09:08:57 -0400
Received: from mout.web.de ([212.227.15.4]:47239 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbfHGNI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 09:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1565183332;
        bh=g5/5IL/iYKgE/6OQ1UDjJ+uDAgkBdlV7PcveBhOiCpk=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=bmiNmWJioG9UWGPJMNRylc7AtQEqCkD25MBxKJR8CxO2Ak1pn7gemhiM6jeDvjA8B
         GnF0nbJNSaNDeDHTUaD05Mjf62F3NHbIW2FASEL7o+H0tizYf1+aF6oMrQ6NFafh9N
         NYSyCzWkUbSid1s+TtNIVC8Wjl5LlCNtjvPEZFpM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MWRoI-1hoAvZ3uiA-00Xda4; Wed, 07
 Aug 2019 15:08:52 +0200
Subject: [PATCH 1/2] nedmalloc: do assignments only after the declaration
 section
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        avarab@gmail.com, michal.kiedrowicz@gmail.com
References: <20190806085014.47776-1-carenas@gmail.com>
 <20190806163658.66932-1-carenas@gmail.com>
 <20190806163658.66932-3-carenas@gmail.com>
 <ab8a378c-0a60-9554-b2dd-ecb3d05229cb@web.de>
 <CAPUEspip98Mq8FrKTOkEikZhaLPprZXf=E2x3d0b7=c7e5+Gyw@mail.gmail.com>
 <c7f08e19-88a7-ca7f-90b9-54465e621d49@web.de>
Message-ID: <5077f91b-958b-bf00-565f-7b96aa05a614@web.de>
Date:   Wed, 7 Aug 2019 15:08:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c7f08e19-88a7-ca7f-90b9-54465e621d49@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ddmMI2gY/MAQIMf0ULsxOpNyz5lV/CB/id6drpYm/1eq+3KArCs
 ckO9rDhR2ppBU1kz5e6dD5XdIPqsB+LrHDRbWo6A/7DuM5U7EjUELXICPH0CaO5MebxKMtd
 Jzc3KYSCaY2hnPKFIsazsIgTubeeOUgEYZtNFis5O5h5pjKWlvl8FmDvC44jZ60OiKL+wlq
 2m5YeSMqKRYb1nNrcjBXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nFcXAqOtkJA=:D5xtYVPtAGNbiqrLr+hjo3
 a8Kr/NDbwFu1SmZE8Tj+cdhAxW8DBJss4u1wjFhLlQV4f86q8Z78lkHG8pPc+FO0k4Ie/6hpj
 AEghR+bFu6XPH624DFB/uEPBL+h61DMViMnZQz9gv2ok8CvSW9GtUFAPPAzT3mt+chnMtag4Z
 TfbePuw5X8YAYNThbdA+zROb+eYdnnqK/oCMsiXWeX0N0zTNryXyABx0zjO9ZE0pnZFOsUdWG
 lIdULjgCw5PS8QTrhDFdntXLP6/CUWnBcCHbV59VL+PbAnRXjV6hCxSRVE0p/keYMYV0IEtAA
 N2nles/rmf4qZAoVmQY8kMmx8QwuOo8qhH89auw3LNK4Kqzvcb2CFjhfsyLH3taqHkjHeMyco
 slpQi2xN8C5GmH8M+khnu8VtyBjp8hi3aJlnljFQ8v9RxaosrsszSzHyWsP3MKdbkNUkvNsUB
 ptmbvbhcfYn2hQUEU9PbkzEihLw4qF/qpWppbsbFnr8FK8eryTJBrbOCQsAOwAWOySsZ9W21n
 kzGNYnM1YOhmk6VM2EITratmFxDB7pGpLsrzvvvuzmqIFQ+aNJwnD4ugSKh/5ZWviGAKoQMma
 BJyxhMV/itflXGyodE/+FPHhxHfd4qGz1xwC9SO5ilSTY+dP/EQzf173icwKwu6heCFN0Nsgv
 Jf8u/9WAQIffxA5IHe8VFEP5vU7VewdHrdF8Aix9btYB2ITU16o2Ztp6k+CdQhvewYAiy6cb9
 UuoqrRtVEEBW/hSAzTSH7RadPugT4quxUfXrh0PGX6RHWiHwDARO4K9PRNnsZ1yXzn0PlW/7T
 MW4GWvvJjaIgcKVJq6OjyaI0Cc3DvZiupKeSqVGvdUp6dlvyltXf1bq6vNnU+hNuMnJqErg8d
 qiy5fKAP9ARKAvKCoSM4zNfUvRPBio6EjYqc1pgrRzCXWEAq476ZgNDD+EAVEQSjvnu8DpGE1
 2RQcA3CbmaqyJvkPOQo4jBWuXPL2U/QZ1RK4LUba1MIpdJnHEhbUqmscPEmFfZMXjKtig6EyU
 3D0qz3Us1O4KvLTBq1oDC6HjTQQgY/QzhdCimDwqTU536OlWd+mBsRyefOON8jnC/2+64PWlV
 38LZzE3e9EldW+o/DfrfB11aFC4wXJ0WpIfmiRmwTnTpY3yYrFN+1G0jj26uAbA8Mf7JSrpM0
 3vvt4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid the following compiler warning:

In file included from compat/nedmalloc/nedmalloc.c:63:
compat/nedmalloc/malloc.c.h: In function =E2=80=98pthread_release_lock=E2=
=80=99:
compat/nedmalloc/malloc.c.h:1759:5: error: ISO C90 forbids mixed declarati=
ons and code [-Werror=3Ddeclaration-after-statement]
 1759 |     volatile unsigned int* lp =3D &sl->l;
      |     ^~~~~~~~

Signed_off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 compat/nedmalloc/malloc.c.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
index b833ff9225..88c131ca93 100644
=2D-- a/compat/nedmalloc/malloc.c.h
+++ b/compat/nedmalloc/malloc.c.h
@@ -1755,10 +1755,10 @@ static FORCEINLINE void pthread_release_lock (MLOC=
K_T *sl) {
   assert(sl->l !=3D 0);
   assert(sl->threadid =3D=3D CURRENT_THREAD);
   if (--sl->c =3D=3D 0) {
-    sl->threadid =3D 0;
     volatile unsigned int* lp =3D &sl->l;
     int prev =3D 0;
     int ret;
+    sl->threadid =3D 0;
     __asm__ __volatile__ ("lock; xchgl %0, %1"
 			  : "=3Dr" (ret)
 			  : "m" (*(lp)), "0"(prev)
=2D-
2.22.0
