Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D40E41F576
	for <e@80x24.org>; Sun, 21 Jan 2018 21:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751038AbeAUVeM (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Jan 2018 16:34:12 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43568 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751021AbeAUVeK (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 21 Jan 2018 16:34:10 -0500
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0LLVYCu014250;
        Sun, 21 Jan 2018 13:34:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=facebook;
 bh=rm5aL0aKuOTxKNhz5V4EAP9xWiCQ6tKr7q//wB6tiPA=;
 b=BrOQzXJN+oH/04WQu9aH2XYbinYTq4z2qgH7Hm+mpU+58Cn0DFfidgWPB+1bNdl//Jy+
 s/e9Z1SfXe2p8hrknwMqkdP4i+OjUg2dxkajGBCXhfJ4rIkmKai4xLOmYTj029bD0tdQ
 LXezC1clK+mow5YobjI0wRj/N4nzuef9S0w= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2fm2fdb1xw-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Sun, 21 Jan 2018 13:34:05 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.20) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Sun, 21 Jan 2018 13:34:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=rm5aL0aKuOTxKNhz5V4EAP9xWiCQ6tKr7q//wB6tiPA=;
 b=fUOgVrK3vkoC/lVq2okmEpVoNX63poWhRiEiBJ9eTwsjUM5QUsK3PVNqHFMUWoTehk3pfOZkaCmgawfdY97GBuMoCxY1V7ikscDaDub7NPrx03ig7UgjjBL/Q2d20fhgOpGCN3o4LHxCd5GnFfiI2GyvO3nIncKWbzN/kDNvDL8=
Received: from [IPv6:2620:10d:c0a1:1110::105a] (2620:10d:c091:180::1:c027) by
 BN6PR15MB1651.namprd15.prod.outlook.com (10.175.131.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.428.17; Sun, 21 Jan 2018 21:33:38 +0000
Subject: Re: [PATCH] enable core.fsyncObjectFiles by default
To:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Theodore Ts'o <tytso@mit.edu>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20180117184828.31816-1-hch@lst.de>
 <xmqqd128s3wf.fsf@gitster.mtv.corp.google.com>
 <87h8rki2iu.fsf@evledraar.gmail.com>
 <CA+55aFzJ2QO0MH3vgbUd8X-dzg_65A-jKmEBMSVt8ST2bpmzSQ@mail.gmail.com>
 <20180117235220.GD6948@thunk.org>
 <CA+55aFxgg6MT5Z+Jox2xyG28g9jNJ4cL3jNZ5AgTOmUODuiBsA@mail.gmail.com>
 <20180118162721.GA26078@lst.de>
From:   Chris Mason <clm@fb.com>
Message-ID: <f797983e-1890-d84c-c3c4-87904a0a8135@fb.com>
Date:   Sun, 21 Jan 2018 16:32:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180118162721.GA26078@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c091:180::1:c027]
X-ClientProxiedBy: DM5PR04CA0026.namprd04.prod.outlook.com (10.171.152.140) To
 BN6PR15MB1651.namprd15.prod.outlook.com (10.175.131.144)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 825c433d-b5bf-4226-479a-08d56116a738
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534125)(4602075)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:BN6PR15MB1651;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1651;3:hCqKi82Xvw7fFtcCzEmkPzvdbIOcr928HSVtVexhSDs8GIWIPhlkkGDgOrswsfHehL/+YQKN+gFHbvgBCeVgKl6hSHZBvNWUuWmbn6/7RhCt00qnfidqdivba7v5y+UeA83mfxNnoIgroz+rRiiaVmtbihR0pq2bcNZ63mLRWIujLjJyXdKPbRT87ydANNLHWeJiSg9lRmGDAmeuVsv/zfb0LGWPeT40XPKPavESJO9hvqN7ssInKll1S6vA7842;25:YdNpMoXfW9iypCd4FIe+U57Nej7+mErTaRMGVd/X+xVFU0FTC7Bn413Yktc9GDPanZYxyY71AGOizKGgAMOGXy3EHHqverCv1iQT9lcaTgu/LC6ukRyvHbd9FMobDQBbhMCIBTpz27KV/xhniGzOXUua1fq4t3687q8MhITCt46vu8t/DvVJDlYg+20a/e1zwWsgVfe7isu5SXFyG9q0wTai6F6ZHQbcL0mzqhskYrtdEck7GyesPmVz4g3LOAMRLTJwtW9xj0WciXb2EUkfE4J4rYJf+GFd0Cmvg8u28Iu9ClwSNxkaJoVDWHZSCHNiAEU8Snbc9bSpWBBfkz/axw==;31:1/imkv0gp1uGPEgKdn75MOkWD0p2eaii90Gzof86pv7teLZFOKMzhxBRDGZ1EKQyxGn7HXehoSDQWo/6Ssd2hvK+tqaz3G+zJjLJwIfZlRapmcdMikpxorqAF0hYVc6WLZ4giIn2NdWTp9x88xd+OH0AmUYOmdX6vd7MEmCRGtOGrJnnaZD8bS0KVz0ogokw6Jx1R9wQTHIm+QbLlFv+Hx86tGR6QTWIFCQ7iifq0ks=
X-MS-TrafficTypeDiagnostic: BN6PR15MB1651:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1651;20:/od+EivoT8W90z5nVCHiVy8mRDEYVfEgdjSsbXATEPy79ODmm/uWF9X+H5A6WaVHucfBN4yFWKANIwFLC+Vn7FK57vgsODfNL1ranXfWwLVJ58bG3pFcA+5P3oPUdHU/+SVRlR2wGc6QcZgVEJXeQ3cpPfAImrkePywamuTY8GBo8Uwd7DtqL7TFDrV4XDQVVqWvKk0uPquSNrAYJLJkZ9869G98M8ECG3udnBp5YpXLxIODQoAndzmoNrw6FoVexwojDvIZ7rF9N8GeU/1os0qzVt9Ln4K6n2J6dSvxnwEW1mL1HYRZa62Hbq61GyZj4etru+hYmFWNEnTJhmzFBJHmOV7N2U1TGmOmDUMfjp/itSxU5TtrDOHmTFsbBEt7Z2i0h9hOn1gDS6ReuAgr03t+aUDusz5Gasv1plLeZ8nSYnDekz8U1gVa2e1ExtVowmjYMSYzI9AbqI34IVNpIoU8GfYr+MKhi76XIT2FVFX/4xv2yRZaP3RaPJ9FCxs4;4:gYJ/obaQ0oOKQILCWqY7idzzr4OuInro2denXTWvXLUINcY5QH5sJ5eyqhiLhh/YfZ6v7tvoE+qd7jU6Y8WuuwM8Iy659I3V5VrxR2nTW9dKfLbaRALa2OuoG34Zg+xJpuaDZM+MxFSuHKnvzYINDKzhWPq9n69S6i47MkbYVDs49NAbjGgHSUBFh7FE8a46xd3sBad+gqenpV9nvrAPKkKi3a47zcArqOY2SS4REW2twv4QnsQci0+9r7MUfv/j+mmctwI5HGGbN+2ZkfKnRSXFx+7y1ZKYdsixx9zxiXb4HeJtKzE85rUZ30E8KhJU
X-Microsoft-Antispam-PRVS: <BN6PR15MB16517AC4B65AFF40764E0B0FD3ED0@BN6PR15MB1651.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(240460790083961);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231023)(11241501184)(2400081)(944501161)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR15MB1651;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:BN6PR15MB1651;
X-Forefront-PRVS: 0559FB9674
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(366004)(39850400004)(376002)(189003)(199004)(6116002)(386003)(67846002)(2486003)(8656006)(6666003)(1706002)(52146003)(25786009)(86362001)(76176011)(36756003)(53546011)(83506002)(2950100002)(52396003)(6246003)(64126003)(31696002)(97736004)(478600001)(4326008)(305945005)(7736002)(23676004)(53936002)(50466002)(39060400002)(110136005)(316002)(52116002)(230700001)(229853002)(106356001)(6486002)(58126008)(2906002)(65956001)(65806001)(47776003)(81156014)(8936002)(105586002)(8676002)(31686004)(93886005)(81166006)(5660300001)(54906003)(65826007)(68736007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR15MB1651;H:[IPv6:2620:10d:c0a1:1110::105a];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjE1TUIxNjUxOzIzOkNOdUUyREc2RjZINVFqby9WUXJoL3B5UUNi?=
 =?utf-8?B?eDlJY2NKcFA1cWE3MWgrdEQvNU1iY3pkd25jRXpEYmxac0FhS3NOUkhOQ1JL?=
 =?utf-8?B?WkpwK0g1T0M1QkNqWXhXc2NjZEJCVjc5Yjg4ZktRS0hDbTVzQytLc2FJODdu?=
 =?utf-8?B?MVNoOUlCdXk3Sk9qK3VUdVR2YXJDUERNRTFqakNpRGF1VzZhc3pUKzQ4MU92?=
 =?utf-8?B?cDBRMC9ZZVNYN0ZBYVlnUWVTZW1SWEg4ckM5bGxsSW9VMnZDU2k2djBiNVp4?=
 =?utf-8?B?NlNsMTNKRk9BMjc3cFFTNUEvajBWMFVBdC92N2NIUk8xTFIvWUI2WlhINGdV?=
 =?utf-8?B?d2R6YlNkVjBWSytuVkVnbWN3c20yRWZFUk9GbHcwTVJOd0gvYWNXaGxMRFh2?=
 =?utf-8?B?ekJXZk5Sd3c2Y3ZGK0hQcEV1QjhVcXlocm9lNjFFR2RuemM0cG56TGliRzJW?=
 =?utf-8?B?TTdHVnF3Nmh3WlpUbXJWZk1RNFFMclpSUnZwMGZ4Uy9mdEY5SHdJNGdCY29i?=
 =?utf-8?B?ZGN1cHBLRDYvd0Mvc08rT0pNVXg3SnA5elNEdnMwdnhEZGdUaHJ5NjVLbDFT?=
 =?utf-8?B?KzBPMXNqUnQ4QkJxMFAydVBZTmIyamM0d2NIeVdhR2hzcW4wajVQVjRJVDBU?=
 =?utf-8?B?K0ZLNUtjcUlpNGF3VDQwaXF1aFhIMThTOCtmUU85TTlPYlNpNEJsOFFOY3hS?=
 =?utf-8?B?NVRNdlpoNlppVGtKQmhlcCtHQTJoOU9Bbm5DM0VMSm5YZDh4ZWZ0MnNpVklx?=
 =?utf-8?B?cjFxTTFMUzN2L3NWU0YwYVo0SC8vSUh3TXU4anBCU2YxMHVYU1Z1R29OeE4x?=
 =?utf-8?B?YkZlaDdvVEpqVGh0ZjhaTEIzVFZMWVZlZWxhcGVrOVFqWlY5OTNvVEdMRFhu?=
 =?utf-8?B?M1EyTG5IYmRUbWdLSlZhNEFTZHpDQzlaKzJPZHJkd3ZGL0FNVXkvWmdqZWlv?=
 =?utf-8?B?NTNrNm1oNGM0T1J2K2R5VG9nWDJWVW1iSjlTSEt3ZUlGUHQ5UllCcDBPbHhS?=
 =?utf-8?B?Rm5BcHhqdEhxT3J5d0RHVFNpQXpWNzdocDhiU1lCdTFQMWtDeEpFTGNpU3BT?=
 =?utf-8?B?T1ZwUEx2VXVWSG80aG82NGZBbWMxV25ELzRkMm9ZcUlxNlRPdWxzU09pVVlj?=
 =?utf-8?B?NlB0M2dXOEJESDczTjVuaGpGVnRuZnlyQ29JK3lUVUQvNUl1YzJFbitzZ1VW?=
 =?utf-8?B?UlFtdkEvQ3liTEtVcFVkdG9DZDJNYzI4TUFOQ0RobTQ3UmNrNm9YTE92cEdY?=
 =?utf-8?B?R2JvaEcwamNza1JiOVNIZGR0REpqMkxENnlBSWx4U3RkZmNIdjM1elRHWEZo?=
 =?utf-8?B?czc0V2crYk81ZXovOE9WUjlsMDRSNDkwcnNzWVpnRXlyT0VJZjBtdk5ESFM3?=
 =?utf-8?B?ZnMyMlBpa21mbGs5Y0hhRGFGZnY4ZldrVEhudm1Wanluck4rU0llUnIwZk5S?=
 =?utf-8?B?WTMzeXh3VWE2RU9VamNSWHdtWmczSWN6UGkzcm92SFlFakxXQ1EzUi9JUVNU?=
 =?utf-8?B?ZlRhUWkrMTJZKzBvbzlhM3RrS1pGbkZlTUt6cm5pbXlhQ244dUUwelR2dWVi?=
 =?utf-8?B?SVAyMnNqZ3BnNjZEN3gzZkxaTnh6VmZsTlRxUEE5WjVielluajR4dlMvcGZC?=
 =?utf-8?B?T1FXNEZDeStQdEN4cFp0dXFKWXlLV0J1cHhnVG9XeWVtdTdsWW1keW9hRUhi?=
 =?utf-8?B?RnVhVHhVRXNqcXBlT1dRMHYzNlJkTHlGL3JXOGF4Smx6QjByTDkwSEFPWEdW?=
 =?utf-8?B?SGxqamFDYmRSM3Ztd3ZMeDAwdHpqUUFKUHh6SW9xaEZQTm92dG5LNFhpTlBl?=
 =?utf-8?B?UGg1L1dzTjJwZlRJSVFUalJ0dVhHQ2RtZWdzUHBBUEh6RE9QSFFVMmtLL09r?=
 =?utf-8?Q?vzP02Oj0yHA=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1651;6:jOYVXqwJQHnrZmy3GYaXyr2LSCr5ydWR34xoMtB2n1dodkHIrxd1nFDKxPUsZxeVoJKIvQmFDkcAzIGQjI15B0czM0qdXrM4tkfo/FHWqqAhwDqM0LBkbXMYWhDxmWLad8PX6Z89l8YED3qkjgfyT4F8fG+gk5SBgybdAgXyXjhySXEYLQqqfDdxAjjNwLNQQx6ukl1fFuhJqKYRAc9+RdtHfu47zQhts4Pn67W5smlgKEDpcjANG+uDFnpGhYnkwW+v0TdHo1lTiBfWm9ahu2MDHysIObODxqQ54yMn07ZjJU2g9qTMn32foIiUrjDSRLzwOOq150JXHbMgMD6LAQ==;5:KLCoaGuSKTBw1/lVUbr8jWAlDGObhSAZYJBxTZRz1+gXdm+KdH/CoVRmj24tTkZrZ21dO8JR9XTHChN2BiTdB4h+sXNUPluvocBsMqQxkZdnepW+SrsVc7i/zXLJCd+sDAaxnce4HB07gbyhvhaexs5PNzJL/CSkjvmTo/7C/b8=;24:0kz1WeH9cnloCK3zbPg4V9jfimgzMYamnEkSIVsFm+lZ47hmt2rmrzkKVVbzoQUclL/PpKdyu+Y+RmOQJaUnJ4cZJzlx9mt0/yPVzX9NGnY=;7:jdakiY1hAFbhGBfMc+tdMjWEhFv3Fkj3TCbyjmlWWoq3UlomFPTGeDKic+9maboKEGWDRa/E3wJcEZJfABGIFqct1F3uBXGxuTAwnCy1IXJV+sFa8CrlGJ+kYVdYcHKnoacHIV2fpKBZCqP+I2SwXMovW3lJ6eb/ZHoB127uyxCsqVCPLFS4PGrEx0J0JzKSleHb6St4Utv2rebf+2zW2I0K2tVlvyTqvw39MpiXBGxhl0+cNn8hI9H9Xt2QlOXy
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1651;20:PY9Ooi8JM5XQ2wSxcFKb7AS+WRGsCEFAHYVt2rAyhSikMFSt3cWnG7PvRAP+Ye0kaS2KQYm6yFUNsDXfddj8h1kNRck/j0oLfcyoQHqexHa64mbK1kY5pukJMMv6TFRgOdFnAK7Og0Ylz1CLDTnGFFNif2VjnILh8Wm95SxvDvk=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2018 21:33:38.2638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 825c433d-b5bf-4226-479a-08d56116a738
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1651
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-01-21_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/18/2018 11:27 AM, Christoph Hellwig wrote:
> [adding Chris to the Cc list - this is about the awful ext3 data=ordered
> behavior of syncing the whole file system data and metadata on each
> fsync]
> 
> On Wed, Jan 17, 2018 at 03:57:53PM -0800, Linus Torvalds wrote:
>> On Wed, Jan 17, 2018 at 3:52 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>>>
>>> Well, let's be fair; this is something *ext3* got wrong, and it was
>>> the default file system back them.
>>
>> I'm pretty sure reiserfs and btrfs did too..
> 
> I'm pretty sure btrfs never did, and reiserfs at least looks like
> it currently doesn't but I'd have to dig into history to check if
> it ever did.
> 

Christoph has this right, btrfs only fsyncs the one file that you've 
asked for, and unrelated data/metadata won't be included.

We've seen big fsync stalls on ext4 caused by data=ordered, so it's 
still possible to trigger on ext4, but much better than ext3.

I do share Ted's concern about the perf impact of the fsyncs on tons of 
loose files, but the defaults should be safety first.

-chris
