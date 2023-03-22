Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9FAC6FD1F
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 16:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjCVQrC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 12:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCVQrA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 12:47:00 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Mar 2023 09:46:58 PDT
Received: from mailfronta2.caissedesdepots.fr (mailfronta2.caissedesdepots.fr [213.41.72.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7C46A59
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 09:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=caissedesdepots.fr; s=mx1; t=1679503618;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=gu7JVpf9b9AbQXEyPPovwm2SQ22bS8DrcwvuFr7uHJU=;
  b=nuslKLmN+q5CZ5zl9YGdRk9htQSHeUJAVwkLNSHwcIJuLKBRvOCUzUD5
   I+5z5AQH+9p/HsCqpu1WCkaImBykBfSENkSeEFZ5Spd8c+nRLUgQ6DRnj
   5EIo3wAfYKj27AfHpL1KtYQmS8PNrH5RTdW017bbpRc6TZU7mdR1COKWX
   Q=;
Received: from dlmailfedproda3.inet.local (HELO mailfrontfeda3.serv.cdc.fr) ([158.156.1.194])
  by mailfronta2b.caissedesdepots.fr with ESMTP; 22 Mar 2023 17:45:53 +0100
X-IronPort-AV: E=Sophos;i="5.98,282,1673910000"; 
   d="scan'208";a="12231944"
X-MGA-submission: =?us-ascii?q?MDGtK0bLuN+s5PT5lsn8k9ovQIkEMBBkyD/4wc?=
 =?us-ascii?q?dqoDhcGIrSU30OhNlm58/EuWTwrLFDjVUgO038bL68ZIXnU4VxGVLYXD?=
 =?us-ascii?q?80hu09O9aNoJJW6RVrficemahJmufYuKZOm0UREzziuikQmLxqitbAgT?=
 =?us-ascii?q?HH?=
Received: from is9prif00112.ap.cdc.fr ([10.12.149.221])
  by mailfrontfeda3.serv.cdc.fr with ESMTP; 22 Mar 2023 17:45:53 +0100
Received: from IS9PRIF00114.ap.cdc.fr (10.12.149.222) by
 IS9PRIF00112.ap.cdc.fr (10.12.149.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 22 Mar 2023 17:45:53 +0100
Received: from IS9PRIF00140.serv.cdc.fr (10.11.134.75) by
 IS9PRIF00114.ap.cdc.fr (10.12.149.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 22 Mar 2023 17:45:53 +0100
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (158.156.156.209)
 by hybridesmtp.caissedesdepots.fr (158.156.156.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 22 Mar 2023 17:45:50 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUQRbCSO29vHMka03hZFmrn7/d4ptShL/wRBLwLOslEJImdafM7k9M951rfQ94o2tb9oZ85YZ40rCJGNdwjdsPbqFW/1sWwYmLZZde53SNGgkhDENRPEJRL9RqQdKToacGqzc3opdP8cXUU6zQn5ahU0Vcbj9Xe2b6yDVerr4UuO1pPe1R6TcpDQxKp1l4qTQn/vwCx5/yTWPf5PPUgdntDfxMLi8zqylvTVvBXhXDxGUcVbCGBwLjRUUWVFymA9RYp69e7q705KGm1oxLKuCoSMxYxWJui2MYCINmNtdCtjkP4HiINOEeb3gYwMmwnFPihxfvELrPg2sfkZM0iFMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gu7JVpf9b9AbQXEyPPovwm2SQ22bS8DrcwvuFr7uHJU=;
 b=brzzl2zMnpzk78BHyHt6lZeul3b172L1BTPIK3d+dV+BTcsxOpnzppzlE+KN/U5z9pX2Iwp1b9Oj5iwAY/Rya801vKe3OEL49tTBq+GfoOAXm6L3lBcAiQQ6xZjTFT+et/+K85souNU77yOwFkcY2+nNH0wxNxH2akWHQraqznziwHQJVbKIkmzUKZ4weezw5xxRTugXXu3h9mMGlEas9BfZ1f3xNXywjZuqOnZbebaSoHYaJLqRA4jLOmz9iEiveNVmDxahQ35A2LMVoV3AHaJ4fdhPmKxR4Ddfogfon28O+fMrLUJF90cRcMwqiu85Mc3SElsBJhmc5bh/eBrC8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=caissedesdepots.fr; dmarc=pass action=none
 header.from=caissedesdepots.fr; dkim=pass header.d=caissedesdepots.fr;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=caissedesdepots.onmicrosoft.com;
 s=selector2-caissedesdepots-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gu7JVpf9b9AbQXEyPPovwm2SQ22bS8DrcwvuFr7uHJU=;
 b=juTzrPFRRZmiet/W/fh1ASLWCiMIKW/WtuxyIBhBnUrQEQ3YDq5Uf5gHnX+N4iD/B54/GIXOILuy0d9LMOCp58a+oQa9nTZuQ2Aw/+mvXwhEcWWPoKocEtMz9IUmKZ7KB5Pf7SbaJcs4PuJ/ysF12cvhTnQ93MWYnm4zc6c8V38=
Received: from PR2P264MB0799.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101:5::13) by
 MR1P264MB2099.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:11::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Wed, 22 Mar 2023 16:45:51 +0000
Received: from PR2P264MB0799.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9483:e6d4:9856:e66b]) by PR2P264MB0799.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9483:e6d4:9856:e66b%7]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 16:45:51 +0000
From:   "Coirier, Emmanuel" <Emmanuel.Coirier@caissedesdepots.fr>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git credential doesn't honor git config precedence rules
Thread-Topic: git credential doesn't honor git config precedence rules
Thread-Index: Adlc3SOlyG0QOZG0SXu+A5iGz9Kw0w==
Date:   Wed, 22 Mar 2023 16:45:51 +0000
Message-ID: <PR2P264MB07999A445EAD2DB4BD48AD4CF4869@PR2P264MB0799.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_94e1e3e5-28aa-42d2-a9d5-f117a2286530_Enabled=true;
 MSIP_Label_94e1e3e5-28aa-42d2-a9d5-f117a2286530_SetDate=2023-03-22T16:45:50Z;
 MSIP_Label_94e1e3e5-28aa-42d2-a9d5-f117a2286530_Method=Standard;
 MSIP_Label_94e1e3e5-28aa-42d2-a9d5-f117a2286530_Name=C2-Interne avec
 marquage;
 MSIP_Label_94e1e3e5-28aa-42d2-a9d5-f117a2286530_SiteId=6eab6365-8194-49c6-a4d0-e2d1a0fbeb74;
 MSIP_Label_94e1e3e5-28aa-42d2-a9d5-f117a2286530_ActionId=b941ec58-b206-4477-9be4-6c0695c4b3b4;
 MSIP_Label_94e1e3e5-28aa-42d2-a9d5-f117a2286530_ContentBits=2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=caissedesdepots.fr;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR2P264MB0799:EE_|MR1P264MB2099:EE_
x-ms-office365-filtering-correlation-id: 597fa671-4d27-4321-7624-08db2af4e595
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iY8VjW9KwoREQbAqnO8hIagy7oPn1NBOkTVm64lmBkjreEbR1WOpPdzzNJF+4pkOzUxxILs0EFCoe0/ODqMs4mprA4Ik7vhBMA/odAhoE0P0dNWxhkEOhbDVyAUAM/lgihwo6IGOE8Xp+HVPTT0WjE4a1WHWLsgsCaJbueXgfGDIuoXGVE5jQazTUn5zUGXUunry2OaEFSY1GOF+hYQgseYPvDXZcGgvEukbBkCtTbjTZMJARSzgYjIlNCUF4cpsrlwL7/VcVmyuYn9E0Rz+9boFSk87XZp9+t4hKNtLpLaF2k+qnSEEO/RN/54CUaiH3tgou+gV1zF3gwgjwmb904AaHofWmZeIF7hzKjeFsBIN6aw9Vf5i0BJCvYLomHa2Hhy5x0YDhhvwBe9cvSYWy9PPFRrvmyZX1AQjHR7OW1MPvYWQNH4cSL/VpkuvWYFQ15QiCp+da9F7og8C8BN2cUd8czuQF7rXlQE5eofC4+xyaMjqAAI/uvFXuTwGjyXqavOhOcCWuuBjM1ykG2zPcDVqcYoo+4vD1QgjR7FVh1r4z53+AXlldxHsQwXm2awJnOIU3+CWqdKi7v+dtGdbg84YMHJEVoUNeHg0jdvERVsMca2PgOCvZ7JFDdKcCESIudis431VHrGtM4wPg5yuFf/DGh7r/Cd1pd6mrYiTHdZ/Z3FuxaiNObBNc6vc8KBPvs2vtbPVp7wvYheMLWLnKYVuG65m+ia1B2qa2xeleVI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR2P264MB0799.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199018)(38100700002)(66574015)(122000001)(71200400001)(7696005)(55016003)(33656002)(8676002)(316002)(41300700001)(52536014)(66946007)(6916009)(66476007)(5660300002)(66446008)(64756008)(66556008)(76116006)(478600001)(8936002)(2906002)(86362001)(83380400001)(82960400001)(186003)(38070700005)(6506007)(26005)(9686003)(460985005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1RuRjlnTkg1RDN0QmNUMVp1blIyQVZaSnI5dTl6WUtDZlpxV29xMFdaTWtD?=
 =?utf-8?B?ekl5WWJaUTBRWDU5ekVsOVNya1RoclJqQW1DUWpZdU55RU9PTCtqWEVzN2kx?=
 =?utf-8?B?Y2U3S3hlK0hoRGhrclhKUmZIeDVKRENxSUdVYVFmNm40Um5ZYUJwTGdCeFo4?=
 =?utf-8?B?Y1l1VkhrejZ6VUhvUVNJcUp0TXBLVE5BL0s5YkIxbUFwbUgrYlViUjZNVzRW?=
 =?utf-8?B?SHFvdnNJK3ZuaDQwaXowa2NVTW56K3hNRkk5WTRxMEtnNUozeWZDNG4rSWkr?=
 =?utf-8?B?SU8yWEZ2Y3RmZXEzcWNabjdSZGd0emhJQXpGQUxJbEhPRmtFTUFCZWxMV09t?=
 =?utf-8?B?RlhKOHBCNmdYbG1aSHJhSHJxcmY4cy9LblFzdXhuRXpJaWtwNUxJbUJmRDRl?=
 =?utf-8?B?eEVaVjZabkJCcVoyVGxuOGZHL004SlhnelBxeEgvK3lYZTJobEVBeHdUNU1w?=
 =?utf-8?B?UU5NQVBwQkM1Y0dQdm9JRVJqbDNlMjRlZUh2SWV6citpTXVIelFDQ29mR05u?=
 =?utf-8?B?V1ptemF0RG14aXNiU2xRVUczdGRKWjFhUHhBc3FCNS9YYWtyRGU3NDdVT0cz?=
 =?utf-8?B?eGFpL2lJa3pUNFZNMHJEdXFYWXBKMDFPSTBDTWMvVTZNR2l0cG45RTlpU1Ev?=
 =?utf-8?B?UDg0Y3o5S2NCL0RhWjRkdE1sNStERTBpNG0vMUsvb0I1M1p0S25oeGpzU29l?=
 =?utf-8?B?TGI2T1JVQ1hjbG1YdGJod3czMGt0K2NNZjR3cSs0eG1NdVF0KzhjallpZGlQ?=
 =?utf-8?B?bDlpK2pRNi9KZG54QTNJMGh5c0lhVzZFQjJSSTNWMFpoR0JVTnhjaWh2Q1Zx?=
 =?utf-8?B?Z3FtUzN6cUloVExDWFdxMXJlQVc5cUppS2pLV2h1ZzhVWnFmNDNYMXZBbXdG?=
 =?utf-8?B?Ty8yNXBjVStVZy9FcmtNNTRrbEpTYzVNcGUzb1JlUHhkcm00TjAxNGJOVUlu?=
 =?utf-8?B?WVNRcG1hbVlhUFovWS83Q0QxRXltQmc3MWQzS3NZTUs0WmV3eVJwek45TWs5?=
 =?utf-8?B?M3E4dVgvclhuVGpBYmhFMDNQc1VQWjNzVE9OMWhvOUl5bUtWaDNLRisxTTNp?=
 =?utf-8?B?Tzk4RHBPb1M3MDNmY0d1UUtjVXh1SlgxdktLTURDdVowelRxeTlUMDlZcW1q?=
 =?utf-8?B?S1UyaGFpaGpNeTVxTlYvbkRYRHk4SGFQS3hpVlM3ODcwUGJETENGMmlTVTVC?=
 =?utf-8?B?bUhhbFFnNTE5aXIraXdiemxxRGFmb3hqRWhQVE9pZ0QrUzdhdVJUazcvQ2hW?=
 =?utf-8?B?SFRyZkpySTE4MCt6aEMxbW9mVVlPMC9uRUlmVDJsOWlTL285aE9sN2VqUlhn?=
 =?utf-8?B?Vm1LTmg4QkkrZ3pBWFgxRFJRYkRSMllobVUwcWJ2Z253cEw2RzRrUkFGQlAr?=
 =?utf-8?B?bkZPR0F5RHlGYlVQU3ZJUU94b0hJdURTZU1JRDRuWThtc1hWbjJBMktEcWtC?=
 =?utf-8?B?SjBXd29VWkVjbi9MbVQ1bk9NSHJXT1NhaGRtTTZPMFh6b2VzVmVnaG03MUJw?=
 =?utf-8?B?S0VNSDNIMlk0S3JITGZGL0h6RlU5WEVUNzIya2J0cWxSa0FkWXBXa3R0NDdS?=
 =?utf-8?B?L1JIVUk1RjFnN1ZIUSsrbFlDV2FmU3d5K1V1dzJyMVU0bTlkOWNOazNSTDds?=
 =?utf-8?B?K3FnN2hMcmlKMEFuUGgzeU81YTd3cmpmOXpOSVBwaGNoOVdpaE5DdFRBV0tW?=
 =?utf-8?B?cVBzRlNuazRLVi9Tc2NtSkF1ZWxUTmZNbkFxRVkveVV1WDJONjVQeW5MRlB0?=
 =?utf-8?B?ZHBXeWozYWJZUDQ1WlNpSDlMVStibHhqUzFxNlhSQWxrbU1ybEFtSU92QXZP?=
 =?utf-8?B?TUJRWFl4M24yVERnVm8reHdqcjNiN1B6T2lBNUNOeEtlVlcvMmo0cVkzelRT?=
 =?utf-8?B?MmVSRmZkVXdDMXc4V2JhUWI2NFh3UjVNT012Z09vR3BjemVrSk40SFM4ZGNx?=
 =?utf-8?B?M3JwdUJQajNhbjN4M0k5VWZVOW1icmZuSXMvaDdVQzFZMlFxUmNjM2FjazV3?=
 =?utf-8?B?eFpmVnZ0dHI0Q3ZtdEVwN3pTZVhQNDNtdlR4U3RoWkxzbDY5cDJzR2lhbStj?=
 =?utf-8?B?OFJjejJRVXQ2VHpZSWE4bXBZcmlmRHRrOEVPVXBHVm9sWis5RVVBN0w2U3JC?=
 =?utf-8?B?UHc2Yk1iM0lnZlFPRDZ4eFgveGZ5cG5DRm16V1NkTGkyOFZDTExyOTZnaWo1?=
 =?utf-8?Q?nWtfKrF9dZFPGKw/Fj0YwRI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR2P264MB0799.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 597fa671-4d27-4321-7624-08db2af4e595
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 16:45:51.5065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6eab6365-8194-49c6-a4d0-e2d1a0fbeb74
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I7laV/BllliQ+JtkCxB7kFW/k64jSI9Xe8EliQvIQyrYXYyqwcLWaml7sxCDiybDXoHC6HsyZU8XIoQRUGIbgYWy49bw9FaS6LcRs/E/eUZOjjMy+K30Yt13FDoGDHT9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2099
X-OriginatorOrg: caissedesdepots.fr
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGVsbG8gZXZlcnlvbmUsDQoNCkkgdGhpbmsgSSBmb3VuZCBhIGJ1ZyB3aXRoIGdpdCBjcmVkZW50
aWFsOiB0aGlzIHRvb2wgZG9lc24ndCBjYWxsDQp0aGUgY29uZmlndXJlZCBjcmVkZW50aWFsIGhl
bHBlciBmb2xsb3dpbmcgdGhlIGNvbmZpZ3VyYXRpb24gcnVsZXMuDQoNCkl0IGNhbGxzIHRoZSBz
eXN0ZW0gY29uZmlndXJlZCBjcmVkZW50aWFsIGhlbHBlciAoZ2l0IGNvbmZpZyAtLXN5c3RlbSkg
ZXZlbiBpZiBhbm90aGVyIG9uZQ0KaXMgY29uZmlndXJlZCAoaWU6IGF0IHRoZSBnbG9iYWwgbGV2
ZWwgOiBnaXQgY29uZmlnIC0tZ2xvYmFsKS4NCg0KVGhlIHByb2JsZW0gSSBlbmNvdW50ZXJlZCBp
cyB0aGF0IHRoZSBjb25maWd1cmVkIHN5c3RlbSBvbmUgKG1hbmFnZXItY29yZQ0KaW4gbXkgY2Fz
ZSkgYW5zd2VycyBhIHdyb25nIHZhbHVlIGluc3RlYWQgb2YgZ2l2aW5nIHVwLiBUaGUgZ2xvYmFs
bHkNCmNvbmZpZ3VyZWQgKHdpbmNyZWQgaW4gbXkgY2FzZSkgaXMgdGhlbiBub3QgY2FsbGVkIGF0
IGFsbCBhbmQgbXkNCmF1dGhlbnRpY2F0aW9uIGp1c3QgZmFpbCB3aXRob3V0IGFueSB3YXkgdG8g
bWFudWFsbHkgZW50ZXIgbG9naW4gJiBwYXNzLg0KDQpIZXJlIGlzIHNvbWUgZGV0YWlscyB0byBy
ZXByb2R1Y2Ugd2hhdCBJIHRoaW5rIGlzIGEgYnVnLg0KDQo+IFdoYXQgZGlkIHlvdSBkbyBiZWZv
cmUgdGhlIGJ1ZyBoYXBwZW5lZD8gKFN0ZXBzIHRvIHJlcHJvZHVjZSB5b3VyIGlzc3VlKQ0KDQoj
IFNldHVwIHBoYXNlDQoNCiMgVGhlIHB1cnBvc2UgaXMgdG8gc2hvdyB0aGF0ICJnaXQgY3JlZGVu
dGlhbCIgJiBmcmllbmRzIGRvbid0IGhvbm9yIHRoZQ0KIyBjb25maWcgcHJlY2VkZW5jZSBydWxl
IHdoZW4gbGF1bmNoaW5nIHRoZSBjcmVkZW50aWFsIGhlbHBlcg0KDQojIEkgc2V0IHRoZSBzeXN0
ZW0gY3JlZGVudGlhbCBoZWxwZXIgdG8gYSBub25leGlzdGVudCBjcmVkZW50aWFsIGhlbHBlcg0K
IyB0byBwcm92b2tlIGFuIGVycm9yIG1lc3NhZ2UgbGF0ZXINCiQgZ2l0IGNvbmZpZyAtLXJlcGxh
Y2UtYWxsIC0tc3lzdGVtIGNyZWRlbnRpYWwuaGVscGVyICJibGEiDQokIGdpdCBjb25maWcgLS1n
ZXQgLS1zeXN0ZW0gY3JlZGVudGlhbC5oZWxwZXINCmJsYQ0KIyBUaGUgZ2xvYmFsIChwZXIgYWNj
b3VudCkgY3JlZGVudGlhbCBoZWxwZXIgaXMgYW4gZXhpc3Rpbmcgb25lDQokIGdpdCBjb25maWcg
LS1nZXQgLS1nbG9iYWwgY3JlZGVudGlhbC5oZWxwZXINCndpbmNyZWQNCiMgdGhpcyBpcyB0aGUg
Y29tcHV0ZWQgb25lIGJhc2VkIG9uIHRoZSBwcmVjZWRlbmNlIHJ1bGVzDQokIGdpdCBjb25maWcg
LS1nZXQgY3JlZGVudGlhbC5oZWxwZXINCndpbmNyZWQNCg0KIyBCdWcgcGhhc2UNCg0KJCBnaXQg
Y3JlZGVudGlhbCBmaWxsIDw8IEVPRg0KPiBwcm90b2NvbD1odHRwDQo+IGhvc3Q9PHNvbWUgaW50
ZXJuYWwgaG9zdD4NCj4gcGF0aD08c29tZSBpbnRlcm5hbCBwYXRoPg0KPiBFT0YNCg0KDQo+IFdo
YXQgZGlkIHlvdSBleHBlY3QgdG8gaGFwcGVuPyAoRXhwZWN0ZWQgYmVoYXZpb3IpDQoNCnByb3Rv
Y29sPWh0dHANCmhvc3Q9PHNvbWUgaW50ZXJuYWwgaG9zdD4NCnVzZXJuYW1lPTxzb21lIGxvY2Fs
IHVzZXI+DQpwYXNzd29yZD08dGhlIHBhc3N3b3JkPg0KDQo+IFdoYXQgaGFwcGVuZWQgaW5zdGVh
ZD8gKEFjdHVhbCBiZWhhdmlvcikNCg0KZ2l0OiAnY3JlZGVudGlhbC1ibGEnIGlzIG5vdCBhIGdp
dCBjb21tYW5kLiBTZWUgJ2dpdCAtLWhlbHAnLg0KcHJvdG9jb2w9aHR0cA0KaG9zdD08c29tZSBp
bnRlcm5hbCBob3N0Pg0KdXNlcm5hbWU9PHNvbWUgbG9jYWwgdXNlcj4NCnBhc3N3b3JkPTx0aGUg
cGFzc3dvcmQ+DQoNCj4gV2hhdCdzIGRpZmZlcmVudCBiZXR3ZWVuIHdoYXQgeW91IGV4cGVjdGVk
IGFuZCB3aGF0IGFjdHVhbGx5IGhhcHBlbmVkPw0KDQpJbiB0aGlzIGV4YW1wbGUsIHRoZSAiYmxh
IiBjcmVkZW50aWFsIGhlbHBlciBpcyBjYWxsZWQNCmV2ZW4gaWYgdGhlIHdpbmNyZWQgc2hvdWxk
IGhhdmUgYmVlbiB0aGUgb25seSBvbmUgdG8gYmUNCmNhbGxlZC4NCg0KVGhlIHJlc3VsdCBpcyBP
SyBzaW5jZSB0aGUgImJsYSIgY3JlZGVudGlhbCByZXR1cm5lZCBhIG5vbg0KemVybyByZXR1cm4g
Y29kZSwgdGhlbiB0aGUgZ2xvYmFsIGNyZWRlbnRpYWwgaGVscGVyICh3aW5jcmVkKSB3YXMgY2Fs
bGVkLg0KDQpMZXQncyBzZWUgd2hhdCBoYXBwZW5lZCB3aXRoIGEgInplcm8gcmV0dXJuaW5nIiBj
cmVkZW50aWFsDQpoZWxwZXIgOg0KDQo+IEFueXRoaW5nIGVsc2UgeW91IHdhbnQgdG8gYWRkOg0K
DQpMZXQncyByZXBsYXkgdGhlIHNhbWUgc2NlbmFyaW8gd2l0aCB0aGUgcmVhbCAibWFuYWdlci1j
b3JlIiBjcmVkZW50aWFsIGhlbHBlcg0KDQo+IFdoYXQgZGlkIHlvdSBkbyBiZWZvcmUgdGhlIGJ1
ZyBoYXBwZW5lZD8gKFN0ZXBzIHRvIHJlcHJvZHVjZSB5b3VyIGlzc3VlKQ0KDQojIFNldHVwIHBo
YXNlDQoNCiQgZ2l0IGNvbmZpZyAtLXJlcGxhY2UtYWxsIC0tc3lzdGVtIGNyZWRlbnRpYWwuaGVs
cGVyIG1hbmFnZXItY29yZQ0KJCBnaXQgY29uZmlnIC0tZ2V0IC0tc3lzdGVtIGNyZWRlbnRpYWwu
aGVscGVyDQptYW5hZ2VyLWNvcmUNCiMgVGhlIGdsb2JhbCAocGVyIGFjY291bnQpIGNyZWRlbnRp
YWwgaGVscGVyIGlzIHN0aWxsIGFuIGV4aXN0aW5nIG9uZQ0KJCBnaXQgY29uZmlnIC0tZ2V0IC0t
Z2xvYmFsIGNyZWRlbnRpYWwuaGVscGVyDQp3aW5jcmVkDQokIGdpdCBjb25maWcgLS1nZXQgY3Jl
ZGVudGlhbC5oZWxwZXINCndpbmNyZWQNCg0KIyBCdWcgcGhhc2UNCg0KJCBnaXQgY3JlZGVudGlh
bCBmaWxsIDw8IEVPRg0KPiBwcm90b2NvbD1odHRwDQo+IGhvc3Q9PHNvbWUgaW50ZXJuYWwgaG9z
dD4NCj4gcGF0aD08c29tZSBpbnRlcm5hbCBwYXRoPg0KPiBFT0YNCg0KDQo+IFdoYXQgZGlkIHlv
dSBleHBlY3QgdG8gaGFwcGVuPyAoRXhwZWN0ZWQgYmVoYXZpb3IpDQoNCnByb3RvY29sPWh0dHAN
Cmhvc3Q9PHNvbWUgaW50ZXJuYWwgaG9zdD4NCnVzZXJuYW1lPTxzb21lIGxvY2FsIHVzZXI+DQpw
YXNzd29yZD08dGhlIHBhc3N3b3JkPg0KDQojIHdpbmNyZWQgd291bGQgaGF2ZSBiZWVuIGNhbGxl
ZCBhbmQgaGFkIHJldHVybmVkIHdoYXQgaXQgbGVhcm5lZCBiZWZvcmUNCg0KPiBXaGF0IGhhcHBl
bmVkIGluc3RlYWQ/IChBY3R1YWwgYmVoYXZpb3IpDQoNCnByb3RvY29sPWh0dHANCmhvc3Q9PHNv
bWUgaW50ZXJuYWwgaG9zdD4NCnVzZXJuYW1lPQ0KcGFzc3dvcmQ9DQoNCiQgZWNobyAkPw0KMA0K
DQojIHVzZXJuYW1lIGFuZCBwYXNzd29yZCBhcmUgbGVmdCBlbXB0eSwgYnV0IHRoZSBzeXN0ZW0g
Y3JlZGVudGlhbCBoZWxwZXINCiMgZGlkbid0IHJldHVybmVkIGEgbm9uLXplcm8gcmV0dXJuIHZh
bHVlLCBub3QgdHJpZ2dlcmluZyB0aGUgZ2xvYmFsDQojIGNyZWRlbnRpYWwgaGVscGVyLg0KDQo+
IFdoYXQncyBkaWZmZXJlbnQgYmV0d2VlbiB3aGF0IHlvdSBleHBlY3RlZCBhbmQgd2hhdCBhY3R1
YWxseSBoYXBwZW5lZD8NCg0KVHdvIHByb2JsZW1zIDoNCi0gdGhlIG1hbmFnZXItY29yZSBjcmVk
ZW50aWFsIG1hbmFnZXIgZGlkbid0IGFuc3dlciBzb21lIGxvZ2luIG9yDQogIHBhc3N3b3JkIG5v
ciBwcm9tcHRlZCB0aGUgdXNlciBmb3IgYW55dGhpbmcuIEknbSBub3Qgc3VyZSB0aGlzDQogIHNo
b3VsZCBiZSB0aGUgZ29vZCBiZWhhdmlvciwgYnV0IGl0J3Mgbm90IG91ciBjb25jZXJuIGhlcmUu
DQotIHRoZSBtYW5hZ2VyLWNvcmUgaGFzIGJlZW4gY2FsbGVkIGRlc3BpdGUgdGhlIGZhY3QgdGhl
IGdsb2JhbCBjb25maWd1cmF0aW9uDQogIHNob3VsZCBoYXZlIGJlZW4gdXNlZCwgbGV0dGluZyBv
bmx5IHdpbmNyZWQgZmlsbGluZyB0aGUgcmVxdWVzdC4NCg0KDQpbU3lzdGVtIEluZm9dDQpnaXQg
dmVyc2lvbjoNCmdpdCB2ZXJzaW9uIDIuMzcuMy53aW5kb3dzLjENCmNwdTogeDg2XzY0DQpidWls
dCBmcm9tIGNvbW1pdDogYzQ5OTJkNGZlY2FiZDdkMTExNzI2ZWNiMzdlMzNhM2NjYjUxZDZmMQ0K
c2l6ZW9mLWxvbmc6IDQNCnNpemVvZi1zaXplX3Q6IDgNCnNoZWxsLXBhdGg6IC9iaW4vc2gNCmZl
YXR1cmU6IGZzbW9uaXRvci0tZGFlbW9uDQp1bmFtZTogV2luZG93cyAxMC4wIDE5MDQ1DQpjb21w
aWxlciBpbmZvOiBnbnVjOiAxMi4yDQpsaWJjIGluZm86IG5vIGxpYmMgaW5mb3JtYXRpb24gYXZh
aWxhYmxlDQokU0hFTEwgKHR5cGljYWxseSwgaW50ZXJhY3RpdmUgc2hlbGwpOiBDOlxEZXZlbG9w
cGVtZW50XEdpdFx1c3JcYmluXGJhc2guZXhlDQoNCg0KW0VuYWJsZWQgSG9va3NdDQoobm9uZSkN
Cg0KDQpCZXN0IHJlZ2FyZHMsDQoNCi0tDQpFbW1hbnVlbCBDb2lyaWVyDQoNCg0KSW50ZXJuZQ0K
Q2UgbWVzc2FnZSBldCB0b3V0ZXMgbGVzIHBpw6hjZXMgam9pbnRlcyAoY2ktYXByw6hzIGxlIMKr
bWVzc2FnZcK7KSBzb250IGNvbmZpZGVudGllbHMgZXQgw6l0YWJsaXMgw6AgbOKAmWludGVudGlv
biBleGNsdXNpdmUgZGUgc2VzIGRlc3RpbmF0YWlyZXMuIFRvdXRlIHV0aWxpc2F0aW9uIGRlIGNl
IG1lc3NhZ2Ugbm9uIGNvbmZvcm1lIMOgIHNhIGRlc3RpbmF0aW9uLCB0b3V0ZSBkaWZmdXNpb24g
b3UgdG91dGUgcHVibGljYXRpb24sIHRvdGFsZSBvdSBwYXJ0aWVsbGUsIGVzdCBpbnRlcmRpdGUs
IHNhdWYgYXV0b3Jpc2F0aW9uIGV4cHJlc3NlLiBTaSB2b3VzIHJlY2V2ZXogY2UgbWVzc2FnZSBw
YXIgZXJyZXVyLCBtZXJjaSBkZSBsZSBkw6l0cnVpcmUgc2FucyBlbiBjb25zZXJ2ZXIgZGUgY29w
aWUgZXQgZOKAmWVuIGF2ZXJ0aXIgaW1tw6lkaWF0ZW1lbnQgbOKAmWV4cMOpZGl0ZXVyLiBJbnRl
cm5ldCBuZSBwZXJtZXR0YW50IHBhcyBkZSBnYXJhbnRpciBs4oCZaW50w6lncml0w6kgZGUgY2Ug
bWVzc2FnZSwgbGEgQ2Fpc3NlIGRlcyBEw6lww7R0cyBldCBDb25zaWduYXRpb25zIGTDqWNsaW5l
IHRvdXRlIHJlc3BvbnNhYmlsaXTDqSBhdSB0aXRyZSBkZSBjZSBtZXNzYWdlIHPigJlpbCBhIMOp
dMOpIG1vZGlmacOpLCBhbHTDqXLDqSwgZMOpZm9ybcOpIG91IGZhbHNpZmnDqS4gUGFyIGFpbGxl
dXJzIGV0IG1hbGdyw6kgdG91dGVzIGxlcyBwcsOpY2F1dGlvbnMgcHJpc2VzIHBvdXIgw6l2aXRl
ciBsYSBwcsOpc2VuY2UgZGUgdmlydXMgZGFucyBub3MgZW52b2lzLCBub3VzIHZvdXMgcmVjb21t
YW5kb25zIGRlIHByZW5kcmUsIGRlIHZvdHJlIGPDtHTDqSwgbGVzIG1lc3VyZXMgcGVybWV0dGFu
dCBkJ2Fzc3VyZXIgbGEgbm9uLWludHJvZHVjdGlvbiBkZSB2aXJ1cyBkYW5zIHZvdHJlIHN5c3TD
qG1lIGluZm9ybWF0aXF1ZS4gVGhpcyBlbWFpbCBtZXNzYWdlIGFuZCBhbnkgYXR0YWNobWVudHMg
KOKAnHRoZSBlbWFpbOKAnSkgYXJlIGNvbmZpZGVudGlhbCBhbmQgaW50ZW5kZWQgb25seSBmb3Ig
dGhlIHJlY2lwaWVudChzKSBpbmRpY2F0ZWQuIElmIHlvdSBhcmUgbm90IGFuIGludGVuZGVkIHJl
Y2lwaWVudCwgcGxlYXNlIGJlIGFkdmlzZWQgdGhhdCBhbnkgdXNlLCBkaXNzZW1pbmF0aW9uLCBm
b3J3YXJkaW5nIG9yIGNvcHlpbmcgb2YgdGhpcyBlbWFpbCB3aGF0c29ldmVyIGlzIHByb2hpYml0
ZWQgd2l0aG91dCBwcmlvciB3cml0dGVuIGNvbnNlbnQgb2YgQ2Fpc3NlIGRlcyBEZXBvdHMgZXQg
Q29uc2lnbmF0aW9ucy4gSWYgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBlbWFpbCBpbiBlcnJvciwg
cGxlYXNlIGRlbGV0ZSBpdCB3aXRob3V0IHNhdmluZyBhIGNvcHkgYW5kIG5vdGlmeSB0aGUgc2Vu
ZGVyIGltbWVkaWF0ZWx5LiBJbnRlcm5ldCBlbWFpbHMgYXJlIG5vdCBuZWNlc3NhcmlseSBzZWN1
cmUsIGFuZCBDYWlzc2UgZGVzIERlcG90cyBldCBDb25zaWduYXRpb25zIGRlY2xpbmVzIHJlc3Bv
bnNpYmlsaXR5IGZvciBhbnkgY2hhbmdlcyB0aGF0IG1heSBoYXZlIGJlZW4gbWFkZSB0byB0aGlz
IGVtYWlsIGFmdGVyIGl0IHdhcyBzZW50LiBXaGlsZSB3ZSB0YWtlIGFsbCByZWFzb25hYmxlIHBy
ZWNhdXRpb25zIHRvIGVuc3VyZSB0aGF0IHZpcnVzZXMgYXJlIG5vdCB0cmFuc21pdHRlZCB2aWEg
ZW1haWxzLCB3ZSByZWNvbW1lbmQgdGhhdCB5b3UgdGFrZSB5b3VyIG93biBtZWFzdXJlcyB0byBw
cmV2ZW50IHZpcnVzZXMgZnJvbSBlbnRlcmluZyB5b3VyIGNvbXB1dGVyIHN5c3RlbS4NCg==
