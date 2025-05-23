Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com [148.163.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01591189912
	for <git@vger.kernel.org>; Fri, 23 May 2025 10:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.133.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747995354; cv=fail; b=EQc4wcvmUcojvOhYN91NnCdRBshE863y0EHx0vRZNfiXhdSUCq3QcvAwPQ/EmmuRfMtTeda73zEHYFcvJMmB/2jIC0w+ecRJuMrojUCGbuhvPlvcCvrJB6wGb43gVzVIBVYh1FDyOjthuaPA9Kl8FPKhQ46TWoNNrUmRYXZulpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747995354; c=relaxed/simple;
	bh=rou4PB5S7bzrv14UZcXk9+5pFqyJmmacbbbv3ObptPo=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GeGWFfpnalxSXaCuovtmZlKvwQXpVa5+O+2g1K2n01u8UPQuotTOuxrFHatBACkogJZ5rw/1XU2376A5sx5iNK/jvbpShfTHRT0gwjaYHYEqBXi9GijZFkkVAGOh634voZ8PsAUgoBZaR7+O5bTtpKAVUJf/YBfoTawr3UfDOss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=y8ByYNoC; arc=fail smtp.client-ip=148.163.133.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="y8ByYNoC"
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54N3MUFk025781
	for <git@vger.kernel.org>; Fri, 23 May 2025 02:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=smtpout1; bh=rou4PB5S7bzrv14UZcXk9+5
	pFqyJmmacbbbv3ObptPo=; b=y8ByYNoCz1q9XD3dkvoWHBEhDIgUIZpH3emHxxb
	t2RZ1kialyOIu4B8jWDZv8qWmWSI9zK/vrdyjIuSlKobiz6Sqj7y4h1SroJ7z9mz
	V4vW6eSE4HbJBE8HQ8J3o9HBd1IQTQvjS2PCYx2b2Qigvy8UkBcCbz4IkXEeLiJQ
	0JW6ukpNKGFML14Ol/SUzWrhM3PVyFEEpblJoPzNEBHFLyRscFaVuICQ7iiDuZRZ
	v5bRKyCDp/axNeSyemXbEFF6grdJ8awqPRhhu6x7NxmOdg8H8DaiqaGbOcvw0Jgo
	DDuluCgnaviCQaewPpfsIm7Zslnkgb3gQ1Q7R9vXJImLnMg==
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 46rwfj0f67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Fri, 23 May 2025 02:15:10 -0400 (EDT)
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54N4A1jD019055
	for <git@vger.kernel.org>; Fri, 23 May 2025 02:15:09 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 46th25husy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <git@vger.kernel.org>; Fri, 23 May 2025 02:15:09 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Otr7HeL06wyVbp9qMlI97K2/ru7ORij2OgdV9+ygJ6cXYgld4Uul9V8b28otCeZHSFK+1GGCwvvvs9uoWwtzyE5gszNj0n5EtOC5zRRqY4Q5MA3EwuArl4u2YYbTERsReAkBBvpr/YApm9qYq26Z/XVV6QQWbaAyKFEYPZfgFJP25VdIIjOclu774SF7+H2vg0eo0I+L78svXHk4e0A6aHS5L+pvmy+fW8Ae751VmWijMw64r85ZiI72DaSQLOKJHcYTkzclgOOVCqJTfAMGvpD8wgHW6jMjp3imdaGu/C0htk2NI422y2zhkhiqCRJWTWlny9bAYXPcDKKXOtDqig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rou4PB5S7bzrv14UZcXk9+5pFqyJmmacbbbv3ObptPo=;
 b=vodbst1ffdxobDZGexGj448U0TbUh08Y2y2s3iFaUDS85joiPsPl097JbQ1S5rWaYas4qlJQDBh74G4n4mG16/J2BYOUt3iC5xllk2zDhhsMqbrhEp7YhbpgfDs8n9F71mjvaUk6wAd1U/GgF+hYi7ClgwrfoS6lVlD2pYS004LMOvrS/kFwPwtFtNv86O8zj/hHa/5ukA2ttKYLelyl9Ln968x8CBLIHsmBgUHQON9L69LUpzSgpi3SRZxcANtAo7hzYWk3GxBrgLdsSar/JVWkVo9cwxWvbJ5XPGMvz/mxPDB2jAl2tP6qKpK1ZbrodJpSIqdAjVPf2MWiC1vU+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from IA1PR19MB8885.namprd19.prod.outlook.com (2603:10b6:208:599::5)
 by CH2PR19MB4023.namprd19.prod.outlook.com (2603:10b6:610:9d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Fri, 23 May
 2025 06:15:06 +0000
Received: from IA1PR19MB8885.namprd19.prod.outlook.com
 ([fe80::d126:d275:aeaf:8b8]) by IA1PR19MB8885.namprd19.prod.outlook.com
 ([fe80::d126:d275:aeaf:8b8%7]) with mapi id 15.20.8769.021; Fri, 23 May 2025
 06:15:04 +0000
From: "Bell, Bob (ISG)" <Robert.Bell@dell.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Bug Report: git show unnecessarily requires parent tree
Thread-Topic: Bug Report: git show unnecessarily requires parent tree
Thread-Index: AdvLqXsNxcn7lihQRvC1cQomkc5ZcQ==
Date: Fri, 23 May 2025 06:15:04 +0000
Message-ID:
 <IA1PR19MB88859FF5C7E547010E555E7F8198A@IA1PR19MB8885.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=90803c7d-9e6e-42a2-9bf3-e3bd18b5e792;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=0;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2025-05-23T06:10:47Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR19MB8885:EE_|CH2PR19MB4023:EE_
x-ms-office365-filtering-correlation-id: 540904eb-4e68-43b3-d984-08dd99c128ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?DjhBYeR4fS23tkZG9Uoxplv57LWxdqF/nSjyRrVbbH2TFUXaZuwNTjBK3e?=
 =?iso-8859-1?Q?NWGoe/sOtSTRmP3TdG4NZUshw2f4k/phtxd5rJgd+9Yo4jOiIyujft25xV?=
 =?iso-8859-1?Q?ttyuPnBQIStwAlPil2ohgedwj6S7otbKWuqcz/941oUwy3Wuz51f2WdHun?=
 =?iso-8859-1?Q?V7KKQ8TbRCWMnkh+vlexYORXLyjZVsUz9hnje4Qq8bkBBoyXPYU2lXUY1K?=
 =?iso-8859-1?Q?3WEy5A0VR5LGQG/1+vLgx8xohkkzZnTre6ndE3lDyusOac7WyEnxB/ANFw?=
 =?iso-8859-1?Q?a/85FRQMpLrM9fKso8qEWVJP6ZoI8OAJHeQ1WUQ+rVUDwPFuhoiQxYz4a1?=
 =?iso-8859-1?Q?oTmdw8E4+rBiLAmjAvq7kywpGwKOYUnDShihFgs3ox3c+344NNTEPKuk8P?=
 =?iso-8859-1?Q?H5gHQ7OxCRg95iIbnQX3inhQT4AoC1Reu+baL7JzxAea/VRuUxO2+R+RQq?=
 =?iso-8859-1?Q?Rn0cSDqcgjQv3EOTCxbM4BGQWCpSiwd0rLw5UUAzgeSCfCeJrMo0qkirzz?=
 =?iso-8859-1?Q?b9vcmlNfLxIuRn305QTKsvx7FgxMuHgMtpsRiXIRtJC6R1SK1JGjH4EfN2?=
 =?iso-8859-1?Q?9ohkk1EBquYWbGdP1LIKJt1QFUYs9a19XCm+orJE5Mn29pSZhtJe4kjwwV?=
 =?iso-8859-1?Q?jHt9f3/GXr9jehFDm7IEhdqXLtbJ8eZDvWWeCXwf9D3FnPJ4Xb3OfZfIM4?=
 =?iso-8859-1?Q?wxHDmUzT4YW53T8YPcP2rjOUyGD8phD5sgG4ig7Fhw89YArgJfjhEIA3fd?=
 =?iso-8859-1?Q?+iWc1S1lVRF2EuZ+4z1+faxzWM+Z1I2Ni+li7WUls+QNWkfNakVb5L9rLw?=
 =?iso-8859-1?Q?Tsko9UsXUUXNXATl7rnaBl4NPiRQiBX2wF8j6XtMzJqSWmyQWWgd3pq//v?=
 =?iso-8859-1?Q?hXNwGAup/MIbQ1/SxcusoLeYcaIvJ01PDIqaOZhYlMBPbf52Xf07HeDPk7?=
 =?iso-8859-1?Q?8W9d4OQqgdwUj0p3VwWCutFcX7swyZ5A/btJE7+5h6V+hoI/6ZLt8grO7s?=
 =?iso-8859-1?Q?mjqCNKMXn78O8P9a9JwLEIYwUov0ndpqTuYWHE16j4ldg1F3oc4grQA1V1?=
 =?iso-8859-1?Q?s5VWmdtLATRlnxcaZrdDXcvUK/mYSKFmmSmYFOMxluf1ycWlQAqvpVmz2b?=
 =?iso-8859-1?Q?3DMz04jHu6FFl1YLGV+zBSZdDUUbFnwfTTPKOXQSm2f+HDAtIRFGajtZ09?=
 =?iso-8859-1?Q?+lWdwutaRfALJpSFQlU4RcdEuZeuyTraTJ3sccIoO3adhJ9x1TpM5BBvdv?=
 =?iso-8859-1?Q?Yy5EG6eyx77yZR3gSbaJ8M3eMAwaPrniEtq8a4dCueF2aojix8HH1S2N24?=
 =?iso-8859-1?Q?/y3Y/UEKAyay3Gx4V7RxoLqAe023rzLQQWrjyLJEZ9+qL7HuILp7oqMJU4?=
 =?iso-8859-1?Q?zRsp5Q7XGKziEkkDSksM2KLlMtnFsihEKpvs5ZeiJW+wD5vXPItwGE2A6M?=
 =?iso-8859-1?Q?OcWQ+ea1vZBK4jYI/fprX4MQt1eyqARvfmdq82IOi8OE/1DVTC3DTWwrRC?=
 =?iso-8859-1?Q?jTI4gtENi5vU2ea8LJrpsBBUgr9kSRZ2lLNpjztrkbdA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR19MB8885.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?MHutv6HdBr0XiHZpQB92kRH3VwAT3HvPFsb+wj/HZAK8WWKXiqCzSPD9ih?=
 =?iso-8859-1?Q?8Gzek0JHqReEUxzlaclC3Z5ZzLInNOfDGXLYxDOXa9oR74Yw9StNeqmBPp?=
 =?iso-8859-1?Q?krWLDMLX+hTdf0Fu27mMcCTFtDIpBBQsTQPf1b1AeAFohVIWF0JCHikvti?=
 =?iso-8859-1?Q?hdGazstkj3BsdYp76t4lU+DkFbWVT/mHriOdrnECjEjYVdOkhjp1odCADu?=
 =?iso-8859-1?Q?knEquibgOTIycaV/6teR15ULt8uv0ckDYdKuOuKMtVwFSj1Z3mD+ZYLbcy?=
 =?iso-8859-1?Q?ymWOOgZenSIuu4Vf0PAQmW+jKagj8twXwzYpBikIVkqB+Qso+44LeIgf+f?=
 =?iso-8859-1?Q?X+NkP+e2/fzcCoB2EytFNkvxozfsCcvOT4GWB+HqReY3ig7pJaey37swDo?=
 =?iso-8859-1?Q?ECG3wH1aLTDkhjzfoTlOoQZC0+2VmHzc354OSc/q7flseEqKPkydD9qS1X?=
 =?iso-8859-1?Q?GFpWJEAqMfPWKcV9f9qTFEr50HPle6lBuFtRoSkp6r5gRri0Fgld3tcJDu?=
 =?iso-8859-1?Q?VzfyxIsg9Z4lgKSlLue6WPZPqvJN9PO20QoQG23jpeRdktDXJb/j2umb9R?=
 =?iso-8859-1?Q?D+wdpHPWH141RoeIsnrXI0FUxm9vS1h9DMU9GTJvUvP8mIQg/w166Thpdq?=
 =?iso-8859-1?Q?W22RrDRiXA3AKQXh3xMz8M9HvW3kiG3X1hLFjsCVNuc4rqXsTrroF0Dono?=
 =?iso-8859-1?Q?ZX8o8XVBtjKP42Z/xAtEELO7+o52ei6Q8qoIn1zsq3N0Gkk5Y0LQJOyfJz?=
 =?iso-8859-1?Q?QGsIYiux1dg3cgYcq9kUAPo4Po9XT/91rOlch7iwl+a1+MrSuuu395WnKm?=
 =?iso-8859-1?Q?gUxNiJCeoAVFwkW1IRLgHmK+YH6Zwy/AcraoCdwDsxvEqIkwkHhZ+r5RZf?=
 =?iso-8859-1?Q?JryHFVDfNLhbzG4zfZ3dNsJSAe3C0csN4RyKO3GvuCS+NBoAqUXkTEpxZr?=
 =?iso-8859-1?Q?stlxxPpPABa6u1/vuOnCsgpOjSokjiLi2mjrkAxZyJpdg3GUNyDpF4Mf6R?=
 =?iso-8859-1?Q?eMSFg9KrnTa7opcSIpE3T4V1/3et42AAXGQeYeiMRrTCdDv3sPV6aS0ONm?=
 =?iso-8859-1?Q?wVbI5ogYp1C0RwrFlyIJFxHe1KL9RDD9tV6y/0lDjDvvGAytlcH0F0FqzT?=
 =?iso-8859-1?Q?yfaZRVLgAEORQ0cC25OCJVUVODa4EPw8v9bxK1OfF/E1Z6vL2ii6IU6JCL?=
 =?iso-8859-1?Q?D8vYH1dQSAgXtl4PDqE+0KEDbAp4jsxJgzJt5pFZ+lCrLO2nhgpe2nECT1?=
 =?iso-8859-1?Q?ECe+VVZQczaTP4W/pTN/SF3xOwgSqYodZ5w1KECP2GnzpZmnrCyNN+ZZPl?=
 =?iso-8859-1?Q?kB6IcB6XA8bQKuojboXDxqjx5TMyzw5o4tIKtW1gMvQuS9eFHpVzc3IQsN?=
 =?iso-8859-1?Q?LUtXtJpMWUbXoreuq4i0ensueOJRDEg+KtMsLTqdvkGajfRwE2+wZhUqoQ?=
 =?iso-8859-1?Q?GFrk8tgEYMccgiLGdvrU+ivw93vSzHjAqv56kcQRqLel76qy7tkG8IyoGw?=
 =?iso-8859-1?Q?BDn8/xNGjArWpMQh/+ZDLdFopa3/N4LVPGFbWEhqRxX0xFpb7xiBu0AZGM?=
 =?iso-8859-1?Q?rDat+7gGu9LK4uDUXALUqHz8NoOulqC51q706z7XYI73kI3YmiJFt+XnLj?=
 =?iso-8859-1?Q?nQGioFTXKwxS3exP3WwX6Ow+AddlOL3NYR?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR19MB8885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 540904eb-4e68-43b3-d984-08dd99c128ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 06:15:04.6467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mTvJT5bjYHGU3sTICmb27C5vPTKApp81TSUf75frx4Vhtam4e+aIMhMchaTCiFA5L+KQ8OdAcDxuhVGro2jGRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB4023
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_02,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=650 malwarescore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 adultscore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505230055
X-Proofpoint-ORIG-GUID: iV5QuP648MXDU_V-8KD4j1_wX5TXc_UW
X-Proofpoint-GUID: iV5QuP648MXDU_V-8KD4j1_wX5TXc_UW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDA1NSBTYWx0ZWRfX4/O/F1j4M7gg vmnNtSW76baEZG4yvYdiO7nd+G0oYXLeVlX1HKj0nfvpbG3pKebo5L9MPKSFan9zSKwseuot+Ds 1Ck+R7RTLHyJVmvzFwGo0CVuf12/a7/6CVUqDL97m31x8ezeKfGK4kcij14lmw3njRPNeC5yJXs
 S1kHJ5UHrIE/n/LPozxXdujGZp2Y9+IripGRCaE7kGuZLXIwQVWpZUu+6UFr15hGIC8kBtHwdZL LxoeHj8UaiFlTRAvALYdbWoOEBNsUKNf7CCzRNDa37EB+sDQ11x+O0StE8KQ42R8GrieiTidFna gI8k6GUpjQNcDKO2Ac9Nsbjixb2yozCVgTUIYvOru+YO7zI8zdewuNXbAPmKqIUXJ774jfS7O47
 mkB1inpg2TAaZB/vY5r/042cQ01kxx2ASDa0JAU6awRhMTCZdfTzOgoBMlPbs+u8I1+M7XuR
X-Authority-Analysis: v=2.4 cv=fO853Yae c=1 sm=1 tr=0 ts=6830126e cx=c_pps a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=dt9VzEwgFbYA:10 a=iLNU1ar6AAAA:8 a=BnCkvSCrZwcQWPicNlEA:9 a=lqcHg5cX4UMA:10 a=wPNLvfGTeEIA:10 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 mlxlogscore=590 bulkscore=0 clxscore=1011
 adultscore=0 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505230055

What did you do before the bug happened? (Steps to reproduce your issue)
Tree-less git partial clone: git clone --filter=3Dtree:0 https://...
Remove the promisor to prevent retrieving more objects: git config --local =
--unset remote.origin.promisor
Git show of a fetched commit with limited metadata fields requested: git sh=
ow --no-patch --format=3D%ae abc123

What did you expect to happen? (Expected behavior)
I expect to get the metadata I requested from the commit, since it is avail=
able in the retrieved commit object

What happened instead? (Actual behavior)
I get an error attempting to read the tree for the parent of the commit spe=
cified:
fatal: unable to read tree (abcdef1234567890)

What's different between what you expected and what actually happened?
I expected the command to output the requested metadata, since there is no =
need to read the parent commit, much less the parent's tree object, in orde=
r to provide the required data.

Anything else you want to add:
Note that the data is fully accessible without error using git cat-file or =
git log
e.g., git log -n 1 --format=3D%ae abc123

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.47.2
cpu: x86_64
no commit associated with this build

--
Bob Bell
Distinguished Member of Technical Staff
Dell | ISG TechOps
Robert.Bell@Dell.com


Internal Use - Confidential
