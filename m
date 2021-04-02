Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC7EC433B4
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 21:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2054A61177
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 21:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhDBVjT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 17:39:19 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60062 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBVjS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 17:39:18 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 132La2fk008142;
        Fri, 2 Apr 2021 21:39:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=5oSiASt7GmVoVap/gt2W0fudrrvvfFPLz61bd9kcnMY=;
 b=XJGrNxr6MbdAduAy0Yhjs1qJA6Xt0G3BTOjJfJjY7zVFfSpfSRLQXjX7vNeWXLl7XaV/
 wImudcsQYY2Vm5iP/gW6muaFwN8423WP3Ec0BAGEOPT0WDIXY6VjKcHe3BpkQ0r7jP71
 d1oNw/13NDvDtchuvlh4VnvNHHHjUQGuKqkXYY9u+y7l9Xoq87QporEB7p7gxsBswkfP
 H57lEtfJUwEFh1lyIiTJ9vPnIUW3MYxJSvPvN2L+JI54/nF35i96oQHV3HL3eRk2ZzcM
 8+0fm0tBK1mrUSeCEgQBIv8Ah5L2dqKfNfJ+/8f8pgcEFxmQG9tZvqXJD6wZuLDTmbIk Sw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37n30sdjnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 21:39:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 132La2N5137496;
        Fri, 2 Apr 2021 21:39:12 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by aserp3030.oracle.com with ESMTP id 37n2atu9u4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 21:39:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQdztuvtx+VLLjER3vz8Ttpr+48YwlKOrCbX1Fl8Ku/AJumbeeNU+nqyM8DJpkXDo757H8hrk89PlzqqRVFeuMvsS5VCZXE3ZWhY4Hgk2eTJXq8LV7Aj0BybyjKYZ/2ageOPHJY+wcYBb4XyBMUzWzSn3fVjgbohaso0KcZpMSF5r8Eof3DNYcX5/yFAFufeE9U3mZAhBec8ilMxUzifNvhQxA8gb1kRCKP4njAHxmAoUIILsofz4oTvvToGHzIoE/YVsJqTIIn8kacWiJtc1Gn+ZJV1tqOnNkHX0AbsQ/92x4HALr7m3gn8sPqXSeiiSJ2dfHY9eL5kO4Zd889cDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oSiASt7GmVoVap/gt2W0fudrrvvfFPLz61bd9kcnMY=;
 b=Hw0NQLZHbRXs4PQrO9Xl8IUlYpAFrt7uiKXtQmfN/RsHga/g82IU0vAIB5xD9XAOw6uJdEtZu9moGMrkix9824Oisbmo9L+1PJro6jvwDi8p5KfGn/hUWLcfpog6MKCXxpoUkqP+XomOkkpVd6cDbkwc7kGIHE7itt3a7bO/L77IdnI12+3MrElCwtoo8KV0k9Q5O5bFT0Cj2dcszugVBB1dXvLr+lJ1xakbWZRtoyt8PWk9JfFWus9mRA1yHUByhIXljQe4mVz7ihfIRrpUyrZDN5ad/qBUrFMQM/rRv5JC8WtgpgIwamp4Kkkxu8jV/IMrdexRhnUf5Mmu5xrtJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oSiASt7GmVoVap/gt2W0fudrrvvfFPLz61bd9kcnMY=;
 b=blRkOB2O7kbiFXZi0GMDt/axESMSNtktZPIhgAnKkP4PoR2+mMfGtAPkpxN2neo1nQ4KpymNRtc85IsBicIILgBPmuM6Y1jIdIAbC1wjdu+7Sj/K4wP5tIncVLvNueRqtmQNNI77oqoaNX5QeRaXHPRBgl5xNBth5GSc6Nm4SjM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by SJ0PR10MB4797.namprd10.prod.outlook.com (2603:10b6:a03:2d8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Fri, 2 Apr
 2021 21:39:11 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978%5]) with mapi id 15.20.3999.029; Fri, 2 Apr 2021
 21:39:10 +0000
Date:   Fri, 2 Apr 2021 15:39:09 -0600
From:   Tom Saeger <tom.saeger@oracle.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: should git maintenance prefetch be taught to honor remote.fetch
 refspec?
Message-ID: <20210402213909.zuyyqqisvq7gjcxo@brm-x62-17.us.oracle.com>
References: <20210401184914.qmr7jhjbhp2mt3h6@dhcp-10-154-148-175.vpn.oracle.com>
 <d246df21-fdaa-a391-847a-e03e8e664af1@gmail.com>
 <xmqq8s613gqa.fsf@gitster.g>
 <3bfd9a88-10f9-df71-bf96-f9c5654e48eb@gmail.com>
 <20210402182716.trbaflsjcvouff2y@brm-x62-17.us.oracle.com>
 <41dc2961-7ba5-a882-3416-45631e2cbb33@gmail.com>
 <a4cf3e48-aed5-ba1f-298d-1f2cc2359be2@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4cf3e48-aed5-ba1f-298d-1f2cc2359be2@gmail.com>
X-Originating-IP: [129.157.69.42]
X-ClientProxiedBy: SN6PR16CA0061.namprd16.prod.outlook.com
 (2603:10b6:805:ca::38) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brm-x62-17.us.oracle.com (129.157.69.42) by SN6PR16CA0061.namprd16.prod.outlook.com (2603:10b6:805:ca::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend Transport; Fri, 2 Apr 2021 21:39:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e540c5a-e19f-4857-a254-08d8f61fc078
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4797:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4797DB901ABAB63A7BF48B4DFC7A9@SJ0PR10MB4797.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /zqz9d19wmR5vivCf5C1oMv/eoGP1UgKSWO51jAU4qKY9kYO/1yrPkAd684QjSI1EEY3A0W9OcE6oTK0z253gmnJso8htQeDbZjkVKCk+iNI1JuukuAjK1Pxt8finCg6ex6ow3YcQud36Io/ZFJrGOrBdvOUXLoBrpC2dw7wSz1wK9L2OFU8nu4ihXBSbcHJ2IWKk46dbpfXvzRU9QSUoVUNegeEeTWXQoKrLqkxbzQcOJfqpeZA6bd/GgpXVubDBq/tckWEz4XlBX/vUOLAS5K/4Nm+oEd0+Y7edWRK0NF2jJ8b09lIHyEqw9asfSBDTxaQmYGaK4avAx0LgNPmNAz/MIUwh/WT4D3SxwPp4ulYS9I7gOXVZdW9J9rJVIy+FhOZAqV9cBWgm6+xK/U8bYS5Jww5EXVSSDi8mvPwXAcXqFLruJrR5DLsTV4ryneQFOigwjIxgsB+VXvTyYsqR99GNq2MGSIz16FSyZ/sytO7YAB1fik0g3Dby8jRzXu0Z0RjVfevpboyhcEuP1NTjm17E7NVU9WHBY5VEo7Qhk2y0Gpuh7HUeBkw+UI39vPMjof+Xj1aiHMx5nZz3ckEesRy9pIZGUQQwIY9ytVW+2QLN3fgqA3UrdnXM4T9pCmJLMoELIc5KxkplG0TG/ECyyaL/hH7enGw5hzWb1spGg6CkLTeO3BzcOHl7ykTjzMEpxQIaBOTFWCrcD3ArhBTEgCyo95Mg5ILm62nCwi2SvE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39860400002)(136003)(346002)(376002)(26005)(6916009)(186003)(16526019)(5660300002)(4326008)(966005)(1076003)(8676002)(316002)(8936002)(38100700001)(7696005)(86362001)(53546011)(66946007)(478600001)(83380400001)(2906002)(66476007)(66556008)(52116002)(956004)(44832011)(55016002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ahrj1ac/bK2MZjH9KDR4kmhhjKfcY8rx+OPS7QK6+GYK8vIoyNS+Ll7jKDB+?=
 =?us-ascii?Q?bOFUi2sPgDvF6L75ERpFAYC7phohmNZjVNzxi+PN/LZZEYuY6Oz2+01uLHqb?=
 =?us-ascii?Q?B1dU2zgeVM27NBYwI1dQ3nlJjnoIMds6OyS/tZeB+wUddPTWCWNtQV05sIta?=
 =?us-ascii?Q?LtBSV3ZXUcacZDExg/cnCP0jUr1ggd7kn58XpmDunOyk817rs2wdaiZDVKDN?=
 =?us-ascii?Q?Gj/6Tu40hfI0PIFG8hM7ururHpY6a14EO4TGpEZbpVMIVHUIPxcwYU/9gMw+?=
 =?us-ascii?Q?YgEsTVfrbR2Rws2nAKaEFvhdizBxpzX7QnDaXYha1AFi06t7SifJfB6pNfVE?=
 =?us-ascii?Q?by+MmqGVqRQcWXBQCqdB6RXCHLHGwpR+FfVQ0U5CQopy1OGAkeTe2RnFDPBS?=
 =?us-ascii?Q?fxYl2hbX0G84QSzmccFLrjPcqJ00yHruM7REP1Hr5bQOC+s1ztblu0PJr6Xu?=
 =?us-ascii?Q?hxPeYdXecHBax/OKrqUZ+K6kiSATf0lUvtQH3exEiqNp3LMGO/2S+8B7WoLH?=
 =?us-ascii?Q?7LXXn97Icpu16cLxTwqo9sxVlrJIP5yFg2MhwNM7wopLzTiu4/qUEtfbCYVE?=
 =?us-ascii?Q?zfN1qsW3MTX/5uv5Y0qETDituxNZYC+E/k2WsnDRTTHm8VkmTUsezEIofP0H?=
 =?us-ascii?Q?Tbhf0w8rtGK2VqU97Z7Edp4k1FbwKw4gaXPgrgvnFlRCr4OQP3/8Ovn2ckXG?=
 =?us-ascii?Q?j7Ujw+94hSdAV7EBDJ+bdiDKM/90Kz7e0Sw9eR1lT2b9WeU2VETMOVYoniEM?=
 =?us-ascii?Q?KSAc3sitw9tI+bPx2cER8UXOuA/N+JZ0pCoyenfMpcykI5A8yTJ2L/syYzgN?=
 =?us-ascii?Q?VgItebVzyJEdz7KeKfc24BS5wiwlFWjdQnsngEtwgjA239lc+9+fVCKVxLKq?=
 =?us-ascii?Q?PlcwKsITpla5rhIOs5oqRlCAoghY0t+K7lh6vfTjmNFj9R47EmiYZ6pK7lhG?=
 =?us-ascii?Q?ttM3sp6RKpbh9nwJ1KmW1O+SU2eEoTRufslSmOskjFCqmtUPGrkbDUbFc3sh?=
 =?us-ascii?Q?zhZ0tJ2o8k+cT/ZZTGVQNBeu+nB5J5nXungtvDkAJfkV+/Ad9oOjShIT8146?=
 =?us-ascii?Q?EXlSR3T4NVpHX3a1bAD8xgo7o86Len28V3rV9K/ARF9gLYOUopSIJs5Vax3v?=
 =?us-ascii?Q?B2gHicLBpXNrDZ+fyrt6eAlDh27VQW8d+gLws9hNWqXcf4i2DpLZglPjg9QF?=
 =?us-ascii?Q?EiEjgTHlD90h9gLQy/rkfoZ9YcBwFs6IyRtxmFQPijVoe5PQkDPlwwo8Q+rH?=
 =?us-ascii?Q?tCsEPZKFCHh1qs8YXvuvibreQww/HxM9K4/xI38jGRK+yhid6wTPw+gOaNPi?=
 =?us-ascii?Q?rfcXcT7rReYviwaej4zHiNS1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e540c5a-e19f-4857-a254-08d8f61fc078
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 21:39:10.8384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TqR71C8PWfrrqDLwPc8omNJEZPxivECWavG7x0sZknd2cijJhGKgOtmyTZ9BuWb7PO9Ib+/eqTqx6E692yODjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4797
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9942 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104020143
X-Proofpoint-GUID: 5Pga4BHd71W5tZzQ26YdY51x1INsfZG2
X-Proofpoint-ORIG-GUID: 5Pga4BHd71W5tZzQ26YdY51x1INsfZG2
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9942 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104020143
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 02, 2021 at 05:07:09PM -0400, Derrick Stolee wrote:
> On 4/2/2021 4:43 PM, Derrick Stolee wrote:
> > On 4/2/2021 2:27 PM, Tom Saeger wrote:
> >> generally isn't it still changing the right-hand side of refspec?
> >>
> >> replacing ":refs/" with ":refs/prefetch/"
> > 
> > Right, this substring replacement might be easiest to achieve. The
> > 'struct refspec' doesn't make it incredibly easy. Perhaps skipping
> > the refspec parsing and just doing that substring swap directly from
> > the config value might be the best approach.
> > 
> >> This would still work for refspecs with negative patterns right?
> > 
> > One of the issues is that negative patterns have no ":refs/"
> > substring.
> > 
> > The other issue is that exact matches (no "*") have an exact
> > string in the destination, too, so replacing the _entire_
> > destination with "refs/prefetch/<remote>/*" breaks the refspec.
> > I think the substring approach will still work here.
> 
> I updated my branch with the substring approach, which is
> probably the better solution. Please give it a try. I don't
> expect that change to help the FreeBSD build, but we will see.


This worked for all the scenarios I tried, which had both negatives and
multi remote fetch values.

Looks good!

Reviewed-by: Tom Saeger <tom.saeger@oracle.com>

>  
> > [1] https://github.com/gitgitgadget/git/pull/924
> > [2] https://github.com/gitgitgadget/git/pull/924/checks?check_run_id=2256079534
> 
> Thanks,
> -Stolee
