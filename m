Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6ADFA1F404
	for <e@80x24.org>; Tue, 13 Mar 2018 18:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753067AbeCMSB7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 14:01:59 -0400
Received: from mail-oln040092004042.outbound.protection.outlook.com ([40.92.4.42]:63618
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753054AbeCMSB4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 14:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=LzQNhGFEXcvmqF2N500Zk3vrvzu7j51GPOwqMUaYwsY=;
 b=KiDHbEUPWdwRAh6+CdeDXK4pCJToo8pMy9Adwfx2VeS+sFOf4yFFaoS4bCl2mY5ljDzDTgQO0731uL0qTEEFhCVNigKTiiHm7RWjNWC7tTYsrZ31jJnlznPA467K2nyTdX2+uDTWT5YlupCI1wyZPD+VJqUXk58r/ikEO6fNYKygDeariWZmIxC9ixuSqvvoB9TUPd/NtI/YCHAmMV4rg0c6GVRZKkoLr1wBGuvY522bLoSCGRAs3TW7IjcJJBaStw5s/dES+PzOirvSz2mMkPDiccdoH5jsrnxssWer9xNSb60JUpGXhksz+eJqQK5qMT5gro4pPYjly5nMKiWe+g==
Received: from CY1NAM02FT005.eop-nam02.prod.protection.outlook.com
 (10.152.74.53) by CY1NAM02HT117.eop-nam02.prod.protection.outlook.com
 (10.152.74.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.567.18; Tue, 13
 Mar 2018 18:01:55 +0000
Received: from DM5PR1901MB2167.namprd19.prod.outlook.com (10.152.74.59) by
 CY1NAM02FT005.mail.protection.outlook.com (10.152.74.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.567.18 via Frontend Transport; Tue, 13 Mar 2018 18:01:55 +0000
Received: from DM5PR1901MB2167.namprd19.prod.outlook.com
 ([fe80::8ce3:8819:e8b3:af6]) by DM5PR1901MB2167.namprd19.prod.outlook.com
 ([fe80::8ce3:8819:e8b3:af6%13]) with mapi id 15.20.0548.021; Tue, 13 Mar 2018
 18:01:55 +0000
From:   Varun Garg <varun.10@live.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [GSoC][Project Idea] Multipart and resumable download while using git
 clone or pull
Thread-Topic: [GSoC][Project Idea] Multipart and resumable download while
 using git clone or pull
Thread-Index: AQHTuvVMS07yfDfThkKVHq6iC331iQ==
Date:   Tue, 13 Mar 2018 18:01:55 +0000
Message-ID: <DM5PR1901MB2167AABED6918A8DAB6E7027F2D20@DM5PR1901MB2167.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:4AD3C0834BE5E272CDF0DC869279DC92ACAAF14D1DF97AB570B776AD07D12511;UpperCasedChecksum:C8FBCCEA51A69B7C49F52F390AC26836963A74507D7CD415C0705162F2E0114D;SizeAsReceived:6903;Count:43
x-tmn:  [XolCrdp3nwPUTDK2TzlCxCC3Ji1ROQx4]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1NAM02HT117;6:n38cqp1cKgxbpKJw7A3w8kkBjxIjDxDne6v3FSn/peyfbBnoGwvsM9rOMCiUlNreged/FWegBNY4WF9T0KdUTk4mmnZV3Rv322eTDFDSnvj2+zMfJ/oLgJVh2UUzN6scpUV08wpQs/XSwrm2r9ymSsHBiwqjZ3vWWh3vbgWi8JImJBxCCKU8/1XQGUjoSRRi/j9JSTYfcaAW28/ut/1XD7FLDHizxGLUgB/Ssv9xcqeEzo5NzPhmEjsPcr/X+/6hvKwJUN21fesOBHgi1X6QhuS+k9fFoxaTMytJ/2BKFcD5POwx8XiAUcDT19IkjBcRk2BpjrnraQKHIue0UU1MmwCl/MhjsHmiT6HRuAmbPU8=;5:7i7frpdONRTPSZ4isuLbHqoyzKsQ318z4EIchgu39jBGl4CQYYtdLy36zi7nhDumsXHdhsFpxcjZzLin3NV2c+AQ3ADN1EMEYYNSJFr+R/OznL2vaiu+eWWZL13dVA48A6ILis1WNfK9j3ud6aF3OoaKPU1rhu/WOxl1sZOedCE=;24:O5/p3yoVwn+FkC5ZN251Tu+w4Bs7da1kOU/IzJLxOOm6q1bWLqfUrcriQ8SNchEkiLbWOXac8IgNVLFl7SYduuE/3irkoNb2rILtaJ5jXf8=;7:85gT7MqGQynWRFMZSUxwU+McUk7HtquPBCjTGYGzY/AsUmpJodcY0X1v6faPzr/px07uDCi1sEvj4SSLIZixoKUxDJUqp8d3mc97uQyc4CFCEV0bSPmIbAdtFEUfxcGcMaO83gVyYErQJ4SJArlr558oTz3o5/RqOWsO21ugr81AnPWXPPhOB5gsBf4b3Cn8iMJNHtgPQ7X8eTgIhhAjhJMVQ4oe/JU36SPc6NYetW78TpM4XJaQiPaUglGp/Cwq
x-incomingheadercount: 43
x-eopattributedmessage: 0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1601125374)(1603101448)(1701031045);SRVR:CY1NAM02HT117;
x-ms-traffictypediagnostic: CY1NAM02HT117:
x-ms-office365-filtering-correlation-id: 4c69acba-b231-48ea-0e16-08d5890c81d7
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(444000031);SRVR:CY1NAM02HT117;BCL:0;PCL:0;RULEID:;SRVR:CY1NAM02HT117;
x-forefront-prvs: 0610D16BBE
x-forefront-antispam-report: SFV:NSPM;SFS:(7070007)(98901004);DIR:OUT;SFP:1901;SCL:1;SRVR:CY1NAM02HT117;H:DM5PR1901MB2167.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:;
x-microsoft-antispam-message-info: Umg7w6XUB+BqCNpN+SM6YqXooW2K0K6upkveM3HuQDq4U8Z+VXuF0XsdovLzI9SuVkMIskD1I4tnJ0wkO0MCUICtA6OI/72kEUoiFbMgMwqiK6Tpz8JYgPSgxhxY7A+j9hIA40da4TCwaRaWyb+vytrrr+3H/e3tF2SAuaS/TXHyXSITyRVSS+CScK7AzNOL
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c69acba-b231-48ea-0e16-08d5890c81d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2018 18:01:55.3135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1NAM02HT117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,=0A=
=0A=
My name is Varun Garg and am a student in Software Engineering. During 2017=
 I participated in GSoC at Eclipse Foundation [1] and still contribute occa=
sionally [2]. I have also submitted a micro project here last year[3].=0A=
=0A=
I would like to add functionality of "Multipart and resumable download whil=
e using git clone or pull" in git.=0A=
=0A=
Motivation:=0A=
The motivation behind this idea came to me when I was downloading linux ker=
nel. Even with shallow clone (--depth=3D1), the number of objects was too l=
arge. Many times we need access to older commits. It is also difficult to u=
pdate shallow cloned repos [4]. And ssh option is not available behind many=
 firewalls.=0A=
=0A=
Downloading objects incrementally is too slow and we can speed this process=
 by downloading them in parallel (multi part) and adding a resume option wi=
ll also be lifesaver.=0A=
=0A=
I am looking forward to take this project.=0A=
=0A=
[1] https://summerofcode.withgoogle.com/archive/2017/projects/5762172684599=
296/=0A=
[2] https://github.com/eclipse/omr/pulls?q=3Dauthor%3AVarun-garg=0A=
[3] https://public-inbox.org/git/CY1PR19MB01289DCA6C08CDC9F07C6D7DF2340@CY1=
PR19MB0128.namprd19.prod.outlook.com/=0A=
[4] https://stackoverflow.com/questions/41075972/how-to-update-a-git-shallo=
w-clone=0A=
=0A=
With Best Regards,=0A=
Varun Garg =
