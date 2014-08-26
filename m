From: Jeff King <peff@peff.net>
Subject: Re: Bug report: Author/Commit date in ISO 8601 format
Date: Tue, 26 Aug 2014 09:06:10 -0400
Message-ID: <20140826130610.GG29180@peff.net>
References: <53FC3768.3090905@arc-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Oliver Busch <oliver.busch@arc-aachen.de>
X-From: git-owner@vger.kernel.org Tue Aug 26 15:06:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMGS1-0000cy-BI
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 15:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754871AbaHZNGN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 09:06:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:59192 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754784AbaHZNGM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 09:06:12 -0400
Received: (qmail 18275 invoked by uid 102); 26 Aug 2014 13:06:12 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Aug 2014 08:06:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Aug 2014 09:06:10 -0400
Content-Disposition: inline
In-Reply-To: <53FC3768.3090905@arc-aachen.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255900>

On Tue, Aug 26, 2014 at 09:29:44AM +0200, Oliver Busch wrote:

> I encountered the following problem: When using the date formatting option
> ISO (either by setting --date=iso or using format:%ci for the committer
> date), the output is formatted like this:
> 
> 2014-08-25 17:49:43 +0200
> 
> But according to ISO 8601, should be formatted like this (see
> http://www.w3.org/TR/NOTE-datetime):
> 
> 2014-08-25T17:49:43+02:00

Yeah, it is not strictly ISO but more ISO-like (to further add
confusion, it is mostly RFC3339, which claims to be a "profile of
ISO8601". But we don't follow the timezone conventions there. Yeesh).

Interestingly, this actually came up when the feature was added:

  http://thread.gmane.org/gmane.comp.version-control.git/52414/focus=52585

but there was some discussion of ISO8601's weird phrasing of "T" being
optional.

> I therefore suggest to adapt the output when using --date=iso or
> format:%ci to comply 100% with the ISO 8601 specs, or at least change
> documentation to say the output is only "ISO-like".

I think changing the output at this point would cause backwards
compatibility problems (not to mention that it's a lot less readable for
humans).

Patches welcome for a documentation update. I also think something like
--date=iso8601-strict might make sense for the case of feeding the
result to another parser.

-Peff
