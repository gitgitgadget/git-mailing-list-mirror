Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EA630648
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.136.64.225
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710329881; cv=fail; b=aZYfgu70kwYwcuD61Kpa4uklEmelZY+5wpPk35lltCIMRY5B56kZrJhMgnlyC8TI5dmdc9pxdWKjIkiVqFRoZ659ijq9yZ9QvcZ/qDdKEYY8EsFqkgGjHFxhlGaRqrzxKAXvCjxQEeRtOKss6iLpVrtIoFfGWHSAIfZ43koxEN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710329881; c=relaxed/simple;
	bh=eLXCBIg95xXQ2biX6j9OMFOpPvKxficPvzcjmIN3zp8=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=UIocE9fXDc9GDsm2YPjcazQlFvpCLLegkhkPi2z8HBQYX3+h83GiTlv0uIQn35qSwjgCT4ONxBES7PPZg4L+bXKt93rypcUSOJ7aXeTvylcFzSOy9XGvRKZMCx2Axut9S9K9i3y+NKSvNEjytn+8PeyLXBROAIGcFvGnTQJBto4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=innomotics.com; spf=pass smtp.mailfrom=rts-flowmailer.innomotics.com; dkim=pass (1024-bit key) header.d=innomotics.com header.i=michael.osipov@innomotics.com header.b=KjETqnGz; arc=fail smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=innomotics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.innomotics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=innomotics.com header.i=michael.osipov@innomotics.com header.b="KjETqnGz"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202403131127406bc22c42d3d2338579
        for <git@vger.kernel.org>;
        Wed, 13 Mar 2024 12:27:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=innomotics.com; i=michael.osipov@innomotics.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=TzGSjMovlg8qaOXir6suj0qODaIHFUXq0ud6sXa28I8=;
 b=KjETqnGzFnAq0LR6tMPCMqDI5Kt4dlEaRp4XWzc1AjKbEN9jiqgwbDdBNZbokFZKJM9Dyf
 ESAAfRIPD/aL5o9pgzy8UveEEL/HTQdo9GqewGXetDej5lwgqX00H5i0prL0OMO5u8YkBS0d
 UGuXTQS0pVHG3nAwuTw6yIfv/iGfQ=;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRGT2YlLYjeu8gye9FYLbQZdKkXEZOEn5zxZv5oK2QXGf/wIB/tWIqZRezXc9afrcotzhC8kkiF38Fm0rSw0t6He2x1dpnvJS/7KGuB400IY+Jf+3TvZs4wHog4yRu3BUhWb+VRJXo5/fvHipL/uWibtpySVUMmv1rSthYMXjv61SIKd17mu0hE6RqR4dIBBZsIA5SxkLZHoKqJ7ac0ItYbESjfVGhoqkHbNpIDR/V6uV+7q/uOd9cSDjp8IS1igmuPzCKhJnkueZSE1PDzJnW3tvy48pTaHV9L27uknLtwMXgGbfmJsVDKGDKPwdl6HJkLYWb6maXGXJfuHRoOFQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzGSjMovlg8qaOXir6suj0qODaIHFUXq0ud6sXa28I8=;
 b=mUj+W7AJ7ZEFtHi75ocZYV6FLpIH4RKA1kQa1D+rt606iIXuy2D0xNVxk2K9kL5y1Tlm7C/O2ptGXMuSuVexbUwVs68rdOdqoJplDnm5fxs66CUeoaWzPGJ3Cnv3+WKbczyuL9EGhBGYotkYdicdlbgSc6/ylbV4FM6+zrFY9zwMP2z3OyQ+gy1RIFafT4WMPFiWgcd9RYT9xqEsU2YFUY6UP8h76ILYME9dHnDeasJoDamPB7J5zZxA4ekRxR47wZw7kTTkBKNh9MUMfuTZvaN8CLOWfMnqH+M/+BKVtyeRAwf3BR7HXYkhdlxC0XE0r5IyahvE+L2bFcoowaZOEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Message-ID: <410d458c-ae5b-40cc-9c8e-97b016c74a76@siemens.com>
Date: Wed, 13 Mar 2024 12:27:37 +0100
From: "Osipov, Michael (IN IT IN)" <michael.osipov@innomotics.com>
Subject: log.date 'iso-strict' does not comply with ISO 8601-1:2020-12
To: git@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0287.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8a::20) To AS8PR10MB7042.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5a9::19)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR10MB7042:EE_|DB8PR10MB3276:EE_
X-MS-Office365-Filtering-Correlation-Id: 2164608b-e7d0-40fa-35ae-08dc43509714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4BMn09MmX9IeJTX2rizXVJ9jhIOhZdAcdyACgwBapj5BUJWp+gI9tJcOQriMHPwM6d6wurmppscothx/4IcG0+HMR7ys+3HSjj5pop1vT1GXWlmhrLfATvJPzCSGv4DnDcX2Cm8XkUfMi9qtRafjNXx06zzzb7F9Yw2j/tllyc1hix73reNFQ7+fpnoORmcF6CrX5U97RjD+gNtA0D9Caog4/30Ca+RHK83BwPABYSGbCNBu8xG0KO18ach5ysdr7FvdmcCn/JEA2QLCAZQnYK2fzZbx3okswZR04aCbdNCSj7kJ+MkT7H171aQbZy/p/ps0CkarWwySUyw4iUyhjkKCWJ8El8PmSRS436TTVeL5zbwLZk30UGnufBeDFkPzjVDnLbaay3Tn+GSKDEwKnOqporOCjfv2w91RX0smr0txDVkemALJShy0pJuik11ZSPlLP4LUgLTa45XYXhNUC3xPSQZn/pNINIdymaLHSxN3M7H5T2QldMxAPOlVn/mXnJMZie3DTIkJzCeWkmh8Z2QcX1DCsmNOK9TYyM9xHKaqasTle/ruBIeFpqZOgVYGfk1ETDKjZLJ7NEhtoFbmjuBF/bLI6RR4NuJeW1T+im6jjecSvLv3/DhpnGXMELcH
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB7042.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?US-ASCII?Q?=09msmdVrYerRu?=
 =?US-ASCII?Q?RIBGSOHRyOMsB?= =?US-ASCII?Q?rO08oB5mS1fvjDI3g1yoGwz4G?=
 =?US-ASCII?Q?1/7qOTqw2aOcqaz4E+gdszvYJo4rCAOvLgIud8N5OMb7neWOums?=
 =?US-ASCII?Q?2H0AEzG4OjUcrC+sLGS6xyo7pDl3w5ExHpCy7E7VysG2hAaHg24?=
 =?US-ASCII?Q?GJGMvEWBwgBKQIvJNMvaB+qDBQu2GUPvPX6+k6yIU97CC2jp4uR?=
 =?US-ASCII?Q?mdy7PPEVAOYYs+7IoWTpxhBTpsUUOd4DrwAMCX3xwa7TxNV0I9?=
 =?US-ASCII?Q?sbzw81C4FdKf7gCdXgPwE44v8AdUgpW5kwsOv0d1o9eXZbMBOwg?=
 =?US-ASCII?Q?OskdoLB6bc79jWHx5df8QiKUfj7+pNAqJ9IqeyjF+kDLZauHaOO?=
 =?US-ASCII?Q?3Iq07kW0bWUkMyvet7D/K9dzCumxoVbpxQOVf+lW6xRpOYFtxaz?=
 =?US-ASCII?Q?wmXKapbrW1g/k75P34amqkWfcl+yMewTjF5kmqCOceO3tew797?=
 =?US-ASCII?Q?YvV9bAacrZndklR4vyc3llipsihMxRC5P48nhTSq0w5q9Gub+3y?=
 =?US-ASCII?Q?0J5XSsJ1sviWF4i4DUiSIBet0NFYzc+JgwE9npDY51PScWzrHLy?=
 =?US-ASCII?Q?nZxt15WkPiBm0psLXTzI23wmN7pv6ztKbBc9eLAJwZtlMOD6S7O?=
 =?US-ASCII?Q?MWa+L7dRA5Ma0NYfIFrnU36geS7y5xDPXsTMbTFgVMNM29DndL?=
 =?US-ASCII?Q?uRJv6sAgOHwaRJSrNi3honVleG2iROu5xpUrloFBaIjr+04Kiyu?=
 =?US-ASCII?Q?twWU+FkxPd494Qon2536PYtjmq6ZCi5ExQga78zZiVZEwqzOE0a?=
 =?US-ASCII?Q?q9GkAUV+IvESpIoARXHFGz696UyQN6MCfr6fsHQjtevFV8BrPoJ?=
 =?US-ASCII?Q?9jX8kJsZLcjF3RVgOqDcryDDhZ10m/klBazlgZJ+N4JzAZCV3K?=
 =?US-ASCII?Q?EK6Cuf+eNWL0Fyo4bTqA+0etmVYQTUlNF6UC116Tv8QzVl6fQsK?=
 =?US-ASCII?Q?nOH+D0v4wTwUCWlUU2roXKk9iG+oG3tSEkvrSlakM5XJkIJJxBr?=
 =?US-ASCII?Q?4+Sf5BpPyZyVKEXfQ3i+OJQ4+k8SbppMDgZApdDVpdio0J+S3Ae?=
 =?US-ASCII?Q?GUB715T504J/R20ponDDT8QY9yXjWNQplKTOtMin331I7DIdyh?=
 =?US-ASCII?Q?Ly6HtBGC7sGWeiFQlxzsteYoc8BxYWnj+RjzNQjrCRAdFk8clqT?=
 =?US-ASCII?Q?WzRN8dwK/BJJntOVoyJHJpG7WNnLn0R8t6QbXNFWBUCFwpkSv2T?=
 =?US-ASCII?Q?/YwaL4jIKKHWtjTz1Vq48LPoP4MNZ7ZXfcWw4lujzmxi9OR14IF?=
 =?US-ASCII?Q?vitxhuBW7NKQrA+k05Sd6RVoXqTknDYJ4Pzmp1z+8hhLH1gwS0?=
 =?US-ASCII?Q?PDen2JYT52WHsAu/8681YePG9YrUCxKt8Hc5ur0tJmdRay3GpJw?=
 =?US-ASCII?Q?EnLzGH8VOoNSO+kt7MzHp4WlGNZ41cHWhNbnlYA0wsfqRq0PRyC?=
 =?US-ASCII?Q?+5sz7QshfzVFq9BvwVxeL8c1hJTy5SSoVgzHlsCwaa6rvgqI2JP?=
 =?US-ASCII?Q?gpmbiK2t03bBsQWXDHeZzkTT0PruoG37pcPE6D771nJ7tRGIDey?=
 =?US-ASCII?Q?1+Hwgp5P0mn5N7QwuxfTL6Dyu5o0b7ikIqmzA/rCL7MZwSM+umQ?=
 =?US-ASCII?Q?DWpzxg7UbBARTowTdLYitFZfvA8sMfjUKvZw05ZW1+L2w/xX8dy?=
 =?US-ASCII?Q?JShjB+Wj/uAGSrzw57bkalRvJjkipgEXNGSLs92+am+JuXkAg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	EuMdQjLna5JIXzXnRcx1cOWHmVyWdnnMzc3aauWKOk/h7j4AksSgTEpSloJ7rbCKWj7PJbA+8UoNzjKbgGanQlPECPQK+xat7TS34fUM1vzhSy0LqXDgALYDx2EGkw8pB3IzqUtekYxG4SlXBkqvW16JzHg27woxjLe3t1FfhR0VbHZaqGKojGjE/joNsTPgHuWy30/Kg+ZFnGlgcp/foa+azGWsTBGQ81xLvQsB3xh8TecrAN7ECsBjzP8PiPVln2X/rNJthuQhJSdd/losFkSVU/+bEP8fAUiWkIVnOgyJgTCr35zDDwI0ifGF6+z8N6/2s54YStuj2H9F7ZDEY+kPwnmKphKXtPdLHqMQV5QcGbXNT+BcKBgINqMCYETwe4A+Qcka95OhcoqSZWPHDm9KhK3bdIgU5GwbW4Ww6fXIqDGurytCjjquVoNFMxCD9TD+IdkzRB92cqcPpuNgfNlQk0pvDecESpefbwk4kfhGdNf5Vqjbtnbgcdr09ZKqo8Z+lWY4F052xMzEw3cHTzrBoQwhHzf7m44id7KtmyZQSAkqnjOzTehCHGFFhHyZOYk1w3TlA/C/1YACIP3el3Ww6QGG+8Bosh+wd1rSYlOLG5knMWGo3j8X8aIaJUv1
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2164608b-e7d0-40fa-35ae-08dc43509714
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB7042.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 11:27:39.1806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y8kvpp+VHnA085IeUPSkcHUFXeCJLAwITbgpFcFWC7wy5OcTk+GVB18REKBt+wuohqCF4nK078UrCtatn7zlYhvKGQckvcb+eg3tpnAeUIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3276
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-7515:519-21489:flowmailer

Folks,

I am running git version 2.43.0 and consider the following config:
> $ git config --system --list
> core.eol=native
> log.date=iso-strict
> color.ui=auto

when a commit happens with a zero offset the following is displayed:
> osipovmi@deblndw011x:~/var/Projekte/tomcat-native ((ba1454e15...)|BISECTING)
> $ git log
> commit ba1454e15619a44fe66d86f59c766c0cc25323eb (HEAD)
> Author: Mark Thomas <markt@apache.org>
> Date:   2024-02-13T08:27:43+00:00
> 
>     Fix link
> 

This not right according to the standard in the original language 
version, namely in sections:
* 4.3.13 Zeitverschiebung (time shift) (roughly translated from German): 
Z denotes that there is no shift from UTC. It also says that you either 
have an offset or use "Z"
* 5.3.3 Uhrzeit in UTC (time in UTC) (roughly translated from German): 
...the formats from sections ... must be used followed by the UTC marker 
"Z" without space.

Throughout the definition neither +0000 for the basic format nor +00:00 
for the extended format are used to denote a zero offset from UTC.

The offending code snippet is here: 
https://github.com/git/git/blob/945115026aa63df4ab849ab14a04da31623abece/date.c#L344-L352

See also Java's Instant class [1] which is based on ISO 8601 as well is 
Java's SimpleDateFormat XXX [2] which will *always* print "Z" in case of 
a zero offset.

I'd expect Git to comply with strict since this is why it has been 
introduced years ago instead of modifying 'iso'.

Regards,

Michael

[1] https://docs.oracle.com/javase/8/docs/api/java/time/Instant.html
[2] 
https://github.com/openjdk/jdk8u-dev/blob/fbb3392d744d1572239eeca082d7365a03897b8b/jdk/src/share/classes/java/text/SimpleDateFormat.java#L1291-L1306
