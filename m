Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3789820281
	for <e@80x24.org>; Fri, 29 Sep 2017 12:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750936AbdI2MHv (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 08:07:51 -0400
Received: from mail-bn3nam01on0107.outbound.protection.outlook.com ([104.47.33.107]:2817
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750715AbdI2MHu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 08:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=SR2FZYq45NT/TEdhsZ0ihXkN7TyWu/k4oPgsx8FGdUk=;
 b=YgZsDB1AZlKlf0quX+ZkDjOYmj3SFuXcEfMGjVhnsp/0A0hXDtFdK38IUz/w97PEG9A7YmxBcFfd9q+Os9S0Sxcy4wcT3zatZakCZWDOw8WN1pBuwnHfdPQGHbDQfR77VxUr1UUooFhPD+JCIlxEdvW8XqGwSSz5hEpr9EF42q8=
Received: from MWHPR21MB0478.namprd21.prod.outlook.com (10.172.102.17) by
 MWHPR21MB0158.namprd21.prod.outlook.com (10.173.52.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.98.3; Fri, 29 Sep 2017 12:07:46 +0000
Received: from MWHPR21MB0478.namprd21.prod.outlook.com ([10.172.102.17]) by
 MWHPR21MB0478.namprd21.prod.outlook.com ([10.172.102.17]) with mapi id
 15.20.0098.003; Fri, 29 Sep 2017 12:07:46 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "David.Turner@twosigma.com" <David.Turner@twosigma.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "peff@peff.net" <peff@peff.net>
Subject: RE: [PATCH v8 00/12] Fast git status via a file system watcher
Thread-Topic: [PATCH v8 00/12] Fast git status via a file system watcher
Thread-Index: AQHTM8Dllik8YVfqyEeff/QqQ+RjwaLLK5aHgACjaVA=
Date:   Fri, 29 Sep 2017 12:07:46 +0000
Message-ID: <MWHPR21MB0478B8D1C5442B2FCE1ED465F47E0@MWHPR21MB0478.namprd21.prod.outlook.com>
References: <20170919192744.19224-1-benpeart@microsoft.com>
        <20170922163548.11288-1-benpeart@microsoft.com>
 <xmqq7ewiz1mz.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqq7ewiz1mz.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Ref=https://api.informationprotection.azure.com/api/72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=benpeart@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2017-09-29T08:07:45.4725569-04:00;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [65.222.173.206]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR21MB0158;6:9Aqd6jWYGT//ND3WsedOZAOcG9jIpM4uyJemGBhJzZ9WXdaAzb7Sn7x5eGOGfGJsZkCOdniojJhC/h0QWh0LNbMdAiP51NhmqYw5qEiHgNU/R1RKJHZ9V0uQake36jPruMStZK3ugGJIHOzHvns5kSzUcV9EvYBR6CCbIOjkjG8QHgwIdnbP7idGgUzGybU9FJaQKKXykfW/Fr4z7vDn3DavqE0YfoUz++pGx+cfJDfCy18LIdEnX1ig/5CJM0k3H9XQtr7wIjCFX/+XRNNhHHqSqiyUTvZupVA53H9xRib3vZWiilRABBgt+OeqoukZmn0hZj0UFJ/BwFJv5vP0Mg==;5:+GYhvxhOzrW/EJO4D23uN8hbQho43jMWKz1qN/lOmlb91rh0owt+InWlTlrLbXQfrEQ14BU/Myd7XOEk1IP6c83U1shbIibaUoBNoGWotXhYDLxEURbY4EufQinRnfVjdhrsXrKl6H93X2clOYHL3A==;24:1Ke/9TE5fV34KFdkCZ+SR+CpcJ3rtJUjDTvY/pFscbsp3HolKLQfD+zqRjd3baIG+9SEg9DgmgVaGXAnC2JC5QwiHJXKgf5m8XfxtKisDkg=;7:7JrHgHRMDhWkoM3KoKgpSAeQdzK72qBZODAugUHl5WJwki17VQCa9r3QtigVbTgCVqvEUTfZZ1a0WIsSP0NrJqizItduQSpZpArWppxUc/tmObz4uF3QkRF6O1z/cpZDSd3224YuvYA7Z2R6vrMWcP1iLbSD1U1Lbp3IGxMSefGuRsYR/amg6zRxbF7zw9MZQW64NyfTyr/Ud9DcMUjFSIvJ8DsWEwIIJJbh8sBYQVI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3f8efb10-59ed-41f3-7f12-08d50732b254
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:MWHPR21MB0158;
x-ms-traffictypediagnostic: MWHPR21MB0158:
x-exchange-antispam-report-test: UriScan:(26323138287068)(89211679590171)(9452136761055)(100324003535756);
x-microsoft-antispam-prvs: <MWHPR21MB0158710EEAC00E0BA5B0AF0EF47E0@MWHPR21MB0158.namprd21.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(10201501046)(3002001)(93006095)(93001095)(12181511122)(6055026)(61426038)(61427038)(6041248)(20161123558100)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123564025)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR21MB0158;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR21MB0158;
x-forefront-prvs: 0445A82F82
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(346002)(39860400002)(376002)(47760400005)(189002)(199003)(377454003)(13464003)(316002)(305945005)(3280700002)(66066001)(14454004)(3846002)(39060400002)(97736004)(7736002)(8656003)(105586002)(10090500001)(68736007)(5660300001)(4326008)(2906002)(7696004)(74316002)(2900100001)(54906003)(8666007)(189998001)(77096006)(6506006)(55016002)(99286003)(101416001)(6916009)(10290500003)(54356999)(2950100002)(76176999)(478600001)(50986999)(6436002)(53936002)(9686003)(72206003)(8936002)(33656002)(22452003)(25786009)(86612001)(3660700001)(53546010)(6116002)(102836003)(8676002)(106356001)(6246003)(81156014)(229853002)(81166006)(8990500004)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0158;H:MWHPR21MB0478.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2017 12:07:46.2559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0158
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Thursday, September 28, 2017 10:21 PM
> To: Ben Peart <Ben.Peart@microsoft.com>
> Cc: David.Turner@twosigma.com; avarab@gmail.com;
> christian.couder@gmail.com; git@vger.kernel.org;
> johannes.schindelin@gmx.de; pclouds@gmail.com; peff@peff.net
> Subject: Re: [PATCH v8 00/12] Fast git status via a file system watcher
>=20
> Ben Peart <benpeart@microsoft.com> writes:
>=20
> > The only behavioral change from V7 is the removal of unnecessary uses
> > of CE_MATCH_IGNORE_FSMONITOR.  With a better understanding of
> *why*
> > the
> > CE_MATCH_IGNORE_* flags are used, it is now clear they are not
> > required in most cases where CE_MATCH_IGNORE_FSMONITOR was being
> > passed out of an abundance of caution.
>=20
> The reviews and updates after this round was posted were to
>=20
>  * 01/12 had an obvious pointer-vs-pointee thinko, which I think I
>    have locally fixed;
>=20
>  * 08/12 forgot to add a new test executable to .gitignore file,
>    which I think I have locally fixed, too.
>=20
> Any other review comments and suggestions for improvements?
> Otherwise I am tempted to declare victory and merge this to 'next'
> soonish.
>=20
> For reference, here is the interdiff between what was posted as v8 and wh=
at
> I have on 'pu'.

I had accumulated the same set of changes with one addition of removing
a duplicate "the" from a comment in the fsmonitor.h file:

diff --git a/fsmonitor.h b/fsmonitor.h
index 8eb6163455..0de644e01a 100644
--- a/fsmonitor.h
+++ b/fsmonitor.h
@@ -4,7 +4,7 @@
 extern struct trace_key trace_fsmonitor;
=20
 /*
- * Read the the fsmonitor index extension and (if configured) restore the
+ * Read the fsmonitor index extension and (if configured) restore the
  * CE_FSMONITOR_VALID state.
  */
 extern int read_fsmonitor_extension(struct index_state *istate, const void=
 *data, unsigned long sz);=20

>=20
> Thanks.
>=20
>  compat/bswap.h      | 4 ++--
>  t/helper/.gitignore | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git b/compat/bswap.h a/compat/bswap.h index
> 6b22c46214..5078ce5ecc 100644
> --- b/compat/bswap.h
> +++ a/compat/bswap.h
> @@ -183,8 +183,8 @@ static inline uint32_t get_be32(const void *ptr)  sta=
tic
> inline uint64_t get_be64(const void *ptr)  {
>  	const unsigned char *p =3D ptr;
> -	return	(uint64_t)get_be32(p[0]) << 32 |
> -		(uint64_t)get_be32(p[4]) <<  0;
> +	return	(uint64_t)get_be32(&p[0]) << 32 |
> +		(uint64_t)get_be32(&p[4]) <<  0;
>  }
>=20
>  static inline void put_be32(void *ptr, uint32_t value) diff --git
> b/t/helper/.gitignore a/t/helper/.gitignore index f9328eebdd..87a648a7cf
> 100644
> --- b/t/helper/.gitignore
> +++ a/t/helper/.gitignore
> @@ -5,6 +5,7 @@
>  /test-delta
>  /test-drop-caches
>  /test-dump-cache-tree
> +/test-dump-fsmonitor
>  /test-dump-split-index
>  /test-dump-untracked-cache
>  /test-fake-ssh
