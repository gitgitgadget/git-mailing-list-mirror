Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91D851FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 12:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757076AbdCXMed (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 08:34:33 -0400
Received: from mail-sn1nam01on0127.outbound.protection.outlook.com ([104.47.32.127]:52544
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752354AbdCXMeb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 08:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=e/+zw+iHmceKRdXfRf7laYqQ3AGwP8yuCpV89FmsjxU=;
 b=P/mSCRRgzXvD0X47FsZvaBlagiYwy07P75TkEpxgwI3bjU7hJcE+sp8JzXBGlju55jCFe05QezOc5ekpMVPSDqmq76EjW0D8eCDLiyJ6gpxcQGMKH697w88TpFmrdUUFDbkF+ZtN1Jl3/3VoLjl3ajN1EPfrz8D4sTgxcJdDPHc=
Received: from BL2PR03MB323.namprd03.prod.outlook.com (10.141.68.22) by
 BL2PR03MB321.namprd03.prod.outlook.com (10.141.68.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.991.14; Fri, 24 Mar 2017 12:34:26 +0000
Received: from BL2PR03MB323.namprd03.prod.outlook.com ([10.141.68.22]) by
 BL2PR03MB323.namprd03.prod.outlook.com ([10.141.68.22]) with mapi id
 15.01.0991.017; Fri, 24 Mar 2017 12:34:26 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     Junio C Hamano <gitster@pobox.com>, Ben Peart <peartben@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>
Subject: RE: [PATCH v1 1/3] pkt-line: add packet_write_list_gently()
Thread-Topic: [PATCH v1 1/3] pkt-line: add packet_write_list_gently()
Thread-Index: AQHSoyzlrutZb0iFXUaHpJW3Xe4PsqGhTW30gAKhmCA=
Date:   Fri, 24 Mar 2017 12:34:25 +0000
Message-ID: <BL2PR03MB32362E9532BFD2C895C1B73F43E0@BL2PR03MB323.namprd03.prod.outlook.com>
References: <20170322165220.5660-1-benpeart@microsoft.com>
        <20170322165220.5660-2-benpeart@microsoft.com>
 <xmqqefxpjc5b.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqefxpjc5b.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pobox.com; dkim=none (message not signed)
 header.d=none;pobox.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [65.222.173.206]
x-microsoft-exchange-diagnostics: 1;BL2PR03MB321;7:MVS0KtX3GjqfygzZ6Z+COa7BdFUfQRo/2/LPX3GBi++/gEgoHUr7xsqnXnYSrbwa3OQt01xXKEV/WnNYuLbI6JeuPfHQE8s1FbfNjTYankdyC4EFe5QmIns/EowCwcHpBqM7s0PytHGpVStBOP/iXBzhNHDnZXOcoyKEsgGqjPIYgBhx/Hr/Ajm2EevkoEAsKtBF7sUWHmn9niSS0bGKbLIdNd9/N8g3ZVXB23FnmTZIl2gigKf9j1qvVmVMgBSZsLfvYpb6R13pKP1EP0VTR2diM9BJIOFbab2H+V6+7ef8yMaoWlDP5On996PTfV8hulPpEPggUCPPvFew5wuR8gxZYZ9/EWeSNJ8FTYeFEyk=
x-ms-office365-filtering-correlation-id: 26279215-f68f-4592-248a-08d472b21bc8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254075)(48565401081);SRVR:BL2PR03MB321;
x-microsoft-antispam-prvs: <BL2PR03MB321970E97868AB896A9132DF43E0@BL2PR03MB321.namprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(100324003535756);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040375)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123560025)(20161123555025)(20161123564025)(20161123558025)(20161123562025)(6072148);SRVR:BL2PR03MB321;BCL:0;PCL:0;RULEID:;SRVR:BL2PR03MB321;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(39850400002)(39410400002)(39450400003)(39860400002)(39840400002)(13464003)(377454003)(25786009)(6246003)(6436002)(8990500004)(10090500001)(6506006)(5005710100001)(10290500002)(53546009)(39060400002)(54356999)(305945005)(2900100001)(189998001)(77096006)(4326008)(5660300001)(38730400002)(81166006)(229853002)(8676002)(122556002)(76176999)(74316002)(8936002)(86362001)(3846002)(6116002)(9686003)(54906002)(2906002)(55016002)(86612001)(33656002)(7696004)(8656002)(3280700002)(2950100002)(3660700001)(66066001)(102836003)(53936002)(99286003)(50986999)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR03MB321;H:BL2PR03MB323.namprd03.prod.outlook.com;FPR:;SPF:None;MLV:ovrnspm;PTR:InfoNoRecords;LANG:en;
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2017 12:34:25.8846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB321
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Wednesday, March 22, 2017 4:21 PM
> To: Ben Peart <peartben@gmail.com>
> Cc: git@vger.kernel.org; Ben Peart <Ben.Peart@microsoft.com>;
> christian.couder@gmail.com; larsxschneider@gmail.com
> Subject: Re: [PATCH v1 1/3] pkt-line: add packet_write_list_gently()
>=20
> Ben Peart <peartben@gmail.com> writes:
>=20
> > Add packet_write_list_gently() which writes multiple lines in a single
> > call and then calls packet_flush_gently(). This is used later in this
> > patch series.
>=20
> I can see how it would be convenient to have a function like this.
> I'd name it without _gently(), though.  We call something _gently() when =
we
> initially only have a function that dies hard on error and later want to =
have a
> variant that returns an error for the caller to handle.  You are starting
> without a dying variant (which is probably a preferable way to structure =
the
> API).
>=20
> Also I am hesitant to take a function that does not take any "list"
> type argument and yet calls itself "write_list".  IOW, I'd expect somethi=
ng like
> these
>=20
> 	write_list(int fd, const char **lines);
> 	write_list(int fd, struct string_list *lines);
>=20
> given that name, and not "varargs, each of which is a line".  I am tempte=
d to
> suggest
>=20
> 	packet_writel(int fd, const char *line, ...);
>=20
> noticing similarity with execl(), but perhaps others may be able to come =
up
> with better names.

Given there haven't been any better names suggested, I'll go ahead and upda=
te it to be packet_writel.

>=20
> > Signed-off-by: Ben Peart <benpeart@microsoft.com>
> > ---
> >  pkt-line.c | 19 +++++++++++++++++++
> >  pkt-line.h |  1 +
> >  2 files changed, 20 insertions(+)
> >
> > diff --git a/pkt-line.c b/pkt-line.c
> > index d4b6bfe076..fccdac1352 100644
> > --- a/pkt-line.c
> > +++ b/pkt-line.c
> > @@ -171,6 +171,25 @@ int packet_write_fmt_gently(int fd, const char
> *fmt, ...)
> >  	return status;
> >  }
> >
> > +int packet_write_list_gently(int fd, const char *line, ...) {
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
> >  static int packet_write_gently(const int fd_out, const char *buf,
> > size_t size)  {
> >  	static char packet_write_buffer[LARGE_PACKET_MAX];
> > diff --git a/pkt-line.h b/pkt-line.h
> > index 18eac64830..3674d04509 100644
> > --- a/pkt-line.h
> > +++ b/pkt-line.h
> > @@ -25,6 +25,7 @@ void packet_buf_flush(struct strbuf *buf);  void
> > packet_buf_write(struct strbuf *buf, const char *fmt, ...)
> > __attribute__((format (printf, 2, 3)));  int packet_flush_gently(int
> > fd);  int packet_write_fmt_gently(int fd, const char *fmt, ...)
> > __attribute__((format (printf, 2, 3)));
> > +int packet_write_list_gently(int fd, const char *line, ...);
> >  int write_packetized_from_fd(int fd_in, int fd_out);  int
> > write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
