From: Jeff King <peff@peff.net>
Subject: Re: About *git clone --depth=n* puzzle
Date: Wed, 14 Aug 2013 07:59:56 -0400
Message-ID: <20130814115956.GA29295@sigill.intra.peff.net>
References: <BAY169-W472B90AB796C71E8D0D038B4450@phx.gbl>
 <520B4529.9080304@googlemail.com>
 <BAY169-W647D5A2BFDC793ADFA5078B4450@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"junchunx.guan@gmail.com" <junchunx.guan@gmail.com>
To: XinLingchao <douglarek@outlook.com>
X-From: git-owner@vger.kernel.org Wed Aug 14 14:00:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9ZkH-0003iR-Hg
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 14:00:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254Ab3HNMAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 08:00:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:37208 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932094Ab3HNMAB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 08:00:01 -0400
Received: (qmail 17259 invoked by uid 102); 14 Aug 2013 12:00:01 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Aug 2013 07:00:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Aug 2013 07:59:56 -0400
Content-Disposition: inline
In-Reply-To: <BAY169-W647D5A2BFDC793ADFA5078B4450@phx.gbl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232281>

On Wed, Aug 14, 2013 at 05:19:36PM +0800, XinLingchao wrote:

> > There was a similar discussion going on in July this year,
> > maybe this is an interesting read with respect to this topic
> > http://www.spinics.net/lists/git/msg196138.html
> >
> Stefan, I do NOT think so, the key point is not about the depth limit,
> it is about whether remote clone depth equals local clone depth.

I do not think it is about local vs remote, but rather about which
version of git the remote side is running. Prior to 682c7d2
(upload-pack: fix off-by-one depth calculation in shallow clone,
2013-01-11), a shallow clone always returned one extra commit. That fix
went into v1.8.2.

So if you have a post-v1.8.2 git client, a local clone will use the same
git version as the "remote" side of the connection. But if you are
contacting a remote server, the results you get will depend on what
version of git is running on the remote server.

And as the example you showed uses github.com as the remote, and as I
happen to know that GitHub's servers do not currently have 682c7d2, you
would see the old behavior.

-Peff
