Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E5F41F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 21:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751027AbdCBVVX (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 16:21:23 -0500
Received: from mail-cys01nam02on0133.outbound.protection.outlook.com ([104.47.37.133]:31456
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751114AbdCBVSy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 16:18:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=R9hjZkUoBlvAZAvHtLHyZbTVrit7KI4UP9OJI5MdsvY=;
 b=GmWVLseGyEz6pgwbAxSwII9nNsWIhsLBlbSVn/f7L9MgvXuvbh1yjePd8dZ/x9boZBIzJ/LucVYTMMfi6n4Ri9UC/dvgrW/iu4jHyd2YiUs0rylgo5fp0NMzDobD1b5S6X1skdYEc367XaSNcxTd6T3AvDYuMuaMySn7SKhZCwI=
Received: from MWHPR03MB2958.namprd03.prod.outlook.com (10.175.136.139) by
 MWHPR03MB2959.namprd03.prod.outlook.com (10.175.136.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.947.12; Thu, 2 Mar 2017 21:18:41 +0000
Received: from MWHPR03MB2958.namprd03.prod.outlook.com ([10.175.136.139]) by
 MWHPR03MB2958.namprd03.prod.outlook.com ([10.175.136.139]) with mapi id
 15.01.0933.020; Thu, 2 Mar 2017 21:18:41 +0000
From:   Jeff Hostetler <Jeff.Hostetler@microsoft.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>
CC:     Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff Hostetler <Jeff.Hostetler@microsoft.com>
Subject: RE: [PATCH 0/5] A series of performance enhancements in the memihash
 and name-cache area
Thread-Topic: [PATCH 0/5] A series of performance enhancements in the memihash
 and name-cache area
Thread-Index: AQHShrXyB0sqhRdBvkSwHrNCSoEwwqFpDvAAgAETBoCAGAPY6oAAAWDA
Date:   Thu, 2 Mar 2017 21:18:41 +0000
Message-ID: <MWHPR03MB29581B0EDDEDCA7D51EC396F8A280@MWHPR03MB2958.namprd03.prod.outlook.com>
References: <cover.1487071883.git.johannes.schindelin@gmx.de>
        <20170214220332.753i4tgclm62er4f@sigill.intra.peff.net>
        <16b1259c-4cdc-8f4d-db47-d724386a3d2b@jeffhostetler.com>
 <xmqqfuivbcz0.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqfuivbcz0.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pobox.com; dkim=none (message not signed)
 header.d=none;pobox.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2001:4898:8010::ca]
x-ms-office365-filtering-correlation-id: 8d75adba-3f0c-4edc-bda7-08d461b1b377
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(48565401081);SRVR:MWHPR03MB2959;
x-microsoft-exchange-diagnostics: 1;MWHPR03MB2959;7:OTVIqPERwSPKXT1vg8CYxg87QTAdipUPR3JDoCsevKvvPWbl6UbadetNoN++YscgEg0+EgDT+KbjXBAq38YFnYknJglI4HEeOJUdpqRNQM0zrGrE2ntpFZigcudml1WLCPwxKPldu2o8bxpQ/Xxz8WDueR3MYK4dPiLZnr4JpKmkuYGHhnHFq2gnOhiKN9pwh/a4PCIrMlNSJaBTIq9pydBSagRTEpsHW5hD/YwfbVMG1ADyxKYe8sVtz4ctZrGyYP1VRA4KrXLblqHY7ni62ki8cHrmgaaZQGBdyipeJrRqmG0bMLkL0oFJA57aUE4VxEz9moQSNoVkk/IMjMeemHM5m2JthyWxL8wVCFlgWXE=
x-microsoft-antispam-prvs: <MWHPR03MB2959BE1FF52E5C30FF14D11C8A280@MWHPR03MB2959.namprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(26323138287068)(9452136761055)(189930954265078)(219752817060721)(100324003535756);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040375)(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041248)(20161123564025)(20161123562025)(20161123555025)(20161123560025)(20161123558025)(6072148);SRVR:MWHPR03MB2959;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB2959;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(7916002)(39410400002)(39850400002)(39860400002)(39450400003)(39840400002)(13464003)(43544003)(24454002)(377454003)(43784003)(76176999)(50986999)(8676002)(6436002)(81166006)(8936002)(122556002)(5660300001)(7736002)(74316002)(93886004)(2900100001)(77096006)(305945005)(229853002)(7696004)(33656002)(25786008)(189998001)(6506006)(8656002)(2950100002)(8666007)(575784001)(6246003)(9686003)(10090500001)(107886003)(38730400002)(53546006)(99286003)(3660700001)(2906002)(55016002)(6306002)(3280700002)(54906002)(6116002)(102836003)(4326008)(53936002)(54356999)(10290500002)(92566002)(106116001)(5005710100001)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR03MB2959;H:MWHPR03MB2958.namprd03.prod.outlook.com;FPR:;SPF:None;MLV:sfv;LANG:en;
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2017 21:18:41.0994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2959
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry,  $DAYJOB got in the way (again).

This is still on my short-list of things to take care of.
I should have something for you next week.

Thanks again,
Jeff


-----Original Message-----
From: Junio C Hamano [mailto:gitster@pobox.com]=20
Sent: Thursday, March 2, 2017 4:12 PM
To: Jeff Hostetler <git@jeffhostetler.com>
Cc: Jeff King <peff@peff.net>; Johannes Schindelin <johannes.schindelin@gmx=
.de>; git@vger.kernel.org; Jeff Hostetler <Jeff.Hostetler@microsoft.com>
Subject: Re: [PATCH 0/5] A series of performance enhancements in the memiha=
sh and name-cache area

Jeff Hostetler <git@jeffhostetler.com> writes:

> On 2/14/2017 5:03 PM, Jeff King wrote:
>> On Tue, Feb 14, 2017 at 12:31:46PM +0100, Johannes Schindelin wrote:
>>
>>> On Windows, calls to memihash() and maintaining the istate.name_hash an=
d
>>> istate.dir_hash HashMaps take significant time on very large
>>> repositories. This series of changes reduces the overall time taken for
>>> various operations by reducing the number calls to memihash(), moving
>>> some of them into multi-threaded code, and etc.
>>>
>>> Note: one commenter in https://na01.safelinks.protection.outlook.com/?u=
rl=3Dhttps%3A%2F%2Fgithub.com%2Fgit-for-windows%2Fgit%2Fpull%2F964&data=3D0=
2%7C01%7CJeff.Hostetler%40microsoft.com%7C1d493f3031f74657f29308d461b0be80%=
7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C636240859121403139&sdata=3D16R=
QH1%2BrDonsanClb3%2Fwue7pcy9l7cUq9lDJenqCgbE%3D&reserved=3D0
>>> pointed out that memihash() only handles ASCII correctly. That is true.
>>> And fixing this is outside the purview of this patch series.
>> Out of curiosity, do you have numbers? Bonus points if the speedup can
>> be shown via a t/perf script.
>>
>> We have a read-cache perf-test already, but I suspect you'd want
>> something more like "git status" or "ls-files -o" that calls into
>> read_directory().
>
> I have some informal numbers in a spreadsheet.  I was seeing
> a 8-9% speed up on a status on my gigantic repo.
>
> I'll try to put together a before/after perf-test to better
> demonstrate this.

Ping?  I do not think there is anything wrong with the changes from
correctness point of view, but as the series is about performance,
it somewhat feels pointless to merge to 'next' without mentioning
the actual numbers. =20

It might be sufficient to mention the rough numbers in the log
messages, if additions to t/perf/ are too cumbersome to arrange.


