Return-Path: <SRS0=wu5b=B6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D6FC433E1
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 18:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5331207DE
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 18:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="bQHheR9m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgHTSrl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Aug 2020 14:47:41 -0400
Received: from mout.web.de ([212.227.15.3]:47795 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbgHTSrj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Aug 2020 14:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1597949255;
        bh=IWdM+6DwsEvMi/2aDgWe5U5F+NNGdtrA0sdrRj5hNKk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bQHheR9mTMed3zfF0a0NpGAyTT3IR6DRUTHPqjf/yQ9O2my6euaFgcT2gnVsj2J+m
         +3UEJxlo08KYpNFEWGT3bwQH5oYfGxECzT8LNau9IVf/slrzM8AtxZ25QMs/dr3GpG
         SJvxMAqMD6Yg6Hal9xO3WRT2r09f3bLKkclm33dA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgAJ8-1kZfMv2u3K-00hUrG; Thu, 20
 Aug 2020 20:47:35 +0200
Subject: Re: [PATCH] Issue #353: Skipping lazy prereq for skipped tests
To:     Gopal Yadav <gopunop@gmail.com>, git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, sunshine@sunshineco.com
References: <CAAUOv8gf7e=pFGgPBK5cb1_RusWEY7s+iWf95_ETTz_3juzggg@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <c3ab29b6-39e8-b0a2-d628-873261850b98@web.de>
Date:   Thu, 20 Aug 2020 20:47:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAAUOv8gf7e=pFGgPBK5cb1_RusWEY7s+iWf95_ETTz_3juzggg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nThkUZeKicxddLve+oUJcim8kti6pIQz8/VnxVXTpp4PO8471hz
 Neb9ZxqReQc6lFbIhtaXjr06k1fiLnkaZ4dO30I9mVfnvJfVsdV65McOUE0cyobDqGapAyH
 CKDyKMCCT4+VzUKsrlv7w+MJYB1qJuNLKvbJ1ZpeszyK6UaKG0BO9VGg6AdKANLn5in2yvL
 X7JCC79xmARNTQG9E7AbQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n1zR2vGRvVA=:uAGxZG9nuwLum5XwnJPd6M
 fPRwGGnHaO04S2DTIS45R/CpNjC18OLRBDf3L2CRfArgq9zVYn/VEHhAeq1KKaBGuhfEbmP63
 gkplZ8p/JTiOPQ55ULjeeGMlFdnDdtZMEcobG2tPPfzJEeVRMTm0mc3Z/zZ2u4YvuQGPpvJp8
 RnBWSFb56aB1HgJESU42HqX6QO0V2bgRfeDUw+HLxb4EBtGemmPKlKT3egEvU3Jgx+udqxVPt
 hUFUvzzG0niIa8pXo0f5yZzU9v4Gjy8w3kVBYLTQBC5/aF/1HdBPvdLYAxhQL0oRgJZkrpqwY
 RqzOMiVsbQdT8sm+//d8AK4zNMEIEfhzcacuGZ7/9ce3zsDaFW4IEFeV5Oi685hQRKvwsEyKu
 xEc7rGPFZ0jpRDRKBJnUzewV3E+A1ttQqxcP+qv9NsBhwCeiZLTNCeIZBHo7nHHFs7zAO444K
 aEG3EKmKgn5C0VaHfAcZr96jRojLRnSaD+9FNCM/b8hUJHpO8qoYjPGirs2OlNVuPuVDMzJxx
 2m4Jd/RXCwss/+ZzpzyqTkZyInBJWCVbMbZvyyLO2fVi/iInE0Yg+IoVbnC05GJc7JqGo6GC/
 RJcdM1xbtydzpjFdMUOObubOk/rWqG4ySNlHTDvfjZ2e2dFMdo4H7V8AXR8x9U8kvRCV4+OIK
 Avx4xsi9ynfcXl7v8Va+rvNec5B2pDqdAFEF0/pwHNBKg1lnJwu7ru2C+gfpbtKSFNUv6O4gC
 P4FD8AwzA+JL3yWzapUIlBiWqfGBC1Nw7e9PlHqdKY6I3jWpA8wzJ/I6Mtt7HkzAG5v71Sw5A
 lg9LQykyED01POOGS7rB7CpOoaR+GXddWH9LcvWQ2uCh//RHhUFLqBqCenfQNwL1/ONVRH8yR
 ugDr+ZDr3XFcFTVXGiOf/q/H+yo7f4nDoh/jduhBviOo8uuolAvIEVboneExwXop2Qeg903fW
 H42AWf+eUsQ+/Ezw06XVZ4xElORkY6nCZaBJRHc23Swi2aPwHzE4tC4lC68mYnk9pRukL+u+h
 mEXv4ELF/fVfzsBmq5ldxp8zwRB9WNcUB3jwh3EE/8o4wCyHKOfFp6/s3mRGpTOtC8oeGIVf6
 OhSHcYGU/zJEsI/TMbc3uI1vPnbjvGAzhriEUXgTINDaTmKf/aOZMs6CJPY265TdSoEFBzemf
 WxSmb/S2ZHiocbVFDEyPWGxzTfeL8rD7jYTPvLUqpCgqjOylciVrdcmr/dcR5VTFpdanLmRqT
 isyeHpLXhyBY7ZzTN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.08.20 um 18:01 schrieb Gopal Yadav:
>  Skipping lazy prereq for test cases that are skipped via
>  the --run option or via GIT_SKIP_TESTS. Issue 353:
>  https://github.com/gitgitgadget/git/issues/353
>
> Signed-off-by: Gopal Yadav <gopunop@gmail.com>
> ---
>  t/test-lib-functions.sh | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 6a8e194a99..bac86ffd9d 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -578,10 +578,10 @@ test_expect_failure () {
>      test "$#" =3D 3 && { test_prereq=3D$1; shift; } || test_prereq=3D
>      test "$#" =3D 2 ||
>      BUG "not 2 or 3 parameters to test-expect-failure"
> -    test_verify_prereq
> -    export test_prereq
>      if ! test_skip "$@"
>      then
> +        test_verify_prereq
> +        export test_prereq

$test_prereq is used as a named parameter of the function test_skip,
which uses it to determine if a test needs to be skipped due to
missing prerequisites.  Checking and exporting its input parameter
only after it succeeded probably won't do any good.

Anyway, didn't e0316695ec3 (test-lib: don't check prereqs of test
cases that won't be run anyway, 2019-11-12) already solve the
issue?

Ren=C3=A9
