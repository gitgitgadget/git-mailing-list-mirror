Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144C31D6DB9
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 23:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748991993; cv=fail; b=P4b1S6ruYMeSW6D7uqIuS/CWaFUBtAEJz/L7c+jc/l4H7Zxw/sYuk+xaF4DciEWYL/rOOt4TTIHLWLjYU2OCXbt7cDFf60EmJwwNDAdAIN99G5S0emj/moNjgAXdyqUMI4ZIiY2pmHJtiCrdDnTuZXLa0zisKMwPirrEj7SuMs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748991993; c=relaxed/simple;
	bh=auG5II56RuSv3Ihpjwl8M/lYlbXe71c5t/QQifm8fas=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=ro8xV1/kYa/grVn5si28Bbg/tdseB4H+XnWZwnknYLTr/z4bU8H0vg/8P7dB5Nug7Wa0duAZFLugU6w1rCkVVNJmD+98yU0HJrkc2j8NoU5uYR6pQv24HXt1x2ZjBnnRjR066eyAaW4Ikl/yTc97LitlXcy5EXCouepuSD02o2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n2BIXrz4; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n2BIXrz4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748991993; x=1780527993;
  h=message-id:date:to:from:subject:
   content-transfer-encoding:mime-version;
  bh=auG5II56RuSv3Ihpjwl8M/lYlbXe71c5t/QQifm8fas=;
  b=n2BIXrz4dlkSHgooWDiPOUHSK55Ul+T1KcO+jLivDxb+4Su5kNZnWokG
   cbRp3oQpXwMhdkNW1R7Gw7TsfrScWUGDnz52ITpc+F9ChFoJFVLbHeCUG
   bHCZ5YmocXHLhUHrwGxsSvILJLVLNpOy/T53x8x5qsmWIKqV9UXfuca/p
   awFxt39mNihsRUsd8Y7nQEvJLD55vq3yK+pI+MQJFqRYIeWStPTZba3iB
   y5woHmbxtLsaDsq2ktYloy3f16Hs5+Kv7PU1yQVAic4VOr6cPnTz8qRHt
   hFbGIVpvBG5hSMb0Oz5TRwzTjL6zJUw9Jkn9xi6tqdAaXkWiWjGO74vJN
   w==;
X-CSE-ConnectionGUID: 8rJM8pfMQlO/xukwwuWZbQ==
X-CSE-MsgGUID: uyWrFyekQMmmQ3riOww0ug==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="61318983"
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="61318983"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 16:06:32 -0700
X-CSE-ConnectionGUID: 43C48KxwSSCIBPsKqlOMrw==
X-CSE-MsgGUID: mDGAvWHBS5iHxib/WMVApw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="182173997"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 16:06:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 16:06:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 16:06:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.46)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 16:06:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Umr4rsxUyab0Lmfi+MoMPlMSOMsSuM+mL4FKKp+/fjOpLr7DQX2W7Y3sRfhSeaEQEIO2iPiHkKyzmPPrGa09F03J88KpAGgtWLxLfblNnmUCgQSXVH6D74HeDLdcIgD8Pq3OLQ0wsl9mA21Qa3bwzZihHMWH3yw56XQC5uea6sAWncwzPf8uEJ3ZiUnPm5RYt8o0VgfJpGrA9MLh9wi5mU7MdVPp6CBIEXwstw1OvfTViKI6QbF2s1gT2dolctgo3LEfkUtcBYQM3wda0hd8Lf37shygjZbqTVFH3jeBzyHd3Ez6uq8VHb4HQ53JvVgzrBejqYusBtMhlSYKVP5EVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEW5lbv2INPrs54+JcF94Orl5M11nYE9lnjcpyKDV0s=;
 b=tc0GGeBPJfaU8zw5N+uaCWzJ+VDJ8xKZMR+trLCPBH+j7qiuEmwaUnloEygWqGxAvmn+jhsfqZwhGc+daox6Xss5iQPgEA5HdtUsGrWwLGU59x8u9st/PYhPFGzBKC0nXr8LPLn4xk4IwL8glEUy/y1rFTcNo7QWTwr2NLsS+uIxFGJkcC4gBGZMDweO7RiY7Agnmq+K2bYyliwu+WbHQQ9t+dYpahoAFEcTJracwlHDLU0dHo44BW8g2u5SwPTIbsUQfU5/o5H18GDUP3TWPWfFrcd2+1UsuQXEicbhULGZCyX4ingl1HVEH+2DcvcNktFRKd0f9/0ePK65B9r3Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CO1PR11MB4961.namprd11.prod.outlook.com (2603:10b6:303:93::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 23:06:28 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%7]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 23:06:28 +0000
Message-ID: <4f638125-39e0-43a1-9c58-35c2d433042f@intel.com>
Date: Tue, 3 Jun 2025 16:06:27 -0700
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>, Git Mailing List <git@vger.kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: issue with git submodules and a clone.defaultRemoteName different
 than origin?
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0144.namprd03.prod.outlook.com
 (2603:10b6:303:8c::29) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CO1PR11MB4961:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd157bd-3402-43da-7bb2-08dda2f34584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cm5RNWZkcS8vVEJDaFRhYWtQNFBKQXcvQm9uVjIwcVM3TmlDcGdLU21oVWM0?=
 =?utf-8?B?MTFDbTVYOHhISmJaYUFNYjVCbFBoTWZXQk85OHF5UUswdE9UcklzZnNReUpj?=
 =?utf-8?B?RWd5Q09hYjFvRnlKR05pZ2hkVjVjRk5pNnFIZkhhbEtHbnJIVlFDM085Tllp?=
 =?utf-8?B?UWVmTWZ2MmZ5czBEdGE1NWU4RVNQVFFTdXdGVkdUMEk1ZnJpZXF1ZjlNcXdU?=
 =?utf-8?B?OUJKWks2aVdTK3lyc1VlbUp0eitDQkFNVldMVkpUWE5pS1hiQnN4NmlOQWdm?=
 =?utf-8?B?OGdYOFNuVXRTbkF3U1NEd0tWQyszNG43RUx5V21HWkJPSGtFRTdEdEhBM3Vp?=
 =?utf-8?B?bi82QXZwdExVQ0dweDJ2U0hEQkVGeVhXWFlIS0tFRkRLdWRTcmhhSExxbkVs?=
 =?utf-8?B?SHBINExQZmlkVTRUa3FOR1ovelk1RDB3WDBBTlJSK21uNVhhbXlCcnpUaFM5?=
 =?utf-8?B?KzVJUkhmODkxYlJzTzYvTWd1QVVUblVUM1ZveW8zTmFucjlJU2RpUFQxa2o5?=
 =?utf-8?B?MjlzWk80Z1l0dnQ5OC9PbTZ5cisyWnBKNXNIZHRXT1I1VmxYKzlMejgxYmt5?=
 =?utf-8?B?bWIvWWVhTlF3WWcyUlliZ2czVzBCU01MQTlJdmJ2ei8vRFJPNlZaMThkSGw0?=
 =?utf-8?B?N2tVVE5KQ3M5UysrNWxySDJlM1BDUDlLd0l5ZFdwdHQvaEtrZU1nN0FnMkFr?=
 =?utf-8?B?dURkaEtnLzFJTGh0aFhGUC9iQTB2SW43VGo1WmwwT1BxK3RpalVxRTI5am14?=
 =?utf-8?B?WUxUMnNSckNFT0UrdDRqNjZYQ0hxeU5oNHZydTd3YmhhK3FuR3M0V1VWSFZ2?=
 =?utf-8?B?K1RJZUZFVmpvN1JTY215K2pJUWV4Q3RDS2NKVzFlNDJPdmJVYXd5YVZMZ2tF?=
 =?utf-8?B?anNKWDgwbFJ5UnpGRUtsRWhlL05QTjN2RllFSEdFdGlyY0lnK1pIVzl0aTVq?=
 =?utf-8?B?TjBJeEVSKzNOTy9UWWYzajg5ZGRGVW9sTWxsaFB4WXNEdVBzZXhvcmRNOWxS?=
 =?utf-8?B?N0hsbThML283aDNmRXhNYlhHZDN1ajRvTm5xTEJXeVorMFlGYVA3TVNyRk0z?=
 =?utf-8?B?NWh1djdjODlJT3g1WU9PaGpPL3hMSmh3SGFwTlJ1bmpoMktIVmFYK2xmaEV1?=
 =?utf-8?B?aGU3YnpFUS9paEZoRTFrejgwQzNUcEErR3E4S2gxVFhIcTVxbFpIOHorWmFQ?=
 =?utf-8?B?WkJRRkhiM1FVaHRaMVBEZHIzZXBHUjM5VFZwb2RqamRhTkpUT2RxZmRnYjUr?=
 =?utf-8?B?US9mdS9hcktTajlxY3I4MFg1aG9saWZkbm1DeW04MlhYWmVINHM0Q2x2R1A4?=
 =?utf-8?B?UmNTM3lVK2dxM2FKUk8reXAyVDByY1J6NzBBcU1rU0d4Qmlqd3BIOUFBcXhC?=
 =?utf-8?B?dHlTSmx4QnBXUzdGTHNpb1p5VnQ3ZU5LS29EYm9kcVJuS2IyekZITXl3YkdG?=
 =?utf-8?B?Z25WaEYvT0hxTWM2QjcxQm02QjdBekZlWkZGT285Qlo4QUlDUHVleC9IWWN1?=
 =?utf-8?B?c0VSL0pBZ3p4QW9FTHFiSnJZb3VTdlk3dXIwQmNpNHBPMmN1bjZpb3FnclVu?=
 =?utf-8?B?Sk0vSTB3YWpWQTRWZHNhWHRXTk5GRnhrL3lGR0R4NXlML1R3Z0hrZmRKSHR5?=
 =?utf-8?B?V0VFd2EzQUY4SEJ3eGgzYXJlQlhQUHE2RU0zcTFoekFhWklwMXVINVVXK3dC?=
 =?utf-8?B?NjhBb1QxTTI0R2JjZXJnUkV4NGpuelROYXh0NFNwMmUwVzExY1ZwUjJEbkgv?=
 =?utf-8?B?OFBnREZENzVXTk84VDFwa0Z2YUpGd0hBRFFESFV6QmM3TTFiRTcweTFyV0xm?=
 =?utf-8?B?U2JZUzVGV2NNZXZXTUd5eTQxVGppZnB4akk5N3VhR0RBVnVpMjNTNEoyT3Zn?=
 =?utf-8?B?WHlRUHBid0diZWV4TjkrajRMaWFERmgrV0d4Nk5PSWxiQzM3NDAvZXdNQTJo?=
 =?utf-8?Q?BtAvAJttkpg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlJSWGxqNE56eXc0U0dtVnBac0lWRDhadWswRVNxb0tkcGlKWEU0RENyRHJ3?=
 =?utf-8?B?cHVIaUZYckJNeERTTFl5VHpCeTh1Q3VEVmNvVHI5TzFEdm1PMWRWT1lrbmFF?=
 =?utf-8?B?cjA4eWFlKzZOZ1ZWL2xnQ0g5dGZMaWZRakpUMWplbFJhem9hNWs1OTJiai9a?=
 =?utf-8?B?VGRxcjBhL3NQdmxVTkV3dm5ncXJUQW8wenBXSk5hUGIwWHRFTGJTN20xR0Zk?=
 =?utf-8?B?Qm1yUVROaUhEclp3RGM0Z1VjcE16UmxDSy9zcXh3b0RmZkZiN1pYcGg4eERP?=
 =?utf-8?B?SHdrZVRUNm14MDl1NVdXVVk5QklXSXlMb09IL3FkSUhZMlVXRDVDZmV2bWtG?=
 =?utf-8?B?Qm1sSXRyNkhyallSYzM0bGxWZmNiL0RHYktVWHpHWTdXa1RVTnlJaHd0Y29D?=
 =?utf-8?B?QUVCSzh3RlVacXJBWnR6Rno5MHVPVGVFOXNYZjZQK2Ywc0p1MGc3WlAwaEw3?=
 =?utf-8?B?ZHE0N3lUNEgraFQrY0VDOTNNRFVTWUdYU2FIUzNBZm9tRGx4SG0rV01ENWFP?=
 =?utf-8?B?NEpBay8yUVZDU0E5dmFlRFgwUDFzNk5kRGppNzRSSzgwNXhIelBmSDZ2YWtP?=
 =?utf-8?B?WDJjVGJiKzRVeHZ1eHpnS2xxYlViR1NtbGhIVGppR1dFSmlKcVVjL0huMUZy?=
 =?utf-8?B?MnlUQkxpZmREbWN0YkZiVVNBeXRQVjU5Z0tVRVRrQTFQeGhWNnpMMDN4dExQ?=
 =?utf-8?B?K0wxWHU4aTR6MC8raFMyc1QxY0FZVjM1VlZVNW5UOWx5SngweDFVMVA4Mlha?=
 =?utf-8?B?ZE8xTERjcVVycjZHZ1ZlYldlZG9sK01XYW4vb0xDL3hWKy9NazhiUWNSK1Na?=
 =?utf-8?B?ckZhc1pmNWFPY2E0KzZMb3FxbmZaWUo5WENPblcrRWxWMzU1Y2VobDRjQkgv?=
 =?utf-8?B?ZjNaYmpPZWluZUIxV1hEN0taZlkwb0tiTmVpVGpkeG5VcVBzNkU2WXZSbVUy?=
 =?utf-8?B?Z1oxazBJbmpxNzkvRUkyK01xaFBWeDN1cGdoOWtMdCtlTTkrQnVLcE5YTmMw?=
 =?utf-8?B?QmZ3aDduMVdVVGFnczhUQ1QwQjNXa3RKNVhvTnM4QXZOeXR0L0x4NXJqWFVO?=
 =?utf-8?B?RXo5RlBQVWc2TG1razAwcFFHQlhhM1c5dlJhUkdvWGRKMXl1eGpPMkpyMnM1?=
 =?utf-8?B?L3dNRHpJOE5hbG5BMGl3QU00UkM1RlQ3VVdPRHl1WjJaK3NTK05QQnZuUTB4?=
 =?utf-8?B?eWJ1YzFYdHNMRHlCMXJFYXNDZ0hsTmNDQS9QOC9pdGNpTnpYYjBEV3hFTmlK?=
 =?utf-8?B?Z0ppeUw3TGg2QzM4Qkcrelh2Rm50ODBRdlhOV3RVNUIwWjhERVp4S2g2VGE3?=
 =?utf-8?B?OVduelpDYUs5bjU3UWtORzV5emppNWtpbE5iK0dHWWVXTjEyaDJNTnhYNzhR?=
 =?utf-8?B?NWIvcGtoeFdyWVI3VG04bENna1V2c3U3aUg5N09OZ2pDeFZKS1NINGx1cXdm?=
 =?utf-8?B?WnYvQ0ZoWlRZd3B6VmZreis4ZzUwbWxjVzVDVENIZUJnQlI0enlJSjN0MUFz?=
 =?utf-8?B?QUxyRDlLdHdSZWxKakFidXhHWW9iczFtNWZ1NUc3VjY4TUdDV3ZlTFlQNVJq?=
 =?utf-8?B?WmlBWnlpMHVzUFloMEZSVmZVYll2T3Z2S3dyUHhzTm1pWm5TN0ZNWkYxN2FF?=
 =?utf-8?B?L3RRMlJwRmtsQTd5dWlVaGJ0L3pwSHNRRVF5Ty84SXNDVFhGS1E0SUMrVDV4?=
 =?utf-8?B?MWtwbDF5R0pXN0hxdXVYQ1FqVmJ5MGhlRDJ3ZVpIYXlYNDhXMVVVQVdhY3Nm?=
 =?utf-8?B?eXp0UStiM3l6ckRoZk4rVndqdUdZaDRhamRsMkcxR0NyUHlYejVZR1dsZ1Ir?=
 =?utf-8?B?TGxKdHZCRnlFbGtNRk0vMW0yMHZ2K1RkRTZZbURnUnpIdnNLSmQ3bzBYVlFF?=
 =?utf-8?B?TURzVFlUSlcxWi96ODN0VWVDSzljZS9FL3hKY2lkcmxMQ3p2aVQwUzhueG1z?=
 =?utf-8?B?SlMvaUZqbllZazN6aThZdXlaTjhzT3M1bDVuZmR4TUhYS1lnVko0Y1V0Q3ZU?=
 =?utf-8?B?VWxCYjRUaHJIM3g4Y3ZmcHpCTEFTYi80TDV4SHQvTHIyK202NHNtbnFnTXJV?=
 =?utf-8?B?T0tRRk11RXhQUEIwQXdtUmRMbHI5ak5FZENObkZzTk5MU1ZGb0Z1S09GSEl3?=
 =?utf-8?B?eFRsSkRaRDZRVmtINDl2UlJlUmxaVjVBQXpjVlVSUytCRUVyOEJYb2kxZ3p4?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd157bd-3402-43da-7bb2-08dda2f34584
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 23:06:28.4945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /wPG739lhH0OrJg9w8NxIUglzj9IuBF0liY4TQ6SYd+aDotn0gKfBf3IM8eO92Sz989vhoYOoavsufC8PgF/VAD+IDxjK4LQs24JPx6fJXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4961
X-OriginatorOrg: intel.com

Hi,

I recently ran into an issue with git submodules because my
clone.defaultRemoteName is not "origin":

> fatal: 'origin' does not appear to be a git repository
> fatal: Could not read from remote repository.
> 
> Please make sure you have the correct access rights
> and the repository exists.
> fatal: Fetched in submodule path 'submodule', but it did not contain <redacted>. Direct fetching of that commit failed.


This appears to be due to the builtin/submodule--helper hard coding
"origin" in "repo_get_default_remote".

I am unsure what the best way to fix this is. I could have the function
read the clone.defaultRemoteName, or I could have it check if there is
only one remote then use that.. or maybe add a new submodule remote name
option?

Thoughts on what the best solution is here?

I'm thinking the following:

1) check if there is only one remote, then use that
2) check clone.defaultRemoteName and use that otherwise
3) fall back to origin otherwise?

Perhaps we could insert a step 0 where we add a config option which will
have submodule clones use the given remote name + use that as the
default when in detached head state?

Thanks,
Jake
