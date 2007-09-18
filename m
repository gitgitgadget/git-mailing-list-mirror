From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH 4/7] Clean up stripspace a bit, use strbuf even more.
Date: Tue, 18 Sep 2007 09:52:17 -0400
Message-ID: <1190123537.23692.2.camel@hinata.boston.redhat.com>
References: <1190074008617-git-send-email-krh@redhat.com>
	 <1190074014548-git-send-email-krh@redhat.com>
	 <11900740142347-git-send-email-krh@redhat.com>
	 <11900740153845-git-send-email-krh@redhat.com>
	 <Pine.LNX.4.64.0709181411200.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 18 15:52:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXdVC-0005gZ-8P
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 15:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754314AbXIRNw1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Sep 2007 09:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754056AbXIRNw1
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 09:52:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53395 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751447AbXIRNw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 09:52:26 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l8IDqNox016930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Sep 2007 09:52:23 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8IDqNbM017674;
	Tue, 18 Sep 2007 09:52:23 -0400
Received: from [192.168.1.101] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8IDqMMv001469;
	Tue, 18 Sep 2007 09:52:23 -0400
In-Reply-To: <Pine.LNX.4.64.0709181411200.28586@racer.site>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58609>


On Tue, 2007-09-18 at 14:12 +0100, Johannes Schindelin wrote:
> Hi,
>=20
> I really like your patch, except for this:
>=20
> On Mon, 17 Sep 2007, Kristian H=C3=B8gsberg wrote:
>=20
> > diff --git a/builtin.h b/builtin.h
> > index 03ee7bf..d6f2c76 100644
> > --- a/builtin.h
> > +++ b/builtin.h
> > @@ -7,7 +7,6 @@ extern const char git_version_string[];
> >  extern const char git_usage_string[];
> > =20
> >  extern void help_unknown_cmd(const char *cmd);
> > -extern size_t stripspace(char *buffer, size_t length, int skip_com=
ments);
> >  extern int write_tree(unsigned char *sha1, int missing_ok, const c=
har *prefix);
> >  extern void prune_packed_objects(int);
> > =20
> > diff --git a/strbuf.h b/strbuf.h
> > index 21fc111..5960637 100644
> > --- a/strbuf.h
> > +++ b/strbuf.h
> > @@ -98,4 +98,6 @@ extern ssize_t strbuf_read(struct strbuf *, int f=
d, size_t hint);
> > =20
> >  extern void read_line(struct strbuf *, FILE *, int);
> > =20
> > +extern void stripspace(struct strbuf *buf, int skip_comments);
> > +
> >  #endif /* STRBUF_H */
>=20
> If you do that, you have to move the function "stripspace" to strbuf.=
c,=20
> too...

Right, the alternative is to #include strbuf.h in builtin.h, or maybe
just add struct strbuf; at the top.  And with Pierres latest patch
strbuf is included everywhere, so maybe this is already moot.

Kristian
