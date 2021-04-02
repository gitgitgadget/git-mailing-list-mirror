Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52D2C433ED
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 22:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 916D66117A
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 22:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbhDBW15 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 18:27:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39962 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhDBW1z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 18:27:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 132MOe47181934;
        Fri, 2 Apr 2021 22:27:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=0xoRgm/X4BXRuNZehmDgP8AR1grXDJ9YkZzrRSkI4ZQ=;
 b=xCX4weP9GlEz0Nk7s+yR9jeZ/IzZGlHwVJwZF5BnnzUaDckhmWzxUj4GP6VKgJoNiEcJ
 SHwLZ9ghfHRYSVzrqrdv7iotMRBbshJYD6GINdhZ08aRuF/aIOxrqZrcinQJS4zq6vjw
 2K0JK7KPLKrgVCnCvzoeZlJJpw1sQ498Xse1dn7epZAJcxwW7mWaIP56vMTyyrP3sol7
 WLghtAWij0dmmWvBg0WFIAF0pZGYsLt8F9f+abiF1JDWXrM2LCRmDWO5GlEGtdzxxvF5
 qkUWEDuUCFIHGeKZl7LcoBWxh00+CVBuvCewZwvaI4OWVLYJ8qECApjRziNLs0VGpk+H rw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 37n2a05p1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 22:27:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 132MJfHM127280;
        Fri, 2 Apr 2021 22:27:50 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by userp3030.oracle.com with ESMTP id 37n2aughsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 22:27:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHT87SmYI7IsC0YQfbre2+SoYhfU7iq4YJbXgN7ZFdJh7ZHidbQSqMQz3Dt14pfk4GKj0xRJXyUNBpjtmlRzyEOs1uOeHJNu4MWaaKDkI2YEGMBA9jLDloKsmfEO0u69vYL4qcz4gcob5u5PYbfKIDYBPoSBEXV96eryd9FKPaYrVRxa9Md7mFzaOkmp/NynX2o/a0l6jnMzaf6MSorlwwCOvTCPCSxEXw/Uiea3qVl3CSAyUcgJkIX3n3YDIq60sq4rTlgCcglddB1OEBjnviz6PZnxlyY4vwRAWjdGkfHUyFYo15Rnjaf2/S9cw0k9VoAuEX0ckC7bV1FBYQp15Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xoRgm/X4BXRuNZehmDgP8AR1grXDJ9YkZzrRSkI4ZQ=;
 b=jLCPkB+P77jPXgIM0oTehJBgqgbSgcqMv6gTv36/bhqTp+ObR3H4LDN+VahvmdeNaDJgWbyBDcT8iC3M6MlldgttmcI8oT3KUf7CsbHfqEHjCNUUxep0bQpERry+Fxvtg4Nbq5BXWf7kGR4YjRL7KJ16ZRP0gwFYlCq5kQ2B6KixQGYXn2/4sV3rfwHL9L9z6tmck4ZxxlZted1RdACeCIhIO1FDUND/OzOy+c0ryB5zE4ZhqCLbLvbUwHdPXGKv8u2kHmeCT5Yh24thO+BSUJszfV/LXYbcnMCja1RLkK9KLO0ovl6ggGYYsUIXI8ZjRihRQIYokEyQHaXFhqZyUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xoRgm/X4BXRuNZehmDgP8AR1grXDJ9YkZzrRSkI4ZQ=;
 b=RpjrrB+L5SDx17gg3SZ3sVsylR4JPj/4NiOf59enc+PSNYQtl33pG8AtfOZdXYMTC0sgsdpf2z8PrL6t1cADjZW7Q9pbhN0PpA97C2qFu5BAqcf7heYwB6NFDjoai3jlP5Z57RqDkPiLmH61V1jFcQAKHlMIxngR5EdFomlgkIY=
Authentication-Results: pobox.com; dkim=none (message not signed)
 header.d=none;pobox.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Fri, 2 Apr
 2021 22:27:48 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978%5]) with mapi id 15.20.3999.029; Fri, 2 Apr 2021
 22:27:48 +0000
Date:   Fri, 2 Apr 2021 16:27:46 -0600
From:   Tom Saeger <tom.saeger@oracle.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: should git maintenance prefetch be taught to honor remote.fetch
 refspec?
Message-ID: <20210402222746.722vf7tssojrzm26@brm-x62-17.us.oracle.com>
References: <20210401184914.qmr7jhjbhp2mt3h6@dhcp-10-154-148-175.vpn.oracle.com>
 <d246df21-fdaa-a391-847a-e03e8e664af1@gmail.com>
 <xmqq8s613gqa.fsf@gitster.g>
 <3bfd9a88-10f9-df71-bf96-f9c5654e48eb@gmail.com>
 <20210402182716.trbaflsjcvouff2y@brm-x62-17.us.oracle.com>
 <41dc2961-7ba5-a882-3416-45631e2cbb33@gmail.com>
 <a4cf3e48-aed5-ba1f-298d-1f2cc2359be2@gmail.com>
 <20210402213909.zuyyqqisvq7gjcxo@brm-x62-17.us.oracle.com>
 <xmqqft082vb6.fsf@gitster.g>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqft082vb6.fsf@gitster.g>
X-Originating-IP: [129.157.69.48]
X-ClientProxiedBy: BY3PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::22) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brm-x62-17.us.oracle.com (129.157.69.48) by BY3PR03CA0017.namprd03.prod.outlook.com (2603:10b6:a03:39a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend Transport; Fri, 2 Apr 2021 22:27:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15157884-1b5f-4815-9696-08d8f6268b6a
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3366E58B36E0AB2522C626A7FC7A9@BYAPR10MB3366.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FrnvuuaDMTh3HEmNWQ1XxbORtpiCU28No7ka9bRPtB+m8vk6V9n8Q7BffayYTnGcYO+WU1piX5ifzijUP84JqKoPnahqTASuBMw/qzAmHpjcj+Hc+es8Z6nWK3UElj7IimqCVQqMFHkAVhPKstFpt41oMU3rm2qKtwciSlLHyg7uFTLDA4bCL6XXjzqupNKZJ3JeyLoStkVohVCiUQroLv7XaudNonaOvhlafzHhCM9Ylt4G9GPJ4N/hnW2ReCSAPrmgsBNNqzkH8cYESdv2P8NQNQa9Hq5p4p7q7Nwv+N2VXuAaN8NTCvrJE5lG9mzwc0pHPNB6qbK1Aobfke8prLoab7rgYDM5j7y2OGO1/aiFuG9U1m9cTYYeAyEVB0XdK0nntIMdYqwgF33qj3JYrFzGYN+Ocn6tXRK5JwTzrf++0B5egwOPJvWc8dIFjUAJVPuu2yBvbF1yjBbcIVqxb3ZGGzeCccbi8wPf/5Wb6zoKaTIGexM7o9mJjR6spzToaUSxTBBQA03IsiUF89mfs3QBHxbydnLhcDh19WN6Mq26Kl05TcS6t2u8/MpDD/RzLa8da9wCnTSJHUkPylfyEGzAcAVKaCx6WYw9qD7SJ+Ynt2cA0hK5VxjeHrqagkG1YbuybFsgVpr0lw/Zy1WYDMYnoDgnyb10I/rd+XgpEJF7+IO9i/sMuJrx1N9dM268/8s8u/XdEm68zcW3T2Uf5w1psK3awPPqTxoHsBw2L7w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(136003)(366004)(39860400002)(346002)(956004)(1076003)(8936002)(44832011)(6916009)(316002)(86362001)(186003)(53546011)(16526019)(66476007)(478600001)(966005)(4326008)(7696005)(26005)(52116002)(66556008)(2906002)(55016002)(66946007)(8676002)(38100700001)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?58G4oVLNNN8bmro9hzpC204bqJQIi6XstnrcPcRLMLjH55lzxnxXNk5J2STa?=
 =?us-ascii?Q?rtw2ozclpKIYGNuiW6jWvugIEuZBjx46U3jj3Y00uzH5oK2hwXK8/UTDIver?=
 =?us-ascii?Q?oblXSrMCHIIrP5GXzici8kREMn6AlkJ/hv8j93vZ/oGRZg3ZRw7GV6Hn3OSO?=
 =?us-ascii?Q?ZAvJVLzmzdhsN28N7tbQoRUmcp3khb1oas2pVLB8V+Ay8NS0StHNVscbBLxo?=
 =?us-ascii?Q?mijZA+YMHRqGscNIhf0LDBbIBO3L1EBoQMFuS9voKPz7Qf65fheYPUyINwFB?=
 =?us-ascii?Q?PpV3M4+hgPvEg7y6MrxbOzKZce82tsvhd8KcSscSnscbQwBpsabrufzM+OeG?=
 =?us-ascii?Q?1b6lffUJN2OfkzbHRBHztKY9Eu0Lzkf/scTprNxodInCTPoQbAlIf/F4sAAN?=
 =?us-ascii?Q?xu/o5OB6heLu2OhRUSJbCFoLXiM0EW7847AL9GZhaRbCcp/02COIzPEnAuc3?=
 =?us-ascii?Q?LvEu8Oynh3K40NYLREcVEeq2eJ3l7uK3MV4BFE5EOdEiRm05trrdIHQke0zO?=
 =?us-ascii?Q?/Ah9vcXznjN4Ks8XTBaGZDGvJIAToGMoyBdmCvYSfoD0WsS5bX7Rh05zzfTU?=
 =?us-ascii?Q?Gk65CSH5gRlVUB1eBPYbdwQVuv0mi0KXjAiW3VjG8/1v7PjW33SI2801yg6X?=
 =?us-ascii?Q?mxE00Jp4n7dZVqsYNo54rs/rlYSgTsLegqw6OYYKqepd/hK40DN/vc6IInyt?=
 =?us-ascii?Q?J7fYWvw6bRjJZBvDayqrG532/Tahu66klk7XhuPJs3b+9c0FumOWTx8eQ+nE?=
 =?us-ascii?Q?PmGPy0yLIPwWBrXIneA6FkWY2UYWH3MWHKQX0DYLc7gDjkGPsziVYPVBgBni?=
 =?us-ascii?Q?pP1m4RnUl4jY5L7TNwdo4p0MQbH3Iue59JUzBtenn68WEQM0ZKKsanIsc5cD?=
 =?us-ascii?Q?ifXLHn50DVEOZ6vGXP2fZFWO44L6yaJFvPJRqaPdB3Q4TxVL7A/mNMlDUr2K?=
 =?us-ascii?Q?GhLdWu+d8CLbw6L+zn0MRfG3BGv0BYbeI4IFns/3oUTSiYWYKgqUHAdskisd?=
 =?us-ascii?Q?OxHu/pjaFWh+G0hm8BJLGsmxiNflES+MKMj6BP4Hybb1EKHCpaR7cclhLbUn?=
 =?us-ascii?Q?ophOeTP+/GX7YJB4ZlrxkIaNiUIz63VpV+Z3myjA6Nj+RBQxbB4d2JSSSHWt?=
 =?us-ascii?Q?nkmJ+7XwRulXSzWHGL8iaAcBHwi8bQ2UgAnc1n1Ba32OUi5OruWtKyIrFw+p?=
 =?us-ascii?Q?ig4caCeiHtQv1H8LKIyip+JfBdtyHTQxLcJhdPVaBNVQ91WtfT7kcb5hhHlh?=
 =?us-ascii?Q?6+2aWaAChgOi60H7+v2YMCrxyiHdMfF3EYXaHpWj0PlqPs4ydkptDnPl/lSG?=
 =?us-ascii?Q?54T5kAV8TPUkLR623oAUAFdN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15157884-1b5f-4815-9696-08d8f6268b6a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 22:27:48.3082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S4frDGc2t5fEGXW/I/5RzPEilfTE8qU1HDaDR/803Sx2p8Mlo+88T8u3vOWQPEB4Zldwwmb+kqF/ph6uRqrloA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3366
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9942 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104020148
X-Proofpoint-GUID: _NTnifXfFAN1gkLFCp55hIWEpPVkVyeb
X-Proofpoint-ORIG-GUID: _NTnifXfFAN1gkLFCp55hIWEpPVkVyeb
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9942 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104020148
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 02, 2021 at 03:09:01PM -0700, Junio C Hamano wrote:
> Tom Saeger <tom.saeger@oracle.com> writes:
> 
> > On Fri, Apr 02, 2021 at 05:07:09PM -0400, Derrick Stolee wrote:
> >> On 4/2/2021 4:43 PM, Derrick Stolee wrote:
> >> > On 4/2/2021 2:27 PM, Tom Saeger wrote:
> >> >> generally isn't it still changing the right-hand side of refspec?
> >> >>
> >> >> replacing ":refs/" with ":refs/prefetch/"
> >> > 
> >> > Right, this substring replacement might be easiest to achieve. The
> >> > 'struct refspec' doesn't make it incredibly easy. Perhaps skipping
> >> > the refspec parsing and just doing that substring swap directly from
> >> > the config value might be the best approach.
> >> > 
> >> >> This would still work for refspecs with negative patterns right?
> >> > 
> >> > One of the issues is that negative patterns have no ":refs/"
> >> > substring.
> >> > 
> >> > The other issue is that exact matches (no "*") have an exact
> >> > string in the destination, too, so replacing the _entire_
> >> > destination with "refs/prefetch/<remote>/*" breaks the refspec.
> >> > I think the substring approach will still work here.
> >> 
> >> I updated my branch with the substring approach, which is
> >> probably the better solution. Please give it a try. I don't
> >> expect that change to help the FreeBSD build, but we will see.
> >
> >
> > This worked for all the scenarios I tried, which had both negatives and
> > multi remote fetch values.
> >
> > Looks good!
> >
> > Reviewed-by: Tom Saeger <tom.saeger@oracle.com>
> 
> That sounds more like tested-by, but anyway, thanks for working well
> together.

Tested-by: Tom Saeger <tom.saeger@oracle.com>

works for me, I did review the code but perhaps it's best to leave
reviews to others.

> 
> 
> 
> >
> >>  
> >> > [1] https://github.com/gitgitgadget/git/pull/924
> >> > [2] https://github.com/gitgitgadget/git/pull/924/checks?check_run_id=2256079534
> >> 
> >> Thanks,
> >> -Stolee
