From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] unpack-trees: fix path search bug in verify_absent
Date: Sat, 3 Jan 2009 13:53:50 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901031353090.30769@pacific.mpi-cbg.de>
References: <1230843273-11056-1-git-send-email-drizzd@aon.at> <1230843273-11056-2-git-send-email-drizzd@aon.at> <1230843273-11056-3-git-send-email-drizzd@aon.at> <alpine.DEB.1.00.0901022248070.27818@racer> <20090103103904.GA4479@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat Jan 03 13:54:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJ61g-0002MA-Pv
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 13:54:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753158AbZACMxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2009 07:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbZACMxX
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jan 2009 07:53:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:41398 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751124AbZACMxW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2009 07:53:22 -0500
Received: (qmail invoked by alias); 03 Jan 2009 12:53:19 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp070) with SMTP; 03 Jan 2009 13:53:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18GxiEY6h0G0pVzFBJ2Dhv4eWf+Zuqy2xEp3+oN6Y
	mwpSH9z4Ub7IPu
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090103103904.GA4479@localhost>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104466>

Hi,

On Sat, 3 Jan 2009, Clemens Buchacher wrote:

> On Fri, Jan 02, 2009 at 10:59:47PM +0100, Johannes Schindelin wrote:
> > This explanation makes sense.  However, this:
> > 
> > > @@ -289,7 +289,8 @@ static int unpack_nondirectories(int n, unsigned long mask, unsigned long dirmas
> > >  	return 0;
> > >  }
> > >  
> > > -static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, struct name_entry *names, struct traverse_info *info)
> > > +static int unpack_callback(int n, unsigned long mask, unsigned long dirmask,
> > > +		struct name_entry *names, struct traverse_info *info)
> > >  {
> > >  	struct cache_entry *src[5] = { NULL, };
> > >  	struct unpack_trees_options *o = info->data;
> > 
> > ... is distracting during review, and this:
> > 
> > > @@ -517,22 +518,22 @@ static int verify_clean_subdirectory(struct cache_entry *ce, const char *action,
> > >  	namelen = strlen(ce->name);
> > >  	pos = index_name_pos(o->src_index, ce->name, namelen);
> > >  	if (0 <= pos)
> > > -		return cnt; /* we have it as nondirectory */
> > > +		return 0; /* we have it as nondirectory */
> > >  	pos = -pos - 1;
> > >  	for (i = pos; i < o->src_index->cache_nr; i++) {
> > 
> > ... is not accounted for in the commit message.  Intended or not, that is 
> > the question.
> 
> Those are trivial readability improvements in the context of the patch.

They are not trivial enough for me not to be puzzled.  Reason enough to 
explain in the commit message?

Ciao,
Dscho
