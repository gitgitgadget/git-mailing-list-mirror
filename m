Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABED5C433ED
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 18:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 843A1610CB
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 18:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbhDPSb7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 14:31:59 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45164 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238226AbhDPSb7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 14:31:59 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13GIUdux160137;
        Fri, 16 Apr 2021 18:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=CKlrACzSXJOqgyvidwygAUh248Mm4wrzls4kpVz7nPw=;
 b=s5gxUOSWQmRlgn1CSq024xntXdYCQeAp3BV23cQgvIjL7bgXnr6YDRMvKaNwOEmvZGax
 kTqKO6H63NQl7E8L2XTVP1SCmTRD0NqARbHhxdXY/uFJ04DkKUs7xFRijHE0Tv/Necrp
 Dwb01Hb8rVTXXS3XylLcbm9y3vWXCfJNZccOBZ7hB7KJaxT2jgO5DYbgsYz+R8A0lkBq
 508ECnY0AUJg042la3HMd/e26423qZo95P6zFcFy3mfG7h6jps+i+tL2NKq9O/69/+ia
 UMCUpOpAmy0sA6/T5TYS/ThJj4f8vTbbPrLGbUw8thx/dX3TPkzWaPx7aPJFHvVXLasX Ng== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 37u4nnsyrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Apr 2021 18:31:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13GITsTc189996;
        Fri, 16 Apr 2021 18:31:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by aserp3020.oracle.com with ESMTP id 37unx4v6ff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Apr 2021 18:31:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGiEU394VJ+lcdoHQB58XWtYj260hAl0rCDGY5qRQwu7wrD4mpv4AViVt85WmJVjOW+h5NKSqAcmKAqxIOlnrwLHhB1OeRy3Ag96bYJrIHBJ8SNxlZ9AVuYW8iQtQAIan8yTh/ZcysMuZ7Gm6++YZkHZXR1rY6NgZ6/I2dpCtE2tEk2ewhkGzWdmGwFIxvlNCUt6199Lqqdv782habQC6pUB5gq61nVw5LOYaWIYk2pFejUvjlSaNRnyabcD+u8LG7HhaKk9Enky5U8JISFdve00jnCnZn61nLW/ksqEvZDuOlQRAFAgAS+NRPG/Kw60lUgAbAijgqmI+Fj+C6EZ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKlrACzSXJOqgyvidwygAUh248Mm4wrzls4kpVz7nPw=;
 b=LSiQ+WvPXlS1M5hvaezAMQNdFsKvUgnhCdJ4cOWdaBzopewbolT54l294CTp+uNhEusSAPypFinOzZfElD7/G6LDv9f7STfDyml3vdfwiBYnsCVk5i+3dCwjhMbujYTkuPEa541LRKWtuviveR4XF+eqx/JkFqPjjRuvoYkUM3X9IhecEZrIHZBS/yGJRiZThXjxAGsY88vCRlzi7zx4jEWmpZVQ23RAldwRT3Bl7bIdtu5jv5h8xbmT7xY+rE3fidiRVrJqMQHsjBHsw1iAi8R7nsJa8uDXaCOS9I2rd/DUkGKAkUNcHfhyWRJOQyIlN5YosckoGc9smtNAtHm2Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKlrACzSXJOqgyvidwygAUh248Mm4wrzls4kpVz7nPw=;
 b=WMzCNP3ERbH5YRsEYfaPRSI9CPkHRXofb+yuXmU7anBbBwgnylxDGDtxs+qumueDQJCdHZgWhBL2irPr2XnPWJoeWWUdzXsbyMDfsiy4Ev+jP7bp8hOWAHL1R20EuxmD1qxwx6p/zfs+8e+hqa5/apGik+Fcs1+mXFzl3N0J0Do=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by BY5PR10MB4004.namprd10.prod.outlook.com (2603:10b6:a03:1b2::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 18:31:19 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978%5]) with mapi id 15.20.4042.019; Fri, 16 Apr 2021
 18:31:19 +0000
Date:   Fri, 16 Apr 2021 13:31:15 -0500
From:   Tom Saeger <tom.saeger@oracle.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        Derrick Stolee <stolee@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 4/4] maintenance: respect remote.*.skipFetchAll
Message-ID: <20210416183115.vzx2zj3q23bqtj73@tsaeger.oracle.com>
References: <pull.924.v3.git.1618020225.gitgitgadget@gmail.com>
 <pull.924.v4.git.1618577399.gitgitgadget@gmail.com>
 <92652fd9e6e17654abdb30625c85937b6b56c38e.1618577399.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92652fd9e6e17654abdb30625c85937b6b56c38e.1618577399.git.gitgitgadget@gmail.com>
X-Originating-IP: [70.114.130.219]
X-ClientProxiedBy: BY5PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::37) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tsaeger.oracle.com (70.114.130.219) by BY5PR03CA0027.namprd03.prod.outlook.com (2603:10b6:a03:1e0::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18 via Frontend Transport; Fri, 16 Apr 2021 18:31:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f95e01e-1ce5-4a1b-8df1-08d90105d3cd
X-MS-TrafficTypeDiagnostic: BY5PR10MB4004:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4004240EA21845F4C724B8A5FC4C9@BY5PR10MB4004.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o+aiUyudiW0jtbBBC14oXTcIYa+lHh1bGmZ9eJLTlarZrHpj5L8ZbxhXk2ucv8iMYueh7f1d137LLi0NM4IMzbz+skKJD9y42O3LjyAiE5Zr0+pXLvACMhUukVo0N9pdz/+RN69akk8YmznK/OG06XdIkK7Rd670sElSxdYXO6msV2MsP5xBe/H1mHtdvhWf2RAOQXN7LL4MWFKtWHI9qoYaNMKOtvwbuMHHqLeYx+ThLnqNGcsx1xFJ/DcuRS32eWUpbK0NtANXkJdK6YUt4jg++hopUMumDN+N1LlVflzp38DGoqkbQwrlgPFM45ZLay/E097wPPcFGjp0LRhjBqVJVGT9m6iU8LvB5+Hq0L+1n2ZtMdw/ZMoBQKF+uQWlOvUJAAVphmb76QaE9d6dC93sTzZPwxYEgTKvVc7mimCGETXzbbscJTUCl1z5+4FNlwr/FahZ522fMB3r/36WvWXNgaMrD1kM5zCOF2PYewrNP80diEa0WKCUIHmz590Nmwom4fLBtUSMIre8xvAs15kEdBVp36EmQ2FuIDkMuLzt20p2u02jiR1+PzzERAMp71dJW5ZfUZ6kfcWWaIPtPk+6lwqER3dIsBB0oUm2q7jMCRZemRcA4Q4A7hQBEwOMbfpRwTsLJ9pwOkgkY2BhZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(376002)(366004)(346002)(136003)(8676002)(45080400002)(2906002)(83380400001)(55016002)(6916009)(316002)(1076003)(956004)(478600001)(54906003)(8936002)(86362001)(19627235002)(7416002)(4326008)(5660300002)(66556008)(66946007)(66476007)(38350700002)(38100700002)(186003)(16526019)(26005)(52116002)(44832011)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zAwAtbS9aABw7tnuBkn4bhE0ia+xDPnBBBrGmCFsdp/Ah16iD/VcV417CZg4?=
 =?us-ascii?Q?jTe5CtGNvvI1/M9JqzgQg89Upti3s74XVDC5QD36IGnNdOiAaNf381/CDDPw?=
 =?us-ascii?Q?ybfzXX7mo0tdVUNLdAV+PMzLohRkPa2T+HtQaqc7tjILgFCt1/kZPZ388E2K?=
 =?us-ascii?Q?04truRTrXcXFEGBCVitEGOp7UqchbsOLYu2hDZUXvbhBVXdInrky2duuG/6B?=
 =?us-ascii?Q?YAIk3hTgjVcDzsZrhd6mhRT6NEmdYom5hKcTjebcCJBFduLc1dW5nOtQ11Z5?=
 =?us-ascii?Q?BOxoTrd7pVblGoDHViIcKvJoZzlV4lbgQ5Coaffv9XDF/gyuJGOT7qzKS0Iv?=
 =?us-ascii?Q?qZOf6pS0d7Y4d5Q8fhpJekNnfbQ2GtVRiImIW24xs930Y+lqNZ34/J52ALT4?=
 =?us-ascii?Q?34FF6yaL+z7DX1IjvQSnWysDRRw8TKAwCHRu0RPd7ipGvtxRG3liJAuglJhB?=
 =?us-ascii?Q?YiBtx+nMS3lnolFjpEGjebuiVt2REUoMe45jQi2GWT0gCgCsvepNqyemFffh?=
 =?us-ascii?Q?h4mYMDTNQvgOEEOXxlqIQOQ3doE7ArsiNLbZoGBMs3KVPxJwZ2nNX47GGyk3?=
 =?us-ascii?Q?Ur/fkondnG7QzOlTj0uWwyec+ACMXuNSWjGFPJnwGzguIWMrCXmUkft5wEPV?=
 =?us-ascii?Q?IXSHziNq5729lPTWR2fNFly4qw4ZcaBp6Qn9tLnPxdbP+W+BBD+l03V8W+v4?=
 =?us-ascii?Q?sLOvhWCrxJk1na3taDBML+hr8J6UXw7xo14THTplupvpcvl9Ljp4OqUFPrNa?=
 =?us-ascii?Q?QlgGwF3c7vj+OiXzj42Dc4ZMBZLCgNjtIqGrnZuXhK+pNMd4j9TFCc3G2sXs?=
 =?us-ascii?Q?IfgnzK7DbVDhXOtQHvRB+cvg8k8sVEZrPBMC5PX8rFJ4GWi24mYDYeoO0m/1?=
 =?us-ascii?Q?EpyFlAnPr/6/5eBj1FTCZJRuKNHdqLlsmqplk9jr730pD3cv9N6WEUZYggpk?=
 =?us-ascii?Q?3hGTbUIGuEvla8oqOMUNk9/rI/0/OkpB9bNej2GYXeTpoysZqk8by/FQbz7B?=
 =?us-ascii?Q?WMR16sZGs0O/dPgvnRnvn1PaR4zS5/ZXVljTEhY+G/8d3+pEb0XvIc/j2laT?=
 =?us-ascii?Q?FlIlOqClgPRFdGoC1XIMkVaOGRUgdaq28oINCxq2YI8ty/3W77UUsIh7HfaN?=
 =?us-ascii?Q?ZcNG+eHqQimZfcoQ/rrojGIOrJrWhQrWxJi5zIAg3qVoZD2iV773QejtbTfV?=
 =?us-ascii?Q?mZq1ZPpkcHdCaLmfTTd3fzh6lGxNjsfgzvkEJ2iJ7/VZT+8wQ9948uYwLIju?=
 =?us-ascii?Q?o8YhYBfd6gT/6fYLFLcLmmpFLXE7UypffJvsvHnpB8IW4t/OEhtVWQW/s8Qu?=
 =?us-ascii?Q?F4eSmcoEY+o9QT2yGrpUE5Eb?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f95e01e-1ce5-4a1b-8df1-08d90105d3cd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 18:31:19.0983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 21RTw0rt4fb54+TOGGR3CL6IX16ax289DgDS4bkBTbp9sJMV5/pAy2w273fLpibRe6/S0X4HdLB1uRPcNPdFtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4004
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9956 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160131
X-Proofpoint-ORIG-GUID: 5OUTH8DJ4FnIFSHN2GSl41UlMghB5Q2o
X-Proofpoint-GUID: 5OUTH8DJ4FnIFSHN2GSl41UlMghB5Q2o
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9956 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160131
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 16, 2021 at 12:49:59PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> If a remote has the skipFetchAll setting enabled, then that remote is
> not intended for frequent fetching. It makes sense to not fetch that
> data during the 'prefetch' maintenance task. Skip that remote in the
> iteration without error. The skip_default_update member is initialized
> in remote.c:handle_config() as part of initializing the 'struct remote'.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

Reviewed-by: Tom Saeger <tom.saeger@oracle.com>
> ---
>  builtin/gc.c           | 3 +++
>  t/t7900-maintenance.sh | 8 +++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 9d35f7da50d8..98a803196b88 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -878,6 +878,9 @@ static int fetch_remote(struct remote *remote, void *cbdata)
>  	struct maintenance_run_opts *opts = cbdata;
>  	struct child_process child = CHILD_PROCESS_INIT;
>  
> +	if (remote->skip_default_update)
> +		return 0;
> +

Well that is way easier than doing it in 'fetch'.


>  	child.git_cmd = 1;
>  	strvec_pushl(&child.args, "fetch", remote->name,
>  		     "--prefetch", "--prune", "--no-tags",
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index eadb800c08cc..b93ae014ee58 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -153,7 +153,13 @@ test_expect_success 'prefetch multiple remotes' '
>  
>  	test_cmp_config refs/prefetch/ log.excludedecoration &&
>  	git log --oneline --decorate --all >log &&
> -	! grep "prefetch" log
> +	! grep "prefetch" log &&
> +
> +	test_when_finished git config --unset remote.remote1.skipFetchAll &&
> +	git config remote.remote1.skipFetchAll true &&
> +	GIT_TRACE2_EVENT="$(pwd)/skip-remote1.txt" git maintenance run --task=prefetch 2>/dev/null &&
> +	test_subcommand ! git fetch remote1 $fetchargs <skip-remote1.txt &&
> +	test_subcommand git fetch remote2 $fetchargs <skip-remote1.txt
>  '
>  
>  test_expect_success 'prefetch and existing log.excludeDecoration values' '
> -- 
> gitgitgadget
