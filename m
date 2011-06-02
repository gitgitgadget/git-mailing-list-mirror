From: Jeff King <peff@peff.net>
Subject: Re: speed of git reset -- file
Date: Wed, 1 Jun 2011 23:18:31 -0400
Message-ID: <20110602031831.GA21008@sigill.intra.peff.net>
References: <20110531190015.GA12113@gnu.kitenet.net>
 <20110531212639.GA13234@sigill.intra.peff.net>
 <7v62oqignm.fsf@alter.siamese.dyndns.org>
 <20110601195831.GA30070@sigill.intra.peff.net>
 <20110601201629.GA25354@gnu.kitenet.net>
 <20110601211847.GA31958@sigill.intra.peff.net>
 <20110601220502.GA28493@gnu.kitenet.net>
 <20110601225647.GD16820@sigill.intra.peff.net>
 <20110601233157.GA2468@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Thu Jun 02 05:18:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRyQu-0006qz-2m
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 05:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753121Ab1FBDSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 23:18:35 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37278
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751516Ab1FBDSe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 23:18:34 -0400
Received: (qmail 21467 invoked by uid 107); 2 Jun 2011 03:18:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 01 Jun 2011 23:18:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Jun 2011 23:18:31 -0400
Content-Disposition: inline
In-Reply-To: <20110601233157.GA2468@gnu.kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174922>

On Wed, Jun 01, 2011 at 07:31:57PM -0400, Joey Hess wrote:

> Cold cache:
> [...]
>        28.846625099  seconds time elapsed
> 
> Warm cache is 0.88 seconds, but cold cache is typical; I use a cheap netbook
> for a lot of different stuff.

Yeah, it is going to be painful on a cold cache. But I wonder whether
your workflow would really permit the "reset" thing to make a
difference. That is, are you doing "git reset -- file" from a cold
cache, and then doing _nothing_ else with git? Because while yes, it may
be annoying for the "reset" to take 30 seconds, it's warming the cache
so that the subsequent "diff" or "status" will take 29.1 seconds less.

Which isn't to say I'm not sympathetic to the performance problems of
large repos on a cold cache. But I'm not sure there's really a way
around that. You're going to want to see the stat information eventually
if you are doing anything meaningful with git, and once it's loaded, the
warm cache delay isn't too bad. Trying to avoid it seems like a losing
battle.

-Peff
