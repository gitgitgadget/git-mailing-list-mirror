From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/2] Improve collection of information for format-patch
 --cover-letter
Date: Tue, 26 Feb 2008 11:27:20 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802261123170.19024@iabervon.org>
References: <alpine.LNX.1.00.0802251822240.19024@iabervon.org> <7v1w70h96u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 17:28:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU2eu-0000Kg-5L
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 17:28:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466AbYBZQ1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 11:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752271AbYBZQ1W
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 11:27:22 -0500
Received: from iabervon.org ([66.92.72.58]:57898 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752174AbYBZQ1W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 11:27:22 -0500
Received: (qmail 5240 invoked by uid 1000); 26 Feb 2008 16:27:20 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Feb 2008 16:27:20 -0000
In-Reply-To: <7v1w70h96u.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75149>

On Mon, 25 Feb 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > ... Note that the single boundary test is empirical, not 
> > theoretical; even a -2 limiting condition will give a diffstat if there's 
> > only one boundary commit in this particular case.
> 
> It is unclear what "a -2 limiting condition" means here...

Like "git format-patch -2". What is that actually called?

> > @@ -962,7 +957,15 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
> >  
> >  	if (prepare_revision_walk(&rev))
> >  		die("revision walk setup failed");
> > +	rev.boundary = 1;
> >  	while ((commit = get_revision(&rev)) != NULL) {
> > +		if (commit->object.flags & BOUNDARY) {
> > +			fprintf(stderr, "Boundary %s\n", sha1_to_hex(commit->object.sha1));
> 
> Leftover debugging?

That last line, yes. I need a checkpatch for new uses of stderr or 
something.

	-Daniel
*This .sig left intentionally blank*
