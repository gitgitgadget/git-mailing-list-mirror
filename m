From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add core.pathspecGlob config option
Date: Wed, 19 Dec 2012 22:55:43 -0500
Message-ID: <20121220035543.GA14965@sigill.intra.peff.net>
References: <20121219203449.GA10001@sigill.intra.peff.net>
 <CACsJy8BB3=3ZHD5Ua9M-0+98JVigHBBuo07gBSgEwanvB0zBSA@mail.gmail.com>
 <20121220031327.GB9917@sigill.intra.peff.net>
 <7vehil7557.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 04:56:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlXEz-0007bQ-JJ
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 04:56:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354Ab2LTDzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 22:55:48 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59265 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751581Ab2LTDzr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 22:55:47 -0500
Received: (qmail 6648 invoked by uid 107); 20 Dec 2012 03:56:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Dec 2012 22:56:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Dec 2012 22:55:43 -0500
Content-Disposition: inline
In-Reply-To: <7vehil7557.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211875>

On Wed, Dec 19, 2012 at 07:51:16PM -0800, Junio C Hamano wrote:

> > ++		if (limit_pathspec_to_literal())
> > ++			item->nowildcard_len = item->len;
> > ++		else {
> > ++			item->nowildcard_len = simple_length(path);
> > ++			if (item->nowildcard_len < item->len) {
> > ++				pathspec->has_wildcard = 1;
> > ++				if (path[item->nowildcard_len] == '*' &&
> > ++				    no_wildcard(path + item->nowildcard_len + 1))
> > ++					item->flags |= PATHSPEC_ONESTAR;
> > ++			}
> >  +		}
> 
> Hmph.  I thought that returning the length without any "stop at glob
> special" trick from simple_length() would be a simpler resolution.
> 
> That is what is queued at the tip of 'pu', anyway.

I don't think we can make a change in simple_length. It gets used not
only for pathspecs, but also for parsing exclude patterns, which I do
not think should be affected by this option.

-Peff
