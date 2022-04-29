Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1C1C433F5
	for <git@archiver.kernel.org>; Fri, 29 Apr 2022 06:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbiD2G1I (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Apr 2022 02:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiD2G1H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Apr 2022 02:27:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8C0F77
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 23:23:49 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23T1IsSJ018608
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 06:23:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=1/aDtpwKw0qhziDEeExqIeY3M6EOxVq5fRaooC5PzaU=;
 b=x6DTYiBL81ZvPSFzrtEEAgNNV9CbZW2qYOPDjj8vKyXsend+esg+o8CFiHqY7xsO84Qv
 3EMPTIJWPdbR/oe3sCHrQk91EacBjugFf8cNZURHx00SzXOQlSDqg1JAU4VmxPFqePXk
 ASMfwg1QmRiaZxtCaY5XTcaRUPDO7Ee3k0VhibMexmZSrIykTNzVllbr0avbJGRVW7pn
 hBSxF7wIMozPs9ob6HCgXCRYuDQTZtsMsWSaehDYM8iEgVLG4gWFlYVxjC8o1lG5kvm9
 vqy1pKeSaC3LjzLN7JMWp5G40IjS/dYE7gLvOchUNwgPJBkHGA2zAWadmfs5esZfm+bz Nw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb5k5wsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 06:23:47 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23T6LKV8037036
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 06:23:47 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w7pc6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 06:23:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWvNQN6QUgJQ+mYopCYMI0gX26FQk7liEq6h9ToyprXqC83WgMh+C4Sc10xTCAu2zLs+rqTxpYiH8fFQ9Jp1/gunddG3jWH3qChr3fcWp2AfgaTryQq0NfamJAoZou2sNjRdqM/y6NlOs+VLMkKv12RDWZFgieTEeqGga6ZjjRgMRO1Ld6pgwplNgrP+E27rOdCosPBiLH8AZKbOKv8wTFUs5koLtss2yFOsI3d4fBujmieNAZ8UQgN4S8sNk5mTwVMjLUmSmPDqMOeInVQNEeelj3s0lmMsKZjfhFH7UhSBABF1bDQUO62V8kjLR1Vr8Sg2P8bsR+C/Hk2gqrMhJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/aDtpwKw0qhziDEeExqIeY3M6EOxVq5fRaooC5PzaU=;
 b=K2IABA4ZtiDuJC3GL0in0ykVn8M2847wuZRzD8W1xakQCqoYxaf/VWBUUa77m0/eoU1tGFgQh4cjLQmfYNilk2ipFuUU0TN7F+OcZDfvmicOGQiDvKCdj+RZGOp5sWmt/sD+jfQnhsfamt0p9d4Uo8jDNSRl9EkP48weu+xBQEbq8DHVC9vMZFCiAZe9awmKUaAFYCzw8+TuCnVCIXSoAG5gZyH5mM/IKQy+ca+alKhC7wqLSirIeCCF7uSXK9CG42933r9/InhqiK/zGSf8cS1B4WjckZED2Ry1aqs4Qx55GEavX0DWsjdTaVVxEc/XvNucEQy8V/1fcPNAaPhDow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/aDtpwKw0qhziDEeExqIeY3M6EOxVq5fRaooC5PzaU=;
 b=IsdXeYL6XCZRBU8q1/ONW9KC+z7zB6bY0LaRsCH5axh3zbukRscm2z7BZt6KrXoLZlMVC9fh3RTHzMsLgV3FGLALfNG6jQAiWxxRSWf+iZJNicJwkEH5jp1qmBh1vqEhLFO+AzustgsrBpBaAB/d77DsYEiJ96wb7U8Z/pG9HUg=
Received: from BY5PR10MB3780.namprd10.prod.outlook.com (2603:10b6:a03:1ff::14)
 by SN6PR10MB2976.namprd10.prod.outlook.com (2603:10b6:805:d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 06:23:45 +0000
Received: from BY5PR10MB3780.namprd10.prod.outlook.com
 ([fe80::48f8:b867:49b7:a584]) by BY5PR10MB3780.namprd10.prod.outlook.com
 ([fe80::48f8:b867:49b7:a584%7]) with mapi id 15.20.5206.013; Fri, 29 Apr 2022
 06:23:44 +0000
Date:   Fri, 29 Apr 2022 08:23:37 +0200
From:   Vladimir Marek <Vladimir.Marek@oracle.com>
To:     git@vger.kernel.org
Subject: Fix for failing tests on Solaris
Message-ID: <20220429062337.bcpjizaujjmw65dt@virtual.cz.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-ClientProxiedBy: LO4P123CA0512.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::18) To BY5PR10MB3780.namprd10.prod.outlook.com
 (2603:10b6:a03:1ff::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b68e841b-ba6b-4de6-7de3-08da29a8cfd0
X-MS-TrafficTypeDiagnostic: SN6PR10MB2976:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB29760A4C1365AFECBC3AB54BFDFC9@SN6PR10MB2976.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fveUOE9cGJUuV/sVKn9v4xbbCseUpO5f9MF2BI6U3YW49VyzVRtTte9OYe+iQ+EwzR4KfmYWf8t/+M64nYdTyDGyHwMnTnCTeuLWTZGEEwdcu6gVbU7OzMvgyKsaTMGMKD+oVuGR799muL4SWRNPF1/7oE17gLs2hp9Hf9i5VTmKdeJgHBaYubr80ptJqYv1qCG9rX9yo8U8ybomXeUqB9kLumzanXIAlPYcCslUmYAgPHCA6j7sWypNNOXQ9ZIQwNDrfK+YUOqAIPtXyexX4tsMIaiYxevYwP5wWGR9N9+oydxc7w/uiIn8I6epTj8mne9hN7IW4j+3IF6vuWSvk5Wigts9VLdMjOH/bWstSyQKSRzTtnudfhes6W3DdogsXglx1+R0WPDyyBpJEguilg6QqNtXV3mp7C7OkIqJOaV5is5OY0YTFUsmiWbr+Le5yGbONWG1zHNre9ixE3XFNvV7+jxPyr3kgBRI0KnmekqIRQ+n0n+kXwmAw+Li7nC8J6rUc1wzG6D3fwhVZk01M+EwQ9sdhk5QgwGhs/X8entyQ84YHBXHGOX3rBwt5RAQvMFcQIUFIbbRlsfmkFShKhoxTnfc4JzRX2jkOC7zougFB6NWt+CH9+t3uA7KnezOz/Lf2gt4oxFukIrBvejS5RvL454CuKcFjdYXtec1WTOEJmkyHGsmpe+zdJaHV6vf89VvSA84o0TofecYGHxIE2m2htVGrEtFxaz/gC/5OlBzLhhKxwYH8cC+Nk/R+YEkjwXmzW8F2BffeC12WRGGUl5lzbtVZxW0b9guAKkaJP91ec2zYjMl0zc8OCfFGwAl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3780.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66946007)(86362001)(66556008)(83380400001)(1076003)(8676002)(186003)(316002)(6916009)(2906002)(52116002)(508600001)(5660300002)(8936002)(38100700002)(38350700002)(6486002)(26005)(6666004)(6506007)(966005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHpWOGdDOEZDdVNFMlZXRmVnSFl3M2d1SDNyT3ZQV0NEU0tsT25IeHVIUzJo?=
 =?utf-8?B?ZHlFbnFIaVRDL3N0enlBYXFZNS8zdjV4cERTMGJLMURyWGEwU3dCamtJOCtB?=
 =?utf-8?B?ZGRYQktaSjkzUFJiWndxTlF1OHlOQWF3RlRlYkJXZ2tucVdLUWZReHBwOXNS?=
 =?utf-8?B?THZoVWhhb0ZobTFPL0lLeCtLdVZpcml4NXVOUXh4TldZTk5IcWR5LzdKK0pB?=
 =?utf-8?B?UGJCYlBBcHhMR0x5dlFhOGMwNnZBbnRsNUl1dEJlUXJNaXFrRU1iZzg5MzMv?=
 =?utf-8?B?d3ZDRFBXZStRRzl3NGoyaVRYbjFqWkt2aGFnTzR1T3dZb2JaeS9aN2lxRWF1?=
 =?utf-8?B?ZVkvVkRYYnFjVktybjBFZS9uQndrNnMvZUU1MkluWEcrSnQ5RytSUWZ6SFNz?=
 =?utf-8?B?eWN4MG5VM05BTU4rUUF4Sy9LS0lMU0R4alZQS1U5WHFFUHBKWlQ2WC9QQWFI?=
 =?utf-8?B?dm5ONXZmcTZpV2lTZG02ZkZUbWtZbGRack9MTUFXK0tONWxnOVlWeDNEZHVx?=
 =?utf-8?B?Ni9LbTd4YW5vMkdxUVByMU1rTlpKeENxYzYrTlZOVTBHVnZNUXVTVWhwRkxG?=
 =?utf-8?B?WkhSZU93d1dUYmpvQnMycTJ0VjRSREY2WnYrcEs2SlBjRTJWQ0RYYytzUk5W?=
 =?utf-8?B?bE14RWFhTmhmN1ZwWTBvRGFBMHgzUmlDcW5yckI0VklaWWZ4S2xJaGQ0MzEr?=
 =?utf-8?B?UndnNFpuOEhFdnVONEZjTHd4MktidUl2cHRIdlZRN0ZXM0U0QkJKSkJCOWVF?=
 =?utf-8?B?ajdBbjgzU0U5TGkrbTBQM0c3NkZOKzdkT0xNU01xRTMyMXZ4RVNnTG1Yc0My?=
 =?utf-8?B?aHMvRHF2OHVnMDJvR3lhNFhtSVRGT0lCZHRoNGZJRCtJdXRycFhMck0ySFlV?=
 =?utf-8?B?RXJQcXNhNW5sZFJUZTVzNVYzTXdVa1oweTBKcW83YlJscUxHMSt1eHlyYWFj?=
 =?utf-8?B?R3BmL3AzN3duWXd0TUYyeEZkRVVLazk2OHhXZmYrYVQzNVJMeWFlcGFUdXNE?=
 =?utf-8?B?V1UvL3pSMERRdGthSFZQVExHL3pkYjFXZzdGU0dKcCttY0wxTWRMRXhoKzRk?=
 =?utf-8?B?ZjI4L0FLZXlWK1pEUzBsSHBQbEZVaTN1bTBaMWlwRmxmaDl2YmtWS3FzRzBq?=
 =?utf-8?B?Sk9aU3JVSFNIL0syeGt1TThxOE5sdVNuaFBOak5oZVUyV0x0SFpDb2ZGYXBG?=
 =?utf-8?B?OXA3cXpBWUhoQVpXWmI0dEdlN0xFbEdwenYyRDdzUXJpZ1BEYjRKTHRFaVEz?=
 =?utf-8?B?Q0pkQ3c5a2UxbmJBaVNEMTVDOWF1SHFqUmNjc1NiVnloNEltVzFRQU41MzZs?=
 =?utf-8?B?aEp5cG5Xc1FhbE5WZVptQ2Vrbzh3aFNXb01DYnRmN0NZM3k1VXRCY0s0L1NW?=
 =?utf-8?B?bGZxdy9vcEM2TnluSCtRL25iaUViZk54RDdRbUgxemIrd0loZ0FCN2pOaHc3?=
 =?utf-8?B?SVlnTStBWDVmOU1Wajh4Qjk0UE1YdTRNSXpHbnhQb1FvWml2Yk43Q3VYYUFP?=
 =?utf-8?B?a3NEclZXMFNZTGRSUTk4d21zV3NaaHlEeEZHU1pKckxhcHV0TExORUZUSnFY?=
 =?utf-8?B?RkNUbHJlZWhSY25kZDk4Z3VKTXRoUVZUc0phdm8rR1VXN1czVG82SkNkUVVS?=
 =?utf-8?B?NDBTanZia3RpaTRDT1R3R1NYenNjbG5EKzFYTXhGYzduZnJ1ZDFPQUlsWWpz?=
 =?utf-8?B?a2p6SzdWSzRyZ3dYaHdqQVg5UTBNNVZBU0o3MVJDUEpuWkFRNnZOOURrbTMw?=
 =?utf-8?B?NVpBTWtJbkxtYk5UUG5ncGdmS2lGU1c4d1NxZk5CajZkSEt6RzFUNzQvV1Uw?=
 =?utf-8?B?Nll6MUFQemowSXhKRGhNQklxdjl1RWlVZThqRG4wWVpRM2NRcU5YVjNpc1BY?=
 =?utf-8?B?eitmS2RIVTBISGZLUElUWDVtKzREZEIxM0NnME85NHAxdjZTSWNoa3F3NFUw?=
 =?utf-8?B?TGVtNW1MTEFQT05LeFFFTlN0ZzlPanlXNFdVUGJuV2JMUUw4U1c0N1NLWkp1?=
 =?utf-8?B?a1ZyNEVEaWVncWtSbjFUTS91VlBJVjJFNEJwQ3JvMUJ1dkJ2MXRLcjBxejRh?=
 =?utf-8?B?VGFJS2dsQTV2emFOZk5aSUFVTTlIQlpvQ3JqTHZBYXdOR1hUMFBzb3A0bzVJ?=
 =?utf-8?B?SmJWb2U5WnE2YTA0c242QzRyWEErYU1aM0FIUDZQZEVzUE1JVTRQZlJJUEJP?=
 =?utf-8?B?SE9lMEtTTnZhUHo4SkJ2Z3BKMUFXcFNKZ3lwUVhGbG9UZTBRSTZUSVE5QkZo?=
 =?utf-8?B?NFpxSmhWeDA3UjZWVEczNllwYncrMzBOQWJuY1ljYzRtclo2dnpvbDcvNjdl?=
 =?utf-8?B?bWh6UFpMbmRwZDlkZmk5ODd4akJrY2QxckJwM2xtMWxKUTlqY0lMSkRhOGJR?=
 =?utf-8?Q?eG/cPgwatGpeezqo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b68e841b-ba6b-4de6-7de3-08da29a8cfd0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3780.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 06:23:44.5388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kr4jrMvrCKfcL8qKjXHRCUWM7x8GLyKw+zSXcEMNqzpNqG+NtLi7mUacoFtAA4+WMulJcUAP7EFqEtfYRaKjidx/BJVXLzaEv8WnfE15w9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2976
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-29_03:2022-04-28,2022-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204290036
X-Proofpoint-GUID: RJdsCD7PzM0ELMswFSxLdNFkBU4JPIVQ
X-Proofpoint-ORIG-GUID: RJdsCD7PzM0ELMswFSxLdNFkBU4JPIVQ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Sorry if this is not the best way to report issues.

Solaris ships git[1]. We run it's test suite and we were having multiple
failures[2]. I noticed that the tests do expect binaries to be found
in [3]:

SANE_TOOL_PATH = /usr/xpg6/bin:/usr/xpg4/bin

That paths contain posix conformant binaries, but the tests do expect
Linux-like behaving binaries.

The patch I am about to apply to git

--- git-2.35.1/config.mak.uname
+++ git-2.35.1/config.mak.uname
@@ -162,7 +162,7 @@ ifeq ($(uname_S),SunOS)
        NEEDS_SOCKET = YesPlease
        NEEDS_NSL = YesPlease
        SHELL_PATH = /bin/bash
-       SANE_TOOL_PATH = /usr/xpg6/bin:/usr/xpg4/bin
+       SANE_TOOL_PATH = /usr/gnu/bin
        HAVE_ALLOCA_H = YesPlease
        NO_STRCASESTR = YesPlease
        NO_MEMMEM = YesPlease

Makes all tests but t7812 pass successfully. t7812 fails on locales and
utf-8 which do behave differently in Solaris.

I would suggest to update the tests to use /usr/gnu/bin path.

[1] https://github.com/oracle/solaris-userland/tree/master/components/git
[2] https://github.com/oracle/solaris-userland/tree/master/components/git/test
[3] https://github.com/git/git/blob/master/config.mak.uname#L176

Thank you
-- 
	Vlad
