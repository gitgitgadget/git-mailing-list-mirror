From: Jeff King <peff@peff.net>
Subject: Re: [RFC] use typechange as rename source
Date: Sun, 2 Dec 2007 20:20:22 -0500
Message-ID: <20071203012022.GA8322@coredump.intra.peff.net>
References: <20071129141452.GA32670@coredump.intra.peff.net> <7vmyswsfl6.fsf@gitster.siamese.dyndns.org> <20071130015716.GA15224@coredump.intra.peff.net> <7vsl2n87jr.fsf@gitster.siamese.dyndns.org> <20071201043407.GD30725@coredump.intra.peff.net> <7vhcj36j6e.fsf@gitster.siamese.dyndns.org> <7v8x4f6iyu.fsf@gitster.siamese.dyndns.org> <7vy7ce6hyb.fsf@gitster.siamese.dyndns.org> <20071201064916.GA7431@coredump.intra.peff.net> <7v8x4cykkj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 02:20:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyzzJ-0004eh-Ro
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 02:20:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118AbXLCBUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 20:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752052AbXLCBUZ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 20:20:25 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3129 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751433AbXLCBUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 20:20:25 -0500
Received: (qmail 25152 invoked by uid 111); 3 Dec 2007 01:20:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 02 Dec 2007 20:20:23 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Dec 2007 20:20:22 -0500
Content-Disposition: inline
In-Reply-To: <7v8x4cykkj.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66840>

On Sun, Dec 02, 2007 at 11:15:40AM -0800, Junio C Hamano wrote:

> > @@ -250,6 +250,7 @@ static void wt_status_print_updated(struct wt_status *s)
> > +	rev.diffopt.break_opt = 0;
> 
> I have to wonder how much this is going to make things worse in the real
> world, although I agree in the "as we already spend cycles for
> detect_rename why not" sense.
> 
> With the recent change from Alex not to run status when not interactive,
> it probably does not matter.  If we are going to spawn an editor, we are
> dealing with human interaction and even -B -M should not be too bad.

I had more or less the same thinking, but I don't have any real-world
numbers. I would be curious to see averages on how diffcore-break
compares to diffcore-rename. Just thinking about it, it seems intuitive
that breaking would always be cheaper, which means that adding "-B" to
"-M" won't have a significant performance impact.

-Peff
