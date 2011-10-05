From: Jeff King <peff@peff.net>
Subject: Re: git-cherry-pick and author field in version 1.7.6.4
Date: Wed, 5 Oct 2011 13:41:39 -0400
Message-ID: <20111005174138.GA22962@sigill.intra.peff.net>
References: <4E8C6F0E.7000508@6wind.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 19:41:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBVTZ-0002Cr-5v
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 19:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935128Ab1JERlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 13:41:45 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53936
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934662Ab1JERlo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 13:41:44 -0400
Received: (qmail 613 invoked by uid 107); 5 Oct 2011 17:41:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Oct 2011 13:41:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Oct 2011 13:41:39 -0400
Content-Disposition: inline
In-Reply-To: <4E8C6F0E.7000508@6wind.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182867>

On Wed, Oct 05, 2011 at 04:51:58PM +0200, Nicolas Dichtel wrote:

> in the last stable version (1.7.6.4), when I perform a
> git-cherry-pick, the initial author of the patch is erased whith my
> name (it was not the case in version 1.7.3.4 and prior). Is this
> behavior intended ? Is there an option to keep the initial author of
> the patch?

I can't reproduce your problem:

  git init repo &&
  cd repo &&
  echo content >file && git add file && git commit -m base &&
  echo changes >>file &&
  git commit --author='Other Person <other@example.com>' -a -m other &&
  git tag other &&
  git reset --hard HEAD^ &&
  git cherry-pick other

gives this output for the cherry-pick:

  [master 6eb207f] other
   Author: Other Person <other@example.com>
   1 files changed, 1 insertions(+), 0 deletions(-)

and the resulting commit looks good:

  $ git log -1 --format='%an <%ae>'
  Other Person <other@example.com>

Does the script above work for you? If so, then what is different about
your problematic case?

-Peff
