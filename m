From: Jeff King <peff@peff.net>
Subject: Re: Forcing re-reading files with unchanged stats
Date: Wed, 12 Jan 2011 22:32:18 -0500
Message-ID: <20110113033217.GA32661@sigill.intra.peff.net>
References: <loom.20110112T150313-103@post.gmane.org>
 <4D2E6D99.9060907@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Maaartin <grajcar1@seznam.cz>, git@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Thu Jan 13 04:32:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdDvO-0008Bi-Qj
	for gcvg-git-2@lo.gmane.org; Thu, 13 Jan 2011 04:32:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263Ab1AMDcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jan 2011 22:32:24 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:60710 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751696Ab1AMDcW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jan 2011 22:32:22 -0500
Received: (qmail 27275 invoked by uid 111); 13 Jan 2011 03:32:22 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 13 Jan 2011 03:32:22 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Jan 2011 22:32:18 -0500
Content-Disposition: inline
In-Reply-To: <4D2E6D99.9060907@dbservice.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165037>

On Thu, Jan 13, 2011 at 04:12:25AM +0100, Tomas Carnecky wrote:

>  On 1/12/11 3:07 PM, Maaartin wrote:
> >There are files in my working tree which changes, but their size and mtime
> >remains the same (I know it's strange, but it's useful). Can I make git to re-
> 
> When can this be useful?
> 
> >read them all, so it recognizes the change? Ideally, using a configuration
> >variable. The repo is fairly small, so speed is no issue here.
> 
> Try git update-index --refresh. I'm not aware of any config option,
> but you might want to look through man git-config.

That won't work, as it respects the stat information. So does
--really-refresh. AFAIK, there isn't a way to tell update-index to
ignore start information, short of blowing away the index entirely, and
doing a read-tree to repopulate it.

I'm curious what this use case is, and whether it would be acceptable to
update something like ctime on the files to make them stat-dirty to git.

-Peff
