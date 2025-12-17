Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013018.outbound.protection.outlook.com [40.93.196.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF74126C02
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 21:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766005283; cv=fail; b=p9v3HoI7oMbQ1lrDvQz3dJ3c72uXEUUNf3S8f53X7kThM4LmkcxdjZTARPDL3HwUlCTxe6d+8Cb4eh/V7HSOZ+YfsVyydRTcC98WJ4CFZES3r4NaAV20pTHK0NGCMaNbj6BNsfcijH9SFVqJN2tnSs04J8f57k+fqhnl/SXjSzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766005283; c=relaxed/simple;
	bh=ixFC+ybnFpcuG6JVIYApw+3OYwuQI/5A1Nh751HINks=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W4l86HbCPqMnmzKNRs0sVW2RO668KUZnWbEPzbWgMhU6FSn1L2q3G6DypPKfqyO58FNA+mN9zg4Bi0gcvJDPkY6at+ecuxKYaursbTppzDtS004LNth1X21gDKQzMfXkcKr3I/hiR1IbioQHYqzUmRxJ1JPqTiGLFa2OwPFgJk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dvw7XJ1O; arc=fail smtp.client-ip=40.93.196.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dvw7XJ1O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hu0fRt+t96D0P2Uyj1qzrXZAbNiZN5VFMPFRMTWxWgy5N42bE7pMXjl/qc4PIMT48wKIZy+NC+kizB5Z78rye02TOl12GWwwUVohyssWUNNp1Wd8JdbnXMTv9GyvcL9Wcrm/yDWIQMuAqMipSAQBGn0QysmEmKXs/1PaIL5cV8WLmRIhkId2H8dGf67nrKskKWZYCar9LGoKF5izEwKS/ehYjMzpg121ynhWogyRYX79MAmm+NS1OYmAJkrsEL1hsKIOIuo2szY+pJveO/Bm+zCzhNKv3V+ygDDHhkYGZrqjpoB3PYSQrx/JvsH+StoA2LS1OwJ7AexSOUJgE5N0XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iw6fKcNmgNO+Uo2NrzvZxRopxFejoh6xhm9uQke4Ib0=;
 b=uhW5OmRl+XB6eC9XMvvOw5rkbNkDouTPQc71yoVSysykb1wG3rW8uVkQUafgUaunCql2SjKgB6T+9EyAREIst7K6yko6lSaZB1HRgAHeP/Ej27OTjgjF2kqfT4jeVXEUp1K9NKvZ1Jlg1K8NUZfXe8rY/Q1osZ6XlziEn6oAWyPaXC1Mwrm3IZwu3hV3ungKhRziIXYVeRgjmybpw2P7JkFpFTmRPmnmVUdf4Nxnx4SsBi6RtPHtpezs/4gPN9gyu1cDozGGrTk9kJAlcPYD+8qEv6hrumdv9Gi4FtKgvEE3irVKVCFGrYJCYfpCU6R8y4TODaE8h6R9+gkgOth9/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iw6fKcNmgNO+Uo2NrzvZxRopxFejoh6xhm9uQke4Ib0=;
 b=Dvw7XJ1OMsSo3A8YwUsKPeQJSJvj4kOA42G72FdwoSEIcYjIdyhuKIiiDmrvnNmXGRvJB75tnLIR6Tf3otnc1ieS3hKq4UbAeuA81rE6DRePgRKzXNHKs8yVIaOijEFg4e/vwlBALMPfb3r8sxf+9GW2q51RBQgVHBFt+d9ynTc8aCVQzr+EKVOZWN8CqPUEzBOYqm3HZ3qIAUio3IjVqmTO07Og6OcjveLrpqJBqEyTlv9NiFcVWtQnspVKwmSY0OcDRwImYGE7vFqQOS6CgWmLbeuGCbnrJ7Sz8omZ2+tsygE+Bxa+9SCTxR/1gyYDAOCPsD02TGPqAIdZjqZt9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5305.namprd12.prod.outlook.com (2603:10b6:408:102::5)
 by MN2PR12MB4096.namprd12.prod.outlook.com (2603:10b6:208:1dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Wed, 17 Dec
 2025 20:27:20 +0000
Received: from BN9PR12MB5305.namprd12.prod.outlook.com
 ([fe80::e7a3:9531:f0c9:bd7f]) by BN9PR12MB5305.namprd12.prod.outlook.com
 ([fe80::e7a3:9531:f0c9:bd7f%7]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 20:27:20 +0000
Message-ID: <f4ba7e89-4717-4b36-921f-56537131fd69@nvidia.com>
Date: Wed, 17 Dec 2025 12:26:58 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Dec 2025, #03)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>
References: <xmqq4ipwc7y2.fsf@gitster.g>
Content-Language: en-US
From: Aaron Plattner <aplattner@nvidia.com>
In-Reply-To: <xmqq4ipwc7y2.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::47) To BN9PR12MB5305.namprd12.prod.outlook.com
 (2603:10b6:408:102::5)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5305:EE_|MN2PR12MB4096:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a39ea5d-18fd-4c29-d6d4-08de3daaad75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?enBYdTVNMjhHVHdOZlY1eUhvRTFDYk5mM2phbVpCbEFoT1MzT3VVRGJvRnU1?=
 =?utf-8?B?M2ZRUjhCR3ZTY1NLTHBGTCs4Uzhudi9IWFkxd1B4ckZLeGpNMDgxUUgzdFFv?=
 =?utf-8?B?QklvKzRuaXUzc3BGdWVCL25ZdytnQ1J4YlY5akthKzBYeTVseEdhalYwVGJB?=
 =?utf-8?B?MFA3dWVVTmJNU1hRQjlCUEMxVXZTczdicElrQmh0NSsveDhENG9PMVNSb1A4?=
 =?utf-8?B?MkFXVWozelluVXhzUWJYL0dpdEpXaXVCbXhiS3pZWnZ6cHBzN3NLeWd1djds?=
 =?utf-8?B?WmMrRktFNko3NjJ6d1dCNHVNY2liUlpORktHTitCdXJETy95eEZXa2lqOVlG?=
 =?utf-8?B?d1N0akxZWWdaVXIwN1dSUWpMRzlJZzk2WUZ2RGdoRkJ5MHFKamJ0ZzBaOHdB?=
 =?utf-8?B?bzI1djJub2NyUk9zMk8yWE9NRk14UmdvcjB3Si9ua1g5blJQMEJwUWxONUR2?=
 =?utf-8?B?bDlkYXkrNTcvclJMWXpjQTR3Y01SdGsydm5XY3M2eXdXUGg5SDB4YlRQSkRn?=
 =?utf-8?B?TjVjM05iQ0ZXUnJEWmN4YjJ2ZEpuVzBjRjlFUjFUMVFTdTM4S0ZQSWw4Qk5v?=
 =?utf-8?B?WUxPM2pBRys4cmExUTVBMXEvN3BFNjJRZWEwZkNaV2kzbERreTFVd1RHbzFT?=
 =?utf-8?B?bHJYYVhwMDNMKy9meG8xOXFENjhPSlVUd24rN3M0S0w2aGZVTjdoaUpVbG51?=
 =?utf-8?B?TDAzNEN3dFpNOGpZSjdsSzRCbWFlRVVPOXZVK1FncVQ5QzFvZGhSTURERUFi?=
 =?utf-8?B?RG1vN3Zsd2pUNDdKY0V5U2dJeW12SjBzODgyeW5nakJxVkNQYmZzTk5HVlFl?=
 =?utf-8?B?cldCNFJUdTQrSU80M2daeHhQVndoT1IrbXRGUGRjOHlmOUZ4NzV1czZib2xF?=
 =?utf-8?B?TzJFZW5acmxZYUNiQ3JrbG5YTW0yMXk1anNTSmJqYkVHMWEySzZQbFJ1MU5W?=
 =?utf-8?B?K21EU2Y2Smd1RHBDY0NhL01aWFNwV2RXZkpOWXk0aExIbFQyS05GcTduVnl4?=
 =?utf-8?B?ZUJCM2lrVlBtNDhNdGtXZ3RyUlR1OVBEa1hUNDRCYW9CMEIvdHkxMDFhUFJB?=
 =?utf-8?B?SFZmQkxrOGlFbG96dU1qZFBidXF4eVZMaUR2NlBNTDU3VGhLZkVOYS8vMlJW?=
 =?utf-8?B?OGhUbjQzTXdFRWJnc2VuWUpmMy9FNW9Nbm55dkdpRVZ2dXRtWVB1VmdTYVJZ?=
 =?utf-8?B?YytrSHhOYlFreksrVFpYMEZvNnhBa2Z5SStvUlJKRTkzR2w4L2Nyb1RORVl4?=
 =?utf-8?B?NkE5a01RTVVmbExpbzhPWE85U05rMDBESzJyak1uaWM4c0RpZzFXQU5lQ0po?=
 =?utf-8?B?eGlPQjZqL0d6NmRUc2FSUnNaNnR4ek8rY0k4RGVEKzg4RGRtc3VRVHFjNFJE?=
 =?utf-8?B?R3d2UGczd3VXQmFMSCtHcm5SdFhFT2VFazFoazVNS05YYWZ2RU5nUG91ejRz?=
 =?utf-8?B?V2tDWjBScXIxR2p3Kzd3RjRaaHpYRjkzcllKd1BuNU9YelZZRG84bllKaGp2?=
 =?utf-8?B?Mi9TamhndXVaS1FSQ3dSTFIwNGZmbDZHRUMwbmgxRy9KbHNJSXdRcU9IOElN?=
 =?utf-8?B?UU5pVDU3RUV3L1NEb0F2YVE0T3g1UnhTaUdTRXJmM2xyMVFEWFFma1BXTVkr?=
 =?utf-8?B?Q2NycCtPVzdsVDU1ODUwOFZpV281WlZBMUxsblhtUWtXMnBxQ2NEYWQvWkg2?=
 =?utf-8?B?UVFWa3NyOHQ3emZ2UkpmcFdhM3pNOVJwYXpvOElNTUtKeTdDVEhCMkcyanZn?=
 =?utf-8?B?S05YWmhIQ3RYR2VpT2h2QXQ0RzBsRzJSRWZmbk5aajlJbVlWUnYrZHZVQkJw?=
 =?utf-8?B?VDJybDF0eDNENzZldHdDdnQrSVJlRHlmMnIzdllOakR6QWk4Zm1XVEVlQ2tR?=
 =?utf-8?B?ZElPbWVvaHZ6TXJQZ3ZUWTk0dk1zVkVPV3FTTStIUi9mdFRyUXRXN09KTWNw?=
 =?utf-8?B?cTcrRytzNlF3RGZJY0JxNXYrVEtjdW96eTFlY2JNd1FKdWI1Z2I0SERtWHpU?=
 =?utf-8?B?TnhBWDI0SUF3PT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5305.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?c1JsNGh0WUduaFFRbnVQUGYrSTVKZFpHVlZpYUNkVXBmQXROd2ErK201QUxh?=
 =?utf-8?B?ZGRBWEVUZEF1NlY4d01ZMzhiR3RkU2p4V2ovaGRDSUcvZ29oTkxOS1NvZ1JP?=
 =?utf-8?B?a0JZdzYyamZiTjlwbFc0L1pNZWlaeXFyY3hzQzJwcmkxWTdabkpiZEhmaDQ0?=
 =?utf-8?B?aDV5RWgxU2lSK3JqOWNqMlM4QTZGUkdnTWFXMFlJNktuTEVMY3B3a2pqOG9s?=
 =?utf-8?B?Qi9KN0h4MmhUcWhxNGtvUHBpK3ZLR1hsMFhHSVh0VG9xYzU2eHV3RlRhVTEx?=
 =?utf-8?B?Qjlwc053QTg2Zm5lS0l2WnZVSFpCbEtZdUxHNGtQMEIvTFFFcU45Wm9tQ2I0?=
 =?utf-8?B?T0RUSU1pVjMzUXRFNUFoT2daU0g3YlEyMTFzYjEwVDVHdlYwUk1Uc3pPZFhK?=
 =?utf-8?B?QkMxMHhQZWZWQlpKUWErV242K21KTkw5NC8vSlZTNlZSMDV1aVBBdkU2Q0l5?=
 =?utf-8?B?VDNBSlJUL0RzWXdpYzNZay84cHdoQjgxSlhTek83TXJjTlJtVDlWdmUxY08z?=
 =?utf-8?B?OStmK2U0bytpaE9UaERiVXBIemRXbndLUW85NCtoeEYrQkFYYk9sYmx1QUxa?=
 =?utf-8?B?QnRMelM3NTh1SVBiMk9KQy9WRm00SE9JUGxzdURXVzFnZ0JyUnNWRlJFQ2JK?=
 =?utf-8?B?Z1NadUp1dXhRNkNrTE1Gem1VY2M4VjJLOUtPRnNzdllldHRNYTdnVWpQelZX?=
 =?utf-8?B?aWJOTHpFdmpTaXNtVFB5K3VvQ2p3ckJIMWlsbThrTjl1SUFWdG5ablBRdlV2?=
 =?utf-8?B?c1RqT2pBaE9HZG15SUxQc2dTUStRMkhMWmo2eTJveTZ6SytSdXJnaG9uVUFB?=
 =?utf-8?B?amlRNmFiNzdBR0hFMDlmczZVSGtxOTRSRENJWmE2Z3NDcnBMUGtaU2VRSlg1?=
 =?utf-8?B?SnE5dWdObklaSUtIL1orRTBtenBLUklScXQzS0FTekFaQVdqV0tIMTlYTWlF?=
 =?utf-8?B?NndsVjd5NVBqaFI0RU1jUVVDYWdBWXc4cUU3R1lmY3RCTkgxT09LeXhOUE5D?=
 =?utf-8?B?VXQ5Y3JhRzNLeTVHV2VoZFk5RnpUdFB0c0QxcXl0WkJjMjRPcXV4TUEvLzkz?=
 =?utf-8?B?RHRlYWNtNnRsZWhVTnZkR2JsSjY1SXRyc0tacjNyRm54V01pQjBSdUNoVWsw?=
 =?utf-8?B?TTZubGhaNDlQZElHcHZGcGYraVhqSXNMbU5iNmNXaGxFMVozWkVaanJ5bVBM?=
 =?utf-8?B?TzB4RHFibStrZjVuVGQ3MHJaUVMzSlVOVnJTSmtOK1NKbEFITDk2dUx3cEJB?=
 =?utf-8?B?aDltOXpGR0x3SXJuL3FDWXZWTXowSko2S1F2MHQ2bk5HVEZjVlExZi8rcllJ?=
 =?utf-8?B?K0QzYjF6ZEYxNUwwYzJQTWphUFdJL0g3dlRkSDVNdEFabEJvMlVaakYzNHNC?=
 =?utf-8?B?WjBEbnRCUEtzZHpxWldFRFV3VmFJQlBLSGlETWcyS25CZGpsUmtaSFFXYkRp?=
 =?utf-8?B?YmgrdmhPdDdjdVhYTmxacUE0M0VneEpLcVU0cWszNVJjM0pFaGFwRFUwRTJC?=
 =?utf-8?B?cmpFN21wQmdUcGhBMnl1a2s5Z1ltdDEzdTRXUXFncllFcXgyNHY2VnRxTTZC?=
 =?utf-8?B?RFpFVHdZM3dZUTVtQStVTzVod0pjbnY2V3ZWdlZTRW9LaCsrVWw4THcxSmNF?=
 =?utf-8?B?TTk1L3Y2cERoallyR0pOWmc5cHY2cDZyVW4vVERKT0RJN1lYcUxRT3g1T204?=
 =?utf-8?B?MDVoczQ2b2tnSTVjaTlzd0R1cXpENTZZZEg0dzlnSUVVT0tMMldKY1NqR1Nt?=
 =?utf-8?B?OWNXM2R1QUE1K1Y5QjFDcnN5S3ZaRlAyelB3M012ZHl3RWl0R3FYTWxHVHJs?=
 =?utf-8?B?UnpKZ3JtTEVxZjJ3VFVjZEoyMU90U0VrcFpaWXNMRGZlNXRCSzQ4Vyt1UlZa?=
 =?utf-8?B?YU1XWHZPSlBDaWxXa1NBZ1pFdE9qUVBnOFRDWDF4M05peENHZU9uM3hZUVBw?=
 =?utf-8?B?dzFwZzNPZGZLanFscTBxK0l2Qm83TDNWVTk3MUVqR0UzVjEzNXUxcDJBUDlt?=
 =?utf-8?B?ZlpGNHphTWppT2RoaVM5dEV4MjlsdVYyc1paVVBJc1FTaVEvOFVZcjI0SUFa?=
 =?utf-8?B?NlNXOHRTOEdFQS9Cc1JUV0h3VFpZSkJwLzVwM000eW11SU5GU3NVMzM2R2pl?=
 =?utf-8?B?SkovS1lPSXpCRjZQU1ZBVHJVRGFkWjZCWnUrVGFzK2RKbFp3ZEl3YkJyNHNO?=
 =?utf-8?Q?Qvpkx42Xae451R2fI2eeTF/jYD7u7IFEdNUOk5ZN0Dmp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a39ea5d-18fd-4c29-d6d4-08de3daaad75
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5305.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 20:27:19.9702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lv3cSn2UCEe7ms7uB7u5Z/aUZqA/OsfNXB9QvtimoryyCwoJJfRYIaMJ8OeHjsJ3Z86n+NIsghde9QgcuN+/Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4096

On 12/12/25 2:26 AM, Junio C Hamano wrote:
> * ps/object-read-stream (2025-11-23) 20 commits
>    (merged to 'next' on 2025-12-09 at c8d645f8ea)
>   + streaming: drop redundant type and size pointers
>   + streaming: move into object database subsystem
>   + streaming: refactor interface to be object-database-centric
>   + streaming: move logic to read packed objects streams into backend
>   + streaming: move logic to read loose objects streams into backend
>   + streaming: make the `odb_read_stream` definition public
>   + streaming: get rid of `the_repository`
>   + streaming: rely on object sources to create object stream
>   + packfile: introduce function to read object info from a store

This commit seems to have caused a slowdown in commit performance. On my 
production codebase (the one from [1] with the ridiculously enormous 
promisor pack), a simple commit that touches 9 files (out of 232,259 
total in the tree) goes from 0.38 seconds to 1508 seconds.

I'm pretty sure the problem is when do_oid_object_info_extended() 
substitutes the blank oi here:

	if (!oi)
		oi = &blank_oi;

and then packfile_store_read_object_info() compares it to its own local 
blank oi:

	static struct object_info blank_oi = OBJECT_INFO_INIT;

         [...]

	/*
	 * We know that the caller doesn't actually need the
	 * information below, so return early.
	 */
	if (oi == &blank_oi)
		return 0;

Here it's comparing the oi parameter to the address of a local static 
variable instead of the one from the caller, and the condition is always 
false.

-- Aaron

>   + streaming: move zlib stream into backends
>   + streaming: create structure for filtered object streams
>   + streaming: create structure for packed object streams
>   + streaming: create structure for loose object streams
>   + streaming: create structure for in-core object streams
>   + streaming: allocate stream inside the backend-specific logic
>   + streaming: explicitly pass packfile info when streaming a packed object
>   + streaming: propagate final object type via the stream
>   + streaming: drop the `open()` callback function
>   + streaming: rename `git_istream` into `odb_read_stream`
>   + Merge branch 'ps/object-source-loose' into ps/object-read-stream
> 
>   The "git_istream" abstraction has been revamped to make it easier
>   to interface with pluggable object database design.
> 
>   Will merge to 'master'.
>   source: <20251123-b4-pks-odb-read-stream-v3-0-1a129182822b@pks.im>
[1] 
https://lore.kernel.org/git/20251209014900.402637-1-aplattner@nvidia.com/T/
