Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D7A2EBBB2
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 17:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078207; cv=fail; b=pN6cjo06L7kKQzjAsKMxGuoiacurRPWwyX3kZKgAdg/z6B6NXDjIqRbOh8dlklOK8PfGkJB3T/vZgG6N1d25YdniZX/IIRgO8yA5d27tJKSD/DyZJ6+8M4j0xn86G94r/yb5nL2b+SNM/MNrQ5EIXULNPhAMP59K2j051dXVQK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078207; c=relaxed/simple;
	bh=FLmE8Wuy0tFFeA/xBqhnJyEB8BGCzYtenSLFok/DzSE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pCvJwZ7CbNq9SXBx+NZ+/wJUOzqFO0pCvCvBjlzSB98i6Uyr1nPyvGoEfr4Ey3fYqO1fG5aW/nJSvjwQSqejth7C6AM6HploWzC+WNKWghi2NxcXfrCfGVyYVEEcORWg+p5ZuqJKOUsjk/PT2JZ33ATjIMtoPNUsVEgupHBziiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=ZJ3Z+r6N; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=pGakbEdT; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="ZJ3Z+r6N";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="pGakbEdT"
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629GP56W3713878;
	Mon, 9 Mar 2026 10:43:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=KzTg2SVFMkt72HhWn4eyB40e4j/ouH9E42JUjVXkU
	tI=; b=ZJ3Z+r6NnTiwUjkMoqI0nO5PXO994FQZX/Wf/HriZ5IjeuYIjOYE8NswG
	STtnsaV1g6sSZFmr1QHHNRPlJ1JKvC5mhzSwRkKOr5zKDsf/XYOB5fTZpTe7qY+o
	2NusqREZbW6lDboo37vKJhd7YSCiJ1S/KV+p8Di4Y/EslU2jmKz/kz8M5IHwtqvd
	+7764Saa8xVDv2PBp4G8DrVFZejjkU5fW6Y87sj8wih3PRjO7hbrrnbKxFavhllx
	kWhwcpSRdMM56Vn4K9IIU2anqZEqn4roekjFtREv9gADqMxfrrj3s311yYAQneup
	PrXeIV6gHwvtlflktif8mixzImzzQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11023136.outbound.protection.outlook.com [40.93.201.136])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4crme1djjd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 10:43:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8CcYz3+fVaFcoBy2YDmrjbIu+M/a6NF4kfZpfj60jJOR3F3we4HgDbmo52P7ir7+pz5H6afzC3jLzlSKXBCgUGc7LncxQKSrfeOflSWLb77rB36lyp0CF+M+u71hsUHPWjIUmheIyZIbagMGbEiLuH6Bd9PoRJ1jL3d8fXVoq4yohVB+XEF6zBjQuSIzgTYTRvXOenUr8JoLoU2AuSHkxBRswosNuoNgWV5QYHdOM7eBux1sZRyk5SxyydIdvkKIbfnADFD7A4w13THnzDFtZJL10NbzHjZS5kMCuQ32/BWvuP2HEAJsFc9SgONSiU1owxO3klBHn3EtfGQkCkwdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzTg2SVFMkt72HhWn4eyB40e4j/ouH9E42JUjVXkUtI=;
 b=Bp4jJ+VLJum/9ooDHRQm3sbr0o1E8koEcASqSL8TjJNPsq7ABOgK2frWhu32TV49Yug6yijfrBNpI1akXfGaJ/8U0rgn4PotYjMwOQXhIVmmddq9aJgaejmBdpMoCwO+bx1IMQTd1oxvxgUVPybho36qSDtz4wEC/0EyyF+NfiH4/WfrIc385fDHtfvwaNNfsHAckQAUxrfq7vo546ju4J1m9Lwdwo0cxsdqTL0raAScZrUtM3S44nPyh3GokB3GExkuzmxr300yI1e5lUizLxMv5D2e6BKxBM7M6hex1VtKCjZnymilIOqluMhX4xUdNAOxauzq7PzSeKg73acn9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzTg2SVFMkt72HhWn4eyB40e4j/ouH9E42JUjVXkUtI=;
 b=pGakbEdTZs3thwBPPBHLP1B7w155pa62FdT0irQqhl066qd9wBnGEPvHDCcyKHcDcHMrIO4l908jVFwEtLeWhzDqrgbtQaedtFm34Wf2eL/Ay5qO2sberMghZdGI+EVto7bt5dYplR54F4n5s8o2Mq7ilB3ckLQ+I1pWrPg1Rza73rXAz/VooAuFCVR9iOGUJ4eHolCOVP8+PYdbqmPftgglrw5OYMqW9u23J9leU7NFn7FL6lr2/eATcdzGX2tB1kGR5nNWndgv5l0RwZkw5Ql3/sCYE7T6jXOuoBztyLQudwXcsIozDVoGLCgkMqJZp3c4uBdzajYRe3qj4+VpaA==
Received: from PH7PR02MB9992.namprd02.prod.outlook.com (2603:10b6:510:2f5::16)
 by SJ0PR02MB8386.namprd02.prod.outlook.com (2603:10b6:a03:3f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 17:43:19 +0000
Received: from PH7PR02MB9992.namprd02.prod.outlook.com
 ([fe80::e2e9:fa4e:10d7:f7c1]) by PH7PR02MB9992.namprd02.prod.outlook.com
 ([fe80::e2e9:fa4e:10d7:f7c1%6]) with mapi id 15.20.9678.024; Mon, 9 Mar 2026
 17:43:19 +0000
Message-ID: <66419a04-67b0-4b60-bf23-078cf92b2c04@nutanix.com>
Date: Mon, 9 Mar 2026 17:43:14 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: Option for "git submodule foreach" to also run on the parent git?
Content-Language: en-GB
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <032a7767-2350-4312-a7b1-75080519c72a@nutanix.com>
 <xmqqsea9591f.fsf@gitster.g>
From: Florian Schmidt <flosch@nutanix.com>
In-Reply-To: <xmqqsea9591f.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0022.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::32) To PH7PR02MB9992.namprd02.prod.outlook.com
 (2603:10b6:510:2f5::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR02MB9992:EE_|SJ0PR02MB8386:EE_
X-MS-Office365-Filtering-Correlation-Id: b105beed-ee99-4f8e-e191-08de7e035a17
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	H+yChV1dXdtVnDoUXedwPjPqRZuCjBvZfcOxud7LQU1wau+nw3vOaQVObXd8qH52KpaC/9LKrGIvoRrJeavv/SwpXkrKxwPpqp1pAD+pkM5EB+t4PVqWQvdixrXbI6nbaCge++Ypl+bMCUKWQSqSkyS5kwT8UR8tb+P4mcCWv4ugBWQFZlnKErOg+hZwcvhIgUhnNxSdoRRhp1uAu1934MJt8RWDmp2iy+ROA00Z3T7PC2U0Yv+XuvMY6MlX1UGatGNQB4pNZilpku8RHsdUWhUgTSdz6/nRwAa4AbotLozBNwVKZe909vNUZC+yv4X2ijbw4mrilt/X7MHz2JwS/jdFdJoTnixx7EabAengPqYSv3uvBPTxgiwJ8sgD4onZkLqBaqi0I4Ib6/WxuZQwI+g4qAbfcpd6vXrYUwtXZGXq5+gtkDGsYmci5umIX1o/hLuZ9UnQSMo6rU9rxpAdjzYW5M5SOfOv2GAs5xHoa9ELrYXn/4h7vDOLQ4OJhrLOGPLzljmGSGPIlZH6IsIAIboKBhD5FlqMS+i5BAYeRVl0Oq+5w5e2/FeLiaKL1XNhTDyBFDp2it5trdEyl8h03S2Jas60j9ajbdMhNjIrG+ilMuxTXIQ7hiOKqIPnjAFer33afoMWr9G/VdhmVaJYkHSEoRj+p2QuMK1vCasUUk2gBtHC4PAM9txwTxvJMwSLC6OIEw6FYU9aQO3VO/nYfA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR02MB9992.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWVQOFdZaDJIZnJ5L3dtQ0hDR0FQeXZLb3VDN2R2SWFhVVlLTjRNZGdGczJo?=
 =?utf-8?B?bG15bENlZ1h1NGJYTnRWalBabHQ0M2RuRFNJNkh1Yld2elBPOUEvSDZ6TVR4?=
 =?utf-8?B?anVNNXRNSnNxeHpPM2ZmZ0tONUlKN2xjdFdUQldvelRZK1NOUzNQc2R4STA0?=
 =?utf-8?B?OGNiRHA1T3E2Z0o0NFhkNkdFclU4WGlwYkY4WEZwTVhVdy9GVE53bDVTVElL?=
 =?utf-8?B?Um9QTGpuNzErR3AwNUl5VkJTdVlaZlp0NGw1bzRwVVZmRE1YaUZQQ09YNHN2?=
 =?utf-8?B?eStGV2l5K3BrYXhZckJPdjg3c3BzOW5mdkZLUHZwS1dYMnJnY3ozK0E0eG83?=
 =?utf-8?B?UFhoQzl3YVREZjlVaW5QenY1eWgrN1l2TEw2S05rd0FuWnN5dlY0ZzZPZ0Z3?=
 =?utf-8?B?bmZZMzhpVVNnODllMU9IUHhZMVcwN1l2TTZsVkVSNXZWeFg2WjRGckVnSWw5?=
 =?utf-8?B?L3A2cFBYMmFpRDBLdGZUUWtKVHlxenlaQmV1TDQ3b0doNC8xRVBTSmlBcmd4?=
 =?utf-8?B?UzBocHc3NGovUUd0UDJ2UFEvTlBTRmY5b1NVdUxYZFN3eDEvYms1bWMwMXZq?=
 =?utf-8?B?MG85RFBuNDluUjgvU0FGUkVBcVhZVVl0eHZUV3BOb3ZVTjkrV09vZ05VYXNs?=
 =?utf-8?B?eG1ieHlpUXNkUVF4VWp3eDBZbnBUKzQyelcrYjRhdkU4RjhLdGVWa3E2SjZX?=
 =?utf-8?B?eE4wbEluRzlDcTNjc04zWEVnUm4xVmtKa1F6SllFekFTelJCYVc2MFB3QzZT?=
 =?utf-8?B?bUprNVQ2Vk03b2RJZ0wxWFdtbzEwOGRJVUJuK3ZMaDRScm9jM1E4UFJHaG5r?=
 =?utf-8?B?a0JFMjg5NXFwaDJQRmpNcVU0OTYzY3hNMVlvbXRRRVk3aVBFM0EzcnQ0cnRV?=
 =?utf-8?B?M2Y1c1lETGhFYkQ4UXNwcWlrVEJBSWhrYkd5UTN5cGJ0WTA0T2NDMlJ6dmpr?=
 =?utf-8?B?aTFKSjhRUzBOc0pEQVFnTXpTVEt4QkVYOHNHS3VFTVluTkVkZ3NsRmZBOEhB?=
 =?utf-8?B?UTlJbVpOMS9hV3FpTGdMUWVDcVgyQXpXcC82RU9FQzlYNVZOTisxLzlTejlx?=
 =?utf-8?B?QzhHVldqRjZhb1c4cTJ1aE8wMnVpM3JaQlM4amJFUUpDSHlOTERVZEhFd2Zv?=
 =?utf-8?B?d0NseVlvR0Nmb2VQYm43VXNSdWIxVWJ1c1pzVjdMY1FONnF4bU9vL1h5cjlm?=
 =?utf-8?B?MVN2Q3J2UnhzblpqVVFSUW9ISkMrRzExNUlIOHhLTWtxbTFzajJlWWFMQnd4?=
 =?utf-8?B?RFNZajRJUDdQb0Z4dVpOdi9sWmRLaFc3QXFOZ01NcXcyUEJHK0w0Y2c5NmdE?=
 =?utf-8?B?Qjg0T2hQUHVDYjVYVlM5MU1ZWUFEaUdHcWdXMzE1SUwzSTlsdDg4QUVRQmxi?=
 =?utf-8?B?eGRHL3I1UUxnSGtWUnFSRVVEcUVzdkFGRldtVnZIUSs0THBoY0QwRkVKSEEz?=
 =?utf-8?B?Tk1LVm92SlM3OFBWdDlMV3ZqWUw0bWcwY2o5RmEycjFUT0k5bHpoSm44cWQv?=
 =?utf-8?B?UzVyTm13VDNodVRBaWZ6TjdxTzdXRi8xTTVjd1YvVmFDVUlUV3hCOEd5dUNv?=
 =?utf-8?B?R04wYkVkK2dRc1MyK2phYzZnSzBPdGdnd1FHTzNQT3hDUklPYWxFRGpqR0lM?=
 =?utf-8?B?N0d3OCs5Tm5ZT1ZzdFNoUGs1Q0p3ZmNJbXNDMUpyNzNFYzR3UVVjLzhxV0xy?=
 =?utf-8?B?ZEpZcmxQREVyUVVwY2tXRVVtcFJzWEpzNE1BanZLd0hwMEY2VGNxQXJJUk1o?=
 =?utf-8?B?N05WMk03ekVBY0tWUjRWKzUrWGRaa3JaZ2w2Q1ZDMXdIQ1VMcGVVeVo5am1i?=
 =?utf-8?B?RG5kZ3V3dy90ckxPZU1wV3BrdFNxN3Z2dTBzai9JdTN4YllLcEdhMTM5ZGJO?=
 =?utf-8?B?c0pYdXg0ZUxLVTQrMTVsTm0rWWJYaWd5QWIyWXNjaUhYWHZZaHhQeDIxTytH?=
 =?utf-8?B?VUhjVVZPQ292Vk83SVJtWEFNTVlkUWw3dW11aDBBdFFLY21Fc3U3OHU0dUxx?=
 =?utf-8?B?YkZjRGt2b2UydUpYWjZtdXVqUEhlaVdURnpST3NCSTkrcDhPYk5mdnRvbjVm?=
 =?utf-8?B?amZnUHg5R0ZTWi9hWFUrZmZHTDVVcHI0V2grbVpONEY0WE5wMUNRT3NrL0Fh?=
 =?utf-8?B?eHVsRCtmS0hlUmdqZG5iNHg1M01PNVNGZFAxVDVNK1pKVll3NzNEVlUwYjcy?=
 =?utf-8?B?M2dRcnhuU1c2amt1WnJRR2J0dWx0d1lieksva05FZTZJSDZaaW1QcXlBNE5U?=
 =?utf-8?B?YUVEMzdZMWR0SWNGcFJ6d1d2Vzl6ZFkyU3V0UmN0Rk5HTVZGKzVpUWIzK1Yv?=
 =?utf-8?B?eXdnSkdyWk1IWjczQ0tURmU4M05CNXJMSTFCeFZBeGN2dytFcU4vbGdFVTlm?=
 =?utf-8?Q?9QT6qebS7G3uYL7o=3D?=
X-Exchange-RoutingPolicyChecked:
	Lq8pgoVxi6vreFlMboFFUhPAHV5fHVeGdcw75K/IXBc+AipJlMfGT9oVlTuVoQxXASQXL30PFejhtr5lIiGn1oSrAFNTZr9oIxsgJr5Uy7PgJ2TVoUi1EK/v9ALP6OQIhQd9geuGdmg3Udg2qmO1c9b4781D0pADbrqkpfzG5xo8LFdmCCHgoUu1zt4iP7x57NKxmWnN8h+Nfsp0p0eeGYBn5ShFK5/3moff4gcZhuJ0OZ+HEgQ1OP+CNPBQWOM3ihpvy+1YOwSzYSWQfuNvj8SVdsezHLGl7eexOSPqu7A3/j2wZczse639X0M1nmrGOJrGSgAgh2mjZDly6lTpNQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b105beed-ee99-4f8e-e191-08de7e035a17
X-MS-Exchange-CrossTenant-AuthSource: PH7PR02MB9992.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 17:43:19.7256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kCbZxqqU2mttfxxCXsW82CqVOISmFVoDXnAUvdLhzrc/tct5RFZ989e3aQ4pyzOnbAPsayM22KuhwuWGxvSaHG2M77IbyO+KTbdio9S0usc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8386
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE1OSBTYWx0ZWRfX1IUtZMuaI6ox
 ez+HsLtzfOV6rIVPSaZ280bxnwRyCyp7Ie/EyKjFzFeNzGNOzLEVeUc/Sn60fhh0b3QLw3e77nM
 4rFJMVOqBLYdQj5h49LPHGDyHxcWuOHdOuYYlq9e+GE/f6o7Y2fXYeFOLfW0nilCGaf4a74RTBq
 pcxLE+b+knVbXjkaeAOYCnfEgjGMrENVuM/EV2gzbaAmj+g+WNP6D59FHmMTDR/EJuLjKH4dKjQ
 crizAms0vMB16JBrWM0jdkVA2qr4wg+meJtLMWjRcO23Z+YyuWb11oe/i0AnAfxCfMn3FBoTNP1
 OmvV+xLgTwkhcG0Y2XpFH/p/Hs5/wTBjxe1Et9onbLmoHEHRpKCwVTW6M977nFDZiz5/816GuF/
 AQczCt4AZwHk4d/Zf2pDLGbLNoYrH05R+Dvy8T77NDf3bGaMQHhYYzB0yF759ftOLt1yeqmiGD+
 B7zr5fy6ILVDEiV/cLQ==
X-Proofpoint-GUID: fFY1tsALhngoXeDTzF6Ad7KAOCyhXnGQ
X-Authority-Analysis: v=2.4 cv=f6NFxeyM c=1 sm=1 tr=0 ts=69af06bb cx=c_pps
 a=ppJUfaEfP5EjbsERzBeGhw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=D9fGmjDSmocawNs5Wu4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: fFY1tsALhngoXeDTzF6Ad7KAOCyhXnGQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe



On 2026-03-09 15:15, Junio C Hamano wrote:
> Florian Schmidt <flosch@nutanix.com> writes:
> 
>> would there be an appetite for a new option to "git submodule foreach"
>> to run the foreach command on the parent git repo as well?
> 
> Not from me.  After all, the top-level superproject is not a
> submodule from the point of view of the tree, is it?  If it were
> "git submodule-and-superproject foreach", then perhaps,

True, I was thinking that, but figured an option such as "--also-parent" 
would be sufficiently clear as to what's happening. But I can see that 
it's maybe pretty niche and potentially confusing.


> but at that
> point, wouldn't it be simpler to explain what you are doing as
> 
>      do-this . ;# do it here
>      git submodule foreach do-this ;# do it there all over

That's basically what's I'm doing. I figured instead of doing "foo && 
git submodule foreach foo", a "git submodule foreach --also-parent foo" 
would be marginally neater. But I don't feel strongly about it.

Cheers,
Florian
