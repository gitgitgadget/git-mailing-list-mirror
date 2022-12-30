Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8FFC4332F
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 21:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbiL3Vvf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Dec 2022 16:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbiL3Vvd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Dec 2022 16:51:33 -0500
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959E216593
        for <git@vger.kernel.org>; Fri, 30 Dec 2022 13:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1672437084; bh=y65xaPDtoDqmvwjqzkptmZdohrFKxrvviK/Gvg4yYIw=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=sXsgC9CJUZSWGrdgblFeqAviY9gWdp+DgTddzTV8BBz4d8x4KRBwcz+qf6dkca62w
         jYn2u749m95+2nba76oUv5pXrV/fXBFZE029BTlAtQnvu75hugbEFX8765VEUneJkS
         BhEaJXOoTd+e3YKc4BxWyrp9q18aAMqwWPMixId6gmh95CszjjbPRGMShBL9h7rofp
         GTAeZE2zDO7dNlah2qjgw4MBRBLS0H3XxyZxxW3el0DclMg3zr0NPgRX4TvA7c5KZV
         I3MQGRRTXvLo8TvyjTY14hvimQKu9AkGBBAq9r3zOB/M5IZQwFgPF+l3zvzeiUUuOI
         VA0Gy7LdKKhig==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N6JxT-1omyg91bUf-016E01; Fri, 30
 Dec 2022 22:51:24 +0100
Message-ID: <efe7ec20-201e-a1c1-8e16-2f714a0aee8e@web.de>
Date:   Fri, 30 Dec 2022 22:51:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 0/3] COPY_ARRAY, MOVE_ARRAY, DUP_ARRAY
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/jSwgKdcCnIPNm3cY5Tn4UvZAqppiCWPhnimd9fto2mS/ms/vNV
 rikdGv9opDNGXEGKF4ZiTHpd5IA79yW40ZsGHfTujvo8ctEzREslzt+4ueXc45bfyoDzCal
 Z+kBJaUERzCq7Ld/bpxjTR8Zhe3pRszdHn8LTVgzYCRSSg80SrZXkks4JnShUS4fMWBrO2t
 H+YvqqlFZe8OZwjm3Nhuw==
UI-OutboundReport: notjunk:1;M01:P0:B91LhAxMVT8=;+w3tVXQ3i/7lRmwNt8GSIe+XfXr
 tJC+IGw85rOD0wnFLIlmdph8ayOJ4djQrlrEx8h2Q9gQUZRXUpMHlkQs1yamWFKRl6FoVnZ+9
 zWTB3BsZ5EpSzS9psEGnDSemaj/Hk27Itqg43L1C/JCIvfTEcwxhzK0NBxjs5pboek1nNCMzE
 pqDRPS6d6+lQvEFbChl7qa512nyLmz5LHVXKi9Xg2mN/Td5gIXq3Tenj2y978FDGZeoa2CxRH
 NxyXQovqPbQhOzSwPWPIlqBKQuLs0w1HqiFMPsYExdVBUvYtk+p+4SIQayLooKsRQLYGPUM9e
 EzR2wJkHHIZeBV2FfEbv7snuWl5aUN58OTJlD/2mYjFelUMgqkEu+CC2+WgV7gkOwLloR5Nw/
 PvK5RtDdEQBLmALyZrhOfV3G01aNber+suJudw9H9ugKzqsSiQDrZcv9IWJ6Fo+sDFHjaZo7w
 gL9OoY9wOsVfQsI5sQwNjAGotcsplJg7NDcabhjQsn2w9DK7wCoAIMytY3SyWDEpZ31U2Tz9E
 k4EdIIJBemZPXQNworRlbXUTo7ivSNhBeQpEFqKcrmRvhGLE8J8zDmp/vtmbZsfajcRN5538C
 DzTdxFSb0GLlYNhoVrhPOTS8RKUe0Spj2xwUa6Xl/kDjTSifhtq68ivEjYVL9N+TAKuwmxc9g
 CmOHeijSepLOJ7niESPJRQdT5VSDiUv2rZPnx/nDEfcqwPCgUeQge2nGRy3iWAAzCIDdTeKr4
 /mnS3euK817ql4S6p7xxms8V5XNG20WjWimoB65GTolrCewJsIzwwIwe5PZTqCsqfs1sM5PGT
 kB68gSdU/MglzkdL4H4d4ZzHxBIFB6A0Y7Fc72iyeXzJT+uLe3hNWg4rmGV23X0ItymFe7Dr9
 v5tyG6v2spvgXSN+GM2v52dYpx9mWpVHgIR9Zy/JiFne1afWcU76FEBJ9lqU7kTZpDVADJTD8
 aYtmtg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tighten the type check of COPY_ARRAY and MOVE_ARRAY.  Then add DUP_ARRAY
for making a shallow copy without repeating destination and element
count, which inherits the stricter check.

  do full type check in COPY_ARRAY and MOVE_ARRAY
  add DUP_ARRAY
  use DUP_ARRAY

 attr.c                         | 3 +--
 builtin/am.c                   | 3 +--
 commit-graph.c                 | 3 +--
 commit-reach.c                 | 3 +--
 compat/mingw.c                 | 3 +--
 contrib/coccinelle/array.cocci | 7 +++++++
 git-compat-util.h              | 7 +++++++
 parse-options.c                | 3 +--
 pathspec.c                     | 6 ++----
 9 files changed, 22 insertions(+), 16 deletions(-)

=2D-
2.39.0
