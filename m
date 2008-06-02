From: Adam Simpkins <adam@adamsimpkins.net>
Subject: Re: [PATCH 2/2] graph API: avoid printing unnecessary padding before some octopus merges
Date: Sun, 1 Jun 2008 17:04:42 -0700
Message-ID: <20080602000441.GA9291@adamsimpkins.net>
References: <20080529085752.GA31865@adamsimpkins.net> <1212353818-7031-1-git-send-email-adam@adamsimpkins.net> <1212353818-7031-2-git-send-email-adam@adamsimpkins.net> <1212353818-7031-3-git-send-email-adam@adamsimpkins.net> <7vskvwakph.fsf@gitster.siamese.dyndns.org>
Reply-To: Adam Simpkins <adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Teemu Likonen <tlikonen@iki.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 02:05:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2xYd-0006fM-NX
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 02:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701AbYFBAEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 20:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752840AbYFBAEp
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 20:04:45 -0400
Received: from smtp142.iad.emailsrvr.com ([207.97.245.142]:36145 "EHLO
	smtp142.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbYFBAEo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 20:04:44 -0400
Received: from relay4.r5.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay4.r5.iad.mlsrvr.com (SMTP Server) with ESMTP id B62B5C7D1;
	Sun,  1 Jun 2008 20:04:43 -0400 (EDT)
Received: by relay4.r5.iad.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 8E369C1D9;
	Sun,  1 Jun 2008 20:04:43 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id 7B51814100CC; Sun,  1 Jun 2008 17:04:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vskvwakph.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83481>

On Sun, Jun 01, 2008 at 02:50:34PM -0700, Junio C Hamano wrote:
> Adam Simpkins <adam@adamsimpkins.net> writes:
> 
> > diff --git a/graph.c b/graph.c
> > index 332d1e8..0531716 100644
> > --- a/graph.c
> > +++ b/graph.c
> > @@ -450,16 +450,18 @@ void graph_update(struct git_graph *graph, struct commit *commit)
> >  	 * it never finished its output.  Goto GRAPH_SKIP, to print out
> >  	 * a line to indicate that portion of the graph is missing.
> >  	 *
> > -	 * Otherwise, if there are 3 or more parents, we need to print
> > -	 * extra rows before the commit, to expand the branch lines around
> > -	 * it and make room for it.
> > +	 * If there are 3 or more parents, we may need to print extra rows
> > +	 * before the commit, to expand the branch lines around it and make
> > +	 * room for it.  We need to do this unless there aren't any branch
> > +	 * rows to the right of this commit.
> 
> Double negation like this is confusing, isn't it?
> 
> "We do not have to do this if there isn't any branch row to the right of
> this commit" may be better.  "We need to do this only if there is a branch
> row (or more) to the right of this commit" would probably be better.

Yes, I agree it is less confusing without the double negation.  Your
second choice of wording sounds best.

How do you prefer to fix simple things like this?  Do you want to just
apply the fix yourself, or is it easier for you if I submit an amended
patch?

-- 
Adam Simpkins
adam@adamsimpkins.net
