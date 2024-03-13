Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA935B1E8
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 19:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.136.64.226
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710358017; cv=fail; b=bRmtgoj5gXkG3PHf32KUDs34nQ8D7Vri2AGG2dJ8iXtgbJC5KUmfee26sbr3I/25s6yhAgXv4mlG8EEyeYJxZLXjNqHhb8feq8rxwnxGfpcXmU3/ZXxN3zHqwhxIiHuWn0kyY9Tedmmc4ara0USjhXhxrxNacW5EcSTeI1I56+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710358017; c=relaxed/simple;
	bh=qC1pTdA6dEvdjVXeja4qM+RZQAsPAIGETezgz+JBmZw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cLLgkuIwp/f4nZlWyCJtBS/syyRyWttNHwwx/ZVsVTT+ldzp1V+U2UZXcfYw6XPhcaWeRtsg5zIPv5zYOFoquD9yuVYbovQBlieWWpHOzzAxjPYtk32LHJMEw88Cd8IqH92zaIfKup/8pgFnmn3Kc8liwGMRvQ8WGuk0QP/dwto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=innomotics.com; spf=pass smtp.mailfrom=rts-flowmailer.innomotics.com; dkim=pass (1024-bit key) header.d=innomotics.com header.i=michael.osipov@innomotics.com header.b=BWbUpckj; arc=fail smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=innomotics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.innomotics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=innomotics.com header.i=michael.osipov@innomotics.com header.b="BWbUpckj"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240313192643e5856a2d23d13ff6b7
        for <git@vger.kernel.org>;
        Wed, 13 Mar 2024 20:26:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=innomotics.com; i=michael.osipov@innomotics.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=IiMQ9UKOGBJSxawLiK3IJhU0VVYfAutatpjTVCHSQWo=;
 b=BWbUpckjVKHBvqVWl1xtRWjnMoKY3RxBGv+o2SQii6DkGn908RtJZYF0kKeN7oQ6GshuTn
 APwotBqGOFOQLQmTj/SgJIGUkd/+uG5Sq9ncgm/C55hPRRWUdL7NJJ8b0Ae4vfOR0/54BJNv
 7YWj6+5+HqD3suZBFrDY2Ag7zg4fY=;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jeXui8Gg5SD8xYkyMEl9RrUpc0XyP4RXQq55UUa3ps6UHfA9EFsQMB7aZxJ3p3OHV04XVXT07krNX+kHZIUcNppT0/LNoO4BO9DlmWBfcxIUsmyuWQRCWsP45SRbtUWnELdQ48qRrUaeXFgRtmxHZTBsTdPi/QnQmWXbU73Jz9PUUlqye1jTzwNOu2c+hK0Bwrw2F9WLSyh9gsegPn4Mxikiz3iwUX9RHcjXPYmyp1Ly7sVwoo2Z59f0CZaSkMKA0GBQkGfaSkSJcRT5ZPJ5N7xe8RDcW3tOCNV7QfXEAUMQVaXorLvEAyxhxcpJJw2s3mwEi8KJJcOKbcxfiJIUCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IiMQ9UKOGBJSxawLiK3IJhU0VVYfAutatpjTVCHSQWo=;
 b=nARcagtRn7EyB2DNuF4s5P17djhbZbl3yNDAX6YNv4A21UZKEC6F2Kq+u+jldXJvN53bi2JbZqB3lPOMHYAwlr8tFdEXWO9RlrOC37wec2JUiRSShcbBNsxy/HaBxihvwxw+cIy/X6VQ3yaf8anDitI2nvcSNFcyqBQY6NnTwIl8MyslL5Uur9Y8Mjs1FXYwOVrZvL/IB2+cMGEQpHWwHuYrrQrxTQH7zMlzN/rOyUxhNov/DddqgvyKrwxr7daI30K3SurrGWfBlddxEZyvHxx3MHfuri6f9U4jrvc00DBY5jK3INHipTbc0fs42VU9vCukXRK0wLsRJN0uXxEIKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Message-ID: <4e2b22fb-7496-4f67-a89f-9fcbffc73a1a@siemens.com>
Date: Wed, 13 Mar 2024 20:26:37 +0100
Subject: Re: bisect does not respect 'log.date'
To: Junio C Hamano <gitster@pobox.com>,
 "Osipov, Michael (IN IT IN)" <michael.osipov@innomotics.com>
Cc: git@vger.kernel.org
References: <645c8253-f1ef-410f-8284-7d6c8b6db601@siemens.com>
 <xmqq7ci6c7mn.fsf@gitster.g>
Content-Language: en-US
From: "Osipov, Michael (IN IT IN)" <michael.osipov@innomotics.com>
In-Reply-To: <xmqq7ci6c7mn.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:89::10) To AS8PR10MB7042.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5a9::19)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR10MB7042:EE_|AS8PR10MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: b816aaeb-1cab-463e-a09b-08dc439381aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hDBkfhVYJFMS7IQE43qpE0QAKh3YExqMRpu38DndURd9apvs8Zmp1CWvaM74CKX3PWw3Uoq7VEN6RVRkinjDjQN9O9+unjQs7s70Z/F7UnPjB0EJ2yIpH0GRq5tCVqNYilNCHfvl+58wjkoqVfuSbs/ZkknvCLstlp1jksdsVXhhotWsKYzeVbtWLvEW8ep8h6cdCexD6oK6ot4tBBzhl8VuWEpRlTxZp11sOaWFhzDibqY9EQ8Dnp8pfDsDsHoUgCjnf6q9EJX6F2jvlvZBYbp5HobZ7kBbektM9JiRan//bmXZwJw0Wsb/c+3JE5hxnAKYOEHWQ+p4A47hBBZBQtx8Z+Mn4Evs0mmBsJSurYIVZgIiD8HrrwQz3M2zKyZsMdJIaz3vKwEDxGMYRUKSnZh+zpGmlEHIp5NPZsn9/4Rl8EIU/Ox8PMOSup/s9AXHfIsVnTHf4WaGyeKyFbQf8WwXmrWaZjems4dJBvue5JldWQsLjPOnPUEYn05s7IgDPYcygnugdJU7W06CsPmO4W2XbXbExB2KNpurj2UctU84q+rvYiFGUj7bqX2R/oYedATRHvmVU8iVdFXz5B7PpjH7f1BFJwzHdIIfhCy4zxp/ZnOko3mlLI/pkcYt8LUKRqKXEvSZBZJ+x6K6uY0+P6p42dxZnVylJXMS+wKQzws=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB7042.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?US-ASCII?Q?=09PJnJjokZevt?=
 =?US-ASCII?Q?XZC43GdTBiSPL?= =?US-ASCII?Q?J8yt6qZvKwzEHkbFmLLJnT+SM?=
 =?US-ASCII?Q?N66X2buXLOz2Bi1BMHeiIlzIpW0aMV7jeKiRObMeCDbyISNWhYc?=
 =?US-ASCII?Q?RnoOqPWbh3Ehrv1Pogj2iAPws7trxd6Z6d/8q2NdI/uBuiHtV5G?=
 =?US-ASCII?Q?KVBoXHK4ypEqwv2tzGng/HUOydgfLTrOyiTLSNq11QaeicWTgSl?=
 =?US-ASCII?Q?eLRBvk5doSzZM9CyRnuRF0n/ydHDQ7MXDr53e5ulvdGWoVzd5o?=
 =?US-ASCII?Q?vnIEPdxI9vKffKM/WxPu+gf4QpHilUNbfJxAuXH5pV0vxCD3CCV?=
 =?US-ASCII?Q?BB5PoAuRBgOHtEoyNiDqlcNV4nHrgVwHl+Nwo9farTAB8w03bud?=
 =?US-ASCII?Q?IBiBtBTcLZjWyjTisoniqOdOjfS66CB8waznvY9A3a4J9K3eA4T?=
 =?US-ASCII?Q?ReT7baRiHN/vTWChX1ImVK8swoDvqWN/PJE0eFMQuZzM101UCd?=
 =?US-ASCII?Q?TWPh5EnVP6XjsQCcYn1jAp3RdFTHfVAz48tDxtaQqkaVReRZ7BQ?=
 =?US-ASCII?Q?XtBi4KkjEI9Cay3kh94111OlserR8n5yeRL+AiuH0JLkL6Mjcsx?=
 =?US-ASCII?Q?uX33tNfgFfiiCEZz0Y3sMSiRoHL4qtm4+mbA2DfV4WJ47ZknPeZ?=
 =?US-ASCII?Q?oMxLuWFK739epsXz2RrUD6APULzg8UBVCFSjLA0trsZLoQVor/?=
 =?US-ASCII?Q?s0te4YT1+oG+G4ysHZSn/cCk0UC3Tz3Eptc8BnHekcn3vmuoUX+?=
 =?US-ASCII?Q?UqktYNmVQBfnWC2kKtIE3P4P83TUBnFjsbYNwOOsG12lC3TMfa4?=
 =?US-ASCII?Q?6Cg03pgqNMKAKSF/aSUKf2xnyBjbGKBoZgS5ST36yM2PTsIGujM?=
 =?US-ASCII?Q?Ebi1wHMnNlNpTOsXAuOSVb9e6/LNv+Fs5vIS8T+t15AB/7gEy1?=
 =?US-ASCII?Q?DotHjATFyz1i/FwJ6y9hltKaRvZg7yvv/WDDjBaHo4YP/f6isTC?=
 =?US-ASCII?Q?fcOMMFrMUpmtTD8Ukjo7n/+15WaBeWqETnoJ4PjUlS0P6nLnOIC?=
 =?US-ASCII?Q?X+Fo/ubriRd2Jg8tkGZPbVSkqnjsh66zgguCQoRy0xUrCo3awgR?=
 =?US-ASCII?Q?1OaiUvtkuasa5oA/yQH8rz+wjzrfQbWNiDayBWZESInj2GY6RP?=
 =?US-ASCII?Q?PofhSwsOiJVNUUtGmwNNkFLoY4K6oxmTHQD6LYd/yJFBW5gEiS/?=
 =?US-ASCII?Q?DbfeAlyfrOoSA+N7OdZWPsz9EUVvMKqOjVNGilBYVj+dKf39Zuo?=
 =?US-ASCII?Q?jYPkdUd1RBMmN9kPM0XnOR1hVC6C5/UjxByfJnqwOJKxz+UjFdI?=
 =?US-ASCII?Q?b+aMiGJymkMlKWf9sLv5EucZsXDb/+zxkv5gECEwm8YVhpe3cA?=
 =?US-ASCII?Q?eBkoqBr5a32vOiMh6F6aKokwuJNjceej/ytKQUGXLFfbG+RSSNj?=
 =?US-ASCII?Q?yrUEfnDYD4kQHRYxSdL3XhIanOvuz4dyaKIN7FmOikLunKAZXuO?=
 =?US-ASCII?Q?XXsYKA5REjTvcfHewf0EeB+2QPlJJ171D7KtdPcS401GuxGnwur?=
 =?US-ASCII?Q?t/XFWGRHh5pCTUhgwmvCL4RuNl/VuSfUhLWBQ+5Fje+8dOMoIc3?=
 =?US-ASCII?Q?U+C3DvYh1GvxeQRXYTIgz3cKKUSF0cOK6fnpwI6slW5cbzrNwsK?=
 =?US-ASCII?Q?rTav1GcbOEflhtuo/2Lu5QYXgQvZFnE04nKiMJdOgAy0ns+LJ/D?=
 =?US-ASCII?Q?e+AYU7HfHUXkVhsfc42Qp+w05it1x5ktEDLJQ+H4UgpNhGy7Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8qcLBRLejHZ3qRKlonDIhKTTiN1iOWuGLUVmPaM/lsfzHvyMsk+O4NEqB1mvry54Iy1jIw7VrLm1tod6scdSwiwlEJENlShxihlkgs4T40sJuvnPM2kujQEe8s8UfYT7uX+fUEnhWesZxkY1zPPUPPVNjkv3qipwExzsO6wSQ5m1hobYjrcxsIe3QSDsCeSU6+d8fAP3fG32K7EWMrtJjWKEFg+PZ1Hssjw2vFOEyaUu2Y6Z7QXSyqFIhiSdKHxDXO+bYDy7aALhYs7loNL/iGphFqUmn4dVWgXtLyVW7n4+aDQDX1aRsUDIULyJkcJ+mHY610RMTWcCtiEqpRsqOqswqBeeKpV7pPhLrIzXjpxC4KGuqe1UKdWP3tD22l3yJfFuFYPJAhJJnlXsvg8ENl0gD9htD8bZitDoWDTjcOIX5RcUgOS+O+4zTDPIhjf0BzzaaGL1b9nodnqGtuYEJTAxOyaqg2j7/8xvJjzcXCiWciDbUTbs19QfAdM4imoNivEbTIoTETC3UyCea34WR5b1Psl5KHZqDWBl/Pv8V9pSNLii3gMUMvB6mlq+9nhmyjlEcpLYLqwIAW2yV0Uwdb0taG/RNCYvVHJlld0C3ugj1224vKmQ4Cnzab81UgwR
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b816aaeb-1cab-463e-a09b-08dc439381aa
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB7042.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 19:26:39.5748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0Ver442gVWykshAoUl2Z2j8/bUSFrVAhf/SSWUpPlH6Fyl8yITA1ivshDGs33hKooSMlbqEoFSKocqAAf/9s8LWfOm4u4JWZV7KF4MaLvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7859
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-7515:519-21489:flowmailer

On 2024-03-13 19:24, Junio C Hamano wrote:
> "Osipov, Michael (IN IT IN)" <michael.osipov@innomotics.com> writes:
> 
>> An oversight or bug?
> 
> Neither, i.e. WAI, I would say.
> 
> The configuration variable log.date is about "git log" and its
> documentation makes no promises how "git bisect" may or may not be
> affected.
> 
> Having said that, I think it is not unreasonable for you to make it
> a feature request to add bisect.dateformat or whatever.  The only
> interesting part from the output being the exact commit object name
> the problem bisects to, I personally would not see it a high priority
> feature request, though.

Interesting thought, but that also means that "git show" misbehaves 
because it respects "log.date" and there is no "show.date". I still 
think that consistency shouldn't be obeyed.
I'd be happy if someone could consider this improvement.

Michael
