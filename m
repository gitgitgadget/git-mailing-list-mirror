Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A344F20756
	for <e@80x24.org>; Fri, 13 Jan 2017 17:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751019AbdAMR5B (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 12:57:01 -0500
Received: from mout.web.de ([212.227.17.11]:55442 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750818AbdAMR45 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 12:56:57 -0500
Received: from [192.168.178.36] ([79.213.118.247]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MHp8z-1cQjSw2OBJ-003cQB; Fri, 13
 Jan 2017 18:49:31 +0100
Subject: Re: [PATCH 1/3] xdiff: -W: relax end-of-file function detection
To:     Vegard Nossum <vegard.nossum@oracle.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <1484324112-17773-1-git-send-email-vegard.nossum@oracle.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <23ca90e5-90a4-a03f-e51e-c82ebc75c16f@web.de>
Date:   Fri, 13 Jan 2017 18:49:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <1484324112-17773-1-git-send-email-vegard.nossum@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:1QfiV4vP9D0AVx62Fl+h5ZgvylmiZqTfDI70cMu4IvlIdUr2Qwt
 HsKFwOji7UkuEQq/q1BEAVeDslV1kms9J5neqkeqn9NdxtmSr7cDvQgnVJexKZLiEsh61XM
 3h7eIcLGNsPrfTswmC9eI6YjewE7UFdoqqZeLViuYIGgJ53ON8KxGd3Vl0Pw2fwztM4WVXN
 rfLBnW2eC1FM6lRAGS2Ww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/uLJbk4qAgA=:RCno7ID3LK06v7hEtUWQPV
 r1SbhLipXAKpkO0tIDx8f5l4bHnmGQRyOzq4kVhP2vyGd5KdLTQwp7iWFLZKm8Qtwil3oDMkC
 q/17SaM90+HunWDnV+o4N9Y/VQiJ5r0O7o+PMNxv85Os/j9DnlF4i66uJev4PNX1NCCexPpUV
 qmH/uP0OboFwqpCG3oyIjBev/1p/8m66UqaiBBZebLcRx6/qOmNiAYwHF4PbpEC38z13/f2RD
 r0BjW4tYa0l0RzIHbyR8yRBrowjZepVHgZHtu960pxU1ss5aJLQciPIAODxw+QTGpnZweOJLT
 I6c2BiYwWJc0c1AjloGFhT5mWCCSLeMl9uORh7GCPUlenj4XDbDxcHLzLPmSW5cqV8lfUYXLq
 8dK4zyBhQ2TK2KEzw08B8I+pERCQihlsHR1YsSuhmldJ9PRhce0vWRaTbH8z7KL59Uy8qvtcm
 Niucfe4iVSpxHNUEbUaczJjjSFggmvZdWgH4tYAsUQn5uSQ5muqUYTl+eqluoJX6REkX629A8
 Rh4LPvLu2MTwyv0Y6UeHMiqKk560lpDQTGFeXifIoxBVmDeHMUBbHwec+jTN7jEAKsdOOEClO
 J3tM85bTXnANy6dW47VsVKONnxs5FW+nfNRyeyqyEmAMGQhINBxbZY1Qb48scQodilNlnk170
 7zRjMgmX7dm009pZ/+tApHNs/4H4go7yA/aaiPZJ1bzf0KHTsg2xSa1UENXzAmMyPxk4nFRDX
 2YRWmBBAG7vb9elzmET4DEpPDrhu94Y3rU940aU/S0MYQLokVgqRLhwKP9lPyrgEag1STDj9R
 ihsc72y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.01.2017 um 17:15 schrieb Vegard Nossum:
> When adding a new function to the end of a file, it's enough to know
> that 1) the addition is at the end of the file; and 2) there is a
> function _somewhere_ in there.
>
> If we had simply been changing the end of an existing function, then we
> would also be deleting something from the old version.

That makes sense, thanks.

> This fixes the case where we add e.g.
>
> 	// Begin of dummy
> 	static int dummy(void)
> 	{
> 	}
>
> to the end of the file.

Without this patch the unchanged function before the added lines is 
shown in its entirety as (uncalled for) context.

>
> Cc: René Scharfe <l.s.r@web.de>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  xdiff/xemit.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/xdiff/xemit.c b/xdiff/xemit.c
> index 7389ce4..8c88dbd 100644
> --- a/xdiff/xemit.c
> +++ b/xdiff/xemit.c
> @@ -183,16 +183,14 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
>
>  				/*
>  				 * We don't need additional context if
> -				 * a whole function was added, possibly
> -				 * starting with empty lines.
> +				 * a whole function was added.
>  				 */
> -				while (i2 < xe->xdf2.nrec &&
> -				       is_empty_rec(&xe->xdf2, i2))
> +				while (i2 < xe->xdf2.nrec) {
> +					if (match_func_rec(&xe->xdf2, xecfg, i2,
> +						dummy, sizeof(dummy)) >= 0)

Nit: I don't like the indentation here.  Giving "dummy" its own line is 
also not exactly pretty, but at least would allow the parameters to be 
aligned on the opening parenthesis.

> +						goto post_context_calculation;
>  					i2++;
> -				if (i2 < xe->xdf2.nrec &&
> -				    match_func_rec(&xe->xdf2, xecfg, i2,
> -						   dummy, sizeof(dummy)) >= 0)
> -					goto post_context_calculation;
> +				}
>
>  				/*
>  				 * Otherwise get more context from the
>
