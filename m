From: Jeff King <peff@peff.net>
Subject: Re: Fwd: git status options feature suggestion
Date: Sun, 12 Oct 2008 20:59:35 -0400
Message-ID: <20081013005934.GA3768@coredump.intra.peff.net>
References: <81bfc67a0810082234p55e2fb9jb2a10f837eea7de0@mail.gmail.com> <20081009061136.GA24288@coredump.intra.peff.net> <81bfc67a0810082327p421ca4e9v84f4b33023bc6fe6@mail.gmail.com> <81bfc67a0810082327q71b9d6apf2787eb8519031bb@mail.gmail.com> <alpine.DEB.1.00.0810091101230.22125@pacific.mpi-cbg.de.mpi-cbg.de> <48EE1F58.2060707@drmicha.warpmail.net> <20081012044900.GA27845@coredump.intra.peff.net> <20081012082607.GA17852@sigill.intra.peff.net> <7vwsgef83n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Caleb Cushing <xenoterracide@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 03:00:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpBnq-0001EI-Bv
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 03:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754329AbYJMA7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 20:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754333AbYJMA7j
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 20:59:39 -0400
Received: from peff.net ([208.65.91.99]:3394 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754328AbYJMA7i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 20:59:38 -0400
Received: (qmail 4287 invoked by uid 111); 13 Oct 2008 00:59:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 12 Oct 2008 20:59:37 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Oct 2008 20:59:35 -0400
Content-Disposition: inline
In-Reply-To: <7vwsgef83n.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98067>

On Sun, Oct 12, 2008 at 02:58:20AM -0700, Junio C Hamano wrote:

> > +		fd = hold_locked_index(&index_lock, 0);
> > +		if (fd < 0) {
> > +			if (!status_only)
> > +				die("unable to lock index: %s",
> > +						strerror(errno));
> > +			return get_index_file();
> > +		}
> >  		refresh_cache(REFRESH_QUIET);
> 
> You would probably want to refresh_cache() here even if you are not going
> to write the resulting index out, so that you won't show the stat-only
> differences to the end user.  Other than that, I think this is a good
> change.

That is a good point. However, I think this change is still not a good
one, because it is only halfway there. It makes "git status" work, but
not "git status path", which wants to write out the resulting cache. I
don't know what complications are involved with making that work.
Probably there is a way, but I haven't looked too closely, as I think a
better path forward is a new tool that is not so closely tied to commit.

-Peff
