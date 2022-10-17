Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320F8C433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 13:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiJQNPr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 09:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiJQNPo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 09:15:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC4A4C2E6
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 06:15:39 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HC70b6011968;
        Mon, 17 Oct 2022 13:14:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=od/ilpXsFf/VmImVD+8i3rQe8oPcwpMjaWMI0kPRXFc=;
 b=GChUliGmZNiXSRG3c7UeIt/ZdF3Rel4pAUlKoUCzfuv7SxHaHrvo+CGSHwG+p7drSZRe
 qPymcb1FWOXbWigXYt24ZbTbb8JDw0ZW45aBs3zou8rlRPpc7U1E4WU97z6cC3kciAEJ
 7JQ+K3f66kt9vkaQLA3roWc4ZckCmySVkCARApdDT8k8ItuiYTaJfvl9KiXwiO4/yY8Z
 Dq56G5cspypJiPIda2Zj17C8GrIlrgDZObHb/fTInYZqAg1rIUHlYq2z8T1FjDt3OztH
 lGKJlJpj9zyoZUoEKQvYHVetENH1u7GZnHhf42Dcj6NGk8lOCFPpRTOJUBha0/jcm6Ui 2Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mw3bdqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 13:14:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29HCXUO9016220;
        Mon, 17 Oct 2022 13:14:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hqxb1cg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 13:14:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjmV3xyNmODzz1dO8sg9h8eOVGiUFFkZ3/21FctmSfQYZhT4WlH4Yh76fVtMNeWB8YZEw4Sur5LZC2l2SgRUejJxrDhStZyjtEvgA/W+kSP5/I1Ldvelf5cRNMMxxwMFXbvl67gGxbnHimpwn84lq5aL0Zg3vxxndIyRnEvrcn6KsFDZs6e3CaxpNapM7AU6sLR8Nx5IAR1pww2SN+Q2AfL6rxnGLPve99qmsPx4xyuwmVGZFF6a17SLK5GgpQt3foi8qzVyHq0AkhN4XJbkJROiWCVf96eXou555fmlTzYnU0Jxrblcz78OO3Tq24M2/AlDQcHWVka5aoJ2LUK2JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=od/ilpXsFf/VmImVD+8i3rQe8oPcwpMjaWMI0kPRXFc=;
 b=gw1vpmQA44P50rfP9x6fdducSMHV2mTFkhjG9AxNhPrJ+06VaPs2BxcYyewB+xWwk1FTaVyZQn+MTYZLPHoiiOWioiaTkpfsazVEm7FM1W1csjOAeA73d5ppj0Rvr0ji5hCElJHZW1oBnQSlnCh7ETUHERx3Sv4uxFb3u9c/tzxoCcWEW1e1iDi1bGQCahx+eG43SwSfN9+2e5v0Q7DPB+8cAPoEf0JLSM3Ewd65yt4Pw7VB1WgvxWKRCkvWfUq3mZ3PV6b1o6jCc4GUdXPD2RFwzFudD13NQJvrvUW6tDpRqUBDpy3GBUc1kfAUGvFM9bj8iwKz8Rv9EcH10uWRAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=od/ilpXsFf/VmImVD+8i3rQe8oPcwpMjaWMI0kPRXFc=;
 b=F1W25mmnI14hIFJVry7iOsvOAy6Fk2L7El0Dsr6rzx0/zIqOqRr4Z4gIja0PYrZ74SXkQrUbrtmMlPzuLyqWJ3yjbN2dlcwC2P/SPMrUNxv0IV2Al2Clka5zuuNZ1XdvJGyJV5VKpnve/CKk49tT5go99Q/8lF1VIGTjh2SexBs=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by SN4PR10MB5656.namprd10.prod.outlook.com (2603:10b6:806:20f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Mon, 17 Oct
 2022 13:14:16 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::2a45:dc8e:4a4f:6562]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::2a45:dc8e:4a4f:6562%5]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 13:14:16 +0000
Message-ID: <66d96a5c-ce6f-9241-a766-f396674798c9@oracle.com>
Date:   Mon, 17 Oct 2022 15:14:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH 1/2] notes: support fetching notes from an external
 repo
Content-Language: en-US
To:     Philip Oakley <philipoakley@iee.email>, git@vger.kernel.org
Cc:     Johan Herland <johan@herland.net>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Christian Hesse <mail@eworm.de>
References: <20220802075401.2393-1-vegard.nossum@oracle.com>
 <96b04fc0-eadc-af01-502a-e5236a393ac4@iee.email>
From:   Vegard Nossum <vegard.nossum@oracle.com>
In-Reply-To: <96b04fc0-eadc-af01-502a-e5236a393ac4@iee.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0187.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34d::16) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|SN4PR10MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: a04a3816-c12c-42bc-f7f1-08dab0417dea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LuCkelgLaYOvPT5Y4m7Re15psFIy055Eo0qWQw4bU/pn3LhEk2H9gosfrtdhEK5G6/CSkRHBHCRZt1LauNa6teVdVKQshOREjgQGUrvWBQWKFh6oh3MafBBeKGc7ipEqh1C6FP7QVAo5r/FIEm/Mtbugpplu4ndi6jHgXai3n9P9W3W38P16JcBmbWMM0jqu8cmQujnoliUln/6I+jjq7v4GJ2pVQ0O14zyN/ezhCwBpnJ32e9mvPUxl/yXSO0xNPBB9Ua+CFV0/xH8/WxtZ3ZqLO5U5q1z/vDAN4FPcFv0cbjApXS/Gn4Gy5hqDWIo7YQGhZGH7iTgwydgpMXuD9EcVP+zynszmztyk6JoS83aI8wYlOf3o5DvKTxEci5SCTpxs3pwG7Yprqr62Rv2gSW1NK8tEIGmqwHseZrqWl3m0YCGKF7zVBmLopHDYkBNo9+gQKtPcnaFEKwEb7DmIpspEHyb+Ue0XD7kcsJ0duJKHrGqihtBQllV1acHNrs7MFbRpN9NjdBivubblBV3uAjaO58Y+6hp/cOdsjsJCe3uvu2j/GkkG27DN+RPDUhe2fC+jVJie/5jQBd7eVWECzoW+JesMvQcy6+Lzz5La0nngjQ3PHE+rcYkM5og7ipnNgutBXsE0QvnuANjc2rRiOwoFT2adRpO1gJok2+gPaUsqRYnRAvH+xddCOnPs1oimVmkOnutok0SSLVGmUc6BgID8eCzeoc8D4+PHe7RxMqRFzV1Xn+sQ/mjvIR1LrTmGvua7AdzuezIjQE+fkh+z74xx80e1gL8tuhFD3iwqufGtKqaC18ysD857aCjyrfg7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199015)(66476007)(31686004)(44832011)(54906003)(5660300002)(8676002)(316002)(478600001)(6506007)(53546011)(41300700001)(26005)(6512007)(186003)(966005)(2906002)(6486002)(4326008)(2616005)(8936002)(36756003)(66574015)(83380400001)(6666004)(38100700002)(66556008)(66946007)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVI4aFFzRElqenJQelRlMEs5eU8wLzlqSS9BTlBOWEQrQUp6cmVOenY0am5j?=
 =?utf-8?B?WW14YXkvSi9RcUE3TWFST3JLVnhSUWpzT3ZvNlA5dFV5MDcvQTlLTmp0em41?=
 =?utf-8?B?SkpYVDRjdHk3TGx4bmE2VG9oUy9KVmxJNHJ4RnBuck9TUzQvaFhjZXlES3hk?=
 =?utf-8?B?WW54U20zbVZoQk9GZHltUVY5UlRNdUNJMzIveTdzem1LN0tCbkxoMUwzUUVr?=
 =?utf-8?B?WEpaU2grbVNjdUlJVW9ONE1Tc1V0WTdpMGh5VE5zdkNIZUVUVnJUdjZkTTZu?=
 =?utf-8?B?MmNmOWRDZ1BuUFFURGtzYUdSNmQzY3l2d0xQa3k3Ti82MXpZSm9lN3VWaEZX?=
 =?utf-8?B?OWxYbmlMajJSNm9GVG4vUkRtcHRFVmh1eEhGbG9oVnU5eVB4Z1J5WHZHNTd2?=
 =?utf-8?B?blhwa3J1SGRKcnRrMFN1eVRrT3NLZ2VDNVhJOEEzTVBJVkl5M3BneEM5Vk5r?=
 =?utf-8?B?MXQ0alhIbnBEaStKcVF6SjBoOXVnUUI1YWpCaElXZTY0V1NQZ2lKejVieEdH?=
 =?utf-8?B?Q0dyMk9lRlQwWFZXUkRUbENQa0NnVi8vRkdVVjkyalBEZkJUYzFnNzZydWQ0?=
 =?utf-8?B?SnIzTXR5YVdGWVk2TE5aMm9tUU5rZ1FZMUhlRnR0ZnBwZ2xCZUhDU1R5ekJl?=
 =?utf-8?B?ckpHeFI5NWl5M1Y0QU9VeG5nKzArNGF4SXZIeUdSL2lZaHZOZDlabTVBdWVh?=
 =?utf-8?B?eVNuV2ZOekkrbTR4TW1uM0VDMFRaMVdUSkhET2s5VjZsVSt3S0VpSXdBUzBp?=
 =?utf-8?B?SVVnSnMyTWsrYU9Ib2xValhnZEdNVnlmNEdQSkZDY0pqa1RjQ25lUFhnQzNu?=
 =?utf-8?B?UWxGRHEweFhlbElEa2p6ZGJTVlZLayt4amRtcFdUNUJuNVp1WkMwbkc3VGtU?=
 =?utf-8?B?eG5yVnk2SSsrUFo3ay94cyswMUh0VGQwTmRMazhTdTk5SS9hbm5xNGw0K004?=
 =?utf-8?B?UFd1THdPSHZZQ3JoMk1WSURXcXBLUWVLaVRMdTYyK1oxb3d1b1ljeTgrL0ph?=
 =?utf-8?B?blFzTnJsVkswbmMveWtUMUttbGdxeFh6eFV6WUVrS04ydjdnbnlmSmlXRnQ4?=
 =?utf-8?B?Vm9nSk01c1JXa01BUE94ZWNoS3oyeGRXclZSZlZiRCtya25ha2ZteWhpbVNi?=
 =?utf-8?B?ekE5TngzUllZcjAyVUNzOTFVa1ByNE9qS2I1SXQxNWpQK0NrU3ltblFiQmJ0?=
 =?utf-8?B?c0ZPMm1OQzZrRURiOXBhN1lHaDE2bDVMUnVaaDZqNVlGbDFiejdlUkxJTXpS?=
 =?utf-8?B?QmlsUEZqQlNobUFqRElFUjhJRmRvckVwR0hmc3lIRmUvUEJGMXB5WnlSV2Iv?=
 =?utf-8?B?T3BtY2hhblZ1MHB0M1JFZFphcWpvUjhNSEkxZk9DM1phNHFQa05JcjVKczEv?=
 =?utf-8?B?NzkzZXhiOExMN2lVRVZRUjM3WkwyU29oK0NUQ1J6UnRDaGFtbDVDRWI4Ykgv?=
 =?utf-8?B?akNGYjA3U21KWXJjcTV3NU42NVhKdGlSRzd0aFZNYVI0NzJ0VVZESm5nN1c0?=
 =?utf-8?B?a095S3BzOTZUc0RSM3VoTnRrRWxYUHZ0Q2NRQk5kM0E0M1FyaDBsQlVDUEw3?=
 =?utf-8?B?NGVydjBWTlZoQzlQVmNPV0RQZVBzVElXZWsvMFNYcEg2Q0VEMEtac0lxeURm?=
 =?utf-8?B?M3M0UTVkNjJKZmJVbS9nb3FScGZ0THRSZXlyMEN0aEhIMVUrVUplS0NMK0Fr?=
 =?utf-8?B?c3ZzM0c2ZE5BV0hFQmtuZURNK3JvNUQ2cWNYb0FTT1B5MFgxNHFyazYySEFV?=
 =?utf-8?B?VG1KdHBmVDhOeEk3M0tKVG5SbmM2VUZaSG5IN0FtTWROajVrblFqaGJLbFV5?=
 =?utf-8?B?YlAwd1h5N0VINEovZUtjS3ZqcGRHZmptcyt0andocVlsM3NySnJsY1ZJeDhV?=
 =?utf-8?B?UnI3KzRUSjhpb0dkTEJYUElwdUU2SkdnK0hrSE82WTZNTnFEYzlLVFhjM0pu?=
 =?utf-8?B?TnhhaVlIdEFuQjNxQTJ2UHg4dmI4elJieXJEdjhrRWMzSExGdEJxYldNNith?=
 =?utf-8?B?azN6Mk5vNEczME5vSXUxM1ZuUnBLMFplUC9qbmdESlFyU1RMMmhxSWNSdVJ6?=
 =?utf-8?B?a1EzTE4yYmpZa2ZVWXFQZmpJcVBlbVhWVGVERGRSdmhTVVdYd21KQnk5WWRu?=
 =?utf-8?B?ZjBiTUErMllzcUtoNm96eUFxaXJaSmxuc1g2TC9zZTlNMjNFQ0lzajQyUGhy?=
 =?utf-8?B?ZlE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a04a3816-c12c-42bc-f7f1-08dab0417dea
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 13:14:16.2478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6sGhNfGve79fOsa60vOO1hZNCu6hPzaKWnoBvZyMXl6sUdzSNhSpqGdk7wTE5LmHd1aPOn/pzGOFZp9fmXNIJxDC/YYSUm7eU6zvxQfrvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5656
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_11,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210170077
X-Proofpoint-ORIG-GUID: nRXMkwJsR595t-9HEYLOLc--eky-HXkl
X-Proofpoint-GUID: nRXMkwJsR595t-9HEYLOLc--eky-HXkl
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 8/30/22 16:17, Philip Oakley wrote:
> Sorry for late comment.

And sorry for late response! I didn't receive your email for some
reason, but I noticed it in the list archives.

> On 02/08/2022 08:54, Vegard Nossum wrote:
>> Notes are currently always fetched from the current repo. However, in
>> certain situations you may want to keep notes in a separate repository
>> altogether.
>>
>> In my specific case, I am using cgit to display notes for repositories
>> that are owned by others but hosted on a shared machine, so I cannot
>> really add the notes directly to their repositories.
>>
>> This patch makes it so that you can do:
>>
>>      const char *notes_repo_path = "path/to/notes.git";
>>      const char *notes_ref = "refs/notes/commits";
>>
>>      struct repository notes_repo;
>>      struct display_notes_opt notes_opt;
>>
>>      repo_init(&notes_repo, notes_repo_path, NULL);
>>      add_to_alternates_memory(notes_repo.objects->odb->path);
>>
>>      init_display_notes(&notes_opt);
>>      notes_opt.repo = &notes_repo;
>>      notes_opt.use_default_notes = 0;
>>
>>      string_list_append(&notes_opt.extra_notes_refs, notes_ref);
>>      load_display_notes(&notes_opt);
>>
>> ...and then notes will be taken from the given ref in the external
>> repository.
>>
>> Given that the functionality is not exposed through the command line,
>> there is currently no way to add regression tests for this.
>>
>> Cc: Johan Herland <johan@herland.net>
>> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
>> Cc: Christian Hesse <mail@eworm.de>
>> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
>> ---
>>   common-main.c |  2 ++
>>   notes.c       | 15 ++++++++++++---
>>   notes.h       |  3 +++
>>   refs.c        | 12 +++++++++---
>>   refs.h        |  2 ++
>>   5 files changed, 28 insertions(+), 6 deletions(-)
> 
> Where's the documentation? Without a clarity of purpose and usage then,
> for me, it doesn't fly.
> 
> I feel that underlying this there may something that's interesting, but
> without the 'SPIN' narrative (situation, problem, implication, and
> need-payoff) I'm not sure what it's trying to do from a broad user
> perspective. (Spin is just one approach to 'selling' the patches;-)
> 
> I'd agree that Notes are 'odd' in that they are out of sequence relative
> to commits, and may not be common between users viewing the same repo.
> I'd like to understand the issues in a wider context.
> --
> Philip

Perhaps the best way to showcase this is with a screenshot of what we're
trying to upstream:

https://vegard.github.io/cgit/6399f1fae4ec.png

Since git commits cannot be changed without rewriting history, git notes
is the mechanism by which we can attach new information to existing
commits. We're internally using these notes for cross-referencing
information like references to subsequent fixes, backports in other
trees, mailing list discussions, etc.

There is also a bit more information in my cgit patch submission from
today: https://lists.zx2c4.com/pipermail/cgit/2022-October/004764.html

My "problem" is that there are many moving parts to this, and the two
git.git patches sit at the top of the dependency chain:

1. these git patches
2. the cgit patches
3. the Linux kernel-specific notes generation scripts/logic
4. the Linux kernel notes themselves
5. displaying notes on kernel.org

Almost all of these steps involve different people with different
standards, different motivations, different priorities.

As I wrote earlier, I am trying to be a good citizen and upstream as
much of this as I can. But it's hard to justify what Junio asked for:
scrapping my current patches (which we are currently using...) in favour
of a complete rewrite with more functionality that does not buy us
anything from my point of view.

Does this clarify things?

I think my patches are a good cleanup regardless of motivation and
everything was fairly well documented in the changelogs, so I'm
surprised to see skepticism in the git community.


Vegard
