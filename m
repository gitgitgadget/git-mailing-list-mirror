From: Joe Perches <joe@perches.com>
Subject: Re: [RFC PATCH] sit-send-email.pl: Add --to-cmd
Date: Thu, 23 Sep 2010 10:46:33 -0700
Message-ID: <1285263993.31572.25.camel@Joe-Laptop>
References: <AANLkTinsM5jdU194FR8L3hTvBXk0Tr_oV2E5752NOUpq@mail.gmail.com>
	 <AANLkTikkJNwF4LS9rx5=bHM2R0Pm751Y1u9V8iAt0w1A@mail.gmail.com>
	 <1285227413.7286.47.camel@Joe-Laptop>
	 <Pine.LNX.4.64.1009231054230.15528@ask.diku.dk>
	 <20100923090931.GA29789@albatros> <20100923120024.GA26715@albatros>
	 <1285253867.31572.13.camel@Joe-Laptop>
	 <Pine.LNX.4.64.1009231757090.11585@ask.diku.dk>
	 <1285262237.31572.18.camel@Joe-Laptop>
	 <AANLkTin_Y8w4ujNGTqGJPNDNfYz7hcjBVLcOG0emBjYn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Julia Lawall <julia@diku.dk>, git <git@vger.kernel.org>,
	Vasiliy Kulikov <segooon@gmail.com>,
	matt mooney <mfmooney@gmail.com>,
	kernel-janitors@vger.kernel.org, Dan Carpenter <error27@gmail.com>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 23 19:46:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oypsa-0002Mt-1N
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 19:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755872Ab0IWRqf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Sep 2010 13:46:35 -0400
Received: from mail.perches.com ([173.55.12.10]:2284 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755851Ab0IWRqf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 13:46:35 -0400
Received: from [192.168.1.156] (unknown [192.168.1.156])
	by mail.perches.com (Postfix) with ESMTP id A4BBF24368;
	Thu, 23 Sep 2010 10:46:23 -0700 (PDT)
In-Reply-To: <AANLkTin_Y8w4ujNGTqGJPNDNfYz7hcjBVLcOG0emBjYn@mail.gmail.com>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156889>

On Thu, 2010-09-23 at 17:29 +0000, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on wrote:
> On Thu, Sep 23, 2010 at 17:17, Joe Perches <joe@perches.com> wrote:
> > I know there's a test harness in git, but
> > I don't know how to wire up the new options.
> You'd add the tests to t9001-send-email.sh and --tocmd out to some
> program you create. Is there anything in particular you need help
> with?

Just the doing.  I was (am) being lazy.

> > -if (!@to) {
> > +if (!@to && $to_cmd eq "") {
>=20
> Why compare $to_cmd to "" instead of checking definedness?

No real reason.  Using define is the style used in the rest of
the file and it should be changed.

> > @@ -1238,6 +1242,23 @@ foreach my $t (@files) {
> >        }
> >        close F;
> >
> > +       if (defined $to_cmd) {
> > +               open(F, "$to_cmd \Q$t\E |")
>=20
> quotemeta() is for escaping regexes, not shell syntax. You probably
> want IPC::Open2 or PC::Open3's functions which'll escape arguments fo=
r
> you.

I just copied the style from the equivalent cc_cmd section below,
so if it's necessary, it should be changed there too.

> I.e. do you need to strip whitespace from the beginning of the string=
?

I think so.
