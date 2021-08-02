Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460A8C432BE
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 22:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27EEB60C3F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 22:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbhHBWqj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 18:46:39 -0400
Received: from mout.gmx.net ([212.227.15.18]:53285 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231126AbhHBWqh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 18:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627944365;
        bh=mDZ3wULFMfGnO53wlk6dr1rvs4z2gLYNyuSxPQSWhUU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LXiwaffYDjuQ8sV6bC8U5A1MWMSCf8UwV2SsWf0Oqnx2IxkaSwagmyBHA1MfEyhwH
         buc3Vq/dGJ1oOZHqUP5FZr+3GixCeQIp7GL9Mpus2v3wuvUPMkQ3RYxsZRMMd0Y3rp
         tnsrtUKtcBwAR7Po80NRAHWnwttXR3S3/QlskVUU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.101.220] ([89.1.212.168]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfpOd-1mmUI02ZwH-00gDQg; Tue, 03
 Aug 2021 00:46:05 +0200
Date:   Tue, 3 Aug 2021 00:46:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/2] Change default merge backend from recursive to ort
In-Reply-To: <8f6af8d494e0924aef4ae6963b8dca2228dad9b1.1627776462.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108030030000.55@tvgsbejvaqbjf.bet>
References: <pull.1055.git.git.1627776461.gitgitgadget@gmail.com> <8f6af8d494e0924aef4ae6963b8dca2228dad9b1.1627776462.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:tprR4aF26F3ZpLVtCDM6+syNtqZ2FPGi3d7/4ofC6vT+M2qYyh6
 LObfPUNi1hA9GajZCVUD1/vFv6IGaIgaDIdyChZhKt35r9I0haiXlqlOmpCyu1nW9RInja9
 gdjUzsdknabcgI1/wB3lu+EjHu0WA18//PGBWt8gW2wCl9XQITNnYsPMdhYmewLO/J2vxlb
 +9Mm9daXScj3RWO+QSf8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FQP4XcbrvI8=:FPMQoqMBSO5eF98wZHo6ra
 vMZB9I/wVGLQZ7BQUmiMf4lVgTrbBZbNPJ6bEljG2F2tUri9zAWCMjwNRijc1gFlMg2i5jEbw
 OQxtzbNjQMG3JcmEkQyk9JImM0pN6AXu+y3bLt6oA3kKLEy4ZnwbyESE5k6rRsu2qoE7CJhQo
 nj0V6p/WHm+k0hoiT+iLVhhaNB2klo3ylvH5R7g6GoM756ooHYFt7GUgtA3R14yZL1HW56jXw
 XaM8a8cYvcbOTg2jiEBQWnLApvSRtxihMMVcYizQ3nDN+8ZVLrsmOMeudI3L5AzJshaTRmbdW
 NhaMV+duph6gsvGTnhsbBg5ezRKRl2qOEXOaFQ9NMwAJNGaYnybKqFuz37eleo/r7YmerxHMr
 XGY8qeUWk2/QJ4yR0j952OIkmJMQUM+UdKE+gQrgV7puaETiZw666Ot/plJcCWim4EqcMIJOi
 qzFqZbZKrUONOygh7W+Ai/7poWcomOnnusUyZUMEkH+KOcPeYzxydk7IdZvd3TfgTIBd5KSPc
 WcaHv53UDrLXh6CZc7V6hvluGkQ0FITTzG8IYEwJO+uk8PnIvky6AcSePmirpXOMQ/mT1H2Ld
 l81nOpBZgYSpSbLpU3BP4KMLyxh8rMdL3jQUDoBqJbe/qCtBBh4eaEgGka7RPsD/BsyMceRbr
 Rxpq+OMZwDUpArMPGsrNtwkWBbJQwvCS4+Ykh91cHj4/cXQO181sXj44E1VT3jmJK+Jli/9C0
 3U1qx0GyYR+Ajvy4Wk+yz4DJGIzXAxNXotJHjTlLTtlXqfbczrkH3W6itv/IrovThezq3230x
 b63ssPxcOicdEVAk/onu1bvoNXTWi9L4iD39P5cAjPuOTubiXwAKCsNCw18bm6sO90NEvd0Dt
 jwYf/LEIEwOCVo671StV++SfpQQHtzRDmIINjMr5PmJkHzlMs1pYRmvnpjcrTg8ZnVrC38c9D
 gWaPp20cHlm5GqfLL6oaF4t/UoVBFTvUN+195QKJPLR7aY4i0tYS2MYXY84pPKZ9dwz5gRw3L
 DYraMVE/53bYqQDzBGfi/dVPtITdpGJVNag7PqaxHphRhO4EEd07nxUUgpJQwKzqhiJm5bNvw
 rGgzx3Eu7qSOde4eUBWNLzNL1BIP5P5bvM9LGNdromlt5vtpK+gAuaOnQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Sun, 1 Aug 2021, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> There are a few reasons to switch the default:
> [...]

I think it would be really fantastic to change to the new default right
after v2.33.0.

As to the patch, I only struggled slightly with the changes to
`sequencer.c`:

> diff --git a/sequencer.c b/sequencer.c
> index 0bec01cf38e..a98de9a8d15 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -636,7 +636,7 @@ static int do_recursive_merge(struct repository *r,
>  	for (i =3D 0; i < opts->xopts_nr; i++)
>  		parse_merge_opt(&o, opts->xopts[i]);
>
> -	if (opts->strategy && !strcmp(opts->strategy, "ort")) {
> +	if (!opts->strategy || strcmp(opts->strategy, "recursive")) {

At this stage, we're in `do_recursive_merge()`, and there is only one
caller, `do_pick_commit()`, and the caller is guarded by the following
condition:

        else if (!opts->strategy ||
                 !strcmp(opts->strategy, "recursive") ||
                 !strcmp(opts->strategy, "ort") ||
                 command =3D=3D TODO_REVERT) {

The issue I see is with `git revert` allowing custom merge strategies. I
_think_ we need a slightly different patch here, something like this:

-	if (opts->strategy && !strcmp(opts->strategy, "ort")) {
+	if (!opts->strategy || !strcmp(opts->strategy, "ort")) {

>  		memset(&result, 0, sizeof(result));
>  		merge_incore_nonrecursive(&o, base_tree, head_tree, next_tree,
>  					    &result);
> @@ -3968,7 +3968,7 @@ static int do_merge(struct repository *r,
>  	o.branch2 =3D ref_name.buf;
>  	o.buffer_output =3D 2;
>
> -	if (opts->strategy && !strcmp(opts->strategy, "ort")) {
> +	if (!opts->strategy || strcmp(opts->strategy, "recursive")) {

It took me a while to convince myself that this is correct. At least now I
_think_ it is correct: `do_merge()` defines:

        const char *strategy =3D !opts->xopts_nr &&
                (!opts->strategy ||
                 !strcmp(opts->strategy, "recursive") ||
                 !strcmp(opts->strategy, "ort")) ?
                NULL : opts->strategy;

and then hands off to `git merge -s <strategy>` if `strategy` is set,
_before_ this hunk. Therefore we can be pretty certain that
`opts->strategy` is either not set, or "ort", or "recursive" at that
stage.

However, I think we could use the same idea I outlined in the previous
hunk, to make things more obvious:

-	if (opts->strategy && !strcmp(opts->strategy, "ort")) {
+	if (!opts->strategy || !strcmp(opts->strategy, "ort")) {

Thank you,
Dscho

>  		/*
>  		 * TODO: Should use merge_incore_recursive() and
>  		 * merge_switch_to_result(), skipping the call to
> --
> gitgitgadget
>
>
