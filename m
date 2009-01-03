From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 2/3] unpack-trees: fix path search bug in verify_absent
Date: Sat, 3 Jan 2009 11:39:04 +0100
Message-ID: <20090103103904.GA4479@localhost>
References: <1230843273-11056-1-git-send-email-drizzd@aon.at> <1230843273-11056-2-git-send-email-drizzd@aon.at> <1230843273-11056-3-git-send-email-drizzd@aon.at> <alpine.DEB.1.00.0901022248070.27818@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 03 11:40:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJ3w3-0000XJ-8H
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 11:40:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755732AbZACKjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2009 05:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755241AbZACKjJ
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jan 2009 05:39:09 -0500
Received: from postman.fh-hagenberg.at ([193.170.124.96]:25953 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754550AbZACKjI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2009 05:39:08 -0500
Received: from darc.dyndns.org ([80.123.242.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 3 Jan 2009 11:39:03 +0100
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1LJ3uK-0001DQ-GP; Sat, 03 Jan 2009 11:39:04 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901022248070.27818@racer>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 03 Jan 2009 10:39:03.0542 (UTC) FILETIME=[7F02F160:01C96D8F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104459>

On Fri, Jan 02, 2009 at 10:59:47PM +0100, Johannes Schindelin wrote:
> This explanation makes sense.  However, this:
> 
> > @@ -289,7 +289,8 @@ static int unpack_nondirectories(int n, unsigned long mask, unsigned long dirmas
> >  	return 0;
> >  }
> >  
> > -static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, struct name_entry *names, struct traverse_info *info)
> > +static int unpack_callback(int n, unsigned long mask, unsigned long dirmask,
> > +		struct name_entry *names, struct traverse_info *info)
> >  {
> >  	struct cache_entry *src[5] = { NULL, };
> >  	struct unpack_trees_options *o = info->data;
> 
> ... is distracting during review, and this:
> 
> > @@ -517,22 +518,22 @@ static int verify_clean_subdirectory(struct cache_entry *ce, const char *action,
> >  	namelen = strlen(ce->name);
> >  	pos = index_name_pos(o->src_index, ce->name, namelen);
> >  	if (0 <= pos)
> > -		return cnt; /* we have it as nondirectory */
> > +		return 0; /* we have it as nondirectory */
> >  	pos = -pos - 1;
> >  	for (i = pos; i < o->src_index->cache_nr; i++) {
> 
> ... is not accounted for in the commit message.  Intended or not, that is 
> the question.

Those are trivial readability improvements in the context of the patch.

On Fri, Jan 02, 2009 at 10:59:43PM +0100, Johannes Schindelin wrote:
> Sign-off?

Signed-off-by: Clemens Buchacher <drizzd@aon.at>

on all three patches.
