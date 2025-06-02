Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1308119EEBF
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 23:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748905540; cv=fail; b=efApX+HLvOdoWXxiH+9/o74h9N0488UHuw/cn2+QxAtcw6jF/OAscZ1o9oEwHOtVJKz3kNf4kNbTGa/yXdv+x/aGkXuEZ8ob1F95oF4FobHwTA+G4cha/aqGr4NCX+nOviKoBH+w1bBCGxansG4UfDrFBKP4w1RBFh76quH7/GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748905540; c=relaxed/simple;
	bh=t7Yg5M5nhnAHpsbEGMptFyWOEc3N67jtxwKiQNhb+CA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PRp/B90/QtZgo6QFAKTMZT2E/t3YcmqCV+f33qmK7YhPBS2mnbEVuOk2qa7/rc04SuTR8ydrKGS1GCQiy6HuunrWfbAfWTiYpwDjoDQaPlIDseM3YXUoTgbkL7jexS5zOECftA3OiVEvuC5MIczJEq6uczbzLkKWA6aVM1YYYes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jpPGRi97; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jpPGRi97"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748905538; x=1780441538;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t7Yg5M5nhnAHpsbEGMptFyWOEc3N67jtxwKiQNhb+CA=;
  b=jpPGRi97VVVrIMG5xZI8j4yoJcsjdtpRbht1KGv8xZKwotdkph3vHJiX
   BZhXsGQ0GRwsBbjhXswRRBeHnPcN0GJ9+GPu2XVr+r8/Uhy2kLwv1b+30
   Bwx+XBxrapWsLU5xvZsvPLSX2kEBadFRsmCDaql9PXkR0kYMffly68Rxw
   2tv7eh30FSVKijofMSyFI3MpsGE95G4KzU571Q8wFvYHVmMAWUl668MMP
   LANcPjurUp2q/ELezuNwFO6Iotu2LHrXGdROQASRDKCMyzP+TUsus2P8A
   JVY3x7JPwSBxAAuSPjngE+RB49h4KLQWu8500NjBSEgSwglArb8TeT664
   Q==;
X-CSE-ConnectionGUID: R6vYHSNtQP6BXgSSAu1E1A==
X-CSE-MsgGUID: hU5/AL96Q8qfs3+SWWT03g==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="51025279"
X-IronPort-AV: E=Sophos;i="6.16,204,1744095600"; 
   d="scan'208";a="51025279"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 16:05:37 -0700
X-CSE-ConnectionGUID: BcAPV3vlQ4Ckr51Xa47lhg==
X-CSE-MsgGUID: Rmmzd/g+Q4KwpZ1/9UzgPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,204,1744095600"; 
   d="scan'208";a="181840598"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 16:05:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 2 Jun 2025 16:05:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 2 Jun 2025 16:05:36 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.44)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 2 Jun 2025 16:05:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FvUVH82QIetkgsm5jw/yjLj4Vf0oTdxAcVWn2iISAoZWMlm7L4oiMzTuwZh3JzPrRtVbEPOXMqG9fOEG07e06l/TGl7a+oh28w+iOMUdAz4F3QgnxbjKZ2rH0b12uNa7zubf2HpOePTXlXJAhRnJHw9q2JOoWiApw8xXY7sHaypKIG8l4zDceV38pNU/TVK2y37paxMWKSOUMAm2GkzgyLswAPFHxsUtJGF3aL2i07kfnS8Ew7ApbcTNARAHQyEh4/DX0RSVFyZNsdv40PGwBzlWU29nMGBFtMuzm98/XhT2Di4YChod/z5hGik1HWZfPl97tvTo/OrODYm1nVjVQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92mrOMCdU7SFONFkxqXh9LF4pzIueqOgn8nT0OCl1uU=;
 b=C4EoxTLmagfQysfAPKetpVEgd19NBY4XsShu5z7KfbtJbp28z1+INawZKsjD29wyuOnLodKG1CAzNPp5W95+4nqr8tlPWFM1xE8sm9/L2MjXANizQh+akFwnSx+c84WG977d7U/8BW1iGwtb1aMYSzIdJy453evkzrMGFhM2AGd9ZyHZbmjfVhs7p1cCDzDzju65z7xMX+Akb776YfpfR324Rb+cV8ky6IZO0PphkKg8Bdw4zg8qQGjvILO5pej1BPFiYoKZvbz2W8uJYg2vdEAFVFYl3NoWDaPGcjYzRC3IuDARH9SdhcdMfkdt9RIEancTMW9LVW+ZRLYHch5jLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB6860.namprd11.prod.outlook.com (2603:10b6:510:200::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.36; Mon, 2 Jun
 2025 23:05:20 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%7]) with mapi id 15.20.8769.037; Mon, 2 Jun 2025
 23:05:20 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Collin Funk <collin.funk1@gmail.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: "jn.avila@free.fr" <jn.avila@free.fr>, Corentin Garcia
	<corenting@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: RE: [PATCH v3] completion: make sed command that generates
 config-list.h portable.
Thread-Topic: [PATCH v3] completion: make sed command that generates
 config-list.h portable.
Thread-Index: AQHb1A432McfwsUmmkO5Qmg4MVsthbPwfU8Q
Date: Mon, 2 Jun 2025 23:05:20 +0000
Message-ID: <CO1PR11MB508935F77DB5D7CA29BF8D79D662A@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <0ab924839df48d869682bea1b0cb400f378ca6dc.1748889654.git.collin.funk1@gmail.com>
 <59b2a12a3f43cf078fbeaf0271b5a7cfffc9eb8f.1748903426.git.collin.funk1@gmail.com>
In-Reply-To: <59b2a12a3f43cf078fbeaf0271b5a7cfffc9eb8f.1748903426.git.collin.funk1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|PH7PR11MB6860:EE_
x-ms-office365-filtering-correlation-id: 93a4b017-bbb9-40f5-7f27-08dda229f27f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|41080700001|15866825006;
x-microsoft-antispam-message-info: =?us-ascii?Q?UCHPJWT2aepr8bW0MfzZJcIc/OGvp6CzBathUEElB364OK/vYoGIq7DXMhcZ?=
 =?us-ascii?Q?kTxljBUboA3cufVH+volmDhoKzjNByXzfeDf0EH/zsuE8cFgfmMlokzlxg0U?=
 =?us-ascii?Q?BHhSrRgPaFZMoHrB1TuckB17b2Qi819XGcOAwwZUHQ6J6wk5uExmd9L0zzbi?=
 =?us-ascii?Q?NpjpH8HDMM8b7iJoJomwVt0O4oBXcnobKSV/gm0rzJiE4qws4IaeKV2ALLtB?=
 =?us-ascii?Q?07ITgZGDAREi8Bbk7cBMs8wrM7Jb+vUq0tomRWqRMmQe1WuryX8CH4TIHM1K?=
 =?us-ascii?Q?hADAGm9NoW7TwmWwYwMiZinZW+qD/DmCaIZviIff/l53air3rCUXQ7vY9pxp?=
 =?us-ascii?Q?lq1lr0tTXzgH/SJdeEXjWRaqZf86A+ABP5bDJkf758nbHzX0B8LTPAoWne0l?=
 =?us-ascii?Q?e+/P6J23InUUOIXQcavMoIk3YuoV3+VX5qKp+JFqg9jJpO9XsLz2oGRdMThx?=
 =?us-ascii?Q?m0uda5Fg/iM7HSsQCzhO5Y6JYs+cNtjW7ZoNpX7XF7MYvJooRPHCVNWHyMsa?=
 =?us-ascii?Q?xjvU41yR/YfnTXz0KLW5QYbb1FsQyR0QLwTt32CQYarcuZC/wbBHbeaY8gQZ?=
 =?us-ascii?Q?Ct9BMCuANve5aHIPoP8acPcrcxr+m4J1d5vGpUZe1BHI5LtLoa6n7sYPAiXa?=
 =?us-ascii?Q?wegGnAlBzeP4n6IK566N5VjgmHg7ZdhuRnt6+M6C/09GQEgLfMlYWlp0v779?=
 =?us-ascii?Q?vweIimknDwyJpcft1PfwPgxiSlRjrhHnWahpDQdMy20tRWP1AxDha+jNASgw?=
 =?us-ascii?Q?fNz5Ti32VHGNlwtTYInd0pGReIwlbkuHM4/nFhCitUOcoD7hFFJzisL28fYB?=
 =?us-ascii?Q?5xmsB3ybAvkJTKrKlWKDnwXiVMcb31gf2yWCKbAdy0R9pz+UDOzYw2FB8sVS?=
 =?us-ascii?Q?BQbglXeMa864fvdUNqnKhft+waNOtBmH3QL32hL7GUdouGDXYl1kkI8SL2rp?=
 =?us-ascii?Q?HgV069zEt+lumJQlJgSX7PFDk1Nh+RH8FNUSe3x6DXSYP5D3L9lCLMK4VSiK?=
 =?us-ascii?Q?pGKyzhGnbrVbOwYp4ygnlD9gp4GBAUZxBGliL9VRR/0GOLVBip8sGN6hMx6D?=
 =?us-ascii?Q?iP3rZg3Pa/2QBKS4MbBMMJtpSA1stYH+DgR2AjSEqZUvoZAtmPxlQ3cE6Gf6?=
 =?us-ascii?Q?rbNuP3dtkDYrPkR4f8y/Zt31J80AZ3aMsFiypA81Mea/R1uzl/jzyoD/JdJ7?=
 =?us-ascii?Q?no39RFyCzvkOJ94XOW4q/9piMfACJkmJ5Aj4q9fT/bqNL+iRVh/7d6fJjCVj?=
 =?us-ascii?Q?OpTKnjtS3jLTfz4ADK/gZ2ZUACJLzX6AvAIbjaz7C3Z0Q9/JDn0tpLk1qxLi?=
 =?us-ascii?Q?BZjtVY0wE6fJn4hOUlC69BaiOzDYs8mhPd5c+7oiEG4rwtllAHDd7UWX1mBm?=
 =?us-ascii?Q?j+bskfF+ELOwOlyiK20ObsKy4Rre7nlJH/cesOayunOVvFt8CSI+1eYb8OX6?=
 =?us-ascii?Q?vQq7myLuGQRqPcyfCnlsP00XAmu8Yz2AfwjRzrZ0IW0o+3l6xYkARSVzJdws?=
 =?us-ascii?Q?KDJ58tWSBdcZGfeEpAV9ljrKRvtiBjPVV+iQe2WrLuHdS9soJISx4BrS6ha8?=
 =?us-ascii?Q?QOVAkiWWIsLp+h/WCPI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(41080700001)(15866825006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cvJ4aRwUoEg+L9efXeaWY0r81bKEbKSQZuH7+1oLOXyUV1RJukGbwrrT8R9H?=
 =?us-ascii?Q?02E4lEEhBtDMyx2Df51X9h9hNbvw+EkhqWHooQQ22PKOObpjIYJTJeksVIFd?=
 =?us-ascii?Q?80r+1gGUNXg9GWxEeJpSpR06m24gvr9IK+wNAhoxCAN8I8S7+Tq1uHETQPNp?=
 =?us-ascii?Q?V2EV9apK50q+wR3i+o7x5pDOmpKlYKP2bWz/kwMZoppqEeJH/8iGkSlrFRY/?=
 =?us-ascii?Q?9umbbJZ4fjtgt8HDd6GIReTcU6dL5hXzI5/rXzgyV/3oCtZ+dPGlu1g18iCi?=
 =?us-ascii?Q?CEASe6mBWb4CMiH5tu1p69fN8RivmyVDokU0/UddLDDfCTNFxOObqRcW5r25?=
 =?us-ascii?Q?+o4jpCwGzzj2F8hFcmuZPxgqS3S/mcUuGorNVJ/ZwAMuPJ1zxMfPSsDeOpY4?=
 =?us-ascii?Q?kspRt4UwdNUtBg8GPwVUs6OZJP2mrk3fKOjv9yBR4B5ecHeP04VIIwdN89xP?=
 =?us-ascii?Q?89admKgK48oQuKVAz64Ay6Xow9gm3OxFvxYMh7UGjzYAGXt5HTRobI+AEaWd?=
 =?us-ascii?Q?jiPy04BzLZ8+9Us1h4InIf3vFPCLQ3k5bpgGOQUPSW9RgFr9n3F/rXsZo5NG?=
 =?us-ascii?Q?Jm9ahQMJJW+K7wSq/E97B306zVkHyu4FFlZWyAN7CU/qxX+1hmStDKBpOlba?=
 =?us-ascii?Q?cJ6B85Gx4kLF1QzDmx14A23QNePL78cMG6IqlybMEoB4TRV2wzG18y+WGnMp?=
 =?us-ascii?Q?YBmfzMie/GSk1OgOZDErTXZ/PiicM35D0whwCPsg8ZDK8Wg2KfMqHe9hHNCG?=
 =?us-ascii?Q?U8n+wY4fqSZp/60veRVHyQU19R8Vs88rdp75Rofflat75Q5arXMYZsScM1ND?=
 =?us-ascii?Q?B+lcsvCVYgQzMTtLwnt6Mnpi2UZUfAuDSzoJT5XidTRAe4tJixYKZjgMYxEV?=
 =?us-ascii?Q?3N9ggN09KIoMbV5syiW0UmK3FGpVXZ8STIzOzF5TelArSc3lTNO2OyS50PMP?=
 =?us-ascii?Q?iPwYYQSu2v0yYfOLzlKK3Vch63D4yO0bS8BwLdPF9n6m52moW55gzA84FdsH?=
 =?us-ascii?Q?s6p0nBX6UX8N0kxG5tcnW8WLXBqbhb/BNyIh0SUJ5t48ruAD6m4GrM+cqtnk?=
 =?us-ascii?Q?Tn+3vTqirQuKPb2Che/2ZXp2NVQhxjJRN8Fp0DHYMemiwHiQpPNu6WRgqdMk?=
 =?us-ascii?Q?h/pol/u8G2yrEMaZ/BZMJlMYT80FBx1pCuCPaUkK5LYWJzgRLjlV2++yKpar?=
 =?us-ascii?Q?eiRlV5G90BpJxIgGokYe0tK3SplPcH1OjA+dHdMpTIrIhW1lsPrjdNsIgp6Y?=
 =?us-ascii?Q?H09Syxt2KkuEChLnEkIqY5g59gXO+5W8pmlClgY3WqM5txodcjMZ5lx7AAik?=
 =?us-ascii?Q?ytKL7RcZ5zMrgPi21HUpxfV2Vhr5yfypxW3Sz6T9zyip2tvlPtKJ2pCEkEG3?=
 =?us-ascii?Q?PJuZn6Md/Vm9CHohVs0RjqO01Fq4A7HB+G7ftcBQJ4vn6yniQ0QhoWwm6FaD?=
 =?us-ascii?Q?wnB9fU7uWPiYjm7lbrRXthhwbkR7dwvznvwez8VPes18dha8nLdfEAGpJ8nu?=
 =?us-ascii?Q?6buMPsZjuy5GEhLkchbHdX1+PdMxPIypK+jjl56tRiYhwWXs/nTJMKxTllPH?=
 =?us-ascii?Q?3zOo/X9BYlOxdlQYL1J8fjSUuXbxum60S474Ot5w?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a4b017-bbb9-40f5-7f27-08dda229f27f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2025 23:05:20.1843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ecEaalAvF3a/j41aoEC/lvB/nzVpiBuSQR+YIzI4BYYgKqE3bTrStAIHYD/kN5xP8WGdjrwWaULm7sIuVXUWVsuh88H+n9I6Zs/26RCKWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6860
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Collin Funk <collin.funk1@gmail.com>
> Sent: Monday, June 2, 2025 3:32 PM
> To: git@vger.kernel.org
> Cc: jn.avila@free.fr; Keller, Jacob E <jacob.e.keller@intel.com>; Collin =
Funk
> <collin.funk1@gmail.com>; Corentin Garcia <corenting@gmail.com>; Junio C
> Hamano <gitster@pobox.com>
> Subject: [PATCH v3] completion: make sed command that generates config-li=
st.h
> portable.
>=20
> The OpenBSD 'sed' command does not support '\n' to represent newlines in
> sed expressions. This leads to the follow compiler error:
>=20
>     In file included from builtin/help.c:15:
>     ./config-list.h:282:18: error: use of undeclared identifier 'n'
>             "gitcvs.dbUser",n       "gitcvs.dbPass",
>                             ^
>     1 error generated.
>     gmake: *** [Makefile:2821: builtin/help.o] Error 1
>=20
> We can fix this by documenting related configuration variables
> one-per-line instead of listing them separated by commas. This allows us
> to remove the unportable part of the sed expression in
> generate-configlist.sh.
>=20
> Signed-off-by: Collin Funk <collin.funk1@gmail.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
