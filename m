Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0715D20966
	for <e@80x24.org>; Thu, 30 Mar 2017 15:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934086AbdC3P1N (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 11:27:13 -0400
Received: from mail-by2nam01on0122.outbound.protection.outlook.com ([104.47.34.122]:40807
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933277AbdC3P1M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 11:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=VjARUUVhyHxnCiovLhHFQGoKPUOBCI2eQs/1ofkGuHk=;
 b=DT/fp4rjNr0eD/1OT6CNk9v9sRcY/eieCZMGJ87v48SosRmtVDqweYC4P40qkhjL17E3QK+i5jhBYwRvb1AgOHTW/58GbVux6ST+YWsplftKQ2+Z/ksk3SfutQZ8gmUfzP8LZj2pekCeVHPC1t1bUmwnlHS+42H8NiL0SOoPwSQ=
Received: from BL2PR03MB323.namprd03.prod.outlook.com (10.141.68.22) by
 BL2PR03MB321.namprd03.prod.outlook.com (10.141.68.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.991.14; Thu, 30 Mar 2017 15:27:08 +0000
Received: from BL2PR03MB323.namprd03.prod.outlook.com ([10.141.68.22]) by
 BL2PR03MB323.namprd03.prod.outlook.com ([10.141.68.22]) with mapi id
 15.01.0991.021; Thu, 30 Mar 2017 15:27:08 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     Junio C Hamano <gitster@pobox.com>, Ben Peart <peartben@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>
Subject: RE: [PATCH v3 7/8] sub-process: move sub-process functions into
 separate files
Thread-Topic: [PATCH v3 7/8] sub-process: move sub-process functions into
 separate files
Thread-Index: AQHSqKS84iqRCXgUoU62Fgt08jNmH6GsSOJrgAE5N3A=
Date:   Thu, 30 Mar 2017 15:27:08 +0000
Message-ID: <BL2PR03MB323086368C35192B4920BE9F4340@BL2PR03MB323.namprd03.prod.outlook.com>
References: <20170329155330.12860-1-benpeart@microsoft.com>
        <20170329155330.12860-8-benpeart@microsoft.com>
 <xmqqmvc3ak6b.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqmvc3ak6b.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pobox.com; dkim=none (message not signed)
 header.d=none;pobox.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [65.222.173.206]
x-microsoft-exchange-diagnostics: 1;BL2PR03MB321;7:t70tmI5XszvvoWpF6FpdBUutuccSWcmWTuEQ7j+spaJBR7JzQ0+b5MR9pyGasBWe224y2ofD69/kyzd0Yk2eAM90eYGaWPtwy8nFVnhxTAPRzcxFWUI77Vvk0R+IIw3vtiuej/SESIQv5Vwv9J1tfFqXX1h4RYgP4QEtS/Daryq/s4ZcAA5UhcKpdRxbi0SXjCEnFuuuv0kr38yIZBh912r2DRZbx3v6FzBU4tZ5aSaij0Rvm+m9I4h3H1RMGBPTCnbBU7/IC1Hfl3HOSV9dLHBZaeCTesirLNuCrlsJUolfsQLuaDIwroe8qNj4WxfpQSYUqQSMC27nB2P/39dOvQLuiI25YxoR65/Ff4bhFL0=
x-ms-office365-filtering-correlation-id: 06785559-d52b-4b03-e607-08d477813ae0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254075)(48565401081)(201703131423075)(201703031133081);SRVR:BL2PR03MB321;
x-microsoft-antispam-prvs: <BL2PR03MB3216E64FD92AB68D29CD378F4340@BL2PR03MB321.namprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(100324003535756);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040450)(601004)(2401047)(8121501046)(5005006)(93006067)(93001067)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041248)(201703131423075)(201702281528075)(201703061421075)(20161123560025)(20161123555025)(20161123562025)(20161123564025)(6072148);SRVR:BL2PR03MB321;BCL:0;PCL:0;RULEID:;SRVR:BL2PR03MB321;
x-forefront-prvs: 02622CEF0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(39840400002)(39450400003)(39860400002)(39410400002)(39850400002)(39400400002)(3660700001)(3280700002)(8656002)(54356999)(102836003)(3846002)(6116002)(86612001)(6506006)(33656002)(25786009)(6436002)(86362001)(2906002)(50986999)(77096006)(66066001)(76176999)(8936002)(229853002)(10090500001)(5660300001)(9686003)(4326008)(2900100001)(8676002)(81166006)(38730400002)(2950100002)(6246003)(7696004)(39060400002)(53936002)(97736004)(305945005)(7736002)(74316002)(55016002)(189998001)(8990500004)(5005710100001)(54906002)(99286003)(122556002)(10290500002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR03MB321;H:BL2PR03MB323.namprd03.prod.outlook.com;FPR:;SPF:None;MLV:ovrnspm;PTR:InfoNoRecords;LANG:en;
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2017 15:27:08.6184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB321
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Junio C Hamano [mailto:gitster@pobox.com]
>=20
> > diff --git a/sub-process.c b/sub-process.c new file mode 100644 index
> > 0000000000..2c4d27c193
> > --- /dev/null
> > +++ b/sub-process.c
> > @@ -0,0 +1,116 @@
> > +/*
> > + * Generic implementation of background process infrastructure.
> > + */
> > +#include "sub-process.h"
> > +#include "sigchain.h"
> > +#include "pkt-line.h"
> > + ...
> > +void subprocess_exit_handler(struct child_process *process) {
>=20
> This is not only undocumented in the above, but it does not seem to be
> necessary to be a public function.  The only thing that uses this is
> subprocess_start(), which is in this file.  Perhaps make it static?

OK.  Missed that somehow. I'll fix it and send another patch series.
