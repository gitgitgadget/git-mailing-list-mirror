Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1A93F9F9
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 11:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.136.64.227
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710328059; cv=fail; b=sAlN5LdRkuqoKdbGJ8UiWaR7tkf7nG6HDi17gbSaZACyFCAVINMNQEVlrMFYWmgBiyXIw5QQgXZwKY+LJpRbSjWOlE5jjfCUY0GTJJe4Htwj3UkH1vVKNqQ9fCUJCNhGj9miIu8sSrPKgeg3MxQd/gMEeS/626CV7goqIcZzPZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710328059; c=relaxed/simple;
	bh=2CTjdJzescOw+ZqlWOGhHVC6X9Z7iLwDqdvjEQJnHYU=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=Tr5cndL+OWs9SbHq3Z0pC/+rRXpk+D7zxbanA0/V1BllHZ6IHjhsxfl2ei+J8Z95B59r67ZknwtDWG6nbNWRxa7MRgksSj8bUTgXXBadoKZ6TLw5gMebrLxW5w4MpYXI6z1AV9OQ3/7Gc9HE43/ZX6kAwPVotanCIrjT800craw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=innomotics.com; spf=pass smtp.mailfrom=rts-flowmailer.innomotics.com; dkim=pass (1024-bit key) header.d=innomotics.com header.i=michael.osipov@innomotics.com header.b=XQRBDOu9; arc=fail smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=innomotics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.innomotics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=innomotics.com header.i=michael.osipov@innomotics.com header.b="XQRBDOu9"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202403131107261071e516f12faddbfb
        for <git@vger.kernel.org>;
        Wed, 13 Mar 2024 12:07:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=innomotics.com; i=michael.osipov@innomotics.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=J1nTAlnCLIsATnFjCW9Ip+91y8HGClXfJnTz5pJNjzE=;
 b=XQRBDOu9tq/xkLU1r1IfQpTCxDpWSpTSoK7qwYicN2RWX8fvkFTJUL54R/WRx0DmeY882K
 CyvLbUB4ATw4yqeAQwe9g38hUUHvgZ5ksaLXQmYD10b0csPkYdFV+C9VPawcjA/YcE9bsUFt
 s/UlnLfFkMIICxWF8U+e9K3rnpegA=;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQM/HhPQaGwuSSr8yxiAUvvLPi6WoK43VJLg4wTBR+sbwGDBQW9hYlWm2Lvx5KTYmFarPZaaM+owEVQEVkRPGgN+66s/vvy1I1hP0/Y+D4OTVfCrnXiLC8xUpfjpiiYCTrI2kaLm5Hwpux1ZPvlAitIEsD7IesdHIS0uVJt7cLeKWmeT35lVDVJLuwLKIHaRmmA9nEBEnWz032z7wiwYUxlBdrhv0GVtcgqXMb/8/2BvWMyNFCVYElmK1tc71dxjPNgy2Y9wFJ2fxEWr2+YI/di1rqbC6QC4CVkZbBqxRUC8qlm6oHy7dBkmevc0lxGcesiogLvaK8O3I5lKN2Mdrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1nTAlnCLIsATnFjCW9Ip+91y8HGClXfJnTz5pJNjzE=;
 b=Oc5Adk6ewNgudYJs6SDoztLVkzt8tgWugxr7iks8DMA7QpVg3iJjAeBRs5yt/qkfQvqUXeVBy6ttLh2TjpirczgmpbuirKAOWRXXbb2wzF/nD3I3XmhvCh/ler1d1TIPb2QEIQRrebleXK5jb2pnBTrqsmWjGxHtK/51pmpv/2/IfC+VlPMNWTuwSNIvr0nCmO4eofiHhtL7E1HgfWUyn+Q8yrJYt0I9RhXXjuLCoc6RjSrQvCIVYKCApX+apuxFtciPA4Q2G16cbMED1mm6Y3+BRj4AtXH1K3a4vQWugm58y0Mm9T4blYkCGLGOBTzU5DDjlUmrke4YofFJnv91gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Message-ID: <645c8253-f1ef-410f-8284-7d6c8b6db601@siemens.com>
Date: Wed, 13 Mar 2024 12:07:22 +0100
Content-Language: en-US
To: git@vger.kernel.org
From: "Osipov, Michael (IN IT IN)" <michael.osipov@innomotics.com>
Subject: bisect does not respect 'log.date'
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0330.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:87::15) To AS8PR10MB7042.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5a9::19)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR10MB7042:EE_|GV2PR10MB6114:EE_
X-MS-Office365-Filtering-Correlation-Id: 13a7233d-4ca1-4193-b0d8-08dc434dc2f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	aSkACwrFc4ZJ3WmvLrOJN4gJnGHO971VYG90WMo0/XTWz62ZH6WKqft36EA2d5Gcf3yfI/THGtLepy0m2KWBhDCQaeWfcno+6JeBpXB5xq9Nd7zzJbHrjkZcMrkqmOFmSQZSO7QdC7+BhwH1RhvwaOiQpIn8yn+rWGQ+4GLXsrqK6flMBM05YKxhrGVd2uOGWpNr4AI96K/AcufU/5niN83j2QAydqlqrUxu5GNuLobvkli7IV6pejSfxyvRyuYKzuKuLXvNi5Yct51v9E/waRtweFDltGkmIVvgjsqjzx2ZxO2mbw1pqvgps+2a0sq1ghwR93hhHaD0QzjOZg1r3+4e3jnsglKOHsXgpJ2hPEtaA5D1U1NLF5qIO//HyXuVZexChH4KHKG6Zs1JYVhwI9fYUFi37JHzO169h3WCWKiWtdYug512wZVAB/qSRUI2hoRMhJIrTqF+WbApgRBr5Wo0r0hxNr1WjW3i/ZY9u+41Vixe4Ua4c1kQanTxoK7uWNiTkX+AOOIFbFqyE/iq300GlM+K/VD9vdOxZHSZjY1DWEk/2ARi6NotH9jEto25nKAVYaPiefjVYb2d5OBTSc8hGizhSGhtwYpwRj1Ool8F195uZG7EmUWrJsnO8Kjqp2YA70quUKeGORtb1rqV/wowiieygqCqnQG8VHQf7YM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB7042.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?US-ASCII?Q?=09bTMLOOAJQg3?=
 =?US-ASCII?Q?v8viarby8BXzm?= =?US-ASCII?Q?v7PV7e9RzmLeg0OAqts089qHM?=
 =?US-ASCII?Q?7hRrQ9IJvZ/UWsQEQoBbhUk9gFNNNHmQ0TB57w5ygWFmP2aXlhk?=
 =?US-ASCII?Q?vw1F+gNttGTKpIGxDCqIrEx0HZkK+luOBhFMYymtQbF3QgxplAZ?=
 =?US-ASCII?Q?dyiy3bRj/TIERcu232Dih81Jqw0rHsnF+xw5K0Xfx1fxiRcsZNv?=
 =?US-ASCII?Q?WA8HxJv3NEeLfzr0jILrkCfYOcfy21y6C3Xnwaw0BbWU6FRdai?=
 =?US-ASCII?Q?PNvpcnWTZAF3fPLMJgPyioG50OTh5M/d/W6JjkLchoHQSkhFJTD?=
 =?US-ASCII?Q?lL1wGX3wnoVLFsSF2ucBMFGGSKJrm/noq3iJ0rIBvy8Y+O24PWn?=
 =?US-ASCII?Q?zw4MBRcjsKLL8jXL5C9b50/UWvgdXzeo8ghmvdPdkALMU5+sXMr?=
 =?US-ASCII?Q?1sVtASOTb7BzgS9m76VuzTrG8n22MgkMf5pu2FWVhscP5WTCVO?=
 =?US-ASCII?Q?PiXGtyoqJncBDP7nF4P1Jv7HazZVqVcyqiHZ7J3gNpjKTAFPNBJ?=
 =?US-ASCII?Q?8ca20VtVTntagQbRlFX7nRnk82Gv61KYOvCmze9RJWVPKWSuoQ0?=
 =?US-ASCII?Q?9r2oIasrex+jl6qZcwf8rmHqUFk7tGGYoKj+pUdU4bOSi3KWbDF?=
 =?US-ASCII?Q?wxB7RbdHERbFWcYB6+kuxNNFS1EZOYHYzrDgZRXRzRwk7+Xs77?=
 =?US-ASCII?Q?mqWvaM4V+dHEYc7CNImdPtjTXtkN9sY1eK8refBeTLdFiOM49AC?=
 =?US-ASCII?Q?BwgXQ76U3PciOQVuXe+7VcrQYoqu3rjR+cN4DKje3fQTbZSMFYx?=
 =?US-ASCII?Q?ikfbLfJ4h+92ymaBR0iZEFHYNbN9/Tll2SKQtR2HuSSxiVJ1jGC?=
 =?US-ASCII?Q?JxqMdpIRGLYZZ2YSI5Yi3Zax9k/811okT/DIVQKINotDXwzqD0?=
 =?US-ASCII?Q?5hK/OcGbssHwcDISGGbC/6bIPGhGFaBF0SagvKIOB6VyllXzOvX?=
 =?US-ASCII?Q?bnaQ/F3LWlYsQKdctsudd+MD0vOagLDTploy93a2lcmHEhRbwCo?=
 =?US-ASCII?Q?JUQ75hV6AcCJldAYptRLNa8RwBFHJdKDWvT7wVDXdggukvj+c5m?=
 =?US-ASCII?Q?dtVcw7Tkfe23bjHUHZA2BKz8NvdOAlmaO9B6z7TGKrYWHtHuHF?=
 =?US-ASCII?Q?e4GkOJLs1ZZI5+8oAdPLt9FpP42frDtYJA9mVmKB5QkSX3bHaGs?=
 =?US-ASCII?Q?95BULL0yx5TqZrIzDjPM8H6tgyeMJ+pHAylLHygfBeRNr9dZrQP?=
 =?US-ASCII?Q?fBbMDXaPpDjNJ62lhLeHSV/zlvYvbdoJdTPLjaTw2bAzN8oZreg?=
 =?US-ASCII?Q?sfMsQ+gMU3lVOH7l5e4B4oyYEmz0J2MZ5IKu6N2383XaxYtiXn?=
 =?US-ASCII?Q?RphKongQxfB9EgMPzRDAnGj1muTKhC2sRGY2cRJOgiz+NGxSWsn?=
 =?US-ASCII?Q?r0ENDTlVmFvxu+7HE/7mUe+3COyg1aH67DweuPZcvDKLtCK2WGi?=
 =?US-ASCII?Q?5B3xKYMsVQBr6T9ThnUjHt33TtivwRmAlgWwLpK5M+LCNN6M5V2?=
 =?US-ASCII?Q?H0TsvRJRBQSCCPtISV+A64KyxxsLuGUeOh00RXvgknWgVw7IL81?=
 =?US-ASCII?Q?qU3cr8cWGhsU1kQGkyhhqE4KpOqri5yJDF6v2AbSMa8hZV4dxt1?=
 =?US-ASCII?Q?9dvBDoMu3Gmw6NfWSrEKw2SyPq993DjYl68QeQoimMWPSF3veMA?=
 =?US-ASCII?Q?yjHHv9LjFesg64bV7JXAfOFGakZK7ftTr8j/iA0w5Bc4difiQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	tajA6EDFdgQRjfoYTkA08TMOtxgtePSe6cgSj2jfp3XH68LuOMFGdIuvofs2QLdC/eIeWm4fT4SVh88Nd3jiV/XTU56/6tW/9898A0nyV3pEsCy4B4L4amKm3NnPSA8hbNP+ezXU45D7ky2hOKbfe0l6jBPycuOeGKXd3bXwkDOFAFK/3DTTbHV4mUGf9jPcgSIK51JnXD39Ruz7SDCD6rLREmfBPddjl49XU+ITAc0WWqG4rpZ8HMSkIkxxyF/LAKxf99PAPs949OGzrK/2q6tU6lVBTEmVF8/+xwTTpjGRz2ewMoMdY6Ha7TMoau3B9b2H9+128+aM6qYaouCA1/h0NlH+yumSHwFz1m4banYYUNozXYNH2wWr2ma2+F0EyuVHX5/BC/47ZVlG79V3QBRruTmhJ5eIbVwTtOO51WxWeXOxeHrzM08M+ZZlYxjGXoF8bcL/TXTvt/tOUglTI31UUf38OoToTM5sNdzlmUNG82WARCFLa3578n0mCJ/gp+hCjITLfCMUG/oKwnpUy1B3MIkaaToCG+PHNwwpUMOaDKesHcADWU3Bzvr0K3dwDBlpRpfxn94TR9B8DtuBeJ8NDcqp4i1lH3J8s7W8VNZghaoqWH5JlieeGH5FwTw/
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a7233d-4ca1-4193-b0d8-08dc434dc2f0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB7042.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 11:07:24.2874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /YccHdh0gloztlvkhq7wbEqva2NKDqp9M3yYNFqIItBHlqxjzkKW3yoQq23M0WQ+Sv4kieOvM7pkf1FFNsD+Bc1W69jUoHpvoi+kqBmIytI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6114
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-7515:519-21489:flowmailer

Folks,

I am running git version 2.43.0 and consider the following config:
> $ git config --system --list
> core.eol=native
> log.date=iso-strict
> color.ui=auto

So date output looks fine with 'log' and 'show':
> osipovmi@deblndw011x:~/var/Projekte/tomcat-native ((ba1454e15...)|BISECTING)
> $ git log
> commit ba1454e15619a44fe66d86f59c766c0cc25323eb (HEAD)
> Author: Mark Thomas <markt@apache.org>
> Date:   2024-02-13T08:27:43+00:00
> 
>     Fix link
> 
and
> osipovmi@deblndw011x:~/var/Projekte/tomcat-native ((ba1454e15...)|BISECTING)
> $ git show HEAD^
> commit ef40b6d00c4bdaa23960b5dc0eaac28cce758d29
> Author: Mark Thomas <markt@apache.org>
> Date:   2024-02-06T16:40:25+00:00
> 
>     Update minimum APR version in a few more places
> 

now let's bisect:
> osipovmi@deblndw011x:~/var/Projekte/tomcat-native (apache-1.3.x =)
> $ git bisect start HEAD HEAD~4
> Binäre Suche: danach noch 1 Commit zum Testen übrig (ungefähr 1 Schritt)
> [ef40b6d00c4bdaa23960b5dc0eaac28cce758d29] Update minimum APR version in a few more places
...fast forward
> osipovmi@deblndw011x:~/var/Projekte/tomcat-native ((ba1454e15...)|BISECTING)
> $ git bisect bad
> ba1454e15619a44fe66d86f59c766c0cc25323eb is the first bad commit
> commit ba1454e15619a44fe66d86f59c766c0cc25323eb
> Author: Mark Thomas <markt@apache.org>
> Date:   Tue Feb 13 08:27:43 2024 +0000
> 
>     Fix link
> 
>  xdocs/news/project.xml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

The config for date format is ignored. Is uses the default value.

An oversight or bug?

Michael
