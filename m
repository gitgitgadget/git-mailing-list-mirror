Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6131A1FF76
	for <e@80x24.org>; Thu, 24 Nov 2016 16:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757241AbcKXQK5 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 24 Nov 2016 11:10:57 -0500
Received: from mga04.intel.com ([192.55.52.120]:3814 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757195AbcKXQKy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2016 11:10:54 -0500
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP; 24 Nov 2016 08:10:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,543,1473145200"; 
   d="scan'208";a="8960717"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga002.jf.intel.com with ESMTP; 24 Nov 2016 08:10:53 -0800
Received: from fmsmsx118.amr.corp.intel.com (10.18.116.18) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.248.2; Thu, 24 Nov 2016 08:10:53 -0800
Received: from HASMSX110.ger.corp.intel.com (10.184.198.28) by
 fmsmsx118.amr.corp.intel.com (10.18.116.18) with Microsoft SMTP Server (TLS)
 id 14.3.248.2; Thu, 24 Nov 2016 08:10:53 -0800
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.44]) by
 HASMSX110.ger.corp.intel.com ([169.254.11.239]) with mapi id 14.03.0248.002;
 Thu, 24 Nov 2016 18:10:50 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "Greg KH (gregkh@linuxfoundation.org)" <gregkh@linuxfoundation.org>
CC:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [char-misc-next] mei: request async autosuspend at the end of
 enumeration
Thread-Topic: [char-misc-next] mei: request async autosuspend at the end of
 enumeration
Thread-Index: AQHSRj7WsbWcWoZfOE2E/htadCzu2KDoR37g
Date:   Thu, 24 Nov 2016 16:10:49 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B5433132E@hasmsx108.ger.corp.intel.com>
References: <1479987242-32050-1-git-send-email-tomas.winkler@intel.com>
In-Reply-To: <1479987242-32050-1-git-send-email-tomas.winkler@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_IC
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMThkYmM4OTItMWViZC00NDc3LTk4YjAtYzgzYzMyNDg3NzI2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX0lDIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE1LjkuNi42IiwiVHJ1c3RlZExhYmVsSGFzaCI6ImpFWWhhZTJkZUpLTnZQNE55TXlmVG04S1wvWFMrNDhIc3k1UlBHbjY2UlVrPSJ9
x-originating-ip: [10.184.70.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> 
> From: Alexander Usyskin <alexander.usyskin@intel.com>
> 
> pm_runtime_autosuspend can take synchronous or asynchronous paths,
> Because we are calling pm_runtime_mark_last_busy just before this most of
> the cases it takes the asynchronous way. However, when the FW or driver
> resets during already running runtime suspend, the call will result in calling to
> the driver's rpm callback and results in a deadlock on device_lock.
> The simplest fix is to replace pm_runtime_autosuspend with asynchronous
> pm_request_autosuspend.
> 
> Cc: <stable@vger.kernel.org> # 4.4+

Looks like git send-email is not able to parse this address correctly though this is suggested format by Documentation/stable_kernel_rules.txt.
Create wrong address If git parsers is used : 'stable@vger.kernel.org#4.4+' 

Something like s/#.*$// is needed before parsing Cc: 

Thanks
Tomas 

