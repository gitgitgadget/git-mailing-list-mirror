From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] gitweb: Use config file or file for repository owner's
 name.
Date: Thu, 31 Jan 2008 11:12:31 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801311110280.23907@racer.site>
References: <1201670898-15076-1-git-send-email-ribas@c3sl.ufpr.br> <7vwsprj0sv.fsf@gitster.siamese.dyndns.org> <20080131023629.GB7778@c3sl.ufpr.br> <7vsl0eg16c.fsf@gitster.siamese.dyndns.org> <7vabmmg0cb.fsf@gitster.siamese.dyndns.org>
 <m3bq728y4o.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Bruno Cesar Ribas <ribas@c3sl.ufpr.br>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 12:13:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKXMT-00022B-3c
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 12:13:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760349AbYAaLNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 06:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758631AbYAaLNH
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 06:13:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:56471 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755641AbYAaLND (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 06:13:03 -0500
Received: (qmail invoked by alias); 31 Jan 2008 11:13:01 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp042) with SMTP; 31 Jan 2008 12:13:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19V8tdMAHBVHsDF5BxVJrn/NULTstYUpW5kHb4sNR
	PPviDHafRmqOj4
X-X-Sender: gene099@racer.site
In-Reply-To: <m3bq728y4o.fsf@localhost.localdomain>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72127>

Hi,

On Wed, 30 Jan 2008, Jakub Narebski wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Junio C Hamano <gitster@pobox.com> writes:
> > 
> >> Bruno Cesar Ribas <ribas@c3sl.ufpr.br> writes:
> >> ...
> >>> Opening the extra file has same problem as the description file. 
> >>> And, as gitweb allow us to create "description" and "cloneurl" file 
> >>> there is no problem having another file to open instead finding out 
> >>> who is the owner of the directory asking to the filesystem.
> >>
> >> We heard the same argument when cloneurl was added, and a newcomer 
> >> who does not know that may rightly use the same argument.  But I 
> >> think we should work towards _reducing_ the number of such ad-hoc 
> >> one-line-per-information files, not using existing ones as an excuse 
> >> to add _more_ of them.
> > 
> > Rephrasing to be constructive (but remember, this is all post 1.5.4).
> > 
> >  * we would need for historical reasons to keep supporting
> >    description and cloneurl for some time.  There may be some
> >    others, but the goal should be to deprecate and remove these
> >    ad-hoc one-file-per-piece-of-information files.
> > 
> >  * we also need for historical reasons to keep supporting some
> >    other stuff found in $git_dir/config of the project.
> > 
> > If the config reading interface in gitweb is reasonably fast and 
> > cheap, we can move the existing description/cloneurl to gitweb config 
> > when deprecating them.  New ones such as "owner" would naturally fit 
> > there.
> 
> Currently gitweb parses repo config file _once_, using one call to 
> git-config -z -l.
> 
> We could simply add description to the projects_list file, but it will 
> be a bit backwards incompatibile change.

Not if you say "the config overrides the description/cloneurl file", i.e. 
when there is a description or a cloneurl from the config, don't even 
bother to stat the single-line files.

That would help transition, and still be backwards compatible.  (BTW this 
resembles what we did for the .git/remotes/* -> .git/config transition.)

Ciao,
Dscho
