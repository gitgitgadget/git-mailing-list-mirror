From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Try harder to find a remote when on a detached HEAD or
 non-tracking branch.
Date: Tue, 19 Jun 2012 17:46:46 -0400
Message-ID: <20120619214646.GA22436@sigill.intra.peff.net>
References: <1340038866-24552-1-git-send-email-marcnarc@xiplink.com>
 <7vaa004j9f.fsf@alter.siamese.dyndns.org>
 <4FDFA030.7080408@xiplink.com>
 <7vmx402rru.fsf@alter.siamese.dyndns.org>
 <4FE08797.50509@xiplink.com>
 <7vipen191a.fsf@alter.siamese.dyndns.org>
 <20120619201259.GB14692@sigill.intra.peff.net>
 <4FE0F267.5070803@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 23:47:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh6GD-0007sC-22
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 23:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195Ab2FSVqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 17:46:49 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:33048
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752399Ab2FSVqt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 17:46:49 -0400
Received: (qmail 14462 invoked by uid 107); 19 Jun 2012 21:46:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Jun 2012 17:46:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jun 2012 17:46:46 -0400
Content-Disposition: inline
In-Reply-To: <4FE0F267.5070803@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200255>

On Tue, Jun 19, 2012 at 05:43:03PM -0400, Marc Branchaud wrote:

> I suggest git would be better off changing the way it finds the default
> remote to:
> 
> 	Use the currently checked-out branch's remote;
> 	or Use the remote specified in the original clone command[*];
> 	or use "origin".
> 
> [*] With some strong mechanism for identifying this remote.

Yes, that sounds like a much saner path. I think your [*] is just
"record the different name in remote.default during the clone".

Then we continue to use "origin" when that is not set (so existing repos
without "-o" see no change at all). New repos cloned with "-o" would be
fixed. Old repos cloned with "-o" are still broken, but there is at
least a simple one-time workaround ("git config remote.default foo").

-Peff
