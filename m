From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] git-branch: add --track and --no-track options
Date: Mon, 5 Mar 2007 19:37:01 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703051930560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <esgm1m$33f$1@sea.gmane.org>
 <Pine.LNX.4.63.0703051520340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45EC3905.7070406@lu.unisi.ch> <Pine.LNX.4.63.0703051648330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45EC4B55.3090505@lu.unisi.ch> <Pine.LNX.4.63.0703051812030.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45EC51C6.5080505@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: bonzini@gnu.org
X-From: git-owner@vger.kernel.org Mon Mar 05 19:37:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOI3d-00051M-8q
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 19:37:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844AbXCEShF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 13:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752849AbXCEShE
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 13:37:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:35050 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752844AbXCEShD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 13:37:03 -0500
Received: (qmail invoked by alias); 05 Mar 2007 18:37:02 -0000
X-Provags-ID: V01U2FsdGVkX18ppcMDBaYpLV4z1oDN8tJP78D9R9NYYUkf7qpc21
	+18tpKEi08Rxh3
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45EC51C6.5080505@lu.unisi.ch>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41470>

Hi,

On Mon, 5 Mar 2007, Paolo Bonzini wrote:

> > Yes, you also check real_ref instead of checking if dwim_ref() 
> > returned 0. I feel a little bit uneasy about that, since there is no 
> > guarantee that these values are left untouched, whereas the return 
> > value is guaranteed to behave as expected.
> 
> There is.  The man page says "Scanning stops when an input character 
> does not match such a format character."  Scanning includes not 
> processing %n elements, either.

So, if you want to be that precise, it never says that it does not touch 
the pointers passed to it. But it states very clearly what the return 
value is in case of a failure.

> Regarding dwim_ref, dwim_ref says:
> 
> int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
> {
>         const char **p, *r;
>         int refs_found = 0;
> 
>         *ref = NULL;

Yes, this is what the source does. But again, the return value is what you 
should -- and indeed forever can -- rely on. I am not really happy that 
dwim_ref() touches ref, even if nothing was found, but it is an 
_implementation detail_.

> > I also feel a little uneasy about having to parse a format in order to 
> > parse a string, when you know what that string should look like. For 
> > example, you could make the code even more compact by asking "(p = 
> > strstr(value, "/*:refs/remotes/"))".
> 
> Go down this way and you will say that printf is useless too.

Nah. You are not fair.

Ciao,
Dscho
