Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE1771F453
	for <e@80x24.org>; Wed,  3 Oct 2018 13:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbeJCT7g (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 15:59:36 -0400
Received: from mout.web.de ([212.227.15.14]:43923 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbeJCT7g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 15:59:36 -0400
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MN43c-1g5SwY13ns-006dtT; Wed, 03
 Oct 2018 15:11:10 +0200
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MN43c-1g5SwY13ns-006dtT; Wed, 03
 Oct 2018 15:11:10 +0200
X-Mozilla-News-Host: news://news.public-inbox.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v2 0/2] oidset: use khash
Message-ID: <64911aec-71cd-d990-5dfd-bf2c3163690c@web.de>
Date:   Wed, 3 Oct 2018 15:11:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:HzAF+kT4FUDWWv6qO0mx1IYCy+nAd8r19h1uurDk+XUNPucVfsW
 eSYnXwGdlXs74f8dWi/O7fmCwN+xRntaOlC2oaXceDczkdLmKWVsr7La6W0FNHEqZIbF3An
 GYxhGeBlfcc1ru3sMf6VB1UlLLMQdC3Y0k+dTj8jxriFy6hBG5wcAidKBeOOtyqSKi+Wllj
 CArYNcAfLf/ysqpyooj2Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:e/m/NmsAByA=:s+dU4vV9RanS02qQTMNdBR
 q63c+rh1N9j2o6zFzq4qQu3q4A/Pf4poKg1MEe3y4+DTdxgV+cQSFp/AQD+Y555v6tYFq+EZZ
 IofWk68+Gvq6WhU/uMqROb+Om2sQaNWzUX7+7rtiE7uYx6NO2kzhQ63sMibRSDxOQRnPUFKPA
 6Io08FuXg5NCBWK1GvPgVhpUcEtCxk8Ah9PSvL1QoFIs3fHUhJBHUR8p01cV55S3EdpOZfY4u
 cW/thptoXxAFWxRyq0Q8CZFxbEvJhb55pTF5sRkgHVxoLdmUaZr9IOB8BfSs0c8MBaTcSwL/9
 CEkiLOmzUbEQGGHZipJsjEo9/z6KFtUzO4BQJDcKf79EUP4DUFtCzHzgGiTyrm30UWStW/m4k
 90KLmZf2PAUiJQiYke9XV7KG5i+h+vhc8gDm2q/tcNMzTPpT82LVcHdmaUxFFr9nocsnPMDCB
 oDkCcL39BkAFOfwAXk9f6X00py6EkY+nbwgPC2hV2oikClfL6o57sTR/s88TNDywkadC3TAMI
 NYq1o9ZcgWiFBFQ6tGCUyLt1FkJ3RROk9mx/9c06/ZA8he6MFaN/WWvgXNahthAqal39io3XL
 v0td/vb1G+FcVTRwWXCPgUGqS7B5C9pWL7A/MCOH/LIIumMspaaX+U58L9JuXYTI1dKkF/cXS
 gd2BELe9wAbaRlSd+Zl/A9hbI/3/98n2CGgC5PJxCCruR0kK0PV0D84ymDs8uG7Q6HBOmhJ5n
 0MrM9vxkahWdj6tojSRt9g1z68ay9WAi6NS9Xk5oYhf5pHOXjLmj7hDCaDU7tOViyk60BXcKv
 NXNDA8BX3951UUdHUKyq8Gxa8CWQ55d4Chzc//NqL/PYRiHh64=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Continue the discussion of speeding up oidset started in [1] here in
its own thread.

[1] https://public-inbox.org/git/20180811172350.GA2689@sigill.intra.peff.net/

The first patch does a mild refactoring to support khash structures
on the stack, and the second one converts oidset to khash.

  khash: factor out kh_release_*
  oidset: use khash

 fetch-pack.c |  2 +-
 khash.h      |  9 +++++++--
 oidset.c     | 34 ++++++++++++----------------------
 oidset.h     | 36 ++++++++++++++++++++++++++++--------
 4 files changed, 48 insertions(+), 33 deletions(-)

-- 
2.19.0
