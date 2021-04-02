Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A0DC433ED
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 21:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7845960201
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 21:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbhDBVdV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 17:33:21 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50428 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbhDBVdU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 17:33:20 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 132LG9iS066969;
        Fri, 2 Apr 2021 21:33:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=rv7bCz3RnYcjbEGMEvsgrA1V0PHjoq3pBl7oq+0GUpE=;
 b=u0TN9nCuBifTHKqKOvUptNIWtUtdXDUPxWo49LE0gWB3KQdYqIbctBayFqoIal6CIZDW
 1YM6JgHLiodMTKc5NKUkJxfwGfOra5hEvCY0mhh6DPIR4kKTL0NT6Pk+/CUAT2Cl0LPp
 Q3UdwT1havm32fa2mrHFh7XHzkJx0tpt8T1nQSX+CGo++NIYq7OKDa8tbPZRq28Kx653
 1ZY2ARH07XVTL0jlK2QYSOznq8RX5068RuNTYzUNybaklLGnTkdvt3osa+X7+i15zZda
 mAjPeLsMKsftFIrH8JnJbhi3NQ1tdCzU9y5g8fyzsJqGF6/J/Ds4gcIdem1x6uyRzj3G Cg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 37n2aknnc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 21:33:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 132LFHlA115361;
        Fri, 2 Apr 2021 21:33:16 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by aserp3020.oracle.com with ESMTP id 37n2acv303-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 21:33:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZlDE1efB2NgOh+cU4HNvKTUB19ApQiJOvuJqZsGiNEXLgLeVowpjP98UDGpllVxvwTNeKesXRxvxv9BlpuVS6kaMvzyHZGU697ysML16GixLEqWFvz3OrFUt/biUrxSVkfoONzYWRbO4cmRAlDWmlrefGASUhN1/DICpd80y1a/LjsuktXo29EGiTXtv3uWHt3j7KkQOSLnGXXR1UmFh7FHZz460lgkanG+YlIoWqlDj3TX6ZgBfFEua7dMNWV9XM9lONvlS4Q9WxmZ7GZa73BWovstxZOQN08Ty74SCx4CBGqRH4CejFVu1oyu51uQSCOtZokcyHnZlhv9SwwjSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rv7bCz3RnYcjbEGMEvsgrA1V0PHjoq3pBl7oq+0GUpE=;
 b=VF4mEegQi2EEz9A5TGd4CIg240SqQakaq6RtlDnedpsKmRPz5UVEblIP3S2aQkXi8fjL8oMpaEMhKYSMvZ2heXemunGDyK7Nd34oqKE/eWgQ+2+HV39roqRw8T7ttwMxLyuLZdORcwybX8SmALk/wiMxMf+KvMHvHIPh4pob4YBKababDlmT3KJK6rfuskb7gOB23gqI4pnTLbzm0z9rF1h+1UDg9FPVwJ23AGuJ9lQbuYNPb8Ye/KBeDCU9cinI1X3dOrzTr+e4INRFvE+OZnDZAsR0u5RUIGvEXIVN3A5Iyi8NCtGDjBeqlm1WVuM8EjYOYRJNmINiiKr3ywsi3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rv7bCz3RnYcjbEGMEvsgrA1V0PHjoq3pBl7oq+0GUpE=;
 b=lqO830g/rM8EooEAUIdj1KGJtpVL7zAWW8Hm9DHruIOUM3A6NZi9KCZSNzyKzy1UFmu/5f+tFjvH0tVd1YB9Yj8Qdg6W7jhMIi/l43uwK8R+WDUROOqsA/5kdK6q4FK5eFW3Nx73eWne7bkNjt+T/q3mvMy/Ao/1QuVYYsR7Gz8=
Authentication-Results: pobox.com; dkim=none (message not signed)
 header.d=none;pobox.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by SJ0PR10MB4543.namprd10.prod.outlook.com (2603:10b6:a03:2d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Fri, 2 Apr
 2021 21:33:14 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978%5]) with mapi id 15.20.3999.029; Fri, 2 Apr 2021
 21:33:14 +0000
Date:   Fri, 2 Apr 2021 15:33:12 -0600
From:   Tom Saeger <tom.saeger@oracle.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: should git maintenance prefetch be taught to honor remote.fetch
 refspec?
Message-ID: <20210402213312.2rpsjqcuhl4n46il@brm-x62-17.us.oracle.com>
References: <20210401184914.qmr7jhjbhp2mt3h6@dhcp-10-154-148-175.vpn.oracle.com>
 <d246df21-fdaa-a391-847a-e03e8e664af1@gmail.com>
 <xmqq8s613gqa.fsf@gitster.g>
 <3bfd9a88-10f9-df71-bf96-f9c5654e48eb@gmail.com>
 <20210402182716.trbaflsjcvouff2y@brm-x62-17.us.oracle.com>
 <41dc2961-7ba5-a882-3416-45631e2cbb33@gmail.com>
 <xmqq1rbs4c6t.fsf@gitster.g>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1rbs4c6t.fsf@gitster.g>
X-Originating-IP: [129.157.69.42]
X-ClientProxiedBy: SA9PR13CA0072.namprd13.prod.outlook.com
 (2603:10b6:806:23::17) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brm-x62-17.us.oracle.com (129.157.69.42) by SA9PR13CA0072.namprd13.prod.outlook.com (2603:10b6:806:23::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8 via Frontend Transport; Fri, 2 Apr 2021 21:33:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 264b8d63-db88-4f36-a2e5-08d8f61eec41
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4543:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB454348C5FB5BDCED7E645345FC7A9@SJ0PR10MB4543.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SsXXmcps1uxRjzUmp8N6X56Abfo38Svcc2d4AfKy1L8ntQH2WoWMhv1U2zsGxHS+/aQBaCB5fjl/sdrzkyZ3yqqVEnWpHFTZ427MIYQ5cYM0SLGoPYNEdQ7V6illQBZcTVBPbvPEzKsKI1uRDPiVTzGj+DUdHxc8dq4u57TAyfmwLXXa83Y5yTpxsfT1/w3IkWK1qZ7RANVYdWrmcPKXJw/6rPdo2Ci83R78FC54Kd5Rzq7q5n/Hdz+NwVn0bZlOAoFNTStwNDs8CN7npXG8gO3HK9lQ7de+8d1BcRASerCa+sho01mg/5FqtIpxvXHRnruqMTnlV7RQQVaan1LiDQ9iBk7VnYbz0znfi8N1LLM4w5gPNBs5WHLpqVEbWEaX0T+cl/GnSsIp3lq6RBz6Ql9dDy1S0rsL3cbk1sJkrFd90Tn7jnBnLC4nd6OBqiow1Xc6YmJyPyDUdR2bkU4TYmFfuE8Y9JKXp43ebHoDE5hi3sM2SnLY5pC0+09HBuqIx5+ogmmBT2I+Dx66LW2KEinIoAsMcVbrW0qROu90QV4tUNnyrwXH7MM/az6l2NScZ4QhHa/LFDgqYi7umoHllB5aZ46MFgdYVjTW6hlZNKadIk0+F69n+15+3HOodek+6TzYu3Jw0IokoBV5SBnFmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(366004)(346002)(39860400002)(1076003)(86362001)(16526019)(186003)(2906002)(66556008)(38100700001)(66946007)(66476007)(55016002)(5660300002)(6916009)(8936002)(316002)(8676002)(44832011)(7696005)(956004)(478600001)(52116002)(83380400001)(26005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0BS+olCkedeoAWQXRHMLqgWXothBakrO+/Z+x40uiC2go3Zm256aTSRX5ONU?=
 =?us-ascii?Q?OjUopCtKqpLlbyBNaBwks2sKKqNY8+0NNLiKrQgQVEuqW7NC0zeCcti1dPju?=
 =?us-ascii?Q?eJMBEaS1YjOM28TaMwuD2enD1l0DwnyDqIoUvWcXEcdNTfhaXwfCGbJrY9ZA?=
 =?us-ascii?Q?SnqsgjCtxwLbaC0SwGacS5fijH/21ZXfyClsYfrWlYiNX6ep2Pbbz8rqkzNW?=
 =?us-ascii?Q?5exi7I7cdCeGoYZDCMb2qZqEW5NC5FNXLQdTHeHThVegNt8JjkaXwzMN0IpW?=
 =?us-ascii?Q?prYfzAFm89lFcbBisXydBBUGpYFctpbQM82agiDwqXy3BohP5hurYkEjspw3?=
 =?us-ascii?Q?CNP/zeanJsHtDRmZRt/v+T3O5MA2XlIsKhvqn0aVS8o7wauYohb7rVW9OJX4?=
 =?us-ascii?Q?5oya3xbGICZEhHufYqP+T1iX2l7OhncsQVs3AySdiFNezdSsM/HRstQUjxYV?=
 =?us-ascii?Q?aWhO5ABag9BYdHTSLz6H8/XwwB8fpWHBFpGWmpLHaGFtrfRBDI7gqw14tWqO?=
 =?us-ascii?Q?n6shWSryhT5/pR5JkSs7nfC54s0zWPGNhlHFeYKCHozfdGtyjXF9bztc0+84?=
 =?us-ascii?Q?hohrB8J/ZyR663T2/+BKvoQou/n71UaudIEFv/7Erma6qg3uCq5smUPRtapp?=
 =?us-ascii?Q?DP8LYG9rRv79qEeD7MuO99HvxtpREX8sHfJCiG9/NDi68/ODmovlapDy6y1D?=
 =?us-ascii?Q?l7h1xU8XIyEtaFehrNqwdq2di1MC0TWU+nmVVPIjXcCYnHwHTA4hTRBlXk8w?=
 =?us-ascii?Q?uGSVdKDApKr4Br+jgzW+lr0avYAkY15JEjb4wOQMhl5FSojKM3SsO9EurKfn?=
 =?us-ascii?Q?4rT5k1+BlT0I68XGytmdERDS9T1CP5t/Qu5IvHmBnNgswmPQ+PxvPIB1uHF/?=
 =?us-ascii?Q?8CtNlJWvELSsdmHnsO3rcyYWFTlcm2h4g6DWuFeVoAmUl6X4F5GI7qgzPVfy?=
 =?us-ascii?Q?gwimFANYCYh2jkTcXTiIz1LgFThD7Vs3M6nYYw3VV6yMAirMNvHCWvCgl9sx?=
 =?us-ascii?Q?EXi/Pscnf6HpqLCAQVZHmIK9DG/UWl5uFYDI2mA5LzOlhqwq3KgHBKluHz/A?=
 =?us-ascii?Q?WvJDdHJhEbS8eJDNqw7FypySys5xxYNc1EsdYCeSK+z5fYOdgjSOkSdSOrw9?=
 =?us-ascii?Q?QemA3gDalf16ZRq8PRL0JM5jELWaViKyg4u1ChPiafAIzj7080eYyEgRBtNo?=
 =?us-ascii?Q?Pghj5PkMZUqTAhdXl/ne0f/Sa3/jPCK9uJNWriNkVCGqr4j+bzqVTRUxxbOR?=
 =?us-ascii?Q?Uz7WUs3MsKUps1Cl5QbyXUo83T6lZ3RYEpckSwMOvuZO+ZuLkqxplwmqN2dM?=
 =?us-ascii?Q?khKAhAX2GJNHYq1hXo5DPWn4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 264b8d63-db88-4f36-a2e5-08d8f61eec41
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 21:33:14.8160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h9BAFOx7hjS/JpuHalTK4YXFiq9JbWrYYCBg11LwKPC/cuV9MsFb0RuEpvyV0S2SDYTG0w7Nq5nwQFSyVNIwMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4543
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9942 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104020142
X-Proofpoint-ORIG-GUID: 3cTeYSsxI19kAcBwU37Lxcu43jjytTOi
X-Proofpoint-GUID: 3cTeYSsxI19kAcBwU37Lxcu43jjytTOi
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9942 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0 phishscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 suspectscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104020142
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 02, 2021 at 02:19:06PM -0700, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
> > The other issue is that exact matches (no "*") have an exact
> > string in the destination, too, so replacing the _entire_
> > destination with "refs/prefetch/<remote>/*" breaks the refspec.
> > I think the substring approach will still work here.
> 
> I wonder if that matters.  If the exact format says
> 
> 	[remote "origin"]
> 	        url = git://git.kernel.org/pub/scm/git/git.git/
> 		fetch = +refs/heads/todo:refs/x/y/z
> 
> you can just add refs/prefetch/<remote>/ to the entire RHS to ensure
> that (1) the prefetch would not affect anything outside the 'prefetch'
> to break @{upstream} and friends, and (2) the prefetch from this remote
> would not affect anything used for other remotes.
> 
> IOW, the RHS, as long as it is hidden from normal operations and
> does not conflict with interaction with other repositories, where
> exactly in the refs hierarchy these objects are "parked" does not
> matter, I would think.
> 
> I do not recommend unparsed refspec and textually munging, by the
> way.  Doesn't
> 
> 	git fetch master:remotes/origin/master
> 
> first parse to normalize the src/dst sides to turn it into
> 
> 	git fetch refs/heads/master:refs/remotes/origin/master
> 
> which is what you want to further redirect to the prefetch hierarchy
> 
> 	git fetch +refs/heads/master:refs/prefetch/origin/refs/remotes/origin/master
> 
> or whatever munging scheme is used?
> 
> Also, I wonder if there should be a mechanism to prune the
> prefetched refs, but that is totally outside the scope of the
> problem we have been discussing in this thread.

FWIW - did this locally to test:

git show-ref | grep -F "prefetch" | cut -d' ' -f2 | while read -r ref ; do git update-ref -d $ref; done
git maintenance run --task prefetch
git show-ref | egrep "refs/remotes" | wc -l
git show-ref | egrep "refs/prefetch" | wc -l
