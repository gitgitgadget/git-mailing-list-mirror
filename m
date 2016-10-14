Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23CAA209AE
	for <e@80x24.org>; Fri, 14 Oct 2016 06:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757000AbcJNG4H (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 02:56:07 -0400
Received: from userp1040.oracle.com ([156.151.31.81]:39848 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756910AbcJNG4G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 02:56:06 -0400
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u9E6tXL4016695
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 14 Oct 2016 06:55:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.13.8/8.13.8) with ESMTP id u9E6tXkJ012906
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 14 Oct 2016 06:55:33 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id u9E6tVUd018619;
        Fri, 14 Oct 2016 06:55:32 GMT
Received: from [10.175.163.23] (/10.175.163.23)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Oct 2016 23:55:31 -0700
Subject: Re: Huge performance bottleneck reading packs
To:     Jeff King <peff@peff.net>
References: <20161013152632.ynsabbv3yrthgidy@sigill.intra.peff.net>
 <d727ee5d-5f0f-e6df-3f83-35fe74641ace@oracle.com>
 <20161013204351.rezqssvw63343l4g@sigill.intra.peff.net>
Cc:     git@vger.kernel.org,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Shawn Pearce <spearce@spearce.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= =?UTF-8?Q?_Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <0e4173b6-8fbb-4223-b061-524c7ebfd4d7@oracle.com>
Date:   Fri, 14 Oct 2016 08:55:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20161013204351.rezqssvw63343l4g@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Source-IP: aserv0021.oracle.com [141.146.126.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/13/2016 10:43 PM, Jeff King wrote:
> No problem. I do think you'll benefit a lot from packing everything into
> a single pack, but it's also clear that Git was doing more work than it
> needed to be. This was a known issue when we added the racy-check to
> has_sha1_file(), and knew that we might have to field reports like this
> one.

After 'git gc' (with the .5G limit) I have 23 packs and with your patch
I now get:

$ time git fetch

real    0m26.520s
user    0m3.580s
sys     0m0.636s

Thanks!


vegard
