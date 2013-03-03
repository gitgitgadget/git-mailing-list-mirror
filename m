From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] Revert "graph.c: mark private file-scope symbols as
 static"
Date: Sun, 3 Mar 2013 10:29:46 +0000
Message-ID: <20130303102946.GH7738@serenity.lan>
References: <50e7b3316fadbb550bea098ae92a0942a4429647.1362228122.git.john@keeping.me.uk>
 <87haktwr2a.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Mar 03 11:30:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UC6Bc-0000jE-7P
	for gcvg-git-2@plane.gmane.org; Sun, 03 Mar 2013 11:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849Ab3CCK34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 05:29:56 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:46205 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793Ab3CCK3z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Mar 2013 05:29:55 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id AB5196064D5;
	Sun,  3 Mar 2013 10:29:54 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.999
X-Spam-Level: 
X-Spam-Status: No, score=-0.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MqIrxMXVD8TI; Sun,  3 Mar 2013 10:29:54 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 8DF866064D2;
	Sun,  3 Mar 2013 10:29:48 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <87haktwr2a.fsf@pctrast.inf.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217350>

On Sat, Mar 02, 2013 at 08:16:13PM +0100, Thomas Rast wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > This reverts commit ba35480439d05b8f6cca50527072194fe3278bbb.
> >
> > CGit uses these symbols to output the correct HTML around graph
> > elements.  Making these symbols private means that CGit cannot be
> > updated to use Git 1.8.0 or newer, so let's not do that.
> >
> > Signed-off-by: John Keeping <john@keeping.me.uk>
> > ---
> >
> > I realise that Git isn't a library so making the API useful for outside
> > projects isn't a priority, but making these two methods public makes
> > life a lot easier for CGit.
> >
> > Additionally, it seems that Johan added graph_set_column_colors
> > specifically so that CGit should use it - there's no value to having
> > that as a method just for its use in graph.c and he was the author of
> > CGit commit 268b34a (ui-log: Colorize commit graph, 2010-11-15).
> 
> Perhaps you could add a comment in the source to prevent this from
> happening again?

That feels wrong to me; would we really want a list of "$OUTSIDE_PROJECT
uses this" against all methods?  CGit is using Git's internal API and so
should be prepared for breakage and to do what is necessary to work
around it - it's just this one case where adding a 2 line function to
Git makes CGit's life a lot easier.

I would hope that having this message in the history should be enough to
prevent this changing in the future; and it means that the comment is
associated with a date so that someone can decide to check whether CGit
is still using this function in the distant future.


John
