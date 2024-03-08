Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA1452F79
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 09:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709888951; cv=fail; b=Kx8OWgRF0/PXKCleqx7bTWbAHcAlQwN4PLcDwG139rcpZw4kZE72gIfzQhZPzBSJAjhfsIrUtpd+7vT6BXiM7L48yUVJhvnPQ5UMz+ejN2XUqzD/Y6lpvVy+G1n/dUFuL0yR/PkJ1TpPfrhDZ8hAm5sZXWvL2MFRkFkxMJ96mQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709888951; c=relaxed/simple;
	bh=swiIdD8VlVkkLFp9Q6PkO6c50FvdfPnn/46/IJk8TQg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XVfXmuWkdtsk25D6nNZn+lm4EAj+NxhB+nQiEIMUgDrJQfUWK0XP2Dhk6xW+qypbwHRy4P+bkolvAoGs7ZP8ksw/UckLHsbhM8e7BZQDIBJETNINNykMT+bJWEsFdA3cXDccMxYYWiZjAbza6g6mMsMOMu3Pc1r1vnG5rxErEEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=2S5IkSus; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=ormqwfvk; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="2S5IkSus";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="ormqwfvk"
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4287jemE031057;
	Fri, 8 Mar 2024 01:08:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	proofpoint20171006; bh=SHo7JATsk5f/Bx+CjhCRFw/bmAApeJFPhULWfp1e/
	a8=; b=2S5IkSusOQz1MpkqKZ8Yu0V1q8U148bk+lWSLq1Y9oC5pMsyF/LuV8n3Q
	KjBLE8ntjTZ4S3nj26MTdakaRo01B6TdIPyKiOBZDIpFasKTLTDdHzWBVEaya45Y
	A8Biyjy8kXgcdyKAEzyWwxmsUKze1i+EkUgM4Rlld1oWVKPjm0kuA3ozCKauUoEa
	R7VLbRQj+/rEmnyNPtCfaXbpYNUrMTicJ9IKPUEm4jfZRTZSYKi1zeWcABaBYCqs
	tMbLIK8gTTqzF1yDyezVlRpwpYGrQaFDPZjOSsOgdi2Tm1+VAbXexpBLw6hnSq/W
	SgUyIKvKb2RKWFMvVKJEiUVS7WFuw==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wm42hmwp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 01:08:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAEgPH9537bHM1+WtP2iYqH3zvXLkyHN7yTdfRYnZhmPWfKz8iLjYtWdXyoyyYkX/iWr+AOeRrtONntkIS60GVzLxRFc9W4ra1LCgvPJYqpGNWtGb7hJPTF1RAg5AaVPAZn5R5ja93YJxncGzw16Ta0i9T/CfrLuMiTFX/ZiEplprbUmW3Pbjfbgayri6OB4oZ9Jfe7WPJyuFY2nlfq6F2NbgNmb2idZa2mIhrlqwhPzCgDXUU30ZGnvPwN05dIPX3mgS7EABZSAYsVsEuT0fiYB8je7JZTYDUzIEIN8HHqLva4UeLa7swMdTnCtg833d7E/l3vw0otfw8uQzHQZkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHo7JATsk5f/Bx+CjhCRFw/bmAApeJFPhULWfp1e/a8=;
 b=MKqcQxALpLWWxPZGstNjNN4Bc7kixe/0ynJAu641m+ohD6zmTQYbsKnmTVV9QKW+yEymWBhZlOTcCAjnTCriYj3i2RFxYWEYdRI11YfUf6N+6FdVds9LVOYNSbEGVcKmU36yMbK91Iu/hlXxRQJw62udBwN0/W2m24ffYA9ucv8ri0vD6Df1+bnkC4XumWSZIUfbENTZEPBHCfTavu/NCO5/4G2Vpi2Yf9YvE1rk81w2yNkUFH31AZY42UyZoIgizQWPN8JjvAjescE3Hn18T6d6A+bXWkHxAv3xz23TBOvzQO7zuA+VWrq+mwrc8YXrV5g15xf31+oL9wJ1E39rhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHo7JATsk5f/Bx+CjhCRFw/bmAApeJFPhULWfp1e/a8=;
 b=ormqwfvkhzTFFH7XQMBy3NVPjGEwHn4j4gNyas3ninWQREpzGsGhJbxo5xln5847neocTR1AUQVjx5w1oFQe0Bs/ZFhjNbasBPsUGlRrMYOdrKjYO1BOAh6RBy3+dNc42GgSpUlPTSxRJRFtSxkFl6JGlguFC4Gb46HB6NFbyB66mYOr9vyXdxq5c2SknZ0cz/BisdS5+nKMjHEEf1Hro9ksDXHFqst+7tXYXmjiGkbc9X88a/QYWTVGVE5wXpRxmSC8jxaix59Itikk+WoBPOhb+F6Ef4OabvnC9f8M8iDrI8Rw/exEW5NZH+y5RTkL3NWulYRfvSwpLwOod+/MnA==
Received: from BL3PR02MB8217.namprd02.prod.outlook.com (2603:10b6:208:33b::20)
 by PH0PR02MB7831.namprd02.prod.outlook.com (2603:10b6:510:55::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Fri, 8 Mar
 2024 09:08:54 +0000
Received: from BL3PR02MB8217.namprd02.prod.outlook.com
 ([fe80::8c3a:4141:fb11:c684]) by BL3PR02MB8217.namprd02.prod.outlook.com
 ([fe80::8c3a:4141:fb11:c684%7]) with mapi id 15.20.7362.029; Fri, 8 Mar 2024
 09:08:53 +0000
Message-ID: <1ff36e64-b993-4cbb-ba0a-01aca5396ef6@nutanix.com>
Date: Fri, 8 Mar 2024 09:08:50 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wt-status: Don't find scissors line beyond buf len
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jonathan Davies <jonathan.davies@nutanix.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Denton Liu
 <liu.denton@gmail.com>, Linus Arver <linusa@google.com>
References: <20240307183743.219951-1-flosch@nutanix.com>
 <xmqq34t1n91w.fsf@gitster.g>
From: Florian Schmidt <flosch@nutanix.com>
In-Reply-To: <xmqq34t1n91w.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR09CA0014.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::17) To BL3PR02MB8217.namprd02.prod.outlook.com
 (2603:10b6:208:33b::20)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR02MB8217:EE_|PH0PR02MB7831:EE_
X-MS-Office365-Filtering-Correlation-Id: a7598d31-6513-4b8a-eddc-08dc3f4f608a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dJFcl5ZI+AFbufPG7oAhs0w4HyDYrsPNSK45s44GuXlhI3ezZEcYN5wwgmtQvm/Qgl0/EcfGqdCPWsn/9YHC+4MuKY27zYT62pYGgxPuqUP1x5Hsz25SIuS87Jn/LHnFOGZLff8qdbbaG5r04BWfMNcJ1K9UL5YVtjkfIQC2Lx4YcYQz4Vo0QBA+RRcKQc92T0T9X5k1Dhq8YYXLNkNVKWhzK/gN8OPw75/AjMg+Svhj03CBePFKj4h+CcldL/lpXEVaCrf47Vl/NidDLnfxOEKmskWyqGDUeBiLqJ9gQTzl+6DWOsNu9T1t/dh3TDNTRyTV0d0nXMF2LopyeU+5/qBquN2VtZISP7oH7aEcpQg84mPsi0B8QCkNqh3bjrttNAmnWZbCujNIce/UA+qm6dF1JkukJm+FWCq/iow7qVJw+MLv+wZab7P0khoaeGLVaIX5x7bUX2ONyLkNPZF14gBTs86Oc3Hw9PEF0DucXQsIXk+o2ElRNrY2IieISvKYVY5CgM4E771HbPWCvx+SGTBD0o/+potys+F4tQXabi3v/wx5y28GO9mal/SX2G4aKgnHnYqgZjBeHHyWS09i0tEuL7FzAYV97aKRgjLMZkni4DXIhtAqjHRXv04trS6s1aS18pbFU8njrU9Z9fmazAAkkXHYQRvawADl8pCmjUo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR02MB8217.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UVN0VjJzNlVpZnZVWDBSNFN4UG03aE9RUGtid284M0pnR01CZUk5ZndxNi9B?=
 =?utf-8?B?THIvQkdZaDRhUzNVNlBFWGhOa3JtUjhoMkV1WlpaTnJTUXlIWWFQWTlxbjZD?=
 =?utf-8?B?ckR6OTFEMHdkeUVGaXpCZDJJcEpiQkdjTitTV2E5dE5FenNkTE5XYlJIRStD?=
 =?utf-8?B?Mi9Ea3FNZjVSYkJhVkFGaDl6cmlhZFZIU3B6NlF0TlU4KzVwdlF5NjNTNXBq?=
 =?utf-8?B?ZWhRU3BBdUZqL3Z3RStNNWlIYjNMQW5ROXJhM2IvTFBxTkdxZktNcWgwRVZm?=
 =?utf-8?B?Vys1UW0xSEVXcDVOOXNlOWxhaTd3N1cwKzBJTkRobFY5SGxDRE9yOHQ0SFk5?=
 =?utf-8?B?YWRTUzRUTG8xU2drdFBMN0RySWFmZ2E5Z3hQbTZVSVNDaFIwak1SQVhnWVVv?=
 =?utf-8?B?KzIwMHQzL2hGRTJ2OEZ0ZHlXbytHWWtXYlRpZ054THYvQmNDRTVJTWJIM0dL?=
 =?utf-8?B?SWU5RlhIM0dONGhzQUlDNTBUdlpmZ3lnVGszem9BSndNUWZHZDEyUVd1Tm5q?=
 =?utf-8?B?SGxxUmN2Z0c2S1NxOEduVVJNR3JIRkg3RGhrempHWU1iYy9GVFpMekE0K0hB?=
 =?utf-8?B?bEN6VG4xRWIvYUIyZUQreGdRUjR3dFFobFJyeExPaDNpSnliN213NlVLeXJr?=
 =?utf-8?B?bE5pWVRJdmxrdkcrbnBzSFZjN0kyQ2xMWEFneGlpWFB4ejFqS3Bqa2xPWXFV?=
 =?utf-8?B?a0JwZUZQdTVrbGU4aE96UGg3ZENTUTVXRHVFTUZJcWVkZUNheUlmWWVsM3A0?=
 =?utf-8?B?OXQ3YW50ZTI3OHJFYnJzTEZIamFITjc0cjBqYTF3R2Vyd0hpRlBxb203bTR4?=
 =?utf-8?B?dFVLeGtlTjhOUlEvaWZPQWJMZUg5NkVleW1PUnlFemp4YitaMWZNbkZoTWdQ?=
 =?utf-8?B?TFNJL0w0RnNCYmFsUHVBYjhtMXBVZkY4dm9lNWVSTUpaNzBNN3dXcnhmOERl?=
 =?utf-8?B?NFBwTllaN2o4d2k0NFdrQXVnRi8rMjlhWkVtdjVzVms5eTNmd3JiR0R2TjVr?=
 =?utf-8?B?UzhNdU9OVnpsb21uRDRFNGIyY05oMGRMR0wrOW1DdE5nK1hLdVJKSE8yZGlS?=
 =?utf-8?B?TWxFM1plL0U0UGR3cGkzMFpvV0ltemxtTmVsYUMwR2gzQStOMjZyaVhuYW1h?=
 =?utf-8?B?RFZuNnN4cGtWUTRnZjFTZWwwMC9SMVFaekVSSlltVHIyYnFDOHZGMkJRTU45?=
 =?utf-8?B?SDFORnlzUnlDeXhtOWJad0h0OS9acndYbVliR1F5Z2JjbnBUNHBIbERDQ0VU?=
 =?utf-8?B?bTZCRU9sTUxrS3cyWG1ndXJCbkNsVEtiZDZzTU9FaytqVXhuMzNVWmNzWXNw?=
 =?utf-8?B?NjJvVDdPa0NiYzNjRHN3ME03SlZqQTQ5ekJRZmlOd3pJUVcyemxWRUVjcSsy?=
 =?utf-8?B?cnpobjF4Tm5zVFRZdHlydTgyZUpSNVJEVDdwaEFDUDBpT2JlOTRFTEFLUlFp?=
 =?utf-8?B?amxhT2h2R2VMKzFobjRiTm9wWEd5WlNaa1l3c0FIS1lUbHNoVEE0eFB3V0xn?=
 =?utf-8?B?cUlQUGJUVVQ5UlhFdStnMGgrMy9VZkFXeHhOOFkwYUlhdjBWYXhFKytMQ1ZR?=
 =?utf-8?B?dnMxV3JEV3VOUTQwOXlGVDFIeDFpeTFNUEZzRk82ZElRQUQ5RU1aOEpYVHYw?=
 =?utf-8?B?YzltUUp3QXNPK1RVSm8yeGhMUmpybkJQQm5YNVU3Nk80YVl6WUpzcit3bFdU?=
 =?utf-8?B?WUVPMWFaZVVZaVQzaGp6ZHZkR25ZTUJOcXc4SXpXSjVRblMvNVJDdkQyYzhy?=
 =?utf-8?B?d1ZlYzdiYnNkRW41QXN4OWd5RHFlQkY2aXZFVkhwZG9lSFhKWnlrcEkrbnJ1?=
 =?utf-8?B?OEZLU3pNMHdDUGdRQ05YU3pHT2xKamMrckwrN2phV0VtOXhKd3piL1FuVS9Z?=
 =?utf-8?B?VlZGVDZnZkpaUklNVERIaWNRN1JubnkzdkFHTyt1cm5qNEN0WFZGWEx3azdy?=
 =?utf-8?B?NUhPSUZpRTNkZXlPeHllQ2F5WG9veGd6U3p2M1JDYnNIL3J2aEN6Y1JzNXg4?=
 =?utf-8?B?NUI3YWREc1hXcjVWTVBHSCsxUmZJSWF1RkR3ZjJucFk1LzJHeTlpUjZRaFpn?=
 =?utf-8?B?eW43VmN6a2FrVU03WGIyeG9TWjFlVTIycXJJbjhHcDZDSjYwb2JUUVJFR3pu?=
 =?utf-8?B?WWgybDU0NWFVVkU3T2IrTzhoYjB6Njd3L3pWejBxamJhTmJ0N3hYSEFjeFhk?=
 =?utf-8?B?dGc9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7598d31-6513-4b8a-eddc-08dc3f4f608a
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB8217.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 09:08:53.6265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x6Ue3G6B9LgF9OY03SOqgWQuIltlLxvoVxpkC0K4+Wal989R75xNYEC9nq3Eu97sPV8T/aU2TuX812zTj0Pzqdj/cdf61dWeAHP1iuqzJEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7831
X-Proofpoint-ORIG-GUID: wf-oSVOnLoLC_PzyW6aBh5dPWzbQRAsp
X-Proofpoint-GUID: wf-oSVOnLoLC_PzyW6aBh5dPWzbQRAsp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_06,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe

That's a quick review cycle, thanks!

On 07/03/2024 19:20, Junio C Hamano wrote:
> You do not have to say "Currently, if"; just "If" is sufficient.
> Cf. Documentation/SubmittingPatches[[present-tense]]

ack

> Looks correct, but we probably can make the fix a lot more isolated
> into a single block, like the attached patch.  How does this look?
> 
>   wt-status.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git c/wt-status.c w/wt-status.c
> index b5a29083df..511f37cfe0 100644
> --- c/wt-status.c
> +++ w/wt-status.c
> @@ -1093,8 +1093,11 @@ size_t wt_status_locate_end(const char *s, size_t len)
>   	strbuf_addf(&pattern, "\n%c %s", comment_line_char, cut_line);
>   	if (starts_with(s, pattern.buf + 1))
>   		len = 0;
> -	else if ((p = strstr(s, pattern.buf)))
> -		len = p - s + 1;
> +	else if ((p = strstr(s, pattern.buf))) {
> +		int newlen = p - s + 1;
> +		if (newlen < len)
> +			len = newlen;
> +	}
>   	strbuf_release(&pattern);
>   	return len;
>   }

That looks good to me, thanks! For context, I had sent in the slightly 
larger patch because at first look, I got confused by the fact that 
wt_status_locate_end takes len as a parameter, but then seemingly 
doesn't read it at all and only writes to it. (Of course, if neither the 
if nor the if-else branch are hit, len is in fact read when it is 
returned unchanged.) So I made the patch a bit larger in the hope that 
the next cursory reader might not get confused.
But this option is a much more minimal patch, and functionally the same. 
So it comes down to style, and you have a much better feeling for that 
in this code base, so I'm happy to go with this.

Do you want me to send this version as a v2 to you + the list as per the 
documentation?

Cheers,
flosch
