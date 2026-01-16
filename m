Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011017.outbound.protection.outlook.com [40.107.208.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E937242D6A
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 20:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768595745; cv=fail; b=P+6LE3Th1TS5Pvhx848Esck5Wysxk/RGDcfuNKTCSjP25KnLgaivO0iuDbESqg5mjMtr2N64ttUeL49bfibgniC+/CZ9bCim5FFWAOJ+x+4PmFJZtrEy+ZJk0jYbnrrFn4CfXKsaexPpz4+gsJD0hqxnw/Fg0gfLPkyW6h+vUAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768595745; c=relaxed/simple;
	bh=aqafOP0bU2Z9E3u/v/RBtxXzEYlGY3t981cwM4QsM9c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Osc/WvA44XYcQ/dMwLvbD9dtEKhIyFXVQPp/Nxxv1JMcAppxVXa+pwhoYUSFzz2KJiqNFkv2PVsFRmzyctFujKV26h19YqGfObHodhYfRkpLdadmG9jEL8XEpdhW0pifLjmlVXi1J8Z6PJVY13+LoVvjgN7eP25akQcK/MPsGFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZpEi5wuv; arc=fail smtp.client-ip=40.107.208.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZpEi5wuv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDH6A62UzmoNg5iQD5J9EC1Uo+iTHK+QE7edj3Jb0S5/u3CNZ9EQAg3djDvQLDa21IVaiv4IJAyOvP6fL2C85CwmEAfQvOtvNATlVRO0UsMNE+WpWi83do55He1kbUMdDcMCA0dyHqhoLL5t8+ehCuSLOj9xHmKFYLwNE6cyoAG/DPnLAdM6Hr9oQssjqoZOz+kjqKR6JcDQzR3wUk9BlAR8EtJ/X+0MkJMX9XBg0B8KJVjaVp3bYH9fYlbLz/b0cuU+AIYcsVj9MdZZ2XoB4CcLQaWiQlaytfCtPUmEusdS7fVcfzvhzea68cOjumyr4ixKcRpMbcgPBxCiAoDMzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fhq4dQLxfR9Ve+B4tK+7hQ1PlOZsw+27uNPUIaqmmf8=;
 b=MMLoTx2XNUaHPS9pDLKy3veuZ8GZxYBLFM0s9VSiibSkPqgUaKds/rNxLXP9aPzFg21qIrnM7YXwokmaZWGe0EoghVKRPOwxOyheouZpWCqOVqQGV7tYdJVdGz+/dJtVjPV5LYKj/17tWO88ol2hvNa/8XzSU/Ak1RreF0sGJAT6xcHLa2RcaX1frHhsEUKQfQj9zBn+M+GmYYNZn7Fumr4MvIFJ69MH2ju5KlVO+L0CMbrxtLpRfSb0NX+xA3Srt8sdNsLrXQ3ehQEQOopRc9EOa9Aj9lVVosKVMSeChBNVc7WlYgzIobWfR2A2YuvOuG3yhVNctOE2ySFXdjCRmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fhq4dQLxfR9Ve+B4tK+7hQ1PlOZsw+27uNPUIaqmmf8=;
 b=ZpEi5wuvAaW1BnMC5qcCqbyrSuNYfnmk26eCn7tT3g95qt0rPpMm/M3Ob5YsVCI0NVzv0YO1JWOmN9pMBrVVE3GTB8YGAhAGCgdFNUkgums7k3fdwXDazz1HkiVE8hksMwAfA4oZUGtFLBiWNKgPE01+MQtDl3kdpNLAYIa3rTZnveq+R62QaSP9QsyYJJ1yLQMyGNvIjiTmNaHar6oB2SLI3rqqrxaLPPILLveQ9VXtzCVz2Wo0yBK3ZurCaO4AaqwHrOaSMw6vh3EHbreSpcfobZQ0FnPaq6aDQ89hJl5MRMeYicBm5WnTjKcVtsJ8st/1bNqGaTWiz8g/DSEA9A==
Received: from CH3PR12MB9026.namprd12.prod.outlook.com (2603:10b6:610:125::15)
 by SA1PR12MB6821.namprd12.prod.outlook.com (2603:10b6:806:25c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 20:35:41 +0000
Received: from CH3PR12MB9026.namprd12.prod.outlook.com
 ([fe80::7e83:9747:5352:4af2]) by CH3PR12MB9026.namprd12.prod.outlook.com
 ([fe80::7e83:9747:5352:4af2%6]) with mapi id 15.20.9499.005; Fri, 16 Jan 2026
 20:35:34 +0000
From: Martin Fick <mfick@nvidia.com>
To: Jeff King <peff@peff.net>
CC: Patrick Steinhardt <ps@pks.im>, "brian m. carlson"
	<sandals@crustytoothpaste.net>, "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Slow git pack-refs --all
Thread-Topic: Slow git pack-refs --all
Thread-Index:
 AQHcdebABRaVmXg1XEKj998vyrImTLUzA1gAgABVq4CAB+sE2oADSLCAgAW7ve6AAH4YAIAA2VTygAEJ2gCAALoZLIAMdr8AgAF2APo=
Date: Fri, 16 Jan 2026 20:35:33 +0000
Message-ID:
 <CH3PR12MB902665032350D502E3D31ACBC28DA@CH3PR12MB9026.namprd12.prod.outlook.com>
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
 <CH3PR12MB9026C8C940270F02CEF83C4FC284A@CH3PR12MB9026.namprd12.prod.outlook.com>
 <20260115210908.GE1053259@coredump.intra.peff.net>
In-Reply-To: <20260115210908.GE1053259@coredump.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB9026:EE_|SA1PR12MB6821:EE_
x-ms-office365-filtering-correlation-id: 90071ba1-0b20-4c72-b5aa-08de553ecc49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Z8bRSF7eS7g+HjhADXm2FTmW78Fib5s7DApKWEVXGPR4ogVqMjLLAQXGUL?=
 =?iso-8859-1?Q?ae9mAy7+R0AcfgPHJFF5pksnYsT4uVwJfv+7+E3oXyAuIJmjzKOLxUUz/0?=
 =?iso-8859-1?Q?fHMC4j+HzhfyIUlMl3jSrOu8bvcsPn59Zm7BuUknnq7dVeFAIBLX0idu7i?=
 =?iso-8859-1?Q?bZTFnPN6S7nn8c0X9YpfjudM1AfX75lJ9GTEFmC+QT8JszzgUHivPyJbj+?=
 =?iso-8859-1?Q?YkASaLsgRVkWGtmYEUFMgsIDabcR9MGLeuNbQpmOjOGaHHRE0qU2OKUxlZ?=
 =?iso-8859-1?Q?1qYDGb9Lwmr946PEH/uDmMJo6EClYr6KKVBg21lYtDtNLhKSmd5xUFDeY5?=
 =?iso-8859-1?Q?uc0RC3dfLEWJsJ1X8QNpHj47Ccqna2rkV0nuw21PtAueV6no8U9fU+sUNe?=
 =?iso-8859-1?Q?oHYx5TEDeQjvjlGbRMrFAjn/AzjWIqzp4PVGkPhvzv5RCyy2jyE4Yiaxf5?=
 =?iso-8859-1?Q?kphf/jVWsoyaEHkB/I/lS+26+kCp2YXapRAtuF9cFZVbgIzacVcDbV9sAW?=
 =?iso-8859-1?Q?00URnQtUkhVoK4XpzDhxOFhUWi5NazeEBXt62CmcOQfaYT+ZNtRRDEt8Pd?=
 =?iso-8859-1?Q?DwPVOLd3PI2klAZrjjimFlZ7L4XL251APwDUV0U+YxUOXJ1mykgEgxP+6n?=
 =?iso-8859-1?Q?MFXhI6h1ja1w1yjMCzylv4ZePlMHas9sYluueLI+MiWgwMphfZ7d+6nar+?=
 =?iso-8859-1?Q?YKFdKz+2s6hBgSi+yvjD7/GqO3YB/KCVKGXKASSBHrQFCg4ub15FThtJMl?=
 =?iso-8859-1?Q?CJ//bzSBuB4QdgCrOWhY2ynx9+D2Tkr9vXqNiXHsGMl1Uhg8a4w13Tgwim?=
 =?iso-8859-1?Q?8SaW3XdFcyXrFNjwq8eUbHKRztbA2a0TjpsF9X0hOfSdKvf3ypqJDLcPux?=
 =?iso-8859-1?Q?IGfdY2di+/N8IlaecxwiD2t6+LJe2WOEDqN+P18okGTeHrI/ssULjaU7xh?=
 =?iso-8859-1?Q?b2p0b6ecVLdHPZ119V0LBT2eeJ9rDRbYGO4tPyjDN+94iN3ox8KgFiVlTp?=
 =?iso-8859-1?Q?1BfepViO1xKwebhvKRJkkm80fD2so8L3jKjkvMMxcUlv/DEW2zzUUN/DZg?=
 =?iso-8859-1?Q?W0xrHKbFowMmrUjA6i1iSeDTJdbWRK19d3SVJdjd5iOslcSHUwT+wcBZry?=
 =?iso-8859-1?Q?RRXe9yi0+NaZivHPC5+WiEdao9pAp0P44wsV0nlwnzCu5wgVWkxkUTo377?=
 =?iso-8859-1?Q?x6SQYIYfUJh6/l6qnUA91TIv+gPgFzJVCj37zErJpyeW1PaKuf3vI4EUbI?=
 =?iso-8859-1?Q?0dJnhkV9vcyMADOSiiZi32zc13pv18+Bqp87bEgoo6Cvyb5837X0JzRi7q?=
 =?iso-8859-1?Q?4pyxxXl7FSFyyVv2/5+0Ui7qqmUpUcwqaRUSshOKoDYow8fkM7chkxJ2bg?=
 =?iso-8859-1?Q?4quqfmwBC2OqIEspLqUor8qbnaOwLZ/iJcQ18TgQmF55XUOQSBoYsVi56b?=
 =?iso-8859-1?Q?UVp0kmVkuX3/ZllTCaUD6EJujVWmtOfDhrEg/jCmqShcMXM361ZdANZLjg?=
 =?iso-8859-1?Q?nGswrOJpnPtTD0Jndg5/WT4ksoPif3ce6Bb93r98djNwkjT/sGjeZ+d6c3?=
 =?iso-8859-1?Q?ghrjCoxQT2sE/sz8JxxJeQaIg39wA1dj+g7JGBwF6jVqBjpYjYHlRreill?=
 =?iso-8859-1?Q?Msrx+oBftkFJqDHSJ9pOxZxNx4HK/U/XUUfdzlWLhRAU7cEa10yxQ8cnSI?=
 =?iso-8859-1?Q?YiKhHVBv3XvV+xKzRn8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9026.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?uz2yTNSbdNd/6mAerkzyOAHT3U0V9Gzh9Itnx6D0rHmJ/4mg2QAjue2Dff?=
 =?iso-8859-1?Q?RWRXkyW8AfGYgKs1yznzHseVMA7tbVKNwpbKuQYh3LQ/y9S7ZnV7nja4mi?=
 =?iso-8859-1?Q?kYBPjgUOlA9W/vdJByOjQJn2wq/1kvxcc5Tz/0hB1Q4GVwftW4DCtMZqrU?=
 =?iso-8859-1?Q?fUg/1gqadjY0nDskkJ/UDbedmdTN/xPb/QZzfjCgbC4j9e4jOXiXPz7DxV?=
 =?iso-8859-1?Q?0pUakUUN/F0ryyVsRlR9gOoU6LoTVW4R4ShV3OVtWbTemNN0qZ+h5QlIPU?=
 =?iso-8859-1?Q?dOLrV5CxGYf/5Ozg91mny9jOaKEJuBM/DgyELFqTjN68d9h41V/ndwpdxy?=
 =?iso-8859-1?Q?IMvmJSwUDj9ebskj3BbJwaOp220w2r1PFGL4wfmBjXzAna+6ZgCn6CbFR5?=
 =?iso-8859-1?Q?fiPL9ilodwBpYuzVY3vOh3qfWQE+hU7jNkQA49aLv762TvnpGEV4ROP6yN?=
 =?iso-8859-1?Q?u14pYcXtVP8Va3LcdmOLuSCeY0NB71PTu6vQV2r3RFuTcup76P6OM/DVJB?=
 =?iso-8859-1?Q?jLQXqGSrBjKQWWTwF29aGbhK7QgJbQZK+Ci44S0ifKklKPyLkwmuqC69w6?=
 =?iso-8859-1?Q?Ie2ndIOuBF3eAu/BTIu5VhwER3zUtxnHc6Nyf3arqHZDDJxb+wgQz0G7p1?=
 =?iso-8859-1?Q?17zLG3O2VDSfzewVmsGfzvThQklXczP7qXd8mkPHPO/5k9pwrphIA+mwI1?=
 =?iso-8859-1?Q?OiOFArxCwi/2ZQZWMKc+jDboV0JyUOXLJLKDvMKKYw2oAaN98PJAtS3c2S?=
 =?iso-8859-1?Q?A3I8pCLX+9BXVGa8IwFXg56Hf7rr+JAXaGd+MNB85yPDocM+pZO4WnnUxJ?=
 =?iso-8859-1?Q?Ld+lv6e9vBMOqQqkcMvpO1nrFjgxtESYmc2mkWMZaf+dYIPaGlVTpKp47X?=
 =?iso-8859-1?Q?JBIVWC3IqiFQHGr60mm555M1QXMYV0Kpq/2ihO/wQXbV0A3pID1ZjBVy+/?=
 =?iso-8859-1?Q?hAbbpnYPcFYESDdBnZINLJtRbOGIqet1e7UIyXQ0yzQX/5cBe9Ul/K2zoM?=
 =?iso-8859-1?Q?2NqpEYOrl2a8z9NbpQipFN1GXGWf3eVK3NrpwCM2fsJQxi5bwwmMyK9BGP?=
 =?iso-8859-1?Q?nNoYlsr0ZWMu1Lc/F93D+8DCbpJci7Lk/ojTCi3EUMWSldbIy/60lBj17v?=
 =?iso-8859-1?Q?omxw6HDOGo4NsuD6o+vjgvtq2iyLkBvvoBbnxfT4BHcqrurC1W+kXwwV/2?=
 =?iso-8859-1?Q?DxBCMVuDMfcM9QCd5irG9Ti4aLMRrnd7B8kJR07GfxvIG8QqxL73/eav3l?=
 =?iso-8859-1?Q?C1kojOc3TSH/m85lejSrzYslN/OWVxvr4Nmgd+oVzHunS7JszZ2yKAE5Y1?=
 =?iso-8859-1?Q?F783duHMOTwDszknD8YkEFAQXQho5+NvsHv5edmgeL+7R0g5dZ58L13PJX?=
 =?iso-8859-1?Q?oTHd5DT+JRzt/kqhYOvrpKG99Bv9NUGq8m3K+Oz+VjGcAk2bdoy/69kl9h?=
 =?iso-8859-1?Q?HfSkwQM594j9PZaP0jcPIJUcBCmamUbTTnGEDlsHpUJLTyhu0FlViXAoAr?=
 =?iso-8859-1?Q?87hA1s/sU1HxHU7+6o/0LlbGHO/tC7CoR3JP5UK0fDRsPtrxEeepf4/7Cz?=
 =?iso-8859-1?Q?CH6RG+ukthGCX/axJLTZNnCmzGcc03viC/ZvvYmD67kwXuwUNHalgbTVTJ?=
 =?iso-8859-1?Q?CcuDjGSmma6uCuQ+pVd7caEbOxZYDdAQNnzSsfh4WUoH0ffQhWK4eRCDNo?=
 =?iso-8859-1?Q?aXnKflk1qlD980jpSmw+LixToo5BxTJGlxavXmXKhDHqDgPu5I3H4uKSvJ?=
 =?iso-8859-1?Q?OXL2vXqH1CESymWzuouuCu3byWUgcVtrGMOD8mU3Md6PA+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 90071ba1-0b20-4c72-b5aa-08de553ecc49
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 20:35:33.5798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dQDn5+X1vqFPSBX1gk0jxjVrkVGYRVHctqngSODVKionNogmd4iTZMlda6YA2aKAVKijNeinFFPuH31ZgbX9Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6821

> From:=A0Jeff King <peff@peff.net> Sent:=A0Thursday, January 15, 2026 2:09=
 PM=0A=
> > ...=0A=
> > And the remaining third was a bit all over the place with small section=
s,=0A=
> > the largest two of those sections being:=0A=
> >=0A=
> > packed_refs_store_create ~8.7%=0A=
> >=A0 unknown 4.4%=0A=
> >=A0 memchr 4.4%=0A=
> >=A0 page_fault 4.4%=0A=
> =0A=
> Hmm, I don't think we have a function "packed_refs_store_create". Did=0A=
> you typo while transferring the name over?=0A=
=0A=
Yes, this should have been packed_ref_store_create (singular), sorry.=0A=
=0A=
=0A=
> At any rate, we can assume this is poking through the packed-refs file=0A=
> itself, looking for trailing newlines via memchr.=0A=
> =0A=
> But why would we do that immediately when creating the packed-refs store=
=0A=
> in memory? In modern versions of Git, we try to avoid reading the=0A=
> packed-refs file as much as possible, binary-searching when we can. Of=0A=
> course that means it has to be sorted, which was not something promised=
=0A=
> by the original format. So we have a "sorted" tag that we write. E.g.,=0A=
> this is from my clone of git, packed with git itself:=0A=
> ... =0A=
> =A0 # pack-refs with: peeled fully-peeled sorted=0A=
> ...=0A=
> =A0 jgit pack-refs --all=0A=
> =0A=
> That gives me this:=0A=
> =0A=
> =A0 # pack-refs with: peeled=0A=
> ...=0A=
>  Aha! So jgit is not writing out the "sorted" tag. As a result, when git=
=0A=
> reads the file, its logic is:=0A=
> =0A=
>   1. Check for the sorted tag. It's not here, so...=0A=
> =A0 2. Check if the file is sorted by reading each entry linearly. If it'=
s=0A=
> =A0=A0=A0 not, then...=0A=
> =A0 3. Read it all into memory and sort the result. We can then=0A=
> =A0=A0=A0=A0 binary-search that (and iterate it in sorted order, which is=
=0A=
> =A0=A0=A0=A0 important for pack-refs).=0A=
> =0A=
> So when git reads the packed-refs file, we are ending up at least with=0A=
> step 2, an extra pass through the whole file, and maybe to step 3=0A=
> (depending on whether jgit actually sorts the file).=0A=
> =0A=
> You mentioned that Gerrit writes the packed-refs file directly itself,=0A=
> presumably using jgit. So it sounds like it is constantly undoing Git's=
=0A=
> "sorted" marker, which causes git-pack-refs to spend extra effort=0A=
> checking the sortedness, and rewrite the marker, which then gets hosed=0A=
> again by jgit, and so on.=0A=
=0A=
Agreed, this is likely the case, but not for the sorted marker, see below..=
.=0A=
=0A=
> And that may explain why jgit is faster, if it is not doing the extra=0A=
> sort check. If it is not even trying to maintain the sorted property=0A=
> that it would be faster still (it takes one linear pass while writing=0A=
> out the file, omitting entries that match our updates, and then appends=
=0A=
> our updates at the end).=0A=
=0A=
Unfortunately, this does not actually seem to be the reason.=0A=
=0A=
> If jgit _is_ sorting the file but not writing out the sorted marker,=0A=
> then it should start doing so. ;)=0A=
=0A=
Agreed, I will see to it that this gets fixed. Unfortunately, adding the =
=0A=
sorted tag does not seem to speed things up. :(=0A=
=0A=
> If it's not sorting the file, then probably it should start doing so=0A=
> (and writing the marker). This will make subsequent reads much faster=0A=
> (mmap + binary-search). It shouldn't even be slower to write (assuming=0A=
> jgit's writes are doing the usual "rewrite the whole thing to a tempfile=
=0A=
> and atomic-rename into place", and not taking some shortcut by appending=
=0A=
> to the file).=0A=
=0A=
FYI, jgit does seem to order things, it does not append. The resulting outp=
ut=0A=
from jgit after a repack with new refs add matches that from git for all bu=
t=0A=
the header.=0A=
=0A=
> Unrelated to your problem, but also jgit should support the fully-peeled=
=0A=
> tag, another thing that makes readers faster. ;)=0A=
=0A=
Ironically, this is not just related, it appears to be the trigger!!! When =
I add =0A=
this tag (and not the sorted tag), the cache flushed time drops down to =0A=
under 4s (from over 5mins)!=0A=
=0A=
I will see to it that jgit fixes this too. That should help solve my proble=
m.=0A=
=0A=
That being said, it seems like something is still broken in git here =0A=
despite this tag being missing?=0A=
=0A=
Thanks so much Peff for helping get to this point!=0A=
=0A=
-Martin=
