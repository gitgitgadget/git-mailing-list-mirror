From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Supplant the "while case ... break ;; esac" idiom
Date: Mon, 24 Sep 2007 11:33:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709241128460.28395@racer.site>
References: <853ax5mb1j.fsf@lola.goethe.zz> <85myvdktb3.fsf@lola.goethe.zz>
 <20070924060521.GB10975@glandium.org> <85k5qgk295.fsf@lola.goethe.zz>
 <ee77f5c20709232330n7b47d9e9v38677678dbf197da@mail.gmail.com>
 <86ejgowl5g.fsf@lola.quinscape.zz> <20070924080134.GA9112@artemis.corp>
 <20070924080436.GB9112@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Sep 24 12:34:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZlGX-000369-98
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 12:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754434AbXIXKeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 06:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754357AbXIXKeF
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 06:34:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:33045 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754022AbXIXKeD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 06:34:03 -0400
Received: (qmail invoked by alias); 24 Sep 2007 10:34:01 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp052) with SMTP; 24 Sep 2007 12:34:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19spKEWDCpsuKwCfRmiTrEhuiWOJYdJV11RxMrgIm
	4Iyqe1SHboFOzp
X-X-Sender: gene099@racer.site
In-Reply-To: <20070924080436.GB9112@artemis.corp>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59034>

Hi,

On Mon, 24 Sep 2007, Pierre Habouzit wrote:

> On Mon, Sep 24, 2007 at 08:01:34AM +0000, Pierre Habouzit wrote:
> > On Mon, Sep 24, 2007 at 07:57:31AM +0000, David Kastrup wrote:
> > > "David Symonds" <dsymonds@gmail.com> writes:
> > > 
> > > > On 24/09/2007, David Kastrup <dak@gnu.org> wrote:
> > > >> Mike Hommey <mh@glandium.org> writes:
> > > >>
> > > >> > On Sun, Sep 23, 2007 at 10:42:08PM +0200, David Kastrup wrote:
> > > >> >> -while case $# in 0) break ;; esac
> > > >> >> +while test $# != 0
> > > >> >
> > > >> > Wouldn't -ne be better ?
> > > >>
> > > >> Why?
> > > >
> > > > Because -ne does a numeric comparison, != does a string comparison,
> > > > and it's a numeric comparison happening, semantically speaking.
> > > 
> > > I don't see the point in converting $# and 0 into numbers before
> > > comparing them.  "!=" is quite more readable, and the old code also
> > > compared the strings.
> > 
> >   Fwiw $# already is a number. Hence test $# -ne 0 is definitely a
> > better test.
> > 
> >   $# != 0 would yield sth like (strcmp(sprintf("%d", argc), "0"))
> >   $# -ne 0 would yield sth like (argc != atoi("0")).
> 
>   Of course this holds only for shell where test/[ is a builtin, which
> is the at least the case for zsh, bash, and dash (but not posh).

The reason we used "case" is that this has always been a builtin (has to 
be, because it changes workflow).

Therefore I am somewhat uneasy that the patch went in so easily, 
especially given a message that flies in the face of our endeavours to 
make git less dependent on any given shell (as long as it is not broken to 
begin with).

Ciao,
Dscho
