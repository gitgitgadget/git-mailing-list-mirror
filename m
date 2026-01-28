Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FDC26C3A2
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 01:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769564725; cv=fail; b=rnNFaoFN7rMMyIOcqTv3BuAg679wSmuC7O8iJ72YtrI1fM6CQJoAoTC5xgnHmZz1CkDCy1rjVClem26677dnZ2rehvDFg3EdLU3rAucTiy38a5Zx6AT0bqV3omLu0hcql0UOX/ejlEFUFs5PQcLefR8bQFW9r6hGnb9IXkyss7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769564725; c=relaxed/simple;
	bh=tTVn9XDE9LNuIgD64x9X8K2iWTdFFE1BShnI514lebQ=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=I3u+qSIvPvOYMkeA88/etwR7vt6buB6DJam9CjEyPqwESJnpmQAIiTt5o9njD8Hz5uID94ImKjb8NNNbgkrm1z92Ng/OjneYb37smFIfz4OXYkgiWQaxo9WanAyG1DoYuRaqotIubA8Q4efe4DE0RWkTstatrBD8wr6Pvsvcxao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LaDsyAso; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LaDsyAso"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769564723; x=1801100723;
  h=message-id:date:to:from:subject:
   content-transfer-encoding:mime-version;
  bh=tTVn9XDE9LNuIgD64x9X8K2iWTdFFE1BShnI514lebQ=;
  b=LaDsyAsodn57KPonL9d9KMsMR2pebF7xHJNxBdO/E7VbbuFm/f9r3qhQ
   QKNNNJL654LCtoNy+VCLD8bM5krOxnT8fghjdSsmPYd+PIxcSQ4Vd8fVL
   0O3Y2HB6PgGmB/SfVKA1NiJWay9T3FubFKuSalkZoepXFMWiKc2bTgx7K
   oZdwzB4DKriiWeSJ6S7FWehaZ+d8unesn33SGdQVB6otTOsdit30oV1TE
   fFGy0CYmVQjSb77yookW7sYqxfYUtYfh+3Q0yDH0Wso+L6RqUrSKVGjz3
   cIyn0npUgUA9JUoDpbzTy9jD9g7ju4E+CUPGhxMXiNTGfhvqkl9x+U60V
   Q==;
X-CSE-ConnectionGUID: 1tf1tkxAS+mNC8NFfAtehg==
X-CSE-MsgGUID: GvMzvPe6QniCM5AfDBuUTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="81406779"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="81406779"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 17:45:23 -0800
X-CSE-ConnectionGUID: yySRkZOhTWm9ynxXbHvU+Q==
X-CSE-MsgGUID: wv4+nCzWQROJiSlwU0E1MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="208585775"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 17:45:23 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 17:45:21 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 27 Jan 2026 17:45:21 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.60) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 17:45:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mM68x+Smf64ODnI6l5Y1gOniiGAofqzwxVjG/JGCMMwaMooSrGXSvBxvIKUwPOsF6aV+8ieXuleS62AU6RRcTenecwMNWAXbsB5xhzp0BeM+HqmXid0nuEXdlsPLNMuDiXOgwrYODI9+spmljFKj7XalVaxojlcjiQ0eGeLCHkl8rTSvKKl+hduTDCOaaQr2RxNluTvqgdPL00kpXMAV0916OG+A23CToH+o7uC8+tsrPgv0IrgzqB9B3Wf5cSGRFhpuxrjYEhMY5eK3S5CAfSOnKcQSF66bO+0Rapx4k8+JeLyfxxut8xcLiyTHdgX3y7j7FvIuodM/tsb4sZl7Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KA4HHmHTzlE5lAmIU6UpS3udHVWbwJHoDd3Z3WBrQo=;
 b=rqN8EQ1fknOTpxdJ+GXxvDCLxAy7+X1zbpU1fd+JTNyBrD5mJHnYe3pz7pq8TRtUlILAQY4/mQmI0DNicHmza1lFQws27Ta8RQoxHJutKLJEhav0Fgdtx+c+4lBlDZKG0cL/U0Fh24fE6TRqvuF7NR1zbqwulVKbzqdf0cIljtXPtMg+XELwVSCm985swAOFN2jK2IVOOh4rLG6BdE+iKGb62MST8bOU042LC79mhGU+GYHZ0vJXp4gUuNYmBmwZt2A7zCA2Nbcl9hlwG1BslpWmR5hck3XxcSf4kqQVXvAWyHlfbkRZkUP2KsFYPg+qp7ZG5eufwcWStNaqG3fqSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY8PR11MB7172.namprd11.prod.outlook.com (2603:10b6:930:93::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 01:45:19 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 01:45:13 +0000
Message-ID: <be156fc6-169b-4cc4-b44b-c77360c44d75@intel.com>
Date: Tue, 27 Jan 2026 17:45:12 -0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: <git@vger.kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: workaround for git maintenance systemd services not exiting when git
 is built with address sanitizer
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0248.namprd03.prod.outlook.com
 (2603:10b6:303:b4::13) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CY8PR11MB7172:EE_
X-MS-Office365-Filtering-Correlation-Id: 13e5b51c-8f41-485e-f46e-08de5e0ee0fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmsvMGxvcmppSGZnSEhyOEczOWF6enduMVB4bnhuNjN1bnVvOFFabTNtSkpr?=
 =?utf-8?B?ZU5wTVExYzJXUEIzaHptY0QxeklrRGRtckE0b0FHWDZSRDhmckFUTEZUOVc3?=
 =?utf-8?B?NHZRVlhIaEk1d2JGRVVyMndjMkJDNUhsQXVLM0NnMzhBNzNOeFJPUTdzS0Fm?=
 =?utf-8?B?VjBqOTJpSFNJRld0TER0c0NFRHRjSlp6S3YvMUpsRVkraTVERDhHRlVPeEdH?=
 =?utf-8?B?U0ZmeWZ2bUd0LzIwckJtRFdyZVVqcklHWUV2VVViVkRzdzIxNUIwUExIZExB?=
 =?utf-8?B?VlFXOERhbnVsSm9TaFNBRXhhaXYwZXllSnZTeDhSQUxSSmRkUk5ZWVVNYllV?=
 =?utf-8?B?MW9wNE5iOFFJSVgrLy9UQ1dYaGFFSGZzaUw3RUdXTXJURFlxUmxxTGROUTh2?=
 =?utf-8?B?WlY4cGhrVTVNQ09ibzJFTjYwRUJmNUZnMHJUVmxJR1JWYlVTTlp1ZXpvOGda?=
 =?utf-8?B?bkJCS0Rpb015YnM0c3VKQWpmbGxQU0c0VVdTbm1TT2taMUtDaGNDcEF3SHVq?=
 =?utf-8?B?WlFRVHQvQWF6M0dzVDd5ZFJxRy9rVFlFaldGblJJUk5PK3B1NjZSVDVDMVRQ?=
 =?utf-8?B?ZXc4QWkwU1FNN3E3QXBIY0E0WFAvbmVRYnlyU3EvaG4rTVQxSlNpb01INWM0?=
 =?utf-8?B?eU5ickhrRzRVUE5yNDJUZ0dNMkRrSVJhOURvRmxEU3RwdW5ZUGpReTVZTDdE?=
 =?utf-8?B?eFVJeVI1R3V4RDdmZVRXWHRHNVRSRDhyRUVIcm9yMFdsV3kzclFZdDFpbVFC?=
 =?utf-8?B?SWUwZVNDTDFIbEpicytSaXkyaW11RU5tUy91Y3ZROEJ6dm1pdC9JR1V3ZWZQ?=
 =?utf-8?B?UVl5TGlsOVF1MW9pQ1B0dHZhTFlWOFFBNk1peENYWitYbytsRGkzZDVlVDNK?=
 =?utf-8?B?MXltOGUrUjVxb2d0bVhaVkIvYlN1YnM1MXJudmVDME1heERzQW83MTVKTWVr?=
 =?utf-8?B?UlFHcWk0T0l1a1UrbVQyVmhzUXc4MnExQXFBNHpwQkFIUkQ5S2NRWlVMOTJT?=
 =?utf-8?B?M0dmVTZxbU51a1l3cDBDa1dFRXkwZ3krTWh3bXlPWUtaa3UzSXl4RzMycFpm?=
 =?utf-8?B?K0lBMU0vdWRVcFZTalBONTVKNUl3ZGhBZkZrY3hwTGluN1ZxL1dreEhaTlY4?=
 =?utf-8?B?ZEhkQmdjTURrZ0RXNFVKZllrNTluRWhZaG03bFV4bmxTWDRiejBmaDAzekFM?=
 =?utf-8?B?aFBjeFZyYnRPN1FCQXRGeURRNlVHYkkrdE9QMloxL0ZMOVN5OE5LaDVBSk5C?=
 =?utf-8?B?NmtXZHdMTFBrZUdWa1pFOUFtSXNyM1NYMVlyU1EzM2JCSm40aTFoTTYzcGpo?=
 =?utf-8?B?WSttNXd2QU04V1RCNDVFSjloUUJqTFM1ejg3VHppREprRFIwM3RsQjNiL09J?=
 =?utf-8?B?Tk1lWDc2MEVNeUUwaVZiK2lNc2IwUFJzeWxuNWV4MTQxcVBHS1RLcU9qazlD?=
 =?utf-8?B?MlU0TUt4Vy9sc25ESkNOdHlTRG10TmhzTjg3SklKWC8xcnNHQ29CeE5wYlJG?=
 =?utf-8?B?TkU1eEtDTjJpVzU5QTRCQ0I1eTZDQ3RycjBmcnlHTUlGUTlzY0Q2bGhWMk5E?=
 =?utf-8?B?azE4VitZRGM2elZkYnlody9pUjk3c0NaVXB4S3R5Yk5QbzdOK203Y1ArMk5k?=
 =?utf-8?B?Qmd6VUJZWjBBR09RcVBVWE9oMnozelRRL1huSUtaZlBYd0c0TGQ5dEsvMkVN?=
 =?utf-8?B?cG5ibm9pRUpQeU1oTmQ5RHFqZnRVU2xweHQyZkJuQWxzc0loVnhOMk0xbk1Y?=
 =?utf-8?B?VnZCbUQ4UnZMdzF5SHRMU0xrd1lFclozRFhsV1NIQlQ3RkNoTjdSMXZuSHdV?=
 =?utf-8?B?Y2R5UGJQay8vWGlDUEpQWjVEZmpsRGdScnc2VDAvZ3pBMEtWS3RJcGdjSys3?=
 =?utf-8?B?Q1doNVo3UGdJekMxZmFFME9OSzdZRXJhSnhJam1kM3pFWXQ5aFFuYXNaVGJF?=
 =?utf-8?B?WjcwVStuMzdXL3pBK1FqdlRpSUw3NC9aQnltc0NLRDltZlZPQmVRdVlpZmk5?=
 =?utf-8?B?Vk14dWxRZ2hXdFE5dkYrTGVYV2VQWkMybSttY205WmhvZFVPYU4zalBoNUg4?=
 =?utf-8?B?S3hFc0JDbW1YWlQ5NkN4RWQ1UDNvUmxHMk4raGFCemhFZE1IeGZKcm41NVgr?=
 =?utf-8?Q?jBbY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tjcva24xTlFrVllpeU51WXl5OWlUeDUxbXIrZXFvNnFTekR5SWFBM0NNazBT?=
 =?utf-8?B?UDlvT1lrQS9XejlEYklzZ1ZMQVZCMWFFbW5VSGtYMkdydzcycDJzVGFpc2N3?=
 =?utf-8?B?QVVzSU9MTklFTjQ2MVVseHNiMU9ualZieUdSMjA1elJHQUtrd245SFNhTlZT?=
 =?utf-8?B?TWNIbU1mdFprTEtkSjJ6SjNMV1U5enhTdzNsNy9OTHhpNFhuVm9idnMwSFd1?=
 =?utf-8?B?UWNtSXhPTFErOFBsRkJXcnlmazYrUStkUlVqUUhRY3JuQXgwV2lwL3lNZDhU?=
 =?utf-8?B?UE5FakVCSld4SEYvTi9JZ2VOVlllc2puUGJJNFErS2JXMkRPTmtWNkEzNnFm?=
 =?utf-8?B?UTZWZVA1dXJsTktqM1N0SXJtaTU3ZUZsWVZFa2pZcXduUUJSRkVMZWd2emFZ?=
 =?utf-8?B?bVBCdUVJSlp3MFRaOEZLWnhMb3Uwb1c1c0ZVYnFyUkdqZzZPUHI4YVRIYWdv?=
 =?utf-8?B?Nm9KamhwSE9ydzBMc2VJd3ZZMERhRjVLZFBneEk3KzQ0MEsrd0VCY2NkRWh6?=
 =?utf-8?B?cCtId0hkTDRFdXVJK1pGbnFqREFoQUNGczAvSWRiMngvWGIvWDM0NjZDWHVt?=
 =?utf-8?B?VEYvSWsybmpIdDhEMHN4VHo2VzJ5VHJzUUpxZTUxL2hwSFU0dUxpYjNKTW5k?=
 =?utf-8?B?bXBaWW9LU1lVcExRejdheCttVFBQejZvUHBNNk5QV1VuRWVBd3FJQ1cvblJz?=
 =?utf-8?B?aUdMWm9vTzZvNW9HRUVjRmlkT0c5UzdLRVR1Y21VNk9sWjNwSUQwZGx4N0VI?=
 =?utf-8?B?MkZaYjhjVlN2YWc1Mzdick1EbE1tY1grWG5xM3JmSTdEeDlENHhkeVp4QzRM?=
 =?utf-8?B?bjFENWFBYlNzajkzWlhQS2tFS2NVZnVFRlFGNVgrd3A4S0lmRCtRQjVFWGZW?=
 =?utf-8?B?K3hJcWJlNndvWUVpUXhYdEZEQ1FBVjBVY3ROUEU1VWRaQm5qWkJZYTlPVWZv?=
 =?utf-8?B?bE1aTkNDWU5pQVY0Uy9Ld0hFaTdTbm1yRW8yY2hrM1ZmUU1PREFPM1N0VTEv?=
 =?utf-8?B?UE9NVll2UXlCeVp6OFhtMllBVy9DdFNrYXhYdjdEZFFTNWVtc3dlT1p2UXcx?=
 =?utf-8?B?T0o0RG9CdW9pZk1PdThncWF3Y0Fxb2RWQno4WkdIK1pnd0Y3S2NMMXJpZDFI?=
 =?utf-8?B?NkhraGpZM0xJc0JaOE9HZVUyaFE3cTlwKzUwclQ1OG1reFJiMWVNOTNCUVJt?=
 =?utf-8?B?bWVzN2NoNVNiN09MOHo2emw3bVhGcXBpeTA5ZlFuaDl2QzlCMkczUDArb053?=
 =?utf-8?B?OFdHM3A4d3UvRXpxU2lHVEEvbHM5bGNDWXJLMkc4dGdtd2NxdUoxUzZJTVJG?=
 =?utf-8?B?amxLalpXQ25qQU1UUk5TWldlcitKcWVRMjBNWjYzUkVMNnRZZE1sRDVrcjUz?=
 =?utf-8?B?cm15VDZ4aGFwRGRiVkFRckNTTjBGU2EvUHJydHdickFjcVhPamxCNFFncEZ2?=
 =?utf-8?B?TGloWjd6MXQrZGR3UUVBZUw3TWtjMDYyenhtWVNQQU5CKzZVVkRPSjQwOVF4?=
 =?utf-8?B?OG1WaHRMNFNMdWJXQ3p2YnlqWGdPUVhKczBrT2dqMS8ybFRISmdBRjBlQ1dx?=
 =?utf-8?B?SUg3OC9RYnIzWFNQYUpGTEYxbVZJcVZSazhQalV2MU0wNmUzWnluUi84RUda?=
 =?utf-8?B?OS9sKythVXhDeHBPYmxud0VuUk1Za0dlTUxZK1Vta3dWOG85V0IvN0JHWk9L?=
 =?utf-8?B?QkhEMEljeFJKT0RoNGdoMlkrMlR1ZHdsWTB1VkF5cW8wME54dkVjdVNwN1h1?=
 =?utf-8?B?OHErN1VNSUlXSytUNlFnVUgxYmVraitKUVMvL0VzMWIxci9ray91dUJwR3VH?=
 =?utf-8?B?eVJvbUF3ZC9CU0dyZ3p1VnlVS2tzancyNFo0bjZMWXFwcU05eW5SOElhWjN0?=
 =?utf-8?B?ZjE3eDNHSkxKR1lMeE9Zc09sK2ZhWHdLaG9OMXZaSnN4UGZnSmlHS1ZNQmN4?=
 =?utf-8?B?Qnl0dFJocXBKaE9aK0lsUGpwUm42MmRTZjd0ak9uRTdnZ0swSEs0OXdvUHlG?=
 =?utf-8?B?R0d2MkQ4Ry9qUmpKTU1vWkVqai9KazZQQVg5UlFXY1ZINUVwZG9EZHg3K3ly?=
 =?utf-8?B?bjZhY2NpaXNOMkM3R0k2ZjFPNTJCSkVZUUxkTWgyMG5GOGxBRkxmMnd6RUR6?=
 =?utf-8?B?M2ROeGNYMk9ramZHbTVRN1BsK1RyTXVhcFprdGFEaEFGcU43bktmVnkrbXpi?=
 =?utf-8?B?Ty9zcFJvZlVvVGhlMERCWVJGVTgwcUgvOEI5QUVjbDhTcnoyS01tT2Qvdk1m?=
 =?utf-8?B?VDhsUDRiVjF6K1VoenBCNkNpMFk0UThhczdBMHdidVRVVENSVXY3c2t4VHps?=
 =?utf-8?B?NGljbEZiTDZ0Vm9HUGNaM3RmdUJyZjV5TkZ0VlpORkFTd0grRE5vQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e5b51c-8f41-485e-f46e-08de5e0ee0fd
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 01:45:13.6949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L0nMz1psyo7fDI9or+55q8jDxY9wbsYElVit6QlgVYB9JSYEv1kQK2JuQ0uY2CeEA2wfoCYng2e+EsOVgfjmia+Kr2K4tddDFXoPxSyyEoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7172
X-OriginatorOrg: intel.com

Hi,

I recently tried to enable git maintenance for some repositories on one 
of my systems.

The services appeared to execute once but then the git processes got 
stuck the services never exited.

I tried various things to figure out what was going on including strace 
on the processes. This showed that the git process was constantly 
calling sched_yield().

I then connected to the process with gdb and took a backtrace:

>    $ gdb -p 1344308
>    (gdb) bt
>    #0  0x00007fe6058e9beb in sched_yield () from /lib64/libc.so.6
>    #1  0x00007fe606312fe5 in __sanitizer::StopTheWorld(void (*)(__sanitizer::SuspendedThreadsList const&, void*), void*) () from /lib64/libasan.so.8
>    #2  0x00007fe60632685e in __lsan::LockStuffAndStopTheWorldCallback(dl_phdr_info*, unsigned long, void*) () from /lib64/libasan.so.8
>    #3  0x00007fe605950197 in dl_iterate_phdr () from /lib64/libc.so.6
>    #4  0x00007fe606326bb0 in __lsan::LockStuffAndStopTheWorld(void (*)(__sanitizer::SuspendedThreadsList const&, void*), __lsan::CheckForLeaksParam*) ()
>       from /lib64/libasan.so.8
>    #5  0x00007fe6063235d2 in __lsan::CheckForLeaksOnce() () from /lib64/libasan.so.8
>    #6  0x00007fe606323835 in __lsan::DoLeakCheck() () from /lib64/libasan.so.8
>    #7  0x00007fe60582943c in __cxa_finalize () from /lib64/libc.so.6
>    #8  0x00007fe606205c87 in __do_global_dtors_aux () from /lib64/libasan.so.8
>    #9  0x00007ffd86656ba0 in ?? ()
>    #10 0x00007fe606a6d2d2 in _dl_call_fini (closure_map=0x7fe606a620c0) at dl-call_fini.c:43

This shows that we appear to get stuck inside of the leak sanitizer for 
some reason.

I build git locally and enable the sanitizer, which helps me catch 
issues both when developing and running git.

I don't really understand why, but some google searching shows that it 
could be related to some of the way that systemd sets up and isolates 
the process.

The end result of this setup is that my git maintenance processes run 
once then never exit, so systemd service never stops, so the timer never 
restarts git maintenance on the next hour/day/etc.

I was able to work around this by adding an override.conf with

[Service]
Environment="ASAN_OPTIONS=detect_leaks=0"

Which disables the asan leak detection, and prevents this particular issue.

I thought I'd post this so that anyone else running into this issue 
might hopefully find the fix or workaround instead of wondering why git 
was getting stuck doing nothing for days on end.
