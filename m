Received: from mx0b-00013f05.pphosted.com (mx0b-00013f05.pphosted.com [205.220.177.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2023D329E4D
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762274589; cv=none; b=Iyk0nhI3XtUD8n9WM3y3mkWrkveBdJ6JZBYtX+l+b6Nq1pJEJhFIgk5ChrzcuS5LhbXnMJRE2sUI/aU5RzyRoOk97sczl7cmMNLuanuZO55ZsRoNwdWycmhjaQbNweLpOmsT16KU4MM4zeVDZzct5Hfbh3mMYZOjmhtwIUf4WdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762274589; c=relaxed/simple;
	bh=JxYytnPiKHV8zhUWchoMR/o90JxAo9GOhGSEw31Ce+I=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qPeBIDMw8c41CYNRbhIbirxznudBM+lSFrtRPEh2FL7aoEZ9nhJH9tl0dYZsgFxomQ/BJPqPWctr9oxgbcZfY1Pg1CBxUBwUUJxECKQSr3GsbPQovjotCevfvard6+xakpfvcvp/vUN54bzeQphNNRJje6f7aIslBuw9j8lOMV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pfizer.com; spf=pass smtp.mailfrom=pfizer.com; dkim=pass (2048-bit key) header.d=pfizer.com header.i=@pfizer.com header.b=CZw85X0c; arc=none smtp.client-ip=205.220.177.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pfizer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pfizer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pfizer.com header.i=@pfizer.com header.b="CZw85X0c"
Received: from pps.filterd (m0218832.ppops.net [127.0.0.1])
	by mx0b-00013f05.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A42DKaW024825
	for <git@vger.kernel.org>; Tue, 4 Nov 2025 10:59:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pfizer.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=00013f05; bh=JxYytnPiKHV8zhUWchoMR/o
	90JxAo9GOhGSEw31Ce+I=; b=CZw85X0cvYFW6/YJB69ZhUAagGl+kd+lypr7rIi
	4gWxtAb+kk73d4tG/p8EDs2FO9kdLxR0xGfF+bzj4dVuvFc9i9VVBZYUMzjSV1/k
	tYtgDkJDhNNs04jupV3rJHYkaroFIv3QX98pCijz6KVpImhG74tbGRj0STHCcpjF
	8PE7czuR6L2dLDqfePRPJ8w8Gll7ehrFC56X0p0ZDUsxNnnSxn7vA65Fd1+IWisO
	RZvKtp1CAHmZkZ9CQlFrfgDNOZIPedzM/90HizGISdTgmXYuZ3yR8KZgtYu1JDpe
	iAYX2zg339f5gBdcJEJz9t0GKOr6C4Ec4rcsqJqp8OPFVlw==
Received: from mopmsgo.pfizer.com (mopmsgo.pfizer.com [148.168.100.84])
	by mx0b-00013f05.pphosted.com (PPS) with ESMTPS id 4a5e452vk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 04 Nov 2025 10:59:44 -0500 (EST)
Received: from pps.filterd (somamrppa09.pfizer.com [127.0.0.1])
	by somamrppa09.pfizer.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4FrV7f008835
	for <git@vger.kernel.org>; Tue, 4 Nov 2025 10:59:43 -0500
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012030.outbound.protection.outlook.com [52.101.53.30])
	by somamrppa09.pfizer.com (PPS) with ESMTPS id 4a5yumyhc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 04 Nov 2025 10:59:43 -0500
Received: from MN0PR01MB7611.prod.exchangelabs.com (2603:10b6:208:376::18) by
 PH0PR01MB6101.prod.exchangelabs.com (2603:10b6:510:12::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.7; Tue, 4 Nov 2025 15:59:41 +0000
Received: from MN0PR01MB7611.prod.exchangelabs.com
 ([fe80::2b01:e2e4:49c1:161e]) by MN0PR01MB7611.prod.exchangelabs.com
 ([fe80::2b01:e2e4:49c1:161e%5]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 15:59:41 +0000
From: =?Windows-1252?Q?Rahn=2C_Ren=E9?= <Rene.Rahn@pfizer.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git-add ignores exclude markers for ignored files
Thread-Topic: git-add ignores exclude markers for ignored files
Thread-Index: AQHcTaOoC81dqWFyW0CtTXag+DsiQA==
Date: Tue, 4 Nov 2025 15:59:41 +0000
Message-ID:
 <MN0PR01MB761143093D1A4D226E8883A380C4A@MN0PR01MB7611.prod.exchangelabs.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR01MB7611:EE_|PH0PR01MB6101:EE_
x-ms-office365-filtering-correlation-id: b95c723c-8336-4a6a-1997-08de1bbb2a2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?rNEaUjP3NMN2LniucyHhLP4NTa3OoUQj9y4Olkl57SULudJM+cXaS/nB?=
 =?Windows-1252?Q?Xdv2WgO+wDcAcJWqf3mKcvO7KWSl491MCkux4gWoiZG8OB4tanX4Fov9?=
 =?Windows-1252?Q?rppoe6swBbf6GYw/0VTwlxTOiemBbFa3COeJ712tljbJU4+e8KCbqEwC?=
 =?Windows-1252?Q?4a1Ds/jIi3U9h5MAoUvoo37JrjVvfXNYmUnsQphiIwibP/K9jOgUWZyp?=
 =?Windows-1252?Q?nm2wAC7h6KgaGWFrpW0585ZBiGj7Go8lxu8o7R7qYhE6jq0np2buIfge?=
 =?Windows-1252?Q?T94mL1jmq08IzHa3aHpQYEPaM+e/b88rfvqihDK+y80MBh0bXPvzzDm8?=
 =?Windows-1252?Q?jqa/JEGwKYr0DLprgoCJZ7aHHgSxx489Zsik+LChXErLe05nnkt2sWDG?=
 =?Windows-1252?Q?lkPkl9xQUaiCzaalPi77cnXit8IXfbN6p3UHnidEc6I53GrCQI07p/Qj?=
 =?Windows-1252?Q?heGPTWjx4mZ4PorCX9LwkeE2buw6spQzuGvU9WqfaUwgHgb6WcT3KO8q?=
 =?Windows-1252?Q?gdQyyNcktqjRsOYODrtKV+gXuu7WliYr/KN2Z9fpy4wgAfdCME9Ha+Ao?=
 =?Windows-1252?Q?dg6SPjP+8CZpbFvUmuuLCzyDVUF81dhl2n7Kjw9RQwsKFI9djxWjAyqR?=
 =?Windows-1252?Q?PAQUk6GGVKB/aaq1uIKf5K6DXGpo4ldXAu9ttMCdrZzY+Cy2Hb0tJj7U?=
 =?Windows-1252?Q?Jsn1aTZOPXMvjAQUznztYDfKYW3T40P1m2KkWNR/AN7hDZplNt+Lw0gi?=
 =?Windows-1252?Q?Rkkr41YXXDOXP7DT9AzFMRA5IFTSAmdKLJ0yacrCxKGvR5Fqa0XyYJLj?=
 =?Windows-1252?Q?BTVSE86FoJMkdV9z3qi/FuMeAjIBAungXzuhQaHKNPo7sj4VfDhotm/p?=
 =?Windows-1252?Q?92Ic24lLIW6kpk7uXBmrAYgIkNjv4qqUncn4lFkgmydIZf9mXp1STWV9?=
 =?Windows-1252?Q?CLAuUxZNHLHCPq6biKsgJKkYwELTATge3iu2qikUEoKI4U/UQ+pb3a10?=
 =?Windows-1252?Q?Mp3yRoIBoh3CVYwuXbWNQh3BtGxsyxeAUM6CBPPB2pzEltIvCAFV3NWd?=
 =?Windows-1252?Q?uSAmL6VM/auy9poALBsGpzaHZ/Uxp8FR1KY45Cq0JQFkkG4e6ZWQ1oTt?=
 =?Windows-1252?Q?0W0FpmmZiwFUeO/hJcTWDg7MQyO4iKjPEh3+lBxGfIKnZ1+3vXbEP+sX?=
 =?Windows-1252?Q?t8JrH+xAz9gm8+xXz8hxe2+HmBM417olIy4kn3IuIAFwHjEgUlw5TGWp?=
 =?Windows-1252?Q?MZlZ9+dqxWFfkLoRF9Il1b01lbjGXBtg3gUC0mwFmFGbyL2d+ipVMBKq?=
 =?Windows-1252?Q?pn31bTJKoIVo+kPfukmpLhhvb/kdZDgWGn/o5HJZLn7taj20/frU4/8Y?=
 =?Windows-1252?Q?odAnk/47OPWnckMUlenKN203VyOUk7WyjcUrDm1LYDWzlHnmNHnSm9iF?=
 =?Windows-1252?Q?gtb+s3kI9mAsRkr3QECP3Z9d3DZ0XVDnxiyWfGPAlEvWNG7pVFHDN+/C?=
 =?Windows-1252?Q?RWH8vpMBSeaCW2+de3GnpAPhAvmnEbxom6vc53TjChQufbPOdnaeAbcz?=
 =?Windows-1252?Q?AZ4CjOSKFJ85OQPVXZJt1b16ag5XYq4/SxMpxu4M5lpAHIyBDemRfdAv?=
 =?Windows-1252?Q?xFegziqSMq6MM0XIrSoEkdoc?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR01MB7611.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?GDOoKjmd3x3UfMKl5N6f/Hr8cfX6ZBz0NA95t9tR5KjahS6qCQ7Md6Gl?=
 =?Windows-1252?Q?hlMD8oLRCvy9GYSlF08svMoJMP/26PYU1JCuGDEC6vwqxafSPKdQI1Y0?=
 =?Windows-1252?Q?stBzOV87FJ550efjfsIwvpG8hhz/9kgToW9jbIVEmqcoJziIpTD0DOa3?=
 =?Windows-1252?Q?w2GT+mpr/mfikUc3dl5u7bB/vn3Xg+/fLiqQ4kCYMKjx0YTM/WSigQuI?=
 =?Windows-1252?Q?Y8uLPpKi/BXXnq4ipfpAXRJIyGVyy9gq+HwFcGtQqmpDdMtEZt0K/Cgm?=
 =?Windows-1252?Q?sKoy7+cmjWFhKO87sIbfljFawAUZULhhaNxTtNhvg82YofGPcclanzR3?=
 =?Windows-1252?Q?7e8cevesYcI7Zf8xhEXMp1pVvB4FZ2daBKe7i+Ubng7mXWg3oTSiEqU6?=
 =?Windows-1252?Q?QXQ0ZL0oq20Hcfk7nFYQEwq8pKZw9/zOWmHOjXtKTsn9zZVXzLoFRzes?=
 =?Windows-1252?Q?CA9fkTK9k69T7ix7f87fMCl0yVBHrf7VC8/xcEMAUsSaLMugJ1786RyJ?=
 =?Windows-1252?Q?e5Cbmy+UgPUy94dr01M28X/vYAHs2PwlB+MF64u6HnoRaErzYyFN38xQ?=
 =?Windows-1252?Q?td1Y+FrbA5L1ghmU4A7q8Jro9qKO6gOgEy7Cccsk+YddIJmt9fAvQz8F?=
 =?Windows-1252?Q?uQi5XKCnaMebgxlRR7UxNs0jrwC+6q2RNl9Dl+vSheIW5UVO5nGxgbyC?=
 =?Windows-1252?Q?B9QOlOsnr1ZrsyDHmX50R41m4Z0zlbYS+wt5PTIqESzBbMXP8sU4y0H3?=
 =?Windows-1252?Q?uH4htQVg1Tg1iZdxKg9WID6Ea0JsSZ9NJIn+JBBFL9ilM9M893zC5BhH?=
 =?Windows-1252?Q?pW8ufFkPKglAsy7rvwkiYir64jg9l2mul7tnB29DBDecaOK18mg63khX?=
 =?Windows-1252?Q?VigsNO3oE9N5FtRSxDo8/c5gai3ZS1DUTYOZ6FhAfiJPaxmB5UdatU4n?=
 =?Windows-1252?Q?PQRT9vibjwP2xXbpdoIZ+eOiI7BJovyrF8G/y51egp8g2wzzI62XBiMZ?=
 =?Windows-1252?Q?30V4YJIiEPG7kiQAJ1ASP86KYDKs6szUc+xzv7wHirnAXewthLMVAgoI?=
 =?Windows-1252?Q?r8BbA4u/afVfNW9uqha4MzyJ78RYAj90tOnbSGEuIUuYTgIXpqsQsEwB?=
 =?Windows-1252?Q?2vkFwOUKkcsNnwBlLJ40yJprEYoHKH2fUuxOhT9U7BWcMHReSyuuYVU7?=
 =?Windows-1252?Q?84z3j4uTdNCLO05LbCqztcdHRl2KdnooftopQYcoTbROtd850Q087K0S?=
 =?Windows-1252?Q?NrcWQG4FnkdN5FujOHgPnphH+4xQy7A6eCWa0IlpCvrNp18nGFyuXONm?=
 =?Windows-1252?Q?VZqWBJv8OCgxWL25Djcwg57MK0g6Ilp7yurBZYMEvgmiEWqVgIYSqZem?=
 =?Windows-1252?Q?LtBhHTrZpLk9YAiuAu9jKSlMY9NTuNWRapqwu+r1W63ate1BjO54lhH/?=
 =?Windows-1252?Q?AF9TL8UcfW8DyUa9+vRolC6QpsB5DV77+zXBzWTGL80CgimW/Z3ttaMA?=
 =?Windows-1252?Q?2hz0bF/xUwYWyKgKEBwd+86Qf4P+vZerfAJLG1MZ64s8FnLG0HHh1Mfl?=
 =?Windows-1252?Q?HRVu9nJunsMr+pF9iSN1PLRAYGfYjco9zcdYiFLhMVYt99ET8iWnlUQn?=
 =?Windows-1252?Q?C5Sbv4/BwtNlvbDFLjKKoNOe6kERhedjDkALrR/xRCQpsRxiVd9jl/2g?=
 =?Windows-1252?Q?o6rvr52sG8g=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Pfizer.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR01MB7611.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b95c723c-8336-4a6a-1997-08de1bbb2a2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 15:59:41.2978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7a916015-20ae-4ad1-9170-eefd915e9272
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pa5kjSV3b9Aen6Wo5ZZj5mMo9Ald15g0PTTuRepcM/wYSJL6dH2mktiUpPJhNJGFa7Al6RsSA3seFfS4ogUkHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6101
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_02,2025-11-03_03,2025-10-01_01
X-Authority-Analysis: v=2.4 cv=LJ1rgZW9 c=1 sm=1 tr=0 ts=690a22f0 cx=c_pps
 a=VjW+4JwRbjZMNe0nr0uk6w==:117 a=VjW+4JwRbjZMNe0nr0uk6w==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=N659UExz7-8A:10 a=6UeiqGixMTsA:10 a=w3-n6PE4KX4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=ly9rQsxkxscU82s04gIA:9 a=pILNOxqGKmIA:10
X-Proofpoint-GUID: 6OoqSxPRf0VKbMpPmgc9RKFubc7cca-W
X-Proofpoint-ORIG-GUID: 6OoqSxPRf0VKbMpPmgc9RKFubc7cca-W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDA2NCBTYWx0ZWRfXybHH0t02GlJ8
 cjnK8wIcVDq/EaCkskLdbx1vRyFfzymg0+JO9RmYjXOmZXcB+HbU9Y1pPfhEqKER/+PFFvGwcmz
 NeFHAnOg6YACz4C9mEkROG/iNU1deoLnFWWXP7SFEwfpKSPTuRgQPzqKRxr0LShZvOff7Irkgwd
 0MMlVxWU/UOnBFxoVRZZotL1N3/kJ3Adx6XTTVF1tNZ2ok/29BJH55slRI67l0wiat4sY5dCnTu
 x4iTb2RuIwZz1iHnikbrdviln5TxiXjeVzgdPxQyIeGA7MG2qAyCrwViUbtFZ3z71E8GsyyAHxu
 ja0Byj5CFO6HCmRSfNr1+/iS48gIgzAGy7B89YLtwXi76RDnUcvCpnyO46YJ05wqOk+lN5EOetf
 7yaEpEx6Y9IpbKJ4UJTMfTmIlmvf8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_02,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010064

Hey all,=0A=
=0A=
I=92ve run into a strange behavior of git-add that I believe is not correct=
. I couldn=92t find something on the mailing list regarding this, so I am w=
riting a new mail. The issue is that if you use git-add with an explicit pa=
thspec with an exclude pattern of a file that is ignored by some .gitignore=
 file (locally or globally) the git-add command errors with the following m=
essage:=0A=
=A0=0A=
git add --":(exclude)ignored.txt"=0A=
The following paths are ignored by one of your ".gitignore" files:=0A=
ignored.txt=0A=
Note: Use -f if you really want to add them.=0A=
Note: Disable this message with "git config set advice.addIgnoredFile false=
"=0A=
=0A=
Steps to reproduce:=0A=
=0A=
mkdir git-add-test=A0=0A=
cd git-add-test=0A=
git init=0A=
touch .gitignore=0A=
echo =93ignored.txt=94 >>.gitignore=0A=
touch ignored.txt=0A=
git add --=93:(exclude)ignored.txt=94=0A=
=A0=0A=
Expected behavior:=0A=
=A0=0A=
The git add command recognizes that the file ignored.txt is already exclude=
d despite of it being ignored by some gitignore and thus does not check if =
it is ignored or not. It simply will not be added. =0A=
Note forcing git-add will do the trick, but this could also have side effec=
ts for some files that are ignored but not present in the list of excluded =
files.=0A=
Hence, this can=92t be the right solution.=0A=
=0A=
Any advice or confirmation are much appreciated.=0A=
=A0=0A=
Thank you=0A=
Ren=E9 Rahn=0A=
