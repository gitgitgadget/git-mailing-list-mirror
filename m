From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] Add a command "fix" to rebase --interactive.
Date: Fri, 4 Dec 2009 19:44:31 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0912041943160.21557@intel-tinevez-2-302>
References: <cover.1259934977.git.mhagger@alum.mit.edu> <6d779d2c244bf5d5b7924cdc5daf66a8186e4bc7.1259934977.git.mhagger@alum.mit.edu> <7v638mskmx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 19:45:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGdA0-0002mM-En
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 19:45:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756756AbZLDSoc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 13:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755116AbZLDSob
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 13:44:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:40180 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755900AbZLDSo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 13:44:29 -0500
Received: (qmail invoked by alias); 04 Dec 2009 18:44:35 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp070) with SMTP; 04 Dec 2009 19:44:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/CPJ53zrvCHFHP3muA/gtU3lAXtT4MLcOK03hfAx
	PrnugbtRYufK4l
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7v638mskmx.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134565>

Hi,

On Fri, 4 Dec 2009, Junio C Hamano wrote:

> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
> > diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> > index 0bd3bf7..539413d 100755
> > --- a/git-rebase--interactive.sh
> > +++ b/git-rebase--interactive.sh
> > @@ -302,7 +302,7 @@ nth_string () {
> >  
> >  make_squash_message () {
> >  	if test -f "$SQUASH_MSG"; then
> > -		COUNT=$(($(sed -n "s/^# This is [^0-9]*\([1-9][0-9]*\).*/\1/p" \
> > +		COUNT=$(($(sed -n "s/^# Th[^0-9]*\([1-9][0-9]*\)\(th\|st\|nd\|rd\) commit message.*:/\1/p" \
> >  			< "$SQUASH_MSG" | sed -ne '$p')+1))
> 
> This sed replacement worries me.  I don't have a time to check myself
> today but do we use \(this\|or\|that\) alternates with our sed script
> already elsewhere in the codebase (test scripts do not count)?
> 
> Otherwise this may suddenly be breaking a platform that has an
> implementation of sed that may be substandard but so far has been
> sufficient to work with git.

IIRC "|" was not correctly handled by BSD sed (used e.g. in MacOSX).

So maybe it would be best to just look for "commit message"?  I agree with 
Michael that the regex should not be too loose.

Ciao,
Dscho
