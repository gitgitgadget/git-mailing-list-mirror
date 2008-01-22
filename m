From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] http-push: making HTTP push more robust and more
 user-friendly
Date: Tue, 22 Jan 2008 00:58:50 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801220056080.5731@racer.site>
References: <1200250979-19604-1-git-send-email-gb@gbarbier.org> <7vbq7ppbyh.fsf@gitster.siamese.dyndns.org> <47946F67.5060601@gbarbier.org> <7vmyqzzdhf.fsf@gitster.siamese.dyndns.org> <47947399.3000507@gbarbier.org> <7vabmzzbcc.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0801211212010.5731@racer.site> <7vejcbx795.fsf@gitster.siamese.dyndns.org> <20080121202953.GA18440@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Gr=E9goire_Barbier?= <devel@gbarbier.org>,
	git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Jan 22 01:59:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH7U4-00006m-Bm
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 01:59:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756684AbYAVA6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 19:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753129AbYAVA6y
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 19:58:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:56987 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755954AbYAVA6x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 19:58:53 -0500
Received: (qmail invoked by alias); 22 Jan 2008 00:58:51 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp043) with SMTP; 22 Jan 2008 01:58:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+CpONfZlaChCqtam/E3CJvcm8foFC4mguvclj8jf
	fpTgPjsAD3USRz
X-X-Sender: gene099@racer.site
In-Reply-To: <20080121202953.GA18440@glandium.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71382>

Hi,

On Mon, 21 Jan 2008, Mike Hommey wrote:

> On Mon, Jan 21, 2008 at 12:18:14PM -0800, Junio C Hamano wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > IMHO it is safer to disable it for curl < 7.0xa -- even if it affects a 
> > > number of distros -- than to give the illusion that it works, when it does 
> > > not.
> > >
> > > As for fixing it in the non-MULTI case, I have a hunch that Mike's 
> > > cleanups will help that, but that this is a 1.5.5 feature.
> > >
> > > So, I would like to read in the ReleaseNotes something like this:
> > >
> > > -- snip --
> > > Support for pushing via HTTP was broken with curl versions prior to 7.16, 
> > > so we disabled it for now.  However, it is likely that a major cleanup of 
> > > the http transport code -- scheduled after the release of git 1.5.4 -- 
> > > will be supported with more curl versions.
> > > -- snap --
> > 
> > That's tempting but I suspect that it might be a wrong approach.
> > 
> > I think two important questions are:
> > 
> >  * Do we know that the current code is broken for everybody, or
> >    just broken for the majority of people who do nontrivial
> >    things?
> 
> IIRC, http-push simply doesn't work without CURL_MULTI. 

I have to agree.  When I last tried without CURL_MULTI (IIRC it was just 
once, when I had an ancient curl available), it would just not work, and I 
gave up/in and installed a newer curl, thus enabling CURL_MULTI.

> >  * Is the code in 1.5.3.8 any better?  IOW, did we make it worse
> >    during 1.5.4 cycle?
> 
> Changes in http-push.c since 1.5.3.8 mostly involve cleanup. It
> didn't change anything about CURL_MULTI or lack thereof.

I meant to look into http-push and curl_multi, ever since Daniel asked me 
(or for that matter, other people knowing about the issues) do do it.

Alas, I forgot about it.

So I am half-convinced that http-push w/o CURL_MULTI was broken since long 
ago (pre 1.5.3).

I'll try tomorrow, since I have a (kinda) working http-push setup 
available then.

Ciao,
Dscho
