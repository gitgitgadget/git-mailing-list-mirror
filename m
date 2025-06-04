Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C72320297E
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 17:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749057778; cv=fail; b=lL+2UObFZSPdYHekYpjBcB7DNo8OsrG33j0sjjm50IA2FaFnbPrSKOkcBWcgfeDTin6DEEItkr5oKzsAGPQwwtQc0bDpelSXtY3o6HaDd0XB7ir96hqcUXUzbts6CvsYXA5lAiLkgq1ZqBf2vuSVZw7r8ZpvWzCbqQoyVzZdTi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749057778; c=relaxed/simple;
	bh=CL99b3xSw3MrlDEFC0qrj3SrnV2IVvMvdbUhXgiPQv0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AW76mac4jYfezK6FXpejNM962q8D0+heIklVTF0wq4Qc1B+DATEqh+Vp1vEOGpG+nf+m3WUdS8AW22a1sF1Aj0JBja50XpY++eeyambEcwwASKZVCHZ8/LnbcCRS66g7lj2Z+VNXmPBVTMR/VOkEPOl8r1vOa8wPzYzctEkUUfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cqUAsjT/; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cqUAsjT/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749057777; x=1780593777;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CL99b3xSw3MrlDEFC0qrj3SrnV2IVvMvdbUhXgiPQv0=;
  b=cqUAsjT/tnfx59bfW0cMCYv7NBWbidQmcwGROYB1f8OfvR12LtaUhUHz
   pyMXLUF/Gg3B1Db12V9KAQ5o3Vx9PwWdqmCwZt+hf9MKkoP0QafXqW+mc
   xx+65bMKWyukO/yij2CGEx5tNCLLISjztbOisQVlYXYiyqC4RtyHkYQ+K
   tDH9dtnjo6BaCzjmT9P3WRT1N4vrJ6fQNpU8x9RMHx9k3mQEXvxInmX/s
   siDiQ0zUowSH8d2NUo+h261MwcMjWfi5kr0ehJd8Clke+zqASTsM3U2Q4
   KZzKlTYqCkceiP+T7cCRppWM0hDtDqvBjsyAIGXB03NJy8sHDvg8mEUZK
   w==;
X-CSE-ConnectionGUID: a/Gn0exeR8mtSb04Qz0wLQ==
X-CSE-MsgGUID: /QdarMcaSe2xLkfI+j5sqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="51302346"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="51302346"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 10:22:56 -0700
X-CSE-ConnectionGUID: xG2B87LZSSK35Z4LHghemg==
X-CSE-MsgGUID: FraZVsa4TrOyseOv4z52IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="146235619"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 10:22:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 10:22:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 10:22:55 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.54) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 4 Jun 2025 10:22:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFpJRK0tTWzofdOj9mOq7vz01Kko9VEdoK6pst9GiyUWze+BF3O0iFVjjcQWPTWVoT6jRjRzEWuCoQ/Qjwl3sX4XCWB7tM6L2cnrgy/L5FzIsedqJYW0v8NYYaRwSWxEl5aJcTHK8jXFmpQObeEpLvBRgELrdO54weY5Uo7tiG8ZKjsysIhDl/yxBNy5RF/A9y6Y7PCbF/XzOusWtplJoOGZp0CtkP1zPIy5piKw1E0WmbRK7f7GOsj7DOMow0MHlgqV/OMS/U8fECGVY/r2BU4t1YGe+Uxf3FdFJXXWtqEI/mVhHha9m2nWgEJyM8uQGUHrHeWdtk5SREQuZmhkPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ed5GlBJgeJKGytAKvCEilouItejBM+qCXlbsZ7CuY8=;
 b=WWEnuHinO3pVPx2A/TC2Lj8RcRdDBlYj/K7pg/n8Coe0j/5re4eIo9NNV/kbaig3nkxx0qXVDFPQW5LNa7XYsTAaoSrCGJfJGimK11PagKNoLztsoKxmW5vi97NMqNwE8iyI8p78CdYEPfkMv6b5R0PS9ncpUWroC5u7Cc5o6MaF1Y6gMvMSmnH8uydROh3R15tu/DePnPyRDSsdyOkZoEDT3+/vJf4HpVYKxZAfPThDD8eFaTdXIRyyrrIkC+SqIQ44GPl1VoDCGpDMAEy4D5ZF3BsrJtPo0Y/01KLmkEQInkzcyoXc2yisB7BVtRY6GRB0fDm+fn/z6KbASESWug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by MW4PR11MB7055.namprd11.prod.outlook.com (2603:10b6:303:22b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Wed, 4 Jun
 2025 17:22:39 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%6]) with mapi id 15.20.8813.018; Wed, 4 Jun 2025
 17:22:39 +0000
Message-ID: <a5bc1851-e80b-4795-8aaf-46984b0cdfb8@intel.com>
Date: Wed, 4 Jun 2025 10:22:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] diff --no-index: support limiting by pathspec
To: Ben Knoble <ben.knoble@gmail.com>
CC: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, Jacob Keller
	<jacob.keller@gmail.com>
References: <20250521232917.2333291-4-jacob.e.keller@intel.com>
 <374BC043-8FB8-4052-BDE7-6BAE7F182994@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <374BC043-8FB8-4052-BDE7-6BAE7F182994@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:303:8f::18) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|MW4PR11MB7055:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d90e5c-ceb7-4ad1-5e1b-08dda38c6810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGw3eWdnc2VlVjkvcHltNm1LVUVPSXlrSWl6WndnbFFtYjVHLy9HZE1mVFhG?=
 =?utf-8?B?TERJOGk2RjNqSC9tTjJHNkM2VTZldFNFK3NxNk9rVXFoS2ovSVJ6Q3dSbGpo?=
 =?utf-8?B?MmxyMkdzZDVMMk5Ud2pNVkYwMXRqSVJLWGZvWUVpSGtTUUlrNnBkbHJIZW5y?=
 =?utf-8?B?dk5WTHpJZktRMi9RNE5icEhrSzliYlQ1czVzSG8ySGVUREthSXVseS9NZlBr?=
 =?utf-8?B?SlZqN0FzaHUwZnpjbFB0azRKOFFzdGxBWC9STExlaUNEd0pya3NzYmZmZVV4?=
 =?utf-8?B?SGwySVlhUjE2N3llUXd3RE91cnZpNHI0UzJ3MVpBOXEvMng5S0RibEd0RzFL?=
 =?utf-8?B?d0JxYjkxUC9HUWR5L3c4aTIvL2wwdXpRdzZtcmNEYjNvWE9rcDFJOTVYMGQ1?=
 =?utf-8?B?bk5iMEwreGIxN3o0MnRKYnJUeEdDeTR4bkZqODY4bkludmNsdkp6cmxXc3NN?=
 =?utf-8?B?YXJ0YTYyOEhwbkxraXRaUXJOL1k0RFZLV3dtYTJpdHBxa1lkcU85alJyZmdK?=
 =?utf-8?B?TUlhWGpGTm1DdCtrRk92SmtNRVRGNkxJeklOcjVRNU1JQVd5cFJLY2JielRE?=
 =?utf-8?B?b0dURFJvZEVOV3k2N0V3QlhZb1N4WitWaUs3TlE2K0t6SnoyeEgwMTFhQ3ZC?=
 =?utf-8?B?MUlYbEVURmdNSjk3RkhnNllzQUxWTjRyZVY2ZzUvSjdXOVBPaXN6c0d5UDFC?=
 =?utf-8?B?aW9wOWl2S3A2QWNlN1JLQWhWQ00vTVVoak51MGd3dG1PaGZNb1NhUkMyVE5E?=
 =?utf-8?B?VjlrQ3BOZGJUU2o4U3lxSi95a1hpaU1Ic3hTZEpoSlpiRERvTlNCNDMvRG5j?=
 =?utf-8?B?TktlMU5wVUtVdnR4TnVMZDU4eVdMdzJkajFrWTc5bGhTR3NRTFZQRW5qdXZ6?=
 =?utf-8?B?TWN4ano5Ujlra3o3YXlmbHM3V0NVOEs1Z2RrcC9Hdm00cXFJY3FQQzBrRDhp?=
 =?utf-8?B?ZGh1N0cvRnExMTNvQmZ4Ti96dFFGSksvTlNpMENTY2VCU0hYTWVnOUMzS1pP?=
 =?utf-8?B?dEJ3TVVLTmNtTlhWT0N6V0F3TnMzT1Zhc2pHdDYyQWM2WnFnWkI5R1FwVjdG?=
 =?utf-8?B?YloxUGU2QmdPYUVIaDB2ZUFWR3lTbWgxeFFXYk5Dc3J2N2RJTExoVjJ0Yjkr?=
 =?utf-8?B?UHp0OFNMdXpkU2lmRzV4SWh6bnVVOWNXKzBjUWRPZjFGNEUvNTdiTHFyaWZ5?=
 =?utf-8?B?Tk9tSnZmcUp4WHhUODJLV2Zvc1JCeUh6Nmd5T3dZOWs2eS92NDlWVTE1akVH?=
 =?utf-8?B?dElSdFlzcHEvMTFvYTJ5S2R4Q2dHN2NBZVpwZ01Id0NRUTZ1VEx6WFBKbDkv?=
 =?utf-8?B?ak41OUQ0WWRzRXJGbzlQQUk5QkY5NUZZYVZERGgyVFE3NlBVUUIyZVB0Sk1B?=
 =?utf-8?B?NWFtSndLNzI3bS9zOXVqUDkwVkR2TDZUazNkS0I4QjVaY3dHemlpTlBoZita?=
 =?utf-8?B?RTNhT2ZzV2U0ZkswVFJXRkREUXdoSm92TDJFVEVGUHZoYU9RR3hkUkVOMnpp?=
 =?utf-8?B?M1Y5REdQTmllVUpWNHg2bGRDSnpBVU43a2VMQWVocE92QVlzU0JzTkZGd2I5?=
 =?utf-8?B?TkdJM2JXSVdNL2RZQXNJUHkrL05lMElYb1NqWWZhenhvVi9JaDB3VUg2cm1R?=
 =?utf-8?B?ajl4dlFVUHk1STFWVWJzY083VlpwUzYvUGkrbnMzeGh3ZS9Zb00vbU1Ga0ZW?=
 =?utf-8?B?YmVYK3pFUC9weGRjZ1pQeUNNL0RUNnRBR0pyckpGV2FobFVuUEMrK2M4OUpB?=
 =?utf-8?B?aUNaOWpBaS9WY05LYm5Rd0pGRkNaSkU0elBmSWh3VHZsQU5ZWkl2clZWbnBP?=
 =?utf-8?B?Z2UwQVQvYnBnZnNEd0VLM0w4L25Mckt2aXh5K29Db1pENVhkZzUvQUdvQ2hU?=
 =?utf-8?B?cWxkamZGMG15K0tCcVp1MjREY2NCQmVHQm9adHlCMGo3VkxCSVlOeCtsY09Z?=
 =?utf-8?Q?fTX8OnzsY3I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjZKUk9lVTJ0emVveVN6UTFIS0M2bUFOcldvQXcvcTVGQjVEcklQM0JUSWxy?=
 =?utf-8?B?MHBZa2xzYVZ3RitMSlY4ZGFuVU1kTUVYbC9LN2pna0JZQnArSU9tNllNcjdU?=
 =?utf-8?B?ZTNZc2FrY1BjSVdzNDYxMmk0ZXdpWXJNNEQ5OXU5NWgvSWVEZUJiUHdGZDVv?=
 =?utf-8?B?ODR3bERqdERxbVBNT1lrMlVTOWU4MUhQcHhMMDlIVEZnOXpTM0ttNE9TNDhO?=
 =?utf-8?B?NmZEaXJFNFlybit2RGs0MVI1YVFBdzNJdXo2UlQ3ZWJISWZ2c3hyMitLVXA5?=
 =?utf-8?B?cXBFcVNkYjJwM29yMUY2SWtVQVh6ekNsbkpNSUc3WFVCSFRVTkZZdGtWMzVo?=
 =?utf-8?B?UEJlRzhYQUNLYXpWb1BZZGF5ZFJlNHIvR0ttN2tnRnZiWTJlSmRDbzRvYy9E?=
 =?utf-8?B?ZGVEaG8rNjZFZnYrYVAyd2FXVU42bWRSYUVRazBLUk85ekRSM0twRVFQc3Jv?=
 =?utf-8?B?YVRsb0Znck5vbDM2b3JmRm1YYUQ2TUNlZnBQaXZFTm91T2hSSmVIRTNWeVZQ?=
 =?utf-8?B?dWFXQzRHMko5SHlONFN1T29ZNFNKaEZwN05nZ0ZmcXVadEM0ajlYb2NudlhO?=
 =?utf-8?B?dXcxU245SXRrNDdvNUp2UGx2VHAxMndKalJMczZwUUxGQ3hEMlg5aS8wQ25p?=
 =?utf-8?B?ZDk5c2p3YjVFalordXpJanRKR2lDL00zWGlSNjh5LzY5cnNTUVZpNnNNVFdr?=
 =?utf-8?B?OWxWSUV6aFRkREpUZXFhZC90QmRnZVY5bFlwdHJMZWRuTDlxOW5xWEtUVHZY?=
 =?utf-8?B?S0xzTFptdlJ0TCtLaUZTa002Y044d0hSS2RMV1NIZFdNUVNnQUQ1Sk5zRUtO?=
 =?utf-8?B?QUpVMGJSYlk2Z3d6YjVuYlRLTE1XMk8vZzVIWHpYTzM4VWxsNktpUmpPZm9J?=
 =?utf-8?B?ZUJQYnpiWkdxV2FJRmVGQlFlM3IyZHdOTHhjSW1DMytYK1dBUy9SbGRkOWtU?=
 =?utf-8?B?UzZSbFVWa2t6WWN6NWN5V3dWc2VqUnU4ZXdOdGV4ZnFCWjNxcDY4K3RRRWNP?=
 =?utf-8?B?TkxKSm9mVVE1UkwrVVo0bkRjM0NPMkg1b1BvcExTclZWOXJTbGYwRkIwTUxN?=
 =?utf-8?B?K3FQeXF1YmNjangzc2JFUTI4M2FsQ0V3MEY1TmtLaVdxamlpMTZZanZ6MWZS?=
 =?utf-8?B?K1F6Qmt3VnlMUFBhendQajVZZDlLQ2xiazVLdzhmaytiMTl5MzVDZWZuazdP?=
 =?utf-8?B?S3hmZDdIbU5zUHBrNjdTekRRZnoxYnZuaTNuV1N0eDhxaEN2T1dTcnVCZWFG?=
 =?utf-8?B?TWNRaXhnSlpscU9NbWVyNyt3ZkNmbVJZbmpSYUx6VzhRY05lOFpkeldveS9T?=
 =?utf-8?B?b1lPcVpEK2xLbnNITHg1NEdFYzRqbmdNekZiTlNtcm5IaHhSVGRrL0kyVjZl?=
 =?utf-8?B?Um52UU1RaDFGUVhLWjVHWE1YR1ErUTVtcUxNS2JyckxENklQdUhaQ2hhRDJC?=
 =?utf-8?B?WTE2Q0x2NkpTa2ZQZXlKL1FCOWtoNVEyNzdJSWFXS1d6OVBOV2ZDS0wzWWYz?=
 =?utf-8?B?Y3JTMVJYblFxQ0hxa1VIeWk5Nmg5RWI3MzRWYXIyWHYwN3BXNkhCNXVVWXpo?=
 =?utf-8?B?Vzd4NkJiSHBZbDVxUWk5ZnNJSmtDWXBTOHFBVE1qdWR2a3NLZDBNdnppeEMx?=
 =?utf-8?B?bm9xT2VZekh1cGtJaXQ4Zlk5aDNsRlVtdGFhMVhVSmp0VjFBdUZzMkYraDFo?=
 =?utf-8?B?M0t2UWVseG5sQjFxK2xpb1RLWXY5Qzhjbm5HNEl4TDRTNHVuaytsY2RWRjdR?=
 =?utf-8?B?c3JmOTFTeWxNK1dPamNTVFl6QWM0c1A0ejFUZnEwVHhLb3JER0ptYjNTTVZ5?=
 =?utf-8?B?aUJsSTFxbjBMNWJScFd2NGtmQmhMM1liM3hjeWlhd1psVUozN2dPNTZUU0h2?=
 =?utf-8?B?eENDdklyYjMwdEtJVnZEMEMza0U2N1dMV01Cc1grbmJIWUQvQ05MQVZhWG4w?=
 =?utf-8?B?c0Y2YkloL0pzL2x3bW9UMGFKZktXMzAvczBBaFlHcS9tN2FoU2RZbUVvTHZ2?=
 =?utf-8?B?emp4ek1yUXlFQW1wL09adTlLQzdnTURLV0ZMbGJDc3I3TjQ4cUF0cG9hcHBi?=
 =?utf-8?B?SzROV1N3VzBkL3ZSUjBKdFg3c1NnK3lNL0xUdDVaYnZmN21nUm9YZzFhc3ZS?=
 =?utf-8?B?amVrTnBSS25SRmZycmlBNlFnYWhSSVFOQktIS0Q4c2t0Q3ZoU2dZbmxkMjBy?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d90e5c-ceb7-4ad1-5e1b-08dda38c6810
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 17:22:39.5317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MEGnzeNOsnNzdo8Y/kHyUm7rWpnwGgL8O5FaTAdixaM1oycm4qaGEK5RfeGQ+apKOsmTTdLsOjRzfILq1JFwcGudn0kpc3WJLnfA0ZbT2Is=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7055
X-OriginatorOrg: intel.com



On 6/3/2025 7:37 PM, Ben Knoble wrote:
> Actually, one comment :)
> 
>> Le 21 mai 2025 à 19:29, Jacob Keller <jacob.e.keller@intel.com> a écrit :
>>
>> ﻿From: Jacob Keller <jacob.keller@gmail.com>
>>
>> The --no-index option of git-diff enables using the diff machinery from
>> git while operating outside of a repository. This mode of git diff is
>> able to compare directories and produce a diff of their contents.
>>
>> When operating git diff in a repository, git has the notion of
>> "pathspecs" which can specify which files to compare. In particular,
>> when using git to diff two trees, you might invoke:
>>
>> $ git diff-tree -r <treeish1> <treeish2>.
> 
> I do find it slightly confusing that this series and in particular this patch is all about git-diff(1), but the only example is about git-diff-tree(1). It’s not the best example to me, esp. since it doesn’t actually use the pathspec machinery (deferring that to prose only). But I get the gist, so not really an issue.
> 

Fair point. I think my brain wires got crossed as I was thinking of git
diff-tree as an example for why pathspecs always come at the end.

> Rereading a bit, it seems this message goes to lengths to teach readers about pathspecs for git-diff here; perhaps we can simplify those parts and assume the reader is familiar enough with the details to understand the implications of « no-index mode doesn’t support pathspecs to limit comparison »?
> 

Yea, we could probably simplify this. I usually try to be verbose with
my "this is the reasoning for why to do this" and give background.. but
that can sometimes end up being too much.

Regardless, the example probably should use pathspecs if we keep it..

> Nit: Should the diff-tree command end with a period?
> 

It should not.
