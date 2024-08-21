Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBEC79CD
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 19:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724267364; cv=fail; b=J0qBY+/FKZGawsDwx/Pcav5URuEVZg1I106w6s2AXmptVfjMTeZo0iUCfqrfqnTOFqKeVuTqDhBWxmEo9vi3I7NEdu0U8UoJTezDE8LdQXQf7JWIex4z/D+haNGQYixsvkVadJqTjXk0bTtzxFbusc2b/dvX5D5903u/WMyXXlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724267364; c=relaxed/simple;
	bh=Uw73/Tb/e6cxddX8mrtJEEGYCTnuHkPRoJIB4nVo50M=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jhXoj9m1RAYAAcc9SJGa0MOC0WLTqAsqCYVFUTbal/8JxXB8HxblDmdPCpNbF2X3fBM94cA3NwHPRorE9u4Jo2jIaDcNyoQzNtYYY3m4SS3NrIRotoFJ5Zs8HczBF0IDj5ERhzd3kQ9vxTFg0mO/vE7qguoAOwYJocTtK+4/Ft8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A+qb00Q7; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A+qb00Q7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724267362; x=1755803362;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Uw73/Tb/e6cxddX8mrtJEEGYCTnuHkPRoJIB4nVo50M=;
  b=A+qb00Q77FBlwltgTaihsyYoZBQCzyqcpGD4x1Ry7ZTHgiqUzdesIMsL
   OXK3xjt8ziiAs6YSJFxzpia1C+QK1SQJyIbV0papPC/G8+sLtd+Yf8LVL
   zk1mSuEu+Mhy51Y30xv6Spby7pRr4BlJr44sdFDA+HjIfcb/pNzrW63Zr
   x4psF4AxKVFIu6A7/U6mIMIQBueHZxDsXSC4mjEdcP1KuqUSL2/85OkGT
   DX/BVDV5upc488IGCul70/FLmJdxYSeqg1/pFxm4sEm0L+8KxbWOMd8Vm
   fZ1WbIhwgGEYeBANVngCIECsKc2JZ3VGTILrQca0MnEbbZNXwOj3qY70T
   w==;
X-CSE-ConnectionGUID: bfMIndvLTce2M3pQUKw52w==
X-CSE-MsgGUID: y9WdnUKGT5e+TUR58H6ybw==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="33314343"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="33314343"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 12:09:22 -0700
X-CSE-ConnectionGUID: s7MMw2xAQk61SqJiCSb+6w==
X-CSE-MsgGUID: 2OHmwGF+ThO6fonbAZ5myw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="84356188"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Aug 2024 12:09:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 12:09:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 12:09:20 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 21 Aug 2024 12:09:20 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 12:09:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNAeJfWmRh0BHifYVBfxBlDGbD/9NjOYx+3ABZRW8IKYugQGggwr1KC9XT/bgrF9Dx3huT0XEmgouBLa7zF8lk+E0EiDv4L0JUSDQABkVpLhGZTXnw5cewXiVFfijaK5HSUYI8BjukbKqPMzANP79YkiPkb+seyqkDuvRRw20m7sFRp06X1KACbX3Qg1oKpeBcXFzXkD0psP2+7016XS8BLCHbc5M02FKGSwtonCGB8iYUnRhrVNwyVJ8G5i1X0+X8L1yCtAuAR/ZLYCXInZrrN9xk2a6Ubb8VINw8SeUtMaeJIDzSoEkAjRPaaLvr37zrRKEWWzOGUDTB8/wynldA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eIM/e88loWhPOizj9hAAR8CQyqXWlMZ3/r6RkOtR6E=;
 b=tC20VH9CXNHNqzHiWOAI/NCwFLIx/ZewHebnfC7i56GuZhIDB4VKFuU0JQ5TYKciESuvfMmC+v6NuWJ9p2ejf0WSIqD7AVoEIL82Bpbzx4kj2u6vYgaEBsorAYGnZltaF8yxIGbEU6IsVvDoImkE8QlUmlf+KZg+V6DJgDEwhDVvzWXDEhZ+CK36qauycUa9V3JQV/Sm1wTxEcm/YVD/IGg9ZHlG4k4tCkxxfXgaDr6W4UTPRJHRtNSqBbu6eMvZ8aPZpOtEsemdeQkrpCSLSkLiutv0VYC/ObgjRyfX4tpZw+Eo81afuOJ2dO6KdZcpLEywtJgFn+oioLuw3wYMtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB4815.namprd11.prod.outlook.com (2603:10b6:a03:2dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Wed, 21 Aug
 2024 19:09:17 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 19:09:16 +0000
Message-ID: <3e4ba368-ab44-4940-856a-800e0ba7ff9f@intel.com>
Date: Wed, 21 Aug 2024 12:09:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] check-mailmap: accept "user@host" contacts
To: Eric Sunshine <sunshine@sunshineco.com>, Josh Steadmon
	<steadmon@google.com>, Jeff King <peff@peff.net>, <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
References: <20240819-jk-send-email-mailmap-support-v2-0-d212c3f9e505@gmail.com>
 <20240819-jk-send-email-mailmap-support-v2-1-d212c3f9e505@gmail.com>
 <mjlmmgwczact5ryprmorqztip2ynpcu5gpbulfabnoul2ubnr6@pfaxe7j4xo3h>
 <CAPig+cRhEJP6-ZX3X9SYrGM335-XTp8V=D9Yc7xkJQAh-g8xRw@mail.gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <CAPig+cRhEJP6-ZX3X9SYrGM335-XTp8V=D9Yc7xkJQAh-g8xRw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::32) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB4815:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b628287-c35a-46b9-007a-08dcc214c0a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3lvRVZoTGYrRVU4akU0dnpzanhPUHJDMFQ3SkFaSkJzQWZQVldab3paMnYy?=
 =?utf-8?B?VGpZbnpzdkFQNUo4QTBEamlSMlRzOXpvS0x3OEN2cVpES0xPWlVyZEZGV0lr?=
 =?utf-8?B?Nlc5dkhGTTBmbktkZm9oMXk3VHVmc0JkeUJzZGJWMXd5SHVIcjl0cjcrRnpy?=
 =?utf-8?B?dzNvcm8vMW01UnVkbDhCdjlnTlovV1pXYnR6S0JFTVMwUjU0RzBoQUN1MzRy?=
 =?utf-8?B?SnF3V05CSnRSelFybkRBdjhzcHRzWGgvTE1CUG4yUjdXZEFQTlAwRnVWRnNp?=
 =?utf-8?B?dFJsd0VmTG1YR200ZkJEYVJSK09iNU5tZnB3Wkl3SjNWYmRFYXJ1Slp5OHFr?=
 =?utf-8?B?OS9nTkJrOVREaFlha0N1c0MvbSsvV1p1a0sxWVlLazVYT2V1ZWNvYzBMVmc3?=
 =?utf-8?B?WUdmMjRiVmk4aFI3OTh2RGNvRTRsZWhGTEhHeWIxcjFBTnZVSDNhYUZRNjAz?=
 =?utf-8?B?UjZmVTlhd055ZTZkSGxiT0JKNktuWGVNNnlnSVU2NGVUYzdGRjd2Rk9SNzRt?=
 =?utf-8?B?ZWp5QklFSGVnalpxWmh4c2tFd3d3Ung5ZkFBTW5RcmkyQWFqK0pSTFRFS0c5?=
 =?utf-8?B?cXdBb21ScmtFMGdqbWlpS2ExOVp1MHVBWjB2U25Xb3BkQlEzU1k5eUlxQWpC?=
 =?utf-8?B?K2I1NHlKcnZSZXBaZVY2c2JKdU52ejJGanhlUlIzODd4L2VNU01MdVhOdG9I?=
 =?utf-8?B?aVVUT05rTm9NRmRHR3I1NzY2WFpuYURqbVB2NFl0L3hQVmVJcVR0Q2dORlVj?=
 =?utf-8?B?ZDV0RFhtWStuWUNteHJoa0JqenI5dEhpRzk1dnVFQ291Z0l2Tjd1VVJLbFVz?=
 =?utf-8?B?VEh5M1RUZHY0MjRiQmdNUlBkNU5FQUNkZDAwVlo3UXVVL2t1ZFVRRVdXOGRu?=
 =?utf-8?B?Y3l2Qm5HZEhLNTYvRGtQSEZoZ2c3TFREYVhyUzRyL3BjR3l6azJlZC94V2t4?=
 =?utf-8?B?aEhNUkJNU2U5TXNhNlJha2tYTWdrNTJqOGtjeFY0T0EwV3VSM1Rxcm1Vdm5T?=
 =?utf-8?B?R2NzVmpXSFlKWnBJS1MxaGt4S2JWT21kMS9JNWhWWWFiTE9hZjdzTjgxR2J2?=
 =?utf-8?B?NXoranQ0M21lWFNxQWFxbXlpQ1NvYVVxOXMzbTlBMjNzZWp5ZjJzUHFxM1RB?=
 =?utf-8?B?UHZGTVFLUDhPQlVuZXE5cWYvZDArazkxc0FLRFVtUytTOFJTVUJia0JSN2Zr?=
 =?utf-8?B?RGJ0cjFralBhdDEzUC9NSFpNaFd5UjJIR3pjU1pISmNZSmlHS1l5aTJxNkVB?=
 =?utf-8?B?aGZGZ3htb2xsdkVBRTJwaGtLaUZESG00M0hvSWtoby9JWDFFTmR3S1lrSGhW?=
 =?utf-8?B?RzVFcm5IRDFtVjFoalpISGMvemhUZEVuUndNV3UvZHYrL1R3WE9FK3N0N29U?=
 =?utf-8?B?eDhhK3V0TFJnaFAxdVlsaENtdFE5ckxmb2dqeit3b3kyMHB5L1JkdU4yWkJJ?=
 =?utf-8?B?UXM0YS9IWEhvaVRObStyUlk1YVVXYVlJdlcwa2VBcUxYVVVmRjREU1dtd0E0?=
 =?utf-8?B?SUJOR1ZoWlZwZXpoN2MyRTFTZlV5c0hNVGcyRGNzdFBERkxYcmVkbUlBbUFH?=
 =?utf-8?B?VURyV0RMekt6UE1ORkc1emlFVzRrTm5JMWdmckVFQXJJUlpIdFhoUHo4NUhZ?=
 =?utf-8?B?UWp4ZmhqcCtTa3JxSDNlaEF4OTROc3hUai9DM1MvY3RNOVkvVzlJeGwycG1y?=
 =?utf-8?B?VHNySEZjbDVGQnNUcy93TEZHbjNzR3RRTkY5aG5rSG1iVGk1ZUlDYmYxQ2Mz?=
 =?utf-8?B?Z2s2dGFJRGQwTitMRkg1VEVpbVA1cnVIeXljWjBCVnc5bWppTG9iWHJGenZj?=
 =?utf-8?B?K1FSOTcrV0dGbzVyeGdLUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFI0U0dlKzZGVUFOLzZEZGMyOXhjbk1ES0pubDNTWmxIQzJuUUovaW8zcSsy?=
 =?utf-8?B?U05laU52NEZTUUsyN3V0MkpTRXBWcDRQT3JxOC80ZTlVcjFDa1ArSVJnMWxs?=
 =?utf-8?B?ODZDR2xKYVJJR3hZTEE5RE1neDB5MEZOUFNLUjk0ckIxYk8yZW9ibkh4S0lu?=
 =?utf-8?B?MXNBdmhhbzdwNzBjbWt4eEIyZE10MTJ2M0pySHNkNGUxOFkxalpjTE5YcGdP?=
 =?utf-8?B?KzRaaG9iMm1lbkkwT3FpTDc2a2ZjZlRYWnFGQlk0b0lwSW5xSDFoRUZEbmxL?=
 =?utf-8?B?aVMrUXlDVmF3RmhVZU56RVQ2aEhYOWpOMVlIM1dtSDZEWDJpeW5GK2I1Wlp5?=
 =?utf-8?B?WVpwczBjZWRqZnVGSStOV1grZi9EbzNxWTNiamdMTUNwem1kalBYQkFBc2Rq?=
 =?utf-8?B?cHh5UVN1Q21WZ0pCT2ppTHVJbVF3QzRPMDk1S3JVTjdwNmw0WXJaN1lkUWJv?=
 =?utf-8?B?bGJQcmZKOGlld25wdU5saGFLVmtQeEtLZ3F3YmsyRlIzZFVpa0pvdFpBVWho?=
 =?utf-8?B?NWpwVW1IQWVqOG9nRnRnQ1VBOTJIRm9JYUJEMTFlbHRVeUJlWDUwOG4veUt2?=
 =?utf-8?B?YXN0Y3NiWVZBc3lqQWg2RzR6c0hWcStDeVhLeFNpa1BpMEdBaFFaS0w5S3Ax?=
 =?utf-8?B?OVRFMTRTY3VaQk9CQml2alp1ajJHVEROdzdvWnptN3hnR2Z1TWgzaStlNDFm?=
 =?utf-8?B?Ui9NaXplRUNJRUUxSzBaYXFlZWExZlhidFhZUm8ybUdoWlBnbkpWa3dKSlJS?=
 =?utf-8?B?TkduYlp4eW9uMWFrVmJUb0VmRkswbnpOSGJXWmVTQndrYmVOcitYUVlSNmZm?=
 =?utf-8?B?SUxxcjg3NUZ4NWVJbnJZWHlKMXRIUjRxMUR6MlBTMUtFQnJ4K2xVMi9iU1Iz?=
 =?utf-8?B?MjJMOEFWVkpLS2VLMHhCdEIza3ZvektDbXYrVkYxWjJKeHZvdFJlZS9SQWNv?=
 =?utf-8?B?c1pucWUyMTZKR1Y4emZaNjhGUHNmcFh5VjhoOWE4aUJaRkx6MjRMeVBqTkJP?=
 =?utf-8?B?ZnRvZi92STViK3ZOSHRlYUxSKzFwWTBRejlYNjJCNmowV2RsRlBrMDRzUWpX?=
 =?utf-8?B?c1FkSEZOM0dSTUkybndlZlNWVzNtKzZTb200VjVEK043S1o1NUwxYVdFV3Vz?=
 =?utf-8?B?aGVROWhBZHEzanpZcFFWWWlRQklDcjIwZUZXU01uUC9xdnlQRWR5Zjk5WHN5?=
 =?utf-8?B?bSszMGhMcTRDMVBxNDVRUmRlRXFMaXgyNW5IaDFPQVcvR3Y5OVRRSXdhQnZC?=
 =?utf-8?B?ekYwaVhhc013cUlqdnczL0tHZFEwZXpUeGNSemI0bW1rdEdXV1k4Zmc3STdE?=
 =?utf-8?B?cGtTOTRyeWN5WnF6Um55MXZBREtlY2JoV3JsTkFkSml4Z0IzTDIwNEpITlVF?=
 =?utf-8?B?WUVuV3VoSU9ySDBBcDhFb3FwOVpvclpkanJRSDlUbHc5WERJSnVTdTI5LzJh?=
 =?utf-8?B?N3cwWXptUzV5WnE4ZmM4ZXFaRE03MHhsdGF0QlBrSXB3c1NRaktvamdEM1JS?=
 =?utf-8?B?MTV5YkhudXFOZWdyL1o0aTY4T2JWY3lZYmhzU1Z4aXhpWTZBSDkvcUNWRlh0?=
 =?utf-8?B?QytoeUZXZEdEZ01jQi8veWk2RFZRZG4vNjhwSmFOY09iQ0t2dlN4dnNIbFJk?=
 =?utf-8?B?N2tCV0J0bmQrUUdCQ01taFVrdGJ0MnU0V2RWZWtxamFMMWF4QWxOZ3REZzY1?=
 =?utf-8?B?N2J4TmxGYTdsZ0Q3b3BkclVpaGJaUk1WY3ZzWW43MWplSDVPK0dZQXZqWHc5?=
 =?utf-8?B?bWNLVm5ja1dMNVY0Ykt0ZkdRQ1RBbzlvRCtEWlJzWnZBbWpUWmxURzdwbHVw?=
 =?utf-8?B?UkR4TVVnaEo4YnI0dDI2UUpydldiOURLOTVGdGd5OWMyVk9lTm1ITWVSeUJw?=
 =?utf-8?B?QUtEMWR2T2NuaUoxNnZ0WUw2UllzTW52RVM3M0VIZkpicjZJdHF0eldKVjFS?=
 =?utf-8?B?cDVPNTdhRVRzdU5RSy9uUkxSVjRtNkxibUlqV2F3SU1odzRlUGZEWjAvUC95?=
 =?utf-8?B?a2NjYnVPdUFzYzJvR3locURxWldNZXlsWU9OaUQwckpWZU1XUzdPLzhOMjB2?=
 =?utf-8?B?aTMweU9KbkZ6WEM5dmx5WDE3SU1uanNCMHZlNUEzRlV0Ui9odE44WEF5Z1N5?=
 =?utf-8?B?TUFPRi9URGlpV2dkQlo2VEowL0w3aU5GcXZnNml0MXE2OXg5RUpYN2hieS9N?=
 =?utf-8?B?TGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b628287-c35a-46b9-007a-08dcc214c0a3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 19:09:16.7763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0z/7nqo/hdy8/2ScVRfr6dW4b2X4HBQedNuU46C+YKv9K3qZwYCx1bUQ8ZkWXe3R0C58R8SU+c/Cb53Oxh01ijLik4iw6EPTM/BpGaXgCQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4815
X-OriginatorOrg: intel.com



On 8/21/2024 11:27 AM, Eric Sunshine wrote:
> On Wed, Aug 21, 2024 at 1:50 PM Josh Steadmon <steadmon@google.com> wrote:
>> On 2024.08.19 17:07, Jacob Keller wrote:
>>> diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
>>> @@ -73,11 +73,40 @@ test_expect_success 'check-mailmap --stdin arguments: mapping' '
>>>  test_expect_success 'check-mailmap bogus contact' '
>>> -     test_must_fail git check-mailmap bogus
>>> +     cat >expect <<-EOF &&
>>> +     <bogus>
>>> +     EOF
>>> +     git check-mailmap bogus >actual &&
>>> +     test_cmp expect actual
>>>  '
>>
>> I think I'd just remove this test case altogether, IIUC it' doesn't
>> provide any additional value vs. the "check-mailmap simple address: no
>> mapping" test below.
> 
> I had the same thought upon reading this.
> 

Yea, I think I've been convinced. I'll remove these tests.

>>>  test_expect_success 'check-mailmap bogus contact --stdin' '
>>> -     test_must_fail git check-mailmap --stdin bogus </dev/null
>>> +     cat >expect <<-EOF &&
>>> +     <bogus>
>>> +     EOF
>>> +     cat >stdin <<-EOF &&
>>> +     bogus
>>> +     EOF
>>> +     git check-mailmap --stdin <stdin >actual &&
>>> +     test_cmp expect actual
>>> +'
>>
>> Similarly, I might change this to use a real address instead of "bogus",
>> as we're no longer checking for invalid input.>
> Ditto for this change, but even more so because this is a fairly
> significant semantic change. In particular, the documented and
> intended behavior of the command when --stdin is specified is that it
> will consume email addresses from *both* the command-line and from
> standard input, and I think the point of the original test was to
> verify that it still correctly recognized a bogus email address
> specified as an argument even when --stdin is requested. Given that
> understanding (assuming it's correct), then the original test was
> already perhaps somewhat iffy anyhow, but after this change, it is
> even less meaningful.
> 

I tried to ensure we have test cases covering both --stdin and a
combination. I'll double check this in a v3 and ensure test cases
covering the behavior.

Thanks for the feedback!
