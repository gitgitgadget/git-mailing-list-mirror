Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010000.outbound.protection.outlook.com [52.101.61.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F5C15E5DC
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 01:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768352801; cv=fail; b=I0FnHoi7UQOi+xPM20H6GDWJQVYQetJ72lxbMQlAdu9/rWTqNwHf/Z228EhkySO31rC+SmEV7lSE6hGG0gfJkcDEHXpIMp93urSOUHLDCs5i/orJ8WCY2aqQUivUTZsWksTxdqCFTMIhE93RNEvmvSEUn5GliUdF3Y7EOuv7TC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768352801; c=relaxed/simple;
	bh=HiHeZJ96rAMBu4TnD+FKqsw2/hE8l4XHwFgPCU4Kj8k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ShRz/kYwQBEUuH0RbPxXdhDzPazLHDAeX1n+8HW2+bgmDT9t+VSMegv9ySu8wxHogK155ih6q27mIrLyY084DqmFYSo6AMNaos7Vnpw95EceNrOX08csLXaSX0qsINp8SuTJCICIYoXUX3HfDjfCyF4Y25SOMHoCSc21VheW0BM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cElj/ilW; arc=fail smtp.client-ip=52.101.61.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cElj/ilW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RiRL2t4OaVYlaLFUjNqjk1j/TPDoi5vi0nazSttHH9p85y/sMyqI5shRGrrUeOrukPXE0M56GjidBSZK8DJjoPJe9jFZ6i/4z7fXqD9bm2g8hbE3EWns2iNKmMNG3zGvGk906NhglClqjlGDs2TpGKEYC5ILt3VTBJA3EvKu8LzTxOUVyod3TmHz6P8/Qvl+uuDxh0mB+BAlejZk9a+r/CJM5Nf2T3peHEhbH7ehemHOnxckJnyy1o7t791SlGUcJIrY+8/sSdCqZ9spyHftHYcGdm4pQHyyta+rgXMtD1wq1IixIFr7KL7Hem8gtDRQP/mbac/kMjrCRA2zrAJ1yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0CFJDtrlAOtPqz3HJy+jVWwaV8whWQC8eVrSagi0JQ=;
 b=ffAdVFChFWXBlgPejy/4L4yyY6pZMxs6r5beaaUntbLztZxg8jtoK2g+i6Cx8n7TrNYVlRhBod74idiUjhi7H6aK2WYPud1mcWOJiG4cc+PU9JjjiDlEq+rMmu+K2Np0BE5JyRJvBdlZDA3W6ifURNc3Fa3yWqo1K8i59b3f7ZWVlL4DMnTU/uudWO/ElOkN4vbzshqC8OI5tw2NDpjTMm1Catu5xsrkE9y58+SZbW4sNTVQg7j6bUJrpIdWMSNJeobLw3oKlVk/Oz2PAzt/DmWln2oUMfc4mmrayiuGWqWB4Ix0c66TV6I4Rbes00fVN7Ird/x/ezFh/Ge+dX4bJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0CFJDtrlAOtPqz3HJy+jVWwaV8whWQC8eVrSagi0JQ=;
 b=cElj/ilWwXRQtMmAeaqyEyg0jV+8H1FEQGVRQefsfLmB9I8aveZLDM6Mqyhg1f3AphYUUYU2PuPG8bGT0Wej3WE0AX8klSYBz4rroU9O8q+FxIsLkp7BPQxjl2jLUBLK1i/62H5cpITybIOn1mi+bCVF8pyiKLfYmSnm17O4dSGgODqx5gvgOb7B8T3+YXOJskWKjt/yLJnzZAhQUZ/NC07uh7+vR5XuFjZMoaxd5GdGmlsCYY7GI732zUn/AJCchbqXtg1RPkDFqUrvJeVBY74S+gZgavDm3qGqCSn5IaG7g+MK83lugtkVkUv/8r67AK95TawdHJIWhjvvcwJEnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5305.namprd12.prod.outlook.com (2603:10b6:408:102::5)
 by SJ0PR12MB8116.namprd12.prod.outlook.com (2603:10b6:a03:4ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 01:06:34 +0000
Received: from BN9PR12MB5305.namprd12.prod.outlook.com
 ([fe80::83f5:1b0e:a61d:6707]) by BN9PR12MB5305.namprd12.prod.outlook.com
 ([fe80::83f5:1b0e:a61d:6707%6]) with mapi id 15.20.9520.003; Wed, 14 Jan 2026
 01:06:34 +0000
Message-ID: <a919f4cf-8355-43dd-a552-df99325e4cc6@nvidia.com>
Date: Tue, 13 Jan 2026 17:06:20 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] remote-curl: Use auth for probe_rpc() requests too
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Lucas De Marchi <demarchi@kernel.org>
References: <20260113031929.3746753-1-aplattner@nvidia.com>
 <xmqqfr89lkve.fsf@gitster.g>
Content-Language: en-US
From: Aaron Plattner <aplattner@nvidia.com>
In-Reply-To: <xmqqfr89lkve.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0021.namprd08.prod.outlook.com
 (2603:10b6:a03:100::34) To BN9PR12MB5305.namprd12.prod.outlook.com
 (2603:10b6:408:102::5)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5305:EE_|SJ0PR12MB8116:EE_
X-MS-Office365-Filtering-Correlation-Id: 14d801d7-8aae-45e1-10dc-08de530927e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXd2R3RxcmIrUXFWYzdrSkdpZ0Z6VjBtRVNnenZtY0xhQ3QxOUJyVnFzditG?=
 =?utf-8?B?U2RTL2o4Zjl5aVJSTmhIRk5kcXBMNWVKcjhsNmJrekc3UWplQ3ZLN1VPLzd3?=
 =?utf-8?B?S3IwWDgzbCt4ODNnay8xa2VNUWNrTVNMSUFqVm9kWXJ2Wk0wbFNER2wxL0Rt?=
 =?utf-8?B?WExvWktuWjBDa2ZWWjJCM2hRZFJGRUh1bXpMc1ZGTGRNdXdEQkRxcytZamU1?=
 =?utf-8?B?SC9uNGhhWG44OHhKN2NxQXk2RkM1am13RHRmYTUvZzZqUDBrNnU1M1VCbUxW?=
 =?utf-8?B?KzlVYzJOZnJreXBXN0J4cjJGaWh6NnZ1UkpDRjJyU1o0VHBoQ0ZWdGNhTTRI?=
 =?utf-8?B?N3N6bUtCK25DV21PWk5mdE9SK2RzbUsvRm15Q0Z6RUFyb2t5NUJOcS9nbWU2?=
 =?utf-8?B?aDJueldMck0rbXNFWHpqVUpubTFHa056ZFJmK3o1WFFBekFQTmtqaytMdUFF?=
 =?utf-8?B?TzlDanZEa3ZzdkVwdUVhOG5kd2FwL3hLQldVOGQxRnpManNIZmJuZDlkamdh?=
 =?utf-8?B?SEp6UVNubm5wcG9NZjBXQ2dYV3lpUmZYSGdQMm9OUW1ESUFSUjFMaWljYXB0?=
 =?utf-8?B?TlNPOUZYbjJHMVA0L2dQMGhPZnU5aHllbHBieEhtS0wvNWxGRFNPM1RGUmlJ?=
 =?utf-8?B?OGZLSUpTcmtURUhONjVGaHBxQURmdkViRGNYZE8ybTlWOVBxMlZsdTRwem9h?=
 =?utf-8?B?UGxnTVpla1VJZHVJVlZ3VDN5Y0VJZGd3QVpwZjVPK2M4SG5CczczVmJBb093?=
 =?utf-8?B?SGQxTjNyUm9oQTBud3VndDRsdWFmbWF4QVMrWVRYTFdpM1ZIUkNqUkk3QkRz?=
 =?utf-8?B?ZysrUkM1emNrWFk4N1h5VDl5UDRlZysyZWFWeTBhT0UreFdSMkNFZXgrS1RD?=
 =?utf-8?B?a3NMTlQvVllkbUpZaWM5VXdCRWNuOGY1c2xkNUlUbDJpcm1qL3BWd0pFV0Nl?=
 =?utf-8?B?bUlrZm5PNm9aZUFDWkp1R0FjdkNaVmhKZUovKzQ3VmtMRy9zNUVTR3A3M1FC?=
 =?utf-8?B?cVZKc3FaS3ZLdjY3MENZbGlsUlZ0eDVVTEk1VkVvRm0wUkhNNysvYng5b1dw?=
 =?utf-8?B?Rlk4RDJDUXpjSlIyNGUwdWdudFRWcUJwOERxc2hjWVNoeVhnZHc5dG4rbWFS?=
 =?utf-8?B?aTNUbVovOHFrWDR1OCtxVDMySk4xRnQ2R2VvM3ZGN3pMMzJpSWlBTXZzMXJI?=
 =?utf-8?B?UGQzVmNPNkJkQmZ1aGVJb1dCcHdkMXIwQy9xS2htejVwaCs4ejlmdDJCcnkx?=
 =?utf-8?B?SmxsTitiUkt6VXNVUEh4WWhvT1FBYWJ0U3c2REFURVlDWFNIbXE4cUxNd1pY?=
 =?utf-8?B?d2h2dGxUWEkwamw4anZnWDE0TWdzTVVZTXRLOHk5NWp1czNROHA4OWFQSC9M?=
 =?utf-8?B?MUZrWVNPMUx5b0swN3pUQ0J0T0ZRNkVGMFNiY01qekFwWUxDb2xZVlJLU2h5?=
 =?utf-8?B?anByRlNoZGZtNlRBS0d1akpVRUFYUkEwY2tEZzU0dkRiOWdZNCs3aDFtSCsx?=
 =?utf-8?B?TjNoQW51M2paMkxadFNMWEhGdHJ3WTg4Vld6ZFEzYjREZmJWRitqcldBMysy?=
 =?utf-8?B?dlRJQUIxTFU5NzFDWGRpTEJaQWk2RHV0KzFxYnRhYXBQU0N3RTBiU3U0RFhP?=
 =?utf-8?B?RzY1eUREbDRWbUNXaHh5TGYySFlLTXlLK29KVjdOWkpsOTJZbUVZZDM0VFpF?=
 =?utf-8?B?cVJlWTRsNllnSUJBWGVhaEMzdkhQWm1wVjhRUCs1Z2RBY0pacDhHRU10dWN0?=
 =?utf-8?B?WVl4UEE1S2Jmb0gyVFYzRTU5dUNaU0hwazBNMFFmYXAwUU5jbXNYZWlrN2po?=
 =?utf-8?B?SEh3SXY2bk9TWUoyaGJlaE1QZTU1N09rK0JFNmpjUXVDQzcwTWw4VXc0SDB2?=
 =?utf-8?B?NG9Oa0xoTzkrSUlCcTd5V0NZTzlidW9KL00vaS9JKy9JZnJVb2pYd2pSVHFo?=
 =?utf-8?B?YkI0bzJrS1BsYTlUemlCUC9IMmFyU2R6eC81Q1lJWDFwa2IxM3F4TjhTYmx2?=
 =?utf-8?B?bko5UWJYdEx3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5305.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDJwVm9mQlg5U2syYzU3V3FEVVM3VVliRkNTYTV5ZVBsRkJUZkNzZlJIS1k4?=
 =?utf-8?B?UlMvbnppb0U5Q0MwZ0trMWxPUDZBNmJzb3ZCNWpCWkNwL0lyd1RFUXBIaFZs?=
 =?utf-8?B?ZFArRy9FbStCRGdRN1FoRFpyUDRxazVqSHprb2hPU0NRa2NnMC9WNFM1elNw?=
 =?utf-8?B?c1N2ejhEL2pKWVNobWRJVXo2Mnl1MXo2dWZ6elQxaFU2Y3VMaGVqZFRIblpU?=
 =?utf-8?B?ZUdTeDdxUU9VbXBObktGSTd0dDFaVUVqc0FFTjBpQkliODNaNXZSTGcxNWlv?=
 =?utf-8?B?bE5oNnlWWEZ6aUFJcVNUWVM0NTFrQ3dsZFkreXZHOFJvS1BiOUt1WWFTakE1?=
 =?utf-8?B?SnNTUjVsUFdFbFdnSVNBU1I0b0F6MjZPazRSOHkwbC95d1B2WnRQN1N0UTRD?=
 =?utf-8?B?cGpZOGE5Ui93MHVDZzZ4a0ErMnJoL1lWMzJpUTRoLytHVTBnamd4M1kweWc1?=
 =?utf-8?B?Q3hPMjltc25hYmdVdzB3N1hPTm5qVGxQVXM1TzZycEk2aVVmYmdWUWh5OTEz?=
 =?utf-8?B?TENGT0h6eUdOSDZIdGswTjVjS0ttVDJXWDBCZE1sbm1Xc2F2L1pubjljclhs?=
 =?utf-8?B?WWFDelNuVGFmREZSYXZPdHlKVlJNZGRqT2l1dzJZWm9lY3kzUXdRMkJscW9N?=
 =?utf-8?B?RWhVc2RpdFo5OXF5N2w5TzZnL3llUWtySGJCK1VSc1lZV0Q5ZDRILytydEVZ?=
 =?utf-8?B?KzJjUjJhcTQ0Zys5UEFTaGxZUHY3bDQwMEtJVDBNdmo2QkQrbjQ1aldiNkVM?=
 =?utf-8?B?cFpmbXJWRkxTVHRHM1R5TmxPd292dnZ2blBEd3dGUk9PckRFckVib3lVVTk5?=
 =?utf-8?B?a0oyUktGY0VBRUFqazl6cHgrQ1A0SjZtTFR4bjAyTHZlWGRYc3VyQVhlQ3Yz?=
 =?utf-8?B?dXdCbzF2MStvY0VkR1lCb3gxK2V6bkRpR3I5aFRqU2UzR2c4NnpldjFhdEhU?=
 =?utf-8?B?bkVzalRYdUw4bGJjeWhPRytVbEZneVdDRXN2THlPL2xTYSszY3JCb1JkVVg5?=
 =?utf-8?B?b3RlWmR6Z2xHaDRQZFBkb04xcEVSS3FIVFRUVjN6d1VZRWZQblJiem81WXF5?=
 =?utf-8?B?REM1ekk5bDU3RUpPVFNxLzVJbDE5OEVhaTFJcWN2QVRraXZmWEthTTY3aDcr?=
 =?utf-8?B?YVhZbHZ5aFN0dU1WSU5pZmdCd3BPWmU0dW8zc0dDZ1ptb1FGdFRkNXZLUWJP?=
 =?utf-8?B?NmM2WWN1TmtRbVdIUkRtMUI3U3B4WlJhbnJtNWxkaU1LQ0lmc0o3NmZPcVdm?=
 =?utf-8?B?Q0J1RXVHbEZsTURqM0kzMmgrdWpBdWVucHFKT082c2NLM0pyK3BZcW1oV2Nr?=
 =?utf-8?B?L1B4REVneS9BRERhYURDQlJENTI0SU4xZWtnRElacmRCaUJ4SGQ3VStTZHBh?=
 =?utf-8?B?SVB5bnI1TWREYm45RWtjVnY0UXR6MTJONHVwdkNnRUppRkg0SUthMVBmS2VN?=
 =?utf-8?B?SDVqMkpVdEJ6OW1VaGprcnZoYmk0K3pQakpHZVErNlYrUlA2Z2Vsd2F5OGNT?=
 =?utf-8?B?eFFsZEpZbTFtZzU1NGxvSU5BS2NPYWlySzN4ZDdZeko0eWdhOHdLdFQyNU1G?=
 =?utf-8?B?OTcwU0cvSmkrMXVZYlFaZkVSSEJtNWFJb1QvZjNscFdWVEF2NWRTTzVVdGpU?=
 =?utf-8?B?T0hBNjVGRkViWVMwN09wNUlkRnhiK1RjcmJaQzc5YmNFVFk1NUFBYlBYLy92?=
 =?utf-8?B?eWo0ZDExZ09UL3k1aDFVR1lpdkQyRDhWTGFCM0NmZ1RqM3BGN003U3RGaTlt?=
 =?utf-8?B?TVFtY1NrcnJFRjAxZ2pXVXBBenJWWnZGV2V0WnJXL1crbDM3TFNBZGxmb3Bi?=
 =?utf-8?B?OHFlalpGOWM5VEVqcFBMZzRSWmphVStoYXoyUk53dEppOWxvcHFyMUtHaS94?=
 =?utf-8?B?S0Q3Y2MyWTc0M3ZSaWQ1WDZFVnFBdFVFQnZsOC9hVDlOK3p1dWFGcEs3L1RU?=
 =?utf-8?B?Tzh2OVpGNjZVcjhGRzVtN1RzVmw3amxzNmtwWCtmZ0xVWDdGSU92eGFyeU0v?=
 =?utf-8?B?T0RROGVVS2cyZVdLZ3ZIY01paVg2dWNXdm5mZkVTS0IwTXNEcGVQNGRoVlRL?=
 =?utf-8?B?M3ROLzFoSUpJd0phTzZuMHpJV2ZsUDdnUWtyQjFLS3VHY3UvNzV0Smw0aHJE?=
 =?utf-8?B?UW5saUlqeGZUTFBXWUw0dVVHenc2WkRIbVQzUGhlb0xtamZ2NUw3ejJTZVBa?=
 =?utf-8?B?SEtjRHYydklRbHhlWTZabWszOWdsVnZyMVdKa2Z0TDc2cVpVczliTlkzbXU4?=
 =?utf-8?B?eUxkaFhtUEZ4TWRvclRaN2MwL0dJMlBnQzhwKy9wbmJMeVdNdUJ3aHZ0ZW1n?=
 =?utf-8?B?VzBMc1Z6VnBJSXhrSk5uZ1VMQ0hoN2lQWmllNGZGK3NCOGhBdmcxTFJRcEJa?=
 =?utf-8?Q?Jlu5g0gzJlkJtpaM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d801d7-8aae-45e1-10dc-08de530927e1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5305.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 01:06:34.3279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THZRg1W9vISu1NLN50CgM+78pv530bpjzbhzhzeJAZbydNnkEYcZQgULuVf642S3SeZ+wI1AMVJHu/gzR5m3cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8116

On 1/13/26 5:09 AM, Junio C Hamano wrote:
> Aaron Plattner <aplattner@nvidia.com> writes:
> 
>> Subject: Re: [PATCH v2] remote-curl: Use auth for probe_rpc() requests too
> 
> Micronit.  "Use" -> "use" (see "git shortlog --no-merges -200
> master" and notice that the usual "the first word of the sentence is
> upcased" rule does not typically apply to the word after "<area>: "
> prefix).

Thanks, sorry for missing that.

>> If a large request requires post_rpc() to call probe_rpc(), the latter
>> does not use the authorization credentials used for other requests. If
>> this fails with an HTTP 401 error and http_auth.multistage isn't set,
>> then the whole request just fails.
> 
>> For example, using git-credential-msal [1], the following attempt to clone a
>> large repository fails partway through because the initial request to download
>> the commit history and promisor packs succeeds, but the
>> subsequent request to download the blobs needed to construct the working
>> tree fails with a 401 error and the checkout fails.
>>
>> (lines removed for brevity)
>>
>>    git clone --filter=blob:none https://secure-server.example/repo
>>    ...
>>    11:07:34.725262 http.c:849              => Send header: POST repo/git-upload-pack HTTP/1.1
>>    11:07:34.725279 http.c:849              => Send header: Content-Type: application/x-git-upload-pack-request
>>    11:07:34.761407 http.c:849              <= Recv header: HTTP/1.1 401 Unauthorized
>>    11:07:34.761443 http.c:890              == Info: Bearer authentication problem, ignoring.
>>    11:07:34.761453 http.c:849              <= Recv header: WWW-Authenticate: Bearer error="invalid_request", error_description="No bearer token found in the request", msal-tenant-id="<tenant>", msal-client-id="<client>"
>>    11:07:34.761509 http.c:890              == Info: The requested URL returned error: 401
>>    11:07:34.761530 http.c:890              == Info: closing connection #0
> 
> Excellent illustration here.
> 
>>    11:07:34.761913 run-command.c:673       trace: run_command: 'git credential-cache erase'
>>    11:07:34.761927 run-command.c:765       trace: start_command: /bin/sh -c 'git credential-cache erase' 'git credential-cache erase'
>>    11:07:34.768069 git.c:502               trace: built-in: git credential-cache erase
>>    11:07:34.768690 run-command.c:673       trace: run_command: 'git credential-msal erase'
>>    11:07:34.768713 run-command.c:765       trace: start_command: /bin/sh -c 'git credential-msal erase' 'git credential-msal erase'
>>    11:07:34.772742 git.c:808               trace: exec: git-credential-msal erase
>>    11:07:34.772783 run-command.c:673       trace: run_command: git-credential-msal erase
>>    11:07:34.772819 run-command.c:765       trace: start_command: /usr/bin/git-credential-msal erase
>>    error: RPC failed; HTTP 401 curl 22 The requested URL returned error: 401
>>    fatal: unable to write request to remote: Broken pipe
>>    fatal: could not fetch c4fff0229c9be06ecf576356a4d39a8a755b8d81 from promisor remote
>>    warning: Clone succeeded, but checkout failed.
>>    You can inspect what was checked out with 'git status'
>>    and retry with 'git restore --source=HEAD :/'
>>
>> In this case, the HTTP_REAUTH retry logic is not used because the
>> credential helper didn't set the 'continue' flag, so
>> http_auth.multistage is false and handle_curl_result() fails with
>> HTTP_NOAUTH instead.
>>
>> Fix the immediate problem by including the authorization headers in the
>> probe_rpc() request as well.
> 
> Great.
> 
>> diff --git a/remote-curl.c b/remote-curl.c
>> index 69f919454a..1d0ae72521 100644
>> --- a/remote-curl.c
>> +++ b/remote-curl.c
>> @@ -877,6 +877,8 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
>>   	headers = curl_slist_append(headers, rpc->hdr_content_type);
>>   	headers = curl_slist_append(headers, rpc->hdr_accept);
>>   
>> +	headers = http_append_auth_header(&http_auth, headers);
>> +
> 
> Is http_auth headers so different from the content-type and accept
> in the larger picture to warrant the blank line before this new
> call?  If not, you probably would want to have these three
> assignments to "headers" that accumulates the header lines together
> in a single block of three lines without any blank line in between.

No, that's fair.

>>   	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0L);
>>   	curl_easy_setopt(slot->curl, CURLOPT_POST, 1L);
>>   	curl_easy_setopt(slot->curl, CURLOPT_URL, rpc->service_url);
>> diff --git a/t/t5563-simple-http-auth.sh b/t/t5563-simple-http-auth.sh
>> index c1febbae9d..adc210cdd3 100755
>> --- a/t/t5563-simple-http-auth.sh
>> +++ b/t/t5563-simple-http-auth.sh
>> @@ -63,6 +63,26 @@ test_expect_success 'setup repository' '
>>   	git push --mirror "$HTTPD_DOCUMENT_ROOT_PATH/repo.git"
>>   '
>>   
>> +test_expect_success 'setup large repository for probe_rpc testing' '
>> +	rm -rf large.git &&
>> +	git init large.git &&
>> +	(
>> +		cd large.git &&
>> +		git config set maintenance.auto false &&
>> +		git commit --allow-empty --message "initial" &&
>> +		# Create many refs to trigger probe_rpc, which is called when
>> +		# the request body is larger than http.postBuffer.
>> +		#
>> +		# In the test later, http.postBuffer is set to 70000. Each
>> +		# "want" line is ~45 bytes, so we need at least 70000/45 = ~1600
>> +		# refs
>> +		printf "create refs/heads/branch-%d @\n" $(test_seq 2000) |
>> +		    git update-ref --stdin
>> +	) &&
> 
> Hopefully, $(test_seq 2000) would not bust $(sysconf ARG_MAX), which
> could be as low as 4KB, on any system we care about.  If not, of
> course we could
> 
> 	test_seq 2000 |
> 	xargs printf "create ...\n" |
> 	git update-ref --stdin
> 
> which probably is not all that more expensive than what you wrote above.

That's a good call. I tried this

	test_seq 2000 |
	xargs printf "create refs/heads/branch-%d @\n" |
	git update-ref --stdin

and verified it produces the same results, as does the same plus passing 
"-n 10" to xargs.

> Other than that, looking great.  Thanks for working on this.

Thanks Junio, I'll send a v4 with these updates.

-- Aaron
