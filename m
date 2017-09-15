Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C786320281
	for <e@80x24.org>; Fri, 15 Sep 2017 18:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751423AbdIOSTC convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 15 Sep 2017 14:19:02 -0400
Received: from mail.greatergiving.com ([208.187.18.38]:26139 "EHLO
        APVWEB37.auctionpay.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751201AbdIOSTB (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 15 Sep 2017 14:19:01 -0400
Received: from APEXC04.auctionpay.com (192.168.2.11) by
 APVWEB37.auctionpay.com (192.168.2.17) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Fri, 15 Sep 2017 11:18:58 -0700
Received: from APEXC04.auctionpay.com (192.168.2.11) by APEXC04.auctionpay.com
 (192.168.2.11) with Microsoft SMTP Server (TLS) id 15.0.1178.4; Fri, 15 Sep
 2017 11:18:58 -0700
Received: from APEXC04.auctionpay.com ([fe80::4d53:2f59:1dec:ea9d]) by
 APEXC04.auctionpay.com ([fe80::24ba:89c:65c4:8a2c%16]) with mapi id
 15.00.1178.000; Fri, 15 Sep 2017 11:18:58 -0700
From:   Wesley Smith <wsmith@greatergiving.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Is finalize_object_file in sha1_file.c handling errno from
 "rename" correctly?
Thread-Topic: Is finalize_object_file in sha1_file.c handling errno from
 "rename" correctly?
Thread-Index: AdMt6BzgEtMQTdVEQOO+ofsy4hJiUwABtU2VABe1cCA=
Date:   Fri, 15 Sep 2017 18:18:58 +0000
Message-ID: <07c6a131ef4b4a92859d59d1dc2cde86@APEXC04.auctionpay.com>
References: <c9b3bc17110048f0b7943704cfbd8f68@APEXC04.auctionpay.com>
 <xmqq4ls4xxok.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqq4ls4xxok.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.12.77]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Brightmail-Tracker: =?us-ascii?Q?H4sIAAAAAAAAC12Sf0yMcRzHfZ/nueu59Nhzv+rTLeFBmrpkSRFLrK2xWTZj?=
 =?us-ascii?Q?HcmV093U3e2eOy7+aTNmJy39VzYuTqMxLZpGkmNKpTgJUU1kJLEzP0bJ89zz?=
 =?us-ascii?Q?lPL96/V9fz/vz+f7/u5L4oqWIA1pcNoNNrO+gJEGE80XsNna8vDGrPiPH6qG?=
 =?us-ascii?Q?Zcmu7uNYcvGJbnwdlvHYtzDja11kJqaTmMy5FuduifG+z49ZPeHOwc7bRDG6?=
 =?us-ascii?Q?q3KhYFJB1yEoH/DgUxv/qxtSYdOEYLD1vsSFZKSU1sJt9xGCZxUdBSePegOM?=
 =?us-ascii?Q?08vAP9aM8ayks+Gl/5NEqNkFd7p6g1yI5Hg1HP6i4mWCXgzdRz4HSig6HX7V?=
 =?us-ascii?Q?TOA8K+j9MObtC+gyOgVGf76X8ozoUPjRdgkTRoVB79szAQY6Bq4PN0kEjoW6?=
 =?us-ascii?Q?nhpC4LXgKfXhAtPgaewSmYETL0dFrxo+vPkjeuPg6Q03EngLlLQ+ETkRRjw+?=
 =?us-ascii?Q?sWc81J9vEjkBas9NSCZntV4eF/tvgJ/1z0V9Hkz0DxB8dKDT4HmnWLIAyoYe?=
 =?us-ascii?Q?iu0zobOsK6gMJVZOSyZwLLhv+qUCx0B11Ue8MvBacnhQ8ZZwI6IGhaVlbtue?=
 =?us-ascii?Q?vj4hKU7vyLObLGarviguz1JYh4RPIW9AtWM6L1pFYoyaCpE3Zinm5Fr2FBn1?=
 =?us-ascii?Q?rDHH5igwsEwktamjIUsRNiWzDtZqyjNZHGyOw1bgRakkyQCVDZxXbjPkG5x7?=
 =?us-ascii?Q?TQXczxPtCyin/WaWQjP95P8OGCnzoiQyhFFR6XwbirXqC1lTvthiLuXmbxA6?=
 =?us-ascii?Q?qc60t6EUTRgVwftovsLoME9N18ynejZx08OnHcx0+5Bao6Sa1Zw7xGqwFZrs?=
 =?us-ascii?Q?grMXKcnXmIIwW8wGDfdWs7gVjYZRIokYJbWBnxZiMtv/XTKCushfUi2KM6cM?=
 =?us-ascii?Q?c+kwLl1HewOfzq63T0833h5IJ6oznZpitEr9buNmV8vI6Ypy3SH/ge9LtMsX?=
 =?us-ascii?Q?pq64uiT52PWIxXtKY1Zq5bbY0T5dwt6I8a2tO/cN/fb6KhdFbTc/QoP96pyx?=
 =?us-ascii?Q?F7hbV/jmyRV/9bWdslt5pfX32oihNcYHPUSSsT7pfai2UZK+K2p2cKoqesWt?=
 =?us-ascii?Q?kZKjp57t+HYwLl5Zy1guegfPzmUI1qhfvhS3sfq/QA4/vFoEAAA=3D?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio,

Thanks for your response.  I'm glad to see that you've been able to understand the problem.  I'm working with the Windows git team to properly return EACCESS when "rename" fails due to access permissions, but it also sounds like there will need to be a fix to finalize_object_file to better handle the case of an existing file when renaming.

Wesley Smith
T: 503.597.0556 | WSMITH@GREATERGIVING.COM

-----Original Message-----
From: Junio C Hamano [mailto:gitster@pobox.com] 
Sent: Thursday, September 14, 2017 11:51 PM
To: Wesley Smith
Cc: git@vger.kernel.org
Subject: Re: Is finalize_object_file in sha1_file.c handling errno from "rename" correctly?

Wesley Smith <wsmith@greatergiving.com> writes:

> 1) This bug is triggered because "git fetch" is causing a pack file to 
> be written when that same pack file already exists.  It seems like 
> this is harmless and shouldn't cause a problem.  Is that correct?

The final name of the packfile is derived from the entire contents of the packfile; it should be harmless when we attempt to rename a new file, which has exactly the same contents as an existing file, to the existing file and see a failure out of that attempt.

> 2) It seems that finalize_object_file is not accounting for the fact 
> that "link" will return EEXIST if the destination file already exists 
> but is not writeable, whereas "rename" will return EACCESS in this 
> case.  Is that correct?  If so, should finalize_object_file be fixed 
> to account for this? Perhaps it should check if the newfile exists 
> before calling rename.  Or, should the Windows mingw_rename function 
> be modified to return EEXIST in this case, even though that's not the 
> standard errno for that situation?

The codepath that is triggered by OBJECT_CREATION_USES_RENAMES ought to behave correctly even on non-Windows platforms, so bending the error code of rename() only on Windows to fit the existing error handling would not be a smart thing to do.  Rather, the rename() emulation should leave a correct errno and the caller should be updated to be aware of that error that is not EEXIST, which it currently knows about.

Thanks for spotting a problem and digging to its cause.

This is a #leftoverbits tangent, and should be done separately from your "OBJECT_CREATION_USES_RENAMES is broken" topic, but I think it is a bug to use finalize_object_file() directly to "finalize"
anything but an individual loose object file in the first place.

We should create a new shared helper that does what the function currently does, make finalize_object_file() call that new shared helper, and make sure finalize_object_file() is called only on a newly created loose object file.  The codepath that creates a new packfile and other things and moves them to the final name should not call finalize_object_file() but the new shared helper instead.

That way, we could later implement the "collision? check" alluded by the in-code comment in finailize_object_file(), and we won't have to worry about affecting callers other than the one that creates a loose object file with such an enhancement.

