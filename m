Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C25E11F403
	for <e@80x24.org>; Tue, 19 Jun 2018 17:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030229AbeFSRZb (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 13:25:31 -0400
Received: from mout.web.de ([217.72.192.78]:60419 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966693AbeFSRZb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 13:25:31 -0400
Received: from [192.168.209.18] ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MOzsZ-1fb5HO3Kel-006Mah; Tue, 19
 Jun 2018 19:25:26 +0200
To:     Git Mailing List <git@vger.kernel.org>, max@max630.net
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: t5562: gzip -k is not portable
Message-ID: <5ee7a65d-63e1-aa6a-c3c1-663c092d0efe@web.de>
Date:   Tue, 19 Jun 2018 19:25:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Provags-ID: V03:K1:HhJarf0rjm0JvXiPpEufKiak4G6p3Rfi+oqG12sIKzjd9+g+4YF
 iofTjeDcU4phgMUhGepl0JN8n5QtEcCe8q/GJeWbvDSaXtY8sXJkxLZD3G8rj/N9vnfVLoP
 D/LLdZXcYkZ0TM93PoIUMioit2vp7VOdWQWZjvCMrCmW56wT0iBMvCNIY/c+6SXekUw8pKv
 geyIMh1r2LpoBfmipj+Sw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ypPk92PDung=:4IRci81A4suA6t0JDX4ybT
 G6rkCvmBwTuun62a82m/lu6h+yJvR/HGDb3Z0LaVZN7wltBSFMCZKjx/t7kBj6AlfP98JReCg
 bGucrokc2xKEW6rAKB56rzz0khWvp1zj2oDbq3xSMNxJvzxaJ6zzcJcDVORUl8tdCuWv8mF3X
 dt3fat8+EjfUbFGVi8ZsVpdQRFqJC2aPpb/mg/8pw0u1Joqa45ObZm1fnnKFOIdWr2JnK+3QS
 nrv5DfJe9FxhIetYL3n+PcIDFD4Xp9uODVt9UyyDYGOGetxXu0LIvKh2QpHMef8Tw12hc5yes
 hDAIoPi/69fhTQMqniaCKhzfFd5oHE2bfekEYjsyyoLwvR9J3QvhoohXCA3L6A6Oar9suZLMA
 V5gdvrs/fN8wSgq4xYkO/bak6gCquu+X+JDpdNnnpyyjHrAV7BKie3mbRPzTFZg2OOqGOTB/G
 VD3P0qoBO1rp6zNvZxbvYOvrmieV3oolKP7OMsS6fBt+U+U3nTycHaJBFbe4iW/O6vvROCudS
 0zesV6pgtRVRYnzt9cboZVVVo16o0uQi8fC7iE5yhHTD24ybG3uvfrxPX59xVHDdL0S1EiL6Y
 BXWEJJVtGMlr9O0kFkB47o2/Nkw6X9MAPbxJ1jYMbj8uLWVxy2Ww3XvGZrFdGANd0QI8qHpy1
 eIJqimIecLhCfJDtmV14ylSZuOQhH5Mu0cSuB0aH8z47rPbazDsaNUGDbdhv+6XwTZCq0UAr5
 DkV9A26+XXNZwrOw83j0FwT6hZuOKEIGyniE7R9Vv2qfdKp4qJYFEQRsd3N9VyfRnvG2phcvf
 worvNfo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hej Max,

t5562 fails here under MacOS:
"gzip -k"  is not portable.

The following works (there may be better solutions, I didn't dig into 
the test code)

diff --git a/t/t5562-http-backend-content-length.sh 
b/t/t5562-http-backend-content-length.sh
index 8040d80e04..7befe3885c 100755
--- a/t/t5562-http-backend-content-length.sh
+++ b/t/t5562-http-backend-content-length.sh
@@ -61,9 +61,13 @@ test_expect_success 'setup' '
  '

  test_expect_success GZIP 'setup, compression related' '
-       gzip -k fetch_body &&
+       cp fetch_body f &&
+       gzip fetch_body &&
+       mv f fetch_body &&
         test_copy_bytes 10 <fetch_body.gz >fetch_body.gz.trunc &&
-       gzip -k push_body &&
+       cp push_body f &&
+       gzip push_body &&
+       mv f push_body &&
         test_copy_bytes 10 <push_body.gz >push_body.gz.trunc

