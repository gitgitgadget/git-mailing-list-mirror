Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17AE57883
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 19:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.136.65.226
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710358197; cv=fail; b=MpzkQjjbLHQ+PZYIViumcLbKD9HAqrWuxaw3/VnG+iJS12lEjhx2C7BfVaryP8neGuUFnG82yFI9d2GhaXDkeXB86RjDd6mlXDVuZDJrXTbU8bcAe38tudOPu1EJ77rWKlkzQwhN6FuhCh1O3gCSpbgZfuWcocRmqqfKrKzN4RU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710358197; c=relaxed/simple;
	bh=QUI2n7p9c2N1RJcpvrzxYqf4ju/JoFys6Ays+YbYdDQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=baTklRK6Thnbki2s5NkStTHOF0ubzUOHC5g9L/2c8l2TxBX9Dgxu7LD4JgAUE80T+7lD1EkBm40kigIFiGJ1P21r9POKnLXWoGkJV02pZLiSLfvO95TIemEiiqk1BHg2+6WU5Y1GiIZTqzYxbzFrrzy7DMU1tWQ7wHfNUqLWQa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=innomotics.com; spf=pass smtp.mailfrom=rts-flowmailer.innomotics.com; dkim=pass (1024-bit key) header.d=innomotics.com header.i=michael.osipov@innomotics.com header.b=CSQN4mc9; arc=fail smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=innomotics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.innomotics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=innomotics.com header.i=michael.osipov@innomotics.com header.b="CSQN4mc9"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202403131929526a1ff9d5c5bfa0f672
        for <git@vger.kernel.org>;
        Wed, 13 Mar 2024 20:29:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=innomotics.com; i=michael.osipov@innomotics.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=MQacqbx2p96CNLAy1d6mKgXDvsaDkzHCP2rF56COIhA=;
 b=CSQN4mc9iw+gZNs24uLDEh+IW/GOkteOAjtmfCK0vy06CJG/Ga2bbztS3Hg+FaaVY76IM3
 WTaUB1Pl5xrUQW898K3Rwi9yQJX008QZwwMAtWH6IN5vWDdpRHbl0y9QpaA/tIkoL44mO2o3
 TbOC6UpUinHbgrDWTWOAGLuOtRtK8=;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hX8AHeYHWetT2vJ8vdXy+I1ZBFTmV0qGOCz2xIfY+3n21AZvnj3WHKC42eMo75rEHgpZgD/Esc4qHl3jvc6tyGIgUr8uiF8bGgHA5I5dne8C5Kgbzv6d1bRwPdsW/vvXNjZmtTU/K7ygQJdqNLomHUQICyG9HmJ4f48qO7w3fH3GnJXgHpaOSZ0+6rTAxhhNwgqhPqq/CxOY3PChBJ/HbpcKDFArb2Z92yPosDWm0NAdxSROQGU40Z1JavyQ3pPTdKfNH8daAtuE9zYu1d0JxFJcjGkkcUwjVuCXY8YhbORi98wCE4qQ7A9uhVTzaIYMfKGME+tYEmrppmOjffGflQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQacqbx2p96CNLAy1d6mKgXDvsaDkzHCP2rF56COIhA=;
 b=GRIoT339sTPixOyguyR67v0djbM87xU7WCXqW2SSnsefwDms1PPEH1fTMqHqgrZC1Wl99Gse2ZR0GN4J9xroHZuio1oqwJ8nMGW/wVL1TIkfCJ9VRLabyvz3EOSWL0blTxiUrKMZBVkjZUt46iSz2Or/uEYo1JwRFwPXkDGIh0Bt+iXJsnTLUj2NGuORLHovDbll9U+ZgJWVfeLEyy8WGnrHPW7eMWFuJpqr2aUg2LGWZXf7A3LQQmxEY+zOJCg+9eHgDmqf2pd2zJtds2JtZ38DqGSYhKiLfRpvy+kcMO5fhjcz7d/4JRdqy7tST9hsSfM0QrBKoirEO110UA5QjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Message-ID: <fa133642-e9b0-4443-b21c-c864c9e4f9b6@siemens.com>
Date: Wed, 13 Mar 2024 20:29:49 +0100
Subject: Re: [PATCH] date: make "iso-strict" conforming for the UTC timezone
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>, Beat Bolli <bb@drbeat.li>
Cc: michael.osipov@innomotics.com, git@vger.kernel.org,
 Beat Bolli <dev+git@drbeat.li>
References: <410d458c-ae5b-40cc-9c8e-97b016c74a76@siemens.com>
 <20240313175000.2148-1-dev+git@drbeat.li> <xmqqwmq6asrx.fsf@gitster.g>
From: "Osipov, Michael (IN IT IN)" <michael.osipov@innomotics.com>
In-Reply-To: <xmqqwmq6asrx.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7b::18) To AS8PR10MB7042.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5a9::19)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR10MB7042:EE_|AS8PR10MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 50c8e906-9dbe-470c-82df-08dc4393f389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	izNQZV2kcmpMPeT3MymYC/3JJAxzWegJJSOsza7ZMiUCZr35AoOn8Tthp6Cfl/3xIM8gdcxc75w9spNTnpkDNXO/hv5wT+buBlZcAv10e0Rrj7nfVRAGIX/S/3snZiz2Fo9EOqqLlZth6LNSj6c3ew+vwvxM0LMiOVtV9r28FpVi117/YZc5Ar5VfWQpvoM3Ax9n6B6rBOwVV4O8S039joF9TkuQnOhaoyOjO3v2KDoCYyl1xxKXs+7NIkw1i25HqNvjKpYOWS3oWkkCHyLSOWKHnqYZUXQT12gUicudB3APYySFh2BJ17MGL6q8SOjjVZji+PVRgAYzmRdBTMtpkfUNe6ZRWuZ+CYhZ7oU2Vjm7BgGYhMH0qxZDji2ipQHLPl5/MoQKXnm17wCrfJxxa+7jaSNbovRuPkoPluhWRBBjyxnIx+BHfwn8YNZdDJOD6ZIACBuyFN9eWtut4jpJCskvEOvH14uGVEM3wj4b06N5Vzy58QTGKwGcJZ9ldLisT+WD6xwj0UHJY/hoKjNWU3p7f8ecak4DT81aJdVUAn9jvtk82V2vxIs1ldOhLcPU3Nxe+QZr9IzTH1lkXRysqnCBfRLNsC3GB5yICtscrE28rBhxNL/NV2Etf2zn0Nm0AvyVeXKmEr8TY2jKWcGn2pzUQcuINi4ntyzmxyIgd7o=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB7042.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?US-ASCII?Q?=09wI16832WAVd?=
 =?US-ASCII?Q?UPUDq6ZdI9PTY?= =?US-ASCII?Q?PoBQY9vbH+Wfw30rIyKXJZ1ZK?=
 =?US-ASCII?Q?V5tf2rRxH7ZWvBGyKL/PJ14cVWQ+G70DLIu80Ahk8pGqA7YNu1H?=
 =?US-ASCII?Q?ZHMbp5Popf50JiEPkr2NjO67sNwny/hbFDpSwQLiv5Hm/BJEico?=
 =?US-ASCII?Q?KRIswm+Yvg90LhtWzRjhlfeH0M+XzIFt8EHtLGEnJig+Y+Bf266?=
 =?US-ASCII?Q?vDalKIpyBDwZIUoR7LWtVP9bnW7vOH8qtbiCKRZjUU7ARnd63c?=
 =?US-ASCII?Q?N7O8gcZdT7+EAuPF2AZs3Zhihsbh4/zpSZob740Ltfb4HQKnKRw?=
 =?US-ASCII?Q?k1+J+vyizROwnOJizoqqELnsRA5zca1jQsiqK9/foXruunieqpl?=
 =?US-ASCII?Q?k2HVKkJGFH4lK1TitMi6lE/ZhGCkA4ozCcU6ZS44NFqgQ2kd/Ju?=
 =?US-ASCII?Q?4YmiacDt8ZzIdwwrTFKSFZHB324ZgpxX3L1pS/XLwcM+ZAkacv?=
 =?US-ASCII?Q?HdcANVRMDa6hTAVz0B/93mWOpyj4IrnKaIy+NIE0gZvewfgPEnF?=
 =?US-ASCII?Q?V/DXRq768lrbyzsNbJ3iRmXRuhlvg8IF5Efhm6Srn+oz2cpDSG+?=
 =?US-ASCII?Q?mgE+YIvnDNaOJCSqJNQZPvA4CPbdd1CtHP1NujnSYNPV0GhXs17?=
 =?US-ASCII?Q?japXksaiMXykoO5jbxJ/Cwet4mXwZjtOam9JJf9tGWsN/RsKnx?=
 =?US-ASCII?Q?IGYMeAHZ6RrAJCaG/gSmn0nd0ycwe64+VPXRgR8GgEgT4+2+DVx?=
 =?US-ASCII?Q?opJuXdNfRMlbk0nO/Ee2o4vm0y8ht3MNxSXE9lxgE2/Vlm7lMix?=
 =?US-ASCII?Q?yyYbEYkEbHkaIXW4b7/dycepEs3MHMMB/PmD+bB/a/TFis15D8N?=
 =?US-ASCII?Q?SGxIMQ9AguIjIqekaDTUTZLQQ1Qz9sVEHRZPrjXfX0KUZjuBm1?=
 =?US-ASCII?Q?2J0nJmjLxKcGp6279xJ6Wjvazbhb+QLC0npxFBdmpV1dXpiippa?=
 =?US-ASCII?Q?w/uMccfDoPs4XxKhmoQnHNkNIHS8gfDcjddgz15EHY95yvZdNqA?=
 =?US-ASCII?Q?WnkOStLv3Y65CWDHcMFaiV6+Em3yi4df5D+ItNjppKXr2hahn8k?=
 =?US-ASCII?Q?M3rJwqqQzLtpup8jlN2sd5lyozutdytlVpXvmOPxRDSIY0HFio?=
 =?US-ASCII?Q?O9Bes51+uXy09NqflPeYEb6AJi2bvMz1JOA60SxuC0JnOPQGRBk?=
 =?US-ASCII?Q?JYN9/tWsfBXNDUzAfDtDPWWfAxv8BXNJwapMVHxcN2LtaMlkAPy?=
 =?US-ASCII?Q?FFkjNjSiPwezLJaqeYmFpEv4VfiJNsh7VKtn4ANSiwCn8Wg5ldp?=
 =?US-ASCII?Q?oRzP0HXCAMAJQn6FXTiv0QkTf/48T91IbfCiU7Uy8qFnsfjAb+?=
 =?US-ASCII?Q?10ppiU9lRy6vM55uw781pMOuvvJZqQ7wgyY0uc7sqMDbX3fCBkI?=
 =?US-ASCII?Q?NThyque5Q0Zaqcq4mtMlnyFz3SXH6e7d1J4KdT8bkHW833XUCDa?=
 =?US-ASCII?Q?r1Lekm3HYRb9LXsOzZqGt8YYoKVcbLhEpdMwvNi/mWnHlQaGmii?=
 =?US-ASCII?Q?vxDZPTkhgfr257F6KDfEGbQt5Qwyvt8+kpITp8Ti0YYf4tJFpsl?=
 =?US-ASCII?Q?/LMYc+fZ0U/DfLL3KbY26hpcm/3UhayCinzf6h1WyfqlC3Vk2HE?=
 =?US-ASCII?Q?imDeSxppc0CMe4F38HqycHo8x1oOl4t0V5I4xK/s2IUX/07Vnu+?=
 =?US-ASCII?Q?mlBQGlHbEDRSlo7NFhDywwr5hDv58R56JqwTa1Q6nc6zR3kBQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VpNYL6SVO2p2uXUZ7qxW9fPtBRLYX6HJv5mx9TbS+bPQDBW1I+WgHPTfZPb8BXSGILmyi2abha9X6FP+600WbIounq1KEX5VxcpU/UMdNJWK4+x/V5NCuLQgcYMEvhjRov170aDHEzJHFqrJsf+Al9SDXnzjRmrODQRxsBWXaCBMKGuJmOODEI+JL/R2QMd/1bAIR1Lu1gmPAYb+5hPxyLovg/0yL0rrhga2FHhr1XiwW3Fn9iz9wwrn9mrmtX4lYGi4B/a5lZsYkd3RxBQHRQopmo9lS92c4Z6Bq3K+QqRFndqFAytWi/AjCNnADrzYGccT151L62U8mTHmtHTl3e64R0sFK1llxf17rZqDxfxQnuYCKs2gJ6R4G1muubzi+5qX7FwuReSiVb3dtvlPWTQBg/bNfj7Krb4Zw3ypla0mHg4icIP+f1r7Zq2fWhThKGX26AXpg0hJMpyIPt62AZCfVNO3e6q3h/ea1tEdiT6XQq8irYBLAsjCec13DUcgbiIkKF58t8Ela5rt8EgGO/vD6a2jeLbKUZl6Au4GBNpeZWJ4PLRfVIDDkO8eRURMQ0sSIs9v04qfE1qmF9In9gk2vZleUHO0G0wuuVjTxAkshHpQnlV5ei3O/w9FHBaj
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c8e906-9dbe-470c-82df-08dc4393f389
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB7042.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 19:29:50.6466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RU/PjP2sG1euhwhpDkUKbfuZv6vESSb5RpuPZSFk4jQRK6T2Wl6WLxB6R8Pyp25+xKb+Rw23sui5KoEcVL1Vex0cdY/zh74dwURaMxGUEXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7859
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-7515:519-21489:flowmailer

On 2024-03-13 19:30, Junio C Hamano wrote:
> "Beat Bolli" <bb@drbeat.li> writes:
> 
>> ISO 8601-1:2020-12 specifies that a zero timezone offset must be denoted
>> with a "Z" suffix instead of the numeric "+00:00". Add the correponding
>> special case to show_date() and a new test.
> 
> Hmph, would this break existing scripts that expects the current
> behaviour, and if it does, is it safe for us to blame the script
> authors for not following the standard?

 From my PoV, if they don't stick it is not you to blame. The standard 
also says that it is equiv ("Z") to both numeral offsets. At the end 
strict is strict.

Thanks,

Michael
