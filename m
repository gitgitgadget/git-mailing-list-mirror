Received: from smarthost2.eviden.com (smarthost2.eviden.com [80.78.11.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F182C2747B
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 12:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=80.78.11.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728044316; cv=fail; b=mrQR+YVztNjR1KwwOVWsNICf3NHwxxEUpbS3oqa7yKdRBGY78P+3m96ihfol4/lDU3JmXl3+VHiMlD5bBGviQXTMiN2b6+/AOMoaiT/G6giM4Df6eqVxIbs693cfGlQuri6RdVJMuz0PVdRwd66Pov9pcXd8tmJ09o9BKFH1gGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728044316; c=relaxed/simple;
	bh=ELNWzkwwwpVKL5LhiYrDRS9Pva8eFBt1hvX8m5w+PP4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dyxAfsFrnmRLiQcrC7uHlXR0pX4HILOY7vnb/jmYT3jkf+LaYIjTzqqZ9hPu40mqIJ05g0bevHPKKXBegbEje9Arx+c7wiH4w3y/H6umGyeW6X8NthllM1GweIkuV1y6HwErblE9UkgB6TLeQGPetk9klEHPGJjip7fTyQiYq9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eviden.com; spf=pass smtp.mailfrom=eviden.com; dkim=pass (2048-bit key) header.d=eviden.com header.i=@eviden.com header.b=GFk+8EK5; dkim=pass (2048-bit key) header.d=Eviden.com header.i=@Eviden.com header.b=jQTKZVX4; arc=fail smtp.client-ip=80.78.11.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eviden.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eviden.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=eviden.com header.i=@eviden.com header.b="GFk+8EK5";
	dkim=pass (2048-bit key) header.d=Eviden.com header.i=@Eviden.com header.b="jQTKZVX4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
  t=1728044314; x=1759580314;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=ELNWzkwwwpVKL5LhiYrDRS9Pva8eFBt1hvX8m5w+PP4=;
  b=GFk+8EK5Hzd/aWlKXh//gxFbshfuMrUOqfuf301kaLOHvxhO99KlJgiw
   cZTLSLi2tLrZ6/3TFOBnIJq+sBT9ypIRKdHIjbZkkVAs6HPawbUC3x+GQ
   zw0iCpOQNQDstG1TrjXQtj2PscmgE6u1aXq7dCPftg2TFaPVyuYZbU/qX
   5DJ/MWP5Tsb/bvkrPsc/MvdMz1BeVqwdgKSkkJk7toBQNwgAl0vU2pL8r
   k2nF345wjh98Kmw6fdG76VuB9xHryStINF/Cp4RzLZZyiIoorVHaL3rob
   RTKJWmO3Kv/CNvRYuMA9qgbN5QOMxg0klz1MDlUumeC4Tkc5L1x2fxgkO
   g==;
X-IronPort-AV: E=Sophos;i="6.11,177,1725314400"; 
   d="scan'208";a="21598007"
X-MGA-submission: =?us-ascii?q?MDEtMThOey2TlNoDzNOoxV1gg5WoVIo34BdBUv?=
 =?us-ascii?q?6rKZ9Z2LHTTRmuCoW5b4lIyKecllKdPqovJqva/PWtN/abjmtWX3puGF?=
 =?us-ascii?q?iyaEy1iEepgQrGOMdFjrhyN6ihljNHwl7JJydTxLvf8x01nnXY0CYXo0?=
 =?us-ascii?q?Eru5o+6SWT2NHW1pdrRKPwgw=3D=3D?=
Received: from mail-am6eur05lp2110.outbound.protection.outlook.com (HELO EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.110])
  by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 14:13:22 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2v5kPnMO7DXomcdm7yT621qwLTvqEWnBr9W/mL48Abb2Zvs7oiiv6YtOLQV1OEP3UQZsNVTP8XGpz/gkrwcTXqLjPrBnKTzSMr4uI4dgsBem0aqLI+Xo+9LmiOn+su8bxLK25/M0S+auP0RpJTvptdGgKnyHaC5VpFEmf4AjPFmXVL3EgHZJgDsHG8fE6iQ0JvbcV2XVZnOTFnSZnGfevPIgWNsUO8iU5EgO8s/fcH0LyuayioCKahowd6l2L+iEB30W91kBh+6WMSIGBI+MSApz+slAezNzUZ5Vp3XaC01xnhjmoj8DqyW7q/YiWAsn06G4SDxh+8yzUiR/mqhaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELNWzkwwwpVKL5LhiYrDRS9Pva8eFBt1hvX8m5w+PP4=;
 b=JQfow/z6QiaIzuPjKM/a4ltjOuW7ZsFcVfvwiwtxMRpc0FpnKiRai4NPh1vWnyheX7vV5W2uOjJ5xX28ABR91l3F+rx2W3tUlDKmQS3sqebY71g2HQkwbRcccP7o00p2fkpgRl29P5Nu9yY1i9YlBRWUfBDewlEpW+sIHqGA+wEyXbzLdWkJBA5Jc2OclsZMj8zcJQrgFY1TQS+R+hxMKHZcwnYQJNQnfBG+q3vJ8McY2KhM6JtVj07Yy3kMNlgAwMkruT/6otq3o+2UWz7BP+D8neCbPbRMquQxo+BUSJqPBrImO7YYQoEjUHk3l4xhcPaQrHIb+RUVSacW35Nikw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELNWzkwwwpVKL5LhiYrDRS9Pva8eFBt1hvX8m5w+PP4=;
 b=jQTKZVX4WPUr4vfk8zCiKXXJ00QhCzW7AT7Kwlv5pGPnzLXrVkjXH1tPY2htnBWUR4NapZtJOo63EmNuVheuv6VVpUG5SH1xbUrj9nLZTO9AmNuzV/IcDlnfVHL3HUcXJ2ULpdCH/MEADSNUpqqQj52t2yUuZbfBreHUM5rEdwkF8+amIvpKF1q/fwoh+RwmlFWK3utN4PhuLeSGdAUSzZnpLX1vkHjEsX9jkXU0fIVOm3DXYvHpyEluv5EXVduFVtwuqUbCyqIpmnydxCfBUNaPQxp4NYLDyRvs37noV+wAELBIvvD5iy9NoZuv4/W+V6wfG8Gt9n3gUX8JFegBWQ==
Received: from PA4PR07MB7406.eurprd07.prod.outlook.com (2603:10a6:102:c8::16)
 by PA4PR07MB7277.eurprd07.prod.outlook.com (2603:10a6:102:fa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 12:13:20 +0000
Received: from PA4PR07MB7406.eurprd07.prod.outlook.com
 ([fe80::f885:5976:29a0:5b03]) by PA4PR07MB7406.eurprd07.prod.outlook.com
 ([fe80::f885:5976:29a0:5b03%6]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 12:13:19 +0000
From: Richard Kerry <richard.kerry@eviden.com>
To: "phillip.wood@dunelm.org.uk" <phillip.wood@dunelm.org.uk>, "brian m.
 carlson" <sandals@crustytoothpaste.net>, "git@vger.kernel.org"
	<git@vger.kernel.org>, Emily Shaffer <nasamuffin@google.com>, Junio C Hamano
	<gitster@pobox.com>, Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: RE: [RFC PATCH 1/1] Add a type for errors
Thread-Topic: [RFC PATCH 1/1] Add a type for errors
Thread-Index: AQHbE4SywXxEJnMge0W/JfB1tHisyLJzOzcAgADL6QCAAkmmgIAANOVQ
Date: Fri, 4 Oct 2024 12:13:19 +0000
Message-ID:
 <PA4PR07MB7406087827EE13D3716C82649E722@PA4PR07MB7406.eurprd07.prod.outlook.com>
References: <20240930220352.2461975-1-sandals@crustytoothpaste.net>
 <20240930220352.2461975-2-sandals@crustytoothpaste.net>
 <2d2f14ea-cfdc-4b52-948f-b42c8f6e41de@gmail.com>
 <Zv3DehUxEN6SJI1M@tapette.crustytoothpaste.net>
 <c37e4dd0-9ad0-4d96-9d0e-ee13d64eb7a0@gmail.com>
In-Reply-To: <c37e4dd0-9ad0-4d96-9d0e-ee13d64eb7a0@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_ActionId=b270da66-69e5-4e9e-895e-fbfd401199dc;MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_ContentBits=0;MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Enabled=true;MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Method=Standard;MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Name=Eviden
 For Internal Use - All
 Employees;MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SetDate=2024-10-04T12:10:08Z;MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SiteId=7d1c7785-2d8a-437d-b842-1ed5d8fbe00a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR07MB7406:EE_|PA4PR07MB7277:EE_
x-ms-office365-filtering-correlation-id: 0acfe6b7-f464-41c3-e2d5-08dce46def54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UjEzSkZnTFdYem5HVkFtS3AzSW51eFZHVWFhaWVYdjVWS2ZJcVFPUWxWSUFk?=
 =?utf-8?B?OTVBbmJBalJxRlErb2xCak5keEp0dkt3RU9pV2Z4NjV6Y0dEQjJiaE9NQTB3?=
 =?utf-8?B?bk4remF2cXZ4bjRGSmlMeUJwdGM1Qk1MYmd1aEtuQzBMRGYrcUxXdjJWdnFB?=
 =?utf-8?B?RUhDZGYxN0hWcnlhUlY2U01mL2tIMUdrNUJicHpqWitwNnl1d0hRUytHUW9v?=
 =?utf-8?B?cFI4ZHJSTHFWN0FXd3R1S3pkcjJWQnFGT2hNbjhERnFTMkNnQzZ2bHBRaFFZ?=
 =?utf-8?B?bWZrcFFuT1Z0K0tyS1BKeFUxWUdZYVdZREtGYy85MlllWFd4YVNYUTVlL1FV?=
 =?utf-8?B?bWNPdTNaZ0FuNFpVL2JkdUZEMTRUbTY5ekNMZWlGZU8wQWpnRVFFRFVjZmY1?=
 =?utf-8?B?TFdGS2tuZGhDdytTck9SNllwZW81WTdhM0ZvNitWV29UbnNwb2NxTU9QVDlV?=
 =?utf-8?B?b1FLbm9LRlo5NnNtN1VYOUExSUxveFJWR0p3VkNKc3h2QzF4OVkrVzcwcE44?=
 =?utf-8?B?WVFRa2tFOThtL09FVCtzNDQzbEh3ckdVbDE5RVhuSWNZaUZXYW5RTExic1Va?=
 =?utf-8?B?YlFFSWFueVhQK0tSbnpzMlozNEIzT0R1dU5ueVp2WDRTVU9Zd0RzUFYyQ2h1?=
 =?utf-8?B?aDlRenk4dW1SZHc0ckZuRGZvUTBRYlREaGtWdTg5T0VEUXVCekNRcm5sVW44?=
 =?utf-8?B?aitBOHZOaXNURER1eEZOSFBXR2E3UTJqQ280T3hQb2dVVFVacEZ4TkhCbUdX?=
 =?utf-8?B?Vk9Rb0M0R1NLUE9iektMRVV0dEpWcVA5dHFPVWgyd0E4VElURStwM3ppOHcx?=
 =?utf-8?B?d1I2T1kwSjF3OWNlRmpFZ2cxa1R0UzhUTVhBOG85QTUyOXlrM21MZGdwRGo4?=
 =?utf-8?B?MERRaGp6WFhNUDBHMFNyWit2eGRsTnRqWC9OamU4R3NLeXA1OHRBN1FaemRY?=
 =?utf-8?B?b3FUQUptTGZMSUtWeU5SV1Z1UWYxVEZlaWt5OTZPK0lLT3F0N2NqTzlYekpk?=
 =?utf-8?B?aXhpaE51WUx5ZWFTK2x4dXpzcW4zL01oaGdYdkRjZDVtL0JXeDg5SGZsaW9I?=
 =?utf-8?B?N3pZYi85NVU5UHZqOEZuN0Jwc1kvZlpKQis5Q3czZ2tvSHpMbjdBSDdYZXpu?=
 =?utf-8?B?N0NrZWtRam9SdzI5VFBGVnI2aWlvTlFpN2xHTzMzZjRYM0tHMU9WcVR5TFF5?=
 =?utf-8?B?M2xCa245Ni90bklFcnMyaEJJR3pZTTdEK1R1QXB1VFA2Q01PSytBQVhubWZj?=
 =?utf-8?B?MmZKQXhtMFlNODhNUjdpV3RjUmFITVhkR05RSXNIeDcxbkdaTEhnbjF5UTlL?=
 =?utf-8?B?aG12TTl0M2lUODZleXJLNWJKT3NZcjFvcWhOM0krblNFN0pNbHkvR3A3WHRl?=
 =?utf-8?B?TjBSKy9CTjdBRGs2RnByV3pQbVpPRFVWdmwyekpKMndjSlNxNGFEZnR5RmpQ?=
 =?utf-8?B?OGcwOHFqK3cyMGFoZXRHUzVxTjg2aXNBaHBpUGE0TXMrK3hPeUhFQm5WTy91?=
 =?utf-8?B?Y01zQkg4d3JVOTRmdmg5MHBlY3lkMFZseDEydDZvSTF0VzJrRVJab3l3UHU2?=
 =?utf-8?B?UW9yenBJUDIwZTFUS2k0THdCeTZHTlRpNjZTV1lIMTA1NkZVbW1PWCtiU3Nn?=
 =?utf-8?B?MlBXVS9LSnFNdWhRNkFlSVBmY1VVeWxycWpkUXRYVzZGQUtHZjZNU2dzbFF1?=
 =?utf-8?B?ejNWTm9VVDRTTm1ZZzZic2FEWG1NMlpOUHg2cERXWVFyOWtoRGdSMEJVa0g2?=
 =?utf-8?B?VStNR2poOUNaZVlCTmtScVYwUEYvdjIrUFBSSktRL09kc01FallPKzlER2NL?=
 =?utf-8?B?dUgwYnFudmNCMTcwYVNYUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR07MB7406.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N3FhNWJnZytaOERRdFFBZ0U5QUVSQjZ5am9iNlRNbFNDSVl1dDRHMnVGczJF?=
 =?utf-8?B?eW9sUHQ4bUdxZFRsanQzcVRER1BtL0pNMkI3U1o5cGg4Z3QvNG1oekJDSGhR?=
 =?utf-8?B?WlhIM1doYU5pb2Fid1p4eVpnT1dOQWY2VlpUZGtyV1k5UzRyeVZLTVIyK1do?=
 =?utf-8?B?U1ZLTUFzZXJHSmx5VlBDdWJEd3RITTA3QVAzN3grUHR4NXM1KzZtSzdPQXdM?=
 =?utf-8?B?N3drd0NES25pN3FWNDNKZEI2VGtuWXlFOTBSNm5vNlpDSkJ2NXJqdXYrQVlp?=
 =?utf-8?B?L1lMckZQSjNVQVRRRzFGd2RTU3JJaVlxUFAyQXdCeEhwaE4ySjI5NzJTRCtQ?=
 =?utf-8?B?K3RNZ3hCeFRQSHhsYUxDQ3IwVWJNbDhxMkI5d1pRTVNrYTkyYUxMY2UwZStl?=
 =?utf-8?B?MVkrTEVXbFB5M0pIOHVBeEthQ1dHKzhMWEJKN2ZjeEVNa2tkK21DVzdhOHl6?=
 =?utf-8?B?amdYK1ZhYlBQYitJdGd6TTJqRG5LUzFiYkljOGVyQ3lsbFdqOVMvRUlQdTYr?=
 =?utf-8?B?dXluOEFjbEw5aDYvc1FOZDVHUHpvRGpZQ0hhK0gwTjRZTk1YVk15ME13amVJ?=
 =?utf-8?B?RFZiSFFCaXpSRnBlRGcyYWlTS1dEWTVYRHREZk0xSjlRWFA0am8yRmMrSTZr?=
 =?utf-8?B?eXkzQ25xSlZmci8vdkZieFZFeWpEY2R3emhVUitiWlladlhtSHdRVmFCOE84?=
 =?utf-8?B?a1dKZTRianRRRThtRmd3UTlOWUc3T2xZQXF0STRMUEJFVVp3bXpzNWVBVmZo?=
 =?utf-8?B?UXJsRERGS1BRTVdBSHBhWk81cGY4M0QvaXFDOFNTWWhhMjZuaXIxSzE0Q1ll?=
 =?utf-8?B?UDlVUXNmeWc1NHV0ZXVzMTNCZkpQUHBDS3ErVlhrNndFQ0NyUmJBVUJnQnJl?=
 =?utf-8?B?Z3NEem1RMFAvS1J1WHhNSlp4NWc0cFRNcXFhOEpGSFFxdENxamZPcGtSTFlR?=
 =?utf-8?B?bm5qSmEwNEl6SEZTT0dkanNrUlJlNXd2OE4xbWhvL21mZzhtaTNJN3hUeC9X?=
 =?utf-8?B?SGJBKzE5ZEJMMFVrWE1aZ3hjSTBsWWJPQ1hvM3NYRy9vUzBnc0pUUFFud3JW?=
 =?utf-8?B?ZE9aNUJoY3lybEd5am12azd3VnJXUitWWkk5K1hmSVZMZklBcHYvaXhpb3RH?=
 =?utf-8?B?ZXp2bUZuZjFFSU1lNHl0d3ZLaFBxUTA3alhwS2QvK08yUzlGODkxaHVqNytU?=
 =?utf-8?B?bzJVTFpDREprWU56eTdRQXJOY0Y1Z3ZjejVacjJzbjRSaWZDNktoa3h6YWYy?=
 =?utf-8?B?YVBYZTRCT3RoZDNleHpqVDlLU1RHTng3SUh0dE9uS05nNDlxekREdXlCb1JC?=
 =?utf-8?B?NytyRGJBRUl1UnpISjE2dGxRZkRub3dDdFpHSEF6UUpXT1RvSGgzdmhtNjhH?=
 =?utf-8?B?U25nOGJNeEVyRURNYXJNY1VaeFVWdy9LbytMenEyQncxZUJLc2U0Zm9SSmgv?=
 =?utf-8?B?NzAxUG9QUFhhaW0yTHpGSHp0T3pWdHA2UWMyWGxlaHB6aXFCYjBTRzZJTkht?=
 =?utf-8?B?Q21jZG9BK1M1azBHeFhKVVFEbnRZRHRsOS9lWkdDc3ZsNkVDa0wyRzVEUXJ5?=
 =?utf-8?B?V2FoeVVZMFBmYVRvN1A4V1dSZFhRUzI0a2pBRVNXUmtDYm1FWkZ6WG9aMXN6?=
 =?utf-8?B?dUN1VHRaQUdsK1lNY0E3STNZMlJDbVljbDNPeDlWOGFsSmo5VDQ0NTh1dmVH?=
 =?utf-8?B?bXBENnR0dnpUZlppb2gzSUNyZFhxTmpac3l0a0l0RCsycFBXb1ZmL2JMeDVS?=
 =?utf-8?B?WERaWUY4Snd1a1ZiZVVwZC9OVkZqbDhPeDR4bitmUVIxYUoxM3NZUXNyRlpn?=
 =?utf-8?B?UERpK3ZEbWtaWGdnY1lnLzllRFZEeVFSSU5tdDljU2Vmano4RUh4a1NiNW1k?=
 =?utf-8?B?NzR6Q3ZrWkhNdlJ2YWo5Q1FPWW02L3JLNzIxRFpTRUFSc013WFhlKzNWZjVH?=
 =?utf-8?B?TDk3L2x4NWs2T3RlcU50Rmx2RHZqOHB4aUUxcTltbGpGNDI4eDQzd2NWTFY4?=
 =?utf-8?B?cnJtdURzY1dZQ0JBajZzU0FTenNRcWRzeUE1UDJEQTl6NGJ1dnh4SFUyT05F?=
 =?utf-8?B?NUFVRFBoZlRXbi9LWjhwSmdVM1RQeVJMRXlWd2N3MWJKLzFGK3B1Snhjb0xU?=
 =?utf-8?Q?sQ8uI51xrSTRkbZlVlFSGRdog?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR07MB7406.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0acfe6b7-f464-41c3-e2d5-08dce46def54
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 12:13:19.7067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RJ3StsMurV8eDXYhXV4AUYJUjYoKdtbKfqIIEzyonRMYWLTQJ1i3lM8haQWtB/m25WY0SY9YKTIdW+rrxmwryYw2kEPiNJ00HkhJFMiCO5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7277

DQpUaGlzIGlzc3VlIHJlbWluZGVkIG1lIG9mIGEgc3lzdGVtIEkgdXNlZCBmb3IgcXVpdGUgYSBs
b25nIHRpbWUsIHF1aXRlIGEgbG9uZyB0aW1lIGFnby4NCkRldGFpbHMgb2YgZXJyb3JzIHdlcmUg
aGFuZGxlZCB1c2luZyBhbiAiQXV4aWxpYXJ5IFN0YWNrIi4NClRoZSBjYWxsZXIgcmVjZWl2ZXMg
YSBzaW1wbGUgcmVzdWx0IHZhbHVlIGluZGljYXRpbmcgT2sgb3IgZXJyb3IuICBJZiB0aGVyZSBp
cyBhbiBlcnJvciB0aGVuIHRoZSBwYXJ0IG9mIHRoZSBzeXN0ZW0gdGhhdCBpbnN0aWdhdGVkIHRo
ZSBlcnJvciBtYXkgY3JlYXRlIGEgZnJhbWUgb24gdGhlIGF1eCBzdGFjayBhbmQgYWRkIHJlbGV2
YW50IGRhdGEgdG8gaXQuICBUaGVuIHRoZSBpbml0aWF0aW5nIGNhbGxlciBjYW4ganVzdCB1bnN0
YWNrIGFueSBmcmFtZXMgYW5kIGRpc3BsYXksIG9yIG90aGVyd2lzZSBoYW5kbGUsIChvciBjb21w
bGV0ZWx5IGlnbm9yZSkgdGhlIGRhdGEgdGhlcmVpbi4NCg0KSWYgYSBmdW5jdGlvbiBkZXRlY3Rl
ZCBhIHByb2JsZW0gc29tZXdoZXJlIGRvd24gdGhlIGNhbGwgc3RhY2sgaXQgY291bGQgc3RhY2sg
d2hhdGV2ZXIgaXQgbGlrZWQsIGFuZCB0aGVuIGFib3J0LiAgSGlnaGVyIGxldmVscyBjb3VsZCBh
ZGQgbW9yZSBmcmFtZXMgaWYgdGhleSB3YW50ZWQuDQpBbHRob3VnaCBJIGRvbid0IG5vdyByZW1l
bWJlciB0aGUgZGV0YWlscyBpdCBjb3VsZCBoYXZlIGJlZW4gdGhhdCB0aGUgY29udmVudGlvbiB3
YXMgdG8gc3RhY2sgYSBmb3JtYXR0aW5nIHN0aW5nIHRvZ2V0aGVyIHdpdGggYSBzZXJpZXMgb2Yg
dmFsdWVzLiAgVGhlbiBhdCB0aGUgdG9wIGxldmVsIHVzZSBhIGZvcm1hdHRlciBmdW5jdGlvbiB0
byB0dXJuIGFsbCB0aGF0IGludG8gYSBzaW5nbGUgYWN0dWFsIHN0cmluZyB0byBvdXRwdXQgKFRo
aXMgd2FzIFBhc2NhbCBzbyBkaWRuJ3QgaGF2ZSBDLXN0eWxlIGZvcm1hdHRlZCBzdHJpbmcgaGFu
ZGxpbmcpLg0KDQpUaGlzIG1lYW5zIHRoYXQgdGhlIG9ubHkgY29tbW9uIGRhdGEgdHlwZSByZXF1
aXJlZCBpcyBhIHN0YW5kYXJkIE9LL0ZhaWwgdmFsdWUgKG9yaWdpbmFsIHdhcyBpbiBQYXNjYWwg
c28gaGFkIHN0cm9uZ2x5LXR5cGVkIEJvb2xlYW4gZm9yIHRoaXMpLiAgKEltcGxlbWVudGF0aW9u
IG9mIGF1eCBzdGFjayB3YXMgaW4gYXNzZW1ibGVyLCBjYWxsZXJzIHdlcmUgUGFzY2FsKS4NClRo
ZXJlIGlzIG5vIG5lZWQgZm9yIGEgc3BlY2lhbCByZXR1cm4gdHlwZS4gIEludGVnZXIgb3Igc29t
ZSBzb3J0IG9mIEJvb2xlYW4gd291bGQgc3VmZmljZS4gDQpUaGVyZSBpcyBubyBuZWVkIGZvciBh
IHNwZWNpYWwgdmFyaWFibGUgcmVmZXJlbmNpbmcgYW4gZXJyb3Igc3RhdHVzIGJsb2NrIHRvIGJl
IHBhc3NlZCBpbnRvIGV2ZXJ5IGNhbGwuICBUaGlzIGltcGxpY2l0bHkgb25seSBhbGxvd3Mgb25l
IHNldCBvZiBlcnJvciBpbmZvcm1hdGlvbiB0byBiZSByZXR1cm5lZCBwZXIgY2FsbCAtIGF1eCB0
YWNrIGNvdWxkIGhhdmUgc2V2ZXJhbC4NClRoZXJlIGlzIG5vIG5lZWQgZm9yIGEgY29tbW9uIHRh
YmxlIG9mIGVycm9yIGNvZGUgbnVtYmVycyBhZ3JlZWQgYnkgYWxsIHBhcnRzIG9mIHRoZSBzeXN0
ZW0uDQpUaGVyZSBpcyBubyBuZWVkIGZvciBhIHN5c3RlbSBvZiByZWdpc3RlcmVkIG1lc3NhZ2Vz
LCBvciBhbiBFdmVudCBMb2cgKGVnIFdpbmRvd3MgbWMsIHJlZ2lzdHJ5LCBSZWdpc3RlckV2ZW50
U291cmNlIGV0YykuDQoNCg0KUmVnYXJkcywNClJpY2hhcmQuDQoNCg0K
