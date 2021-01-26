Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD495C433E9
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 14:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A760E22EBF
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 14:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405833AbhAZOff (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 09:35:35 -0500
Received: from mail-db8eur05on2110.outbound.protection.outlook.com ([40.107.20.110]:5760
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392729AbhAZObJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 09:31:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cj1z7jQKHHNl8VzMMeRoBUWraiOVsdLZYfjzdcNDD7ZqtnhQ1LZCabxgIVi2c1gruLy6qIlOcl/1OudIJhfKNocXc4jqdhmtzXpYB2tj4Mcmp0VdcXvUt6plZbPTBjHrwpHDT/V8PjqUmFuBEEz6nqGS9BVScrWsfG+Zdol8QPlaUax5fk+Z30RhjzoOuhUeR84pHvmIWFFkXHGjNXiPE2IaXrIzK73EcuSpgbhHuEmO3SEyaaQLWvetLu8J1kTYKJqEL6Jccm4C/HeJH/F/TRA6bTslme7c4UPITXKlz+ZQTTEHdsDwfEsm2fLmyj2kcaQ+aZ7d+SZ5mg13ZN4mPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0Amv8nblUWDKcEeNYRratCau3/FsDbwoJuv7Z7d8Rg=;
 b=mrDgCIvv1FkMQmO/ZEcRB1zffw9kqQPuYWPAWP5EankRR0eBu9Rl/y5YQkyFwpxh17G6W9VhXR1pqDVuiKlqsbeNJtLeQ2ra/bdhoEWyKSEcirSlFBEnkdSQhrHqGr4B/HAqTaUCgfXvnZOuniFKizaIQnGxgyRG/U1krZ7SCidBbZx1h/bSRIagJqkljYXIXXQ788upbHL9dBCMgkEwJ1cgbpQ06Y4ge4yQlHShD35+u+zoioI4zAaroPjlKULjqv3rX7wmCzmlp/CdNDL0XTtDn+NKYnzKGAmScBaxbwPleq6lR0MtW1WhMWh36WsP4TVJb8RmVu339c8zkmAtrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0Amv8nblUWDKcEeNYRratCau3/FsDbwoJuv7Z7d8Rg=;
 b=Dtv3Zc45+3b0nI05pl4Rh8Op6JDB8Ma4XXc9G71yr+uksiTAqS1/4E2HwPH8+VVvpoDNnXtSaNWMBuQxVWJ39V1yQh5mYU8EGQxEUTG6uNMUqO+S2FfFA6JTiRalwj5CUN5/Gn/SaDwJNy6Xccc32WCBvQYjLdfne358O23P+sk=
Received: from (2603:10a6:20b:1bd::8) by
 AM7PR83MB0402.EURPRD83.prod.outlook.com (2603:10a6:20b:1bf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.4; Tue, 26 Jan
 2021 14:30:25 +0000
Received: from AM7PR83MB0434.EURPRD83.prod.outlook.com
 ([fe80::94df:7115:4ee0:8f27]) by AM7PR83MB0434.EURPRD83.prod.outlook.com
 ([fe80::94df:7115:4ee0:8f27%7]) with mapi id 15.20.3825.006; Tue, 26 Jan 2021
 14:30:25 +0000
From:   Rene Schumacher <Rene.Schumacher@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Git Commit Signature Encoding
Thread-Topic: Git Commit Signature Encoding
Thread-Index: Adbz7Oh9PSrPF9WVQ4qtX5G7B9S16AAAkSXA
Date:   Tue, 26 Jan 2021 14:30:25 +0000
Message-ID: <AM7PR83MB04349E882710B0EC0E186A09EEBC9@AM7PR83MB0434.EURPRD83.prod.outlook.com>
References: <AM7PR83MB0434B67B0F15E4433347D555EEBC9@AM7PR83MB0434.EURPRD83.prod.outlook.com>
In-Reply-To: <AM7PR83MB0434B67B0F15E4433347D555EEBC9@AM7PR83MB0434.EURPRD83.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=aa93a574-9ecd-4031-8287-8b068332c93c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-01-26T14:09:32Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2a0a:a543:d741:0:7057:efb2:100f:dd54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 34351326-7ac5-411b-811e-08d8c206ebf2
x-ms-traffictypediagnostic: AM7PR83MB0402:
x-microsoft-antispam-prvs: <AM7PR83MB0402B9867EF6E1DB840F7FBFEEBC9@AM7PR83MB0402.EURPRD83.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gaRqhzVtAnmyXx6/JVgRdF0IVQDQkeHl0aq2oyKJJrfvLKTFmCv0DXmbrkE2n0meBUsnNzVo5Sw4xyoWm+ezvBs7Z0SrdenqjjjV3GpCwbive8S2jM0cB7/KcvBA5e6ZtrBKAjyr+3Sh+Kj1ViIifGFFlKdGuq5bSfAv3bLa0Ku9bmHZ+9UHOzQBzHBA0eRR5fnrz1AOZIGSbY2pvd02ssQkEZMyxbiPsDqZJkK2Fw4OcpVZDao7S5iHHp17MkwOqQzLXwvKs5yTmuxVTTWPUOJqX27Js0A90D6ZeyfImgI92uAJYu4+J7wjz+ttB4SaziX+DvIZWBYBCe+vBsx9cVYrWHmY3Q9GSSOkakKcYNIMf869nDz/XdmGmM7Al3RZFoH8DCfQB8lWOny16DvCSluGHt2oo/+OiBhspYOo9X3/dzMqY4+R+CF72JPTK+u7/e0xzGbcvADu8gYiWWClxyN5GbSZ8pHKEWfA2pENhTGCMcsA84yrQGE0JuD//1IFFuMf2syZuuRykF364wz4Tg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR83MB0434.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(6916009)(2940100002)(66574015)(66476007)(5660300002)(66946007)(66446008)(2906002)(316002)(83380400001)(64756008)(6506007)(3480700007)(33656002)(8676002)(8936002)(66556008)(10290500003)(52536014)(9686003)(478600001)(55016002)(86362001)(8990500004)(186003)(7696005)(82960400001)(19627235002)(82950400001)(76116006)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?RdwjlemDQCWGQ3xX+wt/H+FVlkRFoB13sp5V4T9cZcBeo8TqbBmfPhY/ne?=
 =?iso-8859-1?Q?ePp1Z+9Hj77sUV1J6iMuAaioojyWGbsvtxke6UWqw0xNHjMqWunhyJRByX?=
 =?iso-8859-1?Q?dD/57rjhD6lrvT7SLFDWTXv2/gLWmhAqmQCfw1ADHgeZBVe30PaU5e43z2?=
 =?iso-8859-1?Q?MmE1ilX7GvzmLPLJcYmlMurVlk7ZPWWC2mPNRSjA7poPbYvFXZ7d+8/30H?=
 =?iso-8859-1?Q?10i+FGLaAEXbhNcI1FBR+U0tFOORakqhv3iQ29sXIZ0bfg9mea+3rm6tHH?=
 =?iso-8859-1?Q?EZniy7mSbBpjLgFYSED0Id6GV4TWb0u3xZD5cBcEFpeLj3/gzklKfVHN0d?=
 =?iso-8859-1?Q?7e6e1VWjRTKx4Xx+pZHifSyGwghqtKhafDblPDTGMng5lY+OHpETIgwEG1?=
 =?iso-8859-1?Q?P+oPqhjK7fGLrvtz0lqmqpFPWSUwmTeS9q9+3zPC1DRo3I1yC+obH+/2c6?=
 =?iso-8859-1?Q?wB51uXC00xLVR6PpY59pi7YT4z0psBofAbjm3PC7vauEH5x5g63rSXRhMv?=
 =?iso-8859-1?Q?gjTQ97yn15pMmRZDIIQrCU82SlVPf0lKqfUM0xJlFxPi0/aBBmdrhcB5dd?=
 =?iso-8859-1?Q?tcari7IQ8fQ0WKkDu1OnSCD9+MhWBY1B5AuXSmvixYUXExr9s7HbsiUwfy?=
 =?iso-8859-1?Q?MWdDfSMENKHxV5xLFt1e9hmafba7deL7P5AziwSHBNXvVMuHigtwmBOXC6?=
 =?iso-8859-1?Q?mBaHabOoZNz44qSuiYgx+qUubAfqe6SRqSegV4KFhNs96RBoAHO9RZws5R?=
 =?iso-8859-1?Q?FiCuZR6mjmpKdWqC8zVGEjG0WP3G1Yc6yO2HVZaj4JVGrB1jmf7u5F5mmJ?=
 =?iso-8859-1?Q?CgEGQiLrohOSqGlWAYXpegaxNiCA1JZsuNXbwL3SH3Xayn2I6//8fGWlB0?=
 =?iso-8859-1?Q?0rd+76ZopsNKHnQ4bnn5cIKflw71xK3VbDMLc7OcsVXTHULZQqZBWEO80v?=
 =?iso-8859-1?Q?xqhHagQQuw8LURsXhy7hW1gXOG1igC6bL7jzrqYL7Zs3xj9PJxHRhaAzEx?=
 =?iso-8859-1?Q?ABp0y4rQJaaxL+oAhQ+nL8eJWIeeEIOy9ok55OOJcho68Ktoq3SdJbfPgV?=
 =?iso-8859-1?Q?vA+qmbDOPOrQtut+5r5JW65auZKqB5pcGKH/iVJx/2HLnZX2FyCREkHgHk?=
 =?iso-8859-1?Q?8s3x79vrgIYli7y8BzW+oQtqs2STYrYMoS6+VOzKkNAcUV8Rog?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR83MB0434.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34351326-7ac5-411b-811e-08d8c206ebf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 14:30:25.5014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G5TVXrhu1eiQGZjs987Cn9AXRCkgBLdzeJSbsd/+QZ/oakLDBhzHdI86RyUE7klw41//4Ta97VeXMDvzguC0Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR83MB0402
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I'm trying to fix an encoding (?) issue when viewing gpg signatures for com=
mits in PowerShell Core on Windows. Apparently, git changes the output from=
 gpg depending on the command used. Here's what I see:

git show --show-signature
This command shows strange line endings and is unable to properly display t=
he =E9 in my name:

commit d7a43da0bd3bc7e31dd46afb8ccd78735ba43a36 (HEAD -> master)
gpg: Signature made 26.01.2021 15:28:26 W. Europe Standard Time^M
gpg:                using RSA key 3848D5B2A3D45419D7F564F97802B995CDB4A2EF^=
M
gpg: Good signature from "Ren<82> Schumacher <rene.schumacher@microsoft.com=
>" [ultimate]^M
gpg:                 aka "Ren<82> Schumacher <reneschu@microsoft.com>" [ult=
imate]^M
Author: Ren=E9 Schumacher <reneschu@microsoft.com>
Date:   Tue Jan 26 15:28:26 2021 +0100

    Commit with signature

diff --git a/file1.txt b/file1.txt
new file mode 100644
index 0000000..a7f8d9e
--- /dev/null
+++ b/file1.txt
@@ -0,0 +1 @@
+bla


git verify-commit
This command does not show the line endings but still fails to properly sho=
w the =E9:

gpg: Signature made 26.01.2021 15:28:26 W. Europe Standard Time
gpg:                using RSA key 3848D5B2A3D45419D7F564F97802B995CDB4A2EF
gpg: Good signature from "Ren82 Schumacher <rene.schumacher@microsoft.com>"=
 [ultimate]
gpg:                 aka "Ren82 Schumacher <reneschu@microsoft.com>" [ultim=
ate]


git verify-commit --raw
This command does properly show the =E9 in my name so I guess that gpg outp=
ut is correct and there's something happening while git parses the gpg outp=
ut:

[GNUPG:] NEWSIG
[GNUPG:] KEY_CONSIDERED 3848D5B2A3D45419D7F564F97802B995CDB4A2EF 0
[GNUPG:] SIG_ID jBtyyA8QIDL0tD5fneVqJo7oU/8 2021-01-26 1611671306
[GNUPG:] KEY_CONSIDERED 3848D5B2A3D45419D7F564F97802B995CDB4A2EF 0
[GNUPG:] GOODSIG 7802B995CDB4A2EF Ren=E9 Schumacher <rene.schumacher@micros=
oft.com>
[GNUPG:] VALIDSIG 3848D5B2A3D45419D7F564F97802B995CDB4A2EF 2021-01-26 16116=
71306 0 4 0 1 8 00 3848D5B2A3D45419D7F564F97802B995CDB4A2EF
[GNUPG:] KEY_CONSIDERED 3848D5B2A3D45419D7F564F97802B995CDB4A2EF 0
[GNUPG:] TRUST_ULTIMATE 0 pgp
[GNUPG:] VERIFICATION_COMPLIANCE_MODE 23


I already set the environment variable LC_ALL to C.UTF-8, which fixed the c=
ommit message output (see first screenshot) but unfortunately not the signa=
ture output. Any idea what might be causing this and how to fix it (if poss=
ible)?


Thanks!

Ren=E9 Schumacher
Sr. Customer Engineer
Tel: +49 89 3176 - 4908 | Mobil: +49 151 5895 5728 | mailto:rene.schumacher=
@microsoft.com
Microsoft Deutschland GmbH - Niederlassung K=F6ln
Holzmarkt 2a, 50676 K=F6ln

Microsoft Deutschland GmbH | Walter-Gropius-Str. 5 | 80807 M=FCnchen
Gesch=E4ftsf=FChrer: Sabine Bendiek (Vorsitzender), Thorsten Herrmann, Benj=
amin O. Orndorff, Keith Dolliver
Amtsgericht M=FCnchen, HRB 70438

