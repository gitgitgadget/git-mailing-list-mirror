Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE8471F516
	for <e@80x24.org>; Sat, 30 Jun 2018 01:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936809AbeF3BLu (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 21:11:50 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44788 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934366AbeF3BLn (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 29 Jun 2018 21:11:43 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5U18YLx003544;
        Fri, 29 Jun 2018 18:11:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=content-type : from : to
 : cc : subject : in-reply-to : references : date : message-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=5NZdhjN4QEwfqmoJc21rrE3jmGOx54qOvWna3wVHTWE=;
 b=ZRux3WsQXaTK4Fjs47KxhSoGCKLVLaL/QVbKQoQCx/JhAu67l4z7x35wyKQq50rPs/+3
 7Yv21fEzWSIJfdNzLOhuQadpHl5hwDkcmZPDxXy5MFBlc1A7a5gE1/xa/0MFaoZ/GvLD
 BXjOaYe609xTDMedOmRxx5fcYXY52G1mQLE= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2jwv0q8gv8-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 29 Jun 2018 18:11:26 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.19) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 29 Jun 2018 18:11:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NZdhjN4QEwfqmoJc21rrE3jmGOx54qOvWna3wVHTWE=;
 b=WptSF/78somJvglGnyyrVxB5VYHOKbmlJgEa28eU0LFk2AaGzS7NWsABfg8A+F9HcEr6dbPR5jsi+ONcwFVgTxeyUe03ojJjhEUZWIRh21jWl9OKrDtm1WGsxzoxiQOA6iJt3FpHITWPu6XRKT/oynSLbeTZgIh5U6UbbrDUGk4=
Received: from localhost (199.201.64.3) by
 BL0PR1501MB2179.namprd15.prod.outlook.com (2603:10b6:207:33::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.23; Sat, 30 Jun
 2018 01:11:22 +0000
Content-Type: text/plain; charset="UTF-8"
From:   Jun Wu <quark@fb.com>
To:     Stefan Beller <sbeller@google.com>
CC:     gitster <gitster@pobox.com>, git <git@vger.kernel.org>,
        jamill <jamill@microsoft.com>, mh <mh@glandium.org>,
        mhagger <mhagger@alum.mit.edu>
Subject: Re: [PATCH] xdiff: reduce indent heuristic overhead
In-Reply-To: <20180629233741.173309-1-sbeller@google.com>
References: <xmqqfu15thr8.fsf@gitster-ct.c.googlers.com> <20180629233741.173309-1-sbeller@google.com>
Date:   Fri, 29 Jun 2018 18:11:16 -0700
Message-ID: <1530320014-sup-1592@x1c>
User-Agent: Sup/g7607543
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Originating-IP: [199.201.64.3]
X-ClientProxiedBy: AT5PR8401CA0023.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7418::33) To BL0PR1501MB2179.namprd15.prod.outlook.com
 (2603:10b6:207:33::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 317234fa-4ac5-4f47-7957-08d5de2664c0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BL0PR1501MB2179;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR1501MB2179;3:gMSXCSO4VRU0XYLyJJEoTg4mRX3PZTUqO9AHAqh3FQ0339ngYo77nxriWWdETt7lxH9na9HwW3RY9z6p4PVL6QCmE80AJWvk4gbzw3MjoqJKYofvmfDnfeTios4IPf+52JQR/bWLzIKsbV866h6LpYtxzeYYub7oSu3pkymC+EGrh/SodU8598mdUubjMDu/iTb8O97O6JXmDxTi+4Wzb4vN1GpCwdHlZqfxL8E1b+kxwlFkgGlfRzjOHrVVCzbP;25:vWMt2sNRZ2oma344h4BKkre7fi0Au3idc8FwN4GMGBXo1C08ISzOJ0uflGzQDB0MCczegKr2hULmRApZuHhVtBIn9qmkDnLGHl7/TB5mV+PjnSHFL3PZPvG7t8+aZAjrENNx9dRxJr5OvGH1wzcYts4anXOAqmyH/rM/dpAGtWoZRY2bUAOqrPbS+PE6PZ28K2oXg3+ktwwlRUwTZsgoUoaDMf8yj6daODEUW3n7/VCqt2yAKlHBHi4mLHHbq6WZiDNcK97h2s8JoFV98wUn//QRfZ7WihfNSHFcJkMWrGXLqr74IPivMv0pbPcKtC02B31k16nSTvWSlUQ248q7WQ==;31:g9w3fs9MDEgKQRdEVfTu515E25rr0WVqXZM5gqEhjf8ccRGkJLh6o4RiLqHFLPp6Cv2CmD3Nf/8ZGwP7CFJUxuBjCoQMW4UCd++NZdrIzlAzhI8UvDsKjyTXIioW22lW5rZS0LA+gLPeuI1QBd+HFGpLkxzUVDadx5ln3Ic5fFtGg3Tnd7zbLs1v6gPjONSkIP7z/zalQgEH9aUlnxm1vKp1mHPYXvJbfpuNWgHkCc8=
X-MS-TrafficTypeDiagnostic: BL0PR1501MB2179:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR1501MB2179;20:Cy62pBlAZguzpsauNRU/weXyC2YSNo+zuUCgZH/6TSZhSXt/z4v6n1Zr69mzrG+d0jmLSVl8cDlrnJBcLqf01shYusNyxA6v70V4W38rZ3IP1i3ztgnceS0Kp28NLkcyp71ALwqN74misvDFyoTTIH5mmRLzNyf0ytEMvn5NlGW6yjoWVQ4ErAmeZUvPb26z9qvPDoK4gJ3hhV2Z4FUW5HfLuYf6kyywhJFMwZfLDOsQXQ+KJiKCtppZBtlQEc90OJsHvAM4UC0zsiJwsjzr43JBP3gKFuJ4RI9dd1/nSW9wdcBbvXQ2jh05JzsfxZxOqKt2Gc/vvqk6sp51sDS9nRx/QjEnxlwH2OFi/NFaQVliXcV/Lung6mo7GJ2RhmSgovki3WoEAqtarkkPiOrv2J8wqSV+ri2VjpsKZ7WydOIT3GF08aPaHgMzZntoTUNjc8dWXVR/SEIHq8YOcMn6XGw3zHd/jcaRBWj63L4mBY/LpRgx+N1FW9A7r8uJXwKP;4:l9F2m6I0wIPKLk48X+nJsDZdCHKUBQXD+0Oqe8PeG+b5HD+uozC77CZkyl+FJpOotkSWtFBx1TmDEC64fI0umFeFTHqJzKexhNnLC721RQQun5dxuGMmXUyeylQdL6ndG/NF+nYThdWvZ3XPdlcDByIkX3pGJ80yzaNcIkuZUV8CoNQ/nE7QdLbWkXO3W2Iu4UgEE0aJNtsyW3CSXLKyPev6LoBdmZCybndTnKzzkaabCt/py3ABeehnW8edyiGqq6vIGcqXo5GjPHoaWshOcA==
X-Microsoft-Antispam-PRVS: <BL0PR1501MB2179DB3A0465DD9B8F08ACC9CD4D0@BL0PR1501MB2179.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BL0PR1501MB2179;BCL:0;PCL:0;RULEID:;SRVR:BL0PR1501MB2179;
X-Forefront-PRVS: 0719EC6A9A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(136003)(39860400002)(366004)(376002)(346002)(396003)(199004)(189003)(8676002)(81156014)(81166006)(8936002)(229853002)(33716001)(5660300001)(4326008)(68736007)(97736004)(66066001)(16526019)(47776003)(476003)(11346002)(186003)(86362001)(446003)(6486002)(6916009)(956004)(9686003)(50466002)(486006)(6666003)(54906003)(2870700001)(76506005)(316002)(106356001)(7736002)(105586002)(305945005)(33896004)(23676004)(58126008)(52116002)(76176011)(2906002)(26005)(6496006)(386003)(53936002)(6246003)(25786009)(478600001)(6116002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR1501MB2179;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDBQUjE1MDFNQjIxNzk7MjM6NXlhaXE1ZzNWZlVObnI4RWJnUHpkNk9q?=
 =?utf-8?B?Q2NLRWxFMWswU0s1NVd4QTNQaEMzb29ZSjVYVndhUjc1NVpVVFY2UzFPUmYw?=
 =?utf-8?B?VHZjcVRSODByUE9DaXpRbzNETHdmZEYyY1RDUVRYQWNzQWl0cVRKSWVZQWhM?=
 =?utf-8?B?UzZCZXNlTGRoRm01SlRJS28xQXYrWEpLMzB4ZTY3MGsweVlmQkxKakxncS92?=
 =?utf-8?B?amp1T1dDT0JudVBXVnVndmxadFpybHB5MUw5ODgweE5MWmltQkEydXd2Mnh6?=
 =?utf-8?B?NW0xcktDZVZ0b2NLNU9ad2hva2lGdVp5ZkkwUFJUcmlKSHdzQWNVOS95dWdI?=
 =?utf-8?B?OXNFeEJ5Y2F1REdOSEkrVE9oSG1CNHdzQkE4VUl6azluMGY2dGIrdGR6UXZM?=
 =?utf-8?B?ZEtvbU1ZUkVncWxpcjQ2UFhEbC9BQzRBZ200Q3FGRVZObm1ZUHR1alFTUXpB?=
 =?utf-8?B?ZWVEU2M0VG94Z2xDN1Q0eUI0cnhoT0lSODdVNVFxdTJSQlN2Q0RxeDV3Q3B1?=
 =?utf-8?B?cG1uWW9YTGxBMHVNcHFIYVc3VFh1L2t0d0JmTW0rNW92em95RkR0R21TRmRR?=
 =?utf-8?B?K2JLeTRuZVRUeXlZaWJNUzNEN0l6dU4xZi8wdGRFN1IwZ0ZYY1F2MkcrcSsr?=
 =?utf-8?B?UGhwK3h3Q2NFOUUwVWloVlhrdlNTcG9aQWR1M2N2dDVoZnpDb24xaEtHUldq?=
 =?utf-8?B?aUR0L2I5eVRRWFNYWWt4dHJZU1ZUMDBWTGJ6VERtMWFTTWlwdkJoZ3NoQmZY?=
 =?utf-8?B?cDdJcVFZM2dvQ04wY3owbnQrNjBwV3JWLy8rU0xUMjJMTkRndTFTRXhydkdT?=
 =?utf-8?B?cG9CVVlxUUp4TjRjQnJZVDhhU3k4K1QzR2lRM1E1Z3o4QnAwUjhVYW1tWUl2?=
 =?utf-8?B?Sjg0d2tDVjhzVW5wZU5UZStEUkJsSTNEZ1Uxd1hIcDlqQ2pzQjRUN3hPV25q?=
 =?utf-8?B?VGVYRnFiNmdGQlVuamVLU21TTnZKYWxyRVFtUGt2eEVscU8zSWZaK0RtZGlv?=
 =?utf-8?B?RURZK3VEL0NnV3NYMWlzZmpGU2tsdXk4R0UwQzh0dnRUd3lYSGdEMDJkalVZ?=
 =?utf-8?B?OEQ0MW1mTk5HTE0rWEp0SXNUVURKYWM0cEJwWjdRMzJtVGNTTFg0NkNUT3ZZ?=
 =?utf-8?B?dm5BZjJrTk9CMzFidVF4TVpCK0QzTHpjYzVkelFIZW12UGwwSm9uajhyMnM3?=
 =?utf-8?B?UUdVa0RtUEdHRVF4OEp3YnhlNnF2WUpIZis2RmlFdUNxYVR5UTVSLysrWERm?=
 =?utf-8?B?SG1NR0NTcTBDdzFCMFhSZ3NxdlBUbXpZWFdSUm5JMUVhY3UxaFVrN2pSQnpH?=
 =?utf-8?B?VnEvc0tZNURBeVFEcEREOWt3bmJMTjZBRkZzaDBGVEpWVmtjNnBkRjJkdG92?=
 =?utf-8?B?ajIxMEd2cUoxeHdqbWhEUU8wbldYTFN4eVY1OXpITklOSjNSeXZWMWVWNlQz?=
 =?utf-8?B?anJBZG9WRnRRL2JjRkcwOE1PS3NVNEw3QWlLNmdnck8rZVBVY1pXaSt5K016?=
 =?utf-8?B?STZLK2tNRGIvQjRYSEJRMDA3NEVSRnFvMDByK2M1MnBvcmp6Y1RpZjFKQit1?=
 =?utf-8?B?YzZvTlN1M0k1VGlNeXd6QkIzQWNtZ3MxbUxiQzBqbEpzOVdBS2c1QVZoSlRE?=
 =?utf-8?B?cjhpMEZaekhBb0Z0Q1pZUVJodWxEU2JGYnBKNzRteDFlVUFUWkE5WE8wTFps?=
 =?utf-8?Q?HcHtVtzFX9ahcgHTwbniDDbLEEpoJrvl4ziy/ndEL?=
X-Microsoft-Antispam-Message-Info: mcB750RLS2sTv20Hoe9NtDn9128obrOJuamNriAEDbvQHIL50lL5a92Xu6m+6ZT267p+k0MxolE1QBcudZQx1/ewZGwjKv/Y8V22kZBTPcV3waNoPzbURBfuMXDuU76Vt3Fy5EzBL5E73qcNF1T277Y40dsUoRaJPe9VfdydLy55ynl8DwsZOjsGYzj4AOF9Uu6ijdAMpdCr5778Z4DBY2zNeW/DYkaphkVUfgMDIIpGdmYewYs9KjPvM+cZ9vSExVE8MS3WqP8XhvUzVpsLfq5dKlAZBxCaV/F6rLG5lhenghjU6zRYBX/wtbNUTxvYYZORcTZRLAXj6jlgzDls5XDD0UlJeGwEV1/4fOoMKVk=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR1501MB2179;6:dIrGe4O/oAQOl8nHiHq8YqIyvZKb/cwuhaPKbDp4r/cbel0IdF2PYKJXX7NOWUCSLhCVA9Lc7y1zE8J1cnzE25ANZhwaatMwOsz4ihNrp1sCxmGbpZRe7LCdx8fXLljMIPmhXKjDTvC9291C0bKv0Q3B9AZhYU7TMkaL2Xxt/+DWjcKny6WeW/oJQTAsAlzu7g72o+56nzsbRPZGv/hMYHuPT+U4RSqutKBFsZ/x/5BeKS801JjCiHgPvbe/FRCySNwZ91u7SJw6aBx/RrxMvWF1z5nH8DA964NOk/y2ozkOc6B4Urtgp9ZOgZT5mfs5gtwAA+wnnqMuDSf8PSP2Pv7xI55auDa4pG4nejlsPlBzxTn46LhtUOzoe5XHxM5+NLY57HW9CgPb3GZAYLs1ssLA/x+5FvmIh/j6lksTQJw+SQRIWP5Afe4PSv5TKuGxdICE8gARYWIQq1MPC8iAFQ==;5:nzG7038Uc4yOjeJ0r2V0YnkInX+Ytos/ZlmcN2cM4BOGahGZVpr0i9IJWzHhpcjLb4ornj4w6nFdeTO12EuSaWPq2R7LZDiI41tW75leZ5oeY2437KQdREotxkCs89WmLbdhtTAj+XPZHOQHdRwujrTfmSjvN0Vc/XsNq9jNsgQ=;24:XQPb2xuJ5CHvgPN2XE8bgY5/zQWqXMEpY5rnIc55sSWnbrHArK6nax5PFaLEm/zPVZLnkWZJ46zHVLQXqKE4wbbBLn0Q+c0q4eNyv61v+q4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR1501MB2179;7:pBJ0CtQF/K3Hl1P5QUhyGLsDKgHcexqfjkYD2dT/NCfMsRUq61pMJz5/MTLN6FMnmK9rLg8iF+yUu0Mwb7Z0aqdT4GFvmCrDvTTp4o3aFclYredwyJkerPD3bvcxz2FI1J7YVdxv5dTuxkUR6szcT2bbO4ONDruhvsGMuEDo7XXPgaOduic1yQadf1dN/h73orVr7sNqgHhg7mbIEOUCTfr5uI+2CX4k2tBLrMxE7txYSTIvFlh1tNf9mQUL8YHP;20:8mgVqlvIfVwlGAjIjvCzom5Wrec9J0RqRRpNM25iFD5N6286SrkGK7fyaZPHGSl8DbkBye5M7HfywS9p1vM7jRC6eq9Xy65ScVnGuODhApSK9K45mQg4eWDm/wPQuF6IuwN6LlYZBCN5vz/md6LdGLqYINHhDiAFpYg6SbQsnpc=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2018 01:11:22.0980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 317234fa-4ac5-4f47-7957-08d5de2664c0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1501MB2179
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-29_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Excerpts from Stefan Beller's message of 2018-06-29 16:37:41 -0700:
> [...]
> Jun, Junio
> 
> By changing the authorship we'd want to have a sign off from the original author,
> before applying; in the previous attempt, I was merely taking the code from
> mercurial as their copy of xdiff is also LGPLv2 so we are free to use that.

I'm fine with signing off the patch. I didn't send this one here mainly
because indent heuristic was default off at the time I made the changes, and
I wasn't sure about how to test this properly according to the git community
standard. If this change is fine without additional tests, I can send it
myself, too.

> Thanks,
> Stefan
> 
> [...]
