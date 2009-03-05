From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] '%S' option for pretty printing to support --source
Date: Thu, 5 Mar 2009 11:59:57 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903051157070.6524@intel-tinevez-2-302>
References: <200903050918.29051.petri.hodju@yumesystems.com> <20090305091758.GC30445@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petri Hodju <petri.hodju@yumesystems.com>,
	Deskin Miller <deskinm@umich.edu>, git@vger.kernel.org,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 05 12:01:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfBKb-0008JI-7c
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 12:01:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082AbZCELAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 06:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752874AbZCELAF
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 06:00:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:48693 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752214AbZCELAC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 06:00:02 -0500
Received: (qmail invoked by alias); 05 Mar 2009 10:59:58 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp047) with SMTP; 05 Mar 2009 11:59:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/xQn1D5drxCgBs36jKYaVF1rgAiUBtT6nU1A2668
	rQOPBlEJdr/5Hs
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090305091758.GC30445@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112295>

Hi,

On Thu, 5 Mar 2009, Jeff King wrote:

> On Thu, Mar 05, 2009 at 09:18:28AM +0200, Petri Hodju wrote:
> 
> > +static void format_source(struct strbuf *sb, const struct commit *commit)
> > +{
> > +    if (commit->util)
> > +	strbuf_addstr(sb, (char *) commit->util);
> > +}
> > +
> 
> Hmm. This is the second patch in the last few weeks to use commit->util
> to carry information for --pretty=format: (I am cc'ing Deskin Miller,
> who wrote the first).
> 
> They cannot both work, obviously. So we need to do one of:
> 
>   - refactor the information out of commit->util to somewhere else
> 
>   - allow multiple commit->util users somehow (which I think is a
>     potential performance problem -- the simplistic design is meant to
>     avoid things like allocation overhead)

The common way to do this is to use struct decoration.  I was under the 
impression that --source already used that method (IIRC both --source and 
struct decoration come from Linus, the latter of which having been 
rejected when I submitted it as a struct object_hash patch, which would 
have been a better name IMHO).

Ciao,
Dscho
