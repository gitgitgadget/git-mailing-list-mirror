Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10ACA20188
	for <e@80x24.org>; Sat, 13 May 2017 15:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752010AbdEMPzQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 11:55:16 -0400
Received: from mout.web.de ([212.227.17.12]:54864 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750935AbdEMPzP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 11:55:15 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LfAoO-1dpTmO19Eu-00orNu; Sat, 13
 May 2017 17:55:08 +0200
X-Mozilla-News-Host: news://news.public-inbox.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 0/5] p0004: support being called by t/perf/run
Message-ID: <9b574d73-8dfb-f0b3-dc3e-d593726a8f0e@web.de>
Date:   Sat, 13 May 2017 17:55:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:ZEZjTHRHccYLob5sJfjEicCeiEYixolTqZmwV9GE7nhpUZh58NQ
 YKvWOqlP/ZZ+keA3PFX05lu/uR6qonjSmXyk9Qv7sByYhu4qjaygV7nxm8QCOX54C/2DUNX
 0ieeNdNyZKdjwje7eiDHizNhJqe+pEb1Ffs+D6GfntUFQU0HfYutwldddEcygGXF1Pn+pMx
 Gq4obiYyrYf9oRj28axVg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MDdtGOskgOs=:9y8LfVLLc8q12dJZfaLnSe
 5P6Lnig3DpW21cUAXGqHtNCMVeq9U2GzvR2j/yN7XbDkRGhJv+/FohchYt5as24Zc9j7Xsa7h
 0o/0wPwE+4YVbm3PVURFcWz1URHzhMYldxYLj4LIkiyZ1tRq0zxcyxdJ4CtVs8/uYb13QO8KO
 rgkQjQugtl5AcfPDciQt+p4Ogr/jdRMQUdYRQ4kayYqhoNznM2D8eFX9/mdSCRQMAgqDtSMZf
 mtFGzVR04LkzCSG1x+F9zXSpFYJ6IPt1xzhK3aDrSNLZ84f8ILpOVI5Uxq1m+y8949ZZrg908
 fJfc0hxYSc6OgREIgah/1KOFhs+50V98IgpggpzI0o5TBzjo1tb7ImTvTORWWGTuyz0ZIcaii
 3AmoAyYYO2/yR06pmkX4nETK/c4lDt+YfaXnkHKA1yKPZbmXP7mHFJM1Y9BTQ9UPgpxb0Z3hR
 pCrlZ5kshgV9ggZjeqLwOelriydbCY4kGQ0jPmxfSTKCVQLRArCudkRVFUiOAhsSvSUD6Jhmj
 Ky8GWWDttyNDEuVBQ4jNcxS00YS0aUDZcFkHOTekRT6ia3tS7ilGWwYeZeS8zj9WWbq5Xf/qz
 h5/OXHXeLIbgFEaefVjPCzLzhwucSrmJYrL/gyOhHlBdvFpuDQeKFCnjMO+DXI/RiO501sm2p
 VYCLTOw2/IoxpQwhUZ+Iq6aAdRnnY0sXxddi7GT5VwswF9+SpREjCX6bp+ggNgUqFN/ooKfuH
 Jo8KonL9BRUnQZ/26n3dyTHSGuCBszTcz/8/mc2z3flSVJ9/umlU+FwzoVEJCRG0+9f0MpqXv
 W02KzIk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

p0004-lazy-init-name-hash.sh errors out if the test repo is too small,
and doesn't generate any perf test results even if it finishes
successfully.  That prevents t/perf/run from running the whole test
suite.  This series tries to address these issues.

  p0004: simplify calls of test-lazy-init-name-hash
  p0004: avoid using pipes
  p0004: use test_perf
  p0004: don't abort if multi-threaded is too slow
  p0004: don't error out if test repo is too small

 t/perf/p0004-lazy-init-name-hash.sh | 47 +++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 5 deletions(-)

-- 
2.12.2
