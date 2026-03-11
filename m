Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010036.outbound.protection.outlook.com [52.101.56.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C0C35FF6B
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 17:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773248556; cv=fail; b=JvmK+Iks0rdCgnOOManHPleUcZXbtuaBf3+c1fWenSL2Uw34w9tGbnXz9lbUgwgrKN3bov+NkE+My4AScJLXgNnmHgm0OYDdIvPYsrUuK5elQlgIrG53HA26rnZu5kCm2zHS+1cYQfzuNawZNIlMJZBxSW2ZdVXLux85Ef9fRAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773248556; c=relaxed/simple;
	bh=hhBhZRT/XqY6ueT8IJxt3P8M567qzWHba6SeKTWhbQs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r1Dyzi3wxh+djcZ5YLvHhlW8YssnV0+wcmeoouUJ2d+7wJ2dylPEke3cLKXhAxF1FNTcI50D/cdhlYPFFDXGlCrjJN13LYAw2S3m01Oxx2Q6QyzBDvh4yp5vnaaAvr9i2Q/DqluRTh8+IFQeO6KKXRCR5q03L3VxzxiZE77C6Yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nTZU9mdP; arc=fail smtp.client-ip=52.101.56.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nTZU9mdP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5pmMtYJRKtQ3w9Ylju5ZGajUyoyywnoVQw3sOqZJzzQ7jvLtew8/cKcH5DSyIHwuZE/iaqHWpjzd1a/DBYrBGAT261siijXhOZg3dNKReWFIoT8s+czg0CpMkOXKkHThH6CQe0ZanfoJhjlFoKJJVxK6qLXxu2a12Ypwewog9H9fdInaVAlOpu/9ihIWiVG5WSwf1QYAL4bNQLC3CfBHT+akW6D4r0DPQpXMI42SXoFxyGKDTfsXRgTdXRi0N321MqyVKX+aoOR7ycLrduYVtK4uYdCeMuTgtJLnds3J6t0H4/Jwk3xrklj+A2tolbhnM1yBNXrEeJ/MvBIajHsHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmFd4tXoCklBnmen+LgDXo5e8UoKaXSRYDX2dgfutKo=;
 b=d+g/vKuSwEX8XiKeUM/NfR3tesXtGmIYuRBk98kaPTnK/FZLEXZAcgYWJU0QQKkPYQBbUDTghh02hSFAgjmgiOVhLpB60siUZvT35N53olpXRlKRB/Lw2P225O4wjMMtpQ9HDw2O/oBNDthr8xgWH44mHFeqepKVwNESboJ6bJ4l7CdAuRSzv1jB/NDas2VSR2PeE1DvkcH9IQbw599Judp3dwPCz1vj/rLOAZbOgXXATlbntzxA3MghJ/6/SLt2egknD59m9iBHj5ECZirCUmuL/9HUJv+3IHNdQ0D7ZgdKtxIYjZxODdb8zVRIF8spFrSBHaRgRLixaUvpwVc26w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmFd4tXoCklBnmen+LgDXo5e8UoKaXSRYDX2dgfutKo=;
 b=nTZU9mdPiRb6CYuCfNjlSPoYWM/WNeapPzs40oyr/fTmaWLeG9GX7zjeXxSgjSYKbue53FkP3YReMvYjUfJu9KtQSLOEkXXQXzg1jgTvE8YOIbaQlTuppQAs7aBgTPeUd4j6XBaHXFy0h9QzV7yFivOybAPQKuIQCDj1HPgobwxBzIP1fSgIEA024v24074Z17HHlYm/ggc6Kg35Gp9PSBMvevWAW4XgxewO66dlo768NsbO+WQGG4jQclyyjP71wnKGHCT5n4JfDpJahxMMWpNqFgBNr78IL2a5akVA+u66gnQqc5Mmd0sNcX3bX217zZdB3/d9ox+o4hdHlw/BYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5305.namprd12.prod.outlook.com (2603:10b6:408:102::5)
 by IA1PR12MB6019.namprd12.prod.outlook.com (2603:10b6:208:3d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 17:02:28 +0000
Received: from BN9PR12MB5305.namprd12.prod.outlook.com
 ([fe80::83f5:1b0e:a61d:6707]) by BN9PR12MB5305.namprd12.prod.outlook.com
 ([fe80::83f5:1b0e:a61d:6707%6]) with mapi id 15.20.9723.000; Wed, 11 Mar 2026
 17:02:28 +0000
Message-ID: <7caf4a0f-f11c-4a4f-864a-933142311a68@nvidia.com>
Date: Wed, 11 Mar 2026 10:01:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] help: add tests for subcommand autocorrection
To: Jiamu Sun <39@barroit.sh>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
References: <SY0P300MB08019805A8304105FA805EB1CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB08015B9BA815B2C4F6CDC639CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Aaron Plattner <aplattner@nvidia.com>
In-Reply-To: <SY0P300MB08015B9BA815B2C4F6CDC639CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0107.namprd05.prod.outlook.com
 (2603:10b6:a03:334::22) To BN9PR12MB5305.namprd12.prod.outlook.com
 (2603:10b6:408:102::5)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5305:EE_|IA1PR12MB6019:EE_
X-MS-Office365-Filtering-Correlation-Id: 9411dc00-5cfd-4990-aa02-08de7f8ff997
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|7053199007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	PkFNiP6AiUouEeJ93fgmPmx3VAy5Bz6PhJe2wrojVsMpr+5YpdOWiZ1e6fnaQMEel1E/b4AcCxkuIXnOguoxcxyb6DAvxStOFhk7ibtY61CJ5+hw3NCZik0lI3jxGByfm0Fs5mGfmlYCFPm5VPyvZX49t9vvOl+KjzA3L75zqtIPos3W8HXPserTBXDDIXZ3b590fjjXO/Uh3sjPcWf5xATrSGF5ozzcd9IVzt08/bMqsgGtF+0ZxQcyC9Srp0gyx1T6mHgZX8z9C1gwuLAIVCcL24ZjvR4507T+RzOQCC/9nJ1wyUE8edjL3DajzLpYJsXlUCgWDkEeQFf182VE40NxnJz1a/vLlKbLEq00r5613yYY4LNRu0fIIX3W1cG7gNJi1928XX9krmPeNDQLLoIZ0PG58xEU+Nid7V00K3wO7DjlP4DLHIFSubCBwDeqfrtu2nSy51me4Zi5HBEUT4Sw+7uVk8jPwHSoJMe/tQy49rhboSEg3AHT+/pddb2L2nbKLMoxsSSRENONzDZJtsXEwtoNdVt+wfKE+nxr0TWShlQh6UaCxZItRZXFSHe0FtVF4HFzEM1Sf2usGK67GiwgqJl5DVvrMM7wLU3gtx4HN4jaa2DBL/vsxjQUqBru0WJDS6PUy0jL1pjVr0pL70H6JPjsVIjN3O6/bKbw41xMxeW7fUOgrP8EOt5w61+/nxzSmCc17gZrR7HT5K+xcyXVXS/Gm83/7PA6Rn1ATHY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5305.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(7053199007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3RoWlFzWWVONHVwdUZ6Qm85K2ZjVTJJR2g5YW5YeHlwZVVxQ1VabmhGa2tm?=
 =?utf-8?B?WmVrNWFZOXlIeENES3JJa3prYWVxNSs5YndSYzhBeGZWTTFCcVhPUGw5N3B2?=
 =?utf-8?B?WEVxTmJzWnBkcFRFUFEzTUp6UTMzRE9uaHJGQ3ZtWjQ1dCt0cFZ3S2c2cDkz?=
 =?utf-8?B?eURLc3VRMHp6eHFWODlUWFhKUzEwZk9iUTZ0ZGRlZTYxbmFJK0QvRjNzeThQ?=
 =?utf-8?B?Zi9kclp5SDg5eE9PTnh6bFVXaHFEZzFQazBDOURPVmZUMFd5ZWtVd0x0N0JZ?=
 =?utf-8?B?WVRDSXdLcWI2aFFKd2Y0anYvank0WUZjdHIzendHakpLRk9QTWpjQVdsY20z?=
 =?utf-8?B?NWtHdUFxZHpyUGJyNlV4ODBnYmc2UWJ3Q0UxTmZJZll5TEI4T0lYa3VvYkVy?=
 =?utf-8?B?Q0Zqam5uM1dvVnlHcFNBVVJOSXQvN3ZXREQydWMrbGJxdmFFS0xIR1lMME9s?=
 =?utf-8?B?bzNEVDRhR0RYakZHS3lPYWVVWlB5R2hWQkxLdzZQU3dtajRnQS9EbzFGcHVT?=
 =?utf-8?B?QVZzeXBlaXJPZDZoQXFDT1lkQ0JVY3owUUV3OGQ0UmlGRFBwYTRlaWJReVZo?=
 =?utf-8?B?V1FKRUtVL1o2c2x2b1Z4S2h2M05ReGU1V050enNob3NReFo5VWwrWmk1NVBO?=
 =?utf-8?B?V1BLeFc3T0RlaTJtRVBxYjZCUmkvQlhZMkh2M2F4L25MblVmWDJTaW1XUUNo?=
 =?utf-8?B?Z2VuemZQZmxwYzdrWTk5cmZPV1Vla3hXUHY5TjVjS0swWjk0Y2oyNTNqUUp0?=
 =?utf-8?B?aFM4d2ZWSTNiODkvYWsyeXcyMmxGbFVocDlYTFRhbjJ3clh5a1YwRWxLbnVN?=
 =?utf-8?B?SzArTjVYSmN6d3ZobTArUWZ2QzUvWHoyeElrSlpWb3FwVTdzaUU3UEVJMTl2?=
 =?utf-8?B?bVJkMDIxbGh4RzQwZG9SNjVTZ3pMa2c5Z2N4UjEyNHRYeTJxRjh0d3FkUnAz?=
 =?utf-8?B?L1B5OGRPc1pyTlAxdmJBMm9TT0RRUGY2UEM5TmhiblYwSDNiOEtHWFphSE5z?=
 =?utf-8?B?eE43VWhLaFl3N1NFNmZYN1RzYmpiL2xUK2g2ejgyaUNZcDJtVFVQK2NadUFL?=
 =?utf-8?B?SXo5OTJVVnBBQTlXWkZPNnB5T0k5ODRyQlNzSE5ScmZUS1NZbEJWcmQ4azJt?=
 =?utf-8?B?eTdjUlhEcUk4cEVuaUx2Wmo2T3VQLzY4L3o3emIvU1k5RVdUeDFWeDgxamto?=
 =?utf-8?B?WmRORXUrWG5JYVpMalVyRTlpUDczdkJEOTg2dUxWbWx6Qklpc1pubjlFY2w0?=
 =?utf-8?B?MG13NW9Kb2Y5TzBNamsrWEsreHpaMVZaRjVENnVhTElQTXdkWGV2Rkh0UTky?=
 =?utf-8?B?YXdQcEZMUi9KWTlvQnhpZW9EVThoRjJBNy8yaGpPc0VHellqb3Q1MndUOHRq?=
 =?utf-8?B?MlIrb3cvQ0lITUV3dGFJdkN4YXFuMCt5M3UwNUNKK2hRdVI4L0JvNUVwS2Zz?=
 =?utf-8?B?S3RaeE1KaklQN2Q5SmkwWEt2QjJicmx6dUlXbWw2aTExUUc4aGJ6ZS9zbGxo?=
 =?utf-8?B?ajcrYjZlOVV2bHJ2WEU1KzZWeHMzUlRnZ0N2L1lOS0FKTUc3cVFndXVML0V4?=
 =?utf-8?B?cEJ5RCttcnpEc1RYb0kzZ1JwSVdNekpOZndnVmJIZXhYSUQ5d0tjWlIyeGw1?=
 =?utf-8?B?TkgrcjkrQ3kvenNJeWNLc2dWdXVNbDk3cjhlcmIzRWwvM0FzMDh4NFhJeGFC?=
 =?utf-8?B?RU13WXdqNE9TZVhQNVZWUS9XVFVFT3BKUmxQWUw2VEVYRjNHUzhsRjJtRSsv?=
 =?utf-8?B?T1BSaUk2MjBUOTJvalJJbUQ0SDJyUVZWU2hSbUU1dDIraldFYXVkbXlMTHF4?=
 =?utf-8?B?eVZkNDkzRUdLYy9qMGFCNUlWd3dBY1pqVFNoVEUrY3d0MlQ4ZHhhQ0pEYWpj?=
 =?utf-8?B?STNJTFl3NWk5SFI1blhoakV6b1RmMFZzNnkxdFpTY0F3UTRuYW9sU3RSRE9K?=
 =?utf-8?B?VGw3K0cwaE1lcE4zM1hOTTF5R0ZCOXl0ZWRIWjhDQ1dKN2VWbEpKNlRiTjFl?=
 =?utf-8?B?VlRtenJFTFNUWStiKzNyTi93ZWRrL2VqOHpLRmEwTDY0bUtra1VET0RJM01n?=
 =?utf-8?B?b2FxQ1VFUnlwcWRJNTg2dHJ1Qi9qaUF4TlRDb0dwcE1qSmFRMXhvaGM0SURV?=
 =?utf-8?B?aVBreUo3TFJPR3JDNFdLTEJXRkEwTVVzdWZoSTdWSnNzRW5TdHV0RWNmUnh0?=
 =?utf-8?B?blFJeFZvVTBDMVdsYW5HZ2E3UTBZaGtFTU9lSDFld0RidFNzRURGOG9yY3d5?=
 =?utf-8?B?Vk9rdnNrWjBmRmhuSHlZa3hIMG5LSWd5UHdyNWY5N1JDUC9OcU8zMitaZyth?=
 =?utf-8?B?blRKTTBPa0ZKU2oxNGViTTdnejVYMGMvVlEyWGF4RkVYYlFTM2wzNmtUTjZJ?=
 =?utf-8?Q?SGD8kPwEzaGXSSnI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9411dc00-5cfd-4990-aa02-08de7f8ff997
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5305.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 17:02:27.9311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N7yqLhXFoXTW9EA6+79uybuhAKtW20Uyy2fdL0szfk/RlJEsc+sK8RWAoEkp1vWz+Fzh4yQiT2AVil/tbS6JCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6019

On 3/8/26 5:17 AM, Jiamu Sun wrote:
> These tests cover default behavior (help.autocorrect is unset), no
> correction, immediate correction, delayed correction, and rejection
> when the typo is too dissimilar.
> 
> Signed-off-by: Jiamu Sun <39@barroit.sh>
> ---
>   t/t9004-autocorrect-subcommand.sh | 49 +++++++++++++++++++++++++++++++
>   1 file changed, 49 insertions(+)
>   create mode 100755 t/t9004-autocorrect-subcommand.sh

Adding this causes meson setup to fail:

t/meson.build:1193:6: ERROR: Problem encountered: Test files found, but 
not configured:

  - t9004-autocorrect-subcommand.sh


I think you just need to add it to meson.build:

diff --git a/t/meson.build b/t/meson.build
index f66a73f8a0..bf0503d705 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -973,6 +973,7 @@ integration_tests = [
    't9001-send-email.sh',
    't9002-column.sh',
    't9003-help-autocorrect.sh',
+  't9004-autocorrect-subcommand.sh',
    't9100-git-svn-basic.sh',
    't9101-git-svn-props.sh',
    't9102-git-svn-deep-rmdir.sh',

-- Aaron

> 
> diff --git a/t/t9004-autocorrect-subcommand.sh b/t/t9004-autocorrect-subcommand.sh
> new file mode 100755
> index 000000000000..760760c8851a
> --- /dev/null
> +++ b/t/t9004-autocorrect-subcommand.sh
> @@ -0,0 +1,49 @@
> +#!/bin/sh
> +
> +test_description='subcommand auto-correction test
> +
> +Test autocorrection for subcommands with different
> +help.autocorrect mode.'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' "
> +	echo '^error: unknown subcommand: ' >grep_unknown
> +"
> +
> +test_expect_success 'default is not to autocorrect' '
> +	test_must_fail git worktree lsit 2>actual &&
> +	head -n1 actual >first && test_grep -f grep_unknown first
> +'
> +
> +for mode in false no off 0 show never; do
> +	test_expect_success "'$mode' disables autocorrection" "
> +		test_config help.autocorrect $mode &&
> +
> +		test_must_fail git worktree lsit 2>actual &&
> +		head -n1 actual >first && test_grep -f grep_unknown first
> +	"
> +done
> +
> +for mode in -39 immediate 1; do
> +	test_expect_success "autocorrect immediately with '$mode'" - <<-EOT
> +		test_config help.autocorrect $mode &&
> +
> +		git worktree lsit 2>actual &&
> +		test_grep "you meant 'list'\.$" actual
> +	EOT
> +done
> +
> +test_expect_success 'delay path is executed' - <<-\EOT
> +	test_config help.autocorrect 2 &&
> +
> +	git worktree lsit 2>actual &&
> +	test_grep '^Continuing in 0.2 seconds, ' actual
> +EOT
> +
> +test_expect_success 'deny if too dissimilar' - <<-\EOT
> +	test_must_fail git remote rensnr 2>actual &&
> +	head -n1 actual >first && test_grep -f grep_unknown first
> +EOT
> +
> +test_done

