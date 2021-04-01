Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF0FC433B4
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 18:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE9776100A
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 18:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbhDASw5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 14:52:57 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:51228 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238081AbhDAStV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 14:49:21 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131InE31184018
        for <git@vger.kernel.org>; Thu, 1 Apr 2021 18:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=ta9ZBqqqxnDutsZheIiuk0XwvBGKLxc84j/QgvyLvQo=;
 b=qX0bn3KTEEcUbwxHPYD0baKQ8sSoB/I/E7vg2FMr2qxJ7hwH3HcMtmBseRzm2NLnntV0
 9/+JSn9h1FyLa8++WA4A99MvfsPefEapR4K+W91dFQqad6NrQsSrmnTn7Q9+lSfwE2Uy
 f/nGJprixgkOsoLrJGd/4GcQC8Yleo8IyKpBUykEdC1LdbuRrXn8CWunJf8qft/zOMcw
 TOsGlGppu3Mj5ZSVKOawDEkAFG/uenZ5C6B+HkeGbVVfZGZv48nTnD2ay5P8OypI2BYC
 ii7tev7DyvGLPq4mZdfJgkZDSHDG/TJ19LXWplFfZDyz6qP9dNUMQ0EqGlr+Zijrm3LQ jQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 37n33dttd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 18:49:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131ITc0G020785
        for <git@vger.kernel.org>; Thu, 1 Apr 2021 18:49:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by userp3030.oracle.com with ESMTP id 37n2at6m4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 18:49:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOAHzWz8d2r2L3kkq9UZxkNC8D5Ih5ObvB4uhTLhMhVuitvYOgHcOZKY+3jhaGFxRJV7fy9AcnyArqnYpqUCwMe6fuXBpiAh5DPrJ9V08q6lGLqD5UHvUM61m0Zifvhej9BGzZMhDk+OIXcmX4hwDdFlsqutytBpzEL8uOwrDtYAz+fc6wVWcXWlbm8+dC/WYG2RR7RrA9nDjIxwvAVwoD9o1ZrRajA091JZ69yflyCQXA8qzO5ge2ct8aTQ4l1WDTwX7oRtoyV/RMnA7VbAtJvSuDSfDeEyGFfY1LZwj7fSk0864q4AYUwlez9ZtICpvWih88YASVA+XodhMVYMwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ta9ZBqqqxnDutsZheIiuk0XwvBGKLxc84j/QgvyLvQo=;
 b=h6wYOGnO5d4uP7j+IgPxrVM0yi3aejeFZkQgU0x7GVC/55iLpjMINhEi3U+YUocNb+FCR0kWe3JSuJsM7HnPrKqPp5JftuKG560TkwU5AZWEjNu/PjE6ZAzpeEfRY0V7jC7lI0psVJLNPM690JgmnHWzxloGH5IbL2laiMePBhG0fUjAboRPQ2PxuUcv9gTMDhGR0pevjraWhlyYU1YgLkQuN2SPKUKT0+IpQc36NaoNX4RU0LSOkDGw9CbysKkhhSeoVLRZQ752b89ijR3fBUh+4zIp6hEGjo5bpwtIe1NIwmxHl4RkMJzDQ+SsFnO6wnnm34CsqtFdipjD55j8aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ta9ZBqqqxnDutsZheIiuk0XwvBGKLxc84j/QgvyLvQo=;
 b=lSFLHNerKUL99DupL6+7WbB3Q53vd3KSnXHU8031bLWLle5Z4r5is62kO+EaeFnBRzw+JR7RQYoQNP9NVN27Roro4y/i2PUS0VXtDYoeNYNIULmMcvRMt36FXq3FFYYlyNlz0OYBh9O5UdouhaoC/JZVFcQlkmlhyT75EbyIVKc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by BYAPR10MB3064.namprd10.prod.outlook.com (2603:10b6:a03:8c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Thu, 1 Apr
 2021 18:49:18 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978%5]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 18:49:18 +0000
Date:   Thu, 1 Apr 2021 13:49:14 -0500
From:   Tom Saeger <tom.saeger@oracle.com>
To:     git@vger.kernel.org
Subject: should git maintenance prefetch be taught to honor remote.fetch
 refspec?
Message-ID: <20210401184914.qmr7jhjbhp2mt3h6@dhcp-10-154-148-175.vpn.oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Originating-IP: [70.114.130.219]
X-ClientProxiedBy: SJ0PR05CA0127.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::12) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-154-148-175.vpn.oracle.com (70.114.130.219) by SJ0PR05CA0127.namprd05.prod.outlook.com (2603:10b6:a03:33d::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8 via Frontend Transport; Thu, 1 Apr 2021 18:49:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ca1c23c-47ea-4ebf-8716-08d8f53eda9e
X-MS-TrafficTypeDiagnostic: BYAPR10MB3064:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3064D51E8DA0311AFD786836FC7B9@BYAPR10MB3064.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:254;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6z6MmkjsJjB0Mbrk9kG2PbH6yIp8AqYERv7Jpg8tqfqQDNzeMWmzEWqosCKgH1OSLBkBpg88dmLOHPZV2rWlycHOZwePqE1o/u3LvzH+IMee2Lp6h8n+EHH1ojQAIAs83qLTsPtfwguwdHQsxMbuFR/6mc+EHuhIY6ewSINSiD/XAUVCkWIr5plH6Y5weljD6NZ7mAtOSdy9wOk3NWyycwkqC/OJdEo6uxW3nnlZM48d0/oTc4Apt4P+A6O6jOy+5fjsIW2i53k0eKGcZaZjpubN+KOx7A3wASS45Y2u3hV8SYjGindZEDr2X4gWMVr7Lk0k0EO9g15MmJ92RnxyqML4OYsG+t2D8cEvYEqtuGtOhYmDgwYxQPW4B013hVwUw6RK19EvmfnUwWIRP2c1NA7ULrWYmFKmue42ta/ZFknqPg4VFTR0P+9/fPIpXP3c9+keTd+L2ME+lfU7RoLCWTO/jLgQLEyZdic6id3sQ9azk/UjhXDMR6n5Qi+oMmkBCyL1kwV/Nlyt4zYk2pfFkIiAdFrfnhYILPpqPyEI01Ufx1Nai2vQaIMbAKgIPuO9cyHrsVDtJiEkeaE/k8eKawYQdENhVJMBdUJHU6pi2AjTIo8BIQVnpPtfGtdptP+DZcDHH77It3okQdXb2boqvy+DVNP/Id9HoSm4ddemu2Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(366004)(346002)(136003)(39860400002)(38100700001)(44832011)(8936002)(66476007)(1076003)(66946007)(6916009)(83380400001)(316002)(2906002)(478600001)(26005)(86362001)(7696005)(52116002)(16526019)(186003)(956004)(6666004)(5660300002)(55016002)(8676002)(66556008)(102196002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?b5ey1uQnldJXPi/CT3sGXNG5jAOVndroo0dBHSR+cIuPXTiXK7d8lAdtQfBN?=
 =?us-ascii?Q?x5jY1tUQY8vSZm5yTDaqGUoFEsfot/beZJe7DQw4GTSD50BaiU6FYzYuE1Ez?=
 =?us-ascii?Q?FEKfybZNUaCtrbQ6kaTU40bhm1Xzed9cNb/OhL8ZY/WQoyPQqIGxrSCRxrwj?=
 =?us-ascii?Q?eID64LFJqZp5BlYcYYdpvoWBzonoCEo2sDMsgepiEBrbj3Guho9cAhsm9RjB?=
 =?us-ascii?Q?q3HoZC2X1VIvKCXc+yk1JN+Ty5JlQHx+sepYcIrI69SgS7ZvBQPEcqJzpMj4?=
 =?us-ascii?Q?09iVyJdvvXCzCLBocnZfvRYp9l8RGbCpNhif9VECgKMKMMmtcVRQ+8jxfdxM?=
 =?us-ascii?Q?ZmastvXzNV/ntcJi4/5xLLDKvi7WihmphjJeuvz72fuZ9vhaH00/k1SSjNd6?=
 =?us-ascii?Q?i7puGlcsIswNAoIGVCBYuUhQ6ADxLbVXMJnTj2vhlpbGVP/opgh3gwVH3+qn?=
 =?us-ascii?Q?87RI58xAIQqYT7VlJ4g2cvPHQV7McjxFDuorLE9XqBFJBT+OApzaOTHvinaX?=
 =?us-ascii?Q?KjOf56B6BuS6u4NvBolimK4ZYu1xtBBTCcaSqYAmNdtpEUP1RRmZ1NNMvUv4?=
 =?us-ascii?Q?Op2K7bMLsRC2OFBhpI1//NdbnJakLrs8n9jaX2KulWkWu24LcdsGHsyUsVBF?=
 =?us-ascii?Q?exSL8gFHpSxLNfB5tvTG1AEWm7hS/tXbkO/ZxodRPNetgE6593XpDid9Qxnv?=
 =?us-ascii?Q?3PhcjkiBuSF5/DmQYfLXQzmzFYSukYz8CrHwddVDRRJNhxilzVewCeXybQFW?=
 =?us-ascii?Q?95F/hdrCKEvMbRTzmiMyfbg3lBRBY9fAEPfIro41HcJlSpUaA22XbXAGqrmU?=
 =?us-ascii?Q?kuDxOaIMtTDNbmr0N6YliICpgHQUfNKsbaBUyUkGwYvtnEQQkdjF3aVLx4Xg?=
 =?us-ascii?Q?zse86Lc7P54meC3hoXzSLMIhNAgWZ5AiSJzyau6ZBhASWucdhzsixPzh8Wdd?=
 =?us-ascii?Q?lULo5LwotX/ouOKhkPcwUsakAblEOrVwiiOY2ksIbN93jBCqtyQIGtL8d+Gp?=
 =?us-ascii?Q?2+OSprXB6VOkpAx//nDNc9HN15hxuDxkJpU63Y54ZJMVdKjdgyDJHDzfQQiw?=
 =?us-ascii?Q?57NwvDxmVs8K1Jbl3KmLdg8l3mGv2oJAJ+1GuCXKelarrkzdAIVeRudmHw0t?=
 =?us-ascii?Q?UQCVo7MdNSKmfBB3R6lpuTf/ISteNMYQxGynXreXrZ9x+fmoKr3ZGdSnNbAF?=
 =?us-ascii?Q?bhmrejtL0ZLQe8NcYqNj/p2rJydtlC02V3pCvZ3bcPAzqiCnH54Slo1maoH4?=
 =?us-ascii?Q?AFLYFa6kgMZlRAlWv3BooSPFLiyHfBSWIA2aX7HVZPS9iUthDY55PWLP45gC?=
 =?us-ascii?Q?0Kmc6UOm1zCWfF24wHVTEhGf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca1c23c-47ea-4ebf-8716-08d8f53eda9e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 18:49:18.1192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OUKGyqAQ7KMxlZ4tqMZQO7eb2tfG/+4nR9z6zoZKasvyIO6Ah8reRzOqrPh9R3ny7R4fqHb/5l33Y0AMF1REEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3064
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=655 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010120
X-Proofpoint-GUID: 680aS12p7eRedORyHDSKC66hgMPLQXdo
X-Proofpoint-ORIG-GUID: 680aS12p7eRedORyHDSKC66hgMPLQXdo
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=856 mlxscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1011 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010121
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've recently setup git maintenance and noticed prefetch task
fetches ALL remote refs (well not tags) and does not honor
remote fetch config settings.

Details:

# narrowed set of remote refs produced by `git fetch --all --prune`
$ git show-ref | grep "refs/remotes/" | wc -l
81

# git maintenance prefetch refs
$ git show-ref | grep "refs/prefetch/" | wc -l
262

# git worktree with 7 remotes
$ git remote | wc -l
7

# some remotes configured to fetch narrowed set of remote refs
$ git config --local --list | grep ".fetch=" | wc -l
11

# concrete example of remote fetch config
$ git config --local --list | grep "stable.fetch="
remote.stable.fetch=+refs/heads/linux-4.14.y:refs/remotes/stable/linux-4.14.y
remote.stable.fetch=+refs/heads/linux-5.4.y:refs/remotes/stable/linux-5.4.y


Should git maintenance prefetch task be taught to honor remote fetch config settings?


Something equivalent to:

git config --local --list \
| sed -ne '/remote\..*fetch=/{s#refs/remotes/#refs/prefetch/#;s#^remote\.\([^\.]\+\)\.fetch=#\1 #;p;};' \
| while read -r remote refspec ; do
    git fetch ${remote} --prune --no-tags --no-write-fetch-head --recurse-submodules=no --refmap= --quiet ${refspec};
done


Regards,

--Tom
