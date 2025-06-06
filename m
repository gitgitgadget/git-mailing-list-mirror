Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E78936D
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 21:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749245397; cv=fail; b=DB4hBu1M5VTygDmSVoyQzPwyRAd5opSrNBdpBWtPjr7BCT6RWSFqzUEzSKia1/8ikU8joWGB8SNQ84hHA/Z0WAVHPAflOxn+aGfnz9O7iqfw+Ulvdtbgl6RzX3Zdw2PzhlfVb9j3JNQnJ3VMiiEWcbwgXVh3qRfR+hlA1K0c5fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749245397; c=relaxed/simple;
	bh=z27U6I9cdnTiIrqBT+2w0ICtXKdOZMcCqLReTpi5p/Q=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W++qcl1enYYsaVudWKwaQPxDNgP0QJVmIo8djGVKf895AmhzWaWYIuCJl+bzkaGCWxs23le4YXpR59dQ3xnm7q+/Wfm3Jv9q5L8br3HnCMY7Ov6UnCVsSjZXE7Xr2/nqna8edx3LBsH96f2PwRBFmTa8ZHGPd1ObBVtcRSYQY5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BGSB1fwJ; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BGSB1fwJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749245395; x=1780781395;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z27U6I9cdnTiIrqBT+2w0ICtXKdOZMcCqLReTpi5p/Q=;
  b=BGSB1fwJ2eaDAvOPhvYJbupl8TpZnT2kxEOv8YHkx+9mzYa004iyPdQW
   dvtuDYpMSIcHyuGP9Z4VCISwVBYfB9zGcA/9Xw1B7goHp53ke+WCkPk7s
   1SrYxUyVHt/mixEaZAjhW8QuJBR2YaStE/h4PNBvUIkXL11FSEWz5yD1+
   1XY7/1Mq43WFQ5G/BwJAbBU4P68vtfgbPM3KRZp2wEiZr/RuHkNq+RjBR
   iCFE4qVsmHDrjhU3+clIwXFlZGM3KzHP8sF6ZkG+juPurd9VeJKs3/1fq
   b6JK8OHea2z+QBD+hMCQ2qBuqhRP5Pc5Kb0AZPX6rffVnqPlRr1qD9PXl
   w==;
X-CSE-ConnectionGUID: NUTJgu2ITZar+FLamLXgHw==
X-CSE-MsgGUID: WuphSVV9QvS4KTYae11avQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="61671627"
X-IronPort-AV: E=Sophos;i="6.16,216,1744095600"; 
   d="scan'208";a="61671627"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 14:29:55 -0700
X-CSE-ConnectionGUID: 5gAQRksBTH+Ltb8kdbA0NA==
X-CSE-MsgGUID: c3A7ruXcRoWKWPDDV+yv5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,216,1744095600"; 
   d="scan'208";a="151188650"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 14:29:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 6 Jun 2025 14:29:54 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 6 Jun 2025 14:29:54 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.66)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 6 Jun 2025 14:29:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J42bCgHvxzL0OYnnTRyaTsY+N/4AQkiAgzK6HAxG1Sxb57NXmVs3y9WOH2YKctJXwFeVsPo3zUcSjLXu3W6DT16rRja6zTT/IEsS7GwZI5XlY1/UUoCmyBy9EWV57npsxgg+ITJyFnGaA1vlacXdhsO4AcTSXFROGNJmXtUJCYefIUsxETVviD8MUtts5TwXDMlo/WaisJpS6N6JcA1j3I3t6+yaFV5y0bJ/YQkIGQh55cW1fpGRODwcIpCcm//2b3meJoTdScIIyxF8SMVf7yz2KT4VNG2OvhMyxGamP4YL6YCwr5O68bthqCT7+T0Zf/sGAZmLv/HH5qLx3JDayQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DzE3muiGiEoY1L9kf7CDuomsnl7u1HKuQJCAgVw3Svc=;
 b=Tmf87PyJQDbEat4l0j+c3uDnZTJqC3E3co4/UAD2TR7Q9dik6xbHoJUoewozJFWb4ObH3qea2uqmapxlKW5o7l6QCsMmBQq7xbofAltj3kuF31vxksUzd3ij3LVezm3V5suWqL+QqgNYZ6MLVAVd45zCMw8XPZEesKHLTLx5/hk6VC0mJPtptAOdE9cE1RKsHh7m7EBvvgafOyQlHJmKicQpQ4BNpSbDgPFnsuOfNkdAVnmp5tK7mbFMRgFHGC0q+41QQFd5m7tU/QyUcnoL2/ro+8wH9CCPQhVgn6J4vlJx7XfZa5NfHgxtpK3tTUGKk7pXVC6rJmo5ziZluQ95nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB8176.namprd11.prod.outlook.com (2603:10b6:208:452::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Fri, 6 Jun
 2025 21:29:50 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%6]) with mapi id 15.20.8813.020; Fri, 6 Jun 2025
 21:29:50 +0000
Message-ID: <bdf7e50f-aa65-4514-b147-9f7ebed147ab@intel.com>
Date: Fri, 6 Jun 2025 14:29:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: issue with git submodules and a clone.defaultRemoteName different
 than origin?
From: Jacob Keller <jacob.e.keller@intel.com>
To: Junio C Hamano <gitster@pobox.com>
CC: Git Mailing List <git@vger.kernel.org>
References: <4f638125-39e0-43a1-9c58-35c2d433042f@intel.com>
 <xmqq1ps0gzo5.fsf@gitster.g> <48c2af0f-348a-4443-a8b7-74ea4b666bff@intel.com>
Content-Language: en-US
In-Reply-To: <48c2af0f-348a-4443-a8b7-74ea4b666bff@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0222.namprd03.prod.outlook.com
 (2603:10b6:303:b9::17) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e3aac4c-8da0-4909-f213-08dda54144b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlJrb3lDazlPK3Qyc3lkZm5sdEZRSGRmTXI3ZFVjTjcrUXM5VWx2bk5BUGxX?=
 =?utf-8?B?WmFUV1BZUlM1Mk1yY1FCRzNuTm5BZVdaTzhXWWtJUWU2SHgxSWVoUE0zbzF4?=
 =?utf-8?B?QzB3aTNYWEhnenB6MnVhcW5pVkdDV09ZUkxoQWRxT1pvVmZMZ2t5U1hWdFU4?=
 =?utf-8?B?VDBoeUJZclNZOHJtQkVySHoyRHAwUzVHY0ErT0dyOUtRSjBkaHY5Z3dOc1NQ?=
 =?utf-8?B?OWFPK2NQVUZkTEhWeGdkeFdNeG5NVTFhWkVWcTFBUlI4S2NjNXFEVjd2NXps?=
 =?utf-8?B?NUNlWnRYMmtSMVRJQ1gxczVwNUtBZDlRVWNHOVVmVmdjOXREM25rYVBaakNW?=
 =?utf-8?B?K1NXL3RYdEZyVFVtUnZiNGdKd3dubmw5dnlCd1N4UjNvZ3d5QnVXWTJuQ1pp?=
 =?utf-8?B?ZGRKRUNHU2I5V3FWeFFvcDZoYWNETGowY3RHV3NsTWorY1kyWnFjTFYvOUJn?=
 =?utf-8?B?WW9QcVBhRTlQaS9zcUxMUGdhOFpDUzVmQ0Y5NnR2YnZDblF2TXdVSEtlcmRC?=
 =?utf-8?B?eDlFenNLNFA2ajFmZVk0eHplY2JGdnRMRG5ya0xMVkZNSlhzQTJCcGp1dXFv?=
 =?utf-8?B?ZnJlbDFqOGhCMXlhMkhqM2R6bVBEd2llcXNFVFIvTGVON2dFQkR3akVMUG5j?=
 =?utf-8?B?bm1BeVcyWmo1NDBXUGpwM041QmVDa1BIbkNseU04TnZWNGxwZzNPMzBTRUZO?=
 =?utf-8?B?eHRSQU14YzN4ck1uYmREUDRwV2lTamR1NUhSTmZEZUJsTEhra2trWFB0RXZi?=
 =?utf-8?B?OTk0UVUzdHhYNWdyR0dIWGx5R1pKVE9xa05zWlZFY0V2bVVGZ2lEcjlYNFli?=
 =?utf-8?B?TmJ3R3JQeGozSjZKMnJSUmtFeGZUbGVza3NOK3VBQUd0Q2ZjNnE1K0JLTmhw?=
 =?utf-8?B?U2gwWWRnbHk2V0RwVXd3SHViUFZYN0JWeUFHOUJuRi9kZUR0bzlLZUovczNj?=
 =?utf-8?B?UmZCNDAvcTg4Z3daaWE3WVcxOVFZejU4WTFwTVdZNEhZV1BVdHdVVUw3MGRG?=
 =?utf-8?B?VVE2eE4zY0RtS080cFkxdTVQK3M1VHk1THpxRmp5djNuL3VVUFFtOXZ5UEIw?=
 =?utf-8?B?QkJ5VVJtUWMySktObTM0aE1CckNsZnR2cHg5ejJ6LzYzeXlPam5wU2NxL3h4?=
 =?utf-8?B?dEV4OUJMSFdBRDU2dFlxVEVydm9WS0RSa2llMWcxZWkva3hGTENtb2sxRGF4?=
 =?utf-8?B?MXl5NjVacGRCN1FzUG5pTllyOWU1K2pUNVdkZHNiQms5Qml3TDFWRmFpNDhS?=
 =?utf-8?B?S1BDSXBaZSs4a0V3OHRHZjVxREx5R0t1MHpUQVlXT2htR0o4V3ZxTk1hc0RM?=
 =?utf-8?B?Y0hZMHh3ckZVeFVtNmZnR29EY0J0WG9ydFh4MnZYdDgreW0zNXdWcVZZWEE3?=
 =?utf-8?B?WjVZM1RNTHRFWmwrcWFhcC9NQmpPUnVlSldGL1dUc0lxUkRrd3duL3VnbjR2?=
 =?utf-8?B?TmhKeWJwRnprQWFtTU00YWhIOUFCdWt2TGwweHpUc3NodGN1Y1VlRHowbU9a?=
 =?utf-8?B?Y1BYTVNTNndKbWN2MWRuK0NLQlhJK0pKU3ZJMTFSdG9zeDI3bHFWalVNOVor?=
 =?utf-8?B?bU9LZW9JZ2RoNm9Bc1dodWlUQkpUQTJTS1o1NnJDd1FBT2xFcGFNelJhUGNK?=
 =?utf-8?B?R1JtZ1dDc01qRkxFTStDdFZqSXh2UDFDN2VBVzdxcWlqdjFYempNcmwzNThi?=
 =?utf-8?B?V0F3Y3gxUTdRQU9IVVBndzRTLzhuN1lrS3pZcXRYdWJrNmVNYnNMWnFTWko2?=
 =?utf-8?B?ZjJySFlhSURJM0NuOEovajdUWGltVDIxWEdrTklVQWNsNWVYNWpnTll4d0I2?=
 =?utf-8?B?YlNmOXA5R0k2YzNkKzlqRkJUZ0N2U20zVGJ3NDBTSVpjQ05tVTNKeEIzUWx4?=
 =?utf-8?B?c1FoaW5tYloydytzVkg2cWE0VkMxWjJ1Z2M1dW1DeDJQa0hHVVJzdCt4REpN?=
 =?utf-8?Q?Fn7cCSgTEfU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWdUM3JiU0xtWE1YNWlodWFBSzdDbzJFQjFrVGFValowZVNxZlExMFBZeVV0?=
 =?utf-8?B?Q2x1a1lzcC9ReVliOGR6Wlo0KzV2UzN0alJaZXo3SisvendibmZSdjc0Qzh6?=
 =?utf-8?B?QytKbVNRZmc3ZlRpbUh4MEtUZCtITGZaWm00bmhtTGhldTZwWkppMVNrYWEy?=
 =?utf-8?B?cVBtRDVUN0RiT0x5Qm1YcVRuZXkzSERKVy9mVmJJNHRQQnM1UmE3WGxJRFJ3?=
 =?utf-8?B?RW5FcEtQTXRqTHl4ZU05Sy9nZG81cGhQMVRQRFljS2Y4S2NzRW8ycklwbHRS?=
 =?utf-8?B?OTVWMmxoWHNtRDd0VHM1STRtZ01NZUhoTXlPU2Z0NDNWdXVaN09qVEFoUWtq?=
 =?utf-8?B?RzBXNmpDTklQYnJ5OGltYnYvTTJXT083VVBUdTdEZ3IzSWJlM3pQVFUyWk1X?=
 =?utf-8?B?aEpOTXUxMUN5ajR3Q2NidFVQT3JNSlRIUEU1dTI4bnRjQlU5NElYZiswMkVv?=
 =?utf-8?B?SVdYRm1DUHFudnFTZmJZMVNodWp2ZEtjbWZ2T0l5SUxtbEpCZDQ1aEl6Y21M?=
 =?utf-8?B?N3NnMWJ2bURPNkw4VkRJUEYwd0Vud0Q5dldEdGV2TGdEY1NsQjZtY2I4VHNG?=
 =?utf-8?B?NHZqZkMzQlc2MkEyM3JPMnpmMDEyQWZuR2ZTNDRWR1BRZjhXODJOdE9DT2hI?=
 =?utf-8?B?VHdBRllqUnlPd2tLUllUeFFtQldKWHFqY3BBeFRNb1hTSVhudFkrTGVWVlBE?=
 =?utf-8?B?VzY3S0RFdWZVUzdURmduU0M1R2xzekN1YUx3U3BuMDdOK01Xa3lPTkozcVZP?=
 =?utf-8?B?Y2dzejlReStwZDZYVlBjZHVJekJ4WEdHQW95eCtpeHdMNTk5QnRXQmdvd1Jn?=
 =?utf-8?B?czRDYVB4bXFTTnFqNUJXQ0RYaDI0ajlqbUxuM2tmb1FpMGVIeXd6Mk83Zm9j?=
 =?utf-8?B?WkJTaXlNVUNIbFlmODNsOHo1a0prY01UZlI3enRJWG80WW1WWEVadFFXbGpW?=
 =?utf-8?B?aElTWEgzdXNsWlVsWXVIYkFPaE53SGZ1eERoRVNuTVh4SFZaWEpYOFdaeVJk?=
 =?utf-8?B?RndkdHNSREx3M0wwVHI5a3VJTVVmcVplRHhtU0Z6R2VsZ0taRlZ5bHV0VndL?=
 =?utf-8?B?VlhQRUhDR1RCck82ZUNXQm9ISEdkSURiQzc4MTk0WDF5K0NPNElXWjBoZ3Vr?=
 =?utf-8?B?cS96eGJiR3Q0VFkydXdNTWtRa2hvUk1lZ3JFbWJ4UzNyemRBbjBJdW4wY2s3?=
 =?utf-8?B?YzZjWnVCeHFBZlYvcC9SWmQ2MGxTaEF5dDdhTm1WY20zRHJ3YlJWVksrOUtr?=
 =?utf-8?B?OWNjVHkwQlA5eVNJTnlsMlhicnArUUpuZUhhOGdFR1FxUk5hWWtEdEhvdng3?=
 =?utf-8?B?TzNzVlJKS3F1dTA3VVJWTmZDRG1oUWxmZU1KYmlNLzNGa0lnbnZiR2JLai82?=
 =?utf-8?B?NThmNWZDaS8rQ1ZUV2RvcmlITllHU29DTC9ubnVVTStxc01kT3RwY2Z6ayt3?=
 =?utf-8?B?eHJIZFZXTCtRR3hQdmRnbC9rcXhzVFJldngrMHFSZjFBQkRHOWIrL05tM0xl?=
 =?utf-8?B?S01wY1lZakVidjY1bjN0R1lnZXVTSFhrR3FPOTZ6NEwzejFscDRBSjlFeXh1?=
 =?utf-8?B?dlJkK1RPckFVZ3ZCSC9mSW1uZ094cC80eWFtT0swYUl0VG95NzFZaHhQU3dC?=
 =?utf-8?B?c0tLdDNhbDZncXU0ZnlDODF5a0VXMDRkQWM2KzIrdXNidE5wRko5RkIzclFX?=
 =?utf-8?B?UFVCREZtdGpWdkZTVWs2Y2NpTWNIdWs4dkl6VzV3c0luNHRSdUVCdWU1emxx?=
 =?utf-8?B?aktaZHlXTXdnUWlvZUJ6alN4Z1J6WmY0YUlzR0VSWC9HM0dxeVkzK3NHOFNM?=
 =?utf-8?B?R3ZHTTJTdlNob2FyczYyV3RqaU1kQ1JtOXJMTEZjbW81V0VvUzV5OFRSVVgr?=
 =?utf-8?B?RDV0K2FlaVI5YkJPU2pQa3djNUtBenlPRFJicmZhbHlmN0J4Z3VEZEFCUENj?=
 =?utf-8?B?Ym5Yc2l6YlhrZjgrU1NUWDFCcmRaOVFILzRlcGlsWXE2NWpBbm9zZkRPMW9Y?=
 =?utf-8?B?Tng2VzQ4N2U1azJtRkNjOXIxaGh6YjhLY3NnOXc1WWgrOVpIT2wrckliQ2k4?=
 =?utf-8?B?NzdTZXNWZWVGZGsvQVU3M29FMjVvWG0zT3cwZkprV054N3c3b05KL2E5NmlJ?=
 =?utf-8?B?UnFoTithenM0Z0d2MHZHZFUzaGlkZHpQME9UcEpFbk9xajFnTTdScmZ1Qkly?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e3aac4c-8da0-4909-f213-08dda54144b6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 21:29:50.3137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z2HwOg9h10AHlSzxBKFaKDT1Bz883qtan1gQhsUYQGanuYJDXxwGZRftBgwjpTdg/ajDrKEuShS5DgDk8iUYxNN9sB+aYk+ceLg299pOgNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8176
X-OriginatorOrg: intel.com



On 6/4/2025 10:18 AM, Jacob Keller wrote:
> 
> the parent project already has a URL in its config. What if we updated
> the logic to just directly use that URL instead of using a remote name?
> Or at the very least, we try to pick a remote based on the URL.
> 

I'm looking into this approach still, but I ran into some interesting
issues with the remote.c logic which claims to work with any "struct
repository *", but ends up calling paths to that hard code the_repository.

It looks like those end up in the "read_remotes_file" and
"read_branches_file" functions which are deprecated, and planned to be
removed in 3.0...

Would patches to modify those to take a repository pointer in order to
allow callers of read_config() to work properly with a submodule
repository be acceptable?

I also saw that many functions take a remote_state structure, but if I
wanted to make them submodule repo compatible I would need to either add
or switch to passing a repo pointer. I'm not sure what the best method
for that is. Add parameters? We can get from repo to remote_state easily
but we can't go back, so it seems like just switching them to take repo
instead of remote_state would be sufficient.

I wanted to use the remote.c helpers rather than re-inventing the logic
for reading the config to figure out remotes, both a) to find the
correct remote by its URL and b) to find out if there is exactly 1 remote.
