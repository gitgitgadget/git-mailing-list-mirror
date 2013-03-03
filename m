From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] Revert "graph.c: mark private file-scope symbols as
 static"
Date: Sun, 3 Mar 2013 21:42:06 +0000
Message-ID: <20130303214206.GL7738@serenity.lan>
References: <50e7b3316fadbb550bea098ae92a0942a4429647.1362228122.git.john@keeping.me.uk>
 <87haktwr2a.fsf@pctrast.inf.ethz.ch>
 <20130303102946.GH7738@serenity.lan>
 <7vk3pob38d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 03 22:42:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCGgB-00075k-JK
	for gcvg-git-2@plane.gmane.org; Sun, 03 Mar 2013 22:42:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754488Ab3CCVmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 16:42:16 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:53458 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753563Ab3CCVmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Mar 2013 16:42:16 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 5197ECDA55E;
	Sun,  3 Mar 2013 21:42:15 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2iqS2IFFsf22; Sun,  3 Mar 2013 21:42:14 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id C5AF2CDA583;
	Sun,  3 Mar 2013 21:42:08 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vk3pob38d.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217361>

On Sun, Mar 03, 2013 at 01:08:50PM -0800, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > On Sat, Mar 02, 2013 at 08:16:13PM +0100, Thomas Rast wrote:
> >> John Keeping <john@keeping.me.uk> writes:
> >> 
> >> > This reverts commit ba35480439d05b8f6cca50527072194fe3278bbb.
> >> >
> >> > CGit uses these symbols to output the correct HTML around graph
> >> > elements.  Making these symbols private means that CGit cannot be
> >> > updated to use Git 1.8.0 or newer, so let's not do that.
> >> >
> >> > Signed-off-by: John Keeping <john@keeping.me.uk>
> >> > ---
> >> >
> >> > I realise that Git isn't a library so making the API useful for outside
> >> > projects isn't a priority, but making these two methods public makes
> >> > life a lot easier for CGit.
> >> >
> >> > Additionally, it seems that Johan added graph_set_column_colors
> >> > specifically so that CGit should use it - there's no value to having
> >> > that as a method just for its use in graph.c and he was the author of
> >> > CGit commit 268b34a (ui-log: Colorize commit graph, 2010-11-15).
> >> 
> >> Perhaps you could add a comment in the source to prevent this from
> >> happening again?
> > ...
> > I would hope that having this message in the history should be enough to
> > prevent this changing in the future....
> 
> Given how it happened in the first place, I do not think anything
> short of in-code comment would have helped.  There wouldn't be any
> hint to look into the history without one.

So you'd accept a patch doing that?  Something like this perhaps:

    NOTE: Although these functions aren't used in Git outside graph.c,
    they are used by CGit.
