Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A14FC6FD1C
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 13:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjCVN0U (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 09:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCVN0R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 09:26:17 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Mar 2023 06:26:14 PDT
Received: from mailfronta3.caissedesdepots.fr (mailfronta3.caissedesdepots.fr [212.157.112.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF63627996
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 06:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=caissedesdepots.fr; s=mx1; t=1679491575;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=GccJesarxoMhnV60XPggGG8ny6mJaI9P1255xsIeapI=;
  b=PZrh5IH9xzPUaga9CGUWzk+DzkH6G9EVeE/PF/XALacG3ekkAqygRR4t
   cbI5mklWhj/uPeSjQ7M+MKDv++6QtxiLOozHbFaz4jr5opF5SVLQaK9bV
   IRWxlL6yduLmfUxuaWKMAlv7gTO3PktudJq3Yl/WgrJJvuAwPJANF/D/k
   w=;
Received: from dlmailfedproda2.inet.local (HELO mailfrontfeda2.serv.cdc.fr) ([158.156.1.195])
  by mailfronta3b.caissedesdepots.fr with ESMTP; 22 Mar 2023 14:25:08 +0100
X-IronPort-AV: E=Sophos;i="5.98,281,1673910000"; 
   d="scan'208";a="16364933"
X-MGA-submission: =?us-ascii?q?MDEeqPItZTRilpTBDx3Rp33l57KWqiz9QGZsZg?=
 =?us-ascii?q?KMm/2Bh6nigSrkUHGIOxplFRg+OFSPL2UsFAcGZay+KaTEC9NbXpvKVz?=
 =?us-ascii?q?0TwFWqIBjb5DatnOuqWo7o3NhyyhZua0BvbQbyoR9JD1eLln2BcQ0j6Z?=
 =?us-ascii?q?Ap?=
Received: from is9prif00115.ap.cdc.fr ([10.12.148.49])
  by mailfrontfeda2.serv.cdc.fr with ESMTP; 22 Mar 2023 14:25:08 +0100
Received: from IS9PRIF00112.ap.cdc.fr (10.12.149.221) by
 IS9PRIF00115.ap.cdc.fr (10.12.148.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Mar 2023 14:25:08 +0100
Received: from IS9PRIF00140.serv.cdc.fr (10.11.134.75) by
 IS9PRIF00112.ap.cdc.fr (10.12.149.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 22 Mar 2023 14:25:08 +0100
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (158.156.156.209)
 by hybridesmtp.caissedesdepots.fr (158.156.156.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 22 Mar 2023 14:25:06 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTvfIDDidBlCPHJbA9WagEJsTSAdc70Z20Na3V3zxiq9hUyIFaqqtEx8rcpK1NhGwlsLixb0QFnPB2qcMIxICSfhuIC0qW3B9RzL3ZFx92+fH/qdxcuGzsUg/5t2FWjW7e56vK1cc8ozMbaQxOrhdvTj+maTO+hnwc5Ap/owIwkbUgBU7q/Vae1lwmt5jzDtQUFXaazFGoM47k/AMkjV/Ykwn/lUsnWt7z1YHCrpKmcnpRTpqva5xskFN1T9SSnK4RDVbB7Pp/IMRQpw+4P3ZyYYf9QDtt9d2b/xQH5Ea1Vdn32c55ubogOjKj1iOp2MQPDSXsvdumBE32CjcdFUFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GccJesarxoMhnV60XPggGG8ny6mJaI9P1255xsIeapI=;
 b=VTtrBnmXCya9+ppx8bu8xKc+Bw6CXl63mVZ5bo+bPFetk3DjCRO8W5xXsP9RROvaGx9MMjOQSvqrMkwaw/aRSjRPlJQYZ1rUAUAnfoZ/KIYxYkvWbzTJeyfuos3UMLXWgqS+M6V/OS2+i+WwMUn2KIrieJR1p3lkADdZ/+xkphpRuDAJZoMVr9OFm9CJUNOEkuBNxu9ui6b2f39o8LwecKNSM7X5kHr6IP8+XkDduXmPX9dJDH4njDNwuC4iGIdXhT5OEzCZfxQDSsDDPlZk8Qq1A0iIzKCFxI3ThwJ7E9Q4N3NgumZTp18rD1Nrfb8daaC12x+th7raqRfmFpRAtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=caissedesdepots.fr; dmarc=pass action=none
 header.from=caissedesdepots.fr; dkim=pass header.d=caissedesdepots.fr;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=caissedesdepots.onmicrosoft.com;
 s=selector2-caissedesdepots-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GccJesarxoMhnV60XPggGG8ny6mJaI9P1255xsIeapI=;
 b=epuCryfFxTKxlLWI511ajjDFf+fVKFb87EVBF0/xFfaHMzkDECCENIIwy36ttObHRf1lGsyqsYBDJvJjz4p9rm9XPRJDL7yyyE0/PXOGO5kIEj6fz8Vsz8u9HmJfPLHelZpCAe7RhwJTH9kWxaIQofErpuWrO7v7fblCa9n8ARQ=
Received: from PR2P264MB0799.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101:5::13) by
 PAZP264MB3087.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f5::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Wed, 22 Mar 2023 13:25:07 +0000
Received: from PR2P264MB0799.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9483:e6d4:9856:e66b]) by PR2P264MB0799.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9483:e6d4:9856:e66b%7]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 13:25:07 +0000
From:   "Coirier, Emmanuel" <Emmanuel.Coirier@caissedesdepots.fr>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Minor bug regarding git-reportbug
Thread-Topic: Minor bug regarding git-reportbug
Thread-Index: AdlcwZ7iuBXUWVorTtS96wvFbIv8+g==
Date:   Wed, 22 Mar 2023 13:25:06 +0000
Message-ID: <PR2P264MB0799BA146D27303A72B3EF69F4869@PR2P264MB0799.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_94e1e3e5-28aa-42d2-a9d5-f117a2286530_Enabled=true;
 MSIP_Label_94e1e3e5-28aa-42d2-a9d5-f117a2286530_SetDate=2023-03-22T13:25:05Z;
 MSIP_Label_94e1e3e5-28aa-42d2-a9d5-f117a2286530_Method=Standard;
 MSIP_Label_94e1e3e5-28aa-42d2-a9d5-f117a2286530_Name=C2-Interne avec
 marquage;
 MSIP_Label_94e1e3e5-28aa-42d2-a9d5-f117a2286530_SiteId=6eab6365-8194-49c6-a4d0-e2d1a0fbeb74;
 MSIP_Label_94e1e3e5-28aa-42d2-a9d5-f117a2286530_ActionId=8f729f13-6296-4d4b-907b-eacce17af4d4;
 MSIP_Label_94e1e3e5-28aa-42d2-a9d5-f117a2286530_ContentBits=2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=caissedesdepots.fr;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR2P264MB0799:EE_|PAZP264MB3087:EE_
x-ms-office365-filtering-correlation-id: 6503d960-ca5b-469f-9b1a-08db2ad8da7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iD7mW7Wif1bbQy/TwhSAPcoZKux1p/mdGd4lsCjhiXyHzRhyw7BLSWy0IXsIw/cRTJ61epFg3tzLqQsrBD4vWTib/jhXdn26ifJii7+zuW8Rz1qBS46eanQ8GcUmquLFVUuHq37TBu73YqHTFK97iLBn1hPCyfX6mECynyuUdS09j7i15IXxroEuIT2P56TaQckZpr83ObiUPS97kcB+e+b2M6hxhL5FAsKyEvU7n25ox7n4UW09kCbe0GHoLBCWbcSamSKc1S29/9mxeLVl38ya0J9ZKpRpCDfWjtdYlVrEL5T/XQ8NRnkn5h7x5HPqIuhDKiLfJnKGUXwWUtY2BO28LRVcEWz/ETfZ96zsJERF/zLgmrZqL8L8vu608c8JbrXN4sdtL83/0grsn04EAA5rtc1xelWxTfonQQheerFmk6S5F0EXBUJMP03azTxFd9lSf6/0XzeGQejXi8KNbVziP/qBV8mcS6mQAIktR5gX97Aep37a277aDbWVveQjkfLXIF4HzLjR5gWbiLNdIAXB5FFkCGiyMGPZyz23Zjzs8HCi/qY+sBfjVXg8lRG40gwN/oDBubBIKX8fhtlKZeEai/xLzXNooAj2mnZ7ItuwtVL6bvsfdDivhnF2hqlN2l+7bqPVlSxlQcchP2ndcXSPCG69haZ7f4tCs11AjifwuLiHAsbFSzAO7LFa/3BnhRnyPxIywXA4kkJb+6ZXiPxewbnsY8AtHa04kybcMsA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR2P264MB0799.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199018)(71200400001)(7696005)(66574015)(186003)(83380400001)(478600001)(66476007)(316002)(66446008)(64756008)(76116006)(66946007)(8676002)(6916009)(66556008)(9686003)(6506007)(26005)(41300700001)(8936002)(5660300002)(52536014)(122000001)(82960400001)(2906002)(55016003)(38100700002)(86362001)(38070700005)(33656002)(460985005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmxVbUZVc3ZGWlBuOXdKRTkrNkFQNWtRN3ViY1Q0U2drVU5yRTM5RGZaK3Va?=
 =?utf-8?B?enQ5UnBMMDlpczUrVUtnd3RtbDVUdnBnU0MyWEFCK1VHalpNUlpIcXRzZTI4?=
 =?utf-8?B?RVJQSmdXd3M0bElhYmhheHpZby9KOUFjN3lxeWZwdVZ0WExNdzduVDhVZEpW?=
 =?utf-8?B?YTNTY2hFV2haZ3lhM1pTQkN0MzZvcXFqdTRzaE9ucVRpMkhHNXNaY0xPbzJ2?=
 =?utf-8?B?UDZ6eldZdHdHZGgvNDY4dlBiYjMvWGh3ZTRuNU1hTUxMTEduR3BQWFZmL1B1?=
 =?utf-8?B?c1RLZ2RhTFhhWTEvdWRzUnVucjNOYUVhUENYT2poZkZ3UjE5WnUrSGpNV3pV?=
 =?utf-8?B?dFpEaHU0OFpNS29Xb2FMZU91cGFvVlovWm45RUs4Mk5nSXVoUGJpaTZ2Z1Er?=
 =?utf-8?B?UWNJSndSQnlrbVovZTR6T1oxMTZYb25INkpsVzR0LzRiV2NFUUx1R1BUaEFm?=
 =?utf-8?B?U25sTG45N0M5YUNBTkNRM083dlNiR2VQK3NXeGhldUdablptMDBGcnJwNUxK?=
 =?utf-8?B?VFdTTzBoV1VoME5JUXJOYmc1NFlBV0tSVE1Xc2tqN09ZMHJlWlkyV3A1Y2Ja?=
 =?utf-8?B?ek15dUNIeUpCYjFxa0NISXpNdGNpOEY3R2ZwQWpHVDZhL1BPREthMUVBU0cv?=
 =?utf-8?B?SmszcTV3djNzQXNma3pqNFBpZnZ4RklEcDNRRFBQYkZhK25jWmk1Y0VlcGY5?=
 =?utf-8?B?OUFTMlRDcmpCRGZSdnc1WFJEbnl1NUdnSzFCaTd3bmNDcUhHeDhWWHZHR3Nj?=
 =?utf-8?B?aGtXRm0zbDdjWE5jR0M1MmNzVTFHL3FFTVl5VlZpRTZLcTJlUkRxOFdwT21z?=
 =?utf-8?B?YXFJSmwyUWxXQ1d3OTRvaVBBUmo0ZzZBQ2JmNmlXWjdkRHZFTDBwODRqTk5Z?=
 =?utf-8?B?QjJkeWxIZmFyZm5IUlpFbXVYcTdSSkd0MkZWOUFYZ0FYeDZUcXM5MEUwQktE?=
 =?utf-8?B?a2tvT2tHSXVhMS9EY2ZYclk4VWNSS2dSZURDUGtiZ3NOZnpCNVNuWnlHV2ty?=
 =?utf-8?B?NzRsMDROOGszZ3VsdGNBQ2U4YWtQandma0RyNDVMMVBBakpIQXVoei9LUW56?=
 =?utf-8?B?dDN4amxTOVVZM2twaWJxS0FaZHBJZXpyYzZyaEVlQW5NMUZ3SC9ZU3lXTElL?=
 =?utf-8?B?QlcrdHZBWDAvZEZoL1hYVzVkSWpQM3NBSFFIMVJ3VGdWVCsybDNJN2RreVZs?=
 =?utf-8?B?Q0ZPanI5ZDZpdUk4QmgzZk5YcmtMMTl6d1dEUjVDN2hhTFR0b1VldEp2TTBT?=
 =?utf-8?B?SkoxbE1WcjB5RGRXNUMvTFZBWmpnUGNYZG91aWlxMEZsVERYQkxhdUVCZmlV?=
 =?utf-8?B?ZFlhRjJoM2FaYm1vVEZhQUJyQnp4QXJ1ZDErQkJDWVlxVDd5ek9QL1VuR08v?=
 =?utf-8?B?RXJkL1ZYOVVlNWxVTzNENHluTmEzSktXb0lab2ROSHVFR1d2cmg5UitRcmtJ?=
 =?utf-8?B?N3lCUDYwdzgyR3RJU1k0Q1ZCT0tYVHVyUFFvREtTQzdHcUJZaWdmMnRUOURW?=
 =?utf-8?B?R2dFKzdQS0ZNU0RDSEZQSnI1S3R1aHVBUW5GVENsdUd5THUrd3dDTUVjS0tw?=
 =?utf-8?B?UExlS1J6MldGWGQyWHJublFKRkl6dmY0ZkNoZFZ5UTdLRTFOY0lxeEY4REhH?=
 =?utf-8?B?RnIvQVVUeWtVcGpHK2xWSXM1VjhGZ1JDSWs4bFk2bXpzUVZIY09nSmNDRFpX?=
 =?utf-8?B?TkY0akJpVVVRaFdpM21iZ2kxbTdHL3lsMXRGcERwUjBrd09LYWk3QWhmMVVL?=
 =?utf-8?B?K1NEKzVNcU5kVEdzdTY1V1BicEVmcEk4SmpqVDZ3cmpidmNLWWw4UEJsTmcr?=
 =?utf-8?B?UzJPcmNNb3VETDhkT09zZ3BpOW5UMVZPTFBkWndHUy8zQjl3VExEcVR0Q1BI?=
 =?utf-8?B?Qks2dHJnNS9vdmhNaVBBNUJIZ2FpWGVOWjJLMGZ2Rml3cjJBTUduYWdiUnNW?=
 =?utf-8?B?RUVVUmI0WFg5dmpGcDFrTGgvSFlDTjZpM3ByKzBMbGNYOEhHTGRVbFEvbGRv?=
 =?utf-8?B?WEd3ZnFpeWhjbnpUeVZqcytWdmczMjd0Q0ljQ1RwQ3JnU2o1WmpwcHBIRFJ4?=
 =?utf-8?B?MWRjSTZCSzFpeFU3YWYvbnBOMCt6RlJMbkhzWDVaL21ocG1wK1kzaDVFMzV6?=
 =?utf-8?B?aW1ueGphdmJqdFhpV1duK2pZNnE1UittYWNJTU9GY0d4QkR0L3VOaGdlKzdH?=
 =?utf-8?Q?P/CYK7s3oKr4gGySWUb9lsg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR2P264MB0799.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6503d960-ca5b-469f-9b1a-08db2ad8da7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 13:25:06.9333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6eab6365-8194-49c6-a4d0-e2d1a0fbeb74
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: USzbgPF4ThFoBjTUQM07PlREanz4XG/6nnlHNLsic38ARUS997lKFBqvg1MYp0gR5v9gsf8H+ynVFJbaYCS9HYUWJZ4MK9G2dHmNE3IwpYp107v4PNqdTm8Jdhd2G0Qg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB3087
X-OriginatorOrg: caissedesdepots.fr
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGkgZXZlcnlvbmUgIQ0KDQpIZXJlIGlzIGEgbWlub3IgYnVnIHRoYXQgSSBkaXNjb3ZlcmVkIHdo
aWxlIHRyeWluZyB0byByZXBvcnQgYW5vdGhlciBidWcgOg0KDQpUaGFuayB5b3UgZm9yIGZpbGxp
bmcgb3V0IGEgR2l0IGJ1ZyByZXBvcnQhDQpQbGVhc2UgYW5zd2VyIHRoZSBmb2xsb3dpbmcgcXVl
c3Rpb25zIHRvIGhlbHAgdXMgdW5kZXJzdGFuZCB5b3VyIGlzc3VlLg0KDQo+IFdoYXQgZGlkIHlv
dSBkbyBiZWZvcmUgdGhlIGJ1ZyBoYXBwZW5lZD8gKFN0ZXBzIHRvIHJlcHJvZHVjZSB5b3VyIGlz
c3VlKQ0KDQokIGdpdCBjb25maWcgLS1zZXQgLS1nbG9iYWwgY29yZS5lZGl0b3IgbmFuby5leGUN
Cg0KJCBnaXQgY29uZmlnIC0tZ2V0IGNvcmUuZWRpdG9yDQpuYW5vLmV4ZQ0KDQokIGdpdCBidWdy
ZXBvcnQNCg0KPiBXaGF0IGRpZCB5b3UgZXhwZWN0IHRvIGhhcHBlbj8gKEV4cGVjdGVkIGJlaGF2
aW9yKQ0KDQpnaXQgZ3VicmVwb3J0IG9wZW5zIGEgdGVtcGxhdGUgdG8gZmlsbCB3aXRoIHRoZSBu
YW5vIGVkaXRvciAob3IgdGhlIGVkaXRvciByZXR1cm5lZCB3aXRoICQoZ2l0IGNvbmZpZyAtLWdl
dCBjb3JlLmVkaXRvcikpDQoNCj4gV2hhdCBoYXBwZW5lZCBpbnN0ZWFkPyAoQWN0dWFsIGJlaGF2
aW9yKQ0KDQpnaXQgYnVncmVwb3J0IG9wZW5zIGEgdGVtcGxhdGUgaW4gdmltLCB3aGljaCBJIGRv
bid0IHVzZSBvbiBhIGRhaWx5IGJhc2lzLg0KDQo+IFdoYXQncyBkaWZmZXJlbnQgYmV0d2VlbiB3
aGF0IHlvdSBleHBlY3RlZCBhbmQgd2hhdCBhY3R1YWxseSBoYXBwZW5lZD8NCg0KVGhlIHdyb25n
IGVkaXRvciwgdGhhdCBpcyBub3QgY29uZmlndXJlZCwgaXMgb3BlbiBpbnN0ZWFkIG9mIHRoZSBk
ZWZhdWx0IGVkaXRvciBwcmV2aW91c2x5IGNvbmZpZ3VyZWQNCg0KDQpbU3lzdGVtIEluZm9dDQpn
aXQgdmVyc2lvbjoNCmdpdCB2ZXJzaW9uIDIuMzcuMy53aW5kb3dzLjENCmNwdTogeDg2XzY0DQpi
dWlsdCBmcm9tIGNvbW1pdDogYzQ5OTJkNGZlY2FiZDdkMTExNzI2ZWNiMzdlMzNhM2NjYjUxZDZm
MQ0Kc2l6ZW9mLWxvbmc6IDQNCnNpemVvZi1zaXplX3Q6IDgNCnNoZWxsLXBhdGg6IC9iaW4vc2gN
CmZlYXR1cmU6IGZzbW9uaXRvci0tZGFlbW9uDQp1bmFtZTogV2luZG93cyAxMC4wIDE5MDQ1DQpj
b21waWxlciBpbmZvOiBnbnVjOiAxMi4yDQpsaWJjIGluZm86IG5vIGxpYmMgaW5mb3JtYXRpb24g
YXZhaWxhYmxlDQokU0hFTEwgKHR5cGljYWxseSwgaW50ZXJhY3RpdmUgc2hlbGwpOiBDOlxEZXZl
bG9wcGVtZW50XEdpdFx1c3JcYmluXGJhc2guZXhlDQoNCg0KW0VuYWJsZWQgSG9va3NdDQooTm9u
ZSkNCg0KQmVzdCByZWdhcmRzLA0KDQotLQ0KRW1tYW51ZWwgQ29pcmllcg0KDQoNCkludGVybmUN
CkNlIG1lc3NhZ2UgZXQgdG91dGVzIGxlcyBwacOoY2VzIGpvaW50ZXMgKGNpLWFwcsOocyBsZSDC
q21lc3NhZ2XCuykgc29udCBjb25maWRlbnRpZWxzIGV0IMOpdGFibGlzIMOgIGzigJlpbnRlbnRp
b24gZXhjbHVzaXZlIGRlIHNlcyBkZXN0aW5hdGFpcmVzLiBUb3V0ZSB1dGlsaXNhdGlvbiBkZSBj
ZSBtZXNzYWdlIG5vbiBjb25mb3JtZSDDoCBzYSBkZXN0aW5hdGlvbiwgdG91dGUgZGlmZnVzaW9u
IG91IHRvdXRlIHB1YmxpY2F0aW9uLCB0b3RhbGUgb3UgcGFydGllbGxlLCBlc3QgaW50ZXJkaXRl
LCBzYXVmIGF1dG9yaXNhdGlvbiBleHByZXNzZS4gU2kgdm91cyByZWNldmV6IGNlIG1lc3NhZ2Ug
cGFyIGVycmV1ciwgbWVyY2kgZGUgbGUgZMOpdHJ1aXJlIHNhbnMgZW4gY29uc2VydmVyIGRlIGNv
cGllIGV0IGTigJllbiBhdmVydGlyIGltbcOpZGlhdGVtZW50IGzigJlleHDDqWRpdGV1ci4gSW50
ZXJuZXQgbmUgcGVybWV0dGFudCBwYXMgZGUgZ2FyYW50aXIgbOKAmWludMOpZ3JpdMOpIGRlIGNl
IG1lc3NhZ2UsIGxhIENhaXNzZSBkZXMgRMOpcMO0dHMgZXQgQ29uc2lnbmF0aW9ucyBkw6ljbGlu
ZSB0b3V0ZSByZXNwb25zYWJpbGl0w6kgYXUgdGl0cmUgZGUgY2UgbWVzc2FnZSBz4oCZaWwgYSDD
qXTDqSBtb2RpZmnDqSwgYWx0w6lyw6ksIGTDqWZvcm3DqSBvdSBmYWxzaWZpw6kuIFBhciBhaWxs
ZXVycyBldCBtYWxncsOpIHRvdXRlcyBsZXMgcHLDqWNhdXRpb25zIHByaXNlcyBwb3VyIMOpdml0
ZXIgbGEgcHLDqXNlbmNlIGRlIHZpcnVzIGRhbnMgbm9zIGVudm9pcywgbm91cyB2b3VzIHJlY29t
bWFuZG9ucyBkZSBwcmVuZHJlLCBkZSB2b3RyZSBjw7R0w6ksIGxlcyBtZXN1cmVzIHBlcm1ldHRh
bnQgZCdhc3N1cmVyIGxhIG5vbi1pbnRyb2R1Y3Rpb24gZGUgdmlydXMgZGFucyB2b3RyZSBzeXN0
w6htZSBpbmZvcm1hdGlxdWUuIFRoaXMgZW1haWwgbWVzc2FnZSBhbmQgYW55IGF0dGFjaG1lbnRz
ICjigJx0aGUgZW1haWzigJ0pIGFyZSBjb25maWRlbnRpYWwgYW5kIGludGVuZGVkIG9ubHkgZm9y
IHRoZSByZWNpcGllbnQocykgaW5kaWNhdGVkLiBJZiB5b3UgYXJlIG5vdCBhbiBpbnRlbmRlZCBy
ZWNpcGllbnQsIHBsZWFzZSBiZSBhZHZpc2VkIHRoYXQgYW55IHVzZSwgZGlzc2VtaW5hdGlvbiwg
Zm9yd2FyZGluZyBvciBjb3B5aW5nIG9mIHRoaXMgZW1haWwgd2hhdHNvZXZlciBpcyBwcm9oaWJp
dGVkIHdpdGhvdXQgcHJpb3Igd3JpdHRlbiBjb25zZW50IG9mIENhaXNzZSBkZXMgRGVwb3RzIGV0
IENvbnNpZ25hdGlvbnMuIElmIHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMgZW1haWwgaW4gZXJyb3Is
IHBsZWFzZSBkZWxldGUgaXQgd2l0aG91dCBzYXZpbmcgYSBjb3B5IGFuZCBub3RpZnkgdGhlIHNl
bmRlciBpbW1lZGlhdGVseS4gSW50ZXJuZXQgZW1haWxzIGFyZSBub3QgbmVjZXNzYXJpbHkgc2Vj
dXJlLCBhbmQgQ2Fpc3NlIGRlcyBEZXBvdHMgZXQgQ29uc2lnbmF0aW9ucyBkZWNsaW5lcyByZXNw
b25zaWJpbGl0eSBmb3IgYW55IGNoYW5nZXMgdGhhdCBtYXkgaGF2ZSBiZWVuIG1hZGUgdG8gdGhp
cyBlbWFpbCBhZnRlciBpdCB3YXMgc2VudC4gV2hpbGUgd2UgdGFrZSBhbGwgcmVhc29uYWJsZSBw
cmVjYXV0aW9ucyB0byBlbnN1cmUgdGhhdCB2aXJ1c2VzIGFyZSBub3QgdHJhbnNtaXR0ZWQgdmlh
IGVtYWlscywgd2UgcmVjb21tZW5kIHRoYXQgeW91IHRha2UgeW91ciBvd24gbWVhc3VyZXMgdG8g
cHJldmVudCB2aXJ1c2VzIGZyb20gZW50ZXJpbmcgeW91ciBjb21wdXRlciBzeXN0ZW0uDQo=
