Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304101B4231
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 21:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750886815; cv=fail; b=TlbN+l0uSHnYIqUZv8g5dftag1+qKe6LjCeFRTUcsrU+i9a/9H3HLIUJ1Bq7rW4bXGq2mqKf0/OCDQD+nQB1hRuW/cIzVo7xWTjRnvwz6qLwb+jcCKZYxB3vseXcg1RarTcEz2BhdQhUiP6j0JOx/EUQSp4NchZQ5sk1ZX9g+SU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750886815; c=relaxed/simple;
	bh=BN4juUK0Nb2xu64/KAKLhsx1hsoSWpZlcfyJU+53wHk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N6SQETNG8uqVFFuwVA8PijF6RIxBPSIHcUOFPgssmkyFLyHSnmbPq4toltTS/CmYhCbYCsYI19R+PtNIrkubybqRPrw19P+hP1OlDEXUQOuxlAIlMywON1td6w92hYTzwzNsipKRCiuKGe922Xk/NqT8EqSx1jfx29VyAmWc0XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EEq4qkKx; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EEq4qkKx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750886814; x=1782422814;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=BN4juUK0Nb2xu64/KAKLhsx1hsoSWpZlcfyJU+53wHk=;
  b=EEq4qkKxQZD90pTlybUBaCYySJyV4HuRx3lemQOlxt6CEm6dIHyyeSXK
   UBI3KPWpy45zhOyonsGuKODChR9pyHH2dJaI65P3s6n5vduvQWFTxG87G
   nO4qc2drWu1WljVnqD0GF2zqDi/NwOvsq9q2zLgZ51ok9Ur1XC308w79t
   QWU7Ya+8kzktpczLt6nZfB8XxPcOR22vge98P3BBytJw3/8yzUNtSv0qM
   KCmOGzLXGqUbch4vCRJEwclg/oI/yXQoYcyLTikk2igfVMBIUhE92wm1H
   EVpTDbNf5ka+CgakHHvsMK73VCkAncvUuva8hZWVIxFFx89edlhBXiWph
   A==;
X-CSE-ConnectionGUID: WuEiqykpTCK5qZZDRd8v+A==
X-CSE-MsgGUID: waaVXRd1TG2ECS2h9TaBKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="64526425"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="64526425"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 14:26:53 -0700
X-CSE-ConnectionGUID: IC3k9ElaQgyluP6a5xatmw==
X-CSE-MsgGUID: Yb9k4WoYQdmKRyK0Ekwi/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="156591267"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 14:26:53 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 14:26:52 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 25 Jun 2025 14:26:52 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.76)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 14:26:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPnzVqlsUOBiF5Pe5+h9nZPppvP8ZcSP8Wi57+OuyXWtF1rsNki5DUYWgvvKbAEDlT1Gb4+VEiE3wGDM63T96anBBql9NcrxxKVJYgxupV9ue4tDgY7OI/DdCrDXRwWdsx4ZO8meCvu0bu/XZtANcQcAXPJN11CHHGLtBui++oQ8VmHJ/Nz+lt/WJ1P274CZkgUuwhGG6HrI4Fy2hy2ikRezNDW4CgZb7dcG5vSIxWWpsm+gSkS4EjPHoo/b1LMjAyIRMAb00fYaaM5MhT88+S5E2Q84i+sDvvI7NKFyE7sPxXkTSHVPiGqFozY4vpCTObm/8qlXtPsi0SXChf3y+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GmKEZE7VgEMyI6qrGM//YdTNLy4xfM8jb4yudu3TFpU=;
 b=e0lSJNXxFff7U5Ow680+6ztE7cBdSzJs3rbu0Y8aetMrLmb9J5Td0Pn8KN2us0y2o8I0hc7EEIrm+vegN0jFx5o6uCJ9tnSxfFZV6ndmAm1YjoqJSyzy46fg8A9ros5saxYlqNmxmsMvxSC1K5yyc8kChfnMgtzReOcNX4NYyTCs+fBHzPFlJOuhZhvdHQ3M4Jx3wOu6277aGPMlXeBTomr37rRKmn6wBDaMk1+6uBnDk02Rq/x9FusBrzCM2PLOLrBGU/GDs6eeORy7ca7Z77SasGjWofWQGKnZwpEFJBFRAC37ejV9DDk0QCOOBjwVRUstkGnvK8TrFvHQ6aQIqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW4PR11MB5872.namprd11.prod.outlook.com (2603:10b6:303:169::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Wed, 25 Jun
 2025 21:26:51 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 21:26:51 +0000
Message-ID: <0595f247-745f-4d57-9d20-4c2065b6c902@intel.com>
Date: Wed, 25 Jun 2025 14:26:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: How to exclude tagged commits from git log <revision-range>?
To: M Hickford <mirth.hickford@gmail.com>, Git Mailing List
	<git@vger.kernel.org>
References: <CAGJzqskFuQqLHgFk97S9uaBB=iW2Ni=NWokHJzMV5rYGsCOG4g@mail.gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <CAGJzqskFuQqLHgFk97S9uaBB=iW2Ni=NWokHJzMV5rYGsCOG4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0345.namprd03.prod.outlook.com
 (2603:10b6:303:dc::20) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW4PR11MB5872:EE_
X-MS-Office365-Filtering-Correlation-Id: 30a2c5d1-d0f5-41bf-baed-08ddb42effd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SllTYXpkeEdVdXo2UkttcFpObzdSaDBiWlRta1IwaTBKcGpZdG9VVHBQc1M2?=
 =?utf-8?B?NWFwSnUxQVdkeGorYXdzdDc4VXZSQ0s0eGI2L0ZXMy9KQmtrSEEzUnZkQUVN?=
 =?utf-8?B?RzJUWkM4eXRLdEJsN25jTUJvOTYwOU9wUS9lbml3UXpPUlh3VVJycDR3cDZI?=
 =?utf-8?B?a2M1VXZ1ZmdvRzZMd1hPcmZFVkthbUxseVhwanRFOEJ3WHpNblhFUlkvVmlN?=
 =?utf-8?B?NFU3bExCVUVHRENvMjhwM1F4bzlhS0dQTlJqUVR3RXh4OXo2WFJZN1l0UzNy?=
 =?utf-8?B?WURWdlhvckpvU3NIY1cvVW1EUjVZcGRUYjFhVHdMclNRcm5ITlFuNktuNEs1?=
 =?utf-8?B?ZnlmWmkyRTB3aU5IQ0ZDQ1lGcDZUS1V6ZXI0QlhWT0FkT0RpcUdabzhCUXM0?=
 =?utf-8?B?eGNUWVo0b3pLc1g3cFVIZER5YW1SR2pQdWFtdERMdzBBMHdVdFZ0UlNRT0ls?=
 =?utf-8?B?M2xEQTdITVVTWjA0VHBtWERkWEdpeFEwQlFwVXZsdUxaNURPNlNPSE4rQXJT?=
 =?utf-8?B?TkYzb1NBYmxoOWVXcU1Mc0JmOXFWZW85aXhzdHJUOGRiWjY1RE5LV3JseGVZ?=
 =?utf-8?B?SEpNcjNWMHJZSHBVdy9JV21zNTNQSVR2c1grdlBoT0N0My9JNS9yZFR2UUNK?=
 =?utf-8?B?TDFFVDlXMjdwN1VSUHBCTnhOWXFzOE5JUE5QaVd1UFpkNXZSeDFYSVp3MG1I?=
 =?utf-8?B?WkxnanJWUWhUdkh1dGZGTmNJUkd6WXRzaTFRaTRmUzlCckNiUzRnTkxXMC9E?=
 =?utf-8?B?SGVFYkFSK2ZDWWFSblFkcTUvamN4U005Qjc3aThXeE9CYkU5Y1UzNWxYU0wv?=
 =?utf-8?B?V2c4clUwczM1UG92LzBwZlJidUFSQ0x6ZTJ4anFacVorTEF6T0Z1MGxQQTNp?=
 =?utf-8?B?QnlaUkE2ZFFoVnN5cmIydVo0V0J6T3FqcVFWR1VBWndSNWFFZTJGMGErWmhZ?=
 =?utf-8?B?ZFo3bnppZFFPYm9lOUZOMnZ5Mk8xc3JVL0hMSkZyUkp4MDdFaWdFWXhtcm5l?=
 =?utf-8?B?RVBtSWlaKy9oc2c1ZkZQQkN6RXYyMkR5ZlJhemc4RXE1VkQ0UXRUWnNlWmU4?=
 =?utf-8?B?VDJ0VWYyTjJTSkNUdkV5QlBtT0ZuUEp2SnpWZ1luZTNGOFZWdUZoRmcrUmFE?=
 =?utf-8?B?R3pCMjFucjZvUVcrWjVsY1dXTG9NaXlDMSs4dGJmOE9ReHdjZXlYUUlTaVZE?=
 =?utf-8?B?VG40d3JSbVVHYWhYMmhaZGtEekhTVFB3UEsyS2hFMlBkcDh3UEphcmI3RkhK?=
 =?utf-8?B?Q2MzbDBwMzVueDZMTjFkK3RsUEpwb3BLaVFmMEEzK1lrdUFqTkpPaStSekF6?=
 =?utf-8?B?Zm1HVzJuUldEZmtFN0pmTFJqb2RrNjZoMjlqUEdQZkhuaStWcjlXYThPTTdq?=
 =?utf-8?B?Slc1Z21TZjJVeGhTVzJ4UDhUcC9RUTdFZkNCQkFKVTNWaHdWaU9mU29TNkxM?=
 =?utf-8?B?STJ6MUJFQWRCM2E1cW5DNEJFU25jWi9xN01tZkV4U01HeEhtSkw1dWVGUCtB?=
 =?utf-8?B?T1cwS1AyWHVlNGVaSlpWc0t2aktibVBTZEg3UmZsVkN5R092ZjlqTHdVMkFT?=
 =?utf-8?B?S2IvdGNSU3g5QzBmcks1ZG1uR1E4NE5zRVNwVWk2UGY1aitlVTJoM0paU1Mz?=
 =?utf-8?B?aE10K01VZUNOVFhBd0tWblpwMXBENWJhNExMaDlJbXFOVjJ6UkZzTlVxRHk0?=
 =?utf-8?B?OUxLaWRyOGJDcy9TZHJJZmFxMEpGMUtURkFvdklYaVMvOHFlQ0dQZGZPQVJj?=
 =?utf-8?B?dGVFUTcydDB3WElsc2NpZm5PeEJGT2ZqVHB6bEVlR1oyN1l6U0VEVWtYd0lB?=
 =?utf-8?B?M25xNkgrYXVZaVFnTVZVNmpaQklnemMza0RUblNqTGhrRElzNStVNng2Mis5?=
 =?utf-8?B?R20vaElham4vSW40NFJDdG1aL0lZQndZS1R1ejBKNFRNNnVIV0R2U04vRjVY?=
 =?utf-8?Q?vT4O1Zf82rk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OG1qMVltRTVtZkhOaUJhUmZrV0M3dytPTU1aUnpRaWkxeGlvVS9GdTBybVpq?=
 =?utf-8?B?blJxT0dIN213Z0p4MzNoa0FhcFE5bDFIL2JDTmFNeklUTFI3b0tqcTNmV2FH?=
 =?utf-8?B?bmF0TEM3NFRoeDdQazhnN0ZSM2RJM3lUYmVXWFFoTFVoSUJJM0xXMS8xVmRj?=
 =?utf-8?B?ZlJYV0lvZ0Q4d1dhY0hCRHZYblJYVkFOakdmWVRzdjBDa0o5dzFraDlGQWRR?=
 =?utf-8?B?S2xPZk40a1FPaGZiZzZLZFVmNFVlaG9xT242TzhXQnBSd3dHV1VKZW4ySk5j?=
 =?utf-8?B?SW02WmM2RXppcEMraEFUSzA1MExCdE96SlMvbldJRDlvbFNZWTQvVENXUHJB?=
 =?utf-8?B?V29oRE4xYmtSNHdXUE16amVlWFBxOW9YYW0xU2VtYndIclBsZlAramNOaUxL?=
 =?utf-8?B?TnpCZUZWMEFhT0xTZmJPeHUvRXVEcTJrbHQvcU9HNFkxMzVZTDE1YmNHTHRx?=
 =?utf-8?B?TTJ3NFdpS1hjQ1hNVXRDWTY1VUFKbW0vTkpUNzFpR1VraTZtZW1WMG5TSHBG?=
 =?utf-8?B?ZzdISmpBN0tJc2NzaDRITnRtSDJLYzJSMG9jc1FTUklFMVJieVdiYUhQZGwy?=
 =?utf-8?B?STdpcjMzMjZQY1JwRnJzUCtLMG1BemFVbUlMVHAzRUltaGgvYUJjQ090VmNi?=
 =?utf-8?B?WGlVN0pLaG83RmtsM29TNVR3c2FXUFhxbm9hNTdIbVM1azNwYUJBQUxWMWdD?=
 =?utf-8?B?L0JaeGhyYWhOcjllYm9VZml3NWVDNTlJQyszdlFuSUN2Rk4yVVZ3Wm1pRm5D?=
 =?utf-8?B?RTZIaHV5QUN0WmJYRmlmNUJpWTQ2eENWM0Q0YTB2VlRVT3o1V2ZiL1oyaVc1?=
 =?utf-8?B?K01BVXlUdFo2eXYzS1FQWVdDM3ZDQ1ZTcXJ3T1pYNXA5UzJNS1g4MFpNYnAr?=
 =?utf-8?B?WGxXc2h2K21TbWlWTHUyazByUWxDdU5aMjJyMlgvc2V6V1VHNzdzcVpVWW9M?=
 =?utf-8?B?Y2U4OXd1blRKVE9FM3Rvb0JROGhvRlJxTjJzTXBPQytDT2w3bnRRZTJVdDNP?=
 =?utf-8?B?Q0YyOFVvMzJwUEdHcEF5dHh2aHpCenlBTXdzSEVsM3RENjFwWDRsSUcwc0tD?=
 =?utf-8?B?R2tpN1MvTURNYzI0TzdYNmNudWErNG9nTnU4aU9xYnlJMGg4T3dDc0IyaTl0?=
 =?utf-8?B?NzlvR1lNUi9BdksyNFJCK2x5ODhlR3FzdVFsdUVqRFpvTXVZa2l3UTRDL241?=
 =?utf-8?B?aGJPQnFKK3pYQ1pVRklqVEpJaXp3UGZIa2V5enRsNVhWVTg2cHpYWXgvZ0hS?=
 =?utf-8?B?aGJzUlN5TnE5dmN4Zm9YNittNFE1U3M0ZGpjeDI5ZkhwS0NlTGN6VU8zL2xh?=
 =?utf-8?B?bEsrY0Y5eGkwd3BiR2JMb0tNYitQWCsrRDYzUFM3MGJ3UHBpNVpzbWRhckVQ?=
 =?utf-8?B?Yk5tUXYvZGV6NFdYSENRQnY1Unl5V1phM0tJaTRXdGpUSThHTms0QklEamQv?=
 =?utf-8?B?QVdnb2ZNK1lSN0N2SUt1bG11V1VmZXRpL3RyQlNCUDNINzQ4ZktYSkxaZ3Jo?=
 =?utf-8?B?c0N3YTZ1VlpiVEhDa210WEVLQjhTcDZlZHcyaDFkaTBYRDZPNDdlU0VmN3Nh?=
 =?utf-8?B?VWRpdkJmcWU3Um1NeHdva2FMRGVMclhickgvNHRRa2txazZwb2RqeUhoN2Z5?=
 =?utf-8?B?S3JteVJnK1JSVWxWQllxWUtsRDcySVNYZ3EvTVRoYjRGYzhaYTVucCsxVVBr?=
 =?utf-8?B?aTFhbnErdXNsSHpYb3h4YUY5aVB2OE45VmNKUmhDVzhma0lKVlUvVUxvWGlH?=
 =?utf-8?B?UHc5Q1Fnc1J1ZGJFd1daQ25KbUI4dHRNVGl6QkJHS3oxS3RrcDdrR3lpYy9U?=
 =?utf-8?B?NTJ1enlVTkFGeHlkZGRJK0VRbENYc3hqMnRFU0FaWXRnM3Q5QTVrN1diYUti?=
 =?utf-8?B?MmJPUENlVGRMZFRKdjFPcEpCb0VhSGtWNjRDdHliNHJNLzNzVjd3L0hEZE11?=
 =?utf-8?B?S3FtakpKem1OVHhqci9aNW9yNWlHbG9GK3g4ZUZXRVZFaGU4eXJhRU9ET2hH?=
 =?utf-8?B?ZXdMU1NvSTh0d0lkQkxyM01LUVIwMERpbWNJRW15bVg5ZURieFhIYUpOVUt0?=
 =?utf-8?B?Rk04bnIvencxWDd5eUJzNDNQa0NlcGVMZ2NuQi9xT1FBblFwWDNjUkNjTEZN?=
 =?utf-8?B?dWlRYVllNWZlSWVrdEJpa2hmZG1TOVNlVnZCREpKQml6ckw1MlA0US9UOEts?=
 =?utf-8?B?L3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a2c5d1-d0f5-41bf-baed-08ddb42effd4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 21:26:51.3650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fo+TsVUGfsG/AlgIcP8Uj6hnEZ8qT24wvlnJ+xhuqWI9pcGI6QKivnIJPpFyb5nCjKqmrFvUfeVC/26Zi91LoCPDVr+/YNwxTRnKwktJelY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5872
X-OriginatorOrg: intel.com



On 6/25/2025 1:30 PM, M Hickford wrote:
> Hi. Is it possible to exclude tagged commits from a revision range?
> 
> I tried
> 
>      git log --exclude=ref/tags/v* v2.3.0..v2.4.0
> 
> but this didn't exclude any commits.
> 
> An inelegant workaround is:
> 
>      git log --oneline --decorate v2.3.0..v2.4.0 | grep --invert-match "tag: v"
> 

What is your actual end goal with this git log? Why do you want to not
see tag commits?

I think your "inelegant" solution may be the only way to get what you want.
