From: Jeff King <peff@peff.net>
Subject: Re: segfault for git log --graph --no-walk --grep a
Date: Fri, 8 Feb 2013 20:05:24 -0500
Message-ID: <20130209010524.GB5469@sigill.intra.peff.net>
References: <201302090052.22053.thom311@gmail.com>
 <7vsj56xsg5.fsf@alter.siamese.dyndns.org>
 <7vobfuxrns.fsf@alter.siamese.dyndns.org>
 <20130209002710.GA5570@sigill.intra.peff.net>
 <7vfw16xqvj.fsf@alter.siamese.dyndns.org>
 <7va9rexqii.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Haller <thom311@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 02:06:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3yt8-0006Vy-Ka
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 02:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353Ab3BIBF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 20:05:28 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42701 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932276Ab3BIBF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 20:05:26 -0500
Received: (qmail 2343 invoked by uid 107); 9 Feb 2013 01:06:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Feb 2013 20:06:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Feb 2013 20:05:24 -0500
Content-Disposition: inline
In-Reply-To: <7va9rexqii.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215838>

On Fri, Feb 08, 2013 at 04:47:01PM -0800, Junio C Hamano wrote:

> > Yeah, that actually is a good point.  We should be using logmsg_reencode
> > so that we look for strings in the user's encoding.
> 
> Perhaps like this.  Just like the previous one (which should be
> discarded), this makes the function always use the temporary strbuf,
> so doing this upfront actually loses more code than it adds ;-)

I like code simplification, but I worry a little about paying for the
extra copy in the common case. I did a best-of-five "git rev-list
--count --grep=foo HEAD" before and after your patch, though, and the
difference was well within the noise. So maybe it's not worth caring
about.

-Peff
