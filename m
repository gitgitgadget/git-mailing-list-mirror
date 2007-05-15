From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/10] Add a birdview-on-the-source-code section to the user manual
Date: Tue, 15 May 2007 01:08:08 -0400
Message-ID: <20070515050808.GA11745@coredump.intra.peff.net>
References: <20070514181943.GA31749@diana.vm.bytemark.co.uk> <20070514183931.GC23090@fieldses.org> <20070515042200.GA10884@coredump.intra.peff.net> <20070515045044.GB2805@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Tue May 15 07:08:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnpGj-0000qD-Da
	for gcvg-git@gmane.org; Tue, 15 May 2007 07:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756016AbXEOFIL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 01:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756078AbXEOFIL
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 01:08:11 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1641 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756016AbXEOFIK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 01:08:10 -0400
Received: (qmail 24206 invoked from network); 15 May 2007 05:08:10 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 15 May 2007 05:08:10 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 15 May 2007 01:08:08 -0400
Content-Disposition: inline
In-Reply-To: <20070515045044.GB2805@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47313>

On Tue, May 15, 2007 at 12:50:44AM -0400, J. Bruce Fields wrote:

> But the mail I got through the git list yesterday has some odd stuff in
> it:
> 
> From git-owner@vger.kernel.org Mon May 14 11:22:01 2007
> Received: from vger.kernel.org ([209.132.176.167])
> 	by fieldses.org with esmtp (Exim 4.67)
> 	(envelope-from <git-owner@vger.kernel.org>)
> 	id 1HncN6-00051C-Mh
> 	for bfields@fieldses.org; Mon, 14 May 2007 11:22:01 -0400
> Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
> 	id S1755729AbXENPVe (ORCPT <rfc822;bfields@fieldses.org>);
> 	Mon, 14 May 2007 11:21:34 -0400
> X-Warning: Original message contained 8-bit characters, however during
> 	   the SMTP transport session the receiving system did not announce
> 	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
> 	   message does not have MIME headers (RFC 2045-2049) to enable
> 	   encoding change, we had very little choice.
> X-Warning: We ASSUME it is less harmful to add the MIME headers, and
> 	   convert the text to Quoted-Printable, than not to do so,
> 	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
> X-Warning: We don't know what character set the user used, thus we had to
> 	   write these MIME-headers with our local system default value.
> MIME-Version: 1.0
> Content-Transfer-Encoding: QUOTED-PRINTABLE
> Content-Type: TEXT/PLAIN; charset=ISO-8859-1

Interesting. vger is correct in translating, since your mail server does
_not_ advertise the 8BITMIME extension (even though exim is 8-bit clean,
and could handle it).

However, the content-type is already specified, so it shouldn't need to
rewrite. However, I notice that your original message is missing a
MIME-Version: 1.0 header. My guess is that vger's logic is that without
that header, it can't trust the Content-Type you have provided (and
indeed, not including MIME-Version violates the MIME RFCs, I believe).

I assumed this was a bug in git-send-email, but looking closer, it
doesn't put in any mime information at all! So your sending smtp server
is adding in the content-type header, but it's failing to add the
MIME-Version header, which I think is a bug (I can dig up the RFC
reference if you want).

Arguably, git should be generating the full MIME header-set, since it
knows what actual encoding the message is in.

-Peff
