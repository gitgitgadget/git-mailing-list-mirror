Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010010.outbound.protection.outlook.com [52.101.61.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DED27702D
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 22:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767826720; cv=fail; b=K9STiqIB9SbN0g8YqZdjQhdtZeRkFBOQWUBtlVMPdVWGwDDdTX7eM5+1kZbmNjPCM8klOLW32MOAZtnWCGoRBplOWKrJ3Hx5dziPkPn4jVn2Ot+ZugZKkqhYqloa8rFOdNEGdtn+P4GGXTEWZI5Gu6k6rM+aXbGiLdxazaDtgb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767826720; c=relaxed/simple;
	bh=zCXh5djR7jQgI5xYVMTv7ji5ZMzizU/55KL4msuZI5Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HXZ+h7azZt/1oBQ52FBrDVA5BzAoCAvucNP39YR14tf5casGwOfdqGIL3uRorPcQn4mVDehnpjLde6zcgyONjJdI9Mb3uiAqOTYOTIsAW3YHtihntZfM5TbMbYt+OQiBNtSnBSs1vcDGuljkuSWb5W1Lhqxlt0I6W5hijfrfVLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NRfhPYSc; arc=fail smtp.client-ip=52.101.61.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NRfhPYSc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZUEfgkvGSHsa/fCcCshlm4xUub49dkVEIxxRrHnGT6J8wTmDRq3CNOBuK2Y8vwjYiWFUI3Kcbl7cU7WpGbNPQ6u3FJb6Ww8TmP30lDugwh6+joNjS0L4va0zWsK0cnif5aMSkTlbnPKffK6nQ0wRzg36ZnAFonpJzyyHp2lriuMTw9FCFObPRMtTAr2MBbsGwhtJVXiyrjMaCN5xoi8N9WzZ9vFaS2XRgiY9ZfxvCphJqdOZTNsgobgXXQgFQ1p80usK7ixBxsw1r8DjwpZcfwqauIVMwOpif0s82vS2YvEuMLUZHpI6iftmZFkV8jeuR/zkbMapdce3Ny+Z3bpLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCXh5djR7jQgI5xYVMTv7ji5ZMzizU/55KL4msuZI5Y=;
 b=cIIbsPbWEX0eYmHC2ijmzQ9yQ9z0xym5ri9nr9/UXKbtdGJTjbWh40A4ts2lKczeWxY41FGsc1U4PZbhH0OvnIySzNzK0/bfIWYm+T4W6mkAHR3JrcxkuvA4iEzZelCq5oVwITQtjaBwEHn6GSupR//0EOsuloY5bgKZSVBqjUoS55DoaMdqOuDp6NggKiT69Nn3HGlJy5VJZlKBmaTL53sYsQavrA65KkvrX7je8UNWF9mySRdQRs7DhR3E1Upr+Jy9u0TyrSe1JT4LI+QP4SUQBCKvqJ00tjjjIEuPt7DUgfuW9QTErYE1PShLc0xVw3rwln++BIdSTnW7WcQhQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCXh5djR7jQgI5xYVMTv7ji5ZMzizU/55KL4msuZI5Y=;
 b=NRfhPYScmaXFusgkbyfxPAIcE2KnUfQrXyNiyuPN5BUi5re3eVMAILJI1HLmlVqGbjXpAQvu4ZdgPbRyOcu2RQBPVSeix2IK5ecKEjd4yyRLW8K6/1ycukt6VVOg1373X6kPm/qCBkr++wmJo2LEnF4aPp8DK6M/ymjq3rmhKKD/LS/Le0cCVQ63v3xVMpAZlSX1F/vO4LFSv08vH7tIhQTIbZrBacWn9DdrCboI8hscPNoiFRc1RvYwaGBz/D4VklH+pNbpITGrzjfLQXpXBRPbNUxGJmeVTiGiVgoDZpo79v4+3hlO28jue19RF+yWajjapSpWJkc2A4C4ubiNhw==
Received: from CH3PR12MB9026.namprd12.prod.outlook.com (2603:10b6:610:125::15)
 by DM4PR12MB5940.namprd12.prod.outlook.com (2603:10b6:8:6b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 22:58:36 +0000
Received: from CH3PR12MB9026.namprd12.prod.outlook.com
 ([fe80::7e83:9747:5352:4af2]) by CH3PR12MB9026.namprd12.prod.outlook.com
 ([fe80::7e83:9747:5352:4af2%6]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 22:58:36 +0000
From: Martin Fick <mfick@nvidia.com>
To: Patrick Steinhardt <ps@pks.im>
CC: Jeff King <peff@peff.net>, "brian m. carlson"
	<sandals@crustytoothpaste.net>, "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Slow git pack-refs --all
Thread-Topic: Slow git pack-refs --all
Thread-Index:
 AQHcdebABRaVmXg1XEKj998vyrImTLUzA1gAgABVq4CAB+sE2oADSLCAgAW7ve6AAH4YAIAA2VTygAEJ2gCAALoZLA==
Date: Wed, 7 Jan 2026 22:58:36 +0000
Message-ID:
 <CH3PR12MB9026C8C940270F02CEF83C4FC284A@CH3PR12MB9026.namprd12.prod.outlook.com>
References:
 <CH3PR12MB9026B5872FD42F031970074BC2B3A@CH3PR12MB9026.namprd12.prod.outlook.com>
 <aU3K9lGbHw68Vv5U@fruit.crustytoothpaste.net>
 <20251226044507.GA1971832@coredump.intra.peff.net>
 <CH3PR12MB9026DFCF7AF4ED1A249B16A5C2BDA@CH3PR12MB9026.namprd12.prod.outlook.com>
 <20260102074901.GD2581074@coredump.intra.peff.net>
 <CH3PR12MB90260C4887067C88629BBE52C286A@CH3PR12MB9026.namprd12.prod.outlook.com>
 <aVyxbqk-2QQIgDXK@pks.im>
 <CH3PR12MB9026F1E4B99D32E138800EEBC287A@CH3PR12MB9026.namprd12.prod.outlook.com>
 <aV5GwOS_N2jyIFaz@pks.im>
In-Reply-To: <aV5GwOS_N2jyIFaz@pks.im>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB9026:EE_|DM4PR12MB5940:EE_
x-ms-office365-filtering-correlation-id: 4929f4e5-ff17-4e99-eddc-08de4e404a63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?VGzDa7dIp8YleNK1lRjPmQQWrLs8OABGmcAhDq4+IHr2mp8XNd4ADCypE5?=
 =?iso-8859-1?Q?PKr+uYO3a83wDw6kDarxla1f7K2DUT8AlMGtC5iOnPWBPRB24wvOZYmqFH?=
 =?iso-8859-1?Q?YnBF3xQYPAdYae6Z3OtdIkhyOvwzivIRJxF2Tt9ZfgwGIxpMqHP/Zq6Nij?=
 =?iso-8859-1?Q?+mVUu2dX47JWfwStemmx6s8NjRolAjLuN1487UXDWqrfPvEBmaf2WI22BH?=
 =?iso-8859-1?Q?5jEYbEecAZkGMPNetVgpD8a0pK64zJBmhqBPzrahjs4Oo3qX5X0JlLOvPU?=
 =?iso-8859-1?Q?ZsS45ES+NVcMzVUpAG8GZCkfcrupAALs7m5Q1ZrZ7bb4jF0pIZMxBy3SpC?=
 =?iso-8859-1?Q?B+TIF6EtcorgbpW7bAz7sqO4ktvvJFiApA6yKivyzsr4KT6gun6kFCfCfv?=
 =?iso-8859-1?Q?R98hBNutAT3HLFLfEDfbzaPQOrfHT7gUzvwfLdZlviMYQCIvv/XS7Ge5bU?=
 =?iso-8859-1?Q?zd5kKy25MP9qKxnZqt2x3tvNBPTTK/jVdQsNCEU+dYZzMtoQ5rQLVJIfv1?=
 =?iso-8859-1?Q?466ZIoqW3dcyBg28Ogfo5QmLd4W/cnvrXLhGFgg0dMCDQMgSgDcd/D96vf?=
 =?iso-8859-1?Q?LMDkWbSKaiSrg+S5rCQ2ZtAFU9F3m0wht+D0a0loOsCbuxTxm4WTse4bhR?=
 =?iso-8859-1?Q?ppN9zgYjp1fhT2RTqKlsAnKp2ouJDFEjTHp9qlXdg99rejGiWga41c3L+I?=
 =?iso-8859-1?Q?1E+8zGHsXFZvwWQsJ6d/ApYeWPQ1ifmnR8iVAhkINuJ5tE5r6JMRUXVfcF?=
 =?iso-8859-1?Q?TujyUtb61H2mYag5UCX/2W1ll9kBJ8DJ8d2pRDa7xVV61l8tlibuxaTxFL?=
 =?iso-8859-1?Q?21CRMUlz7agihzgBXt0PhM3WsrIxO/MSulhGdxNrOaD3Da4yztSN70ycMn?=
 =?iso-8859-1?Q?Onyq2lGqoRFUMIBjN9BhJpvNC4qylX74lPLXF0LXrmytGfL/LP8AHkmBeB?=
 =?iso-8859-1?Q?wUrVI8Ax0TUGsFu2w+NbWEEg1ofedvUUr/+JjOgmpXCy5qimGMXxc5OlYZ?=
 =?iso-8859-1?Q?wUGXqD1LnAU8WiqDEnANTS+yZLlw/AXq5MqIeVlyXjiuXvACpFGol76riJ?=
 =?iso-8859-1?Q?iErsKwX9VQj66QxkvtpPJc1uYZ8VDYIpBmvyar1OU1Lxw+KpffyX6wlT4p?=
 =?iso-8859-1?Q?/QIKqY+Hkqqv/PuFVs6/Yk5TQkSUUjQjbLv5r9d0xmrm+Qpc19sb+CZeRM?=
 =?iso-8859-1?Q?MU/yC+F4wXXBVM5eBz6a12apS+yblHjz8Vr2n0Xzyg/vdwyhGz7XaQtL6U?=
 =?iso-8859-1?Q?Vt4p9VRRQIS8yaluGpC/r1kdLQRt17zwy9QXp0T7Igz2WotNSxaCQt64XO?=
 =?iso-8859-1?Q?NbCy5d+1Dh6SmMS5sdR9rZ+RkYv6NcTWoe6r3QlmxdHcuQJ39Alki9lGH5?=
 =?iso-8859-1?Q?GmCEnhVIHP019YvSlLHX2NYB3eQhgPBBpnKtgoLLz57ktli9n+FdC6/WoS?=
 =?iso-8859-1?Q?PpfNel62TC7ujfjwTRBHwADp1SOg6YgFd5U+7q66Y0hZxL0gWtfvHuY5sr?=
 =?iso-8859-1?Q?SsRwcsVy7tHo5p4KSAKucM6Jv1E7tNyMIcbC8ngVrpHmQTYb6y3kdGkgPC?=
 =?iso-8859-1?Q?xms7b0BKGo/37Ci/k5Vy9rJVlGTc?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9026.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?hB/dt6fa/2bl0UcjW/Ix12E4c0hJ3XPAnV4wI4hIfv2t6QN1IsPrEpIGT4?=
 =?iso-8859-1?Q?Bvo4UcNioXZeNiFmdX20jrI8ooqk6XXjd5JrmVdjovQyI+YX+WMdR46LUK?=
 =?iso-8859-1?Q?rWt66EJ/4JD0NsYHTdHNfyYWGfSaP9Iib9aql/jtu4O54myucBxguxpiSe?=
 =?iso-8859-1?Q?wVI/ejfbvuMucPceAVmFb6jiN/zrAZqxUZYn9gcCQRuS8vxFyU8yDEy9sP?=
 =?iso-8859-1?Q?dJLbymU5Wag1LacJbaUNxkQHq+Wb7gt7ONyhhAIgxzU774xXInS849lYMa?=
 =?iso-8859-1?Q?BJdKXIBS70iURFHmtepnXH0TpNg51nrVkB5R1wUBiO7ffCdm/Dw2zq+lml?=
 =?iso-8859-1?Q?OUYrruDe+sccRF45k2GJELS77twx52n8iNHYPYikFpu3QSZjehHRRZUH0d?=
 =?iso-8859-1?Q?vpY+TZwbS2mQQCA2oZygALMhmePKHzFp9PYLzEx9LlNzO8pb5Cl5Ppjom9?=
 =?iso-8859-1?Q?gkCSEpnSqyBeqC1T+1g+XZbd/gWP5NFsXevt/e4289kFcM7bfSxJUikFD8?=
 =?iso-8859-1?Q?62o1AefMFZeYLlubC0dz4JZpUXseXf2X3EisXrX08fO6sM4n1cJXyiKB+1?=
 =?iso-8859-1?Q?eZb9nt1WaZdQdkBQ/MUFPH37hn0zmFpjPTEuHjqV0RY7skAtsWDKyKq3AC?=
 =?iso-8859-1?Q?SMXKhOOoJ9ttll2Voeopqy7A+VPxshm8Ozj2HOGWsfuVo/7i5fRl4kYWT6?=
 =?iso-8859-1?Q?lOilRJKZ2BYUJweB4oUCrGI6ZoA1cfG2GJRx6qJUka6SUacoJlhEI132es?=
 =?iso-8859-1?Q?TvX4qcjU39Jgn7dT/YDccIQm775/GUNh5eyRKgrn6IUh3KkQxj05F60YZm?=
 =?iso-8859-1?Q?VdRFfeOgEu+r9c6dPk0awEq0c2nSnTCCJlbw/eoWJxWMDhr6VlJ0n7miWm?=
 =?iso-8859-1?Q?pdPmDGMoFzZHWT/uelWRkIj/rCUmMbav0myIZAFXwsbYMmofPtAP5tSQP7?=
 =?iso-8859-1?Q?Ig/pUNdNPk5yStO/0HKoO6JI6qVo4QPo3yOXq8EfoWfZblQ1GVXWuWBdj1?=
 =?iso-8859-1?Q?UDgL6OZ0a/Sz/TVpwBApQj50AY1CcLj3yhv5jvJZl0RqKiJSERnght00gJ?=
 =?iso-8859-1?Q?HtJ3v01hhP30rv0O/CZOpRCo6SZ2T659Dn1MmbTJilBv93Z2xmc87OT1g0?=
 =?iso-8859-1?Q?jy+GHjdt+TLTDBjgtlbvWoutQOX0Sp9uoWvVquhXBnvnr+9+1rhzdCE1Sf?=
 =?iso-8859-1?Q?DzvrtrtDBe+kA8mJure26K7EGwDjWQ2+F0KQ/yvMCieW6wXlJReNtkVFU6?=
 =?iso-8859-1?Q?xFXmSwe/M5lbl1r1cPV13sbrag6a2l3tIiPP5/dJYUlK9wUqQxHAhWC3js?=
 =?iso-8859-1?Q?R6IvhOaNVGc6YaFq3DHk7zPXUyJPYyrN8LrZNS6wAp38QqFmv3rVzfDuCz?=
 =?iso-8859-1?Q?LsQZMGQMZzRxG5Ftd+sBiQd+ZrP2SWK/WaglO0D6PSym1Wz8ULvosfWRu3?=
 =?iso-8859-1?Q?n/wgY+Kc4GGdYAVNTkm8f0gFTnbembprwijxehQ3pHmvSpMeqot0PSv0qI?=
 =?iso-8859-1?Q?RJ1q3/s/O8Svz9LqRBzvTCe2dfJ6i0fKStlPDKv4dpGqrpIh6ukDKggmyW?=
 =?iso-8859-1?Q?f/7brJg5z4eVVb/lHAcecYpJ39h4QuutCzcYsboUmCBqNmvJwzVxrCyn2R?=
 =?iso-8859-1?Q?HBWFvmkbAqIJKKtkEmYzwRt9gBB7AlzkEDSRKpykp6QJqv2/A7h4rEEK+t?=
 =?iso-8859-1?Q?m0MlTf6uXw2OfBu2nIVHLFYQwRTXRstjtJFQSvbef9S9ylj2jXyMPVUySP?=
 =?iso-8859-1?Q?wVVd2U9QvC+QKivAVk6zw4GsNP94/RYznBB+ZxNi0SrEQA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4929f4e5-ff17-4e99-eddc-08de4e404a63
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 22:58:36.6053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 53YVEh5z8U1EZHQcI4gdX3slt25KyF4HWHYwZIHppvtJXduB9eZRT0Pw4iQ80ic4FlGAlughbrNw4fGTumcVsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5940

> From:=A0Patrick Steinhardt <ps@pks.im> Sent:=A0Wednesday, January 7, 2026=
 4:42 AM=0A=
On Tue, Jan 06, 2026 at 11:02:19PM +0000, Martin Fick wrote:=0A=
> > From: Patrick Steinhardt <ps@pks.im> Sent: Monday, January 5, 2026 11:5=
3 PM=0A=
> > > Did you try using perf(1) to profile the process and generate a flame=
=0A=
> > > graph from it? That should likely make it immediately obvious where G=
it=0A=
> > > is spending all of its time.=0A=
> >=0A=
> > I will pursue this. Unfortunately this might be difficult on this=0A=
> > particular server.=0A=
> =0A=
> True, on the server side this can be a bit tricky.=0A=
=0A=
I ran perf, and got a flame graph, I am not sure what the best way to share=
 that=0A=
is, but I will try to summarize what looked important:=0A=
=0A=
About one third of the time is in this section:=0A=
=0A=
libc-2.17.so 32.5%=0A=
 _memcmp_sse4_1 29.8%=0A=
 page_fault 7.23%=0A=
 ...=0A=
=0A=
I am not really sure what that is doing?=0A=
=0A=
=0A=
Another third is doing:=0A=
=0A=
unpack_object_header_buffer 30%=0A=
 page_fault 26.9%=0A=
 ...=0A=
 nfs_read_page 10%=0A=
=0A=
Which could very well be looking at the headers of objects to see if they a=
re =0A=
tags needing to be peeled?=0A=
=0A=
=0A=
And the remaining third was a bit all over the place with small sections,=
=0A=
the largest two of those sections being:=0A=
=0A=
packed_refs_store_create ~8.7%=0A=
 unknown 4.4%=0A=
 memchr 4.4%=0A=
 page_fault 4.4%=0A=
=0A=
nth_packed_object_offset 7%=0A=
 page_fault 3.2%=0A=
=0A=
This was way less informative (to me) then I would have hoped. :( Maybe=0A=
this means more to you? =0A=
=0A=
It does look like a lot of page_faults, likely due to the use of mmap?=0A=
=0A=
-Martin=0A=
