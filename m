Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 030E71F461
	for <e@80x24.org>; Sat,  7 Sep 2019 23:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbfIGXus (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 19:50:48 -0400
Received: from mail-eopbgr710059.outbound.protection.outlook.com ([40.107.71.59]:29152
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728575AbfIGXur (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 19:50:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSwWmugox6h8I0jlLV8foz5LN/IOnanzAPvRTywaZziqhR2UrxruOGsD4VuvjaViPuQe3JayvPRVD9DQV6bdmVeLSzBa0IRxfe4C9mciazZg0c8BpmnJ6LM0R6J4BgeWGDY1e1tTs/fCyXFcT7MfoB7KeRvzDXzTrqICWdYU4r0cBCJQ0Ev2qF1JXHOeEQygmC1OAopK/AckR3IOiiKjNtCFUQBdpsEoD3IRjuxdJ2f1ZKTVb2d/yRNkojEdd/tiuChjQ/ZpMDkFK4elpBjCpnW6N5iIZeiy+ZH4Wa9YG2oO1YuatYb3sfVH8KMI98zJ+i1z2L+I4wV6xyf10YwWbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etnpBsJmru2NbT8W5LuGMBz3nrEKUdBU0A70tsUZlqU=;
 b=bjZsjSneRCLBkswMkpz4x0OuhcWOfPp5isi5hcRD/BlhVRF6LK2MMnBGWHhRBikc+ZiFlCpQ00Y80o2HpfUspuwlP82D4FjzvLD1EOTyxtOf2QDsS4Z6V+0B/KXbLnLQ/zd49Ks2z9EGDvU1MgIYU0NDHfgHSGFzedzUuXTRiPDrPt/fk6zqnXPHI6DInO7dyXM73vvuZCNixGyHr5DTA+DgBx7NT2X6a0NiG/wOHwgHsxk3IF6y2ViZPoq5eb9jFv7qwf5MVwAL0bIwvnQFBcKv668j3628tSrA4q4X+l55BLThd/WLklkTIH9UuIjLnaI7MtinILHkJvfqbJP7aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etnpBsJmru2NbT8W5LuGMBz3nrEKUdBU0A70tsUZlqU=;
 b=ZzP8MvvNMq/Yh1BXrxH64iIFOJhL7wyk7XZ0oZYeoW77CY+1PD62wPEYVzVQPp43mUUKSeSlBHpgo5VQNrF1zKxm0Jxs6kwsup94M+d2u8wE5RfFEsth3dWaiMMWoJZHBEZC43HiiARXASmA00c1ERA1YVJUOgdfthuQMahlkgU=
Received: from BN8PR15MB3025.namprd15.prod.outlook.com (20.178.219.157) by
 BN8PR15MB3252.namprd15.prod.outlook.com (20.179.74.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Sat, 7 Sep 2019 23:50:42 +0000
Received: from BN8PR15MB3025.namprd15.prod.outlook.com
 ([fe80::e8c3:511d:a644:8789]) by BN8PR15MB3025.namprd15.prod.outlook.com
 ([fe80::e8c3:511d:a644:8789%7]) with mapi id 15.20.2241.018; Sat, 7 Sep 2019
 23:50:42 +0000
From:   Douglas Graham <douglas.graham@ericsson.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: O_NONBLOCK: should I blame git or ssh?
Thread-Topic: O_NONBLOCK: should I blame git or ssh?
Thread-Index: AdVl0BxXRbD448LvQ7CYoSk6Z4FLzQ==
Date:   Sat, 7 Sep 2019 23:50:41 +0000
Message-ID: <BN8PR15MB302515278334F3BD7B63D519F0B50@BN8PR15MB3025.namprd15.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=douglas.graham@ericsson.com; 
x-originating-ip: [142.112.214.127]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4da87901-1b03-47af-c80c-08d733ee3164
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN8PR15MB3252;
x-ms-traffictypediagnostic: BN8PR15MB3252:
x-microsoft-antispam-prvs: <BN8PR15MB3252B56C60778878B29D33F5F0B50@BN8PR15MB3252.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0153A8321A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(199004)(189003)(316002)(71190400001)(26005)(25786009)(7696005)(6916009)(44832011)(186003)(99286004)(486006)(6436002)(66066001)(476003)(71200400001)(6116002)(74316002)(3846002)(2906002)(86362001)(102836004)(478600001)(2351001)(33656002)(2501003)(52536014)(5660300002)(8676002)(8936002)(81166006)(1730700003)(81156014)(305945005)(256004)(9686003)(5640700003)(55016002)(7736002)(53936002)(66556008)(66946007)(6506007)(66476007)(64756008)(66446008)(14454004)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR15MB3252;H:BN8PR15MB3025.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ericsson.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lezC9bljBx7jSS8g1/F/8xiloG+LiScJW+4kozfk1Zm7pSJBa8GnuMfca0eXeI1b4FE3q6E9Vl4u7eBYx8/oScdU2XDFpGFND+tFcVWVtbSW3lUMkB2pv6B5ZAIUc+ekWJokubFxzZhzt9BkPTdSGu9EAcqKYZKvBAQkwpSow2WuiYs3XcrqyoLjWoSydQEivsg1FVVJ44tquCO1CNyiyLmF/27DZQWlDcsV2AY7X9VtBHS+ds0uEIp6SWC/wpcSFoBaJXD6lYjHecDJ3L/7QMpVxu67vTQwxUYPGqNDcZa/gwSjAOtxHAJiuRdHcxC7o9AQgmd05ApqqVWOXy9znK0ENAyVm1nqk2TKdebsEZJ7pM6vKNJ3kZtlkwrKq6t4P30FxmimP0ZzrKy1owb9ni75rHCjJelLLf+g0LejYhc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da87901-1b03-47af-c80c-08d733ee3164
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2019 23:50:41.8966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bwzmJLDfbnHdGM9DeUaCpeyQO31Y063PcpMHFlX6xOnm0PE40Ee+M7dxg2LArshXGQznR6tZ3UU8/jAOPXus04BXLlDjbE0HfZJfu4h78Jc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3252
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have a parallel build that occasionally fails with the error message
"make: write error".  Make prints that error message as it is exiting when
it detects that it has seen errors while writing to stdout.  The error it
is enountering is an EAGAIN error, which implies that something has made
its stdout non-blocking.  As far as I've been able to tell so far, this is
occurring while make is running the command "git fetch --quiet --tags".
Once that command finishes, stdout goes back to being blocking but since
this is a parallel build, make is doing other work while this git command
is running, and may attempt to write to stdout during that time.

By stracing this git command, I can see it running subcommand

ssh -p 29418 user@gerrit.domain "git-upload-pack '/repo'"

and I can see that ssh command doing this:

39828 dup(0)                            =3D 5
39828 dup(1)                            =3D 6
39828 dup(2)                            =3D 7
39828 ioctl(5, TCGETS, 0x7ffea2880800)  =3D -1 ENOTTY (Inappropriate ioctl =
for device)
39828 fcntl(5, F_GETFL)                 =3D 0 (flags O_RDONLY)
39828 fcntl(5, F_SETFL, O_RDONLY|O_NONBLOCK) =3D 0
39828 ioctl(6, TCGETS, 0x7ffea2880800)  =3D -1 ENOTTY (Inappropriate ioctl =
for device)
39828 fcntl(6, F_GETFL)                 =3D 0x1 (flags O_WRONLY)
39828 fcntl(6, F_SETFL, O_WRONLY|O_NONBLOCK) =3D 0
39828 ioctl(7, TCGETS, {B38400 opost isig icanon echo ...}) =3D 0
39828 fcntl(5, F_SETFD, FD_CLOEXEC)     =3D 0
39828 fcntl(6, F_SETFD, FD_CLOEXEC)     =3D 0
39828 fcntl(7, F_SETFD, FD_CLOEXEC)     =3D 0
...
39828 ioctl(0, TCGETS, 0x7ffea28806e0)  =3D -1 ENOTTY (Inappropriate ioctl =
for device)
39828 fcntl(0, F_GETFL)                 =3D 0x800 (flags O_RDONLY|O_NONBLOC=
K)
39828 fcntl(0, F_SETFL, O_RDONLY)       =3D 0
39828 ioctl(1, TCGETS, 0x7ffea28806e0)  =3D -1 ENOTTY (Inappropriate ioctl =
for device)
39828 fcntl(1, F_GETFL)                 =3D 0x801 (flags O_WRONLY|O_NONBLOC=
K)
39828 fcntl(1, F_SETFL, O_WRONLY)       =3D 0
39828 ioctl(2, TCGETS, {B38400 opost isig icanon echo ...}) =3D 0

So ssh has dup'd descriptors 0, 1, and 2, and then turned on the O_NONBLOCK=
 flag on
the copies of stdin and stdout.  You can see afterwards that ssh reads the =
flags on
descriptors 0 and 1, and both have O_NONBLOCK set.  It then clears that bit=
.  It set O_NONBLOCK
near the beginning of its runs an cleared it near the end.

Should this be considered a git bug or an ssh bug or something else?

I thought I had finally figured out exactly what is happening but while wri=
ting this,
now I'm not sure why my workaround appears to be working.  My workaround is=
 to pipe
make's stdout into a simple program that reads make's output and writes it =
to where
make uses to write to, except it does a select() on descriptor 1 before wri=
ting, and
it makes sure to handle short counts.  But now I'm thinking that if it's th=
e ssh started
indirectly by make that is messing with O_NONBLOCK, presumably it would be =
messing
with O_NONBLOCK on the write side of the pipe that make writes to, so make =
should
still be encountering EAGAIN errors. And yet my workaround does seem to wor=
k.

Thanks for any light you can shed on this.

