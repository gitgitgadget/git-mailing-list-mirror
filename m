Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012065.outbound.protection.outlook.com [40.107.200.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D9C24466D
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 16:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768408494; cv=fail; b=QkcP3uGjMJFb7WA4KtoiTom+4xLd8fWwNFykBJ7bsc339pQIc2NmhTXjwp0cquG0ygRo28aO33ibQB+RrWI3b8tBOTt3MCgnWiPpn0oA6qUJ+5qFeiQDxseFzLqDLq/n+UG6+XDMMOcmGVttqdq1mtufHVUoUZTNH9XM5t/wJ28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768408494; c=relaxed/simple;
	bh=ZiZDRLIIghWPJ0IlwDRNv22oDB+0L2tAeuzUsiXPofU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=snOp+v2ltxfr+Y4wS+QJaixX33jKxhveM5HRQVWDgbIdiIqpgzuZPwPUkNdxmENu4/O0nyqBUKgTQ139nDHsqxHK5dGo19jJ0A2NpnRVcqZ7FvxfX0ceUBgqwdxDzPAtCDXEQfd04NEcYauvcAcMAf1Wl3SwYw9J/sXNEQYBCJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dewptKxz; arc=fail smtp.client-ip=40.107.200.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dewptKxz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNPaMN/80kP9bAouvRoggtxe0NIJnemVFGvO8P97kCRPGQDKkDBALMYPtQDqoXDtoHYORoGBBew/Tl96ns+OD7u80H6KJmZdFq2xPlnAjKg2APZRXxHUPHcSeviXlQmVdNTYBuyyxj9UJTyQAKQVK9wbBuUT1TT2xfrhRp1Mkf2FBKSqCeaJDHdBVIjxR2rOqvE0UY9pOzjB4t35KD6pomlvDji/gkqM4WFHrTBCNofmLeaws1CR1gDUfDrnk3RH0inQu2CA0Nl/0pEEDGQiDiSPgdymF48LusC3mE0Jiu/LHokJDCuy4hNjAc+R9uRF1S2q6gyJsGCO7aiE6oR5EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gi1fLp0RI3jBra6tUQ59B/fTTm0vVt2EZ8+pb1qZzQ4=;
 b=Ut13tVzXa8hG8vftSNLPbyLtQwBpkvBnub8X12pyhQCpwnnHR4KmbynbsVyzAH9K1uHpL7CkYzI9D2yCddxujU7BTtpx2vpmio4pmyyJAlnXpRc8MLRUpDUl3ADQTR17vWbvI0WvYyvii/NtojMd5LFldxOsDaX5oA28Ptqri2rhI0tKYkPIs6RLKuFp9e6oNdLq2+9me8fKc/fs9A7fFOVqzNM6xCqvwA9U7pqw8pYosHIdEkbXtfk99QbXxRNzJ4p++CPnVUnZ/twJNaqrrQubDs3RIn5Q/qmCMixlfjQfAXZ3KF/Uk8zlHbvK91MTt1vkGpSKep6beL8+jYE6iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gi1fLp0RI3jBra6tUQ59B/fTTm0vVt2EZ8+pb1qZzQ4=;
 b=dewptKxz/RRQRbvGmyqs9jT+6MhjzgeodL5Z7OB9aMR3nlJVIB26OGOhq9Pe0z4Bz02lA8uso5lTePnLEnz1lCEMIpi0POR8uXZIKh8qGJodKgvpIpFLIq6v3bt0g205YHf1MiqmshgZe4CwVqg2E7GKV2dU2K4Ca0MptGb+w5Qz9i0qGFymzXbDrmz374fUoqJeBkMui1Ox3np7zCzbFR+vqWFXAggRm+TkQdL7pHA1qReGnu6ZjpbYJwO90lkLycTVeUwxpvU7vJkzsX75JJ51rITU0E3STIPiHqDbuVHGltTmJWX+Fbju2hYgGUVqXTobowH3U6fLiLR85xxTNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5305.namprd12.prod.outlook.com (2603:10b6:408:102::5)
 by BL1PR12MB5948.namprd12.prod.outlook.com (2603:10b6:208:39b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 16:34:49 +0000
Received: from BN9PR12MB5305.namprd12.prod.outlook.com
 ([fe80::83f5:1b0e:a61d:6707]) by BN9PR12MB5305.namprd12.prod.outlook.com
 ([fe80::83f5:1b0e:a61d:6707%6]) with mapi id 15.20.9520.003; Wed, 14 Jan 2026
 16:34:49 +0000
Message-ID: <613b47af-5269-44e3-87f5-d29fba9d73b3@nvidia.com>
Date: Wed, 14 Jan 2026 08:33:43 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] remote-curl: Use auth for probe_rpc() requests too
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Lucas De Marchi <demarchi@kernel.org>
References: <20260113031929.3746753-1-aplattner@nvidia.com>
 <xmqqfr89lkve.fsf@gitster.g>
 <a919f4cf-8355-43dd-a552-df99325e4cc6@nvidia.com>
 <20260114022057.GA858110@coredump.intra.peff.net>
 <xmqqikd4gu7r.fsf@gitster.g>
Content-Language: en-US
From: Aaron Plattner <aplattner@nvidia.com>
In-Reply-To: <xmqqikd4gu7r.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0134.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::19) To BN9PR12MB5305.namprd12.prod.outlook.com
 (2603:10b6:408:102::5)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5305:EE_|BL1PR12MB5948:EE_
X-MS-Office365-Filtering-Correlation-Id: 86f9731f-6180-4cf2-0ce6-08de538ad5d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDhxVVVhRFhTbnVLVFM2RUJCUmYxanEzT3R1WXh2OStsRDNkZE5GMXQ5bUpv?=
 =?utf-8?B?VUgyMWxkVlp0ZFVKUGJTMHI4UThtbVA2Ly8yeVV6OThaMkU3UitMWXdzL1lR?=
 =?utf-8?B?Vkpsdm1oS0V1QUVCYkZZaVg4MjBsVXRpM0pmeG1KYU9RSDFHZ0R4N0NxYm0v?=
 =?utf-8?B?d0VVb1ZvWElqcnZ1T2szUG8wdzhRdTJ6bklGWFBCdURzOVc3REtUaXY0bTIx?=
 =?utf-8?B?MFNYRVBycm9tNlc2ZVM1K2FBZDFacHZGTzdkOU52RW9mQWRtWGlib0FnM1h1?=
 =?utf-8?B?U3pMT3hXRld5U1JrcW9PQWtZMG5VRmZjTzg4N1J1VE9Na3FudjZnUzJOb1dU?=
 =?utf-8?B?NW1hdnVwaHFuczlVcXpST3dkOU1uazBnVjhPSDNBRFVrZGlkSU84UjZHTWFt?=
 =?utf-8?B?S2N5NG1RTG83bDZJVzJBYndKUXI2SmYzWVppcGJkUTlpMnpyTHhMNTR2YW1y?=
 =?utf-8?B?RnRvV3hvUHpRcjIrMUZNZytJKytBc1hNUzN6eWJQN1RxOXBVUGUweW5EOGNI?=
 =?utf-8?B?T255dGYyVWRGSWJCV3l0UXMweDBqZlFTQUU3aWVLaG5TRDFTK3c3MGhpV0NU?=
 =?utf-8?B?cE1SanZvWVFjcEJRQXZ1UkhnUitZWWtKbFlRYUtuR2NTYVJCRWNadG54TTVh?=
 =?utf-8?B?SWxkRFpZeC9HZ290R1hrRUdlRnRKdWhndStrcG9lNjVySzVmU1pmRGcxYjNz?=
 =?utf-8?B?bWNhcURjTTZLK29qdWJpTTFzTTBRck1HV2Y1NWN3dXpzQXpmMEExVEFLM1Fk?=
 =?utf-8?B?MkE3Nmw2Mk8vMDRzcnNoeW5zdmNqVE9rSHFHVDhBcFRRc0o4TkF2Z3pETEN6?=
 =?utf-8?B?Mm1XRmpCeWEyVjl0UndJd0xTOVRGUWtUSHF3ZG9oQ2lZS0xoRGZBcHJHTHEy?=
 =?utf-8?B?NFgwbTZuRUFqZy9XQVpYNE4zNWRQNnhoVDM5dXE5STZBSTVZdGhkdVB1dzNQ?=
 =?utf-8?B?cEx2YzJwYWRYSjRoODU3SENGc2t5RUFISkR3Yi81OVFydVV2TjBWZjlGalVv?=
 =?utf-8?B?OEVBY1VrbkFiQmg1R0xwL2ZaT0t4OCtRUTFwNVREbHNoL0JQMmgrdmNRZXQz?=
 =?utf-8?B?cU1iRHFPV1ltRlpvc2Jqc2c0VTRtU0VqVXJITU9xekFSZStTZVNkcE9JOS9l?=
 =?utf-8?B?RXphYkJkaWFXS2EvUWRkeG4raXNJSk9YRVBEMnQrSjFqMVVCSG81RFc5cEMw?=
 =?utf-8?B?SEJ6Q2xSaHdrYUdicUpjU3ZJTEdjVTN3dys5bnM0RHlrWmtmU2Q3YTNNTkFZ?=
 =?utf-8?B?R3BPV1RhS1VHekJIWDVDdVhwaUF4UzlIYnZqRng4ZzV1MWV0cDVZZFJkTGdo?=
 =?utf-8?B?bllNejI4T0prQjRRRVJSb0piTk5JV09ybHZtTEVVRzg5L3VlT2xvazhuM3px?=
 =?utf-8?B?Rm1Jd2xtdmVXTC95WmpPZWp0YnJ6ZkFmR0FCQXg0eklITlZEa3dZbk9aV0g5?=
 =?utf-8?B?MzFOem5kTFhiQUo3YVhWRTRQL0E1MkxhU2RDSDBjUEE1WjQ5T0NkWXl4OTV5?=
 =?utf-8?B?bDI2TlVRRWRDK1Ftb3JDQmtGRVR2MllSVFlBdFdUVnZQZ09SSXNUMTlLcFhj?=
 =?utf-8?B?K2Z6dWZsM3BUdW5ON055NHdXVkUwU2diRS9BYy9Ya0lBNVNIRWFEa3plTWh2?=
 =?utf-8?B?YnlaamcyMFBDdHBENHZwNlZxSGVxOHhZSUV1cmlzVTh5WEJnSXlwRzBoK0dU?=
 =?utf-8?B?d3ppT0hSWkpHVzJSd1pybHZJdkliWEtlellab2hJaTVhcGpZRHdPaTgvanhK?=
 =?utf-8?B?VG1wU1gzZWEvV2hhRmpUeG5ETXc5UzhrWHUxK3g5SENFVXRPZHhUVFN5L0lW?=
 =?utf-8?B?ODBjbG5sSzlIb0F2VndlU2VkbEJjRzhINGRuNEl2eU1wcVJhTUJIdTdpaXJw?=
 =?utf-8?B?OTlyc0pzMW41bEZNSmFralJYRTJ4UnVkWnFBWmxUUVI1YUhHUjZjSzVLVG5l?=
 =?utf-8?B?cTVuQUVZMUFpUzlMbFQ3cVhMRmJoREh6SEpCMmZrOFlwUFczQW4rbnlQazgr?=
 =?utf-8?B?YWtoVFFGODhSd0FjM3R1YWpEZTBJVU4yc29hc29MN3RSdE9id0tZcGs4TSsz?=
 =?utf-8?B?RksrdW84Y2t0d2VNaXFVd0tURkdQODMvbktnVW5hY0RTKy9FN1NjU1J4N2F0?=
 =?utf-8?Q?ACiQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5305.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2V3d0tVNjZWT3UwL00zZWlXcFZGc2ZyWFlPK1JoTEJ2Y2htYkpYa1FQMzBU?=
 =?utf-8?B?U2RqTXFTQ1VqZ0gwVWdRRk90cG5EVElkSS9IV3FpU3dtWm5XcEFMVVJ0VmFs?=
 =?utf-8?B?QVBXQjBqcFlhcFBwMHZsRE5pODZoWGhSYzV3K2xyS2NNTlNMcDBITGM3UmVl?=
 =?utf-8?B?VG1Lbkhldkt5WUVTZFZEd1I0a3c1b3NreUlkMWZNYmNRVlBEamkwRVBvMGt5?=
 =?utf-8?B?Z0dvNlQxOFNROUlwOUt5eVZxVmc5dmdRK0NGMnRQZTJuV1NjQlF4eitDN1F3?=
 =?utf-8?B?YlkzYStBWjR0blEvYVhad2dnS2hHcC9STUFqNGtUZVJqYVZ2b0YvWDc2bXRM?=
 =?utf-8?B?Q2ZkL1BGMW1YalJKMWgza0VacHMwYnJ3MXNSRzcyZHdDV1l4WjRKVFFieDBj?=
 =?utf-8?B?UDNnSkNzZXhCTEZvT0FOZzZWRzVjWlc2dGNWM3F6cHFBMjRJMjEzRmdQRFFL?=
 =?utf-8?B?OWsrRG9FeGhpSkwxYWZSUXB1bzNhQmJqTlhyUm4vTWx0dEpZVVdmZll1cklU?=
 =?utf-8?B?ZEZlMldrQ1RFd3Y3THg3ZHh0dlBBb3o0bGxOckpVMjZHdlhQNWI0MU9KQ1Zs?=
 =?utf-8?B?TjAwcjZOWWtleFFlTHRnVWhIY05aQ1BMYk1US3NGR01odHBWTWswclJySVhP?=
 =?utf-8?B?S1J1RXFsY25EcGRHSkdndDBBcUdMcThCdW1PRUZvSk1NMmVTY0E4eURZc3dr?=
 =?utf-8?B?YWNXL0NGU2V0Q0JUSC9UWHlBb3RuT0doaHd1MW5kcmczU2RTM3BzbVh0eVIw?=
 =?utf-8?B?Tmc1NER5QVNNb2M0cjJVd3pFK3h3UG5wYUVxVU14cGZQa0dLMkNBRitsQTRq?=
 =?utf-8?B?bWdLejVQb3J2WDVRamVRYUllVUEzL3gvbTBWaTk3QldlTVNsaUYwRXpRbnlQ?=
 =?utf-8?B?Ykk5RENITE9mRVE2Z2lBK3pWbStkTXJQSDNqcVdCNit1TmRUdGt5SGgrM25E?=
 =?utf-8?B?REVJOVBRU0hsQkFONjY2YlA4UURlNkxFd0NaaFg3dVFwM1JlbFZjdURYb2hu?=
 =?utf-8?B?aFVQMWJ4NWJueVF5b2xLQlFnTVFDSmpEU0xueUZzMkxUMGc4VjZNcU1tK0Zh?=
 =?utf-8?B?ZVNKWGh6UkFmWHdISmNVSlNwQnh3RVhDRWtZR0ZsODVTQndGSVRJbjRNaGt5?=
 =?utf-8?B?d1VrUjgvTnlwdEFqOE1XVWdFQ1Fja2tyVGlIeEU1OEF1cHRNM0NvNzJmZ3lB?=
 =?utf-8?B?M05Fck5qZGFBb0tFZU9HeHFQTXoyMlpHWE1WNDVsbFJteTNsWjdMbFJvaThj?=
 =?utf-8?B?UnhBaktMZ3pWTEozSG9qeU8vKzdnZmg3dzZPZXZncUJSYlRjZ1NNVVRsMXVY?=
 =?utf-8?B?YVJqYnhQWWx2NEVFVzFGeDhVTDVCQXpFQWxRZ1NBU1J5RVBadnJ5TGdoK1BI?=
 =?utf-8?B?NGRIbFBtd2NyWmJGTTBFTEFrV21tV0x6Ly9XaWtpRWV1bzhSemRKOGNLUW9z?=
 =?utf-8?B?b25zTEdGd2I0QXQ4UGRwTTR2WWEwUEkwdWFRMzY0SEtiS0oxMVdXbWJuUGtL?=
 =?utf-8?B?cHdTWU5wZUtBblpyTnZlS3U2amZBYVozYXFPSEtSQXNrVUo4dHRpYlBwOHNO?=
 =?utf-8?B?NWt2dWdUYzR3bGd1NmY1dEJ5QkNsajNEa0RtbllyUG9OQUVHaGJDZEV1cnhI?=
 =?utf-8?B?TEx1b3U4R2hld0ZPa2dZb0dXU1YxUTRkcWRQVjF0N3N6TVpTUFlKbCtXQjly?=
 =?utf-8?B?UGZkMHZWWFBWaHlqWVdXT2pqM2FOaGhVcG9WcWJRUElndTVib0IrZEJrcURt?=
 =?utf-8?B?MzJjeW96Y0tiK0VVOUlrK1I0a3BsZDIzY2lObGJqOFhvT1dRdHJsYS83aUk5?=
 =?utf-8?B?cGk5R0VVMDBLTWgwM21wa09la3RLem9CeXM2R0tvWVBEWHVXSmZubVI3QzVv?=
 =?utf-8?B?alFlYVhaaFBxREdTUnhBNW55SzJXLzJtamVkdnA2Q1BOUGJTdVhEV29UeHBn?=
 =?utf-8?B?dW1WTHFucmd2aS8ycTZHWnRmaGRSbTFSVVlKNTJqVm9ITlczc0lhUGVKOHlZ?=
 =?utf-8?B?bG9kL2cyNFB4SXY3cGZxRlFQbmVVdWMvT3hiR2w4bFplU0tNdFQycVU5Tkg1?=
 =?utf-8?B?WG5xUktveHIxVHdudXorSGNhZm5vSVZzN3cvNVBHM3NPaFlWMHlNKzZSbVVs?=
 =?utf-8?B?eSt4SVJ1dytJQWZ1NlhoZW40T1NTZmUrVDdXN2k1cHJaRlYwYjFtbmRNS2sy?=
 =?utf-8?B?TnEvSFNQUUFpNXhKUTZCSXFtVWQvNG9YVGlFakF2aSt0ZHRvQkNUQlpibGtk?=
 =?utf-8?B?ZzVudi85OW04c3NFc3V6VGtCa21lTVlHTlRWYktOSDhTRzFUN1pwbzRxRGk2?=
 =?utf-8?B?MkZSNU9adk1ZZVkxZE9zUzJHM0lQUFVpdm9TYVBzY0FvelJ3WGVQakVOdFA3?=
 =?utf-8?Q?QhL53pgtJvpgFC5s=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f9731f-6180-4cf2-0ce6-08de538ad5d6
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5305.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:34:49.2611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GyX9b3T2Qb15JTHA8mwTuxS8DJLZ6emBIHHlHCjZQIhyxZRuGnVbfqhsjPi/Un8z5gKeGoCoxJXrQU2MaMoCLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5948

On 1/14/26 6:11 AM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> test_seq can take a format parameter these days, so just:
>>
>>    test_seq -f "create refs/heads/branch-%d @" |
>>    git update-ref --stdin
>>
>> is enough, and saves some processes.
> 
> Ahh, I forgot about that one.  Good suggestion.
> 
> Thanks.

Ooh, neat. I guess I copied the wrong example. I verified that this 
works too, so I can send a v5 for that.

Is it worth changing up the other cases of this pattern, mostly in 
pack-refs-tests.sh? E.g.,

	# Create 15 loose references.
	printf "create refs/heads/loose-%d HEAD\n" $(test_seq 15) >stdin &&
	git update-ref --stdin <stdin &&

[...]

	# Create 99 packed refs. This should cause the heuristic
	# to require more than the minimum amount of loose refs.
	test_seq 99 |
	while read i
	do
		printf "create refs/heads/packed-%d HEAD\n" $i || return 1
	done >stdin &&
	git update-ref --stdin <stdin &&

I can put together a patch for those.

-- Aaron
