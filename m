Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91B4C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 20:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 973126121E
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 20:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237957AbhDLUNs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 16:13:48 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50136 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237307AbhDLUNr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 16:13:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13CKAQXI062270;
        Mon, 12 Apr 2021 20:13:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=HQX2Tlt3Eht1TWQ/6GdATmt1jhSEt9opfl9x5Na1+4s=;
 b=P4yyZTgZHkjQ1YTfjvLPlVGFnKw7j8kpGfhJewmaSp6GT2ddv1zdn00Pp+rWdHvXJqgq
 mrby8j6WSdnuKB8tRNzwEe9ksuP7G8sz0Vs/dvw9mju9HCFGhRLIhIVIerXUjI4Z+OHH
 aAxjItLUdbpdzWvK7rrMpUf/ug9yfQaaKNEAEQuVqfFQZW4ovSn34yHnRUuSTsTlnpEF
 vWF5oqZGpM805q2SMa0BTRBnfz2Q+tNQuBti7D6lRBKHuF8pi0wWFKBUg/6EWAZMNqkK
 Wdz9TzHFytONJmo8cuU+GK8CRWYt64ZCbDetE6aiirkA2/wcadElhk9SP34tvY8+dG5f xg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 37u3erd0pe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Apr 2021 20:13:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13CKBcxP072183;
        Mon, 12 Apr 2021 20:13:16 GMT
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2051.outbound.protection.outlook.com [104.47.45.51])
        by aserp3020.oracle.com with ESMTP id 37unwxtspq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Apr 2021 20:13:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GS9IK5faCaICTQWqJs5OHzpOCy6XVlDVpiHqMtnxCjx65meN/vYkVFEk2c0X8sgo4TXjSA+XRflQulkjz8Ng8/9ynGIOo8OIR6MUD1tmt65vdQGnwOrx0cDI9OWSxyq+FREPGD71OfAeyuKDLEAk5Bt9lMPZVYR3CSTq1/LDr5CyVS3fiFB6cj8owOTpuQgfYbT42sArDuVTEFnmTjZOnDmbKHGkkRUykdWTEgOOt477FWcVHBcJFlAK9NthhiwGu41eYdf6INbgCelh43EGKTgDAMZhpk14hhZY1fSRLxsOiwLO0gA/2ncQ9JA3sZg7vRN0pZCfFm+21Bl7dShBSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQX2Tlt3Eht1TWQ/6GdATmt1jhSEt9opfl9x5Na1+4s=;
 b=ctX8APMeyC41mvhUJYy3QB0atfoIt3YEREAPl8s3dDfAV/LHlRumD33bt/oUM4YZNDzKiRaCMXX5KalZcJpi8rOcsAwD7DjUi+cJ/XSj1aE/HPOK2a6KrBoXg0rNRUArh5LhcKXGNGHUoRTGRHFgYL2XmKs6BJcrS/KLDvhZbr986y8ZRUZq2oge92rqWdf4gBimEoGJFfpTa+rP6JSpGTUHhjELZOrHOyBWdIVQnpwLgKSzIBsotTN3l09pD88XovoXDI0L9yEtzZxQ7ouQd1QxBoHtZddZG7VeEtr7tq0ybvpw2uJDGnUdXiVsoPhaxpCMGFSbEAGky+ILKBdJfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQX2Tlt3Eht1TWQ/6GdATmt1jhSEt9opfl9x5Na1+4s=;
 b=ZGh76zJZLgL7V3waHwYI4qrdlq6+nNJz0XMwkmjvEawVU2x8oMHWiJ9bAciEAy5iBe3R7GOQzzIWiyrfHtTYF5RsjdCvyztKIdJq2rGnNFcbYRN0qiwZS34sKUi6iwbgr9C9vP8w/XIoXbUwbsyVkDCD1fsXezHFb4l0KjSimC4=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by BYAPR10MB3525.namprd10.prod.outlook.com (2603:10b6:a03:128::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Mon, 12 Apr
 2021 20:13:14 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978%5]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 20:13:14 +0000
Date:   Mon, 12 Apr 2021 15:13:08 -0500
From:   Tom Saeger <tom.saeger@oracle.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        Derrick Stolee <stolee@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 1/3] maintenance: simplify prefetch logic
Message-ID: <20210412201308.teugitvky5cctcio@dhcp-10-154-186-72.vpn.oracle.com>
References: <pull.924.v2.git.1617734870.gitgitgadget@gmail.com>
 <pull.924.v3.git.1618020225.gitgitgadget@gmail.com>
 <4c0e983ba56f030851370ef71887117db45e8479.1618020225.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c0e983ba56f030851370ef71887117db45e8479.1618020225.git.gitgitgadget@gmail.com>
X-Originating-IP: [70.114.130.219]
X-ClientProxiedBy: SA9PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:806:20::24) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-154-186-72.vpn.oracle.com (70.114.130.219) by SA9PR03CA0019.namprd03.prod.outlook.com (2603:10b6:806:20::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.20 via Frontend Transport; Mon, 12 Apr 2021 20:13:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42c18088-a7e5-4765-e97f-08d8fdef6707
X-MS-TrafficTypeDiagnostic: BYAPR10MB3525:
X-Microsoft-Antispam-PRVS: <BYAPR10MB352527B7E05C2F0B6475D17BFC709@BYAPR10MB3525.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C/C3Byp24nXAtb7Ch3ysFiahmQrXFiLNifmU0zvfs1tUuPhGdwfGeQUyw7XmDbyq4HwjBtFbGyQ0+FZ+liKJAUjDn/P2kXnrkQR/L0ABJAgyyw1w6ry+AnAZRFrkUOhG3DbgwlFPOH3ieLx54PAKHyi8RoOLqzvWeTDvTuSmI7FL19bq0DOCwrOEpKbMbDf2VIfKrQghgKEw1qD+XdZ8aJykBRO6/cBZUHAMI4v2M4fzFbnSF0rBXsE5MEXjs4D84MxcZb4E80Vzb25cnLcyoX20FoJF/0B1wyOQwZWjEBXETWUhKHWzrE2+9CGHpnKQZ/R5JY1ZGh0XSluN2A12BdpsJal/0USytbWkuQOEXPCR2O0NFl1UUgf0oWCOZTDSVi6A3AvlAIvZaXk8MVDmbmktvEybfWyItpJxxYOo6/GS/V847xqKqOJ8/0E8xvZYjDb2sooXo87ydwouiLAqFd8CzF17ma5XSJEecLBD9oCDg+Ue7kR0a5jCpt/HQ4MGq+tLr+/vo//RFh1cKrUsJlpHZCto4dZVkIThPbpvPiwy1alzsrwpN0R2vLpCzc/2Uh1Z2Mlov/kPscma2yI4hbw/bE+XGiBii93T01H2kkgfOE7K/njRRuRo2p0A853bRq1h4bFUxlavQKNYr3DkceLAWJb3xlcqJu5SVxOFVlBN4khK6llEwri4kJUe25xfJPfcE8A91VlToPohYkA1xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(346002)(39860400002)(366004)(26005)(8936002)(16526019)(8676002)(38100700002)(316002)(6916009)(54906003)(478600001)(956004)(38350700002)(45080400002)(186003)(44832011)(86362001)(2906002)(66476007)(83380400001)(66946007)(66556008)(55016002)(52116002)(5660300002)(7696005)(1076003)(6666004)(4326008)(102196002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Ofeq7GBj7eq9tMQI8fQINmy7ETltcZtaky/1WmkXVq+mbqCyewYbz4rWTmIA?=
 =?us-ascii?Q?bljssFx1ygL1HbpBnsxJ2sK0Gqbrd4tPey5bAVu2McfOYhEo6MUdCfO7uJNO?=
 =?us-ascii?Q?wyzPuN/WFASuTgSPJuPNTtxq/ainGRSiNFztxhXWenQrGsX2oMtC/ZHmRIvp?=
 =?us-ascii?Q?ZDNIVncH8MxikA0l6vxxaR8UI9Y2YS9np0AgpFoHjNPJU0jRsG2023kvqphD?=
 =?us-ascii?Q?rjURSmsaG6N9SoAUqLg2zkIj9JoJm5fdo0KAsC6vfRRdgqU0X+zTxzsaVSAa?=
 =?us-ascii?Q?ZAEf2rUzj3uf2BKOIlaemcHLxmdnnk3AWCV9M7DKGSfHm+juurvtOlpqG5kr?=
 =?us-ascii?Q?6hjSjMpnJrx5HiRy0C7lH5BjOp3w+6qIoSxlV1ZebnOOKScowoofBTkOrKMa?=
 =?us-ascii?Q?t7D/wbMgpS0ahREWkLeRWPKXoSJ0Oa4VjuDecWgDwxllZrPcPPEenPi0s1tQ?=
 =?us-ascii?Q?wBxvHszfEZUyC1WBrCUx4uRPpoL6TFj1GzdH8pMhCGi+w0xiQbdBIOb38g8a?=
 =?us-ascii?Q?lxr/DIVFk8sCU4lhjID9c/fKxy695CsjIk2eb22bYLNWSngdmQu++XtSaZ0G?=
 =?us-ascii?Q?boakHF25ddrs43R4p6d4nsG2ZZ9dZKxxNV0i+NP00YA+rq8KowPqGX2bdzAb?=
 =?us-ascii?Q?n37bjJ71ofx5vqX4vRiz/sP+utCBluRHlcVjuJ9l5F6dKSrJWCmjj2gtJ2lx?=
 =?us-ascii?Q?4bbdWzlrGSy9eGYgp+fZvRzLStm42MNv1UGG0nyJcr3RXqDzcjUflEq4bZe8?=
 =?us-ascii?Q?hXuXghyv44MjvSYD8Df6Akw1tA5Gvbt1DzQXg25GkSN34sPDr2n159qkQ5ip?=
 =?us-ascii?Q?3dz0kB49/SMq7AC0I/fTz+koF4WngiReDirFuUNHYuhcY6KMxTGqUfsb+Bxn?=
 =?us-ascii?Q?Kb8TGInjJib5TSeVaER9iXQvuSnIfu0J9IpJ8eI6JBu7I2RMskw8q4OFO9C3?=
 =?us-ascii?Q?hDtDCqbY0Vf8VkrC/KDZMSMgYgf1HJ4W6ExFhxj38/Ekret/l8drINnCFr9f?=
 =?us-ascii?Q?eSjd93caDhBTX4JinlzKRsUR3TVq9UJ2av1m/ThWh/7j/fDtBjdyQd+ouIAF?=
 =?us-ascii?Q?pv5HGZH/C6j+j+NZOkmlQS1goWMudW3eqSh8M0h9ABRq6MUBYpg/cfU+YQHZ?=
 =?us-ascii?Q?fJOYXXIpT1A6XIl4oIbViad0CQK75a0W6XbG3b5mOvst1v8NPwJzlm7N97EQ?=
 =?us-ascii?Q?SpZR0vBUGantgmWlUerONA7JAHTCzu8SFJ4uBo5u6kmAozIJD5wqxBw1ax0o?=
 =?us-ascii?Q?GUC9mtRitVtQiqh9n840fERVHpT8d6Zr4Xu4mT5mxMF7LC6bN46ozpsJeSfB?=
 =?us-ascii?Q?xgVPUUw95tc0AvkX5ZT+wFmT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c18088-a7e5-4765-e97f-08d8fdef6707
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 20:13:14.2806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: njksmqQMhyPtBJ97YoouNAkwpyhPY6qtpx+4uI+4mBenEGGuVUchEeaA1QrAtUhIfiTwlSHxxfI2WUqGIy3a8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3525
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9952 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120129
X-Proofpoint-ORIG-GUID: AjEGV88GPiDCFrDAsmkrGn86Ne4sTvqB
X-Proofpoint-GUID: AjEGV88GPiDCFrDAsmkrGn86Ne4sTvqB
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9952 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1015
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104120129
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 10, 2021 at 02:03:43AM +0000, Derrick Stolee via GitGitGadget wrote:
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


I think this might be appropriate to add:


       if (remote->skip_default_update)
               return 0;


maintenance prefetch is acting like `git fetch --all`
So it should also skip remotes with configs `skipfetchall = true`
Agree?

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
