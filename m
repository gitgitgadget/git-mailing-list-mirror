Received: from mx0b-001b6a02.pphosted.com (mx0b-001b6a02.pphosted.com [205.220.176.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AA61B413D
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 12:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.176.217
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743768309; cv=fail; b=tzxv7eqPw4PVIDNDNps8wfgLcLWHmq3dk2cvc2eohAlSKOtHNmt95i22uce60pGjhjFgCceqJV98Xlv4FP+7+yGCDKX7wBrt2rYb0shPa6peFKK9776RwZfWhmnV9JwDXrJoxayi+83gaVeMznA7dZeDQzukBPm+pJ0bx8wxOJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743768309; c=relaxed/simple;
	bh=ZQeWQ3xIMFKVvKVXPadOYFrq1fGZRusGUa5ZnCM9yG4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=csFlT8g3SMHOO06UyrXIYcfrSDZSHQMXr4FX+SuyImwUYpO4kmJxtezSIZ3b+9aorDvuOqcJBBqpgvKHvApP+anqY1w/nJp6vsYYoKt0kpl5da3G4802my/k5xdI0+ExLbBdUgyRP4zSNxKUOpMjjuLnCsKIMuAKzh0WXV/O268=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadridge.com; spf=pass smtp.mailfrom=broadridge.com; dkim=pass (2048-bit key) header.d=broadridge.com header.i=@broadridge.com header.b=258N/TXf; arc=fail smtp.client-ip=205.220.176.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=broadridge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=broadridge.com header.i=@broadridge.com header.b="258N/TXf"
Received: from pps.filterd (m0214205.ppops.net [127.0.0.1])
	by mx0b-001b6a02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 533EJXTR003343
	for <git@vger.kernel.org>; Thu, 3 Apr 2025 10:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadridge.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps1; bh=/cezq8swmGFih2ngMm29H5sbek5
	msBuyOTnCrajlx60=; b=258N/TXfVe7uf19OLAlHpHCbDTquYHDD0/DAxvav2m1
	mPXPEXvXSW5ytlrT5pZckiBY0ttCI+zvTMUFCnATFwuJA9g1msRFDTiFYH2DvDJw
	pQR6ZSzKqqJLgo6lhpIXvlzECqh9JvdB4RgUm4PuJ1bP3b3rqt1yG/grEJlf5/G3
	LK74moBRVUy6HK2S5XMiUTO2EVT3nwTNqZfnPxTTgtfJa9fUD9cpuVDG5Jo/EWN0
	XL2bWtEnx8Kt2xyGdcRkHs+XKyi5oR/ZcLdanaGDXuHELqJvdDpBPyTcc3D1Q/IK
	9VbOimvDlcfHqThHcI/w0p675kbtbHcqWjStxd4MHaQ==
Received: from gwm.broadridge.com (central4-gwm.broadridge.com [167.212.42.154])
	by mx0b-001b6a02.pphosted.com (PPS) with ESMTPS id 45sskhgkbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 03 Apr 2025 10:48:49 -0400 (EDT)
Received: from CLIPVWEXMAA2.bsg.ad.adp.com (10.17.79.182) by
 CLIPVWEXMAA2.bsg.ad.adp.com (10.17.79.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 3 Apr 2025 10:48:40 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.25.150.27) by
 CLIPVWEXMAA2.bsg.ad.adp.com (10.17.79.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 3 Apr 2025 10:48:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=swrQdNoM2gwz7BATJ4LKynuUXqacAOZTHzvR1pLW7wdkiEs3Ont/4efSkGUEe7v6zaS2gTypRxUVLiU03CC+qlh6rfSkzESe5d81mOjDGpGHaEI2OOXoZZdmaChUUAAPTDVS0J0QO+S1Qg0/r3chwHRa+UoC1WvHoDgmOMaIUSlc2XSO1l3dMF2Q4lo7VcVuI62mb8B3GrYxoNIfVO/j04OR8xOt3becU/9wSaiQton/2yqp+i0qquXk+c+TcEruv0HGLFPzvIkPC2TuIOV6luh8SDbuE+Yw/17MJWPG7fe+QsXtWQL1EDPX3NRf5qCtMoCrCVJvCUaMuQcM2U6zwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYSlCu9BcsH9jijNp2bM1GaTCnNCIhbFg3OCuUNQNaM=;
 b=C8iFZbV/O/ivOubKae8pVr7PF+W8M5/ckSOb6fzJEp3/g2M+7b22AFsRxKpUJJr2s0xuS0OC8XDBaEgiCFilD7UBZXjukufBIzZyiIP8radL3ZXCw+RmXNVX27wCR0HWbY4MAGYIUZjvYGQZKKWC+mmWHKF8AMM3KnkypcIXaPYLR+SY7pFXCptayvAQHScIBp5dP+iTtjHqpQHcJS1bLnCPkZmTVGd+cBSUW4fdurgiAMdCGAjj4wWsDHmpzISK5OZaktl5iePV7v75sAJGlVUiWCK7z/Tw0t4W2vqE5NjWG4XNvMbXv+3V5G8vVZe3c5Ii7/DI3fEnvXa3cD5vmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=broadridge.com; dmarc=pass action=none
 header.from=broadridge.com; dkim=pass header.d=broadridge.com; arc=none
Received: from PH0PR20MB6183.namprd20.prod.outlook.com (2603:10b6:510:290::14)
 by SJ2PR20MB6677.namprd20.prod.outlook.com (2603:10b6:a03:53d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.39; Thu, 3 Apr
 2025 14:48:38 +0000
Received: from PH0PR20MB6183.namprd20.prod.outlook.com
 ([fe80::7c20:3b8a:c063:dba5]) by PH0PR20MB6183.namprd20.prod.outlook.com
 ([fe80::7c20:3b8a:c063:dba5%4]) with mapi id 15.20.8583.041; Thu, 3 Apr 2025
 14:48:38 +0000
From: "Torpey, Bill" <Bill.Torpey@broadridge.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: problem w/recursive, submodules?
Thread-Topic: problem w/recursive, submodules?
Thread-Index: AQHbpKcEtHRrZTLb3kyA8FppRK4eTA==
Date: Thu, 3 Apr 2025 14:48:38 +0000
Message-ID: <PH0PR20MB6183E53678E814C2B473BE8B92AE2@PH0PR20MB6183.namprd20.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR20MB6183:EE_|SJ2PR20MB6677:EE_
x-ms-office365-filtering-correlation-id: 0c7a64a1-46e2-47fe-76d3-08dd72be9eaf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|13003099007|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?gnJnFkSz5gz2vHVZ90qlgLHXOu9X0wAPLvSQoRbDSpxTdUuOWxzBG/taiJ?=
 =?iso-8859-1?Q?FdIQTRATZsv8Lyt4hYzDi3qSFE7UNyTIrNwkregFv6EPR4TjthDmSqkUoi?=
 =?iso-8859-1?Q?Xf1hkYuyOybKfybes8Tz6fTmTpqH1xeW7FFz+Aw67QiPqveVlqWwO7FxSq?=
 =?iso-8859-1?Q?yPoOmn76kXnh3hiSzl11g3UxHW+iJfYj+t7HofhGylmqEjEkvA+vDeARjA?=
 =?iso-8859-1?Q?4G3tzArrouJkvF7ZTIFL+rAfmkEZ46S6pBzfTNoza61YdsinLtiVJyYC6d?=
 =?iso-8859-1?Q?iJGduZY15oh6FgH/EO1MUbe2e2VTbaTn0qum1erAq2LTN7OOL/Ed30XrHK?=
 =?iso-8859-1?Q?wMEqr6sgP9VGplsUsyMFdS+kFrLpSKDvM4zC8sNfjdsLyrT8gcHIACm+rV?=
 =?iso-8859-1?Q?pzzFLLKT729FfyKBCPmuh4z2lpatZLI2v/w7s04Fmo0ISOca5o1vXhsEQr?=
 =?iso-8859-1?Q?r3f13oSbiGXR7kpd8HJX1eqpvHP2z9jvHcN7vZzsaheu6cL1I3e7ultEka?=
 =?iso-8859-1?Q?oxRWmLlSITLs9MEyrV1Zjm8JXPdw67QsXk3uk9trkxeeI518A3EDng6AsA?=
 =?iso-8859-1?Q?5M9HF7DY4tNOdmczLQcC6Nm38grxDwZTWRj+FbVEdwSMpnnyTp6xMAWT6o?=
 =?iso-8859-1?Q?S8WHdLqy0xO/vXualuIDNW6WNe3iif4Pa0MM6boZqJKiQQ+O5HriWwsC/O?=
 =?iso-8859-1?Q?MrJWDc7oGUdANKp+P2nCDxWtqomPIHFBpH+xAZH1LAFPeaES43+CCrsmMS?=
 =?iso-8859-1?Q?YcSj59MMP5Z5yc1Emfxj6ohy4KG5/WPRfegIXAFc79ochc1P3JPLmNJ5kS?=
 =?iso-8859-1?Q?xTBUZB/N/n7MD6+sc+wlLVARdUALJTUGU/aYlgV1UYQtbvTB8Q7GHKQkyY?=
 =?iso-8859-1?Q?+bC18HN++LNXKsuqg/Pe/5BysTcRUH6OM9l6Igty/nxAAlEaYFFMYV7MAq?=
 =?iso-8859-1?Q?qT0Txfq/1pt9fFQrbjRXsROeFvUwp/noYpiwo3Gm/nvmLmSDy8KEAK/rUF?=
 =?iso-8859-1?Q?+9a4gpP6riwMf085EdmCgYGiOuG/Lxi4t/S749uf5tf+e9n1kdkjXufcpp?=
 =?iso-8859-1?Q?WPanmegG4Vt1lIiWB3HjBQD9d9sGheq9fLILMy1Jllkx059dwGrYCtt0eG?=
 =?iso-8859-1?Q?GMv25oZ+RfpjZEKX9H7bV+zRh+eghLKI+1z6AJwhX32a96Y49vTA1zMVD3?=
 =?iso-8859-1?Q?PxMf4FnftQbKn+z0yxRcyw0B6A+I0xkmvsTDAzH242+GQ2gAWHqhb3yqww?=
 =?iso-8859-1?Q?huTH6JmeEO00J5Vv4O7IM7MAUsO8ZjoJQzGNQ11ImuGlCV3ab1KbG/pGib?=
 =?iso-8859-1?Q?rsO4+J7wqktloItAVp/fxn22CtLsdlVivg9K/93ZLoXaGiNYGiK64fjdwX?=
 =?iso-8859-1?Q?vworwbbb736oBE1V+smmUnWjDeMEm7Yj0OADz8sb6VEzteERpRo1KZHER2?=
 =?iso-8859-1?Q?THj30z3yTIxJS5gB9pegwM2NWvnRThPer+o2NVj791IQrKj5rkTUKmROo6?=
 =?iso-8859-1?Q?RUjKZ0NYVfTCziJtwrSiyl?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR20MB6183.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KAVVfpDJ3XcnHyASjbglHOhm/5bl2McMB1I71nsooeCFCIRbGMf96uY0u1?=
 =?iso-8859-1?Q?I2lJOg06sZecgAEG3tzkjczo2mBMSr3mM61JSGT33iQ0anjQT5HqP/zFP7?=
 =?iso-8859-1?Q?KfOyPQRRc7FvtiWaoRkQ7y+2GLzE+2YTTyniTB7RaLJLWWTgDRJqsR0cLk?=
 =?iso-8859-1?Q?1CbwITvgsqdrmCsf141toczX5WDSSECS1u1doLMNNqAKURUeBvLSRnjEom?=
 =?iso-8859-1?Q?4rVcWmknOA08Tpg97GUwAOfzm0pKmO6/qCx9IVJqU5aa+kCd/ciNkAihIo?=
 =?iso-8859-1?Q?5Rszc6Fg9OllGj2meoDj5ZWsbGvl5Ld3wrAfI5FyeRx67fOXzlPL6AbTc7?=
 =?iso-8859-1?Q?Iv5JXIefvcd6SjzMRJZxM0aiLz2AS2Z/Z8PoplCXBNZMgJIKFIh2cYEeqW?=
 =?iso-8859-1?Q?5Npr3n7Cs/j8/Xu6t7ScMiaEiioEkPOnMer1IPVwT/2zUOpzwRp311rr0+?=
 =?iso-8859-1?Q?BLVdrMqCWHr5X8hSThq2Je2qgPcvyHJNYjs+TmWBoYJANA+kK8PEHSPGaB?=
 =?iso-8859-1?Q?D7AUU+XwIaO7bvNBNLpwEUtBVHCPOITySRG7i1xOEWgpQ7w/xJ/mxBln8L?=
 =?iso-8859-1?Q?3TRlysA67vSGAWNXpdm7Z/p8WGUmnU24IE4hFCJ8hMwVvo2/0qIKKTA8yH?=
 =?iso-8859-1?Q?SRhz3mPCG///k4qyS+yX/sy/L855wS6EgBb/axZYPAQ1sAK8Gz8CW+DzvH?=
 =?iso-8859-1?Q?wm4yKNWPVaLD2g+Kf4KGIrsOBDOUZ/h9ODFDd4kW9OChUvH5Qs8ysMGPFN?=
 =?iso-8859-1?Q?1x+OewxvQeTo2aSysW9XcfRhVbI3lBxIxHop5Bg/sOFO3i3fWCDK51SxSe?=
 =?iso-8859-1?Q?MOOmXN4eoPQ8Oj0YrsAAG61bFgC6Wzqva9ULuywgiJPibMtKKR5S4w/7bp?=
 =?iso-8859-1?Q?nLACFF5KviBQbeq4w3+iDzljmx49lPFb6hXU2B1cdcNw8pllUBjY+VUr1S?=
 =?iso-8859-1?Q?8c3aKTKyLSg8AnFV+M5mwJpK3EycekvmXDfPzmYONh7RyA8nMVjCrEFhVl?=
 =?iso-8859-1?Q?93kTL5BpvQhvaVSzCZs+awyooYI8O1zAECJOQkZU3Y33UJkmmFFnxWpS1Z?=
 =?iso-8859-1?Q?TIjs6iYE8JUK+F7yduzdD5Ci8tVa/yEC9w5AiFMIAsXbVmTc/X+9+B51w2?=
 =?iso-8859-1?Q?E+P+s3tou+YVHqpUAn59b/e4sravz2DJkwtXs0ojYQ87toj2/Uffc5QgWF?=
 =?iso-8859-1?Q?2no88bb1JD+vQWQl8kc6RKnx6CX8pb1yQskLwwReCLsBRMBlT21llWCSLf?=
 =?iso-8859-1?Q?oiUBKqAvYDKK7ndFq3V2i8plMvImTCVQry47uOmUdpSHJSHNXbJTumTB7S?=
 =?iso-8859-1?Q?jHq0UvOHV4Aj0PL4a1IwBDFGFiER26BBe4eDj/+J5U49mZ9oss9jwg2pmV?=
 =?iso-8859-1?Q?cL5l/NHSVupudRrq1JuGl9HBD93l3ACFAp3lOwDR2xjU3IDxwubDCjnP1v?=
 =?iso-8859-1?Q?3vZ/fQH8PtiZGER0wGzCOND1Z2PntWlKJXnYlBtvaY/UxN3bbW3IC3yHZe?=
 =?iso-8859-1?Q?53tLB3F1eXgU+A90PwBmnIEE+UZdRzfOZGKGIj8cMdv1Gm7qvBQRYD/Lt9?=
 =?iso-8859-1?Q?n8tgY5wf1eMXQByB69QN5ErNKf0AYz3Ym2h0+dW4RywyfaoGkqfayMAEEN?=
 =?iso-8859-1?Q?jT2G3SzVnuUtatWiWyR6dZOlN4HcWxR+qZ?=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR20MB6183.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7a64a1-46e2-47fe-76d3-08dd72be9eaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2025 14:48:38.7825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a3198c8c-0642-4649-849d-daacc3298f83
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DvaW9FWxb1iFWd1I24bcMUXJB+FMMMjoIx+mK9DuzMF6JMvZRgkOCPlGhDa3/SJNpz1jXRergF8axibxO2PHfxrr3Chc06qlgCivcCna7cs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR20MB6677
X-OriginatorOrg: broadridge.com
X-SYMANTEC-INSPECTED: YES
X-Authority-Analysis: v=2.4 cv=A91sP7WG c=1 sm=1 tr=0 ts=67ee9fd1 b=1 cx=c_pps a=YnOVPckIGGBkTk0ctD2pUw==:117 a=YnOVPckIGGBkTk0ctD2pUw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=XR8D0OoHHMoA:10 a=NEAV23lmAAAA:8 a=nbSOIJ1jvwo7dPjPY0AA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: ctl_LsW7v87FICeGS-sZZav6rgrhjbnv
X-Proofpoint-ORIG-GUID: ctl_LsW7v87FICeGS-sZZav6rgrhjbnv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_06,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 mlxlogscore=984 adultscore=0 bulkscore=0 clxscore=1011
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504030070
Content-Type: text/plain; charset="iso-8859-1"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

(We've got a setup where our internal git repos provide wrapper scripts etc=
. for our=20
environment and then pull in open-source projects, some of which we contrib=
ute to and others
which we sponsor directly.  We've been using submodules to make that work a=
nd de-couple
the internal bits from the open-source bits).=20

Cloned a repo including a submodule:

	$ git clone -v -b master --recursive ssh://git@<internal>/nyfix/OpenMAMA-o=
mnm.git
	Cloning into 'OpenMAMA-omnm'...
	remote: Enumerating objects: 789, done.
	remote: Counting objects: 100% (789/789), done.
	remote: Compressing objects: 100% (461/461), done.
	remote: Total 789 (delta 498), reused 472 (delta 323), pack-reused 0
	Receiving objects: 100% (789/789), 492.75 KiB | 970.00 KiB/s, done.
	Resolving deltas: 100% (498/498), done.
	Submodule 'staging' (https://github.com/nyfix/OpenMAMA-omnm.git) registere=
d for path 'src'
	Cloning into '/Users/bill.torpey/temp/stash/OpenMAMA-omnm/src'...
	remote: Enumerating objects: 916, done.
	remote: Counting objects: 100% (127/127), done.
	remote: Compressing objects: 100% (58/58), done.
	remote: Total 916 (delta 63), reused 105 (delta 49), pack-reused 789 (from=
 1)
	Receiving objects: 100% (916/916), 563.50 KiB | 444.00 KiB/s, done.
	Resolving deltas: 100% (594/594), done.
	Submodule path 'src': checked out '7bb809da9746051b96c0448f8137f25eaf8c15d=
1'

Noticed that the commit hash of the submodule does NOT match the commit has=
h when the submodule is cloned directly:

	$ git clone -v -b staging https://github.com/nyfix/OpenMAMA-omnm.git
	Cloning into 'OpenMAMA-omnm'...
	POST git-upload-pack (377 bytes)
	POST git-upload-pack (gzip 1559 to 810 bytes)
	remote: Enumerating objects: 916, done.
	remote: Counting objects: 100% (127/127), done.
	remote: Compressing objects: 100% (58/58), done.
	remote: Total 916 (delta 63), reused 105 (delta 49), pack-reused 789 (from=
 1)
	Receiving objects: 100% (916/916), 563.50 KiB | 454.00 KiB/s, done.
	Resolving deltas: 100% (594/594), done.
	$ cd OpenMAMA-omnm
	$ git status
	On branch staging
	Your branch is up to date with 'origin/staging'.

	nothing to commit, working tree clean
	$ git rev-parse HEAD
	a092be3bc330f53f644b53d80881bf30cadd367f

What did you expect to happen? (Expected behavior)

I expected the commit hash to be correct (a092be3bc330f53f644b53d80881bf30c=
add367f) in both=20
the recursive clone and the direct clone.

What happened instead? (Actual behavior)

The commit hash from the recursive clone is the hash of a different (more r=
ecent) commit:

	$ git switch release/1.0.0b
	branch 'release/1.0.0b' set up to track 'origin/release/1.0.0b'.
	Switched to a new branch 'release/1.0.0b'
	$ git rev-parse HEAD
	7bb809da9746051b96c0448f8137f25eaf8c15d1


What's different between what you expected and what actually happened?

The commit hash in the recursive clone is wrong.

Anything else you want to add:

Nope - just, thanks for taking a look. =20

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.49.0
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
libcurl: 8.6.0
zlib: 1.2.12
uname: Darwin 23.6.0 Darwin Kernel Version 23.6.0: Mon Jul 29 21:14:30 PDT =
2024; root:xnu-10063.141.2~1/RELEASE_ARM64_T6000 arm64
compiler info: clang: 16.0.0 (clang-1600.0.26.6)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]

This message and any attachments are intended only for the use of the addre=
ssee and may contain information that is privileged and confidential. If th=
e reader of the message is not the intended recipient or an authorized repr=
esentative of the intended recipient, you are hereby notified that any diss=
emination of this communication is strictly prohibited. If you have receive=
d this communication in error, please notify us immediately by e-mail and d=
elete the message and any attachments from your system.
