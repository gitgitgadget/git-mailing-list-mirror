Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52D831F461
	for <e@80x24.org>; Fri,  5 Jul 2019 18:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfGESvE (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jul 2019 14:51:04 -0400
Received: from mout.gmx.net ([212.227.15.19]:59809 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfGESvE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jul 2019 14:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562352655;
        bh=AwW/MG4Np8HENrmS96+fLdp41EXRn/+MFq6YIaExaOY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gju3ojxuo3gp9OaVpFXKDL6mLs8B/HYPe4SWpm9jJHIeFmwJA2Fsg3Wl8+96dnPvs
         5moxVZKmzo2TmpPv/jdesxn6smZfVKkYxyl2cvmn3ukFR/AQiMcbp8pJbRkYqMY5Ov
         d7LW9pGrkS9n6i1eWliW9CoLOp44j88vMXTG9TnE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LsCdj-1ietqC2jPz-013wTL; Fri, 05
 Jul 2019 20:50:55 +0200
Date:   Fri, 5 Jul 2019 20:51:25 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 06/14] apply: only pass required data to gitdiff_*
 functions
In-Reply-To: <20190705170630.27500-7-t.gummerer@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907052048570.44@tvgsbejvaqbjf.bet>
References: <20190414210933.20875-1-t.gummerer@gmail.com/> <20190705170630.27500-1-t.gummerer@gmail.com> <20190705170630.27500-7-t.gummerer@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:oHiLxoYvB4tNp+uHiicvvDVRvyoVFqfYBzTwGHaY++aBRZ07DlE
 kzkBs3VKxnT0faGzKs58Xi+TRGwgS89rX6En5kUhjK5IC+Ve2Mf3VoGDFs/jnXKFLHzeKwb
 v9G+Ar1nrD0GD8eE2rWQlfaNYdp0tkEgpiTCmiFrdIRGow4EdfBKQxcPbHHYOWegh03jC3e
 a6660CqbyigZfsS6ng8fg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WNlhndwFi6s=:ECWmssLrfDFBH08+q4ga3t
 /d4tqrp+rVjJdIrwJWb0/4UeXRq/yiWLGePNxkIZh0ad4UffMkaM3AMA+DIcaONaXJLwkkeQz
 8mX/g8bEvewjO0Z0veL81dq1RIsJKA4knnhSghMVv0H6Vsk6FndXPvoyHyTyKKYR2BzfihwJK
 euJ3JioOESPWaamFZBtsh8G5rt5W6Lt5YDnoSnHGTTI3gNMJoGqlyCN8kI9bYiEhU+dc+a4oV
 PLX431ULx4ESmphTH995DgJNgvHIH46kZ3bxRJcABHKdKY1RI92X3E9lI2775vTSDv3cmQknD
 Ibh4bxFwdhMR7FWTSMEHY4glepFozI69arlJyA3RGEEncO3obPsL9uroHl/qU/RoB7y426ffz
 mZpD3z3ZpP73iXZDTVfZ/NXbelXsMm51/hZD4YUxVYw5QniJWI5r1pw06SK16aFf5VxtDm7AT
 NlaX7r44B5n9NQp3hGiJ47MymiAuJ2JOJvr2hEmMJ7/iP4lCCDuKVpbK0X8RiqONUYSrJltvz
 /vqFpMVUcjt0cxDOVjZiUT3kRlffPkUxg0awm5r0bxNOONaKpUMliZtE9o26uvV82+EKj9b8m
 erIRtNJQA730HjKQSNpXFyUByvqjCLYdmUyLS2xKiAtO3vXLkHkYwogsawr7qZBysSXo9F6ja
 Bmk9vbyqW68XadKQged0clTUisXRTD3PMNeeDVoJHxBKuMMsUNxcCszUCY3Ler7XIInwtGof/
 dIVxBuH37pIaY+BIuMItv63Bjy8x4MbJHp6gKNJZgUV2txHXkWMPzmdikTMV0it1W0P1TwPmt
 INm+OhjfDDjMXgmmKtJV9Wt5iNz0Nku5dXoIDl5afuqcx67Zte7FCQl5CEWkuSMCmsifNrmSA
 gVHDMEBDWuPM573fuGTl5EnGH/DWZgsdfK/ryNSuigbe8ZCFzgfe9VT/5BKeU2MXNbkmSN+We
 dQdo9wibxbFrpdLeGPAzvc8mhDLOB2IYs6FtGrF5dlwEV6gH4u84yn0M4SrYR/+42NyGssjD0
 O4NJWFnrzCVQJqw/eWzMYXhCAbJ6hf+X1YX3Q4jZmnPKuT8ydMCKugGy6TECTNt0U5DKJAMLX
 CWTkELhycUIsZd8jorM6yOScS6WVesB+c6E
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Fri, 5 Jul 2019, Thomas Gummerer wrote:

> Currently the 'gitdiff_*()' functions take 'struct apply_state' as
> parameter, even though they only needs the root, linenr and p_value
> from that struct.
>
> These functions are in the callchain of 'parse_git_header()', which we
> want to make more generally useful in a subsequent commit.  To make
> that happen we only want to pass in the required data to
> 'parse_git_header()', and not the whole 'struct apply_state', and thus
> we want functions in the callchain of 'parse_git_header()' to only
> take arguments they really need.

This commit message follows the exact pattern of the previous patches (and
they were pretty convincing to me), but...

> diff --git a/apply.c b/apply.c
> index 3cd4e3d3b3..468f1d3fee 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -22,6 +22,12 @@
>  #include "rerere.h"
>  #include "apply.h"
>
> +struct parse_git_header_state {
> +	struct strbuf *root;
> +	int linenr;
> +	int p_value;
> +};
> +
>  static void git_apply_config(void)
>  {
>  	git_config_get_string_const("apply.whitespace", &apply_default_whitesp=
ace);
> @@ -914,7 +920,7 @@ static int parse_traditional_patch(struct apply_stat=
e *state,
>  	return 0;
>  }
>
> -static int gitdiff_hdrend(struct apply_state *state,
> +static int gitdiff_hdrend(struct parse_git_header_state *state,

... here we pass a different, newly-invented struct instead of passing the
relevant information explicitly.

My guess is that the code would look horribly verbose if we started
passing three instead of one parameter? If that is the case, I think a
little side note in the commit message might be warranted.

Ciao,
Dscho
