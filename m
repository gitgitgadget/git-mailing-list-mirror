Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5ED547066
	for <git@vger.kernel.org>; Sun, 20 Sep 2026 23:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789945498; cv=fail; b=h1XQraJtBsH7qh/1IymRSYJkbCy49LUGAHfeGEibUJ+52pw6rFbWX04S4lVgIOYQlWt8wsOZG+FpqHsc+POuXH+BF/YJaoiiFwKswH3Nbv18EvLwT3u3nhvwygmpjTfAEKmpAGFVFrR2LIrWXwBWe4TPq1lp1ZyDiN+BlpBKgjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789945498; c=relaxed/simple;
	bh=neGEtM1nQeIxDp8IXQatoi/KEb53UMHzwELamO+vb2M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mkcGLIyQkkATQ4WtGD/qstluYtXdv7NsAR7WnHk/rdBziouCISbguKTwV+FU/UxGHral1vfeG3TxCTwYsIZ1CESqZvOFfe6bLtHJaXOG5oJYyR6vUrpUIzIt6mIfBabGuDoR9PRNh4qMQsOoi67r36+By/ANEXDSddGaw013lQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PCoKFOUP; arc=fail smtp.client-ip=192.198.163.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PCoKFOUP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789945496; x=1821481496;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=neGEtM1nQeIxDp8IXQatoi/KEb53UMHzwELamO+vb2M=;
  b=PCoKFOUPVOCMfdh25a1JVek02chPV+pUMjgN2kGglphiMm+prtXYoKsM
   t89N49HfDGWHD379oUE+xDSV66Dj+ukta4Yot5cPhTx6Wjz2ieGAejAB4
   muvJbbmGJ/o3h4ARL8BFVRfW3207OzkEmURAb2kPZ182cIzY4utkhoF3m
   mTUBJeIPBnXTXQxw436nZs/AtqNrtvU/mgWINEaiUkMxrUmOFOwG5sjCb
   UGmqDgFAWsUyVbebVCRRFJHd6CJ3S9Hqeo0zJpuZK6f/9QqEDEcsTgLtO
   lUHWkjvgTfNMwayDodqp6UtB8sHWhAlTcPc4R+Jsnbyg8MgFdUHE0tIqo
   A==;
X-CSE-ConnectionGUID: 3DTZdhrGTAiHxAQJlSefhw==
X-CSE-MsgGUID: 03GavYHITu+Z3kHhLiUHHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="945036"
X-IronPort-AV: E=Sophos;i="6.27,112,1787036400"; 
   d="scan'208";a="945036"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2026 16:04:55 -0700
X-CSE-ConnectionGUID: btOkyP4JTQKe6eszuWnZAA==
X-CSE-MsgGUID: MPI/49B/RfazpkjkN8zztg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,112,1787036400"; 
   d="scan'208";a="277194400"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2026 16:04:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 20 Sep 2026 16:04:54 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sun, 20 Sep 2026 16:04:54 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.31) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 20 Sep 2026 16:04:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqwQCRrUv7QlCDwhIEmKsOwgjmGQJkW9XTImlrhFRHLG69XMP8M+2rZpxtliNrKqvScQ1tWjPt9e7LB9xwJDRD7FZBDGR/h8NxX3+rZNNa8TI/KEQCqn1Y+kGWOcmlJaZlKmvRRlXBI0JWaWehybWSOKvHJTrrPpNC0Rrjhtva6YwHbvddessKUWi0ugQFNWLKYkmN35s5HW9rIRHBaaPhyLqxY71r5ZXYbp0HiPPqNq863phFDjVahGKtbwi2A7fHa1LaPYa+I54D/bLVJkmiAnKHeO23osITPD0F0xRqsyir31uzLAEKNSS5qY5ZJZcq++UYFRE8X4ARrtxWlGqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QKv7Yn9kMFCJ2jIWVsDZ1zOyaOtsO/DKerpgGtaags=;
 b=dUeKcrrw+XO2Njz54OQJG0i+MgHlrR2GyHabodz2a2YYSgu+mR+GVMbpqsj4UM/+7xFxQidhVPD59hYCUgkBDQgl0wNAbCqpvNzqf4ZP2yfw4EFwcyCZpfVJ0UJepnAov66Y7Yf6U38WuKGmaSxDcr5DEpz44KwOTB8nE9G/ROTiY71+N2i6Og3u7wcF5POln4fyfubcE/gkeDOWXoAKeuFUoE1mEzBGi1uGHO5xxizUK7fkEgi2kBSjySxRWKkqUVKVi++Tc5i0mxladMtuWG/qs8HS070ZXF+zu7nqA2QNWsP6rLptG/yvJkdHSKy8rmEvK3fQw/OlqBzgVQ287A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SA7PR11MB9543.namprd11.prod.outlook.com (2603:10b6:806:4d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Sun, 20 Sep
 2026 23:04:39 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0428.015; Sun, 20 Sep 2026
 23:04:36 +0000
Message-ID: <0c82d50e-f2c0-4db6-ade8-7a403cac73da@intel.com>
Date: Sun, 20 Sep 2026 16:04:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] diff --no-index: fix -R with file/directory conflicts
To: Haokai Ding via GitGitGadget <gitgitgadget@gmail.com>,
	<git@vger.kernel.org>
CC: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, Haokai Ding
	<hk_ding@outlook.com>
References: <pull.2232.git.1789715946888.gitgitgadget@gmail.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <pull.2232.git.1789715946888.gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0145.namprd04.prod.outlook.com
 (2603:10b6:303:84::30) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SA7PR11MB9543:EE_
X-MS-Office365-Filtering-Correlation-Id: ddc38131-98b4-4202-c47e-08df176b8a5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pqJG7Xhh4W3CH8z9WDtwe1+pMimHaneNGc1n+CcfG9MlVS0TUhchCXTCZon60E73L1UHffvfnpO/ZY5gtjwnHomQ+SKB5WJWZ1ljv/Y9+LVSGM11Swv/g7RXJRzGIFXsmgbDy/G7XB93BHmv8JY8DvA80jgu8D7J+cCCEwMn6mhRfIoFZmvA29me1e2ammy9JJgZiG69tatp12FHzZcJN9WvtqjPOEtnQ3Y7CSBBTIMQnSnSA+IHQG66ddD4ITUmXxPUhPjljwCKinR69uubdVp66SssKeITaAl+rlXUGYkovyeSvd6tEAHrdrTaCDWXJ6MDQgL9Cmv5QYoaEIRK3bCqMcR9Z8PCkx6+UHTh/xooR+B2HdguK/c8dXI3Pk0il4l8ilC0O4X8d03RGoLbNE3WtgpYPcZIHk/5mG7t1uVRhgUx1fmfhUbC6T4fpHXSncFur3YswusJAI0+ARrCxI9nLOXTkvzDasUjPvK8Ka26G7ZwybcfiL9Iq5j3xOVjVbcOXAxpa5kT4gloJhHuCXt0XctHpN0LgYrGU9yV1JcIRKanQhnIUKoU4u7/2VQe+NijD7+G6sH5RNGdS72ej4K413RjA/Tuv4dGED9UXJZhiGf4jUIWJJKLOTduAdhD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1orMCtjd2lNb3Y2V00rbWxSMmpybDlPRjVYRVpiOHM1V2dFSW1VMFgrYmdF?=
 =?utf-8?B?VG5IZG9YcTBlenBpMmlBcjduanpJQ1hYdGNjbS9BZlBkb0pBNGdvRHNleFNv?=
 =?utf-8?B?N1BSZ0FwWExrdWhSRFQ2SzFpcXBEejNmUUljWTBPWm56MXk4TUtjbk82L1U5?=
 =?utf-8?B?R1FuUXNacitweEYyaklVT0Rudk9PWStQZFhrY3ZPaEd6N1lxbUQ4dVRtYUFZ?=
 =?utf-8?B?dWd4aytTQnhHR1VqWU9jL1NsTHcrMGNiTXBlRjFKRlhhcFlJK3NwaVNkdzJI?=
 =?utf-8?B?a2hoOFRiNHRLVnRUM0RwYmp0Z01GSllzVGEvRVJRY1N5WWlEazNxM283ZW1D?=
 =?utf-8?B?cnRJN1BhUElWUlpad0wva0ovbU5sWElMZDB4RVhNelhJSWZNZXhCWUJmYjRP?=
 =?utf-8?B?Tmdyelh2dUFKbVM3UEthWkVFa1N5bS9VMk02U1ZzY1JRdFA3V3lOZTk4aE9E?=
 =?utf-8?B?SHpxRVAvcWlaWXU1Q1BnZXNHMDcyTmwxTVJLcEJwajV2MmVrQ29RdTJLRU1H?=
 =?utf-8?B?Uk1sdC9mN24xVFFuaW42Z3U5SFZQRmxFbjV1eFExSlp2VGo1c2tnbjhPRzNN?=
 =?utf-8?B?dWRtclpSbmh4MEJOcHpPc0dQSjdTUnZrOUJMRUx3bGtXQnN3RDc1SW45d2Q0?=
 =?utf-8?B?bUQ3SUxVaGp5L2dVd3FZb3E3Ykg4SWFzRkZTV1Y4Mnc5VEIvVlB6U3JKYkl1?=
 =?utf-8?B?UVphQXhXclppaW9jS0x5MjZoTGV1Qzh1Y0tiQ2pjN3A3bmwyLzlOSklxUnlj?=
 =?utf-8?B?ZGptMVlCV0RkMG5aMVIyamVEQzkzd3Z2SGw1aDNmenVyR3NlZ2JtcFQyK2Rw?=
 =?utf-8?B?dGpHVitscmR4NXdYcGROVkI2M2pNWk1rTDJBU3RkRFZ0Y0E1UTZoVVRzRzZN?=
 =?utf-8?B?d2RSVk52bHNOU04xL2dSS0tkdU03WERUQ0JLUlRTaGRmN2c2eHJuMXFUM1J3?=
 =?utf-8?B?bWVyMThSQUI2RFJxOUZBQUlHNXYzckZTUzRoZm1wVnFaRTVxODVsV3N3aUZx?=
 =?utf-8?B?KzRWWUNKWGF6ODl6NGlVblU4REdkL3JCWFRvWVJRU1RaS3VhL0RDRkJmRWtv?=
 =?utf-8?B?aFVvcUJzNGtYWnd6VzZyL29PdGc0ZjVzVlZhTlRQVERLTnRqNTIvOHRValRa?=
 =?utf-8?B?bTJBYmE2T3d1VXZ0ckRUbDdydEF3TUhVZ3N6bUtka3AyU1VJWFVwZVQ4eXRx?=
 =?utf-8?B?QUJ3MFhjM2N5OXR3NitSQjk3Z3pOUmJvYjRIc1psR01KckpGbkJucUx3Ymcx?=
 =?utf-8?B?T3NUY1ZXQmRjeHAvdnJlV3Z1Vy9wWlJvREFScWlyMWZ2c25BYytYYkE5Z2JV?=
 =?utf-8?B?QisvREpmT3JOQS8zdU1xV2VJUGpLazFWZ1ZJb1NMaXUvTWxFYnpDM09QSEEw?=
 =?utf-8?B?dStXMFM4cFlRTk5rVVdKRDk0M0NGZnY3a0FWWm1mNkdqQWxQVzlrbjR6Q1JK?=
 =?utf-8?B?eFhBaVpUMm8rWllPZDRBUUdFNjdETU9oTWtNTi9XZ2c1Rm9EU0lnemJsVms4?=
 =?utf-8?B?cnRrYzl4ZEF5NGtueUxOdkVjbHAwanJiSGk4T2Y1V2w4KzUybXJIeEgwb3di?=
 =?utf-8?B?MytYUUZsZEV1R21ucXQzK0libldNSDdxd29yQUQ2Mi9HdGNSWTdkMG5tVTJs?=
 =?utf-8?B?czRhNlNEaE1rV2RBcUpiaWw1VWdYZkIyNVFLZ1JuUTVVc1VZcnhuNXF0VFV5?=
 =?utf-8?B?SURWNFZCL1ArbGJqY3ZUZW9JUThDeEJTbDhTcDV6SVQ3TW1ONzF5SmJaS1pC?=
 =?utf-8?B?WUJCYkRmcnZnUFdZc2hzZ0FJSjU5YjdvS09yRWhqTDZsOHcwUmtpMGZJcnFw?=
 =?utf-8?B?TkF3S1Q0T3JiSFp4MGVSUE9xKzRubHhQSjJoZldBclJaTVNaci84MzlhSU9k?=
 =?utf-8?B?ejNQV2REM2xIakU1WkptYjMxY2t4UjMyQWNCL1h0OWJWL3BMZGtzclRQcEpi?=
 =?utf-8?B?V0NTcW1YeFVmSlloNGVtNVZUSjBxeTliNE5pNFZmQ1M3TlFoTjJZOU1mSVhj?=
 =?utf-8?B?RnVjalJleXVUaFlha2FOWmwwU1lNR1A0NENjZElQNVBtcTlzOXVKRlhWdWpF?=
 =?utf-8?B?UmlSaXZyOVJCSTVObkNJK3NUS09XMVpCajU2cnd1QVVUT0hDNW1OQ1V2UW1k?=
 =?utf-8?B?WENicEVEMi9QOVFSbU5PVjRremp0VlpFUWVKcVFYMTArbHp6Sk56Tk0welpT?=
 =?utf-8?B?RE9oL0NrQmRzV3VXNGhuWGtXODFYZE1aVU92RzhRVk0vNXYzZUVSdCtUQ2RO?=
 =?utf-8?B?a1pDSXlYL0RlMmduL2dZdjNHSHIyOCtCemZYQk9Ic1F3SmlHMUtSZTJsU2xl?=
 =?utf-8?B?SG4wcW1xN2JsVjBPRnIrMHFNOXJ2dEg3VDU4SlVRdzhsQWd5VHl6UT09?=
X-Exchange-RoutingPolicyChecked: i+o//nbU1neDCilKVplTBPIjlEahx0CC/xzkNq26N6lcn+5iY0K7USdyDPPX/EqWOPuMlpcnNuJHp61f10Jqg0085vLiNb3mZ1amXwPEazSE/xcd4FLalunt/ky2+AjFI6ABz++e1OhyT3UlVt4cCTN+k60kxIMFwg6eYacGmT7FtamgtmWp2vM9YqsvgaPRci4B0VTsUoEU+XQwwjfnd4P37ASIOVaCFCysJmHJ2h6EQZNLlk9MhWEtxE2Ys1t+1RE5AoXkfH3XOfe0H/N1RIBHehiLDxsanXLy0EAdG/r7qM48OCfymoDEfJioxKlPcEyqAx3w8YVMbBX/HSr20g==
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc38131-98b4-4202-c47e-08df176b8a5d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 23:04:36.1811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cssv1GVPm1/kjyZl8+wNKIVNadvyltLbbaQ0c3fpnI+yAbTRqAM9Yo/zCQyijmCbbyRwupkB5+nMjJO+ZSgJIaTDPrZYdAKcjV40R5alYME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA7PR11MB9543
X-OriginatorOrg: intel.com

On 9/18/2026 12:19 AM, Haokai Ding via GitGitGadget wrote:
> From: Haokai Ding <hk_ding@outlook.com>
> 
> When a path is a file on one side and a directory on the other,
> queue_diff() queues the file separately before recursing into the
> directory. This early queue entry bypasses the reverse_diff handling
> used for ordinary files.
> 
> As a result, comparing directories d and e where d/sub is a file and
> e/sub/file is another file reports both paths as deleted with -R.
> Reversing the operands reports both paths as added instead.
> 
> Swap the filespecs of the early queue entry when reverse_diff is set,
> so that -R reverses the file change as well as the directory contents.
> Add regression tests for both directions.
> 
> Signed-off-by: Haokai Ding <hk_ding@outlook.com>
> ---

Thanks for fixing!

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>     diff --no-index: fix -R with file/directory conflicts
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2232%2FHaokaiDing%2Ffix%2Fno-index-reverse-file-directory-mail-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2232/HaokaiDing/fix/no-index-reverse-file-directory-mail-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2232
> 
>  diff-no-index.c          |  2 ++
>  t/t4053-diff-no-index.sh | 18 ++++++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/diff-no-index.c b/diff-no-index.c
> index f320424f05..a9151cc27a 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -188,6 +188,8 @@ static int queue_diff(struct diff_options *o, const struct git_hash_algo *algop,
>  			mode1 = 0;
>  		}
>  		/* emit that file */
> +		if (o->flags.reverse_diff)
> +			SWAP(d1, d2);
>  		diff_queue(&diff_queued_diff, d1, d2);
>  
>  		/* and then let the entire directory be created or deleted */
> diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
> index 8e0394cf5a..c3c703f4f4 100755
> --- a/t/t4053-diff-no-index.sh
> +++ b/t/t4053-diff-no-index.sh
> @@ -120,6 +120,24 @@ test_expect_success 'turning a file into a directory' '
>  	)
>  '
>  
> +test_expect_success 'reverse diff when turning a file into a directory' '
> +	(
> +		cd non/git &&
> +		printf "A\td/sub\nD\te/sub/file\n" >expect &&
> +		test_expect_code 1 git diff --no-index -R --name-status d e >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'reverse diff when turning a directory into a file' '
> +	(
> +		cd non/git &&
> +		printf "D\td/sub\nA\te/sub/file\n" >expect &&
> +		test_expect_code 1 git diff --no-index -R --name-status e d >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
>  test_expect_success 'diff from repo subdir shows real paths (explicit)' '
>  	echo "diff --git a/../../non/git/a b/../../non/git/b" >expect &&
>  	test_expect_code 1 \
> 
> base-commit: d38352cd43ab9745686d697872408bc3249a153f

