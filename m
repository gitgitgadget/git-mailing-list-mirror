From: Jeff King <peff@peff.net>
Subject: Re: MIME headers in introductory message (git send-email --compose)
Date: Tue, 25 Mar 2008 19:06:49 -0400
Message-ID: <20080325230649.GA5273@coredump.intra.peff.net>
References: <1205426419-4594-1-git-send-email-sam@rfc1149.net> <7vhcfaxxxk.fsf@gitster.siamese.dyndns.org> <200803252031.17017.tlikonen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Samuel Tardieu <sam@rfc1149.net>
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Wed Mar 26 00:08:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeIEv-0001km-1v
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 00:07:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755729AbYCYXGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 19:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755475AbYCYXGv
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 19:06:51 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4725 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754860AbYCYXGv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 19:06:51 -0400
Received: (qmail 6810 invoked by uid 111); 25 Mar 2008 23:06:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 25 Mar 2008 19:06:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Mar 2008 19:06:49 -0400
Content-Disposition: inline
In-Reply-To: <200803252031.17017.tlikonen@iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78228>

On Tue, Mar 25, 2008 at 08:31:16PM +0200, Teemu Likonen wrote:

> By the way, 'git send-email --compose' does not add MIME headers to 
> introductory message. All non-Ascii chars will output something 
> undefined in receivers' end.
> 
> I guess the right way would be to detect user's charset (locale) and add 
> appropriate MIME headers. Also, the Subject field should be encoded if 
> it contains non-Ascii characters.

I just posted some patches to fix this; however, they always encode as
utf-8. I'm not sure what is the best way to find the user's encoding.
AIUI, locale environment variables are not enough, since, e.g., "en_US"
could come in iso8859-1 and utf-8 flavors. Is there a portable way to
figure this out? Should we be pulling it from .git/config? Neither the
commitEncoding nor the logOutputEncoding really makes sense to reuse.

-Peff
