Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 463391F453
	for <e@80x24.org>; Thu,  2 May 2019 20:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfEBUa2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 16:30:28 -0400
Received: from mout.web.de ([212.227.15.3]:56791 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbfEBUa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 16:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1556829013;
        bh=W2TujA7hFKw+WgiZKj9bPkDn2K2R05KHgcwaT3AW9Ms=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=masTEwG69kuzZv2VEbo6urSq3RwfeeCrF8vaiXPjfYo5NHIPAVWItxanEqRZs009R
         +feGIe80gqYfrnt+NXCz4VqL3OmATGyac1efoPp1+Jk8tTWfAnf9P5/SXSe7U91XCI
         k3bb0HQueJ+2qOTjPjpTOE3gwx3vXphtn3zKcwOg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.19.151]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MX0q4-1hIwoT15l6-00W0x6; Thu, 02
 May 2019 22:30:13 +0200
Subject: Re: [PATCH v2 2/4] archive-tar: mark RECORDSIZE/BLOCKSIZE as unsigned
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.145.git.gitgitgadget@gmail.com>
 <pull.145.v2.git.gitgitgadget@gmail.com>
 <ac2b2488a1b42b3caf8a84594c48eca796748e59.1556321244.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <d960966d-a7d4-dc3e-ca0a-70e9e5d1abf3@web.de>
Date:   Thu, 2 May 2019 22:30:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ac2b2488a1b42b3caf8a84594c48eca796748e59.1556321244.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6NonGE54N3+N6ofIbWADFhEOwcUs87KLC1WmtTJWiBfMGIkf8fh
 2lMKnvDLPj2v3NFHMX6ioPG39ACgvqKseoodqn8WvPr5xzMzPeYdON32mRVN2s3jT9/1wgg
 1t6M66zuwzSwhRIhmkhVX8c2M2o218GxLJQFImawb0S1wqxFUhDdMKixHRpIy+IhTI91cgn
 dMJQ1gEgrzgjSvr+kuyAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1jXXioYqVxM=:KiLeWU1fr1mbs0MzfqHazx
 dlAD2qsIlrCNSi49xLBreDL8C7x/WdEd1m30HlNKnINvHKGd/ilbQYwXHh3Id8UhXyJZ1B3ee
 yDl7PSIvo13K/ENvjhYagIII+07LUI5EUMu7NqQh1m+nBTpOwriPWXpqG1J0UnepR4jAB0ERS
 95dwFa+gewFzz64tB/0aM/+XDlTl+UeJINqtomu28qFH0vUZllrsCkYNxF723+RVOYUi40J/h
 rd0HXG9IYrGvbg6/tOJpo1PxmLYgHds0txob9cMz3F6c24llefIeXdgLAaKZ2kyAFtqzBhSKf
 yMsDd1M/TIgiXqjSn30iCd/nE6JvICOR/QA2/tOBIHQq4eUAlneDP4CZPQBB+8+5bIg4/8v9m
 IQCgyE9+LsD5m3qT9yj3vVZy0zR5oeEeJPSf8HCfnKWVTZh9pVyW0KUqrLZfXthCOQOdE5c+x
 HWNlCkxJ+LI111Ea4otj4BNMlraq9yglvgfDtjKy/UzsFuvH38LLs8uvBk55/4EIhbPNzj6ql
 4pcKdg7utklymjnFiig0mFVVXUi6lWHRpFv9Bhtk2sqRZxdiX3rAhGu6iO9oAAZuicTR3knPN
 RunwVtXm259wy/clvdm5EImu1hapZ0cDNlnQOn342MWeInqX8edSRSvl+rFuN/lOxs3syfueX
 djh4KG88rjFjKht174D1t/RiyfnCFT2+IrmuRHbomLGD6A5hTxhGTAFM+b+mhwpGXpQ25M34H
 PRDnlbooVetZY6vrdM/Y3gQ30vU+K4k9k3kkkgYFH1/TkRRf9Ujbjet9UHaC5UgvYV1Ox7hOb
 0G1y+kJapU6lEkcTxdnAf6BPSm5XBMB7A3tbf3rAX3p6fGR9J3aPGV2sMwV6O5dHNT0KWRvno
 TZDf8PUNbKzltnri4g6qggQqAF3Ne59ytQ7ay7zZGwMTlFNfvMCOfV21kkQu+p
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.04.19 um 01:27 schrieb Johannes Schindelin via GitGitGadget:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> They really are unsigned, and we are using e.g. BLOCKSIZE as `size_t`
> parameter to pass to `write_or_die()`.

True, but the compiler converts that value correctly to size_t without
complaint already, doesn't it?  What am I missing?

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  archive-tar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/archive-tar.c b/archive-tar.c
> index af9ea70733..be06c8b205 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -9,7 +9,7 @@
>  #include "streaming.h"
>  #include "run-command.h"
>
> -#define RECORDSIZE	(512)
> +#define RECORDSIZE	(512u)
>  #define BLOCKSIZE	(RECORDSIZE * 20)
>
>  static char block[BLOCKSIZE];
>
