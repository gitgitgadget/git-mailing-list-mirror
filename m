From: Jeff King <peff@peff.net>
Subject: Re: Howto remove accidentally fetched remote tags?
Date: Tue, 9 Dec 2008 01:03:39 -0500
Message-ID: <20081209060339.GA3174@coredump.intra.peff.net>
References: <1228793683956-1632369.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: roylee17 <roylee17@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 07:05:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9viS-0005tj-Sq
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 07:05:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbYLIGDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 01:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbYLIGDm
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 01:03:42 -0500
Received: from peff.net ([208.65.91.99]:2761 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750880AbYLIGDm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 01:03:42 -0500
Received: (qmail 533 invoked by uid 111); 9 Dec 2008 06:03:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 09 Dec 2008 01:03:41 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Dec 2008 01:03:39 -0500
Content-Disposition: inline
In-Reply-To: <1228793683956-1632369.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102600>

On Mon, Dec 08, 2008 at 07:34:43PM -0800, roylee17 wrote:

> Is there a convenient way to remove tags which accidentally( forgot adding
> --no-tag ) fetched from a remote repo?

How about

  $ git tag -l >tags-to-delete
  $ $EDITOR tags-to-delete
  $ xargs git tag -d <tags-to-delete

?

> Will git add tag namespace( like branch namespace) in the future?
> In this case, we can manage tags as convenient as branches.

I don't think there any plans for it. You can get something close by
doing this:

  $ git config --add remote.origin.fetch '+refs/tags/*:refs/tags/origin/*'
  $ git config remote.origin.tagopt --no-tags

The big difference is that you are asking to fetch _all_ tags here,
whereas the usual tag operation is to grab tags that point to anything
you are already getting via branches. But in practice, that is usually
the same content anyway.

-Peff
