Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 372D71FCA0
	for <e@80x24.org>; Mon, 27 Mar 2017 22:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752660AbdC0Wev (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 18:34:51 -0400
Received: from mail-dm3nam03on0108.outbound.protection.outlook.com ([104.47.41.108]:11884
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752356AbdC0Weu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 18:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=9cxQbPrP25lTZLfzb8xEyoQywYuO8B8ZGou5ULZb1OI=;
 b=GB+qrMrCQxuvribwo9VHQLbgOQGphXp1JxCvd/3JV7b9klibhg8h8ipZCjNVH6cGaD4NJeNl7pkQTimGinOYuobvFzPDogLlcSFO7ZapMohy1HHq3JMSmfRqsdGhPZRpI4pQq+suC9M7MaGK9xjCCk61ybHL6Nb4nvRsygaMxRg=
Received: from BL2PR03MB323.namprd03.prod.outlook.com (10.141.68.22) by
 BL2PR03MB324.namprd03.prod.outlook.com (10.141.68.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.991.14; Mon, 27 Mar 2017 22:19:40 +0000
Received: from BL2PR03MB323.namprd03.prod.outlook.com ([10.141.68.22]) by
 BL2PR03MB323.namprd03.prod.outlook.com ([10.141.68.22]) with mapi id
 15.01.0991.020; Mon, 27 Mar 2017 22:19:41 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
        Ben Peart <peartben@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>
Subject: RE: [PATCH v2 1/2] pkt-line: add packet_writel() and
 packet_read_line_gently()
Thread-Topic: [PATCH v2 1/2] pkt-line: add packet_writel() and
 packet_read_line_gently()
Thread-Index: AQHSpLMw2WN94lefeEWS0KPJi8Zk+6GlDRWAgAQ2/gA=
Date:   Mon, 27 Mar 2017 22:19:40 +0000
Message-ID: <BL2PR03MB3233616BE57BB7D911B1AAEF4330@BL2PR03MB323.namprd03.prod.outlook.com>
References: <20170324152726.14632-1-benpeart@microsoft.com>
 <20170324152726.14632-2-benpeart@microsoft.com>
 <7a2c73c8-bb09-12ec-dd8d-99c5363f9bb4@web.de>
In-Reply-To: <7a2c73c8-bb09-12ec-dd8d-99c5363f9bb4@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: web.de; dkim=none (message not signed)
 header.d=none;web.de; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [65.222.173.206]
x-microsoft-exchange-diagnostics: 1;BL2PR03MB324;7:BbjqvBQeVLHmSEeupDeU5jsNUqgBbIPHIfd+Q7nd2G20fBUQQhS6CWC9qxa2F6z9QMS/hfmRiMa9MsWnl//959GqRohK6jFJtlp34ZBmlHBdvuH5QScruYmGi9FZK3LRhUWTKAvBsPNwFkhZAMtr4sy5epbUcVtQbywamAFY4F32DnBNhBkHUsYMYD0++pqW0XBRPR0SRBlNpVLZktzg+QJBgO5uKnhybW/8AjYzMiEwRmjwGyhtU9kgoV0cLEMcSWw8U+t/9xU44kLA2wu1nOVs9WpfwOOFhMtVSvvSM3advSrfc31HMZZ0oaOiCxcuULiFK/QE0wFBvvssMjeFCocRpNF88uEn26USh9WhJJs=
x-ms-office365-filtering-correlation-id: ae1d9cde-8ccf-4fbf-dd69-08d4755f5d3d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254075)(48565401081)(201703131423051)(201703031133057);SRVR:BL2PR03MB324;
x-microsoft-antispam-prvs: <BL2PR03MB3247C388984879F64FDE333F4330@BL2PR03MB324.namprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(245156298449039);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040375)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123564025)(20161123562025)(20161123558025)(20161123555025)(20161123560025)(6072148);SRVR:BL2PR03MB324;BCL:0;PCL:0;RULEID:;SRVR:BL2PR03MB324;
x-forefront-prvs: 02596AB7DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(39840400002)(39450400003)(39410400002)(39850400002)(39860400002)(24454002)(13464003)(377424004)(377454003)(66066001)(229853002)(33656002)(8990500004)(10290500002)(5005710100001)(7696004)(2501003)(2950100002)(6246003)(102836003)(189998001)(5660300001)(81156014)(3846002)(81166006)(6116002)(10090500001)(39060400002)(53936002)(8936002)(7736002)(305945005)(561944003)(38730400002)(77096006)(6506006)(8676002)(86612001)(76176999)(25786009)(50986999)(54356999)(6436002)(86362001)(2906002)(4326008)(3660700001)(9686003)(53546009)(2900100001)(55016002)(122556002)(74316002)(3280700002)(99286003)(54906002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR03MB324;H:BL2PR03MB323.namprd03.prod.outlook.com;FPR:;SPF:None;MLV:ovrnspm;PTR:InfoNoRecords;LANG:en;
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2017 22:19:41.0659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB324
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Torsten B=F6gershausen [mailto:tboegi@web.de]
> Sent: Saturday, March 25, 2017 1:47 AM
> To: Ben Peart <peartben@gmail.com>; git@vger.kernel.org
> Cc: Ben Peart <Ben.Peart@microsoft.com>; christian.couder@gmail.com;
> larsxschneider@gmail.com
> Subject: Re: [PATCH v2 1/2] pkt-line: add packet_writel() and
> packet_read_line_gently()
>=20
> On 2017-03-24 16:27, Ben Peart wrote:
> > Add packet_writel() which writes multiple lines in a single call and
> > then calls packet_flush_gently(). Add packet_read_line_gently() to
> > enable reading a line without dying on EOF.
> >
> > Signed-off-by: Ben Peart <benpeart@microsoft.com>
> > ---
> >  pkt-line.c | 31 +++++++++++++++++++++++++++++++  pkt-line.h | 11
> > +++++++++++
> >  2 files changed, 42 insertions(+)
> >
> > diff --git a/pkt-line.c b/pkt-line.c
> > index d4b6bfe076..2788aa1af6 100644
> > --- a/pkt-line.c
> > +++ b/pkt-line.c
> > @@ -171,6 +171,25 @@ int packet_write_fmt_gently(int fd, const char
> *fmt, ...)
> >  	return status;
> >  }
> >
> > +int packet_writel(int fd, const char *line, ...)
> The name packet_writel is hard to distinguish from packet_write.
> Would packet_write_lines make more sense ?
>=20

Just goes to prove that there are two hard things in computer science: cach=
e invalidation, naming things, and off-by-one errors. :)  The feedback on V=
1 was:

"I am hesitant to take a function that does not take any "list"
type argument and yet calls itself "write_list".  IOW, I'd expect something=
 like these

	write_list(int fd, const char **lines);
	write_list(int fd, struct string_list *lines);

given that name, and not "varargs, each of which is a line".  I am tempted =
to suggest

	packet_writel(int fd, const char *line, ...);"

> > +{
> > +	va_list args;
> > +	int err;
> > +	va_start(args, line);
> > +	for (;;) {
> > +		if (!line)
> > +			break;
> > +		if (strlen(line) > LARGE_PACKET_DATA_MAX)
> > +			return -1;
> > +		err =3D packet_write_fmt_gently(fd, "%s\n", line);
> > +		if (err)
> > +			return err;
> > +		line =3D va_arg(args, const char*);
> > +	}
> > +	va_end(args);
> > +	return packet_flush_gently(fd);
> > +}
> > +
> I don't think that this va_start() is needed, even if it works.
>=20
> int packet_write_line(int fd, const char *lines[])
> |
> 	const char *line =3D *lines;
> 	int err;
> 	while (line) {
> 		if (strlen(line) > LARGE_PACKET_DATA_MAX)
> 			return -1;
> 		err =3D packet_write_fmt_gently(fd, "%s\n", line);
> 		if (err)
> 			return err;
> 		lines++;
> 		line =3D *lines;
> 	}
> 	return packet_flush_gently(fd);
> ]
>=20

This is a helper function to simply the common pattern of writing out a var=
iable number of lines followed by a flush.  The usage of the function as cu=
rrently implemented is:

packet_writel(fd, "line one", "line two", "line n");

which requires the use of variable number of arguments.  With your proposal=
 that convenience is lost as you have to create an array of strings and pas=
s that instead.  The usage just isn't as simple as the current model.

