Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FB55D724
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 19:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.136.64.228
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710358075; cv=fail; b=mdijZytT2wuxwY9S65hYriQgF2FCCAietw71bnsvL15uccm/znFaFaxcVg51qxyEcaBhB5G+X23Fuf0gHlg0cKbgbGd4jXPgpipNQldXbT8KXaBZW9lNI0fTH08I12Kkk2ZFePknB9DKbZvff3p7YWXRksLbmLq414/AlbDHWbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710358075; c=relaxed/simple;
	bh=52vU4H0X0/pEj/jNRVTMOrw9gcUfqHZD8HWTmocVvnc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GcwP4DsnOqkfyQkrCKBgfvUJ8cUWCl6bUdj3R4KltCbRYrHBpJ4LbaFwTPtoxdB6iqxp1d0nyUDixcJIXKZjtFT7dXuPx33gRkJ84Pfba2QUNI/8lYOOm30HkwC5yN+c6W6elud17DLzu2MFWnuCpOnQpmAqH6dWaKKU9GvMf60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=innomotics.com; spf=pass smtp.mailfrom=rts-flowmailer.innomotics.com; dkim=pass (1024-bit key) header.d=innomotics.com header.i=michael.osipov@innomotics.com header.b=SCJxzlHb; arc=fail smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=innomotics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.innomotics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=innomotics.com header.i=michael.osipov@innomotics.com header.b="SCJxzlHb"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240313192744b98e6f902d9ddc899d
        for <git@vger.kernel.org>;
        Wed, 13 Mar 2024 20:27:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=innomotics.com; i=michael.osipov@innomotics.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=52vU4H0X0/pEj/jNRVTMOrw9gcUfqHZD8HWTmocVvnc=;
 b=SCJxzlHbD7lM9xEqRza+e0gTF48HDvTnEuAu3Rmd7/2BeDRUwQ9mcCL73vlT8+xZuYNKgR
 ATSXLtsCJ+OQb9kgRix0hCLiqUJKzPJB+a74MLqs7PlCn5KJUSz714d3Q6XvUCRAWALNiSBz
 1EZUZT8RouTg5aRySJb30e3AB/UCw=;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hudZB64fLRpJazIncBZPakea7Fc4YtG2jOK/bLD2SXBdUAKaSBs7vfc2NIiEJj85K81viBizdzuz/EU4rOCXWrZYoSwKumWJ+P9SAeJzvIF3DkLk4005CDo4snh8y54Iw/rytZ9EREtxYkLDXuOawMhYFwNvB6er+xMz7A3scg2jvrFbC9QzES75cT7Zs7dxcjT8DZ4UCGH1qd0Hi1kISQg0aLZJtxTpzC6ho0Tdcn/5sN+2CSjOE96ULdGGgEqIdI3TshZNEdai0oY5PJyHtBfdMBV+K2vB+iXOcct6s3CYUhncalAdUptfuLGB1wkBVPQi7n1c1tutog/YET2f8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52vU4H0X0/pEj/jNRVTMOrw9gcUfqHZD8HWTmocVvnc=;
 b=cpB3Mkl4/bp8oGeiJJiBDffilD9QaKQFyF8qOjArLXDSNMOmE/zgTZ+fTxeiID+P/ebc/frD7zTAHL92AkUjIGbgoPuf8DTD/kD0J6QVumrTvSg6PjGpe6tCrdsaMvRCe1rwB90FC/53+NZ8PjfkluRSafjJVEMmkhXJtgFtp2dCtR3WqinPxz6rbb6ZXwZf0YgFdyH6URyqW8dfgJYRM0sSrag7NBbp2IjOrx+nw5bKDyW0l8qVqjCKTt4y2aoLQSWtMTVMoaSQeY//kFNBAI6i0dB2P0TDqB8r40Zq1lNFUAPW0yo+YXQ55jUDu5DXCUZeBWn1gKMjFZRAuvle0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Message-ID: <f2fff194-5df4-4bb6-9044-7d7bba529570@siemens.com>
Date: Wed, 13 Mar 2024 20:27:43 +0100
Subject: Re: [PATCH] date: make "iso-strict" conforming for the UTC timezone
Content-Language: en-US
To: Beat Bolli <bb@drbeat.li>, michael.osipov@innomotics.com
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Beat Bolli <dev+git@drbeat.li>
References: <410d458c-ae5b-40cc-9c8e-97b016c74a76@siemens.com>
 <20240313175000.2148-1-dev+git@drbeat.li>
From: "Osipov, Michael (IN IT IN)" <michael.osipov@innomotics.com>
In-Reply-To: <20240313175000.2148-1-dev+git@drbeat.li>
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
X-MS-Office365-Filtering-Correlation-Id: b3cc3c7b-64a5-4972-4dae-08dc4393a7b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	eRLyxabfl7uMjYb/uyzGJjRd3tzA+B/R8+cd5Ex8zysyiD957r4DeI4CazwMnILVyS45Exwfi1LMVmRr2+kHPIi23FfUVnecbftBn6EdL/XzTd6VotMYnSFbbAZpSsiOZuHPcDuJj7DLYapmN3l23IK+Ym5+9eB83b+1WAK95hDuNPKEvUM/55QGgJDwAqT+DhCC3pSm0PGvjImNsREZz1GHK/RqCGK8Vmuhl1AGXSRw+gUJHRe4HBnblk5a6GfSmQPif4vLvaDwvHlOb00o4JdUR4ATCSjMwHmn4PsDYjajrb1RKLrhm022++Axrgrho1khHoxQELQMAyWjLszGYby1j5fwZdMaIhfr4DBS/RLMiKVGRGXawH1AXrcdAHAM4/6v4yTYsRt+Q3QjO9vNbHdgycNTJWBL0fhM+hhRzOyi6dHWWtN8wGaPaPJGYK5ZKv6GWi+q98LFoza1Je5mJ5wmXliSwc6/ptu4OQFr3q8OpcTcyFvTnffLqkDg+vSfbWcu8rUCTVVIBqDnyK3PvU88oGYUtPTuYEc6yazwjRbaOHCWC6ZsmHgZDwTb2jncLXW5el+FrAvwMmShOXpa2w4L43RV8CmG2PHVglkwLqlaiRCjat8fDTf47Sv4AJ11rJXv2yoCnErZ9isllfeGK7YsDTfRt1Rk+fVZl+faqRk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB7042.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?US-ASCII?Q?=09yPFb5OAOZYa?=
 =?US-ASCII?Q?WOR6bScK2oTzV?= =?US-ASCII?Q?S/D60EBNDCbBG9Vsf/F0vVPr8?=
 =?US-ASCII?Q?UtOnWXCMJNE2CPzEhn0GmWo+c78Ip0fyzudEiJ7JbveRcGvcmNb?=
 =?US-ASCII?Q?bIeslBPh5NJtM8LjG4oihpuO6HNIKvK/9Lci8Ew1JzT4Zvp8jVN?=
 =?US-ASCII?Q?QMH5wInCVz3A/8th+hvLrNLK4d80pYcl0F5kN6HrpeIvXqvADjL?=
 =?US-ASCII?Q?ogDt6R8DuF9d2RZf5w5vw/tc0hW0RfjtncbBTtw7E462jGGUoE?=
 =?US-ASCII?Q?5EZH2BGgDgxI05oHCJsaTnvWtULQDEN3+GBTQGJ64mrrdHNmzly?=
 =?US-ASCII?Q?cQnYRGfurmSeUXs6/ue3bLTifnq5cr6c62QSWhh3YZeirJ/hJQT?=
 =?US-ASCII?Q?Mt+m3ePvamlSsMe2dOEjHSaT6ER1khWz6VNpaM3DeF2yQA5YSOa?=
 =?US-ASCII?Q?nNGKkHwK7gWV4/twtLYCcmsCZ+YiBTCsyd9gLugACoyQn86jiN?=
 =?US-ASCII?Q?Dyr34mJXveUWZ/LlBrMwRZONVEHyJR8hESkS4/mR+h8hIc/vP54?=
 =?US-ASCII?Q?Tsog9F+5yfHMqzrOp918eh2wvRZlMm6H5va/MfPDwXxx/0Bdajw?=
 =?US-ASCII?Q?Pw0Lg+feB2kkCwhMQ30bMmdyvnAMc/aKk2jIMxftLUJow2Gpo3j?=
 =?US-ASCII?Q?7FXbdTyz/CK0UTRx6gYCjZCu4vU73FcXigCi0W2KtExfovWQPZ?=
 =?US-ASCII?Q?XasunwdZg/tPTlEtltbTf1gXj5cCcQ8aZRORCvbjhv6RGeIdz/k?=
 =?US-ASCII?Q?+8Sp0KNloZOcedtj43+vf1PeBhCrspRqieQ7UvfD96izKuLf/2e?=
 =?US-ASCII?Q?cd2fAtisSFYlvqtCYwtnzOItWRCcnyg4dELSLHohE729WT64VWJ?=
 =?US-ASCII?Q?7QywQUwR1tJPrudqSnIsCVMrfKi9N4UpxrkIexX2carO9b2L8b?=
 =?US-ASCII?Q?L73oG6Qo02yiot/R7RoWO0UE3EdxvGqkgG0HAH7ooSVOl/RQrIs?=
 =?US-ASCII?Q?nPzDZaV6neuprg4whf0e0Hg6aDVmP5mPyyWzsotYCzI7oXCK676?=
 =?US-ASCII?Q?Xa8g6q0Tgv46oJMLl866fuo4iMt2WiQNewT2UdOkdNI+SK61rLM?=
 =?US-ASCII?Q?nciWnajo+ZIFEAfaaOm/ontD4j/iGRLGMVE6e6Wl7oQKMbvKWY?=
 =?US-ASCII?Q?+d6xnVHS5iwyTHnu1GxiVPg1+hjSGOp0RUwSxM5QJ1/tv4eK+mE?=
 =?US-ASCII?Q?GNnX50DPU2EIXNLe5DYeLegPNtLgjv+hb+A6Tvq2sn1iO5DS1tl?=
 =?US-ASCII?Q?k3UqVruHp5Itpl8USlcEwIgiGD6s0oeMhDeLA+Et1dasoz+jv5s?=
 =?US-ASCII?Q?8QysphI4DwIFkbjQpwkMet4sKhmOreo9KcUZu+p0IF0zT5Z8l1?=
 =?US-ASCII?Q?Z3tCo1gWLtB1nM6vKxYvR33DCy0d0J20qtXknowq2LF7/nyRs9s?=
 =?US-ASCII?Q?knvRAZp0I3t97B7Ftp1Zq56DTN8m0R2x0b6KEnoSf2ipTlgRrOt?=
 =?US-ASCII?Q?k8sK8iVWXTQcA0yD/iXfKbZ/Ao4l9xF6ihrnw46BlaWcVg5MUOG?=
 =?US-ASCII?Q?wvi5sYsSfy0AVTs/KY6wYly1uSa7QwroOWDLvuR7uV+tPbDyp4Y?=
 =?US-ASCII?Q?s0WYQ9UbjCrs11705q1nz+EBH1dHNDavwcEafrqV9kz+GZOqvsh?=
 =?US-ASCII?Q?nZHNir2Ux975MJ89MV507jfx/leqGMS+ybhnYOzE0QM3cgqKDD+?=
 =?US-ASCII?Q?m9oYVVhxh7IYGo/kkk1gpyJS2wW2lnDQAUz80N20vbNZ78XlQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jRvgwytuahLFpMLhtV3o7Vaa2wvXq/iNK0rBcoPEG5IcwnZWNbSIorGx9V63UI3bBXKgcO0vGFKkJXOm9Jwt8pTS/+EOH53z6c021MMuXJXCuqN7/Vw4MYV0CB+K0o0NcsFPGbfuT92Jw1VxF5pmwOLyxBJyytVqKvcdFaMwdKByWaglfPcb+P7ktMGyoyhw+IUZsVeM8idzkfLXHwisZAnq8WXELjTVXbkGFK9vgdLK4gOJTzTChn20AecblYEa0xv19s5hn99izqCJMhkdVDTwoO08Gk9o7DeTgVq+C9oRlLij72UVVVSOpYe2lSzpMyZnOeg+7B5mcGCkkQ4akTv+fKZrS0xsseiPsbyy9dT54cvuiGZUfAP8kA4Z5RKzOFRhho51v2n9bdkqC70Mq9VdUKgBQrIKdQdcQZkYno1pzDTwOuOJQRD4NY5wipAOknSf6x0tdNwfLFTVHc3vv8aNL4FSu2lqxBtIKH2U2zaYs9nDCdiCnznNR+xDeOqPG5qmejw7X/11PscTXkWSOrExf9mXFpWv5NC4jZWeIpcvvjjAHyh6rO84mfGFTdV7fHkwp/74VgG+O12LidFhrOIGl/k6hVeHHVp+nWPYiQdIGn+Wgjv7cB9/QcdstK7N
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3cc3c7b-64a5-4972-4dae-08dc4393a7b3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB7042.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 19:27:43.3955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n96OxKNG+o1pNw2zt/26u5ICJ04ctwkZEEjNkiAN8do5F7JSkrYN7Iob2bLgBgVrV7nHjaIpwldDD9GwVRkpVeTtcKfS3GXMFSWBOeQBHTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7859
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-7515:519-21489:flowmailer

On 2024-03-13 18:50, Beat Bolli wrote:
> ISO 8601-1:2020-12 specifies that a zero timezone offset must be denoted
> with a "Z" suffix instead of the numeric "+00:00". Add the correponding
> special case to show_date() and a new test.

Thanks for this lightspeed fix!
