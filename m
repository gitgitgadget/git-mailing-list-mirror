Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014A7539E
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 04:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709525997; cv=fail; b=ZF+WW/fjYGjPizfbSEkzvYQF4loQhX5A1d+6wWfw6bIlpPHp6OD+hlrIXPoKYDalXZ8tgOKy2W0Em7ywqei3BfRIW3HQgkRIULnhYc/4iA/8rXrNt7P3PqdW9SGz/cLynISyysNQMxHneTBhOHlodmW6CdwPcdGNgrqWgrMgUKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709525997; c=relaxed/simple;
	bh=8uzfOxRlefEO+Wvls0DrbCQ4U1Jl1lb/xhCVFYL2nDs=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=S85loVMaZdnUnh+6OdjZ2AyDdrB3MrFbZy0NzvZXq/HkyVwT2xUPAiJQPA8OK2yB5X27YUivTKFEM4w7Xo9QI2yGPDnhj7X9Jov/9nF+AiLh03WAV1568AJTr/ZMa3qzNVEw3/ceC8tAxCjeJh6Qz2YjZatPaM0zzBNgQhK8dbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S4H0cV70; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S4H0cV70"
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4244Hcxx021858;
	Mon, 4 Mar 2024 04:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=8uzfOxRlefEO+Wvls0DrbCQ4U1Jl1lb/xhCVFYL2nDs=;
 b=S4H0cV70iLGgXuf6B6vo2XmNw6bVJz9ZFTKoubHoByiJvKHLUMC8qrURP1Hf8OeUEySC
 QqQv2VcefM1odpcezEQqJm1/TkWig09diDKwi52dadQk0Y/sgGLgaWi4kdLaPuXRR0cx
 EGvL+4Kq4ma1yxCLwNuBF+X/XwrDc2OjcLftJIUaPxJ+NgKneUyfdXvnucDSqRxEiScS
 iLv0Wd6exFx8QRbXNNv4qlNAvIezRnTdlnK2g+mh8UhEl3mWTWWX2nlR2GEJ+UCjkaFa
 d5YQyIB5pE8snLnaWWtOtYkufQ5UjXzP9BHr4VKP4Ni3HLxBxG5gZ4j6ARK2z+7b3HZ/ qg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wn751r0xb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 04:19:51 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4244Jp53026884;
	Mon, 4 Mar 2024 04:19:51 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wn751r0x4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 04:19:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3yK33ZxmI2ZrJgs0aew7L4VN43jlYSmLKamD2Jx+xpXMEl0da3AMz17Tcx8MjIlFDzYhEB78GZkPvcKfpOgiRhicwsYtr697sIO9ji2zzMzfZGI2YYspPcnVD8TF7cfmP32dVzpnbweI6ouwiKM9ZguZhmSHHipOCYrDvlBJ5iLbTXZ0fsDTJO/YRk5aDmzUt5vf+x2OhQ9euLS6QpSwx4oMvpyvJVM6VTKPoLI/UqR6sb0EvmmN9aOqf8JFq0re7LT+9Esh24ey+q61WXITaqPlLeeB85ol5XWVTf+WRjYPDWnMbcGvESFh1dI6UHTO6H30YaZRot6yr0ZLkCGbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uzfOxRlefEO+Wvls0DrbCQ4U1Jl1lb/xhCVFYL2nDs=;
 b=G2rHseGnzUgZwNomPsVhPxmAmPU/ranE73h1rJSnhQF5I3fZOVx9ejYSh2rJsGZfjYVca+vMnlbpUUNvEQ/bfqNm+Bszd5xXBDZpHLwmij/N3Nl8KiSujfw/QNzXxSU7skq03p/vTMAUjF71Qxn1EJDp2YjfblyyQAbvu7C2gKn/xt7pEozE2D+b5fIf3r6vCdyvRw56sNiupdiVGhce+Z4LB7ZQT1U4JhuZw1TGCCH+1JIXH9d6woUTqfZptSCBxouZwmqm9T8GI5OIUCCkc8CsU3LcNoM15XSanAJCmoMDX94Cn2sRwzxDC4HyVWrVZ3+O7KxIJ2GgVEoP2G6J+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from DS0PR15MB5446.namprd15.prod.outlook.com (2603:10b6:8:ca::7) by
 MW4PR15MB4459.namprd15.prod.outlook.com (2603:10b6:303:104::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.38; Mon, 4 Mar 2024 04:19:49 +0000
Received: from DS0PR15MB5446.namprd15.prod.outlook.com
 ([fe80::845:c5fb:6101:b56a]) by DS0PR15MB5446.namprd15.prod.outlook.com
 ([fe80::845:c5fb:6101:b56a%7]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 04:19:49 +0000
From: Haritha D <Harithamma.D@ibm.com>
To: "rsbecker@nexbridge.com" <rsbecker@nexbridge.com>,
        'Junio C Hamano'
	<gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>,
        'Kristoffer Haugsbakk'
	<code@khaugsbakk.name>
Thread-Topic: [EXTERNAL] RE: [PATCH v3] build: support z/OS (OS/390).
Thread-Index: AQHaaNuoE+M1pSFCDky4b8aLMCgY57Ei+sKAgAA8bweAAAKlgIAEJwqA
Date: Mon, 4 Mar 2024 04:19:49 +0000
Message-ID: <9BAA31E9-858B-4F6F-9334-316C428EEE32@ibm.com>
References: <pull.1663.v2.git.git.1708660111.gitgitgadget@gmail.com>
 <pull.1663.v3.git.git.1708841439516.gitgitgadget@gmail.com>
 <xmqq7circevo.fsf@gitster.g> <B3775704-6FCE-4994-8682-309D521FD2CB@ibm.com>
 <xmqqbk7x6cox.fsf@gitster.g> <04df01da6c05$caaa5dd0$5fff1970$@nexbridge.com>
In-Reply-To: <04df01da6c05$caaa5dd0$5fff1970$@nexbridge.com>
Accept-Language: en-IN, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR15MB5446:EE_|MW4PR15MB4459:EE_
x-ms-office365-filtering-correlation-id: 824158df-f80d-4737-b5e6-08dc3c02552c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 xL84Cp8YFFRkmBX/3hSx4gKZPcfXsZF5/dsrxaJqs4l4tgmqhh6EH3AzHRGyJP8KZ0nMh8C+cZ2WMtEkfJ87teBpGNsPoSEthkG+AQWJ14veCSlS96rlCcoNXUgT7TsllNZ6JWugO6nRKaosgUE44UY8E9IlWIWi81NUVM421F7I6yY1D/24Ml5vc3DXZLC5kKNxelmw0UBUl6NOB27INPtlGFd+/hmmrbF43jLfuVb6T6iitp2wSdmD2HyAP0+krGvYc/jXlCynWjjxqDvlJWme6g8sK+CPV9c6CTizG85Mg7WsxR8ZSdBt51WkWtRz/AlZvQqDu05iV9uWlIgKgwmyHUY+ZID2dl0bzGJfT2Z4M+y7nMopRrfk5Iovxi8riUbPZF0no9uqK2ORi9EM49XtUqkZ56jOp9b76r9PwYYTIVEwlFa/Sz4NcfAhLp+aaJ0L4g/DJh42H0OQRabojYsmIG2ulAJO+1kGVzlRfFSrZxXWeXWU2gyZHMD7HSMAmBEjFYq8tC92Xvbg4CSh5m0eKeqDv+lMFdpVsMUt8zKPaWtWLWAG29eewobpgnKVhyNmc1ZzxQVmND0Q429nTy1dJkOEcomM6tMnnXpYzc7e3BfNZh+F8WOKVAekPDPUHqQqHkvUiXT0Lo3acYT0RF9VfNReKizYexv7HtFzcgBhpW2vXr9KHfH//bAdBsQ2bXNJoDlbJPoUk6OclXQ9xfbivZJJgqbfqBukMGlSAn0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR15MB5446.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TjhUd3VKYlBxRXhVSWtWRllJSVdZdHgybVl5WjdXVEt6TEZsTGpRSEE4dkpN?=
 =?utf-8?B?cmVLbENMekJ2bnZEQ2FSb04rOXVLL1J4WE1KS1VkdFZIRTZLQUQxekVkazJD?=
 =?utf-8?B?VkNxMVRINStDMXk1ckNLeVZJc28rR2VSRWpxdmVITVdFSm9ReXBUenNRUjVj?=
 =?utf-8?B?QThKU3pudk9HRXNheWVnT2pnWndPUVprUjFISnBycDhuT3pKRWViUUZuWmRn?=
 =?utf-8?B?TEZTSDN5Zm9ITmlrUjR3TzJGZ0llcTZ4dXVEK2JPT05Tc1lqYS8zQ0luNCti?=
 =?utf-8?B?eVptSW92ak5yem41RC9LbFIzdWxQV0FwQ1hEUWNFbGFxNk10K0pIcEVTeUlE?=
 =?utf-8?B?ZEVrSXg2QVMrTXFwU0lPTGlnMktsbkxwdWpLeTIwcmw5UHEvM2txaHdxWWth?=
 =?utf-8?B?V2p3S2RMYTJYVEE2RUpXaFh4bkhud0lualFiYnhXU1dyT3hqUTNQMXBlbCty?=
 =?utf-8?B?KzgzaEMxUk9IeE50NzhPR1VsZGpRK1lwUWJOU0IzS3NYZEZxZmkvODFiWUpy?=
 =?utf-8?B?Y21zSGdqbE9QcWdrMmJjZU9nS0ViNFNlamFtcldaeEl6czVUVG51L1NSSFUr?=
 =?utf-8?B?L2VxU0lSUW01RXF0VkpSZ0FUYTNPT2RXU2g0eU5iY3VySWlwY2thZTNjM3FF?=
 =?utf-8?B?bDRJc3NzTDlQWkhUaVlaSGhIOTBCaVVaald5c1dmZk0zTklsS1RWU3FkTlYr?=
 =?utf-8?B?RUZkMnpDbUpRNVRmV2ZXb0N3ejVCVFRiRXlBaEFtM21QWXBuRjFjVm8vbzFT?=
 =?utf-8?B?TUJBT05yWUdqczN6MzBzS3kxeDdjSXNpZlJyV2gycXJCT3ZmUEpMZEsvbW40?=
 =?utf-8?B?UXlGcDgwZmdFMUJrNE9iYlc5LzJTUVowVVYwR3J0VEJMU2lwcWJRZGlXK2pQ?=
 =?utf-8?B?Yk5HVkVITnNZM1hKdGZEb2pGcENnRkUxaWI0TkxjRHlZeWl6dVBrL3pXQ0p6?=
 =?utf-8?B?ZTh0MkIyUU45ZHVhVVdqa0dZRGdMdERlSUdUblMwVlMrcms1L3pEZFY0MWlT?=
 =?utf-8?B?QWt0YVYwY01sMHd4RWVTNVVjNW0wbUllckpiNEJNOEdubkxBOVU2akUyeUpz?=
 =?utf-8?B?V1Nnbi8rT3h1c2llZjFzd2k2SGdOZHRJSklORm5pOFRHaTVlMU9tWGNyYnIw?=
 =?utf-8?B?N3hhOHc5MHJVZ2ZkSUg2R0RBeU54cXpacVJUSFlpM2xMQUlJaFl3UzRTN0hz?=
 =?utf-8?B?T05tNE5vQVBvOGRsa2RLc3hjRWRIbGdhZCt1N1BJQzV1NkM0WmprdjR1RDJG?=
 =?utf-8?B?Y2RHai9sOExwWk5DNXM1cHNHdWcrU0t1d042blN2bjFWZjR0aWFDZHZOUVc3?=
 =?utf-8?B?aWRFUXp0M3VGVnY5Nkp0K01NVGpVcHh5N3FGRDVhSjVZeTRBV3JYT0tGcjRi?=
 =?utf-8?B?UG1EWUFadUp0ZVlZajl4eEJRTVhxcThBaEpKRm12citKWGk1andnVFNaWDhR?=
 =?utf-8?B?OEFoT2R5dlJURlhLcTJLVmg4aE5sYmFRRWNhUVVYUVR5ZmM5eUVHMmFrTXMx?=
 =?utf-8?B?WVRyanV0WE9VTzlVNldydkt4RXdKV1RHU29LNWJZa2ZKOTNGN0tGanNYQTFK?=
 =?utf-8?B?d2tpM2VkczNrVDNXbWdla2g3MnNVdjBlYmhTRmRjelVKVmI0S2FXcHBtYXlX?=
 =?utf-8?B?NHJ0MHBZcUhJdEI2SDVDajFyV2pvckRjc2sydHpSQm83QWwzdEJ5dGx0dk4r?=
 =?utf-8?B?YmRybHkzblVNRTFTT0tsSHJPWU9yQnJPYjRjSXdnSVAyNERkZzRYaHQyVnFI?=
 =?utf-8?B?Ykh3dUdzMVJSZ01hSFJWSXhEams5SkgzcVQ5RFE0WStpL2NhTm9JWmVKUEhq?=
 =?utf-8?B?WWcya2ZRTnk5c2dkRzdSQmZWS3lrQ0lkbkg4YjUwTUN5OHoySXBZZVltbkFU?=
 =?utf-8?B?bEg3WWgzWmxnR2dRNTIxQmk5bW5DV1ZkTFl1NkNXRFpRU2V4SWNycytRWnFN?=
 =?utf-8?B?WVdDOXFNeEJ3bk9LNVh3cC9UODU4OTdmSkEySm9BbTRvMXZ1WGx2eDkwQzVZ?=
 =?utf-8?B?WjZJckFIOWxRMjh1VUFjWG5EVFVPWjBCNm81ZmFIdWNhVXp1czJEclltVkNa?=
 =?utf-8?B?R2JmYUxZRXhUSDlEek9RZDdzT3B0SExUUzZBL2dlNVY2blFKYU4zc3lMS0dh?=
 =?utf-8?B?V0FOVmJ6SmVCUGFLbUNRMGFZQ3RkSHBFWm9PSE9vQmdnL0ZJMGhwV2NuQkZS?=
 =?utf-8?Q?Af+rRyQ9pP18nZVYeQ/xpBM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7433AF36FBF664C9CF6BB2DF603E16C@namprd15.prod.outlook.com>
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR15MB5446.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 824158df-f80d-4737-b5e6-08dc3c02552c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 04:19:49.6050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xzHPYK5fupemjUpWBTdjIg6eFVYhGmw5+HYZFROUkMy/4nKeEY0LhtPrkZp6CkHdSYi2PJaZA+JSG2S1mQVYvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4459
X-Proofpoint-ORIG-GUID: 2Nb_--ZRc9Tb7ZrOIAcsSf1fhFp5AUtS
X-Proofpoint-GUID: -uORlKnDe4Em3KCZN7lh_Y56dJMGwUX2
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
 definitions=2024-03-04_02,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403040028

TG9va3MgbGlrZSAsIEkgZG8gbm90IGhhdmUgc3VmZmljaWVudCBwZXJtaXNzaW9ucyB0byByZXJ1
biB0aGUgdGVzdHMuIEhvdyBkbyBJIHByb2NlZWQ/DQoNClBsZWFzZSBzdWdnZXN0Lg0KIA0KVGhh
bmsgeW91DQpIYXJpdGhhDQoNCu+7v09uIDAxLzAzLzI0LCAxMTo1NSBQTSwgInJzYmVja2VyQG5l
eGJyaWRnZS5jb20gPG1haWx0bzpyc2JlY2tlckBuZXhicmlkZ2UuY29tPiIgPHJzYmVja2VyQG5l
eGJyaWRnZS5jb20gPG1haWx0bzpyc2JlY2tlckBuZXhicmlkZ2UuY29tPj4gd3JvdGU6DQoNCg0K
T24gRnJpZGF5LCBNYXJjaCAxLCAyMDI0IDE6MTUgUE0sIEp1bmlvIEMgSGFtYW5vIHdyb3RlOg0K
Pkhhcml0aGEgRCA8SGFyaXRoYW1tYS5EQGlibS5jb20gPG1haWx0bzpIYXJpdGhhbW1hLkRAaWJt
LmNvbT4+IHdyaXRlczoNCj4NCj4+IFRoZSB3aW4gdGVzdCg3KSB0ZXN0IGNhc2UgZmFpbGVkIHN0
YXRpbmcgdGhlIHJlYXNvbiBhcyAiVGhlIE9wZXJhdGlvbg0KPj4gY2FuY2VsbGVkIi4gSSBzYXcg
dGhhdCBpdCBmYWlsZWQgYWZ0ZXIgNSBob3VycyA1OSBtaW51dGVzIG9mIHJ1bm5pbmcNCj4+IHRo
ZSB0ZXN0IGNhc2VzKGJ1aWxkKS4gSG93IGRvIEkgaGFuZGxlIHRoaXM/DQo+DQo+VGhvc2UgIndp
biB0ZXN0IChuKSIsIGF0IGxlYXN0IHNvbWUgb2YgdGhlbSwgc2VlbSB0byBoYXZlIGJlZW4gc29t
ZXdoYXQNCmZsYWt5IFsqMSpdLiBJZiB5b3UgYXJlIGNlcnRhaW4geW91IGRpZCBub3QgYnJlYWsg
dGhlbSB3aXRoDQo+eW91ciBjaGFuZ2UsIHlvdSBkbyBub3QgaGF2ZSB0byBmaXggdGhlbSB5b3Vy
c2VsZi4NCj4NCj5JIGFtIGEgd3JvbmcgcGVyc29uIHRvIGFzayBob3cgdGhlIHRlc3QgZmFpbHVy
ZSB0aGF0IG1heSBbKjIqXSBibG9jayBHR0cNCnN1Ym1pc3Npb24gY2FuIGJlIGNpcmN1bXZlbnRl
ZCwgYXMgSSBhbSBub3QgaW52b2x2ZWQgaW4gdGhhdA0KPm1hY2hpbmVyeSBhdCBhbGwuDQo+DQo+
VGhhbmtzLg0KPg0KPg0KPltGb290bm90ZXNdDQo+DQo+KjEqIEFsc28gSSd2ZSBzZWVuIG9zeC1j
bGFuZyBqb2IgdGltZS1vdXQgZnJvbSB0aW1lIHRvIHRpbWUsIHdpdGhvdXQNCj4gZmFpbGluZyBh
bnkgc3BlY2lmaWMgdGVzdC4gUmUtcnVubmluZyBmYWlsZWQgam9icyBmcm9tIHRoZSBtZW51DQo+
IG9mdGVuIG1ha2UgdGhlbSBwYXNzLCB3aGljaCBpcyB3aHkgSSBzYWlkICJzb21ld2hhdCBmbGFr
eSIuDQo+DQo+KjIqIEkgZG8gbm90IGV2ZW4ga25vdyBpZiBHR0cgcmVmdXNlcyB0byBzdWJtaXQg
YSBzZXJpZXMgd2l0aCBhIHRlc3QNCj4gZmFpbHVyZSwgbGV0IGFsb25lIGlmIGl0IGFsbG93cyB0
byBvdmVycmlkZSBzdWNoIGEgc2FmZXR5IGlmDQo+IGV4aXN0cy4NCg0KDQpXaGljaCB0ZXN0cyBo
YXZlIGJlZW4gaGFuZ2luZyBvbiBTMzkwPyBXZSBoYXZlIG9jY2FzaW9uYWwgaGFuZ3Mgb24gTm9u
U3RvcA0KdGhhdCBlbmQgdXAgYmVpbmcgYXR0cmlidXRlZCB0byBvdXIgQ0kgYnVpbGQgc3lzdGVt
IG5vdCBzdXBwbHlpbmcgcGlwZXMNCnByb3Blcmx5IHRvIGdpdC4gSXQgd291bGQgYmUgaW50ZXJl
c3RpbmcgaWYgdGhlIHNhbWUgdGVzdHMgYXJlIGhhdmluZyBpc3N1ZXMNCm9uIGRpZmZlcmVudCBw
bGF0Zm9ybXMuDQotLVJhbmRhbGwNCg0KDQoNCg0KDQo=
