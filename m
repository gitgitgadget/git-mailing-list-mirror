Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FD5C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B354561353
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243907AbhDLRl4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 13:41:56 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46060 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238649AbhDLRlz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 13:41:55 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13CHe0cx159574;
        Mon, 12 Apr 2021 17:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=KdJuL+x12AWakXUpQkitLJvabLYKYPwj8MX/hlxVJc4=;
 b=xX5Thkv6qtDBPZiprqeU/EDDFbapqzL0RIOMA4VqVw6oJooTQyh6nOFfZMs6AL5YL7eA
 X6t2PWPbhzjmJC130igSt0nnZA2+4aVuuMvBphzxauPwCjN2gGvwpPWcJwIrwEqU2u8f
 pa6a85EQbCEgMy1cCsFVjhDg+gO0WhKe6997xrc/AB+ugTiNAQYwlyce7lGZkHuhSZCY
 OKtQYzKJqv7B4aEHH9mbriUKmoBoLmVW6jNNvW79VLxB7boWEx5RfK7xbWDXguoYqalC
 FaanHNaGjgb62bTRLY2o8mV1lxLQEiIMhysgRr7wwUUAduAKwZDWzsapMCl4H8VJpznb AQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 37u1hbcnd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Apr 2021 17:41:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13CHfPDt097451;
        Mon, 12 Apr 2021 17:41:28 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by userp3020.oracle.com with ESMTP id 37unsr7ng4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Apr 2021 17:41:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HrYp8Xdw7cRzfqiAsuKHZFMx5rHP0xrTjr/f5Mcgd6qjPJlRZzgGfCKfKbMlIRvtGXC22fBfIcDvMuZJgsT5XdFZHi/y7K/0S5rdRBWx91vymoHVk+23HMA+2jcIQHL5HBUYH4KJGZR82I0HwCq3cF8VzIu25ED/vJFhhsmfQzZcbp2s0siue13WGnBPPGZWhjime4t01C++A7oyCU8V7hTc1Hg2KkIl4MuGlrNirSq80OnjYroJAoqovaQKAUMd+SMTCPuKDx1ckMqpYmYBMIZcRfbT2E8hwYwMRXb0emN46GHfccsyTKGoN/tQSk7S1ps9ZFRZ1Du1mZAj12ybvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdJuL+x12AWakXUpQkitLJvabLYKYPwj8MX/hlxVJc4=;
 b=P4o08rhF9RLdsf20QAFosVKbU2dn4ALcmAm7KnlLCpjhlo//5J7qP9v60HeTe4LeKw/97KDCLEDMshmkOPBEfDGUaQg6PrmD8Orzo9zailk+ISlLmKvNKzvM7mV478KloytGPOpbULP79pn0UE1z9pimfS3xjFdCJWPQWCBkD/wrT9YA7C0Gmd1Q6oxCfuyes5OXzkE5jBLXvCvrwydgksswX9WzsB0zFc5PlSNdbnrjYUReMxcj4vDcyQysEoa6gyLdd2t/4IBbobpZ7aOPu3LIa0gqp/8V87XottxLDUPh5Ddh1TnZeg3M/eMGx3nB+ZGEqnK3gvZ65Oq/u3rB6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdJuL+x12AWakXUpQkitLJvabLYKYPwj8MX/hlxVJc4=;
 b=Lnh/bzD4Msl/EshX3sv+yEoTSDrq/bf59RSnVB60t8/ajsC1vG0WxCfxc1B/PaJmo03RoxgtULy8KdjM4OxeXpxQr3mUwQMt1OOLo1Bj908tsYgdolZWWfY26gRMYzUb3eQ70DPM+HBS4HR8+UdbVCTQu7Ow1cmL0r2aX+Np61k=
Authentication-Results: pobox.com; dkim=none (message not signed)
 header.d=none;pobox.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by BYAPR10MB2534.namprd10.prod.outlook.com (2603:10b6:a02:b1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Mon, 12 Apr
 2021 17:41:19 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978%5]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 17:41:19 +0000
Date:   Mon, 12 Apr 2021 12:41:13 -0500
From:   Tom Saeger <tom.saeger@oracle.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sunshine@sunshineco.com,
        Derrick Stolee <stolee@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 0/3] Maintenance: adapt custom refspecs
Message-ID: <20210412174113.g5iv4muedcklg7mv@dhcp-10-154-186-72.vpn.oracle.com>
References: <pull.924.v2.git.1617734870.gitgitgadget@gmail.com>
 <pull.924.v3.git.1618020225.gitgitgadget@gmail.com>
 <xmqqtuodiowj.fsf@gitster.g>
 <20210412164805.pxq7acln43gbggkl@dhcp-10-154-186-72.vpn.oracle.com>
 <20210412172423.rjwv7gozmnnzcaep@dhcp-10-154-186-72.vpn.oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412172423.rjwv7gozmnnzcaep@dhcp-10-154-186-72.vpn.oracle.com>
X-Originating-IP: [70.114.130.219]
X-ClientProxiedBy: SJ0PR13CA0160.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::15) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-154-186-72.vpn.oracle.com (70.114.130.219) by SJ0PR13CA0160.namprd13.prod.outlook.com (2603:10b6:a03:2c7::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.8 via Frontend Transport; Mon, 12 Apr 2021 17:41:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b949375c-ea5e-46aa-571b-08d8fdda2dd5
X-MS-TrafficTypeDiagnostic: BYAPR10MB2534:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2534770F70E373952F8A34D2FC709@BYAPR10MB2534.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oZP0f2mh6MUGPrW1BalHMIQtv+IFwbE6wegNX3QdMOtwRoBLHgexeQwdqTzKfGJt+/a1JLwwgopLyBpdB43ViO7I9tXVhe3Jd+GjXNXsVrUNhu3S1TMbiWR2oHuoHboE1SbzMrNbqLuxllY5dM/l2vf9l1b8RPguwfYQBHBkORnN39xKvx05PiJxbYVcmIBG0HO65p6qsxLgwOsNVHZdVG3QtRdD+mc6dGdW38V/wJ1LWxT0ju+xDufo0vmdgYDoRceQ5WMnuGSG/duOVFKJZOayV/dEy8uNgiziIKrp3IJIs9zPRDNpQyopNLZ/oxVvDjsI63SIUxHiUJ+KZnopUr2c+xnp40y+9IlMM/1wQEfk4+4RwUMEQCCrWK/2Th97azxrxdg+1x1TEDPtrcvcWNbRE8Pw2tXcAwV83Ey8fgH9NNxpTLYYfYJbF7ChdWtcAtu6YMVtJ3n3PVITUqbPcS9l2y7e6ZAkj3BBkMZBaKIfL+4dxzHjirPg0hLizoO3uW7bNbKJ3uAOR75QNzw7QcjG95Wo8fbbwJH6x6HNpZZFlIw5hVey+AnkMCPaXWt9NC9Jb1AyGc3v4ayv6nXca98HDUR3uOt/5mWcpGk0xcRpMAApMvvg8Eyt/GfMm/BraDs/pMGab4CxZn55W/6pbO3WL/MAGHxfa7HeWwqPOsM+9q6N+7Vic7pwNhIdSJjglx7yVjqT+ezp7CpLU0rZQBEFwBfX/8la3QSS4pAuIZj9dVyVO50Ye1AMPE0gebG8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(376002)(39860400002)(396003)(6666004)(52116002)(55016002)(83380400001)(38350700002)(44832011)(66556008)(966005)(38100700002)(16526019)(6916009)(1076003)(26005)(8676002)(54906003)(316002)(2906002)(8936002)(186003)(478600001)(956004)(7696005)(5660300002)(66946007)(86362001)(66476007)(4326008)(102196002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RWkI1w+J2zDXyRaKTeGX8myIh949l71iod7yJtMPL38F6oVTymSnZxQZ6hUv?=
 =?us-ascii?Q?O4ExTLGljyixqeAe+LgYFi179tmRjCiezfKpFS8/rnC1oUi/ePUcZq/2TQ2K?=
 =?us-ascii?Q?ik+DNUPSTWgIvXFx5UoO/e1gddqWwVxEG14Gssk/uCMxpHj6I3BrdFYUslA5?=
 =?us-ascii?Q?M/s9oqHfQXxVtZazXc6fjkCBHpunI+xPiTBGNReW/c5QlArVxdLSCFBjoVXJ?=
 =?us-ascii?Q?490LfHX7NrUp2UwgICBWvrvMqKmdZ0XL6rcdYKDEh2K3cVNQ2b7L6ywRRb+0?=
 =?us-ascii?Q?pY87/D53opzegcPxrFmWtmKzc6bbBX6XSAeKCDnvtoO+p059rNTyPGKmDdmi?=
 =?us-ascii?Q?DUi1/HZjeoIA4zAYCO5crMxgv4yETstp387uCuTdDXl4Ki1dcLaNVng14G+m?=
 =?us-ascii?Q?d215XbViq4gOIEVRTQFcyjcLSBDOhcSlq4Oz5FJG1zYWRmT1nPfwa6bc+w+1?=
 =?us-ascii?Q?tG8+Ch7Bh9gyFQ3LkGOH6ZqHqTuIykHKmZ1yHFcfmhzJQpuX9ENu4xuSuE0T?=
 =?us-ascii?Q?AkxqBrVzeO14oUBodNzCk0lPbe4QOHKYH8XsO+rELlLZAsEsToi1W1PmZ0M+?=
 =?us-ascii?Q?2Ax4Bpr60spJhB2a2FncyDjTZWo8E9wBZBG1oa0TvmmhuG7Ueou62TZi01VZ?=
 =?us-ascii?Q?BXKwBspATf0shCe8BNjHwQGgWEH5JbhQcMNNrrl9+aeHF+p2H5mbJtMDy324?=
 =?us-ascii?Q?ZtwwCxIaq2MPRJTceF1uWx9rv6jr5izeNGQQgzjXsJ0ZLih1tKwOOwhG/SeS?=
 =?us-ascii?Q?poPN+IJTXfutxveoH9YzQniNI++XtSNWWrGK13bzSMzh2AvjW5e4WQ9OwbVW?=
 =?us-ascii?Q?E3JQlQfAgl8NO1exjPLId6Eqg7MN/Jp2eB7bpz6QOVmlaHNCcI6QmSPsFrag?=
 =?us-ascii?Q?nROr6CD+kSqy+ftR44sowbfYc+09RZaBXsuZh9Bk8qRijISS2EqM7IZzul1p?=
 =?us-ascii?Q?PuWuKu+TEfhSA9ntbVIqPM8NanjBa4lXq8PydIC7lQI1ql+yLZUf5s4QPcY0?=
 =?us-ascii?Q?f+krodmT1lkm5dGaogoXyePvbUWnDg5GqkluyDFwD/QiQzAYqH3in1v8JTup?=
 =?us-ascii?Q?mnNaX16NWR3mgor3eIrm8adtbQ7v23xKIQ3QFAgWZrffS2oARBPhMnhYO+Nr?=
 =?us-ascii?Q?WMw/YSZGt/sC3LHjTW/BYWnYuX+sHOFXAQcFItqH3FQpcNEEcv/Dl0kzz5g8?=
 =?us-ascii?Q?bEqw4ZXVyH3yihADeS6X4eTZ3xB5Ia5Dwod5BwHAJjgn3bfVPxIYiwQNyolN?=
 =?us-ascii?Q?Pcf5yAxex2WyombfcFuStMf6ClpmdnJYBB8XdyQFVBUVNUaPN7IDhpL/hbKE?=
 =?us-ascii?Q?ARHqMfc+Fe6Icl9U4d2BitGp?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b949375c-ea5e-46aa-571b-08d8fdda2dd5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 17:41:19.0147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EbkfH/hSpDHN6NwrzLZctJzDiMWZRd4NbbuDWUPYcyk0+mYskvNhl5JIGn94jxb4HzS09pwCooLa17W1fVvx6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2534
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9952 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120112
X-Proofpoint-GUID: 4fYELlN-QTiN7cHfdM_aIcYZ0E-9RpRQ
X-Proofpoint-ORIG-GUID: 4fYELlN-QTiN7cHfdM_aIcYZ0E-9RpRQ
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9952 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104120112
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 12, 2021 at 12:24:27PM -0500, Tom Saeger wrote:
> On Mon, Apr 12, 2021 at 11:48:09AM -0500, Tom Saeger wrote:
> > On Sat, Apr 10, 2021 at 06:35:40PM -0700, Junio C Hamano wrote:
> > > "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > > 
> > > >  * The fix is almost completely rewritten as an update to 'git fetch'. See
> > > >    the new PATCH 2 for this update.
> > > 
> > > I do agree that it gives us the most flexibility there with nice
> > > encapsulation.  Nobody other than "git fetch" needs to know how it
> > > computes which remote refs are fetched given the real pathspec, and
> > > the only thing the caller with "--prefetch" is interested in is that
> > > the prefetch operation would not contaminate the remote-tracking
> > > refs.
> > > 
> > > Great idea.  I wish I were the one who thought of it first ;-)
> > 
> > Yes - this simplifies things greatly!
> > 
> > I do have one case that fails prefetch though.
> > It's a case where all the remote's fetch configs are filtered out.
> > 
> > Example:
> > 
> > 	[remote "pr-924"]
> > 	    url = https://github.com/gitgitgadget/git
> > 	    fetch = +refs/tags/pr-924/derrickstolee/maintenance/refspec-v3
> > 	    skipfetchall = true
> > 	    tagopt = --no-tags
> > 
> > 
> > In this case, running `git fetch pr-924` will fetch and update
> > FETCH_HEAD, but running with maintenance prefetch task results in:
> > 
> > fatal: Couldn't find remote ref HEAD
> > error: failed to prefetch remotes
> > error: task 'prefetch' failed
> > 
> > I tracked this down a bit, but don't have a suggestion how to fix it.
> 
> This ugly hack fixes this failure.  I'll keep staring at it.
> 
> 
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 30856b442b79..6489ce7d8d3b 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -508,6 +508,9 @@ static struct ref *get_ref_map(struct remote *remote,
>         if (remote)
>                 filter_prefetch_refspec(&remote->fetch);
> 
> +       if (prefetch && !rs->nr && remote && !remote->fetch.nr)
> +               return NULL;
> +
>         if (rs->nr) {
>                 struct refspec *fetch_refspec;
> 
> --
> 

Less ugly fix...

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 30856b442b79..5fbffbd17d7d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -576,6 +576,8 @@ static struct ref *get_ref_map(struct remote *remote,
                        if (has_merge &&
                            !strcmp(branch->remote_name, remote->name))
                                add_merge_config(&ref_map, remote_refs, branch, &tail);
+               } else if (prefetch) {
+                       ;
                } else {
                        ref_map = get_remote_ref(remote_refs, "HEAD");
                        if (!ref_map)
--

Other ideas?


> 
> 
> > 
> > builtin/fetch.c `get_ref_map` makes two calls to `filter_prefetch_refspec`,
> > one for 'rs' and another for 'remote->fetch'.
> > 
> > `filter_prefetch_refspec` works and filters out the above fetch config.
> > This correctly yields condition
> > `rs->nr == 0` and `remote->fetch.nr == 0`
> > 
> > Later a call is made to `get_remote_ref(remote_refs, "HEAD")` which
> > fails, leading to `fatal: Couldn't find remote ref HEAD`
> > 
> > Should this be expected, or should this now be special-cased for 'prefetch'
> > somehow?
> > 
> > Regards,
> > 
> > --Tom
