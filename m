Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0899EC43217
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9C6C20679
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbhAZWAA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:00:00 -0500
Received: from mail-am6eur05on2095.outbound.protection.outlook.com ([40.107.22.95]:11873
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730384AbhAZRFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 12:05:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8ZYAjm1EdhVrGCSz6yZ6sanNjK9zUSu/0L4Rymbg9PVtF/dzNieGuGKHSeAadjEAkk0pmFW4nSD17V3TInKem6D2J42UMt3q1MlqsHq6dag6n6JPYNDp8gCi+YDAR/aDxRhL2Mi3k3vkGfeGNfMhGBb2VBfFo3v9xRRKzcIpIUMp+NsIOczkwar8smTXOlAIJyei1THoTimQ97/tqd7JbPGkF6r+QU0gVzDkeFpiESezjnfuYzx2oEZmQhVezY/Qto8P3CE9/Z9hhA3IiY4vj0KKsFOfh/HQyL+0WzHH6qTNJ/XKmaF/9LmWLP7UlyghHWVrNroGdrhjleiWsKlxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwVktCpc31+PkfDrDXMahWOVWiK13dOoCn/A/IvJ5JU=;
 b=UeBYCiT0GcrYcV7eeeFGtPstaF+tA2Tk0kPATn/VVEP/V0Hw1flUmrdL2eePQFff940nrFvnMFyrHTS9s9ULQr1djNvHLFCPQFfUkMthhiJ28RT6uCVsRQgy95GrVijmMM72C1KH1GOgKEI3kI1Q3oZI+wojBbrA9fkmo7VyTOVvF4ou+Z/4yD5TQvCmKLP81ka1DwI1VxUEFV21yDIo7zafitrGpKAGUZdQldBV/fU6SgkuKRE6l8qsFE1tWN+Bgfb5b+0+e2JNYyrMVOhLAwaOVab7EUQqgyuYeXTlXreJZtC7Al1XFScANVO69rBnFxyqPfiMRDjIPZ5bWJVr7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwVktCpc31+PkfDrDXMahWOVWiK13dOoCn/A/IvJ5JU=;
 b=QysCbqonFP1ZsBu5Jf1XtBcWMGnnVFF7oDoccA5NxYWirj4tG+YAfi0MEK1nJU4umFBcPwx6T7rhnz6OIXUdFWTcqd7kXVqsT1n4QLaVN4bcPbOOn7gIyxZDUOagtlx9XdqjGPF94bHhA8sbG1n6DMHB03XO0In9oeyZlAfmQYs=
Received: from (2603:10a6:20b:1bd::8) by
 AM7PR83MB0404.EURPRD83.prod.outlook.com (2603:10a6:20b:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.1; Tue, 26 Jan
 2021 17:03:57 +0000
Received: from AM7PR83MB0434.EURPRD83.prod.outlook.com
 ([fe80::94df:7115:4ee0:8f27]) by AM7PR83MB0434.EURPRD83.prod.outlook.com
 ([fe80::94df:7115:4ee0:8f27%7]) with mapi id 15.20.3825.006; Tue, 26 Jan 2021
 17:03:57 +0000
From:   Rene Schumacher <Rene.Schumacher@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Git Commit Signature Encoding
Thread-Topic: Git Commit Signature Encoding
Thread-Index: Adbz7Oh9PSrPF9WVQ4qtX5G7B9S16AAAkSXAAAVjBjA=
Date:   Tue, 26 Jan 2021 17:03:57 +0000
Message-ID: <AM7PR83MB0434CE5BAC56BA8FDC3E6F80EEBC9@AM7PR83MB0434.EURPRD83.prod.outlook.com>
References: <AM7PR83MB0434B67B0F15E4433347D555EEBC9@AM7PR83MB0434.EURPRD83.prod.outlook.com>
 <AM7PR83MB04349E882710B0EC0E186A09EEBC9@AM7PR83MB0434.EURPRD83.prod.outlook.com>
In-Reply-To: <AM7PR83MB04349E882710B0EC0E186A09EEBC9@AM7PR83MB0434.EURPRD83.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 1aaaa365-c55e-4421-cf9d-08d8c21c5ed1
x-ms-traffictypediagnostic: AM7PR83MB0404:
x-microsoft-antispam-prvs: <AM7PR83MB04047DFA4333CE56FD9590DDEEBC9@AM7PR83MB0404.EURPRD83.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o1eCK+ZmP9fnkSzbjdAYPYsxoTSIAbaYWwAo1C4DbRJOY/mG1cNo2ymtpcIPM3J2S45MRQMjqvf8Jy7yisH2U98W8gL4aQovcEikl+wEWXwfNIAgTSMy5h1tX8VXcbK6/LuTwUzD3c7Bth68uF6HfzuEQgIpr8RqGmwgskpwvV8q6aynyjlO2sal+N2UqKXLJeIsPA8wOi+qPoMiLHvck1CjiryV0SiG5JCrYIjAtIwL+jqVaRxUJQjf21ZE9CwkRL3/NhykEuBcFwlVEq1BHy4flQi4m6wOKcr9d+TTI8ZkmIE/VlwUDSe/diFLAIwRBJf2awOPDxS1BdMiBrJnoclslIaqMyi3Layu/Co5zFWezY8009Om2vwchItRzn4dKknYddhIujRWN17AWgMhoQWB6z17sswuUrro09D24ObOUYXJsPI5w10JDgpIp/rXeaR6svgmInszhZ/gy9H4jgVjkjGjnWvfAfnXOLk1VdO1ZeYRXUcxhNoan7J0C1HL6sEXiFl+o8E4w7BRfztJLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR83MB0434.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(2940100002)(9686003)(186003)(86362001)(19627235002)(66946007)(66476007)(8936002)(8990500004)(76116006)(66446008)(52536014)(5660300002)(2906002)(55016002)(71200400001)(10290500003)(6506007)(66556008)(316002)(478600001)(33656002)(64756008)(83380400001)(82950400001)(53546011)(7696005)(82960400001)(66574015)(6916009)(8676002)(3480700007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?eDhm8cGop65N53tbe387NwqglP4p7yOiDN04uLzvkVrln99dV8iJSjRSPl?=
 =?iso-8859-1?Q?MNQwonsBoxtwst42zC/gPPm0THa2uWNye4v4KBJROpqbcTHhpyTsk0TtyI?=
 =?iso-8859-1?Q?4heRE2PmTV7BssGqexRXizAxUrdbWJDfSAL6IypEO6OO2+LyWJvhzfI9Mo?=
 =?iso-8859-1?Q?Egwbx3jwkiICXcj7/HmHgofmynbk4zh80JuG/Fo7x1foy0S9Ybra5rttSV?=
 =?iso-8859-1?Q?8uMj2AIAvIF5faKiZZC3XtXp5iPe2+nBPJERt8/KcNbzJ9Ub8wIAMRMzVM?=
 =?iso-8859-1?Q?N9HD3U2okqzbvF8MeBssBdGwU/XWkD/N8DX/k0bBgWQcJERNPvRJS0pHTU?=
 =?iso-8859-1?Q?89WaemLDYMReKSyLF/MHzz48d292ZF6+wC8VHfz5tfcRYo9tzOe5JWU8GM?=
 =?iso-8859-1?Q?q8YUjmnWMWFRMEqKZUaktVk5Ol/ZQnL2ZDMT6R/U9T29RvVlH8hrsID/lr?=
 =?iso-8859-1?Q?0F682gbhhpvqWcBmkEZxMw9vEjq5//Ym3f8gJ7qS4MJdFEdTHs7RUAG5Tg?=
 =?iso-8859-1?Q?MM4CuK4l/TFCOVDNC1FC4sviqPkgmYs68G8R3LF4qy1hsv3GL8dOL3P86n?=
 =?iso-8859-1?Q?siKnQtRGzLSQtJjfG8L81pQcsF9WbsIRPcjH6ml1+UatPIgRe2OBUcPWcX?=
 =?iso-8859-1?Q?+dgmbAJD9eKmI49aqbI2p7CqYgNK9QaKBjwBRFCEo3MVu4VFpBYUOoF7di?=
 =?iso-8859-1?Q?mPII2pqh+Z/LJCkhssAAcyJP9XbfdcEPP6Vu3nYATJj4sN1XaYKJiZtdtE?=
 =?iso-8859-1?Q?FeXGYPzafKcFcwSdVwwXycskIFVKz+1NMKVI6/lQEouF2KJ8g/qN3APlVc?=
 =?iso-8859-1?Q?2WA8GxQ3vSK4ZlG7jWy9eh3PlAA92pnW/JLg55PKJ9GNxDz83TXNhtaZar?=
 =?iso-8859-1?Q?/iBx0tAzUbdMZ+gjiaLOyLTizbyDoSAyEMmMaJie26A9boMAVAsFJT3gcx?=
 =?iso-8859-1?Q?VUqleyS6WKQRrZMmIayYXWQWxLq7npO6Lzlu4nn12K3g698eWx1sKYJxwD?=
 =?iso-8859-1?Q?wIl9GVnGngFTjazGjcQ6vqHqoDz2Qebi3L2dexGl9Bpf1gMBakFH1TrzLY?=
 =?iso-8859-1?Q?pA84fnruIlRshOcw8M9iqsPPONmgEBmdvzO3M1nw6eTzK4T2MBXHdXu5XD?=
 =?iso-8859-1?Q?B4A6tqTmwg/7TXGYBr/q+rn/Gl5d8Jb5RIM38KeUBUXPdQ5w7i?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR83MB0434.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aaaa365-c55e-4421-cf9d-08d8c21c5ed1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 17:03:57.6684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HaSCiqP+O1vII+nCdymxizC1O3l3kKN6kUbuyNjedSZ3PIYGNVzGlLV50yMc8mDIgaOMYUTa8unDhTTqmoZjiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR83MB0404
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi again,

after a bit more testing and research it seems that the issue is actually c=
aused by PowerShell's OutputEncoding, which does not default to UTF-8 (why,=
 oh why). :(
Setting the OutputEncoding to UTF-8 fixes the problem with displaying umlau=
ts and the =E9. I still don't have a clue why the git show command adds tho=
se carriage return characters (^M), though. I'll dig deeper.

Ren=E9

-----Original Message-----
From: Rene Schumacher=20
Sent: Dienstag, 26. Januar 2021 15:30
To: git@vger.kernel.org
Subject: RE: Git Commit Signature Encoding

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
[GNUPG:] KEY_CONSIDERED 3848D5B2A3D45419D7F564F97802B995CDB4A2EF 0 [GNUPG:]=
 SIG_ID jBtyyA8QIDL0tD5fneVqJo7oU/8 2021-01-26 1611671306 [GNUPG:] KEY_CONS=
IDERED 3848D5B2A3D45419D7F564F97802B995CDB4A2EF 0 [GNUPG:] GOODSIG 7802B995=
CDB4A2EF Ren=E9 Schumacher <rene.schumacher@microsoft.com> [GNUPG:] VALIDSI=
G 3848D5B2A3D45419D7F564F97802B995CDB4A2EF 2021-01-26 1611671306 0 4 0 1 8 =
00 3848D5B2A3D45419D7F564F97802B995CDB4A2EF
[GNUPG:] KEY_CONSIDERED 3848D5B2A3D45419D7F564F97802B995CDB4A2EF 0 [GNUPG:]=
 TRUST_ULTIMATE 0 pgp [GNUPG:] VERIFICATION_COMPLIANCE_MODE 23


I already set the environment variable LC_ALL to C.UTF-8, which fixed the c=
ommit message output (see first screenshot) but unfortunately not the signa=
ture output. Any idea what might be causing this and how to fix it (if poss=
ible)?


Thanks!

Ren=E9 Schumacher
Sr. Customer Engineer
Tel: +49 89 3176 - 4908 | Mobil: +49 151 5895 5728 | mailto:rene.schumacher=
@microsoft.com
Microsoft Deutschland GmbH - Niederlassung K=F6ln Holzmarkt 2a, 50676 K=F6l=
n

Microsoft Deutschland GmbH | Walter-Gropius-Str. 5 | 80807 M=FCnchen
Gesch=E4ftsf=FChrer: Sabine Bendiek (Vorsitzender), Thorsten Herrmann, Benj=
amin O. Orndorff, Keith Dolliver Amtsgericht M=FCnchen, HRB 70438

