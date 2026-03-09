Received: from smarthost4.atos.net (smtppost.atos.net [193.56.114.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8026637C10F
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=193.56.114.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773048991; cv=fail; b=ZlmIXgMMO58D8rfNNxlhZCFjzNghgvaRE22CjyHH0FF6etpVtUJKr3UF2J8TboWOwmMwP2/Fg0U8e9zWznLxItlssVWMLlepWgZ0vDnu7Z7hkblO+Bi5YgW/SQksB3av0OHXO/r0/23UgcSzR9LdtwBTr+Qwl8y8nOSzYWOf14Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773048991; c=relaxed/simple;
	bh=PfcIjrM0+uCcBhDEzigw4EaVsvxkYPU9gEe/WLttqFc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H22qiteJ5vmrBD5k1Zp5PGQRiFL6VEqaSwaQ4UrsZH1iRWmoSXTrreV1xmUwP+0G2tHRRJf7HPnud6ZUbZHGhXipl1RcUdr5asTvtAIyoV6e0qEhhjKf0vz5bUFtCjlfgasifMEajeT2prbXSMbihZWsdHC8UUGOsyZ86k7scsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=atos.net; spf=pass smtp.mailfrom=atos.net; dkim=pass (2048-bit key) header.d=atos.net header.i=@atos.net header.b=s48M7eB+; arc=fail smtp.client-ip=193.56.114.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=atos.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atos.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atos.net header.i=@atos.net header.b="s48M7eB+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=atos.net; i=@atos.net; q=dns/txt; s=mail2022;
  t=1773048987; x=1804584987;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PfcIjrM0+uCcBhDEzigw4EaVsvxkYPU9gEe/WLttqFc=;
  b=s48M7eB+BfN1JLGiDuj/mdDXPkIO/4eHvP6WmNQubqzUBBulIrB1TQ9x
   FbAqdH1df+/apGy0ktB3MOR2ywa4uw0AyfezxPS81mYNm63hl5jwk5LPo
   C+MZGMRO5q8sKQ/ydi/RMF8qNip9BXht9g/+1fFwkoT9q5aoaFZ5UDu8j
   U2yqzq9+NYvTZpbrRWMPdKOz5dd8GQoZKW/nRYgjBj6FAjoVUNPgcqd0w
   74n1sJlBmtX8IP4xyZGRzXSm4Zul3Flz5UM3Q9cTs7sEPWPrtiAQ2vRBR
   GWwe1L5vOJA1gLD3KdB4xjg9fuBHSkZaJMJ3NDpky+k5Z6iJ409OzvdIh
   Q==;
X-CSE-ConnectionGUID: /nvVL6VoTiCRUFpnl2En7A==
X-CSE-MsgGUID: Kb2Gux2aTOOgjOlZ0bx0Zw==
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="831937755"
X-MGA-submission: =?us-ascii?q?MDFBW6nObSXb/JkBhNuoD+2EAuG0bi6GhtYlZO?=
 =?us-ascii?q?YpsxTqq+qo2Xul06/jQp6qpzv3hhKp15o7iYJJ1KMr+Pk/i7yOH3sx2U?=
 =?us-ascii?q?JPFTZeSHMFa9+cGXCCJIw8G48hKw8D2H6Z82jZKqw2xrI83xww2AEiWx?=
 =?us-ascii?q?fy?=
Received: from mail-duzpr08cu00101.outbound.protection.outlook.com (HELO DUZPR08CU001.outbound.protection.outlook.com) ([40.93.64.65])
  by smarthost4.atos.net with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 09 Mar 2026 10:31:15 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hogup5qyIbivqnwbmywa/JrK4WxiN/Oj6K7mYH5swZa02gT36bEBFJbx2EXexMK8RNOUfU3+V4dzK0ByOTZyncKBJ9HB67vORySH1nTzCSUhr1fgzMbdLdNdxexbfYBuSNx8HSG5yBs/xGXOmPvTglQkXly1TqyRCDOxaAft/kk1yL6VJO7akQSbw8qxnwoZUhN2H8FrKRpuMtjDHCfaJvewAEGuy6HvCLDEpZ8/0WxSRYBlboR0ZpXhSOVpqDdivwx3YadpRdNlHkvsvvmVySVW15T2xUOBSPAWNyncIRc0jJuHTm0NoI8gGOByiOcGte8fptEk0kNH1fGo27Du4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfcIjrM0+uCcBhDEzigw4EaVsvxkYPU9gEe/WLttqFc=;
 b=x2PrTopEqsUTcx/NHH2AuKiidQhSI71/xuWNiYaVreDQSnA9aBWwW8EO3o0OwOAv0HLTfgJw2Ie1i1t5hk5aM+aDXqxLxd6+IEeB3Ezt1NxAwb/zMNIW3/rIM4IVF3uExhnsV0okVJL+YWgooxSGbdYajbQrVYW+nFCKaCyBI4UBOihxcIhRt+yynQ+H+v9EQELAK4dfOcwVkYUeNZS8DO1YNQNziityTAzO0pRRnVwI+Jd9bICwZM5eEW5ssdx+peFQQstzJH/HMU7n4WtJeT4VV21OlywwKIOP5mvo5F1jTC50hxEWb1GV6iYw5NHVCcEQi+mAvYnferCg2c7i4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from GV2PPF54105D074.eurprd02.prod.outlook.com
 (2603:10a6:158:401::5d1) by DBBPR02MB10795.eurprd02.prod.outlook.com
 (2603:10a6:10:53d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 09:31:14 +0000
Received: from GV2PPF54105D074.eurprd02.prod.outlook.com
 ([fe80::5cec:ef49:267d:ce55]) by GV2PPF54105D074.eurprd02.prod.outlook.com
 ([fe80::5cec:ef49:267d:ce55%8]) with mapi id 15.20.9678.024; Mon, 9 Mar 2026
 09:31:13 +0000
From: Richard Kerry <richard.kerry@atos.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Mike Banon
	<mikebdp2@gmail.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [PATCH] clone, progress: add --no-turtle-speed option to abort
 slow clones
Thread-Topic: [PATCH] clone, progress: add --no-turtle-speed option to abort
 slow clones
Thread-Index: AQHcrba1kMvBCFud00uu5r1LPhZr2bWiJs4AgAPLJ3A=
Date: Mon, 9 Mar 2026 09:31:13 +0000
Message-ID:
 <GV2PPF54105D074FFCB458CC64E663AD54F9C79A@GV2PPF54105D074.eurprd02.prod.outlook.com>
References:
 <CAK7947msLiGgrYTcg1m3ew+bP0F+VNbRaTy=ZW7zkkHh69bN0Q@mail.gmail.com>
 <aatjasMiPIeT0s27@fruit.crustytoothpaste.net>
In-Reply-To: <aatjasMiPIeT0s27@fruit.crustytoothpaste.net>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ActionId=67a77b8f-7931-4931-9739-984b4d703dde;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ContentBits=0;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Enabled=true;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Method=Standard;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Name=All
 Employees_2;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SetDate=2026-03-09T09:25:38Z;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PPF54105D074:EE_|DBBPR02MB10795:EE_
x-ms-office365-filtering-correlation-id: 82140d37-183f-4136-a6be-08de7dbe9b64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 pjAPDjgcmlQnehJxHJKbKEJ/95toLcknOYMKvpIFPc4j4U4LN/rTR8ptbMdUx0wQ9niPl+fZAwRClazFJ8c8kJwqnFRyqjEHKZsiPaAMCCNpPUgYxIdHqqYditFsjdYUz85xkPhd3QecpslrmLs8GfFmLiCHCTCiQ7FjvKx10FC68Kop1uF+FjyRB0gStFgsZeuxSsz/gGLcTTeCyiGcVpeZAuPXFczB3Hm59qo32TJXl5F2d4gjKMWM9/HtXSks//3j1EjtMtkEuLc6z5gzuUaDF8cmGbkkE+Ujy/nt8x/wxFnnvjQZhYMSKamHeTzQnQTkvL4lIiihVq4mrt9c2GfssMMuzJa9ptMY0tjuTT3ovGAu2aMbAQTz3PyoRhQKsY/Rk91Rn8g3e1Gp8M7lBDeTnynRY8e2T5FBBtNWb5KWujGJOHG2u6kV5R7AsPGAo2w21UORbI/ODr9I16gNla8WA50H9IsAar43e200S8AGFdUVQw1Z6wjXMKafN41qpCX5fHe4P0MVOLgkGybgL6R/raiNBreROpukUQMpVwTgwnFq70C2PvWFoYQ4JLHZFI5c3922lHzrwF0kWD+3MRfuU/YVbDVPknDORGbfcFMMiMRUqdrheMvqV+84aqVPIdmHkkYo5XlDkdJGEX9FLI2tX9Hx1eMBJqROF/PTrR2IpmdECGjqm96+9AQIDLNnj587NSRuwqsBUPw0eG2+StCeK1F66sWkh4gdzIDrdW3RhlgJ9dX8pe/Z+vVKWup248TslZI3So8fxIkUUqe9ByOhIu3sYlYmSEWbUHcdDe8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PPF54105D074.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z09GOHFqWE03WWZJMXNCMDdPZU95aTF5Snl5LzlDeVh0N2R6SDVKZDQ4K2lR?=
 =?utf-8?B?Y0dCaDc1bUwxaW5WRzRTcmYwdGxwWlphaks4aFV1VlBYYzVITzlJS2tXdThy?=
 =?utf-8?B?cFRHWm1mMnNjMHZzL1YzUDRVSkIySXlCbkNqZG05NTk2aW5POWlLN1U0NU1l?=
 =?utf-8?B?bDI5VDVVSEI5UDFJbXA0MzJzbnRIRDhqNzlRM2kxekd0ejRsUG9uTVZUYk92?=
 =?utf-8?B?eWE1ZzZ6K0tkYURtSmdSL3hxVStUVm5hSWFhUlQ1MW5jTWFNeGhKc2ZUbGlX?=
 =?utf-8?B?aytPRE1XU21CZUVnOTU5a3JMR0I2Y3NSRFk1WmhoanBLNUVZYS9EQVVqTGRT?=
 =?utf-8?B?QUR0bk0xOExvRy9VaXU1R0pyNDl3dlkzSmxyYTB0UEdQejVUeDhZT0VkUkxK?=
 =?utf-8?B?N29mUExCSitRVmx0VWx4ZGp4VDN0dWJVYW91YjF1MTZ0YTBYYVZtVVkzTTNU?=
 =?utf-8?B?dk9paU1kS2dsZ3pGaFJaME9XMmprMXZVNEppOThQNk9VM2JJazN4aWVyYlpj?=
 =?utf-8?B?OUNhdS9OVy9sTUpHR0V3c3lIdVB0MVA2NFo2MVRTUWRiR0l5NXJmU2t4Ui9a?=
 =?utf-8?B?bUlLN2xscGpzQkZKS3RDcW5PMkdxR0xhNndISC9odG5pYzE0VS95NE9qSnFp?=
 =?utf-8?B?TzhtNks0N0h0NkhJZ1pOdVkva25MQWhhNDhIYllva2VsRitVbktrSTVtcUNy?=
 =?utf-8?B?UlQwVGxvQzhSZUZFR1A0a0xyZ0tuUG5VcnNmN05lNGVNQi8rcm0wY202N3Ro?=
 =?utf-8?B?TktReUNmSStIa1FTR2NjSFpIdHU3M0plUVhrcmxzenJsYU1UQ01IWjMrcW9x?=
 =?utf-8?B?VWlhWWcycGRJczFWOWtEeGhtMWFoR3dadUtXVE9Lc1N4bzQ1a0dBME0xUFAr?=
 =?utf-8?B?WStWc1M1MnBNdENWQUozWk94YTN0ZVFwTDFDMng1UDIraWNiSHZuNVQ0dVU0?=
 =?utf-8?B?OEhDdDArUHFucDdNU0Izc1d5b0VsRmhMTXlxUjI5MzAvN2ZpY2s3QVphN0lw?=
 =?utf-8?B?RHRNRlBvd2Z2VTF1blQ5ZThLd1E1UmY2SnpoaTh6TzByWEZMaFl5SWJsZW12?=
 =?utf-8?B?bmsxakozTzlZNFlBN2VKT1VKTzNZSW0xY0psM3ZsWWUyd3F0eVkwbXp2UzVJ?=
 =?utf-8?B?RkF4SEoydXh0b0lrZklKWjdocEJCN0xjZU1MdllTdjgzYkxzbWdGczVoeERa?=
 =?utf-8?B?SWk5c3JFTjlaOFdoNUFtdkpQVU5NazcxSjJvWTdKdGNZWnJuM3ZFUDlpZmI3?=
 =?utf-8?B?cFgyTWwwcENwM1l1aU9lY2RQTnE5ekNpbHI0SGpxbkJQREJXa0VYaHVYZU9Q?=
 =?utf-8?B?OGo5VlZGZnpvYWxpSVZyUk5YSUhwVHN1anVKaVF3VUNCWkJrUmUwZW9UdG1t?=
 =?utf-8?B?T1VBd0lhRG9IdGN6cHNpekRGOVBocDdjOGNUTzVwa3BqRXR2REZtNHpWbWor?=
 =?utf-8?B?UGpaY0FLcHRzTHpXbDBmL3d3MmNoRG1uaE5CQkVIREtmUHFSN1ZWMG5qOGxy?=
 =?utf-8?B?UGZPQmJXWTlFUDJwdDR2VFhXZjhzZG9RMTM0a25jOURwb2U4NC83dWVWODVF?=
 =?utf-8?B?VVNqUEZ6a1piVXQ2c3llRE1lbFo2YlB1cDNMSE1IekdueDI0OC83YXdPRDRu?=
 =?utf-8?B?SnNMVGdYeDZ0Z2ZnZFNoZU5Fa0tRRno2a2FaODhvUGdoUWRLZXJtM2xjQlJI?=
 =?utf-8?B?eFFLZWNVUHl2YUpRSHdGWnhyUlRhdzEzaVI1L1FrcGRLRHV2U0cxbTV5Tmk4?=
 =?utf-8?B?dDVjc0RIVktOeFc5Q005aTNFR2RtbTRlRjU5bFU0Szk4V1E2cndiNUNzWktu?=
 =?utf-8?B?UmFuVGpIM0pBS0MreDFHYnpzQ2ZFNjJHdGRhcFZmWldHbTJDbE13Q3NCaUF1?=
 =?utf-8?B?QkM0M0N4RGFFVHFJZWorRCtGZUVkV3JyNnIxZ0F1eUEzVzVDd25xYW1NTk9u?=
 =?utf-8?B?aUdhYXR2SUt5UnY2V0d6azZyMlhCV3ZEU2ZaZHo0RFA1NmtFNGw0WU1INHg4?=
 =?utf-8?B?bkRITityeUFHSElVT281Y25rT0NQVCtXUjBMbWs3YmFxYWxkdFpNMnZnSnho?=
 =?utf-8?B?OFFTNlU5dDZOU3NVakdOWU1FejVZV0IwUDBLZnFIVzFMN05nZ2ZkcXNCaHB0?=
 =?utf-8?B?TWtrbXRpbXRVV0tJbm8vUVNyWFlRU3V5L0lWOG1vaEN6bWN4Wk94QWRWN0hi?=
 =?utf-8?B?MFA3K1BReS9WeVR5dDZUanJZc0J5WkNPdFBkRDhJWE55aFlwdCswUnI3RDhE?=
 =?utf-8?B?a1J0eW1PSFREMmhDQmtxTzRMMHYzRUtJWUVuZDVlMUNlZWZCemNQSEJRTWx3?=
 =?utf-8?B?NVlvR1k2M2NRVXEzanVZVVI5RXNYUkpBRHIrZ3RzVjVFa2pGeWZxQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	VfnnfkA+5JSVk8ye2EY6EpyU4QuglH8LQGfwkufO6NMKIiaaAEscS5mKKjUEIA+5qbNaftunvdw2JpFrCIhEFd45vOWiCuRAmJXiEeycwGnM0m7VhJ8vkToEoLvrJo3b8Esowvq/2MPVoEo1EtMyRDsfVatGZiWWpqbM1ZX2wxbiXTD02ZcluBhCiCzRshnGHZQxuspQG45NYSnOlA9ouKXpytHdMiKMMgpPcIylk2WsKZXlRKNfmCgeINO0pXvnMbjRogcDAqRLiatT3JfCkP7WziYbO5kP5TkVEAURQk5XyyIXJKgabGo4p7o9Wvut3bA7itRmQPGxsg7JQWl73Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kimZ0qTBOVZrLRphLCiNH/r8cmqLrCCAJm5YW1achFmjD+eLBZwn9Ti09SGO0qvhlhi4m45sumcFYnm2EirexsiXNL+YcxjPzq2QqGcSzfFogbO1VwePHe4iFWuFyPXU9x23l3Q6QH7OEhe9bNc7lVk2rinpHl+X4VoLMxSWbthyZRYByeq/DQMGQQUp5o3rRvtuiJyVresBET8SxpfU7RjOVrAoXkHcIy+sL4OYDhWS8XwP7pquxiMgA1+rXOaXfVhVp9sc8I93KxnLWaY8Y+QCzIWnqwgWCRtzYNTbTMe6SPKXul9Eta/zlOStfzmT8wUtov4J1tHTET2d72RpZG/rSdPE7AlPNqCsHv3WEKuVeXnEe+Ldc49XUOvzevBDM5KdoBikEphlvv6/bDx/EFe/cANDNF+cDZ1fGoySd3+IcYZ5478pY9Z6O3kjL6g3PtXK7YM9XRphpYZCq6ym2tlBIlbVOA0j5kVgEkHwKf+qoE89CCGB7SguiOoEnxmbF9nX3cBLJpuj1qUeB7CQ+3OzX/tgkWJZyO6fVM4CgnPOMHCWTWCZhorrI3OA7qp8ASJwJo0dGz/QUhbM4IFxx1Xgq+sRAdBj/cYA3tMqO13YecusO2MQyW7uGiupnU19/ihIt1ghQAbFnnfQM4Htv7/fW5fr7d96Uy8DYB+DI5AOejf9XZhEBMNK1EZNJ/49
X-OriginatorOrg: atos.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PPF54105D074.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82140d37-183f-4136-a6be-08de7dbe9b64
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 09:31:13.6922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LzWY8jOk+EHXXflAMbuZuoUCOgy0yNylA7kL32kjZc59kl9hhzjs5a8XpsUMWB62jXsKQU8qtBOMxY1fhKilSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR02MB10795

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGJyaWFuIG0uIGNhcmxzb24g
PHNhbmRhbHNAY3J1c3R5dG9vdGhwYXN0ZS5uZXQ+DQo+IFNlbnQ6IDA2IE1hcmNoIDIwMjYgMjM6
MzANCj4gVG86IE1pa2UgQmFub24gPG1pa2ViZHAyQGdtYWlsLmNvbT4NCj4gQ2M6IGdpdEB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gY2xvbmUsIHByb2dyZXNzOiBhZGQg
LS1uby10dXJ0bGUtc3BlZWQgb3B0aW9uIHRvIGFib3J0IHNsb3cNCj4gY2xvbmVzDQogDQo+IEkg
YWxzbyB0aGluayB0aGF0IHRoZSB3b3JkICJ0dXJ0bGUiIGluIHRoaXMgY29udGV4dCBtaWdodCBi
ZSBwb29ybHkgdW5kZXJzdG9vZCBieQ0KPiBwZW9wbGUgd2hvIGFyZSBub3QgbmF0aXZlIEVuZ2xp
c2ggc3BlYWtlcnMuICBJIGFncmVlIHRoYXQgdHVydGxlcyBhcmUgdHlwaWNhbGx5DQo+IHRob3Vn
aHQgb2YgYXMgc2xvdyBjcmVhdHVyZXMsIGJ1dCB0aGV5IG1heSBlcGl0b21pemUgb3RoZXIgdHJh
aXRzIGluIG90aGVyDQo+IGxhbmd1YWdlcyBvciBjdWx0dXJlcyAoc3VjaCBhcyB3aXNkb20gb3IN
Cj4gbG9uZ2V2aXR5WzBdKSB0aGF0IG1pZ2h0IG5vdCBicmluZyB0byBtaW5kIHNsb3duZXNzLg0K
DQpJIGJlbGlldmUgQW1lcmljYW4gdXNhZ2UgdGVuZHMgdG8gbG9zZSB0aGUgZGlzdGluY3Rpb24g
YmV0d2VlbiB0dXJ0bGUsIHRvcnRvaXNlIGFuZCB0ZXJyYXBpbiwgd2hlcmUgQnJpdGlzaCAoYW5k
IG90aGVyPykgdXNhZ2UgZGlzdGluZ3Vpc2hlcyB0aGVtLg0KSSB0aGluayB0b3J0b2lzZXMgYXJl
IGxhbmQtYmFzZWQsIGFuZCBhcmUgdGhlIHNsb3ctbW92aW5nIG9uZXMuICBUdXJ0bGVzIGFuZCB0
ZXJyYXBpbnMgYXJlIHN3aW1tZXJzIGFuZCB3aGVuZXZlciBJJ3ZlIHNlZW4gdGhlbSBpbiBkb2N1
bWVudGFyaWVzIHRoZXkgc2VlbSB0byBtb3ZlIHF1aXRlIHF1aWNrbHkuDQoNCkp1c3QgbXkgdHdv
LXBlbm4nb3J0aCAobm90IFVTLCBvciBhbnl3aGVyZSBlbHNlIHRoYXQgdXNlcyBjZW50cywgc28g
bm90IGluY2xpbmVkIHRvIHNheSB0d28gY2VudHMpDQoNClJlZ2FyZHMsDQpSaWNoYXJkLg0KDQo=
