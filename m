Received: from smarthost2.eviden.com (smarthost2.eviden.com [80.78.11.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC1DA939
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=80.78.11.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732113099; cv=fail; b=oKlXKl0bmy8Q+E80+shpdpg7IZDr8+MjMgp+WLKacZxwvub7i33A79VJkYrHZ5LN6X/R4S0vtL9aw1j3oFti31Zm111Awta/4S61AFGwY5d9jcnG5lEYXZ7A+GS497rvL/wzbj+lUgj16syyFQrqoBlDnu+l/9F1j0PPzc77tqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732113099; c=relaxed/simple;
	bh=eA1WKciaWi5Ar8rPQxit/IwRDam90VC/xJg4xz/lpxU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ryuxj+fIGU+eDoWa4EBM1MhjnmWUZF4hSrb4HCup8yrVR1BWzT71FbaCcjm0Mz5kpex3iTIS3Rydc0q1Wb4ixLO23+iPtet5wX5vQ13kwmlWuveo4XgShbW315j4af2r3tbSRI18JBIqy8hTGcYidXH09zdcBda77Iu/y6untlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eviden.com; spf=pass smtp.mailfrom=eviden.com; dkim=pass (2048-bit key) header.d=eviden.com header.i=@eviden.com header.b=JOIt3kKl; dkim=pass (2048-bit key) header.d=Eviden.com header.i=@Eviden.com header.b=GBkXpN9d; arc=fail smtp.client-ip=80.78.11.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eviden.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eviden.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=eviden.com header.i=@eviden.com header.b="JOIt3kKl";
	dkim=pass (2048-bit key) header.d=Eviden.com header.i=@Eviden.com header.b="GBkXpN9d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
  t=1732113097; x=1763649097;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eA1WKciaWi5Ar8rPQxit/IwRDam90VC/xJg4xz/lpxU=;
  b=JOIt3kKlEtZ87/STeyLO6dmV3zVGQUESg7iZjYQzsWxRzpysnZ7fu3ya
   27peg/Piw15p7Rw00lChOSMHNr2K74jbvBL0C34MrrJsC3Ht2lNjPt5f2
   gCEXgacR9ew7PRYzYlg3NLTLGYnIp4dn/XIXebpgJZQujH31fg6E6KOvI
   qx611nbYhS18NaonhN8nk9St8jNx+V0UPVpEqnlfkA+kh4wPAhCACM+xQ
   J7uWCRGi9P6lAswKacmBkznYvWgGwzDe04/FyidJre5LkIIAWYEsspYSl
   ddzARxLW4J+4ibkII75w2w3ZKOOs2uW5hvYePsA3fXyLnf306Dz0orgOy
   Q==;
X-IronPort-AV: E=Sophos;i="6.12,169,1728943200"; 
   d="scan'208";a="25051030"
X-MGA-submission: =?us-ascii?q?MDEitOTNUwZvcQEVNXbbsXm/oOXV8aPImTcR+R?=
 =?us-ascii?q?xVnWSxu9cUvNJGYJj3vrS9KjqSYQ0/EpcGOv6QfJQ24AfwGayWDGiSm/?=
 =?us-ascii?q?a3PSXiO/Otv2JFKb3cQ2GS0CNFxCUZpqayGQpap53wZV4Wq43JfChCyU?=
 =?us-ascii?q?SJNree1mYh7L2EDYEqYD0FqA=3D=3D?=
Received: from mail-vi1eur05lp2175.outbound.protection.outlook.com (HELO EUR05-VI1-obe.outbound.protection.outlook.com) ([104.47.17.175])
  by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 15:26:25 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bx4ySNXlS+7m8yxZVlWun4LusqVcUOrmxYTWSSi4Shyz2vJQRjqU4urGtOtE28PYVez2/hleclVFAjqzn6Wf6KCv+prTOHdwm964V+pEfXt0q/A89GRc2bAgTxC3GDKlH4rVV53WS1CVx2NJLLH3W+auNwDnuC/TJzG9j29hZWSpFbf9N2CbzXGRf/r8SXYpmVTFDqob4eyNZ6mvbk6cy5wTv6iju2Pv61CX291Y9nC4Z4thndPJfVIOrbGvEvCT/gcG0LbaA6KYAYmwm9iVgjqNXZwRqaJfVZsU8zFuwPHBwFkQVh3I/646o1w+OcqCtnNWt1wxB4deKtrAq1eFAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eA1WKciaWi5Ar8rPQxit/IwRDam90VC/xJg4xz/lpxU=;
 b=RhbIoWj3b8o2CrSJS19xrrOkwCZNDFZDYhFZDnrP04u7P4OwWHBUkliUPhYr9YTjw3SeufaQfypPPE3NmgOhZskTnQ8PFTQovh28VQIo0m7w70yFoVDT/ltWLiqb1AiMhkGaZpnnK2fJYhP8civie6f5+F/Kgfcd2ymx/fibfQm+2TDhkQWkaDfFPTn9hOj6kFfjSZq+eFSouHgnA1uM1UjxAuDExrkTJ+5LcxWLn70HaVHj85yasX/N73JgKlDbIC31F/8WrdjpheW6fw1MRoIlIsOg8z7SXiIzWY4lJnoq0+7WSGOHND3EzI8TVGl7HtMBEi4xKOl0otC2XbaX2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eA1WKciaWi5Ar8rPQxit/IwRDam90VC/xJg4xz/lpxU=;
 b=GBkXpN9dpldWh1+0vPD8SYjx2vDIIpOBYd03Tmpe8Wb31TFbzYS9QSi7R12tO5jQv9rVTYooJhDBxJ7boE7j/DFrWhfmwfX39/TMbT/OjU8MWqu2aMBLKd0ykLplCxV6e50Aqitr9rclKxBnlV2C7CqhtRBqG71NmXM5Z4nhuQzpDxZjWqsGhvqrGKbelUCosZD+VZzjvo5T2AgdsrrgcLaiN5r4AwMbuiTYO/ghaUe/CmbLrAzYixByG5vAX/3hHUDWZPpkDlrY8/HUg6jqahUBqBRb0y8nldHhYLnaUvgiWfU2pPn4em7ZyGOmbiR70vK3T+RMcXbJZGsxuXFDvg==
Received: from PA4PR07MB7406.eurprd07.prod.outlook.com (2603:10a6:102:c8::16)
 by DB8PR07MB6299.eurprd07.prod.outlook.com (2603:10a6:10:131::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 14:26:23 +0000
Received: from PA4PR07MB7406.eurprd07.prod.outlook.com
 ([fe80::f885:5976:29a0:5b03]) by PA4PR07MB7406.eurprd07.prod.outlook.com
 ([fe80::f885:5976:29a0:5b03%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 14:26:23 +0000
From: Richard Kerry <richard.kerry@eviden.com>
To: shejialuo <shejialuo@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, "ps@pks.im" <ps@pks.im>
Subject: RE: [PATCH v2 03/10] midx-write: use `revs->repo` inside
 `read_refs_snapshot`
Thread-Topic: [PATCH v2 03/10] midx-write: use `revs->repo` inside
 `read_refs_snapshot`
Thread-Index: AQHbOpkrkujm5A3uzUisCN8xGT+Fo7LAIqaAgAAXubA=
Date: Wed, 20 Nov 2024 14:26:23 +0000
Message-ID:
 <PA4PR07MB74069403837F36FD07D075EB9E212@PA4PR07MB7406.eurprd07.prod.outlook.com>
References:
 <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
 <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-3-e2f607174efc@gmail.com>
 <Zz3dAZGAG3BupQqE@ArchLinux>
In-Reply-To: <Zz3dAZGAG3BupQqE@ArchLinux>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_ActionId=b7409dbb-9c18-4773-9375-056a82c188ea;MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_ContentBits=0;MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Enabled=true;MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Method=Standard;MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Name=Eviden
 For Internal Use - All
 Employees;MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SetDate=2024-11-20T14:23:35Z;MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SiteId=7d1c7785-2d8a-437d-b842-1ed5d8fbe00a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR07MB7406:EE_|DB8PR07MB6299:EE_
x-ms-office365-filtering-correlation-id: 2f2a4efd-5fd4-4f33-546f-08dd096f4f9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XvOtksq37xVW+zSpVZxYTKbHvNGyjbsYwXLR0Hhnshir9m30KVCrsQybQ7Gf?=
 =?us-ascii?Q?d/emDprM7VRxHV7jnSCd28rZccFhO4Ru5DTVb+HxIxYVfF+o3T9+m4DsljUe?=
 =?us-ascii?Q?3erC6N4VB6MoRIyWNMEzjG5Yutz/Qkxi93QumRQwUKgCpDJKNIwa7X4QLLXX?=
 =?us-ascii?Q?7D5R2mO2MMhkzG5/xGDsRFLzXD2YcWAQRfEH8R+vf+T1boPEfElWDIA4iwFm?=
 =?us-ascii?Q?Oiw2cpu5h1f1zypWfBfjbSkaeBUbNB630gIU4ezZprNqD0de2JqvN4TpYGSx?=
 =?us-ascii?Q?Uh8QXwB+CnpTtOIOtaIY4NX6Fx0NcThbVvb6Z6SNcn86UpCvSjfZ7g/DmXpj?=
 =?us-ascii?Q?nwtRr0p+TPMGnWMjd7h8G+EmE+xXq4WNUDsRoqQadaBOZJ1uvheil9E5At1m?=
 =?us-ascii?Q?m+4ZT3Ax4sRyOTBqfM4Svpoq5Dvb2bD/MXsSv8UYGnqZhHMiZ3CCyGcXsNwW?=
 =?us-ascii?Q?DSw6ZmdCywA4z+vakGERGSvh1V73dTCxLw8j7BkNmWj1Pn5jAfgWjcHugbZj?=
 =?us-ascii?Q?rK+rEoSqjkhqlfHqsGz5QC6yI+WSL1X2YWw29xb8ApM6WcovEHbKgZ0I/ot6?=
 =?us-ascii?Q?t6WoNte5O8Ctz2YkvsS2koIZS5f/+DnGvEKCcKOBm44yVJwEXONkw2Ekd5fg?=
 =?us-ascii?Q?04u0nC9FgEKB5rORGBhzP3TnRFeZh7xydLAC4lUiwZXkyJG30tyav5v2s0xW?=
 =?us-ascii?Q?6wN9dpNULH204mwJ96bJu4VP42Nlk5iUFtYyzH/iNl8UITCHTeHmUjKuV2oZ?=
 =?us-ascii?Q?eCDDTF6v83dNaddiexqp343kzUvhQo9pCyGGB3XCWY9iKq+7erzsw+LEc8xz?=
 =?us-ascii?Q?9cJrqAyeQ8sLoYe2XZDDG43XuM5CM183r5SdDSYUkh3Mg2xWDyEmboVjAWZh?=
 =?us-ascii?Q?Ly4jSuPajpWKOM13MAkwA5VygCtgKJ2RPNBtZGKqdi8dBfYr+IG3dXqmsPvH?=
 =?us-ascii?Q?V54JwT9bAVKipd1Ku7pao/cJqvB8ZU2LlSBQfIW+qY0Js1FzySlaIBt8lvwa?=
 =?us-ascii?Q?aPx81kvIV9h+BFB8QRrbHRQUf2etp92odGQBCgkErJ7sBsWcwBcI51l31lRh?=
 =?us-ascii?Q?WSAU8xMSmPn/wf06LtWxJRYu+34zPDUbP2ngTw+U6jRwyCSFAS3TY7lUbTxP?=
 =?us-ascii?Q?BUD3dMUtJA2QJm2Z6wtPqxVVnN7MGtuUWdXuoxk+r/MV5eBzbwToMgnv+hYM?=
 =?us-ascii?Q?EgJPCQ1u5XsMY//Gj3Vy0XF/ixk4avzoVH8ytmi91084ZG7UxHv3ZGkQ+a5z?=
 =?us-ascii?Q?b0bcMq4nKlpOepeiLNAs35wuSYvpemKe9hsUXxcccoKZPEV1X0ouCi3J0PU4?=
 =?us-ascii?Q?x+HbDqq5O3KmWshxqXdc/URhif/155osuPkkGdDYfW2A7AAFGuBLC7WeV891?=
 =?us-ascii?Q?OSfjcbo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR07MB7406.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MJcmCzbNE2jFav1zPCM2wEYaGtc9HT+3tw8FhNm6qjHZCmGuDjUetdj6SUeJ?=
 =?us-ascii?Q?rzM1iAIeIwjYOonW/6fQXQTvEk6wSKGHc9poGRvVrk78uFOj9kmzdCQZJNaT?=
 =?us-ascii?Q?VRnmG1avTIPVxx6Od64uFvdXio5gdSKbJPIV8fjxtktXwod37kgHE3Z/uCJc?=
 =?us-ascii?Q?Hmp28lEEmTupzX9HcWFY8IgvVEWscStRvnXTc0DWjSdeQBJpVA/Qzxl5SXSa?=
 =?us-ascii?Q?UuxbN1GUlktATm8MjJWHZ9bCs+aZLt2lF0rhwxRgPa+ApvCPxvGZpYLG+0HD?=
 =?us-ascii?Q?F0C6HI++I3W9OIe28ycXS/eJLsxtHHOi8N3FBWZAy1U9aN2Sj6NJ8xVpg5WZ?=
 =?us-ascii?Q?9PyBeYLge8jUK8JXWvkKxet+JeN0ovOFeQMyGvNn8ZlA7r8pQPNxzXwhRoZx?=
 =?us-ascii?Q?NItqrONsg1/JAQ56lcFwb4GrwMQxHsdKSVk8EsIilDvbU7WWSRipr/ALRzlF?=
 =?us-ascii?Q?mDpmCzcsOhxVFikjY/n7Bk6tjRIksMuOn/mJY7L4pU08aCT7eQrgLEAUc6Ap?=
 =?us-ascii?Q?qPCd9RaCqLvcy+W6U5jOr4SV0jxm2i7flFcYpIo+nRst/DXiBmhfy22J+UbL?=
 =?us-ascii?Q?TdXaEP3i3crCe/17LWHQJPULtyf6W+Dpi30xrAhZrZmXOP3lmtZK+jTL9ipr?=
 =?us-ascii?Q?dp9yHPWk0Zv+Q9cXdIGC+CV5h82liaogS5cqGbPid23yzEfqMB5/j1ifQhus?=
 =?us-ascii?Q?mY8mpjZPz+nSu0asEbmoJhGCnTf+O+gj/u0l7xSsUpz6RjGiQT+Ny/9M7ZFx?=
 =?us-ascii?Q?UhlxgNGbYDUZHElJhqqcaKxNAn5L4umFSVQ6sFHbRG/5IPUv9BCs0NThhMn3?=
 =?us-ascii?Q?CPBxBtci05xtgpaCO3VzEhXA71kDCGueZc1wzW7lIl3pujbU3nCs0VQXirge?=
 =?us-ascii?Q?XMJNnfw0C7GSM//z6Xa8I0Dc4WnSyiqnjh+abbhlj/9NEqPmOGPSBxloDc4E?=
 =?us-ascii?Q?Phac8DQxXriFgMQC/oVuBVzKL3yjXLX6MZxyh6/xorxMbLmMVofceMMQjh+h?=
 =?us-ascii?Q?rnzHoHaIPLxFKsNU8lENMyOZ4h7y63ZUYnVL3FMCifIS/HVTN378Ib8TeV+A?=
 =?us-ascii?Q?y98CL8SNvtEfK2avtD2YjzvbK4d6fttLnJw7MCfZPlTI/nAWoI2ZMO8cxXos?=
 =?us-ascii?Q?hlEALn1qxTRDYiOTKUfrc/qv276mddmQZp6wZKgaV33kMEYRiGCyWEdK8UbH?=
 =?us-ascii?Q?QkcR1NPa8hapA08JH8FlCaA0wUStP/cWfdrhQbXMhTW0u1knEerwKZNEeOjR?=
 =?us-ascii?Q?N0m5/+07w318ie/JROglWIhGlWNsXe4FhoeDPB6oE83XLZ36HepLKUz2FhKK?=
 =?us-ascii?Q?DJJRX9ekTg1pk/TY5ju4Xwl4ze6WxBslp6wRKf+Sv9udDqcgLBJ8EXUz/rxS?=
 =?us-ascii?Q?3c0X4Bf10tpT5mFK+A63dDtYD+YGm3rGtEOrekaSWKSq55S9nazRb+IblAvT?=
 =?us-ascii?Q?5Be8gx6T9U7JmtEQvswc8KK2nquKDN7pG/BDnBvoaSjOWdzYhoba9/MjHDTe?=
 =?us-ascii?Q?TR9N5BF4RhXdfM5eJLtggBnSfTYfTGIGiWxHMrWWJ4J6fwFwmho8jZXl++qx?=
 =?us-ascii?Q?Ea3+u+YgwzODDtDHFFNSLYextXh3Nz2IjQPYyH/G?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR07MB7406.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f2a4efd-5fd4-4f33-546f-08dd096f4f9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2024 14:26:23.8172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7aVop579U99FZ8DC0FM0PtYjTjzGGT6yRIQBqVSZep0uUZwWwLu94D/KNdiJCfkb0nKZhX7E60rG9+t1E+96RJBcEs0KHCKfT3IC2MZkxPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6299


>> The `read_refs_snapshot` uses the `parse_oid_hex` function which=20
>> internally uses global variables. Let's instead use
>
>Nit: s/variables/variable

No, that's fine.
It's plural, so ends with 's'.
Unless it should be "uses a global variable"

>>
>> Also, while here, fix a missing newline after the functions definition.
>>
>
>Nit: s/functions/function

Maybe.
But it could be "the function's definition" as it could be seen as possessi=
ve.

Regards,
Richard.


