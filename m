Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF38C249EB
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 09:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709889206; cv=fail; b=Lya1ajn0xOK2utPtk21+8h35ocK4PAOwGaQX0JAMRn7S/uTqx74ylVIFFeQOYcqYIMYV7e/T1nkIYuEiZiXM14HpNNCHWU2MWplGGSZWsxbKAuPKwsCobyJu8eGnfQDdg9+/XJro7r2DmSDgwdXbT+XWzcu344AStE/bt2t6Vb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709889206; c=relaxed/simple;
	bh=R7LxZFC7EEJq2cB4K9v6Wau2GDvPstd/hV/nLrxXZ8A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gu2DGUM8EeQ4K6yQ1KFOPnGhCTy+NM4m03iTrjPAHj9N0dfB5fvpgch12xdaouzNkrSeJs5tkbAOyOWJSh9CiphcwgIafelXDEX4JQ3VE13OPgMzuLJx14zLBA+QSLkoignU0OXnriD4O3nNTQb6bX/WaYPhv6umilrale0Z3sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=EJ6OQ0Un; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=goHn66yL; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="EJ6OQ0Un";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="goHn66yL"
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42879VE8027209;
	Fri, 8 Mar 2024 01:13:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	proofpoint20171006; bh=fE2lvGGQg9z/vkZ7YCBIc2AjMZM5dMgnZ0QQ/d/h6
	Jc=; b=EJ6OQ0UnQ8k+5QHPbCFArwpLnzZ6aZ7Raez8vLzK1ta0f+BcNGMCfYszS
	168z1rSZvhdJbjoNLXKI5/16tH0pU+O/OAvu77EJ9fymgmHRTL1SgjEE5qawGUav
	jvexBtMd8pdj3u1YegHa5nZbv+canMN3TQaJ8he0/97CYqqGIMa7dLjV7ogjQf9R
	kB5FeganbArLKRl6KrlwO2FV+VDo1q5a2Cyo79RHSrjw7Lk+3+t+kg9OBKypJL8L
	JyQuul93czxLBF4V31BW7uiDtS+EUO+TjOTnmvuA/zjZNqPieCmb15ZQGIkQwAZA
	rzHQDohFqJESA9jvbF3inmCVRyGyg==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wm42hmwuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 01:13:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clPUFLGXHISDfMkBkZKnuzcO5ip9y0D3OCwR0iKN2GRqXxb66YTZ6ns3SS8i0c0v+P088FWXCsaP8vJ8mBT1PsWfoyPD4/rlGHIZ7yUfD5gFN8+lK8oCq+4uD1LDuoXrkcjgSsoSkKZeyTHvE/1qIVQBzIllrpTX3LBANW6haQZrJJg1FqOUydA52z3niLo27ACOOuSwvyuJL1G9gmChK3Z4UlniasY/xPXXynSLLZBwT7cvz3ufCyDLIDjyuaF+Yksk5slT11MZCgod5RkpPM/O1WhH0uhFopJpxRu75crYnZ5taRo/X7lSCauR+cMdTIzJ1veSOn75K5WQHZt/ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fE2lvGGQg9z/vkZ7YCBIc2AjMZM5dMgnZ0QQ/d/h6Jc=;
 b=ZgHLtiFbgvhi09lqWLIU4Dhk64u9s+Lqh+CaDTGKsaN7ldYCFoNu/lTWmda1IRivbCpSMFo6Yz8aqERFBj9vGp2Bd+zO6HeT4PdA32CHDDHEIxVOkk9JXTOhWH6hgvZvvHVDkfZJdA0wKDrYvQ3Y5b149aU07eRgSbX+C3f9puuQ3vAUF6xGa/aRT05tyCN1cnnQw/epUIaGvbDltIKnbB7KmvyCE10aGSAGhLU4RWaFKVfcnDrDPaW6TdQzodR/OidKQ4FRia+kvfPjUyBHUA8Hy1A71pp1FAZd/sH/32MHF2sL10qxNgvDGT/+AAfO8XyxXBnWT9yVfsb/i4Zp+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fE2lvGGQg9z/vkZ7YCBIc2AjMZM5dMgnZ0QQ/d/h6Jc=;
 b=goHn66yLnT2FYFv11SfOa8PY0pJELsltx4cLhMxH2UOAL1TCWPNWQB2lX7PmA46wbyv6h58OBFW2qi/FrPiT4PvsPBr9Wzsq7Tv9KzkKFXqwWUBlnzwywTuhDQ83E0UBwCos0nUduoJTrSju+AqwCpqm+WDcsAkPyzNGxKHmZhTZd+hw0W20Kzcdu3YNJPfKErsPrB5pTf3otx5B3AEVu9szpoipkMB+D167VgnTh+8aAJLfMw5KxvJTzzs6JHTjr/5OKkACY2IKqT9DImy+VZbbiXjA+wX8Zwn2zElKBFSd93/W9/Vukrmy/L65oZX2Xb6iEa9Vr5Ja1Bfqzipuyg==
Received: from BL3PR02MB8217.namprd02.prod.outlook.com (2603:10b6:208:33b::20)
 by PH0PR02MB7831.namprd02.prod.outlook.com (2603:10b6:510:55::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Fri, 8 Mar
 2024 09:13:15 +0000
Received: from BL3PR02MB8217.namprd02.prod.outlook.com
 ([fe80::8c3a:4141:fb11:c684]) by BL3PR02MB8217.namprd02.prod.outlook.com
 ([fe80::8c3a:4141:fb11:c684%7]) with mapi id 15.20.7362.029; Fri, 8 Mar 2024
 09:13:15 +0000
Message-ID: <d280a87b-e6ab-4f0d-b112-bbedc223c9fd@nutanix.com>
Date: Fri, 8 Mar 2024 09:13:12 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wt-status: Don't find scissors line beyond buf len
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jonathan Davies <jonathan.davies@nutanix.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Denton Liu <liu.denton@gmail.com>
References: <20240307183743.219951-1-flosch@nutanix.com>
 <xmqqsf11ltrt.fsf@gitster.g>
From: Florian Schmidt <flosch@nutanix.com>
In-Reply-To: <xmqqsf11ltrt.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0097.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::14) To BL3PR02MB8217.namprd02.prod.outlook.com
 (2603:10b6:208:33b::20)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR02MB8217:EE_|PH0PR02MB7831:EE_
X-MS-Office365-Filtering-Correlation-Id: 111d22d4-7339-4ccb-b658-08dc3f4ffc6f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5jj4riyR3XIpJq7P2szpdc8VcU7kbqxaWAVgBcj9OFMK87NRh+zAEmM6POy8V1tzOPgB4lgyfsQDB/SRg43EXFCQNFO4wUTSIQ7qbrY/NeVKlVf0LBqgbm2PjA6yBbxKm/jI0FBNZYd9LVjpfs9eg8qOwzpArVVgruypREV54KkpRlhOs4OfoHKdx7/BKUXEmlURk91OQRxsZnCX0AP0aAmu6WHYxLzsFEuea87AkWbZ6RQBiSiVq7ED2zhH5xARq09YO0GJ26IyR/BnId9G0PwmBnlPXvzKwn/ngObtKqxoZuuIiNImm12QjWipfYWHxy590pSg5jie0H6I2ubWLdadyUGF4lwIAa7mmcBIhRijbbIc9Iix9DMDYee/mf8uoIjtLQ/QbfOrUMspzTQH5P8Gnwn5/ueSqYroH/cvwBOasfq8dubYB0l3SOnakeZEI1GMqYLYbUat0Eaq5iYKNt4H6mph+06F/x7I2Nqe6Ze7Z7YDgrU6hNjPXq5Z/C4mY14UdcJJpOqsDruaX/4UlCSRH8PS4G7VpxcRmvMkUJHmU/oXhCZGm1CpxaaZ3b7d58S2UVKCjWMxSk5vUzIFIKCNVLr4VsWDfryj7PqO+BoDCH2clz+R+TfJ6n15KVmELSa95xUzWZjx/c+Iv7B9kTFDKH+Pi87V0HglqbTQURw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR02MB8217.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UFJrL3NQT0dhTmd4YzFNWmpENSt5aXIyQlppaFE0UWRza0dDS0pBVnlSeGl0?=
 =?utf-8?B?VE9oSlBGcVEzcktjMDQydjkveGFLTDBZUkFOdm4rKzFBdDVZbGQ3alI3NS96?=
 =?utf-8?B?QzV4L1l6bnh1MkVmQ1piT3hkZ2ZKOVA0V1RJcVJkeU56R3lGOHNOUjFvc2V5?=
 =?utf-8?B?TCtpRkREaG9pdlMxNHpPMmprb2daUjdqRlE3bEhnQ3FLVU9yTVBmTU5KNlJU?=
 =?utf-8?B?MGxHemJ6a05pT050VVhuSlVMVHZXWTdIdzdjSzdVWGhKeXVzV245TWltSEFD?=
 =?utf-8?B?WjBlcEJPWVd0YW1KUjc3MW1oNTVDRGx4RGcvWXAwczlkdERTMTYvRXhENlJ1?=
 =?utf-8?B?TXdVT3YvT25XWjBVVGNtcnNwSVRkaDZGZ1VDSk53aGlGYnM3bEF5b2dSVGpV?=
 =?utf-8?B?ZUVRTmpXangrRVNDeFFEY2lReGRBeTFCRDhBbmRyMmdBczRYQXpydDFReklr?=
 =?utf-8?B?NVVJRnU0dW9wTHl0djRnNTd5cGlkQURtdndCeExCT3hwWFV5V3YrR0FXcEhy?=
 =?utf-8?B?cmZCYlJFSitHb2pyRnlJL3Z2VTNFRHBCSW94enZoZXNlUjRuSEhxSEpmTkxQ?=
 =?utf-8?B?THViQ0FDcTJWZWx1ZjdtZ2F0RjhJeHdLQkQyZGpvdzNsRSttQzgzS1hwbDYw?=
 =?utf-8?B?MXNuT3J1VVdvOTVHb1Z0S3duRUZuUkpBSVhYdVhYTHA3V2tFbkFmb2FqQXBC?=
 =?utf-8?B?KzVIOVkvTHRteWh5TkFIcm5xbXVDYStzTzhXMUxFOG80UUltR0FFVzBHR0F4?=
 =?utf-8?B?eWxNeEwxU0pTVDZMS3ZSQWcwdS91RHVGbklNUlJTWlhZU1dkRnRkYTE0eDhP?=
 =?utf-8?B?eUlabitleUFyeHIzUXN5eWsyZ1hlT2txcWNCS0p0dHNhZEN5MFpQajlOWnRB?=
 =?utf-8?B?T2pMcjNTZUtFTnBxbmJrbVRrQjkwT0JBcXR5Q0t3amFwc2hMSXZhNG5XQ1Zx?=
 =?utf-8?B?c05TWXBTaDhyY2RFQk05aTNIemQxOTNBRzlFTmZXb2RORDJaZkRCNWJUOEVG?=
 =?utf-8?B?cit4QXd3b0Z3c3pkR0ZsNmE5WTdmcU1MZllKMW1HcDFjWk5xTXdXMm04SGxU?=
 =?utf-8?B?QjBCMGkxbDFYNkRaSTF6NlAvNDZoMXQ4MHowTFEvMnIxSmg0eG9aMUxrL1dr?=
 =?utf-8?B?MHR4YXA3TW51eG9MTTE5U2pQTG5lMFlZbWJGWmJMMWNRUjFDMzI3TkVNSFJp?=
 =?utf-8?B?RjRLejRCSUE0WjYrQ3dMUjZDSWx4c2l6VW1uNGp3WkhYc0VsWnBSSTJTZzV4?=
 =?utf-8?B?aUlKU3l3eFc4RkR1MUVqd0liRVZmaXJVdnNQSEMrcWxiMCtjZGgxbVVVSlBF?=
 =?utf-8?B?UWxBT3FJVWRWYWgxK0tOZG5zWlFoRVErY1lJYWZGdHJkOTVwN081d2pha3dk?=
 =?utf-8?B?S0RJMjVEL3dVMUhPS000STNBOTk0ZXJDQXA1bHV3WWRYV3JVN3pDMVo4Z3p0?=
 =?utf-8?B?K3RMdVI3OHFFV2dob3A3YVBZQWVhRTVSZWZRUWZ0djFES2FrVVdHOTFiVkdj?=
 =?utf-8?B?RS83SG5FSm5YSS9wTjhlU2Zmc29PZFlZMExwTTZtSDZKN21aRTc2SG5rM0hU?=
 =?utf-8?B?QWNPWENIUFIzeFlGMkxLUEYvS0xXc003cjl1ZUd4SkpkWlRhTkFpOThIZTA0?=
 =?utf-8?B?UnFWbGM2MTVQK2JsdGdkRlNudkpVUVY2aTdUMnVuUDkySTFjOWdKQlBFSzUx?=
 =?utf-8?B?bG1DY2VIRzZYcCtsOXkycU81QjRydFVGYnpvalBPcFNrTXptamd1ZzVzdGtZ?=
 =?utf-8?B?U3lwVGgySXZmOC9MbnJrY1RkeUpZVjZBVnBWTVREcE5tOFduUzVDQ2dwRU16?=
 =?utf-8?B?RWpTS3RhREtDWFZTU0dEbENxQjRxOWxiM2d2M0JJZWIyQzBISlp5bk85M3hD?=
 =?utf-8?B?bVRNc0E1UmZHZzd1MU5ySDRmU3RZY3lUQjZsVEFrdXhhQmRQMXFmbUR3VnZK?=
 =?utf-8?B?Kys4VjFid0pJRFhEdC9STXJSc0Q4SUw2WGN0MSs2WVJXM3NUTVowaU9mMFM1?=
 =?utf-8?B?dkxMajY4YzJESEk5UFJCdkhwMmtRWlFRUFZWWlZ3R0tVOGdsdFdvQWJReEZX?=
 =?utf-8?B?aHFIVXRQS2NXdkwrSitwMlhuVDA2WnpvbXc2YTh6SWt1YjZuZmQ4SFNCOFk5?=
 =?utf-8?B?TVNWajZzZUJXYy9BdXB3eW9LTTJLTThCTGY4cFloWXdnT3RQbzBReUVTY0xy?=
 =?utf-8?B?RUE9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 111d22d4-7339-4ccb-b658-08dc3f4ffc6f
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB8217.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 09:13:15.1713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13YnzuUrzrHZYrBxyqdC8Pqqn5sEuTOjqkba7UV19glEfpsrUGoECgIcQWGVSBePd/IRVTUqZdxcUuEkYR8ZnJSFQfMDcZMp3hVP17Dv0pY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7831
X-Proofpoint-ORIG-GUID: iSAupIRlZULYUu9-8K-CBhZbnqr2W8cR
X-Proofpoint-GUID: iSAupIRlZULYUu9-8K-CBhZbnqr2W8cR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_06,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe

On 07/03/2024 19:35, Junio C Hamano wrote:
> Florian Schmidt <flosch@nutanix.com> writes:
> 
>> Side remark: Since strstr() doesn't consider len, and will always search
>> up to a null byte, I now wonder whether it would be safer to create a
>> new strbuf that only contains the len bytes we want to operate on.
> 
> That is a valid concern in general, but does not seem to apply to
> the current codebase.  Thanks for being careful.

Thanks, that confirms my cursory look at the consumers of the function. 
If you think that it's unlikely that in the future, a new user of this 
function would provide a non-terminated string, then there is no need 
for action. I guess the aim is to use strbufs wherever suitable in the 
first place, anyway, and those won't have this issue?

Cheers,
flosch
