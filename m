Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3025769D04
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 09:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709284166; cv=fail; b=RlcgR3eW5dLir//dTqz2vQhobqN5Q5iQ3tpePxxoCsDa1Eqw6C9d1620DrCnKM+nW6E50Rp2pF8s0XLDf06j4wFGipdFBMQ0BDMRoA5u7hlc/Yfu04iYBDTJQ8vytILJwtJEW0gXaiyJAh3GyQxFIKv4MW8JhnYEL7ZlPnSADZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709284166; c=relaxed/simple;
	bh=GGAjOvv0raZXXSzfiNtlsrW/LTtChrFL4AxMKAFfFfY=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=TSB/DreWJEecA5vkMy4M5egPzENMc6Uy+/jRCz+Y3tNPUVbu8w9wkrv8PEb9bC7Z4y7SDJj+KSFXt8g3VwAKhjZvh2rlEaxT/JBRrGy7yrZA7bRQgADEVigwp8pzpvQieW6Zs0putCdX3lDaRrHCBmHkOpHVFNZhve4O6Hmadb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hQolnK+J; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hQolnK+J"
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42196XpN022775;
	Fri, 1 Mar 2024 09:09:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=GGAjOvv0raZXXSzfiNtlsrW/LTtChrFL4AxMKAFfFfY=;
 b=hQolnK+JaZ/7cCRcHGHyJSecSMNl4sk0J3oJEyWlO8ADDHjxIMYIjikB2sakNWAgNz7w
 L6M1IK/Ak1fi2WumX38Kaojn6H+Ey7AMpIDvD8FHqSon00pw+0u76p+3A1vaVOkrj648
 p2LI5Tqux1XZUPQZlVGz4uav7G9+ohmCecLL6N1m+XeGiNz+dbT5Id/zCtxWLNaGOcRH
 3FsdZ+odmfBsgSlhvh4O0i1GoMu430gDboC8+vqxxNGNRm4VGlpNLjiQcAM/oAnxc5PJ
 s4FiPZYwVaxFS9fnOKFcz3DGIB6khFZ71WFSCLd1vHmbWsURCPLTtg5pxXc0O/0VA1sy WA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wkc3jg1qg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 09:09:20 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42197wbQ027708;
	Fri, 1 Mar 2024 09:09:20 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wkc3jg1q8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 09:09:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cN+fllYu45kA94SQYmRbef0g+FBRtKJ2wSb3cG7IZ5KLX6UBvg600cUBGniNm4fNmOUL9QD40Prsb8sUlJvIw8Hxm5Fq5pWeNtE0p/ZCEFpVA23qofgwXm7JDwuaMY62lFvg+/zbXEMl5z35OT7Vq4k9oFpNog4vimINYOAa0gxnD99oqk4j5d+CxGUG/JUP63t48tvvpXEYvU48XWkc4xfwpx1fgtFCTaWZrLZ23AyeiYyly+FKM20paKStUONplxS5VXLiO3uZSfQoP3uMrwecYa3FI3SkEzQDuJs2a9NbJjFJ68A3vxk//UBOyR+k1Hc2966R/NiniBHDsdHEKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGAjOvv0raZXXSzfiNtlsrW/LTtChrFL4AxMKAFfFfY=;
 b=euXZX2xmAyfkrq9QvRIO5IGntULf3YZaYhnp6kK4w8QMWkLvjwggeIx+IKWjcULeZ+OBcgwot8hkp8I9OIRE3PzAc31r8CWVpQ0VCT9L1RIRYTWpVHBqvXpIPIqIDStBcbKSzKSF56KfYiZbUM3n1wUn2/L/u9qGCWaM6W1K/x9yv4p5Afa67UywfNlMbZ79eztqfI2nrPbuc9Li9f7MWrBENKbJAYnNhLhWJwM9N0Rqh4KEshakS+Qi1Q0heQgyT9Z3eySePmgsDqmrVg94JKGS2jg+BD0iejF+BCYjYPsWZjf9/O1AmGigFdXWDxaW43bKaPLfvf52hybiLcGVJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from DS0PR15MB5446.namprd15.prod.outlook.com (2603:10b6:8:ca::7) by
 SA1PR15MB4888.namprd15.prod.outlook.com (2603:10b6:806:1d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Fri, 1 Mar
 2024 09:09:18 +0000
Received: from DS0PR15MB5446.namprd15.prod.outlook.com
 ([fe80::845:c5fb:6101:b56a]) by DS0PR15MB5446.namprd15.prod.outlook.com
 ([fe80::845:c5fb:6101:b56a%7]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 09:09:18 +0000
From: Haritha D <Harithamma.D@ibm.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
CC: Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Junio C Hamano
	<gitster@pobox.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v3] build: support z/OS (OS/390).
Thread-Index: AQHaaNuoE+M1pSFCDky4b8aLMCgY57Ei+sKA
Date: Fri, 1 Mar 2024 09:09:17 +0000
Message-ID: <B3775704-6FCE-4994-8682-309D521FD2CB@ibm.com>
References: <pull.1663.v2.git.git.1708660111.gitgitgadget@gmail.com>
 <pull.1663.v3.git.git.1708841439516.gitgitgadget@gmail.com>
 <xmqq7circevo.fsf@gitster.g>
In-Reply-To: <xmqq7circevo.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR15MB5446:EE_|SA1PR15MB4888:EE_
x-ms-office365-filtering-correlation-id: 10072373-6e8e-400d-1362-08dc39cf4650
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 VDBnR7ed1w9IkgIuK066cw74EwHC1y9oESu/RnEFzO3HB6XUVMQR3bNpaJl7R9+0I9Qabfq+cojoCUay5cu5kd2nds+40yWFeZi0HAS/pqpVDxkwpkYSNGtby+YwhmCulTPyrfT4xlSGFTcv336h5zqW7e9CvL2IMj6D4ntqA6qJAFXmgbNdQprqzRP0Hy972Kuv3ko6KsPFZ2EJbQSFu+eW+JuzsFSJIM95SBWz7T5n/ejrbNB3ybrSARhHwFaMNgoljwFD4uSUuCy4kYYpeOqHpy7bvyzpXNPI1KD2XNU1kugBzu5hr1aAc6gFDEVW0Ilw2bQmGD6fc2PgAAPFt3guqgONewkW2vBvw5DH1xBD44HEI+sjR1QxutYcFAUgVx4ELZ/OWzlBSzPZAIB94wxIGd+4X9LB5hjsJQQfjh/5wGOPE1yawFd1U+phifiq4PbFNmv0fQWcHGgKQhNNDxVrPsF5ee47gO0h0258MqtMycHHWgFDua0EHASJugEEkTzSkWgY7KK4yh4151zgZ6pim0SH1HLErgnarc9ooJgiQtevwR9lP+NTYv83L0+fRCop48w94fapbrCHeA0z0esm3eg4XAWeaxPV+h9+K2dveMn4iSOHj492l1y+WURXPDyvw9S4xp7vIF9ai0bn3TCb0Nd4/OsSoIesSetuSY69npF82TTjq+Offep1t7GtC544mIkyI+bbucsAPMe6K8Bh4JCybdJRZ1Nv+0t4gKo=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR15MB5446.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?QkR1WEtHTllWak00R1diSXoveXU5VU5TOGhaQTdUS0JqVUtlWFAveFEwWjBC?=
 =?utf-8?B?djBaM0lHbzkzQ3lEM0pzeWphd1NIamhuek1CVnlwbmIrWndiMWpEUEg3SzlB?=
 =?utf-8?B?NkUvMmxIRFAzZThqU01kQUZuSUFoUW5Vd1NORnVQdXVNOVBZQzkrQWRwei9z?=
 =?utf-8?B?cjJ2aXp0dDJHQTFMQldPamdIR3J1K3hUUGZCUzRjaTdQWDRhei9aUzB6WVpn?=
 =?utf-8?B?SUVvMnZvbnZqdTJaYU90azBGRHBIaEJXNEdtenNIejB4SVRJYWlFWXUxUXRB?=
 =?utf-8?B?Y1NqTGJYbldHZFIxR1JFa1JrMWYrLzBpVHdLYzNUWHlCM2NLWG41VkdxdjRk?=
 =?utf-8?B?Wnc0d2p0YzcxNnZud3Y2SGdyb2UrWkozcWVJTGQyOEZVQ1oveVVsaUVTRlRU?=
 =?utf-8?B?TW9oTXFjSHErdEtVV1FrSk44MFBXeG5PRjRmMVY0em01Rnl1TVFkTWZwSXRH?=
 =?utf-8?B?UmtPUXQwa3R4NExDOG1Kd2dnR1VuQXRvK1JwWWtJSW5lb053dXlhYklLQlQ3?=
 =?utf-8?B?RjNCQjlaRlF6M3o2MEtuUUIzd3YrMDBpbDZremMrNjNSd1RkMFZKZkhVUXZr?=
 =?utf-8?B?eVNReE9Ycjh1Wk1kT2pMUVFLeHhramcyeDFxeTYyZ1pIc3l5VUtGL0VQNDNE?=
 =?utf-8?B?QUFiVWtLeGF1L0w3UW56V0tzRkJ5cUYwM2xmakx0Tk9ac1JuMXN1WU9NTmw4?=
 =?utf-8?B?R0psMjJSRERnNUwwTTVZVkZLYVFiQlZMc085NGc4NUtYZ0hndHF6YVNTTDFI?=
 =?utf-8?B?aWhWbUZuT25ROUxjQXFsM0ZFYW5TOENzb0Rrck1uT1RDTm80bDJRK1lSY3Bq?=
 =?utf-8?B?cXZVRW5VTndYbFJkTmVObXBtc09XUHB0ODdSMXRGVVhXbGZoVUcrRHdiMitX?=
 =?utf-8?B?dXQvVG40dmpxYUN3NEpQbUNhV2prOTZiamlkTHNXRWtBMVh2UC9Hd1FjaXQy?=
 =?utf-8?B?a3hEemlaSkZBdXNwRUlLeWRwSG9Ubi9lQ0ZHNzN3US9YVG5RR3pVZWYyVlRM?=
 =?utf-8?B?MDdaLzVERklSUHNQMGx6cU5VTm5EVXphNThaelBHRFkwd2VTbitGTDRaelRa?=
 =?utf-8?B?WWI2Y2QrYXRJaG5aUEdHVjlMRmdEN3RMWHh3eEh4UUwwVEwwRFlEWHYvNWMr?=
 =?utf-8?B?OCs3TVFDYkJyd2pOUnNrREpzYU4xMHZiYUJCZjJ5UUdLeVZ4dlJLMDd0ZTY1?=
 =?utf-8?B?WWMvL1ZFVzFmdTFFQWYwUWxPbGQxNy8zOGZtVjdHUGpBeE5tdHhRVGlEbWdC?=
 =?utf-8?B?bk82YnVLS2tuZmV3SnhmNmwwVjhQVGtBY2VkVHRvN25ZUXlqaWcvOUtUWnhG?=
 =?utf-8?B?K2cySmMwdG9aWXJhSG9nbGs5RUVNVElUK1FubVR5dkk2SkxmUkQwU0YwOG4v?=
 =?utf-8?B?VDhTSUg5aUZjVGRlK2VieGJRbXlUc09TcXVsWWZBbTBGT25wN3RpOFEvWUJZ?=
 =?utf-8?B?VklIM3huVTE1ZTdsczU5dXJXR3Ewc1BnV2c5K2pLUUM0Q3UzZHZIUVlLd1RH?=
 =?utf-8?B?dmpSdU94RXBpbWlCVmxPTThOUGNWcDVTVko2b3ZYYTcrZWZ0SGsxRDA1bU9Y?=
 =?utf-8?B?a25yNXNFQ1oxZ0VXVHNPT1NjZUs3bEpvYWc4bitEb25yc21lUEZla3hJUWZF?=
 =?utf-8?B?aWY0SDdvTWQwWHlKejNmUmdTYndlODJ4ajZubWFXUS9PeWhVUFVrVlVpNU1j?=
 =?utf-8?B?MnNPZzlLRndGajJMNDJwRkZ0dGNtU3RPQU5OS1I3ck1FeHpiRytZUWJsUmlD?=
 =?utf-8?B?Q3FEb1VnUkVrV25OYi9QWFN2VHh3RHE5WFp1bGRRWjhzQXpnWkw4Z1ZOa0hR?=
 =?utf-8?B?NkpKMVU3Y0NKckFHZExUSWk2TEVpcll0ZmwwMDIrNmxhNndTQjRZMVhJZGRq?=
 =?utf-8?B?Qi9sU29GMUpMbmNoTVo4YlNTb1RqSGdFYnBmdVUyU3hDVVd1Q1dhcHdOWnNh?=
 =?utf-8?B?OHo4OTQyZ0FlOGdTWDRvQlJCVmRFZzdjRm4wanJ2VTV1WU1IYjdTU2J0aTU5?=
 =?utf-8?B?NWYxelRkOWRwQU9HU3QzZEMxZlZxeVlFSHphblNCRWEzTXhaM3ZmNEo1VTA3?=
 =?utf-8?B?bEpyVUl6RFdtZWgrUXdoN1lUUklYNFhsQmIyUHdkVUkrWGpEVkl5bk95b3N6?=
 =?utf-8?B?MGtXa3pqeGJIclJoRVVtN1lvT251Y05LZzBBTjJhKy9wcjVWU0lCVGJ1Rk9j?=
 =?utf-8?B?dVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E7777876A63AC4B9A76B58165AF9721@namprd15.prod.outlook.com>
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR15MB5446.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10072373-6e8e-400d-1362-08dc39cf4650
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 09:09:17.9903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2o0vXT7hwdpL5dvgBSxewZYPuEMnzRnvaRge/It1TwFtWe6go//rmk7iYvhfgvfkBnBqnHH8Dyd2q5q0BqjtUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4888
X-Proofpoint-GUID: 2gz-y8V8INtaFJfyGL026HFGLHMhIsk1
X-Proofpoint-ORIG-GUID: 0jMU0OCDpsG8dYpGGACGhPz1j1R1gEAT
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH v3] build: support z/OS (OS/390).
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_05,2024-03-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403010076

SGkgVGVhbSwNCg0KVGhlIHdpbiB0ZXN0KDcpIHRlc3QgY2FzZSBmYWlsZWQgc3RhdGluZyB0aGUg
cmVhc29uIGFzICJUaGUgT3BlcmF0aW9uIGNhbmNlbGxlZCIuIEkgc2F3IHRoYXQgaXQgZmFpbGVk
IGFmdGVyIDUgaG91cnMgNTkgbWludXRlcyBvZiBydW5uaW5nIHRoZSB0ZXN0IGNhc2VzKGJ1aWxk
KS4gSG93IGRvIEkgaGFuZGxlIHRoaXM/DQoNClBsZWFzZSBzdWdnZXN0Lg0KDQpCZXN0IHJlZ2Fy
ZHMNCkhhcml0aGENCg0K77u/T24gMjYvMDIvMjQsIDExOjE1IFBNLCAiSnVuaW8gQyBIYW1hbm8i
IDxnaXRzdGVyQHBvYm94LmNvbSA8bWFpbHRvOmdpdHN0ZXJAcG9ib3guY29tPj4gd3JvdGU6DQoN
Cg0KIkhhcml0aGEgdmlhIEdpdEdpdEdhZGdldCIgPGdpdGdpdGdhZGdldEBnbWFpbC5jb20gPG1h
aWx0bzpnaXRnaXRnYWRnZXRAZ21haWwuY29tPj4gd3JpdGVzOg0KDQoNCj4gRnJvbTogSGFyaXRo
YSBEIDxoYXJpdGhhbW1hLmRAaWJtLmNvbSA8bWFpbHRvOmhhcml0aGFtbWEuZEBpYm0uY29tPj4N
Cj4NCj4gU2luY2UgdGhlIHovT1MgbGlua2VyIGRvZXMgbm90IHN1cHBvcnQgc2VhcmNoaW5nIGR5
bmFtaWMgbGlicmFyaWVzLA0KPiBhbmQgdGhlIGN1cnJlbnQgc2V0dGluZyBvZiBDQ19MRF9EWU5Q
QVRIIHJlc3VsdHMgaW4gYSBkaXJlY3RvcnkNCj4gdG8gYmUgc3VwcGxpZWQgdG8gdGhlIGxpbmsg
c3RlcCB3aXRoIG5vIG9wdGlvbiBhcyB0aGUgc3VmZml4LA0KPiBpdCBjYXVzZXMgYSBsaW5rZXIg
ZXJyb3IgYmVjYXVzZSB0aGUgei9PUyBMRCBsaW5rZXINCj4gZG9lcyBub3QgYWNjZXB0IGRpcmVj
dG9yaWVzIGFzIGlucHV0Lg0KPiBUaGVyZWZvcmUsIC1MIG9wdGlvbiBpcyBhZGRlZC4NCg0KDQpT
aG91bGRuJ3QgYWxsIG9mIHRoZSBhYm92ZSByZW1vdmVkIGJ5IG5vdywgd2l0aCAwN2JiZTRjYSAo
TWVyZ2UNCmJyYW5jaCAnamMvbWFrZS1saWJwYXRoLXRlbXBsYXRlJywgMjAyNC0wMi0wNikgdGhh
dCBtZXJnZWQgdGhlDQpzdXBwb3J0IGZvciBwbGF0Zm9ybXMgd2hvc2UgbGlua2VyIGRvZXMgbm90
IGhhdmUgYSB3YXkgdG8gc3BlY2lmeQ0KdGhlIHBhdGggdXNlZCBhdCBydW50aW1lIHRvIGxvY2F0
ZSBkeW5hbWljIGxpYnJhcmllcyBhbmQgaXMgYWxyZWFkeQ0KaW4gdGhlIEdpdCAyLjQ0IHJlbGVh
c2U/IFRoZSBhdXRvY29uZi1nZW5lcmF0ZWQgY29uZmlnLm1hay5hdXRvZ2VuDQp3b3VsZCBsZWF2
ZSBDQ19MRF9EWU5QQVRIIHRvIGVtcHR5IG9uIHN1Y2ggYSBwbGF0Zm9ybSwgd2hpY2ggdGhlbg0K
YWRkcyBvbmx5IG9uZSAiLUwgJHdoZXJlIiAoaW5zdGVhZCBvZiB0aGUgdXN1YWwgIi1MICR3aGVy
ZSAtUg0KJHdoZXJlIikgb24gdGhlIGxpbmtlciBjb21tYW5kIGxpbmUsIG1ha2luZyB5b3VyIGVh
cmxpZXIgd29ya2Fyb3VuZA0KdG8gdXNlICItTCAkd2hlcmUgLUwgJHdoZXJlIiB1bm5lY2Vzc2Fy
eT8NCg0KDQo+IEFsc28gaW50cm9kdWNlZCB6L09TIChPUy8zOTApIGFzIGEgcGxhdGZvcm0gaW4g
Y29uZmlnLm1hay51bmFtZQ0KDQoNCiJJbnRyb2R1Y2Ugei9PUyAuLi4iIChjZi4gRG9jdW1lbnRh
dGlvbi9TdWJtaXR0aW5nUGF0Y2hlcykNCg0KDQpPciBwZXJoYXBzDQoNCg0KQWRkIHBsYXRmb3Jt
IHNwZWNpZmljIHNldHRpbmdzIGluIGNvbmZpZy5tYWsudW5hbWUgZm9yIHpPUw0KKE9TLzM5MCku
DQoNCg0KPiBkaWZmIC0tZ2l0IGEvY29uZmlnLm1hay51bmFtZSBiL2NvbmZpZy5tYWsudW5hbWUN
Cj4gaW5kZXggZGFjYzk1MTcyZGMuLjAzZWUyYjc0NTI1IDEwMDY0NA0KPiAtLS0gYS9jb25maWcu
bWFrLnVuYW1lDQo+ICsrKyBiL2NvbmZpZy5tYWsudW5hbWUNCj4gQEAgLTYzOCw2ICs2MzgsMTgg
QEAgaWZlcSAoJCh1bmFtZV9TKSxOT05TVE9QX0tFUk5FTCkNCj4gU0FORV9UT09MX1BBVEggPSAv
dXNyL2NvcmV1dGlscy9iaW46L3Vzci9sb2NhbC9iaW4NCj4gU0hFTExfUEFUSCA9IC91c3IvY29y
ZXV0aWxzL2Jpbi9iYXNoDQo+IGVuZGlmDQo+ICtpZmVxICgkKHVuYW1lX1MpLE9TLzM5MCkNCj4g
KyBOT19TWVNfUE9MTF9IID0gWWVzUGxlYXNlDQo+ICsgTk9fU1RSQ0FTRVNUUiA9IFllc1BsZWFz
ZQ0KPiArIE5PX1JFR0VYID0gWWVzUGxlYXNlDQo+ICsgTk9fTU1BUCA9IFllc1BsZWFzZQ0KPiAr
IE5PX05TRUMgPSBZZXNQbGVhc2UNCj4gKyBOT19TVFJMQ1BZID0gWWVzUGxlYXNlDQo+ICsgTk9f
TUVNTUVNID0gWWVzUGxlYXNlDQo+ICsgTk9fR0VDT1NfSU5fUFdFTlQgPSBZZXNQbGVhc2UNCj4g
KyBIQVZFX1NUUklOR1NfSCA9IFllc1BsZWFzZQ0KPiArIE5FRURTX01PREVfVFJBTlNMQVRJT04g
PSBZZXNQbGVhc2UNCg0KDQpBbGwgb2YgdGhlIGFib3ZlIHNob3VsZCBiZSBpbmRlbnRlZCB3aXRo
IFRBQiB0byBpbWl0YXRlIHRoZSBzdXBwb3J0DQpmb3Igb3RoZXIgcGxhdGZvcm1zLCBJIHRoaW5r
Lg0KDQoNClRoYW5rcy4NCg0KDQo+ICtlbmRpZg0KPiBpZmVxICgkKHVuYW1lX1MpLE1JTkdXKQ0K
PiBpZmVxICgkKHNoZWxsIGV4cHIgIiQodW5hbWVfUikiIDogJzFcLicpLDIpDQo+ICQoZXJyb3Ig
IkJ1aWxkaW5nIHdpdGggTVN5cyBpcyBubyBsb25nZXIgc3VwcG9ydGVkIikNCj4NCj4gYmFzZS1j
b21taXQ6IGY0MWY4NWM5ZWM4ZDRkNDZkZTBmZDVmZGVkODhkYjk0ZDNlYzhjMTENCg0KDQoNCg==
