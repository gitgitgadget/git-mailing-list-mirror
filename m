Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FA7C3DA6E
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 13:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbiLTNup (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 08:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbiLTNum (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 08:50:42 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA774B6C
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 05:50:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1mTV5TBTFwUYidDrtWq7qyfn30FW7Cd+oW4LOp0m86oQ6zqPZDpjPOIiZ51lE5a4z+g44l7LDA9OryLbIqYK3OHOQgnX+EeLhE1xmePzURPms5xvDL3YK3imBK/Ozr30qdwMjb4PWVaTQ57yqFVHZyMqzLUq8gdbpcJhK0L/w7GLRN6YSWB0k8f+nUaUfakwW3f//s64Muba3BXI6OrB1VCGkQmnYAwdmT2Sh+X195wgXOtt8C725mZIRZWWBgk8aUlUgvLu22URag6f57R24CFCK83biVZs8/LSKC2Q3hpD/yFzre2COsr8Et8Q3FmNp9boPmAPVS71zSAqJSEBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/btOViYnqrmEIxUX+rmsgDo/5J0qhYvcd+9eTYCJeU=;
 b=N4gqVtF5Y5uCL5+ibvH3B7KAjXT8wJZXkiCir2NYZ3OG2VRIF8dMkYch1pkbP1pDcE63RiUNbdAthDq3VSJSoGlA+Yhpn9qcqLds9r8KxGPbFYK1ydLVKGzYU/Qh7WY30hNr3GBngYqcn2nzRbv9Gdg7ooOpyTGiO0rchY6ZI/Cjg2Y/g+3SNR3pw2KjhFaYeYRoOt/rXSheB7vYHd2F6sJQ26K5uABq+tCj06sSB/dRNzLcOPCGqCsrdKVjp40Y2nddeFxW+nK1YpC0z4pVNH+g+tkES29th44z4GqFM81/nAisBmKE6QXT+f7OKufydpwWjb9MlCAtvLaDNLCyyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=stmcyber.pl; dmarc=pass action=none header.from=stmcyber.pl;
 dkim=pass header.d=stmcyber.pl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stmsolutionss.onmicrosoft.com; s=selector2-stmsolutionss-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/btOViYnqrmEIxUX+rmsgDo/5J0qhYvcd+9eTYCJeU=;
 b=Oy2Gpc+B5HEZAGeI8Sm6dUFKl4Jxb5mxsVZbyMJe51CYyer6CnZDzMxtF58LZqRRkx8CAD/CyVoe62FgCVFB1Oxpnu4X36weAHgnetBnDeaJpjCHBEJ2uClpLZUONwUb/Vk+StBHl2H5BpHwHMVpNb/X0qRV1WgPsIqF3XnSxVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=stmcyber.pl;
Received: from DB8PR09MB3225.eurprd09.prod.outlook.com (2603:10a6:10:3e::25)
 by AM9PR09MB4546.eurprd09.prod.outlook.com (2603:10a6:20b:280::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 13:50:38 +0000
Received: from DB8PR09MB3225.eurprd09.prod.outlook.com
 ([fe80::4ed2:b653:4240:5e36]) by DB8PR09MB3225.eurprd09.prod.outlook.com
 ([fe80::4ed2:b653:4240:5e36%7]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 13:50:38 +0000
Message-ID: <12f06dc2-8bfe-8cbe-c6b8-659f5bf92ea4@stmcyber.pl>
Date:   Tue, 20 Dec 2022 14:50:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US, pl
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20221220123142.812965-1-hubertj@stmcyber.pl>
 <patch-1.1-2319eb2ddbd-20221220T133941Z-avarab@gmail.com>
From:   Hubert Jasudowicz <hubert.jasudowicz@stmcyber.pl>
Subject: Re: [PATCH] bundle: don't segfault on "git bundle <subcmd>"
In-Reply-To: <patch-1.1-2319eb2ddbd-20221220T133941Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BEXP281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::11)
 To DB8PR09MB3225.eurprd09.prod.outlook.com (2603:10a6:10:3e::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR09MB3225:EE_|AM9PR09MB4546:EE_
X-MS-Office365-Filtering-Correlation-Id: 62c8666a-9295-4f8d-fe76-08dae2912ceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rg7cF06Qv2PLC0E8ur+5/f722S8ctKtvItyA94JhyLvqtf+6R9Xdannb2n8rLNqsSoHBh9UqbIvl32CL/SvceT3iWNYljSVKYMZD2XmOPECeMSGAOye5UCBKfRrJDe9HKcm82yt4Yn8m0OTvtXQGChO0/G/BZ0y/Nby1CKX5oohCrUcQAkwaTA5+DEOwCrutbHSlyDS15tiey1Ncn4GMp1Y71SftGjxeJvqeCE/CgehciUOnD4Bh1e7mnufzNiNKwj5lrY3nFvMpxr5FrQ+Mn3OqsK8vM6ggBHGDykrQVMkxGJOeZ4g6Rkp9WhtrqJpivoRRyJRI59meaHL0uAOnPJ9ln8QSdRSUHuPyDpyA62LzR8Ia40JudYL9FRWXeRqkQD5+NWe8cuOaKhd59fMCOrC8cgwZE2x4z6AZ71FPpBu7rGKnj/9qpDc75dkNqA+iUgU4n2qn9J7Snbr/5mGfQS/GwqnJJ+0UwaE9chGDxBx3jvdxvDGLyBhjW8EW/mXVaUHG210JSIHtf+V+XdPHQvhdW6+oFosmV79kdLVUXWOaBaf+8YyNtU5mDIM2yITI8QpxyXglXoeWbmiurmdOJ4bCzh2H4kpioe5ESvHQM5JS6HJo/munAdB6Yo4fr+ncREqxLh3EhOj3aizLbPRGzmcJLcMyMfiWYv+4qcjDKsc9FKr+DlQ/TsPY+Xs1kD8rHZvRYu6ygjhdlNqh4Q+PufmDR9VTVjxnDvnCiXCJNU21dw+Bj6MKWWaRPAZ83tSx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR09MB3225.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39830400003)(346002)(376002)(396003)(366004)(136003)(451199015)(38100700002)(36756003)(31696002)(31686004)(6512007)(316002)(186003)(54906003)(478600001)(6506007)(6486002)(966005)(6666004)(26005)(83380400001)(44832011)(66574015)(8936002)(2906002)(66556008)(5660300002)(66946007)(4326008)(2616005)(8676002)(66476007)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmdmOU1nVjFZMHRWaG5tTnluZ2hlV2xyUU9oVTdJbWsremJkVUg5RWNVTStQ?=
 =?utf-8?B?MlFkRm5xRWROS04yVXFLdGxET3VxRUdnelh6ZFdsZGdYQyt1dEg5WVppWXlZ?=
 =?utf-8?B?TFJJSmdQUkR2ZksvWnl2d1pWbXJMN1RIV05RbU1TTkR6L08zRUE0bCs0U2Jx?=
 =?utf-8?B?TitxZ0xmdUE0cGl5bTN5c1R6SnR5Q2ZoQlp3Z0ZNTXprOVNzUnNaTnZKa1I5?=
 =?utf-8?B?RXc2eDFHdVJwRkxtUmVDNHlXQnhHT0xTdm83VC9SeldFZGUzOHh4TGxjekhj?=
 =?utf-8?B?UGF6YnNxR0ZaM3E1YlFIYzVhMU5zc0xIcmNCbzljUk5iMGRiZkNWUHNidUxH?=
 =?utf-8?B?TDZRR1E0N2xHU2pKMlJUR0pEMFlQY3V3TzFCSTBiSXhvTWszM08rVUVuNExY?=
 =?utf-8?B?TEUyYkRrcHRobW9KdFp2eU1hdlhPNitVNFBQREV6TVFpM3NXMk84OGptUUlW?=
 =?utf-8?B?T1c4blNkMUE1WGtRSFk5Y0ZaMGpZL2hHOGd3Q0hHR1pabFpKT0JJSVlEQVRV?=
 =?utf-8?B?N3FHUzNFczRBY0JqQ2xCeUYweVBnZjllN0xwWDVIQVllalArRnY4MzF5aUhZ?=
 =?utf-8?B?emVPb2o5MEN0bGIvQ3RPZGFIU2UrZm02RU1nMlpyeWg1VVZOdTcxOXlrb2Nw?=
 =?utf-8?B?aDhZZjViQy9xQXk3Q05Ga2hTbWxjNk5QVCtPeWw2Q1VHOFppZldSZ1JxczNa?=
 =?utf-8?B?dFZsU2FkVDRIbmcyQjdHSTAzd0JRK0RwRFVuZ25vTTg3L0lIY0wyeHhWN08w?=
 =?utf-8?B?dHhFYUJpQU5CK2k0RkhVQUpJbUw1MHZCL1p5WTk4dmJUOVlNbjBXOWhEY1RK?=
 =?utf-8?B?Y0lpbUZiVTcxNDJEb1l2bHZsSURFVzdBdm1MV1BlQlgyVjRlWVpxSlF5eWdx?=
 =?utf-8?B?dkxtYlpKMldsd1JjNmw1Q3dsUzkyY2pjN29LU3E5Z2hCYnJQRURVWTdiL1lj?=
 =?utf-8?B?Z2VYdExXWERCQnlpSlAwV0ZISDIvK09uUVl2SFdCWnhUeUh0bUdpK1hFN3A5?=
 =?utf-8?B?MjNCODhrVGZhZjN2TTVQWDR0OTA3aThzdG9ETFFPOEhNK0xmamcwaXhNbFBT?=
 =?utf-8?B?MlloVnVBTVFKd1dJb1VTMEV3REl3QWtxVUF0eW13a2NpMWsyL3ZWZ1AwSFJM?=
 =?utf-8?B?K2lvbDN4eVcrU3p1OSszNCsrYldqWjROeXNsb0JqNTIwbnJ0czNlY0YwNEp5?=
 =?utf-8?B?NDFwWHdOaE80TDh0L1VLRmwxNk5ndjE3NExPeXpCT1lZeU5CSHpScmhlanNK?=
 =?utf-8?B?bWxreFJqQ3FHb2F1OUxnMGtncU9Qa1haV3F5MExpOWorMjcwUUMxSVhuVVY5?=
 =?utf-8?B?NUo5T0VIVjNzN2pvOVRqS2hQUGNHdkJrRkZ3Y08vVHBWaXhxeWE4by9GaGdO?=
 =?utf-8?B?ZGYxTjJ5YW45UDdtUW1pQUlVWWFmdFltYzlXY0l4N05LQ0Q4ZXlvTXJsd0cr?=
 =?utf-8?B?UWhpMHZNVnpsTUZ3WDdDQmtsUjgzd1dBTnB2WXRtMHVBWFV1d0tSK2xGOU45?=
 =?utf-8?B?TDRzQnRWVlpFcGxHbEJQNDlhYnVzUkNZRE5jS1dNYW1HdlB2Rk50eWNiOVAy?=
 =?utf-8?B?eDgzb0U3d0NZbHIxRHp3NkNlSy9nckg2ckNVSHlNaVVlZW1ORFV0OHB1eW5k?=
 =?utf-8?B?Y0JVTUxWL09mOVp2TTJjeDdRZVpTcjYyd21kNlhsVFBFNFY0VXRhaS9XVTc0?=
 =?utf-8?B?MTQ5QmQwbWRDSktPV1RhZ0FTS3Jqdjk3N3NtUm1hL3MrNVJVbmJKQnIrOUJ4?=
 =?utf-8?B?eUo0WmE2K1lseExHMUROZTZSMnZjWW9MazErNDFNZVZscC9WTFNhOTFObGlP?=
 =?utf-8?B?VUhVZHU5TmcreEl5eHN6NitqZ1lianc0RUFGTTgxN2RvSWphMmc3akZnZ3Zk?=
 =?utf-8?B?LzNoaUlnZnpBNUVJOVhFUzl2MGtlK1B2TkJCTEtkWUorMTVHcURVMmpkWnNP?=
 =?utf-8?B?aDU4bVpvVUZQa081YWF5UFVLdXQ0QUxHNUo3b21pNFp2MVNWd0JtUkp3WGxV?=
 =?utf-8?B?OHRsOE9pQnNiNHBkdVVGQW84V2dZMlhtaThjVXZ5dmt5WFA0YUNuMlJ2bDBy?=
 =?utf-8?B?c1BQWXpkL2h6cU9VM1NlV0JZS1ZRd25HRGJGZHROa2EyNEVNVThiNTlqV2x4?=
 =?utf-8?Q?KhHog7cis7/TbkhRx+VkUngBn?=
X-OriginatorOrg: stmcyber.pl
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c8666a-9295-4f8d-fe76-08dae2912ceb
X-MS-Exchange-CrossTenant-AuthSource: DB8PR09MB3225.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 13:50:38.0020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 62c20329-7415-4bf0-95a1-601ddd24eeea
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2faklJXJfQ3j7LE8Rs6BLwNra+lEozMOEQlz87UryQy6Si0idpNwyWpsI3bttLm7h8siJPUUvCUe6KuAzE2Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR09MB4546
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/20/22 14:40, Ævar Arnfjörð Bjarmason wrote:> A proposed replacement for
> https://lore.kernel.org/git/20221220123142.812965-1-hubertj@stmcyber.pl/;
> let's move forward & add a test rather than reverting away from the
> subcommand APIe
> 
>  builtin/bundle.c       | 2 +-
>  t/t6020-bundle-misc.sh | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/bundle.c b/builtin/bundle.c
> index c12c09f8549..61c76284768 100644
> --- a/builtin/bundle.c
> +++ b/builtin/bundle.c
> @@ -58,7 +58,7 @@ static int parse_options_cmd_bundle(int argc,
>  	int newargc;
>  	newargc = parse_options(argc, argv, NULL, options, usagestr,
>  			     PARSE_OPT_STOP_AT_NON_OPTION);
> -	if (argc < 1)
> +	if (!newargc)
>  		usage_with_options(usagestr, options);
>  	*bundle_file = prefix_filename(prefix, argv[0]);
>  	return newargc;
> diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
> index 833205125ab..3a1cf30b1d7 100755
> --- a/t/t6020-bundle-misc.sh
> +++ b/t/t6020-bundle-misc.sh
> @@ -11,6 +11,13 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-bundle.sh
>  
> +for cmd in create verify list-heads unbundle
> +do
> +	test_expect_success "usage: git bundle $cmd needs an argument" '
> +		test_expect_code 129 git bundle $cmd
> +	'
> +done
> +
>  # Create a commit or tag and set the variable with the object ID.
>  test_commit_setvar () {
>  	notick=

Seems to work. Thanks!

Tested-by: Hubert Jasudowicz <hubertj@stmcyber.pl>

Hubert Jasudowicz
