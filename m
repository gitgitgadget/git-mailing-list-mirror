From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Wed, 14 Oct 2009 11:39:34 -0400
Message-ID: <20091014153934.GA3680@coredump.intra.peff.net>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>
 <20091014050851.GE31810@coredump.intra.peff.net>
 <alpine.DEB.1.00.0910141233060.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 14 17:43:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My613-0001Ku-Aw
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 17:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934235AbZJNPkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 11:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934044AbZJNPkL
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 11:40:11 -0400
Received: from peff.net ([208.65.91.99]:36327 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933548AbZJNPkK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 11:40:10 -0400
Received: (qmail 30081 invoked by uid 107); 14 Oct 2009 15:43:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 14 Oct 2009 11:43:06 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Oct 2009 11:39:34 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0910141233060.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130298>

On Wed, Oct 14, 2009 at 12:33:22PM +0200, Johannes Schindelin wrote:

> > > +char *get_detached_head_string(void)
> > > +{
> > > +	char *filename = git_path("DETACH_NAME");
> > > +	struct stat st;
> > > +	if (stat(filename, &st) || !S_ISREG(st.st_mode))
> > > +		return NULL;
> > > +	struct strbuf buf = STRBUF_INIT;
> > > +	strbuf_read_file(&buf, filename, st.st_size);
> > > +	strbuf_trim(&buf);
> > > +	return strbuf_detach(&buf, 0);
> > > +}
> > 
> > Would it hurt to tuck this information into HEAD itself, as we already
> > put arbitrary text into FETCH_HEAD?
> 
> AFAIR we still remember HEAD to be a symlink.

I think that has been abandoned for detached HEAD (that is, if you
support only symlinked HEAD, then you cannot detach at all). But I might
be wrong. It has been a while since I looked at that code.

-Peff
