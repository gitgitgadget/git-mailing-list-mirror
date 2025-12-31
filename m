Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011058.outbound.protection.outlook.com [52.101.52.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D89D18CBE1
	for <git@vger.kernel.org>; Wed, 31 Dec 2025 05:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767159600; cv=fail; b=NCCHIyKzjO0vs51n/dkViPZXYG3EGyb5hp7tDUUYrXnhzH8P/p+YyGCxHIU6muBxc4lAqBiCJy9Btp4qYKTTzcSSRmWp0lbx1X8IeCNroftcaBxjgI5+SlbK4SuxuNjNjvp+7yea/+/xCFX2vHtqQN00oWWbJyYRxYDmTMCXR+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767159600; c=relaxed/simple;
	bh=oFYbMEIGsDh2FHvy+Iga6MOF1PebdNUwjyevmX/4yfo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KA9QHjfBsulwg0wyaMsieM9Te4tWWq9/VOtCIyLQhkgnRRZ7C8Lf72VmbjGzJTyeUNc5U2hwyzCqFp0uepYNJpZA4Z7AChhhAsb8v0SF+vTmr9nlxpVc67UWNY1KraGdSj/vHmLiF8qEsgF943P+S5E/YB4cOeGHkFr/eR0CvBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JRyAwnV3; arc=fail smtp.client-ip=52.101.52.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JRyAwnV3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+7i6UrEsI2TjY+xjG2YSNn2HuuJPBvA5FO/aUzObIrfHgu1yjOwtT5r2GZb19aS88tWjeLrkyu6rHI35gNmIv94HR3wRHw6jIWz2Dcncnpcfrk5mXQaePtrmoBh1mC58wLm0MztMVQIj03KC8nUUCsVrjS0IJ96ctk+1uR+IFV4RzhwbpvUj5DH956jCpTNik9W+puKNNE/IRulU6I6VXwzZDuvU+xcnF+rR3+ivbYXCFeXbC732bPTOyikya+C2R9+PZDKEPdGcAXvV2Y9fMXrShq+8bhP7L8tnsF5Y2KHbkN9PIzkf1s1qksfMrRD2+OEREoCTJ+tdNKZJ+BeVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFQ5AGZCt0jjZjaR4rM+2M5I18Vyd6DmZzGA5LZ+Ah0=;
 b=AG6/On9RPvCVSWTmDxNdtdOMrTUVqS12WolZapeK5C3zFEZaU11Gc4xYeqAmpwm0cG8VpQ1sFePmNlu94bbPZjycBXr53pe4S3cT7Ssmsr9PAMukqYItprSUNQjf8FO4BWXV42YAY+Y8T4Ynmbz+C6wkpPivvNQGsGd3QjAnD+15Vx3PCM22+pJtJ8WdQtTSfNZjZnTwJ7iMFw2oD4BoxdJcMfOZ26oOgSte/1ugyE9ke/7MtcZexPBefCuC+FJfAcrim5tvL5NAFHx2znSDopmvRv0FBPqjnSGWgHXoqpqmKJpgqSPt5ex+0L9xLTXm01hZt07FLT6YdS25ATn7Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFQ5AGZCt0jjZjaR4rM+2M5I18Vyd6DmZzGA5LZ+Ah0=;
 b=JRyAwnV3dlfgoeotsQI64MenZJuMlFJuSKq4XJvK33ssORgvAIEP1SCQG8g/JBM46O6g9fylKpZ0fmCdgySi3UkV5U/mG6TGmGXe5E6Hsa3UbXRHalBUTjo8I0ff6DQcYgxEMxygBbBrSre96+ix+ZcShPkl/bz/9Ea825FNxPnlQgJMiFXjV6f5yFQblsscZN6Ut70AOa+B1Hsa95RBzTNZczzHaBs6Rj16FQKHdTJJ9TTg1wfupO8BjatXafnMgIkxw8BOd6Qr8jkqEV7Jcl1Q5idGQeGHpfiBLipnQXKOBhLYGSLyDukwfgJga/rcGLHDbY5EY2FCbgTlXGnyDA==
Received: from CH3PR12MB9026.namprd12.prod.outlook.com (2603:10b6:610:125::15)
 by DS0PR12MB8367.namprd12.prod.outlook.com (2603:10b6:8:fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Wed, 31 Dec
 2025 05:39:56 +0000
Received: from CH3PR12MB9026.namprd12.prod.outlook.com
 ([fe80::7e83:9747:5352:4af2]) by CH3PR12MB9026.namprd12.prod.outlook.com
 ([fe80::7e83:9747:5352:4af2%6]) with mapi id 15.20.9456.013; Wed, 31 Dec 2025
 05:39:55 +0000
From: Martin Fick <mfick@nvidia.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Slow git pack-refs --all
Thread-Topic: Slow git pack-refs --all
Thread-Index: AQHcdebABRaVmXg1XEKj998vyrImTLUzA1gAgAg9YvE=
Date: Wed, 31 Dec 2025 05:39:55 +0000
Message-ID:
 <CH3PR12MB90260871D7B0D3516FCF3DCBC2BDA@CH3PR12MB9026.namprd12.prod.outlook.com>
References:
 <CH3PR12MB9026B5872FD42F031970074BC2B3A@CH3PR12MB9026.namprd12.prod.outlook.com>
 <aU3K9lGbHw68Vv5U@fruit.crustytoothpaste.net>
In-Reply-To: <aU3K9lGbHw68Vv5U@fruit.crustytoothpaste.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB9026:EE_|DS0PR12MB8367:EE_
x-ms-office365-filtering-correlation-id: 4870768b-ef99-432c-4b97-08de482f0777
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?t4K5bW2xVUFQaacobRamxxDxNNmd5sea6TI0pXOBWgkrnhvDda8ffzm8sP?=
 =?iso-8859-1?Q?NOKPVDFnIBErJ6+jqV6yR9SSL+BNYKjJkE5CFXEKa8Py3Kcyb9Z2tBhVJn?=
 =?iso-8859-1?Q?YYE7niXJQfwHzYrrUCwhivPZaRXh2Nnz0PFQdX/OqLxjNdW8Kj1sw6//kk?=
 =?iso-8859-1?Q?M/HwuJBeDYG1jpaownEv5ZBEPthqH3EJbBwhc9t8pXkzbjQaRUE12pBv+7?=
 =?iso-8859-1?Q?20PxcVYu2zBE4snGIhNHJm1a1gSvVRwemAZOtNaEBo9DJrmtwCYRpFGNro?=
 =?iso-8859-1?Q?zwwsPFFr8bNlWqr8S1LpSIZtuZHH+QVO+ujomALDhBE47i2yRDBJ+U7MjP?=
 =?iso-8859-1?Q?GcV1PzSFc9XQx9gBZrRAnqGAYLGqjFw7Tra6adgbBfNmtnk3ZOS0rkHxQl?=
 =?iso-8859-1?Q?y26W/OeiQcYirFMGzkFLYveHZmMMsK+KMnDRgs3gxKzb5lLyIw2nlaBdPo?=
 =?iso-8859-1?Q?3UVD9pVvJLKCdLtchrrSK5mOsBgyJECz91n/DZOqi0Jq/VJRjadmKwnNFz?=
 =?iso-8859-1?Q?SR5ud5/a/g9qDd0qksp8zK/LHRTRRWN3Kfij/PsTELs8QQlCRiyWBanszA?=
 =?iso-8859-1?Q?vkVAAS2NlHL7GXocFucxWu98EeZrmfp9DB+rE46jLAhM5nK1iTdVOkddAl?=
 =?iso-8859-1?Q?Rhzjkb123w2IxBaIoJnCzOTSm3I3lL5zeEdlVweIgLBLfyyAKtEN7rkBko?=
 =?iso-8859-1?Q?t1Zd5j8lgr5Ff3dbDIMLsCA5in7LtkGQzrxzw4ZQlHMupf3lUUeFVCoixg?=
 =?iso-8859-1?Q?VuxldV2aLElo1X9s/x/zlIJBULiQbm7FtWF8nq4Ip4y5o56ON3xu3SAnaz?=
 =?iso-8859-1?Q?CCrwmuQ+0KAEXjn7b7TF7m4DIKxpVTMkzYEkzyCet3Tjawmfwq2IeyqN7i?=
 =?iso-8859-1?Q?wLbS9+0kkwXez9n+9y1cYvceCekAV/8Di+607ytXNN5CpfGlvVWH6T8kMm?=
 =?iso-8859-1?Q?zmMmLGVLSy2RJItcxQUETM0AYqMC/DiiXZMLLuP5f9Vhq5HnkpAOm7a9lt?=
 =?iso-8859-1?Q?n8zqlcHRCLKH2iZqK3L7sZAeODjV6cRx/CAIOWUwiZMSSPgfxflsc0gqBJ?=
 =?iso-8859-1?Q?Yf/0M7mXpxEYPiGsF7fA7iGWA4KdoDWwD0z8rSVJ+6lRFsQTaAGx+6Tis+?=
 =?iso-8859-1?Q?7rhyYfXhaQYmoCpmzRYcfUA1iW++FGbMXNBbrLmqb4eYW0zPsa1WIhZ2e2?=
 =?iso-8859-1?Q?pjClbDT4pnI3w52pSa4QykxCUYRu1Q8f36rHiJfmigTK2BVLZNoOEZOBJi?=
 =?iso-8859-1?Q?6LWLC/2XbUpzjcRVI9veFUf144Q5Yte8nX6MB3B0Ql69on1oTwS6c5apl6?=
 =?iso-8859-1?Q?wp/SZq9IeMsTquaG9lKOMIeLDp2N5DxvNeRiIwkyEpH/6Ari9IZxXweR9p?=
 =?iso-8859-1?Q?3ZxKP6Ewh8U1XHBxu9Kiw6e4ZjxA2lObt+HjBTIFRY3OPXv2as0J5NC0cy?=
 =?iso-8859-1?Q?T2NFz9dLq3su6jYeK5JWwQPwnMFTmgVENA2o9DrMUmke2bfry0k8Z3JHpz?=
 =?iso-8859-1?Q?ALvO1Hb+A+Xgs3qTQTkLReZgjrmudchZ8qm8gg6FXAhYFqQElDdJYk3Bl8?=
 =?iso-8859-1?Q?jP296m4SzpfAL68J8FJz6e/KQbWg?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9026.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Rbnyr8820Ej0RH238lIDAL6wNx8lYGBuIvLegeUFeqeaKlT6aJywIOi22p?=
 =?iso-8859-1?Q?H6UZi52PLKKXfkMVIfamCdK7KfrZ5M8WZJq5UbfkyKyzRSe67VqLNhmqgZ?=
 =?iso-8859-1?Q?KKldUO2Rvihuf1Vn9OvSVc2XJk93EZECtRgllmHqamkAUepMtIuCi+FZcy?=
 =?iso-8859-1?Q?dcXOPTlxTbcj/ixuxtBc/ZPxlCy8jlVl/njdVZoA9iPgy9yjeetEE2eprc?=
 =?iso-8859-1?Q?DtN6Igz9XWsSBH+XPpwucVJ3EyTzXmO2BtVDDDf4o4J+FpN48Ok1rSusPy?=
 =?iso-8859-1?Q?BoIa7jNcqXMJcNGjlI2SG5CZ29WLS1yoPzLPiOHMEPqyCCraGANOwBlYdH?=
 =?iso-8859-1?Q?EUWT+PRhWpHrJn0A25fp1zR6Mj4sfQJ8z8RizbCzAsS0C1KWLEkQ6YKRUb?=
 =?iso-8859-1?Q?JFOmKKZVDnAXJ3wHrT6dvXz1+m3FlcAGWj1mfXMTuajnVe+suneHizkfGb?=
 =?iso-8859-1?Q?B/DArAg5gu5zISUEqyTYdMGW2ZSoYz/qYSUKbUcASNcrvVlblUW321FA0Q?=
 =?iso-8859-1?Q?eWkiRH5/bTY3/ZXaVGNOWlR8/2QCilQv2CP6Vd6dBarnd40xAfWE1S2Ni8?=
 =?iso-8859-1?Q?6SVAYUH8TnYN28vVdlC0ChhMTOdG1u4ITN/K/e/k/ryifeobPO0adasgYZ?=
 =?iso-8859-1?Q?ESdjmg+Y1KtWYf4udbQeqgmUXc4Ma/SrOT3D1Y4ljFpey28/dTs0JhxAjD?=
 =?iso-8859-1?Q?3fBWqOWMQ+45jXPZZZwNjyA/kfcNKvkn9Cyby93A00wc7cCg3mS+2gMhTX?=
 =?iso-8859-1?Q?6Na9tso8XrP71YtMIVxLUwc7AizsCx10J/zFpgv6+7mEt7ERQ4bo6Ce1Rz?=
 =?iso-8859-1?Q?c3T8jW1qxsTLOYcB/hdpkEdlS8H7wk+LO4oAj/PbD3FmAnmg/dMKZa/Kv5?=
 =?iso-8859-1?Q?pRULYKX6XjnMDRW0GELTzvHaHQu1JYF/FuejgZcQ9baq2U88hIr+uTxcC4?=
 =?iso-8859-1?Q?mOePzC8JE7azF+i/BmXb5KT8N2SUCsmxLD5vmCqneaxGPIrCR4svwaED3F?=
 =?iso-8859-1?Q?T+d5ZDtj+ET42RUlZ5GBB+abASNERQkZzkp2kwzx8tK2YONRq6NmnUqw7F?=
 =?iso-8859-1?Q?rnEYh2srOEyzgFQXQeiPD1bCn0i6P51bi5cbWDBOdhW9ViHcs+y+zcPB6y?=
 =?iso-8859-1?Q?c2kgR4gj/mYxRER9dOpJBp0Kprs92ReR9Oe4jKK6JI2dvUhF14PYg23ePI?=
 =?iso-8859-1?Q?gGy2FUJpCECoda74rbYQdgcBnSt6sK3H0wr+nPuCi6ATTMj7CyAk0NOlpR?=
 =?iso-8859-1?Q?yPSfCEzPEe/hhJze46v4AFCWDhrSZ2QSeU1JsTiBDp1fxojA/NQ0VUZtQK?=
 =?iso-8859-1?Q?Evin3dERXkL+ee3LRLYpAAF3rueJ+ZihLacTQDpVr8OrzhfX/BFRL0kLGR?=
 =?iso-8859-1?Q?JIzYvrvCIDQ30PeZF5OGKsX4xKOEfhITkn+0X1IGpj1FxBOafYnraZtktF?=
 =?iso-8859-1?Q?exrQ1aSxEHMgKk4z1NSrmjWpwJXzId22Y4NkoIkkcTVw59s6Xo8/YICsvz?=
 =?iso-8859-1?Q?HTR+Najn7szo1qGcvwF4AkbfZXz1DPCVW+bFebd9O7F9hO93Bsq6Ql+LnJ?=
 =?iso-8859-1?Q?UkGExlCbGiA4IiqwLqA9farUtL+5fKHY+MvRLy/O2DvpNSx6oJYigt/Ozq?=
 =?iso-8859-1?Q?0AW04WxFlMD9KU9PB2K9+DUUe9gWOJZDcQ90qJcuFqHLe2dwj5glq8KZKS?=
 =?iso-8859-1?Q?+sBZeozUJSbB58o6kkdnWcCeOZL6wQQBMrCykZTBeCRfn/FJy0YPKLGBI9?=
 =?iso-8859-1?Q?NjuVvJIbx8orNPVrSCx8AxVv51G5yk3XF+D83rCvUXQ2VB?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9026.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4870768b-ef99-432c-4b97-08de482f0777
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2025 05:39:55.8891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sHw7QdCazflsCmuuvsa+0nzahEYrkTuNC7b1PsYAy50b9u2f1U8jbQILmvEUESxuYGJFRE2aUsvoqA+LdUNdjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8367

>From: brian m. carlson=0A=
> Sent: Thursday, December 25, 2025 4:38 PM=0A=
> On 2025-12-25 at 22:13:54, Martin Fick wrote:=0A=
>> Although the repository is not in terrible shape before packing refs=0A=
>> (~1500 loose objects, 37pack files). Surprisingly, repacking the repo=0A=
>> first does speed it up so that packing refs then takes under 20s.=0A=
>>=0A=
>> This repository is on NFS.=0A=
=0A=
> That's almost certainly part of your performance problem, too.  Loading=
=0A=
> a single pack file and index is going to be way, way faster than making=
=0A=
> lots of network calls to open 37 pack file and 37 index files, plus at=0A=
> least stat some loose objects.=0A=
>=0A=
> I will note that at least some forges always have Git write pack files=0A=
> and try to avoid loose objects altogether since that almost always=0A=
> improves performance.  You may want to set `receive.unpackLimit` to 1 to=
=0A=
> see if that helps in the general case.=0A=
=0A=
This would not explain why jgit can pack-refs much faster, since it has to =
deal with these NFS latencies also. In my experience with jgit, we generall=
y don't see performance issues unless packfile counts exceed 300 or so on N=
FS, definitely not with only 37 of them. It could be that git is doing some=
 things less efficiently here, but I would be pretty surprised if git could=
 not also perform well typically on NFS with only 37 packfiles. I don't thi=
nk that 200 something object lookups, should ever take 3+mins, even on NFS,=
 and even with way more packfiles than this. To be that slow, it would have=
 to take about 1s per lookup! Something really seems fishy here to me. I ha=
ve to think that somehow it isn't these reads that are slow, but I can't ex=
plain what else it would be?=0A=
=0A=
-Martin=0A=
=0A=
