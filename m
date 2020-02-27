Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F0DC11D3D
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 15:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B21E24688
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 15:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="KiY+1PFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbgB0Pzp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 10:55:45 -0500
Received: from mout.web.de ([212.227.15.3]:47671 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729372AbgB0Pzo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 10:55:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1582818926;
        bh=+oCdDRJoo6rjVYpHSrwT55POkZFmZVo3c5JNVE4a4lg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=KiY+1PFXE22l/Z5XaRxJI6yB5rMljKrMbMqU35uWjY6Vaxp8jnBg7pUsbAoU0Fu/d
         e19kRTpHgIFsotJ2m5Xxo25Pk0aSiQ+ihd0Nl7N74bIels9XZphKm+QEQzpWoOYCQ+
         IBx2LezfRx9rdqe+DUp45c0T8EvOaUqxACS0r8fs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.21.89]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Mb8h9-1ir3o51byt-00Kjjc; Thu, 27
 Feb 2020 16:55:26 +0100
Subject: Re: [GSoC][RFC][PATCH 1/2] STRBUF_INIT_CONST: a new way to initialize
 strbuf
To:     Derrick Stolee <stolee@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Robear Selwans <rwagih.rw@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <20200218041805.10939-1-robear.selwans@outlook.com>
 <20200218041805.10939-2-robear.selwans@outlook.com>
 <467c035f-c7cd-01e1-e64c-2c915610de01@kdbg.org>
 <113d4221-d7bd-cf0c-ebfc-1fc08442c303@web.de>
 <a94a32f6-a650-4ec7-927e-032e22a23ffe@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <ef831d8f-7667-3315-ab80-2cb13bb963a1@web.de>
Date:   Thu, 27 Feb 2020 16:55:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <a94a32f6-a650-4ec7-927e-032e22a23ffe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6QhDrqbZsoRMG/Efn2GVltMDjIKCndAzDbNs8nblnRYl7nSUNOK
 vuqj2Kdp6bf8mVyQi9fpqxqW25msMbkjIWqPu6bljOoa4+ndfUlGZpcCea/ZeQD4B9KG0A9
 C4+j/P5KuA4WBB5p5eXJ+7dLCpsUknqPzfooBUfSga+ut/IVQlcaY8rdMhBSZNDdMBRhpy3
 A6qfHEWxmBg/UYLLVe5Lw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DXcdKNPbERM=:EcCxNXtwZKfPE7f4qW5FNi
 VFHGu67A8V43XA9Yh41YznVVgYzwAmhwwSytkLhRtvLqqA1hv3GZjJjALGFrPazm5LV7hWv8Y
 PCeS42ZTIQTgBw4KS6JPQnPf5YkVW2AtzwSWhNU2h26ivdE2SxKzD4EgNuvfmY4n3mxPuW4lS
 76RaFP8eJrAGPFh7qdpAQPp8EkbPtVqixcwyyop3vk3nJ0TYJ+z0FgiotY021ZtKv4e6zTyAZ
 xVI5cj7TRGTNG7ZdSWyDt1Kt4SZaETAG0bpjLVX5cacYynWp0OGRbP2ryjSpyHX/SL9IPRsoL
 wEeTbMas8KePkORQahuerCj4yuS90sUDkwECQ4rTexcgCYKEwRdpMG8WZmMJepyCixJRFz3cY
 90KTCcAnb62ZLRU8iAmmXTkl3Mn4W57VRVa9CISJSb5u4+uaZMyLHCrgC85OdaLKfNed06Yzn
 DJjpC3iKL8SrjtF554w+iijaK8TSqRUlVHGNGQcHvSa4wNT8hcuNCFq8Ggm08mA0udMsRTRWZ
 KfzK/76Mb16wiJbDxq009hfRpP3+OUd0sEfPVzk1KSgIHGrKfYArqHmyLkb16JfWK27Bg5O63
 ZHlV+9LSEwJRZndTzMFX4NmMFVU64I+ckzXkbkexedRWhU05uomVbae2iVKvJb7QyQxoydVN+
 FTzA9vlkx55t9mPAIR6ZFBG+gyiR0NKUF9YBV8VE3pVua56VqmM7g01or9uBJC3btB2h/cS+z
 dMIxcW1d1GV5fS3bjDrMyRFir2V0pqD+6CygIu/fJV/SkcfJ8iG3D14Hq2Dng9OIChfAD77+0
 cJcMrJyqVbBQrVo5WjcUm+g4YTmJfUayxrYXch0YdIfq/FYUP2k2NNu4stFxRdFEkDKZQsNMS
 llpwvDUTCWE6Bo2eQCsnF1FpeoDVm9Chk9YOneELVeD+CuRSan1NAt6uMbP3ff05ddUkbFsKg
 xZKp9MgoEkyTeiGxBBG2z7feb7wXpe71E3AHM7mjYPHuzL8eYv/hw8ncY6DADsVGaVHPPlOC8
 myQ0r8lqnficTCxNqbusS+JA+AWI5whHPGPAgT9ujV/PxfU3m62y6i6HY71HFAw8bG4IagnR7
 RbsjqNMGfOz7CXkBiPN6Jlm1oiaaHqMKaOP0OclvvTEJTrjEA4yDql2CpXS4pEFyM/1frcvXR
 de3Orm2d0iVD4Ma2PLv9saTL6oHsidLd0PR8xoDxSxF/cOueDcagDAcFgK46SRHLnJrkLZBFG
 KzxO78KuVxUigjajE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Am 27.02.20 um 07:50 schrieb Derrick Stolee:
> On 2/20/2020 1:49 PM, Ren=C3=A9 Scharfe wrote:
>> Subject: [PATCH] commit-graph: use progress title directly
>>
>> merge_commit_graphs() copies the (translated) progress message into a
>> strbuf and passes the copy to start_delayed_progress() at each loop
>> iteration.  The latter function takes a string pointer, so let's avoid
>> the detour and hand the string to it directly.  That's shorter, simpler
>> and slightly more efficient.
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  commit-graph.c | 8 ++------
>>  1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/commit-graph.c b/commit-graph.c
>> index 656dd647d5..f013a84e29 100644
>> --- a/commit-graph.c
>> +++ b/commit-graph.c
>> @@ -1657,19 +1657,15 @@ static void merge_commit_graphs(struct write_co=
mmit_graph_context *ctx)
>>  {
>>  	struct commit_graph *g =3D ctx->r->objects->commit_graph;
>>  	uint32_t current_graph_number =3D ctx->num_commit_graphs_before;
>> -	struct strbuf progress_title =3D STRBUF_INIT;
>>
>>  	while (g && current_graph_number >=3D ctx->num_commit_graphs_after) {
>>  		current_graph_number--;
>>
>> -		if (ctx->report_progress) {
>> -			strbuf_addstr(&progress_title, _("Merging commit-graph"));
>> -			ctx->progress =3D start_delayed_progress(progress_title.buf, 0);
>> -		}
>> +		if (ctx->report_progress)
>> +			ctx->progress =3D start_delayed_progress(_("Merging commit-graph"),=
 0);
>>
>>  		merge_commit_graph(ctx, g);
>>  		stop_progress(&ctx->progress);
>> -		strbuf_release(&progress_title);
>>
>>  		g =3D g->base_graph;
>>  	}
>> --
>
> Not only is this a good change, it no longer leaks memory.
> Thanks!

strbuf_release() frees the allocated memory, so I don't think the code
was leaking before.  (It would have with strbuf_reset()).

Ren=C3=A9
