Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3277FC433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01DAE6124C
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244167AbhDLRYy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 13:24:54 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55950 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244073AbhDLRYx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 13:24:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13CHOTq4092561;
        Mon, 12 Apr 2021 17:24:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=QK3s7lvNG0CvOzZyDg9lQUZGfZexM9vSSsVouCLsTKk=;
 b=V6Yg2RgaWKWCdlX85/fJ/t+prSVTuO0untNvAR/v47QgNNua57Wwxm5yKsGgvmIMljhs
 Sg6p1niLCCe1HbgeuHUkb3RyqYLB5Gk/T9RxMVW89h6lVNsr07Xh9ckpLUhUZM5VXt2j
 BXt8T003b4O+i79iGH8Q8uxSmtaEvcWCXJ9cXlZtF19cZd9/qz7G4M2nDsUaL+K5F4LK
 2lDon2LoUeU76KKsXvpbXlImD2taYueTMF9VsKxWFAtIjccadF6Ka2Bn47Ob9laxvnjc
 9vFE6AgyOKbWIrx2ycYJg+kpBd4oPEn+kWpZwx5K4wLM4XpirGy+I3yyDYyHhPIVxge+ fw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 37u3ymcfqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Apr 2021 17:24:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13CHOQfr019354;
        Mon, 12 Apr 2021 17:24:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by aserp3030.oracle.com with ESMTP id 37unkncv9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Apr 2021 17:24:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6srKIuGC3pxqrr0hwcCuUpjkeNIhD54lkms0OyRLbF3l0B29oioXtWIRNMGWGq2SPtqo3vrPrjWsXj0bwLYjw3OUzxVM+cDeFFEluS40Rc8VbARWQ532v1ZwhpmaExgm6G3iohhEBRWOCKXL1KnEEidShRB11TCul/i0onpM2RdF7fNDEiKaZ4TzyYhJtVyPtuvO1Ta6VvJUoiOG4h03Z4Dw8SiBXWEC9/cCPYwcXjOKdRabv84sq/SRrqTFdR3UEo3LMT6j2VFV9sQ6xrrIfrSj458BITDQG/CuPzSJMN6xLl2NpJBXKgx+yqy4mZMGlhKgxzEEVOpyQnOdD85Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QK3s7lvNG0CvOzZyDg9lQUZGfZexM9vSSsVouCLsTKk=;
 b=YJODaXNGa5fXTUCx2ou6JlTHFSXOgcxOUF4klvHpZzppxSzPO0I8/IwsxPuLEzbQmgxZYQG26v8e89AnHcJzDQoGvVR2xSC75crXDU34Mqw7JZeXQp50VgNk9z7gxYtS8JKHzLZcYPQSVOJS7hM4ruNCnbfOktJHCbl4oPXmQTtnstLc13BfCkpT3t4xjj5Oe2hMw/TLidIdrmlaZ82NKqrL/rN6O9quNJ6TJgyJxyaNPk9tDszP2A83bL7WwbTaeWDQMadi/qmPMFWEjN1yyL/ZHmadwjVx0HydHi7Lj5V05nFGZPX5tJEoj87aM8MlO8smd2Bl+lkdmF7/3h9NHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QK3s7lvNG0CvOzZyDg9lQUZGfZexM9vSSsVouCLsTKk=;
 b=LzwdXWgdWQGAr4gxM8isfiJ6OxlTU6X9T2Ewifsvqr2eBpcirPAc0TWdLEyxqhl27o7SBBiCCwB2hR0xfPIkQy17fYxDMYd25A1R1poll8Juz3G6KTQ5MvEgI8vot4OFr2uejTKcdyH4Bv4+D/biLTwMvvjTJg0xARQVdpjukoY=
Authentication-Results: pobox.com; dkim=none (message not signed)
 header.d=none;pobox.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by BYAPR10MB3621.namprd10.prod.outlook.com (2603:10b6:a03:121::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Mon, 12 Apr
 2021 17:24:27 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978%5]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 17:24:27 +0000
Date:   Mon, 12 Apr 2021 12:24:23 -0500
From:   Tom Saeger <tom.saeger@oracle.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sunshine@sunshineco.com,
        Derrick Stolee <stolee@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 0/3] Maintenance: adapt custom refspecs
Message-ID: <20210412172423.rjwv7gozmnnzcaep@dhcp-10-154-186-72.vpn.oracle.com>
References: <pull.924.v2.git.1617734870.gitgitgadget@gmail.com>
 <pull.924.v3.git.1618020225.gitgitgadget@gmail.com>
 <xmqqtuodiowj.fsf@gitster.g>
 <20210412164805.pxq7acln43gbggkl@dhcp-10-154-186-72.vpn.oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412164805.pxq7acln43gbggkl@dhcp-10-154-186-72.vpn.oracle.com>
X-Originating-IP: [70.114.130.219]
X-ClientProxiedBy: SJ0PR13CA0169.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::24) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-154-186-72.vpn.oracle.com (70.114.130.219) by SJ0PR13CA0169.namprd13.prod.outlook.com (2603:10b6:a03:2c7::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.6 via Frontend Transport; Mon, 12 Apr 2021 17:24:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31cae9bc-882e-4e3e-9bc4-08d8fdd7d251
X-MS-TrafficTypeDiagnostic: BYAPR10MB3621:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3621EA60111A0E3B9AC67455FC709@BYAPR10MB3621.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mS0sBbamWCC6+1KOUQx5km4RmaDirdAZKI+qvnhu/h63v3J1CdoQfk4rLAebzKYTY+1MKy5D7IPGXH8XMK2M6YizkN+N6jdjSFgVgoS+pjTdl+FiU2saDtbTGPcp977Sf2eOw8Jm1aHGvEFHJFXEeiMOkVE4apZmf72yJuwZebgUWeVTwJmDO442/UkzXZ+s58KCRkwAU4SnmTE5CKAXTlqDivwowAgCCp+UApKv7Z0akKHTmzlWBfIo0ggonP6waegw96tHe1QVsjoSxZwYvWWtjerNxDbnNOX4gLWrY2NUvdF0PqkqXy3oJPkFHH96HNAXHC2KJqUnHrMhCcb1w7x3Ip5j7CtMEsNRR0X4f8VEnOQpeBXsddeMottTkfTo0OtQ0LKvUoZwYQrWkodJvtThu4n0qGFlntincZLvZvCnd0LZK48vOCcS1b4L6eRHC6CfvPkIlymfc3/CQcg/GiBGMqe12oSO1Vpff6e/4ErCivSzIyVmgO6Q5NKk5UxRBPOykq5+0bnzM5qxNbuHd1mEk1WkAMODugeIwjqEFC2XJCsIPPPXZOR29Y3GNE55P7RQku5yx1RmZpluR5RMHprBBcApybojd196oRnqMoXiOVaoIOFiiM15yGEfqSf6xGL9zQaL7I3dXGI/TpiM+I5L4Y0lb8pLoaucl1b9GeqgPOyo1DZT8/WWG8Xw+5dynAKSDFIWGkoUaw92jmQQQnk0fX4cieJdDeEVFZIuZzFZ8LhcnW3NDWJSVUt3ApGe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(136003)(366004)(396003)(346002)(186003)(16526019)(6916009)(956004)(54906003)(86362001)(38350700002)(44832011)(38100700002)(4326008)(966005)(8676002)(478600001)(5660300002)(1076003)(52116002)(316002)(7696005)(66946007)(2906002)(8936002)(26005)(66556008)(66476007)(83380400001)(55016002)(102196002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bHTJUvowKCLIg+EZrBsL/IbLyLYdfP7ZTqA7svEhuE4iiyhdCaA1PqnWg7Kz?=
 =?us-ascii?Q?yVKM2IPFfOJ8kMZNC9YCDa2i5vLJF5FdvMV7YPSgxHi0FxQrD6zLx37Bm/ik?=
 =?us-ascii?Q?Ml/KcQ4jShtMaNE2nL/9u+uAoiTO+s1G7rN95skfXX46EWLkY8X76sRLyEn+?=
 =?us-ascii?Q?hKWO4COiBBTLOBOSZUYG8H5zzRo7zMLNkdMewfskvn1auBniw1xnet4QfPiY?=
 =?us-ascii?Q?OsqvZMP2QXVln4WBWTQzOLoG4zc+4Bm4Jf8Fqd8BGO322hpWB3WMwBMd2cr/?=
 =?us-ascii?Q?C3kpOLHKZ5SG+2Q0y3dIWKFSw9uYHWl4b/Q1trYbEx8k9R3i3FbjWwqFgtBf?=
 =?us-ascii?Q?4SS+DFVnBGEjAoAnDrfunkM3uIIgV8WeW7jjmpByKIUqNEUaTZC1mvOUs/PT?=
 =?us-ascii?Q?rq5nGCOOMtnRL5CenOEDh8Wypc9K/RIh8aHKiHEQDo5gJVVRfAHH799O+Xa9?=
 =?us-ascii?Q?SEYZIvA8AtBU0Fc3h250apTE+4wG3xDqGeE6+NmNu5gj91Cfumw55bFVP51f?=
 =?us-ascii?Q?qRygtzKOodTQIKccf6NK7lQGF5rWnblg5d0ykKpEDMsyExLQQeuW4sjzYtpE?=
 =?us-ascii?Q?vdjlpjr8P8GlDuchaVvJiQNMW1xWe+AbHxFOH+O+PMA0U/oOFBOf6iihhczM?=
 =?us-ascii?Q?3xZfAu8MkI8ofqyS79BXPIYtcGE3dpFh8unOiJatNNHNvLha1GpuKF641U4A?=
 =?us-ascii?Q?rksXn5FqXLO9Mk7XWzSbZc4mFyJNSo0ue88BQtQXxx37XsiuYdCTTkQKZRNP?=
 =?us-ascii?Q?my6cbwVTo05tFE1VPjtP6YsBPlqyADWMUN/Cw39YlwxQJl00Eio/fxI5uRhh?=
 =?us-ascii?Q?c4Bw538f6++Ak1r7cIEjcbf6yizSiccR7gwG9q9bW+jW+gLaN81pRDkXSGJj?=
 =?us-ascii?Q?THKCRh87yXnydUC1wQZBP0clmKwZ7OhTWkwLWR634kq8W6YEDS1kp6SwwJde?=
 =?us-ascii?Q?JmMczbeyTUCKEsc3lCWnCfmYYCry/W7+7oVVHmxEX9bqOZyXEriyZukIcI3f?=
 =?us-ascii?Q?g8Rke3Mwkqg90NoQRYb2xfcYo/23AZDYwVVyc1dClc11ISZfJgmCzmDdrGb0?=
 =?us-ascii?Q?i0JphWbDbDqyphkXkJFqg+/ZuBgawLhGIbHtsYZM2pueoeNuauHaWbMIJLRM?=
 =?us-ascii?Q?7SQijrnlioYQ0ErsbwRrH1RifR120owIUIWjPzeaD0GkX13vrRL6ofaB3TDw?=
 =?us-ascii?Q?Pq9myZ8HHujw+Uk3MpPyZN5oIP+FnyMxrgmn+KoJpxmIQ5cOLMWLCEZ3uRlP?=
 =?us-ascii?Q?wFY8E6A7ohqLX8T1ebC932mbU1vFFrSjASWV+te1tBSKvUcshQenGheC0X5D?=
 =?us-ascii?Q?JdG1y7Rk9RSLMUKvFXU7uJ6X?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31cae9bc-882e-4e3e-9bc4-08d8fdd7d251
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 17:24:26.9729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3tsJ0EdmOPeH0/kdNgGt8vB4459EDKAoShyxdUdfPQ8IAORnxrrG0Zx3o2G3Ko5J6JQo9JY1ctJtdgMprgjjLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3621
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9952 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120110
X-Proofpoint-GUID: D2TEKTnWu6NtAk7oHFMcDp5fSwFBXn-t
X-Proofpoint-ORIG-GUID: D2TEKTnWu6NtAk7oHFMcDp5fSwFBXn-t
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9952 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104120110
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 12, 2021 at 11:48:09AM -0500, Tom Saeger wrote:
> On Sat, Apr 10, 2021 at 06:35:40PM -0700, Junio C Hamano wrote:
> > "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > 
> > >  * The fix is almost completely rewritten as an update to 'git fetch'. See
> > >    the new PATCH 2 for this update.
> > 
> > I do agree that it gives us the most flexibility there with nice
> > encapsulation.  Nobody other than "git fetch" needs to know how it
> > computes which remote refs are fetched given the real pathspec, and
> > the only thing the caller with "--prefetch" is interested in is that
> > the prefetch operation would not contaminate the remote-tracking
> > refs.
> > 
> > Great idea.  I wish I were the one who thought of it first ;-)
> 
> Yes - this simplifies things greatly!
> 
> I do have one case that fails prefetch though.
> It's a case where all the remote's fetch configs are filtered out.
> 
> Example:
> 
> 	[remote "pr-924"]
> 	    url = https://github.com/gitgitgadget/git
> 	    fetch = +refs/tags/pr-924/derrickstolee/maintenance/refspec-v3
> 	    skipfetchall = true
> 	    tagopt = --no-tags
> 
> 
> In this case, running `git fetch pr-924` will fetch and update
> FETCH_HEAD, but running with maintenance prefetch task results in:
> 
> fatal: Couldn't find remote ref HEAD
> error: failed to prefetch remotes
> error: task 'prefetch' failed
> 
> I tracked this down a bit, but don't have a suggestion how to fix it.

This ugly hack fixes this failure.  I'll keep staring at it.


diff --git a/builtin/fetch.c b/builtin/fetch.c
index 30856b442b79..6489ce7d8d3b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -508,6 +508,9 @@ static struct ref *get_ref_map(struct remote *remote,
        if (remote)
                filter_prefetch_refspec(&remote->fetch);

+       if (prefetch && !rs->nr && remote && !remote->fetch.nr)
+               return NULL;
+
        if (rs->nr) {
                struct refspec *fetch_refspec;

--



> 
> builtin/fetch.c `get_ref_map` makes two calls to `filter_prefetch_refspec`,
> one for 'rs' and another for 'remote->fetch'.
> 
> `filter_prefetch_refspec` works and filters out the above fetch config.
> This correctly yields condition
> `rs->nr == 0` and `remote->fetch.nr == 0`
> 
> Later a call is made to `get_remote_ref(remote_refs, "HEAD")` which
> fails, leading to `fatal: Couldn't find remote ref HEAD`
> 
> Should this be expected, or should this now be special-cased for 'prefetch'
> somehow?
> 
> Regards,
> 
> --Tom
