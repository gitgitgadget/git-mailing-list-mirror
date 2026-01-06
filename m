Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012025.outbound.protection.outlook.com [40.107.209.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F28122A4FE
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 23:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767740619; cv=fail; b=VdVEsaM4r6rf/gcaa+F0wISkrRjmgaW3LFlCsYH+k2sBZiLzyMJCnveCxP/k9SitrMtJYgKKA0Qyvnb6/1SZmyj/oBnX8KDOlo7kCBPjmUszxPauGSoCOvnXPCHhcBqUMqDyn/wTa9bj5Ab8PIjqJoqvJsLJuqFfFQYQhyPCqMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767740619; c=relaxed/simple;
	bh=P3yARxucd35sFTMs55twcLhsz1/IgajI2dQM1jaViw4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qd5FI4K3XXTZgAnqILTKKhpigIoo6sJBFSn4CRh8EpRotGFUYstN+fbD0cfBut3J7ltkTo8Cuyw/rx77IRtECppneByyiH+ZNXm6luzCC9O/jUy+RE2jL5CT2qmfahQJHT4HdUpxT+Xy7rWRF2+K9AF4AXccrUSIMtyGWFWZF8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eQa1RGsb; arc=fail smtp.client-ip=40.107.209.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eQa1RGsb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UASd9xAn9jJsECtP/DQlLif8bZnthMku0U2QIy+eoRJOGqtQ55YKROqzqdi1ustBrD5Zar8WADRdNM+7x+CHVceCfBgWFCYqRioN5gw44v7sT8wxVPNxUETXixnAT1qCnLdsWA8MfuiOI1VVOKQsyIGhuCKn/aycQPt6g6iilQ2jMqutXkB/pseseeCszPLebH1veXIYccKa6Sxqs0+Tgniw2ttbKgS0+i7TF6tU67ALIPedS8wkB2KYSe0J3riwFjZlXIg99AdEuTKs5S9NldBCgK/09sTPn0MqDwkzfrM5gqkN49tKDQ0o4QRS6UtX4ySjOweFhPCqNDjcU20bBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3yARxucd35sFTMs55twcLhsz1/IgajI2dQM1jaViw4=;
 b=UKBZ4Th2wS0gJ/HJgY48si9K5GL5WZVlubvoimcedFMFsjYjczg2rff4fUQeVpdJ+vrJjr3qzcW7JN7JbFCJ+jPNAS+sPvDyM1V/Zi0NNvJnsBUOJDkN2VYtJWKTTLLhXvrEhu16GUh1S+n16PKgdHiL/1h9MqUKATANCAYq+my2A8jgbPtCds+rhuKepQUHMCS7hEOczaRedbE/w+UZmKInSq9AOATtDB7W75KVGAbUVyGDo9QTcUEQNG+QnkzK+I3rRgX1soDkMMRw+lJfYPlpWgH2n28OrMnTvx9uVswv3PUSLAVmQhymOultmmAghGdGGTf/oJR8SPggYnwt7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3yARxucd35sFTMs55twcLhsz1/IgajI2dQM1jaViw4=;
 b=eQa1RGsbgCFVEVyxDtgVyUBhReDrQ7R6wRY6+syBukIHF3gUTHxKluhiVRNKBmgeWgV6h3X4STv2M5kUv5WkVlpwrtDMMkmRKGc8Swyz86fNJVjMVaCy6Y1f+j+lo8I2QS4N+cJO1Fdxh/qUSTk0sfrwqLiQCo8YuGHgXPw2lI77Y+E3NuRVgqJHpI7TsGPrfC/AFUY7lARaleXui0MPi3yHF00xIzYlkCEXZhdT6tcyI9q/wzkMba3EZpLOnwK8M14dzopq5B3+SRq613NrUxzkGj/haJGfHLUZn0qKDq7oeUgzzCw3HqEos6Dy7F4DUby0HxaMyuPeMZ6TXqeaPg==
Received: from CH3PR12MB9026.namprd12.prod.outlook.com (2603:10b6:610:125::15)
 by DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.2; Tue, 6 Jan 2026 23:03:35 +0000
Received: from CH3PR12MB9026.namprd12.prod.outlook.com
 ([fe80::7e83:9747:5352:4af2]) by CH3PR12MB9026.namprd12.prod.outlook.com
 ([fe80::7e83:9747:5352:4af2%6]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 23:03:35 +0000
From: Martin Fick <mfick@nvidia.com>
To: Jeff King <peff@peff.net>
CC: "brian m. carlson" <sandals@crustytoothpaste.net>, "git@vger.kernel.org"
	<git@vger.kernel.org>
Subject: Re: Slow git pack-refs --all
Thread-Topic: Slow git pack-refs --all
Thread-Index:
 AQHcdebABRaVmXg1XEKj998vyrImTLUzA1gAgABVq4CAB+sE2oADSLCAgAW7ve6AALzQgIAAoMFs
Date: Tue, 6 Jan 2026 23:03:35 +0000
Message-ID:
 <CH3PR12MB902640F983E7FB0FAB92D404C287A@CH3PR12MB9026.namprd12.prod.outlook.com>
References:
 <CH3PR12MB9026B5872FD42F031970074BC2B3A@CH3PR12MB9026.namprd12.prod.outlook.com>
 <aU3K9lGbHw68Vv5U@fruit.crustytoothpaste.net>
 <20251226044507.GA1971832@coredump.intra.peff.net>
 <CH3PR12MB9026DFCF7AF4ED1A249B16A5C2BDA@CH3PR12MB9026.namprd12.prod.outlook.com>
 <20260102074901.GD2581074@coredump.intra.peff.net>
 <CH3PR12MB90260C4887067C88629BBE52C286A@CH3PR12MB9026.namprd12.prod.outlook.com>
 <20260106103803.GA69061@coredump.intra.peff.net>
In-Reply-To: <20260106103803.GA69061@coredump.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB9026:EE_|DM4PR12MB5963:EE_
x-ms-office365-filtering-correlation-id: f39a4ba5-8cd7-44e1-af63-08de4d77d228
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?8Te7P8RayHR9AM+BWE1n0ffQVCJXxbyDqHxrXAGKevsj4UiBwspCHSyLQt?=
 =?iso-8859-1?Q?RKIFOG8M+ecVW6vTAkI0hDZmXUQFnLP4Xja/4b93tJ+e1s0r/BMTAHc+7L?=
 =?iso-8859-1?Q?nZpF0Eox+s8vMr0XRPSpwnJDVa+JV7Vf9nJygZVR2JhRPnSLxmXGAo2fwa?=
 =?iso-8859-1?Q?gxjntaEzseYzvGErsFdWsyUsKEStmcp61TyQPJXxKXVBWlxg53Cya4D7k1?=
 =?iso-8859-1?Q?q9emmruxJQ3Hi4tEFWQJ+RdwwQadvxaNa6y/U4uFr2Ed0vQYGEsiMYZYn5?=
 =?iso-8859-1?Q?E6jHbkWGSzHH5556rD7JJH0NFhJVmZkYTlL9VblXYlBu89uyAEeFSVOtG5?=
 =?iso-8859-1?Q?P1aYdKHWvLJVjvqTX9R9qJpeDGxm8epVJHBbQeLtZ+b3nAN26A9GNOAODp?=
 =?iso-8859-1?Q?35/qa/MfEvH2qyZduu8fNg/PB43uaTBfYB1sOj0q0OA3VJ2cLvHA7M09J+?=
 =?iso-8859-1?Q?t5EtRF1osITcVrIRzdm0D7wM6ymBJK9l/LyKlJRLpx7hgo2sEvb3smYzWw?=
 =?iso-8859-1?Q?l0KzSvwV0s1nOVyqv4mzpLyeQtg7OuBQdDgTWhH/pkLniXlAuovaxKIzHh?=
 =?iso-8859-1?Q?bEaj7HiNSqJCXrzCeXXSA0o0t6qiS8pTdOXxvxgCVJJiRpsFdEJbeTkBqj?=
 =?iso-8859-1?Q?RHFAtBuYBxvaZOM6OVDtEszdNP3EIixFfCBTH9+3nt5VHDSH256Z6QIpjT?=
 =?iso-8859-1?Q?elYwCsFFPPrhUuzY9HyWBwlEhMn1XB18w1Pdvjl28OU4aGN67K7ZIpimGA?=
 =?iso-8859-1?Q?S+385tjBs22G4HNeKatG6045mCDQKsLz+NrGISRBdd4uiwolggNx76vJqN?=
 =?iso-8859-1?Q?aYxP+ou28SKKxY8SFhcEGGj0pYL96h7nntBMkHd+ElZU9Ap1K7CpeRwnfp?=
 =?iso-8859-1?Q?4W3YCKJj4VOemhYgUEKP1oEb53mzyRLo7YEOGmv+rQYFA3KIpu53LLDi+X?=
 =?iso-8859-1?Q?IGrR/48i+y4IGZEORf5NfdFKdrlMmXmomi4AsgQkvFHE8r/aKQz0+fn1Zc?=
 =?iso-8859-1?Q?lsphg6lC/AiQG1WK+DnzZfgZRv2/Kf+otpbHMYFgI+IjChQIKVZ4xs8ABM?=
 =?iso-8859-1?Q?/PYpe15PIN12aHatkVEj0eWmMsw1fa10ME6nk7B4tWpV+69nheOyJ8if5o?=
 =?iso-8859-1?Q?3wM+IvCfP1/7BaBxH/lO+cd5unMRYnYHIpQyUU/yHGNCuFNQpNycGx8wT0?=
 =?iso-8859-1?Q?XOC38Pcvi14l4PowCVecf/TP0JeacS29ENVq1GPIuJEtLeTvXCjUbSGek6?=
 =?iso-8859-1?Q?gp307XfPbHOWfjBtXJDivQMcz2YH3VI+2H1pMBPY/oNdOC27kxRqKOTeVz?=
 =?iso-8859-1?Q?TcGJRLTMw7f6uMhJgN1AXkCUnL8RN47JfQDW94I5Nkl+vMP4iKTVqrz0Xi?=
 =?iso-8859-1?Q?Y9DbOBoEgts2/IHdSltxJlWz5wiQ1GFLQ4DA1iMi83+AS8WKcNzBe+/xTc?=
 =?iso-8859-1?Q?vgwMgmLRk8/QBJkfqOWB30bCVoRtBzQ10a7agHHyFs2W2KHSTN3albLIcp?=
 =?iso-8859-1?Q?WgfjS16CDJuYEPFhJkc185a8lnpgGrMQ705rNj/NiWzRFbGfBwhRFghGJI?=
 =?iso-8859-1?Q?5c3SChV8/7dFm/2DVGDezX02T2na?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9026.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?hATJ57P62Qzmmbv4HsLis12lV+OuY5bgG3wa+dKXNN0l6mSOpAoTWb8Hrq?=
 =?iso-8859-1?Q?4blHByEtVL/gKJYY6W/a0NLbGDDIdzqnZn9NphvXBjdUwdAVSmxk0CNa/m?=
 =?iso-8859-1?Q?gUs630BbYEER3zVuCm1S6R53iz7BpMAoX541RY7ObaV3wDnMJBkAZFNStc?=
 =?iso-8859-1?Q?hKdU8HwxDBTemXQBQP/y4pifIRm7lYnQyBrXI+/LjV49vMCX2U/yC9KR3l?=
 =?iso-8859-1?Q?64UpebyUrJj+Ej2GvpjefJue6ujx0pfeJ4D59c06mnO9FT9Bkn2ezaZ5JY?=
 =?iso-8859-1?Q?m7ZdZ3xiFsNey6ThSBUjz/evfbTQrlKar08f+jSe5wecO9paHZhbsQnroJ?=
 =?iso-8859-1?Q?WGnPwtDP4kiKshbJ/0FLfP1bh5UoA4ARuASa4iRRRc9J5bOaRZ0Z5pJXbd?=
 =?iso-8859-1?Q?9x4aKVd5BZ5x01U4FRgSlryyNhHu+qRsUL04t/rrhPhykPWj9tJkpaEXK0?=
 =?iso-8859-1?Q?Lia07vSxrgggekNkho6hMh6Ayo6uvuVxJevze6UYHbNnyP9XpRFZwMwIox?=
 =?iso-8859-1?Q?NZ6HuBtPkFNRr9S9GLHJnVhvRVfvNNTYWAQEwzKV3sjHzvUxO4oIB0spE4?=
 =?iso-8859-1?Q?J3GcIOySmxXoD5I7xGTwh7I09DXv2/oJ4EGTTB/MHhDwvpPgVYkbqC3ukO?=
 =?iso-8859-1?Q?XBA2tURvOd6GGl5wozyc3cOM/rz1IVYlJ6ZBQ3KaV5zfNbNaVfoTYqVc2j?=
 =?iso-8859-1?Q?GYVjJvRR9maWrUBw4yIS7gd9L1JhbGkCGYlvG7vhfST8DgGXr9tsl8pWTW?=
 =?iso-8859-1?Q?3LpvMkYG47ZybqWN4YJHK2viVVwK5+jHy3IYGluH0Fp+MCgJh+F2WX18re?=
 =?iso-8859-1?Q?QtudtFKgndE00BgYPJzwAlojDtZq4fjXLsTtVCgLa511CC4VccW7jBVqXL?=
 =?iso-8859-1?Q?ypB9BNx0+/zbKgjiZzMhdZkbmjHnTElG5Op51zvpaeP/LIet+VAl2EJYmI?=
 =?iso-8859-1?Q?Vr4I1wEaR8Avl3LGnK/TWM7DqdQOd2ZL1ViLPjJLzuK0HX21PJf3b6Revp?=
 =?iso-8859-1?Q?/CE9IO+WZyhoClC/433A7l4EUJEz4jgmRQT46rAVJDl6lsrtulP1NU2AKZ?=
 =?iso-8859-1?Q?Cqgo1P7x+mcbd7POe994p24DbEpdRddBcznwonIjNDv3b8mF9z19QlI7hS?=
 =?iso-8859-1?Q?F5cNKm+pVXtDxRkRGrxbDAv48+j0QVnaiZFqq0ZwkCxjyPYTa0lPcFXJa1?=
 =?iso-8859-1?Q?DDmrG+u6cXbpkC16B7dBea98kCXoZ7+4nLnNXx4AL4PGc3/5qSq7sZbkal?=
 =?iso-8859-1?Q?JErxGVSmMntwNvkFmZRj94fwZ3VYP+BWPi18ZRoiw1k6Em/pxdkdKt8kLR?=
 =?iso-8859-1?Q?23Qf5kxBeMEx28dLEsZK79i+Xo51acEhGkrCfOunsvZ8cikE3p+5j3lR6v?=
 =?iso-8859-1?Q?xcyLtbg/jOz9PngCVT9VCgxDn+SImABqbNkGGUiXeiaFYYGhbXglglLB0R?=
 =?iso-8859-1?Q?K51Bf6hsOgdYl0BEkvoofGIpJq1Zxjb+RHfU39jJT824uIIF/db9IyEosH?=
 =?iso-8859-1?Q?bTAZoT2GIYYaODnCQSppX/Tmr9ukyo5+5+cCzFxq68RFFpV+r+NMXNHA2A?=
 =?iso-8859-1?Q?wB0RInK1AvY6xlzd/C3jWUqrim0C9dOvx73cfA7lcuCrn9L5aYesppgnMG?=
 =?iso-8859-1?Q?Q3l43HUMn11U/1Vc9vLH2nIf/RnNaWmV1ZpqQGhVi9ZKcs0k4oHsG8NWVI?=
 =?iso-8859-1?Q?kyd2vacaf3i2n2R8egVqUbfKKlEBo2GaxkYrfkjp2HyBzdqinPAF1RBneF?=
 =?iso-8859-1?Q?vqPciAUmdAOtP+ZZH8kiFgVssTb2+W2PxfrfLZ33ZrPbji?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f39a4ba5-8cd7-44e1-af63-08de4d77d228
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2026 23:03:35.5237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4XFs7glv0fDLQHVPlM0+RyjF7PXyOflQs36h/DLu9GYl3IVX14c9G+GEzYZX8dVZH6tCBJWU2q4t8iRh+TnIrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963

From:=A0Jeff King <peff@peff.net> Sent:=A0Tuesday, January 6, 2026 3:38 AM=
=0A=
=0A=
> On Mon, Jan 05, 2026 at 11:45:41PM +0000, Martin Fick wrote:=0A=
> > By repacking to get one used, and one cruft pack only, and no loose=0A=
> > objects, I have confirmed that pack-refs it is still slow. This rules o=
ut the=0A=
> > idea that the loose object, or pack file counts were making things slow=
.=0A=
> =0A=
> OK, that is interesting. I'd still expect opening the objects to be the=
=0A=
> dominating factor, but now the load would be on jumping around the=0A=
> mmap'd packfile rather than open/read/close calls.=0A=
=0A=
I believe I have confirmed this now with more testing...=0A=
=0A=
By first dropping the system caches, and then catting the pack file to=0A=
/dev/null, it sped things up to under 20s!=0A=
=0A=
Note that neither catting the idx, nor the packed-refs file helped to =0A=
noticeably speed things up.=0A=
=0A=
> > OK, after discovering the strace -r and -T options, I have determined t=
hat=0A=
> > the 29K writes were all very fast in themselves. However, most of the=
=0A=
> > writes seem to follow each other with no other system calls in between.=
=0A=
> > This explains why it looks like the writes are slow, even though they a=
ren't.=0A=
>=0A=
> > If I tally up the time between the previous system call, and each write=
(),=0A=
> > it adds up to the bulk of the time (4mins out of 4m15s) that it takes t=
o=0A=
> > pack refs. This tells me that no visible I/O or system calls are the pr=
oblem,=0A=
> > but rather that the program itself is taking a long time between writes=
.=0A=
> > I very much doubt that this is heavy CPU time, but rather I am going to=
=0A=
> > guess that this is hidden system time spent accessing mmaped memory.=0A=
> =0A=
> That would be consistent with reading object data from the packfile.=0A=
> We'll jump around within the packfile to get that data.=0A=
=0A=
Agreed, but boy is that really bad performance!=0A=
=0A=
=0A=
> > Could it be really slow reading the packed-refs file? I can see the=0A=
> > packed-refs file is mmaped() before the writes start, and then=0A=
> > munmapped after the writes are completed. If I had to guess, that likel=
y=0A=
> > means that the packed-refs file is being read in small increments by th=
e=0A=
> > kernel via mmap, and that is what is making things very slow over NFS.=
=0A=
> =0A=
> The packed-refs file is mmap'd, but we'll be reading it sequentially. I=
=0A=
> guess whether or not there is good read-ahead there may depend on the=0A=
> NFS implementation.=0A=
=0A=
Yeah, ruled out now by dropping the system caches, and then catting the =0A=
packed-refs file before running git pack-refs, which did NOT help speed =0A=
things up.=0A=
=0A=
=0A=
> > My alternative theory, is that each ref is being looked up via a binary=
=0A=
> > search, but I don't think git does this?=0A=
> =0A=
> Git does binary search within the packed-refs file, but it shouldn't be=
=0A=
> doing so here. The write-out phase of packing refs is a straight merge=0A=
> between two lists: the existing packed-refs entries and the new entries=
=0A=
> we are adding.=0A=
=0A=
Agreed, and I should have ruled this out by realizing that this would likel=
y=0A=
not have been affected by the system caches in my earlier tests.=0A=
=0A=
=0A=
> I'd second Patrick's suggestion to use perf or similar to try to see=0A=
> where the time is going.=0A=
=0A=
Noted, thanks.=0A=
=0A=
=0A=
> You might also try building Git with NO_MMAP. That might make the I/O=0A=
> costs more apparent via strace, because they'll be coming via pread().=0A=
=0A=
Agreed, I will try to do this. I think that the jgit results hint that this=
 =0A=
this might even eliminate most of the I/O costs (jgit is not using=0A=
MMAP in my tests). It would be nice if this were a runtime config=0A=
instead of requiring a rebuild, as some use cases might be better=0A=
with, and some without MMAP.=0A=
=0A=
Thanks for all the input,=0A=
=0A=
-Martin=0A=
