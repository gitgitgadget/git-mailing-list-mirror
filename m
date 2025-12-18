Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A82F72634
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 07:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766042724; cv=fail; b=Zk9Bhis5txaWlEBw0akzpyC46CQgRgA4ZK5Vr1T7re37Po+u7lmT32k1DJrrYAMR9/cFVIzE/V0c0e+PvtOuRkTXxbPxm+/art2OZf8PI+oBSeCMOLdMg4x7M8NVtuUfnq77xlgESq1CIal0yo1zy4piZ6rZzElPAgNNFQR5hz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766042724; c=relaxed/simple;
	bh=m8xKRdZHSIeVpn0W5zxdnrHIYweZlPsLLk9JLIg6a9o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q1k3OlxxDXnbZcv5lwT3pPMCa6X7xJuuDqhqsEO8aB7JtmQl+ia/h0Dk9jymemdXngxgZ218+SO5K4uDXbwO9hnWxhuot516TRVDMttvNDRNG/2pLZTCeNB2G0gnOO4lvm117l8dbdDt8lCXWmNsQosFkxE2yfiL0PAJI3/zHXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cvRwwZlB; arc=fail smtp.client-ip=52.101.56.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cvRwwZlB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vopHQ1fh0YL1XMCJj6Qubli+OEOb3egTPg++asU1BO54kni1g4p+Sqw8AlVPGlwKHTq23IoIYA2IE3pRD/c5KHJyYdpz34x9QozrmjDm0RSPDk8NXf5E7p5BKNQvOh1jxxSxZUfyDDbIyjnpJxgeliwmgYiPxq/YQbhLRm2U5/IFKAGimdPvQLaJKXrU3bE3WH5U05abDeUNvrdAUJlPYc/oFKOls+FZh/ZwyOgNvP0MhcjtvVb5I/UlGt7AMdADZtkUO0zaJGBIm58gbYooOzxPefSL7GspHD4TDiule0nvPKfxjtqD9NeLmY42NWN9dbFaAi0mgJ7LuBmUt4C2EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K175M74fvyf+ew4g3U7ANKG1MceKWQ0IrxxT/AbBLM0=;
 b=LmEOxH+acbnNHl9JKxCZNBPGr8ioT/slGPEPjj/hVdeAOqn7gs7XbelT1GwcdcksMBYUhQ4S2iWnSDDHDU1mIpog4caYqSGan/pc7l47fxNVmF3RjGi8un6LUG/Envkn1LU0xG6I3LX51YIJhEKjCxWJxkrpNRVKte0dPqnjaRCLySJB+KUA3lswzzaKBUG7hBvt39gNCu9MMmUTgVZchP/gQKGWxMmoC8IvFdYwWKc3PLvy5T4sZvcLuM7Pe+6TLtCrQKOrkAul7bNLMmyMxJosnk7FrYfrVKMfYbGegtnmXcbFDfolTZcHeOBGLXx6ATLfwVfEHGzPF8hS5y23rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K175M74fvyf+ew4g3U7ANKG1MceKWQ0IrxxT/AbBLM0=;
 b=cvRwwZlBHiOUux9fK5HkhBWFyOxygYU/TLOJz2b9zS9tCUtEvj8yZiFW4zV+oILaWlSRvnQ6F0JwSuQ0TgVrHtmjBPjsPppCq5fF+wR5coT4J7OFILUJ7QcnFz5DNEbxyLoLxOZcYGFQb8lKgbjYKOVVpOFS/oZYpYPJ2rqsjccA5nzv4wDqTOJK0c8ptE8jpZvvgVAHesuR18jDKrcqrFDbAcjJl5o6hLQxJqP9vvMNhYOAPBqQ8tdnE8skd1xMxFp6ucBkOd9V9zSLCFAP+4TwUMBHiVCb6spPKZMu40eld1DeBk3+R5kavKxRvnWcOCEZZX/gQfqrF85SOqgR2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5305.namprd12.prod.outlook.com (2603:10b6:408:102::5)
 by SA1PR12MB8744.namprd12.prod.outlook.com (2603:10b6:806:38c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 04:51:50 +0000
Received: from BN9PR12MB5305.namprd12.prod.outlook.com
 ([fe80::e7a3:9531:f0c9:bd7f]) by BN9PR12MB5305.namprd12.prod.outlook.com
 ([fe80::e7a3:9531:f0c9:bd7f%7]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 04:51:50 +0000
Message-ID: <a31e054e-0eb2-48b9-a802-3592a737d1e3@nvidia.com>
Date: Wed, 17 Dec 2025 20:51:43 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] odb: do not use "blank" substitute for NULL
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
References: <xmqqpl8cxy0j.fsf@gitster.g>
Content-Language: en-US
From: Aaron Plattner <aplattner@nvidia.com>
In-Reply-To: <xmqqpl8cxy0j.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0155.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::10) To BN9PR12MB5305.namprd12.prod.outlook.com
 (2603:10b6:408:102::5)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5305:EE_|SA1PR12MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: 42f2b444-d09e-4637-086c-08de3df12828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?dDV4Q0hYd1gyNSt5WjBDcEJ4L0FKSi84cXVMRkJhK0txVTJOVE9uZVI3R2N5?=
 =?utf-8?B?V2g4TG1iOWRHeFVhbVNYNzc1WGNxUEZXbDhLWDN5ZmNnRWR6T0M3dldNZ1Y1?=
 =?utf-8?B?Vm9zWnV1YThJOFZmT3lwYVlUY3luamJoRFdQcDdLZU82MERFMlE5QzZBbVdR?=
 =?utf-8?B?TVZSZzNzTTdjNVVTSWtIcUVaVDVBaTVrZThPUm5DUVBhWkdBc3o3VVU0U2JD?=
 =?utf-8?B?ZzZPZkswWkFFYS9LOElBTG1IYzNaRldFeVJ3YTNlNXdqSXlLRmt0VjdHOXdy?=
 =?utf-8?B?ZDh2eVY5U1ZqS3FFKzlDV2wyeFJ0K0pqd0JJb3NFOWFRa2NkZzFBVWdRTytH?=
 =?utf-8?B?elVkc2tlNUdkeThiUkQvZjFGcmo4TmEzK2ZrdTdHbFR0akhYaEFXNkZCd0tV?=
 =?utf-8?B?QzhFd2s4SWlqUVdHQkFyUzVqMzNJY0IxQzB5WE56Y3FtSWg5M0NTWHRaaHJS?=
 =?utf-8?B?YlY0SUVncnFrM2ZVVXQ1dUJkN3dLSUF3YTN3VnQvak00bW1KMjIvZ1hTSWto?=
 =?utf-8?B?Z2Y3TnJEZWFpektnYjVrUlZiandjaTJGVCtWVkdleGxKRkdHM0ppaTZHLzMv?=
 =?utf-8?B?bU5zb3NxV0lQbFEwOTAyMEVJTTI5MVZwMTRuUnBGdFRic2NXVU9MSXBQUkVq?=
 =?utf-8?B?R2ZSRjhvQTBxbGlGWVp3ZWdkdWhCNWlBaW9zN1JGa2p0aHZXK0NpdkFtb2Zl?=
 =?utf-8?B?SjR1VXlHQWFCSnNlWGtzbWpTR0NvTUVKNmpaemZLcWNVSndvK2xjanVpdTFo?=
 =?utf-8?B?NTdlR0FxOW1INUVKVVI2Q0F3ZTNHeDdaSisrUjNPZGFZdkVRR1NacS9oNUJr?=
 =?utf-8?B?QVZRWTRDQmM4WUU1amtvMnU1TTlHekFqU2R4ditiZlhiY1lNWmsrcTQ4KzU1?=
 =?utf-8?B?Tm8wa2lXczRHT3QwdHdwYkVhY1JTWE9VMllSVWhpUHhzaWkwTVRNZG1BSlV3?=
 =?utf-8?B?VGxab3pCaHBVcGdZTG4vZlN6OVdTMzNKZ2FnNVh0K1dVVGRubGwwN2plK2Zz?=
 =?utf-8?B?SjBSdGNSNFNjTlRtaGROYXNzS014ODNzV0ZYajFSN2FKT3NkekxwRm5sbWxl?=
 =?utf-8?B?YlZoTm5GOEZVZksrVTNuY2VCamtOSHBnV1U0dmVOU3NXcEg2c092RW9uVzk3?=
 =?utf-8?B?Ync0MlFQTlpESzlUMU0wVy91ZXR2bVhaODNoVWZSWVVLMDFCbldZeno5djcv?=
 =?utf-8?B?TTdqK2dtcGhLOWkvTkk5SlZONkppOFoyWC81TmEySkhVaVQvSVZlZHBUSHZP?=
 =?utf-8?B?bWpCcXZRWkFDUkVtRnZCdXlQRk55QVl3bk1icUdmeXluSERPNHJMcjMwSnZ3?=
 =?utf-8?B?cnJweXpYanVoL2Q2a2NTdVNsWlhSZU1hSHpVbzdwVXllZ3I2cTVBZlZvaGNs?=
 =?utf-8?B?WDJNcGNjT3BXcndNQkxNZytJVVB6azAzMXp5Z2M4bmpyOU5jTG5xMlFHOXBp?=
 =?utf-8?B?bk1YeTc3cjE4Qm1VeEJOejZwYWoxSTJrVG9QamtYK3JRQ29jb0c1aGpUYlNz?=
 =?utf-8?B?UUpTdVFZMmI3YlB1SVNhdjhIRzIxbUZUaEdPOHJzbWU5UUxqYVpOUmhFNGNC?=
 =?utf-8?B?aUVTT1Y3SldUQm5EZ0xlQjdRU2YwWWRESFhIMGlqd01VNXdlRzVPTWEvRmJs?=
 =?utf-8?B?SW5IamdVdXBCZ3VDd3JZc1doeDhCUzdhaGhCOUxiTW1Baks4VFE1TmxZWG8v?=
 =?utf-8?B?bW1RM1BEdEhUaU1zUG45WVFTaEdPdnVjMG8xdWkvazdVaVVGOEJMLzkwbjhn?=
 =?utf-8?B?Y3g2RnZ4cmZqakdDZHMxV1loL1d6UktmSm9OdzU0RDR6TDM5ZnRSajRCclc1?=
 =?utf-8?B?a0NScmZOSmE4RkUwcE1MVFhObkVXMWR2ZkJZa0x4RHFoTm45WTg1RWtLWGhC?=
 =?utf-8?B?c0hhdnU5em03a0l6VjM5KzlZM0hLclJhODFTbWV3Y3lyVG9nMDlwbXZmeCtO?=
 =?utf-8?B?enlPWElYUDF2Z2hCRS8zRE5hcUpvWXdTcGl3TncyYnpxalhPUnRQWXZGeFJs?=
 =?utf-8?B?MldmcStxUy9nPT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5305.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dXhISndBbitZVUc0ZjIxbmJKdytnSklQQ0ZjdTFtRk9YdlNLTWo4a0dGemlV?=
 =?utf-8?B?SEFnaUUvVlZLYWxURlc0ZkZoalYrQzVWT1pGTEx6OGgrMDVGUmYyS3dIb3Zp?=
 =?utf-8?B?KysyL0lPc1U2WVprOEE3QW14THJHRFE1SHhXZGpjUE1hdmgzQ2lTZVhmM1ln?=
 =?utf-8?B?NVhTbnRmTkJVcFFLbGVxaVRjblZWQ1dENGhMVFREcXZrLzQzZHdXOTVwcWlZ?=
 =?utf-8?B?L1RVMXhzdGxuMzF1M0JaaDd4YmtPZk5mZFlrRTFCbWt2YURyOFZKcUxOcE1n?=
 =?utf-8?B?aWFadEh5bGZ4ZjZVdWQyd1dscUdTcEF1YTdXTHlhR0FEb1VEajJiTTdsNUNN?=
 =?utf-8?B?OGZSeHRCNmRHRTZXQXRTM2duT1BrK0xYSVFIU1Z5NDI4R3hoYm1GV3oyNDhx?=
 =?utf-8?B?dHhPaUpMWWxVbzhvUGFPMG00WTRBVi8rWUxvd2IweGtyeHpjSnFYMTZONUhv?=
 =?utf-8?B?OXdOQmVhVUdyQ053OHA4UjE1Z0RBL1JIbk5uQlc2emE5ZVRBQTQrK3JYNFJN?=
 =?utf-8?B?b3VuelEwanJrU2dDelBwdHI1amNhUVFFclNST3IxTFhlMkxqOHFBd2N5WnlZ?=
 =?utf-8?B?K2x6Zmcybzd3R2lpKzc2Z21icGZ4d1V3ZHZnakxxSVBwMUJ1Vk96MFR6NnQ1?=
 =?utf-8?B?VlRVYVYrNm9KYVNMcVUrYk1QWVpnWURCckg3NCt6UGVPczJmaTZEZ1RwWnRj?=
 =?utf-8?B?N1l2b3l2NnA0VGVyVlI2Q095dzdPSlRjQk5lSUhUQmt6Y0NrRk5lOUVST0pR?=
 =?utf-8?B?alB3V05kajJhdW04eWR4aFJDczNXZ3hzdmQzMGdzaVljSStJZzFsYTZYYjJB?=
 =?utf-8?B?dmpzQi9UckgwN0FHdFM5SnNhYWE2c0Y3dDBtRG55YjNuY2xVUVV4bktQMERo?=
 =?utf-8?B?ZUdpaDBzaG5qa3FlbTd4Q3hVWjlzM1RFNit6eFY2dkZlZ3VxRzQwNVBzSWJi?=
 =?utf-8?B?WTd2UTBYNU81eFliTEhvekpvcEh2Z2VHRnN3bk5KbTRXS2xiY1dFc2U5Uk54?=
 =?utf-8?B?dmpWWWk4Rm0zNU93T2ZkZklaWkcxSXNLamY0aUZsU1RwbVYyazVmVHJuQWdV?=
 =?utf-8?B?UG4ydG02MkgwdXVCbkI4M0RMczgrNURIWHZmQURHdklGSm1WRFFvN1d4TERx?=
 =?utf-8?B?ZDVvT1hHdlZRUk4yczhFV01Pczl4VU1ZeEM4ejAzVU5mSnVlSjNSSWdZZnVU?=
 =?utf-8?B?b2Z2c1FVZVFLbEpvOWxSUElUalVWMk1vZ1hoczVjT2wrL2lyU01WVEVLVVBH?=
 =?utf-8?B?L1FCTGVacXhVaEJsZzJId1pLQ3lPeTVGUlozYlFzdHFkZWdneDdjVEJ6OVQv?=
 =?utf-8?B?cFFVYUhwSTZSb044SXdJWnlLeU4ydm15Vy84U1ZpSHkwWW9LcGRMTTlSZ1dL?=
 =?utf-8?B?VUgwbVlrbDVxZmMzYzY5MWhyZE9oeUpXZnV2VVM0T2t1bGY0MUlOTzFZdktB?=
 =?utf-8?B?VjNxSENYdEpOSHF3NkNCcDRhUkJrVHBqRUNhOGUvRHlzVnVIWmYzYk5VNEpl?=
 =?utf-8?B?bDNuRHl6bHp1KzMzVXNuWmJvS250MWZoQ0JtMXpnV0hnMzU2OCs5SUxGUUJK?=
 =?utf-8?B?UW1NbmpWcmdZWU11VzAxa0lTMVFYZVpXcXdiVFhvUWx6MUEvbHBYdXViZ0xm?=
 =?utf-8?B?ZXQrV0k0RUNIZUFOY0xOU1pkYkV2TVZ1V2FLWnl1eVoxcjlmNFlsU3Z0T281?=
 =?utf-8?B?VzlvRnU4Qi9pM3R5ZGdqUk5zRnBVZE5DODc2U0ExNHdJSWtrTWI0ME5HQVgw?=
 =?utf-8?B?UGp4SmE1b3JWb2YvSThtUllaUEZRQXV4L3JJRE1zakQ5U082Q3Npd3lDczdo?=
 =?utf-8?B?aFBONllUYUtBTzQrcEE1TUw1bXR3MisyZ2JRNi9jOEJCRStCajZ5WXNXd0ZS?=
 =?utf-8?B?bmg2dmp3UDNVS3RzSEI3eis2UmdCa001dXNBMUtUM2ZpTjltTno4OFBYcFdY?=
 =?utf-8?B?QWlCc2NMY0loRmtkTWlYcDJ6b25jcXFtem4vOVVaOWJzRGxtdytBbDRkZFRY?=
 =?utf-8?B?SEhRTURxaTBnUnVCR1hrUGk0TlFtc3l4Q3BwR3dZcXVORGwzeng0TVovMzVM?=
 =?utf-8?B?Q0JrYjdWSmlEMEkyQ0I4ZXBrditVRkR5czNGY1hzQTUxNTFoUXV4cTllSi8z?=
 =?utf-8?B?MW5YanlKUlFmZnJNTEZxTklPV1JhSWVuSkVDOUg4YWUvc2RzcGh2aHRINnIz?=
 =?utf-8?Q?QCScgWdJw2MLUXWiiZQl4VQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f2b444-d09e-4637-086c-08de3df12828
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5305.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 04:51:50.5263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fc5ooM2x8UrfLG0nGEqXhOfGSj1LdYz9FY3qDR4393ADiwyaLVlB1bR7wEON1Jl5vBGi3YnRf+3FvxBHMIhl5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8744

On 12/17/25 7:35 PM, Junio C Hamano wrote:
> When various *object_info() functions are given an extended object
> info structure as NULL by a caller that does not want any details,
> the code uses a file-scope static blank_oi to pass it down to the
> helper functions they use, to avoid handling NULL specifically.
> 
> The ps/object-read-stream topic graduated to 'master' recently
> however had a bug that assumed that two identically named file-scope
> static variables in two functions are the same, which of course is
> not the case.  This made "git commit" take 0.38 seconds to 1508
> seconds in some case, as reported by Aaron Plattner here:
> 
>    https://lore.kernel.org/git/f4ba7e89-4717-4b36-921f-56537131fd69@nvidia.com/
> 
> We _could_ move the blank_oi variable to a global scope in BSS to
> fix this regression, but explicitly handling the NULL is a much
> safer fix.  It would also reduce the chance of errors that somebody
> accidentally writes into blank_oi, making its contents dirty, which
> potentially will make subsequent calls into the callpath misbehave.
> 
> By explicitly handling NULL input, we no longer have to worry about
> it.

This reasoning makes sense to me.

Would it make sense to add a

Fixes: 385e18810f10 ("packfile: introduce function to read object info 
from a store")

line?

> Reported-by: Aaron Plattner <aplattner@nvidia.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   object-file.c |  8 ++++----
>   odb.c         | 29 +++++++++++++----------------
>   packfile.c    |  3 +--
>   3 files changed, 18 insertions(+), 22 deletions(-)
> 
> diff --git a/object-file.c b/object-file.c
> index 12177a7dd7..e0cce3a62a 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -426,7 +426,7 @@ int odb_source_loose_read_object_info(struct odb_source *source,
>   	unsigned long size_scratch;
>   	enum object_type type_scratch;
>   
> -	if (oi->delta_base_oid)
> +	if (oi && oi->delta_base_oid)
>   		oidclr(oi->delta_base_oid, source->odb->repo->hash_algo);
>   
>   	/*
> @@ -437,13 +437,13 @@ int odb_source_loose_read_object_info(struct odb_source *source,
>   	 * return value implicitly indicates whether the
>   	 * object even exists.
>   	 */
> -	if (!oi->typep && !oi->sizep && !oi->contentp) {
> +	if (!oi || (!oi->typep && !oi->sizep && !oi->contentp)) {
>   		struct stat st;
> -		if (!oi->disk_sizep && (flags & OBJECT_INFO_QUICK))
> +		if ((!oi || !oi->disk_sizep) && (flags & OBJECT_INFO_QUICK))
>   			return quick_has_loose(source->loose, oid) ? 0 : -1;
>   		if (stat_loose_object(source->loose, oid, &st, &path) < 0)
>   			return -1;
> -		if (oi->disk_sizep)
> +		if (oi && oi->disk_sizep)
>   			*oi->disk_sizep = st.st_size;
>   		return 0;
>   	}
> diff --git a/odb.c b/odb.c
> index f4cbee4b04..85dc21b104 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -664,34 +664,31 @@ static int do_oid_object_info_extended(struct object_database *odb,
>   				       const struct object_id *oid,
>   				       struct object_info *oi, unsigned flags)
>   {
> -	static struct object_info blank_oi = OBJECT_INFO_INIT;
>   	const struct cached_object *co;
>   	const struct object_id *real = oid;
>   	int already_retried = 0;
>   
> -
>   	if (flags & OBJECT_INFO_LOOKUP_REPLACE)
>   		real = lookup_replace_object(odb->repo, oid);
>   
>   	if (is_null_oid(real))
>   		return -1;
>   
> -	if (!oi)
> -		oi = &blank_oi;
> -
>   	co = find_cached_object(odb, real);
>   	if (co) {
> -		if (oi->typep)
> -			*(oi->typep) = co->type;
> -		if (oi->sizep)
> -			*(oi->sizep) = co->size;
> -		if (oi->disk_sizep)
> -			*(oi->disk_sizep) = 0;
> -		if (oi->delta_base_oid)
> -			oidclr(oi->delta_base_oid, odb->repo->hash_algo);
> -		if (oi->contentp)
> -			*oi->contentp = xmemdupz(co->buf, co->size);
> -		oi->whence = OI_CACHED;
> +		if (oi) {
> +			if (oi->typep)
> +				*(oi->typep) = co->type;
> +			if (oi->sizep)
> +				*(oi->sizep) = co->size;
> +			if (oi->disk_sizep)
> +				*(oi->disk_sizep) = 0;
> +			if (oi->delta_base_oid)
> +				oidclr(oi->delta_base_oid, odb->repo->hash_algo);
> +			if (oi->contentp)
> +				*oi->contentp = xmemdupz(co->buf, co->size);
> +			oi->whence = OI_CACHED;
> +		}
>   		return 0;
>   	}
>   
> diff --git a/packfile.c b/packfile.c
> index 7a16aaa90d..2aa6135c3a 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -2095,7 +2095,6 @@ int packfile_store_read_object_info(struct packfile_store *store,
>   				    struct object_info *oi,
>   				    unsigned flags UNUSED)
>   {
> -	static struct object_info blank_oi = OBJECT_INFO_INIT;
>   	struct pack_entry e;
>   	int rtype;
>   
> @@ -2106,7 +2105,7 @@ int packfile_store_read_object_info(struct packfile_store *store,
>   	 * We know that the caller doesn't actually need the
>   	 * information below, so return early.
>   	 */
> -	if (oi == &blank_oi)
> +	if (!oi)
>   		return 0;
>   
>   	rtype = packed_object_info(store->odb->repo, e.p, e.offset, oi);

This looks good to me and I verified it restores the original 
performance, so,

Tested-by: Aaron Plattner <aplattner@nvidia.com>
Reviewed-by: Aaron Plattner <aplattner@nvidia.com>

Thanks!

-- Aaron
