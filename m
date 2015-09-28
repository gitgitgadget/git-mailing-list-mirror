From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] gc: remove broken symrefs
Date: Mon, 28 Sep 2015 15:03:32 -0400
Message-ID: <20150928190332.GA17258@sigill.intra.peff.net>
References: <xmqqr3lnuzqu.fsf@gitster.mtv.corp.google.com>
 <cover.1443448748.git.johannes.schindelin@gmx.de>
 <fb29b39adf14a702c5127d722d86647a3dc9c891.1443448748.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 28 21:03:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgdiL-0007Oq-IN
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 21:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbbI1TDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 15:03:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:37315 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750855AbbI1TDf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 15:03:35 -0400
Received: (qmail 14343 invoked by uid 102); 28 Sep 2015 19:03:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 28 Sep 2015 14:03:35 -0500
Received: (qmail 10332 invoked by uid 107); 28 Sep 2015 19:03:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 28 Sep 2015 15:03:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Sep 2015 15:03:32 -0400
Content-Disposition: inline
In-Reply-To: <fb29b39adf14a702c5127d722d86647a3dc9c891.1443448748.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278744>

On Mon, Sep 28, 2015 at 04:02:08PM +0200, Johannes Schindelin wrote:

> @@ -136,7 +139,14 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
>  	if (show_progress)
>  		progress = start_progress_delay(_("Checking connectivity"), 0, 0, 2);
>  
> -	mark_reachable_objects(&revs, 1, expire, progress, NULL);
> +	revs.ignore_missing = 1;
> +	mark_reachable_objects(&revs, 1, expire, progress, &broken_symrefs);

You should not need this ignore_missing anymore, right?

It is the dangerous thing I mentioned earlier, but I am puzzled why it
does not cause t5312 to fail.

-Peff
