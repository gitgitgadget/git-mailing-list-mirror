Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 034D41F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 16:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502122AbfJQQRf (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 12:17:35 -0400
Received: from spfnldca1.capgemini.com ([80.253.212.196]:30527 "EHLO
        SPFNLDCA1.capgemini.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2501902AbfJQQRe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 12:17:34 -0400
X-Greylist: delayed 1803 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Oct 2019 12:17:32 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=capgemini.com; i=@capgemini.com; q=dns/txt; s=group2;
  t=1571329052; x=1602865052;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FhPgqZCpxABzAlKdDB5u9sxij7Sx19MCDaHoVsUg8hU=;
  b=LHFbCWwuXqampCUBj749kaRbmZETAUWJ+8noCI/UDwzo4pJ4jTs4xv5i
   5Lfd8Izim/E/88GKkzvvK0WtyD7NakQyzG/OyXlrV2Nq5xk7pruvZROGA
   p/rxa46t2Sn8QWgxZm89kVVzZc90i6qrRWYZohkhJCVewI68AEBYSYZXX
   0=;
IronPort-SDR: 3RLSP7VD+j7nn3NfsPsSgxLwjEj/px0fNVJutu8CDKdWu3kKhDVb6j5e1ERJXGbS+g2echgRrx
 +Ci6FwpdRbmA==
X-IronPort-AV: E=Sophos;i="5.67,308,1566856800"; 
   d="scan'208";a="171626026"
Received: from gddlppraplv02p.corp.capgemini.com ([10.247.137.137])
  by IRNLDCA-C690-01-D2-incoming.capgemini.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2019 17:47:26 +0200
Received: from gddlppraplv02p.corp.capgemini.com (gddlppraplv02p.corp.capgemini.com [127.0.0.1])
        by gddlppraplv02p.corp.capgemini.com (Service) with ESMTP id 1FF1E203B0A5
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 17:47:26 +0200 (CEST)
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (unknown [104.47.10.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by gddlppraplv02p.corp.capgemini.com (Service) with ESMTPS id E9B8A2006A04
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 17:47:25 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmIkJi0sBIEIBOGO8NG3N+t98QtfQ5Y7hSN5KM5gfyO+ITVoX9e05r8ESsS3IQ59LbkAcM6pl7EDsBj5vyCDweXz28k4zLJD5R87hL/+xicTIp8995pfKyG5CzMLMKO1FKzRyeyvDAlEmHW+OK/QUhznpUKjNUlJm6Q5/BbEoZJGw1rZ1QcsXgU4+ZIrfWeG7zByAmvZmkDXxzYPHv0dbCL8d2zf8ei8EQWcADBfH9PmV811N0cOcKVMyJ350j+aM4/ZeryCBew5F9Hx01iZw78rfCWaXTv1XT7Qm7JfJ2X7BPziNhN4JpdF3nZdz4EZiwaVmTyeZhZnv10GmRIkUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qi+TwAEiBQT0of6kI6hSoBRDpKEzm0/ySyTcN2fNY8o=;
 b=Im9fruODcmmgLKLhaprwVRmNzase4xDiDLNQ61LsXjCczSf1c86WMamSYiiaFnQ7Fpz7dXqEbtUEML9dX7xmpfqnBp7zrxfAmJcfDUxp9Q0QKwKa6eiugniigr/HKlahsawTK9Xxj4OErtHmYzZ7K+G9GGK63A4iJqRud+BVWLdm+UaXWaDnRnz0SBq+LbHteA5HXUm0h5qCCSI2XWcyWsyw8Y/+KQIr8dm1J8ZL6QyLgT3obx1lQ3JT0xHBMlGmF8s8PBGv2N+iGLNwe8GD6FT1HGsuyHddd2wjUi5ptmEG2faQ6RBNVjgbDCMRW2Eo54XNTH4byi3W0pForGh2ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=capgemini.com; dmarc=pass action=none
 header.from=capgemini.com; dkim=pass header.d=capgemini.com; arc=none
Received: from DB8PR02MB5531.eurprd02.prod.outlook.com (20.179.15.210) by
 DB8PR02MB5465.eurprd02.prod.outlook.com (10.255.16.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.22; Thu, 17 Oct 2019 15:47:25 +0000
Received: from DB8PR02MB5531.eurprd02.prod.outlook.com
 ([fe80::a435:e1b4:49e5:dd15]) by DB8PR02MB5531.eurprd02.prod.outlook.com
 ([fe80::a435:e1b4:49e5:dd15%7]) with mapi id 15.20.2347.024; Thu, 17 Oct 2019
 15:47:25 +0000
From:   "GOSSENT, Kevin" <kevin.gossent@capgemini.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: feature request on git-merge-recursive
Thread-Topic: feature request on git-merge-recursive
Thread-Index: AQHVhQHzHqJTG2iuU0mHEjIGUtWUUA==
Date:   Thu, 17 Oct 2019 15:47:25 +0000
Message-ID:  <DB8PR02MB5531685CAC9ABF2D5B01B436E06D0@DB8PR02MB5531.eurprd02.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kevin.gossent@capgemini.com; 
x-originating-ip: [192.196.142.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2523a416-1179-4e63-5a2a-08d753194e85
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DB8PR02MB5465:
x-microsoft-antispam-prvs:  <DB8PR02MB54654F242880CEC9134009F2E06D0@DB8PR02MB5465.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report:  SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(136003)(346002)(189003)(199004)(6916009)(71190400001)(102836004)(2501003)(7696005)(6506007)(66066001)(99286004)(3846002)(52536014)(6116002)(316002)(2906002)(25786009)(71200400001)(74316002)(81166006)(2351001)(1730700003)(8936002)(86362001)(81156014)(478600001)(55016002)(9686003)(305945005)(7736002)(5640700003)(486006)(14454004)(476003)(5660300002)(26005)(186003)(66446008)(66476007)(66556008)(64756008)(14444005)(6436002)(256004)(76116006)(66946007)(33656002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB8PR02MB5465;H:DB8PR02MB5531.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  UhKH7qus5B3CFHnDmuHuzVOIveoGrqFlBhUpCtDV0n3UA5DJdsyPrQMs/ao/RZ4NyiB7FqedRBEUQKVLMSr6qT/vdWTaVEs0sG2yGbnuDQDDZpE6Jf4CSWJ4FLNWQerUgYo3zMP0B56cuZcOaclRKfPTz3iLRv/93Y3DRX/3+9zxbzuz4zdPq13KYfXv05mWotUUGgtVszCq1KTNg7y/1Me0Y/VWae911Uz6RESCr414lfIUjJ7cne1NczoSZYqRh+EFIH9gYDgvaxkcVIq8+Bo3u1OBLZkkbjDwun+c227Ed39kh9iXTuLp6zMHieqTNGN7mYIgqhNVFTPGe0eCV3ZgM9D2271n4e+8wFsAGoNhKS+NVBlMcFyZybmtbwFZLPO6GPRkv0ioxxIBx65XYZ15GVwCQXPHyw53SDXa3Ak=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
X-OriginatorOrg: capgemini.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2523a416-1179-4e63-5a2a-08d753194e85
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 15:47:25.2634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 76a2ae5a-9f00-4f6b-95ed-5d33d77c4d61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FFOVuSp9dyPo3DgNJNCxlRC5r5s5lpoxbbBgxwo2RDRRUsJ0A8okSHCXkubUiMWAOqkA0RhNITBvEijWAn/NnlnekVC0ZtkP98AnuTqXmRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5465
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've seen recently some development with a special development flow that is=
 the source of my feature request.
Description of the feature:
For each treated file, in case of an empty ancestor (file created on both b=
ranches or orphan branch), I found that usually the best way to help (or ev=
en do) the merge is to override the empty ancestor/base by the most recent =
between the oldest creation of the file of each branch.
It could be:
- an improvement of recursive strategy
- new strategy that would be recursive with the special empty ancestor case
- a new option for recursive strategy indicating how to treat empty ancestor

exemple: orphan branch1 created 2 weeks ago, develop branch existing since =
years. File a.txt created 2 years ago on develop but only 2 weeks ago on br=
anch1. In such case, it's very likely that it has been created from a "git =
checkout develop -- a.txt" command. So taking that creation as the ancestor=
 will propose a very good ancestor to look for possible merge process

That's some things I've seen on projects that for some reason want to have =
only the minimum of files on each feature branch.
It can happen usually when what's inside git (the source code) is not actua=
lly code that can be built but metadata describing the configuration of a p=
roduct that's used to deploy the parameters.

Thanks for reading this request.


Kevin GOSSENT
This message contains information that may be privileged or confidential an=
d is the property of the Capgemini Group. It is intended only for the perso=
n to whom it is addressed. If you are not the intended recipient, you are n=
ot authorized to read, print, retain, copy, disseminate, distribute, or use=
 this message or any part thereof. If you receive this message in error, pl=
ease notify the sender immediately and delete all copies of this message.

