Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C54241F406
	for <e@80x24.org>; Mon, 25 Dec 2017 17:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752511AbdLYRla (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Dec 2017 12:41:30 -0500
Received: from mout.web.de ([212.227.17.12]:51191 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751456AbdLYRl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Dec 2017 12:41:29 -0500
Received: from [192.168.178.36] ([91.20.60.211]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Marpe-1eEjxS1sQk-00KObC; Mon, 25
 Dec 2017 18:41:20 +0100
Subject: [PATCH v2 0/9] revision: get rid of the flag leak_pending
To:     Git List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <6ace4f8f-824b-2825-ef18-1fccebb9fb5c@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <ac4c77a1-6403-ca20-2021-50c99201915a@web.de>
Date:   Mon, 25 Dec 2017 18:41:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <6ace4f8f-824b-2825-ef18-1fccebb9fb5c@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:OcaktMI2UmtM93C/7cgRiulkF42nQkBaJO/PME2H/iqT62+2aXC
 a8+8MwcGPSxFx8WE6X2H0L0kbeziILetcguoNc17I0GnNTXCBgw+SEP8GnogVNZwZqCe9uB
 YTr0FSux98Rl97cPD2oVaMeP+8HhHBb9JlBw5lLg/qlC8wo/AO9FYSEpdFmIik0p4XBL4t4
 oODBqrEIeK/tNa5uQ0lkg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:r3wQOJ8nz7I=:wKlJzNTmgf6O3K7BwvYQaC
 RwN+D9ZQuCTxVW18Va3o7TfvhCr8PhIUmjbSTmz6BdbrlyzvO2wJLfZhM7BmuIe9a2yiixDvN
 Zuh2Dedt4FsB5UdiDTWswP3QyXlSXO05NFJ1f0c0lFhOQmIiCvrGkYEHzvWQmsXlK8ljFCro4
 2oHJkPi6Q8D6gKE50YmLiaXByumsAb2PPOH02ofE5r2+VBkjVr5gm/QEjdO1R0KbjWHjO283E
 yi+0rgjpbThHG42WNolnGRs11YmlF/HFDqXRRb3wCmz2rSJAzWUsj2rewVGx5ERWkws7qBdC6
 s2HkZihQZClHSwt4UODfNHmuVsybvb1h0CeZlrDkOZXqhzm/xhyZz/YGf1WPjq9BzbFHVyy9Z
 gUwONJunTiVTdpCVlcNU3hlcLfYJ7IkrQZgTxx/rL3tBoD3lvCvpzCZPJegALJ0AiVpeLNFK3
 vW0p9CqOXBmuJavw1dWORnldhzBnudlymNY1c965dWacJUf0qc6iwmziHp6qWloAVqy82TnUi
 p/JSiHOwSiWq72gxosXDhpPAlYiPhzNO7hN79JDXpNArXAmSzRFQ3XvgXrA/SQu9pV676HKYq
 I6RsC0zoof+xYOHMBG2NAs3dXzZ4hm2V9FADlu/dTck3wOn8ZIdEQkRCZNIgs98daKrrnRw/V
 SGQg4FalzkGZYLYsUj1irfhRUtor578xtZGtsOjXE8rDlxJJQR6HCxHUB4Ry/CKtcZLDVFkTs
 EIcDqerJTs3+sg4v01Z+QvsYlQsSXccZp8DfFUB9lZe4+1vB3avUf+U7nnpNvN0B3l4Kxof1t
 tnywPIIn9LLzY6ZQH2HvUKtgsPVraVcsKSdRTIev+VfNBSGl4c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The flag leak_pending is weird, let's get rid of it.

Changes from v1: Everything.

An independent optimization found while working on this series:

  commit: avoid allocation in clear_commit_marks_many()

Trivial unrelated conversions (included as bonus patches):

  commit: use clear_commit_marks_many() in remove_redundant()
  ref-filter: use clear_commit_marks_many() in do_merge_filter()

A new function is introduced, will be used by checkout:

  object: add clear_commit_marks_all()

The users of leak_pending are are converted to use alternatives:

  bisect: avoid using the rev_info flag leak_pending
  bundle: avoid using the rev_info flag leak_pending
  checkout: avoid using the rev_info flag leak_pending

Cleanups:

  revision: remove the unused flag leak_pending
  commit: remove unused function clear_commit_marks_for_object_array()

 bisect.c           | 30 +++++++++---------------------
 builtin/checkout.c | 13 +------------
 bundle.c           | 35 ++++++++++++++++-------------------
 commit.c           | 19 ++-----------------
 commit.h           |  1 -
 object.c           | 11 +++++++++++
 object.h           |  5 +++++
 ref-filter.c       |  3 +--
 revision.c         |  3 +--
 revision.h         | 12 ------------
 10 files changed, 46 insertions(+), 86 deletions(-)

-- 
2.15.1
