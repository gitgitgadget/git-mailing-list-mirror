Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD63C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 17:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C102B60EE9
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 17:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344492AbhIXRJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 13:09:44 -0400
Received: from mx0b-00209e01.pphosted.com ([148.163.152.55]:48568 "EHLO
        mx0b-00209e01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343657AbhIXRJU (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Sep 2021 13:09:20 -0400
X-Greylist: delayed 8319 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Sep 2021 13:09:20 EDT
Received: from pps.filterd (m0115756.ppops.net [127.0.0.1])
        by mx0b-00209e01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18O9KVPm011668
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 10:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ncr.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pod1119; bh=0I+ZhbzQFJgQEkEjTXbNjcEjx2xMQNDTDwruq/nw/3Y=;
 b=u0q+dIKMTx+06AZ3flr7twHJmeMmV08wwAHtQ7KjrTHMO3TWOrhMOxuRGgXnfJJ8SVBx
 LvdsVjqa8HM49zWjdVjWf+OGEm6NEP0n3ETyPEXpdYDJ+uqijxtcYDjO5BtTIaDzrmHj
 Az1EPvRcWyDHEu5a4KOxxGVbpdvyPEMtPpGZwGPsNk9Ah5X6iapkr3iL5yMAJlv7//Eb
 SX4JcPD5fwfGb5sbrep8nrqqkGZBsMufT9iuJHVI+ZrEa9y8N/hscf4NPE8nbkL+0Tc6
 DXo265U2IWeFQRzq8mYk/LfKGECbYAr5NbqNyCTbqlZ3rGlN/5W+vY7frYvX0I4ZcsLI GA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by mx0b-00209e01.pphosted.com with ESMTP id 3b93f1mdq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 10:49:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bz6psRu+0Ix87buXeZ9NXeosRhMy9HIc949TU205DEC6Nt0VJdjYwZqUf66sLb4hPbxNn5a5i2kCa4bw5Twu2wG7IBZN1Cmyx1EWt4WZV0tRyczbNZVAn9DTbOPupQIunsYquVLBbYzvzQ+xHS3NVMc/Fq5k/t3+3gKICQGe6eoS+rlmXer79dlTWKlEh8jHaQbSuTJayYP+yzjOZjR60s4aschaZoOE1Vy4WJEX5za/5RNxPVtIyNR6xtIxtpb3WU26wA13eXzdvsW0haz5VLA7ZBkFTe1CrQPPxYB2ZnWF3+qYgIAVQc0IxZViXM5oAc1wTjJmqwoOL9ggUYlxsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0I+ZhbzQFJgQEkEjTXbNjcEjx2xMQNDTDwruq/nw/3Y=;
 b=aT/YoEB8w9CoB0uk+knJkXNHZyDGSJc62/KRqnTmP5tHg/kvC4ayV1jXz7ZoorE4Nl0Z+G8m2OHFUKl9g5qPtv3ejieuU9oOvy0t6vcdyv7Gy4BLhLZ7K0q/8sf5UIcYUAkFVuc1HEZwFIEqHLEEFt4EOkdMMKwovn5ens3IlOsZKWSvzrmQylKUTLqc+IsBap7crWd9/VjgI8aIZ2J2Z8GqU64iUlx2dYyBB9rSX+v1j7sc/wyZIC4OsBSAjn9jH+BOVQ2xgDVslDC8IdJGoeWImr3nxIz3m0IVCuBPWv4JE9f9MKVFGLVrbleTFJXcO0gohmrHrW/F2hCu30G6nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ncr.com; dmarc=pass action=none header.from=ncr.com; dkim=pass
 header.d=ncr.com; arc=none
Received: from BN6PR15MB1426.namprd15.prod.outlook.com (2603:10b6:404:c4::18)
 by BN7PR15MB2450.namprd15.prod.outlook.com (2603:10b6:406:92::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Fri, 24 Sep
 2021 14:48:59 +0000
Received: from BN6PR15MB1426.namprd15.prod.outlook.com
 ([fe80::fdf3:7fad:62b4:e015]) by BN6PR15MB1426.namprd15.prod.outlook.com
 ([fe80::fdf3:7fad:62b4:e015%12]) with mapi id 15.20.4544.014; Fri, 24 Sep
 2021 14:48:59 +0000
From:   "Russell, Scott" <Scott.Russell2@ncr.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: pull failed - why should I receive this message.  
Thread-Topic: pull failed - why should I receive this message.  
Thread-Index: AdexUt9vq4ww6wDrT/SkOsyNHqWUqQ==
Date:   Fri, 24 Sep 2021 14:48:59 +0000
Message-ID: <BN6PR15MB1426A342CBA9D993C0C49E55CBA49@BN6PR15MB1426.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Enabled=true;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_SetDate=2021-09-24T14:45:22Z;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Method=Standard;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Name=dc233488-06c6-4c2b-96ac-e256c4376f84;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_SiteId=ae4df1f7-611e-444f-897e-f964e1205171;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_ActionId=f6047282-e59f-453b-8bf1-bef0a06d57fd;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_ContentBits=0
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=ncr.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 443e0d7e-3ce8-4100-6a2a-08d97f6a7174
x-ms-traffictypediagnostic: BN7PR15MB2450:
x-microsoft-antispam-prvs: <BN7PR15MB24507128799F0A18CB4416E3CBA49@BN7PR15MB2450.namprd15.prod.outlook.com>
x-from-ncr-tenant: Processed
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +/a/K1dfV5FFiuxhbsRTcIU5Tm9piHEUbzMHHkMBy31ist4iVV2fjo+CMRoMFuCD9SmPWoS8Rhs/pWiZozT96Vuezrv3t6dhBksh96OyiwkaLjG81l6ur99hHnsK54hkVQ6BfCVISuAwLghUsJNH1Ynjmtgw+jQNsY0pZB+sEAMnIM4ZOpU2AlbzAVXoBapojBhh/GOBIehnXq1OzUE5WG7AJ6Sk9kmwUKCsjEn/O3U5ai1ay0/UAojVrDQVR3g2jS/JBJFCCvxe3SChdzZbZhDxK5c+rAZtTZbZMZvvW/VzVE0BOd8X1kv4jK6bDkuLwNug8ay1YUgxE2tbOeUJyvwQL7jkWNTTGwoAjt/uwT5iVeiKIaV7YUH1sJB+Y99vYdh2iN72Svv9GgZp0ZLBaERHA3Js2XZ2D0QQjaiTe4kte+pyn0LbI4d0LNDlDjK7m1y5cPLuKlRLf1SmGMur37iheyT425xYM7IutJhDjlMs3w/ujCa+IeaD1ETEXpdzqauX1AN6x+wt2tZcrstv3ezoBEcBLlrjWJakqdjzpxX2seOMBb87lvWRpVqlFWvLzPBOwgbJXCPOsgDPMLfKA6/MaZE6/3VAF5EsrVZRe8vd+ZzK3tdWxqSJ4C3jBsBVz+L37GT2dzqNj/Z9bbebAvLfQltBdlsAWFaDqsoZY/VNUW7dNA/S6wdWPqwL4gcejcF+bpwN/qC5fx15NgcX77xw44TK7NhL83YKVciu6HCLG6A9GRQYqQOeMhlyLEmcNqC61KYfjdpdC/7i2kGSFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR15MB1426.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(83380400001)(86362001)(6916009)(55016002)(9686003)(7696005)(8936002)(6506007)(5660300002)(38070700005)(52536014)(186003)(26005)(71200400001)(316002)(508600001)(8676002)(122000001)(33656002)(64756008)(66446008)(76116006)(66946007)(38100700002)(66476007)(66556008)(460985005)(2480315003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2aD2thTWd64J3sz6uSi+lMasipHH+BbR/PD16NuMtTFDnyDCUCZ4A7acWojG?=
 =?us-ascii?Q?OB9xxcMyU2wfytPun+K6/fugrZa0wQIW0ASvNjzFpZvgejRZiWez1FkByqg+?=
 =?us-ascii?Q?XjCzmd9g8msVJEnXWxaOFwUCU6SechTfZ43aSrj/mrEZW/qxtCVbOR3KeFEq?=
 =?us-ascii?Q?tl/cC9SZZL6y71KF1mg/55LTbgEREcVAx9nuy2TBLXzH2Gf0DTnNLMt+uISx?=
 =?us-ascii?Q?qkpVpuXA07fz8n4Jef8JPA6/jQ8A6gV5HbX/uXdAFfF1wnAbLwrsmhEFLP6g?=
 =?us-ascii?Q?sBYgwdAgxnJ5LRw6EH93cXqva1OKDgo+bs1+LCzTgCBKXy2Sze8dAkGO0Rm3?=
 =?us-ascii?Q?gDbvW2eZYrKX6tFx6ImKQWCy8ySq09Yx0BQKhMQ3orY3NP1P8e6mjElXNqrq?=
 =?us-ascii?Q?OTIX/lN1pDCCWkFPWY7QdG38BEbgWJ1Qhj+ALsqGcIVHQLNpwIBvzYb1FXAb?=
 =?us-ascii?Q?BpLVDIZM1KV8mBVBuV0o9+NI4/XoTplH39pwnAydsQMJghcmlG17yoRw8x7f?=
 =?us-ascii?Q?AcOY4MNsLeBsd40leTqjvLBrxDjbBS5i2N1Kg0zBWW/Uwd75N5q1yBMAdr5B?=
 =?us-ascii?Q?4vUEmCotRcmKmyKnk+At5TokSMsIVDKbHfXdDPWVxyBdgYvxRICbft0RlCux?=
 =?us-ascii?Q?+cUebwt2uroIu8RbE93+tCJEFndbXpBWiMKANE4k0KnxIYXO9hpkLEuCaRma?=
 =?us-ascii?Q?9PBJas3SH0mmF8GXtqeUPwHle9vSK7ujadbz6dASiPIt+p9tl/IeLTZNT34d?=
 =?us-ascii?Q?M7pUDR3tKfPsTrSmjr9FAEvHFQ5mLT6Yl0L6xU21fBndaZfu8bnwUhhaA3F/?=
 =?us-ascii?Q?ha/WeFZliynzTvkHCeCgJwxQSA4V3fTvv42rQBm/fcEAsuVFsm4blLeG9Snh?=
 =?us-ascii?Q?VROiNpYdaAL1/dMVPQxKUCxbtobRsLNXZd4gMu42T6qe+0psuwc4G+MOv0H4?=
 =?us-ascii?Q?6PmOr/Bpt/AiAPqwgdP3kmyGfrX9iZTBhV/TyKFIhV7hbmgvnRgKSaGlBXp7?=
 =?us-ascii?Q?pdPwzobObrqSY3Axk8UjmHiTuKsU7e9mOQiTrJDH4qQsViASarTVRzPe81zl?=
 =?us-ascii?Q?bcKOuF2+1pOmDUfTRxsRpKpcLDcNiIQuOFZqWTo5Grugqqdgrxpd5mt0wdh/?=
 =?us-ascii?Q?q3qgyLLignPuEHsZSx1TmfNY04Z9Zc3iAmV7OTtkFsn/TPaIlFXYX+W7V1az?=
 =?us-ascii?Q?sJyJCQTd/RCGqtiBhDLKpPatNPgDLC8vAW4DKWXCTQVX1QnBH1ALY2kUTFy7?=
 =?us-ascii?Q?AE+3crckMY1GQyZv62SrutIOaRwNtsiMDCUUT8/jK1k2qkeZug+R24E0EM50?=
 =?us-ascii?Q?u4mcQ2BMJig+h/tfJd9F6tzJ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ncr.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR15MB1426.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 443e0d7e-3ce8-4100-6a2a-08d97f6a7174
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2021 14:48:59.4752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ae4df1f7-611e-444f-897e-f964e1205171
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hen0ZULW5rSOKeaPUpVq+MS+v1JQ+PbzgpGGqtqLNZ91aEiqGDPkn+p+wQ/8cZwBNXtwBfq0+UTUf5Av4Ya8tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2450
X-Proofpoint-ORIG-GUID: 531U5AmcfUp19hqV6B8enPXt68CiD1vX
X-Proofpoint-GUID: 531U5AmcfUp19hqV6B8enPXt68CiD1vX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-24_04,2021-09-24_02,2020-04-07_01
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Files not previously in git were added to git.   Why should I have to manua=
lly delete them?=20
Why can git put not replace them?  They were untracked files that are now t=
racked  and so the git copy is desired. =20
We can't always know ahead of time what files may have been added elsewhere=
. =20
We need the pull to work automatically.=20

error: The following untracked working tree files would be overwritten by m=
erge:
        Staging/CADDApps/CADDUIHelper/Source/Release/CADDUIHelper.exe
        Staging/CADDApps/CADDUIHelper/Source/Release_Unicode/CADDUIHelper.e=
xe
        Staging/CADDApps/InstallDriversPackage/Release/InstallDriversPackag=
e.exe
        Staging/Common/NCRCommonCCLib/Source/Release/NCRCommonCCLibMsg.dll
        Staging/Devices/NFC/Elatec_RFIDReader/Bin/Director.exe
        Staging/Devices/NFC/Elatec_RFIDReader/Firmware/AppBlaster.exe
        Staging/Devices/NFC/Elatec_RFIDReader/Firmware/flash.exe
        Staging/Utilities64/SSPSWDriverInstaller/Bin/DIFxAPI.dll
        Staging/Utilities64/SSPSWDriverInstaller/Bin/DriverForge.v4.5.4.exe
        Staging/Utilities64/SSPSWDriverInstaller/Source/Release/SSPSWDriver=
Installer.exe
        Staging/Utilities64/SSPSWDriverInstaller/Source/Release/SSPSWDriver=
InstallerMsg.dll
        Staging/Utilities64/SSPSWTaskMgr/Source/Release/SSPSWTaskMgr.exe
Please move or remove them before you merge.
Aborting
Updating e6f37b6878..02aa693031


Thanks,=20

Scott Russell
Scott.Russell2@ncr.com  |  ncr.com
      =20

