From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 9/9] trailer: add tests for "git interpret-trailers"
Date: Mon, 30 Dec 2013 12:52:34 -0800
Message-ID: <20131230205234.GU27213@leaf>
References: <20131224061541.19560.17773.chriscool@tuxfamily.org>
 <20131224063726.19560.61859.chriscool@tuxfamily.org>
 <xmqq1u0utfwk.fsf@gitster.dls.corp.google.com>
 <20131230202042.GJ27213@leaf>
 <xmqqk3emqd7a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 30 21:52:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VxjpN-00062J-W1
	for gcvg-git-2@plane.gmane.org; Mon, 30 Dec 2013 21:52:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270Ab3L3Uwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Dec 2013 15:52:42 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:39786 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932172Ab3L3Uwl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Dec 2013 15:52:41 -0500
Received: from mfilter18-d.gandi.net (mfilter18-d.gandi.net [217.70.178.146])
	by relay5-d.mail.gandi.net (Postfix) with ESMTP id 2E0CA41C060;
	Mon, 30 Dec 2013 21:52:41 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter18-d.gandi.net
Received: from relay5-d.mail.gandi.net ([217.70.183.197])
	by mfilter18-d.gandi.net (mfilter18-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id JMfsheWK-0Yu; Mon, 30 Dec 2013 21:52:39 +0100 (CET)
X-Originating-IP: 50.43.14.201
Received: from leaf (static-50-43-14-201.bvtn.or.frontiernet.net [50.43.14.201])
	(Authenticated sender: josh@joshtriplett.org)
	by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id E59E741C051;
	Mon, 30 Dec 2013 21:52:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <xmqqk3emqd7a.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239825>

On Mon, Dec 30, 2013 at 12:46:33PM -0800, Junio C Hamano wrote:
> Josh Triplett <josh@joshtriplett.org> writes:
> 
> > On Mon, Dec 30, 2013 at 09:19:55AM -0800, Junio C Hamano wrote:
> >> Christian Couder <chriscool@tuxfamily.org> writes:
> >> 
> >> > +# Do not remove trailing spaces below!
> >> > +cat >complex_message_trailers <<'EOF'
> >> > +Fixes: 
> >> > +Acked-by: 
> >> > +Reviewed-by: 
> >> > +Signed-off-by: 
> >> > +EOF
> >> 
> >> Just a hint.  I think it is far safer and robust over time to do
> >> something like this:
> >> 
> >> 	sed -e 's/ Z$/ /' <<-\EOF
> >>         Fixes: Z
> >>         Acked-by: Z
> >>         EOF
> >> 
> >> instead of a comment, which can warn human developers but does not
> >> do anything to prevent their editors' auto-fix features from kicking
> >> in.
> >
> > This, but for simplicity, since every line needs the trailing space, why
> > not just use 's/$/ /' and drop the ' Z' on every line?
> >
> > </bikeshed>
> >
> > - Josh Triplett
> 
> A few reasons:
> 
>  - The "everybody will have a single SP at the end" may or may not
>    last forever;

Trivially fixed if that ever changes, but given the nature of all of
these, that seems unlikely.

>  - With your scheme, if you already had _one_ trailing SPs in the
>    input, it would be hard to spot in the source;

Git makes them quite difficult to miss. :)

- Josh Triplett
