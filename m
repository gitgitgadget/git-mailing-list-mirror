Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C71C433ED
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 19:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEEF1610CA
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 19:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbhDATmh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 15:42:37 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53808 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbhDATmg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 15:42:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131JaLgn124269;
        Thu, 1 Apr 2021 19:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=NCs2HM10rwhT99m8HHMBwK9YstZr4twPn1Mwzcyd2DE=;
 b=LqXX4INuvuXjFqNG+Ei8Hu1HzSqG7aOiaDRS6BOk3RpN819Lfp2mrF+KQHvjw2AHVpRl
 N1/pG8a3ZiRS7wRGRsUBE/YfG4yNDrixCu09StWIGnJkbJ3fVrIElVyxYhNXR5vbbLwo
 9FEFtToxDnKHIBMxovL+xHUBPLShUfnLyJbdNDZq4a/a177agLVZrJo5VJRGsF2JKFb4
 bmDh0LOlulUqnWksf4FqWJRyFRvqEnC762fJ1Fiw0WjjhnbMo0oTkzOVhOEtlxL2Okcf
 rOEDMTY+ubpKokfQujkOU3mSj4kJe3Snr5EBl5cSxKQrquDv7DsQ688MFyO+XuAHbhFZ JQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37n30saxbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 19:42:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131JaxsQ157387;
        Thu, 1 Apr 2021 19:42:35 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by userp3020.oracle.com with ESMTP id 37n2paybcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 19:42:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ps3MOXn2FxRSAX4aewyn8b20YGbLHT06bukM+4gVLmd6t2LXY5dazjtLICVevyNl2Boxsd3dseziqDmkA5lOcf2VwlChJnRGaGuS7lQ8qK3cJ3o3vRJ/pW9jNDn0qAWsTupzdrrtitk8wAK4JxuAG1a5oDQ3CBG5weZajplnoCoCAFcZbITxOQM+TLkLPSacEVggmljikCCrV/eGEnmTQzQRcJl2/Wlsdbk3HpHymB+tDc9zt7TbdoL/C+2ESJBqf5QLT79bZeF2GpOgmwL+pKrPYtVJlDl2LY0rmhso4ahKAQapgwzTjwURSPQP7D6ziF3fL5aLF9kgrsKfB5EmQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCs2HM10rwhT99m8HHMBwK9YstZr4twPn1Mwzcyd2DE=;
 b=c9WUUCjpKvXwI+V+srvC+GV9urn1tcT22yQ+yJSv4HJI+VZ7CIssbqMCAvXPtW3aP1SfI+2A2tVkuxtaPOtNXSKxyroneYhqahsfFSUQAsuYXT8tHkl6tpoPGYXWOr4egZkHEmYJt95Y8oTgPTYnM6P08rNJhiL2FIyvchVgDM0ZusHPmN2+x2X98Z2zdQALwWEJ1wbZX3Hn9ZUyIKaTYNe4GjZ/EzOaEMD0xTxW2IEcx4PA6tTEvULLuHOjHE4I5ejmIuYB/i81Oc30iwHbNmUrxy2w98Q9aSxVzY5MHzHt/PrItZEg+QoQW6U1zYgyJQz7FKgdl2cGVWekLZ11VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCs2HM10rwhT99m8HHMBwK9YstZr4twPn1Mwzcyd2DE=;
 b=YuxC9BfoUTDFE7qHxNC1ihEdcA9/gm8rK0D1+rZYRKoUsAn4ggPl0xwUmCvvUWH14OkbLxm/7ulHWLv3TEKRPaIB2sPEiE0L+jjGHJc5jFs4FIU+YI1wphf4d/e1B3NalOUlaU9vmj+7TUtKQt06RDNL+3nZuckbteKMTNmTZb0=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Thu, 1 Apr
 2021 19:42:33 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978%5]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 19:42:33 +0000
Date:   Thu, 1 Apr 2021 14:42:31 -0500
From:   Tom Saeger <tom.saeger@oracle.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: should git maintenance prefetch be taught to honor remote.fetch
 refspec?
Message-ID: <20210401194231.aeazn5izmxsk5hcn@dhcp-10-154-148-175.vpn.oracle.com>
References: <20210401184914.qmr7jhjbhp2mt3h6@dhcp-10-154-148-175.vpn.oracle.com>
 <d246df21-fdaa-a391-847a-e03e8e664af1@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d246df21-fdaa-a391-847a-e03e8e664af1@gmail.com>
X-Originating-IP: [70.114.130.219]
X-ClientProxiedBy: BYAPR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::23) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-154-148-175.vpn.oracle.com (70.114.130.219) by BYAPR02CA0010.namprd02.prod.outlook.com (2603:10b6:a02:ee::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend Transport; Thu, 1 Apr 2021 19:42:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1cce1c3-b813-458e-303b-08d8f5464b34
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4542:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4542451397E06B46C2185AAAFC7B9@SJ0PR10MB4542.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fjvCjg5/dxp/QlCqfZlLx4MrZ/zEGkhocVWHrMA5PX+Fa2jSv95bztCBXK0ipVFm1kR2qPae/eJMX6LEcgNFEATwil1WDAHGVTK00l6bAZx1l7arhPaknUrRqkIgnmf6DfQq/cuqbx2+wi/Qy9okiG4zWwh00MnqGGtLUJfSa1hiC49GiTnooftfSoM/IGLBY/TfO3hHDadKu2AvY/9NxXqlAm/83Qqzg3wQcDmsOJwb1n3nqI5ohzGKz5PzYXxgmzlg52x2ebbgDx7UaCjd35CnogAxi+g3mRvYTCWE2YmB5I9qqwkdJuHCvHxn3gdSDFBp97BI6W3q4LBJJ5YmwTuKpqlPetmIrRcNQynctHmmHlyYoQmpDBwb8lDoNZ8THdHRlDH8ANWCCJVUZpzoPdOucFSAPobnxwrNll2JLjlc2BCyDHgSjuIWk1GnohucGXNcOtykyn7Fv+0H/o7fnAsifBUwOD1aWCieP2Eeg+qFdeQgk3tAg91V+Zyzgg6YUGg07IKRnVb1twcHHVam0q7kQZaIkLqr9GKVFi+RJNnsLzxuS0xwaY9TJUJ4D9+IRMHtUOcdb4hTKGTKd00YpHUeuS5GImCPQSN8ZNUUp/6OheuUNxOwuMD+cawILi4DoiLhjhhO/KzR8dOdyHwHLo7aJZCoIlg8xCsBtExQ/VpOnHewpJUGHAZUnZ5oeYB5TYTpFQ4IV7NkJ2H5UU3ujw+nVLwec6HJHurktZdr3Mdh8A6GzTQx7VnhBWfhz4vB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39860400002)(376002)(346002)(136003)(16526019)(83380400001)(26005)(5660300002)(186003)(478600001)(66476007)(6916009)(55016002)(8676002)(53546011)(66556008)(4326008)(966005)(316002)(956004)(2906002)(7696005)(44832011)(8936002)(38100700001)(86362001)(1076003)(66946007)(52116002)(102196002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8X7zQkfMlo86CbbjVNIpj7htuacrPh5Dswu5ipGbUL2LZN+O452dtPACmr4W?=
 =?us-ascii?Q?Wj0DGKThwxvmBA5UOuTnCpaQE8ptfzuo35yrf/nkOH2xFPcAn4W9yGsSijw5?=
 =?us-ascii?Q?SyqfzE+ISeKj9Z7OUq0KYVVDVGVWV0KcK5X2zFXFcrIovrOGzV2grKhitYCj?=
 =?us-ascii?Q?sGK1n1V0XcaMA4VQcrJQfdTK3I37lEbWXZgTDZueQb9lZiPujQAf6FWb3liG?=
 =?us-ascii?Q?dZ3rFlUAgPp89vlau+y67FCDaSATGtJsdNr/pWSy8t60FVrlbJFxKREqL29H?=
 =?us-ascii?Q?6YnDOGQOJJ+cKT8UrTm/oTkX/Xf6Umsl+ymay0C/qtgD72yVPOPoe/6Ti6E5?=
 =?us-ascii?Q?DWKKa1fEpoDvf25qqfaJ0wNAin16AePBJcVLDq7ocw+De4rIgtje/RYCF4Xk?=
 =?us-ascii?Q?7/zB5MWquzqW78F7VgwzmRld55WDJfLgPoQ11YiDf0c5/O9s0i6k9Cgp3tMn?=
 =?us-ascii?Q?JSoqBGunD6P0imrbkigFWXH2D5fLpiymfGjp97zEl1Led25p3+006dso8riY?=
 =?us-ascii?Q?/bOJsa+lfQ/QESlTzQWrqoPUVLtaOM1wlqTQSjbBZLV54Xl+lvQ5JVbI31Ii?=
 =?us-ascii?Q?VBb1CqIc8pIw1SLj1y9h9shdDnWx/aDA6pEO40Ri/eS6n/CIDfoAbUTM1/1v?=
 =?us-ascii?Q?c8mWV3GwKbWx7txV4MOcO8b7Ss0kSRidWGQh/2nUs7WrjmgWnAqrCuSadcjE?=
 =?us-ascii?Q?1iDRfvYhcGdWBe1cgNv8w1aGRwfwzE1Ahs3Z/nD6TA1+8uPH0knizKtGiRjV?=
 =?us-ascii?Q?/5szQpZ0YOHpT/KoSSmDyhuXYya+QiMbwoD6k6g5rtIMuy19iPL5MeQ8jE9N?=
 =?us-ascii?Q?M+7bDMqeJaylEB2AK0VqOD2wxbFQK3c2hKIUOmRWIca9Ji4Qg7OLSdh2F7iR?=
 =?us-ascii?Q?PPoKavOz4A7G4yz4c9XGuTittIuik/OJYxXX0aGa74J0LT64ZvFFaWtEmkHC?=
 =?us-ascii?Q?sf/Letk2aJB98S+f+s2eud4hJ4/n6nZnusAoFMWBv+UFF6xEy1zGToUZOxCj?=
 =?us-ascii?Q?3rFbF0+bmDgNnrTSmd31Tag3UcHcZLx8JRcToZwnejfEBaEEMrq4vJ6nDDSy?=
 =?us-ascii?Q?yUbtP6kO7+0YjsVKj1M9VCQbrCQI4OZKaFod3UdlJpNhZ28kC4Va3Om+pz6X?=
 =?us-ascii?Q?5kNPFfOgadIgPwUEkyRfEV9nX6VpQXg5EjlhToQ5Qfn2hg5aUTmTaF/H5OTx?=
 =?us-ascii?Q?1SsZapYAsZoC4ofou65pFBhjSUQf5tBPpQXh2noZsLsUzFoVZBOointWKj6d?=
 =?us-ascii?Q?zK7Hd1SmqWqFdFR44KtWnlESBFiLMx7qBniQBqaJCPjOngzC3eL9M1rYrBOA?=
 =?us-ascii?Q?eAnysVyCt1fnVusjMTbENPcZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1cce1c3-b813-458e-303b-08d8f5464b34
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 19:42:33.3850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4EokzOmK91u32SqoYGPff9i+AAtE415tOlIMBW3QF82TZGYkCV1nI+gSq85pzkUEYZG9Ex7L1jRdDlb396Wjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4542
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104010126
X-Proofpoint-GUID: lRecHNRcxlJolhOCcgv2C2PE84p03XTY
X-Proofpoint-ORIG-GUID: lRecHNRcxlJolhOCcgv2C2PE84p03XTY
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 spamscore=0
 clxscore=1011 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010126
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 01, 2021 at 03:07:37PM -0400, Derrick Stolee wrote:
> On 4/1/2021 2:49 PM, Tom Saeger wrote:
> > I've recently setup git maintenance and noticed prefetch task
> > fetches ALL remote refs (well not tags) and does not honor
> > remote fetch config settings.
> 
> This is intentional. The point is to get the latest objects
> without modifying any local copies of refs. You still need
> to run "git fetch" manually to update the refs, but that
> should be faster because you have most of the objects already
> in your copy of the repository.

I get all that.

In my particular use-case - I constrained the fetch refspec to purposely
limit the number of objects and remote refs only to those of interest.

"git fetch" won't ever use the other 120 refs that got pulled in by
prefetch.

If the configured remote fetch refspecs were honored,
prefetch would only update those objects/refs which `git fetch` would
have.

> 
> Here is the essential part of the documentation [1]:
> 
> 	The refmap is custom to avoid updating local or
> 	remote branches (those in refs/heads or refs/remotes).
> 	Instead, the remote refs are stored in
> 	refs/prefetch/<remote>/. Also, tags are not updated.
> 
> 	This is done to avoid disrupting the remote-tracking
> 	branches. The end users expect these refs to stay
> 	unmoved unless they initiate a fetch. With prefetch
> 	task, however, the objects necessary to complete a
> 	later real fetch would already be obtained, so the real
> 	fetch would go faster. In the ideal case, it will just
> 	become an update to a bunch of remote-tracking branches
> 	without any object transfer.
> 
> [1] https://git-scm.com/docs/git-maintenance#Documentation/git-maintenance.txt-prefetch
> 
> Thanks,
> -Stolee
