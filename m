Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324702517AF
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 08:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344513; cv=fail; b=bmT15u7zTxA8aXpQg5Tipib3fe/i9RyBeR1bxGaFuKI3PeoTuRCHQW2z1bbDnnNNodK+ZZDK1kU1MIWI/WGv/GeM92tMG0FPtZVL5oxgmS17QgWr9Y/BFHrGas0rgCLJbJ+YXhjZJdf6WE21X8cnhV1W6bLjqeNDaVdhRHDaewQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344513; c=relaxed/simple;
	bh=ntqkwiMknvKWLbNrs0WSHMk2zLrpPgzBPt+GfgIzeZ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N0AolqJxAfERvYyjHqqI00CXWqgzBIdnzmjxw6n1XUVrmxYezjmKGuQbxH6rNqnUyPp99azJORoMXzvvM7JAr9hlEk8XmoSHFVUPsE6ngUS2WoJVGLAf6abwfWGXk5Ft2edqji00f910/Lq5p1EpLWeyg/ZfQC7zpuHSh8WyZss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 56O7Ncd7450387;
	Thu, 24 Jul 2025 08:08:22 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 483duq054e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 08:08:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNtNLII46yS0mbCdP3pSgTdxHktx2URT7tUf682dvSH6lZSEs8kdod1Zcbiik3tW9oKjWoCbNHffUTWMO1K+n8ig2M8RD6rF05pjfxS2SETnm4l9fs/aLuFrvhQEHyiwjEfO24pcuOLt9YEALpIRmygpQJNG4bKjA4632lEAWHXfkwNl3KXtxdRJhojjs73RIYk2nNUFry9S5X56fAcdo3TrVILKvpNupS99reTbk35HpnuMfOOHkhLddAHczMisibTWJ1ViFG5fmi6FgkvfQfpWOCyfZN2riFkQ6ccyGD8xkPUlA5xnVZq7vyzgMoQOAjUfa5uCiyw7bgdbdR9BEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntqkwiMknvKWLbNrs0WSHMk2zLrpPgzBPt+GfgIzeZ0=;
 b=frzlN+T0V/z4NPnLSrjLgNDeUKdFiXr2D+8WAdUO973KobNAB6IfomC75rBvDqBHibmCJkMbt0Ewvxyt+fu5HJXAbDtM6GeRICg5GB8EFA08CAFvc/k+yDX0H6CiqHrWkcAyUAgREYkMsUJOyrYfETDfsXqKOYm/vcFJgPMYK7k7u8o+G3z9qz3zC4Vn6FSPV82MAqK0SWKdf5563v0VzZeA7eegY0Oe4xLcJ8NGRmqYSQvQdpLYrEUS+punxAwI8VAZuFRT0sN1qACQJDCEYFQd5w22dpp2/F72pVMVBNPiLLusJXYcKhZRgEOeDfsSpjSmaShImxaSzbaDki3eEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM4PR11MB5533.namprd11.prod.outlook.com (2603:10b6:5:38a::7) by
 SJ0PR11MB5055.namprd11.prod.outlook.com (2603:10b6:a03:2d9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 08:08:19 +0000
Received: from DM4PR11MB5533.namprd11.prod.outlook.com
 ([fe80::8ce3:74f6:33ca:3dfd]) by DM4PR11MB5533.namprd11.prod.outlook.com
 ([fe80::8ce3:74f6:33ca:3dfd%3]) with mapi id 15.20.8943.028; Thu, 24 Jul 2025
 08:08:18 +0000
Message-ID: <c2dcded3-a317-4065-a26c-3cb12a860eba@windriver.com>
Date: Thu, 24 Jul 2025 16:08:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: warning: ignoring unknown core.fsync component 'true'
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
References: <209ecbf7-0d53-4674-bb7b-3ca084edb761@windriver.com>
 <aIBy3xH2eZsCZYiY@pks.im>
Content-Language: en-US
From: "Wang, Jinfeng (CN)" <jinfeng.wang.cn@windriver.com>
In-Reply-To: <aIBy3xH2eZsCZYiY@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SEWP216CA0149.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2be::19) To DM4PR11MB5533.namprd11.prod.outlook.com
 (2603:10b6:5:38a::7)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5533:EE_|SJ0PR11MB5055:EE_
X-MS-Office365-Filtering-Correlation-Id: a3e5017a-accc-43a7-f348-08ddca893fbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NU1uTk5wZjJDOWh6WXg0QnBCdm4vOTRmeHlMN2ozZGJQY1JMeEk4WFRiNGpF?=
 =?utf-8?B?OXZwK0Z1eEVPSHJjeC83bTFZeEMxL1ZnZEpxOWw4Rjd5U0grMXRQV0crZFNV?=
 =?utf-8?B?b2ZxTWY5K3JMUUduN3UvZnFwaTZqNDl6TU5uRm5RYm5xTGVVOGxnS3RZT1lt?=
 =?utf-8?B?ak51S0ZQTk1sS1VDemJGNDlrdU5tVDdsVThOazJndVBZYk40SDNFT3A0WFNp?=
 =?utf-8?B?OWhpUkJhclZDb1ZtV052V3picE1sZG5iSmlTbFdiVjI5Z1piaW4xTlB3YUVJ?=
 =?utf-8?B?NHM1aXdCaWlsdld4MUxuL2hucGR0ZzAxNm1OcncrWjMzVmVOKzJBRjcyQzYy?=
 =?utf-8?B?VERneS9tVG9IQlE4NHdKdFd5eXE3dExTT05IKzA2d05uU0FDSUJFcTdHNk41?=
 =?utf-8?B?SVNDWitSWjVCMmpKS0lkVk9BY3BzTWhGQXlYeXR2dVJyaE5OMXpGN0xOODhN?=
 =?utf-8?B?bzZ1a1lTMUhVWXg0UUFtNTNMaCtLbU1ZMis3T05UUC9jZmVJQ2dmd1VKK1da?=
 =?utf-8?B?akQ1b1BMaDcrMTlCWlc1azZGQWlDUUNnbVQ4bFprQ0hZR3dkM0ZyTnI1SEp4?=
 =?utf-8?B?Y0p1Z2c1NHNYZG9sRDcrWHNxZmt4dUl0NUVjM05Oeml5T01HYzBwYTdyN0Jx?=
 =?utf-8?B?aWU0YUM2VmFVQi9CS2VVdUhKd2FtSmRpK204N2FucUhuQk82a1IyL0JiMGlX?=
 =?utf-8?B?OXY1K2hBRVUvbDJDVUQ0cUdRcmZyL2F1VmR2U2RXdXYzRDRUQlBGUm5Rd1dR?=
 =?utf-8?B?cmRBS1N5eUZQdmN4MnR1cm9Rd210WVZaK01oQzlLTjBOR09rSEdxemZMNWda?=
 =?utf-8?B?Q2FBZXpZZ3UzYjZsNDRFYXhuZTRzRExlcEpoUnAyNFJYVS9HQy8ydzIzS1Va?=
 =?utf-8?B?Yng4UlVuVkpkeWZNT1NNTXppUkJUWXA3UlBxeWFGRVFmazF0cTROL0ZVZXZn?=
 =?utf-8?B?aCtXS0UzQW90ZWUxMmU3aWc5SzlObGU5T3hsK3FIek9UWkVIcDZyZ1FDVkpj?=
 =?utf-8?B?cmlnOHlSZDF5QlJ3akc1OWtNV2Y4TndnNk9IUlNZTERTSWxvUFhkQ3NqdW5I?=
 =?utf-8?B?c0RBUmVCd210OXJka2k5TXBxVTlCV3I1cTJWcWZSdjhCOHhrb0hhYVRYQVYy?=
 =?utf-8?B?ZWozTkEzUEpqZGlKSkN2M1IvdGI0RE4wNlFxT0Y4ZHJmenJ6NFFBVll6L1dY?=
 =?utf-8?B?SkhIZVRJQ3VNaVl1RzhiUlBaUUV6UkdZMXdjRFNnTDg1SEZkZG9IeWs4ckJP?=
 =?utf-8?B?aldaUWVXTzR4NFZpTDhsVWt2akFyWFRIQ2tBU3ZRN3UybWhMMlp4VVpPOGYz?=
 =?utf-8?B?Zk1Xd3BPMk1NRkhqSUplNDQ2MS9STi9panNWSGRWckQzSGVmeEoxRUhWL1BH?=
 =?utf-8?B?K09GTHF1SGRMeVFxOU1NRkRPN09hLzJUMjl4cUUyNW9HcDNuZ2ZCdlpOT3Ni?=
 =?utf-8?B?NEFkYVNaWUhYbXJSUFBmMS9XbTRWaXJteHVieHBtcE9iZDZaZ1p4RHJHa2h2?=
 =?utf-8?B?a1poWDM3cU15MkhaajFVOVdUNVRhQVF2aXc5anBTY0hobkZ4SXJBUVlJSHUw?=
 =?utf-8?B?cUNDNGF1N1FmemZLbDhhanJFalk2RVA0NlNSVXJKdzRSaHB4b2t5UC9lbVNH?=
 =?utf-8?B?bG1WTnNWL1dXWFdzYUhkOFp6NHpTWUZmY1RwWllybThkM1FFZ0RjM0pmK29U?=
 =?utf-8?B?dlVWRUwwMy9oTkwrb2ZZYUxRWkRCdU9RYUhmVVFHazczZlFldTN2NCtYRXZ2?=
 =?utf-8?B?dGR1S2dlcFByYzFJNGRkWGtwS0V4eC9PMFcyZndZOW9SVEhjajEzYTJoZVdo?=
 =?utf-8?B?Mk5YSVpYSWZYcERFck5LeEVScWxqa2doSC9zUzczejcySmw2QTk2cDlhYnhx?=
 =?utf-8?B?REcxT2J5OEY4QlVMdXUybTYzN1hCWEY4c2tBVEZvK0VTOHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5533.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHlDZGNVUnBXOHk1QUlFbExic0hSRmhDMGMrTGtnR3hXTXYvOTkwd002VnZl?=
 =?utf-8?B?cGZkSVoySHNRTzRaeHNHYmZqWENUTVJGQ291N2Q4Tm5aVTdPSWxzdk9sTTB2?=
 =?utf-8?B?K25wRE5IL0ROck1QRzU5dEV5S3pQemQydW1uYmpJNmVUaXJIeG9lblMwTGhZ?=
 =?utf-8?B?Y3cyYmN1aUloRVAxSkhpdXlldWN1eW80c001L285NHhnMDU3RVdybHNzTHlo?=
 =?utf-8?B?cERMbm5OUE1GUU1DL2RCMlp2VzdLUjlKZzkrSncwSXM5ZFlaUHh5R2FMYndV?=
 =?utf-8?B?Y2hlU2tZQjdsaWpyYUJ6OVV0dHB4ZXhxTEJvRHlhcFVVZ2NlUVhhNDBlMWVm?=
 =?utf-8?B?ZW5aeCsxenJHZXJFSHJlTUlpblBJZHQ4S0F1OWRwd244NkdBb1dvYXEzbGxh?=
 =?utf-8?B?SzZuN3BuK2VhYU8rNS94bVVXaXNNRjlmZ1hLQndad21jWFRBNVRxL3RNaXpi?=
 =?utf-8?B?RGlXVFNJQ1p6UWl1SjNNdHlkaFBMdGdzT1BGeG9VMWdQRDRSZVhkSnVsQTJU?=
 =?utf-8?B?ZjdHcDdIY09ZeGgrUkhXbThqY1RzeHljUkZ0MUY1NUpsUlNIZXVFcXVkbFFU?=
 =?utf-8?B?OUZib0x3UmFhak1JNllqa1ZIaUMyNitKZDJmNGxTbXRNa2doaTRQK2QzVTFj?=
 =?utf-8?B?aWhIL1JNaG9ieDJpM0FLbThrK1cwT3NGWVoydHJSVFB3SmNwZ2FtbEo0STdO?=
 =?utf-8?B?Sy9WZlZ2Vmd6bFlVcXBEQWI1N0FDS0tmSjhnb0twdVlTelRzSCswSmJGSXJV?=
 =?utf-8?B?TlZFdWVheDM5VkljcW5lbHc0QVZpWlNiZTN0ajZIMklSWS93dUU2bWJ2eCtD?=
 =?utf-8?B?bHlxYW9mNW1sRUtFcFoyOHEzRzRNZUg3Q01ESVZGUFI5MDEvajFTK1psa3RM?=
 =?utf-8?B?RDlzeWk2b0t2ZE5tOWxWNlpGWHpCR2tJNlk2L0YxdTBWUGtHU3FCVUxtV0dV?=
 =?utf-8?B?MXUxK2NIVjRzZUFCaEJPc2RMWnh0SGwrbnJTQk9Ebi9zZWdjbUdZcG03aWs2?=
 =?utf-8?B?cTFYeE5ISnNteGhZNE9jdmw1WHoxckFXdUtiZ2VXWGZwejg4V2x5UVhPeEhk?=
 =?utf-8?B?VlB6UnJvcUJiYjJ4a3dVWGZQQmxTRkQwMnhyZWszUllYZENXWjArUVJhWWpw?=
 =?utf-8?B?azN5ZlVRT3dSdWk2TUdLdSt3ZDJianZJWUJVRUR1c3dHblVJY1pqYUlpOVR3?=
 =?utf-8?B?VENsTWtjeXJqcjRGRUU3aDl1emtQSkhVWmNpK1MyZWt2aHMyQ1p0Mjg1Rlgv?=
 =?utf-8?B?ZW1OZ2RmbTExS3dBZXlSWVQrR3RzS0NxY2dvTUg3bHZzaDh4TDVIbjdvVVNo?=
 =?utf-8?B?by90VG5UY2pVU1QyQndBS0JDRWg0bGNFMVhTQmptZjNjWG5SZnlOTHZSWHd4?=
 =?utf-8?B?amFLWWxYY3grTWhFeG4wcHNlQmthWDA5a2kzeHZLN3NEOVMxZWtvdU9ESXY4?=
 =?utf-8?B?MWVOQUc1TWtpNkp4K1BOajQzakIzajdLcW1JbDZkd2Y2Mjh4aVlTeStBZlhv?=
 =?utf-8?B?WWxWSzlldktLVDl3UG1Hc0ZpLzdaMVZxdWVLM3gxc1hCUCthb0ZYUGVweUs1?=
 =?utf-8?B?T2MrbDRkbDRCcWNOcXFIR0tsMXRkVVVJakNVUkptSlI2d3N2RnhFOU51cXI4?=
 =?utf-8?B?eVRMQ213VGhJbzNLQWJDMDhWZnhtbUNKWDgybXZNMlRVc1RsZ0pEOXFkMnhK?=
 =?utf-8?B?QVkzSzNVSE1DQ280Z2ZHY3F4bzZVdWczL1hKZEVSOFFWV21qWUxEdllUako1?=
 =?utf-8?B?TDFxZEQrd0JmdWQvQXdSaGR5L1RucjByWmpBUE8rZVR4d3FwdEhoMjVsVU9D?=
 =?utf-8?B?eG9nY2U5ZFJueUlxa3djckFwTjkvWEFuTWxtU1JXbGFpa3JVS291YW5remdr?=
 =?utf-8?B?a3VhUGZ1SlU3Rk1KVWxrZEYxdmFycjNwRzUzYXV2Njlsb1psTGE0M0xKaUdx?=
 =?utf-8?B?UklTWm1oQXVzRmd6SjBGT1lTajFueUJhQ2x4V0FVcDRDMG9naDB3a21YREwy?=
 =?utf-8?B?bkI1Nm5oUEs5dmlTaXVmSU1FdnN4Z09PMWZzNks3OVlKc1Yyd05tZUdpTU50?=
 =?utf-8?B?bGNOdDRKRE81NS9JbWpDWm0vSWRPNVlCNW8xZ2drU3dlVnlMUmQ2d2RpbVR0?=
 =?utf-8?B?NDNLekFCTE5zb3kxZDYxdU91Z2EwSmhaQUhqaHNuYWhyY256VzVUbEcyRVVB?=
 =?utf-8?B?SGc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e5017a-accc-43a7-f348-08ddca893fbf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5533.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 08:08:18.8204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Ti0s+cJCnHaJF82lf8XKF0uKObNhByUgFvY0t0sb/+HDi63c8WMamPCF+ZyVtwliIPJgRCb7R0gQQiB8M9QtpoKNyMn/YvkD43h218htpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5055
X-Authority-Analysis: v=2.4 cv=f/tIBPyM c=1 sm=1 tr=0 ts=6881e9f5 cx=c_pps
 a=ct44O7CZgj5oH0XY3SFooQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=x1LY-hpAslPs3y2KQ3oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: xpICgB9odhY5mZ2ZXUXaCLYJvw1N64rF
X-Proofpoint-ORIG-GUID: xpICgB9odhY5mZ2ZXUXaCLYJvw1N64rF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA1OCBTYWx0ZWRfXxL3GcltDVCVy
 3jCN/iBsSw7M5YEMDdlGLx/Wvf6JE1yvChPgMzIuucyXyEYhvZkGfc3djX+EkYTw00pfO9sufOw
 W6qHaPt27nJiFD4Ets9HEpobDODEq7WZinttiOIJEPNlOXMnHS3J6rNXGDQhkm+zIBfVqW0c3eK
 RFrq3Khg3/D7DprVYCOVzMPO82og6x9eSqYQgpUVaVGD9itqwbpfMOprhosMJGWjj3u59R38deB
 z9zoU1jKuTwCMRkGzQ3KXK6pMoR/JK7KHLNWfDZwb3KhgbECrpTquS+M+N5cFcHFYh8riBQJPIL
 kkk/M3g8ewvnBKWbMVOEOldSx5kSSWo3LgMPN0Y/mu81UqGxpqMPQypQiVWlt/78VuWz8A0tXuX
 W52fgLvA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 clxscore=1011 spamscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507210000 definitions=main-2507240025

Hi Patrick,

Thanks.

On 7/23/2025 1:27 PM, Patrick Steinhardt wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> Hi Jinfeng,
>
> On Wed, Jul 23, 2025 at 11:07:37AM +0800, Wang, Jinfeng (CN) wrote:
>> For a specific git repo, when I clone or fetch the repo, I encounters the
>> warning
>>
>> remote: warning: ignoring unknown core.fsync component 'true'
>> remote: Enumerating objects: 41, done.
>> remote: Total 41 (delta 0), reused 0 (delta 0), pack-reused 41
>> Unpacking objects: 100% (41/41), 37.51 MiB | 10.91 MiB/s, done.
>>
>> But after clone the repo, I didn't see core.fsync in my .git/config. And
>> there isn't anything relates core.fsync.
> The problem doesn't exist on the client-side, but rather on the remote
> as indicated by the "remote: " prefix. So there's nothing you can do on
> the client-side to address the problem, you'll have to reach out to the
> admin of that repository and tell them that the repository uses an
> invalid value for "core.fsync".
>
>> I also tried git with different version (2.25.1 and 2.34.1) to clone the
>> repo, both will show this warning. What configuration causes this warning?
> It's "core.fsync" indeed, but not on your side. The config does not take
> a boolean, but rather a list of components that should use fsync. I
> guess the admin wanted to just fsync everything, but in that case you
> don't want "core.fsync=true" but "core.fsync=all".
>
> Patrick

Regards,

Jinfeng

