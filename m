Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E7EA201C8
	for <e@80x24.org>; Sat, 18 Nov 2017 18:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423193AbdKRSBe (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 13:01:34 -0500
Received: from mout.web.de ([212.227.17.12]:64298 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423188AbdKRSBc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 13:01:32 -0500
Received: from [192.168.178.36] ([91.20.49.242]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M8iLA-1eSBiA2xga-00CEAe; Sat, 18
 Nov 2017 19:01:22 +0100
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 0/6] show non-empty lines before functions with diff/grep -W
Message-ID: <790c2344-a71e-7089-9000-f9b37a4a5cd9@web.de>
Date:   Sat, 18 Nov 2017 19:01:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:vWgLao+dbKkfGaZ63Y7pW7YL0zviEjK0VV46jibk3N1OKHwzumS
 Cs0c+q/VlT8RxANK3vVZTmrgBegP8VBbbobFxWtGe8mnpb99KtNGX0hLiLt46X+BLREhCYF
 VQ2/v3tmk+sCjxjGNbUCYqo8khZVhbpVWJWeEqd1+T+qT7GxJv4vekTA3I5cgiLneXGo2Qy
 vDBsU15OvnD9qkqEHc5hw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xYWTo+4SOQo=:BP9kS2SBgVJEfyai9PeHAb
 VkP38nqVuMuNUZwTSZbJtGJELhnyULwdFzIZS4OVCsKHcjpBdWTZrsXZtAsfdK+qq6AYHdQUx
 3s9qZCZ3JZteLLThQN6kPq3P7ZOYe0Bh16EHPwFX/y+aKcmDKE9klVDqGxBEfq1cWl1T7CQEt
 5/ao9ls9ohVKv4hzt5GM1jS47PJHz5Q03+CsWuQglF0qgQ2Rd4C/5+Qs0Rt6NUwb75Qk6ZCNe
 t5cg5dhOxZx+H5pRwLUsQjDKYaViVNt1zwUwE7Qshbv5775PL6F+0P7bhjchJwXs2VaI24GiW
 c3K7s4bklghCk2ObOqb2sx7fjLgTpHluQsmoOxxeKxGqi1p6d48Ww/fQ19dLyvSjSdhhUvRgM
 NdGgHvxwUrZpUx5bP9ywcHBteMGyBcQ0p/PKMG0eRNQrLmhLtpr/xEH/xihVRJsUjBmdIOb6p
 XC+K2IOH/olscXltvWCFpuHRjX01R8/3/GwxdLXo7O0nmRwLXvaWQZKk5s0jLu+/ToYHBmNUB
 I/lBxpDBWoKr7TDP4gk5wl4ujQvY+oR9+6HRQ+s+7wJBh6unqGFeYeLIfaWearqJ1arPNEl+z
 hEmiryGs/Rs6xa7DQbHpTb9dsVnlmxxkx0Y5iER6lSgOFIjnCk5f7frrW1XEpKu4VEK28BtGH
 MDsML3tDNo3Uk0KV0bC+HWnSqL2xZPpxniPSIjLlpcvhEvDuDZoyfTTd2dJZjbf6vrXpJcxlR
 18dL26OhubHeWZFEUjYbrJ+lCFrTc9T3Fuirb+UjzhqtEgSXiFfgYJky67JcZEgpa5SjI9wBs
 am01/mGaDaDFTez0LMQ7sd5t8F+vW20hSeZZU+vHVgJWH3rSD8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The option -W/--function-context lets git diff and git grep show the
whole surrounding function as context.  For the sake of simplicity and
performance they don't fully parse the files, but as a heuristic show
all lines from the preceding function line to the next one.

This series refines that heuristic and extends the context to include
any non-empty lines before the preceding function line as well.  They
most likely contain comments related to that function and are thus
relevant for reviewing diffs and search results.

Idea and original implementation for git diff by Vegard Nossum:
https://public-inbox.org/git/1484324112-17773-2-git-send-email-vegard.nossum@oracle.com/

  t4051: add test for comments preceeding function lines
  xdiff: factor out is_func_rec()
  xdiff: show non-empty lines before functions with -W
  t7810: improve check of -W with user-defined function lines
  grep: update boundary variable for pre-context
  grep: show non-empty lines before functions with -W

 grep.c                           | 35 +++++++++++++++++++++++++++-------
 t/t4051-diff-function-context.sh |  4 ++++
 t/t4051/hello.c                  |  3 +++
 t/t7810-grep.sh                  | 41 ++++++++++++++++++++++++++++++----------
 xdiff/xemit.c                    | 13 ++++++++++---
 5 files changed, 76 insertions(+), 20 deletions(-)

-- 
2.15.0
