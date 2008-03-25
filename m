From: Jeff King <peff@peff.net>
Subject: Re: MIME headers in introductory message (git send-email --compose)
Date: Tue, 25 Mar 2008 18:07:43 -0400
Message-ID: <20080325220743.GA5248@coredump.intra.peff.net>
References: <1205426419-4594-1-git-send-email-sam@rfc1149.net> <7vhcfaxxxk.fsf@gitster.siamese.dyndns.org> <200803252031.17017.tlikonen@iki.fi> <76718490803251217q27ae4381h298ec6de8a4d965a@mail.gmail.com> <7vhceuleeu.fsf@gitster.siamese.dyndns.org> <20080325215614.GA5189@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org,
	Samuel Tardieu <sam@rfc1149.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 23:09:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeHKG-00062s-BW
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 23:09:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761948AbYCYWHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 18:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761943AbYCYWHr
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 18:07:47 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4425 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761931AbYCYWHq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 18:07:46 -0400
Received: (qmail 3126 invoked by uid 111); 25 Mar 2008 22:07:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 25 Mar 2008 18:07:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Mar 2008 18:07:43 -0400
Content-Disposition: inline
In-Reply-To: <20080325215614.GA5189@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78225>

On Tue, Mar 25, 2008 at 05:56:14PM -0400, Jeff King wrote:

> We could be more clever about parsing format.headers and mark the "we
> have already added MIME" flag (I think we already have to do such
> parsing because of to/cc magic). But I have to wonder what the real goal

I started on this out of curiosity, and it _is_ really simple, but it's
also wrong.  It can't be right to set your MIME headers statically
because some options (like --attach) might cause us to have to put in
_different_ MIME headers. So we are left with either conflicting
headers, disallowing --attach, ignoring some of your format.headers, or
possibly picking out those headers and making them part of the header of
that patch part of the multipart. All of which seem a bit ugly to me.

If this is something people really want, I think just adding an "always
add mime headers" option makes the most sense.

-Peff
