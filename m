From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Git GUI vs interactive post-commit hooks
Date: Thu, 22 May 2008 17:12:46 +0200
Message-ID: <20080522151246.GA9765@atjola.homenet>
References: <c6c947f60805190348g3395f8degae81963b402856b6@mail.gmail.com> <20080519131942.GA5526@atjola.homenet> <20080520223158.GB13123@steel.home> <20080520230204.GA5383@atjola.homenet> <20080522125301.GD3206@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexander Gladysh <agladysh@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 22 17:13:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzCUG-0006LM-7r
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 17:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752436AbYEVPMw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 May 2008 11:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752315AbYEVPMw
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 11:12:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:60872 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752017AbYEVPMv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 11:12:51 -0400
Received: (qmail invoked by alias); 22 May 2008 15:12:48 -0000
Received: from i577B8886.versanet.de (EHLO atjola.local) [87.123.136.134]
  by mail.gmx.net (mp042) with SMTP; 22 May 2008 17:12:48 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19vIFdID2hvGCvu+kcn9h3ooM1GBuZVqlHi6aeAz2
	8EEdWF+QcP4crZ
Content-Disposition: inline
In-Reply-To: <20080522125301.GD3206@steel.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82631>

On 2008.05.22 14:53:01 +0200, Alex Riesen wrote:
> Bj=C3=B6rn Steinbrink, Wed, May 21, 2008 01:02:04 +0200:
> > On 2008.05.21 00:31:58 +0200, Alex Riesen wrote:
> > > Bj?rn Steinbrink, Mon, May 19, 2008 15:19:42 +0200:
> > > > On 2008.05.19 14:48:14 +0400, Alexander Gladysh wrote:
> > > > >=20
> > > > > Any advice? I do want to input password for my key each time =
I use it.
> > > >=20
> > > > For a graphical tool, you might want to use something like
> > > > gtk-led-askpass, which shows a window with a password prompt. S=
SH will
> > > > make use of it if SSH_ASKPASS contains its path _and_ ssh is no=
t started
> > > > from a terminal. Unfortunately, the latter is probably not true=
 for git
> > > > gui most of the time.
> > >=20
> > > Redirect stdin from /dev/null
> >=20
> > Does that actually work for you? It didn't work for me, because ssh=
 then
> > simply goes and opens /dev/tty to ask for the password.
> >=20
> > $ ssh -V
> > OpenSSH_4.7p1 Debian-10, OpenSSL 0.9.8g 19 Oct 2007
> >=20
>=20
> No :( I took this information from sshs manpage:
>=20
>      SSH_ASKPASS           If ssh needs a passphrase, it will read th=
e
>                            passphrase from the current terminal if it=
 was run
>                            from a terminal.  If ssh does not have a t=
erminal
>                            associated with it but DISPLAY and SSH_ASK=
PASS are
>                            set, it will execute the program specified=
 by
>                            SSH_ASKPASS and open an X11 window to read=
 the
>                            passphrase.  This is particularly useful w=
hen call=E2=80=90
>                            ing ssh from a .xsession or related script=
=2E  (Note
>                            that on some machines it may be necessary =
to redi=E2=80=90
>                            rect the input from /dev/null to make this=
 work.)

Yeah, that got me trying the redirection, too. But the "If ssh does not
have a terminal associated" part is actually what counts, it seems.
Because ssh falls back to /dev/tty if stdin doesn't work. Guess the
stdin redirect might just be required in some cases, where it would use
/dev/stdin directly, so you force it to try /dev/tty and then use
SSH_ASKPASS.

Bj=C3=B6rn
