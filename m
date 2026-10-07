Received: from mx0b-00318502.pphosted.com (mx0b-00318502.pphosted.com [66.159.239.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149473D1CA5
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 13:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=66.159.239.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791381241; cv=fail; b=G41iNVB+HXW9oOeJK32Uz3OtPt85kQ9wZ4oOti+K4r+3vtCJLWylUB3B185ZjwV2lta52zNc+pz8kCzxAyrgc+HBs8fA4fvAUcsFY35N4EmyxhU34qF+DYkkrcVe1LFrYtN91CFEm6prT5ZDYB9AAqX98DpQaHEbILZRfyWYiN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791381241; c=relaxed/simple;
	bh=vcDgXJnfgcmNKCwsFSRoCAcFDHvgZdmMJtLx2PiU1tk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O8YqzCLcJEMfolTUj09Qs0Y+sI33zfdXP/MTlm5rZyX++btirCt0F5W77K+smSO4QXt8rJaG9YoNoyunsY86Ekr+kWacxKDOZ5JLCB4xv45Pg2Cs24I9VDTmF2tlsWGns2o5OVaMAe0eHBA2Xw0DdYNHp6W4r/r7kFWH4+Ko56g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mmm.com; spf=pass smtp.mailfrom=mmm.com; dkim=pass (2048-bit key) header.d=mmm.com header.i=@mmm.com header.b=g6T4Ra8N; arc=fail smtp.client-ip=66.159.239.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mmm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mmm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mmm.com header.i=@mmm.com header.b="g6T4Ra8N"
Received: from pps.filterd (m0437337.ppops.net [127.0.0.1])
	by mx0b-00318502.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BVtQX2839909
	for <git@vger.kernel.org>; Wed, 7 Oct 2026 13:21:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mmm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=ppp01-25-mmm;
	 bh=vcDgXJnfgcmNKCwsFSRoCAcFDHvgZdmMJtLx2PiU1tk=; b=g6T4Ra8NqBS4
	vXgpLidOYdCRn1xM5Fxn8vyQAZ06+26OrGR4WsgCNpRY0l+bhXTxtHqYUu/b3Uzm
	kgSIi0ji3hvYvv7cYWmEj3S0QNqPtF8Y8tf+3fHsDjoDEPoetC5TyWWbjmeSYcKW
	x5LxVROc9iepxgLykc15Yj4bwlRKP6IF1YTIqE9boE1WBkEGLN9RZjciK/ObNKZj
	fLJIBsJSvzMlwiHlxd0+1jvyCEkwSBWd+IwsVJ6SSKQMw/ReNJjoxtuUGUb4krZi
	02Y+E9ga+/ZC47KggP3opaMFesw2TAhxueC5W4zKyXn13zp/S7o3KRdqClBOWEiR
	6Pwkt9hsCQ==
Received: from smtp-277a-c.mmm.com ([192.28.24.1])
	by mx0b-00318502.pphosted.com (PPS) with ESMTPS id 4h54t2x54m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 07 Oct 2026 13:21:16 +0000 (GMT)
Received: from CY7PR03CU001.outbound.protection.outlook.com (unknown [10.88.0.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by Forcepoint Email with ESMTPS id 3CD2311AACE0AD6C2385
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 08:21:15 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X7hcvX3w+46aSeVtix2ZBPWs3U/m6djoAMVIOLP6zW0fGT/FDhnxf4bNNqJUPUzZvvRES144B1G1N2X9xKKmMscqKSMfIbLi4kpw/hEFWr6WCgXpKMHUCnAG5VVV7TKuFJuY8Z+EYQ1VCnN4zMVRpd/R1D70Dy6dcblxCIeScoc6Bs+/8qvmSPH6hNhSrRoTuBpwvKX5PkAHs5q9vxgwPm2XSYekTiKnxttGhveoWsvSP7rkenf6rStvDjsAo1Kwli6vA4xbPfwVrucU0H1aez8NAu4zxOeLNyT/hYtYs/hGMw8a1FL5VYpBhokiRICmP3kKQvGs8Z1FaeLg6O+51Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcDgXJnfgcmNKCwsFSRoCAcFDHvgZdmMJtLx2PiU1tk=;
 b=Tq3uDAAx/DPcwyXqmbz/YoEFAIsB1UUCHVT+tgVvAzcAtsyREaXERY9CvOZjuq19zZodvR3s70nO/O3YmC9h4DGF1aG2uiANqUovmRsC1W0qyAeey5lxqBEzLAIc+aE27yHMzqtPde2bZjBY0P8eMGWuIoj6E32WgF05k8V0aU5w/D6p/K4g0yub8H1i3BqnanUNsERx8V1I94QuPd2sGunQx72BrPcYvAiJ/Q7I5/v8OEa4L9w1jdPEwSY+AycWgr+PPVFhGa4ImXbZ2n8r+pvYO/qqqUCnLl5xqiysQ5fSUNaArqqtK2SMFKg5e50rvGFHyWKGdg7nL2eMD4Ptig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mmm.com; dmarc=pass action=none header.from=mmm.com; dkim=pass
 header.d=mmm.com; arc=none
Received: from PH0PR03MB5944.namprd03.prod.outlook.com (2603:10b6:510:36::13)
 by SJ2PR03MB7110.namprd03.prod.outlook.com (2603:10b6:a03:4fd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 7 Oct
 2026 13:21:12 +0000
Received: from PH0PR03MB5944.namprd03.prod.outlook.com
 ([fe80::3194:820c:80c2:3506]) by PH0PR03MB5944.namprd03.prod.outlook.com
 ([fe80::3194:820c:80c2:3506%4]) with mapi id 15.21.0472.016; Wed, 7 Oct 2026
 13:21:11 +0000
From: Daniel Gullberg <daniel.gullberg@mmm.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: FW: [Windows] safe.directory: unreachable UNC entry stalls every
 command in a repo that fails the ownership check (~25 s)
Thread-Topic: [Windows] safe.directory: unreachable UNC entry stalls every
 command in a repo that fails the ownership check (~25 s)
Thread-Index: Ad1WWoEoK70hv43RT/qfG/44VWo6vwABBhaw
Date: Wed, 7 Oct 2026 13:21:11 +0000
Message-ID:
 <PH0PR03MB594476FBBE28305EA52BB482FD942@PH0PR03MB5944.namprd03.prod.outlook.com>
References:
 <PH0PR03MB59443B1A6BA969CD509B8C22FD942@PH0PR03MB5944.namprd03.prod.outlook.com>
In-Reply-To:
 <PH0PR03MB59443B1A6BA969CD509B8C22FD942@PH0PR03MB5944.namprd03.prod.outlook.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mmm.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB5944:EE_|SJ2PR03MB7110:EE_
x-ms-office365-filtering-correlation-id: 248ad05b-1f68-447d-a8f5-08df2475db4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10067099003|56012099006|11063799006|3023799007|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 AYLctgJ3G3WZMwA6ZpbUH6S/KmLv6UhnlpceW2Kb1bjzkAjrz3BVGwE6zbgzCFr64/5QAV9Ux8/l3/ET8+jwUH78q4ZCb/BCH4qYwgnaCOb0NBV8Lq87GYfFePAzG3OZdCpriHDIZ/E5LfSRL+XiWy4+GbXbX/vPckmP7rGUPkzAPhPVTBhO4ClkOJVWxc8E6udKH4HpG/mTuVwOBMgheZ2HU7Wf+z3IAT5yhxhL1aKOWO8tSOesWs9v6q+QXryYTlGH9wCz0wJoukAPNtUukNkSkpjeTGDsswHFOSQCZPDsl4jo1j6NKRZSHaywllS3V2/9wsK35Wqdcc0AtKNaq3hTNh3kWXLNYLui3SnR2nCsHTXYME2b9fcA+X/W4AslsH//bjEYnRV6Hj37W5uQ00auZ4EBOINRXTA2rB5vC1JBdkMPt37P99pThgvjdfnAu+Fj+xUpxsWEVSld3Bgfrbd5KbVeoK+Zwgig2B/sNWEfWovnZi+xZv+GKwc59kW7YmUC/ivyPYyuMPnIQjLOjBi/ETaV+Qq6SWus1Ib98KWYjYowE5jZwGSevV7WDoLbTDe1g5YDCiEg46yh6QptGLF8imFhn+Ph9iR1UczvekS3njKIOm6v3jHaWSPRONLqvVJxN4QctUij2TXZ12ng9o3faz+g+2TnXQITdrjt2y2lCsFHPfGvJg5nXQRL6O66AgOmw5XjPoZWWBfeYnUVoatvWdIj2vOPXqHqLVki7Sc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB5944.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(3023799007)(6133799003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?wJX6XTyoZJ9eBIjJfPu6kl0OAyzEwuNSCX3K9ktX+NiHjtUzp5VnmZlme5?=
 =?iso-8859-1?Q?cYgGAaRd+izs6uTcBqVWoBiakU2bDIZj3poYaCuE45HwfCE1QHmunPOAFR?=
 =?iso-8859-1?Q?uT2nP1LLicR5aSmAMpsh9xh9midfGT80CisYgylLdY6iipzw926I/nYpfq?=
 =?iso-8859-1?Q?j3SP3Jx+0+CYyMK8gJWTPwIEx4pOvvYvAAL8j+qBAq+UYoEllUzxK6WCQU?=
 =?iso-8859-1?Q?DKU/9KMLeEnU4btwG/ys/T/gMy5lVJ1hxUorEVOYhEgurTkKkLbA/VMPvO?=
 =?iso-8859-1?Q?9fQ2noIIxc5INPS/75LFjVoxqKnWsZOLdC6UlrFx//JguB8EECEx+CYH1E?=
 =?iso-8859-1?Q?fWtCv8PiTJZxSIAeLtW2l0Mbucsssy77o3g4kFe4eR6h8kDim1KOMutSY7?=
 =?iso-8859-1?Q?nU30PtAQjc+QoLO+Hq915Sfy1/L44Um92nH/2Z0c51sfzeCAP+D4U0uGd4?=
 =?iso-8859-1?Q?h501tZ5GXwwrc7l6UucJd0BMd5z7pplQY4IwcO0cNCJn/abXyqKuZ+AjbU?=
 =?iso-8859-1?Q?uqwJjVCs+MA9ll3P/u8vvT+cozZDzWvtvWUue5a0w4Xf7iANM+8XG3CITp?=
 =?iso-8859-1?Q?lzVQ1kb7UgKkAFJIIMoBQQaQStWRDUSVCw8asmHlDc+S6cpg9MOOIXctok?=
 =?iso-8859-1?Q?uNAMy6zrtn9GrU05egSJDlXbso3zOELzA15w4+yPGRbMww+WR/hOf4w0mE?=
 =?iso-8859-1?Q?t/RmPU8vx5GQIlvuVdIZ05qe4yDQrVSwrEu1V9hbbJlOTUvggi4lwZAuJ3?=
 =?iso-8859-1?Q?NM4abNLPe6VeHMk7DJ3AB10oAnBSWOJDR5haOKPsCpLN8Vd/Who4+Jhs9H?=
 =?iso-8859-1?Q?RQFc1hd4X3MUaVDSl+zlkS1TVd73zy0bR1WJoWaBHqB98t32dyDfxhelEg?=
 =?iso-8859-1?Q?w2BGfW1T2Z7z8C5RZWuZRND7hZVgaBPOsZYxktm+wO0T9GrPCYrPyCaVbx?=
 =?iso-8859-1?Q?1eYUeo6bZa9FFf5UYZOuCb47yoDs88vYcFLvXLU1ZjJC+g1mARiGyJ5i4r?=
 =?iso-8859-1?Q?SZN6JUkOt20Ix9I0ELYkRMWP+ppwhk/pkUbFvLEUJBwxRONUme54lyM8l/?=
 =?iso-8859-1?Q?HuC2+GD9hwFJdJINrJGK3jBrtejULtnqW/kOZQ6i14c3AJf0LOZjrADu0V?=
 =?iso-8859-1?Q?iQLQoAvYFHjKpSvJV612Pa82ir0aw6T1liRR5J0aKPVvDwdB82rZdY8f4q?=
 =?iso-8859-1?Q?LpJjqXnsjheOMfQyD6xJcq6imCZ8kLHP7jOeLSzaaTJfm50fSkEsCXV4yX?=
 =?iso-8859-1?Q?mr3sFN5FnFVNr8PbVdIjPQVtiBaIQsjIm5Z2XTbiVkSAJL6ZTljEewJumT?=
 =?iso-8859-1?Q?GxXBauFfLo7VcFg6Fy/vBkQ87EJsoTv0jFFaJ73u/dvA0+foGdrqHR82TT?=
 =?iso-8859-1?Q?QMBos6cxVRZ/1zMfkRA+TM8PvMNIfcxV/tTsy6PIztfysBP5sWsqNQK0s7?=
 =?iso-8859-1?Q?Pf25td8uTEawkWuFwYbAgy+rFyNbbWl8Hl3KI1jX8vA/B2wvf30wkNmoWn?=
 =?iso-8859-1?Q?ygoo9zsEv9pSOQUkdo6zDTKpfla7b4gxNP6op6JQBWjL4Lc9kIbUONw594?=
 =?iso-8859-1?Q?4gcFq+iDFj8Xa0+5MF6H+RYlDqEVKNJVxyN37ZB5wAT2EZUCgGbjAVkjBk?=
 =?iso-8859-1?Q?bmOd83uYzvM+zTfoBK2/3kgJjeXyrtgb0MFONwZ5ANNN9TvkgZ8yjB4ghJ?=
 =?iso-8859-1?Q?JV/x43o1OFVEMAMDPgU9B+PZtJj6xbKw6MpGg4j2R16E/CaZNmvlljx0Mw?=
 =?iso-8859-1?Q?xRnbEw7ZPCDrHlOeGK06nTI8I/QA0SZYfVUu+x5GJQV2xS?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	AV45CSwE9MuuI4xN8LJpMlJ5VyhOPtHJc/jLlVuFy2UocyjyA2NXRspfxAo1LRn7iy1LdZjjPX8fwS0LWbV/92QWyKPSI3h1ZFoSGyDcudNtIU5SVz6fyoERz5ZLUNIYtvdRGAFFoxjoh2EkG4NRNiIHwTJNNZXasG260RO98RK+85cPpFIuF8k9iaWaYYw/WnVVxMj5Baw46yLAXfXiibQYBrS2Oe/m7Roq20ZSLU75eedLLHGTRyjMq8OKXGd4DTvJ/11Xp5pQcNo7T4Vcd/w+LwHk62v7C6GcSMFSMH6Dn+5HbQmzqe6VzUA3sJPPKvs7uqa7lDTc1SInfEb43Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FZsEllmKijBoxU5F7U179Cf6yShuTuIayCRGW8Xn+hXwIj49q+HRpPV5WHla71DXch7n90yi91Y4nt0WJLPKUHHoAmljSXF+H7tmaS1UzEL7aM886Y2XHU8WY8Y713xbsKVcbM0RmTRuiqm2yUljFBTm4yfppC8yxozBMO5UW73OEZLxNgY9qaWBcC9Qsg5wSp1zk8s7MrH3CIdQxT8vNaLRr88DUbKwbgeEtjc8SUnub/Uip+bAZDY0avfe79uGav1KWLX1b8RJNcPJEDgDcMv0NwaiZhxp55evz6GZo/nlNNomHxZwPPXaxca/WhCgNtALEhwj/aLMFvzkt8a3rzeadiuqlykLz4sfwJnCe18bLMThNYXpuVae/5aQC5Ko3he0mjJto+7Wq3OPamtRFTE34NcEkRqw054ggDFW4TZ/Lv0FbHy7H+/Ijt4sCst0SdPNjPRRvc5D7UxH3d6ojM8GvWsviLg4rmMUh+iA+5pPpymlDt6AZ8BeVXl3QuHpgoh/6zXWMwhTaXkqjp1HI3zWb/eQy+UpiyNVW8M1DCf+F8NSZQ6L3Vtpa3DGoW8n78UEAh5GOI2OVnnHPxEOyYNCGpubpJA1ThsqfxNAQkqCjcGJoLRzf1bZV1QrMcnr
X-OriginatorOrg: mmm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB5944.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 248ad05b-1f68-447d-a8f5-08df2475db4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2026 13:21:11.8588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: facac3c4-e2a5-4257-af76-205c8a821ddb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NpqQ1GIIKDG/1S/5l9cfer5cm3akRUvzyu2AmnBQq/sR2fVQWwbUn1S7rCJR2hM8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7110
X-Proofpoint-GUID: AfBNgG2wwHfKey7vtzVfCGU0lHf7G0AH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA1MyBTYWx0ZWRfX3VJtwmJaRpFF
 7BXyFsn9hqlvw7B76fY4K+Mo0pI4/Qtrt3PuoaC6qBgNV+wO9oolrPxRr9bt+FOjO5TtuVUuxO9
 zp2846EeToF6QBGtmwt651XADF2KVD3v2SyEkdYXVCrdVb6imLfi3AblTDdQPrZ8bzIS6SCs13D
 mtAwRyrKJc1TQRfvK3xXqLEGwnTtVopMJRB/PCXtqzl9JKDkNSZPKYjw/EmyT2YA+1jwFFGufg6
 gb7ZJl3Mvu7V12Iy+xYP15odjEIiKyqzlhp3t2x57jBg2XOh5FUcKt7b92TyTaGc3GY9KgIg8Ic
 gHrQrKs6lP57+y6nW1FofxxUmBm4aBA4ifUHOCZ6JcZoBw9RM6G1I9zCvfMgHD2CNe5e9RHwn/t
 0bNZ5jYn7PcIyiPQW7neXRqw2Ca6kCxuB9i0D271EGaCp5UzeXTvtLsEpC2zw0AQFH7+blX4haj
 0S77eMQAF0cnjogcdgA==
X-Authority-Analysis: v=2.4 cv=KKbPn1Fo c=1 sm=1 tr=0 ts=6ac6474c cx=c_pps
 a=pNE5+r34OR9oZdTVbUeSDw==:117 a=pNE5+r34OR9oZdTVbUeSDw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=zaMZgybHLTuKVbT8q-ld:22 a=xwsepRW8owwziKdWbztK:22
 a=NEAV23lmAAAA:8 a=flTH6UCbAAAA:8 a=A7YcJicIsup7aEF5nMMA:9 a=lqcHg5cX4UMA:10
 a=wPNLvfGTeEIA:10 a=9eB-evr0Qm0WS-MQJWAA:22
X-Proofpoint-ORIG-GUID: AfBNgG2wwHfKey7vtzVfCGU0lHf7G0AH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA1MyBTYWx0ZWRfXyCfXO7EWXKpO
 MqU+2AaH/Desc0VWXIg5k9iv88OSVhWkv8FYdtut5ryGdsglsE7vNSTCe2xgWboZEM1dxXCnalu
 GoPOeyULxjUb9cMo2PAShUNq8N3mjX8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070053

What did you do before the bug happened?

On Windows, a repository on an SMB share mapped to a drive letter
(P: =3D file://192.168.56.101/TestDir, Samba on a VM; files are owned by a
different SID than the current user) is used with a global config
that lists several safe.directory entries. One entry points to a UNC
path on a host that is currently not reachable:

=A0 git config --global --add safe.directory \
=A0=A0=A0=A0=A0 '//192.168.1.190/dummy-test/repo.git'

=A0 cd P:\
=A0 git status

What did you expect to happen?

An entry that cannot match the repository being opened should not
slow down the command. "git status" should take about 2 s, as it
does without the entry.

What happened instead?

The first "git status" takes about 29 s. Repeated runs shortly
afterwards take about 1.8 s (Windows seems to cache the failed host
lookup for a while). Removing the single unreachable entry from the
global config brings the first run down to about 2.3 s.

Timings (same repo, same session):
=A0 with unreachable safe.directory entry:=A0 29.07 s, 1.93 s, 1.78 s
=A0 entry removed:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 2.27 s, 1.58 s

GIT_TRACE2_PERF shows the time is spent before the worktree is set
up, with no git work in between:

=A0 13:43:00.798=A0 main=A0 ancestry: git.exe, powershell.exe, ...
=A0 13:43:21.973=A0 main=A0 worktree://192.168.56.101/TestDir
=A0 (exit after 26.2 s total, of which about 5 s are git work)

A plain filesystem probe of the dead host root from PowerShell
(Test-Path '//192.168.1.190/dummy/') also takes about 25 s to fail,
so the wait appears to be the Windows network connect timeout.

My hypothesis, not verified in the source: the configured
safe.directory values are normalized (resolved to a real path) when
checked, which makes Windows contact the unreachable host. The
ownership check is only done when the repository is not owned by
the current user, which is always the case on this share. Comparing
the entry against the repository path first, and only resolving
entries that could match, would avoid contacting unrelated hosts.

Impact: tools that run git often, such as TortoiseGit, pay the delay
repeatedly (our Commit dialog took ~30 s to update). Stale entries
for old or offline network locations are common, so this is easy to
hit.

What's different between what you expected and what happened?

An unrelated, unreachable safe.directory entry makes git commands
wait about 25 s.

Anything else you want to add:

Reproduced with Git for Windows 2.56.0.windows.2 and 2.46.1.windows.1.
Related reports (not the same problem):
=A0 https://github.com/git-for-windows/git/issues/5673
=A0 https://github.com/git-for-windows/git/issues/6359

[System Info]
git version:
git version 2.56.0.windows.2
cpu: x86_64
built from commit: cc4dbf752a05efdc0e04e71fd3e8110d11bdd35c
sizeof-long: 4
sizeof-size_t: 8
shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
rust: disabled
feature: fsmonitor--daemon
gettext: enabled
libcurl: 8.22.0
OpenSSL: OpenSSL 3.5.9 29 Sep 2026
zlib: 1.3.2
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Windows 10.0 26200
compiler info: gnuc: 16.2
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Programs\Git\usr\bin\bash.exe




Best regards

Daniel Gullberg
3M Personal Safety Division | Welding Center of Excellence
3M Svenska AB, Ernst Hedlunds v.35 | 785 30 Gagnef | Sweden
Time: GMT +1:00
mailto:daniel.gullberg@mmm.com





