Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010067.outbound.protection.outlook.com [52.101.85.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EA427B32B
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 18:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767984004; cv=fail; b=mtwPe4fACedljXvNm2hsSoSduQqCq3gu9JKV0vkeN+XhX4p4iufSFZhC0gJZCDINxV57rv+DPTntmcWl83EX9Vsn8BkAf6y4eDLb7aEGz5ZfaAr6AJjbyAmFhCwkENFxdhBaEAOZ2SXn2OPpDmSbVu2QeDzDrwD6KSWcEJk3xgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767984004; c=relaxed/simple;
	bh=pquiiB3UvPl8lOVzA8Io2BpnOr3/JiKDT8vqo2V4pf0=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cwRxJMUkRZM3PIeykmXQuQg3el58T3dK9gJZN5ArQn4jzTsfjTEfpNX0grKCrtAtGreeBZ6SMOGAXZQ0ZLMnDxeyRp968Mg3E1LxBYbdrJ0eHkybX+Ty3YQRYmSQ2d+mWcjPNPjxe5HMTGCRuDkSxHj5SO88V5buCxbQbT02+Lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZKhApzlI; arc=fail smtp.client-ip=52.101.85.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZKhApzlI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBzMg2ZwCOKhnZZSk+lpVGFcClUtEJf3vG0SNPwpjScq7O424kFp5iHuS3ST7Q0HQNVWBAsapn/c0KwMBmCi+M0TsI24lg2q99vFM4wru+Jy6YEeEVH7wi+2wd9ZId6SmhIrlC7HB9oexlbr1pkklA7VqJ+5ivk06Cr1xrfM/mZmQPJWjsSk2inx6NAS4MadGkF/uLlONvLFbamc/ClNq76gQVWUB7s2pbMLnZL80/zQY17suL07jBU3hk0haLgx4qwQN5JVK+7d5CRJQpt8pAEHGFnxrWWID/EBjC3ELPNDOMoIGmAn9IF0Gnh29T+pDmavvX+qAVrWSeQ/Be8qZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2iUnzLwYznbCyN3zqpfJfyx7hF/8fATobrAQ1vhh8c=;
 b=ujTSEErn2R8NcQgH8gasLhLqeh7cpogAOy2ui5HYy66JlSK9STRxTD0ythCy/HbMPR1QyoFVEYDa+kCHqQQCgTJ1YCsbD6mEQJd6HNYb8etxV4UIjNjgm/DIANWxIYkJGUB4npJ/6sfdDIPAB76TD30+1P8DCiBIlqmYiGl6/tOGnU9BJBl1cQ+A/jWkQlmvzTKPG+kR4UsnC5zf6i4uzP+EFQbOAf5qvk6qv+EJt8q4p70EDEB2/RgGCDXgU/opy1GwZm9yNyEiY+kUqh1Efqkgxut+YmndNOb7SYuOGx9oWvkT++miUINZxryPdsiZWJVylwcbR4cCsGeieCk6rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2iUnzLwYznbCyN3zqpfJfyx7hF/8fATobrAQ1vhh8c=;
 b=ZKhApzlIiR93U71uCY8vurxL12z7IqxsJpPKtC9UEI+LO16v+v1PuDVw7xs2AA5B5QYYVcL/NPLydyjli57uO7R8YwcV8oJ/q0xmvkP92DjwsPVQP5AWH+QIh9K44V+YIHLV1opJa8GzBD8I5Xjp8SbxJUJvwvxOZ6aL22yRjEfROm81+sghzcNEvlxH+qrfw7SEMr/1PylTHIL8zZUNgLhVvJLTuDU9FNnj+kiPnaKKuMsUZm5sSVLAma/LGiWpehx/vBh8Zu3FABFJYq19H4eWbDEhnqUh0n2eqG27w0wrsYfPZ4TXq2G8dSfCztf6NiV7VU9yvrGaooGDdzM2eQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5305.namprd12.prod.outlook.com (2603:10b6:408:102::5)
 by MN0PR12MB6295.namprd12.prod.outlook.com (2603:10b6:208:3c0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Fri, 9 Jan
 2026 18:39:59 +0000
Received: from BN9PR12MB5305.namprd12.prod.outlook.com
 ([fe80::83f5:1b0e:a61d:6707]) by BN9PR12MB5305.namprd12.prod.outlook.com
 ([fe80::83f5:1b0e:a61d:6707%6]) with mapi id 15.20.9499.004; Fri, 9 Jan 2026
 18:39:59 +0000
Message-ID: <c09387eb-0847-4130-85d1-9da8a3f64164@nvidia.com>
Date: Fri, 9 Jan 2026 10:39:10 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remote-curl: Use auth for probe_rpc() requests too
From: Aaron Plattner <aplattner@nvidia.com>
To: Patrick Steinhardt <ps@pks.im>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: git@vger.kernel.org
References: <20251112223722.376330-1-aplattner@nvidia.com>
 <aWEV2qs8MHqt_JXC@pks.im> <2e103c5b-8cb3-40ec-aa0e-793f85a1f80d@nvidia.com>
Content-Language: en-US
In-Reply-To: <2e103c5b-8cb3-40ec-aa0e-793f85a1f80d@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0175.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::30) To BN9PR12MB5305.namprd12.prod.outlook.com
 (2603:10b6:408:102::5)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5305:EE_|MN0PR12MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: c88ee6c8-0f80-482d-0da8-08de4fae7e45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHlGMWgzU2FnWnVyTFJjZndsS0RUTlRjV01kYkdPYTJoODd0b2hjdXp3M2tj?=
 =?utf-8?B?WFJCNVl6SjJmUXlGakFEWktENnN5WDVGN083VG51WXhMWmpPY2ZwejRSWGRi?=
 =?utf-8?B?YzJ0SmVJRHBzZ3J0YVRoL2Y4anoweks4eURLcXB0K01JNmdjK2RmZ2N2VlYy?=
 =?utf-8?B?REFEelA3eUg4MXViMW0rTjBjMllHY24yVUxKb1d1c0N5TlNwekhaOGdrTkVD?=
 =?utf-8?B?a0tkVVA0VUlZbG4rdjZVamNVWEJxeWV6NFVNQVNXM1V2Y0VwNHQ3M2oweDZk?=
 =?utf-8?B?d0s5d29zUHpsYTFKeGErd2JRSWthS0NVWlpXNVRJRks5S3BGR0RBY3RGUlB2?=
 =?utf-8?B?bE1jazhkU2xKN3lZQ1lRUDc5REJ4cTUzeFBPcFdsQXZjb0hCOWkram9Ncno3?=
 =?utf-8?B?cEE3ZzhOUlVtaGlOSWtVWS9DV01NNjhZUm93MUpmL3lnNmRCNG5SVG9UR2Zp?=
 =?utf-8?B?ZzJhQkoxNnRSZHludU5EQ1p3KzFxOFJrbUlRQ2xzd1kwUjdkVElscXl2aGRQ?=
 =?utf-8?B?MG5WckpXd09CbHVvc3MxZDdsNFVpVEpYUzcvbFk0UjZWMzJlMDc1Z25iNXNQ?=
 =?utf-8?B?VTlNUW40V3F5MWVRcStHMWxab1BTa0NSY1A2UVRqcHJMZFZjNEc2bTQ3M2xn?=
 =?utf-8?B?UFhzL2sxL0NsRGRjbm5BMzZZeFRUaW5lNUM2amVJTjZOaVkwQ2JzdDJWa3JQ?=
 =?utf-8?B?NkhYMWlrejdvRjNJblB0K0lJQTdPZVlwaUlpUkhWaXl5Tk9Lc3lkRG95dzFS?=
 =?utf-8?B?V2w5Z1BJcHRzaDQxZFlObFBUK3pHQkJtMUdVRG9PTmlpZlJmVXVZQVVQclcy?=
 =?utf-8?B?anlOUnhaejM5TUkrWHRwcVVRelRISGovN1hXU29icjRaOHFqL09BQmttUzNU?=
 =?utf-8?B?dm9keXBHSmNsRjlqVVZNUU14SDM2NHYrQk95ZmhKSkQzZHErTnNwLys0NUMv?=
 =?utf-8?B?c0NUQmhzN2NjM2dlMGF4ZExWTGNzY3RHUFBXblpQOExjTUNZbms0aWF2c08v?=
 =?utf-8?B?N2pwOTlWc28yNXloRjRXbmd6NytJYlFVSFRUVHczM1RFNXpqTG1RcjBNMFpl?=
 =?utf-8?B?aUsya2tJbzBNUk03TnAyM1VtbXhNRERrTDBrbUJabE1ZaEF1MHZ0dXdmaGE0?=
 =?utf-8?B?dDhuVG4yQnpyNm9CY3RoZm1NSUFzdzRGUUNtb0Ewb2xMUUQ2cUdsbXd1c2p0?=
 =?utf-8?B?NWtXdFRYdU5NeGs2WGpPQWlOR0M3QUZJTnJqb0RVK2wrZi9YWkVkUE50cmFM?=
 =?utf-8?B?d1hRRXhadmRJSXk1RmljZWNnc3J5WjVDRHZWM3hweXNQZmhRTE5BSnp1WVBV?=
 =?utf-8?B?L2ZoanQwd0ZOdXBGMFRDMUxvNU9uQ0FZeXE3ZGliQ0QrTXZPR0dyK0FKdHZS?=
 =?utf-8?B?TXE4VXlKM0xxY3ZHUStOT25Ec2hxcUhNdUpDT2xkcWh6K2tSRXVDeEthNzhy?=
 =?utf-8?B?OUc5UitreDFkVm9SaUsveEJhanBJMStQYnhQbnl4NUZLL3I3M0dyUlIwWVNm?=
 =?utf-8?B?UTN0NXk5anQ0N2pLKzdVazY1QStoKzhSaG1uODNMRnNtZTVUdnJIVVpibkx2?=
 =?utf-8?B?aVVCZTllYnM4bENETWZZd3Jxbnp0aG9TWHA2QWU5anNxb1pONHVoOHJQMlBU?=
 =?utf-8?B?OVEyOXRPYjFnUWFpWmd3M1U3VE5YNnBLcmxIcjFJR01uOGlRYXg5SUMrQlJX?=
 =?utf-8?B?NXJiWTgvVG8xcUVxQ3dqSEo0QXIyR0lnZWE2aU9DcG51VCt5ZWJyeXVkTWtq?=
 =?utf-8?B?eFZpcld0V2lFTWZUeWQrMEdLNnBFa0s4TjZqZkRnN3kwR1Jlc2lwenRyUFN3?=
 =?utf-8?B?UUZDRGZGUWpiVEZXOGtycHRBQUJmSEJsNFU2SlBUNjczaDAzQkMzUzJzN2NC?=
 =?utf-8?B?SHVINy9ieTJkKzViK0RiWUh5NExiSTJyTE9YbkdBN3B5U1VxOWJXalpUR1o4?=
 =?utf-8?Q?F5sZzj1D/LTqfbdlZyoKCrcRY7m/D/qK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5305.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2NlQS9haTB5QkFBc2xIZXJJcFRqYm5KbGI5UXBPYWRvdU0xR25yeTdGZGwy?=
 =?utf-8?B?T3ZDQ0Q0cUtOYjh6dFJmcXZYeWlwdEpETkx5TzFDbHJnN0dqaldSUmJrc2c2?=
 =?utf-8?B?NEdJeHlRdEZoZE1jclRFeEI4Smx0ZGs5ejFnNXVjalVxMlAwb3h5c2xHaEtv?=
 =?utf-8?B?UHlDQmc2TVUxSkovL3BjNFdQZU9hQzhCTHR3dTlGTklHQnJ2R2hUdk9OL1dM?=
 =?utf-8?B?L1RUdGNuS2hPei9nNGtGalY2NmJxNW9BNHg0UkxvL2hIdWVhdWdsUGFLb3dM?=
 =?utf-8?B?SEdSZUFyV0h4ZE01bEpWUEN2M0w1Z2RKdXloSjdFcmRZQ2VLRWdhc293dnU0?=
 =?utf-8?B?L0lYWFpIc0tWSURwekpwT05iU1BGbjZYRTVsUXlJSDNtZTE4aWlRT1NlZVQy?=
 =?utf-8?B?ekFNVFM3ZGhQOXFRdHJRSHloeEx4Mi9JbTJqRmRBVUJtazRIQkVUWU1aYmVZ?=
 =?utf-8?B?ZEgyTlhTRThVK1pJYjlMRnJnTjZoeFBEbGJ1WHJtWnhYdG9tbzZXRGhaOG1h?=
 =?utf-8?B?U2RUNHF6NUhzaEllNFF0R1FQMG5WZGJhZEV6ckJZVDhLS3ZCeitBamVBOXp5?=
 =?utf-8?B?ZmI2SFVCSk5aYkh0SGR5N05Pdld3K2Rob1BKd3ZvT25vT0tocUsxcWpSS3hk?=
 =?utf-8?B?azlsUXI2SUpCZTVGcC9iM1Zwa1RJU28rYXVKRUN3ZVlhQzRGekc2b0JXZFFy?=
 =?utf-8?B?SGVSbUZTZ3NHNk5ZTzJzZStHRDBUaEZLWE9FdzN3U0pHcHVuVUdGU0MwZlE0?=
 =?utf-8?B?N1QrRTh1OWs5RHA0SlhiMGVOK3k3SEJQQTVyeitEL3p6bjBZcldhWU9NaTZj?=
 =?utf-8?B?M010UmJ1VXdKMHNLbm53ckhiWGpmMU41cFM2ekNvcUhkUG9PZGFsVCtIK3dF?=
 =?utf-8?B?c01MQmlyWFpJYy8wdmY4N1JUTjVGV3AwUGxaSmc3UkVBUFc5d2krdS9BRmgr?=
 =?utf-8?B?OU5kSXB4aW9ZSjZSNENGM0VLZnNDdjhyeXgvSHliWlBuNHRtVitYOXNtL00z?=
 =?utf-8?B?bFIwNU8yUmJSc05maDVOSnRXV3RseWVJUXJpYlFQVHdYVTl4VHgzdFNvSFhk?=
 =?utf-8?B?WGc3RzZnRGVLaUhLcGJjN3hRY0dWYnl4WHI5UURTTkxhT01IWFlVRDN0Y3lE?=
 =?utf-8?B?cTNJZDJ3RWNWWHJ6aVR5VmszcFJHY0FxTDVYYUU5a1NvYlFWNkNndkUrcmd4?=
 =?utf-8?B?cm5ybmNJREpYeGEzdG1hOVFQRjl5b1ExMVdqWVVLYUwyTTNTU2c2dU5sdldl?=
 =?utf-8?B?RS9SMEg1ZWx6Ym10ZHVVZlFQMnU3MXhIZHhWNHFDV0o0UVJxOThBeC93VEt0?=
 =?utf-8?B?SldsU3NlVGEwTzZCNTh6QndJc0lpS1lKMFlId0VOV2J0WUMvVEFhVUgzaVEx?=
 =?utf-8?B?Ry94TENudmFvRjJKQlFjMzVCNkQzM2pyRU50Vk5qWlFxN0tLaGMrczBtQzJY?=
 =?utf-8?B?N1d0YU83c3lYVzNuM3dZUjZUeWlmbDZGVHROVGNOLzJORnduRVRhbTZxZWlt?=
 =?utf-8?B?cU5TL014WDFJbXlNWkxXVmlva3pxb2pDcWRxeWl6TFBtdklKVnBnT0JEakFz?=
 =?utf-8?B?N0tmTUJmUG5oRjE4cUFmQklMZXN5eU45WUpnSWpENVUxekxtTE0yaUZoSldo?=
 =?utf-8?B?MHRFZllXd2xPMlVzMmEyNm4xT3haL2F2eC9TS3Z2VUxUcDFOdEliTzZaS0lj?=
 =?utf-8?B?K25WUkdKWGRiUnZMcnF4dXQ1djBqd2hEZ2ZzcVBxaFdwYjBueVlkNFNPTVI4?=
 =?utf-8?B?bnZxWDZxclF0ZVR1MXdMNzl2VVdlN3NhN2lNb3JvNkdHVHMxRXVmb1RLN0Nt?=
 =?utf-8?B?Mm1rKzFnUUovdjZxWkhRdjdCNlRxeklxVUlhdTI1VDJiOWp6ZHBuUmd4QTlO?=
 =?utf-8?B?VXpBRU1RUEY2SnlwajhlMmJEemhKbDNXbzNiY1JQM3d2dVIrMHNmbHhtWldj?=
 =?utf-8?B?YmY0M1BMU25HN3djVEhvRVI2T1NpVGE1VjM3QXA1UHBhamxyOW1vMkpSQnlh?=
 =?utf-8?B?YlhmRlA5N3hyTFZGaW9PbExJOGYzYWgzQ0RDeVA3SVBhNTd0OGZTRFdyeFI5?=
 =?utf-8?B?WnBadVFhSnBxamVaaEF2ZDN2VURFQ2JVeVBqQ3FTRmNzTENLZWJ6SnpLNzFX?=
 =?utf-8?B?T1k3Mm5QQnNYUzVFdUx1R21zREQrMlU2aWtiZ1c0RTZxMktHMFllam90UlFn?=
 =?utf-8?B?VllDUmhTTkxrajE2K3puaVZSZ1VRNnV3OEF2K25IMkZKM0JyZG9pdE5wMTRF?=
 =?utf-8?B?ZmxrRG0zK2toNWdEUTFwajFTeE9kcHUwYzFZRm5CQStrVzUveG8wemptUDFJ?=
 =?utf-8?B?L0VXcWhIUGpXQmc2TStpSUdMNUJFQjM0T05rdVM3MHp3UXdhd3NTYmM1bFRF?=
 =?utf-8?Q?fbhf338g8Hsc0bkU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c88ee6c8-0f80-482d-0da8-08de4fae7e45
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5305.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 18:39:59.6008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GG4jzHi2uUsX6N2SFOhvZ3fgqAKmUTnF3tXHGKqlpy1zy6Tyf4fa3AxcowY71/CZH+tAAqGZG3NZrwCUfz7og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6295

On 1/9/26 9:57 AM, Aaron Plattner wrote:
> On 1/9/26 6:51 AM, Patrick Steinhardt wrote:
[...]
>>> diff --git a/remote-curl.c b/remote-curl.c
>>> index 69f919454a..1d0ae72521 100644
>>> --- a/remote-curl.c
>>> +++ b/remote-curl.c
>>> @@ -877,6 +877,8 @@ static int probe_rpc(struct rpc_state *rpc, 
>>> struct slot_results *results)
>>>       headers = curl_slist_append(headers, rpc->hdr_content_type);
>>>       headers = curl_slist_append(headers, rpc->hdr_accept);
>>> +    headers = http_append_auth_header(&http_auth, headers);
>>> +
>>>       curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0L);
>>>       curl_easy_setopt(slot->curl, CURLOPT_POST, 1L);
>>>       curl_easy_setopt(slot->curl, CURLOPT_URL, rpc->service_url);
>>
>> The change looks simple enough, and matches what we do in `post_rpc()`
>> itself.
>>
>> It would be great to have a test case for this. It might be possible to
>> use t5563-simple-http-auth as an example, where we already know to set
>> up an HTTP server with authentication.
> 
> I'll look into that. It wasn't obvious to me how to make it hit this RPC 
> case specifically but I'll see if I can figure out a way.

I asked AI to try generating a test case for me and it discovered that 
the problem doesn't reproduce with Basic auth because git sets 
CURLOPT_USERNAME and CURLOPT_PASSWORD and curl implicitly includes those 
in subsequent requests without git having to add them explicitly. If we 
used CURLOPT_XOAUTH2_BEARER like imap-send.c does, then curl would 
presumably do the same thing behind the scenes.

That said, I'm not sure using that makes sense since the credential 
helper just tells git to use Bearer auth and what the token is, but not 
whether it's OAuth2 or some other kind of token. I don't know if that 
matters. Rahul, do you have any opinions there since you're familiar 
with this stuff than I am?

Anyway, the test it came up with creates a repository with 2000 branches 
to get the reply to hit the large_request=1 case and then uses a simple 
credential helper with a dummy Bearer token to trigger the problem. If 
you think the current fix and that test scenario sound reasonable, I'll 
clean it up and send out a v2.

-- Aaron
