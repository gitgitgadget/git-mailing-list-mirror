From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Wed, 14 Oct 2009 11:56:20 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910141143520.32515@iabervon.org>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org> <20091014050851.GE31810@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 14 17:58:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My6F4-0004Ar-QA
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 17:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934327AbZJNP5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 11:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761884AbZJNP5A
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 11:57:00 -0400
Received: from iabervon.org ([66.92.72.58]:47150 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761847AbZJNP47 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 11:56:59 -0400
Received: (qmail 17547 invoked by uid 1000); 14 Oct 2009 15:56:20 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Oct 2009 15:56:20 -0000
In-Reply-To: <20091014050851.GE31810@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130301>

On Wed, 14 Oct 2009, Jeff King wrote:

> On Wed, Oct 14, 2009 at 12:44:34AM -0400, Daniel Barkalow wrote:
> 
> > +char *get_detached_head_string(void)
> > +{
> > +	char *filename = git_path("DETACH_NAME");
> > +	struct stat st;
> > +	if (stat(filename, &st) || !S_ISREG(st.st_mode))
> > +		return NULL;
> > +	struct strbuf buf = STRBUF_INIT;
> > +	strbuf_read_file(&buf, filename, st.st_size);
> > +	strbuf_trim(&buf);
> > +	return strbuf_detach(&buf, 0);
> > +}
> 
> Would it hurt to tuck this information into HEAD itself, as we already
> put arbitrary text into FETCH_HEAD?

I don't know; I'll have to try that and see if the tools that handle HEAD 
are happy with extra text there. If it works, it's a good solution.

I think I tried it at some point and things failed all over the place, but 
that may have been before symrefs, when you could get the actual sha1 
hash out of HEAD with "$(cat .git/HEAD)".

	-Daniel
*This .sig left intentionally blank*
