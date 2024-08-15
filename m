Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5E0158216
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 23:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723765589; cv=fail; b=dVRU9zNu6FEATxNs/z+piuTK6GoB6/mbjuyMucQ+F7JicRqjCrbjQjUC/F0QMzMrFPQfPKFVJPPIBvishAifpYdag0sUms34lrzgE+dir1R7ihWj92Zgr0LdQZZH1gpe/WBUdOHjsrf24H6njI2AbqC14vfndq3q19CCgVNbLOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723765589; c=relaxed/simple;
	bh=EVh+QMkO1WGUXZHAEumjM0wfm7qiRh8WiXkVjyBB3NI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MS32mijItMfRIrlRnTnkGUmFhHa8qjm76x8oNPYu479+H8Rn4KMclqliFQe0GYYbNaEdTDTCgT2kQPuEcqcEiOewz2my9ltLlzW6c6zixJKA6tyTbc6r/H7uZMxNx8r1OcWDqlKcnqV+Ku0D8Sq5mFNI/NkqvL+Di3hFs9c6QD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XaDoE6bI; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XaDoE6bI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723765588; x=1755301588;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EVh+QMkO1WGUXZHAEumjM0wfm7qiRh8WiXkVjyBB3NI=;
  b=XaDoE6bIch7ILcsEC3A0fZcIx5Zr5mHMAn0ThkIqPu9v5RTi/zpRweAG
   x8tHLRdU/GP1+5JBY5BdZdb+oVE+Jk2n9L7558yLGUgN5XRQ4Gcs+/JnU
   iduupd37DB8YSn9aWTp19Ce4XS+jVsqkM99SVb7l7mV+g0Bh7+L11PpCp
   R+D45Yl0PZQwFQfVWpOFAdOSCjTd796BP0WwiOkkPgyQCgxy+cytsoFYb
   ri20o8Q4D+inAIHS23kQvHRF/MqW8HQQSVWSTQZpbEe9MAbUdjcbqsk0g
   22w8IVCDWeC2MBtZ2bGZ9v8vrFNAdxTpCuLJrjAySAdu5Z3jmotdJB1VS
   w==;
X-CSE-ConnectionGUID: o7t83ehmQ7abQ5Wmn2qKUg==
X-CSE-MsgGUID: EjGYJ/3cRC6633tB7T6CyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="22191857"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="22191857"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 16:46:27 -0700
X-CSE-ConnectionGUID: zhI/Vw1IR1ysv7n3E1oovg==
X-CSE-MsgGUID: 3SzNO6fxSn648Ff6Qcy0Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="82701517"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Aug 2024 16:46:27 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 16:46:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 16:46:26 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 15 Aug 2024 16:46:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 16:46:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nO8bB53SmJiITcrv98fY+VvSvBJkeIuoPqVM4fuHY7FrgjqCC1Fr5arx2OTCFzCUgoq5ocmDttB3hqSPdkr85m7jgEN9V/SzOOhxICz4QY8I3SqUU1vwfBesph/8oVEBPPA1am9+qjpGyBCmJzSvdlUnUwZvotSkeGmaZYvWCpDRnKMW+EBR/xrK6j5pCqVOrBKMBt/z6hDsymo7pWESoijGPFgW8diSnY8BmAPQA9bV5cSVVbgvx7iMlScEsDoTLPbev6um6sCxZRXMXc8YprSrxbwrRAfShrFza8o2/bjtvW0tqr7V2bj8hCTQTW431EYxr5jvKZgSl7I9lKW6QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LPUq9ZU/++C81d1kB75//5saaAlCwechcfY5ORrlwE=;
 b=vGFHxrB2R+nT95VBwJZPUMb/R01O9YlmFh/8qvOnAffLg3dmHdO7KmciQcO7hXK8xIvvX+/D2RZHfKbQlGA/8wf4ZgnHgAOFyoosEkEHw6srDhzYpSNgZSGCLyviDPEx1NJz/9F0F6U7x6XqGGXsPEgxcdMX46io3ca+R+1to/LNoLUYyUShKVJ1Lufvd6rWPkEPIeDufhq3QwDgDsUHm3CObh3WMYUvnGE+7BSbZRsUdQEVc/CUUZDrc3NRt1rsfTDyzlhjMHSHoTD6rOGo4m/uxShdKyaWh9hTMMhXf+s0iEYNQ+kaUonmYcLrC+yUUMehWXjU5rOvW37L0QtBFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS7PR11MB7782.namprd11.prod.outlook.com (2603:10b6:8:e0::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.17; Thu, 15 Aug 2024 23:46:22 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7875.018; Thu, 15 Aug 2024
 23:46:22 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, Jacob Keller
	<jacob.keller@gmail.com>, Konstantin Ryabitsev
	<konstantin@linuxfoundation.org>
Subject: RE: [PATCH v2 0/3] send-email: teach git send-email mode to translate
 aliases
Thread-Topic: [PATCH v2 0/3] send-email: teach git send-email mode to
 translate aliases
Thread-Index: AQHa7d2vJr6kDrcBBkuCHAPHj9qZZbIo8UemgAAMLaA=
Date: Thu, 15 Aug 2024 23:46:22 +0000
Message-ID: <CO1PR11MB50896A614BEE7E54A6105E1CD6802@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20240813-jk-translate-alias-send-email-v2-0-912db4eb6846@gmail.com>
 <xmqqplq9qtrr.fsf@gitster.g>
In-Reply-To: <xmqqplq9qtrr.fsf@gitster.g>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|DS7PR11MB7782:EE_
x-ms-office365-filtering-correlation-id: 4c62ae69-f146-406f-ea71-08dcbd8477c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?4fQx/PFPxWRn6KPQ2zHRPsGDYqy1sWk7IJgeebmzMKivEajRF8KgbLdmCYQu?=
 =?us-ascii?Q?oB5JUTYyTbmR0PqqU5dGQE+y0EI38fxpK0VOBu8s8GHTJAllUppKvwg9Awf7?=
 =?us-ascii?Q?A/YV6W9k3RBtMQqbbKbW6nUfpgeXscf3DVq+mHXID4QWac4WHEXl3bq1h2z0?=
 =?us-ascii?Q?K7l26sEYZ1kq9xpxdGfiXarOVf0wY4b5vafTCRVTN9ObMY4qhrSy8+LatM4l?=
 =?us-ascii?Q?brg3F216JoHgWrLQZB31+DVe1XArT4ruziltPLsN8gEtktOPFBoMT91ZVEGO?=
 =?us-ascii?Q?C/zY31r9YmjABcCpp5quAk2QkjFgXixqNQ7uS9vEoUmCMtlRIetR2qqPvo6l?=
 =?us-ascii?Q?948F6ky+vibEby2xN3ycKlWXZyDqiGktXFVKquoDciJRf6n9s9Ef5sUidgC4?=
 =?us-ascii?Q?5QiQP1MB0cs8M7UIMtnIiRSljpr2XWtc+UJyp50sPK4g7SvM5M3Yskfcu39B?=
 =?us-ascii?Q?z6NoGODRwHGzZCk5gBGTeWbJ+LoTgXT/s34mzWh1YkzR7XLJpW/u3zo+eAbN?=
 =?us-ascii?Q?VQifj+9HUNBa+vxYZLl6DPABrUHeyLG0UtdgWEy/wKZAQ0vOp5YMBDe6S97L?=
 =?us-ascii?Q?My2OVR5+rj7iHlQ16KXuKIs9gxVxT/BAXae2CyST1SkUGNs+kc62wGz2Vh0Z?=
 =?us-ascii?Q?K9fZCIuX8125/NVjUbGNI36JBjyPjAtEd/jyrh1qPCgoTzGMTGqZyFNCJMIl?=
 =?us-ascii?Q?4yoZF4/LAzbaj+HlIzBlABgqW+PS6GmUd953/j5gKAfD4UY4AJKrzQcaoO9U?=
 =?us-ascii?Q?qXoynPafzFOmxWHb7nzYT+eioeN19kQIJmdutHL4n9PILJ5VRDhosdyBsDnJ?=
 =?us-ascii?Q?Aqde3iZvZVsGM5WlfKKa9LC+yLARW2xAo1rJzq+j4HL/MtN5cOkPXufMDq5X?=
 =?us-ascii?Q?V/AIB3gvDxq6Xb53Pqbk005O8wiMyI5fCq1EvbFP3fVFaHZuSzWr3tbZfrg8?=
 =?us-ascii?Q?UZYwPTuVpd8C1C6ZTLjdA9dTOMlXc/yGzi4eD0CF0T5majuiPn21zHdOTsLG?=
 =?us-ascii?Q?sIx+JeunbLYz8XO9arQ9mogph7ys2VHv+invDfyOXbj4RWbi87QCwsUOcpH7?=
 =?us-ascii?Q?rzGh/zsxHrIwE6TDSDYB2Z6LFewBvsmbZYXxbm0OEoKxw48Aw78WIzei35DR?=
 =?us-ascii?Q?bjdxq4idjZbxGlZndYJH957cwJ2ndQL7uYc0CYxymiUI9Vy6Vlqoh2QK1LdA?=
 =?us-ascii?Q?IqyrMZQbUqzPdbIx4gOFmNa7DtzFM7mg+KUzAFq7u1q0Hr0FTFH4BtNfYjFP?=
 =?us-ascii?Q?sCsvT3BFjowGSMLFj7KTd56mm7GBAG3DQRKcjUY3d+CIDhdzhvvKLS+niMSs?=
 =?us-ascii?Q?TvZKrCl3LshhWyxB+0X8yM/T9DAtSZiOka7Y74ozTmDragrdlNYlclcg/AuB?=
 =?us-ascii?Q?Nrit8NI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7XgRS66HmDfnnjmGZIrIZaPhwWAbpMXjIuuBCbHHV+foUrzCarCxhBRstaSb?=
 =?us-ascii?Q?wkAHuHFMRc9adJGoae2n9pJPdTNSKtvvz+JTSxVPeoUhbvCvtPn19iaLhiwp?=
 =?us-ascii?Q?dBvS2YT3nMwenZ+hqBe3G1eQw4BX4+qzgZsjwifa0zDSblBwSty/PvC6/EfM?=
 =?us-ascii?Q?GGomqTfkEIkrI03+IyInNJzVBHLLNqpw8lZwQUPOi3/DEPRZqdb4DCbKIRQm?=
 =?us-ascii?Q?OhFaMbZN2JGgfllx8Ky3txFuPue9O9NzZB4HDvxWunlL0dt7rreqZt/1aQVK?=
 =?us-ascii?Q?jr0X+STFthnCEHORvst0tfwh3igQECHKnx0A8aJ8uJBrPNPb3XE3VRbRCjzc?=
 =?us-ascii?Q?CVD2+jhB6bMFjDmMvmTxrQ67XkJVOfxSfSF2mGTBxjP2ADcxZXa/UqryUxaf?=
 =?us-ascii?Q?nzpX0EdGfjZE24t0rvns3YDpNWNVSuZGPILyLWMinzh7YHtKe1na3CdDtBPO?=
 =?us-ascii?Q?msx0yf1+a5WuRYNcCErhpKkv/R8e2IgDr5pOJJ8G4D5oWTRX9T7+I+qIR0gf?=
 =?us-ascii?Q?C4GDL/YLLKQl/VVZYAeZ0ecM2Zz2q4kCqItHG7RCtltLb8/ZBk66UgYAfc4T?=
 =?us-ascii?Q?4M2vlsvRFv1MldqSIf06Ln3i1yy5LFhGJSQzEMbRO/DdUKe2gihqjY2RvdtJ?=
 =?us-ascii?Q?gdxAolofNmPo0YrgZVgjKJwMvjg/+9A50QJNnffiZt3N0AS+40fVu3hlPivO?=
 =?us-ascii?Q?9j09512lgt8rOtUIe6+pOklTQ2dgRZWAHf7wzKFRmuAP8hMC5kaibvWDnDPb?=
 =?us-ascii?Q?KoesHVwi0xu1EdSaDq1HoMfn3z5gQ+olGWFgZX9/L/UFW0UHgONK06iAnjK4?=
 =?us-ascii?Q?pq/bz0FRc/SyHkym2+kHDsPgs8tCy/4fx0n8HsiDMUz4XaOmr5LZwm/sPMjU?=
 =?us-ascii?Q?AiiXa2q26SHmH3MOBvKhEKzHsvmHKRErisXfUFdIIjvzqlpblC1+OamZx2kj?=
 =?us-ascii?Q?hPPcq8QrqJ4xjpOBZYN1XgvmX/wL8dbPw97Lr8MUmn59dF85RQiQ5WHPA60h?=
 =?us-ascii?Q?o0b+a48sLAtYNW4OcO4Mfv2VSAhdfk9+alXRmRMNd5rh0pwVl799qb7m/X+Y?=
 =?us-ascii?Q?mccm69A716RHn6fAVzSF73rrT/suqcsBIN9p/sVatEopQXM+rVIKgCBy8bTa?=
 =?us-ascii?Q?xj00TcNyruOY5DbZgRHN62GVgW7OYo3TxurNqhgdwtT0fPo6QJn2nVHTQVkZ?=
 =?us-ascii?Q?Sna8aVA+1aHakRBRbNtrgVgbxrgoomdfXYHgC4y8XVKx8uyflS94p8vXMMMq?=
 =?us-ascii?Q?K/JsbeJJnAnc7SCCrwxgLPTTCB0pRF1Vgi9IPA1f1iGQX+6n31s4+R36J2Ae?=
 =?us-ascii?Q?Folm08kBu9McaneYcnA8vYfEZzXs6a0a/RDP1hKFWWHkxPzbSP8Hwnlc8Gt/?=
 =?us-ascii?Q?p1gEWM3m9r+UK0s63/cYTY5PBWPwIYg2Mm4zvRfA6bJHyuKNFJHiTUyWNweW?=
 =?us-ascii?Q?VXMer6LJZvWkiwaSmL611CyGU6RT67uDgpLIIBkic+Y91/dVKKhR2ovupVEC?=
 =?us-ascii?Q?N0YfUqiDHM34kKkAdkvgUzROxJsoJkTwyjl4mk81H5K+pxfe4OL3duVF+ka/?=
 =?us-ascii?Q?BxekbVaNsyT7EhYgiFoWmEk/Ron4ogKD8izcyp+d?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c62ae69-f146-406f-ea71-08dcbd8477c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 23:46:22.2295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W9+XZk0pv/3ZiYhtR8aeFme60DgGri9JtfVvq71HU5d07yF5MCYL1ZUYEiCbWS4VrpEBWnxZlqhfrCvKFsl9u0c0sRxf5eJLn8DzT6ERZpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7782
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Junio C Hamano <gitster@pobox.com>
> Sent: Thursday, August 15, 2024 3:57 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: git@vger.kernel.org; Jacob Keller <jacob.keller@gmail.com>; Konstanti=
n
> Ryabitsev <konstantin@linuxfoundation.org>
> Subject: Re: [PATCH v2 0/3] send-email: teach git send-email mode to tran=
slate
> aliases
>=20
> Jacob Keller <jacob.e.keller@intel.com> writes:
>=20
> > Jacob Keller (3):
> >       t90001-send-email.sh: fix quoting for mailrc --dump-aliases test
> >       t9001-send-email.sh: update alias list used for pine test
> >       send-email: teach git send-email option to translate aliases
>=20
> Seems to fail t9001 rather miserably on Windows.
>=20
> https://github.com/git/git/actions/runs/10411559740/job/28835810137#step:=
5:24
> 44
>=20
> There seem to be way too many PREREQ related skippage, it is not all
> that surprising (it does not make it excuable, though) if a new test
> that comes later and not skipped is broken because earlier steps are
> not executed.

It looks like we're missing the perl PREREQ on the tests, so these execute =
and then fail because of lack of perl. Should be easy to fix.
