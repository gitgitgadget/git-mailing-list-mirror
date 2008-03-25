From: Jeff King <peff@peff.net>
Subject: Re: MIME headers in introductory message (git send-email --compose)
Date: Tue, 25 Mar 2008 17:56:15 -0400
Message-ID: <20080325215614.GA5189@coredump.intra.peff.net>
References: <1205426419-4594-1-git-send-email-sam@rfc1149.net> <7vhcfaxxxk.fsf@gitster.siamese.dyndns.org> <200803252031.17017.tlikonen@iki.fi> <76718490803251217q27ae4381h298ec6de8a4d965a@mail.gmail.com> <7vhceuleeu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org,
	Samuel Tardieu <sam@rfc1149.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 22:57:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeH8h-0001r2-Vo
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 22:57:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754278AbYCYV4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 17:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752872AbYCYV4T
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 17:56:19 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2647 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752116AbYCYV4S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 17:56:18 -0400
Received: (qmail 2377 invoked by uid 111); 25 Mar 2008 21:56:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 25 Mar 2008 17:56:16 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Mar 2008 17:56:15 -0400
Content-Disposition: inline
In-Reply-To: <7vhceuleeu.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78223>

On Tue, Mar 25, 2008 at 01:47:05PM -0700, Junio C Hamano wrote:

> > I stuck this in my config and it works-for-me:
> >
> > [format]
> > 	headers = \
> > "MIME-Version: 1.0\n\
> > Content-Type: text/plain; charset=UTF-8\n\
> > Content-Transfer-Encoding: 8bit\n"
> 
> I suspect that you shouldn't do this.  This would badly interfere both
> with existing format-patch behaviour that adds these MIME-Version and
> Content-Type headers by looking at the contents, and with recent
> format-patch fix 6bf4f1b (format-patch: generate MIME header as needed
> even when there is format.header, 2008-03-14) to make the detection based
> on contents (and presense of format.headers).

Yes, I can confirm that that is problematic without even testing.  The
whole point of 6bf4f1b was that we _should_ add MIME headers even if the
user has set format.headers.

We could be more clever about parsing format.headers and mark the "we
have already added MIME" flag (I think we already have to do such
parsing because of to/cc magic). But I have to wonder what the real goal
is here. There has sometimes been a call for "please add MIME headers
unconditionally"; maybe that is an option that people would like.

-Peff
