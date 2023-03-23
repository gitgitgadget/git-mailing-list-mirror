Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4606AC6FD1C
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 10:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjCWKii (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 06:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjCWKhz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 06:37:55 -0400
Received: from mailfronta3.caissedesdepots.fr (mailfronta3.caissedesdepots.fr [212.157.112.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D22934F6D
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 03:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=caissedesdepots.fr; s=mx1; t=1679567690;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ajTWYge6LK4pKblyzNhpqGzEY7rs909PCViE37YJsjQ=;
  b=dLAh2knW/cAJTPHoaGI1nc/gF549ojgYhF2gFra3yHJR1Dz8VIAQN3VR
   TXmiW1gXRTOvq4jswo0RNQRr6nQ/QH2wGbOsb3nF+0JHahRMx3uJo0J1S
   vcmtAd8geZLa3dCuUai95cc9/THj1pkTV7QSnBpWNG/z/Gc0kpoEL2tUK
   4=;
Received: from dlmailfedproda3.inet.local (HELO mailfrontfeda3.serv.cdc.fr) ([158.156.1.194])
  by mailfronta3b.caissedesdepots.fr with ESMTP; 23 Mar 2023 11:34:48 +0100
X-IronPort-AV: E=Sophos;i="5.98,283,1673910000"; 
   d="scan'208";a="12305104"
X-MGA-submission: =?us-ascii?q?MDEmY+olWSgzQ7DWIZihBu+ZchP7/pNhAqi1Za?=
 =?us-ascii?q?4yBsEaMs2bns2z/9wV+RSpS1AXWWCxBNX9T6BhPaeVcRRl0KKA5Uq30Z?=
 =?us-ascii?q?WisQ86s7AaYPn8GX9A2wiSHdox4CcMGYAdRGBHg5bwTE1BgdaNLNxs/y?=
 =?us-ascii?q?Jp?=
Received: from is9prif00117.ap.cdc.fr ([10.12.149.182])
  by mailfrontfeda3.serv.cdc.fr with ESMTP; 23 Mar 2023 11:34:47 +0100
Received: from IS9PRIF00117.ap.cdc.fr (10.12.149.182) by
 IS9PRIF00117.ap.cdc.fr (10.12.149.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Mar 2023 11:34:47 +0100
Received: from IS9PRIF00139.serv.cdc.fr (10.11.134.74) by
 IS9PRIF00117.ap.cdc.fr (10.12.149.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 23 Mar 2023 11:34:47 +0100
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (158.156.156.209)
 by hybridesmtp.caissedesdepots.fr (158.156.156.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 23 Mar 2023 11:34:45 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtV31TplCi/XcnZ6at1obVOpD2Vg1a7ef8//NmP5RvJzyjS4HwXhfGVmR3b5oM+Og+e9eYdXX1oXdez/OfauAyU2P/3ReQ/eGQiukCSL+4RPP/6yKnaMF3WpACxpL7H6iE/ZL/VyONdDblVG4xxDTZeP8B460D4ovTrOMIO19jaCdWLKLMH16En15JLTHaQ8OHXnsUwYM1V7PNi9qjL1qw6N0cASo5/iXVZhWLslpm/oVjRECAxgd1j68MdWvxtkbqWxzzrwswdEIlaJZIP2Q7AvgGO/IMJv+QlZPGrLvAJC6v84AW2JgHneBLq3m5KmZyDFY7hcoekhnCtu0mzBtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajTWYge6LK4pKblyzNhpqGzEY7rs909PCViE37YJsjQ=;
 b=LjISNF/GeO6nJzq/DJEY1jzKBtpEw8xrD2ZD0HoGwiCwLOJwUmasKuJkqakHOHvjk1nPFi0rW8lO+Q9dMgsfO3CT72ahEJZ5bv3/2WG4jBWMlkGYzHalaYQ9Gxf3RTEfw3ZBvhdyyscTf1aSgurH6B3ZCT/puXIbXc2Kmxlq3dCJVyytw25qRxx0xlJJW5KfgPwhjU7B1xpg00GjCGZ2L/0ejsoIfINTDd7pZw8QaB1caV9G4Y2fnvkElDeVt3+1qG24A1x7Xnz2FAxuJsGjwltmEqEifp+9E3UZcXg7tLar44Sq+RDmn42+nww3O9A3Zs2nckmVnIrBmaCgzVrigw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=caissedesdepots.fr; dmarc=pass action=none
 header.from=caissedesdepots.fr; dkim=pass header.d=caissedesdepots.fr;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=caissedesdepots.onmicrosoft.com;
 s=selector2-caissedesdepots-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajTWYge6LK4pKblyzNhpqGzEY7rs909PCViE37YJsjQ=;
 b=geYfElUNXwF6kqwYsD3D+tH6mcEn91fBpOypnMuC0WC+I7ZTy/92Q0QxNmxLZBi8XFTYiw9i6QZMDmN73u9M8QqXP9TLTgXe+qEpddYlxcVpWBJ0GTJc/AJftVbB2mhUdmgtUmPyGQyVsMPda9f8Pt4jExNbO5lECTlfshpIJc0=
Received: from PR2P264MB0799.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101:5::13) by
 PAYP264MB3350.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11d::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.38; Thu, 23 Mar 2023 10:34:45 +0000
Received: from PR2P264MB0799.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9483:e6d4:9856:e66b]) by PR2P264MB0799.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9483:e6d4:9856:e66b%7]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 10:34:45 +0000
From:   "Coirier, Emmanuel" <Emmanuel.Coirier@caissedesdepots.fr>
To:     Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: git credential doesn't honor git config precedence rules
Thread-Topic: git credential doesn't honor git config precedence rules
Thread-Index: Adlc3SOlyG0QOZG0SXu+A5iGz9Kw0wABV+wAACO17SA=
Date:   Thu, 23 Mar 2023 10:34:45 +0000
Message-ID: <PR2P264MB07997215D8A116F782FD131CF4879@PR2P264MB0799.FRAP264.PROD.OUTLOOK.COM>
References: <PR2P264MB07999A445EAD2DB4BD48AD4CF4869@PR2P264MB0799.FRAP264.PROD.OUTLOOK.COM>
 <20230322171952.GB4296@coredump.intra.peff.net>
In-Reply-To: <20230322171952.GB4296@coredump.intra.peff.net>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_94e1e3e5-28aa-42d2-a9d5-f117a2286530_Enabled=true;
 MSIP_Label_94e1e3e5-28aa-42d2-a9d5-f117a2286530_SetDate=2023-03-23T10:34:43Z;
 MSIP_Label_94e1e3e5-28aa-42d2-a9d5-f117a2286530_Method=Standard;
 MSIP_Label_94e1e3e5-28aa-42d2-a9d5-f117a2286530_Name=C2-Interne avec
 marquage;
 MSIP_Label_94e1e3e5-28aa-42d2-a9d5-f117a2286530_SiteId=6eab6365-8194-49c6-a4d0-e2d1a0fbeb74;
 MSIP_Label_94e1e3e5-28aa-42d2-a9d5-f117a2286530_ActionId=239c2900-69ca-4cff-9668-85e253dd67b7;
 MSIP_Label_94e1e3e5-28aa-42d2-a9d5-f117a2286530_ContentBits=2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=caissedesdepots.fr;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR2P264MB0799:EE_|PAYP264MB3350:EE_
x-ms-office365-filtering-correlation-id: 62da7f90-96e3-48b2-fe9f-08db2b8a3844
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Acq8Ug/HZ94FitvwGAB5NLErqBTBgg7lvBwsj+SUPtUoIhrFHFfXFIk5vKFIiqYts9TJADY8aptS6ztRpLAOFlXzzWpsaZoTur2cRQYcOCteiQNOa7Z1LpA2t0PWg+fZwgQCvcIgA/wXBNWka0/nQvuTgkhZx64hp7bAy23a+vjh/9prO/goBIjOMvI6T9h7JwQ33WcnSvcGOzSlMPwDuc5olcwvTNIhFz3TYP9wUsjNXNsfnIl+vVmbYhsz930EL+Cgi9SUpICG8ROlUO6vb+r0Qm15Oa5H5DDR94iKknM0xYAqiqphvAn9kGtGEpWaoy6nsseQvRA2AVkltd/mIceIPM4SLLlBPvPMR6/tGLPRNU3bLJGbI/SYNzssud70efefSDvHZhP8BI3oPqqVtcyBpDhF6lYVaHBvp5fMYqFq8SlH5sQO+wnK5wnVXDynVdD8JaSIZnZCuhvW7bwA9iD5BoapWiEB3ATNeKoScq/3nHK2JqLrByuq0F22vfwCTtcDsCc7yi7z9SdfyJ5oYbK1erLeECZE1mGHP85xiwoJowKzx06+eToRNPlE9k9bSiKXKU4MplsJhRsv00jaaouVdFAx4YL/qedV+SKTa6oFlgU2wY+SdkhI7poPyZGd5wKPtdt38UwxdajMfexZ3WOLP16POtkM4pnyJ5GefTMz4grnsh0g4M/bv9w7zU5G7ksB6KHqzRle5+5ylyYWnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR2P264MB0799.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199018)(4326008)(6916009)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(316002)(5660300002)(122000001)(82960400001)(41300700001)(8936002)(52536014)(26005)(6506007)(66574015)(9686003)(186003)(83380400001)(478600001)(7696005)(71200400001)(86362001)(33656002)(55016003)(38100700002)(2906002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGZQMlUvdVkwWHNWZm40aFJyTEV6Qm95aWY3OW42STJ0R0ZjbGhmT29ubEkz?=
 =?utf-8?B?a2dvc05DYnNQSzdUeWQ0YWJ4L1pNdk1RL1d4b1RDTDNSRnFod3ZRMk9ocWxj?=
 =?utf-8?B?MXE4L3VtaVlxU0xaZEZkOEdTa1pIdDRPRkcrQ0NpM2dCR2VxeXd0Y2V4Q1BR?=
 =?utf-8?B?bWZyNURNVXdVeFhLNUtFeDd1b2o1SUhFb2haVGFuNnFJWDRqb0J2NVFSU0RH?=
 =?utf-8?B?amRERU5vb1JQWjV2azdZbkRpTkdMbVh3Vnp6RWdnMURHcWEyVEdNS3ZBRzdH?=
 =?utf-8?B?eE5kOGwwT3YwUExwVWVTMXhBNWV1TEdvYUd2MlFKWTNTdWdoTHJZUXhoeFNV?=
 =?utf-8?B?V1pVVmFhZ2sweEhibm9XSEhMdTVCc09PNmN1YWR0enZCRGwrbjhPQ285R3ov?=
 =?utf-8?B?SnJkaVg3NWZDS2t4M2V1ay9qaEZFMGtSdWRsck1odGVXaHJ5cnRsQVd3ZmZN?=
 =?utf-8?B?Nnd4UVJaYm5kN28xeGxvQ09mZCt6WFl1eC9oYWYwSkMvQ0JMRHMwUWhjTnhm?=
 =?utf-8?B?YWtYMFJCcStPejFDVEFBM0Fodkc2bmgvVXVkTXFhZFZNT2ZqdG9SRGIwTy81?=
 =?utf-8?B?bTE3U25NVUhlNjBtWXFxN0pnbTR2T3FadUVmT1pCYllDN0hwcGErdk9lbXZn?=
 =?utf-8?B?MFhneGFUbHBwd05DTnZzRHhoSGNWU3MwN0RraGhRaUU5VE1VUUswamFkeVpV?=
 =?utf-8?B?Mi9ZZjRicUZ2ektncU85YUhoSWtkRGZ5MEZTdFJibEVwcFgzdUxRL05MSmsz?=
 =?utf-8?B?aitoVXBzQjQyckh2OGVVUlEvUGxZSEFMWFJIb2c0Y20yTzhIOU5pa2FTS05k?=
 =?utf-8?B?bkRZRU1CR25zdTFkRmlNcjlNMVdsNytiWmZrYXRKbFl1SktHTFhyMGtPQi9L?=
 =?utf-8?B?TnJ2bUFucnd4c1hBK3RUdWp2RW9iSE9idkp3YXJmME5KM3VkNmhmYWQzZHpM?=
 =?utf-8?B?VWFVbUh2WnRHZG9KTTBELzBhRVJ1UU1lQjdiZHljbHlrTlA3a2p2a05VenJ0?=
 =?utf-8?B?eVI5NmVTbnpKRVRJYlVJVG5Oc1BFNUNoTmp3UnFFWUR5aHFMUldPQU01U1RO?=
 =?utf-8?B?alBDaGoxTjRDUHpScFROQ1BBM2NhaVpGYTRSRko5LzBvcGF6YzluT1d4bWRG?=
 =?utf-8?B?VlZGZTNDRkIyUXpHdENuNGpEQmFCbWJ1UkkwanBIZWJ1OXU4amNucjU3TldN?=
 =?utf-8?B?UDJ4MVZPWE1PVmhQdTJIK0JRd0ZVVXh5azM4Z21XOU5SM2VaWHdYa3RHK1hh?=
 =?utf-8?B?ZzZJcjJXT1kwVUE5aU9BdGtsaDFQNXp3dklDUkc3SVZsdXo5VnFQZXo1QWRE?=
 =?utf-8?B?bmU2TnhNZy9CN2ZtSitlRUx6ekJoeE00ZmlTSFBjdjBla2JSMENmWTA4eGNS?=
 =?utf-8?B?Qy8wVUtEY1Jwc0M0Tm5sL0h5UzUxWFp6MTNhamwzQWJQTzBFV3laa1ZqSGxv?=
 =?utf-8?B?alB6bG4zOEJGdWRqRmhYT09UWnNlVHRXbkVETkRSekxnNDl2YWYvLzdFeksw?=
 =?utf-8?B?ZTBHa096NE15ck9odUdxR3RDdlBMSlJHSEE5VWNqOVVqQ2I1SVVEL3pOSndy?=
 =?utf-8?B?djFEKzRieCt4bEhLQjEyYXIyTnJkdUpjMVNYZEFJbDNWNTlna2tqL2xlcXh3?=
 =?utf-8?B?T0hwcjdvaDV2VThNbnZ1a2FvZzU4emM5OHdYbkp6MmtvTXJhYWIvKytTb2tu?=
 =?utf-8?B?TmZBTStrUW9FWU9NWUlOT0pCVVpVQmhxMldSak9WT09IT2hCQlEwV0V1NXpB?=
 =?utf-8?B?eVQxQjRFVlZYdEdWaDN2TEpsZHpZZStNTUpyaWFyN0FEMDBkc1ZTWXF3amEz?=
 =?utf-8?B?S1NnVXNrcU9kdlFHTEZQR3BZa1NlSTZoREdHTUkzc04zWnpHTUc5VjRWZFc4?=
 =?utf-8?B?K25BZmEybEFaM29PK2orZ3planUzM1BIKzE4aktWS2R0Y0hQT3lFKzV5NjE4?=
 =?utf-8?B?cVFrSkxUWFQxOGZXWmNRVnFQUzNTT2laa2dKYmZvMjZQWDF3eVczUU9oTk96?=
 =?utf-8?B?cEU2NFgyMWRoemlBZnlDdTk2czlLdC9IS2dZMGU3ZkJKRXhzb3dCeE83YTBx?=
 =?utf-8?B?czZ3bnQxMmhBc1ZCL3hqZXBtWHJRZUxCNmdUNk1NN1hwWlExZGxEdmVPUnFC?=
 =?utf-8?B?STN2Mk5pYnRUdWVQNkJQWURzWFZvZCtNTE5YWU43elBjNTh4MmtOYVkvVGJl?=
 =?utf-8?Q?6fgykpFpaRe0ybDvQVYjTBc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR2P264MB0799.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 62da7f90-96e3-48b2-fe9f-08db2b8a3844
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 10:34:45.2271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6eab6365-8194-49c6-a4d0-e2d1a0fbeb74
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aP1/rcr8t3pEp8HZm4Qj06KQ+LFhYtpPSOWFTHGi3fcJBYXzzrZiFEZJzw0mroLaALFBYNmFWeRKzhi1WKCLWn2/Mm/aON3tVirv8ZPqano6j3SLm+mNFqKfRKQp0tkI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAYP264MB3350
X-OriginatorOrg: caissedesdepots.fr
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

RGVhciBKZWZmLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgdmVyeSBpbnN0cnVjdGl2ZSBhbnN3ZXIu
IEkgcmVhbGl6ZWQgdGhhdCBJIHdhcyBvbmx5IGF0IHRoZSBoYWxmIG9mIG15IGpvdXJuZXkgdGhv
dWdoIHRoZSBjcmVkZW50aWFsIHN5c3RlbSAoYW5kIHRoZSBjb25maWcgc3lzdGVtIGFsc28pLg0K
DQpJJ20gc3RpbGwgc3RydWdnbGluZyB3aXRoIHRoZSBtYW5hZ2VyLWNvcmUgaGVscGVyIHRoYXQg
ZG9lc24ndCB3YW50IHRvIHByb21wdCBtZSBhbnl0aGluZyBhbmQgcGVyc2lzdCB0byByZXR1cm4g
YmxhbmsgdXNlciBhbmQgcGFzc3dvcmQgZGVzcGl0ZSB0aGUgZmFjdCBpdCBoYXMgbm8gaWRlYSBv
ZiB0aGUgcmVhbCB2YWx1ZXMsIGJ1dCB0aGlzIGlzIGFub3RoZXIgc3RvcnkuDQoNCkJlc3QgcmVn
YXJkcywNCg0KLS0NCkVtbWFudWVsIENvaXJpZXINCg0KDQpJbnRlcm5lDQoNCj4gLS0tLS1NZXNz
YWdlIGQnb3JpZ2luZS0tLS0tDQo+IERlIDogSmVmZiBLaW5nIDxwZWZmQHBlZmYubmV0Pg0KPiBF
bnZvecOpIDogbWVyY3JlZGkgMjIgbWFycyAyMDIzIDE4OjIwDQo+IMOAIDogQ29pcmllciwgRW1t
YW51ZWwgPEVtbWFudWVsLkNvaXJpZXJAY2Fpc3NlZGVzZGVwb3RzLmZyPg0KPiBDYyA6IGdpdEB2
Z2VyLmtlcm5lbC5vcmcNCj4gT2JqZXQgOiBSZTogZ2l0IGNyZWRlbnRpYWwgZG9lc24ndCBob25v
ciBnaXQgY29uZmlnIHByZWNlZGVuY2UgcnVsZXMNCj4NCj4gW0VNRVRURVVSIEVYVEVSTkVdIDog
U295ZXogdmlnaWxhbnQgYXZhbnQgZOKAmW91dnJpciBsZXMgcGnDqGNlcy1qb2ludGVzIG91IGRl
DQo+IGNsaXF1ZXIgc3VyIGxlcyBsaWVucy4gRW4gY2FzIGRlIGRvdXRlLCBzaWduYWxleiBsZSBt
ZXNzYWdlIHZpYSBsZSBib3V0b24gwqsNCj4gU2lnbmFsZXIgdW4gY291cnJpZWwgc3VzcGVjdCDC
uy4NCj4NCj4gT24gV2VkLCBNYXIgMjIsIDIwMjMgYXQgMDQ6NDU6NTFQTSArMDAwMCwgQ29pcmll
ciwgRW1tYW51ZWwgd3JvdGU6DQo+DQo+ID4gSSB0aGluayBJIGZvdW5kIGEgYnVnIHdpdGggZ2l0
IGNyZWRlbnRpYWw6IHRoaXMgdG9vbCBkb2Vzbid0IGNhbGwgdGhlDQo+ID4gY29uZmlndXJlZCBj
cmVkZW50aWFsIGhlbHBlciBmb2xsb3dpbmcgdGhlIGNvbmZpZ3VyYXRpb24gcnVsZXMuDQo+ID4N
Cj4gPiBJdCBjYWxscyB0aGUgc3lzdGVtIGNvbmZpZ3VyZWQgY3JlZGVudGlhbCBoZWxwZXIgKGdp
dCBjb25maWcgLS1zeXN0ZW0pDQo+ID4gZXZlbiBpZiBhbm90aGVyIG9uZSBpcyBjb25maWd1cmVk
IChpZTogYXQgdGhlIGdsb2JhbCBsZXZlbCA6IGdpdCBjb25maWcgLS1nbG9iYWwpLg0KPg0KPiBU
aGF0J3MgYmVjYXVzZSBjcmVkZW50aWFsIGhlbHBlcnMgYXJlIG5vdCBhIHNpbmdsZSB2YXJpYWJs
ZSB3aGVyZSBsYXRlciBlbnRyaWVzDQo+IG92ZXJyaWRlIGVhcmxpZXIgb25lcywgYnV0IGlzIGFj
dHVhbGx5IGEgbGlzdCBvZiBoZWxwZXJzIHRvIGV4ZWN1dGUuIEZyb20gImdpdA0KPiBoZWxwIGNy
ZWRlbnRpYWxzIjoNCj4NCj4gICBJZiB0aGVyZSBhcmUgbXVsdGlwbGUgaW5zdGFuY2VzIG9mIHRo
ZSBjcmVkZW50aWFsLmhlbHBlciBjb25maWd1cmF0aW9uDQo+ICAgdmFyaWFibGUsIGVhY2ggaGVs
cGVyIHdpbGwgYmUgdHJpZWQgaW4gdHVybiwgYW5kIG1heSBwcm92aWRlIGENCj4gICB1c2VybmFt
ZSwgcGFzc3dvcmQsIG9yIG5vdGhpbmcuIE9uY2UgR2l0IGhhcyBhY3F1aXJlZCBib3RoIGEgdXNl
cm5hbWUNCj4gICBhbmQgYSBwYXNzd29yZCwgbm8gbW9yZSBoZWxwZXJzIHdpbGwgYmUgdHJpZWQu
DQo+DQo+ID4gVGhlIHByb2JsZW0gSSBlbmNvdW50ZXJlZCBpcyB0aGF0IHRoZSBjb25maWd1cmVk
IHN5c3RlbSBvbmUNCj4gPiAobWFuYWdlci1jb3JlIGluIG15IGNhc2UpIGFuc3dlcnMgYSB3cm9u
ZyB2YWx1ZSBpbnN0ZWFkIG9mIGdpdmluZyB1cC4NCj4gPiBUaGUgZ2xvYmFsbHkgY29uZmlndXJl
ZCAod2luY3JlZCBpbiBteSBjYXNlKSBpcyB0aGVuIG5vdCBjYWxsZWQgYXQgYWxsDQo+ID4gYW5k
IG15IGF1dGhlbnRpY2F0aW9uIGp1c3QgZmFpbCB3aXRob3V0IGFueSB3YXkgdG8gbWFudWFsbHkg
ZW50ZXIgbG9naW4gJg0KPiBwYXNzLg0KPg0KPiBJZiB5b3Ugd2FudCB0byBjbGVhciBhbnkgcHJp
b3IgZW50cmllcyBpbiB0aGUgbGlzdCwgeW91IGNhbiBkbyB0aGF0IGV4cGxpY2l0bHkuDQo+IEZy
b20gdGhlIHBhcmFncmFwaCByaWdodCBiZWxvdyB0aGUgb25lIHF1b3RlZCBhYm92ZToNCj4NCj4g
ICBJZiBjcmVkZW50aWFsLmhlbHBlciBpcyBjb25maWd1cmVkIHRvIHRoZSBlbXB0eSBzdHJpbmcs
IHRoaXMgcmVzZXRzDQo+ICAgdGhlIGhlbHBlciBsaXN0IHRvIGVtcHR5IChzbyB5b3UgbWF5IG92
ZXJyaWRlIGEgaGVscGVyIHNldCBieSBhDQo+ICAgbG93ZXItcHJpb3JpdHkgY29uZmlnIGZpbGUg
YnkgY29uZmlndXJpbmcgdGhlIGVtcHR5LXN0cmluZyBoZWxwZXIsDQo+ICAgZm9sbG93ZWQgYnkg
d2hhdGV2ZXIgc2V0IG9mIGhlbHBlcnMgeW91IHdvdWxkIGxpa2UpLg0KPg0KPiA+ID4gV2hhdCdz
IGRpZmZlcmVudCBiZXR3ZWVuIHdoYXQgeW91IGV4cGVjdGVkIGFuZCB3aGF0IGFjdHVhbGx5DQo+
IGhhcHBlbmVkPw0KPiA+DQo+ID4gSW4gdGhpcyBleGFtcGxlLCB0aGUgImJsYSIgY3JlZGVudGlh
bCBoZWxwZXIgaXMgY2FsbGVkIGV2ZW4gaWYgdGhlDQo+ID4gd2luY3JlZCBzaG91bGQgaGF2ZSBi
ZWVuIHRoZSBvbmx5IG9uZSB0byBiZSBjYWxsZWQuDQo+ID4NCj4gPiBUaGUgcmVzdWx0IGlzIE9L
IHNpbmNlIHRoZSAiYmxhIiBjcmVkZW50aWFsIHJldHVybmVkIGEgbm9uIHplcm8gcmV0dXJuDQo+
ID4gY29kZSwgdGhlbiB0aGUgZ2xvYmFsIGNyZWRlbnRpYWwgaGVscGVyICh3aW5jcmVkKSB3YXMg
Y2FsbGVkLg0KPg0KPiBSaWdodCwgdGhpcyBpcyB0aGUgY29ycmVjdCBhbmQgZG9jdW1lbnRlZCBi
ZWhhdmlvci4gWW91J2QganVzdCB3YW50IHRvIHJlc2V0DQo+IHRoZSBsaXN0IGluIHlvdXIgbG9j
YWwgY29uZmlnIGxpa2U6DQo+DQo+ICAgZ2l0IGNvbmZpZyAtLWdsb2JhbCBjcmVkZW50aWFsLmhl
bHBlciAiIg0KPiAgIGdpdCBjb25maWcgLS1nbG9iYWwgLS1hZGQgY3JlZGVudGlhbC5oZWxwZXIg
d2luY3JlZA0KPg0KPiAtUGVmZg0KQ2UgbWVzc2FnZSBldCB0b3V0ZXMgbGVzIHBpw6hjZXMgam9p
bnRlcyAoY2ktYXByw6hzIGxlIMKrbWVzc2FnZcK7KSBzb250IGNvbmZpZGVudGllbHMgZXQgw6l0
YWJsaXMgw6AgbOKAmWludGVudGlvbiBleGNsdXNpdmUgZGUgc2VzIGRlc3RpbmF0YWlyZXMuIFRv
dXRlIHV0aWxpc2F0aW9uIGRlIGNlIG1lc3NhZ2Ugbm9uIGNvbmZvcm1lIMOgIHNhIGRlc3RpbmF0
aW9uLCB0b3V0ZSBkaWZmdXNpb24gb3UgdG91dGUgcHVibGljYXRpb24sIHRvdGFsZSBvdSBwYXJ0
aWVsbGUsIGVzdCBpbnRlcmRpdGUsIHNhdWYgYXV0b3Jpc2F0aW9uIGV4cHJlc3NlLiBTaSB2b3Vz
IHJlY2V2ZXogY2UgbWVzc2FnZSBwYXIgZXJyZXVyLCBtZXJjaSBkZSBsZSBkw6l0cnVpcmUgc2Fu
cyBlbiBjb25zZXJ2ZXIgZGUgY29waWUgZXQgZOKAmWVuIGF2ZXJ0aXIgaW1tw6lkaWF0ZW1lbnQg
bOKAmWV4cMOpZGl0ZXVyLiBJbnRlcm5ldCBuZSBwZXJtZXR0YW50IHBhcyBkZSBnYXJhbnRpciBs
4oCZaW50w6lncml0w6kgZGUgY2UgbWVzc2FnZSwgbGEgQ2Fpc3NlIGRlcyBEw6lww7R0cyBldCBD
b25zaWduYXRpb25zIGTDqWNsaW5lIHRvdXRlIHJlc3BvbnNhYmlsaXTDqSBhdSB0aXRyZSBkZSBj
ZSBtZXNzYWdlIHPigJlpbCBhIMOpdMOpIG1vZGlmacOpLCBhbHTDqXLDqSwgZMOpZm9ybcOpIG91
IGZhbHNpZmnDqS4gUGFyIGFpbGxldXJzIGV0IG1hbGdyw6kgdG91dGVzIGxlcyBwcsOpY2F1dGlv
bnMgcHJpc2VzIHBvdXIgw6l2aXRlciBsYSBwcsOpc2VuY2UgZGUgdmlydXMgZGFucyBub3MgZW52
b2lzLCBub3VzIHZvdXMgcmVjb21tYW5kb25zIGRlIHByZW5kcmUsIGRlIHZvdHJlIGPDtHTDqSwg
bGVzIG1lc3VyZXMgcGVybWV0dGFudCBkJ2Fzc3VyZXIgbGEgbm9uLWludHJvZHVjdGlvbiBkZSB2
aXJ1cyBkYW5zIHZvdHJlIHN5c3TDqG1lIGluZm9ybWF0aXF1ZS4gVGhpcyBlbWFpbCBtZXNzYWdl
IGFuZCBhbnkgYXR0YWNobWVudHMgKOKAnHRoZSBlbWFpbOKAnSkgYXJlIGNvbmZpZGVudGlhbCBh
bmQgaW50ZW5kZWQgb25seSBmb3IgdGhlIHJlY2lwaWVudChzKSBpbmRpY2F0ZWQuIElmIHlvdSBh
cmUgbm90IGFuIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIGJlIGFkdmlzZWQgdGhhdCBhbnkg
dXNlLCBkaXNzZW1pbmF0aW9uLCBmb3J3YXJkaW5nIG9yIGNvcHlpbmcgb2YgdGhpcyBlbWFpbCB3
aGF0c29ldmVyIGlzIHByb2hpYml0ZWQgd2l0aG91dCBwcmlvciB3cml0dGVuIGNvbnNlbnQgb2Yg
Q2Fpc3NlIGRlcyBEZXBvdHMgZXQgQ29uc2lnbmF0aW9ucy4gSWYgeW91IGhhdmUgcmVjZWl2ZWQg
dGhpcyBlbWFpbCBpbiBlcnJvciwgcGxlYXNlIGRlbGV0ZSBpdCB3aXRob3V0IHNhdmluZyBhIGNv
cHkgYW5kIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5LiBJbnRlcm5ldCBlbWFpbHMgYXJl
IG5vdCBuZWNlc3NhcmlseSBzZWN1cmUsIGFuZCBDYWlzc2UgZGVzIERlcG90cyBldCBDb25zaWdu
YXRpb25zIGRlY2xpbmVzIHJlc3BvbnNpYmlsaXR5IGZvciBhbnkgY2hhbmdlcyB0aGF0IG1heSBo
YXZlIGJlZW4gbWFkZSB0byB0aGlzIGVtYWlsIGFmdGVyIGl0IHdhcyBzZW50LiBXaGlsZSB3ZSB0
YWtlIGFsbCByZWFzb25hYmxlIHByZWNhdXRpb25zIHRvIGVuc3VyZSB0aGF0IHZpcnVzZXMgYXJl
IG5vdCB0cmFuc21pdHRlZCB2aWEgZW1haWxzLCB3ZSByZWNvbW1lbmQgdGhhdCB5b3UgdGFrZSB5
b3VyIG93biBtZWFzdXJlcyB0byBwcmV2ZW50IHZpcnVzZXMgZnJvbSBlbnRlcmluZyB5b3VyIGNv
bXB1dGVyIHN5c3RlbS4NCg==
