Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37235C19F28
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 08:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbiHCIJ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 04:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbiHCIJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 04:09:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FA1220E4
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 01:09:25 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2737hsTn032246;
        Wed, 3 Aug 2022 08:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=5NmZ9KMPCmPQWTvvZfd56h+983B2K3BP6p3BuZhwpOQ=;
 b=1NLO4KgvuyV2Xvv0jJyVplvWULSVgj4W1s6CUg/BsRwR14YnHqzCED+6yjwskq26JKk1
 3WIgPM/Ffys86K/ayTO+7X9++O6MKQFqKRPCTTETGwJ2rLzW2qn2AgoeAfBy1w5XrYDN
 XK+kwzIHgbD49Q9+7sL0Ev0jCLPrL+lfEegc9Iudukip9G2DJSj0T6t6HohuL5HROA6M
 Z7fWGnlnqCH2VtgZk3E/TSTSRkNsWiZshQSHvHMLn315WymHf+Ofr3R+/MKMYptjE//E
 2PecbUXskprqM/j+/Mf3y33SXv2wMQksYO/rMct+12IOERzR5Et+2YO111sv1Afkv9Nv Nw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmv8s96kp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Aug 2022 08:09:11 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2734eBmA030891;
        Wed, 3 Aug 2022 08:09:11 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu333w90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Aug 2022 08:09:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuKDqQMg5S2WtaJbDcjTG8IlczOxBUZ85FqS0D26X1oFOD9yuKGjqNpTUg0asCRvb/9KEJFWCuEaDh7pTb1fT2CaZ59US1wP2+LZTW/EaWtDQMCP3Wy3PSFst5GxUrERNzE32KMpIvf4ngAPZoRgURe5z4ENBQU0D92/c68htkO0pXXna1/KT/sE0zYyjGxDnBOHk4x0FFPTvDIAouHnVDtNG46ifX6Ui0DXN2I/tBvf123Q1BUQH0+pGrxzWZNqP8bN9u7MbGILri4DZe6sKljEWHO3CIp6SRz54m4Ew2ubsEcg4y0Ss+yI5Uv2LkuNlnuG3wHgZPWNCtIhGUq5fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NmZ9KMPCmPQWTvvZfd56h+983B2K3BP6p3BuZhwpOQ=;
 b=DwujDEgzqifabMIpnWncueFMNUl0F4JuFuqZ2IlnRvraqAFBkJdyK/YI1vcgzoEqKOtuqYq8wuuBKI97uGQNQNyPCse3Cj+S0JZyPDjftbyo6A2Is6ULF/XXYjhCCYSWPAcDC5vik3kqL06lUZaVFZV3xahIZnHEtoMQM4UdvoEnlEu1y72RWNjPT96x3lMOHm4r7oUuulq3U0PzYBzKW4ww6cEbkxAkodlY01ifDVTXaToUUGn90R3fCAUXE1ohyYvVHIuAZekcW5SLq6fDcBsgR6Cld3l7MV2kV4HdfRHqw+do+AEr9DS+YkvXRU9JVNOpSnD0mNL2U7p42chlDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NmZ9KMPCmPQWTvvZfd56h+983B2K3BP6p3BuZhwpOQ=;
 b=sJu1ubEJTQvvhTh800bV/vpQhtyTgrsFIHHkKIDBOyX8HL7WIPdOTegMu0oIP36TTE4qV0JsqgkscD5mADaDP8NHzp/l87j0BclKJBct4UIwPk7+F5ZgP2MyfPLG5s0/khY9pZJfjxeOD4od303QQ1RWPBBcC9den0pOZ1zzKsM=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by DM6PR10MB3611.namprd10.prod.outlook.com (2603:10b6:5:179::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Wed, 3 Aug
 2022 08:09:09 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::9076:a11e:f5a3:dde7]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::9076:a11e:f5a3:dde7%8]) with mapi id 15.20.5482.016; Wed, 3 Aug 2022
 08:09:09 +0000
Message-ID: <69fd9dcf-7769-6c5c-ca0e-ea61e6d616d9@oracle.com>
Date:   Wed, 3 Aug 2022 10:09:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 1/2] notes: support fetching notes from an external
 repo
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Johan Herland <johan@herland.net>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Christian Hesse <mail@eworm.de>
References: <20220802075401.2393-1-vegard.nossum@oracle.com>
 <xmqqczdiirh8.fsf@gitster.g>
From:   Vegard Nossum <vegard.nossum@oracle.com>
In-Reply-To: <xmqqczdiirh8.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0173.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:236::16) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb211a80-5b4d-40d8-2da6-08da75277120
X-MS-TrafficTypeDiagnostic: DM6PR10MB3611:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dYt7iOTURJXLyCcxNDvc4O2G9dkWFoD0HqCN8dykCtGeq+utOrkv8S4+sDo7FNFgGU15zyXTtlKgzhFUgbyHYymSySnuEk4M5WGIYaSVQP3EYufJcjiW48dQaAxQY1cE+R9jiVXhINUbOJ3DUt6vQZjpWpZm5k+drjU7CNfUPLbhO/aW9tSpWLRxrtNWPQ8C3ZfSgUuvKTFnKB2GAMM7Dx7vWS/nm8C8wFyeySVk72hEphNRr9AdzxZeH51VuzBYKNyulktYZfIis9+Tg2uONbzcC8tVIsTDxnglBnAvQdBXtRWRfgZR3qKJiy6P7rJ1F4/27NBIeeC4O1UYbfQFK2GOZPECbC4WTUYJHRukB7R0rGpMMlT2aXt9JrpRDBsW3ZYBmPrtdUTYR3gU9gTvL3Xn3MhdgxePMRRAh6/abXdqFi9xE3MYTDsMV+tRa80Slghh8p1hxGDY7n4cRqT2+9K1w9BvFqN5VGxSkiTGlVdkxUPVC2IlCj6L/eAp1JKsFFeDIBVDQfabSi/hk/FIEPjSrIyqGIodPgLuGRdrwct0DaVahf8SLaPgsz28zvrLewzBfjVBHK5l+9rOiYx5CMGisO/bkqDySAWANrLRAiv5x8bOogSZ0Vc0pkU0mbxnohBjAj9R1KJZ8G1lFneqcA59ZL/fXu6Rgjlv8p6YrpAV+rB5Lx7O2syAGd6DaChx98Y4TJtnC1s11F15n341ToIwhhfd/RQUQfPejGpWNFXsE53F5IGtXvQkQDecUjrXollRBl1RHpga5BHVJdWpgSbFas7CPBFug9itzTwDpv9N5EJx/o8v184yaXygpmJHhpo4yTlKbiSIrxUuR5amwL9ib1SAuKkOSvomrt61mes=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(39860400002)(366004)(396003)(346002)(6916009)(54906003)(44832011)(186003)(316002)(38100700002)(6506007)(38350700002)(52116002)(2906002)(53546011)(5660300002)(36756003)(6666004)(26005)(478600001)(31686004)(6512007)(31696002)(66946007)(66556008)(6486002)(66476007)(4326008)(8676002)(8936002)(86362001)(2616005)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUs1MnduZEZOR0VwUFV6OWh0STIzOCtadFpFNmJ4TUgvS0VvaWh2SGk2cjIw?=
 =?utf-8?B?REpnN1ZiSmNaQWRkcmhic1dtbCs3Q1I1UVJqL2lyRjB6cGdnNmF2OVFuY2RY?=
 =?utf-8?B?a2R3Y1hPQjBVeGp4MURoNGtUeHhVenBhTFVBRzJ1ZGYweENjUEZJWmVVZW5K?=
 =?utf-8?B?UkJzRFh3MCtMejJPMTNMQlE3anU1UlBTMkdwTDR0Rk5JVVlvaU0zWmVGUW5j?=
 =?utf-8?B?RHVpWllsSEJVTjZoMUNzNWhMallSOTVvTEs2SGZXQWd1b21PRVZONm5ueUxn?=
 =?utf-8?B?SGgvcWdGQldCUGF6WGpla3AyVVBydlhDaUFmNlRWa2FRWnJOUTlNeVZ6eU9z?=
 =?utf-8?B?eXR0RW5zeUJwc29nVWtNQ1NvZWJCM2NZOUc1Smp4VWY3a05jcGVBTUs5TjRh?=
 =?utf-8?B?T282cEQ3NzhFZWM0alBEUTYyQjVGWVo4dGVaVXBLZW5weUNVT3Z5MlJpTDgz?=
 =?utf-8?B?RUpoT3BZN3ZrcFZqSXdTRUl1RUc1MlREY2xBNWVORkN3TDlQcXNianQrWk9P?=
 =?utf-8?B?WmphL041bUt1ais5SXFTdGg4amZMRW16VjY3cnB6L3BwWEhYREpSWFA4a1NI?=
 =?utf-8?B?Y3k2clcxRzRYdjdoZE9CV3UrdFd6NHZvSytYbHJCdHJJcjBRTCtIVk5CWHo4?=
 =?utf-8?B?VSs0UUt4STIvUklicDNxbDREMkNPRTdST3BrbHowMTlOSUVjRDhQc2NPb0to?=
 =?utf-8?B?STc5MEJuM1ZSd21JYlBmRCtpSUJSZ1BXUkpKWk1hSldKRVBLRkpnTUpUQW80?=
 =?utf-8?B?MFFCSkJoMU5NQ0RJN0N4cGFsTUtZOE85MEQxVXFlQUZpRVpYYjNMWHNsT2Zy?=
 =?utf-8?B?NDFCeEt4TCs5dWJ1UnRnSHVGYjM2MlVheGRaWUtMbnIvYWhaUEpsZ0EwenZG?=
 =?utf-8?B?WTBja2ZtcSs0Y2lTajJFQ29sZHV1VTJ4anpYWmxzZTg5MDhwdkEyNmFQTHNh?=
 =?utf-8?B?bzhOeGY1NjVucjU0MDZFOVNVMXQvVzlDWmlsMTV5M1NHcFpoR01DQWxPVW5r?=
 =?utf-8?B?NWVVcmx3aksrcUsxZU5DdEpES29FQzF1cnVIdGlwQXRPWUZ2M2dpUjBRd3Zr?=
 =?utf-8?B?NEp4RlpJcit6WmZTRWdkNHdCVENucWFEQnU3dWx6elZCdk5VbUhhZWxDcEls?=
 =?utf-8?B?VnNJYS9yMThKUnl1YVVEUmtDYndTdmpHSGlHcEhLU2FRbUJnR0JtZGZWSUNs?=
 =?utf-8?B?TDkrbUw0MHROalAwMzhYK3ZLb1R0aUV1UVN3dWoyQmczblZkTndUZHlReHhY?=
 =?utf-8?B?U3VZR1FmL09qU1d0QTgySDQxZGl1anlXMEdpSTFyQzdYb0h0NW51MjFJUEpu?=
 =?utf-8?B?NFhrTTZwSXFtZ0FGaVV5cDIvdHRQQVlHQ2ZrYWM4VzBpR1VTUnlHVWhPTXZX?=
 =?utf-8?B?RTJxV3F6elVvTVkvRDhCZWVGMGJWY0VqLzFabXgwK0t6UGNzbVNuM0NIWUdI?=
 =?utf-8?B?N0F4NXZSRVpKdDF3VkRneUFRbjhIRjJjbTV0bVBSQ2lDNEE0ZzkxcFJ0TjA5?=
 =?utf-8?B?VkxYMjlmV1dXUUtTSzl0d2U3Q2dubzFrRlh5MDNvbU5VVXBlMUFMTkMvNUpo?=
 =?utf-8?B?cGEyYkRZZ3RDK3JCQW9ieG1kOWRBSENFNytXeHlJcC9nVEF1UHZEQ1kyKzd2?=
 =?utf-8?B?cTlzbzkxY25yZVR0YStWOEZqbzZkZDdIRGVNOFRZVFloWVlmMFU4UGZkSHRu?=
 =?utf-8?B?U3JMTUY4b01Hem1QV1hoN3kvQmNKZmZSeEltZHBJWDJDWUNYa3haZDJqbnBk?=
 =?utf-8?B?MlVrZFNYL2pGalE1bnQ2SzMxR1BFeXlCdHB0Q2htclk3NjVIMklxb2pqTDI3?=
 =?utf-8?B?R09iaU1sRWVYQWpRUS94V3dnZXpNTDlLVjRQSWFMU2xOTXYwYVFRRTlUL3l6?=
 =?utf-8?B?NVJmVUZaclAzeEtGOS9XNmk5NFRXek5iNXNjc1lQd2VXUGhoTkJobUNXdnQw?=
 =?utf-8?B?Z2FKYWJaRFlDVDlnQ09CWndwUGdxR3JHa015RCs5Y1U5Z0pEM0ZTb3pHSzg3?=
 =?utf-8?B?cWVaMnZCZnQ1Y3JHanBQNHlCM1ViNk1kaTFJeHF3ZDJVVkZjRExMcDV1UFc4?=
 =?utf-8?B?Rjk4Z05rMUU2dHJ1eWJmeUxZM2NLdXBUWkZXTU1ocSszMGhQdHltSUFvMEkw?=
 =?utf-8?B?NnFmWmVCeldnVlVXaC9DTGJoR3czakl2WjF5Z1RFNTlVMC9mZVd6aFBOMU9E?=
 =?utf-8?B?Mmc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb211a80-5b4d-40d8-2da6-08da75277120
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 08:09:09.1278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KsDiFfj78PL9YcuDhC30/b4CWejU5ZPXfcBt3apCutIji/3buZYwss0hJTWQjmU9rqcFMVLjm4QBODilQvMxMgpXUCATTs7ko4tYsShrkLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3611
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-03_03,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208030037
X-Proofpoint-GUID: Lto7WHmVgXaKIoRoObMaPQqo4MtoBhbI
X-Proofpoint-ORIG-GUID: Lto7WHmVgXaKIoRoObMaPQqo4MtoBhbI
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 8/2/22 17:40, Junio C Hamano wrote:
> Vegard Nossum <vegard.nossum@oracle.com> writes:
> 
>> Notes are currently always fetched from the current repo. However, in
>> certain situations you may want to keep notes in a separate repository
>> altogether.
>>
>> In my specific case, I am using cgit to display notes for repositories
>> that are owned by others but hosted on a shared machine, so I cannot
>> really add the notes directly to their repositories.
> 
> My gut reaction is that I am not interested at all in the above
> approach, even though the problem you are trying to solve is
> interesting.  Mostly because notes are not the only decorations your
> users may want.  What if you want to "log --decorate" their
> repository contents with your own tags that annotate their commits?
> A notes-only approach to mix repositories is way too narrow.
> 
> A usable alternative _might_ be to introduce a way to "borrow" refs
> and objects from a different repository as if you cloned from and
> continuously fetching from them.  We already have a mechanism to
> borrow objects from another repository in the form of "alternate
> object database" that lets us pretend objects in their repository
> are locally available.  We can invent a similar mechanism that lets
> any of their ref as if it were our local ref, e.g. their "main"
> branch at their refs/heads/main might appear to exist at our
> refs/borrowed/X/heads/main.  

Hi Junio,

Thanks for the reply.

To be clear, are you saying there is no way you would ever take my
patches in their current form, even though they only rearrange internal
workings (and have no other user-observable effects) to solve a problem
I am currently facing?

The thing is, I personally have no use for displaying refs borrowed from
another repository at this time, and I'm not sure I have either the time
or the ability to provide what you are asking for.

I don't think my patches preclude adding "borrowed refs" as a feature at
a later time, so can we not do that when somebody actually has a use for it?

Just to provide a bit more background: These two patches are just the
first two in a bigger project to make extensive use of git notes to
provide added value to the whole Linux kernel community -- in other
words, this is not just for myself, I am trying here to upstream our
internal patches for the benefit of everybody. I have cgit patches as
well (but I'm waiting to submit them until git can support them) and
hundreds of thousands of notes annotating Linux kernel commits with
useful information.

Respectfully,


Vegard
