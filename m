Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5E3C433ED
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 17:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 100C2613AF
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 17:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbhDERB0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 13:01:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50870 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbhDERBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 13:01:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 135GnEe7077007;
        Mon, 5 Apr 2021 17:01:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=yVziCRPT7KnyeFi3rLIAnbQjfDetg/yOqR8yxzR7fUc=;
 b=Fpk7O8BrfPXh0VSW2kTduroFY0Ml9a3KA6wSH8oLhdTWJZ5XqtjnvZv3YWbREVW+/SNX
 m3VY+y9ZMVd17kWBbbOzN/G/6mQUucTywdoWmGrUjCKPjeqxhZpL1GaKGlK/bpKMFdP/
 fOc65RLVATE6yYzQf4Ot+H2JHKsE40rBT6eqxBIzXNdYvR/kMF0F9if6dvPa4aLoeyCm
 A2o/5voT1jlZBO6bHGEKbOeLDbbbWUU98N0LUV3Oz1pQBgBoF87QbAXjarwgNr+fyAs0
 Y+fPa76JjEqZ4SqytZmURhrm/H2NMZbSDVQR+EOkvhGv7W3oZ1Eu1zzV4nrHZQ3Y6Qbe bA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 37q3f2apv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Apr 2021 17:01:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 135Gjx4r075320;
        Mon, 5 Apr 2021 17:01:10 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by aserp3030.oracle.com with ESMTP id 37q2pbfk71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Apr 2021 17:01:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wx+Mz2Rwkm9gUxOrCE6dg+IB4udgjCra8HkuEf2+Hj/GYxjZ7T9VBSq0MB92KIiNOO4bBGcu0yVrGNdc831nRhWCW17xqEMMt1kiTts8EfcfZNQilAkCQ5iCgrWNHVewdimAKSm4Ceym5lP+qavKY5bpNLSWl9oRfv8r4CH9y4RjoOx0xic+Opme0Q6NblOyE44ZaeTGN9F+dZOJvMIP7u001CyXDYtF1dZV8+k+mEWZlDe/lHMEtueC//fjyCx2ILJQV2KTGT3OkIDdmTGivaLz6MfrQPk4yzioDioplxso1DniucRHd9mpxoAxH2rQtaIHrXEOZbWKHEXQHwg2NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVziCRPT7KnyeFi3rLIAnbQjfDetg/yOqR8yxzR7fUc=;
 b=aUhSSI56xGhPQwcT1qsWlCptleZBOAjqxyd25e2hftGHf9Nz0EmbwpoAcBZy8pKD6DU4yHP0HHhljEyRO8r2a2606qJEZbdkbIeR1VAHBeZOYBzfLOrVIDsm2H3ZHhaxKe291QQwb2U8D5W19ac8NOzNBcj5HoCnJ6LjTou4B30dgAODjIaPuswNVUi1pGG3zc9aaox9klQ3YVdir803nnRwh9sk+9JJ7Ew98XQbZZIGqDkorCXlDsLee/TOYpvZLwSzLpQRg1je8KosA2g9W0MfNnZ7gA1yrU7D99u6oy0TkpRhZJqt1vHMbMonkEV1w3SwteVkKAv86ZSv3iBRqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVziCRPT7KnyeFi3rLIAnbQjfDetg/yOqR8yxzR7fUc=;
 b=NcNo75zAUV48BUIxSNpsXYPfNilqK3kWoDYOPlFO2G/3sJ6dRwR/DzaWDJu9txRKU+D0jxsqqH8yDdh7YOnYTqxYSdi40v9K289QG9Ah/CqUu/C0O6iQpco6Z7R7avL+mYtEc5MpTPLwYypCyXzYLJ2M7U743hYZPreyVpE6rIo=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by SJ0PR10MB4734.namprd10.prod.outlook.com (2603:10b6:a03:2d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Mon, 5 Apr
 2021 17:01:07 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978%5]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 17:01:07 +0000
Date:   Mon, 5 Apr 2021 11:01:05 -0600
From:   Tom Saeger <tom.saeger@oracle.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/5] maintenance: simplify prefetch logic
Message-ID: <20210405170105.fujb5hc5usthuw2y@brm-x62-17.us.oracle.com>
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
 <3a94ff80657cd8e0142c1007be4f183c6a18587e.1617627856.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a94ff80657cd8e0142c1007be4f183c6a18587e.1617627856.git.gitgitgadget@gmail.com>
X-Originating-IP: [129.157.69.41]
X-ClientProxiedBy: SJ0PR05CA0100.namprd05.prod.outlook.com
 (2603:10b6:a03:334::15) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brm-x62-17.us.oracle.com (129.157.69.41) by SJ0PR05CA0100.namprd05.prod.outlook.com (2603:10b6:a03:334::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.9 via Frontend Transport; Mon, 5 Apr 2021 17:01:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c93d20cf-1e1d-42ba-56d1-08d8f854677a
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4734:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB473471BEAF5598B83CD6EC53FC779@SJ0PR10MB4734.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:204;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r2HAwRvR2yj2Ay6M1gNfjPY2P8LG0Qb9XY3VbSXuQeNLbOX3xAbuQm3gcrX14k8lpHFUuBd4yq/ACem0cXOxUy9EVD50y5sUMbidZF8yQYMILWKooFQKib9JKl40kV17XiGMCttSauNoxc+zAyA6+igJKp2xANnowlIPRQ9m5B3Zn/K+tFqgbujviOyEJMtBm+nrgxNCeIZPT0Jp3C8YPDVZTOgHjMP+XSyN9PSpPlom1d4gm5ILxMAs+pXzRRDxBE40/4fNdWq9frhswaduqihTDljw6VLHPByjAI5UeWJIjhQp59Uss7gbqFZ7rz197c9hOOQ+g8xDelG6McyiFLvOezI9zPOrEfBQp0YgupNswh9Tt5j3eyTa9o4F5xgD5vF5B4eNI5yWKZ8BryUBYlUlFkxG2fQj4U8B6ZmXJ9fYwIa2QFxeUL5e+//8DdWPediG4c1BzVjXF8L6KOebKTmDnMMfCd7qEPTaVPxm1QUqUGqHX5NasB0SCv7Rifao1EkMq+hwWDWRdD4mvs0+13xwYp0VzEUyFg959fRL2MGIE6L9KMcx+Etz70aGLImkMBz9IJR5mQolysZdvYDAWRgw1IadDFKxpmMDU75HVHCHfdzqKRsJ4pjMIFASnu79TFYSidlLoimMqplzbwOGDZAgM+IKgb9wQiMYLDXTX2OBiAEPbeHUJS6Muj2CDYID
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(396003)(136003)(39860400002)(346002)(83380400001)(44832011)(38100700001)(54906003)(956004)(16526019)(66476007)(5660300002)(2906002)(66556008)(8676002)(186003)(26005)(8936002)(45080400002)(55016002)(1076003)(6916009)(7696005)(52116002)(316002)(66946007)(478600001)(86362001)(4326008)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GqwIcTsHZtixd2It9mfxQjHAR8UY2Pzf7D7rB3NQbENYDoxV4fCehCR9Zsr/?=
 =?us-ascii?Q?n4UpVerxxhz7eDL7jNdA7ApqjiTv7cpPXCXI0NNCj2DQo+VyrRJkAxJCXiWT?=
 =?us-ascii?Q?pbuC7MER+4A+A8leX3RpXA6mYsuXphGVidr9wwrmz6FHLp7tcr0pXBSrQKgF?=
 =?us-ascii?Q?JwaJFh1zcFIUigslpd2rq25OwBc/u884vtDd+um3bLYTlvTwpNtrGxSMzqK6?=
 =?us-ascii?Q?+BfFiN5j6Dd628jduZ1TpU2GG3mPHMKdePDv2h6CpactJIdsq2wY7B3PkWJ+?=
 =?us-ascii?Q?uuQmGi3SbyRxB4CQkQF6NOnQC5lQzxrqw62xwsApa+DN2GK1jK+paSgltBiK?=
 =?us-ascii?Q?RP8XTrz1E5bxmJKGrxIkJXRRGlk+lcQgGsKDFNrc//yijJ8F04RCcrE4kX3a?=
 =?us-ascii?Q?IaolxN7WvOmJaYL0Gvqg9FYlSTcF2bDMcWeh3KhwAnWVL+eZlXJKzu8zl30l?=
 =?us-ascii?Q?lDUH9L8wRDD4y1aDhFPxq+mp+ej4ez5aVLEM3stPDo3Mggn+RHMB0efiqnul?=
 =?us-ascii?Q?5mHnKq5zdzZAGnJT2sB0ScMQ8aL+fnnge/HW0+RaWNZWEvT4J7vEZ9Nquruc?=
 =?us-ascii?Q?9Mv+RLR5w1YrEf8qRhRjJuGTEDs+PaQ4IujF9IO6DxRyQdpxe9KYAGV2zeCG?=
 =?us-ascii?Q?hsB0WvVqw14CH9mzo6WQ0gpmwPk+ZSkrJmleVvab/EwDvBIwEqb2fy9ZreJI?=
 =?us-ascii?Q?H7YO+CvYDZsqcn6DFzT1w6Xtf1xfLWJBsBbaDIBtwZ4e66lVVr6YOiqKQcUw?=
 =?us-ascii?Q?9DHIp1dfuZvBzP3ghICMWZZTBwQ3fRDpMgbrfN052HuPL/KVJSeMZj006wnK?=
 =?us-ascii?Q?UBNQvQRgvDJjcd+VmCU+cwFHQprTDyFoeH51YpbPCG0OvFT8/XHjKCUvEuj3?=
 =?us-ascii?Q?0wr0txsd+JWx8IZxlJtn2rhtizm6iedu8x0hs7R8T8VeXPO6q8HynSzbLoHu?=
 =?us-ascii?Q?d4g+sG9t7bYPJu/XyXrGZvJoiuD6X1ugyz66CB/EXjdpgStuRSSNM/QWbDwD?=
 =?us-ascii?Q?toQIyqTag6VYaGI0ZhYb0zN+QxhmaRJ2mhUvqoy4NM+XrZNX9cK60dnNtKyt?=
 =?us-ascii?Q?YDiLq7BYf/qDPghmzry1q/3kF4bTne4tf+ZIQuvkfmndMACJHn62XOyRK3vO?=
 =?us-ascii?Q?uLanQknhwfTE+w98LnkYCKG4a+YAj11fu8mDeOCDer0i38sHbeZOdEVqqFQY?=
 =?us-ascii?Q?z7qh7AcqC8VPtT10ULmuvJ+D8cOumg+RqI0915kqgUxcgfjC0yUJ2wJ0cc/3?=
 =?us-ascii?Q?GSfOvEnzA4OzSF7LOV0FcBebp2t4PsvPK0XqaAK3gCarLcSIo1cU0Bru+WC2?=
 =?us-ascii?Q?ucaShqS6XBo8T8WAdbDnA8cj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c93d20cf-1e1d-42ba-56d1-08d8f854677a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2021 17:01:07.2985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y/cD2GU8yk74BDswXu5ogA69enmYQcNbVHL8ciZ6R6r6Wzqee3mYMn3B5yJpn8/zK8ihOF/K196EpZFhL8dh6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4734
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104030000
 definitions=main-2104050110
X-Proofpoint-GUID: At8h_P_24qv19ybwepkzJivSmXlPeHqM
X-Proofpoint-ORIG-GUID: At8h_P_24qv19ybwepkzJivSmXlPeHqM
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104030000
 definitions=main-2104050110
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 05, 2021 at 01:04:11PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The previous logic filled a string list with the names of each remote,
> but instead we could simply run the appropriate 'git fetch' data
> directly in the remote iterator. Do this for reduced code size, but also
> becuase it sets up an upcoming change to use the remote's refspec. This

*NIT* because

> data is accessible from the 'struct remote' data that is now accessible
> in fetch_remote().
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
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
