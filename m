From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] git repack: keep commits hidden by a graft
Date: Fri, 24 Jul 2009 11:37:38 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907241136081.19988@intel-tinevez-2-302>
References: <cover.1248362827u.git.johannes.schindelin@gmx.de> <34dfd22bb99c7c466b6131876e8b52ac46f388aa.1248362827u.git.johannes.schindelin@gmx.de> <7v8wievf20.fsf@alter.siamese.dyndns.org> <20090724053506.GB12855@atjola.homenet>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-853889181-1248428259=:19988"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 24 11:37:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUHDp-00024x-AV
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 11:37:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbZGXJhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 05:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751544AbZGXJhm
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 05:37:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:50995 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751962AbZGXJhl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 05:37:41 -0400
Received: (qmail invoked by alias); 24 Jul 2009 09:37:40 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp039) with SMTP; 24 Jul 2009 11:37:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+XzZMIE7mXrcGxZy4DqTIvQ86J1nphX7aUoIoK++
	ZoYRq6EIdZDaRs
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090724053506.GB12855@atjola.homenet>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123911>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-853889181-1248428259=:19988
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 24 Jul 2009, Björn Steinbrink wrote:

> On 2009.07.23 22:13:43 -0700, Junio C Hamano wrote:
> > Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> > 
> > > diff --git a/commit.c b/commit.c
> > > index a47fb4d..ef8e911 100644
> > > --- a/commit.c
> > > +++ b/commit.c
> > > @@ -262,7 +262,7 @@ int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size)
> > >  		    bufptr[47] != '\n')
> > >  			return error("bad parents in commit %s", sha1_to_hex(item->object.sha1));
> > >  		bufptr += 48;
> > > -		if (graft)
> > > +		if (graft && (graft->nr_parent < 0 || grafts_replace_parents))
> > >  			continue;
> > 
> > Hmm, what is this "if it is negative" check for?  I did not see it
> > mentioned in the proposed commit log message.
> 
> That's for the special grafts for shallow clones. They override the 
> other grafts, and are identified by the negative nr_parent value. Those 
> have to stay in effect as the original parents aren't present in the 
> repo.

Right.  How about a comment above the if():

		/*
		 * If nr_parent is negative, the commit is shallow, and
		 * we must not traverse its real parents.
		 */

Hmm?

Ciao,
Dscho

--8323329-853889181-1248428259=:19988--
