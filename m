Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013060.outbound.protection.outlook.com [40.107.201.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E880B14F70
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 00:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767833769; cv=fail; b=PuH5uIN4IBH17vs9CYjoLuLUtbTJceksxKBeSNg73IiLOD8+xL56zJoOnNBsxPkWkCEPS1l1E0tQKjfMjQcV5Mq4B1GbXavML17H++dDcmz7ELzZPx5VkLYEF16VZHXXeooVffS9UnB0NyfnX5nfhck+weMq5ihlyL2NRDlWIQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767833769; c=relaxed/simple;
	bh=PNx0McYpFOxUFAOwzXtRMyKgC1cYKQzx6JXVHsbLZW8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YB1B4bM+KpXMR4e3/t4Zm5fr7AtFuxWurCqUAntgrVfDjIUtTOziV4+MSodao4JL77ryy76FDWlQ+ZBaYbjow3AcY8dc88bPvX452iY3/8mjCdx9ca5lNDyX2QEQUPSCcEWOAIvVhlmzwJbeq8tky0uT08Igb4/8zV3Voe2y9QA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g9s2bm4x; arc=fail smtp.client-ip=40.107.201.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g9s2bm4x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rwe1b2VVcUAsU99CRlbqdshLVZvphg0B2+gwJT/9/GZg8/cfuqkSxe03+9JcOk/Ikb6BVexaa8l6bMgcQM5/YzqhiVF0g8xrX089VMHMBCAbQWy4nWQ0Qu73xKPX5s4pzmGClcxl7AN0yMAqume4zyaL6KZAwG8Eoc4v40+Zs4EbN117ZTRxlKPJpS9mtObhojzhlhNVCp3kAiv/nJG5QssFTYiKTj3R783og+l1xROvNkx25SHrFxoNGO93Dyrp9muwPJH7J0pywrvO3qTv/kqjEZ3x1ziSeETk8w09BjXrOWuFMpl6QPjnFGLDULBarH7grhVqugWkCmWPyDkz9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNx0McYpFOxUFAOwzXtRMyKgC1cYKQzx6JXVHsbLZW8=;
 b=r1P+6EJvnYtGO7JUaV06f/tbVIRMzhtNB60mw1ShQQ5vi/Zvk/KQ60bT+jTBjFAeL3dalg1RC3+TD1Db0l1j9YgYk295acPotG5tHbcX+KIXf2ELGsim/ICO6ATWGRufiuR7j6jCX71pjelTUYCcpACKeeH7XuupKU1/BKczJDd9AQWtQXPUajsmcW84tLsrVwew97i/QuSnrA6Ph2pKbb3W2+Xll+YRYseSxP3rGUNhZRzZHorqPw+xDousgHxFJYU+AiVuj10IZkRdIeAyDGuwXv4DKvTn85HFCI30UR913SkomI3UOzEmN1tDBuNe3tufq1+NKcJtrQdZgYF9GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNx0McYpFOxUFAOwzXtRMyKgC1cYKQzx6JXVHsbLZW8=;
 b=g9s2bm4xWoWIhR3390jC68CTwIfbqfsWwaQ0QqHMo2QoTZtXNq+1reRk1VYS+aRrO1358bRBX5USoRuxRtrgN+s+scDaZpSgmKTC5II58Tm72uecqe2Bx7sPiFNaNh9ovN5io5OKEAyHgbhT+wchVQkE5lhXQYtG78VwDWmnQYhXDqrO982Q0bzzJmLAiT44Eop/QbFc7sj4vBWyV664vxhX8QhlU3g/EH53RmW5oWRsg8TXVXAZ64sdq45XdVPAOO5rApakzrD0+b7G8VUe2CgtrLOJ022nzxnHwaHIgbCrTJZx4L93YH69BbyKfUyPjavlifN96dW2oamBRxndUA==
Received: from CH3PR12MB9026.namprd12.prod.outlook.com (2603:10b6:610:125::15)
 by SA1PR12MB999085.namprd12.prod.outlook.com (2603:10b6:806:4a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 00:56:03 +0000
Received: from CH3PR12MB9026.namprd12.prod.outlook.com
 ([fe80::7e83:9747:5352:4af2]) by CH3PR12MB9026.namprd12.prod.outlook.com
 ([fe80::7e83:9747:5352:4af2%6]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 00:56:03 +0000
From: Martin Fick <mfick@nvidia.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Delta Islands without bitmaps?
Thread-Topic: Delta Islands without bitmaps?
Thread-Index: AQHcgDacB111zAh4+0KT9qD1+hIxMg==
Date: Thu, 8 Jan 2026 00:56:03 +0000
Message-ID:
 <CH3PR12MB90262C525E918BDE952987FFC285A@CH3PR12MB9026.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB9026:EE_|SA1PR12MB999085:EE_
x-ms-office365-filtering-correlation-id: b237d6f7-fde5-4f8e-72c5-08de4e50b27a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?+dEzXjZrB/n/LXvCkV6lKyH6VEG0iC3+oV23WmyKvt9QgS61bqa/YLey7n?=
 =?iso-8859-1?Q?bVJuhL4bAUymJfTfKEqa0ZEOfBOGhj2BG90bqmjaNmTAMoLLV2EwMyZCd5?=
 =?iso-8859-1?Q?bdRLk5nfKqnOHkNLC5iNWF11gukBhWl9hQxY73ZF++aRi7EM0Zv8Q7V4JW?=
 =?iso-8859-1?Q?RUbNmXDGSiJEv2vk5ZvQXraSeicQdWMYR5u5el3MmJnGzNoP4OEZF5LA1G?=
 =?iso-8859-1?Q?dKrfmgODpwFwKBlipKD456mkgAvN9WthVA9I4y6OlpJz2/GbGran4FcFqJ?=
 =?iso-8859-1?Q?A3LeEoJ418aOSq1a2W5js5i4uUaBag+6Qr23nxpSxxjcu7Bbj0jPOCCO64?=
 =?iso-8859-1?Q?r3jFr0EJ6Js/Gx3Ab7ntBh4ocwZgKeBnn9Ksc5B6Wyy31fa/ktSxJ8lOA0?=
 =?iso-8859-1?Q?7NTTYMl/CPAKWhMYnL5W9SERfDHrCcM7YGvkp7OoWGrBF/HP7atBgWcUKp?=
 =?iso-8859-1?Q?/yAJe0HC8s7OFYcH0ZSUhv0oyZqrChlPCBR+03FAxpeGqyrO5Iu7O77E2d?=
 =?iso-8859-1?Q?CyzX/GVm7AkusDGGmG5WyrGICfuEZFcT4iFlIWsQHsRmz3isEDZTXrH0b2?=
 =?iso-8859-1?Q?nZFA/Mj0t9PFE+p0ttbRIuftOuyH9TUsoUWiuWpHWE43HcYNN5/S/fDn2A?=
 =?iso-8859-1?Q?dniU7CR6hab6cH5p1bQIkKozltbhI42ezSW2P26mE0XrT847sHmuc5CDGR?=
 =?iso-8859-1?Q?V27TumDWOnI/omNCvIN7Z2/Mj5K/7nmHhoz3AMbRJfPf+cdDaSg7EkcB1m?=
 =?iso-8859-1?Q?+y0PN4qheNrrteBZVuROh6tkI/4TVAwcUTj4Ao1WAGO1eDvJmMGV2vcVnX?=
 =?iso-8859-1?Q?DN988+v3kdExdvF9RoapsVvoAc8Xlf+Is3Yr9sNtIf3wTuqJROAyCvkTqs?=
 =?iso-8859-1?Q?O/XTFOrBvGzVpz8QUjdaptZNB1gDZto4KnWM1ze83CGyHC4o4h4lPZwTaA?=
 =?iso-8859-1?Q?S8NqYOP8Qxt0SZlFj9TFyfwN7U0s31zzmrYiLmUazqUasAFiNhbZRTl4tm?=
 =?iso-8859-1?Q?2xtNertLR6H9wCI8dCsAyhxzX0Anxnu7M4MqRUZLL/WB0QD4KPHtq3XjxI?=
 =?iso-8859-1?Q?PjFQkqJfWxn5K3b381+kympDXI4W21xrJyoCuH7L9rdCObI77c2oZEa37y?=
 =?iso-8859-1?Q?cDNHVXtuwbYheVfaPx3PNIUs+AlU0EjV00V2CLz29/QWGLz7cnmMWyxa4d?=
 =?iso-8859-1?Q?1rk2Y1vn6NsjT0dDZEaJs/smlt68/flAgABkyYxU+zi5YDhJAupm2KHrfw?=
 =?iso-8859-1?Q?J6h9rmpSu2Q6PFSKZ4XaxfeE3/Is0A/lz8TaYgnqukiVB64F7/xHZY/ZjU?=
 =?iso-8859-1?Q?TzutWzn3aikKDL8PrLMsl+WX135pzcf3EckGnJuncQztBJlCak6xjy0jdd?=
 =?iso-8859-1?Q?Hw+o2XkB4o/o/VZbbVOKfYhnWc6bLpGmIUQTjlfv8bjwUKP7ok+wCycZ41?=
 =?iso-8859-1?Q?ETs8ZgQnINTEV9+wm/75q6vCEcy1vlUOctWipJ4gPjPm64PNkCAmuMgqhh?=
 =?iso-8859-1?Q?fSN85YHBLKlk01S5nP27ZpJhjq19LtqgC93EQxpNTxZL25TASu1J8HHUmp?=
 =?iso-8859-1?Q?7VhyLeLEhHsGTlI+Uy35PUXXktrH?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9026.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ltDrMpBSRLterg9a4tUf7pQekPcZqkyOwQRpeZbUlwfuzBaGEjK8YALrZH?=
 =?iso-8859-1?Q?N8LWjiIb7tAVe6Bw97RJY2z24e8k3hZwFE7UUjkUZEopiMO8vekAztzIm2?=
 =?iso-8859-1?Q?RVm9l+lg+Z8sUvDV79kXzGETIhJQXtUr9eqK+3UoZzijFSabEfsflEidBP?=
 =?iso-8859-1?Q?aEIIxBoKJs7dNLF+7jMA7L8TGGG35eVBdufRbGduBZ9exxlfvb0s3BbODi?=
 =?iso-8859-1?Q?T5aYG/hWTAHFNzV3lZByuFjAhJF2DgrMUiDFyqhMhGNMLyDJ0eXPfDZHv1?=
 =?iso-8859-1?Q?5wu2PELVzhcwPdfgelrEPflZdhTiSespXEPz7SNOYTIzYOwyYtIYQ+nWwc?=
 =?iso-8859-1?Q?FQ/HoibyoL/Ixh4oG+ZA4SGEKRhsLB3fcqHZVvTdqWFS/xXMJy6WRDwOI1?=
 =?iso-8859-1?Q?qypSNytFWnVF1v2iVotS9tCB9MIxD1+MMKmkLuqDuMEFbqtp5WwsIYl4xT?=
 =?iso-8859-1?Q?6kl9g8FtlcELWJn6mjZLm+HoSfhipnoIIkpZ1edDyEkJ4p51jrxwcJFMbj?=
 =?iso-8859-1?Q?+W7fw6em0QmgMl1AGcco8A6TRYPom17efMZL7s4ELFCEYjCoPqekfKN+G+?=
 =?iso-8859-1?Q?aH/zRWISYKV6QDN8veQC2wcJMmsYWQ9lh6xZRNlbXJEzERqlPWwBw5TrEK?=
 =?iso-8859-1?Q?aO5/VY5VgY3a29BIHLMzp44VMZ34X8Ro+hY3iN92PjOLIKSFjOrdcObdj1?=
 =?iso-8859-1?Q?el8sDIrMySXVcRtwx3bndKTUz62RzehHhD6tq7SbNgNOkKBwdsuGp6bQ3j?=
 =?iso-8859-1?Q?pjp7Gkcw9eL+pQi4K2MEyBArqk38Ymasuv8FDoRnLkQoyFcZ2JWBJcKw9j?=
 =?iso-8859-1?Q?SOrh+hZOeb545JuQvmpgMC5bBWdJzfPeZT4s+1EWfZcZN0ybR+1ZeWsDsR?=
 =?iso-8859-1?Q?HhfKZDvEL1U2TI9AkEzHLEXIn3fPII0trwMRNbFwEa1zCd1QJkW7BYxt7m?=
 =?iso-8859-1?Q?FsKIAAX8Os3yPu6pQTiBjUsXSRT/+z+ouf550qbyGv5wfGFAZpIyfT3Qnd?=
 =?iso-8859-1?Q?61n42EPCK5dBZD43U+dfAR0Lel1pavytuMZR2Mr5DvjtwDJ8LQLiGyl8Rx?=
 =?iso-8859-1?Q?3rBn0UkIc6vaERk9M4D7xFRIVApDcYi41M6tXhj/PpgmA0rTrlvBQu03bV?=
 =?iso-8859-1?Q?xu4ukgX7iyizbFdwshNUKKHQMniLauUY/kn5M70Hx+Ozw6tiJ8qEYML81C?=
 =?iso-8859-1?Q?xYVKbIyKFdcIs3YP9KX3usQh6nHPyqQyDo/vbbOphBjfByMRWapPQBUVZL?=
 =?iso-8859-1?Q?0Ot6w8hoUdYr6IZ24m50Kr5Qdxwj09qSYdrZETkwS6a7kucO7KZMa2pIdK?=
 =?iso-8859-1?Q?/G/wdrHTtDZONi75sTZmtI32PHnGB2wp1hwheB16qutlADPMJ4X41gd1z9?=
 =?iso-8859-1?Q?cGa9CUmoY8h4f5OIaJIc0W0QNjrYf3IwRW6OpTZzzcQuCHHBsOOnpFKs13?=
 =?iso-8859-1?Q?8En0Bwu4ipxEZOmXDrmrEmaZ9TWb6jVHtdYHhaom0kYmOmp+j21wxHhplm?=
 =?iso-8859-1?Q?Xc28+uiFzphJafdqviG9LBeDxHm3lWPSpQJa0x7oX9WiLd75OaQb1N8leq?=
 =?iso-8859-1?Q?20mq+CQ8wQk+zES9vg7KXd05OFuksdRSxSRFRVtwqvg1TJs+8BisLthIKA?=
 =?iso-8859-1?Q?2U3vqvJsSAs2xZx9aKcWi0Qvikql/A0OIRfs5J0Acub7et/IE2jFmL8Noh?=
 =?iso-8859-1?Q?rbfRj98aQ/GbbD7OUIWfp6414cHUj8CDzPKKag1QAJ/NkKtlYz7dps5NJI?=
 =?iso-8859-1?Q?CkluTOj8QjWh5BEnXAaCuznHCDDQAxD+LLhU7S+SLgc+Ni?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9026.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b237d6f7-fde5-4f8e-72c5-08de4e50b27a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 00:56:03.1784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dPkwUSuNPLAAd/1g/Ut7fpcNDJ0QyFZQrn/Sn91xAKUqthCTJoWxoFAg0pPZMGxZ0QpMABRNhmuT/ZgPTX6nfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999085

I am having a hard time trying to get delta islands to work as I expect.=0A=
I would like to treat each head as an island of its own, but I do not=0A=
seem able to do this. From reading the code, I believe that I am not=0A=
able to make this work because the feature ignores objects which =0A=
are not covered by bitmaps and refuses to put them in their own =0A=
island? I don't see anything in the docs hinting at this, so I wanted to =
=0A=
confirm whether my reading of the code was accurate, and to maybe =0A=
get some clarification as to why this was done? =0A=
=0A=
Perhaps this would work if I could force every head to have an =0A=
associated bitmap, but there doesn't seem to be a way to do this?=0A=
Is there some other way I can force all heads to be in their own =0A=
individual island?=0A=
=0A=
Thanks,=0A=
=0A=
-Martin=
