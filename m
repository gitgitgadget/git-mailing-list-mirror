Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBA8B1F404
	for <e@80x24.org>; Fri, 19 Jan 2018 20:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756311AbeASU2w (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 15:28:52 -0500
Received: from avasout03.plus.net ([84.93.230.244]:55519 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756160AbeASU2v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 15:28:51 -0500
Received: from [10.0.2.15] ([80.189.70.206])
        by smtp with ESMTPA
        id cdHMe8hSrM9yPcdHNezj57; Fri, 19 Jan 2018 20:28:49 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=JLgVTfCb c=1 sm=1 tr=0
 a=BecK+r/lr4XRfISlKBaA+g==:117 a=BecK+r/lr4XRfISlKBaA+g==:17
 a=IkcTkHD0fZMA:10 a=onhi19IbAAAA:8 a=Dx4yW56zAAAA:8 a=ccWbX4lM0BBtC2vfFDUA:9
 a=QEXdDO2ut3YA:10 a=JvkiTdytZRqVYIXWt-wT:22 a=X_u8qhY6y2Nm79co_leF:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 1/6] Bypass GCC attributes on NonStop platform where
 used.
To:     randall.s.becker@rogers.com, git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
References: <20180119173406.13324-1-randall.s.becker@rogers.com>
 <20180119173406.13324-3-randall.s.becker@rogers.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <86c7345f-814d-8d81-bb55-e91fe630e118@ramsayjones.plus.com>
Date:   Fri, 19 Jan 2018 20:28:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180119173406.13324-3-randall.s.becker@rogers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLtoaQeqtvRdVVY4Pj33SmkIoMoanUsMgC9NXWv8Wdey2hP4Md2XdIlOuzu3zyf/xfA164OOctuclVpwveovkmTs4O/b/g3ldzxUqdKcRmbjIE8+1Bq9
 1ocfi0PWnc+4r0KcZLLoLuq2KgdmsTroShusskbo5gZpBJP22pAtokn8qO1J0fQ0FhV3PmGzG+j7+w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 19/01/18 17:34, randall.s.becker@rogers.com wrote:
> From: "Randall S. Becker" <rsbecker@nexbridge.com>
> 
> * remote.c: force ignoring of GCC __attribute construct not supported
>   by c99 by defining it as an empty CPP macro.
> 
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
>  remote.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/remote.c b/remote.c
> index 4e93753e1..c18f9de7f 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -11,6 +11,10 @@
>  #include "mergesort.h"
>  #include "argv-array.h"
>  
> +#if defined (__TANDEM)
> +#define __attribute(a)
> +#endif
> +

Hmm, the only use of __attribute() I can find is in compat/regex/.
In particular, there is no use of __attribute() in regex.c.
[__attribute__() is used in regex.c]

Is this an old patch which is no longer required?

puzzled.

ATB,
Ramsay Jones

>  enum map_direction { FROM_SRC, FROM_DST };
>  
>  static struct refspec s_tag_refspec = {
> 
