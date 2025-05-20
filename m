Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6793202C3B
	for <git@vger.kernel.org>; Tue, 20 May 2025 22:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747781134; cv=fail; b=ZV7rDoRvswqE/YzpPUmHxpmYxQgADsdYaXp6l7lglda+38y9DYZdjeoYj4gmuWdXjpVUxdulAmS8BVQZSTyBG2qQ+EWjsg7NiIEJWl1stAEgL2jq4gluj0MiGAwDdxSESiyHx6RjngzUr6q/EwAvlv3Vz/cjYwMTkDsVqumbfQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747781134; c=relaxed/simple;
	bh=JaPnwbXoTwpsOZRkC0GKS25riIdB3eCkU2IeOuqfHVQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pl52BiQRNMpkhr2Wnj6z7I2USGQW7MiNu22KbQR2ZaxSXZkcQ8GEuhddoLzSLdn8nLg6dcQ8MuD8NaSWloG3I0+iB0BYJSAmGnQUFB3wS5BYNfcL/U7GEzxff4aG68iaW5WQ173WfxatmraPMop/+LDaz8BQL+2d2t+8V+YLVxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n0Zqa6J7; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n0Zqa6J7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747781133; x=1779317133;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JaPnwbXoTwpsOZRkC0GKS25riIdB3eCkU2IeOuqfHVQ=;
  b=n0Zqa6J7de3d8B0gH/sE1rxO5i9FEwx8ZH3S2Ar8w9RpSAF4PwTpumyo
   UYkZ/1eZrA1SNkxECeTcIUQ4FZaEeCrGgwGdIc8twG6Te7xmG4XG2x3sp
   44rSo3Y9QN6qLAKnGDoB78BvXHdtezNrVcUVZTBjU5YEiNwUEIDXeBqXh
   1G3JAKzv2z7aTiw8i4bI3MkLAxYHKtlR9MEfvSnvG5PYO0ONf2s6RDB22
   c4191URK/to4I7WyrLaJl/O/v1TMepMPortUFucIgvH0aMkCNrWChm5P7
   aRFvCMBWTE6Zt0DP3XK3g7ntAQCXhYhWyqUDuSaO+atpmDhJv1rmAvY0o
   A==;
X-CSE-ConnectionGUID: pI90FQikSbGSArZv2crGKQ==
X-CSE-MsgGUID: fJ9GLKm4TlCjXX5sw4CfLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49720299"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="49720299"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 15:45:33 -0700
X-CSE-ConnectionGUID: ZNUQYFR2R8ai7uvhSk6xhw==
X-CSE-MsgGUID: k0c0Y+q4Tu2Y7MitCL2Otg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="140761380"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 15:45:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 20 May 2025 15:45:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 20 May 2025 15:45:31 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 20 May 2025 15:45:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fy/f6f4B0XUidAZd1fI1liAkkWDe6oIw4U5uProDonFzrEMgZ8dku8/7kGIGyNrJBA86/thHBzpc2Sw/C4oSVyIAwUNSZyAaQ2ddgfoFSWN6PkH0AUDnLK9LxQTbzAlYzELyuJSMbC/5iAI2L29dsvkrQn7aN+GOjzTYze78E4iG4V+9rAz+kYYtkyYmeTxDCzgFRN+b/nlofpoW2j24O3g0gCZU0/2WQg2o58ICWWRhsoz8kq+ga7jW/cp4KPk2dqoQhYv6tKqwTtoKnzhqvWOoE4W1N75lc7bTBleAvRlccjqZ32Iy4i/N5m0N1a+bhpEfTJGYJNpmXLum8DzDCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNL0gsxLDoFgXElo1OYedrueFJcJraS0Uh0LF6XtLbI=;
 b=s6vwEGZmFfg5t1DOZxJa9h53J90jE73hXHx3NTU/j7nVxGHdUAXYlRLX/eXrqS/4EJxvCkSFdIBzzE0ytr1X5ACZ87iFiIB3Aw/pghUnSQGlhTuAjtQUChxivwLR3DzYr6xSXdQ4A+iUfvxhf7VLKwkt2MTVjMmEvWS0lRgDCJ+rsl/qLhZr0/s3/EgUmkWJWwWQIhVp5tk4efxHUD3z71ovDgc+Ceu+Y611srY/oRCFNOTE3IXH6nTCl/wfEagxhbbYOZsV2XIJVbSa2ldnwwvHRQ59J076NOqEoAtA8CaXkbMZRwO3OC9d9IuaDRLpZfx55k3W+SAK37aXc0nPEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB5182.namprd11.prod.outlook.com (2603:10b6:a03:2ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 22:45:30 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 22:45:30 +0000
Message-ID: <5343efa2-99b2-4532-b52d-0e120678470c@intel.com>
Date: Tue, 20 May 2025 15:45:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] diff --no-index: support limiting by pathspec
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>
References: <20250520000125.2162144-1-jacob.e.keller@intel.com>
 <20250520000125.2162144-5-jacob.e.keller@intel.com>
 <xmqqy0uri6st.fsf@gitster.g>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <xmqqy0uri6st.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:303:8f::34) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB5182:EE_
X-MS-Office365-Filtering-Correlation-Id: bb59af00-b167-4b16-6452-08dd97f00546
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bTQwclY1dnNFaWZSZUQyRHFOaEpGb0UveWJSUWRPekJqejRMbUlVNnZpczBW?=
 =?utf-8?B?Z2U3TktyQUlndE4xU0FZSnJ6QXBGS3Y4WG5DOFpLVjN6cUhKUFhHaXQwMTZi?=
 =?utf-8?B?QUwrb2twQ3F6RzhuN2ZSOHlOM1JENDMyTTAyT2QwTlhua1dhaW5jd2V2YzRr?=
 =?utf-8?B?dzRCMjZYNjUwZlEwV1UxMk0rQzBKQTRvQ0FZRlJKNmZ1VVVuVWljUHMvVkhm?=
 =?utf-8?B?UFNPaDFtOGtUVTZhTm9HUkpVL2k2MElnekFSMGJNQ3B0NTJvZ0RBMUZ4SnV3?=
 =?utf-8?B?aENBaFBZU0dDdm9jbGtqUHBmaWxYSmFFVk1TZllncnBIWVNxa01YaEc2UE95?=
 =?utf-8?B?SnVIZ1VmMmJpVGViU3ZJTkg4L01yYzM0NUpsWW9rSDhkOE5HRHFTNGozTWdx?=
 =?utf-8?B?QmNXdUF4bDlDMlNvUVQvSnVIWmFXV1Rnc0tmOUM0QkpDUUpRL0dlSU40aHp4?=
 =?utf-8?B?djF6TnhZRVB3Z3JQOE1idEJnVnhMandmc1FYRnhmZXNrZlRyOTFpOGRSeDFK?=
 =?utf-8?B?K04zMFA2QzAwMlJzTzBxZFlXUmJmcXBLallwUnRkODhmL3NIV2tOL2NLVWFK?=
 =?utf-8?B?QkFYSEFVR210RldLTUpSVDZSZWQ3Y0pKYytFVmVreWhiME1kcDZ5Ulp4cjJM?=
 =?utf-8?B?d3lnK3ZzeHhtRGxaajNFa3hVMGpKTXY3T1J2TUNjN0szK3FxaXRxc0JmSHM0?=
 =?utf-8?B?b2lTdXczamNOVjZFUjFGai9EbWg1MGJrRXJzS25ET0QvSDZQc2dub08wUzBs?=
 =?utf-8?B?bmNFN1llSlFxWWI3eFNFazkvd0puNGFONERYNWRMbDJ4Qkd5NkcraUZsam9L?=
 =?utf-8?B?MVdaMi9jbUtMQ1o4Kzd2OUFtRFlmRzM0d0ZSSjIwTXVIb2UwcGhRaXhtakZM?=
 =?utf-8?B?N1gvRWtDaTZObGh2L29uVEJ3Rjdxbkl4NFJqNWtCK0FnRUF2WUhyaFMyNEtn?=
 =?utf-8?B?R0EzakNxcndsN0gvUlpTNVRsdjc1SXU0cVB5MUgrVXdZUHJKYzVZanEvTG14?=
 =?utf-8?B?OHR1YnA4MFk4Y3k3RUVwam1zbnJBYisvK21UTDhCRjZnMU16WXpXZmFuT2Ex?=
 =?utf-8?B?SmxOVjJ2V2Z3WVRqNEdRY2tGNU0vNU81dDRNcy8rUEJuN1VRMkwrVWk3MGNu?=
 =?utf-8?B?UFBaS1U1a1M1bExLWERSR3hoSDMwd0JVWTBVOGprY0VGcFE2cGtGb1kvUjVs?=
 =?utf-8?B?aWswQWNtVFBGNHRHTGoyVVJUaG9neVlRTmN0Q2tDVEhxeHkxK0JaWUxmaU8y?=
 =?utf-8?B?SmhGZmd0eno4Vkt1VVlhZXdyblJrRy9nWWlrVXpxTFVNeXdPQ2F6TkoxT1ow?=
 =?utf-8?B?MEZEL0RRSXZXRVRWQW5FWEEyd3Q1M1JKRnBDZVZiR1M2UTFsaXpwRzczb1do?=
 =?utf-8?B?NTRjeHQ3cFF4QlNxWEJod1pvMm0yT2ZhVzNreUtiU01GNU04djdkeGE0Mk5s?=
 =?utf-8?B?M1NhcWN6WW80N1Rxc0J6RjhPWFI3V2dvQ1pyT3o5ZnVLM3JLRVBWZjNFN25V?=
 =?utf-8?B?Rml1bHIraUFHTDhteHpBYU56ZFdnMy9VYXFEUmZ6SFJzOHhVR3VscUdINnJu?=
 =?utf-8?B?NDZyeW9vazM2cXloRjI1QTNCMkdZL3ZvZlV2d3dMUDFRK3NoS3FYRkhsZ1o4?=
 =?utf-8?B?Q1Q3VDQyUmxGYVhCMGdZQzN4b29Kdy9qKzVKYjgvbXk5VnRoRWhLMHQyWTVT?=
 =?utf-8?B?Ni82L1BtZ1czWHF5M25Fc3huRlNSdjZpRWUzVjB2UldMajJ0TkpLaGppMUhX?=
 =?utf-8?B?VXRsanpNR2s5U0NoYWt2b05IOEVKZU9FdW5obUFpQ25MWExEdGhHMXQvK1dU?=
 =?utf-8?B?Z0tQUFpzelk5NTJjL3NLQ2JIR0U3U0VqNGgvT1BLRTZIWmFMaGxmS1Fpbzg0?=
 =?utf-8?B?anpSTk9kdHhWQ25ISlBhSGx2SlVpSW9wMHNhNTdMTUtBTlpqUTRIVjJLdlRF?=
 =?utf-8?Q?b2BGz8YAyLE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z29BYktabUZ1VkNHaGpYeXdKR0M0L3d2bE5UNCtkbFpSWXY2L3lsK3orUFQ2?=
 =?utf-8?B?UlpWcEtOQWpJczBJY3YxdVhEUmVrZGMrdWFWSUxiQTNSa1RTbDJQRS9YQmZt?=
 =?utf-8?B?VWttdmNKdzFhRWxaQ2xwTG90Y1VWVURVUURMYUgyeE1UVXNqdkl2UTVTRUhB?=
 =?utf-8?B?ZXEzUHpScDhoQTF0bVpjSEltYVVJNXM0bDdRWXFWSDVMS1VjbS9WM2d5NStI?=
 =?utf-8?B?cUd1N0U5Vjk0aGtZTVhZbWt6QkcrS0F1anlXeDNCQWVGRTUwQ1FwRFo4TWVE?=
 =?utf-8?B?M05GZ1A4K0cyWnN0a3R5djJPT1pYdHBvYVpzOG8zekJ6dmswQTRiM0cycG5r?=
 =?utf-8?B?bzQxZ3NsZTdDdDFwN01NaGNIaEErZmNXV2JCOC90UDlTd05WdkVXcldsdVl5?=
 =?utf-8?B?THVNSFlPd3lEZktWWFowVHBQbWlNcC9weUErMG11TGJQTzlza3R3Z0pFZFVY?=
 =?utf-8?B?amhIRjk5SmgyU2RwUUthQnVXVVE4NC9xRHR2cmx3Tjc1blJVZ0ltTGVKSjdJ?=
 =?utf-8?B?TFI2UWJmajBIaHFsSVYrOWtiQTVSVkxnRVVWYk1DUlJlcGhJTmlsQ2IreEht?=
 =?utf-8?B?NmdRODhid1d2aXJKdEF4ZnZpanB1ZXZhQVN4azNuSXZ0cmQzUzB0Um9ndzZk?=
 =?utf-8?B?L2lTUzA2RXQwSWFnVHpscGI2SC92cE0rQnczakREcTcyNkR2YXI2dVd4UnN5?=
 =?utf-8?B?OGh2VVlHcDFZNTlKd2hkQVBMQjFOcVNiSXJCL21pOEdyV1NKaHZFdUpaeDVE?=
 =?utf-8?B?RmJmMmFyWmcxcmNjdHF5S1FWd2toZStQaEVmTnNjVjR3cFRpWHJtYkdPVGFz?=
 =?utf-8?B?ZGxVM1BFSVUvSk5vU0NCNldvc2JQc3ZzbFhVZFpCaHRKTDNpek5pOUk0N0NW?=
 =?utf-8?B?dHh2dEdFd2JjOGk0U2tIdjhZM1pXTmlqL2hONmdNcFZnRXJTZXhKMEs0cm8w?=
 =?utf-8?B?emVNRHRGUFo3RGpMRHViTTJxZEpGaEdpYjIwemtxZjA2bFAyMFdPeG1pNmt4?=
 =?utf-8?B?QzZhdEtFV2lFMGd4K09VSFhVbTY4QnNSZEFGUlpZQ1JHOEN4QVd2ZndOVFFl?=
 =?utf-8?B?SnlGb1BHT1N6WE8zUm03ejJDK0N1N2NENnJuem1WWUFrTHFvdXIwRXp5dnVC?=
 =?utf-8?B?em5jYWJEU0VUQmlhMlZ2Y3FvWGM1S0tnYlJoaE13cEFnSjFtdEZKYWYyTTly?=
 =?utf-8?B?am9XWGFqSFpYVm9wV2MzZ21EVDhFL05NUXFIaWRmYzhsWkQ2SU9PQkNyZFVn?=
 =?utf-8?B?ZGQ3OFZ4ZWtmWm5FNGptZ2lwZ0JMSWtiYVJwRUN5Yy9wdWdpRXJUYVEwR2JP?=
 =?utf-8?B?ODhnZk16QktOSTlPaXVNYzdvQ2hUbWR2c0dsQUYvT0h6VVVaSnVmUGtwTkc2?=
 =?utf-8?B?YmtoaGoyUEhSeUwvUGNDbUNHWUc1Zkl5M1B6QXIvOHNZY3hhRWNZTExQSDh6?=
 =?utf-8?B?ZmJ5UVJBSU4veFhqVzBWYm9YV3RmaEJXSmY0S1NxWlVzMDZQajllVllaNkgv?=
 =?utf-8?B?c2dnK015T0lnWTlZTUEydndGWUY1V0tUMW5xa1VndzI4WXFiWllCOFpiVnhj?=
 =?utf-8?B?Q2JsbkRrM2NqUVBaa1NCczYyYmc3NTBzZ0RJZk9pWks1ZzRwQzZ3VGpFbEVP?=
 =?utf-8?B?VUhVYlFNQTZVcTBKT3VFdTVaL3drNlNLdzRneWZOT1VhbVBGYW0vY0hPc1Vo?=
 =?utf-8?B?cHVMdXNoU2NRN0tLZ0FOTGt2U1pTUkNCMEQ2MjlXODVTYlJxSFROUjB5QUVx?=
 =?utf-8?B?QkgrN1ZGY2k5SXg0VmhEcUE2V0N2aG80dUs1Q2JQU0VMSndQakpITnNVSWZG?=
 =?utf-8?B?RllaWnE3RWhHRjM5TVFKS0N1Y2hnb2x6Z0EweC9Gcmp2d3poS1NNU1d6dWE5?=
 =?utf-8?B?Zi9xSXlmZElubTMwTFU1ZUx6NWRHeXZhZHFDSjkyVFp0TE01bHJGWjJqTVZG?=
 =?utf-8?B?WXA4VUp5Y1RlakpOU2VaS01lN2V5SHRzVnJjYVRMSnp0ZVNlVHBZaWJFVlor?=
 =?utf-8?B?NUt4bVYzOUpBN3pMcHIzcGZFV2tpTitzaEhQWXhLamhyT2xabXVhR0pkUDI3?=
 =?utf-8?B?aExWeXlNWmpXUnhjaURFYkRGcHgrYWlKQ25BR2NVaUk5VURENWhmU2tXTUFk?=
 =?utf-8?B?RmM3NjVDemd2WHlSWTl0OHZ4K2xWNFM1RUZyNnA0c2dwNEhtRmlwSWY0a0x2?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb59af00-b167-4b16-6452-08dd97f00546
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 22:45:29.4900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5B2QXKeFh2Zneft2wSot4BW2iauS8+dkCrcAWxZ0NvBhhTCHVp6+XMPXnKFGYw7uWKutFoJjfftuinXkFXXOK2RM1XZpDhb3TjlRyufx0wA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5182
X-OriginatorOrg: intel.com



On 5/20/2025 9:30 AM, Junio C Hamano wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>> -`git diff [<options>] --no-index [--] <path> <path>`::
>> +`git diff [<options>] --no-index [--] <path> <path> [<pathspec>...]`::
> 
> This is a bit unfortunate.  The disambiguating "--" should ideally
> be between the "things to be compared" and the pathspec, as the
> former corresponds to <rev> in the normal "git diff" invocation.
> 

True, but it looks like we already had it before paths. I am not sure if
we can easily change that now. :(

>> +	... If both
>> +	paths point to directories, additional pathspecs may be
>> +	provided. These will limit the files included in the
>> +	difference. All such pathspecs must be relative as they
>> +	apply to both sides of the diff.
> 
> "as they" -> "and they"?

I think I meant "because they", but for documentation I think and they
makes more sense. I can clarify this a bit better in the next version.

> 
>> +test_expect_success 'diff --no-index with pathspec' '
>> +	test_expect_code 1 git diff --no-index a b 1 >actual &&
>> +	cat >expect <<-EOF &&
>> +	diff --git a/a/1 b/a/1
>> +	deleted file mode 100644
>> +	index d00491f..0000000
>> +	--- a/a/1
>> +	+++ /dev/null
>> +	@@ -1 +0,0 @@
>> +	-1
>> +	EOF
>> +	test_cmp expect actual
>> +'
> 
> If you use --name-only or --name-status would the test become
> simpler?
> 

That is a good idea.

>> +
>> +test_expect_success 'diff --no-index with pathspec no matches' '
>> +	test_expect_code 0 git diff --no-index a b missing
>> +'
> 
> OK.
> 
>> +test_expect_success 'diff --no-index with negative pathspec' '
>> +	test_expect_code 1 git diff --no-index a b ":!2" >actual &&
>> +	cat >expect <<-EOF &&
>> +	diff --git a/a/1 b/a/1
>> +	deleted file mode 100644
>> +	index d00491f..0000000
>> +	--- a/a/1
>> +	+++ /dev/null
>> +	@@ -1 +0,0 @@
>> +	-1
>> +	EOF
>> +	test_cmp expect actual
>> +'
> 
> OK.
> 
> All other tests also look sensible.
> 
> Thanks.

