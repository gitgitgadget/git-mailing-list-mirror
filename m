Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69CA21F462
	for <e@80x24.org>; Tue, 11 Jun 2019 20:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406412AbfFKUCB (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 16:02:01 -0400
Received: from v-ironman-out.ucdenver.edu ([140.226.190.221]:12655 "EHLO
        v-ironman-out.ucdenver.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405168AbfFKUCB (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 Jun 2019 16:02:01 -0400
X-Greylist: delayed 578 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Jun 2019 16:02:00 EDT
X-IronPort-AV: E=Sophos;i="5.63,362,1557208800"; 
   d="scan'208";a="306121743"
Received: from ex2010hyb1.ucdenver.pvt ([140.226.231.44])
  by v-ironman-out.ucdenver.edu with ESMTP/TLS/AES256-SHA; 11 Jun 2019 13:52:21 -0600
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.50) by
 webmail.ucdenver.edu (140.226.231.44) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Tue, 11 Jun 2019 13:52:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=olucdenver.onmicrosoft.com; s=selector2-olucdenver-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcWyrRQ9DtGGsL4RZKwImPaOfycT1sU/sQ+z+NMn6dA=;
 b=DWUuh3JmE7fTBR+B58L/4wXNxZ56lXQsFgIdTYVzWluvfv22Bud5MgJ8eTh48WGxYUm2pe2jbB1huK7eSBhi+A/DsCX1EUCzAj3LqawD2+1B0XO7qWil7MX7IRmRa4TImrvfQSsbDQyhJoz8K8fzb3vYjEWfyxawFsTPo2ZOaC0=
Received: from SN6PR05MB4688.namprd05.prod.outlook.com (52.135.114.210) by
 SN6PR05MB3998.namprd05.prod.outlook.com (52.132.125.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Tue, 11 Jun 2019 19:52:19 +0000
Received: from SN6PR05MB4688.namprd05.prod.outlook.com
 ([fe80::984e:defb:a025:7a46]) by SN6PR05MB4688.namprd05.prod.outlook.com
 ([fe80::984e:defb:a025:7a46%7]) with mapi id 15.20.1987.008; Tue, 11 Jun 2019
 19:52:18 +0000
From:   Elmar Pruesse <p@ucdenver.edu>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Reducing git size by building libgit.so
Thread-Topic: Reducing git size by building libgit.so
Thread-Index: AQHVII8s1ySSM+AOe0C7NnGhZz6DCA==
Date:   Tue, 11 Jun 2019 19:52:18 +0000
Message-ID: <21f1f334-755e-3283-d0da-ec0ab9231cfc@ucdenver.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR0601CA0065.namprd06.prod.outlook.com
 (2603:10b6:910:89::42) To SN6PR05MB4688.namprd05.prod.outlook.com
 (2603:10b6:805:93::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ELMAR.PRUESSE@UCDENVER.EDU; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.166.7.79]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a8a8efc-3193-4963-52c9-08d6eea64f1b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR05MB3998;
x-ms-traffictypediagnostic: SN6PR05MB3998:
x-microsoft-antispam-prvs: <SN6PR05MB3998BC74B97BC02016FEF7DB96ED0@SN6PR05MB3998.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 006546F32A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(136003)(366004)(39860400002)(189003)(199004)(71190400001)(25786009)(186003)(71200400001)(305945005)(68736007)(7736002)(256004)(31696002)(4744005)(75432002)(14454004)(66066001)(6116002)(2351001)(66476007)(64756008)(31686004)(26005)(2501003)(73956011)(3846002)(66446008)(66556008)(66946007)(81166006)(8936002)(72206003)(478600001)(316002)(8676002)(99286004)(786003)(6512007)(1730700003)(81156014)(6916009)(5640700003)(88552002)(2906002)(5660300002)(52116002)(102836004)(6486002)(476003)(36756003)(2616005)(486006)(6436002)(53936002)(386003)(6506007)(49092004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR05MB3998;H:SN6PR05MB4688.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: UCDENVER.EDU does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oSsWnDDtvKHyaehVMFDz/vuSMT6FrgZPXkM3pTk3sR8cat4KPVc5gu0OHsjAwu2CdDDjSJqn0M48AXATR3iqlkj1TdpFFUPrfSUhtOgQ0+JRin6LM4krQ6Xb0RgkbiPM+aTnz86ByCBOmaOJOLyoba9aIxu0skQ3LOtZ6pO9zm9cNoBwVuvJxEQK5k7bk/LFAQMV5vNiHx7XVSyQA/tPbsuzACBLIdY6B/EF1rrV/PJUA/8QDPFY8K7UGIDDgQkwBBPmy6lLTBr+5D0SJxm5ltkcuHzYde1EYCmKFdAnP+POs58ZYVkORudnjfAhSoI43hBSoGtiKidv3hntgNMW6h+Go1i23Q0vRcm3Vx56+uD1FieGE5IZgmi4dCisNoRDjCSH9lvuieNY3oq+lncWhxUQ4YPeXRScSjpNEKU8ZuM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8644D0A72CD27468E8FB94DDBB1ED0C@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8a8efc-3193-4963-52c9-08d6eea64f1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2019 19:52:18.5002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 563337ca-a517-421a-aae0-1aa5b414fd7f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p@ucdenver.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB3998
X-OriginatorOrg: ucdenver.edu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGkhDQoNClRoZSB0b3RhbCBjb21waWxlZCBzaXplIG9mIGxpYmV4ZWMvZ2l0LWNvcmUgaXMgY3Vy
cmVudGx5IHNvbWV3aGVyZSANCmFyb3VuZCAzMCBNQi4gVGhpcyBpcyBsYXJnZWx5IGR1ZSB0byBh
IG51bWJlciBvZiBiaW5hcmllcyBsaW5raW5nIA0Kc3RhdGljYWxseSBhZ2FpbnN0IGxpYmdpdC5h
LiBGb3Igc29tZSBmb2xrcywgZXZlcnkgYnl0ZSBjb3VudHMuIEkgDQptZWRkbGVkIHdpdGggdGhl
IE1ha2VmaWxlIGJyaWVmbHkgdG8gbWFrZSBpdCBidWlsZCBhbmQgdXNlIGEgbGliZ2l0LnNvIA0K
aW5zdGVhZCwgd2hpY2ggZHJvcHBlZCBwYWNrYWdlIHNpemUgZG93biB0byA1TUIuDQoNCkFyZSB0
aGVyZSwgYmV5b25kIHRoZSB+MjAgbXMgaW4gZXh0cmEgc3RhcnR1cCB0aW1lIGFuZCB0aGUgc2xp
Z2h0bHkgDQpiaWdnZXIgaGFzc2xlIHdpdGggRFNPIGxvY2F0aW9ucywgcmVhc29ucyBmb3IgdGhl
IGNob2ljZSB0byBsaW5rIHN0YXRpY2FsbHk/DQoNCmJlc3QsDQoNCkVsbWFyDQoNCg==
