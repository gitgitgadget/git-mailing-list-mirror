Received: from mx0a-002b1501.pphosted.com (mx0a-002b1501.pphosted.com [148.163.150.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7272025777
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 18:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.209
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719252182; cv=fail; b=RbcBBdV/VAQxOMMgMhw5aMwN3f6uRmICMWsHT+5jxbOPUNFDtamLaolhqn544XHqnuW1dRdNk7Cb9jW4aASut5MP38xUBlwMnmG813Ppu8/xDW+9kRxIOyy+vFFDkwL8MtazxxNz/dTSPo7PFJfle87GCqt1OVPG7PcYPr96aT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719252182; c=relaxed/simple;
	bh=V279mGWq/ZCvusC3DsxyvhGO4V3OY9sXIfvyoJ1rr4Q=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kXPWqILvizPTfZLjYrZV3rVgEWh5K2+6oVloTzF07tkwlm0gTPwRc4+CL27t4oRLrxcV1JwvR5OEukXzL9+Mc5q7T/BvnQk0r8ESNVm6QCWPU9btZUyNwiIM+SIHhbGEm9Dam/FiNNq1ndHNmOU9drO08sK9oO7+By1jRTN1uzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=epic.com; spf=pass smtp.mailfrom=epic.com; dkim=pass (2048-bit key) header.d=epic.com header.i=@epic.com header.b=W7IsDcJ8; dkim=pass (1024-bit key) header.d=epic1.onmicrosoft.com header.i=@epic1.onmicrosoft.com header.b=EhEwEodU; arc=fail smtp.client-ip=148.163.150.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=epic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epic.com header.i=@epic.com header.b="W7IsDcJ8";
	dkim=pass (1024-bit key) header.d=epic1.onmicrosoft.com header.i=@epic1.onmicrosoft.com header.b="EhEwEodU"
Received: from pps.filterd (m0119676.ppops.net [127.0.0.1])
	by mx0a-002b1501.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OHB7wW027576
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 12:43:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epic.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=2k24; bh=V279m
	GWq/ZCvusC3DsxyvhGO4V3OY9sXIfvyoJ1rr4Q=; b=W7IsDcJ8i2k/VReGokhqo
	lxjNbge8L5JTRRdrj2eYQGH5yPsMBbBpu1Kr0LRwri0/0TDiUKqHiyOgXMTl8thm
	yorAOO4PeKgGHRxrQFTvcRxLwbZCyFt0vJsz6B0Saipd+fl/FjqJae7b/B7Hp4iN
	2uUeGwgNrYCVfUvP2EC0YQ93BoyAig/PfMPDTI7jSEb+f7MY2k2LbUfW9cmot8Sj
	zrLLNoWgzR1yK5fqpPHnuRtttUeYb2YuY48q2MMkguxD3ZdCQ+3+39JcvkFFZqPd
	/+hD372h+4lTfLRcDzFNewsLDkZ8Dr1bkWobs0RG8BBIHRRQ4faBjyaR8REIhXKT
	w==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by mx0a-002b1501.pphosted.com (PPS) with ESMTPS id 3yycyq82pg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 12:43:47 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQnPlI6Z/mSxuxfITuw0WAn/ANI1H25D6kVjGKAEegE00S5gt8oQuCrhZPNjRtIlV2y39E9r7wl7BXW8WS2zWHpAi9+Gyiyls2PMRfuSYMx10s0q+0lLFatoQNlR7rxxAkIFTd8wonuvmCLSVqx5T/yFjW69v3eQCcVcH8DP0Db7hIgKbFTZH2tMpvF6/KvSNYHYQ+2iv0RdEMue1fau2vkCQuYUOaUzlP5agk2Ji1Y+B3RvwCK1wxeRjuzxDaPaA+Vrp5BDfJIChfiCiXOGJw44KK4UnmlClCbtAbE1qJh07vGpwt/j9D8hg2/Uiiavr/g1PjP9pc755xmzz/Dcng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V279mGWq/ZCvusC3DsxyvhGO4V3OY9sXIfvyoJ1rr4Q=;
 b=B9XBTvfgiCDmPlRn4e65BywT2MiTlURS17iQQu4x4/qSWzK9hWKWD0IIbyMTKQfbY4tSgkWdhy77JOkg5l0mTBPNMD/UTocyN/RMaFFHte4YZP5Zbb7hO00KR55Rw+RBOZYU8iHIL9TfjgCZiE4l9pX7V0m95ScrciOYs9SuNEQZO2Rwrasuax4xLydxx23T7KVLciGPRI7NaOt8Po1NnsslbuHKv9UmZQjair3c1LP0itmyEcfurhim5KuUD8mnhWR/YIfWnjQYds4dLHAmdYqJcl/1glIPfPJiCdGsVHHWqotUoUL6FxVPm3K9ThMCqy9ifw1v6aP+sGwK2Cc5jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epic.com; dmarc=pass action=none header.from=epic.com;
 dkim=pass header.d=epic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epic1.onmicrosoft.com;
 s=selector2-epic1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V279mGWq/ZCvusC3DsxyvhGO4V3OY9sXIfvyoJ1rr4Q=;
 b=EhEwEodURiHfe+lahELK0Kbl+l6rRIDj4w+XM2QfmGh6ksD3Dog11hfpxSowsmzv5FyIW0/iPjOX+x/cbDxgALBv6BJNMdvyypDDoXPQ3TQ25zweLhCY+bPyVwbKxaHyX0+BCUiDd/fCHiDtP1qwy2XGGclT6uks9rYNGaFP1ls=
Received: from DM6PR17MB2156.namprd17.prod.outlook.com (2603:10b6:5:af::29) by
 BY5PR17MB3985.namprd17.prod.outlook.com (2603:10b6:a03:238::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 17:43:45 +0000
Received: from DM6PR17MB2156.namprd17.prod.outlook.com
 ([fe80::cc65:c6a3:d614:ae26]) by DM6PR17MB2156.namprd17.prod.outlook.com
 ([fe80::cc65:c6a3:d614:ae26%5]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 17:43:45 +0000
From: Joni Lameter <jlameter@epic.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [BUG REPORT] fsmonitor and core.untrackedCache combination causes
 inaccurate git status
Thread-Topic: [BUG REPORT] fsmonitor and core.untrackedCache combination
 causes inaccurate git status
Thread-Index: AdqiJ8SyNgb1asgGRQOGVfbRsdLCvAkNfU3Q
Date: Mon, 24 Jun 2024 17:43:45 +0000
Message-ID: 
 <DM6PR17MB215638310B4E03A891C1CF8FA6D42@DM6PR17MB2156.namprd17.prod.outlook.com>
References: 
 <DM6PR17MB215602138249E744ECFE4185A6E62@DM6PR17MB2156.namprd17.prod.outlook.com>
In-Reply-To: 
 <DM6PR17MB215602138249E744ECFE4185A6E62@DM6PR17MB2156.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR17MB2156:EE_|BY5PR17MB3985:EE_
x-ms-office365-filtering-correlation-id: d205f588-8bf6-4b05-43a3-08dc9475323d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?xL3PA1gRvWbAlC4+J+bUF4ahXiOqJ8FpMOt3NS5lMWVa2jT29k5efU4Up2?=
 =?iso-8859-1?Q?HcOvYwMLbbzr3By7bNjajaPgkhJhVzVWjNu6aoZMCbPedUec6fKenDfO5g?=
 =?iso-8859-1?Q?PVtnZPfReAGetf6g7ZVtyvlS0OHfe/SpQOf43yWkxN9m/FF+e+D4lSILbV?=
 =?iso-8859-1?Q?eUqc/NIyp7R33yKBHA84Na0usPDM3A6i80vYTQuURFywmZcl7M/vvL61lW?=
 =?iso-8859-1?Q?gYhkw5Yi8dRFVISK93867NlMinvWw1cMMrRIA+k+IoijKwfXUuFfXbP3YJ?=
 =?iso-8859-1?Q?0DD4M4mkrJRVoc1/4/JnNozro4XotBlVCZVyNXeiqwP/nkZtE9nFVmXjul?=
 =?iso-8859-1?Q?mudTXhNWfnJ7ye/twpvPjMstDhp1T0zJ5d/Y7Rbav2SiXLVsCBw68wY+pq?=
 =?iso-8859-1?Q?MrG1wB6oy9JPxSIoCWHDtLsSD84VF6hkZhASABctsuiHLIypQ6CH+rhNM4?=
 =?iso-8859-1?Q?4VTxnXN4axoceYjZ1uF34CxZxt1uWat3BMm/g//2zztyKZwnXrTndG6jYw?=
 =?iso-8859-1?Q?03yI8LJ+93bDiQKXONIdaEtbwdOpPPiUsr9eHv2c61Yw3nq9K8q/9660fo?=
 =?iso-8859-1?Q?zFcKR6b4EPP8tpjmLGF9ArE7owTVhtUiYEUUe5TJyOiTCSx6MtbrE8o7p4?=
 =?iso-8859-1?Q?RMnV3zWkAXuV4eIwK/odiVS7c0Py50HBjCsHvEgrglS2kHjrAwclwsKtL3?=
 =?iso-8859-1?Q?/tdbPHrsxE+A6fvRmab0yN0TeebkV+2x5JUr1UTANDvgObObHhttqN01qp?=
 =?iso-8859-1?Q?+DZlwKhZiilKusuYfpAO/ghc0bqPS+VuIxQOQfYFxatyDCyy6WoKDJ8vl/?=
 =?iso-8859-1?Q?W1VgmwPGcwl5NpDLLrG2leFbWIAvrMXQTg87oYsEEVfVMVcX/qjY6Ecc8I?=
 =?iso-8859-1?Q?YTKRhREyz/yyiq1fR0yNAceNRJJ7ynBLZqasxxv/FmXtfgEuZXWvOmJoqI?=
 =?iso-8859-1?Q?wZwXDn/2sw8lONn9mmhr1hXIFByTAS9P1yII6WgTYJo5VGGjccrZh5LLBo?=
 =?iso-8859-1?Q?QlKX4ckmyQFvnKvxMXc8f9nQUodrBZCi7X0wkGb841AdmXKpWNG8qN3ank?=
 =?iso-8859-1?Q?DgA2gFvKRA4kP7IALAKaNl99D76shKvGX7mdQ9N9EG382jOfgKwDEn8AmB?=
 =?iso-8859-1?Q?Zenw0dWiIAh27L85jJxmYOXGnawrsCC8EjR8jtfAth7YGyAB28rv+IicXd?=
 =?iso-8859-1?Q?6cNRiWXEctq9gVyrW3o1NqR123QlyJGW+msJJUTOjks6pWafuCez8LZLYM?=
 =?iso-8859-1?Q?umJMh/cutpIBYhff66HMoNqHJbqWcWn3gKHBLJJVS7dR7KASEPqIttTbf5?=
 =?iso-8859-1?Q?CLZNjZEsAMD0C8NOdC3cHABEGt4UKY1HAc85Z1FsEfUqLozU7tNQhVT9rt?=
 =?iso-8859-1?Q?VYbd9SXkebbN5OEfBa48WvXsqDTrpdm3r8HiqRS9ZPE6G6Ikm4Ma8=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR17MB2156.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?liLmr7wSJRjeX/VEWKKifksV4bDXR6f1LJ7F3p8ghPPKFBiZ7ZyeTZX66Q?=
 =?iso-8859-1?Q?9djiCO8Q5K60LccKDhHn++XZ9vxXny75DIgq/lceJTt7lSggTe4P6cVslm?=
 =?iso-8859-1?Q?T+oaHBmrKaYqDZPEjhZ+7+hXQumzdCRC1ypajcIwYTfP0TBAFDjnTUFDOw?=
 =?iso-8859-1?Q?kubSnpmmM5y7xJu5TPSZzg7wRsXLkvq/k0114NKUNYOETBS1U5/1koYWcb?=
 =?iso-8859-1?Q?l8xHobsk9KavTK5cElvdILO+JVhzOg6do7a13GJXC4z+zQQkQr+k/qv8CG?=
 =?iso-8859-1?Q?i+BO16dTc9YVZwb/vVOivKjsPnL+ED39v+fnGaNyOb5P6kT+M85YPgDS/5?=
 =?iso-8859-1?Q?Lo5Fl7LzO9dB6jxojYQrqTqeOdyWhuC2JBkFxrOSv7gjH564tYTTz4JJvX?=
 =?iso-8859-1?Q?OLBEKvG2WWH8zNJUazBDC8ik+JnDslt5QYroj7oveolSF4sVdDZjUVGQQT?=
 =?iso-8859-1?Q?cG1KK0RYqSuW8RqjpyHGEpmrL3lq5S8Iuj3bDZbCKb8YxKUdpofDnvzQAm?=
 =?iso-8859-1?Q?OG1VeOrmb4UkYzy03bzdZSLf8Imun6Zh02wSOOklFnZj1XHzoVQdiGzSgp?=
 =?iso-8859-1?Q?Ke4GZuZ7pXeEVeslJDuWyW/E/fjJZlWlRVupc26pmZkJ2z2NYLHJLw95qA?=
 =?iso-8859-1?Q?izk8da211WtIOQniA/9lNANXwvL2Vfo1xmHbpf9bnboeHVIXYZ7zLqXVtn?=
 =?iso-8859-1?Q?jbF7yoLpVrqJCkKlzfoejZFuSj2VFF7CYOG+8zsEr03yhUpRlRM4hPLIMW?=
 =?iso-8859-1?Q?zPvoCDFbekjm7NoTvnZo2i5jZ1j3SLSC9NjFeryzj1d5WrlcXmwyvYkrV8?=
 =?iso-8859-1?Q?sHlDSEMXTQ9cOOxtRp74cKKmnFqXF7mcId8aZlwDbHSMi84/5pDtf/Vq5y?=
 =?iso-8859-1?Q?Ek3nGfVCYtOOhKsSkkzSxpy6LTCSRXPKINrLHVS2tmW98KYt77L3RxTz22?=
 =?iso-8859-1?Q?tvxCgkn13cuj7cwrPjQcwc8GWa4lN4xsbeIZV/iLxn6sQRKV8DW3Iezztw?=
 =?iso-8859-1?Q?I+3a1oxmbKlvwEcZyRBUc4HmLozhY6O+iVLmkpmddMHNs3edEwitm/1S5p?=
 =?iso-8859-1?Q?PsOydAUMsS1EbfXEO2hsqLkAH1FyDmtiWyRUCzPd6dTc5piBeXvoSGnB72?=
 =?iso-8859-1?Q?RBf0NucyuCbmBYL4rZcvwFBJLyfOzjFSA7Jcq5u4StcAPvphJphheOOz+5?=
 =?iso-8859-1?Q?QI/j3CrOTJ410PWhs1cfuCYJFOzJtjBskmFSrIuv88yLWGwaRhtXK3MGCw?=
 =?iso-8859-1?Q?NZiCeHQ0n8c5glLs0iJZny6NBINWGSVrdKlzyA8QP0uLlq6hD4CY0DoRm1?=
 =?iso-8859-1?Q?7wkjxtYEONNdY+VsjO1lLczKcmZ83ahcLuqN+sAbcpy2ZBCrvOMJ5nhy/3?=
 =?iso-8859-1?Q?kxQt33L2O3MIfDbBpogioAmwE39f5uGJmkxKJtaiatIB8ldlm7r17uVUHz?=
 =?iso-8859-1?Q?DaCxoAS3zOgQ/WzGH3zlrGIEya4uMAJIp21jGao2+TCVIpcoRF7h5YpqoL?=
 =?iso-8859-1?Q?p8vypjZTRZF3Jz/lfntK1ae17DJWd56ur4G0OmhY1TULeEgBglIQ7R++Pu?=
 =?iso-8859-1?Q?ka8VEUzfHeFV80zm6FgeiBsm2h6u5cYWsN4FLtdXiGxyWge05VRD1enyb2?=
 =?iso-8859-1?Q?h80TlO+tc/bajLq8Do2hf5F8Tg3BLXOdKtrAK7yUOCvBE/7lhazEClKHUd?=
 =?iso-8859-1?Q?i7pJhHzZS53UA77Mnys=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: epic.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR17MB2156.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d205f588-8bf6-4b05-43a3-08dc9475323d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 17:43:45.4316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d8d598e0-2fb2-4605-8514-1967b50e2bd6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oVrHh1PH8w+SOtWHescFsl8R6AN0SLiXlfpVq+emr/tHpGzycQNcvenCvs2K9vhkxhoriB1PqgPGLeEMPy0RzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR17MB3985
X-Proofpoint-GUID: QpV1N_eRDBesno2ppGoGIP5xQU56hxLd
X-Proofpoint-ORIG-GUID: QpV1N_eRDBesno2ppGoGIP5xQU56hxLd
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=680
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 clxscore=1011 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240141

I haven't heard back about this bug report. Is there any additional=20
info that would be helpful here? Should I have reported this=20
somewhere else?
