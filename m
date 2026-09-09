Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9011439B970
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 18:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788978324; cv=fail; b=lc/hgcaROBTHGGzC18j3n7x0CL9Fm7xSUXLLowWfiOh2gPHdevytJUDfCjCHtbMrZKrfr+t/AL3eojxmDLvGZk9pUQVmlCNt/B9EqGshRg2laWovDOMpVk/WF2VwK9ZJL/EtlmwjIWEegIeO4GXPJSHI9CagQpz8qCV2QtRz648=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788978324; c=relaxed/simple;
	bh=g1R3rddCa9w85EYEoWIW53D2ZUY1ZuB4MMDn6F2haZw=;
	h=From:Date:Subject:Message-ID:To:CC:MIME-Version:Content-Type; b=enXGqNZWpgRt3OgKbNoLcSGX4IhnNJzdjrrB7XkE0u05JbR/1Me+NDEVNpwhaQkZj5VSX5K7sCAilIUBG2YFtn+OO5KueRX/iCsB5uwovHsQdNMk3xIxKRoeAV7VP+pywpc27LvLXFMisxGMQhtimWYgaigKd5ETdsQ6864C2w8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wl1ntGvH; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wl1ntGvH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788978322; x=1820514322;
  h=from:date:subject:message-id:to:cc:mime-version;
  bh=g1R3rddCa9w85EYEoWIW53D2ZUY1ZuB4MMDn6F2haZw=;
  b=Wl1ntGvHAyhDjp0XD0wQN3Er2BryF3lv+eXpmccoDZwNyJ80lOVLmuvY
   eJSHZlOlWvy3yZQaEEhDWlMlGE0noaI+1dlyPwHpIzjodDKhT/u8w/0ZT
   RxhyVoX9sFWqRg1VEItdMlrrCVKmquEaRn6UWTJXN3Satj+9AscqJBIgX
   NqEWZ/GU5SwGLaCODWyv/LuNdJ5il862LnbYkrNhVATodbIK5ab8zZMnr
   dy4ep2EKrupI4ZP0SlntSXR50NQz0+U80zoqB1I2n/6i/AzHZJ1u+uIrA
   P6+S7DTMTjjXpE32UdrRsYQwERWsJGP4ff4XxnTG2qFx97ywiLK/DTMfW
   g==;
X-CSE-ConnectionGUID: pEwbbr5DQ3i6y6SZTyM7wg==
X-CSE-MsgGUID: MWxIYXLjSzaurAN88gU8VQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89456978"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="89456978"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 11:25:21 -0700
X-CSE-ConnectionGUID: UQXM/BNERxWsJbMVO5ngTQ==
X-CSE-MsgGUID: 7ozoG6BqQdawKRk4+6M9uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="273364299"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 11:25:20 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 11:25:19 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 9 Sep 2026 11:25:19 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.60) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 11:25:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WU3gyfJsyXum5dVncYmfKUAJy+eJNY4wYNBmXztL1+h8b8586+hDqpDHULNqyOldyyPCpdqVbFtDtklNF1ZNAGsY7V/dHksNz0IiXxgEVRWC1Bf1G78p2eBGmOj9cY3dtrVOI3lmYU9usqOktT/NzweQbqur2sUCXTSRFjqSDr17mW9j8N5ZhtyG448OnBNYMj0XUtV8Fdhlzd49m/Kc0tR27R8rtVVNmZ1AWsEcpD5GT/ALM0vHnY+eh2h47hkVIBtugqyhU0gySalyNylFshvl+vvRwbY+jbrPiIMj5NVMruMo32PUuyppGNeGYJS9MRnVz1RrLCg4qvbZbzngCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1R3rddCa9w85EYEoWIW53D2ZUY1ZuB4MMDn6F2haZw=;
 b=Q0ua7Cs15PtXgSd88Ju9nqKCezbM2wk9DsRWRDsJrDNC3yviH8Jna4K1MbGZ0vz+cXeXBlmjpoxzlrQZVXuJdb/PWZDtUgC7zGuILL9u0fh9D7Oxbu0NHgNhPHatEKylKkY0KRxmtBzhRC6+gHhkJNuj9p65N/62CEx9EYHDTVdm6F0Ptas4XjNzXUJn8ipjOA9qD2EK4k0WolxfFVQZcHigOhni3MBsYu/I9U1Q9lI5LaXVep29Cm5yhqMOk9dCy6MBNxxBBCSFYEAPtw5LzHkHUCS7r5RTdgX0ZZfISO583SFwDt/nb0UTtE3GqsX93UoXewAf8CjBrcaivb65gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from substrate-int.office.com (2603:10b6:806:52d::6) by
 SA3PR11MB347531.namprd11.prod.outlook.com with HTTP via
 DS7PR03CA0342.NAMPRD03.PROD.OUTLOOK.COM; Wed, 9 Sep 2026 18:25:17 +0000
From: "Goli, Pavansankar" <pavansankar.goli@intel.com>
Date: Wed, 9 Sep 2026 18:25:17 +0000
Subject: Recall: Issue after updating the GIT version from 2.44.0 to 2.50.1.
Message-ID: <BUN4RZFP9UU4.8CU9ACYE0A9G2@ph8pr11mb6926>
To: <git@vger.kernel.org>
CC: <sudheer.v.badana@intel.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-MS-PublicTrafficType: Email
client-request-id: 71cffd6c-a00b-bbc2-a9e6-732f021a1bdc
request-id: 71cffd6c-a00b-bbc2-a9e6-732f021a1bdc
X-MS-TrafficTypeDiagnostic: SA3PR11MB347531:EE_MessageRecallEmail
X-MS-Exchange-RecallReportGenerated: true
X-MS-Exchange-RecallReportCfmGenerated: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|11063799006|56012099006|10067099003|19003699004|18002099003;
X-Microsoft-Antispam-Message-Info: wDZ7nqQcnzV7D/hlXpYtqUftRDQz7+Ez/EzPEx4C1rSWeEQSb1UdIBYdYjTEVVar5EJBAhg2sPVOZ2F8T8c7pjKLOoM/0Wlgeu7I2AE/qyiIXK6iWay0rxGTbScPbuK7utU1I/W4Q5WVPT/rMVcyr5g5ouALuz4z4d6Ez6gFrJQ2ybA0X42ZgpGqN43o1B3NKu/1g6oR8G06RsUsBJgOO4DVVEPXAtDikUZvxz/yyMaXJKW97wLoH1Uw52VlByVHFhO9YnQdIcABfo8KpczEoh0uhT6oSDtiOUpGMTF2QijO6wuvKQdmJ9W1IhTvcRipoLT29VNR6CI2JmSzz+ALEv/UOwiv+gt42Jbh5RlNFQYt3o2P0aqjLHbM+go34UU9dylRWI8MYD3KuyaEEl0H2R/Odox9zh6+1dK47qsz/o6L0xHuXqJxfvvNPrNq7k90n60h4+cYr4UXPANETACDNXuQxan9cgaDh80zkXzgHC5b/+kPrIaKloB7js3xuYmg/N1Cv7lcg7/I9Jz6buSR4b9DaqdzTXd5/Ownd80nsuko/IJ5i6szXVB+CpeKCQ97TZcwt+J89+/9pe7N79cYN6bk1x5cV28O33lLK7m2PdNSGa9ahHlSNBJmmZOTSV4HJjr4h2iDIKYe8/wYXIznM9nby3gpj2Om/iq7Wr3G3cI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(11063799006)(56012099006)(10067099003)(19003699004)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NOmukiqudv817cQt0E5WRcP2kq3SzJY+pTVhyzOqc81InVIjJTwWSWKTkW2yVeuH+TACQjl8uWEIv3+sKoTYoLb1+sML3wzeXZII81gsrrDyXCRMDwa9T0S4G1oRkZ+6C63bhWm9EVLugE/y4TJAKNcN+UuNXeEN1Luu4EJ1ewEsaCHpZxsN4mxnhKuObkI5KHLIPSYNn6rfatj5Qd50HP7fo6Www8mswVX+isBG5/kBbfDZDJCjbbaGfeZRtiGFo7qe7Cp/s7a1dc7hXkVQVsYey174OW/BtfYBXa88Gn8sULEmBWBKGZdtw+wHJTbsK8dxzwnNwtSmzF8+PI0v6Nsnp6daeiKv1H0EjA3Edjy90wee0QoHrXuXGHQCz5dil3FnAFwrqqGPXo/V2fFo3KhL6kmNd1wwu/O8AIQuwG0HS0gTqZJj/xgETR70OdloaR4dchEHyyWjpV7gRyGYGKcCc0WJOdBph2+mNw6/4Zmvs1MWSgWmsSY0tc4uEdsUjs9i6fX5l3vKYitbJ+KHl5Vv04okjBMdVQbBDfl49RI430y0rPfufkCOXV/r55JV
X-Exchange-RoutingPolicyChecked: UjNHXlyqxj830NzSSL+I2XGDwOigsdRLnRwWCLe0P2n2E8imtaJ5ikABg1uijqsJWkMKOPRfIDTn+0/XwG5gvjM1500DLqmZWxTKM4wzr2Yo2pNdey3FK+i5s5LJ/+61r6/kxpubxcUIXV05abFOHJMJy1yOGaAgdow2Iu16C/7SkwCwk7XHoYr6Xmkwk5alWVc5AMsNXytgKu30IhnT+IzVMxnrx1FOeSRmCeUjhZSPRpQ+pchlZC77+kEQg2A9VsNz+n3vC6cuzz3q3xOm2j0e9h3PogXtiLCeNLoQmkQJnUQvSvzgi9gdDannC57vrtM5FckwkycMn/gwB8ueeg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HttpSubmission-SA3PR11MB347531
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 18:25:17.7904 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75bfa74a-f41d-4e9a-3402-08df0e9fb335
X-MS-Exchange-CrossTenant-TrustedPartner-TransportRecall-OriginalMessageId: =?utf-8?q?=3CPH7PR11MB714835E2FEBDA9AF003FB22E80B02=40PH7PR11MB7148=2Enamprd1?=
 =?utf-8?q?1=2Eprod=2Eoutlook=2Ecom=3E?=
X-MS-Exchange-CrossTenant-TrustedPartner-TransportRecall-Client: Monarch
X-MS-Exchange-CrossTenant-MessageRecallSenderObjectId: ca502514-d081-4ec7-a74a-c986bb3158aa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB347531
X-OriginatorOrg: intel.com

pavansankar.goli@intel.com would like to recall the message, "Issue after updating the GIT version from 2.44.0 to 2.50.1.".
