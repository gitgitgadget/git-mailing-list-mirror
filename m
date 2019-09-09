Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 147381F461
	for <e@80x24.org>; Mon,  9 Sep 2019 15:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388422AbfIIPxB (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 11:53:01 -0400
Received: from mail-eopbgr740087.outbound.protection.outlook.com ([40.107.74.87]:41728
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725846AbfIIPxA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 11:53:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnlH+v2nLoNjl/N9bgxt2hv/FTJx0+ZAFoL9ZP7mct48r3VcmX7Eie1pAMl/6s3rUsApKCuFTQpOYUXH4AElascV9ZCnur8LLDuPg/J9VmuexHx9iWK1lYdBojIAMXd4CPdJZi/NQRN5AotAXC7/GWcbszj047iwSp35NVjYP1kQDbfZJIhZXcN9UFbX8zlnK+iesDNcw0CYQGatbz8+f+PbKn0wr1MSjQSaxr2ebnBhg+QzjpL7dvZA7WhnCyl+FgNehApTxpAOJvUso5GjL+YfJq7edas7gFJe1NvK2cFJMvFWdXCkuKKvh0zuZwzCcqLkJjjEkydyD8ziPXCJaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUxrHRkRHtiSXs9oLgFsWXLi92nE+/qHe5cH82P8JQQ=;
 b=TpyYdp4R8dsw7d+iMQRd0V5JWo7j2YJktbtP1Wi5LT+SUt0KOkIocQjktI6pvBhzaKMlqxPY/Q20zxsJguMCdRIO/Twpg/R+SHBQjKGxNmTxGAKTgj3YWxaPhjrEkS/qyzxw/9IqNOfmFiXuyLUfz2Mtwe+AM7N3qm33JiLKo8TRIAGj5sQMxLgUA4jR5BikjcbU8/HQd8kdFjL8NXXyXTwk7Y1+Ap//SymIHyjXmG8BB34by9aUJ66ADIAAjKOOgQpVHADjPk0rUcWSQ7b2mSG/fmOp3yuzzP6ufZRW5ZlecBJ41VohhocWhFOaysaD+TfrEZvhDBy8kjoeQ7EuJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUxrHRkRHtiSXs9oLgFsWXLi92nE+/qHe5cH82P8JQQ=;
 b=bs2ago4MJrj/DFDbjNmv1tZ/LnpQUKLYPiWpVpA/Kg5meBNLFiqX8rIynfHDSm/ywsiqkZxSBZhkZC9iA8EXrpi3nMJAaC9dXmOSRuqk1cUQNpO6UMIGDSQ+PkCFN05y5QXVTepkxdNyIzZpyrtLPYHA+pua0FCScyqdNyEjG4M=
Received: from BN8PR15MB3025.namprd15.prod.outlook.com (20.178.219.157) by
 BN8PR15MB3059.namprd15.prod.outlook.com (20.178.220.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.14; Mon, 9 Sep 2019 15:52:58 +0000
Received: from BN8PR15MB3025.namprd15.prod.outlook.com
 ([fe80::e8c3:511d:a644:8789]) by BN8PR15MB3025.namprd15.prod.outlook.com
 ([fe80::e8c3:511d:a644:8789%7]) with mapi id 15.20.2241.018; Mon, 9 Sep 2019
 15:52:58 +0000
From:   Douglas Graham <douglas.graham@ericsson.com>
To:     Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: O_NONBLOCK: should I blame git or ssh?
Thread-Topic: O_NONBLOCK: should I blame git or ssh?
Thread-Index: AdVl0BxXRbD448LvQ7CYoSk6Z4FLzQAYBIIAAD2Cl4A=
Date:   Mon, 9 Sep 2019 15:52:57 +0000
Message-ID: <BN8PR15MB302506328B68B266FD0835F8F0B70@BN8PR15MB3025.namprd15.prod.outlook.com>
References: <BN8PR15MB302515278334F3BD7B63D519F0B50@BN8PR15MB3025.namprd15.prod.outlook.com>
 <20190908102839.GC15641@sigill.intra.peff.net>
In-Reply-To: <20190908102839.GC15641@sigill.intra.peff.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=douglas.graham@ericsson.com; 
x-originating-ip: [192.75.88.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a931d41c-2869-4e42-c8bc-08d7353dc925
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN8PR15MB3059;
x-ms-traffictypediagnostic: BN8PR15MB3059:
x-microsoft-antispam-prvs: <BN8PR15MB30595AF344DBF0E0C83BC1A7F0B70@BN8PR15MB3059.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01559F388D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(189003)(199004)(86362001)(2906002)(476003)(25786009)(5660300002)(4744005)(186003)(53936002)(446003)(7696005)(7736002)(71200400001)(66946007)(66476007)(66556008)(64756008)(66446008)(44832011)(11346002)(26005)(3846002)(478600001)(71190400001)(76116006)(99286004)(256004)(102836004)(55016002)(9686003)(6916009)(76176011)(229853002)(74316002)(486006)(6116002)(66066001)(6506007)(305945005)(6436002)(8676002)(52536014)(33656002)(4326008)(6246003)(81156014)(81166006)(8936002)(14454004)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR15MB3059;H:BN8PR15MB3025.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ericsson.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7XDs8oBfU1FQhAZgihE0ayK76BqzJ7Y53r8QXQWn4ZSu9PrZQbHeKueiLtCYCnQ8cn0UGIYLbKo3+1ih9WLU0J0/EJAtx1ltLPOIApkiw7xpS14wwo95eQNkUVX/nDENCh/4CYQumzVKmXpOIX9yWSasi2c3cnBAJWV/8yUpr5JixGGju7mhX+HJrr5q1+ZCvw98bVoRygj8O9BZUCzV8nBNbzDqcghqN7zJimiT9L6mOp5tYPXgQ7NFlKZkSrtyhWZ9gKtB1CfgpBiFmydnJSm7hfVTqaAdw5j4dyGjmOggdqOjVbCQVaP8ZEgTFxOks1PwZ9bUV3FLrflGElIs/0iAv9tY7Jow71loZuB+gvkQl211XyPYzuLyw5ER2Jw2iwy9u6t4FIS/evlg6clPUl1/cxyQxmGRMII4maxMMJo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a931d41c-2869-4e42-c8bc-08d7353dc925
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2019 15:52:57.8779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gBDJwE+J4ffvQF7IMDjJgQ1UbMCZ5IvM4OUbRWIfA7Lz565HSN1xq1AUDijgaMrUJsckONr9sGm6c9fYGUFssuNgLjb2PwJp5lG+f1jgGlc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3059
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SSB0aGluayBJJ3ZlIGp1c3QgZmlndXJlZCBvdXQgd2h5IG15IHdvcmthcm91bmQgd29ya3MuICBX
aGVuIHNzaCBzZXRzIE9fTk9OQkxPQ0sNCm9uIHN0ZG91dCwgaXQncyBzZXR0aW5nIGl0IG9uIHRo
ZSB3cml0ZSBzaWRlIG9mIHRoZSBwaXBlIHRoYXQgZ2l0IGNyZWF0ZWQuICBOb3RoaW5nDQplbHNl
IHdyaXRlcyB0byB0aGF0IHBpcGUsIHNvIHRoaXMgZG9lcyBub3QgY2F1c2UgYSBwcm9ibGVtLiAg
UHJlc3VtYWJseSwgc3NoIGl0c2VsZg0KaXMgYWJsZSB0byBkZWFsIHdpdGggd3JpdGluZyB0byBh
IG5vbi1ibG9ja2luZyAiZmlsZSBkZXNjcmlwdGlvbiIuIFdoZW4gc3NoIHNldHMNCk9fTk9OQkxP
Q0sgb24gc3RkZXJyLCBpdCdzIHNldHRpbmcgaXQgb24gdGhlIHBpcGUgY3JlYXRlZCBieSBKZW5r
aW5zLiAgQnV0IHRoYXQncw0KdGhlIHNhbWUgcGlwZSB0aGF0IG15IHdvcmthcm91bmQgcHJvZ3Jh
bSBkb2VzIHRoZSBzZWxlY3QoKSBvbiwgc28gbXkgd29ya2Fyb3VuZA0KY2FuIGNvbXBlbnNhdGUu
IFdoZW4gSSBydW4gIm1ha2UgfCB3b3JrYXJvdW5kIiwgdGhlIHdyaXRlIHNpZGUgb2YgKnRoYXQq
IHBpcGUgaXMNCm5ldmVyIG1hZGUgbm9uLWJsb2NraW5nLCBhbmQgdGhhdCdzIHRoZSBvbmUgdGhh
dCBtYWtlIGl0c2VsZiB3cml0ZXMgdG8uDQoNCk9rLCBJIHRoaW5rIGFsbCBteXN0ZXJpZXMgYXJl
IHNvbHZlZCwgYnV0IEknbSBzdGlsbCBub3Qgc3VyZSB3aGF0IHRoZSBtb3JhbCBvZg0KdGhlIHN0
b3J5IGlzLiBUaGlzIHNlZW1zIGxpa2UgaXQgY291bGQgbGVhZCB0byBzb21lIHJlYWxseSBkaWZm
aWN1bHQgdG8gZGVidWcNCnByb2JsZW1zLCBidXQgaXQncyBub3QgY2xlYXIgdG8gbWUgd2hhdCB0
aGUgcmlnaHQgbG9uZy10ZXJtIGZpeCBzaG91bGQgYmUuIEZvcg0Kbm93LCB3ZSdsbCBqdXN0IGxl
YXZlIG91ciB3b3JrYXJvdW5kIGluIHBsYWNlIGFuZCB0aGluayBhYm91dCB0d2Vha2luZyBvdXIN
Cm1ha2VmaWxlIHRvIHJlZGlyZWN0IGdpdCdzIHN0ZGVyci4NCg0K
