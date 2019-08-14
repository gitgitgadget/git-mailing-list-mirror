Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5C031F45A
	for <e@80x24.org>; Wed, 14 Aug 2019 04:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfHNEbD (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 00:31:03 -0400
Received: from mout.web.de ([212.227.17.11]:44979 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbfHNEbC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 00:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1565757055;
        bh=NxCJP655HZa1alETg42CskJ1UaGo8YvPAJmA/uub6Jc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=LvxnJ5uoHG3jwgMtePl5ub+1KfH9839NsFzdhIYbDRleyt7N6PqVVy5Br9z79eUrk
         CGBADA89W2OXVG3xXW/CdBt5zNthbI7d3IFQyO2bYn6DwcOjzmkRjLyyEJUQqfek/a
         gDslaEQvlKl6FJ+kJqTVAN/Bm958BldgZDhqn8F8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MAMy6-1i8EFR0ey2-00BcUh; Wed, 14
 Aug 2019 06:30:55 +0200
Subject: Re: [RFC PATCH] unpack-trees.c: handle empty deleted ita files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Varun Naik <vcnaik94@gmail.com>, git@vger.kernel.org,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20190813160353.50018-1-vcnaik94@gmail.com>
 <b7f4b745-8942-6d90-dbc5-7f79f2cc323e@web.de>
 <xmqqr25o7qmf.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <22b814f7-4b71-aa68-3078-9cc40338a37d@web.de>
Date:   Wed, 14 Aug 2019 06:30:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqr25o7qmf.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9Rnz21eP9N8I9knUBHgGt4EvzdTGhwdbA72Xc5C8iIBnG7bKe5x
 J9rAxkGlDxE7OFmXvk+mP8kIBiouOW5GMftv4vRBcN6Iqf+v442LoeNfA3NdVbB1hlp17Mv
 Lvyzlm1ZySpGK/AOOZz64/DtEsYZZn0n+WYAPWI72ltSru9DQUSOaHXhqLYnokFKu1MUPJk
 vczEnjBTZuE0ghMFWigKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bfmmEyGgCJQ=:RW47KZLObT2EUKfnQSzWto
 yWnwNYi7gQcg75ba28Yye/lpborNEKmzXwg/shm0T4ep1vX4YvyQWTl7LPawn6FzBeoVS3J0+
 yDvVUBhZ+rf35XOXKMzJdDfGaEbx+UdjP4KXF4AefATkOIKpHke7XbW7Cq9YV+0vrQ4w/A2Vf
 hs43BEz69M8d+cToZBTQr7wt8I6a97Ad4iQDVz21gNunOmIaXGt2s+RFGdlOjzZNMYNhvHOWi
 NRsgf2mRRUdQHtEAAZqTCmJDns5iccG4/GCVoRF1cZ7SUMhx1ePKX7WNGzHLkrRxZtEVA9Amp
 SjQrY181Hr1eaQQbvV+0T7T+LmVhsjVR+loXoGp2tVgk1RFzNplJPOueF56a7tNZ3bsHucnAa
 yg/zTU23tITGNrc6PnCAtYjv70EQ5DvZVb+fVfNK/fGQZXP1QeuUWEP8abH5E1J5YNJ20t5tF
 5vEhPx5k3ufONUSx6wNK2RSkisezwI1kKSd9xuTDTp71J8OjXQiRojy17CUhikgZNZRqihbNU
 wnpxVptwV6tPmDIWbGB7BGFzmcSfy3y09zUeL9Ax5MxEDBTlwHILfZyD58e6kuBBs98K66d88
 txo8lGvOBY34aFjMfOp+szMmDvzFp5ct1b8dcA4dNGGo777h3TViETjAtgqPfogFLxSeMbE7g
 8QEDmqanhcWQvqYGwnb+veeKmaOHwKnQIJDwc89cf98bEvqbyIZ35t88TMWzgp9inS5gz1+G7
 jM4gMOrEmWRYeAIKOD9A3TmPFq0HKLzEdvqlJL+gEOyasWm+JVC/tUS/efTW0RwTE2e8lLNNS
 dQKwEgerzNb0MJYNncjsBkg8KGqYgZHzeWzVjIdV0qdmmhWp8dWTRYtX2Y+odCmDjf32ehpiH
 4WfqJt5nbDUvspeNV84B08gJaQxFMZ6swYceZR1HhFXhsdHIpi1Bip7cY1HhQwskXKWMmc100
 M9S9A7lskgdPpp1OA5DLFVDIshgT8+telRP7s/lGpNGjkSnu+4uiMwqnHilXfkmtnjNHqKc66
 YQhnsT/BkoUzTKJhfoyf+YsQ4DAuMunfYaB97AfqXN3PWDPHlDG7nPc4uzvrN29meT+L7oX5R
 WY0RySqIAdXkpvrt9Qcboxkzo/5BdGgacyTJivHPbwpEShauMkhOOdtXfVctCAZoAeovCSLsF
 jwibsLkihqnnJJ/HwRSYXjFePLMyGGTB4VeFE47vWRKX4E5Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.08.19 um 22:32 schrieb Junio C Hamano:
> So perhaps
>
> +	!ce_intent_to_add(a) && !ce_intent_to_add(b) &&
>
> i.e. "a cache entry is eligible to be same with something else only
> when its I-T-A bit is unset".

FWIW, here's another way to express that:

diff --git a/unpack-trees.c b/unpack-trees.c
index 62276d4fef..a62d67d131 100644
=2D-- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1658,7 +1658,7 @@ static int same(const struct cache_entry *a, const s=
truct cache_entry *b)
 		return 0;
 	if (!a && !b)
 		return 1;
-	if ((a->ce_flags | b->ce_flags) & CE_CONFLICTED)
+	if ((a->ce_flags | b->ce_flags) & (CE_CONFLICTED | CE_INTENT_TO_ADD))
 		return 0;
 	return a->ce_mode =3D=3D b->ce_mode &&
 	       oideq(&a->oid, &b->oid);

