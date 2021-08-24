Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33539C432BE
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 14:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C2DC61176
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 14:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237631AbhHXOA6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 10:00:58 -0400
Received: from mout.gmx.net ([212.227.15.18]:35543 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237593AbhHXOA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 10:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629813612;
        bh=v4RkXi73hRERku8J3ug5pWfqDw1jFrPUZ12GG+3MToc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dsWwU+tVvlRRV+T9riAjq+tOCOdsTtWsxw070J4u9c8ewTLAYjexXXHOwiF6cn6Me
         B8qbHdNUDibggEMCC8G6uKLqlyjHzgPB4FD53MsUs0Dp0zK/qw9ExlvHYHzeZaIpwr
         lbJIX0e0WZZCuNkPDVFjXFlC1XBFDf/1mTlBj9oA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([89.1.214.7]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MV67o-1mQg9a0TCA-00SB5B; Tue, 24
 Aug 2021 16:00:12 +0200
Date:   Tue, 24 Aug 2021 16:00:10 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v5 0/6] Finish converting git bisect to C part 4
In-Reply-To: <20210820172148.2249-1-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108241559350.55@tvgsbejvaqbjf.bet>
References: <20210820172148.2249-1-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:W+JEQiczRC/Mr1MHuMZBre6nd/cyfx5N39K2TNlVm4FxVu/2e2m
 Uv9w6Q4HSadvU50ZrAmGiFbc9eoEAzvMzw7r2mzk0Wfl/SvwXkp0+3VRkEsnxGMjypGyG65
 on+U4deN5t5orL/CsTbrOM0Q5QgsAmO9FXq1wqwLKw8iSiT0x9e6RcpBEh7+F0Og0S1ef9m
 fDYK1fvvSijzSUrXEVV1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IReG+8KTGrY=:e+YmMw365ItqvYLkPZBO11
 qLpzlO8kRrbn6e4AzVmYLpHaX/JdiBHaWaV2hwsGFK9WHK5Bqt6ZeflK5Cyu5CtnEHiqJlA+u
 LJnZTHa+DYMMmNCLSIqTX3VOOvedbSbU5o+8woVRKpDXJ54Q7Q6IzyigHugOha9x6WOxWSkQX
 3MPek1ejUNfZanb+cmJgfWl4wK6xYsYMsACQcBhVjc/Z99oMRdAH5SZHgZlVvi2nXa4JMXNCy
 H3zzqMT7t3xtx73nalarxyLPrp+jwZViR7/JB+SKu4MyF4OlLgfwl2+sHc0pOc7k7DYM6P3me
 8H/LPckBiep7Cwtp3PSS9DcPy+8sKyzEVF9rwb4yb+oZ1g0sZueJPjEIkHrzKeltvXOgzu9Uc
 luEzd0ANnzV/YDeAP8LahCP8XXsXHVoxm/lKYCpcytHPLYVCq9WflQ3ISryqo31Br+lo/rkxn
 qJJaSzKRGPz1soBh92RA0SyLUxXZRN1HPHxXG2WHjuP0tgQy2xEVUK9fu0aMVLDv4irEZ6Sep
 64k94bU6v8pcYiuHvSLgZTCOYKNF15IpM+5rbBAFsJmXkwL0gbwRaN2Xc/wUZnlyWM5ZTHIje
 +2S4fVtDx0KOhaG3K66q3YMKMJOWAtsztEtJ6y1xHKlyqPhqwEOd6CNHsLHYvRLu+XbWZxkfF
 1iECsbUdfSNwQlDniCMICHgulvOB3fDUievOiixDZxWLxJKRwzRhoFstkTzmWs7DQuLjkNJcp
 zrliDfvQPilY8a/YtLUtyb/Q0YDaUeNBbAImvxJUMOG4z6yLzoSssA3hGxdy/G28pPfNZ+efN
 0tAeMj9lzIAPEUZ5kIpGCaZsLn9E38Vg0hA0E1r/nihlxe5a4w+RuhoXSVxnCm5v4T8xNWNTj
 RuHzwZA2FMXHdvofC2G6JU1vdevDCZnKrpGV9dDbbSIkAn9AjyVVC6LJObUmQAxu0SGbHltqX
 +TwkEkm4YEJP1R/sKyddcB4YN02NZiY22ibaPRwK85Gm6LFPV6gENk54qVFpmebW8BSoTJk41
 aktZ/g73EfWJgFUaKppXek8WXS7ZQR+oKgfE66F1oa/YmmFA//sd4D++8yAuot3Glp8lJvR9e
 2QXmnfYgTYTkHIVfUE3hvi5SZT68BCZprsgZTa3qilN8pWM2VcH+Qmy2Q==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

On Fri, 20 Aug 2021, Miriam Rubio wrote:

> These patches correspond to a fourth part of patch series
> of Outreachy project "Finish converting `git bisect` from shell to C"
> started by Pranit Bauva and Tanushree Tumane
> (https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) and
> continued by me.
>
> This fourth part is formed by reimplementations of some `git bisect`
> subcommands, addition of tests and removal of some temporary subcommands=
.
>
> These patch series emails were generated from:
> https://gitlab.com/mirucam/git/commits/git-bisect-work-part4-v5.

Apart from the stdout redirection in 5/6, the patches look really stable
to me.

Thanks,
Dscho

>
> I would like to thank Johannes Schindelin, Bagas Sanjaya and
> Christian Couder for reviewing this patch series.
>
> Specific changes
> ----------------
> [1/6] t6030-bisect-porcelain: add tests to control bisect run exit cases
> * Add evaluation of error code 255 in test 'bisect run fails with exit
> code equals or greater than 128'.
> * Remove test with error code smaller than 0.
> ---
>
> [4/6] bisect--helper: reimplement `bisect_visualize()`shell function in =
C
> * Use strvec_push() instead of strvec_pushl().
> ---
>
> [5/6] bisect--helper: reimplement `bisect_run` shell function in C
> * Add error message.
> * Remove exit variable.
> * Write contents of bisect_state() in BISECT_RUN file and show to user.
> ---
>
> Miriam Rubio (3):
>   t6030-bisect-porcelain: add tests to control bisect run exit cases
>   t6030-bisect-porcelain: add test for bisect visualize
>   bisect--helper: retire `--bisect-next-check` subcommand
>
> Pranit Bauva (2):
>   run-command: make `exists_in_PATH()` non-static
>   bisect--helper: reimplement `bisect_visualize()`shell function in C
>
> Tanushree Tumane (1):
>   bisect--helper: reimplement `bisect_run` shell function in C
>
>  builtin/bisect--helper.c    | 157 ++++++++++++++++++++++++++++++++++--
>  git-bisect.sh               |  87 +-------------------
>  run-command.c               |   2 +-
>  run-command.h               |  12 +++
>  t/t6030-bisect-porcelain.sh |  18 +++++
>  5 files changed, 182 insertions(+), 94 deletions(-)
>
> --
> 2.29.2
>
>
