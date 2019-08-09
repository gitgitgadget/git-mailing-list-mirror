Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D16311F731
	for <e@80x24.org>; Fri,  9 Aug 2019 22:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfHIWQn (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 18:16:43 -0400
Received: from mail-eopbgr710134.outbound.protection.outlook.com ([40.107.71.134]:6212
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726078AbfHIWQn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 18:16:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPPi1FjENop/aMXA1/9H/zSUYu5DVUJkzaN5ejFGiN7zIX0MLflSqIokN/3p+fj/zZUWAMv2x/eqCyuYgon39h2bnGWf6S/sIroJH/Pe7EpAhFjuVJLjrxSYOjPJpo6iCX9MUHpPULe4EXAQ5RqemzuWit/x+Xjc0jLWevDOseB8utG0nqLG0FjsAmtBwd4At4q7oMca+GTx7Sug7uJY1w1BAtY04tegkPg8sgHrmo5xVWhYTuQcBz3EHYxE1UC/IdbxBLfSikmbg8HnSLQYKt2LOrNfwgGHIsOJFAr1cLA62I7gjkok4//pQwKvdJDwuOLaRVkzgnVHwKj0PysoZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpnhOxm340nwz+6Q/6bcLqJyKTQ6ChCvaVUl9cQMOk8=;
 b=VoA9oju0ujLjUgeK5BZ8PHJZ8y6lNeBuQlMyZDIJAAAv+iVPW3PTJTaRKIZMMGsHPmamudOTpWhxkBGufRivhQqccGwad5Yelx2X8QwdBvX17ozmYHnDgIcP5iEcWQE45NrJGSPcwLJSfbIvZxjwnz7O0vz9RPCNlZd7ERN6QcOfBO8nnyTwTyblkuDwirX6uxdHjhECJiU40QUK9a+6rIKADKO1jwOxLe1+oyBBx3yrOfY16kJNQqv9XrgXBM6LMl7XReDA4fVwUR+ULDKlYGiGe/AQD5YDWim8YDPGakRd4GQyWKtE2Nl+Rco9y1eId6ZUf/Dql+IKzaDuWxQAlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpnhOxm340nwz+6Q/6bcLqJyKTQ6ChCvaVUl9cQMOk8=;
 b=HD1YE/XVlk9hw+UkOsGdqExIRNGPwTMrfjz3fwm6cs+tLjZbsh9nx7flp0noAo/a0zI/+yvg/IyZ6i9Gn2ZXSbZpd2RmvL/cBLK+PZ4xGy1aFwi2PBUx4TcwgCUR84WEr5cmozWqVC/UGq6rLVfd9htrzMVYD4aWbZ4zzFXOKNc=
Received: from BN8PR21MB1156.namprd21.prod.outlook.com (20.179.72.203) by
 BN8PR21MB1138.namprd21.prod.outlook.com (20.179.72.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.8; Fri, 9 Aug 2019 22:16:41 +0000
Received: from BN8PR21MB1156.namprd21.prod.outlook.com
 ([fe80::b896:fe09:31ae:e9a4]) by BN8PR21MB1156.namprd21.prod.outlook.com
 ([fe80::b896:fe09:31ae:e9a4%9]) with mapi id 15.20.2157.001; Fri, 9 Aug 2019
 22:16:41 +0000
From:   Cliff Schomburg <clisc@microsoft.com>
To:     "gitster@pobox.com" <gitster@pobox.com>
CC:     =?iso-8859-1?Q?SZEDER_G=E1bor?= <szeder.dev@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: "git log" does not display refs info when executed via C# Process
 class on Windows
Thread-Topic: "git log" does not display refs info when executed via C#
 Process class on Windows
Thread-Index: AdVO6XCnSWdcLXyxQQWtA59IuPRg6AAAkKqAAAOOazAAAJ5efgAA6vuw
Date:   Fri, 9 Aug 2019 22:16:40 +0000
Message-ID: <BN8PR21MB11560DB6FA18D85672CFE8FEB7D60@BN8PR21MB1156.namprd21.prod.outlook.com>
References: <BN8PR21MB11569DAA8A677BF00113F683B7D60@BN8PR21MB1156.namprd21.prod.outlook.com>
        <20190809195031.GK20404@szeder.dev>
        <BN8PR21MB11566C135B1326AF1B45E4D8B7D60@BN8PR21MB1156.namprd21.prod.outlook.com>
 <xmqqblwyc8l8.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqblwyc8l8.fsf@gitster-ct.c.googlers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=clisc@microsoft.com; 
x-originating-ip: [24.182.67.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26fdca17-7656-4e04-dcb2-08d71d174131
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600158)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN8PR21MB1138;
x-ms-traffictypediagnostic: BN8PR21MB1138:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BN8PR21MB113857A39175E7560996A9CFB7D60@BN8PR21MB1138.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(13464003)(189003)(199004)(316002)(76116006)(66946007)(4744005)(102836004)(22452003)(66446008)(66556008)(66476007)(53546011)(2501003)(54906003)(64756008)(6506007)(9686003)(8676002)(99286004)(26005)(55016002)(10290500003)(186003)(81166006)(81156014)(1730700003)(229853002)(10090500001)(52536014)(66066001)(478600001)(7696005)(76176011)(66574012)(71190400001)(33656002)(71200400001)(2351001)(8936002)(6246003)(5660300002)(86362001)(25786009)(6916009)(53936002)(486006)(6436002)(476003)(11346002)(8990500004)(305945005)(446003)(7736002)(14454004)(256004)(6116002)(4326008)(3846002)(74316002)(2906002)(5640700003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1138;H:BN8PR21MB1156.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Umimq4rk5sTTlcjcmJInPQSYaoYN10NKekeF0nlgJ+fGOjK6GsAZUQlxo633DsnqYQ2IZOVvHMArsSYxzxRbJ3s0LiZ2webu2wALpxvW1bPVy9EJV25RQFczyhlzl2Y94FUFgqUjOIN/oQAXMy8z7aXoHlMuULPzb+tUxQjq2wpvoXeJiMKOgNzPjQK+aYnTCNFKl/8Byo5IcOnxKQNc8H0fd9KRwCv7MCsdvz+lkUTUnDs7htBdHUeZdNqkGK+QmOViStUAXJwyRzw0S6yPDdiGi3K9cAV4N7uf7VK4r+HQKCjHsOuNvyS9+WnYJNICZs4TfjvsZsxPfENM3I2o6vpgHVF4+taPykD5WQzX/jagCFhgBJp9TuNtbVyThBJbl/vHpGBHjzbPKWYCimJA/fvRSeyIIlVXB0wNlDyWQ2Q=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26fdca17-7656-4e04-dcb2-08d71d174131
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 22:16:40.9725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1s3kDNlJG+mmLiBPKMhmVACl83JktmX2rHgEe8qx2a+HFQhFVpt3gLCyIiL53OJ4BdT4qUwPoxN4UY5A2Vax2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1138
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, I will try that as well.  Strange it works on command line but not =
STDOUT though.

-----Original Message-----
From: Junio C Hamano <gitster@pobox.com>=20
Sent: Friday, August 9, 2019 5:50 PM
To: Cliff Schomburg <clisc@microsoft.com>
Cc: SZEDER G=E1bor <szeder.dev@gmail.com>; git@vger.kernel.org
Subject: Re: "git log" does not display refs info when executed via C# Proc=
ess class on Windows

Cliff Schomburg <clisc@microsoft.com> writes:

> Strangely, when I run this command:
>
> Git log origin/master --pretty=3Doneline --decorate -1
>
> I get the format I want from STDOUT.  However, when I try to filter it to=
 show only the tag refs:
>
> Git log origin/master --pretty=3Doneline --decorate=20
> --decorate-refs=3D^tag* -1
>
> No refs are returned to standard output again.  Only on the command line.
>
> Does --decorate-refs not return to STDOUT?

If you are asking for tags, which does not begin with a caret "^", perhaps =
drop "^" from the pattern?

The pattern is supposed to be wildmatch pattern, so it is already left anch=
ored, e.g. --decorate-refs=3Dag* won't find any tag.


