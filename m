Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B0E1AAA1C
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 23:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750720022; cv=fail; b=bvPxD2PhpiE+HYSE12tZ3aI83IGBrzNlHputL/Rk+GQ1Kd09RngO29y6UBqxJVMUL007eqMgkOkcc/Eq+8kaEhtnlJeUUeTpH5WpsloqX3SEtzipfRdTF7GLuz1Vw/iQU+O1JPVeiEuWWYIa1LiyFxl64WdBYn1zHthqayfYASg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750720022; c=relaxed/simple;
	bh=Dm1mSR5yFNANOKqoDEpyzCDwOIoEmEFXgRARljdSDEA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=keRdfkev6IuWBAKk4vkQYPJ5CbQVjjMghl7BBogrTn06EZJYo8QuUMCcNRGr8gVTvJazLbzaW+jxv3VW1O+9jVxZUrcGsAT9X4N4yunQ9u4J0sXhYhXGoOJNeWxdUyAwpyTfO4yBg3y6TGU9LAJ0eesgp/6fmdLz+oTEdO8BLBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RZY8vuOn; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RZY8vuOn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750720021; x=1782256021;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Dm1mSR5yFNANOKqoDEpyzCDwOIoEmEFXgRARljdSDEA=;
  b=RZY8vuOnuipcWIBw8Nvbe5pkRsk5FpWuamvaqm9kkXcmpx2UYq2pu6xH
   bQLAqrH1HAjer4mQ6NS3biczoRsKEjZi0nh8aB5D9X/seqP/tcOrXzRg4
   rA5Kagby2e+c8F1jW/sXIqlAj5lkH5YSrQiiO/kQ7sywqWmCds+0q9wGd
   ocqZ/mv+zupOioO+SDwZ4HLSfnaANb0CVfq+8oAQxMpYaBX7MHOO/F73q
   1Idxox3IN6dyRMQRd28NrSkC0Ix9821f+xBy2kdmrLQ5/oSrFS4AkwQAK
   rrkQDPFliHR2Cb1c/yY9g+4oTIk5hSvxX05Dsgp1z6IzLDSr9fqF4f0/J
   g==;
X-CSE-ConnectionGUID: qedcLiPCS12KJMvUR11AOg==
X-CSE-MsgGUID: RFitrcIiR6mif8hdd9TcyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="63639488"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="63639488"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 16:07:00 -0700
X-CSE-ConnectionGUID: dPXc4D5JQQmiZtHGB7r8nw==
X-CSE-MsgGUID: TGrkEqe0SpKw1GTHtobCYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="152246335"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 16:07:00 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 16:06:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 23 Jun 2025 16:06:59 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.65)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 16:06:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E72GeK0HpCV4cMuAMNwMpPVqnt/7qUUu6QjR1dxQfbS3R647REYiyqeDEEUZ6WAO6IU3rPYqRI9CcMCf5GqyBigpKLBvRlSH+lO4lq3XRGhO5An4aIAE9P/unQ8ATH3Befs9yMf6B5IZCK9t0f6DesmvkZqb8I8hkV/meuG1gB40lDc8RMjh06fvYV6KPqcjy+ZWImeZBVnkDpdoNYxQ9pvRS59cj8HDNH6LYGhMjT8yvI7EcBS+s6jj+u7j+aeSW7m1mxf0vflrtnbENPm7aZLM7g0x3pkjZ1RBgqyNzEcrzFsCwykLVbtkIPzdtmtpvd1wc6vyXGoL6vF1Mc5LnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Drq0fjyVDTUXvFTOvIH3dQLMTrbQboD+9efhzARFn0o=;
 b=Mbx/qLKmXhca9zTOS+NrQwoWfp9liW996No+p9QaxK08QLWE9ORtZSghx1fSQnJeyh4WWqTt5hWteJ3r2g12WAYjBnnCkBv0tWEMODyXsWP2Rw6mRVf3ci02pzSp5ik0ndYZxbKW+zYz+c9OsQgdEwiej4Pbfu5BnXRfDcOdzeD2tVJ93LTWFypvmjKDTnRNe2rM9adU4dEOefLH0x/Ui2htUHFGduVL2BlL0//ehrHbCvXdTFqq4NaGT925zFNYhWIFvzsOgQ2wNVXS6eXxWKmcQTueDiK9r2Sf2o2l77OZ2JrWfVR0T8MKdNg0LnojTjZc4EHqQopCVy9u1scp4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB7450.namprd11.prod.outlook.com (2603:10b6:510:27e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Mon, 23 Jun
 2025 23:06:29 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 23:06:28 +0000
Message-ID: <6a61a09f-464c-49d5-b57d-1f8a4d8b1907@intel.com>
Date: Mon, 23 Jun 2025 16:06:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] remote: remove branch->merge_name and fix
 branch_release()
To: Lidong Yan <yldhome2d2@gmail.com>, Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>, "Patrick
 Steinhardt" <ps@pks.im>
References: <20250618-jk-submodule-helper-use-url-v3-0-7c60f2679271@gmail.com>
 <20250618-jk-submodule-helper-use-url-v3-1-7c60f2679271@gmail.com>
 <xmqqecve0yvz.fsf@gitster.g> <CA42712D-C127-4142-9424-2A512F9488CB@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <CA42712D-C127-4142-9424-2A512F9488CB@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0028.namprd21.prod.outlook.com
 (2603:10b6:302:1::41) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: 11960216-f4f8-4cbf-922e-08ddb2aa95dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VjRFU0ZiNmNUT3poaDM1Sm5Nb0hkdHROcVNjb0w5b2R6YXYrL1E5SzJqWUZB?=
 =?utf-8?B?ckphdmJMSTRWbWZyMXJ0MnA4RzExTlF3SWU0UHhwbkVTNEpLSFp3UWxNZXpE?=
 =?utf-8?B?bkc0UTZEMjd4K0xvUlE2aUZSZDRUMGJGYnNOTlpQdzlQRUs4aFRQY1R2UGJk?=
 =?utf-8?B?Y2hnSkJiWkdSd2kwL3d6c1RDN2VKR1J1UFArMmlCZHBkM1ZTWTVjcWt3Q21I?=
 =?utf-8?B?SkpmVU9ZalViRGRKZ3RRWTZPMk5mYXBlL1hLbm1LYnd6YzhKdmdtSXhRL0cy?=
 =?utf-8?B?OXdnZkhLT1l5RVVHUHlNSFJVbHhXVGt1MzE1SVdlR1NDU0d5TGVaN1ZiKzM0?=
 =?utf-8?B?aERNVnI0Nk9GaWUrVld4VlBYWlVJV1RiU0cvdU02MUxMdGhwd3dNWXVGYkww?=
 =?utf-8?B?S1pVQWEvRzNnKzhrQmFUY09KTnRqWnJWc1Y2ZlNBZm9acDhTU21SUFpvb2F1?=
 =?utf-8?B?VkpOZUN5QlNacGVTbElqcEt1Y2FNWVp6Z0l2Qzd6VXJta05oS01lak80QmQ4?=
 =?utf-8?B?VXQ0b25aRktjSStUUXRjS3VlOGVlQm1nd0RPMHo1NlFjZFlqcGgxTy95QjFC?=
 =?utf-8?B?dGhPVjhrem5zQ2kyNWJaY1NmcGNtajlBTmh3WmhsYS9xTVB2TDJpOVdOY0lt?=
 =?utf-8?B?dkZYWWQvaGNpOWRvWnZRNWlRU1hzWCswTmY1K1VMQmRlYXpDY05nTkFPTnZz?=
 =?utf-8?B?ZklLaDJ6Und1clVuZ3psSmJtWlFhd1hBYjRrK2hVMXBKV1grNFRCRGk1OVJT?=
 =?utf-8?B?eThTakdISUN2ZU9vYnZUSXUwWkhSRWh2dVZWclpFWGIxdVo5Y0drQ0ppaHRM?=
 =?utf-8?B?MmVMcFVoR0d2NWlaaWU3OVl1SlM4K1FHQkxjZi9DRDNFU3JQSjdRQkVJS1Jp?=
 =?utf-8?B?NlNCNkJDV05SdHV6NlNTcjQxY3F6UEU1TDlGTHhDU09vMDR1SncvNitZcTlR?=
 =?utf-8?B?YUFjTnRoSVVCR0dqWFg4SmFoSFF5c1BhY3VBM2tNN0o2cEsydGtnRmFqbjdK?=
 =?utf-8?B?cEoyZVVuZmE0MXNSWXE0SW1EdWdPa3laQ3Z4dlVaSEFITjlPTEVrU09CSWlo?=
 =?utf-8?B?OEl3V00yd3ZyaHdqZ0dOaFNycnhnVlFTbmhKMjQ1M3hjYzZ0ZUxrcFM3cjlQ?=
 =?utf-8?B?NXJ4cERHZWdpY245QWtiVFh5TDRYNmo0UFVPVEJSOTA5aWFiUUVZdFUzNlc5?=
 =?utf-8?B?Sy9qZ1N2ejYvWDY0dTBiaXcwZkZqbUdxZkFVSmp4RUU3eUN0QWVQNGVpbmhs?=
 =?utf-8?B?RmkxRExLVmJscGZ5SEVEWXoxNldQdmlYNE0xb2c4dUkvcUcrY29Td0JraDVG?=
 =?utf-8?B?eVhxZXY0Qzhjdk5FOVNNaERVblBEMEp5cFcrdXhDTlpDUnZCNjkvbG1KKzUy?=
 =?utf-8?B?azlYRlBNN01kRzhaZ1QwVE04RUcya1E2cHZTaEg5d3granFQS3lnSFVPWEdk?=
 =?utf-8?B?Smt4RDdVaUY4K2dKZ0pxSkpXZmg0VkE0WjBCNWVuM3JiUWJRbXE0QmpOa2lx?=
 =?utf-8?B?NTU1WTViQk5ETVhMSXUzVU80VEJWMjVZa21NV0hPUFgwRnBTZHI5bWhlTzVC?=
 =?utf-8?B?YUtPQjVOM1Nway82cWt4c0JZaHhqMkx5dG1iUlFmbzhWajQrWEYwakU4M3dR?=
 =?utf-8?B?SUhTMHZYUUNJRFpMdmdraDRCOS9BZTNFeGFDWUVpT1FUaWJVa3BHbzlKOXdD?=
 =?utf-8?B?QWUyVFhjYytuZlZ1bnFTejVCYVFqaUZaNGpJVUp1MnMvSFdVVXc4T3ZvN1RV?=
 =?utf-8?B?NHYwTGlDeFNObUNwcHFEUHdOOFdEQlVrdnBxMzU4L3c4OGQ1MjU4QkNhZFNt?=
 =?utf-8?B?QTgwMFBvTkR1TFIzdkZ0Y21lYVdiSXFYRUNZSS92cmt0d29xczFNcFlucHYy?=
 =?utf-8?B?RHdoeWZLRnVHK1hQME9ubjJob1kyNUowaUtUcGh0OWg3ODh1TE1ISnVqNHZH?=
 =?utf-8?Q?VaHG9BvjvZ8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mms3dVA2clFsRi9VeFZEcENuTURrR1FOdGs0SUorK2E0WDB6RUN0OTllTnp4?=
 =?utf-8?B?clpTUld1bkl2d0NjS1F3UWV1YVl4VWdoU2JlTW02bXRMSTBLV2F5a053NVFw?=
 =?utf-8?B?VWJsMW1NNlA2dTBPVFpOMkxLS3JQVENLSnRlRHg5a1Y5MDVSWStxVk1wZnQ0?=
 =?utf-8?B?N3puWFBPeldDT29MRUFCaVgrYkNCUm1uWGNaWGtwZUZPT3dpUnlITWdNYmdD?=
 =?utf-8?B?ZTVhcEZWa0x6MW43eEg5NFhJZ0lBV29pOGs2LzNFYXJnQ0VQaXVVWlAyVW82?=
 =?utf-8?B?emtIV2NRWm1TTDRDRzRhQjBBK21FVVluTk1yN2RTdG15Sk5yMkxySTNJQ2Jt?=
 =?utf-8?B?M3JGYVZha0xOclZmUWR4LzJSV0FVZFB0VEJwemRad3N2QlFDN1dsSlVWRHl1?=
 =?utf-8?B?a2E1Ylh5UGNaVVUzVkx2WlYyZU1zMC9sOFAreHMxbG5uMGxpZUNKWnhJVXpT?=
 =?utf-8?B?aGRaQWRXMjVxMW1OUjA3Z3RiOFQ5ekg4OWVCd3pROGZ5aG16M0U3L2w1M0s2?=
 =?utf-8?B?dW9xUUE5MUtTR2JlZHNwZWNiTkliS1BsOUhISGJYMWRHYzZrTkRVbUdGaENV?=
 =?utf-8?B?SEVBb1Z5TkY5aFlhUk5ESzRwRnFyemV1OWJPeFBLWDhoUTJiMGtDWkxhbWll?=
 =?utf-8?B?a0hHS1h3MG1sREVRQjd6L0FYbUtlVjNuaTdZazJSUFRvV01PTEYvQmRRL2dx?=
 =?utf-8?B?QlVkRUZmWFM3bjliZkd2VmZhS0dxRzFhZ3U1TmF1bDczQVVJMGZLQWx2RkxL?=
 =?utf-8?B?eWN4K1NVN0R1aDFPNTVTM1ZEU084dHJQWjBIanRiR1V4NWdqVHpMb1d3WkVl?=
 =?utf-8?B?M0dQdkg1ZGlEQlpjbW5kakdiTzc5QXB6YVF3T0UrZUpqWm1URmdENHl1a0Uy?=
 =?utf-8?B?dFYvb0sweVFDNDNjMGdGVWhJMEl3d3RaV25qdSthelg3SkpuQUMrc1o1aVE0?=
 =?utf-8?B?dW9wRHpQemZSZWtvM0dseURXdGF1b2NaYWZzanRpYUJ6OGtLdm5TamNzT0FV?=
 =?utf-8?B?UThrckVJMHdJM25mYjFyVU0wdmFtSjZscm94elMvU0FGVnJmeDRhQXlzcDBt?=
 =?utf-8?B?RFpaTUlpTENYQUo2Vld0MnZNazVvaUtpKzZ0dmc4UDBnOGVlbUxVczhNYmZl?=
 =?utf-8?B?U3BZc0JCN09TNjExM3NNdnNldHk0YTlJUWVhczlEK2s2VjZoS21yZXFlc0Fq?=
 =?utf-8?B?bTRUb2dobHVQWXhMcG5hajhaZm1DUEtCbVRKYzhjemExbFcvQnB6S1RXd0hr?=
 =?utf-8?B?bVkxOGlQamFWemFMc2RESFZ2Vld2RGNQMWRwRDJpZlBPVEh0MUM4bitYdzFP?=
 =?utf-8?B?a1IzMjZ6MlZhMjN1Nzc4ZTFPNFlLcmRNNUJnVlBmaDNaYnRDcVlaaFRoNEp5?=
 =?utf-8?B?QWhYenR1aFM3OVFrMGJoWW1hNi9yQVRoRlZLOHJXS0lBbDZ4TGdRQ3V3c2VI?=
 =?utf-8?B?Z1FlWnhCNDdTOUZSS3NSZFh1OFhpTlZvbGNDbmxtd3N3cDhleXFOcTY4T2Nr?=
 =?utf-8?B?ZTdXNnd0azlzYmpreTZqanpBSDdRWk9VTmY3WnpqdHluQ2VvaER2bEVBbzBh?=
 =?utf-8?B?UHc0bkFzUlFWUW5pK01jZjl0cFRWSW4xZ1NSRWVOQzVMZXY5RGhUTk1GcXRG?=
 =?utf-8?B?L1dUV1RySFA2eHQ2TGxCLzRGaWVkeVF6YlUvRVVVbzFsQUhmWDBnMDNKUUlB?=
 =?utf-8?B?WkdCd25ybU8xOUl0MDc3QVl2Q3hkZkw5ZWdUckRSOWkwbGJYSGh2VzAzbTFu?=
 =?utf-8?B?Z2wySXVwVEpZWHhocnJDZlg1TkQ1SU02ZExqNHZ5aFNyeHZGL3VRQ0dmdmpJ?=
 =?utf-8?B?eFFaUFZPOVNaTWt1QnZlTkUwZE1YRzB1TjdJTC8rbC82TnFhQTFzZUtQRjlZ?=
 =?utf-8?B?U2dJVkE4d24xN2llYUFiTWVjSmMzTE5KMXcrR2tMUWFleEdxR29BWlU2Uk9P?=
 =?utf-8?B?RmVKcG9qM0R4bnNoTWhtN0Y2QTZhN3A3SmtobEN3dnVVcWYvQkhNSTBPMFhP?=
 =?utf-8?B?UExGcElsUkh6QlhIZTVrdnhLVm5oTmlxVVl2Tm15eFBSNmthQzlrbU9mek1s?=
 =?utf-8?B?a2s1eFpEODFKa2gweTB3ZzBpR3NKbkQyWnJZaXZTV0x3c2w5WXp3a1VXT2dP?=
 =?utf-8?B?UEZ1MEdqQlRDc3Q4ZTVDMUNhK3NLS3N3RWFlbWlsZE5Oc1lIRHhjQ2l3Skcz?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11960216-f4f8-4cbf-922e-08ddb2aa95dd
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 23:06:28.8781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZyPTBxLzAch6Gzhc9uOBtnqVj84OwcvstFrjbUF2Bm0kpCYFHs+eJWA0ST2tCa/8+QrdECq1WhpzrHnm1H69HwTgeLSaxQqFwY2kRiToD6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7450
X-OriginatorOrg: intel.com



On 6/20/2025 7:12 PM, Lidong Yan wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>>
>> Jacob Keller <jacob.e.keller@intel.com> writes:
>>
>>> This end result is cleaner, and avoids duplicating the merge names
>>> twice.
>>>
>>> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
>>> Link: [1] https://lore.kernel.org/git/20250617-jk-submodule-helper-use-url-v2-1-04cbb003177d@gmail.com/
>>> ---
>>> remote.h       |  4 ++--
>>> branch.c       |  4 ++--
>>> builtin/pull.c |  2 +-
>>> remote.c       | 42 +++++++++++++++++++++++++++---------------
>>> 4 files changed, 32 insertions(+), 20 deletions(-)
>>
>> This unfortunately makes t5582 segfault.
> 
> I used Clang's Address Sanitizer and found that the segmentation fault
> was caused by the following two null pointer dereferences.
> 
> ==501602==Hint: address points to the zero page.
>     #0 0x72be47ec6ce1 in strcmp ../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:465
>     #1 0x5d7e2f246b11 in do_fetch builtin/fetch.c:1732
> 
> ==501614==Hint: address points to the zero page.
>     #0 0x7b9812ac6ce1 in strcmp ../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:465
>     #1 0x64e39a76cdc1 in get_ref_map builtin/fetch.c:555
> 
> I believe this is because we didn't update the corresponding
> branch_has_merge_config() function. In the previous implementation,
> if branch->remote_name was a null pointer, branch_has_merge_config()
> would return false. However, PATCH[v3 1/7] broke this convention.
> 

Yep, this is likely the correct fix.

> The solution could be:
>   - Replace !!branch->merge with branch->set_merge in branch_has_merge_config().
>   - Replace free(branch->merge) with FREE_AND_NULL(branch->merge) in merge_release()
>     to prevent double free.
> 
> I test my solution locally by just running t5582 and it passed.
> 

I think the FREE_AND_NULL is a good improvement too.

> ---
> diff --git a/remote.c b/remote.c
> index dff76e4626..ee95126f3f 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -259,7 +259,7 @@ static void merge_clear(struct branch *branch)
>                 refspec_item_clear(branch->merge[i]);
>                 free(branch->merge[i]);
>         }
> -       free(branch->merge);
> +       FREE_AND_NULL(branch->merge);
>         branch->merge_nr = 0;
>  }
>  
> @@ -1788,7 +1788,7 @@ struct branch *branch_get(const char *name)
>  
>  int branch_has_merge_config(struct branch *branch)
>  {
> -       return branch && !!branch->merge;
> +       return branch && branch->set_merge;
>  }
>  
This is probably the real "fix" since branch_has_merge_config should
return false until set_merge is called.

>  int branch_merge_matches(struct branch *branch,
> ---
> 

