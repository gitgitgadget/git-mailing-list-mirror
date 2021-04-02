Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599F4C433B4
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 21:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 113E06115B
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 21:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhDBVPd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 17:15:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38962 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBVPb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 17:15:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 132KsZfp036413;
        Fri, 2 Apr 2021 21:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=ObUJtQTqNQTM4c+6f2LRSmtqVcIqGEnyZqO8wifCPmI=;
 b=JF10T5eHLLYEQQKAVtTvq1G0cKwN5bfwdZ9j6KCmTITPQPtXTsSQrn4MM6HeaSXUBjB9
 Q1NjyXC4gpcAZwQnX3oyyU0ODwkRdiKu06BvO+AmCycAq6K/Hmohwq6eRddyNDlR6z/s
 g1fAx7KAlTTWGc53HxNgkIsH4n9Morjm6gngiNSaHeSNLD+2OmhTlRF2vhNJrsnzD+jq
 NUgltYDf+kmYjNR47ovvvYSt62XOfZ8QICoRX9Qvjq+B8g0CxK5znUMcyX6srWHPLkCA
 4EmXS24CPIn20IqPzhgRIs+21z6jeGAosPyu2SCR+LGHh6NBrQMq1bttswSWNmPg9gDa iA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 37n2a05ky6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 21:15:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 132LFHkw115411;
        Fri, 2 Apr 2021 21:15:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by aserp3020.oracle.com with ESMTP id 37n2acuqx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 21:15:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FsuzIpvsCiAu53cWXWZ2Slwepm+jqlPwUx0ajMpxA+T5pdhn/88u4LCgddvW4mYCojNbsiOpF9Ui8xzYJDNZm+43MQt3jUr9uXI9sZouiWPsDs7yi4cbS30JaaihEJNnANqvkibxuNPWEi+5oyRv86T7xRlhipUaO2zHQdyBgmK6Tb5Hgrsf32FEj9wz3ULiYAsrcECvPoQmWl+K9yRtlsYW0wzwjfmdyFLDWd3Hijf+LWDoYk6efh/kNVxG9XnVs56T8WmMygi+8PURx6A3fwd3CaptYNOwFxfipIeHBMgd/0ixgRAZ5MmUmTJUOmGPqafJz0+qugOMC2BPilBgGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObUJtQTqNQTM4c+6f2LRSmtqVcIqGEnyZqO8wifCPmI=;
 b=jKsHddc47yombHFOdJgBAPriJaGZiX6J6aEO/b7COFolBvH2X5ul2pFNEae13Pecr8mOBpB3njDOUBYd8LuSJobB1WyPyJahYUGh8u7y3U7Pf0/tul/BRNsRG1T4YLOa23Ua4zsX/a8Erny67tC2QhTMuWCwX+1fe1ODJE/77wnKsi/tUFQTHeGWn2tyU700V35uI5ZdwlATVO0J+itP9WzsF+og2VrKcOX23kGsjJDQYB3A89H6XP8CB/GbLqQV03g5ANoTJ6IAWyBxXvQdfcpPY+mvKJmB7X0X6LGFKnpwwYJpIQkDib7mAEpeiudWBxQjpwFAErg0WyEH5TVblw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObUJtQTqNQTM4c+6f2LRSmtqVcIqGEnyZqO8wifCPmI=;
 b=XtXqfRnpPo+qiCxAmWogdASXYXKj6oQrOVv7yEANlRCnBuWG+GrANrvJ1216eTySE2FChnNUASwVQpMEv980bzWyEERpd9Ej6jIh6X+MDEI3gbGkZZFrVr2APB3Nhc3D8HX9gddJuEvugShdn6RwZoZasYzL2FSriGnF3Vt6H/E=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by BYAPR10MB3239.namprd10.prod.outlook.com (2603:10b6:a03:156::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Fri, 2 Apr
 2021 21:15:22 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978%5]) with mapi id 15.20.3999.029; Fri, 2 Apr 2021
 21:15:21 +0000
Date:   Fri, 2 Apr 2021 15:15:19 -0600
From:   Tom Saeger <tom.saeger@oracle.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: should git maintenance prefetch be taught to honor remote.fetch
 refspec?
Message-ID: <20210402211519.l2bnzx5higqfcoyi@brm-x62-17.us.oracle.com>
References: <20210401184914.qmr7jhjbhp2mt3h6@dhcp-10-154-148-175.vpn.oracle.com>
 <d246df21-fdaa-a391-847a-e03e8e664af1@gmail.com>
 <xmqq8s613gqa.fsf@gitster.g>
 <3bfd9a88-10f9-df71-bf96-f9c5654e48eb@gmail.com>
 <20210402182716.trbaflsjcvouff2y@brm-x62-17.us.oracle.com>
 <41dc2961-7ba5-a882-3416-45631e2cbb33@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41dc2961-7ba5-a882-3416-45631e2cbb33@gmail.com>
X-Originating-IP: [129.157.69.42]
X-ClientProxiedBy: SA9PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:806:21::18) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brm-x62-17.us.oracle.com (129.157.69.42) by SA9PR13CA0013.namprd13.prod.outlook.com (2603:10b6:806:21::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.11 via Frontend Transport; Fri, 2 Apr 2021 21:15:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 553b1977-1b94-4fa4-237a-08d8f61c6cac
X-MS-TrafficTypeDiagnostic: BYAPR10MB3239:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3239A2BA0207E7DA165DDE0DFC7A9@BYAPR10MB3239.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u64oDtGp7s353V+qZ4oDS8Zc2d+guWx6UumblJ8dPQtkt+GwyAhZwNQpL96qOtmTxD73X1IKpNdz88/9856H/S/qcZe9XtPBIV3x9yOPUKfv0GyO/zTQ9p2PHox3amIOO7ie3AIKi75umey41rnvZcNnxtq5rOMXZ8dntmPNzzF0q17uBaMJgXj2rSa4FQd3XrLt3UfFnq8yq75aYqCTNKjAf35L6nk+eJbQ4wxmSyUWImYHd7k/PcrJFOtE0hLQ/IDed8qE++TJrx5BNGbb6kkS+AOVUi+GqxRIMEHAnqjaAzKEYKDCdU+O8x4cPl3dffXl4aikpP8e91KjCVYro6KLlCFLf2XCAagXVEOonu9rfxLUulS/FfxojAgT4Uh0bYPs+t22dRQhgbffgJt67KRjF3dJScHCpx4xu36bDvLwOucOlUqrGaJaPL6Z73At22xglfCSlUnuCpyE6SRRupZg1ljVkf1/SF3OizHhUBV8X6LO1sKTG8PXJAy5pskRr1hcAGn62gxcx9GnHabf1Bbwi6/9ja9RDeXV5iI8EHWHednB4ivAWuibMzB93fM0fyKW6GD1AW/IKrRrU6g6RQfaB0nYECeCVPTFRj84THArudDFp0f+eIzz3udwlRbZM/NL/qf2mMPxCZpL+uXfUnZ5LdXTkF/GbY5fWajaP6TmH9aczoyYDBlJ5IVFZO8z0/HK5jHZpV3OpfFFucfbdx9Ll6GayoG2c75TccBIQbA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(136003)(346002)(39860400002)(5660300002)(6916009)(66946007)(966005)(66556008)(66476007)(52116002)(55016002)(53546011)(4326008)(7696005)(478600001)(44832011)(8936002)(1076003)(316002)(38100700001)(956004)(2906002)(8676002)(86362001)(16526019)(186003)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Y3R8elHuTlHuia5yhj8PyeaeTjlf85RCqIUowOQXd1b9HGaoRmCgp6WF1xu+?=
 =?us-ascii?Q?Fguqk2f0im4KpQ84o+Ws18qdVG1ydK1uMiWkeOj2NDpr5UoVqMnYfLC0RgO8?=
 =?us-ascii?Q?fcw4ZOnofEvheQG8sjmCIxXzchsyXKZrbhISsTYYk2iwObXz2HsjI2BCKcD/?=
 =?us-ascii?Q?JzyCFYfa2+I39cdcgCgkFOFhKMyYjtLECnZnPwy6HCAYN3vxo3pP9lkL72r6?=
 =?us-ascii?Q?eeCNgU4F1SRlD384iR1wQ9Hh++NnsOdsTqdxJ/4aYh6iQGQEjNcbA58TYssv?=
 =?us-ascii?Q?EWSdEsW21U8o3XZ9CbWIwqGKJZ1uYR5CinLLZF+U9rDRQuVlNC4Q5+LSNvTF?=
 =?us-ascii?Q?dDqy+h36J3NdSds7RvjgNNXLZwdJHErOGO8WSsDuy/+xTZOlQGbI2ELiXUER?=
 =?us-ascii?Q?FqWXYNv3CcQEDWbz5G/Hb6IsWETPVgjTKQON43BMPn9m5Om8m+Nzmv1/1L3o?=
 =?us-ascii?Q?LWjltycJSe1jOoDokoUO6I3bBo2G+jRkkLtDCSoH5NrRW6hj4r7/lXXTE0X3?=
 =?us-ascii?Q?zfjQv2WJiLIjJJOb76haJlaPj8w1uEVw61/iXFWG9eoeC82dmRbiDewSkgqh?=
 =?us-ascii?Q?uQatm5GS9cHK7Fqq3zuiEI2zBmD8lka9wvceAW0iHl9RoOElHmTvqsU392Xj?=
 =?us-ascii?Q?dLpOleqf/lccCzTS6Jb5xsDfGbVPcx1NUfbfFA+B+xN0YLMy996mx2j40KiA?=
 =?us-ascii?Q?WXBdR33OvemzwcIhEk+BQCfZFBPadEkzRMRTY0z1Iipit8/xtpUxVQFQDZeT?=
 =?us-ascii?Q?nMvP199Du1ebT2LX69SjgFK2I2JxX+79F3Wu1W9kXA8y2H+pooh56MqgdSzZ?=
 =?us-ascii?Q?asWlBl9SLH/q3oOUnPT72enOvPcpuBuycd8xFykLQYNwpF2KNu8/PR4YVoyR?=
 =?us-ascii?Q?ubnyS78hCRCZnJlNvak9BhnamvFPGqW2Zor6jqc+nIENvnPnVnimUuAvJeBv?=
 =?us-ascii?Q?dJfbmEXEaBtjCz9895WhnnRnKDH1GnBDrMWbOGkLzMgzrM4jgIUJTk909kcF?=
 =?us-ascii?Q?zW67oAb0y4TUxdraQqx32BYsRlLb018JX9d9+oVv5Q3EETJ/pXXbmCtBfv58?=
 =?us-ascii?Q?wwUPXnr1HV32ib3gtzBipYCxk4z/ny48q2lFht2KLDvi/awQKVF51R9GjMzJ?=
 =?us-ascii?Q?hWvAd/LW7vHU8c0/+//dI4XnbJpz7AssM+Q6J2u8qNYM4XaQVK8AUoCRGCHb?=
 =?us-ascii?Q?ZuY4VAu6FrmNc70DQiP8tVZMTfNKmFnJZbRSsVkxjG0c1fPCbn6CBImsqBjR?=
 =?us-ascii?Q?K2PWM4R7d0nOW1PdZgBhQryYrP3xa+K2AE8OwU46k7Mxefzn7usvD3vbTSAl?=
 =?us-ascii?Q?Li4QrerFOlYJ9TDKTQGi43MV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 553b1977-1b94-4fa4-237a-08d8f61c6cac
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 21:15:21.7831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qsk/bD1HBwKpCDXaJdVz8OSB5N1fxINXvAzOIiZfj5FJu6M6ZjtuzEkb0YVSAMY34RcLgHGGvWit1iwIG3LQ6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3239
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9942 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104020142
X-Proofpoint-GUID: Pq4z1ixz20475l0uq-T8NDuQLyvDfXD6
X-Proofpoint-ORIG-GUID: Pq4z1ixz20475l0uq-T8NDuQLyvDfXD6
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9942 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104020141
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 02, 2021 at 04:43:16PM -0400, Derrick Stolee wrote:
> On 4/2/2021 2:27 PM, Tom Saeger wrote:
> > On Thu, Apr 01, 2021 at 06:25:36PM -0400, Derrick Stolee wrote:
> >> On 4/1/2021 4:14 PM, Junio C Hamano wrote:
> >>> Derrick Stolee <stolee@gmail.com> writes:
> >>>
> >>>> On 4/1/2021 2:49 PM, Tom Saeger wrote:
> >>>
> >>> So, redirecting the right-hand of configured refspec is a good idea;
> >>> not copying the left-hand of configured refspec, and unconditionally
> >>> using "refs/heads/*" is not.
> >>  
> >> This makes sense as a way to augment the feature. It doesn't seem
> >> like a common scenario, but it would be good for users to have
> >> that flexibility.
> > 
> > It's common for me, especially on repos requiring 'maintenance'.
> 
> I'm sure that once this is a tool in your belt, then it becomes
> common. The number of users who think about refspecs is likely a
> small proportion. But features should work as well as they can
> for as many users as possible. There's a way forward here, it
> just is a little tricky due to the generality of refspecs.
> 
> >> Upon initial inspection, it shouldn't be too much work. However,
> >> there is some generality to the refspec that might not be wholly
> >> appropriate for prefetch (such as the exact_sha1 option). I'm
> >> unfamiliar with the advanced forms of the refspec, so it'll take
> >> some time to have confidence in this approach.
> > 
> > Didn't know about exact_sha1.  prefetch probably wouldn't do
> > anything in that case?
> 
> My guess is that those should be dropped and ignored. But
> maybe the approach below will still work?
> 
> > 'negative' refspecs - hmm haven't tried those.  I see how that might
> > complicate things or maybe not.
> > 
> > generally isn't it still changing the right-hand side of refspec?
> > 
> > replacing ":refs/" with ":refs/prefetch/"
> 
> Right, this substring replacement might be easiest to achieve. The
> 'struct refspec' doesn't make it incredibly easy. Perhaps skipping
> the refspec parsing and just doing that substring swap directly from
> the config value might be the best approach.
> 
> > This would still work for refspecs with negative patterns right?
> 
> One of the issues is that negative patterns have no ":refs/"
> substring.
> 
> The other issue is that exact matches (no "*") have an exact
> string in the destination, too, so replacing the _entire_
> destination with "refs/prefetch/<remote>/*" breaks the refspec.
> I think the substring approach will still work here.
> 
> > I'm willing to help with/test/review this, thanks for investigating.
> I have a branch available [1], but I'm seeing some failures only
> on FreeBSD [2] and I can't understand why that platform is failing
> this test. The current version (as of this writing) does not do
> the substring replacement technique, and hence it just gives up
> on exact matches. I will try the substring approach as an
> alternative and see where that gets me.

I also worked up a patch, not nearly as elegant as yours, but it did
work.
I didn't think about changing fetch_remote to take struct remote like what
you've done.

Thanks - I'll give this a try.

--Tom

> 
> [1] https://github.com/gitgitgadget/git/pull/924
> [2] https://github.com/gitgitgadget/git/pull/924/checks?check_run_id=2256079534
> 
> Thanks,
> -Stolee
