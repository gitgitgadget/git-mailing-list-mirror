From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/6] strbuf: add string-chomping functions
Date: Tue, 29 Jan 2013 06:10:29 -0500
Message-ID: <20130129111028.GA11055@sigill.intra.peff.net>
References: <20130129091434.GA6975@sigill.intra.peff.net>
 <20130129091540.GB9999@sigill.intra.peff.net>
 <5107A146.4000309@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jan 29 12:10:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U095b-0003tU-JL
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 12:10:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753993Ab3A2LKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 06:10:33 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53302 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752260Ab3A2LKc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 06:10:32 -0500
Received: (qmail 20643 invoked by uid 107); 29 Jan 2013 11:11:55 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Jan 2013 06:11:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jan 2013 06:10:29 -0500
Content-Disposition: inline
In-Reply-To: <5107A146.4000309@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214928>

On Tue, Jan 29, 2013 at 11:15:34AM +0100, Michael Haggerty wrote:

> > +void strbuf_chompmem(struct strbuf *sb, const void *data, size_t len)
> > +{
> > +	if (sb->len >= len && !memcmp(data, sb->buf + sb->len - len, len))
> > +		strbuf_setlen(sb, sb->len - len);
> > +}
> > +
> > +void strbuf_chompstr(struct strbuf *sb, const char *str)
> > +{
> > +	strbuf_chompmem(sb, str, strlen(str));
> > +}
> > +
> It might be handy to have these functions return true/false based on
> whether the suffix was actually found.

Yeah, that sounds reasonable.

> Please document the new functions in
> Documentation/technical/api-strbuf.txt.  Personally I would also
> advocate a "docstring" in the header file, but obviously that preference
> is the exception rather than the rule in the git project :-(

Will do. I need to document the metapack functions, too, so I was thinking
about experimenting with some inline documentation systems.

-Peff
