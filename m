From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/6] config.c: Fix a sparse warning
Date: Mon, 7 Oct 2013 07:31:36 -0400
Message-ID: <20131007113135.GB5792@sigill.intra.peff.net>
References: <5251CC9D.9040309@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Oct 07 13:31:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VT92T-0005rM-AY
	for gcvg-git-2@plane.gmane.org; Mon, 07 Oct 2013 13:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497Ab3JGLbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Oct 2013 07:31:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:45094 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751306Ab3JGLbi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Oct 2013 07:31:38 -0400
Received: (qmail 26312 invoked by uid 102); 7 Oct 2013 11:31:37 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 Oct 2013 06:31:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Oct 2013 07:31:36 -0400
Content-Disposition: inline
In-Reply-To: <5251CC9D.9040309@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235758>

On Sun, Oct 06, 2013 at 09:48:29PM +0100, Ramsay Jones wrote:

> Sparse issues an "'git_parse_unsigned' was not declared. Should it
> be static?" warning. In order to suppress this warning, since this
> symbol only requires file scope, we simply add the static modifier
> to its declaration.

Thanks. This one is my fault. Commit 7192777 refactors git_parse_ulong,
which is public, into a more generic function. But since we kept the
git_parse_ulong wrapper, only that part needs to be public; nobody
outside the file calls the lower-level git_parse_unsigned.

-Peff
