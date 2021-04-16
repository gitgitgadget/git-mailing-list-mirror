Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBBDC433ED
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 18:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 364256137D
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 18:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244156AbhDPSDc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 14:03:32 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:50008 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243844AbhDPSDb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 14:03:31 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13GHxdxO123218;
        Fri, 16 Apr 2021 18:02:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=P62h27ZcmPVlg6fhN7ThIEVXTrdHIh4Yb1JXkTwKWns=;
 b=LM25ULI8ADp8p4Zhu+SG5N7MgwUzaJ2QhfI5hNsHpfvKGgI48QR5pXNNn65XBFy6lrEc
 4nNDHv7ISKBLAqPPAI0/WSLdSbAxsmPfYiRQYa8iZQomC7cuJMuI/YoV89iyqQqbIFYd
 MljAV9QcOi1Uags57VYdRtqVqcK+Bl2/U5wSBfKF0Cv25nhpo8+WkgtXgAReesEuqSTy
 ISKioJD6P2fsLwSi7DLW5C/WleVLzx6PpIfT9g1KCVKdciFtYrqyeI/yIB4YetuEVmwy
 aQOOoMadTwD1dv5/elRNr29htou8cfKR9HKrxUZ+7T6Yzw9eVEPWrLAogC/EV3mODbru dQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 37u1hbt2qm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Apr 2021 18:02:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13GI0a8i010747;
        Fri, 16 Apr 2021 18:02:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by userp3030.oracle.com with ESMTP id 37uny30rra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Apr 2021 18:02:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eleQB5Tfearxm5uFHTzJD+EbniwQOk4yA8m/dMFIhjOoZ2adJ1iGL2V5F1C6Y7sqNzbo46MPG0iLJNrRo69MrVX9DSGaydA47zoueUL8A+2D6GCQ8Z4lp+GyKKEXUVYVIRjlT/Y9KgxvTvlgkjsrtPOyPwLKtZFeaBH/uOEYwfvDSLGTD4KuWruPYVNIEo2kVirFv3iiujrsYFzw/y5atR6HQO/WwiG6NHVftXeB8E6qQ+s3CMJLgY8yiZI8wLeiEp4/YZMqdgGavgoqpbpWRU/dF1QieotrkYBS+5aNk7wZQQNCCQ6LLhOg8Qw2KhY1YfHK5wQj+6dhDJ7G5DxTRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P62h27ZcmPVlg6fhN7ThIEVXTrdHIh4Yb1JXkTwKWns=;
 b=FKZQhmoSsUZcz1tRpkyQSlE+aaa6dXaHnMt1jcdfJMybWH4wScL8BxCk5AJQAAx+rYN84ysBoCNTAfphoagASQ+XMakkqYEUDdHlI8dN/CnsXWlIPm8RTg6PgfLINHU2wb7kTicrDVpuqEVcDgDFadPpdBbuOdpAClUkIPpUL+oTYW5/ZQj7rQ78WeSC7FgrEflZNKl65XuEdyH7lm/ilv0UUf0LwrvQu3nusiLEff9DJ+tf+Wrb0PJBP3UrCzfi7doRKfzPFBn2/RM1Qvu3iNB+71NxojJ3Fkuybhn/EglXMc23vDpId8nHgUevfPXiyt1JHvbCnNy/Dz1v3s7DNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P62h27ZcmPVlg6fhN7ThIEVXTrdHIh4Yb1JXkTwKWns=;
 b=oxVlsXPKHqN8W9Sokyt7Bb4hc6tdHhhARUAOKmhSIDo971kZsgqOcRAx8MrAYUOwOOEmFYQheD2/2pc/Nnq6tU2QMhkj2YOG7SeJKRo5PfO1ha26X1gJrilmheVGDF8PutY1Iq7CNo/VsR2tV2l3vis90MYPzpQV/ERjLWhALzI=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by BYAPR10MB2679.namprd10.prod.outlook.com (2603:10b6:a02:b2::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Fri, 16 Apr
 2021 18:02:44 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978%5]) with mapi id 15.20.4042.019; Fri, 16 Apr 2021
 18:02:44 +0000
Date:   Fri, 16 Apr 2021 13:02:41 -0500
From:   Tom Saeger <tom.saeger@oracle.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        Derrick Stolee <stolee@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 1/4] maintenance: simplify prefetch logic
Message-ID: <20210416180241.sxcbs2fg52r7hmjz@tsaeger.oracle.com>
References: <pull.924.v3.git.1618020225.gitgitgadget@gmail.com>
 <pull.924.v4.git.1618577399.gitgitgadget@gmail.com>
 <4c0e983ba56f030851370ef71887117db45e8479.1618577399.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c0e983ba56f030851370ef71887117db45e8479.1618577399.git.gitgitgadget@gmail.com>
X-Originating-IP: [70.114.130.219]
X-ClientProxiedBy: SN7PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:806:f2::17) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tsaeger.oracle.com (70.114.130.219) by SN7PR04CA0012.namprd04.prod.outlook.com (2603:10b6:806:f2::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 18:02:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9113337c-40b5-4841-b2f3-08d90101d5f8
X-MS-TrafficTypeDiagnostic: BYAPR10MB2679:
X-Microsoft-Antispam-PRVS: <BYAPR10MB26796EB8AF8003E1AB248A29FC4C9@BYAPR10MB2679.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:204;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7h6B+a2fNQPzjY/BaNmwxp/M9GW7L6HvOxI9EPtTDoNWzZq3K7zU8JzWm8YJT0BN/0I7Ik2NoEvLfMnpeZGJq5fNnOY3ktXr9ENDqM+9e1XymRkrvajFy/OxhRQ/ACXOjFHfOMXwzIrjxwmlTCMX3O0eA/vEK2T0IqYe6UKluDQ7NH1Swe6+fWIVJyW6RQ0d8B8t11IWv34Gb59qOtQW9NsqGofvdeFTzbtfslOmoeGS6HRtOSvVLwlv0F81+C4NzHrauOpCdY5lo6jU7kR85CwsCYHo+/ozdM1hpji0975xtHQt8rq0SFABUWyyE7BI+O2pvODJISxpP6dsEOl7ZJMGq07pnOJa2FUIDrVXyPW+odUThBgmGxoymCIACwROk+OMolMTC9cIR/kpN2p2zaUk0rLk09zNMT/k3GfmHg+PJMUTopMMKq4Ni22EtnG+8Lavyvg50gL/tFf12S9pGZemw4hC4AJH6MzF/Mpvqlg+1rQfVMoQ3IkniaRCB8dYIIcLeaT3A77ImujNhf8vfOKg+lEuHZF3fFWRrn7W7bCe0QwWa0OcTW16vl7aYI40idw/nNpgczHFp/mYsyrwWoW/QvEsRWMA/uIt6WPqhrlF4EsuYBOkoL6ZDqjUqu8gCODshfkj6Z/tFKm84W5lh0Set3oRN0zwsoMK2a9Fr3o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(39860400002)(366004)(346002)(396003)(54906003)(5660300002)(52116002)(38100700002)(83380400001)(8936002)(26005)(956004)(7696005)(38350700002)(7416002)(66476007)(66556008)(6916009)(66946007)(316002)(186003)(1076003)(8676002)(478600001)(86362001)(4326008)(44832011)(55016002)(45080400002)(16526019)(2906002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?UcueWRBdsZ/+N0JdCg6fo1xq09kjp7o6Ymb1T44OW7ouS9zmeKo+vu+Lb3ad?=
 =?us-ascii?Q?VUUiq2wnLKcDnt+e2+lyhFD1FU7WVYPA72eyEnR7uwCymIIjrbaMBv7eGieC?=
 =?us-ascii?Q?MUXPuZJvP8uN6cQ5JFVAGwRkECHunAQOOC1IYYPxpyo5itEd52w8vqymBMfN?=
 =?us-ascii?Q?SbRqmN83IOBjyC9o+P2A1v/8KVeHZsJtrwsbYrG4kETamLUxj6NuX5WbGOra?=
 =?us-ascii?Q?IW1NzxMXaYL3g5njf+WRF8RGA1ymuFhi2+gY/JWS3Am7fFKFH4zTk3O+67AS?=
 =?us-ascii?Q?yuLE/e0n+ZXFtlsDCQeeDGuzj1q9gEiVa5mdBvA4egJ+kL4xR+Z20Hds1ozV?=
 =?us-ascii?Q?P034a37iN/mmWGsbadGO1cs0+88t5whBDV5rqEkqxGaTGPkneoKdXAMPL5H3?=
 =?us-ascii?Q?AVV6U0JCiEWdgsps5JvL8a5VcuLsilDBWiUfaYZYvJ/6UzqKnMiXZX8FNYBQ?=
 =?us-ascii?Q?TMtOPYYgZJeCX0fKIhhtx9JY9D43S0OIJkbH3ekjaJwveXfgiCi+k4Y4RxZc?=
 =?us-ascii?Q?HkzSgQG05bfIeq1t/oLW3nCEf7r0f60HdEQa0yE+7SiJ/9Q3ZEQCbe8w1RfS?=
 =?us-ascii?Q?wTKe5dnmi6VNDvvDKcb6ajUnwhKNnp3ls+v+Wl5jdQlv4TYdcIlIRo3YQNK2?=
 =?us-ascii?Q?51dg02VkJ7j2RlOZg7WJv8SGUTPPIQUGDjzTR6sksdMLixzE3thykqQPGWh5?=
 =?us-ascii?Q?GIjguYMkyMDV8Pg3bOw6oz8cLZTKeC9zmKlDWGhI3N4WcVBKZMB0W+SjFkNV?=
 =?us-ascii?Q?KdOb/o0qRrlPRNQg/ZGr7lfwouojXMtubawApPQpMYRdvzm/LcRdwMlSD2aS?=
 =?us-ascii?Q?KjlnmXEakpGo6jGtvaezF39oC/0dx+tAg4nQr7SkMCDdEGvdRWwulh6MXIeR?=
 =?us-ascii?Q?lpw/QIwY3pHP6UwareCUZC7aiuGtXDSA0vKmhgFxe0zjsG04eptiFpv5fhsp?=
 =?us-ascii?Q?+8RWhOCSfl9rjv2+z9rYKfyR1VKaoN3yb3T9KpEbNAoaPi9JnM9lbq5sKCoq?=
 =?us-ascii?Q?zQQMfEosT7Nzp1WbeHMeaiNgLcwiNbQLPHaQb5za8RB8QleOKoTbOeaxk1PQ?=
 =?us-ascii?Q?MY7SVMuEJYcWn/Um0zg+aUwd9EeImR8KqyzhSZ290mmLDkfyfk7pram2A7Cy?=
 =?us-ascii?Q?Rg8cEqjC+BbMPu6WlAs19EUM2YgGrZIw3j9hcncqB550eVsKFtW+dYxbhAji?=
 =?us-ascii?Q?7uWZSfi9kgePpeTrZ+b4LlX6ukZBCftT40D8T/0f/apZHIxvfAf62retS9AS?=
 =?us-ascii?Q?39Tv6vneOH70AJf6QO5J1j0VcaRCqtjKtUpAVpRCLPcroyl2gLUJvhpmpIe1?=
 =?us-ascii?Q?YFlDcvuKVCTCX52YnMoHbI2N?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9113337c-40b5-4841-b2f3-08d90101d5f8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 18:02:44.7355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 32m8+QcmYB5F2x7xbEO0XM0khSDEm9/57GCzu9nmkpb7GKSIyPjRlagsK0aEg3Vw89Kj65uUcZbm+jReTcLhFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2679
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9956 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104160128
X-Proofpoint-GUID: V4cZOn88QQ8KQjfm8qSXzAavF_GkZkNa
X-Proofpoint-ORIG-GUID: V4cZOn88QQ8KQjfm8qSXzAavF_GkZkNa
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9956 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104160128
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 16, 2021 at 12:49:56PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The previous logic filled a string list with the names of each remote,
> but instead we could simply run the appropriate 'git fetch' data
> directly in the remote iterator. Do this for reduced code size, but also
> because it sets up an upcoming change to use the remote's refspec. This
> data is accessible from the 'struct remote' data that is now accessible
> in fetch_remote().
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

Reviewed-by: Tom Saeger <tom.saeger@oracle.com>

> ---
>  builtin/gc.c | 33 ++++++++-------------------------
>  1 file changed, 8 insertions(+), 25 deletions(-)
> 
> diff --git a/builtin/gc.c b/builtin/gc.c
> index ef7226d7bca4..fa8128de9ae1 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -873,55 +873,38 @@ static int maintenance_task_commit_graph(struct maintenance_run_opts *opts)
>  	return 0;
>  }
>  
> -static int fetch_remote(const char *remote, struct maintenance_run_opts *opts)
> +static int fetch_remote(struct remote *remote, void *cbdata)
>  {
> +	struct maintenance_run_opts *opts = cbdata;
>  	struct child_process child = CHILD_PROCESS_INIT;
>  
>  	child.git_cmd = 1;
> -	strvec_pushl(&child.args, "fetch", remote, "--prune", "--no-tags",
> +	strvec_pushl(&child.args, "fetch", remote->name, "--prune", "--no-tags",
>  		     "--no-write-fetch-head", "--recurse-submodules=no",
>  		     "--refmap=", NULL);
>  
>  	if (opts->quiet)
>  		strvec_push(&child.args, "--quiet");
>  
> -	strvec_pushf(&child.args, "+refs/heads/*:refs/prefetch/%s/*", remote);
> +	strvec_pushf(&child.args, "+refs/heads/*:refs/prefetch/%s/*", remote->name);
>  
>  	return !!run_command(&child);
>  }
>  
> -static int append_remote(struct remote *remote, void *cbdata)
> -{
> -	struct string_list *remotes = (struct string_list *)cbdata;
> -
> -	string_list_append(remotes, remote->name);
> -	return 0;
> -}
> -
>  static int maintenance_task_prefetch(struct maintenance_run_opts *opts)
>  {
> -	int result = 0;
> -	struct string_list_item *item;
> -	struct string_list remotes = STRING_LIST_INIT_DUP;
> -
>  	git_config_set_multivar_gently("log.excludedecoration",
>  					"refs/prefetch/",
>  					"refs/prefetch/",
>  					CONFIG_FLAGS_FIXED_VALUE |
>  					CONFIG_FLAGS_MULTI_REPLACE);
>  
> -	if (for_each_remote(append_remote, &remotes)) {
> -		error(_("failed to fill remotes"));
> -		result = 1;
> -		goto cleanup;
> +	if (for_each_remote(fetch_remote, opts)) {
> +		error(_("failed to prefetch remotes"));
> +		return 1;
>  	}
>  
> -	for_each_string_list_item(item, &remotes)
> -		result |= fetch_remote(item->string, opts);
> -
> -cleanup:
> -	string_list_clear(&remotes, 0);
> -	return result;
> +	return 0;
>  }
>  
>  static int maintenance_task_gc(struct maintenance_run_opts *opts)
> -- 
> gitgitgadget
> 
