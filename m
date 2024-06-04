Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C664A11
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 18:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717527107; cv=fail; b=V6ikPPZJUM0HSqPP0i/HSqvsJpeLfDdDcbowsqDWvrEGZVARVDfbu7mthVqzKjh33txrLPD5YjkfI4f+IdkPkihgY4SCGmZJmVrVyi0d2Beed4v+AqX+Tn9OMCnQYzBcPuSdSngfnkgfJDX6oNgaQJ4JKKNsVirIfSgEFN1a9Jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717527107; c=relaxed/simple;
	bh=Qgc1hovlpPsDuPcsPK9F6emwaxOOnRQqaWhkQBg8n6M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=klJv5uVJgC4IOdxggCajk5G3+/lhkh5BBKkGfzMiXkWFjmZX4F2BmuFSrT8B7YjVC9lHord680I6G1GlzEkpW6AlP+0U6K3c5ZFzo2MvPkfD0cTtgfTpd9oJfkjfWshZavMMTar7L7OGXiiaj3feZlYG3zWaTenjBusbt9Eavb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dxye9LH5; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dxye9LH5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGZXQw7wHW5u/wfowWluho81XtpmOBLK/X1G+cbo96FV0lqdXVAxYRMCLBE+9S77uMiEuk2CRS45TQEDubii0To4MqwIwYGj8UA9KKjSxqq7pCjmLEM2Pjwk52GModX8+ihVQt1B5QHZ0WncqtcGRyc6tFC3TrcQXWbeft4MGd6HC60cepNO+XSJms2LTmIitA5gUA8XBciabPFARruCO8kDqzdHC4jM1B0Dd3EUiFODCh+5s28YVY1eQNBYFlaqJxtiByUNPzAAYQiGEBggj8nS61hNgBoJCPxffhIAv0LglEVF54nkg7yNP/e1UPSHwC68Mm0Bt0TfgaqD1Zr70g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyFsEeGsFLhNQ7zrWok7fUX1v7KdxAVq3Pt/3bOsxFE=;
 b=YwjqhRG1/Eax9+Af6OZb6wHQbKNYVP643b53PPXL1SRTjaDFTBhBS8S1of5kvbuAr86CgwNYS/4iZy1cfpIG8y0+iCqsdOi0EeDK3FtZ0fqu1dXOXjRuDdwcDrbHBoHYf5rXXcs0gfaPCHfXao9go8vgivpTi2HANYYB+OMQQpmCclz3K23SVAJqcJY/l8+4/E400OIncJ2wvbhS0ltpI5hvD2631pXJBOS31frLUMbJEUr+mV2ghjKBd56xuzNIegSL6ZOzpjqv0q6o91c4hnU2pBJl81bEDxgPatDOdgMFIaOA2B3cjdotAZdPRO2bpIpH5xAd2vK8RKxRmQbwCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyFsEeGsFLhNQ7zrWok7fUX1v7KdxAVq3Pt/3bOsxFE=;
 b=dxye9LH5Ok0yYmcw6jbP8juc/Bk7vJdyzFpZrupgZePQWOn6kvwfpFEkOjMR8QFRDNPCsb962EoeFk/zWbcXX2mPfYT0asi4q9QJpww3ODZtcop63e7m+L32iOxO1WI+aBCIRlvnU4C3A3uwlkXlmPmJizKy8H6sNVycNxMm0TorypkSvTpmnpo48LosFr4GvEi2aevIMjjSQjG1XNxfK5uaku2FWjeCWfVWrsipatR0lIb9dLW9FHb7EBZbBHJUcy3wEReoFGupciobSsuI8nGpdxbLLzPp9DFQWWghruM8FlM2Y1Z0uhfrT3t9Dsk5DqYtTWCHLiRNGGFes/tKng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2981.namprd12.prod.outlook.com (2603:10b6:a03:de::26)
 by SN7PR12MB7322.namprd12.prod.outlook.com (2603:10b6:806:299::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Tue, 4 Jun
 2024 18:51:42 +0000
Received: from BYAPR12MB2981.namprd12.prod.outlook.com
 ([fe80::7e8:e993:c7e:656a]) by BYAPR12MB2981.namprd12.prod.outlook.com
 ([fe80::7e8:e993:c7e:656a%6]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 18:51:42 +0000
Message-ID: <4639c4de-9915-4e3c-9c5f-9c55cfd46637@nvidia.com>
Date: Tue, 4 Jun 2024 11:51:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] credential: clear expired c->credential in addition to
 c->password
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Rahul Rameshbabu <rrameshbabu@nvidia.com>
References: <20240604180224.1484537-1-aplattner@nvidia.com>
 <xmqqed9cva5s.fsf@gitster.g>
Content-Language: en-US
From: Aaron Plattner <aplattner@nvidia.com>
In-Reply-To: <xmqqed9cva5s.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0105.namprd03.prod.outlook.com
 (2603:10b6:a03:333::20) To BYAPR12MB2981.namprd12.prod.outlook.com
 (2603:10b6:a03:de::26)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2981:EE_|SN7PR12MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: e68cf154-5edd-4950-b8af-08dc84c75ffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjE0SWUzMlgzRElva0c1aDhPemFVSkZmbzhXQ253RjhHY2VLeHk1eGFjVXNG?=
 =?utf-8?B?R09NMGFaYllaSCsyeU9iR3dzeHY0Ri9sdWZXWWpkQlNBc3FvVHJSNGNXa2Vq?=
 =?utf-8?B?TFFWSEpIZkh6YTcvMWQvSEtrRi9EQnVMNkJ5bmtGcVQrNnJUZ00waUI1Q1ZM?=
 =?utf-8?B?ZFl3V0twMldHK0JQZ1dRQ3pqYzBRekVuN0JnMnhNUWdyalJ6NXBXNjR2YnJj?=
 =?utf-8?B?Z0lvSW1uZVFnTis5MzhzNnpjWGhHNWFRYTJZeGt6NU5iT095MnJVdTVMdXpN?=
 =?utf-8?B?S2U1RE81OUtrejN3eWhVMDlwWW1MZVBWQWlNZ21tcEp6ZHgybmxUaFhRZUJn?=
 =?utf-8?B?NXV6clpVcjg4dnMwN1VLcnloYU5HNXEwbDUxS1FrWEh4cHpVNGVQc0s5ZGVS?=
 =?utf-8?B?Rnk5YzF2RURTMnZCNjRyTFRzYVZJbzhxSTk4dVBmbFJmS2xOdUhOWjF2d01O?=
 =?utf-8?B?QzBwaDU1WUxYQ2RUK09CczJQZWVxcnRNd1haNDlURy8vaUswbGt2ZHlIWkhU?=
 =?utf-8?B?Y0dUaGI4cWY5cWRZWnVrMTRoQjFDZVBzYlpQZEV5d3FhQmxSOGVJVGdodFo4?=
 =?utf-8?B?OWlDT3VoMUhxRkl4bjRMY2xvaGRSM291aG1wWHVPbE56OW4wS0RtT3c1NEgv?=
 =?utf-8?B?ZnpDc2JpUWVzV3hzUjBSSi9EWjN0bmJQU0svblJMcFR3NnpET1lzOUxQRVdy?=
 =?utf-8?B?RnFBOWt2OUEySzBkNXlDeENvbUdrdk5DaFZ6ZkRWaURTSGszR3NtNHNTK3Jv?=
 =?utf-8?B?ZG9xRGE4QUtBelZZOUNuMTFxUzlXaXVJNC9hTkU5bnNKSjVzYXBSLzNZUFBX?=
 =?utf-8?B?TUw4dmw0WDZYTy9BTGN2S0ZTaGIvNTNiWGc0enBoVkN1dTdsQ2J0aXB3NVZw?=
 =?utf-8?B?Tnp1bTRGTVAraU9PVDh4YmUxaTV4OGJZQ0tPa0p4SEJoRnhYcUlsT3JMZzhO?=
 =?utf-8?B?WGNOclBRWU5yOXF6WnlxRndMRVhlSEEySGQwbHN3TWN0U0FxSmpLcHB0RUxj?=
 =?utf-8?B?SklpS0YxOFJqNnpSemZ3ekdPS0pOcWlYSk4wdUs5Yjh4bGVsQzlNSStFL2FR?=
 =?utf-8?B?L0VFa0YzRjJVUmg2a1ZUTzN3SFN5MnNJWmVRdTcwN0JYN2NCbmlGelduNHZ6?=
 =?utf-8?B?SnQwc0lqVGxud0tkZ3Zvb3hSR1dqUlNwOFdOOU9GSS9sWEJKaUJmMkpVdlBE?=
 =?utf-8?B?M3NsbkI1c3BkZnFTdlRNZjhzRlRaejFUMW1pdk5DRTBpZDZjYnVHZ3hRdW1v?=
 =?utf-8?B?WUUvbHJnMjN5S1hxTlRiYXBKQm9CRnlHY2RIaTl6UVhSZnVPRmhQWDJwaXQ4?=
 =?utf-8?B?Y04vaElLR08zbHNpUmNnTkFnZUNmb0UzNVQrdEszdG9DNEptLzRCWmxqYyt3?=
 =?utf-8?B?TWJONk0wKzlnU1MrNmZkTlFRZll1MXB2WDIxSHNYNmk5WEFkNWRQVmVsZ3lz?=
 =?utf-8?B?ZjNyMGVMS2trb0p3VExiUFViRzhPekx3ZmVVdjZQdkFJUVl5aHZGZy91bTl0?=
 =?utf-8?B?Uzh0OVZqQ0t2Z1JmZUt4cjJ2SVlaUDlET2t3dDFXRTdDRjg1UFcwNXdSMHFz?=
 =?utf-8?B?OUdWUy9YaGxHdldoc3FIdHpmNWxkaHplcGxnU0FMc3lJZ2dCdHltOW5jc0tN?=
 =?utf-8?B?WUNCRTJMYkVBTThBZmlzanQ3akxSL3dSL2pOckhCVys1bWJhd1VacFo2ZStr?=
 =?utf-8?B?ZisrOFBwU204cGJGUm5JRWtXUFIxL1h0OXJ1cXVYRVpQeERhT1V1elhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2981.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXJSZXhmOVhPM1lPLzU4cCtwdGRXVnZLR21RcTdLQTZwZFdiZC93cithcFNV?=
 =?utf-8?B?YWxXTXBmYUhWU051U3AvRXAvWnNubm5iMjF6Y3htMnQwTStTN1daUWFjTTh4?=
 =?utf-8?B?UE54TkdtTm5DYkZLSGxaaXE0OHRHa0orYlFSbUdYS3VjdWxiT2pXcFU2Yndt?=
 =?utf-8?B?UHlCcnJKd2FpUjkvMStob09BaTN3VlJOWTROV1RpcHFMWHFteVFGdVhsNkUz?=
 =?utf-8?B?NWJiWUoxcmgwY1VsSnV4bnU2ekpiNmpSWk9ldkI0amJBcGlOZmhKcjdObkZk?=
 =?utf-8?B?dHFQQkhFczJDQjBGZHFGS2RFK0NEeVBaWktYNlpsVVB3TFpvMS91ZGRKVC9a?=
 =?utf-8?B?U3ZTRElwdjBvNEdKV045T0duTEVWZnVkV0hPUU8zZldRdDcwa0p3R2lrYVFh?=
 =?utf-8?B?N0hqdlN2TmswcXRjNld5SjcyYm83bU55YkkzTlFKamowbnQ2SGJQYXlTZ1Jp?=
 =?utf-8?B?THFKaXJxR0QyK2hTak5ySlJrejBkNmE0a0JwS2FPcitpRUZOOFFsSEtvUWI5?=
 =?utf-8?B?OTl2Tnd4Tjg3dG1Zcm1tQ0ExZDFPL2FZU0lobFErN25seWlBYlhCYTkxU05p?=
 =?utf-8?B?YWxpMEcxZ3oySFFYQmk3QzdmM0xRVlo0OTloYnp2VTQzbkVxbkc3djAzWG1x?=
 =?utf-8?B?bnpFZzhBTEs2dENuczN3a0NiU1lKVDQ2M2E3WjlRbVN2bTVUZnBUS2JvcG8v?=
 =?utf-8?B?RGdpZStFcVFIRFFMVUJBUVYvY2tCVnU1QVROT2EveUlhS0M3Q1RmdzNTRGVL?=
 =?utf-8?B?V1hEdzJjOGJKRm5hbHFoZnJMMFdVUWJQOUFsUHRKVzVTYkxUU3h4cllNbW11?=
 =?utf-8?B?WE1VSWlDVHhNRnRZT3NaTzRxdHZKck1OdTVldmFxMDJ5YnY0S2I3VTFIaGhO?=
 =?utf-8?B?emN5L3piVEFmVXF1eU5XemVSamtmSm1Ra1k1eFBiaHppLzRQUS9JbHpuMnNm?=
 =?utf-8?B?QzJjK2hsWG16aVRWWjZuUmR5b1F0WlE4b1g2VnNSaFN3OSs4K3REVHBDWDh3?=
 =?utf-8?B?aUNlckowMEltZWlFakh3aVpra0FaaW5OQ2JHTmFobHNXdzVNUVBBaUFuK1Fh?=
 =?utf-8?B?WFlXNVhsMWdwMGdFNitQUE9RbHl3UFBDRVlQN29oelNGSTFOUUZjcmVqTTZw?=
 =?utf-8?B?Y1hCVHp0b3ROMFdxU0d5K0g3SmNOWUtFNzZOWm44aUt1YTA0VEo3WGFBM3dp?=
 =?utf-8?B?K1I4U05uM1BXSXI4UG92aFZiWTNnRWFPQ1ltZlllOG9pWGc1Ym1lTGYyZDls?=
 =?utf-8?B?Nm5WSEJHRnl6SGxLY3cybWlwd0xyemdGQTZMMnpJakdPZ0lqNUJDNUNHWVN2?=
 =?utf-8?B?L3FMM3RGdFZ1dVhWbVdod2lnd1F3bDIvMGdkc1RzbVZGOUs1TkFNYm9EMEUv?=
 =?utf-8?B?c3lZVW1RcXBRWU50YllNRWxPeVE4VzlsbE5Sa0s0a01uNzhtSnZFcEJVdVZ4?=
 =?utf-8?B?N3Z5VUlNZVlKbGFZbWlRQzVFTWM5ZnV4cXZxcDU0eHVIWnlFT0dSdjlFMTJw?=
 =?utf-8?B?aWYwU2lxdGlRK2UrTVJ4SzB2Nm5hSzJzb0lyQzdiSlQyMHYyaEVLN2JtcGt4?=
 =?utf-8?B?VGM2dGU2bkhoekpiODJwbmIrdE9CSWpqUjF1YlJQSkRSQW4vMkJkbkdrcEJF?=
 =?utf-8?B?VldteGhXTG5OMURvaWF1Wm9FZ1RMRXh3Ritib01LOVN5ZGNjNlN3OHhVbFhl?=
 =?utf-8?B?OUtzVHRrUDJRb21ONmovQ2tjOUFwcjZvYm00WGVpYk54aStwcmwrQVBVRDAz?=
 =?utf-8?B?V3VkYkpld28rcldqc2t6dlFDSXVrclV4N1hmQnlITU5lY0VTb3RvSFBPMERV?=
 =?utf-8?B?ZEExUVlHUmtNVFA4YjhkdXFlSEF0ZGplZUJsaEthNzgvanVxVW96d2dldkQ0?=
 =?utf-8?B?NXZhQXFTcDVRd3h6cGJZQ1pteG03TVZiRlprcTVzRzV4K05RcThHUU5iVStF?=
 =?utf-8?B?Sm4vanJWeGhpZGdXWHozd1pEbEJ2K081TXlwOHlSa2Zyam5BbEhxc0hpQUdv?=
 =?utf-8?B?Y2FpWHRFczBUeEpjVm1aV3pLbzduU2oyQk1nRC9tWGxlWTIxem81OWtBQU1y?=
 =?utf-8?B?NG9HVmEwOHRQdS9FakluMnMzWkVxV0lEa3hMTnJZTGZETHlMM0tKbHhwUG9N?=
 =?utf-8?B?Um1SWXp6WXE3bGw1WFlHZTdqZmYvcjRTLytGMGNiU003OWVwdW9pZEl0R2VD?=
 =?utf-8?Q?MoKwhLUTjULJmGKLMMSH26A=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e68cf154-5edd-4950-b8af-08dc84c75ffc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2981.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 18:51:42.4420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+hb589AoAJmt5skP5xbYUxe4tX9c6C/sjDi1IE6kLJ+2F8wybUN5gBGbur5BMu9gDvMFiREO6AHtvFTbUQvHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7322

On 6/4/24 11:24 AM, Junio C Hamano wrote:
> Aaron Plattner <aplattner@nvidia.com> writes:
> 
>> When a struct credential expires, credential_fill() clears c->password
>> so that clients don't try to use it later. However, a struct cred that
>> uses an alternate authtype won't have a password, but might have a
>> credential stored in c->credential. Clear that too.
> 
> Hmph, piling another thing on top of these selected "discard/reset"
> we already have should make us rethink a few things.
> 
>   - Is this the only place we discard/reset/clear?
> 
>   - Isn't there already a helper function that was DESIGNED to do
>     this for us?
> 
>   - Are all these places we discard/reset/clear using that helper
>     function?
> 
> For example, when we rejecting credential, shouldn't we be clearing
> the same members of the structure as we notice that the auth material
> is stale and has expired?
> 
> There is credential_clear() and credential_clear_secrets().  Would
> one of these want to be reused in this (and also reject) context?

Good questions.

As far as I can tell, credential_clear() is for when we're done with a 
struct credential completely and want to reuse that memory for 
something. credential_clear_secrets() is used when we just want to 
reject the secret part of the struct cred but reuse the rest of the 
fields. I'll go through and see if I can determine which is which and 
send a patch to unify some of these.

-- Aaron
