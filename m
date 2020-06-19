Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DA5C433DF
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 12:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94AE9206FA
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 12:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="gyR7sh18"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgFVMMV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 08:12:21 -0400
Received: from mout.gmx.net ([212.227.17.22]:41185 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727852AbgFVMMV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 08:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592827932;
        bh=SZVmNcsv3Am1LqutREuiauiIwQGkuhsuoRzE0RDgPDE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gyR7sh18JI9E6i39M2030pAOg41+kwDPR8rl8EwBbdHKK3vtGBek58ZgnyQJeW/5V
         +AkxFnuJVxf5EkAn/qk9KgwOoGcMI6OwpgG8wDg9Rn/0YBBXVcgF/GAskLGM3+i4pF
         GCE4Vkivzxeb6r2W1hK9oUAJsaKVOkqWgM+sQa/Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.227.237] ([89.1.213.251]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCbEp-1jfKxz1p5f-009kI6; Mon, 22
 Jun 2020 14:12:12 +0200
Date:   Fri, 19 Jun 2020 15:51:55 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] fast-export: allow dumping anonymization mappings
In-Reply-To: <20200619132304.GA2540657@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2006191550260.54@tvgsbejvaqbjf.bet>
References: <20200619132304.GA2540657@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WhOsn9dLgbsT+FvDupupo54kMPZwOHIKsJ5TpHWdFYcV1O18Uyg
 qoR7RvgDb0DW4jq4IchMBZ2XWIPZooanSuBGmrmqX9bSc3jRE2nrfJFLVdtntmq/PDJmoVC
 2q5bor2CD30skjfBNvGIvIyIQrw5ye/13a/M8wFotLgb1nH2bqHuvkK/enlizpTtdOn233r
 nAFoKRqs3ulSjkCwc49Kw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8KV+9bwJs4c=:pRfknpUCHEdN3Gw1lVDgMm
 pFFtFGlzz5MHSKjh8jjRyS15qSBkKKqvrDlXmMsoasYJU3+upHBp7hnYXmxzPFi8XPtBFygvz
 Pt/T8n2W12D/llJukEa3xCNJcvlMIXXN65xbs4xX4VIzFyHvokLeTpeoC/0eNPaCNL+iHXzP0
 eeghHifiwQnz/wh4qORO6UaWGhRuextClBhOEdS62ED9uypHEF7CjYEBmjjMSoHrMxeTS5GKn
 unSI8yYn0pR5oCOfsKryPz7aLI6jHVPy8c5KZhnOaSwcFwb/dfpiExFz/Y76jznWOeGhqqFs2
 Q47TWIg14gIAK14sHqJg3AlppXSQo3iav3MHV7zv+/tgJyhT4JKPJRw8R9aZSojEKP2XnMBJt
 MD0xAkiogfu0uOenzhVHcRl8pD84beMTmCMu8VxaYc2hxGblRrKZVWRdk8ZNytkhAbeQI+Unl
 zAy9la92vaNJFsbW0lAX5GYRfAmAxOvlcT1vu+kk6pCKcYQ4DLpGWImqyGq4HJs3K9QZsQVjD
 7Vxcxs42Hb22sswvaLNBqlnmLxfSDid1aPFITmeQC3uf4ZcdsXuTlix5GpVZk1IJbRA3Z3nOM
 p4IogmPqGpQhYEbs13g9rVl32XLViKqzhoy7324nP77EhVT6+xbE7qINjT4kIYNpghYo0yBPQ
 n8ffileLdG6V1aKVfvDRyqsNIwfoBA5LVBVspmm1r4969KnfHpaNkcLB58/KCzbie8gWjdgCS
 UBf4H8NRGcQUVou0pqjmirwdkUVaoJlMMdBb/NAz4PcaoapzsiDmvbRCZvTIqzkrUJvI1l97K
 iJtrMpN10/Ch3w/5Coyqnb8E5VgaFGvVpYe8SLfS2QA3AtnbEFgm/w6FWqrk4lSkNVKIxYpxB
 YPY+DiySoigxNngbZF5TX79r+JdcZ8kqECcp1HGvMUVq/XfrRBB8uIVGE2mfnNlapLOGl60XL
 90N9okPMWLhzhEwdwuz7Fc/aEuKL4sOBYDLUt7TdOiCniyk3U6eQSEnvB2yWiYqlzIR7Bx6WA
 OgmvmwLLtfRPzYOtpl1P6omuIwe4FVXlvt3AQhDqz8cgNCQKJTXeYLT/qDo/JGZjJbY4rC6eN
 S+JRLdV9Vh7f7EupMETuxhPjI0eRTLTKRi2havkyAX+RGiKAmvSLVwDTncl0OjnkQuDeecMFr
 pnjBrSNJQzlXnX9FSBWd4dvN78nRRBOPzC9SvirjrqTo0hI+EeV8LrRKTqMW6TqcrLlmWvoLk
 PH7KEMKTlpKi/Xvp2
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 19 Jun 2020, Jeff King wrote:

> The "master" branch is special in fast-export in that we don't anonymize
> it.  And the reason is that it helps to have some known reference point
> between the original and anonymized repo, so you can find the same
> commits.
>
> This series gives an alternate way to achieve the same effect, but much
> better in that it works for _any_ ref (so if you are trying to reproduce
> the effect of "rev-list origin/foo..bar" in the anonymized repo, you can
> easily do so). Ditto for paths, so that "rev-list -- foo.c" can be
> reproduced in the anonymized repo.
>
> And then we can drop the specialness of "master", which in turn is one
> less thing to worry about in Dscho's series to make the default branch
> configurable.

Thank you for working on this!

I don't have any suggestions on top of Eric's and Junio's.

I'll drop the `fast-export` patches from the next round of my patch
series.

Ciao,
Dscho

>
>   [1/3]: fast-export: allow dumping the refname mapping
>   [2/3]: fast-export: anonymize "master" refname
>   [3/3]: fast-export: allow dumping the path mapping
>
>  Documentation/git-fast-export.txt | 32 +++++++++++++++++
>  builtin/fast-export.c             | 58 +++++++++++++++++++++++++++----
>  t/t9351-fast-export-anonymize.sh  | 30 ++++++++++++----
>  3 files changed, 106 insertions(+), 14 deletions(-)
>
> -Peff
>
