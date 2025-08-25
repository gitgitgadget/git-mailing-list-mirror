Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718CA3209
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 19:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756149160; cv=fail; b=qymJ6ppXnNpQ5JSFUNzbxKovEaU0UlzlwhIfYLv5kpDhx+5TzDLGCueOD13MYnFC8X10WzTirhhidZ7XrNDAJO2M++LQqtxeWZjqoOX6mxyK2Tbrk2GcjZdKS1j9vOjEJ1wgMO7qSNEnyW60XRZOyDBCa+jDux3eKxwX3KKWs9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756149160; c=relaxed/simple;
	bh=atoXS7v++zgmjixAEbZU77hVOJS7Zb7TDM+/fksxSBM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RU3j8+OgpoTAFqEeM+uM6cSSyVFNSk5hReQ0Hpz+4SRAzD1Uv5DsAwqFLSsK7AvT1P7nIvfjFcpyQtDWqKmkzyFSMHCifpv+VXQpwTKW+01EEvEt4erGoVLjLFKytrqCmrs6EhuVWu04gbJfpAn7W2v8r9RSMcJY7P2042vSKpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=gby/1kG9; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="gby/1kG9"
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PEtlWh026148
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 19:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps0720; bh=atoXS7v++zgmjixAEbZU77hV
	OJS7Zb7TDM+/fksxSBM=; b=gby/1kG9xDAqeRqKCPTU09+GBC+WJ5ZSiUfdL8P2
	a9UOWCHzntpIPrPY0krR+JQgEiJb9+V5LUa8urzB+hzOo2eCsVwhpKsvraJPVuBJ
	FzdO1t2q0fnOqZPdZ7hUPQ/8a55vjxQZgczWMJguXM8xsI26FDm//+kftjIU7Jl3
	iZyjvAAUGh30O7DTgV+zNCZDsCse62f/NGM9rwUZt9b+k6Bg+KofiXz0z53wKCo9
	gzEgeQSUBCWOa20GIQq8ydNRR22D/oWcmaU092AxtVKsRBD13VpG+lJ/5ygCoUeV
	rjO06Aj4vlkDx3MhRGCPbDlH1BtZJpCkUsS39uovcLX/Qg==
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 48rt101wwv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 19:12:35 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 5FDB38003BD
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 19:12:34 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 07:12:19 -1200
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 07:12:18 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 25 Aug 2025 07:12:18 -1200
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 07:12:13 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+oAlRkdr21JcC34o2Alb0klidmKFaV/0T0jPA1vnbyjlQqCSe37k7NlDWkN7y2Xt5ZIDWYg6cv8PRHvgGTJc/vg4V+2uJUjLbS4fdIZ2pfDVH4e8BUUoxNAe1I8lEe2ElHW92Z8uiBDf0fe9bDL8yJv9njY56YLq7HhCxBqH4zXDJ60MLGSq6C838U8YP8aX9Yad5uztkAtjrAYjEm3+Eg4UWfWggjxhXdNomkX37P7BdjZgI4lDECb27SyJJXuZDbcpIl0xLfzqUjr7iMcsnD6L3THC1sC9uD/oj7k5lCrhTc3yxwuTrHJdhPnUm0gmG0LutZnd4akswQcdNe3OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atoXS7v++zgmjixAEbZU77hVOJS7Zb7TDM+/fksxSBM=;
 b=cMqRrJ94cWtqAQTekfZB7yREEZmBvzqbJxL2uVeMB+6Q2xRS2p0mf3QOddKWbteGzSaVs6XCN35BRjpurZRcpTSwRACCX5BUz0hR92ReHnJm4EduVWch7k8EggHi5fyv/EHOcEgsmCxp5zATPYXRr8Mk0sQk8mABA0wJcWOBrSBqjj425Hw8zPSDYMDrzPuYaWuJafqnjfi3BBjkuFYiYyZaZ/YPgoGkkBuQtM/XsH/M6oYfVcShDDJzda6kPnNiPOe7IA71gBBRuv6cDomadD+YanPFc3h3dc4HALtWIvfTGrMglQ5AR2L/G6YFFg5R30r+eg3xbwASSdd0dkT+Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from IA1PR84MB3012.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:208:3d4::14)
 by IA2PR84MB3949.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:208:4ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 19:12:11 +0000
Received: from IA1PR84MB3012.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::9103:d7f8:609d:1fc]) by IA1PR84MB3012.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::9103:d7f8:609d:1fc%5]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 19:12:11 +0000
From: "Harding, Mitch Perry (The weird one)" <mitchell.harding@hpe.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: I still use "git whatchanged"
Thread-Topic: I still use "git whatchanged"
Thread-Index: AQHcFfO1+iTQg5FbskeY786PAd3XEw==
Date: Mon, 25 Aug 2025 19:12:11 +0000
Message-ID: <IA1PR84MB3012CE550D803A3C3CC5572D873EA@IA1PR84MB3012.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR84MB3012:EE_|IA2PR84MB3949:EE_
x-ms-office365-filtering-correlation-id: 9fe5ce04-5bd5-4526-c2bb-08dde40b4afe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?rPhdYsJN4nIxCjukjZoLBMo9hPKlx57C8+UdFm/Mn1DiupotbBs5Gwu5PO?=
 =?iso-8859-1?Q?tHCK9oJAw9ahNjAafto19XxBs18KBe0Vga0IU+gYeEZdUq4v+KeVqHJBBB?=
 =?iso-8859-1?Q?uHEXx33BlyHF4r8rbmkk+5zxT/T/lI3w1vbVxUO2/VJ5I8/LcxDMaoS42u?=
 =?iso-8859-1?Q?gg5DLOkdSo5eW3EXVBAsOg2j0uODh8SV8yTQonKoFUP1u4gaN/J+wu4sEZ?=
 =?iso-8859-1?Q?IrXBQM4d2MjksTxmqv4mfbNyhXfKL+MyCj1hLk4q3/LhZMuP8uv8oDSkRb?=
 =?iso-8859-1?Q?z0S1RaVBqXrw6unz/5anBpTFSufDjYDs4ApSeOc9RejnD0bg+kTu6QDKpf?=
 =?iso-8859-1?Q?xbzk2k9MCl9EQbCY30ZLRByk1cxBznELjf8KINDJDJ1FCfjHYgiFxAREyb?=
 =?iso-8859-1?Q?dsO2jTTMaO+iVSlE6UXd/hPukBl+ayrw0yYNOKlC5OnZKiWiA8eWip2U0z?=
 =?iso-8859-1?Q?ROizEU6gzdIX+J+6TVk9ilpqwu1sMjM4UmV5N6piYzBI98XrvdrIWOhPyR?=
 =?iso-8859-1?Q?RDgYn6Cx+fQjA+irDWOeutVyj43p/mMhdQ0vxDWqKB+91XZVVaoODYKeBD?=
 =?iso-8859-1?Q?y+Iv9vpIHqrpxsga/lW3Y9ZEWTpOxlLd3BeoLGGP8H4dy5ivsEStBRNUXZ?=
 =?iso-8859-1?Q?KYiwJiQa8bgqpKYFVxdM+rFo3RtZvmyhdXqcC1OEJ4JAHBrYJJvmpYO3A+?=
 =?iso-8859-1?Q?8wFXN+NW5ZIkMd5lv6v5JdEIeRWaSvYfdwRnA9IZfam6y5NVIXLYQk8QGY?=
 =?iso-8859-1?Q?ENxihLQjwTAfaDw/MEXKN9dJQ0v3Xv57PMj/dTAamBxeqBxHwAYgieGqhS?=
 =?iso-8859-1?Q?ywo01sRftKJTp5NZl2sUFt8OQamG3JlndzeJ61Cv+RlfAJRuuc30Ev4rqM?=
 =?iso-8859-1?Q?N/JdZbEpWU8Tv9tEMp4qSXvkp+YVyfzNqNHmBVzmYfejX6YJdejqY0JlQ4?=
 =?iso-8859-1?Q?VCrEkTdR33rgzH1ktaroG/OT4m5WyPffSiKourEZcDdQLj7zooJlN8V/wz?=
 =?iso-8859-1?Q?4/7DywVBHSdiO2U9S8ac+OdWQN5MWtAX2A7Woi/ZP3ae8QhP/i9S3kBucQ?=
 =?iso-8859-1?Q?3mBMUts56Dm4eDy1KwhiiVt4zfZS+NeEwIUhGWoW3xvtM02exqE8m4YEnl?=
 =?iso-8859-1?Q?wmkLTwr0QGOHIFBzEdvxvSaKnObfweuYBzECMP8jy3BMuKWpp1IvVzai7q?=
 =?iso-8859-1?Q?LvPKYsR/7m+dRfqC6sjJnOmMh4ghAMd+ZsjtbbmQZw9hvowcjIWYar/EcI?=
 =?iso-8859-1?Q?QWC2gGufYcSLILiEjphCi9FlxOq4cA2KcT6UB4yCAr5x7C2ePsMX5tXqqz?=
 =?iso-8859-1?Q?gccPgr3A0HJzQe7FGxt7oJwT82SmHAZ5y4dYVYy2/3ARQ+ljsvadmY8aKH?=
 =?iso-8859-1?Q?S+bDq/CssbWDiH7p96vNI7s2eIztGVwyxIjeGjPM6rFGLJQQIOIFuH5gPJ?=
 =?iso-8859-1?Q?WDlvS+Yqg+z8zqZ2ik/zmdA8zxwubkFmiTrQK425WWIj3KcGjjYFvNbz0h?=
 =?iso-8859-1?Q?QTiZdzmpYJc+Gp1Q9rjpq5EwtfoCkkSV7bndsFpWzJfg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR84MB3012.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5+zpDQkh4eyoFKe+J7VpuM19shl7BpwCjllr6ySL2WEZ9BqS7Bhb7zlKgU?=
 =?iso-8859-1?Q?M6sKUXk+umJjnBg5O/1SUUj2sMb12+z1/9KxOHxgAu5ubHcu4Kk1WCZ3/B?=
 =?iso-8859-1?Q?kj12fuub4JF4WLjiCj5VZCyHHuGrCUjQZxo9LWn4c0uTGTwvP//Oimyw5I?=
 =?iso-8859-1?Q?kzjGFanmDd9TjyRWsm+kOM4g4d6qi34zun/I9+Pzqy3MfHLh6m9S4UUase?=
 =?iso-8859-1?Q?SuAB3PyFVXf+/q7p43UX+4zmBQ/LVDsmU5SGwbRSKtw5XzxAEmP93uhAFm?=
 =?iso-8859-1?Q?6z4qAy7m1OGt35O0H3EOKRWIVxBEMszoicchCPEXd46jcTfNNd6Z7SDoMi?=
 =?iso-8859-1?Q?oiZAo3Blr/Wfc/K/is2dlQiiSIG5VkD8bwychJ6wHyiwDE3bTypGpsX9cs?=
 =?iso-8859-1?Q?CQ0oC02olBJ69VS+H4AmO58eWapddsCN8NiQ5QopbTLsSMjhsZ9+bSumUb?=
 =?iso-8859-1?Q?NUGETyh7TjcbEhoAbbNAKyaVrCw0y9/vnpnK+MGzH2KN1r+0JQS3vM4n8z?=
 =?iso-8859-1?Q?FX0CGKhk6Mie9rWmxjy3XVNLz7D6ZkRUQoo23NTYmZyCMYtqEI64ES3URP?=
 =?iso-8859-1?Q?96HT1Atzi/wXBxoXyjStClHlw3fNSQQf5xzozH9KP5v/HIyXzVek/h+Dws?=
 =?iso-8859-1?Q?yccfLm5z05iRVV+ce4+KnI35RgQ55ZXvTInNTzFgtqIENxr+idWoMdNJZI?=
 =?iso-8859-1?Q?QO9rUPCMUUH/FC4NjEC1xbkh0yqElHy1eFenf1kFVvU61ocssH2umyHsJr?=
 =?iso-8859-1?Q?wdy76ubsgQ4tj6fv1o98TpJgHjkC4c+F7CDxINAScd07CU3JmeLtetft+s?=
 =?iso-8859-1?Q?U0LeSW5IRQo+Ty5/Y4ps0MvgwKgFEMnkectIYJ/wTjsYOkNBCRYlQKoyAQ?=
 =?iso-8859-1?Q?TsTg7JMYO4R0fcGj8YnSrHtOBR/qYM8El60iqhjD8uV+QOfLSDHfAC++U5?=
 =?iso-8859-1?Q?thO4qNS2Q6UsoF989uMTnE6jkXF2r7lIr2YZdYpyAohC0+omSlV93t95K6?=
 =?iso-8859-1?Q?6GTGlLKLBewYJQkvG90mXznxOu6D2EEtWmqpImR6h1na1AZiOcIcBGOSDo?=
 =?iso-8859-1?Q?Dgy5fBVVAeuMLH6pOEibBqRG7nmhas/rjpnXuRF8/z2ruhvb59sENkaHdx?=
 =?iso-8859-1?Q?Rj+Enh7NN5WeDsWU5dYeOiNVbhC2fMfL7jIKxOTnvmtM/BA9PzprNsy0qe?=
 =?iso-8859-1?Q?3Pnm6qdT6IAfgi1pQUrvq0sF5eW0kwYH0D65n4krx77oDl4ll8TdDLYMHP?=
 =?iso-8859-1?Q?ctl3em/5fj5s4NwvGYFPQAacrwKEY+aFISamoPmkCtZQV97kJNV1AqEdJj?=
 =?iso-8859-1?Q?Hh/Bk9MyEZlc47TobKFKRXkky/xughY0XSflKt8aujNDvLINK2iuFZKDuj?=
 =?iso-8859-1?Q?m4/gOiP8KiTcg5B7X8NZxgm0Dyb+SIwA4EDYtoa4Qn0sJsME9Gka22Ceia?=
 =?iso-8859-1?Q?BQUBdydfjYg+9zB0+mu2411h/djBmgM2sc8UZMM5KV/IlA5jLtiMp/z0/i?=
 =?iso-8859-1?Q?bPxAE6FrbepOPgIgNtajVmo+mECXRw9WKu2apNDF41ZAJkfUULoQq/4hdk?=
 =?iso-8859-1?Q?8ibFR5G2fsjSbAsm0UABKorY0A52FB7OhfmOGjmQutEOLcwaKkdhStuLjv?=
 =?iso-8859-1?Q?kflyS5747DE79Bnr/yCoAUth8frhqQKTHs?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR84MB3012.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe5ce04-5bd5-4526-c2bb-08dde40b4afe
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 19:12:11.0360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1PDhwKij/KRiVdrSIG6z9D411j7gsOqITwcfZhL3ljImpfSTlK48Jr99MppwtWDnF1vyzEgRGP0DFRQH6BSuwY/XrxuAUGsqVZeN2lupARc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR84MB3949
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: fR3KacufN-vINpwi7k2RBiF0Af8ky8Mt
X-Proofpoint-ORIG-GUID: fR3KacufN-vINpwi7k2RBiF0Af8ky8Mt
X-Authority-Analysis: v=2.4 cv=CpG/cm4D c=1 sm=1 tr=0 ts=68acb5a3 cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=2OwXVqhp2XgA:10
 a=d3YzHw5hJDTihnFLL1IA:9 a=wPNLvfGTeEIA:10 a=ZXulRonScM0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDE3MiBTYWx0ZWRfX+LfD6ZhVBnyS
 s1XdOrecHGm0PkSp3a56RFhurvucENPHgKqMhE4o86bWYkqUoocPia0GpmPWwJks7Q8rXNrGX0k
 +QuEAmi2pRlADfgMhOyoPIRFX+GI5dGCAlv2SN+PRT3G89rcABE1h/AGjGl+x3wbZ9UxtJj6LkP
 f2EyGYAwtIl5PHrl08Tlymh9CN0YFT/WuhVjXuvPUPlRMKD4JF5SC/lgH0dlpPFX7ob/sjRODhh
 ywiJ7CZsvr+by/9s+2Hak2Rz+KpJdd0WTdYB2gWY3N+jgaf6jktj7cBIO7/cnPx1mNF7tMknSZs
 FtWx1hq0NTDcUAVNyXhNiOcLm7ZEdPyXgEGi1iksmzNbzgvMOJ84dPcHukU5E4+PW40NaResmje
 s+NIKEnwHYk+H/JrhqV8p1suRiMW50WbTgQYAmtVYt81S+QWz3/COiZxPUDnrmQkB16pn7Je
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_09,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 mlxlogscore=385 lowpriorityscore=0 suspectscore=0 mlxscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250172

Sending this email as requested by my friendly git binary.=
