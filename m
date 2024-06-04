Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCC614291B
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 22:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539570; cv=fail; b=Euarv0pVoBQ9pAG9l2PXGKcYr004ftYQ+iijh2irvLZl7HiUHLqm9EjjCRlnJWBiv/2ptjhBIuD8ZQ2Jfqt/oKr64ze2i3dKJEPfpWpTMihkBBs+6nkKHeZrBzZeBg/qkIxC19eYEtKqfMWImSlTRPulqI+zMQOXjTfh7Y8ENxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539570; c=relaxed/simple;
	bh=1TmjQf1DdjVVwmh2isZYQXZE+wAgbBYLtgKPr0E7wEs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s4p9uvKr6NjQeq1+yav+0msjRnfe3NAyZUsej8fH/h+61q2Wvz64YdExlen8SaBjMkEmWiy82hE5MtbOt7U6LCCEXkwHujjHWQrRkwH1o9Y+vMZccmcaerB/7Us1NJCJOB8/w+SDgl8+1HhGAQteMAB8O9jecj6EbU6tpeL1ssc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sqIAXPdV; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sqIAXPdV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/mzt88RHtYlUXpcwNuE6POamWRp0IqlJQuafSD24ZMobaqgGsBw7u59eP2QrjVwSXwXQF0QUmdSFjCuMjEMw3rUyrUzBgCGLKg6mNuG8VAs3Q+bHxlAKf2UveTB/uqXuejsG41VoF2uKUiLHKKTOCNx9ivuonvLkZo1vRxT7QI++/Yqyku3rpCL71y+Om+RGWDdo0k1FgGxc/K7Fm/swIqCqlfjsde6eshDdyKqKvksWbQoC5mhjF1hqucNDYjEZS4nCMUNHbFDz7i1i+clj/kBYYF1KA05HyBHG0Dt9qfzooxzwMYGASLS0WxAE0GVuLwjn30Y25cv8NyTM5Tlxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=er4OB7/oymzOSgQkwjn/6eB9c3ZzgjqQ2MgHB3Y4fK0=;
 b=R7O8bl/DzVQRLmigAEkVMRS7xkT6iz4Sj95zxSt8JxHdEHmU9XNW+diP5DHE6nQNSbx0+MZpgabXdV72X0KhiWJFG5PohKuINbtIDZOe1tkfFlxR86ASJb4udPv4vufJ2r5BXKMUDYQjNhylK9/I7SD4vq5BIs5Ttxnlwd/Qb6nJ7WhDvvmXD9+slRF2GiQ537lYAiW32QqEBAQkyClBMpCVxgtWy5cm/5rAlxem8Mor4fTtJW1ia/jaAG1inUVpZDVXRW5aSBPlyhJ2NVQDxxNakiOyeaYIakoGkVqaHPcYuXrAY7yACoUGI6EbXg9wSaOgKcnfexzsUQMCulvWAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=er4OB7/oymzOSgQkwjn/6eB9c3ZzgjqQ2MgHB3Y4fK0=;
 b=sqIAXPdVg92KOR3yXmcgRfSM0VWGa63I/g/PZuwcKwFEtGrUiqCy5YrqlJyjY0cSmfL+cUMp6JWXwK0gWG6reZXFo1W3urH1V3UCJzXi3aUcOh+eBLgg7+91SnYRo9iIgliTFFCsufAAd1ZcrxQHa7P+WGRSj36yBpvBrkwndhJxZernnUNIq6Hbp/F1Zl2Izp5c2hyIJh/N0i62WezN1yMCVLq4UKYTbRXwhw8TZrgLTOdHRaYRFOCS5ZJM8pSML6EelTyaFd5PKosRGOXQeHyGKW2dympGzM5j9CTnY7konluZdkEMj9j7g+N/Qb06gaznYfVAmsiQ5Oi4OEZe8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB2992.namprd12.prod.outlook.com (2603:10b6:208:d2::18)
 by DM4PR12MB6376.namprd12.prod.outlook.com (2603:10b6:8:a0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Tue, 4 Jun
 2024 22:19:20 +0000
Received: from MN2PR12MB2992.namprd12.prod.outlook.com
 ([fe80::b968:51c7:3ca1:8172]) by MN2PR12MB2992.namprd12.prod.outlook.com
 ([fe80::b968:51c7:3ca1:8172%5]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 22:19:18 +0000
Message-ID: <4521d5ab-c0e8-44d5-90aa-72555681219f@nvidia.com>
Date: Tue, 4 Jun 2024 15:19:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] credential: clear expired c->credential, unify secret
 clearing
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Rahul Rameshbabu <rrameshbabu@nvidia.com>
References: <20240604192929.3252626-1-aplattner@nvidia.com>
 <xmqqo78gtldz.fsf@gitster.g>
Content-Language: en-US
From: Aaron Plattner <aplattner@nvidia.com>
In-Reply-To: <xmqqo78gtldz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::21) To MN2PR12MB2992.namprd12.prod.outlook.com
 (2603:10b6:208:d2::18)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2992:EE_|DM4PR12MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: ad62c534-ee78-4c36-85b0-08dc84e46018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qk03NkwrQVJuWlVWaFlPREtWcU1DVzd6Y0wxWnlIdnhRVDEyanR1aGUxNWh6?=
 =?utf-8?B?OWlBaVdCMFgySkRldXk4eHlFZ1Y2S1cwbVpOUnhRSGdxbXFnSzdOOXNPbWlS?=
 =?utf-8?B?ZGtuMEpwMlIrcUJxaW1SWXpXUytwWGhEYkV2WkR0SzJFZ3FDd2hHN0YxY0F2?=
 =?utf-8?B?OTFMNlR4Q2RiRFg0RElrK200OTliVUdicW9XNGdQM0FBTmNaVmU5MDJwMGhM?=
 =?utf-8?B?WmJsVStnS29tYzhMNU9tNUZMUUxYM2UxMmF4NFNVRzZFRm9YVTU2dGlGWHpK?=
 =?utf-8?B?WCtENERlVjNieGVyblFaUkpVMXJHZzZmMHBUV1hhbGk1MVlFVGh0enJFWnRi?=
 =?utf-8?B?SnFtYzFBeHdUYmk2Y0pXYXJ2WkhDeHZPQU1rd1Rlb3dxUnVtM0lyUXptWCtZ?=
 =?utf-8?B?OFFHcWwva3R6R05YQ0pBSjNSYklRWGs3ekFSNmpla2FOTGwycHU0enhlekFK?=
 =?utf-8?B?RkxDVGxmam4zTG85NXgxbkVhNS9OcHFWanFCZW5JQTVVQTFGOE5FMFRnN3VO?=
 =?utf-8?B?ak1oRzNzNyt5M1QrWWJHakJUR2R5UnN1YjZ1TlgwV2x3U2RaM29BMEljYUFM?=
 =?utf-8?B?NWllY0tGOFZnSjZISTIzRTRaOFRqSWVkWndPelhGUFZxMnQ1Y3BHQkdOL205?=
 =?utf-8?B?azl0bENUWnBaY3ZRT2NOTXNVMCtIUysyQ1ovbkxXaURqSVAxUmp4elR2ZjM2?=
 =?utf-8?B?d1RXRlgvK1pMSEJnSDQ5UmdpOExRS0xyM0xvQ1NqVHhMZk5Vd3B3bWNVNXNk?=
 =?utf-8?B?cXY0WjNZY1ozWkwwSm1rS0ZqeHY5aEFjdmRYdm11dUcyR3QyU05uUkxJdmJW?=
 =?utf-8?B?dHVZYmYwMWNPY2RqTEQ0dnRRdmR5T2lIODBCMDBSMXFobVEzOXBWZUR4enBx?=
 =?utf-8?B?N2c2S0pxYVBDeEZlSnhpMitTQ1JuRTkzR29lSVBmZUxpQWhtKzZkVFdtM21v?=
 =?utf-8?B?dFpPNDZnZk5RNzhqV1JLQXFNQzBjTi8yUWRxaGE5bG4rTlVlODlSZ0tCSitJ?=
 =?utf-8?B?ejVlRnlhNEprOE0rdG1UejBjNVlNRkwxVCs2QUhQcDlGRmlVZjFTR1pQZ3hY?=
 =?utf-8?B?MWZJQ2ZxYVJxdXZHTXd4Q3g0RVhONk5wTDliTWdRbEZRVG9oTnoxc3JqR0RS?=
 =?utf-8?B?TDVxY3dXNEFNaG1YUUtZN2MvZkZBSktDRHRhU1MwOGRIOWlKK3dsUzFLQ3Mz?=
 =?utf-8?B?VUYxR0tmZmFGTE8wWlBwTDlzdDc1VnNoSGIyZHdoY1lkUGhsWU0xbUlzVzJx?=
 =?utf-8?B?QzJJMkpLRlR5SXVVQ0hieXdKdnN5dGc5anN2WUFoTUxjTHhuOWE1VXNrNnNL?=
 =?utf-8?B?ZHhObUhmNFQ2U05IUzlGSXpNa1dUWk9yQ1dVekpFaStvQzY2dFpORE1FcTcy?=
 =?utf-8?B?WnVZRDN3bmNkQ0RwNW1HOFV5N29VSDlXVTlVUXhUdGlZeFNCU01tR3d2aE9a?=
 =?utf-8?B?TW44clFMKzdYRHBCWWdHWXhWUjlZUG9FRUo1a2NxQkdVVFd6d2dhajVsZnNr?=
 =?utf-8?B?amtuYmYwVG1QUC94QnJ5NWEwOHArTVpsb0Mwa0VSVmNqWTlEL2xoQlduN3k4?=
 =?utf-8?B?UGcyS0NOVGFlM0FCWTFhVmtoS1h6SWRhcnNxQlUrOGlWVFJTalV6WmV2anpI?=
 =?utf-8?B?alZMZjhIMHd2S0FRM2czYk1FS3VEOXc5SmhjQVloaWUzNFpzZW5kOWxQOXRI?=
 =?utf-8?B?cS92VWZsd3FOWWhKU214SUpUQlljWXBhQXBaVjVvUThpZEphWDArWTFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB2992.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z28rb0w2SnlEamd3d2piS2RnaHBsczRyMGRuZThyY3VYNU84Y09UbDlTd3lj?=
 =?utf-8?B?aFJsZlppaGhIQUZJVUpjUFZzSWdiSDdUUmVwMm1lMndseGw4MjE5UXF5ZGFZ?=
 =?utf-8?B?bTlTUWozL0dQTlRhNmJmZDZPVVFpMnhKdXVmTEpSVkZuUXY1d2l4SUVnN2tk?=
 =?utf-8?B?emE4UmJIZ2k5NE9YSDFRdkJWL2ZaQnRWUHd0TVRxbjhFcUNESWhnV1FXR3N4?=
 =?utf-8?B?UFNJTlBpTkZxZFJYUzFOcTAySkFXam5rbzBhOWhqcHNzVUdBZ1VjcUlMQzZm?=
 =?utf-8?B?ZjE5M2xoSkRDOTk0ak9BdWFOVXZUY2NXNXhqaGl6MEEvcHFvUFkwVGZuSHRO?=
 =?utf-8?B?dCtuQlZMSFRVNHhLUGhJbzgyZVFDUDBOMDJ1M3J4Z2VHbW94SktJc2N3WEww?=
 =?utf-8?B?OE1zay9objljSE45VWFmYkdMR0VwSFRSdWhzZUx3MVM2U09xRnphMzgzMTMy?=
 =?utf-8?B?d21VakVCa0k5ZStYUlBuWFFpdGtXNk91YlpDQ3NzNS9wbWQzSXB4bFF0bWly?=
 =?utf-8?B?L1dHWVh0N1dpNzBZdEZqUThENVVNdFlYalpOR0V0a1Y5NkVpQU5UUm83aTZQ?=
 =?utf-8?B?cXNaSGVFa1FVUnNFV1BhOXlRL2ZFWStGd2tZRVlwcUtiVGZoYm5Ndlg3Vkwv?=
 =?utf-8?B?dFloejFRVVhvc0hEcitHWW16U1c3ejh4OG1WaTBiazFPUW5QbG45c0h6NUpW?=
 =?utf-8?B?VS9VQU8vY3lZc1NxT0pGS056czR5SUdHZ0hPUGg5VEpzWmxCTVZ1SjBnTDF0?=
 =?utf-8?B?V21FTTN5OGlVRTlSVmhmUDBGa2lnY0wyUzJGWmpRWnJKR1BWKzZPWGJrNi8x?=
 =?utf-8?B?b1JNaHVIWkNGNTJsN1ptZEdLTDBUZXVOdFhkR1BaRGJIZ1FxOUV1Q0dQeCtL?=
 =?utf-8?B?Y2pPdkpPVGRnbTF6bkluQWk0OXZQWU9hRHZXR3krM05HcDRGRkZPNUVxcXVj?=
 =?utf-8?B?a1BGUFd4MEpMbmt0M2J6RytCa3lEQm0zZmpQbUxlUjh5dGJZM0MxdmV0eHdO?=
 =?utf-8?B?eU11eFpaUnU1UmtneTVEQ005SFMrOVB5NTNIQklGckd5MWNXZE5Sb1A4T2Vi?=
 =?utf-8?B?NGlDanNLZE5WZU9BN3E3NkxZK3gxQWVSS3FOazNJQmxZaXo4b3dKTjFJU1ox?=
 =?utf-8?B?WFNFMmVjUGRiSXpqREFKdkRPd2MvTnZ4RGlYQWVPWjdtSjBnL0JqMndBWlZp?=
 =?utf-8?B?ZFpXSnV1dmc4UWtFaXVQSWZ3OUpHcEdpYlZibkRrTnNocGp1bHRta2JTc1Nq?=
 =?utf-8?B?RTV3aS9lRjVrZ1dlc0lEVkRPUDNJQzhvZzQ4QU94RnkrYk5sWUlEbFVDS2s5?=
 =?utf-8?B?RVB1bjVPQ1l3MEtyNGhZYjliYjdTc0FhRzdFRW9IMW4yQ0xSRmhaTERQakpW?=
 =?utf-8?B?OHhIekh6Snl4UTNhRU4wc2MyTGFSV3l3OFRZTVJCYk1uZVBkNkRPM2pXQkYz?=
 =?utf-8?B?YllPVzUxakE5Z3BSZWE0SUR1c2RRQmtGOHVRclQyK3hpaldDaWN1T29xeW1E?=
 =?utf-8?B?K2t6NzBYVHhHbUkwSEVpUlRxUmFCdnNyVWtrN2t3ZHhkMk0wSHdPdllCZ0Fx?=
 =?utf-8?B?U0NqNE1kMzRhTExUNGtQUk9zYVVqVEpXcjVTZkhzeFdmdWllUmJwemkrNVda?=
 =?utf-8?B?bkFzL21PdXd2RTBYSjQwVWFEN3lobSt6YlRrYlZDV3RkV09HdFJoRm93MUk0?=
 =?utf-8?B?K0VybjA3eEhTdTdmb2dqVy85UzBpcEd2VWFoaG9sUFhobzJSQUkxVmoxb0xY?=
 =?utf-8?B?VGhHanYxcTFkV3dRaFN0S2U2eW54cldBdkZDZFhTSENlaUNoMjBqaTFqUC9W?=
 =?utf-8?B?M29UOEhldGZDNjlBL3AzcGFGNFhqMXhrZUE0dlBGaHFjRDc0V29EREs5akpL?=
 =?utf-8?B?K1ExcXgzeUtoZHlhY2ZYKy8vNkRydERYUmVYNnFsTTRxYjNmbi9TMDFEWSty?=
 =?utf-8?B?dnRUaWxkdk5nbkhBTDBkbno4TVRvUlhuM09DYmN1WUd0Um45TTFzL0twT2Vt?=
 =?utf-8?B?YlF5Wk5xeUNqVDIwZlkyTGxnd3JNMFV6QUt3OWdvSTdqbk9KblhCTzJQTGIw?=
 =?utf-8?B?cEtqRnZjQndqWDJ5bWdvb1ZsQnN6anBHcWhoZlM5RWtCRU5nRlpiakZOb1U2?=
 =?utf-8?B?cUJTa2xDTHkvelRLdXJnODc1ZWVNUU9EbDBhc2YvWlI1KzVKcVhrMXZhcFNj?=
 =?utf-8?Q?Ky2nllV/pCFPLNRnup43GfE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad62c534-ee78-4c36-85b0-08dc84e46018
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2992.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 22:19:18.0341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DXeL+apNMTah4x7soh4MQkzFVdLODtdgSeojZPpftGJt2XB0TV1qPnR+JwBShrQAlG6Laxi0cghq/i8dqh8YWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6376

On 6/4/24 3:04 PM, Junio C Hamano wrote:
> Aaron Plattner <aplattner@nvidia.com> writes:
> 
>> When a struct credential expires, credential_fill() clears c->password
>> so that clients don't try to use it later. However, a struct cred that
>> uses an alternate authtype won't have a password, but might have a
>> credential stored in c->credential.
>>
>> This is a problem, for example, when an OAuth2 bearer token is used. In
>> the system I'm using, the OAuth2 configuration generates and caches a
>> bearer token that is valid for an hour. After the token expires, git
>> needs to call back into the credential helper to use a stored refresh
>> token to get a new bearer token. But if c->credential is still non-NULL,
>> git will instead try to use the expired token and fail with an error:
>>
>>   fatal: Authentication failed for 'https://<oauth2-enabled-server>/repository'
>>
>> And on the server:
>>
>>   [auth_openidc:error] [client <ip>:34012] oidc_proto_validate_exp: "exp" validation failure (1717522989): JWT expired 224 seconds ago
>>
>> Fix this by clearing both c->password and c->credential for an expired
>> struct credential. While we're at it, use credential_clear_secrets()
>> wherever both c->password and c->credential are being cleared, and use
>> the full credential_clear() in credential_reject() after the credential
>> has been erased from all of the helpers.
> 
> OK.
> 
>>
>> v2: Unify secret clearing into credential_clear_secrets(), use
>> credential_clear() in credential_reject(), add a comment about why we
>> can't use credential_clear() in credential_fill().
> 
> This does not belong to the commit log message proper.  Those who
> are reading "git log" would not know (and care about) an earlier
> attempt.  Writing the changes since the previous round(s) like the
> above paragraph is very much appreciated as it helps reviewers who
> saw them, but please do so after the three-dash "---" line below (I
> can remove the paragraph while queueing, so no need to resend).

Sorry, I wasn't sure what the convention was since this was my first 
patch to the list. Thanks for fixing it. You can feel free to properly 
wrap the last line of that comment that I missed too, if you if you like. :)

> 
> Will queue.  Thanks.

Thanks!

Rahul (CC'd) and I had a series of patches to add something similar to 
the current authtype system but hadn't gotten around to sending them to 
the list before this more flexible mechanism was merged. It's nice that 
this worked out of the box with minimal adjustment.

The credential helper he wrote is specific to the Microsoft "Entra ID" 
identity provider system, but hopefully it'll be generally useful once 
this stuff is in a git release. It really cleans up the authentication 
process over https for sites that support it.

-- Aaron

>> Signed-off-by: Aaron Plattner <aplattner@nvidia.com>
>> ---
>>   credential.c | 19 +++++++++----------
>>   1 file changed, 9 insertions(+), 10 deletions(-)
>>
>> diff --git a/credential.c b/credential.c
>> index 758528b291..72c6f46b02 100644
>> --- a/credential.c
>> +++ b/credential.c
>> @@ -20,12 +20,11 @@ void credential_init(struct credential *c)
>>   
>>   void credential_clear(struct credential *c)
>>   {
>> +	credential_clear_secrets(c);
>>   	free(c->protocol);
>>   	free(c->host);
>>   	free(c->path);
>>   	free(c->username);
>> -	free(c->password);
>> -	free(c->credential);
>>   	free(c->oauth_refresh_token);
>>   	free(c->authtype);
>>   	string_list_clear(&c->helpers, 0);
>> @@ -479,9 +478,14 @@ void credential_fill(struct credential *c, int all_capabilities)
>>   
>>   	for (i = 0; i < c->helpers.nr; i++) {
>>   		credential_do(c, c->helpers.items[i].string, "get");
>> +
>>   		if (c->password_expiry_utc < time(NULL)) {
>> -			/* Discard expired password */
>> -			FREE_AND_NULL(c->password);
>> +			/*
>> +			 * Don't use credential_clear() here: callers such as
>> +			 * cmd_credential() expect to still be able to call
>> +			 * credential_write() on a struct credential whose secrets have expired.
>> +			 */
>> +			credential_clear_secrets(c);
>>   			/* Reset expiry to maintain consistency */
>>   			c->password_expiry_utc = TIME_MAX;
>>   		}
>> @@ -528,12 +532,7 @@ void credential_reject(struct credential *c)
>>   	for (i = 0; i < c->helpers.nr; i++)
>>   		credential_do(c, c->helpers.items[i].string, "erase");
>>   
>> -	FREE_AND_NULL(c->username);
>> -	FREE_AND_NULL(c->password);
>> -	FREE_AND_NULL(c->credential);
>> -	FREE_AND_NULL(c->oauth_refresh_token);
>> -	c->password_expiry_utc = TIME_MAX;
>> -	c->approved = 0;
>> +	credential_clear(c);
>>   }
>>   
>>   static int check_url_component(const char *url, int quiet,
